#include "mir-old/constpool.hpp"

using namespace MIR;

ConstPool::ConstVal::ConstVal(const std::string &imme) : value(imme) {}
ConstPool::ConstVal::ConstVal(int imme) : value(imme) {}
ConstPool::ConstVal::ConstVal(float imme) : value(imme) {}
ConstPool::ConstVal::ConstVal(bool imme) : value(imme) {}
ConstPool::ConstVal::ConstVal(char imme) : value(imme) {}

unsigned int ConstPool::ConstVal::getType() const { return value.index(); }

bool ConstPool::ConstVal::operator==(const ConstVal &another) const { return another.value == value; }

size_t ConstPool::ConstPoolHash::variant_hash(const std::variant<std::string, int, float, bool, char> &val) {
    return std::hash<std::remove_cv_t<std::remove_reference_t<decltype(val)>>>()(val);
}

size_t ConstPool::ConstPoolHash::operator()(const ConstVal &constant) const {
    return std::hash<unsigned int>()(constant.getType()) ^ std::visit(variant_hash, constant.value);
}

std::shared_ptr<ConstObj> ConstPool::getConstant(const std::string &imme) {
    auto temp = ConstVal(imme);

    auto it = pool.find(temp);
    if (it == pool.end()) {
        std::shared_ptr<ConstObj> constant = std::make_shared<ConstObj>(pool.size(), imme);
        it = pool.emplace(temp, constant).first;
    }

    return it->second;
}

ConstPool::iterator::iterator(
    std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash>::iterator _umap_it) {
    pair_it = _umap_it;
}

std::shared_ptr<ConstObj> &ConstPool::iterator::operator*() { return pair_it->second; }

ConstPool::iterator &ConstPool::iterator::operator++() {
    pair_it++;
    return *this;
}

bool ConstPool::iterator::operator!=(const iterator &other) const { return other.pair_it != this->pair_it; }

ConstPool::iterator ConstPool::begin() { return iterator(pool.begin()); }

ConstPool::iterator ConstPool::end() { return iterator(pool.end()); }

ConstPool::Citerator::Citerator(
    const std::unordered_map<ConstVal, std::shared_ptr<ConstObj>, ConstPoolHash>::const_iterator _umap_cit) {
    pair_it = _umap_cit;
}

const std::shared_ptr<ConstObj> &ConstPool::Citerator::operator*() const { return pair_it->second; }

ConstPool::Citerator &ConstPool::Citerator::operator++() {
    pair_it++;
    return *this;
}

bool ConstPool::Citerator::operator!=(const Citerator &other) const { return other.pair_it != this->pair_it; }

ConstPool::Citerator ConstPool::cbegin() const { return Citerator(pool.cbegin()); }

ConstPool::Citerator ConstPool::cend() const { return Citerator(pool.cend()); }