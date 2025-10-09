# lab1实验报告
## 练习1：理解内核启动中的程序入口操作
### 问题回答
#### 指令一：
```asm
la sp, bootstacktop
```
##### 完成的操作
- 加载地址到栈指针寄存器（SP）：指令 la 是 RISC-V 的伪指令，用于将标签 bootstacktop 代表的内存地址加载到寄存器中。在这个指令中，它将 bootstacktop 的地址加载到栈指针寄存器 sp 中。

- 设置栈指针：栈指针 sp（Stack Pointer）用来指向当前调用栈的顶部，通过将 bootstacktop 的地址加载到 sp，栈指针被初始化，指向内核栈的顶部。

##### 目的
- 初始化内核栈：la sp, bootstacktop 通过设置栈指针，确保内核启动时的堆栈空间可用。操作系统在执行过程中需要栈来保存函数调用的局部变量、返回地址、上下文切换等。因此，在内核启动初期，正确设置栈指针是确保内核正常工作的基础。

- 内核栈的分配与初始化：bootstack 定义了内核栈的底部，而 bootstacktop 定义了栈的顶部。由于栈的增长方向是从高地址向低地址，栈指针设置为栈的顶部以开始使用内核栈。


#### 指令二：
```asm
tail kern_init
```
##### 完成的操作
- 尾调用：tail 是 RISC-V 的尾调用伪指令，它表示跳转到函数 kern_init，并且不保存当前函数 kern_entry 的返回地址。这种跳转方式不会为新的函数调用分配额外的栈空间，因此 kern_entry 的栈帧会被释放。

- 跳转到内核初始化函数：kern_init 是内核的初始化函数，执行操作系统的核心初始化任务。通过 tail kern_init，控制权从当前的 kern_entry 转移到 kern_init，并不会返回到 kern_entry。

##### 目的
- 内核启动流程的转移：kern_entry 是整个内核的启动入口，负责完成基本的设置（如栈的初始化），而真正的内核初始化操作由 kern_init 执行。tail kern_init 将执行流程从 kern_entry 转移到 kern_init，开始内核的初始化过程。

- 优化函数调用：尾调用是一种优化的函数调用方式，它减少了函数调用的开销，避免了多余的栈帧，节省内存空间并提高了性能。在这个场景下，使用 tail 可以避免在启动过程中消耗不必要的栈空间，从而使内核的启动更加高效。

## 练习2: 使用GDB验证启动流程
### 实验步骤
进入实验路径：
```bash
cd /home/root2/labcodes/lab1
```
启动两个终端窗口，分别执行以下命令：
1. 在第一个终端中，使用以下命令启动GDB调试器
```bash
make debug
```
2. 在第二个终端中，使用以下命令启动QEMU模拟器并进入调试模式
```bash
make debug
```

在GDB中输入指令 
```bash
x/10i $pc
```
查看RISC-V硬件加电后的10条指令。
得到的结果如下：
```bash
0x1000:    auipc    t0,0x0
0x1004:    addi    a1,t0,32
0x1008:    csrr    a0,mhartid
0x100c:    ld    t0,24(t0)
0x1010:    jr    t0
0x1014:    unimp
0x1016:    unimp
0x1018:    unimp
0x101a:    0x8000
0x101c:    unimp
```
通过观察发现，在执行到 `0x1010` 处时，程序跳转到了 `t0` 处，继续执行内核的初始化代码。
可知实际执行的代码为：
```bash
0x1000:    auipc    t0,0x0
0x1004:    addi    a1,t0,32
0x1008:    csrr    a0,mhartid
0x100c:    ld    t0,24(t0)
0x1010:    jr    t0
```


接着使用si指令逐步执行，并且输入info r t0来获得指令涉及到的寄存器结果：
```bash
(gdb) si
0x0000000000001004 in ?? ()
(gdb) info r t0
t0             0x1000    4096
(gdb) si
0x0000000000001008 in ?? ()
(gdb) info r t0
t0             0x1000    4096
(gdb) si
0x000000000000100c in ?? ()
(gdb) info r t0
t0             0x1000    4096
(gdb) si
0x0000000000001010 in ?? ()
(gdb) info r t0
t0             0x80000000    2147483648
(gdb) si
0x0000000080000000 in ?? ()
```
我们分析指令执行流程与寄存器变化：

` 0x1000（auipc t0, 0x0）`：t0 = pc(0x1000) + 0 → 0x1000
`0x1004（addi a1, t0, 32）`：t0 未修改，保持 0x1000
`0x1008（csrr a0, mhartid）`：不涉及 t0，仍为 0x1000
`0x100c（ld t0, 24(t0)）`：从 0x1018 读取数据→t0=0x80000000
`0x1010（jr t0）`：跳转到 t0 地址 0x80000000，进入 OpenSBI 执行

