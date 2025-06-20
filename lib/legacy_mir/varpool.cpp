#ifdef GNALC_EXTENSION_ARMv7
#include "legacy_mir/varpool.hpp"

using namespace LegacyMIR;

bool VarPool::IRValueWrapper::operator==(const IRValueWrapper &another) const {
    return &(this->val) == &(another.val); // 比较地址
}

size_t VarPool::VarPoolHash::operator()(const IRValueWrapper &val) const {
    return std::hash<std::string>()(val.val.getName()); // Value名唯一
}

size_t VarPool::LoadMapHash::operator()(const ConstObj &obj) const { return (size_t)obj.getId(); }

std::shared_ptr<Operand> VarPool::getValue(const IR::Value &val) {
    IRValueWrapper wrapper{val};

    auto it = pool.find(wrapper);

    if (it == pool.end()) {
        return nullptr; // 一般不会出现的情况
    } else {
        return it->second;
    }
}

std::shared_ptr<PreColedOP> VarPool::getValue(CoreRegister _color) {
    std::shared_ptr<PreColedOP> ptr;
    if (gpr_pool.find(_color) != gpr_pool.end()) {
        ptr = gpr_pool[_color];
        return ptr;
    } else {
        ptr = std::make_shared<PreColedOP>(_color);
        gpr_pool[_color] = ptr;
        return ptr;
    }
}

std::shared_ptr<PreColedOP> VarPool::getValue(FPURegister _color) {
    std::shared_ptr<PreColedOP> ptr;
    if (spr_pool.find(_color) != spr_pool.end()) {
        ptr = spr_pool[_color];
        return ptr;
    } else {
        ptr = std::make_shared<PreColedOP>(_color);
        spr_pool[_color] = ptr;
        return ptr;
    }
}

std::shared_ptr<BindOnVirOP> VarPool::getLoaded(const ConstObj &obj, const std::shared_ptr<BasicBlock> &blk) {
    if (const2blks.find(obj) == const2blks.end() || const2vir.find(obj) == const2vir.end())
        return nullptr;

    const2blks[obj].insert(blk);
    return const2vir[obj];
}

bool VarPool::isLoad(const std::shared_ptr<Operand> &op) {
    auto reg = op->as<BindOnVirOP>();

    if (!reg)
        return false;

    for (auto &[obj, vir] : const2vir) {
        if (vir == op)
            return true;
    }

    return false;
}

// const auto &VarPool::getConst2Vir() { return const2vir; }
// const auto &VarPool::getConst2blks() { return const2blks; }

void VarPool::addValue(const IR::Value &val, std::shared_ptr<Operand> Value) {
    IRValueWrapper wrapper{val};
    pool[wrapper] = std::move(Value);
}

void VarPool::addLoaded(const ConstObj &obj, const std::shared_ptr<BindOnVirOP> &Value,
                        const std::shared_ptr<BasicBlock> &blk) {

    Err::gassert(const2vir[obj] == nullptr, "lowering: addLoaded for an already loaded constobj");
    const2vir[obj] = Value;
    const2blks[obj].insert(blk);
}

std::shared_ptr<BindOnVirOP> VarPool::mkOP_backup(const std::shared_ptr<IR::Type> &type, RegisterBank bank) {
    auto virtual_val = std::make_shared<IR::Value>("%" + std::to_string(size() + countbase + 1), type,
                                                   IR::ValueTrait::ORDINARY_VARIABLE);
    auto ptr = std::make_shared<BindOnVirOP>(bank, virtual_val->getName());
    addValue(*virtual_val, ptr);

    return ptr;
}

std::shared_ptr<BindOnVirOP> VarPool::addValue_anonymously(bool isFloat) {
    std::string name = '%' + std::to_string(countbase + pool.size() + 1);

    std::shared_ptr<IR::Value> val;
    if (!isFloat)
        val = std::make_shared<IR::Value>(std::move(name), IR::makeBType(IR::IRBTYPE::I32),
                                          IR::ValueTrait::ORDINARY_VARIABLE);
    else
        val = std::make_shared<IR::Value>(std::move(name), IR::makeBType(IR::IRBTYPE::FLOAT),
                                          IR::ValueTrait::ORDINARY_VARIABLE);

    std::shared_ptr<BindOnVirOP> Value;
    if (!isFloat)
        Value = std::make_shared<BindOnVirOP>(RegisterBank::gpr, val->getName());
    else
        Value = std::make_shared<BindOnVirOP>(RegisterBank::spr, val->getName());

    addValue(*val, Value);

    return Value;
}

std::shared_ptr<BaseADROP> VarPool::addPtr_anonymously() {
    std::string name = '%' + std::to_string(countbase + pool.size() + 1);

    auto val = std::make_shared<IR::Value>(name, IR::makeBType(IR::IRBTYPE::I32), IR::ValueTrait::ORDINARY_VARIABLE);

    auto Value = make<BaseADROP>(BaseAddressTrait::Runtime, name, 0, nullptr);
    Value->setBase(Value);

    addValue(*val, Value);

    return Value;
}

std::shared_ptr<StackADROP> VarPool::addStackValue_anonymously(const std::shared_ptr<FrameObj> &obj) {
    std::string name = '%' + std::to_string(countbase + pool.size() + 1);

    ///@warning 这里的val虽然应该是ptr, 但是是用Btype初始化的
    auto val = std::make_shared<IR::Value>(std::move(name), IR::makeBType(IR::IRBTYPE::I32),
                                           IR::ValueTrait::ORDINARY_VARIABLE);

    auto Value = std::make_shared<StackADROP>(obj, val->getName(), 0, getValue(CoreRegister::sp));

    addValue(*val, Value);

    return Value;
}

size_t VarPool::size() const { return pool.size(); }
#endif