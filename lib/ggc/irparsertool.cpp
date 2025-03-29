#include "../../include/ggc/irparsertool.hpp"

#include "../../include/config/config.hpp"
#include "../../include/ggc/irparser.hpp"
using namespace IRParser;

Module IRGenerator::module;

extern IRPT tool;

IRGenerator::IRGenerator(const std::string &module_name) {
    module.setName(module_name);
}

int IRGenerator::generate() {
    yyy::parser parser;
    // parser.set_debug_level(1);
    if (parser.parse()) {
        tool.clean();
        return 1;
    }
    tool.clean();
    // IRPT::refactorAllInst(module);
    return 0;
}

void IRPT::clean() {
    GVMap.clear();
    FMap.clear();
    UFMap.clear();
    BMap.clear();
    VMap.clear();
    UBMap.clear();
    UVMap.clear();
}

pFuncDecl IRPT::getF(const string& name) {
    const auto it = FMap.find(name);
    if (it == FMap.end()) {
        auto &f = UFMap[name];
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

float IRPT::hexToFloat(const string &hex) {
    union {
        double d;
        uint64_t l;
    } u;
    u.l = std::stoul(hex, nullptr, 16);
    return u.d;
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
    replaceUF(name_, f);
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
    if (name_ == "@" + std::string{Config::IR::BUILTIN_MEMSET}) {
        fd = make<FunctionDecl>(name_, params, ret_type, is_va_arg_, true, false);
    } else {
        fd = make<FunctionDecl>(name_, params, ret_type, is_va_arg_, false, true);
    }
    replaceUF(name_, fd);
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

void IRPT::replaceUF(const string &name_, const pFuncDecl& fd) {
    if (const auto it = UFMap.find(name_); it != UFMap.end()) {
        it->second->replaceSelf(fd);
        for (auto user : fd->users()) {
            auto inst = user->as<Instruction>();
            if (inst->getOpcode() == OP::CALL) {
                inst->vtype = fd->getType()->as<FunctionType>()->getRet();
                inst->trait =  inst->vtype->getTrait() != IRCTYPE::BASIC ||
                (inst->vtype->getTrait() == IRCTYPE::BASIC && inst->vtype->as<BType>()->getInner() != IRBTYPE::UNDEFINED &&
                 inst->vtype->as<BType>()->getInner() != IRBTYPE::VOID)
            ? ValueTrait::ORDINARY_VARIABLE
            : ValueTrait::VOID_INSTRUCTION;
            }
        }
    }
}

void IRPT::refactorAllInst(const Module& module) {
    for (auto &func : module.getFunctions()) {
        for (auto &blk : func->getBlocks()) {
            for (auto it = blk->phi_begin(); it != blk->phi_end(); ++it) {
                pPhi new_inst = (*it)->clone()->as<PHIInst>();
                (*it)->replaceSelf(new_inst);
                *it = new_inst;
            }
            for (auto it = blk->begin(); it != blk->end(); ++it) {
                pInst new_inst = (*it)->clone()->as<Instruction>();
                (*it)->replaceSelf(new_inst);
                *it = new_inst;
            }
        }
    }
}
