/**
 * @attention update: 使用 `Use` 类来管理操作数
 * @todo 使用智能指针优化
 */

#include "../../include/ir/base.h"


namespace IR {

const std::vector<Use*>& Value::getUseList() const {
    return use_list;
}

void Value::addUse(Use* use) {
    use_list.push_back(use);
}

/**
 * @todo null, not found process
 * @todo optimize (can use "erase" cpp20 feature)
 * @attention no repeat delete
 */
void Value::delUse(Use* use) {
    if (use == nullptr) {
        return;
    }
    for (auto u = use_list.begin(); u != use_list.end(); ++u) {
        if (*u == use) {
            use_list.erase(u);
            return;
        }
    }
}


void User::addOperand(Value *v) {
    operands.emplace_back(v, this);
}

Value* User::getOperand(unsigned i) const {
    return operands[i].getValue();
}

void User::setOperand(unsigned i, Value *v) {
    operands[i].setValue(v);
}

unsigned User::getNumOperands() const {
    return operands.size();
}


Use::Use(Value *v, User *u) : val(v), user(u) {
    val->addUse(this);
}

void Use::setValue(Value *v) {
    val->delUse(this);
    val = v;
    val->addUse(this);
}

void Use::setUser(User *u) {
    user = u;
}

Value* Use::getValue() const {
    return val;
}

User* Use::getUser() const {
    return user;
}

Use::~Use() {
    val->delUse(this);
}
}