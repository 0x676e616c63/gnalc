// Generic Breadth-First/Depth-First Visitor,
// providing an interface for easy traversal of CFGs and DomTrees
#pragma once
#ifndef GNALC_UTILS_GENERIC_VISITOR_HPP
#define GNALC_UTILS_GENERIC_VISITOR_HPP

#include <deque>
#include <set>

namespace Util {
template <typename NodeT, typename ChildrenGetter>
class GenericBFVisitor {
    std::vector<NodeT> worklist{};

public:
    using iterator = typename decltype(worklist)::iterator;

    explicit GenericBFVisitor(NodeT root) {
        std::deque<NodeT> q{ root };
        std::set<NodeT> visited;
        while (!q.empty()) {
            auto curr = q.front();
            q.pop_front();
            visited.insert(curr);

            worklist.push_back(curr);

            const auto& children = ChildrenGetter()(curr);
            for (const auto& child : children) {
                if (visited.find(child) == visited.end())
                    q.push_back(child);
            }
        }
    }

    [[nodiscard]] size_t size() const { return worklist.size(); }
    [[nodiscard]] iterator begin() { return worklist.begin(); }
    [[nodiscard]] iterator end() { return worklist.end(); }
    [[nodiscard]] iterator begin() const { return worklist.begin(); }
    [[nodiscard]] iterator end() const { return worklist.end(); }
    [[nodiscard]] iterator cbegin() const { return worklist.cbegin(); }
    [[nodiscard]] iterator cend() const { return worklist.cend(); }
};

enum class DFVOrder {
    PreOrder,
    PostOrder,
    ReversePreOrder,
    ReversePostOrder
};

template <typename NodeT, typename ChildrenGetter>
class GenericDFVisitor {
    std::vector<NodeT> worklist{};
public:
    using iterator = typename decltype(worklist)::iterator;

    explicit GenericDFVisitor(NodeT root, DFVOrder order) {
        switch (order) {
            case DFVOrder::PreOrder: {
                std::deque<NodeT> s{ root };
                std::set<NodeT> visited;
                while (!s.empty()) {
                    auto curr = s.top();
                    s.pop();
                    visited.insert(curr);

                    worklist.push_back(curr);

                    const auto& children = ChildrenGetter()(curr);
                    for (auto it = children.rbegin(); it != children.rend(); ++it) {
                        if (visited.find(*it) == visited.end())
                            s.push(*it);
                    }
                }
            }
                break;
            case DFVOrder::PostOrder: {
                std::deque<NodeT> s{ root };
                std::set<NodeT> visited;
                while (!s.empty()) {
                    auto curr = s.back();
                    s.pop_back();

                    if (visited.find(curr) != visited.end())
                        worklist.push_back(curr);
                    else {
                        visited.insert(curr);
                        s.push_back(curr);
                        const auto& children = ChildrenGetter()(curr);
                        for (auto it = children.rbegin(); it != children.rend(); ++it) {
                            if (visited.find(*it) == visited.end())
                                s.push_back(*it);
                        }
                    }
                }
            }
                break;
            case DFVOrder::ReversePreOrder: {
                GenericDFVisitor dfv{ root, DFVOrder::PreOrder };
                worklist.insert(worklist.end(),
                    std::make_move_iterator(dfv.worklist.rbegin()),
                    std::make_move_iterator(dfv.worklist.rend()));
            }
                break;
            case DFVOrder::ReversePostOrder: {
                GenericDFVisitor dfv{ root, DFVOrder::PostOrder };
                worklist.insert(worklist.end(),
                    std::make_move_iterator(dfv.worklist.rbegin()),
                    std::make_move_iterator(dfv.worklist.rend()));
            }
                break;
        }
    }

    [[nodiscard]] size_t size() const { return worklist.size(); }
    [[nodiscard]] iterator begin() { return worklist.begin(); }
    [[nodiscard]] iterator end() { return worklist.end(); }
    [[nodiscard]] iterator begin() const { return worklist.begin(); }
    [[nodiscard]] iterator end() const { return worklist.end(); }
    [[nodiscard]] iterator cbegin() const { return worklist.cbegin(); }
    [[nodiscard]] iterator cend() const { return worklist.cend(); }
};
} // namespace Util
#endif
