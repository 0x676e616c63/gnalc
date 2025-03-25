#pragma once
#ifndef GNALC_GGC_IRPARSERTOOL_H
#define GNALC_GGC_IRPARSERTOOL_H

#include <memory>
#include <map>
#include "../ir/type_alias.hpp"
#include "../ir/visitor.hpp"
using namespace IR;

namespace IRParser {
    class IRPT { // IR Parser Tool
    public:
        using string = std::string;

    private:
        std::map<string, pGlobalVar> GVMap; // 所有的GV都在定义后使用
        std::map<string, pFunc> FMap; // 所有的Func都在定义后使用
        std::map<string, pFuncDecl> UFDMap; // Undefined FuncDecl Map, 由于其总是在文件末尾，故最后进行替换
        std::map<string, pBlock> BMap; // 新的function被定义时将清空
        std::map<string, pVal> VMap; // 新的function被定义时将清空
        /// 用于保存Undefined却被使用的值
        /// 例如phi, br的操作数等
        std::map<string, pBlock> UBMap;
        std::map<string, pVal> UVMap;
    public:
        IRPT() = default;
        ~IRPT() = default;

        void clean();

        // 普通make, 用于无值指令
        template<typename T, typename... Args>
        std::shared_ptr<T> make(Args&&... args) {
            return std::make_shared<T>(std::forward<Args>(args)...);
        }

        // value's make, 添加至vmap, newVal
        template<typename T, typename... Args>
        std::shared_ptr<T> vmake(const string& id, Args&&... args) {
            auto &v = VMap[id];
            Err::gassert(v==nullptr, "Value is redefined!");
            auto raw_v = std::make_shared<T>(std::forward<Args>(args)...);
            v = raw_v;
            return raw_v;
        }

        pFuncDecl getF(const string& name);
        pBlock getB(const string& name);
        pVal getV(const string &name); // 可获取GV或普通Value

        std::vector<pFormalParam> legalizeParams(const std::vector<pFormalParam> &params);

        pGlobalVar newGV(STOCLASS _sc, const pType& _ty, const string& _name, const GVIniter& _initer, int _align = 4);

        pFunc newFunc(string &name_,
            const std::vector<pFormalParam> &params,
            pType &ret_type, ConstantPool *pool, std::vector<pBlock> &blks);

        // replace all Undefined Function Declaration
        pFuncDecl newFuncDecl(string &name_,
            const std::vector<pType> &params,
            pType &ret_type, bool is_va_arg_=false);

        pBlock newBB(string name, const std::list<pInst> &insts);

        pPhi newPhi(const string &name, pType &ty, const std::vector<std::pair<pVal, pBlock>> &phiopers);
    };

    class IRGenerator {
        static Module module;
    public:
        IRGenerator() = default;
        explicit IRGenerator(const std::string& module_name);

        int generate();
        static Module &get_module() { return module; }
    };
}

#endif
