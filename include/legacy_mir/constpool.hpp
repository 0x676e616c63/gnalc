#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_CONSTPOOL_HPP
#define GNALC_LEGACY_MIR_CONSTPOOL_HPP
#include "misc.hpp"
#include "operand.hpp"
#include <unordered_map>

namespace LegacyMIR {

class ConstPool {
private:
    class ConstVal {
    public:
        ConstVal() = delete;
        explicit ConstVal(const std::string &imme);
        explicit ConstVal(int imme);
        explicit ConstVal(float imme);
        explicit ConstVal(bool imme);
        explicit ConstVal(char imme);

        std::variant<std::string, int, float, bool, char> value;

        unsigned int getType() const;

        bool operator==(const ConstVal &another) const;
    };

    struct ConstPoolHash {
        static size_t variant_hash(const std::variant<std::string, int, float, bool, char> &val);

        size_t operator()(const ConstVal &constant) const;
    };

    std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash> pool;

public:
    ConstPool() = default;

    std::shared_ptr<ConstObj> getConstant(const std::string &imme);

    template <typename T_variant> /* int, float, char, bool */
    std::shared_ptr<ConstObj> getConstant(T_variant imme) {
        ConstVal temp(imme);

        auto it = pool.find(temp);
        if (it == pool.end()) {
            std::shared_ptr<ConstObj> constant = std::make_shared<ConstObj>(pool.size(), imme);
            it = pool.emplace(temp, constant).first;
        }

        return it->second;
    }

    class iterator {
    private:
        std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash>::iterator pair_it;

    public:
        iterator() = delete;
        explicit iterator(std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash>::iterator _umap_it);

        std::shared_ptr<ConstObj> &operator*();

        iterator &operator++();

        bool operator!=(const iterator &other) const;
    };

    iterator begin();

    iterator end();

    class Citerator {
    private:
        std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash>::const_iterator pair_it;

    public:
        Citerator() = delete;
        explicit Citerator(
            const std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash>::const_iterator _umap_cit);

        const std::shared_ptr<ConstObj> &operator*() const;

        Citerator &operator++();

        bool operator!=(const Citerator &other) const;
    };

    Citerator cbegin() const;

    Citerator cend() const;

    ~ConstPool() = default;
};
} // namespace MIR

#endif
#endif