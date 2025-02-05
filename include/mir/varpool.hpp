#ifndef GNALC_MIR_VARPOOL_HPP
#define GNALC_MIR_VARPOOL_HPP
#include "../ir/base.hpp"
#include "operand.hpp"
#include <unordered_map>

namespace MIR {
class VarPool {
private:
    struct IRValueWrapper {
        /// @brief 为IR::Value添加 operator ==
        const IR::Value &val;
        bool operator==(const IRValueWrapper &another) const {
            return &(this->val) == &(another.val); // 比较地址
        }
    };

    struct VarPoolHash {
        size_t operator()(const IRValueWrapper &val) const {
            return std::hash<std::string>()(val.val.getName()); // Value名唯一
        }
    };

    std::unordered_map<IRValueWrapper, std::shared_ptr<Operand>, VarPoolHash>
        pool;

    std::unordered_map<CoreRegister, std::shared_ptr<PreColedOP>> gpr_pool;
    std::unordered_map<FPURegister, std::shared_ptr<PreColedOP>> spr_pool;

public:
    VarPool() = default;

    std::shared_ptr<Operand> getValue(const IR::Value &); // Use

    std::shared_ptr<PreColedOP> getValue(CoreRegister _color);
    std::shared_ptr<PreColedOP> getValue(FPURegister _color);

    void addValue(const IR::Value &, std::shared_ptr<Operand>); // Def

    size_t size() { return pool.size(); }

    ~VarPool() = default;
};

} // namespace MIR

#endif