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