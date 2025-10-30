#include <stdio.h>

int
main(void) {
    /* 生成中断/异常处理程序入口和向量表的汇编代码 */
    printf("# handler\n");
    printf(".text\n");
    printf(".globl __alltraps\n");

    int i;
    for (i = 0; i < 256; i ++) {
        /* 为每个向量生成全局符号和标签 */
        printf(".globl vector%d\n", i);
        printf("vector%d:\n", i);
        /*
         * 对于不会由 CPU 自动压入错误码的异常，压入一个占位错误码 0。
         * 按惯例，向量 8-14 和 17 会有错误码，因此这些不需要额外压入 0。
         */
        if ((i < 8 || i > 14) && i != 17) {
            printf("  pushl $0\n");
        }
        /* 将向量号压栈，然后跳转到统一的处理入口 __alltraps */
        printf("  pushl $%d\n", i);
        printf("  jmp __alltraps\n");
    }
    printf("\n");
    /* 生成向量表（数据段），每项为对应处理程序的地址 */
    printf("# vector table\n");
    printf(".data\n");
    printf(".globl __vectors\n");
    printf("__vectors:\n");
    for (i = 0; i < 256; i ++) {
        printf("  .long vector%d\n", i);
    }
    return 0;
}

