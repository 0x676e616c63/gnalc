#pragma once
#ifndef IRPARSERTOOL_H
#define IRPARSERTOOL_H

#include <memory>
#include <map>
#include "../ir/visitor.hpp"

namespace IRPT {
    class IRPT { // IR Parser Tool
    public:
        template<typename T, typename... Args>
        static std::shared_ptr<T> make(Args&&... args) {
            return std::make_shared<T>(std::forward<Args>(args)...);
        }

        using pF = std::shared_ptr<IR::Function>;
        using pGV = std::shared_ptr<IR::GlobalVariable>;
        using pB = std::shared_ptr<IR::BasicBlock>;
        using pI = std::shared_ptr<IR::Instruction>;
        using pV = std::shared_ptr<IR::Value>;
        using pT = std::shared_ptr<IR::Type>;
        using string = std::string;

    private:
        std::map<string, pF> FMap;
        std::map<string, pGV> GVMap;
        std::map<string, pB> BMap; // 新的function被定义时将清空
        std::map<string, pV> VMap; // 新的function被定义时将清空
        /// 用于保存尚未创建却被使用的值
        /// 例如phi, br的操作数等
        /// 新的function被定义时应为空
        /// 当该string对应的value被创建时，使用replaceSelf替换
        std::map<string, pB> TempBMap;
        std::map<string, pV> TempVMap;
    public:
        IRPT();

        pF getF(string name);
        pF initF(string name, pF f);
        pB getB(string name);
        pF initB(string name, pB b);
        pV getV(string name);
        pV initV(string name, pV v);

        ~IRPT();
    };
}

#endif //IRPARSERTOOL_H
