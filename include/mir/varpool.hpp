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

    /// 一个ConstObj, 经过ldr/mov之后得到的虚拟寄存器
    /// @warning 理论上, 这个东西可以减少ldr/mov的数量, 但是可能增加寄存器压力
    /// @warning , 尤其是某个常数或者全局变量很常用, 而且执行流程又很长时
    /// @warning 然后, 一些特别大的常数可能不在这里面, 比如ChooseMultipler生成的multipler
    /// @note 其次, 这个东西可以被其他优化方法取代
    struct LoadMapHash {
        size_t operator()(const ConstObj &obj) const {
            return (size_t)obj.getId();
        }
    };
    std::unordered_map<ConstObj, std::shared_ptr<BindOnVirOP>, LoadMapHash>
        load_map;

    // 两类预着色操作数
    std::unordered_map<CoreRegister, std::shared_ptr<PreColedOP>> gpr_pool;
    std::unordered_map<FPURegister, std::shared_ptr<PreColedOP>> spr_pool;

public:
    VarPool() = default;

    std::shared_ptr<Operand> getValue(const IR::Value &); // Use

    std::shared_ptr<PreColedOP> getValue(CoreRegister _color);
    std::shared_ptr<PreColedOP> getValue(FPURegister _color);

    std::shared_ptr<BindOnVirOP> getLoaded(const ConstObj &obj) {
        return load_map[obj];
    }

    void addValue(const IR::Value &, std::shared_ptr<Operand>); // Def

    void addLoaded(const ConstObj &, std::shared_ptr<BindOnVirOP>);
    size_t size() const { return pool.size(); }

    ~VarPool() = default;
};

} // namespace MIR

#endif