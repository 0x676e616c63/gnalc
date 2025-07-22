// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_TRANSFORMS_PEEPHOLE_HPP
#define GNALC_MIR_TRANSFORMS_PEEPHOLE_HPP

#include "../pass_manager.hpp"

namespace MIR {

///@note 某些一眼丁真的优化

class GenericPeephole : public PM::PassInfo<GenericPeephole> {
public:
    enum Stage : uint32_t { AfterIsel, AfterRa, AfterPostLegalize } stage;

public:
    explicit GenericPeephole(Stage _stage) : stage(_stage) {}

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
    using Stage = GenericPeephole::Stage;

    MIRFunction *mfunc;
    FAM *fam;
    Stage stage;

public:
    void impl(MIRFunction &, FAM &, Stage);
    bool runOnBlk(MIRBlk_p &);

private:
    // inst matches
    bool Nop(MatchInfo &);            // after ra
    bool Arithmetic(MatchInfo &);     // after isel
    bool MA(MatchInfo &);             // after isel (MA = Multiple and Accumulate)
    bool Select(MatchInfo &);         // after isel
    bool RTZ(MatchInfo &);            // after isel
    bool FusedAdr(MatchInfo &);       // after stack generate
    bool ScratchRegSimp(MatchInfo &); // after post legalize

    bool rmByRC(MatchInfo &);
};
}; // namespace MIR

namespace std {

template <> struct tuple_size<MIR::GenericPeepholeImpl::MatchInfo> : integral_constant<std::size_t, 3> {};

template <size_t I> struct tuple_element<I, MIR::GenericPeepholeImpl::MatchInfo> {
    using type = decltype((declval<MIR::GenericPeepholeImpl::MatchInfo>().get<I>())); // extra brasses
};

}; // namespace std

#endif