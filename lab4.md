## 练习1：分配并初始化一个进程控制块（需要编码）
### 实验要求
alloc_proc函数（位于kern/process/proc.c中）负责分配并返回一个新的struct proc_struct结构，用于存储新建立的内核线程的管理信息。ucore需要对这个结构进行最基本的初始化，你需要完成这个初始化过程。

请在实验报告中简要说明你的设计实现过程。请回答如下问题：
请说明proc_struct中struct context context和struct trapframe *tf成员变量含义和在本实验中的作用是啥？（提示通过看代码和编程调试可以判断出来）

### 设计实现过程
proc_init 函数中包含对 alloc_proc 初始化结果的校验逻辑，通过对比 idleproc（空闲进程）的成员状态判断初始化是否正确。校验条件明确了各成员的预期初始值，是 alloc_proc 实现的核心依据，关键校验逻辑如下：
```c
if(idleproc->pgdir == boot_pgdir_pa && idleproc->tf == NULL && !context_init_flag
    && idleproc->state == PROC_UNINIT && idleproc->pid == -1 && idleproc->runs == 0
    && idleproc->kstack == 0 && idleproc->need_resched == 0 && idleproc->parent == NULL
    && idleproc->mm == NULL && idleproc->flags == 0 && !proc_name_flag
){
    cprintf("alloc_proc() correct!\n");
}
```
其中：
- context_init_flag 是 idleproc->context 与全零内存的比较结果，要求上下文初始化为全零；
- proc_name_flag 是 idleproc->name 与全零内存的比较结果，要求进程名初始为空；
- 其他成员需满足特定初始值（如 pid=-1、state=PROC_UNINIT 等）。

### 代码实现与逻辑说明
根据校验逻辑，alloc_proc 函数需通过 kmalloc 分配内存，并按 “校验预期值” 初始化所有成员，确保与 proc_init 的校验条件完全匹配。实现代码如下：
```c
alloc_proc(void)
{
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
    if (proc != NULL)
    {
        proc->pgdir = boot_pgdir_pa;
        proc->tf = NULL;
        proc->state = PROC_UNINIT;
        proc->pid = -1;
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        proc->flags = 0;
        memset(&(proc->context), 0, sizeof(struct context));
        memset(proc->name, 0, PROC_NAME_LEN + 1);
        }
    return proc;
}
```

### 编译依赖问题解决
编译过程中发现 kern/trap/trap.c 调用 sbi_shutdown 时出现 “隐式声明” 警告，最终导致链接错误。原因是该文件未包含 sbi.h 头文件（sbi_shutdown 的内联实现位于此文件）。
解决方案：在 kern/trap/trap.c 头部添加头文件包含：
```c
#include <sbi.h>
```
添加后编译器可正确识别 sbi_shutdown 函数实现，消除链接错误，确保内核正常编译。

### 解答
#### struct context context
（1）含义
struct context 是进程的上下文存储结构，核心存储 CPU 关键寄存器的状态（如返回地址 ra、栈指针 sp、保存寄存器 s0-s11 等），是进程执行现场的抽象。
（2）本实验中的作用
上下文是进程切换的核心数据载体。当内核通过 proc_run 函数调度进程时，会调用 switch_to 函数：
- 保存当前进程的 context（寄存器状态）到其 PCB 中；
- 从目标进程的 context 中恢复寄存器状态，使 CPU 无缝切换到目标进程的执行现场。

本实验中，context 通过 memset 全零初始化，确保进程切换时寄存器状态无脏数据干扰，为后续线程首次运行和调度切换奠定基础。

#### struct trapframe *tf
（1）含义
struct trapframe *tf 是指向陷阱帧的指针，陷阱帧存储进程发生中断、异常（如时钟中断、系统调用）时的完整 CPU 状态，包括通用寄存器（如 a0-a7、s0-s11）、程序计数器 epc、状态寄存器 status 等关键信息。
（2）本实验中的作用
陷阱帧是中断 / 异常处理与进程状态恢复的核心媒介，在本实验中主要用于内核线程的初始化与执行控制：

    内核线程创建时（如 kernel_thread 函数），会通过 copy_thread 函数初始化 tf，设置线程的入口点（epc）、执行函数及参数（通过 s0、s1 寄存器传递）；
    子线程创建时，会将 tf 中的 a0 寄存器设为 0，用于标识线程创建成功（类似系统调用返回值）；
    当中断 / 异常处理完成后，内核可通过 tf 恢复进程的执行状态，确保线程从暂停点继续运行。

