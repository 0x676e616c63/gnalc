#pragma once
#ifndef GNALC_IR_CONSTANTPOOL_HPP
#define GNALC_IR_CONSTANTPOOL_HPP

#include <unordered_map>
#include "constant.hpp"
#include "../utils/exception.hpp"

namespace IR {

using Constant = Value; // 方便以后添加Constant类

class ConstantPool {
private:
    // 键为常量的唯一标识（类型 + 值）
    std::unordered_map<std::string, std::shared_ptr<Constant>> pool;

    // 辅助函数：生成唯一键
    template <typename T>
    std::string getKey(IRBTYPE type, const T& value) {
        return std::to_string(static_cast<int>(type)) + ":" + std::to_string(value);
    }

public:
    ConstantPool() = default;

    // 获取整型常量
    std::shared_ptr<ConstantInt> getConst(int value) {
        std::string key = getKey(IRBTYPE::I32, value);
        if (pool.find(key) == pool.end()) {
            pool[key] = std::make_shared<ConstantInt>(value);
        }
        return std::dynamic_pointer_cast<ConstantInt>(pool[key]);
    }

    // 获取浮点型常量
    std::shared_ptr<ConstantFloat> getConst(float value) {
        std::string key = getKey(IRBTYPE::FLOAT, value);
        if (pool.find(key) == pool.end()) {
            pool[key] = std::make_shared<ConstantFloat>(value);
        }
        return std::dynamic_pointer_cast<ConstantFloat>(pool[key]);
    }

    int cleanPool() {
        int count = 0;
        for (auto it = pool.begin(); it != pool.end();) {
            if (it->second.use_count() == 1) { // 只有常量池持有引用
                it = pool.erase(it);
                count++;
            } else {
                ++it;
            }
        }
        return count;
    }


    ~ConstantPool() {
        cleanPool();
        Err::gassert(pool.empty(), "ConstantPool is not empty when destroyed.");
    };
};

}



#endif