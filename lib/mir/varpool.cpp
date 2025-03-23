#include "../../include/mir/varpool.hpp"

using namespace MIR;

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
    if (gpr_pool[_color]) {
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
    if (spr_pool[_color]) {
        ptr = spr_pool[_color];
        return ptr;
    } else {
        ptr = std::make_shared<PreColedOP>(_color);
        spr_pool[_color] = ptr;
        return ptr;
    }
}

void VarPool::addValue(const IR::Value &val, std::shared_ptr<Operand> Value) {
    IRValueWrapper wrapper{val};
    pool[wrapper] = std::move(Value);
}

void VarPool::addLoaded(const ConstObj &obj, std::shared_ptr<BindOnVirOP> Value) { load_map[obj] = std::move(Value); }

std::shared_ptr<BindOnVirOP> VarPool::addValue_anonymously(bool isFloat) {
    std::string name = '%' + std::to_string(pool.size());

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

std::shared_ptr<StackADROP> VarPool::addStackValue_anonymously(const std::shared_ptr<FrameObj> &obj) {
    std::string name = '%' + std::to_string(pool.size());

    ///@warning 这里的val虽然应该是ptr, 但是是用Btype初始化的
    auto val = std::make_shared<IR::Value>(std::move(name), IR::makeBType(IR::IRBTYPE::I32),
                                           IR::ValueTrait::ORDINARY_VARIABLE);

    auto Value = std::make_shared<StackADROP>(obj, val->getName(), 0, getValue(CoreRegister::r7));

    addValue(*val, Value);

    return Value;
}