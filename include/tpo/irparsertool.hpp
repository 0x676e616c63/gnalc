#pragma once
#ifndef IRPARSERTOOL_H
#define IRPARSERTOOL_H

#include <memory>
#include <map>
#include "../ir/visitor.hpp"
using namespace IR;

namespace IRParser {
    class IRPT { // IR Parser Tool
    public:
        using pF = std::shared_ptr<IR::Function>;
        using pFD = std::shared_ptr<IR::FunctionDecl>;
        using pGV = std::shared_ptr<IR::GlobalVariable>;
        using pB = std::shared_ptr<IR::BasicBlock>;
        using pI = std::shared_ptr<IR::Instruction>;
        using pV = std::shared_ptr<IR::Value>;
        using pT = std::shared_ptr<IR::Type>;
        using string = std::string;

    private:
        static std::map<string, pGV> GVMap;
        static std::map<string, pF> FMap;
        static std::map<string, pFD> UFDMap; // Undefined FuncDecl Map, 由于其总是在文件末尾，故最后进行替换
        static std::map<string, pB> BMap; // 新的function被定义时将清空
        static std::map<string, pV> VMap; // 新的function被定义时将清空
        /// 用于保存Undefined却被使用的值
        /// 例如phi, br的操作数等
        /// 新的function被定义时应为空 函数创建之后使用replaceSelf替换
        static std::map<string, pB> UBMap;
        static std::map<string, pV> UVMap;
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


        static pF getF(string name);
        static pB getB(string name);
        static pV getV(string name); // 可获取GV或普通Value

        static std::vector<std::shared_ptr<FormalParam>> legalizeParams(
            const std::vector<std::shared_ptr<IR::FormalParam>> &params);

        static pGV newGV(STOCLASS _sc, const std::shared_ptr<Type>& _ty, const std::string& _name, const GVIniter& _initer, int _align = 4);

        static pF newFunc(std::string &name_,
            const std::vector<std::shared_ptr<FormalParam>> &params,
            std::shared_ptr<Type> &ret_type, ConstantPool *pool, std::vector<std::shared_ptr<BasicBlock>> &blks);

        static pFD newFuncDecl(std::string &name_,
            const std::vector<std::shared_ptr<Type>> &params,
            std::shared_ptr<Type> &ret_type, bool is_va_arg_=false);

        static pB newBB(std::string name, const std::list<pI> &insts);
    };

    class IRGenerator {
        static IR::Module module;
    public:
        IRGenerator() = default;
        explicit IRGenerator(const std::string& module_name);
        void generate();
        static IR::Module &get_module() { return module; }
    };
}

#endif //IRPARSERTOOL_H