本实验中 tf 初始化为 NULL，表示进程尚未发生中断 / 异常，后续会在线程创建过程中动态分配并初始化。
四、实验总结

## 练习3：编写proc_run 函数（需要编码）
### 实验要求
proc_run用于将指定的进程切换到CPU上运行。它的大致执行步骤包括：

- 检查要切换的进程是否与当前正在运行的进程相同，如果相同则不需要切换。
- 禁用中断。你可以使用/kern/sync/sync.h中定义好的宏local_intr_save(x)和local_intr_restore(x)来实现关、开中断。
- 切换当前进程为要运行的进程。
- 切换页表，以便使用新进程的地址空间。/libs/riscv.h中提供了lsatp(unsigned int pgdir)函数，可实现修改SATP寄存器值的功能。
- 实现上下文切换。/kern/process中已经预先编写好了switch.S，其中定义了switch_to()函数。可实现两个进程的context切换。
- 允许中断。
请回答如下问题：

在本实验的执行过程中，创建且运行了几个内核线程？

### 具体实现
```
void proc_run(struct proc_struct *proc)
{
    if (proc != current)
    {
        // LAB4:EXERCISE3 2312823
        /*
         * Some Useful MACROs, Functions and DEFINEs, you can use them in below implementation.
         * MACROs or Functions:
         *   local_intr_save():        Disable interrupts // 禁用中断 /kern/sync/sync.h
         *   local_intr_restore():     Enable Interrupts  // 启用中断 /kern/sync/sync.h
         *   lsatp():                  Modify the value of satp register // 修改satp寄存器的值 /libs/riscv.h
         *   switch_to():              Context switching between two processes // 在两个进程之间进行上下文切换 /kern/process/switch.S
         */
        bool flag;//禁用和启动中断的标志变量
        local_intr_save(flag);//保存并禁用中断

        struct proc_struct *current_proc = current;
        current = proc;

        lsatp(proc->pgdir);//将下一个要运行进程的 pgdir 值加载到 satp 寄存器中

        switch_to($(current_proc->context), $(proc->context));//进行进程上下文切换，使用指针以修改原始值

        local_intr_restore(flag);//恢复中断状态
    }
}
```

### 解答
在本实验的执行过程中，创建且运行了2个内核线程：
- idleproc：空闲进程，一个特殊的进程，它的主要目的是在系统没有其他任务需要执行时，占用 CPU 时间，同时便于进程调度的统一化。
- initproc：完成内核中各个子系统的初始化后，idleproc 内核子线程为满足 uCore 创建其他进程来完成各种工作需求，initproc 作为第一个用户进程被创建并运行。

## 扩展练习 Challenge1
### 实验要求
说明语句local_intr_save(intr_flag);....local_intr_restore(intr_flag);是如何实现开关中断的？

### 解答
local_intr_save 和 local_intr_restore 的定义位于\kern\sync\sync.h，具体如下：
```c
#ifndef __KERN_SYNC_SYNC_H__
#define __KERN_SYNC_SYNC_H__

#include <defs.h>
#include <intr.h>
#include <riscv.h>

/*保存当前中断状态，并在必要时禁用中断*/
static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
        intr_disable();
        return 1;
    }
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
        intr_enable();
    }
}

#define local_intr_save(x) \
    do {                   \
        x = __intr_save(); \
    } while (0) // 确保其行为与普通代码块一致，安全地在任何上下文中使用该宏，避免语法问题
#define local_intr_restore(x) __intr_restore(x);

#endif /* !__KERN_SYNC_SYNC_H__ */
```
- intr_flag：用于保存当前中断状态。1表示中断已启用，0表示中断已禁用。
- local_intr_save(intr_flag)：调用__intr_save()函数，检查中断状态寄存器 sstatus 的 SIE 位。如果 SIE 位被设置，表示中断已启用，则调用 intr_disable 函数禁用中断，并返回1。否则，返回0。
- local_intr_restore(intr_flag)：调用__intr_restore(intr_flag)函数，根据传入的标志变量 intr_flag 的值决定是否重新启用中断。如果intr_flag为1，则调用intr_enable()函数重新启用中断；如果intr_flag为0，则不进行任何操作，保持中断禁用状态。