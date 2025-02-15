// Generic Breadth-First/Depth-First Visitor,
// providing an interface for easy traversal of CFGs and DomTrees
#pragma once
#ifndef GNALC_UTILS_GENERIC_VISITOR_HPP
#define GNALC_UTILS_GENERIC_VISITOR_HPP

#include <deque>
#include <stack>
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
};

template <typename NodeT, typename ChildrenGetter>
class GenericDFVisitor {
    std::vector<NodeT> worklist{};
public:
    using iterator = typename decltype(worklist)::iterator;

    explicit GenericDFVisitor(NodeT root) {
        std::stack<NodeT> s;
        s.push(root);
        std::set<NodeT> visited;
        while (!s.empty()) {
            auto curr = s.top();
            s.pop();
            visited.insert(curr);

            worklist.push_back(curr);

            const auto& children = ChildrenGetter()(curr);
            for (const auto& child : children) {
                if (visited.find(child) == visited.end())
                    s.push(child);
            }
        }
    }

    [[nodiscard]] size_t size() const { return worklist.size(); }
    [[nodiscard]] iterator begin() { return worklist.begin(); }
    [[nodiscard]] iterator end() { return worklist.end(); }
    [[nodiscard]] iterator begin() const { return worklist.begin(); }
    [[nodiscard]] iterator end() const { return worklist.end(); }
};
} // namespace Util
#endif
