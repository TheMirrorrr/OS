#include <sbi.h>
#include <defs.h>


uint64_t SBI_SET_TIMER = 0;
uint64_t SBI_CONSOLE_PUTCHAR = 1; 
uint64_t SBI_CONSOLE_GETCHAR = 2;
uint64_t SBI_CLEAR_IPI = 3;
uint64_t SBI_SEND_IPI = 4;
uint64_t SBI_REMOTE_FENCE_I = 5;
uint64_t SBI_REMOTE_SFENCE_VMA = 6;
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

// SBI 调用函数，用于与 RISC-V 的 SBI (Supervisor Binary Interface) 交互
// 参数:
//   sbi_type - SBI 调用类型
//   arg0, arg1, arg2 - 传递给 SBI 的参数
// 返回值:
//   ret_val - SBI 调用的返回值
uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
        // 将 SBI 调用类型存入 x17 寄存器
        "mv x17, %[sbi_type]\n"
        // 将参数存入 x10, x11, x12 寄存器
        "mv x10, %[arg0]\n"
        "mv x11, %[arg1]\n"
        "mv x12, %[arg2]\n"
        // 触发 ecall 指令，进入 SBI
        "ecall\n"
        // 将返回值从 x10 寄存器取出
        "mv %[ret_val], x10"
        : [ret_val] "=r" (ret_val) // 输出操作数，ret_val 存储返回值
        : [sbi_type] "r" (sbi_type), [arg0] "r" (arg0), [arg1] "r" (arg1), [arg2] "r" (arg2) // 输入操作数
        : "memory" // 通知编译器内存可能被修改
    );
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}

void sbi_set_timer(unsigned long long stime_value) {
    sbi_call(SBI_SET_TIMER, stime_value, 0, 0);
}

int sbi_console_getchar(void) {
    return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
}

void sbi_shutdown(void)
{
	sbi_call(SBI_SHUTDOWN, 0, 0, 0);
}