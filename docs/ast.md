# 关于 AST 的一些说明

> 命名空间说明：
> 
> - Flex生成的 `lexer.cpp` 为C风格的代码，没有使用命名空间。
>
> - Bison生成的 `parser.cpp`, `parser.hpp` 使用了命名空间 `yy` .
> 
> - `ast.hpp`, `basetype.hpp`, `visitor.hpp`, `printer.cpp` 均使用命名空间 `AST` .

## 文件结构

- `include/parser`

  - `ast.hpp` : `ASTNode` , `ASTVisitor` , `Exp` (继承自 `ASTNode` ) 基类的定义，二元、一元操作符枚举 `BiOp`, `UnOp` 的定义，所有派生AST节点类的定义。（这里把所有函数定义都放hpp里面了，之后可能会迁到ast.cpp里面）

  - `basetype.hpp` : 数据类型 `dtype` 枚举，包括文法定义中的 `Btype`, `FuncType` 共3种；`int32`, `float32`, `string`类型别名；`num`类的定义（实际上，没有直接使用num类，而是套在Exp类里面了）

  - `parser.hpp` : Bison生成的语法分析器头文件，其中包含token定义，生成token的函数等，故也被 `lexer.cpp` 包含。

  - `visitor.hpp` : 目前有派生访问者类 `Printer` 的定义。用于定义各种访问者类。

- `lib/lexer`

  - `lexer.cpp` : Flex生成的词法分析器。(C风格，使用C++风格的生成函数)

  - `lexer.l` : 词法分析规则文件。

- `lib/parser`

  - `parser.cpp` : Bison生成的语法分析器。

  - `parser.hpp` : 由于 `parser.cpp` 默认include “parser.hpp” ，目前还没有查到如何修改默认include路径的接口，故放一个空文件使其转至真实的头文件，后续弃用。

  - `parser.y` : 语法分析规则文件。

  - `printer.cpp` : 访问者Printer的成员函数定义。

## 访问者类

> 依照访问者模式的设计思想，对AST添加新操作时无需改变AST节点的定义，直接新建一个Visitor类即可，故除更改ast的定义外，应当无需更改ast.hpp中的内容。
> 
> 每个AST节点定义中都有基类中纯虚函数 `accept(ASTVisitor& visitor)` 的相同实现
> ```cpp
> void accept(ASTVisitor& visitor) override { visitor.visit(*this); }
> ```
> 访问者访问时通过 `visit` 函数来对节点进行操作。

1. 新建访问者类继承自 `ASTVisitor` ，并实现所有ASTNode节点派生类（Exp抽象类除外）的 `visit` 函数。（所有需实现的函数均声明在ast.hpp中的 `ASTVisitor` 类中）

2. 访问函数定义类似下面，仅有传递的参数类型不同，用以区别操作的节点类型，在visit函数中访问节点类的成员直接 `node.func()` 即可。

  ```cpp
    void Printer::visit(CompUnit& node)
  ```

3. 在visit函数中访问某个节点的子节点，只需使用某种方法获得子节点的指针（例如 `node` ），然后调用其 `accept` 函数即可调用该节点的visit函数。

  ```cpp
    node->accept(*this);
  ```

## AST节点

### 总述

#### 按性质分类

我将AST节点分为三种：

- 编译子单元及其辅助节点：CompUnit, VarDef, DeclStmt, InitVal, ArraySubscript, FuncDef, FuncFParam. 除DeclStmt外均继承自ASTNode. 

- 表达式节点：Exp, DeclRef, ArrayExp, CallExp, FuncRParam, BinaryOp, UnaryOp, ParenExp, IntLiteral, FloatLiteral. 除FuncRParam外均继承自Exp.

- 语句节点: CompStmt, IfStmt, WhileStmt, NullStmt, BreakStmt, ContinueStmt, ReturnStmt. 均继承自Stmt.

> 将这些节点分类的两个重要原因是：一些链式结构的节点，或者说并列关系的节点，它们可能和不同类型的节点并列，例如复合语句（语句块）中包含的WhileStmt和IfStmt，这样在用容器储存时就必须将他们统一；各种表达式节点在语法分析时可以相互归约，例如UnaryExp可以归约为BinaryExp等，也必须使用统一的基类来管理。为了区别方便，就分出了Exp和Stmt这两种。

> Stmt为ASTNode的别名，只是为了便于分别。
> 
> Exp节点原来也是ASTNode的别名，后来考虑到表达式节点和其他节点的不同是其有确定的值，之后可能在使用时需要简化求值一些Exp类的节点，故设计了一个继承自ASTNode的Exp抽象类，添加了_value成员及一些方法。

