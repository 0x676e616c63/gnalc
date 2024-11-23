/**
 * @brief 使用访问者模式重构的代码，将AST结构和操作解耦
 * @attention AST在构造后应该是不会被修改的
 */

#pragma once
#ifndef PARSER_AST_H
#define PARSER_AST_H

#include <vector>
#include <memory>
#include "basetype.hpp"

namespace AST {

class ASTNode;
class ASTVisitor;

class VarDef; // int a; 中的 a
class DeclStmt; // int a; 整个语句
class InitVal; // 初始化列表，单个的
class ArraySubscript; // int a[2]; void f(int a[]); a[2];等 单个的下标


class AddExp;


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
    virtual void visit(DeclStmt& node) = 0;
    virtual void visit(InitVal& node) = 0;
    virtual void visit(ArraySubscript& node) = 0;
    virtual void visit(AddExp& node) = 0;
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

public:
    std::shared_ptr<VarDef> next = nullptr; // in parser.y:91:VarDefs: 由于自下而上的语法分析，先构建VarDef，再构建DeclStmt，故先使用next存储;

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

    // // 添加至vardefs链
    // std::shared_ptr<VarDef> link(const std::shared_ptr<VarDef>& next) {
    //     this->next = next;
    //     return std::shared_ptr<VarDef>(this);
    // }

    bool isConst() const { return _const; }
    bool isArray() const { return _array; }
    bool isInited() const { return _inited; }
    dtype getType() const { return type; }
    string getId() const { return id; }
    auto& getSubscripts() const { return subscripts; }
    auto& getInitVals() const { return initvals; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class DeclStmt : public ASTNode {
private:
    bool _const = false;
    dtype type = dtype::UNDEFINED;
    std::vector<std::shared_ptr<VarDef>> vardefs;
    
public:
    // 参考：ConstDecl, VarDecl
    DeclStmt(bool const_, dtype t, const std::shared_ptr<VarDef>& vardef)
        : _const(const_), type(t) { addNodesToVector(vardef, vardefs); setAllType(t); if (const_) setAllConst(); }

    void setAllType(dtype _t) { for (auto& v : vardefs) v->setType(_t); }
    void setAllConst() { for (auto& v : vardefs) v->setConst(); } // 设为true

    bool isConst() const { return _const; }
    dtype getType() const { return type; }
    auto& getVardefs() const { return vardefs; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

/**
 * parser.y: ConstInitVal, InitVal
 * 变量初值：int a = 1+1; int b[2] = {1,2}; int c[2][2] = {{1,2},{3,4}};
 * 若为单个值：(InitVal: Exp)，则_list, _empty为false
 * 若为空列表：(InitVal: {})，则_list, _empty为true
 * 若为列表：(InitVal: {InitVals})，则_list为true, _empty为false
 * 
 * {{1,2},{3,4}}:
 * InitVal0(l=t, e=f, exp=null, inner=i1, i2)
 * |-InitVal1(l=t, e=f, exp=null, inner=i3, i4)
 * | |-IntiVal3(l=f, e=f, exp=xxx, inner=empty)-Exp-1
 * | |-IntiVal4-Exp-2
 * |-InitVal2
 * | |-IntiVal5-Exp-3
 * | |-IntiVal6-Exp-4
 */
class InitVal : public ASTNode {
private:
    bool _list = false;
    bool _empty_list = false; // 为了简化，该项仅在_list启用时有效，即单exp时也为false
    std::shared_ptr<AddExp> exp = nullptr;
    std::vector<std::shared_ptr<InitVal>> inner;

public:
    std::shared_ptr<InitVal> next = nullptr; // 它的上级节点为VarDef，或者InitVal

    InitVal(const std::shared_ptr<AddExp>& exp) : exp(exp) {}
    InitVal() : _list(true), _empty_list(true) {}
    InitVal(const std::shared_ptr<InitVal>& iv) : _list(true) { addNodesToVector(iv, inner); }

    /**
     * @brief 添加至InitVals链
     * @bug 返回std::shared_ptr<InitVal>(this)将创建一个新的shared_ptr，导致管理混乱。
     * @brief 现在直接在parser.y中实现
     */
    // void link(const std::shared_ptr<InitVal>& next) {
    //     this->next = next;
    // }

    bool isList() const { return _list; }
    bool isEmpty() const { return _empty_list; }
    auto& getExp() const { return exp; }
    auto& getInner() const { return inner; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

/**
 * parser.y: ConstAS for (Const) VarDef, ArraySubscript for FunctionFParam, LVal
 */
class ArraySubscript : public ASTNode {
private:
    std::shared_ptr<AddExp> exp = nullptr;

public:
    std::shared_ptr<ArraySubscript> next = nullptr;

    ArraySubscript(const std::shared_ptr<AddExp>& exp) : exp(exp) {}

    // // 添加至ArraySubscripts链
    // std::shared_ptr<ArraySubscript> link(const std::shared_ptr<ArraySubscript>& next) {
    //     this->next = next;
    //     return std::shared_ptr<ArraySubscript>(this);
    // }

    auto& getExp() const { return exp; }
    
    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class AddExp : public ASTNode {
private:
    std::shared_ptr<num> n = nullptr;

public:
    AddExp(const std::shared_ptr<num>& n) : n(n) {}

    auto& getNum() const { return n; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

}
#endif