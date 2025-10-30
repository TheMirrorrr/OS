#include <clock.h>
#include <defs.h>
#include <sbi.h>
#include <stdio.h>
#include <riscv.h>

volatile size_t ticks;

// 获取当前的时间戳（CPU周期数）
static inline uint64_t get_cycles(void) {
#if __riscv_xlen == 64
    uint64_t n;
    // 64位系统下，直接读取时间戳
    __asm__ __volatile__("rdtime %0" : "=r"(n));
    return n;
#else
    uint32_t lo, hi, tmp;
    // 32位系统下，读取高位和低位时间戳，并确保一致性
    __asm__ __volatile__(
        "1:\n"
        "rdtimeh %0\n"  // 读取高位时间戳
        "rdtime %1\n"   // 读取低位时间戳
        "rdtimeh %2\n"  // 再次读取高位时间戳
        "bne %0, %2, 1b" // 如果高位时间戳不一致，重新读取
        : "=&r"(hi), "=&r"(lo), "=&r"(tmp));
    // 合并高位和低位时间戳为64位值
    return ((uint64_t)hi << 32) | lo;
#endif
}

// Hardcode timebase
static uint64_t timebase = 100000;

/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
    // enable timer interrupt in sie
    set_csr(sie, MIP_STIP);
    // divided by 500 when using Spike(2MHz)
    // divided by 100 when using QEMU(10MHz)
    // timebase = sbi_timebase() / 500;
    clock_set_next_event();

    // initialize time counter 'ticks' to zero
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
