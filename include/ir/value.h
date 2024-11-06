#pragma once
#include <vector>
#include <string>


enum Type
{
    INT, FLOAT, VOID
};

class Value {
public:
    Type *type;
    std::string name;
    std::vector<User*> users;   // 反向指针，指向所有使用此 Value 的用户

    Value(Type *type, const std::string &name = "") : type(type), name(name) {}
    virtual ~Value() {}
};

class Use {
public:
    Value *val;   // 指向被使用的 Value
    User *user;   // 指向所属的 User

    Use(Value *v, User *u) : val(v), user(u) {}

    void set(Value *v) {
        val = v;
    }
};

class User : public Value {
public:
    std::vector<Use> operands;   // 记录此 User 的所有操作数（即使用的 Value）

    User(Type *type, const std::string &name = "") : Value(type, name) {}

    void addOperand(Value *v) {
        operands.emplace_back(v, this);
        v->users.push_back(this); // 记录该 Value 被当前 User 使用
    }

    Use& getOperand(unsigned idx) {
        return operands[idx];
    }

    void setOperand(unsigned idx, Value *v) {
        operands[idx].set(v);
    }
};
