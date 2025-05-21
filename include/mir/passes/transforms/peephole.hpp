#pragma once
#ifndef GNALC_ARMV8_MIR_TRANSFORMS_PEEPHOLE_HPP
#define GNALC_ARMV8_MIR_TRANSFORMS_PEEPHOLE_HPP

#include "mir/passes/pass_manager.hpp"

namespace MIR_new {

///@note 某些一眼丁真的优化

class GenericPeephole : public PM::PassInfo<GenericPeephole> {
public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class GenericPeepholeImpl {
public:
    struct MatchInfo {
        MIRInst_p minst;
        MIRInst_p_l &minsts;
        MIRInst_p_l::iterator &iter; // handle del carefully

        MatchInfo(MIRInst_p _minst, MIRInst_p_l &_minsts, MIRInst_p_l::iterator &_iter)
            : minst(std::move(_minst)), minsts(_minsts), iter(_iter) {}

        MatchInfo(MatchInfo &&) = delete;
        MatchInfo(const MatchInfo &) = delete;

        MatchInfo &operator=(MatchInfo &&) = delete;
        MatchInfo &operator=(const MatchInfo &) = delete;

        template <size_t I> auto &get() {
            if constexpr (I == 0) {
                return minst;
            } else if constexpr (I == 1) {
                return minsts;
            } else if constexpr (I == 2) {
                return iter;
            }
        }

        template <size_t I> const auto &get() const {
            if constexpr (I == 0) {
                return minst;
            } else if constexpr (I == 1) {
                return minsts;
            } else if constexpr (I == 2) {
                return iter;
            }
        }
    };

private:
    MIRFunction *mfunc;
    FAM *fam;

public:
    void impl(MIRFunction &, FAM &);
    bool runOnBlk(MIRBlk_p &);

private:
    // inst matches
    bool matchNop(MatchInfo &);
    bool matchZeros(MatchInfo &);
    bool matchFusedAdr(MatchInfo &);
};

}; // namespace MIR_new

namespace std {

template <> struct tuple_size<MIR_new::GenericPeepholeImpl::MatchInfo> : integral_constant<std::size_t, 3> {};

template <size_t I> struct tuple_element<I, MIR_new::GenericPeepholeImpl::MatchInfo> {
    using type = decltype((declval<MIR_new::GenericPeepholeImpl::MatchInfo>().get<I>())); // extra brasses
};

}; // namespace std

#endif