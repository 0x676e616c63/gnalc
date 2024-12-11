# 1 跳转优化
## 优化情景:
### 跳转涉及4个basicblock: %head %true %false %tail
### %head底部存在一个br的IR指令, 视情况跳转到 %true 或者 %false
### 当%true或者%false结束时, 控制流合并到 %tail
## 优化方法:
### 朴素的做法会产生2个分支各两次跳转
```
%head:
    cmp ...
    b<cond> %true
    b %false
%true:
    ...
    b %tail
%false:
    ...
    b %tail
%tail:
    ...
```
### 利用汇编指令的顺序执行, 可以节省跳转指令的执行时间, 同时提高cache命中率
### 方法是, 将%false和%true位置调换, 以节省 ```b %false```, 同时删除%tail上一个块结尾的```b %tail```
```
%head:
    cmp ...
    b<cond> %true
%false:
    ...
    b %tail
%true:
    ...
%tail:
    ...
```