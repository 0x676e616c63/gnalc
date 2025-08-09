// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/function_specialization.hpp"
#include "ir/base.hpp"
#include "ir/function.hpp"
#include "ir/instructions/control.hpp"

namespace IR {
Attr::AttrKey FuncSpecializationAttr::Key;

struct SpecPlan {
    using ParamsT = decltype(FuncSpecializationAttr::Specialization::params);
    // Original Formal Params to Specialize
    ParamsT to_spec;
    // Original Function
    pFunc callee;
};
struct SpecPlanHash {
    size_t operator()(const SpecPlan &key) const {
        size_t hash = std::hash<pFunc>{}(key.callee);
        for (const auto &param : key.to_spec) {
            Util::hashSeedCombine(hash, std::hash<FormalParam *>{}(param.first));
            Util::hashSeedCombine(hash, std::hash<Value *>{}(param.second));
        }
        return hash;
    }
};
struct SpecPlanEqual {
    bool operator()(const SpecPlan &lhs, const SpecPlan &rhs) const {
        return lhs.callee == rhs.callee && lhs.to_spec == rhs.to_spec;
    }
};

struct SpecCallSites {
    std::vector<pCall> call_sites;
};

// TODO
bool isProfitableToSpecialize(const SpecPlan &key, const SpecCallSites &candidate) {
    if (key.callee->isRecursive()) {
        Logger::logDebug("[FuncSpec]: Skip recursive function '", key.callee->getName(), "'.");
        return false;
    }
    return true;
}

pFunc specializeFunc(Module *module, const SpecPlan &key) {
    auto *attr = key.callee->attr().getOrAdd<FuncSpecializationAttr>();
    for (const auto &spec : attr->specialized) {
        if (spec.params == key.to_spec) {
            Logger::logDebug("[FuncSpec]: Reuse specialized function '", spec.func->getName(), "'.");
            return spec.func->as<Function>();
        }
    }

    auto cloned = makeClone(key.callee);
    std::string plan_str;
    for (const auto &[orig_param, val] : key.to_spec)
        plan_str += ".idx" + std::to_string(orig_param->getIndex()) + "_to_" + val->getName();
    cloned->setName(key.callee->getName() + ".spec" + plan_str);
    module->addFunction(cloned);
    auto &cloned_params = cloned->getParams();
    std::vector<size_t> to_del;
    for (const auto &[orig_param, val] : key.to_spec) {
        auto idx = orig_param->getIndex();
        cloned_params[idx]->replaceSelf(val->as<Value>());
        to_del.emplace_back(idx);
    }
    cloned->removeParams(to_del);

    attr->specialized.emplace_back(FuncSpecializationAttr::Specialization{.params = key.to_spec, .func = cloned.get()});

    Logger::logDebug("[FuncSpec]: Specialization on function '", cloned->getName(), "' done.");
    return cloned;
}

void doSpecialize(Module *module, const SpecPlan &key, const SpecCallSites &candidate) {
    auto spec = specializeFunc(module, key);

    std::vector<size_t> to_del;
    for (const auto &[orig_param, val] : key.to_spec)
        to_del.emplace_back(orig_param->getIndex());

    for (const auto &call : candidate.call_sites) {
        call->setFunc(spec);
        call->removeArgs(to_del);
        Logger::logDebug("[FuncSpec]: Replace call '", call->getName(), "' with specialized function '",
                         spec->getName(), "'.");
    }
}

PM::PreservedAnalyses FunctionSpecializationPass::run(Function &function, FAM &manager) {
    std::unordered_map<SpecPlan, SpecCallSites, SpecPlanHash, SpecPlanEqual> candidates;
    for (const auto &bb : function) {
        for (const auto &inst : *bb) {
            if (auto call = inst->as<CALLInst>()) {
                auto callee_def = call->getFunc()->as<Function>();
                if (callee_def != nullptr) {
                    auto args = call->getArgs();
                    SpecPlan::ParamsT spec_params;
                    for (size_t i = 0; i < args.size(); ++i) {
                        if (args[i]->getVTrait() == ValueTrait::CONSTANT_LITERAL)
                            spec_params.emplace(callee_def->getParams()[i].get(), args[i].get());
                    }

                    if (spec_params.empty())
                        continue;

                    auto key = SpecPlan{spec_params, callee_def};
                    auto &candidate = candidates[key];
                    candidate.call_sites.emplace_back(call);
                }
            }
        }
    }

    for (auto it = candidates.begin(); it != candidates.end();) {
        if (!isProfitableToSpecialize(it->first, it->second))
            it = candidates.erase(it);
        else
            ++it;
    }

    if (candidates.empty())
        return PreserveAll();

    auto module = function.getParent();
    for (const auto &candidate : candidates)
        doSpecialize(module, candidate.first, candidate.second);

    return PreserveNone();
}

} // namespace IR
