#include "../../include/tpo/irparsertool.hpp"
using namespace IRParser;

Module IRGenerator::module;

IRGenerator::IRGenerator(const std::string &module_name) {
    module.setName(module_name);
}

std::vector<std::shared_ptr<FormalParam>>
IRPT::legalizeParams(const std::vector<std::shared_ptr<IR::FormalParam>> &params) {
    int i = 0;
    for (const auto &param : params) {
        param->setIndex(i++);
    }
    return params;
}

IRPT::pGV IRPT::newGV(STOCLASS _sc, const std::shared_ptr<Type>& _ty, const std::string& _name, const GVIniter& _initer, int _align) {
    auto &gv = GVMap[_name];
    Err::gassert(gv==nullptr, "GV is redefined!");
    gv = make<GlobalVariable>(_sc, _ty, _name, _initer, _align);
    return gv;
}

IRPT::pF IRPT::newFunc(std::string &name_, const std::vector<std::shared_ptr<FormalParam>> &params,
                       std::shared_ptr<Type> &ret_type, ConstantPool *pool,
                       std::vector<std::shared_ptr<BasicBlock>> &blks) {
    auto &f = FMap[name_];
    Err::gassert(f==nullptr, "F is redefined!");
    f = make<Function>(name_, params, ret_type, pool);
    for (const auto &blk : blks) {
        f->addBlock(blk);
    }
    for ( auto& [s, v] : UVMap ) {
        auto real_value = VMap[s];
        Err::gassert(real_value==nullptr, "real_value is not defined!");
        v->replaceSelf(real_value);
    }
    for ( auto& [s, b] : UBMap ) {
        auto real_block = UBMap[s];
        Err::gassert(real_block==nullptr, "real_block is not defined!");
        b->replaceSelf(real_block);
    }
    VMap.clear();
    BMap.clear();
    return f;
}

IRPT::pFD IRPT::newFuncDecl(std::string &name_, const std::vector<std::shared_ptr<Type>> &params,
                                std::shared_ptr<Type> &ret_type, bool is_va_arg_) {
    if (name_ == "@memset") {
        auto fd = make<FunctionDecl>(name_, params, ret_type, is_va_arg_, true, false);
        return fd;
    }
    auto fd = make<FunctionDecl>(name_, params, ret_type, is_va_arg_, false, true);
    return fd;
}

IRPT::pB IRPT::newBB(std::string name, const std::list<pI> &insts) {
    name = "%" + name;
    name.pop_back();
    auto b = make<BasicBlock>(name);
    for (auto& i : insts) {
        if (i->getOpcode() == OP::PHI) {
            b->addPhiInst(std::dynamic_pointer_cast<PHIInst>(i));
        } else {
            b->addInst(i);
        }
    }
    return b;
}
