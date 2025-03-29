#pragma once
#ifndef GNALC_MIR_CONSTPOOL_HPP
#define GNALC_MIR_CONSTPOOL_HPP
#include "misc.hpp"
#include "operand.hpp"
#include <unordered_map>

namespace MIR {

class ConstPool {
private:
    class ConstVal {
    public:
        ConstVal() = delete;
        explicit ConstVal(const std::string &imme) : value(imme) {}
        explicit ConstVal(int imme) : value(imme) {}
        explicit ConstVal(float imme) : value(imme) {}
        explicit ConstVal(bool imme) : value(imme) {}
        explicit ConstVal(char imme) : value(imme) {}

        std::variant<std::string, int, float, bool, char> value;

        unsigned int getType() const { return value.index(); }

        bool operator==(const ConstVal &another) const {
            return another.value == value;
        }
    };

    struct ConstPoolHash {
        static size_t variant_hash(
            const std::variant<std::string, int, float, bool, char> &val) {
            return std::hash<
                std::remove_cv_t<std::remove_reference_t<decltype(val)>>>()(
                val);
        }

        size_t operator()(const ConstVal &constant) const {
            return std::hash<unsigned int>()(constant.getType()) ^
                   std::visit(variant_hash, constant.value);
        }
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
            std::shared_ptr<ConstObj> constant =
                std::make_shared<ConstObj>(pool.size(), imme);
            it = pool.emplace(temp, constant).first;
        }

        return it->second;
    }

    class iterator {
    private:
        std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash>::iterator pair_it;

    public:
        iterator() = delete;
        explicit iterator(std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash>::iterator _umap_it) {
            pair_it = _umap_it;
        }

        std::shared_ptr<ConstObj> &operator*() {
            return pair_it->second;
        }

        iterator &operator++() {
            pair_it++;
            return *this;
        }

        bool operator!=(const iterator &other) const {
            return other.pair_it != this->pair_it;
        }
    };

    iterator begin() {
        return iterator(pool.begin());
    }

    iterator end() {
        return iterator(pool.end());
    }

    class Citerator {
    private:
        std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash>::const_iterator pair_it;

    public:
        Citerator() = delete;
        explicit Citerator(const std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash>::const_iterator _umap_cit) {
            pair_it = _umap_cit;
        }

        const std::shared_ptr<ConstObj> &operator*() const {
            return pair_it->second;
        }

        Citerator &operator++() {
            pair_it++;
            return *this;
        }

        bool operator!=(const Citerator &other) const {
            return other.pair_it != this->pair_it;
        }
    };

    Citerator cbegin() const {
        return Citerator(pool.cbegin());
    }

    Citerator cend() const {
        return Citerator(pool.cend());
    }

    ~ConstPool() = default;
};
} // namespace MIR

#endif