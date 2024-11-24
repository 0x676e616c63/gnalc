/**
 * @brief 使用访问者模式重构的代码，将AST结构和操作解耦
 * @attention AST在构造后应该是不会被修改的
 * @todo 考虑将一部分inline函数迁到ast.cpp中
 * @todo 添加反向指针？
 * 
 * @bug 最初设计时考虑到AST不会被修改，所以全部使用const，但是现在设计的Exp类是可能被修改的，不知道会不会引发问题
 */

#pragma once
#ifndef PARSER_AST_H
#define PARSER_AST_H

#include <vector>
#include <memory>
#include "basetype.hpp"
// #include <variant>

namespace AST {

class ASTNode;
class ASTVisitor;

// 编译单元
class CompUnit; // 包含 Decl, FuncDef
class VarDef; // int a; 中的 a
class DeclStmt; // int a; 整个语句
class InitVal; // 初始化列表，单个的
class ArraySubscript; // int a[2]; void f(int a[]); a[2];等 单个的下标
class FuncDef;
class FuncFParam; // 形参

// 下列为具有值的Expression，相互引用时，统一用Exp（若满足不了需求再改为varient）
class Exp; // 以下具有值的节点的基类，继承自ASTNode
class DeclRef; //变量声明引用：VarRef, FuncRef(callexp), array;
class ArrayExp;
class CallExp;
class FuncRParam; // 仅应用于CallExp, 具有链式结构，不太好抽象成Exp
class BinaryOp; // 包含 ExpOp, CondOp
class UnaryOp;
class ParenExp;
class IntLiteral; // 数值字面量，num包装了一下。之后可能直接替代num
class FloatLiteral;

// 语句，包括 Exp;
using Stmt = ASTNode;
class CompStmt; // 复合语句，即block
class IfStmt;
class WhileStmt;
class NullStmt;
class BreakStmt;
class ContinueStmt;
class ReturnStmt;


class ASTNode {
public:
    virtual void accept(class ASTVisitor& visitor) = 0; // 支持访问者模式
    virtual ~ASTNode() = default;
};

class ASTVisitor {
public:
    // 针对所有节点类型添加：
    // virtual void visit(example& node) = 0;
    virtual void visit(CompUnit& node) = 0;
    virtual void visit(VarDef& node) = 0;
    virtual void visit(DeclStmt& node) = 0;
    virtual void visit(InitVal& node) = 0;
    virtual void visit(ArraySubscript& node) = 0;
    virtual void visit(FuncDef& node) = 0;
    virtual void visit(FuncFParam& node) = 0;
    virtual void visit(DeclRef& node) = 0;
    virtual void visit(ArrayExp& node) = 0;
    virtual void visit(CallExp& node) = 0;
    virtual void visit(FuncRParam& node) = 0;
    virtual void visit(BinaryOp& node) = 0;
    virtual void visit(UnaryOp& node) = 0;
    virtual void visit(ParenExp& node) = 0;
    virtual void visit(IntLiteral& node) = 0;
    virtual void visit(FloatLiteral& node) = 0;
    virtual void visit(CompStmt& node) = 0;
    virtual void visit(IfStmt& node) = 0;
    virtual void visit(WhileStmt& node) = 0;
    virtual void visit(NullStmt& node) = 0;
    virtual void visit(BreakStmt& node) = 0;
    virtual void visit(ContinueStmt& node) = 0;
    virtual void visit(ReturnStmt& node) = 0;
};

// 在parser.y中改为左递归构建
class CompUnit : public ASTNode {
private:
    std::vector<std::shared_ptr<ASTNode>> nodes;

public:
    CompUnit(const std::shared_ptr<ASTNode>& node) { nodes.push_back(node); }

