# backend mir: 后端isel之后的产物
# 在godbolt.org上，传入LLVM IR，然后使用 ```llc -stop-before=machine-scheduler -march=arm```生成
# mir中没有phi，也就是不是ssa
# mir中存在寄存器保护指令
# 消除phi有两种思路, 暂时不知道哪一个效果更好, 实现应该都不算是太难：
## 第一种是拓扑排序, 然后调用中端BCE优化来消除多余的COPY指令(上一届方案)
## 第二种是参照论文, ```Translating Out of Static Single Assignment Form```以及后面的伪代码
# 虽然没有开始做isel, 但是应该是一个宏展开的方式, 主要是为了简单, 并且phi消除需要在instruction粒度上实现
# 理论上可以做成llvm mir的标准样式, 然后用llc验证正确性, 但是llvm mir的格式比llvm ir复杂许多

# mir_function
1. mir_info, 一个function对应一个info, 大部分没什么用, 主要是liveins(显式传参), stack, tracksDebugUserValues, debugValueSubstitutions, body(mir代码), 其他的其实不是特别重要
2. stack,
3. debugValueSubstitutions常量池
4. body, 基本块的list, 在entry块需要打印liveins
