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
#include <list>
#include <unordered_set>
#include <vector>

namespace Util {
template <typename NodeT, typename ChildrenGetter> class GenericBFVisitor {
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
        std::unordered_set<NodeT> visited;
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
    [[nodiscard]] iterator begin() { return worklist.begin(); }
    [[nodiscard]] iterator end() { return worklist.end(); }
    [[nodiscard]] const_iterator begin() const { return worklist.begin(); }
    [[nodiscard]] const_iterator end() const { return worklist.end(); }
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

template <typename NodeT, typename ChildrenGetter, DFVOrder order = DFVOrder::PreOrder> class GenericDFVisitor {
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
            std::unordered_set<NodeT> visited;
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
            using ChildContainer = decltype(ChildrenGetter()(root));
            using ChildIt = typename ChildContainer::const_iterator;
            struct POCtx {
                NodeT node;
                ChildIt it;
                ChildIt end;

                POCtx(NodeT node_, const ChildContainer &children_)
                    : node{node_}, it{children_.begin()}, end{children_.end()} {}
            };
            std::vector<POCtx> stack;
            std::unordered_set<NodeT> visited;

            // explicitly hold a child container to keep the iterator valid
            std::list<ChildContainer> child_containers;

            visited.insert(root);
            child_containers.emplace_back(ChildrenGetter()(root));
            stack.emplace_back(root, child_containers.back());

            while (!stack.empty()) {
                auto &ctx_node = stack.back();
                if (ctx_node.it != ctx_node.end) {
                    auto child = *ctx_node.it++;
                    if (visited.insert(child).second) {
                        child_containers.emplace_back(ChildrenGetter()(child));
                        stack.emplace_back(child, child_containers.back());
                    }
                } else {
                    // All children processed
                    worklist.emplace_back(ctx_node.node);
                    stack.pop_back();
                }
            }
        } else if constexpr (order == DFVOrder::ReversePreOrder) {
            GenericDFVisitor<NodeT, ChildrenGetter, DFVOrder::PreOrder> dfv{root};
            worklist.insert(worklist.end(), std::make_move_iterator(dfv.rbegin()), std::make_move_iterator(dfv.rend()));
        } else if constexpr (order == DFVOrder::ReversePostOrder) {
            GenericDFVisitor<NodeT, ChildrenGetter, DFVOrder::PostOrder> dfv{root};
            worklist.insert(worklist.end(), std::make_move_iterator(dfv.rbegin()), std::make_move_iterator(dfv.rend()));
        }
    }

    const_reference operator[](size_t i) const { return worklist[i]; }
    reference operator[](size_t i) { return worklist[i]; }

    [[nodiscard]] size_t size() const { return worklist.size(); }
    [[nodiscard]] iterator begin() { return worklist.begin(); }
    [[nodiscard]] iterator end() { return worklist.end(); }
    [[nodiscard]] const_iterator begin() const { return worklist.begin(); }
    [[nodiscard]] const_iterator end() const { return worklist.end(); }
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