    void addNode(const std::shared_ptr<ASTNode>& node) { nodes.push_back(node); }
    auto& getNodes() const { return nodes; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
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

class DeclStmt : public Stmt {
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
    std::shared_ptr<Exp> exp = nullptr;
    std::vector<std::shared_ptr<InitVal>> inner;

public:
    std::shared_ptr<InitVal> next = nullptr; // 它的上级节点为VarDef，或者InitVal

    InitVal(const std::shared_ptr<Exp>& exp) : exp(exp) {}
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
    std::shared_ptr<Exp> exp = nullptr;

public:
    std::shared_ptr<ArraySubscript> next = nullptr;

    ArraySubscript(const std::shared_ptr<Exp>& exp) : exp(exp) {}

    // // 添加至ArraySubscripts链
    // std::shared_ptr<ArraySubscript> link(const std::shared_ptr<ArraySubscript>& next) {
    //     this->next = next;
    //     return std::shared_ptr<ArraySubscript>(this);
    // }

    auto& getExp() const { return exp; }
    
    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class FuncDef : public ASTNode {
private:
    dtype type = dtype::UNDEFINED; // 包含int float void
    string id;
    bool _empty_param = false;
    std::vector<std::shared_ptr<FuncFParam>> params;
    std::shared_ptr<CompStmt> body = nullptr;

public:
    FuncDef(dtype t, string id, const std::shared_ptr<CompStmt>& body)
        : type(t), id(id), body(body), _empty_param(true) {}
    FuncDef(dtype t, string id, const std::shared_ptr<FuncFParam>& param, const std::shared_ptr<CompStmt>& body)
        : type(t), id(id), body(body) { addNodesToVector(param, params); }

    dtype getType() const { return type; }
    string getId() const { return id; }
    bool isEmptyParam() const { return _empty_param; }
    auto& getParams() const { return params; }
    auto& getBody() const { return body; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

/**
 * FuncFParam: int a, int b[], int c[][2]（根据语言定义，第一维一定为空）
 * int a: _array=f
 * int b[]: _array=t, _one_dim=t, subcripts.size()=0
 * int c[][2]: _array=t, _one_dim=f, subcripts.size()=1
 * 
 * 处理时需注意第一维的问题!!!
 */
class FuncFParam : public ASTNode {
private:
    dtype type = dtype::UNDEFINED;
    string id;
    bool _array = false;
    bool _one_dim = false;
    std::vector<std::shared_ptr<ArraySubscript>> subscripts; // 为了简便，从有实际值的第二维算起

public:
    std::shared_ptr<FuncFParam> next = nullptr;

    FuncFParam(dtype t, string id) : type(t), id(id) {}
    FuncFParam(dtype t, string id, bool one_dim) // 必须为true
        : type(t), id(id), _array(true), _one_dim(true) {}
    FuncFParam(dtype t, string id, const std::shared_ptr<ArraySubscript>& subscript)
        : type(t), id(id), _array(true) { addNodesToVector(subscript, subscripts); }

    dtype getType() const { return type; }
    string getId() const { return id; }
    bool isArray() const { return _array; }
    bool isOneDim() const { return _one_dim; }
    auto& getSubscripts() const { return subscripts; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

// num 是供后续求值使用，生成AST时没有赋值，除了数值字面量
class Exp : public ASTNode {
protected:
    num _value;
public:
    Exp() : _value(0) {};
    Exp(int32 i) : _value(i) {} // 仅用于int字面量
    Exp(float32 f) : _value(f) {} // 仅用于float字面量


    void setValue(num& n) { _value = n; }
    const num& getValue() const { return _value; }
    virtual void accept(ASTVisitor& visitor) = 0;
    virtual ~Exp() = default;
};

/**
 * 变量名的引用
 */
class DeclRef : public Exp {
private:
    string id;

public:
    // 参考LVal
    DeclRef(string id) : id(id) {}

    string getId() const { return id; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

// a[2]
class ArrayExp : public Exp {
private:
    std::shared_ptr<DeclRef> ref = nullptr;
    std::vector<std::shared_ptr<ArraySubscript>> indices;

public:
    ArrayExp(const std::shared_ptr<DeclRef>& ref, const std::shared_ptr<ArraySubscript>& index)
        : ref(ref) { addNodesToVector(index, indices); }

    string getId() const { return ref->getId(); }
    auto& getRef() const { return ref; }
    auto& getIndices() const { return indices; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

// a(1,2,3)
class CallExp : public Exp {
private:
    std::shared_ptr<DeclRef> ref = nullptr;
    bool _empty_para = false;
    std::vector<std::shared_ptr<FuncRParam>> paras;

public:
    CallExp(const std::shared_ptr<DeclRef>& ref) : ref(ref), _empty_para(true) {}
    CallExp(const std::shared_ptr<DeclRef>& ref, const std::shared_ptr<FuncRParam>& para)
        : ref(ref) { addNodesToVector(para, paras); }

    string getId() const { return ref->getId(); }
    auto& getRef() const { return ref; }
    auto& getParas() const { return paras; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

// 采用右递归的方式构建
class FuncRParam : public ASTNode {
private:
    std::shared_ptr<Exp> exp = nullptr;

public:
    std::shared_ptr<FuncRParam> next = nullptr;

    FuncRParam(const std::shared_ptr<Exp>& exp) : exp(exp) {}

    auto& getExp() const { return exp; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }

};

// 二元运算符
enum class BiOp {
    ASSIGN,
    ADD,
    SUB,
    MUL,
    DIV,
    MOD,
    LESSEQ,
    LESS,
    GREATEQ,
    GREAT,
    NOTEQ,
    EQ,
    AND, // Cond
    OR // Cond
};

enum class UnOp {
    NOT, // Cond
    ADD, // positive
    SUB // negative
};

class BinaryOp : public Exp {
private:
    BiOp op;
    std::shared_ptr<Exp> lhs = nullptr;
    std::shared_ptr<Exp> rhs = nullptr;

public:
    BinaryOp(BiOp op, const std::shared_ptr<Exp>& lhs, const std::shared_ptr<Exp>& rhs)
        : op(op), lhs(lhs), rhs(rhs) {}

    BiOp getOp() const { return op; }
    auto& getLHS() const { return lhs; }
    auto& getRHS() const { return rhs; }

    void accept(ASTVisitor& visitor) override{ visitor.visit(*this); }
};

class UnaryOp : public Exp {
private:
    UnOp op;
    std::shared_ptr<Exp> exp = nullptr;

public:
    UnaryOp(UnOp op, const std::shared_ptr<Exp>& exp) : op(op), exp(exp) {}

    UnOp getOp() const { return op; }
    auto& getExp() const { return exp; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class ParenExp : public Exp {
private:
    std::shared_ptr<Exp> exp = nullptr;

public:
    ParenExp(const std::shared_ptr<Exp>& exp) : exp(exp) {}

    auto& getExp() const { return exp; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class IntLiteral : public Exp {
public:
    IntLiteral(int32 n) : Exp(n) {}

    int32 getValue() const { return _value.getInt(); }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class FloatLiteral : public Exp {
public:
    FloatLiteral(float32 f) : Exp(f) {}

    float32 getValue() const { return _value.getInt(); }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

/**
 * Block: [Decl, Stmt]+
 * items 最初我考虑了两种实现：1是使用variant容器，2是使用基类容器+dynamic_cast<>动态转换
 * 但之后想到，似乎使用多态的访问者函数已经足够，故此处直接使用基类容器
 * 后续如果有在ASTVisitor::visit之外访问成员函数的需求再考虑使用其他实现
 * 其他需要使用混合类型的容器也同上述
 * 
 * 使用左递归的构造方式就不用使用next指针了...直接pushback就行，这样也可以避免定义一个stmt子类的需求
 * （待检验的方法）
 * 以下和上面的一些链式结构的构造方式不同，见parser.y:BlockItems.
 */
class CompStmt : public Stmt {
private:
    bool _empty = false;
    std::vector<std::shared_ptr<Stmt>> items; // Decl, Stmt

public:
    CompStmt() : _empty(true) {}
    CompStmt(const std::shared_ptr<Stmt>& item) { items.push_back(item); }

    void addItem(const std::shared_ptr<Stmt>& item) { items.push_back(item); }

    bool isEmpty() const { return _empty; }
    auto& getItems() const { return items; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class IfStmt : public Stmt {
private:
    std::shared_ptr<Exp> cond = nullptr;
    std::shared_ptr<Stmt> body = nullptr;
    bool _else = false;
    std::shared_ptr<Stmt> else_body = nullptr;

public:
    IfStmt(const std::shared_ptr<Exp>& cond, const std::shared_ptr<Stmt>& body)
        : cond(cond), body(body) {}
    IfStmt(const std::shared_ptr<Exp>& cond, const std::shared_ptr<Stmt>& body, const std::shared_ptr<Stmt>& else_body)
        : cond(cond), body(body), else_body(else_body), _else(true) {}

    bool hasElse() const { return _else; }
    auto& getCond() const { return cond; }
    auto& getBody() const { return body; }
    auto& getElseBody() const { return else_body; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class WhileStmt : public Stmt {
private:
    std::shared_ptr<Exp> cond = nullptr;
    std::shared_ptr<Stmt> body = nullptr;

public:
    WhileStmt(const std::shared_ptr<Exp>& cond, const std::shared_ptr<Stmt>& body)
        : cond(cond), body(body) {}

    auto& getCond() const { return cond; }
    auto& getBody() const { return body; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class NullStmt : public Stmt {
public:
    NullStmt() {}

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class BreakStmt : public Stmt {
public:
    BreakStmt() {}

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class ContinueStmt : public Stmt {
public:
    ContinueStmt() {}

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

class ReturnStmt : public Stmt {
private:
    bool _void = false;
    std::shared_ptr<Exp> return_val = nullptr;

public:
    ReturnStmt() : _void(true) {}
    ReturnStmt(const std::shared_ptr<Exp>& return_val) : return_val(return_val) {}

    bool isVoid() const { return _void; }
    auto& getReturnVal() const { return return_val; }

    void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
};

}

#endif