// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_UTILS_ATTRIBUTE_HPP
#define GNALC_UTILS_ATTRIBUTE_HPP

#include "misc.hpp"

#include <memory>
#include <vector>
#include <type_traits>
#include <string_view>

namespace Attr {
class alignas(8) AttrKey {};

class AttrConcept {
public:
    virtual ~AttrConcept() = default;
    virtual std::unique_ptr<AttrConcept> clone() const = 0;
};

template <typename AttrT> class AttrModel : public AttrConcept {
public:
    explicit AttrModel(AttrT attr_) : attr(std::move(attr_)) {}
    AttrT attr;

    [[nodiscard]] std::unique_ptr<AttrConcept> clone() const override {
        return std::make_unique<AttrModel<AttrT>>(attr);
    }
};

template <typename DerivedT> class AttrInfo {
public:
    static AttrKey *ID() {
        static_assert(std::is_base_of_v<AttrInfo, DerivedT>, "The template argument should be the derived type.");
        return &DerivedT::Key;
    }

    static std::string_view name() {
        static_assert(std::is_base_of_v<AttrInfo, DerivedT>, "The template argument should be the derived type.");
        return Util::getTypeName<DerivedT>();
    }
};

class AttrManager {
    using StorageT = std::vector<std::pair<AttrKey *, std::unique_ptr<AttrConcept>>>;
    StorageT storage;

public:
    AttrManager() = default;
    AttrManager(const AttrManager& other) {
        for (const auto& [key, value] : other.storage)
            storage.emplace_back(key, value->clone());
    }
    AttrManager& operator=(const AttrManager& other) {
        if (this == &other) return *this;
        storage.clear();
        for (const auto& [key, value] : other.storage)
            storage.emplace_back(key, value->clone());
        return *this;
    }
    AttrManager(AttrManager&&) noexcept = default;
    AttrManager& operator=(AttrManager&&) noexcept = default;


    template <typename AttrT> bool add(AttrT attr) {
        for (const auto &[key, value] : storage) {
            if (key == AttrT::ID())
                return false;
        }
        storage.emplace_back(AttrT::ID(), std::make_unique<AttrModel<AttrT>>(std::move(attr)));
        return true;
    }

    template <typename AttrT> AttrT *get() const {
        for (const auto &[key, value] : storage) {
            if (key == AttrT::ID())
                return &static_cast<AttrModel<AttrT> *>(value.get())->attr;
        }
        return nullptr;
    }

    template <typename AttrT> AttrT *getOrAdd(AttrT default_value = AttrT{}) {
        for (const auto &[key, value] : storage) {
            if (key == AttrT::ID())
                return &static_cast<AttrModel<AttrT> *>(value.get())->attr;
        }
        storage.emplace_back(AttrT::ID(), std::make_unique<AttrModel<AttrT>>(std::move(default_value)));
        return &static_cast<AttrModel<AttrT> *>(storage.back().second.get())->attr;
    }

    template <typename AttrT> bool has() const {
        for (const auto &[key, value] : storage) {
            if (key == AttrT::ID())
                return true;
        }
        return false;
    }
    template <typename AttrT> bool remove() {
        for (auto it = storage.begin(); it != storage.end(); ++it) {
            if (it->first == AttrT::ID()) {
                storage.erase(it);
                return true;
            }
        }
        return false;
    }
    void clear() { storage.clear(); }
    size_t size() const { return storage.size(); }
    bool empty() const { return storage.empty(); }
};

template <typename FlagT>
class BitFlagsAttr : public AttrInfo<BitFlagsAttr<FlagT>> {
    using UnderlyingT = std::underlying_type_t<FlagT>;
    UnderlyingT value{};

public:
    BitFlagsAttr() = default;
    explicit BitFlagsAttr(FlagT flag) : value(static_cast<UnderlyingT>(flag)) {}

    explicit operator FlagT() const {
        return static_cast<FlagT>(value);
    }

    FlagT val() const {
        return static_cast<FlagT>(value);
    }

    bool empty() const {
        return value == 0;
    }

    bool has(FlagT flag) const {
        return (value & static_cast<UnderlyingT>(flag)) != 0;
    }

    void set(FlagT flag) {
        value |= static_cast<UnderlyingT>(flag);
    }

    void clear(FlagT flag) {
        value &= ~static_cast<UnderlyingT>(flag);
    }

    void toggle(FlagT flag) {
        value ^= static_cast<UnderlyingT>(flag);
    }

    BitFlagsAttr& operator=(const BitFlagsAttr<FlagT>& other) {
        value = other.value;
        return *this;
    }

    BitFlagsAttr& operator=(FlagT flag) {
        value = static_cast<UnderlyingT>(flag);
        return *this;
    }

private:
    friend class AttrInfo<BitFlagsAttr<FlagT>>;
    static AttrKey Key;
};

template <typename FlagT>
AttrKey BitFlagsAttr<FlagT>::Key;
} // namespace Attr

#endif
