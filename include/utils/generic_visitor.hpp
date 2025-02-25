// Generic Breadth-First/Depth-First Visitor,
// providing an interface for easy traversal of CFGs and DomTrees
//
// TODO: Current implementation performs eager traversal during the construction,
//       which may introduce overhead for large graphs. Certain traversal orders
//       could be optimized with lazy evaluation to enable on-demand traversal.
#pragma once
#ifndef GNALC_UTILS_GENERIC_VISITOR_HPP
#define GNALC_UTILS_GENERIC_VISITOR_HPP

#include <deque>
#include <set>
#include <vector>

namespace Util {
template <typename NodeT, typename ChildrenGetter>
class GenericBFVisitor {
    std::vector<NodeT> worklist{};

public:
    using reference = typename decltype(worklist)::reference;
    using const_reference = typename decltype(worklist)::const_reference;
    using iterator = typename decltype(worklist)::iterator;
    using const_iterator = typename decltype(worklist)::const_iterator;
    using reverse_iterator = typename decltype(worklist)::reverse_iterator;
    using const_reverse_iterator = typename decltype(worklist)::const_reverse_iterator;

    explicit GenericBFVisitor(NodeT root) {
        std::deque<NodeT> q{root};
        std::set<NodeT> visited;
        while (!q.empty()) {
            auto curr = q.front();
            q.pop_front();
            visited.insert(curr);

            worklist.push_back(curr);

            const auto &children = ChildrenGetter()(curr);
            for (const auto &child : children) {
                if (visited.find(child) == visited.end())
                    q.push_back(child);
            }
        }
    }

    const_reference operator[](size_t i) const { return worklist[i]; }
    reference operator[](size_t i) { return worklist[i]; }

    [[nodiscard]] size_t size() const { return worklist.size(); }
    [[nodiscard]] iterator begin() const { return worklist.begin(); }
    [[nodiscard]] iterator end() const { return worklist.end(); }
    [[nodiscard]] const_iterator begin() { return worklist.begin(); }
    [[nodiscard]] const_iterator end() { return worklist.end(); }
    [[nodiscard]] const_iterator cbegin() const { return worklist.cbegin(); }
    [[nodiscard]] const_iterator cend() const { return worklist.cend(); }
    [[nodiscard]] reverse_iterator rbegin() { return worklist.rbegin(); }
    [[nodiscard]] reverse_iterator rend() { return worklist.rend(); }
    [[nodiscard]] const_reverse_iterator rbegin() const { return worklist.rbegin(); }
    [[nodiscard]] const_reverse_iterator rend() const { return worklist.rend(); }
    [[nodiscard]] const_reverse_iterator crbegin() const { return worklist.crbegin(); }
    [[nodiscard]] const_reverse_iterator crend() const { return worklist.crend(); }
};

enum class DFVOrder { PreOrder, PostOrder, ReversePreOrder, ReversePostOrder };

template <typename NodeT, typename ChildrenGetter, DFVOrder order = DFVOrder::PreOrder>
class GenericDFVisitor {
    std::vector<NodeT> worklist{};

public:
    using reference = typename decltype(worklist)::reference;
    using const_reference = typename decltype(worklist)::const_reference;
    using iterator = typename decltype(worklist)::iterator;
    using const_iterator = typename decltype(worklist)::const_iterator;
    using reverse_iterator = typename decltype(worklist)::reverse_iterator;
    using const_reverse_iterator = typename decltype(worklist)::const_reverse_iterator;

    explicit GenericDFVisitor(NodeT root) {
        if constexpr (order == DFVOrder::PreOrder) {
            std::deque<NodeT> s{root};
            std::set<NodeT> visited;
            while (!s.empty()) {
                auto curr = s.back();
                s.pop_back();
                visited.insert(curr);

                worklist.push_back(curr);

                const auto &children = ChildrenGetter()(curr);
                for (auto it = children.rbegin(); it != children.rend(); ++it) {
                    if (visited.find(*it) == visited.end())
                        s.push_back(*it);
                }
            }
        } else if constexpr (order == DFVOrder::PostOrder) {
            // Node, processed
            std::deque<std::pair<NodeT, bool>> s{{root, false}};
            std::set<NodeT> visited{root};
            while (!s.empty()) {
                auto [curr, processed] = s.back();
                s.pop_back();

                if (processed)
                    worklist.push_back(curr);
                else {
                    s.emplace_back(curr, true);
                    const auto &children = ChildrenGetter()(curr);
                    //
                    //  a:
                    //    br a c
                    //  b:
                    //    br c
                    //  c:
                    //    ret
                    //
                    //  a ----> c
                    //  |      ^
                    //  v     |
                    //  b ----
                    //
                    //  a
                    //  ├─ b
                    //  │  └─ c
                    //  └─ c
                    //
                    // To get the desired order, (c, b, a)
                    // we DO NOT reverse the order of the children
                    for (const auto &child : children) {
                        if (visited.insert(child).second)
                            s.emplace_back(child, false);
                    }
                }
            }
        } else if constexpr (order == DFVOrder::ReversePreOrder) {
            GenericDFVisitor<NodeT, ChildrenGetter, DFVOrder::PreOrder> dfv{ root };
            worklist.insert(worklist.end(), std::make_move_iterator(dfv.rbegin()),
                            std::make_move_iterator(dfv.rend()));
        } else if constexpr (order == DFVOrder::ReversePostOrder) {
            GenericDFVisitor<NodeT, ChildrenGetter, DFVOrder::PostOrder> dfv{ root };
            worklist.insert(worklist.end(), std::make_move_iterator(dfv.rbegin()),
                            std::make_move_iterator(dfv.rend()));
        }
    }

    const_reference operator[](size_t i) const { return worklist[i]; }
    reference operator[](size_t i) { return worklist[i]; }

    [[nodiscard]] size_t size() const { return worklist.size(); }
    [[nodiscard]] iterator begin() const { return worklist.begin(); }
    [[nodiscard]] iterator end() const { return worklist.end(); }
    [[nodiscard]] const_iterator begin() { return worklist.begin(); }
    [[nodiscard]] const_iterator end() { return worklist.end(); }
    [[nodiscard]] const_iterator cbegin() const { return worklist.cbegin(); }
    [[nodiscard]] const_iterator cend() const { return worklist.cend(); }
    [[nodiscard]] reverse_iterator rbegin() { return worklist.rbegin(); }
    [[nodiscard]] reverse_iterator rend() { return worklist.rend(); }
    [[nodiscard]] const_reverse_iterator rbegin() const { return worklist.rbegin(); }
    [[nodiscard]] const_reverse_iterator rend() const { return worklist.rend(); }
    [[nodiscard]] const_reverse_iterator crbegin() const { return worklist.crbegin(); }
    [[nodiscard]] const_reverse_iterator crend() const { return worklist.crend(); }
};
} // namespace Util
#endif
