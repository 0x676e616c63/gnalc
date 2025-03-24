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
        static std::map<string, pGlobalVar> GVMap;
        static std::map<string, pFunc> FMap;
        static std::map<string, pFuncDecl> UFDMap; // Undefined FuncDecl Map, 由于其总是在文件末尾，故最后进行替换
        static std::map<string, pBlock> BMap; // 新的function被定义时将清空
        static std::map<string, pVal> VMap; // 新的function被定义时将清空
        /// 用于保存Undefined却被使用的值
        /// 例如phi, br的操作数等
        /// 新的function被定义时应为空 函数创建之后使用replaceSelf替换
        static std::map<string, pBlock> UBMap;
        static std::map<string, pVal> UVMap;
    public:
        IRPT() = delete;
        ~IRPT() = delete;

        // 普通make, 用于无值指令
        template<typename T, typename... Args>
        static std::shared_ptr<T> make(Args&&... args) {
            return std::make_shared<T>(std::forward<Args>(args)...);
        }

        // value's make, 添加至vmap
        template<typename T, typename... Args>
        static std::shared_ptr<T> vmake(const std::string& id, Args&&... args) {
            auto &v = VMap[id];
            Err::gassert(v==nullptr, "Value is redefined!");
            v = std::make_shared<T>(std::forward<Args>(args)...);
            return v;
        }


        static pFunc getF(string name);
        static pBlock getB(string name);
        static pVal getV(string name); // 可获取GV或普通Value

        static std::vector<pFormalParam> legalizeParams(
            const std::vector<pFormalParam> &params);

        static pGlobalVar newGV(STOCLASS _sc, const pType& _ty, const std::string& _name, const GVIniter& _initer, int _align = 4);

        static pFunc newFunc(std::string &name_,
            const std::vector<pFormalParam> &params,
            pType &ret_type, ConstantPool *pool, std::vector<pBlock> &blks);

        static pFuncDecl newFuncDecl(std::string &name_,
            const std::vector<pType> &params,
            pType &ret_type, bool is_va_arg_=false);

        static pBlock newBB(std::string name, const std::list<pInst> &insts);
    };

    class IRGenerator {
        static Module module;
    public:
        IRGenerator() = default;
        explicit IRGenerator(const std::string& module_name);
        void generate();
        static Module &get_module() { return module; }
    };
}

#endif //IRPARSERTOOL_H
