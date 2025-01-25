#include "../../include/mir/constpool.hpp"

using namespace MIR;

template <typename T_variant>
std::shared_ptr<ConstObj> ConstPool::getConstant(const T_variant &imme) {
    auto temp = ConstVal(imme);

    auto it = pool.find(temp);
    if (it == pool.end()) {
        std::shared_ptr<ConstObj> constant =
            std::make_shared<ConstObj>(pool.size(), imme);
        it = pool.emplace(temp, constant).first;
    }

    return it->second;
}