代码会跳转到 0x80000000 处继续执行，输入
```bash
x/10i 0x80000000
```
显示0x80000000处的10条指令。
得到的结果如下：
```bash
0x80000000:    csrr    a6,mhartid
0x80000004:    bgtz    a6,0x80000108
0x80000008:    auipc    t0,0x0
0x8000000c:    addi    t0,t0,1032
0x80000010:    auipc    t1,0x0
0x80000014:    addi    t1,t1,-16
0x80000018:    sd    t1,0(t0)
0x8000001c:    auipc    t0,0x0
0x80000020:    addi    t0,t0,1020
0x80000024:    ld    t0,0(t0)
```
我们在 0x80200000 处设置断点设置断点：
```bash
(gdb)b *0x80200000
```
该地址是内核入口 kern_entry 的起始地址（对应 kern/init/entry.S 代码）。
设置监视点，观察该地址的变化。
```bash
(gdb) watch *0x80200000
```
最后输入
```bash
(gdb) c
```
后，OpenSBI 完成初始化并跳转到 0x80200000，触发断点，此时程序进入内核入口函数 kern_entry。
我们得到的结果如下：
```bash
(gdb) watch *0x80200000
Hardware watchpoint 1: *0x80200000
(gdb) b *0x80200000
Note: breakpoint 1 also set at pc 0x80200000.
Breakpoint 2 at 0x80200000: file kern/init/entry.S, line 7.
(gdb) c
Continuing.

Breakpoint 2, kern_entry () at kern/init/entry.S:7
7	    la sp, bootstacktop
(gdb) x/5i 0x80200000
```

我们也可以通过
```bash
x/5i 0x80200000
```
查看汇编代码
```bash
0x80200000 <kern_entry>:	auipc	sp,0x3
0x80200004 <kern_entry+4>:	mv	sp,sp
0x80200008 <kern_entry+8>:	j	0x8020000a <kern_init>
0x8020000a <kern_init>:	auipc	a0,0x3
0x8020000e <kern_init+4>:	addi	a0,a0,-2
```
在0x80200008地址处，程序跳转到了kern_init，在该函数里完成内核的其他初始化工作。

我们通知输入指令
```bash
c
```
让程序继续执行，得到
```bash
(gdb) b *0x8020000c
Breakpoint 3 at 0x8020000c: file kern/init/init.c, line 8.
(gdb) c
Continuing.
```
程序进入死循环。
实际上当执行c后，程序会执行完cprintf输出启动信息，然后进入while(1)死循环，此时 GDB 会显示 “无响应”（实际是程序在循环中运行）。

另一边的make debug终端得到的结果为：
```bash
OpenSBI v0.4 (Jul  2 2019 11:53:53)
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name          : QEMU Virt Machine
Platform HART Features : RV64ACDFIMSU
Platform Max HARTs     : 8
Current Hart           : 0
Firmware Base          : 0x80000000
Firmware Size          : 112 KB
Runtime SBI Version    : 0.1

PMP0: 0x0000000080000000-0x000000008001ffff (A)
PMP1: 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
```
### 问题回答
#### 加电后几条指令的地址
RISCV加电后的指令在地址 0x1000 到地址 0x1010 。
#### 主要完成的功能
auipc t0,0x0
- 通过 PC 相对寻址，将当前程序计数器（PC）值加载到寄存器t0，用于获取当前代码段基地址。

addi a1,t0,32
- 将t0的值加 32 后存入a1，设置与代码位置相关的地址参数。

csrr a0,mhartid
- 读取当前硬件线程 ID 寄存器mhartid的值并存入a0，用于多核心系统初始化。

ld t0,24(t0)
- 从t0 + 24地址处加载 8 字节数据到t0，获取下一阶段引导程序入口地址（此处为 0x80000000 ）。

jr t0
- 跳转执行，跳转到寄存器指向的地址处（此处为 0x80000000 ）。

简单来说就是，这5条指令完成了获取当前地址、设置参数、读取硬件线程ID，最终跳转到下一阶段引导程序（如OpenSBI），完成从硬件复位到引导程序的过渡。

## 重要知识点对应分析
### Qemu启动流程
- 加电启动：QEMU 模拟硬件上电，CPU 自动从复位地址 0x1000 开始执行初始引导代码。
- 引导至 OpenSBI：0x1000 处的指令（auipc、ld、jr 等）通过读取预设地址的跳转目标，将控制权移交至 OpenSBI 固件（入口 0x80000000）。
- OpenSBI 初始化：完成硬件配置（内存保护、中断控制器等），加载内核镜像并跳转到内核入口 0x80200000（对应 kern/init/entry.S）。
- 内核入口执行：kern_entry 函数初始化内核栈（la sp, bootstacktop），通过尾调用进入 kern_init() 函数（kern/init/init.c）。
- 内核初始化：kern_init() 完成数据段清零（memset）、控制台初始化（cons_init），调用 cprintf() 输出启动信息，最终进入死循环，标志启动完成。
### make debug与make gdb的关系
要在执行make debug之后才能运行make gdb，这是因为make debug启动目标程序并开放调试接口，而make gdb启动调试器并连接到服务器。
如果不先执行make debug，调试器将无法连接到目标程序，导致调试失败：
```bash
localhost:1234: Connection timed out.
```


## OS原理中重要但实验未涉及的知识点
### 进程管理与调度

- 核心内容：进程的创建（fork/exec）、销毁、状态转换（就绪 / 运行 / 阻塞）、调度算法（时间片轮转、优先级调度等）、进程同步与互斥（锁、信号量）。
- 未涉及原因：实验仅完成内核启动到初始化结束的流程，未进入多进程环境，无需管理进程生命周期或进行调度。

### 内存管理

- 核心内容：虚拟内存机制（页表、地址转换）、内存分配策略（伙伴系统、Slab 分配器）、页面置换算法（LRU、Clock）、用户态与内核态内存隔离。
- 未涉及原因：实验聚焦启动流程，内存访问直接使用物理地址，未涉及虚拟内存初始化或动态内存管理。

### 文件系统

- 核心内容：文件组织结构（inode、目录树）、文件操作（创建 / 读写 / 删除）、磁盘管理（分区、块分配）、虚拟文件系统（VFS）抽象。
- 未涉及原因：实验未涉及持久化存储或文件操作，内核启动无需依赖文件系统。
