// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifndef GNALC_UTILS_FAST_SET_HPP
#define GNALC_UTILS_FAST_SET_HPP

#include <algorithm>
#include <iterator>
#include <list>
#include <stdexcept>
#include <unordered_map>
#include <utility>

namespace Util {
template <typename Key, typename Hash = std::hash<Key>, typename Equal = std::equal_to<Key>,
          typename Alloc = std::allocator<std::pair<const Key, typename std::list<Key>::iterator>>>
class FastSet {
private:
    using ContainerType = std::list<Key>;
    using IndexType = std::unordered_map<Key, typename ContainerType::iterator, Hash, Equal, Alloc>;

    ContainerType elements;
    IndexType index;

public:
    using value_type = Key;
    using size_type = size_t;
    using difference_type = ptrdiff_t;
    using reference = Key &;
    using const_reference = const Key &;
    using pointer = Key *;
    using const_pointer = const Key *;

    using iterator = typename ContainerType::iterator;
    using const_iterator = typename ContainerType::const_iterator;
    using reverse_iterator = typename ContainerType::reverse_iterator;
    using const_reverse_iterator = typename ContainerType::const_reverse_iterator;

    FastSet() = default;
    FastSet(std::initializer_list<Key> init) {
        for (const auto &elem : init)
            insert(elem);
    }

    template <typename InputIterator> FastSet(InputIterator first, InputIterator last) {
        for (; first != last; ++first)
            insert(*first);
    }

    template <typename Container>
    explicit FastSet(const Container &container) : FastSet(container.begin(), container.end()) {}

    FastSet(const FastSet &other) : elements(other.elements) { rebuildMap(); }

    FastSet(FastSet &&other) noexcept : elements(std::move(other.elements)), index(std::move(other.index)) {}

    FastSet &operator=(const FastSet &other) {
        if (this != &other) {
            elements = other.elements;
            rebuildMap();
        }
        return *this;
    }

    FastSet &operator=(FastSet &&other) noexcept {
        if (this != &other) {
            elements = std::move(other.elements);
            index = std::move(other.index);
        }
        return *this;
    }

    void rebuildMap() {
        index.clear();
        for (auto it = elements.begin(); it != elements.end(); ++it)
            index[*it] = it;
    }

    bool empty() const noexcept { return elements.empty(); }
    size_t size() const noexcept { return elements.size(); }
    size_t max_size() const noexcept { return elements.max_size(); }

    iterator begin() noexcept { return elements.begin(); }
    const_iterator begin() const noexcept { return elements.begin(); }
    const_iterator cbegin() const noexcept { return elements.cbegin(); }
    iterator end() noexcept { return elements.end(); }
    const_iterator end() const noexcept { return elements.end(); }
    const_iterator cend() const noexcept { return elements.cend(); }
    reverse_iterator rbegin() noexcept { return elements.rbegin(); }
    const_reverse_iterator rbegin() const noexcept { return elements.rbegin(); }
    const_reverse_iterator crbegin() const noexcept { return elements.crbegin(); }
    reverse_iterator rend() noexcept { return elements.rend(); }
    const_reverse_iterator rend() const noexcept { return elements.rend(); }
    const_reverse_iterator crend() const noexcept { return elements.crend(); }

    Key &front() { return elements.front(); }
    const Key &front() const { return elements.front(); }
    Key &back() { return elements.back(); }
    const Key &back() const { return elements.back(); }

    std::pair<iterator, bool> insert(const Key &key) {
        auto [it, inserted] = index.try_emplace(key, iterator{});
        if (inserted) {
            elements.emplace_back(key);
            it->second = std::prev(end());
            return {it->second, true};
        }
        return {it->second, false};
    }

    std::pair<iterator, bool> insert(Key &&key) {
        auto it = index.find(key);
        if (it != index.end())
            return {it->second, false};

        elements.emplace_back(std::move(key));
        auto list_it = std::prev(end());
        index.emplace(elements.back(), list_it);
        return {list_it, true};
    }

    template <typename... Args> std::pair<iterator, bool> emplace(Args &&...args) {
        Key elem{std::forward<Args>(args)...};
        return insert(std::move(elem));
    }

    iterator erase(iterator pos) {
        if (pos == end())
            return end();

        auto next = std::next(pos);
        index.erase(*pos);
        elements.erase(pos);
        return next;
    }

    size_t erase(const Key &key) {
        auto it = index.find(key);
        if (it == index.end())
            return 0;

        erase(it->second);
        return 1;
    }

    void clear() noexcept {
        elements.clear();
        index.clear();
    }

    void swap(FastSet &other) noexcept {
        elements.swap(other.elements);
        index.swap(other.index);
    }

    size_t count(const Key &key) const { return index.count(key); }

    iterator find(const Key &key) {
        auto it = index.find(key);
        if (it == index.end())
            return end();
        return it->second;
    }

    const_iterator find(const Key &key) const {
        auto it = index.find(key);
        if (it == index.end())
            return end();
        return it->second;
    }

    size_t bucket_count() const noexcept { return index.bucket_count(); }
    size_t max_bucket_size() const noexcept { return index.max_bucket_size(); }
    size_t bucket_size(size_t n) const { return index.bucket_size(n); }
    size_t bucket(const Key &key) const { return index.bucket(key); }

    float load_factor() const noexcept { return index.load_factor(); }
    float max_load_factor() const noexcept { return index.max_load_factor(); }
    void max_load_factor(float z) { index.max_load_factor(z); }
    void rehash(size_t n) { index.rehash(n); }
    void reserve(size_t n) { index.reserve(n); }

    bool operator==(const FastSet &rhs) const {
        return index.size() == rhs.index.size() && std::all_of(index.begin(), index.end(), [&](auto const &p) {
                   return rhs.index.find(p.first) != rhs.index.end();
               });
    }
    bool operator!=(const FastSet &rhs) const { return !(*this == rhs); }
};

template <typename Key> FastSet<Key> fastset_difference(const FastSet<Key> &A, const FastSet<Key> &B) {
    FastSet<Key> result;
    result.reserve(A.size());
    for (const auto &elem : A) {
        if (B.find(elem) == B.end())
            result.insert(elem);
    }
    return result;
}

template <typename Key> FastSet<Key> fastset_union(const FastSet<Key> &A, const FastSet<Key> &B) {
    FastSet<Key> result = A;
    result.reserve(A.size() + B.size());
    for (const auto &elem : B)
        result.insert(elem);
    return result;
}
} // namespace Util

#endif // FAST_SET_HPP
