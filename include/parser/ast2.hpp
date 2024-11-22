/**
 * @brief 使用访问者模式重构的代码，将AST结构和操作解耦
 * @attention AST在构造后应该是不会被修改的
 */

#pragma once
#ifndef PARSER_AST_H
#define PARSER_AST_H

#include <cstdio>
#include <cstdlib>
#include <vector>
#include <memory>
#include "basetype.hpp"

namespace AST {

class ASTNode;
class ASTVisitor;

class PrintVisitor;

class VarDef; // int a; 中的 a
class DeclStmt; // int a; 整个语句
class ArraySubscript; // int a[2]; void f(int a[]); a[2];等 单个的下标
class InitVal; // 初始化列表，单个的
class FuncDef;
class FuncFParam; // 形参


class ASTNode {
public:
    virtual void accept(class ASTVisitor& visitor) = 0; // 支持访问者模式
    virtual ~ASTNode() = default;
};

class ASTVisitor {
public:
    // 针对所有节点类型添加：
    // virtual void visit(example& node) = 0;
    virtual void visit(VarDef& node) = 0;
};


// 此模板将 用next维护的节点链表 转化为 vector，例如：DeclStmt中的VarDef。因此，这种链表关系被两个对象维护：上一个节点和上级节点。
template <typename T>
void addNodesToVector(const std::shared_ptr<T>& head, std::vector<std::shared_ptr<T>>& outVector) {
    std::shared_ptr<T> current = head;
    while (current != nullptr) {
        outVector.push_back(current);
        current = current->next;
    }
}


class VarDef : public ASTNode {
private:
    bool _const = false; // 在上级declstmt中赋
    dtype type = dtype::UNDEFINED; // 在上级declstmt中赋，仅包含int or float
    bool _array = false;
    bool _inited = false; // 是否被初始化，即 initvals 是否为空
    string id;
    std::vector<std::shared_ptr<ArraySubscript>> subscripts;
    std::vector<std::shared_ptr<InitVal>> initvals;
    std::shared_ptr<VarDef> next; // in parser.y:91:VarDefs: 由于自下而上的语法分析，先构建VarDef，再构建DeclStmt，故先使用next存储;
    
public:
    // 构建函数参考：parser.y:95:VarDef
    VarDef(string id) : id(id) {}
    VarDef(string id, const std::shared_ptr<ArraySubscript>& ss)
        : id(id), _array(true) { addNodesToVector(ss, subscripts); }
    VarDef(string id, const std::shared_ptr<InitVal>& initval)
        : id(id), _inited(true) { addNodesToVector(initval, initvals); }
    VarDef(string id, const std::shared_ptr<ArraySubscript>& ss, const std::shared_ptr<InitVal>& initval)
        : id(id), _array(true), _inited(true) { addNodesToVector(ss, subscripts); addNodesToVector(initval, initvals); }

    void setType(dtype t) { type = t; } // 仅对此vardef赋类型，整个链的在上级declstmt中赋
    void setConst() { _const = true; } // 和上面相同

    // 构建vardefs链
    std::shared_ptr<VarDef> link(const std::shared_ptr<VarDef>& next) {
        this->next = next;
        return std::shared_ptr<VarDef>(this);
    }

    // 按理说，所有操作都在visitor中完成了，这些操作函数似乎没有必要...后续有需要再添加
    string getId() const { return id; }
    dtype getType() const { return type; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class DeclStmt : public ASTNode {
    
};

}
#endif