/**
 * @attention update: 使用 `Use` 类来管理操作数
 */

#include "../../include/ir/base.h"


namespace BaseIR {
/**
 * @todo complete removeuse func
 */
class Value {
protected:
    Type type;
    std::string name;
    std::vector<Use*> use_list;

public:
    Value(Type type, const std::string &name = "") : type(type), name(name) {}

    void setName(const std::string &name) {
        this->name = name;
    }

    void setType(Type type) {
        this->type = type;
    }

    std::string getName() {
        return name;
    }

    Type getType() {
        return type;
    }

    const std::vector<Use*>& getUseList() const {
        return use_list;
    }

    void addUse(Use* use) {
        use_list.push_back(use);
    }

    void removeUse(Use* use) {
        if (use == nullptr) {
            return;
        }
        // TODO
    }

    virtual ~Value() {}
};

class User : public Value {
protected:
    std::vector<Use> operands; // 操作数

public:
    User(Type type, const std::string &name = "") : Value(type, name) {}

    void addOperand(Value *v) {
        operands.emplace_back(v, this);
    }

    Value* getOperand(unsigned i) const {
        return operands[i].getValue();
    }

    void setOperand(unsigned i, Value *v) {
        operands[i].setValue(v);
    }

    unsigned getNumOperands() const {
        return operands.size();
    }

    virtual ~User() {}
};


/**
 * @todo no empty warning
 */
class Use {
private:
    Value *val;   // 指向被使用的 Value
    User *user;   // 指向所属的 User

public:
    Use(Value *v, User *u) : val(v), user(u) {
        val->addUse(this);
    }

    void setValue(Value *v) {
        val->removeUse(this);
        val = v;
        val->addUse(this);
    }

    void setUser(User *u) {
        user = u;
    }

    Value* getValue() const {
        return val;
    }

    User* getUser() const {
        return user;
    }

    ~Use() {
        val->removeUse(this);
    }
};
}