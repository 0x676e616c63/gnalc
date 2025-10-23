## Brainfuck

在这个编译器的开发初期，我们尝试将 Gnalc IR 翻译为 Brainfuck，并实现了部分功能。 编译时带上 `GNALC_EXTENSION_BRAINFK`
即可启用，命令行参数为 `-march=brainfk` 和 `-march=brainfk-3tape`。

Brainfuck
是一种 [esolang](https://zh.wikipedia.org/wiki/%E6%B7%B1%E5%A5%A5%E7%9A%84%E7%BC%96%E7%A8%8B%E8%AF%AD%E8%A8%80)
，以下我们摘抄了一段 [Wikipeida](https://zh.wikipedia.org/wiki/Brainfuck) 对 Brainfuck 的介绍：

> Brainfuck的名字已经暗示出来，它的[程序](https://zh.wikipedia.org/wiki/%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A8%8B%E5%BA%8F)
> 代码很难读懂。尽管如此，Brainfuck 仍然可以像[图灵机](https://zh.wikipedia.org/wiki/%E5%9B%BE%E7%81%B5%E6%9C%BA)
> 一般完成任何计算任务。它虽然计算方式与众不同，但确实能够正确运行。
> 这种语言基于一个简单的机器模型。这个机器除了指令以外，还包括：一个以字节为单位、已初始化为零的数组、一个指向该数组的指针（开始时指向数组的第一个字节）、以及用于输入输出的两个字节流。
> 下面是这八种状态的描述，其中每个状态由一个字符标识：
>
> | 字符  | 含义                                                                 |
> |-----|--------------------------------------------------------------------|
> | `>` | 指针加一                                                               |
> | `<` | 指针减一                                                               |
> | `+` | 指针所指字节的值加一                                                         |
> | `-` | 指针所指字节的值减一                                                         |
> | `.` | 输出指针所指字节内容（[ASCII码](https://zh.wikipedia.org/wiki/ASCII%E7%A0%81)） |
> | `,` | 向指针所指的字节输入内容（ASCII码）                                               |
> | `[` | 若指针所指字节的值为零，则向后跳转，跳转到其对应的]的下一个指令处                                  |
> | `]` | 若指针所指字节的值不为零，则向前跳转，跳转到其对应的[的下一个指令处                                 |
>
> Brainfuck指令可以逐一替换，翻译成 [C 语言](https://zh.wikipedia.org/wiki/C%E8%AF%AD%E8%A8%80)（假设 `ptr` 是
`char *` [类型](https://zh.wikipedia.org/wiki/%E8%B3%87%E6%96%99%E9%A1%9E%E5%9E%8B)）的语句之类：
>
>
> | Brainfuck | C                   |
> |-----------|---------------------|
> | `>`       | `++ptr;`            |
> | `<`       | `--ptr;`            |
> | `+`       | `++*ptr;`           |
> | `-`       | `--*ptr;`           |
> | `.`       | `putchar(*ptr);`    |
> | `,`       | `*ptr = getchar();` |
> | `[`       | `while (*ptr) {`    |
> | `]`       | `}`                 |

我们的翻译分为两阶段：

- IR 到 3 tape brainfuck
- 3 tape brainfuck 到 1 tape brainfuck

其中 3 tape brainfuck 是基于标准 brainfuck 的拓展，也就是把 wiki 中提到的 `一个以字节为单位、已初始化为零的数组` 拓展为三个。
此时指令数有 8 个变为 24 个，每条带都有自己的 8 个指令。我们将之前的指令后面加上 tape 的编号，将新的指令表示为 `>1`, `+1`,
`>2`, `]3` 等等。  
3 tape 到 1 tape 的转换有[通用的替换规则](https://github.com/RacistCat/3-tape-brainfuck)。
此外，这样得到的 brainfuck 每条 tape 每个位置实际上只能存一个 byte，
但还有[通用的替换规则](https://github.com/RacistCat/32-bit-brainfuck)可以转为 4 byte。

我们的 tape 大致这样划分

- tape1: 主要用于存放 IR 的虚拟寄存器以及基本块跳转信息。
- tape2: 作为内存带，用于模拟栈上分配的对象。
- tape3: 目前用于辅助复制和调试的临时存储带。

由于后面还在写编译器的其他部分，时间有点来不及，这里有很多功能并未实现，目前我们只有：

- 控制流基本支持，可以翻译 `if`,`while`
- 内存操作基本支持，可以使用数组
- 支持一部分数值运算（`+`, `-`）
- 支持一部分 SysY Lib 函数（`getch`, `putch`）

比如可以翻译一个简单的 helloworld:

```c++
int main()
{
    int str[14] = { 72, 101, 108, 108, 111, 44, 32, 87, 111, 114, 108, 100, 33, 10 };
    int i = 0;
    while (i != 14)
    {
        putch(str[i]);
        i = i + 1;
    }
    return 0;
}
```

因为实现并不完善，翻译后的代码体积非常大，而且运行也较为缓慢，~~需要一个性能足够好的解释器和足够的耐心（逃~~

另外这里给出一个性能比较好的一个 brainfuck 解释器

- https://github.com/MDLC01/brainfuck-interpreter

## 参考资料

- [Wikipedia - Brainfuck](https://zh.wikipedia.org/wiki/Brainfuck)
- [BrainFuck Algorithms](https://github.com/moky/BrainFuck)
- [3-tape-brainfuck](https://github.com/RacistCat/3-tape-brainfuck)
- [32-bit-brainfuck](https://github.com/RacistCat/32-bit-brainfuck)

