// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#include "mir/info.hpp"
#include "mir/passes/transforms/scheduling.hpp"
#include <cstdint>
#include <functional>
#include <type_traits>
#include <unordered_map>
#ifndef GNALC_MIR_PASSES_TRANSFORMS_REDUNDANTLOADELI
#define GNALC_MIR_PASSES_TRANSFORMS_REDUNDANTLOADELI

#include "mir/passes/pass_manager.hpp"
#include "utils/fast_set.hpp"

namespace MIR {

class RedundantLoadEli : public PM::PassInfo<RedundantLoadEli> {
public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class RedundantLoadEliImpl {
private:
    struct ldValue {
        std::variant<uint32_t, float, uint64_t, string> inner;
        OpT type;
        size_t size{};
        size_t align{};

        [[nodiscard]] bool isI32() const { return inner.index() == 0; };
        [[nodiscard]] bool isF32() const { return inner.index() == 1; };
        [[nodiscard]] bool isI64() const { return inner.index() == 2; };
        [[nodiscard]] bool isLiteral() const { return inner.index() == 3; };

        [[nodiscard]] bool isZero() const {
            return isI32() && std::get<0>(inner) == 0UL || isF32() && std::get<1>(inner) == 0.0f ||
                   isI64() && std::get<2>(inner) == 0ULL;
        }

        [[nodiscard]] OpC getLoadOpC() const {
            switch (inner.index()) {
            case 0:
                return OpC::InstLoadImm;
            case 1:
                return OpC::InstLoadFPImm;
            case 2:
                return OpC::InstLoadImmEx;
            case 3:
                return OpC::InstLoadLiteral;
            }
            return OpC::InstLoadImm; // just to make clang happy
        }

        [[nodiscard]] MIROperand_p getConstOp() const {
            return std::visit(
                [&](const auto &v) {
                    using T = std::decay_t<decltype(v)>;

                    if constexpr (std::is_same_v<uint32_t, T>) {
                        return MIROperand::asImme(std::get<0>(inner), type);
                    } else if constexpr (std::is_same_v<float, T>) {
                        return MIROperand::asImme(std::get<1>(inner), type);
                    } else if constexpr (std::is_same_v<uint64_t, T>) {
                        return MIROperand::asImme(std::get<2>(inner), type);
                    } else {
                        return MIROperand::asLiteral(std::get<3>(inner), type);
                    }
                },
                inner);
        }

        ldValue() = delete;
        explicit ldValue(uint32_t _u32) : inner(_u32), type(OpT::Int32) {}
        explicit ldValue(float _f32) : inner(_f32), type(OpT::Float32) {}
        explicit ldValue(uint64_t _u64) : inner(_u64), type(OpT::Int64) {}
        explicit ldValue(string literal, OpT _type, size_t _size, size_t _align)
            : inner(std::move(literal)), type(_type), size(_size), align(_align) {}

        bool operator==(const ldValue &other) const { return inner == other.inner; };
        bool operator==(ldValue &&other) const { return inner == other.inner; };
    };

    struct loadInfo {
        ldValue loadedValue; // uint32 & float & uint64 & literal
        Util::FastSet<MIRBlk_p> mblks;

        std::map<MIRBlk *, std::vector<std::pair<MIROperand_p, MIRInst_p_l::iterator>>> const_uses;

        MIRBlk *lca = nullptr;

        bool operator==(const loadInfo &other) { return other.loadedValue == loadedValue; };
    };

    struct infoHash {
        std::size_t operator()(const ldValue &constVal) const {
            // std::size_t h1 = std::hash<unsigned>{}(constVal.first);
            // std::size_t h2 = std::hash<bool>{}(constVal.second);
            // return h1 ^ (h2 << 1);

            return std::visit(
                [](const auto &v) -> size_t {
                    using T = std::decay_t<decltype(v)>;

                    // if constexpr (std::is_same_v<T, float>) {
                    //     return std::hash<float>{}(v) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
                    // } else {
                    //     return std::hash<T>{}(v) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
                    // }
                    if constexpr (std::is_same_v<uint32_t, T>) {
                        return std::hash<T>{}(v) ^ (0 << 1);
                    } else if constexpr (std::is_same_v<float, T>) {
                        return std::hash<T>{}(v) ^ (1 << 1);
                    } else if constexpr (std::is_same_v<uint64_t, T>) {
                        return std::hash<T>{}(v) ^ (2 << 1);
                    } else {
                        return std::hash<T>{}(v) ^ (3 << 1);
                    }
                },
                constVal.inner);
        }
    };

private:
    MIRFunction &mfunc;
    FAM &fam;

    CodeGenContext &ctx;
    std::unordered_map<ldValue, loadInfo, infoHash> infos;

public:
    RedundantLoadEliImpl(MIRFunction &_mfunc, FAM &_fam) : mfunc(_mfunc), fam(_fam), ctx(mfunc.Context()) {}
    void Impl();
    void MkInfo();
    void CulculateLCA();
    void ApplyCopys();
};

}; // namespace MIR

#endif