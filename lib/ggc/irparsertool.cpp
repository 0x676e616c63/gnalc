#include "../../include/ggc/irparsertool.hpp"
#include "../../include/ggc/irparser.hpp"
using namespace IRParser;

Module IRGenerator::module;

extern IRPT tool;

// std::map<IRPT::string, pGlobalVar> IRPT::GVMap;
// std::map<IRPT::string, pFunc> IRPT::FMap;
// std::map<IRPT::string, pFuncDecl> IRPT::UFDMap;
// std::map<IRPT::string, pBlock> IRPT::BMap;
// std::map<IRPT::string, pVal> IRPT::VMap;
// std::map<IRPT::string, pBlock> IRPT::UBMap;
// std::map<IRPT::string, pVal> IRPT::UVMap;

IRGenerator::IRGenerator(const std::string &module_name) {
    module.setName(module_name);
}

int IRGenerator::generate() {
    yyy::parser parser;
    if (parser.parse()) {
        tool.clean();
        return 1;
    }
    tool.clean();
    return 0;
}

void IRPT::clean() {
    GVMap.clear();
    FMap.clear();
    UFDMap.clear();
    BMap.clear();
    VMap.clear();
    UBMap.clear();
    UVMap.clear();
}

pFuncDecl IRPT::getF(const string& name) {
    const auto it = FMap.find(name);
    if (it == FMap.end()) {
        auto &f = UFDMap[name];
        if (f == nullptr) {
            f = make<FunctionDecl>("UNDEFFUNC", std::vector<pType>{}, makeBType(IRBTYPE::UNDEFINED), false, false, false);
        }
        return f;
    }
    return it->second;
}

pBlock IRPT::getB(const string& name) {
    const auto it = BMap.find(name);
    if (it == BMap.end()) {
        auto &b = UBMap[name];
        if (b == nullptr) {
            b = make<BasicBlock>("UNDEFBLOCK");
        }
        return b;
    }
    return it->second;
}

pVal IRPT::getV(const string &name) {
    if (name[0] == '@') {
        const auto it = GVMap.find(name);
        return it->second;
    }
    const auto it = VMap.find(name);
    if (it == VMap.end()) {
        auto &v = UVMap[name];
        if (v == nullptr) {
            v = make<Value>("UNDEFVALUE", makeBType(IRBTYPE::UNDEFINED), ValueTrait::UNDEFINED);
        }
        return v;
    }
    return it->second;
}

std::vector<pFormalParam> IRPT::legalizeParams(const std::vector<pFormalParam> &params) {
    int i = 0;
    for (const auto &param : params) {
        param->setIndex(i++);
    }
    return params;
}

pGlobalVar IRPT::newGV(STOCLASS _sc, const pType& _ty, const std::string& _name, const GVIniter& _initer, int _align) {
    auto &gv = GVMap[_name];
    Err::gassert(gv==nullptr, "GV is redefined!");
    gv = make<GlobalVariable>(_sc, _ty, _name, _initer, _align);
    return gv;
}

pFunc IRPT::newFunc(std::string &name_, const std::vector<pFormalParam> &params,
                       pType &ret_type, ConstantPool *pool,
                       std::vector<pBlock> &blks) {
    auto &f = FMap[name_];
    Err::gassert(f==nullptr, "F is redefined!");
    f = make<Function>(name_, params, ret_type, pool);
    for (const auto &blk : blks) {
        f->addBlock(blk);
    }
    for ( auto& [s, v] : UVMap ) {
        auto real_value = VMap[s];
        Err::gassert(real_value!=nullptr, "real_value is not defined!");
        v->replaceSelf(real_value);
    }
    for ( auto& [s, b] : UBMap ) {
        auto real_block = BMap[s];
        Err::gassert(real_block!=nullptr, "real_block is not defined!");
        b->replaceSelf(real_block);
    }
    f->updateAndCheckCFG();
    VMap.clear();
    BMap.clear();
    UBMap.clear();
    UVMap.clear();
    return f;
}

pFuncDecl IRPT::newFuncDecl(std::string &name_, const std::vector<pType> &params,
                                pType &ret_type, bool is_va_arg_) {
    pFuncDecl fd;
    if (name_ == "@memset") {
        fd = make<FunctionDecl>(name_, params, ret_type, is_va_arg_, true, false);
    } else {
        fd = make<FunctionDecl>(name_, params, ret_type, is_va_arg_, false, true);
    }
    if (const auto it = UFDMap.find(name_); it != UFDMap.end()) {
        it->second->replaceSelf(fd);
    }
    return fd;
}

pBlock IRPT::newBB(std::string name, const std::list<pInst> &insts) {
    name = "%" + name;
    name.pop_back();
    auto &b = BMap[name];
    Err::gassert(b==nullptr, "BB is redefined!");
    b = std::make_shared<BasicBlock>(name);
    for (auto& i : insts) {
        if (i->getOpcode() == OP::PHI) {
            b->addPhiInst(i->as<PHIInst>());
        } else {
            b->addInst(i);
        }
    }
    return b;
}

pPhi IRPT::newPhi(const string &name, pType &ty, const std::vector<std::pair<pVal, pBlock>>& phiopers) {
    auto p = vmake<PHIInst>(name, name, ty);
    for (auto& [v, b] : phiopers) {
        p->addPhiOper(v, b);
    }
    return p;
}
