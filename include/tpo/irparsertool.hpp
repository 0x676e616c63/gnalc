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
        template<typename T, typename... Args>
        static std::shared_ptr<T> make(Args&&... args) {
            return std::make_shared<T>(std::forward<Args>(args)...);
        }

        using pF = std::shared_ptr<IR::Function>;
        using pFD = std::shared_ptr<IR::FunctionDecl>;
        using pGV = std::shared_ptr<IR::GlobalVariable>;
        using pB = std::shared_ptr<IR::BasicBlock>;
        using pI = std::shared_ptr<IR::Instruction>;
        using pV = std::shared_ptr<IR::Value>;
        using pT = std::shared_ptr<IR::Type>;
        using string = std::string;

    private:
        static std::map<string, pF> FMap;
        static std::map<string, pGV> GVMap;
        static std::map<string, pB> BMap; // 新的function被定义时将清空
        static std::map<string, pV> VMap; // 新的function被定义时将清空
        /// 用于保存尚未创建却被使用的值
        /// 例如phi, br的操作数等
        /// 新的function被定义时应为空
        /// 当该string对应的value被创建时，使用replaceSelf替换
        static std::map<string, pFD> TempFDMap;
        static std::map<string, pB> TempBMap;
        static std::map<string, pV> TempVMap;
    public:
        IRPT() = delete;
        ~IRPT() = delete;

        static pF getF(string name);
        static pF initF(string name, pF f);
        static pB getB(string name);
        static pF initB(string name, pB b);
        static pV getV(string name);
        static pV initV(string name, pV v);

        static std::vector<std::shared_ptr<FormalParam>> legalizeParams(
            const std::vector<std::shared_ptr<IR::FormalParam>> &params);

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
