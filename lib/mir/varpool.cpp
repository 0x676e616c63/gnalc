#include "../../include/mir/varpool.hpp"

using namespace MIR;

std::shared_ptr<Operand> VarPool::getValue(const IR::Value &val) {
    IRValueWrapper wrapper{val};

    auto it = pool.find(wrapper);

    if (it == pool.end()) {
        return nullptr;
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