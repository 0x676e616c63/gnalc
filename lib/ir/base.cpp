// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/base.hpp"
#include "ir/instructions/phi.hpp"
#include "utils/exception.hpp"

#include <algorithm>
#include <functional>

namespace IR {

Value::Value(std::string _name, pType _vtype, ValueTrait _vtrait)
    : NameC(std::move(_name)), vtype(std::move(_vtype)), trait(_vtrait) {}

pType Value::getType() const { return vtype; }

size_t Value::getUseCount() const {
    // Expired use should be deleted by User.
    // So just get the size.
    return use_list.size();
}

Value::UserIterator<> Value::user_begin() const { return UserIterator{use_list.begin()}; }
Value::UserIterator<> Value::user_end() const { return UserIterator{use_list.end()}; }

Value::UserIterator<Instruction> Value::inst_user_begin() const { return UserIterator<Instruction>{use_list.begin()}; }
Value::UserIterator<Instruction> Value::inst_user_end() const { return UserIterator<Instruction>{use_list.end()}; }

pUser Value::getSingleUser() const {
    if (use_list.size() != 1)
        return nullptr;
    return (*use_list.begin())->getUser();
}

void Value::addUse(Use* use) {
    use_list.emplace_back(use);
}

const std::list<Use*>& Value::getUseList() const {
    return use_list;
}

void Value::replaceSelf(const pVal &new_value) const {
    Err::gassert(this != new_value.get(), "Replace with an identical value doesn't make sense.");
    Err::gassert(isSameType(getType(), new_value->getType()), "Replace with a value with different type?");
    auto ulist = getUseList();
    for (const auto &use : ulist)
        use->setValue(new_value);
}

Value::~Value() = default;

bool Value::delUse(Use* target) {
    for (auto it = use_list.begin(); it != use_list.end(); ++it) {
        if (*it == target) {
            use_list.erase(it);
            return true;
        }
    }
    return false;
}

User::UseIterator User::operand_use_begin() const { return operand_uses_list.begin(); }

User::UseIterator User::operand_use_end() const { return operand_uses_list.end(); }

User::OperandIterator::OperandIterator(InnerIterT iter_) : iter(iter_) {}

User::OperandIterator &User::OperandIterator::operator++() {
    ++iter;
    return *this;
}
User::OperandIterator User::OperandIterator::operator++(int) { return OperandIterator{iter++}; }

User::OperandIterator &User::OperandIterator::operator--() {
    --iter;
    return *this;
}
User::OperandIterator User::OperandIterator::operator--(int) { return OperandIterator{iter--}; }

User::OperandIterator &User::OperandIterator::operator+=(difference_type n) {
    iter += n;
    return *this;
}
User::OperandIterator &User::OperandIterator::operator-=(difference_type n) {
    iter -= n;
    return *this;
}
bool User::OperandIterator::operator<(OperandIterator other) const { return iter < other.iter; }
bool User::OperandIterator::operator>(OperandIterator other) const { return iter > other.iter; }
bool User::OperandIterator::operator<=(OperandIterator other) const { return iter <= other.iter; }
bool User::OperandIterator::operator>=(OperandIterator other) const { return iter >= other.iter; }

User::OperandIterator::difference_type User::OperandIterator::operator-(OperandIterator other) const {
    return iter - other.iter;
}

User::OperandIterator User::OperandIterator::operator+(difference_type n) const { return OperandIterator{iter + n}; }
User::OperandIterator User::OperandIterator::operator-(difference_type n) const { return OperandIterator{iter - n}; }

bool User::OperandIterator::operator==(OperandIterator other) const { return iter == other.iter; }
bool User::OperandIterator::operator!=(OperandIterator other) const { return iter != other.iter; }
pVal User::OperandIterator::operator*() const { return (*iter)->getValue(); }

User::OperandIterator User::operand_begin() const { return OperandIterator{operand_uses_list.begin()}; }
User::OperandIterator User::operand_end() const { return OperandIterator{operand_uses_list.end()}; }

User::~User() {
    for (const auto &curr : operand_uses_list) {
        auto curr_val = curr->getValue();
        // Because one's operands may be destroyed before itself and we can't prevent this happen.
        // It's hard to always delete a value before its user.
        // For example, when the whole compiling is done, and Module's destructor runs,
        // all instructions will be deleted, but not in the def-use relationship.
        if (!curr_val)
            continue;
        auto ok = curr_val->delUse(curr.get());
        Err::gassert(ok);
    }
}

size_t User::replaceAllOperands(const pVal &before, const pVal &after) {
    Err::gassert(before != after, "Replace with an identical value doesn't make sense.");
    Err::gassert(isSameType(before, after), "Replace with a value with different type?");
    size_t cnt = 0;
    for (const auto &use : operand_uses_list) {
        if (use->getValue() == before) {
            use->setValue(after);
            ++cnt;
        }
    }
    return cnt;
}

User::User(std::string _name, pType _vtype, ValueTrait _vtrait) : Value(std::move(_name), std::move(_vtype), _vtrait) {}

size_t User::getNumOperands() const { return operand_uses_list.size(); }

void User::addOperand(const pVal &v) {
    std::unique_ptr<Use> use{new Use(v, this)};
    operand_uses_list.emplace_back(std::move(use));
}

const std::vector<std::unique_ptr<Use>> &User::getOperands() const { return operand_uses_list; }
std::vector<Use *> User::getRawOperands() const {
    std::vector<Use *> ret;
    ret.reserve(operand_uses_list.size());
    for (const auto &use : operand_uses_list)
        ret.emplace_back(use.get());
    return ret;
}
Use * User::getOperand(size_t index) const { return operand_uses_list[index].get(); }

void User::setOperand(size_t index, const pVal &val) {
    Err::gassert(index < operand_uses_list.size(), "index out of range");
    auto old_use = operand_uses_list[index].get();
    auto ok = old_use->getValue()->delUse(old_use);
    Err::gassert(ok);
    std::unique_ptr<Use> new_use{new Use(val, this)};
    operand_uses_list[index] = std::move(new_use);
}

void User::swapOperand(size_t a, size_t b) {
    Err::gassert(a < operand_uses_list.size() && b < operand_uses_list.size(), "index out of range");
    std::swap(operand_uses_list[a], operand_uses_list[b]);
}

bool User::delOperand(const pVal &v) {
    return delOperandIf([&v](const auto &value) { return value == v; });
}

bool User::delOperand(NameRef name) {
    return delOperandIf([&name](const auto &value) { return value->isName(name); });
}

bool User::delOperand(size_t index) {
    Err::gassert(index < operand_uses_list.size(), "index out of range");
    if (index >= operand_uses_list.size())
        return false;
    auto use = operand_uses_list[index].get();
    auto ok = use->getValue()->delUse(use);
    Err::gassert(ok);
    operand_uses_list.erase(operand_uses_list.begin() +
                            static_cast<decltype(operand_uses_list)::iterator::difference_type>(index));
    return true;
}

Use::Use(wpVal v, User *u) : val(std::move(v)), user(u) {
    val.lock()->addUse(this);
}

User *Use::getRawUser() const { return user; }

pVal Use::getValue() const { return val.lock(); }

pUser Use::getUser() const { return user->as<User>(); }

void Use::setValue(const pVal &v) {
    val.lock()->delUse(this);
    v->addUse(this);
    val = v;
}
} // namespace IR