#### 一些特殊情况

- DeclStmt本质还是Stmt，只是它也属于编译单元的内容（全局变量声明），故在形式上归为第一类。

- FuncRParam也可以归为Exp，但是它本身只是一个Exp的壳子，仅用于辅助生成函数实参列表，故为了简便，让其不继承自Exp。求值时可以访问子节点的value.

> 目前版本的所有节点均不依赖于其继承自Exp基类或Stmt，故以后若弃用Exp基类或者增加Stmt基类，只需定义Exp别名或取消别名即可。

> 节点包含的方法详见ast.hpp及相关注释，根据名字应该都好理解

### 编译子单元及其辅助节点

> 根据语言定义，编译单元CompUnit包含两种子单元：全局变量声明DeclStmt，函数定义FuncDef。其余节点基本都可算为辅助作用。
> 
> 该分类包含CompUnit, VarDef, DeclStmt, InitVal, ArraySubscript, FuncDef, FuncFParam。

节点间关系为：

CompUnit -> vector\<DeclStmt, FuncDef\>

DeclStmt -> vector\<VarDef\>

VarDef -> vector\<InitVal\>, vector\<ArraySubscript\>

InitVal -> Exp or vector\<InitVal\> // 用于嵌套的初始值 {{}, {}}

ArraySubscript -> Exp

FuncDef -> vector\<FuncFParam\> and CompStmt

FuncFParam -> vector\<ArraySubscript\> // 非必需，只针对int a[][2]这种的形参

### 表达式节点

> 具有值的节点：Exp, DeclRef, ArrayExp, CallExp, FuncRParam, BinaryOp, UnaryOp, ParenExp, IntLiteral, FloatLiteral. 除FuncRParam外均继承自Exp.

Exp ：抽象基类，包含num类以储存值

节点间关系为：

DeclRef -> string // 变量名，DeclRef为 引用声明（使用变量，引用数组，函数调用），被数组表达式和函数调用包含。

ArrayExp -> DeclRef, vector\<ArraySubscript\> // 名字+下标列表

CallExp -> DeclRef, vector\<FuncRParam\> // 名字+实参列表

FuncRParam -> Exp

BinaryOp -> BiOp, Exp(lhs), Exp(rhs) // 操作符，左右操作数

UnaryOp -> UnOp, Exp // 操作符，操作数

ParenExp -> Exp // 括号表达式

IntLiteral, FloatLiteral // 无其他成员变量，可以视为Exp按不同类型初始化，包含转发函数getValue

### 语句节点

> CompStmt, IfStmt, WhileStmt, NullStmt, BreakStmt, ContinueStmt, ReturnStmt. 均继承自Stmt(ASTNode).

CompStmt -> vector\<Stmt\>

IfStmt -> Exp, Stmt, Stmt // 条件，语句(块)，else块

WhileStmt -> Exp, Stmt // 条件，语句(块)

ReturnStmt -> Exp // 返回值

### 其他的归类方式

#### 按作用分

一些节点类型是必须需要的，例如DeclStmt等等编译单元或者语句块的组成部分等。

有些是在语法定义文件parser.y中辅助生成AST的中间节点，这些类的父节点可能只有一种，比如InitVal或者上述的FuncRParam实参：它与Exp相比就是多了一个next指针用于生成链表结构，父节点只有CallExp一种。这些中间节点的子节点可以直接包含在父节点中，但为了简单化，就保留了中间节点方便parser构建。

#### 按构建方式分

只针对子节点是链式（并列）结构的，例如DeclStmt的可能有多个VarDef、CompStmt(Block)也有多个BlockItems等，大部分这种关系都使用vector维护，这些并列关系节点的生成分为两种办法。

1. 使用next指针先把各个子节点串起来，构建父节点时（即在parser中归约至父节点时）将其转换为vector，为此，定义了一个模板函数 `addNodesToVector` 。**这种生成方式适用于在parser.y中以右递归方式处理子节点的情况**，例如VarDef, ConstDef等。

2. 直接生成包含vector的节点，添加并列单元时使用push_back方法添加，**这种生成方式适用于在parser.y中以左递归方式处理子节点的情况**，例如Block中的BlockItems等。

> 实际上，两种方法的使用方式可能只在于parser.y中如何处理子节点，为了节省工作量，我就没有将各种处理方式统一。
