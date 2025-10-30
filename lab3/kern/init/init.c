#include <clock.h>
#include <console.h>
#include <defs.h>
#include <intr.h>
#include <kdebug.h>
#include <kmonitor.h>
#include <pmm.h>
#include <stdio.h>
#include <string.h>
#include <trap.h>
#include <dtb.h>

int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);

int kern_init(void) {
    extern char edata[], end[];
    // 先清零 BSS，再读取并保存 DTB 的内存信息，避免被清零覆盖（为了解释变化 正式上传时我觉得应该删去这句话）
    memset(edata, 0, end - edata);
    dtb_init();
    cons_init();  // init the console
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);

    print_kerninfo();

    // grade_backtrace(); // 用于测试的栈回溯函数，当前被注释掉
    idt_init();  // 初始化中断描述符表（IDT），设置中断向量和处理函数

    pmm_init();  // 初始化物理内存管理（PMM），建立内存空闲/分配数据结构

    idt_init();  // 再次初始化 IDT（保留原代码，若为重复调用可考虑删除）

    clock_init();   // 初始化时钟中断，设置时钟硬件和定时器
    intr_enable();  // 使能外部中断（IRQ），允许处理器响应中断请求
    // LAB3: CAHLLENGE 1 If you try to do it, uncomment lab3_switch_test()
    // user/kernel mode switch test
    // lab3_switch_test();
    asm("ebreak");//触发断点异常
    asm("mret");//触发非法指令异常

    /* do nothing */
    while (1)
        ;
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
    mon_backtrace(0, NULL, NULL);
}

void __attribute__((noinline)) grade_backtrace1(int arg0, int arg1) {
    grade_backtrace2(arg0, (uintptr_t)&arg0, arg1, (uintptr_t)&arg1);
}

void __attribute__((noinline)) grade_backtrace0(int arg0, int arg1, int arg2) {
    grade_backtrace1(arg0, arg2);
}

void grade_backtrace(void) { grade_backtrace0(0, (uintptr_t)kern_init, 0xffff0000); }

