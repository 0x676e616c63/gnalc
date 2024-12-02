/**
 * @brief 包含通用的Type, Name类
 * @todo 这部分后续可能会简化合并
 */

#pragma once
#include <string>

namespace IR {
enum _type { INT, FLOAT, VOID, UNDEFINED };
typedef const std::string& NameParam;

using i32 = int32_t;

/**
 * @todo 使用模板？
 */
class Type {
private:
    _type tp;
public:
    Type(_type t) : tp(t) {}

    void setType(_type t) { tp = t; }
    bool isVoid() { return tp==VOID; }
    bool isFloat() { return tp==FLOAT; }
    bool isInt() { return tp==INT; }
    _type getType() { return tp; }
};

class Name {
private:
    std::string _name;
public:
    Name() : _name("") {}
    Name(NameParam name) : _name(name) {}

    void setName(NameParam name) { _name = name; }
    bool isName(NameParam name) { return _name==name; }
    std::string getName() { return _name; }
};
}