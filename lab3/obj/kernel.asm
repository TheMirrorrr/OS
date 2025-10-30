
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	00007297          	auipc	t0,0x7
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0207000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	00007297          	auipc	t0,0x7
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0207008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)

    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c02062b7          	lui	t0,0xc0206
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc0200034:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200038:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc020003c:	c0206137          	lui	sp,0xc0206

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 1. 使用临时寄存器 t1 计算栈顶的精确地址
    lui t1, %hi(bootstacktop)
ffffffffc0200040:	c0206337          	lui	t1,0xc0206
    addi t1, t1, %lo(bootstacktop)
ffffffffc0200044:	00030313          	mv	t1,t1
    # 2. 将精确地址一次性地、安全地传给 sp
    mv sp, t1
ffffffffc0200048:	811a                	mv	sp,t1
    # 现在栈指针已经完美设置，可以安全地调用任何C函数了
    # 然后跳转到 kern_init (不再返回)
    lui t0, %hi(kern_init)
ffffffffc020004a:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc020004e:	05428293          	addi	t0,t0,84 # ffffffffc0200054 <kern_init>
    jr t0
ffffffffc0200052:	8282                	jr	t0

ffffffffc0200054 <kern_init>:
void grade_backtrace(void);

int kern_init(void) {
    extern char edata[], end[];
    // 先清零 BSS，再读取并保存 DTB 的内存信息，避免被清零覆盖（为了解释变化 正式上传时我觉得应该删去这句话）
    memset(edata, 0, end - edata);
ffffffffc0200054:	00007517          	auipc	a0,0x7
ffffffffc0200058:	fd450513          	addi	a0,a0,-44 # ffffffffc0207028 <free_area>
ffffffffc020005c:	00007617          	auipc	a2,0x7
ffffffffc0200060:	44460613          	addi	a2,a2,1092 # ffffffffc02074a0 <end>
int kern_init(void) {
ffffffffc0200064:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc0200066:	8e09                	sub	a2,a2,a0
ffffffffc0200068:	4581                	li	a1,0
int kern_init(void) {
ffffffffc020006a:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc020006c:	72f010ef          	jal	ra,ffffffffc0201f9a <memset>
    dtb_init();
ffffffffc0200070:	414000ef          	jal	ra,ffffffffc0200484 <dtb_init>
    cons_init();  // init the console
ffffffffc0200074:	402000ef          	jal	ra,ffffffffc0200476 <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc0200078:	00002517          	auipc	a0,0x2
ffffffffc020007c:	f3850513          	addi	a0,a0,-200 # ffffffffc0201fb0 <etext+0x4>
ffffffffc0200080:	096000ef          	jal	ra,ffffffffc0200116 <cputs>

    print_kerninfo();
ffffffffc0200084:	0e2000ef          	jal	ra,ffffffffc0200166 <print_kerninfo>

    // grade_backtrace(); // 用于测试的栈回溯函数，当前被注释掉
    idt_init();  // 初始化中断描述符表（IDT），设置中断向量和处理函数
ffffffffc0200088:	7b8000ef          	jal	ra,ffffffffc0200840 <idt_init>

    pmm_init();  // 初始化物理内存管理（PMM），建立内存空闲/分配数据结构
ffffffffc020008c:	792010ef          	jal	ra,ffffffffc020181e <pmm_init>

    idt_init();  // 再次初始化 IDT（保留原代码，若为重复调用可考虑删除）
ffffffffc0200090:	7b0000ef          	jal	ra,ffffffffc0200840 <idt_init>

    clock_init();   // 初始化时钟中断，设置时钟硬件和定时器
ffffffffc0200094:	3a0000ef          	jal	ra,ffffffffc0200434 <clock_init>
    intr_enable();  // 使能外部中断（IRQ），允许处理器响应中断请求
ffffffffc0200098:	79c000ef          	jal	ra,ffffffffc0200834 <intr_enable>
    // LAB3: CAHLLENGE 1 If you try to do it, uncomment lab3_switch_test()
    // user/kernel mode switch test
    // lab3_switch_test();
    asm("ebreak");//触发断点异常
ffffffffc020009c:	9002                	ebreak
    asm("mret");//触发非法指令异常
ffffffffc020009e:	30200073          	mret

    /* do nothing */
    while (1)
ffffffffc02000a2:	a001                	j	ffffffffc02000a2 <kern_init+0x4e>

ffffffffc02000a4 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc02000a4:	1141                	addi	sp,sp,-16
ffffffffc02000a6:	e022                	sd	s0,0(sp)
ffffffffc02000a8:	e406                	sd	ra,8(sp)
ffffffffc02000aa:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc02000ac:	3cc000ef          	jal	ra,ffffffffc0200478 <cons_putc>
    (*cnt) ++;
ffffffffc02000b0:	401c                	lw	a5,0(s0)
}
ffffffffc02000b2:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc02000b4:	2785                	addiw	a5,a5,1
ffffffffc02000b6:	c01c                	sw	a5,0(s0)
}
ffffffffc02000b8:	6402                	ld	s0,0(sp)
ffffffffc02000ba:	0141                	addi	sp,sp,16
ffffffffc02000bc:	8082                	ret

ffffffffc02000be <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000be:	1101                	addi	sp,sp,-32
ffffffffc02000c0:	862a                	mv	a2,a0
ffffffffc02000c2:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000c4:	00000517          	auipc	a0,0x0
ffffffffc02000c8:	fe050513          	addi	a0,a0,-32 # ffffffffc02000a4 <cputch>
ffffffffc02000cc:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000ce:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc02000d0:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000d2:	199010ef          	jal	ra,ffffffffc0201a6a <vprintfmt>
    return cnt;
}
ffffffffc02000d6:	60e2                	ld	ra,24(sp)
ffffffffc02000d8:	4532                	lw	a0,12(sp)
ffffffffc02000da:	6105                	addi	sp,sp,32
ffffffffc02000dc:	8082                	ret

ffffffffc02000de <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc02000de:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc02000e0:	02810313          	addi	t1,sp,40 # ffffffffc0206028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc02000e4:	8e2a                	mv	t3,a0
ffffffffc02000e6:	f42e                	sd	a1,40(sp)
ffffffffc02000e8:	f832                	sd	a2,48(sp)
ffffffffc02000ea:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000ec:	00000517          	auipc	a0,0x0
ffffffffc02000f0:	fb850513          	addi	a0,a0,-72 # ffffffffc02000a4 <cputch>
ffffffffc02000f4:	004c                	addi	a1,sp,4
ffffffffc02000f6:	869a                	mv	a3,t1
ffffffffc02000f8:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc02000fa:	ec06                	sd	ra,24(sp)
ffffffffc02000fc:	e0ba                	sd	a4,64(sp)
ffffffffc02000fe:	e4be                	sd	a5,72(sp)
ffffffffc0200100:	e8c2                	sd	a6,80(sp)
ffffffffc0200102:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc0200104:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc0200106:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200108:	163010ef          	jal	ra,ffffffffc0201a6a <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc020010c:	60e2                	ld	ra,24(sp)
ffffffffc020010e:	4512                	lw	a0,4(sp)
ffffffffc0200110:	6125                	addi	sp,sp,96
ffffffffc0200112:	8082                	ret

ffffffffc0200114 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
    cons_putc(c);
ffffffffc0200114:	a695                	j	ffffffffc0200478 <cons_putc>

ffffffffc0200116 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc0200116:	1101                	addi	sp,sp,-32
ffffffffc0200118:	e822                	sd	s0,16(sp)
ffffffffc020011a:	ec06                	sd	ra,24(sp)
ffffffffc020011c:	e426                	sd	s1,8(sp)
ffffffffc020011e:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc0200120:	00054503          	lbu	a0,0(a0)
ffffffffc0200124:	c51d                	beqz	a0,ffffffffc0200152 <cputs+0x3c>
ffffffffc0200126:	0405                	addi	s0,s0,1
ffffffffc0200128:	4485                	li	s1,1
ffffffffc020012a:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc020012c:	34c000ef          	jal	ra,ffffffffc0200478 <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc0200130:	00044503          	lbu	a0,0(s0)
ffffffffc0200134:	008487bb          	addw	a5,s1,s0
ffffffffc0200138:	0405                	addi	s0,s0,1
ffffffffc020013a:	f96d                	bnez	a0,ffffffffc020012c <cputs+0x16>
    (*cnt) ++;
ffffffffc020013c:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc0200140:	4529                	li	a0,10
ffffffffc0200142:	336000ef          	jal	ra,ffffffffc0200478 <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc0200146:	60e2                	ld	ra,24(sp)
ffffffffc0200148:	8522                	mv	a0,s0
ffffffffc020014a:	6442                	ld	s0,16(sp)
ffffffffc020014c:	64a2                	ld	s1,8(sp)
ffffffffc020014e:	6105                	addi	sp,sp,32
ffffffffc0200150:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc0200152:	4405                	li	s0,1
ffffffffc0200154:	b7f5                	j	ffffffffc0200140 <cputs+0x2a>

ffffffffc0200156 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
ffffffffc0200156:	1141                	addi	sp,sp,-16
ffffffffc0200158:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc020015a:	326000ef          	jal	ra,ffffffffc0200480 <cons_getc>
ffffffffc020015e:	dd75                	beqz	a0,ffffffffc020015a <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc0200160:	60a2                	ld	ra,8(sp)
ffffffffc0200162:	0141                	addi	sp,sp,16
ffffffffc0200164:	8082                	ret

ffffffffc0200166 <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc0200166:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc0200168:	00002517          	auipc	a0,0x2
ffffffffc020016c:	e6850513          	addi	a0,a0,-408 # ffffffffc0201fd0 <etext+0x24>
void print_kerninfo(void) {
ffffffffc0200170:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200172:	f6dff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", kern_init);
ffffffffc0200176:	00000597          	auipc	a1,0x0
ffffffffc020017a:	ede58593          	addi	a1,a1,-290 # ffffffffc0200054 <kern_init>
ffffffffc020017e:	00002517          	auipc	a0,0x2
ffffffffc0200182:	e7250513          	addi	a0,a0,-398 # ffffffffc0201ff0 <etext+0x44>
ffffffffc0200186:	f59ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc020018a:	00002597          	auipc	a1,0x2
ffffffffc020018e:	e2258593          	addi	a1,a1,-478 # ffffffffc0201fac <etext>
ffffffffc0200192:	00002517          	auipc	a0,0x2
ffffffffc0200196:	e7e50513          	addi	a0,a0,-386 # ffffffffc0202010 <etext+0x64>
ffffffffc020019a:	f45ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc020019e:	00007597          	auipc	a1,0x7
ffffffffc02001a2:	e8a58593          	addi	a1,a1,-374 # ffffffffc0207028 <free_area>
ffffffffc02001a6:	00002517          	auipc	a0,0x2
ffffffffc02001aa:	e8a50513          	addi	a0,a0,-374 # ffffffffc0202030 <etext+0x84>
ffffffffc02001ae:	f31ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc02001b2:	00007597          	auipc	a1,0x7
ffffffffc02001b6:	2ee58593          	addi	a1,a1,750 # ffffffffc02074a0 <end>
ffffffffc02001ba:	00002517          	auipc	a0,0x2
ffffffffc02001be:	e9650513          	addi	a0,a0,-362 # ffffffffc0202050 <etext+0xa4>
ffffffffc02001c2:	f1dff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc02001c6:	00007597          	auipc	a1,0x7
ffffffffc02001ca:	6d958593          	addi	a1,a1,1753 # ffffffffc020789f <end+0x3ff>
ffffffffc02001ce:	00000797          	auipc	a5,0x0
ffffffffc02001d2:	e8678793          	addi	a5,a5,-378 # ffffffffc0200054 <kern_init>
ffffffffc02001d6:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02001da:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc02001de:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02001e0:	3ff5f593          	andi	a1,a1,1023
ffffffffc02001e4:	95be                	add	a1,a1,a5
ffffffffc02001e6:	85a9                	srai	a1,a1,0xa
ffffffffc02001e8:	00002517          	auipc	a0,0x2
ffffffffc02001ec:	e8850513          	addi	a0,a0,-376 # ffffffffc0202070 <etext+0xc4>
}
ffffffffc02001f0:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02001f2:	b5f5                	j	ffffffffc02000de <cprintf>

ffffffffc02001f4 <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc02001f4:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc02001f6:	00002617          	auipc	a2,0x2
ffffffffc02001fa:	eaa60613          	addi	a2,a2,-342 # ffffffffc02020a0 <etext+0xf4>
ffffffffc02001fe:	04d00593          	li	a1,77
ffffffffc0200202:	00002517          	auipc	a0,0x2
ffffffffc0200206:	eb650513          	addi	a0,a0,-330 # ffffffffc02020b8 <etext+0x10c>
void print_stackframe(void) {
ffffffffc020020a:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc020020c:	1cc000ef          	jal	ra,ffffffffc02003d8 <__panic>

ffffffffc0200210 <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200210:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200212:	00002617          	auipc	a2,0x2
ffffffffc0200216:	ebe60613          	addi	a2,a2,-322 # ffffffffc02020d0 <etext+0x124>
ffffffffc020021a:	00002597          	auipc	a1,0x2
ffffffffc020021e:	ed658593          	addi	a1,a1,-298 # ffffffffc02020f0 <etext+0x144>
ffffffffc0200222:	00002517          	auipc	a0,0x2
ffffffffc0200226:	ed650513          	addi	a0,a0,-298 # ffffffffc02020f8 <etext+0x14c>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc020022a:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc020022c:	eb3ff0ef          	jal	ra,ffffffffc02000de <cprintf>
ffffffffc0200230:	00002617          	auipc	a2,0x2
ffffffffc0200234:	ed860613          	addi	a2,a2,-296 # ffffffffc0202108 <etext+0x15c>
ffffffffc0200238:	00002597          	auipc	a1,0x2
ffffffffc020023c:	ef858593          	addi	a1,a1,-264 # ffffffffc0202130 <etext+0x184>
ffffffffc0200240:	00002517          	auipc	a0,0x2
ffffffffc0200244:	eb850513          	addi	a0,a0,-328 # ffffffffc02020f8 <etext+0x14c>
ffffffffc0200248:	e97ff0ef          	jal	ra,ffffffffc02000de <cprintf>
ffffffffc020024c:	00002617          	auipc	a2,0x2
ffffffffc0200250:	ef460613          	addi	a2,a2,-268 # ffffffffc0202140 <etext+0x194>
ffffffffc0200254:	00002597          	auipc	a1,0x2
ffffffffc0200258:	f0c58593          	addi	a1,a1,-244 # ffffffffc0202160 <etext+0x1b4>
ffffffffc020025c:	00002517          	auipc	a0,0x2
ffffffffc0200260:	e9c50513          	addi	a0,a0,-356 # ffffffffc02020f8 <etext+0x14c>
ffffffffc0200264:	e7bff0ef          	jal	ra,ffffffffc02000de <cprintf>
    }
    return 0;
}
ffffffffc0200268:	60a2                	ld	ra,8(sp)
ffffffffc020026a:	4501                	li	a0,0
ffffffffc020026c:	0141                	addi	sp,sp,16
ffffffffc020026e:	8082                	ret

ffffffffc0200270 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200270:	1141                	addi	sp,sp,-16
ffffffffc0200272:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc0200274:	ef3ff0ef          	jal	ra,ffffffffc0200166 <print_kerninfo>
    return 0;
}
ffffffffc0200278:	60a2                	ld	ra,8(sp)
ffffffffc020027a:	4501                	li	a0,0
ffffffffc020027c:	0141                	addi	sp,sp,16
ffffffffc020027e:	8082                	ret

ffffffffc0200280 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200280:	1141                	addi	sp,sp,-16
ffffffffc0200282:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc0200284:	f71ff0ef          	jal	ra,ffffffffc02001f4 <print_stackframe>
    return 0;
}
ffffffffc0200288:	60a2                	ld	ra,8(sp)
ffffffffc020028a:	4501                	li	a0,0
ffffffffc020028c:	0141                	addi	sp,sp,16
ffffffffc020028e:	8082                	ret

ffffffffc0200290 <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc0200290:	7115                	addi	sp,sp,-224
ffffffffc0200292:	ed5e                	sd	s7,152(sp)
ffffffffc0200294:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc0200296:	00002517          	auipc	a0,0x2
ffffffffc020029a:	eda50513          	addi	a0,a0,-294 # ffffffffc0202170 <etext+0x1c4>
kmonitor(struct trapframe *tf) {
ffffffffc020029e:	ed86                	sd	ra,216(sp)
ffffffffc02002a0:	e9a2                	sd	s0,208(sp)
ffffffffc02002a2:	e5a6                	sd	s1,200(sp)
ffffffffc02002a4:	e1ca                	sd	s2,192(sp)
ffffffffc02002a6:	fd4e                	sd	s3,184(sp)
ffffffffc02002a8:	f952                	sd	s4,176(sp)
ffffffffc02002aa:	f556                	sd	s5,168(sp)
ffffffffc02002ac:	f15a                	sd	s6,160(sp)
ffffffffc02002ae:	e962                	sd	s8,144(sp)
ffffffffc02002b0:	e566                	sd	s9,136(sp)
ffffffffc02002b2:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02002b4:	e2bff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc02002b8:	00002517          	auipc	a0,0x2
ffffffffc02002bc:	ee050513          	addi	a0,a0,-288 # ffffffffc0202198 <etext+0x1ec>
ffffffffc02002c0:	e1fff0ef          	jal	ra,ffffffffc02000de <cprintf>
    if (tf != NULL) {
ffffffffc02002c4:	000b8563          	beqz	s7,ffffffffc02002ce <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc02002c8:	855e                	mv	a0,s7
ffffffffc02002ca:	756000ef          	jal	ra,ffffffffc0200a20 <print_trapframe>
ffffffffc02002ce:	00002c17          	auipc	s8,0x2
ffffffffc02002d2:	f3ac0c13          	addi	s8,s8,-198 # ffffffffc0202208 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc02002d6:	00002917          	auipc	s2,0x2
ffffffffc02002da:	eea90913          	addi	s2,s2,-278 # ffffffffc02021c0 <etext+0x214>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02002de:	00002497          	auipc	s1,0x2
ffffffffc02002e2:	eea48493          	addi	s1,s1,-278 # ffffffffc02021c8 <etext+0x21c>
        if (argc == MAXARGS - 1) {
ffffffffc02002e6:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02002e8:	00002b17          	auipc	s6,0x2
ffffffffc02002ec:	ee8b0b13          	addi	s6,s6,-280 # ffffffffc02021d0 <etext+0x224>
        argv[argc ++] = buf;
ffffffffc02002f0:	00002a17          	auipc	s4,0x2
ffffffffc02002f4:	e00a0a13          	addi	s4,s4,-512 # ffffffffc02020f0 <etext+0x144>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02002f8:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc02002fa:	854a                	mv	a0,s2
ffffffffc02002fc:	2f1010ef          	jal	ra,ffffffffc0201dec <readline>
ffffffffc0200300:	842a                	mv	s0,a0
ffffffffc0200302:	dd65                	beqz	a0,ffffffffc02002fa <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200304:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc0200308:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020030a:	e1bd                	bnez	a1,ffffffffc0200370 <kmonitor+0xe0>
    if (argc == 0) {
ffffffffc020030c:	fe0c87e3          	beqz	s9,ffffffffc02002fa <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200310:	6582                	ld	a1,0(sp)
ffffffffc0200312:	00002d17          	auipc	s10,0x2
ffffffffc0200316:	ef6d0d13          	addi	s10,s10,-266 # ffffffffc0202208 <commands>
        argv[argc ++] = buf;
ffffffffc020031a:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020031c:	4401                	li	s0,0
ffffffffc020031e:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200320:	421010ef          	jal	ra,ffffffffc0201f40 <strcmp>
ffffffffc0200324:	c919                	beqz	a0,ffffffffc020033a <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200326:	2405                	addiw	s0,s0,1
ffffffffc0200328:	0b540063          	beq	s0,s5,ffffffffc02003c8 <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc020032c:	000d3503          	ld	a0,0(s10)
ffffffffc0200330:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200332:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200334:	40d010ef          	jal	ra,ffffffffc0201f40 <strcmp>
ffffffffc0200338:	f57d                	bnez	a0,ffffffffc0200326 <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc020033a:	00141793          	slli	a5,s0,0x1
ffffffffc020033e:	97a2                	add	a5,a5,s0
ffffffffc0200340:	078e                	slli	a5,a5,0x3
ffffffffc0200342:	97e2                	add	a5,a5,s8
ffffffffc0200344:	6b9c                	ld	a5,16(a5)
ffffffffc0200346:	865e                	mv	a2,s7
ffffffffc0200348:	002c                	addi	a1,sp,8
ffffffffc020034a:	fffc851b          	addiw	a0,s9,-1
ffffffffc020034e:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc0200350:	fa0555e3          	bgez	a0,ffffffffc02002fa <kmonitor+0x6a>
}
ffffffffc0200354:	60ee                	ld	ra,216(sp)
ffffffffc0200356:	644e                	ld	s0,208(sp)
ffffffffc0200358:	64ae                	ld	s1,200(sp)
ffffffffc020035a:	690e                	ld	s2,192(sp)
ffffffffc020035c:	79ea                	ld	s3,184(sp)
ffffffffc020035e:	7a4a                	ld	s4,176(sp)
ffffffffc0200360:	7aaa                	ld	s5,168(sp)
ffffffffc0200362:	7b0a                	ld	s6,160(sp)
ffffffffc0200364:	6bea                	ld	s7,152(sp)
ffffffffc0200366:	6c4a                	ld	s8,144(sp)
ffffffffc0200368:	6caa                	ld	s9,136(sp)
ffffffffc020036a:	6d0a                	ld	s10,128(sp)
ffffffffc020036c:	612d                	addi	sp,sp,224
ffffffffc020036e:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200370:	8526                	mv	a0,s1
ffffffffc0200372:	413010ef          	jal	ra,ffffffffc0201f84 <strchr>
ffffffffc0200376:	c901                	beqz	a0,ffffffffc0200386 <kmonitor+0xf6>
ffffffffc0200378:	00144583          	lbu	a1,1(s0)
            *buf ++ = '\0';
ffffffffc020037c:	00040023          	sb	zero,0(s0)
ffffffffc0200380:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200382:	d5c9                	beqz	a1,ffffffffc020030c <kmonitor+0x7c>
ffffffffc0200384:	b7f5                	j	ffffffffc0200370 <kmonitor+0xe0>
        if (*buf == '\0') {
ffffffffc0200386:	00044783          	lbu	a5,0(s0)
ffffffffc020038a:	d3c9                	beqz	a5,ffffffffc020030c <kmonitor+0x7c>
        if (argc == MAXARGS - 1) {
ffffffffc020038c:	033c8963          	beq	s9,s3,ffffffffc02003be <kmonitor+0x12e>
        argv[argc ++] = buf;
ffffffffc0200390:	003c9793          	slli	a5,s9,0x3
ffffffffc0200394:	0118                	addi	a4,sp,128
ffffffffc0200396:	97ba                	add	a5,a5,a4
ffffffffc0200398:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc020039c:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc02003a0:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003a2:	e591                	bnez	a1,ffffffffc02003ae <kmonitor+0x11e>
ffffffffc02003a4:	b7b5                	j	ffffffffc0200310 <kmonitor+0x80>
ffffffffc02003a6:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc02003aa:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003ac:	d1a5                	beqz	a1,ffffffffc020030c <kmonitor+0x7c>
ffffffffc02003ae:	8526                	mv	a0,s1
ffffffffc02003b0:	3d5010ef          	jal	ra,ffffffffc0201f84 <strchr>
ffffffffc02003b4:	d96d                	beqz	a0,ffffffffc02003a6 <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003b6:	00044583          	lbu	a1,0(s0)
ffffffffc02003ba:	d9a9                	beqz	a1,ffffffffc020030c <kmonitor+0x7c>
ffffffffc02003bc:	bf55                	j	ffffffffc0200370 <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02003be:	45c1                	li	a1,16
ffffffffc02003c0:	855a                	mv	a0,s6
ffffffffc02003c2:	d1dff0ef          	jal	ra,ffffffffc02000de <cprintf>
ffffffffc02003c6:	b7e9                	j	ffffffffc0200390 <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc02003c8:	6582                	ld	a1,0(sp)
ffffffffc02003ca:	00002517          	auipc	a0,0x2
ffffffffc02003ce:	e2650513          	addi	a0,a0,-474 # ffffffffc02021f0 <etext+0x244>
ffffffffc02003d2:	d0dff0ef          	jal	ra,ffffffffc02000de <cprintf>
    return 0;
ffffffffc02003d6:	b715                	j	ffffffffc02002fa <kmonitor+0x6a>

ffffffffc02003d8 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc02003d8:	00007317          	auipc	t1,0x7
ffffffffc02003dc:	06830313          	addi	t1,t1,104 # ffffffffc0207440 <is_panic>
ffffffffc02003e0:	00032e03          	lw	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc02003e4:	715d                	addi	sp,sp,-80
ffffffffc02003e6:	ec06                	sd	ra,24(sp)
ffffffffc02003e8:	e822                	sd	s0,16(sp)
ffffffffc02003ea:	f436                	sd	a3,40(sp)
ffffffffc02003ec:	f83a                	sd	a4,48(sp)
ffffffffc02003ee:	fc3e                	sd	a5,56(sp)
ffffffffc02003f0:	e0c2                	sd	a6,64(sp)
ffffffffc02003f2:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc02003f4:	020e1a63          	bnez	t3,ffffffffc0200428 <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc02003f8:	4785                	li	a5,1
ffffffffc02003fa:	00f32023          	sw	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc02003fe:	8432                	mv	s0,a2
ffffffffc0200400:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200402:	862e                	mv	a2,a1
ffffffffc0200404:	85aa                	mv	a1,a0
ffffffffc0200406:	00002517          	auipc	a0,0x2
ffffffffc020040a:	e4a50513          	addi	a0,a0,-438 # ffffffffc0202250 <commands+0x48>
    va_start(ap, fmt);
ffffffffc020040e:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200410:	ccfff0ef          	jal	ra,ffffffffc02000de <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200414:	65a2                	ld	a1,8(sp)
ffffffffc0200416:	8522                	mv	a0,s0
ffffffffc0200418:	ca7ff0ef          	jal	ra,ffffffffc02000be <vcprintf>
    cprintf("\n");
ffffffffc020041c:	00002517          	auipc	a0,0x2
ffffffffc0200420:	c7c50513          	addi	a0,a0,-900 # ffffffffc0202098 <etext+0xec>
ffffffffc0200424:	cbbff0ef          	jal	ra,ffffffffc02000de <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
ffffffffc0200428:	412000ef          	jal	ra,ffffffffc020083a <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc020042c:	4501                	li	a0,0
ffffffffc020042e:	e63ff0ef          	jal	ra,ffffffffc0200290 <kmonitor>
    while (1) {
ffffffffc0200432:	bfed                	j	ffffffffc020042c <__panic+0x54>

ffffffffc0200434 <clock_init>:

/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
ffffffffc0200434:	1141                	addi	sp,sp,-16
ffffffffc0200436:	e406                	sd	ra,8(sp)
    // enable timer interrupt in sie
    set_csr(sie, MIP_STIP);
ffffffffc0200438:	02000793          	li	a5,32
ffffffffc020043c:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200440:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200444:	67e1                	lui	a5,0x18
ffffffffc0200446:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc020044a:	953e                	add	a0,a0,a5
ffffffffc020044c:	26f010ef          	jal	ra,ffffffffc0201eba <sbi_set_timer>
}
ffffffffc0200450:	60a2                	ld	ra,8(sp)
    ticks = 0;
ffffffffc0200452:	00007797          	auipc	a5,0x7
ffffffffc0200456:	fe07bb23          	sd	zero,-10(a5) # ffffffffc0207448 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc020045a:	00002517          	auipc	a0,0x2
ffffffffc020045e:	e1650513          	addi	a0,a0,-490 # ffffffffc0202270 <commands+0x68>
}
ffffffffc0200462:	0141                	addi	sp,sp,16
    cprintf("++ setup timer interrupts\n");
ffffffffc0200464:	b9ad                	j	ffffffffc02000de <cprintf>

ffffffffc0200466 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200466:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020046a:	67e1                	lui	a5,0x18
ffffffffc020046c:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc0200470:	953e                	add	a0,a0,a5
ffffffffc0200472:	2490106f          	j	ffffffffc0201eba <sbi_set_timer>

ffffffffc0200476 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc0200476:	8082                	ret

ffffffffc0200478 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) { sbi_console_putchar((unsigned char)c); }
ffffffffc0200478:	0ff57513          	zext.b	a0,a0
ffffffffc020047c:	2250106f          	j	ffffffffc0201ea0 <sbi_console_putchar>

ffffffffc0200480 <cons_getc>:
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int cons_getc(void) {
    int c = 0;
    c = sbi_console_getchar();
ffffffffc0200480:	2550106f          	j	ffffffffc0201ed4 <sbi_console_getchar>

ffffffffc0200484 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc0200484:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200486:	00002517          	auipc	a0,0x2
ffffffffc020048a:	e0a50513          	addi	a0,a0,-502 # ffffffffc0202290 <commands+0x88>
void dtb_init(void) {
ffffffffc020048e:	fc86                	sd	ra,120(sp)
ffffffffc0200490:	f8a2                	sd	s0,112(sp)
ffffffffc0200492:	e8d2                	sd	s4,80(sp)
ffffffffc0200494:	f4a6                	sd	s1,104(sp)
ffffffffc0200496:	f0ca                	sd	s2,96(sp)
ffffffffc0200498:	ecce                	sd	s3,88(sp)
ffffffffc020049a:	e4d6                	sd	s5,72(sp)
ffffffffc020049c:	e0da                	sd	s6,64(sp)
ffffffffc020049e:	fc5e                	sd	s7,56(sp)
ffffffffc02004a0:	f862                	sd	s8,48(sp)
ffffffffc02004a2:	f466                	sd	s9,40(sp)
ffffffffc02004a4:	f06a                	sd	s10,32(sp)
ffffffffc02004a6:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc02004a8:	c37ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc02004ac:	00007597          	auipc	a1,0x7
ffffffffc02004b0:	b545b583          	ld	a1,-1196(a1) # ffffffffc0207000 <boot_hartid>
ffffffffc02004b4:	00002517          	auipc	a0,0x2
ffffffffc02004b8:	dec50513          	addi	a0,a0,-532 # ffffffffc02022a0 <commands+0x98>
ffffffffc02004bc:	c23ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc02004c0:	00007417          	auipc	s0,0x7
ffffffffc02004c4:	b4840413          	addi	s0,s0,-1208 # ffffffffc0207008 <boot_dtb>
ffffffffc02004c8:	600c                	ld	a1,0(s0)
ffffffffc02004ca:	00002517          	auipc	a0,0x2
ffffffffc02004ce:	de650513          	addi	a0,a0,-538 # ffffffffc02022b0 <commands+0xa8>
ffffffffc02004d2:	c0dff0ef          	jal	ra,ffffffffc02000de <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc02004d6:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc02004da:	00002517          	auipc	a0,0x2
ffffffffc02004de:	dee50513          	addi	a0,a0,-530 # ffffffffc02022c8 <commands+0xc0>
    if (boot_dtb == 0) {
ffffffffc02004e2:	120a0463          	beqz	s4,ffffffffc020060a <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc02004e6:	57f5                	li	a5,-3
ffffffffc02004e8:	07fa                	slli	a5,a5,0x1e
ffffffffc02004ea:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc02004ee:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004f0:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004f4:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004f6:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02004fa:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004fe:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200502:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200506:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020050a:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020050c:	8ec9                	or	a3,a3,a0
ffffffffc020050e:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200512:	1b7d                	addi	s6,s6,-1
ffffffffc0200514:	0167f7b3          	and	a5,a5,s6
ffffffffc0200518:	8dd5                	or	a1,a1,a3
ffffffffc020051a:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc020051c:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200520:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc0200522:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfed8a4d>
ffffffffc0200526:	10f59163          	bne	a1,a5,ffffffffc0200628 <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc020052a:	471c                	lw	a5,8(a4)
ffffffffc020052c:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc020052e:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200530:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200534:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200538:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020053c:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200540:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200544:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200548:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020054c:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200550:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200554:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200558:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020055a:	01146433          	or	s0,s0,a7
ffffffffc020055e:	0086969b          	slliw	a3,a3,0x8
ffffffffc0200562:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200566:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200568:	0087979b          	slliw	a5,a5,0x8
ffffffffc020056c:	8c49                	or	s0,s0,a0
ffffffffc020056e:	0166f6b3          	and	a3,a3,s6
ffffffffc0200572:	00ca6a33          	or	s4,s4,a2
ffffffffc0200576:	0167f7b3          	and	a5,a5,s6
ffffffffc020057a:	8c55                	or	s0,s0,a3
ffffffffc020057c:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200580:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200582:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200584:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200586:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc020058a:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc020058c:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020058e:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc0200592:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200594:	00002917          	auipc	s2,0x2
ffffffffc0200598:	d8490913          	addi	s2,s2,-636 # ffffffffc0202318 <commands+0x110>
ffffffffc020059c:	49bd                	li	s3,15
        switch (token) {
ffffffffc020059e:	4d91                	li	s11,4
ffffffffc02005a0:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02005a2:	00002497          	auipc	s1,0x2
ffffffffc02005a6:	d6e48493          	addi	s1,s1,-658 # ffffffffc0202310 <commands+0x108>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc02005aa:	000a2703          	lw	a4,0(s4)
ffffffffc02005ae:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005b2:	0087569b          	srliw	a3,a4,0x8
ffffffffc02005b6:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005ba:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005be:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005c2:	0107571b          	srliw	a4,a4,0x10
ffffffffc02005c6:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005c8:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005cc:	0087171b          	slliw	a4,a4,0x8
ffffffffc02005d0:	8fd5                	or	a5,a5,a3
ffffffffc02005d2:	00eb7733          	and	a4,s6,a4
ffffffffc02005d6:	8fd9                	or	a5,a5,a4
ffffffffc02005d8:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc02005da:	09778c63          	beq	a5,s7,ffffffffc0200672 <dtb_init+0x1ee>
ffffffffc02005de:	00fbea63          	bltu	s7,a5,ffffffffc02005f2 <dtb_init+0x16e>
ffffffffc02005e2:	07a78663          	beq	a5,s10,ffffffffc020064e <dtb_init+0x1ca>
ffffffffc02005e6:	4709                	li	a4,2
ffffffffc02005e8:	00e79763          	bne	a5,a4,ffffffffc02005f6 <dtb_init+0x172>
ffffffffc02005ec:	4c81                	li	s9,0
ffffffffc02005ee:	8a56                	mv	s4,s5
ffffffffc02005f0:	bf6d                	j	ffffffffc02005aa <dtb_init+0x126>
ffffffffc02005f2:	ffb78ee3          	beq	a5,s11,ffffffffc02005ee <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc02005f6:	00002517          	auipc	a0,0x2
ffffffffc02005fa:	d9a50513          	addi	a0,a0,-614 # ffffffffc0202390 <commands+0x188>
ffffffffc02005fe:	ae1ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc0200602:	00002517          	auipc	a0,0x2
ffffffffc0200606:	dc650513          	addi	a0,a0,-570 # ffffffffc02023c8 <commands+0x1c0>
}
ffffffffc020060a:	7446                	ld	s0,112(sp)
ffffffffc020060c:	70e6                	ld	ra,120(sp)
ffffffffc020060e:	74a6                	ld	s1,104(sp)
ffffffffc0200610:	7906                	ld	s2,96(sp)
ffffffffc0200612:	69e6                	ld	s3,88(sp)
ffffffffc0200614:	6a46                	ld	s4,80(sp)
ffffffffc0200616:	6aa6                	ld	s5,72(sp)
ffffffffc0200618:	6b06                	ld	s6,64(sp)
ffffffffc020061a:	7be2                	ld	s7,56(sp)
ffffffffc020061c:	7c42                	ld	s8,48(sp)
ffffffffc020061e:	7ca2                	ld	s9,40(sp)
ffffffffc0200620:	7d02                	ld	s10,32(sp)
ffffffffc0200622:	6de2                	ld	s11,24(sp)
ffffffffc0200624:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc0200626:	bc65                	j	ffffffffc02000de <cprintf>
}
ffffffffc0200628:	7446                	ld	s0,112(sp)
ffffffffc020062a:	70e6                	ld	ra,120(sp)
ffffffffc020062c:	74a6                	ld	s1,104(sp)
ffffffffc020062e:	7906                	ld	s2,96(sp)
ffffffffc0200630:	69e6                	ld	s3,88(sp)
ffffffffc0200632:	6a46                	ld	s4,80(sp)
ffffffffc0200634:	6aa6                	ld	s5,72(sp)
ffffffffc0200636:	6b06                	ld	s6,64(sp)
ffffffffc0200638:	7be2                	ld	s7,56(sp)
ffffffffc020063a:	7c42                	ld	s8,48(sp)
ffffffffc020063c:	7ca2                	ld	s9,40(sp)
ffffffffc020063e:	7d02                	ld	s10,32(sp)
ffffffffc0200640:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc0200642:	00002517          	auipc	a0,0x2
ffffffffc0200646:	ca650513          	addi	a0,a0,-858 # ffffffffc02022e8 <commands+0xe0>
}
ffffffffc020064a:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc020064c:	bc49                	j	ffffffffc02000de <cprintf>
                int name_len = strlen(name);
ffffffffc020064e:	8556                	mv	a0,s5
ffffffffc0200650:	0bb010ef          	jal	ra,ffffffffc0201f0a <strlen>
ffffffffc0200654:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200656:	4619                	li	a2,6
ffffffffc0200658:	85a6                	mv	a1,s1
ffffffffc020065a:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc020065c:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020065e:	101010ef          	jal	ra,ffffffffc0201f5e <strncmp>
ffffffffc0200662:	e111                	bnez	a0,ffffffffc0200666 <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc0200664:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc0200666:	0a91                	addi	s5,s5,4
ffffffffc0200668:	9ad2                	add	s5,s5,s4
ffffffffc020066a:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc020066e:	8a56                	mv	s4,s5
ffffffffc0200670:	bf2d                	j	ffffffffc02005aa <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200672:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200676:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020067a:	0087d71b          	srliw	a4,a5,0x8
ffffffffc020067e:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200682:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200686:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020068a:	0107d79b          	srliw	a5,a5,0x10
ffffffffc020068e:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200692:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200696:	0087979b          	slliw	a5,a5,0x8
ffffffffc020069a:	00eaeab3          	or	s5,s5,a4
ffffffffc020069e:	00fb77b3          	and	a5,s6,a5
ffffffffc02006a2:	00faeab3          	or	s5,s5,a5
ffffffffc02006a6:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006a8:	000c9c63          	bnez	s9,ffffffffc02006c0 <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc02006ac:	1a82                	slli	s5,s5,0x20
ffffffffc02006ae:	00368793          	addi	a5,a3,3
ffffffffc02006b2:	020ada93          	srli	s5,s5,0x20
ffffffffc02006b6:	9abe                	add	s5,s5,a5
ffffffffc02006b8:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02006bc:	8a56                	mv	s4,s5
ffffffffc02006be:	b5f5                	j	ffffffffc02005aa <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02006c0:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006c4:	85ca                	mv	a1,s2
ffffffffc02006c6:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006c8:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006cc:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006d0:	0187971b          	slliw	a4,a5,0x18
ffffffffc02006d4:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006d8:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02006dc:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006de:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006e2:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006e6:	8d59                	or	a0,a0,a4
ffffffffc02006e8:	00fb77b3          	and	a5,s6,a5
ffffffffc02006ec:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc02006ee:	1502                	slli	a0,a0,0x20
ffffffffc02006f0:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006f2:	9522                	add	a0,a0,s0
ffffffffc02006f4:	04d010ef          	jal	ra,ffffffffc0201f40 <strcmp>
ffffffffc02006f8:	66a2                	ld	a3,8(sp)
ffffffffc02006fa:	f94d                	bnez	a0,ffffffffc02006ac <dtb_init+0x228>
ffffffffc02006fc:	fb59f8e3          	bgeu	s3,s5,ffffffffc02006ac <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc0200700:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc0200704:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200708:	00002517          	auipc	a0,0x2
ffffffffc020070c:	c1850513          	addi	a0,a0,-1000 # ffffffffc0202320 <commands+0x118>
           fdt32_to_cpu(x >> 32);
ffffffffc0200710:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200714:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc0200718:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020071c:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200720:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200724:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200728:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020072c:	0187d693          	srli	a3,a5,0x18
ffffffffc0200730:	01861f1b          	slliw	t5,a2,0x18
ffffffffc0200734:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200738:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020073c:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200740:	010f6f33          	or	t5,t5,a6
ffffffffc0200744:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200748:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020074c:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200750:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200754:	0186f6b3          	and	a3,a3,s8
ffffffffc0200758:	01859e1b          	slliw	t3,a1,0x18
ffffffffc020075c:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200760:	0107581b          	srliw	a6,a4,0x10
ffffffffc0200764:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200768:	8361                	srli	a4,a4,0x18
ffffffffc020076a:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020076e:	0105d59b          	srliw	a1,a1,0x10
ffffffffc0200772:	01e6e6b3          	or	a3,a3,t5
ffffffffc0200776:	00cb7633          	and	a2,s6,a2
ffffffffc020077a:	0088181b          	slliw	a6,a6,0x8
ffffffffc020077e:	0085959b          	slliw	a1,a1,0x8
ffffffffc0200782:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200786:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020078a:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020078e:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200792:	0088989b          	slliw	a7,a7,0x8
ffffffffc0200796:	011b78b3          	and	a7,s6,a7
ffffffffc020079a:	005eeeb3          	or	t4,t4,t0
ffffffffc020079e:	00c6e733          	or	a4,a3,a2
ffffffffc02007a2:	006c6c33          	or	s8,s8,t1
ffffffffc02007a6:	010b76b3          	and	a3,s6,a6
ffffffffc02007aa:	00bb7b33          	and	s6,s6,a1
ffffffffc02007ae:	01d7e7b3          	or	a5,a5,t4
ffffffffc02007b2:	016c6b33          	or	s6,s8,s6
ffffffffc02007b6:	01146433          	or	s0,s0,a7
ffffffffc02007ba:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc02007bc:	1702                	slli	a4,a4,0x20
ffffffffc02007be:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007c0:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc02007c2:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007c4:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc02007c6:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007ca:	0167eb33          	or	s6,a5,s6
ffffffffc02007ce:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc02007d0:	90fff0ef          	jal	ra,ffffffffc02000de <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc02007d4:	85a2                	mv	a1,s0
ffffffffc02007d6:	00002517          	auipc	a0,0x2
ffffffffc02007da:	b6a50513          	addi	a0,a0,-1174 # ffffffffc0202340 <commands+0x138>
ffffffffc02007de:	901ff0ef          	jal	ra,ffffffffc02000de <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc02007e2:	014b5613          	srli	a2,s6,0x14
ffffffffc02007e6:	85da                	mv	a1,s6
ffffffffc02007e8:	00002517          	auipc	a0,0x2
ffffffffc02007ec:	b7050513          	addi	a0,a0,-1168 # ffffffffc0202358 <commands+0x150>
ffffffffc02007f0:	8efff0ef          	jal	ra,ffffffffc02000de <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc02007f4:	008b05b3          	add	a1,s6,s0
ffffffffc02007f8:	15fd                	addi	a1,a1,-1
ffffffffc02007fa:	00002517          	auipc	a0,0x2
ffffffffc02007fe:	b7e50513          	addi	a0,a0,-1154 # ffffffffc0202378 <commands+0x170>
ffffffffc0200802:	8ddff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("DTB init completed\n");
ffffffffc0200806:	00002517          	auipc	a0,0x2
ffffffffc020080a:	bc250513          	addi	a0,a0,-1086 # ffffffffc02023c8 <commands+0x1c0>
        memory_base = mem_base;
ffffffffc020080e:	00007797          	auipc	a5,0x7
ffffffffc0200812:	c487b123          	sd	s0,-958(a5) # ffffffffc0207450 <memory_base>
        memory_size = mem_size;
ffffffffc0200816:	00007797          	auipc	a5,0x7
ffffffffc020081a:	c567b123          	sd	s6,-958(a5) # ffffffffc0207458 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc020081e:	b3f5                	j	ffffffffc020060a <dtb_init+0x186>

ffffffffc0200820 <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc0200820:	00007517          	auipc	a0,0x7
ffffffffc0200824:	c3053503          	ld	a0,-976(a0) # ffffffffc0207450 <memory_base>
ffffffffc0200828:	8082                	ret

ffffffffc020082a <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc020082a:	00007517          	auipc	a0,0x7
ffffffffc020082e:	c2e53503          	ld	a0,-978(a0) # ffffffffc0207458 <memory_size>
ffffffffc0200832:	8082                	ret

ffffffffc0200834 <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc0200834:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200838:	8082                	ret

ffffffffc020083a <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc020083a:	100177f3          	csrrci	a5,sstatus,2
ffffffffc020083e:	8082                	ret

ffffffffc0200840 <idt_init>:
       that we are presently executing in the kernel */
    //约定：若中断前处于S态，sscratch为0
    //若中断前处于U态，sscratch存储内核栈地址
    //那么之后就可以通过sscratch的数值判断是内核态产生的中断还是用户态产生的中断
    //我们现在是内核态所以给sscratch置零
    write_csr(sscratch, 0);
ffffffffc0200840:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc0200844:	00000797          	auipc	a5,0x0
ffffffffc0200848:	39478793          	addi	a5,a5,916 # ffffffffc0200bd8 <__alltraps>
ffffffffc020084c:	10579073          	csrw	stvec,a5
}
ffffffffc0200850:	8082                	ret

ffffffffc0200852 <print_regs>:
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200852:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs *gpr) {
ffffffffc0200854:	1141                	addi	sp,sp,-16
ffffffffc0200856:	e022                	sd	s0,0(sp)
ffffffffc0200858:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc020085a:	00002517          	auipc	a0,0x2
ffffffffc020085e:	b8650513          	addi	a0,a0,-1146 # ffffffffc02023e0 <commands+0x1d8>
void print_regs(struct pushregs *gpr) {
ffffffffc0200862:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200864:	87bff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc0200868:	640c                	ld	a1,8(s0)
ffffffffc020086a:	00002517          	auipc	a0,0x2
ffffffffc020086e:	b8e50513          	addi	a0,a0,-1138 # ffffffffc02023f8 <commands+0x1f0>
ffffffffc0200872:	86dff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc0200876:	680c                	ld	a1,16(s0)
ffffffffc0200878:	00002517          	auipc	a0,0x2
ffffffffc020087c:	b9850513          	addi	a0,a0,-1128 # ffffffffc0202410 <commands+0x208>
ffffffffc0200880:	85fff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200884:	6c0c                	ld	a1,24(s0)
ffffffffc0200886:	00002517          	auipc	a0,0x2
ffffffffc020088a:	ba250513          	addi	a0,a0,-1118 # ffffffffc0202428 <commands+0x220>
ffffffffc020088e:	851ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200892:	700c                	ld	a1,32(s0)
ffffffffc0200894:	00002517          	auipc	a0,0x2
ffffffffc0200898:	bac50513          	addi	a0,a0,-1108 # ffffffffc0202440 <commands+0x238>
ffffffffc020089c:	843ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc02008a0:	740c                	ld	a1,40(s0)
ffffffffc02008a2:	00002517          	auipc	a0,0x2
ffffffffc02008a6:	bb650513          	addi	a0,a0,-1098 # ffffffffc0202458 <commands+0x250>
ffffffffc02008aa:	835ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc02008ae:	780c                	ld	a1,48(s0)
ffffffffc02008b0:	00002517          	auipc	a0,0x2
ffffffffc02008b4:	bc050513          	addi	a0,a0,-1088 # ffffffffc0202470 <commands+0x268>
ffffffffc02008b8:	827ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc02008bc:	7c0c                	ld	a1,56(s0)
ffffffffc02008be:	00002517          	auipc	a0,0x2
ffffffffc02008c2:	bca50513          	addi	a0,a0,-1078 # ffffffffc0202488 <commands+0x280>
ffffffffc02008c6:	819ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc02008ca:	602c                	ld	a1,64(s0)
ffffffffc02008cc:	00002517          	auipc	a0,0x2
ffffffffc02008d0:	bd450513          	addi	a0,a0,-1068 # ffffffffc02024a0 <commands+0x298>
ffffffffc02008d4:	80bff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc02008d8:	642c                	ld	a1,72(s0)
ffffffffc02008da:	00002517          	auipc	a0,0x2
ffffffffc02008de:	bde50513          	addi	a0,a0,-1058 # ffffffffc02024b8 <commands+0x2b0>
ffffffffc02008e2:	ffcff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc02008e6:	682c                	ld	a1,80(s0)
ffffffffc02008e8:	00002517          	auipc	a0,0x2
ffffffffc02008ec:	be850513          	addi	a0,a0,-1048 # ffffffffc02024d0 <commands+0x2c8>
ffffffffc02008f0:	feeff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc02008f4:	6c2c                	ld	a1,88(s0)
ffffffffc02008f6:	00002517          	auipc	a0,0x2
ffffffffc02008fa:	bf250513          	addi	a0,a0,-1038 # ffffffffc02024e8 <commands+0x2e0>
ffffffffc02008fe:	fe0ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200902:	702c                	ld	a1,96(s0)
ffffffffc0200904:	00002517          	auipc	a0,0x2
ffffffffc0200908:	bfc50513          	addi	a0,a0,-1028 # ffffffffc0202500 <commands+0x2f8>
ffffffffc020090c:	fd2ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200910:	742c                	ld	a1,104(s0)
ffffffffc0200912:	00002517          	auipc	a0,0x2
ffffffffc0200916:	c0650513          	addi	a0,a0,-1018 # ffffffffc0202518 <commands+0x310>
ffffffffc020091a:	fc4ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc020091e:	782c                	ld	a1,112(s0)
ffffffffc0200920:	00002517          	auipc	a0,0x2
ffffffffc0200924:	c1050513          	addi	a0,a0,-1008 # ffffffffc0202530 <commands+0x328>
ffffffffc0200928:	fb6ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc020092c:	7c2c                	ld	a1,120(s0)
ffffffffc020092e:	00002517          	auipc	a0,0x2
ffffffffc0200932:	c1a50513          	addi	a0,a0,-998 # ffffffffc0202548 <commands+0x340>
ffffffffc0200936:	fa8ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc020093a:	604c                	ld	a1,128(s0)
ffffffffc020093c:	00002517          	auipc	a0,0x2
ffffffffc0200940:	c2450513          	addi	a0,a0,-988 # ffffffffc0202560 <commands+0x358>
ffffffffc0200944:	f9aff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200948:	644c                	ld	a1,136(s0)
ffffffffc020094a:	00002517          	auipc	a0,0x2
ffffffffc020094e:	c2e50513          	addi	a0,a0,-978 # ffffffffc0202578 <commands+0x370>
ffffffffc0200952:	f8cff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200956:	684c                	ld	a1,144(s0)
ffffffffc0200958:	00002517          	auipc	a0,0x2
ffffffffc020095c:	c3850513          	addi	a0,a0,-968 # ffffffffc0202590 <commands+0x388>
ffffffffc0200960:	f7eff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200964:	6c4c                	ld	a1,152(s0)
ffffffffc0200966:	00002517          	auipc	a0,0x2
ffffffffc020096a:	c4250513          	addi	a0,a0,-958 # ffffffffc02025a8 <commands+0x3a0>
ffffffffc020096e:	f70ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200972:	704c                	ld	a1,160(s0)
ffffffffc0200974:	00002517          	auipc	a0,0x2
ffffffffc0200978:	c4c50513          	addi	a0,a0,-948 # ffffffffc02025c0 <commands+0x3b8>
ffffffffc020097c:	f62ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200980:	744c                	ld	a1,168(s0)
ffffffffc0200982:	00002517          	auipc	a0,0x2
ffffffffc0200986:	c5650513          	addi	a0,a0,-938 # ffffffffc02025d8 <commands+0x3d0>
ffffffffc020098a:	f54ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc020098e:	784c                	ld	a1,176(s0)
ffffffffc0200990:	00002517          	auipc	a0,0x2
ffffffffc0200994:	c6050513          	addi	a0,a0,-928 # ffffffffc02025f0 <commands+0x3e8>
ffffffffc0200998:	f46ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc020099c:	7c4c                	ld	a1,184(s0)
ffffffffc020099e:	00002517          	auipc	a0,0x2
ffffffffc02009a2:	c6a50513          	addi	a0,a0,-918 # ffffffffc0202608 <commands+0x400>
ffffffffc02009a6:	f38ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc02009aa:	606c                	ld	a1,192(s0)
ffffffffc02009ac:	00002517          	auipc	a0,0x2
ffffffffc02009b0:	c7450513          	addi	a0,a0,-908 # ffffffffc0202620 <commands+0x418>
ffffffffc02009b4:	f2aff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc02009b8:	646c                	ld	a1,200(s0)
ffffffffc02009ba:	00002517          	auipc	a0,0x2
ffffffffc02009be:	c7e50513          	addi	a0,a0,-898 # ffffffffc0202638 <commands+0x430>
ffffffffc02009c2:	f1cff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc02009c6:	686c                	ld	a1,208(s0)
ffffffffc02009c8:	00002517          	auipc	a0,0x2
ffffffffc02009cc:	c8850513          	addi	a0,a0,-888 # ffffffffc0202650 <commands+0x448>
ffffffffc02009d0:	f0eff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc02009d4:	6c6c                	ld	a1,216(s0)
ffffffffc02009d6:	00002517          	auipc	a0,0x2
ffffffffc02009da:	c9250513          	addi	a0,a0,-878 # ffffffffc0202668 <commands+0x460>
ffffffffc02009de:	f00ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc02009e2:	706c                	ld	a1,224(s0)
ffffffffc02009e4:	00002517          	auipc	a0,0x2
ffffffffc02009e8:	c9c50513          	addi	a0,a0,-868 # ffffffffc0202680 <commands+0x478>
ffffffffc02009ec:	ef2ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc02009f0:	746c                	ld	a1,232(s0)
ffffffffc02009f2:	00002517          	auipc	a0,0x2
ffffffffc02009f6:	ca650513          	addi	a0,a0,-858 # ffffffffc0202698 <commands+0x490>
ffffffffc02009fa:	ee4ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc02009fe:	786c                	ld	a1,240(s0)
ffffffffc0200a00:	00002517          	auipc	a0,0x2
ffffffffc0200a04:	cb050513          	addi	a0,a0,-848 # ffffffffc02026b0 <commands+0x4a8>
ffffffffc0200a08:	ed6ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a0c:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200a0e:	6402                	ld	s0,0(sp)
ffffffffc0200a10:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a12:	00002517          	auipc	a0,0x2
ffffffffc0200a16:	cb650513          	addi	a0,a0,-842 # ffffffffc02026c8 <commands+0x4c0>
}
ffffffffc0200a1a:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a1c:	ec2ff06f          	j	ffffffffc02000de <cprintf>

ffffffffc0200a20 <print_trapframe>:
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a20:	1141                	addi	sp,sp,-16
ffffffffc0200a22:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a24:	85aa                	mv	a1,a0
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a26:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a28:	00002517          	auipc	a0,0x2
ffffffffc0200a2c:	cb850513          	addi	a0,a0,-840 # ffffffffc02026e0 <commands+0x4d8>
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a30:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a32:	eacff0ef          	jal	ra,ffffffffc02000de <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200a36:	8522                	mv	a0,s0
ffffffffc0200a38:	e1bff0ef          	jal	ra,ffffffffc0200852 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200a3c:	10043583          	ld	a1,256(s0)
ffffffffc0200a40:	00002517          	auipc	a0,0x2
ffffffffc0200a44:	cb850513          	addi	a0,a0,-840 # ffffffffc02026f8 <commands+0x4f0>
ffffffffc0200a48:	e96ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200a4c:	10843583          	ld	a1,264(s0)
ffffffffc0200a50:	00002517          	auipc	a0,0x2
ffffffffc0200a54:	cc050513          	addi	a0,a0,-832 # ffffffffc0202710 <commands+0x508>
ffffffffc0200a58:	e86ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
ffffffffc0200a5c:	11043583          	ld	a1,272(s0)
ffffffffc0200a60:	00002517          	auipc	a0,0x2
ffffffffc0200a64:	cc850513          	addi	a0,a0,-824 # ffffffffc0202728 <commands+0x520>
ffffffffc0200a68:	e76ff0ef          	jal	ra,ffffffffc02000de <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200a6c:	11843583          	ld	a1,280(s0)
}
ffffffffc0200a70:	6402                	ld	s0,0(sp)
ffffffffc0200a72:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200a74:	00002517          	auipc	a0,0x2
ffffffffc0200a78:	ccc50513          	addi	a0,a0,-820 # ffffffffc0202740 <commands+0x538>
}
ffffffffc0200a7c:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200a7e:	e60ff06f          	j	ffffffffc02000de <cprintf>

ffffffffc0200a82 <interrupt_handler>:

void interrupt_handler(struct trapframe *tf) {
    intptr_t cause = (tf->cause << 1) >> 1;//抹掉scause最高位代表“这是中断不是异常”的1
ffffffffc0200a82:	11853783          	ld	a5,280(a0)
ffffffffc0200a86:	472d                	li	a4,11
ffffffffc0200a88:	0786                	slli	a5,a5,0x1
ffffffffc0200a8a:	8385                	srli	a5,a5,0x1
ffffffffc0200a8c:	08f76363          	bltu	a4,a5,ffffffffc0200b12 <interrupt_handler+0x90>
ffffffffc0200a90:	00002717          	auipc	a4,0x2
ffffffffc0200a94:	d9070713          	addi	a4,a4,-624 # ffffffffc0202820 <commands+0x618>
ffffffffc0200a98:	078a                	slli	a5,a5,0x2
ffffffffc0200a9a:	97ba                	add	a5,a5,a4
ffffffffc0200a9c:	439c                	lw	a5,0(a5)
ffffffffc0200a9e:	97ba                	add	a5,a5,a4
ffffffffc0200aa0:	8782                	jr	a5
            break;
        case IRQ_H_SOFT:
            cprintf("Hypervisor software interrupt\n");//来自虚拟机态的软中断
            break;
        case IRQ_M_SOFT:
            cprintf("Machine software interrupt\n");//来自机器态的软中断
ffffffffc0200aa2:	00002517          	auipc	a0,0x2
ffffffffc0200aa6:	d1650513          	addi	a0,a0,-746 # ffffffffc02027b8 <commands+0x5b0>
ffffffffc0200aaa:	e34ff06f          	j	ffffffffc02000de <cprintf>
            cprintf("Hypervisor software interrupt\n");//来自虚拟机态的软中断
ffffffffc0200aae:	00002517          	auipc	a0,0x2
ffffffffc0200ab2:	cea50513          	addi	a0,a0,-790 # ffffffffc0202798 <commands+0x590>
ffffffffc0200ab6:	e28ff06f          	j	ffffffffc02000de <cprintf>
            cprintf("User software interrupt\n");//来自用户态的软中断
ffffffffc0200aba:	00002517          	auipc	a0,0x2
ffffffffc0200abe:	c9e50513          	addi	a0,a0,-866 # ffffffffc0202758 <commands+0x550>
ffffffffc0200ac2:	e1cff06f          	j	ffffffffc02000de <cprintf>
            break;
        case IRQ_U_TIMER:
            cprintf("User Timer interrupt\n");//来自用户态的定时器中断
ffffffffc0200ac6:	00002517          	auipc	a0,0x2
ffffffffc0200aca:	d1250513          	addi	a0,a0,-750 # ffffffffc02027d8 <commands+0x5d0>
ffffffffc0200ace:	e10ff06f          	j	ffffffffc02000de <cprintf>
void interrupt_handler(struct trapframe *tf) {
ffffffffc0200ad2:	1141                	addi	sp,sp,-16
ffffffffc0200ad4:	e406                	sd	ra,8(sp)
            /*(1)设置下次时钟中断- clock_set_next_event()
             *(2)计数器（ticks）加一
             *(3)当计数器加到100的时候，我们会输出一个`100ticks`表示我们触发了100次时钟中断，同时打印次数（num）加一
            * (4)判断打印次数，当打印次数为10时，调用<sbi.h>中的关机函数关机
            */
           clock_set_next_event();
ffffffffc0200ad6:	991ff0ef          	jal	ra,ffffffffc0200466 <clock_set_next_event>
           ticks++;
ffffffffc0200ada:	00007797          	auipc	a5,0x7
ffffffffc0200ade:	96e78793          	addi	a5,a5,-1682 # ffffffffc0207448 <ticks>
ffffffffc0200ae2:	6398                	ld	a4,0(a5)
ffffffffc0200ae4:	0705                	addi	a4,a4,1
ffffffffc0200ae6:	e398                	sd	a4,0(a5)
           if(ticks % TICK_NUM == 0){
ffffffffc0200ae8:	639c                	ld	a5,0(a5)
ffffffffc0200aea:	06400713          	li	a4,100
ffffffffc0200aee:	02e7f7b3          	remu	a5,a5,a4
ffffffffc0200af2:	c38d                	beqz	a5,ffffffffc0200b14 <interrupt_handler+0x92>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200af4:	60a2                	ld	ra,8(sp)
ffffffffc0200af6:	0141                	addi	sp,sp,16
ffffffffc0200af8:	8082                	ret
            cprintf("Supervisor external interrupt\n");//来自内核态的外部中断
ffffffffc0200afa:	00002517          	auipc	a0,0x2
ffffffffc0200afe:	d0650513          	addi	a0,a0,-762 # ffffffffc0202800 <commands+0x5f8>
ffffffffc0200b02:	ddcff06f          	j	ffffffffc02000de <cprintf>
            cprintf("Supervisor software interrupt\n");//来自内核态的软中断
ffffffffc0200b06:	00002517          	auipc	a0,0x2
ffffffffc0200b0a:	c7250513          	addi	a0,a0,-910 # ffffffffc0202778 <commands+0x570>
ffffffffc0200b0e:	dd0ff06f          	j	ffffffffc02000de <cprintf>
            print_trapframe(tf);
ffffffffc0200b12:	b739                	j	ffffffffc0200a20 <print_trapframe>
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc0200b14:	06400593          	li	a1,100
ffffffffc0200b18:	00002517          	auipc	a0,0x2
ffffffffc0200b1c:	cd850513          	addi	a0,a0,-808 # ffffffffc02027f0 <commands+0x5e8>
ffffffffc0200b20:	dbeff0ef          	jal	ra,ffffffffc02000de <cprintf>
               num++;
ffffffffc0200b24:	00007797          	auipc	a5,0x7
ffffffffc0200b28:	93c78793          	addi	a5,a5,-1732 # ffffffffc0207460 <num>
ffffffffc0200b2c:	6398                	ld	a4,0(a5)
               if(num == 10){
ffffffffc0200b2e:	46a9                	li	a3,10
               num++;
ffffffffc0200b30:	0705                	addi	a4,a4,1
ffffffffc0200b32:	e398                	sd	a4,0(a5)
               if(num == 10){
ffffffffc0200b34:	639c                	ld	a5,0(a5)
ffffffffc0200b36:	fad79fe3          	bne	a5,a3,ffffffffc0200af4 <interrupt_handler+0x72>
}
ffffffffc0200b3a:	60a2                	ld	ra,8(sp)
ffffffffc0200b3c:	0141                	addi	sp,sp,16
                   sbi_shutdown();
ffffffffc0200b3e:	3b20106f          	j	ffffffffc0201ef0 <sbi_shutdown>

ffffffffc0200b42 <exception_handler>:

void exception_handler(struct trapframe *tf) {
    switch (tf->cause) {
ffffffffc0200b42:	11853783          	ld	a5,280(a0)
void exception_handler(struct trapframe *tf) {
ffffffffc0200b46:	1141                	addi	sp,sp,-16
ffffffffc0200b48:	e022                	sd	s0,0(sp)
ffffffffc0200b4a:	e406                	sd	ra,8(sp)
    switch (tf->cause) {
ffffffffc0200b4c:	470d                	li	a4,3
void exception_handler(struct trapframe *tf) {
ffffffffc0200b4e:	842a                	mv	s0,a0
    switch (tf->cause) {
ffffffffc0200b50:	04e78663          	beq	a5,a4,ffffffffc0200b9c <exception_handler+0x5a>
ffffffffc0200b54:	02f76c63          	bltu	a4,a5,ffffffffc0200b8c <exception_handler+0x4a>
ffffffffc0200b58:	4709                	li	a4,2
ffffffffc0200b5a:	02e79563          	bne	a5,a4,ffffffffc0200b84 <exception_handler+0x42>
             /* LAB3 CHALLENGE3   YOUR CODE :2312823  */
            /*(1)输出指令异常类型（ Illegal instruction）
             *(2)输出异常指令地址
             *(3)更新 tf->epc寄存器
            */
            cprintf("Exception type:Illegal instruction\n");
ffffffffc0200b5e:	00002517          	auipc	a0,0x2
ffffffffc0200b62:	cf250513          	addi	a0,a0,-782 # ffffffffc0202850 <commands+0x648>
ffffffffc0200b66:	d78ff0ef          	jal	ra,ffffffffc02000de <cprintf>
            cprintf("“Illegal instruction caught at 0x%08x\n", tf->epc);
ffffffffc0200b6a:	10843583          	ld	a1,264(s0)
ffffffffc0200b6e:	00002517          	auipc	a0,0x2
ffffffffc0200b72:	d0a50513          	addi	a0,a0,-758 # ffffffffc0202878 <commands+0x670>
ffffffffc0200b76:	d68ff0ef          	jal	ra,ffffffffc02000de <cprintf>
            tf->epc += 4;
ffffffffc0200b7a:	10843783          	ld	a5,264(s0)
ffffffffc0200b7e:	0791                	addi	a5,a5,4
ffffffffc0200b80:	10f43423          	sd	a5,264(s0)
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200b84:	60a2                	ld	ra,8(sp)
ffffffffc0200b86:	6402                	ld	s0,0(sp)
ffffffffc0200b88:	0141                	addi	sp,sp,16
ffffffffc0200b8a:	8082                	ret
    switch (tf->cause) {
ffffffffc0200b8c:	17f1                	addi	a5,a5,-4
ffffffffc0200b8e:	471d                	li	a4,7
ffffffffc0200b90:	fef77ae3          	bgeu	a4,a5,ffffffffc0200b84 <exception_handler+0x42>
}
ffffffffc0200b94:	6402                	ld	s0,0(sp)
ffffffffc0200b96:	60a2                	ld	ra,8(sp)
ffffffffc0200b98:	0141                	addi	sp,sp,16
            print_trapframe(tf);
ffffffffc0200b9a:	b559                	j	ffffffffc0200a20 <print_trapframe>
            cprintf("Exception type: breakpoint\n");
ffffffffc0200b9c:	00002517          	auipc	a0,0x2
ffffffffc0200ba0:	d0c50513          	addi	a0,a0,-756 # ffffffffc02028a8 <commands+0x6a0>
ffffffffc0200ba4:	d3aff0ef          	jal	ra,ffffffffc02000de <cprintf>
            cprintf("ebreak caught at 0x%08x\n", tf->epc);
ffffffffc0200ba8:	10843583          	ld	a1,264(s0)
ffffffffc0200bac:	00002517          	auipc	a0,0x2
ffffffffc0200bb0:	d1c50513          	addi	a0,a0,-740 # ffffffffc02028c8 <commands+0x6c0>
ffffffffc0200bb4:	d2aff0ef          	jal	ra,ffffffffc02000de <cprintf>
            tf->epc += 2;
ffffffffc0200bb8:	10843783          	ld	a5,264(s0)
}
ffffffffc0200bbc:	60a2                	ld	ra,8(sp)
            tf->epc += 2;
ffffffffc0200bbe:	0789                	addi	a5,a5,2
ffffffffc0200bc0:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200bc4:	6402                	ld	s0,0(sp)
ffffffffc0200bc6:	0141                	addi	sp,sp,16
ffffffffc0200bc8:	8082                	ret

ffffffffc0200bca <trap>:

static inline void trap_dispatch(struct trapframe *tf) {
    //scause的最高位是1，说明trap是由中断引起的
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200bca:	11853783          	ld	a5,280(a0)
ffffffffc0200bce:	0007c363          	bltz	a5,ffffffffc0200bd4 <trap+0xa>
        // interrupts
        interrupt_handler(tf);
    } else {
        // exceptions
        exception_handler(tf);
ffffffffc0200bd2:	bf85                	j	ffffffffc0200b42 <exception_handler>
        interrupt_handler(tf);
ffffffffc0200bd4:	b57d                	j	ffffffffc0200a82 <interrupt_handler>
	...

ffffffffc0200bd8 <__alltraps>:
    .endm

    .globl __alltraps
    .align(2)
__alltraps:
    SAVE_ALL
ffffffffc0200bd8:	14011073          	csrw	sscratch,sp
ffffffffc0200bdc:	712d                	addi	sp,sp,-288
ffffffffc0200bde:	e002                	sd	zero,0(sp)
ffffffffc0200be0:	e406                	sd	ra,8(sp)
ffffffffc0200be2:	ec0e                	sd	gp,24(sp)
ffffffffc0200be4:	f012                	sd	tp,32(sp)
ffffffffc0200be6:	f416                	sd	t0,40(sp)
ffffffffc0200be8:	f81a                	sd	t1,48(sp)
ffffffffc0200bea:	fc1e                	sd	t2,56(sp)
ffffffffc0200bec:	e0a2                	sd	s0,64(sp)
ffffffffc0200bee:	e4a6                	sd	s1,72(sp)
ffffffffc0200bf0:	e8aa                	sd	a0,80(sp)
ffffffffc0200bf2:	ecae                	sd	a1,88(sp)
ffffffffc0200bf4:	f0b2                	sd	a2,96(sp)
ffffffffc0200bf6:	f4b6                	sd	a3,104(sp)
ffffffffc0200bf8:	f8ba                	sd	a4,112(sp)
ffffffffc0200bfa:	fcbe                	sd	a5,120(sp)
ffffffffc0200bfc:	e142                	sd	a6,128(sp)
ffffffffc0200bfe:	e546                	sd	a7,136(sp)
ffffffffc0200c00:	e94a                	sd	s2,144(sp)
ffffffffc0200c02:	ed4e                	sd	s3,152(sp)
ffffffffc0200c04:	f152                	sd	s4,160(sp)
ffffffffc0200c06:	f556                	sd	s5,168(sp)
ffffffffc0200c08:	f95a                	sd	s6,176(sp)
ffffffffc0200c0a:	fd5e                	sd	s7,184(sp)
ffffffffc0200c0c:	e1e2                	sd	s8,192(sp)
ffffffffc0200c0e:	e5e6                	sd	s9,200(sp)
ffffffffc0200c10:	e9ea                	sd	s10,208(sp)
ffffffffc0200c12:	edee                	sd	s11,216(sp)
ffffffffc0200c14:	f1f2                	sd	t3,224(sp)
ffffffffc0200c16:	f5f6                	sd	t4,232(sp)
ffffffffc0200c18:	f9fa                	sd	t5,240(sp)
ffffffffc0200c1a:	fdfe                	sd	t6,248(sp)
ffffffffc0200c1c:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200c20:	100024f3          	csrr	s1,sstatus
ffffffffc0200c24:	14102973          	csrr	s2,sepc
ffffffffc0200c28:	143029f3          	csrr	s3,stval
ffffffffc0200c2c:	14202a73          	csrr	s4,scause
ffffffffc0200c30:	e822                	sd	s0,16(sp)
ffffffffc0200c32:	e226                	sd	s1,256(sp)
ffffffffc0200c34:	e64a                	sd	s2,264(sp)
ffffffffc0200c36:	ea4e                	sd	s3,272(sp)
ffffffffc0200c38:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200c3a:	850a                	mv	a0,sp
    jal trap
ffffffffc0200c3c:	f8fff0ef          	jal	ra,ffffffffc0200bca <trap>

ffffffffc0200c40 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200c40:	6492                	ld	s1,256(sp)
ffffffffc0200c42:	6932                	ld	s2,264(sp)
ffffffffc0200c44:	10049073          	csrw	sstatus,s1
ffffffffc0200c48:	14191073          	csrw	sepc,s2
ffffffffc0200c4c:	60a2                	ld	ra,8(sp)
ffffffffc0200c4e:	61e2                	ld	gp,24(sp)
ffffffffc0200c50:	7202                	ld	tp,32(sp)
ffffffffc0200c52:	72a2                	ld	t0,40(sp)
ffffffffc0200c54:	7342                	ld	t1,48(sp)
ffffffffc0200c56:	73e2                	ld	t2,56(sp)
ffffffffc0200c58:	6406                	ld	s0,64(sp)
ffffffffc0200c5a:	64a6                	ld	s1,72(sp)
ffffffffc0200c5c:	6546                	ld	a0,80(sp)
ffffffffc0200c5e:	65e6                	ld	a1,88(sp)
ffffffffc0200c60:	7606                	ld	a2,96(sp)
ffffffffc0200c62:	76a6                	ld	a3,104(sp)
ffffffffc0200c64:	7746                	ld	a4,112(sp)
ffffffffc0200c66:	77e6                	ld	a5,120(sp)
ffffffffc0200c68:	680a                	ld	a6,128(sp)
ffffffffc0200c6a:	68aa                	ld	a7,136(sp)
ffffffffc0200c6c:	694a                	ld	s2,144(sp)
ffffffffc0200c6e:	69ea                	ld	s3,152(sp)
ffffffffc0200c70:	7a0a                	ld	s4,160(sp)
ffffffffc0200c72:	7aaa                	ld	s5,168(sp)
ffffffffc0200c74:	7b4a                	ld	s6,176(sp)
ffffffffc0200c76:	7bea                	ld	s7,184(sp)
ffffffffc0200c78:	6c0e                	ld	s8,192(sp)
ffffffffc0200c7a:	6cae                	ld	s9,200(sp)
ffffffffc0200c7c:	6d4e                	ld	s10,208(sp)
ffffffffc0200c7e:	6dee                	ld	s11,216(sp)
ffffffffc0200c80:	7e0e                	ld	t3,224(sp)
ffffffffc0200c82:	7eae                	ld	t4,232(sp)
ffffffffc0200c84:	7f4e                	ld	t5,240(sp)
ffffffffc0200c86:	7fee                	ld	t6,248(sp)
ffffffffc0200c88:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200c8a:	10200073          	sret

ffffffffc0200c8e <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200c8e:	00006797          	auipc	a5,0x6
ffffffffc0200c92:	39a78793          	addi	a5,a5,922 # ffffffffc0207028 <free_area>
ffffffffc0200c96:	e79c                	sd	a5,8(a5)
ffffffffc0200c98:	e39c                	sd	a5,0(a5)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200c9a:	0007a823          	sw	zero,16(a5)
}
ffffffffc0200c9e:	8082                	ret

ffffffffc0200ca0 <default_nr_free_pages>:
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}
ffffffffc0200ca0:	00006517          	auipc	a0,0x6
ffffffffc0200ca4:	39856503          	lwu	a0,920(a0) # ffffffffc0207038 <free_area+0x10>
ffffffffc0200ca8:	8082                	ret

ffffffffc0200caa <default_check>:
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
ffffffffc0200caa:	715d                	addi	sp,sp,-80
ffffffffc0200cac:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200cae:	00006417          	auipc	s0,0x6
ffffffffc0200cb2:	37a40413          	addi	s0,s0,890 # ffffffffc0207028 <free_area>
ffffffffc0200cb6:	641c                	ld	a5,8(s0)
ffffffffc0200cb8:	e486                	sd	ra,72(sp)
ffffffffc0200cba:	fc26                	sd	s1,56(sp)
ffffffffc0200cbc:	f84a                	sd	s2,48(sp)
ffffffffc0200cbe:	f44e                	sd	s3,40(sp)
ffffffffc0200cc0:	f052                	sd	s4,32(sp)
ffffffffc0200cc2:	ec56                	sd	s5,24(sp)
ffffffffc0200cc4:	e85a                	sd	s6,16(sp)
ffffffffc0200cc6:	e45e                	sd	s7,8(sp)
ffffffffc0200cc8:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200cca:	2c878763          	beq	a5,s0,ffffffffc0200f98 <default_check+0x2ee>
    int count = 0, total = 0;
ffffffffc0200cce:	4481                	li	s1,0
ffffffffc0200cd0:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0200cd2:	ff07b703          	ld	a4,-16(a5)
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0200cd6:	8b09                	andi	a4,a4,2
ffffffffc0200cd8:	2c070463          	beqz	a4,ffffffffc0200fa0 <default_check+0x2f6>
        count ++, total += p->property;
ffffffffc0200cdc:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200ce0:	679c                	ld	a5,8(a5)
ffffffffc0200ce2:	2905                	addiw	s2,s2,1
ffffffffc0200ce4:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200ce6:	fe8796e3          	bne	a5,s0,ffffffffc0200cd2 <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc0200cea:	89a6                	mv	s3,s1
ffffffffc0200cec:	2f9000ef          	jal	ra,ffffffffc02017e4 <nr_free_pages>
ffffffffc0200cf0:	71351863          	bne	a0,s3,ffffffffc0201400 <default_check+0x756>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200cf4:	4505                	li	a0,1
ffffffffc0200cf6:	271000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200cfa:	8a2a                	mv	s4,a0
ffffffffc0200cfc:	44050263          	beqz	a0,ffffffffc0201140 <default_check+0x496>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200d00:	4505                	li	a0,1
ffffffffc0200d02:	265000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200d06:	89aa                	mv	s3,a0
ffffffffc0200d08:	70050c63          	beqz	a0,ffffffffc0201420 <default_check+0x776>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200d0c:	4505                	li	a0,1
ffffffffc0200d0e:	259000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200d12:	8aaa                	mv	s5,a0
ffffffffc0200d14:	4a050663          	beqz	a0,ffffffffc02011c0 <default_check+0x516>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200d18:	2b3a0463          	beq	s4,s3,ffffffffc0200fc0 <default_check+0x316>
ffffffffc0200d1c:	2aaa0263          	beq	s4,a0,ffffffffc0200fc0 <default_check+0x316>
ffffffffc0200d20:	2aa98063          	beq	s3,a0,ffffffffc0200fc0 <default_check+0x316>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200d24:	000a2783          	lw	a5,0(s4)
ffffffffc0200d28:	2a079c63          	bnez	a5,ffffffffc0200fe0 <default_check+0x336>
ffffffffc0200d2c:	0009a783          	lw	a5,0(s3)
ffffffffc0200d30:	2a079863          	bnez	a5,ffffffffc0200fe0 <default_check+0x336>
ffffffffc0200d34:	411c                	lw	a5,0(a0)
ffffffffc0200d36:	2a079563          	bnez	a5,ffffffffc0200fe0 <default_check+0x336>
extern struct Page *pages;
extern size_t npage;
extern const size_t nbase;
extern uint64_t va_pa_offset;

static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200d3a:	00006797          	auipc	a5,0x6
ffffffffc0200d3e:	7367b783          	ld	a5,1846(a5) # ffffffffc0207470 <pages>
ffffffffc0200d42:	40fa0733          	sub	a4,s4,a5
ffffffffc0200d46:	870d                	srai	a4,a4,0x3
ffffffffc0200d48:	00002597          	auipc	a1,0x2
ffffffffc0200d4c:	3285b583          	ld	a1,808(a1) # ffffffffc0203070 <error_string+0x38>
ffffffffc0200d50:	02b70733          	mul	a4,a4,a1
ffffffffc0200d54:	00002617          	auipc	a2,0x2
ffffffffc0200d58:	32463603          	ld	a2,804(a2) # ffffffffc0203078 <nbase>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0200d5c:	00006697          	auipc	a3,0x6
ffffffffc0200d60:	70c6b683          	ld	a3,1804(a3) # ffffffffc0207468 <npage>
ffffffffc0200d64:	06b2                	slli	a3,a3,0xc
ffffffffc0200d66:	9732                	add	a4,a4,a2

static inline uintptr_t page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
ffffffffc0200d68:	0732                	slli	a4,a4,0xc
ffffffffc0200d6a:	28d77b63          	bgeu	a4,a3,ffffffffc0201000 <default_check+0x356>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200d6e:	40f98733          	sub	a4,s3,a5
ffffffffc0200d72:	870d                	srai	a4,a4,0x3
ffffffffc0200d74:	02b70733          	mul	a4,a4,a1
ffffffffc0200d78:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200d7a:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0200d7c:	4cd77263          	bgeu	a4,a3,ffffffffc0201240 <default_check+0x596>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200d80:	40f507b3          	sub	a5,a0,a5
ffffffffc0200d84:	878d                	srai	a5,a5,0x3
ffffffffc0200d86:	02b787b3          	mul	a5,a5,a1
ffffffffc0200d8a:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200d8c:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0200d8e:	30d7f963          	bgeu	a5,a3,ffffffffc02010a0 <default_check+0x3f6>
    assert(alloc_page() == NULL);
ffffffffc0200d92:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200d94:	00043c03          	ld	s8,0(s0)
ffffffffc0200d98:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0200d9c:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0200da0:	e400                	sd	s0,8(s0)
ffffffffc0200da2:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc0200da4:	00006797          	auipc	a5,0x6
ffffffffc0200da8:	2807aa23          	sw	zero,660(a5) # ffffffffc0207038 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0200dac:	1bb000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200db0:	2c051863          	bnez	a0,ffffffffc0201080 <default_check+0x3d6>
    free_page(p0);
ffffffffc0200db4:	4585                	li	a1,1
ffffffffc0200db6:	8552                	mv	a0,s4
ffffffffc0200db8:	1ed000ef          	jal	ra,ffffffffc02017a4 <free_pages>
    free_page(p1);
ffffffffc0200dbc:	4585                	li	a1,1
ffffffffc0200dbe:	854e                	mv	a0,s3
ffffffffc0200dc0:	1e5000ef          	jal	ra,ffffffffc02017a4 <free_pages>
    free_page(p2);
ffffffffc0200dc4:	4585                	li	a1,1
ffffffffc0200dc6:	8556                	mv	a0,s5
ffffffffc0200dc8:	1dd000ef          	jal	ra,ffffffffc02017a4 <free_pages>
    assert(nr_free == 3);
ffffffffc0200dcc:	4818                	lw	a4,16(s0)
ffffffffc0200dce:	478d                	li	a5,3
ffffffffc0200dd0:	28f71863          	bne	a4,a5,ffffffffc0201060 <default_check+0x3b6>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200dd4:	4505                	li	a0,1
ffffffffc0200dd6:	191000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200dda:	89aa                	mv	s3,a0
ffffffffc0200ddc:	26050263          	beqz	a0,ffffffffc0201040 <default_check+0x396>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200de0:	4505                	li	a0,1
ffffffffc0200de2:	185000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200de6:	8aaa                	mv	s5,a0
ffffffffc0200de8:	3a050c63          	beqz	a0,ffffffffc02011a0 <default_check+0x4f6>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200dec:	4505                	li	a0,1
ffffffffc0200dee:	179000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200df2:	8a2a                	mv	s4,a0
ffffffffc0200df4:	38050663          	beqz	a0,ffffffffc0201180 <default_check+0x4d6>
    assert(alloc_page() == NULL);
ffffffffc0200df8:	4505                	li	a0,1
ffffffffc0200dfa:	16d000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200dfe:	36051163          	bnez	a0,ffffffffc0201160 <default_check+0x4b6>
    free_page(p0);
ffffffffc0200e02:	4585                	li	a1,1
ffffffffc0200e04:	854e                	mv	a0,s3
ffffffffc0200e06:	19f000ef          	jal	ra,ffffffffc02017a4 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0200e0a:	641c                	ld	a5,8(s0)
ffffffffc0200e0c:	20878a63          	beq	a5,s0,ffffffffc0201020 <default_check+0x376>
    assert((p = alloc_page()) == p0);
ffffffffc0200e10:	4505                	li	a0,1
ffffffffc0200e12:	155000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200e16:	30a99563          	bne	s3,a0,ffffffffc0201120 <default_check+0x476>
    assert(alloc_page() == NULL);
ffffffffc0200e1a:	4505                	li	a0,1
ffffffffc0200e1c:	14b000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200e20:	2e051063          	bnez	a0,ffffffffc0201100 <default_check+0x456>
    assert(nr_free == 0);
ffffffffc0200e24:	481c                	lw	a5,16(s0)
ffffffffc0200e26:	2a079d63          	bnez	a5,ffffffffc02010e0 <default_check+0x436>
    free_page(p);
ffffffffc0200e2a:	854e                	mv	a0,s3
ffffffffc0200e2c:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0200e2e:	01843023          	sd	s8,0(s0)
ffffffffc0200e32:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0200e36:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc0200e3a:	16b000ef          	jal	ra,ffffffffc02017a4 <free_pages>
    free_page(p1);
ffffffffc0200e3e:	4585                	li	a1,1
ffffffffc0200e40:	8556                	mv	a0,s5
ffffffffc0200e42:	163000ef          	jal	ra,ffffffffc02017a4 <free_pages>
    free_page(p2);
ffffffffc0200e46:	4585                	li	a1,1
ffffffffc0200e48:	8552                	mv	a0,s4
ffffffffc0200e4a:	15b000ef          	jal	ra,ffffffffc02017a4 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc0200e4e:	4515                	li	a0,5
ffffffffc0200e50:	117000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200e54:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc0200e56:	26050563          	beqz	a0,ffffffffc02010c0 <default_check+0x416>
ffffffffc0200e5a:	651c                	ld	a5,8(a0)
ffffffffc0200e5c:	8385                	srli	a5,a5,0x1
    assert(!PageProperty(p0));
ffffffffc0200e5e:	8b85                	andi	a5,a5,1
ffffffffc0200e60:	54079063          	bnez	a5,ffffffffc02013a0 <default_check+0x6f6>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc0200e64:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200e66:	00043b03          	ld	s6,0(s0)
ffffffffc0200e6a:	00843a83          	ld	s5,8(s0)
ffffffffc0200e6e:	e000                	sd	s0,0(s0)
ffffffffc0200e70:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc0200e72:	0f5000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200e76:	50051563          	bnez	a0,ffffffffc0201380 <default_check+0x6d6>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc0200e7a:	05098a13          	addi	s4,s3,80
ffffffffc0200e7e:	8552                	mv	a0,s4
ffffffffc0200e80:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc0200e82:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc0200e86:	00006797          	auipc	a5,0x6
ffffffffc0200e8a:	1a07a923          	sw	zero,434(a5) # ffffffffc0207038 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc0200e8e:	117000ef          	jal	ra,ffffffffc02017a4 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc0200e92:	4511                	li	a0,4
ffffffffc0200e94:	0d3000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200e98:	4c051463          	bnez	a0,ffffffffc0201360 <default_check+0x6b6>
ffffffffc0200e9c:	0589b783          	ld	a5,88(s3)
ffffffffc0200ea0:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0200ea2:	8b85                	andi	a5,a5,1
ffffffffc0200ea4:	48078e63          	beqz	a5,ffffffffc0201340 <default_check+0x696>
ffffffffc0200ea8:	0609a703          	lw	a4,96(s3)
ffffffffc0200eac:	478d                	li	a5,3
ffffffffc0200eae:	48f71963          	bne	a4,a5,ffffffffc0201340 <default_check+0x696>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0200eb2:	450d                	li	a0,3
ffffffffc0200eb4:	0b3000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200eb8:	8c2a                	mv	s8,a0
ffffffffc0200eba:	46050363          	beqz	a0,ffffffffc0201320 <default_check+0x676>
    assert(alloc_page() == NULL);
ffffffffc0200ebe:	4505                	li	a0,1
ffffffffc0200ec0:	0a7000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200ec4:	42051e63          	bnez	a0,ffffffffc0201300 <default_check+0x656>
    assert(p0 + 2 == p1);
ffffffffc0200ec8:	418a1c63          	bne	s4,s8,ffffffffc02012e0 <default_check+0x636>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0200ecc:	4585                	li	a1,1
ffffffffc0200ece:	854e                	mv	a0,s3
ffffffffc0200ed0:	0d5000ef          	jal	ra,ffffffffc02017a4 <free_pages>
    free_pages(p1, 3);
ffffffffc0200ed4:	458d                	li	a1,3
ffffffffc0200ed6:	8552                	mv	a0,s4
ffffffffc0200ed8:	0cd000ef          	jal	ra,ffffffffc02017a4 <free_pages>
ffffffffc0200edc:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0200ee0:	02898c13          	addi	s8,s3,40
ffffffffc0200ee4:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0200ee6:	8b85                	andi	a5,a5,1
ffffffffc0200ee8:	3c078c63          	beqz	a5,ffffffffc02012c0 <default_check+0x616>
ffffffffc0200eec:	0109a703          	lw	a4,16(s3)
ffffffffc0200ef0:	4785                	li	a5,1
ffffffffc0200ef2:	3cf71763          	bne	a4,a5,ffffffffc02012c0 <default_check+0x616>
ffffffffc0200ef6:	008a3783          	ld	a5,8(s4)
ffffffffc0200efa:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0200efc:	8b85                	andi	a5,a5,1
ffffffffc0200efe:	3a078163          	beqz	a5,ffffffffc02012a0 <default_check+0x5f6>
ffffffffc0200f02:	010a2703          	lw	a4,16(s4)
ffffffffc0200f06:	478d                	li	a5,3
ffffffffc0200f08:	38f71c63          	bne	a4,a5,ffffffffc02012a0 <default_check+0x5f6>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0200f0c:	4505                	li	a0,1
ffffffffc0200f0e:	059000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200f12:	36a99763          	bne	s3,a0,ffffffffc0201280 <default_check+0x5d6>
    free_page(p0);
ffffffffc0200f16:	4585                	li	a1,1
ffffffffc0200f18:	08d000ef          	jal	ra,ffffffffc02017a4 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0200f1c:	4509                	li	a0,2
ffffffffc0200f1e:	049000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200f22:	32aa1f63          	bne	s4,a0,ffffffffc0201260 <default_check+0x5b6>

    free_pages(p0, 2);
ffffffffc0200f26:	4589                	li	a1,2
ffffffffc0200f28:	07d000ef          	jal	ra,ffffffffc02017a4 <free_pages>
    free_page(p2);
ffffffffc0200f2c:	4585                	li	a1,1
ffffffffc0200f2e:	8562                	mv	a0,s8
ffffffffc0200f30:	075000ef          	jal	ra,ffffffffc02017a4 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0200f34:	4515                	li	a0,5
ffffffffc0200f36:	031000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200f3a:	89aa                	mv	s3,a0
ffffffffc0200f3c:	48050263          	beqz	a0,ffffffffc02013c0 <default_check+0x716>
    assert(alloc_page() == NULL);
ffffffffc0200f40:	4505                	li	a0,1
ffffffffc0200f42:	025000ef          	jal	ra,ffffffffc0201766 <alloc_pages>
ffffffffc0200f46:	2c051d63          	bnez	a0,ffffffffc0201220 <default_check+0x576>

    assert(nr_free == 0);
ffffffffc0200f4a:	481c                	lw	a5,16(s0)
ffffffffc0200f4c:	2a079a63          	bnez	a5,ffffffffc0201200 <default_check+0x556>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0200f50:	4595                	li	a1,5
ffffffffc0200f52:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0200f54:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc0200f58:	01643023          	sd	s6,0(s0)
ffffffffc0200f5c:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0200f60:	045000ef          	jal	ra,ffffffffc02017a4 <free_pages>
    return listelm->next;
ffffffffc0200f64:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200f66:	00878963          	beq	a5,s0,ffffffffc0200f78 <default_check+0x2ce>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
ffffffffc0200f6a:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200f6e:	679c                	ld	a5,8(a5)
ffffffffc0200f70:	397d                	addiw	s2,s2,-1
ffffffffc0200f72:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200f74:	fe879be3          	bne	a5,s0,ffffffffc0200f6a <default_check+0x2c0>
    }
    assert(count == 0);
ffffffffc0200f78:	26091463          	bnez	s2,ffffffffc02011e0 <default_check+0x536>
    assert(total == 0);
ffffffffc0200f7c:	46049263          	bnez	s1,ffffffffc02013e0 <default_check+0x736>
}
ffffffffc0200f80:	60a6                	ld	ra,72(sp)
ffffffffc0200f82:	6406                	ld	s0,64(sp)
ffffffffc0200f84:	74e2                	ld	s1,56(sp)
ffffffffc0200f86:	7942                	ld	s2,48(sp)
ffffffffc0200f88:	79a2                	ld	s3,40(sp)
ffffffffc0200f8a:	7a02                	ld	s4,32(sp)
ffffffffc0200f8c:	6ae2                	ld	s5,24(sp)
ffffffffc0200f8e:	6b42                	ld	s6,16(sp)
ffffffffc0200f90:	6ba2                	ld	s7,8(sp)
ffffffffc0200f92:	6c02                	ld	s8,0(sp)
ffffffffc0200f94:	6161                	addi	sp,sp,80
ffffffffc0200f96:	8082                	ret
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200f98:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc0200f9a:	4481                	li	s1,0
ffffffffc0200f9c:	4901                	li	s2,0
ffffffffc0200f9e:	b3b9                	j	ffffffffc0200cec <default_check+0x42>
        assert(PageProperty(p));
ffffffffc0200fa0:	00002697          	auipc	a3,0x2
ffffffffc0200fa4:	94868693          	addi	a3,a3,-1720 # ffffffffc02028e8 <commands+0x6e0>
ffffffffc0200fa8:	00002617          	auipc	a2,0x2
ffffffffc0200fac:	95060613          	addi	a2,a2,-1712 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0200fb0:	0f000593          	li	a1,240
ffffffffc0200fb4:	00002517          	auipc	a0,0x2
ffffffffc0200fb8:	95c50513          	addi	a0,a0,-1700 # ffffffffc0202910 <commands+0x708>
ffffffffc0200fbc:	c1cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200fc0:	00002697          	auipc	a3,0x2
ffffffffc0200fc4:	9e868693          	addi	a3,a3,-1560 # ffffffffc02029a8 <commands+0x7a0>
ffffffffc0200fc8:	00002617          	auipc	a2,0x2
ffffffffc0200fcc:	93060613          	addi	a2,a2,-1744 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0200fd0:	0bd00593          	li	a1,189
ffffffffc0200fd4:	00002517          	auipc	a0,0x2
ffffffffc0200fd8:	93c50513          	addi	a0,a0,-1732 # ffffffffc0202910 <commands+0x708>
ffffffffc0200fdc:	bfcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200fe0:	00002697          	auipc	a3,0x2
ffffffffc0200fe4:	9f068693          	addi	a3,a3,-1552 # ffffffffc02029d0 <commands+0x7c8>
ffffffffc0200fe8:	00002617          	auipc	a2,0x2
ffffffffc0200fec:	91060613          	addi	a2,a2,-1776 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0200ff0:	0be00593          	li	a1,190
ffffffffc0200ff4:	00002517          	auipc	a0,0x2
ffffffffc0200ff8:	91c50513          	addi	a0,a0,-1764 # ffffffffc0202910 <commands+0x708>
ffffffffc0200ffc:	bdcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201000:	00002697          	auipc	a3,0x2
ffffffffc0201004:	a1068693          	addi	a3,a3,-1520 # ffffffffc0202a10 <commands+0x808>
ffffffffc0201008:	00002617          	auipc	a2,0x2
ffffffffc020100c:	8f060613          	addi	a2,a2,-1808 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201010:	0c000593          	li	a1,192
ffffffffc0201014:	00002517          	auipc	a0,0x2
ffffffffc0201018:	8fc50513          	addi	a0,a0,-1796 # ffffffffc0202910 <commands+0x708>
ffffffffc020101c:	bbcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201020:	00002697          	auipc	a3,0x2
ffffffffc0201024:	a7868693          	addi	a3,a3,-1416 # ffffffffc0202a98 <commands+0x890>
ffffffffc0201028:	00002617          	auipc	a2,0x2
ffffffffc020102c:	8d060613          	addi	a2,a2,-1840 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201030:	0d900593          	li	a1,217
ffffffffc0201034:	00002517          	auipc	a0,0x2
ffffffffc0201038:	8dc50513          	addi	a0,a0,-1828 # ffffffffc0202910 <commands+0x708>
ffffffffc020103c:	b9cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201040:	00002697          	auipc	a3,0x2
ffffffffc0201044:	90868693          	addi	a3,a3,-1784 # ffffffffc0202948 <commands+0x740>
ffffffffc0201048:	00002617          	auipc	a2,0x2
ffffffffc020104c:	8b060613          	addi	a2,a2,-1872 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201050:	0d200593          	li	a1,210
ffffffffc0201054:	00002517          	auipc	a0,0x2
ffffffffc0201058:	8bc50513          	addi	a0,a0,-1860 # ffffffffc0202910 <commands+0x708>
ffffffffc020105c:	b7cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(nr_free == 3);
ffffffffc0201060:	00002697          	auipc	a3,0x2
ffffffffc0201064:	a2868693          	addi	a3,a3,-1496 # ffffffffc0202a88 <commands+0x880>
ffffffffc0201068:	00002617          	auipc	a2,0x2
ffffffffc020106c:	89060613          	addi	a2,a2,-1904 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201070:	0d000593          	li	a1,208
ffffffffc0201074:	00002517          	auipc	a0,0x2
ffffffffc0201078:	89c50513          	addi	a0,a0,-1892 # ffffffffc0202910 <commands+0x708>
ffffffffc020107c:	b5cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201080:	00002697          	auipc	a3,0x2
ffffffffc0201084:	9f068693          	addi	a3,a3,-1552 # ffffffffc0202a70 <commands+0x868>
ffffffffc0201088:	00002617          	auipc	a2,0x2
ffffffffc020108c:	87060613          	addi	a2,a2,-1936 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201090:	0cb00593          	li	a1,203
ffffffffc0201094:	00002517          	auipc	a0,0x2
ffffffffc0201098:	87c50513          	addi	a0,a0,-1924 # ffffffffc0202910 <commands+0x708>
ffffffffc020109c:	b3cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02010a0:	00002697          	auipc	a3,0x2
ffffffffc02010a4:	9b068693          	addi	a3,a3,-1616 # ffffffffc0202a50 <commands+0x848>
ffffffffc02010a8:	00002617          	auipc	a2,0x2
ffffffffc02010ac:	85060613          	addi	a2,a2,-1968 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02010b0:	0c200593          	li	a1,194
ffffffffc02010b4:	00002517          	auipc	a0,0x2
ffffffffc02010b8:	85c50513          	addi	a0,a0,-1956 # ffffffffc0202910 <commands+0x708>
ffffffffc02010bc:	b1cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(p0 != NULL);
ffffffffc02010c0:	00002697          	auipc	a3,0x2
ffffffffc02010c4:	a2068693          	addi	a3,a3,-1504 # ffffffffc0202ae0 <commands+0x8d8>
ffffffffc02010c8:	00002617          	auipc	a2,0x2
ffffffffc02010cc:	83060613          	addi	a2,a2,-2000 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02010d0:	0f800593          	li	a1,248
ffffffffc02010d4:	00002517          	auipc	a0,0x2
ffffffffc02010d8:	83c50513          	addi	a0,a0,-1988 # ffffffffc0202910 <commands+0x708>
ffffffffc02010dc:	afcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(nr_free == 0);
ffffffffc02010e0:	00002697          	auipc	a3,0x2
ffffffffc02010e4:	9f068693          	addi	a3,a3,-1552 # ffffffffc0202ad0 <commands+0x8c8>
ffffffffc02010e8:	00002617          	auipc	a2,0x2
ffffffffc02010ec:	81060613          	addi	a2,a2,-2032 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02010f0:	0df00593          	li	a1,223
ffffffffc02010f4:	00002517          	auipc	a0,0x2
ffffffffc02010f8:	81c50513          	addi	a0,a0,-2020 # ffffffffc0202910 <commands+0x708>
ffffffffc02010fc:	adcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201100:	00002697          	auipc	a3,0x2
ffffffffc0201104:	97068693          	addi	a3,a3,-1680 # ffffffffc0202a70 <commands+0x868>
ffffffffc0201108:	00001617          	auipc	a2,0x1
ffffffffc020110c:	7f060613          	addi	a2,a2,2032 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201110:	0dd00593          	li	a1,221
ffffffffc0201114:	00001517          	auipc	a0,0x1
ffffffffc0201118:	7fc50513          	addi	a0,a0,2044 # ffffffffc0202910 <commands+0x708>
ffffffffc020111c:	abcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201120:	00002697          	auipc	a3,0x2
ffffffffc0201124:	99068693          	addi	a3,a3,-1648 # ffffffffc0202ab0 <commands+0x8a8>
ffffffffc0201128:	00001617          	auipc	a2,0x1
ffffffffc020112c:	7d060613          	addi	a2,a2,2000 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201130:	0dc00593          	li	a1,220
ffffffffc0201134:	00001517          	auipc	a0,0x1
ffffffffc0201138:	7dc50513          	addi	a0,a0,2012 # ffffffffc0202910 <commands+0x708>
ffffffffc020113c:	a9cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201140:	00002697          	auipc	a3,0x2
ffffffffc0201144:	80868693          	addi	a3,a3,-2040 # ffffffffc0202948 <commands+0x740>
ffffffffc0201148:	00001617          	auipc	a2,0x1
ffffffffc020114c:	7b060613          	addi	a2,a2,1968 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201150:	0b900593          	li	a1,185
ffffffffc0201154:	00001517          	auipc	a0,0x1
ffffffffc0201158:	7bc50513          	addi	a0,a0,1980 # ffffffffc0202910 <commands+0x708>
ffffffffc020115c:	a7cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201160:	00002697          	auipc	a3,0x2
ffffffffc0201164:	91068693          	addi	a3,a3,-1776 # ffffffffc0202a70 <commands+0x868>
ffffffffc0201168:	00001617          	auipc	a2,0x1
ffffffffc020116c:	79060613          	addi	a2,a2,1936 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201170:	0d600593          	li	a1,214
ffffffffc0201174:	00001517          	auipc	a0,0x1
ffffffffc0201178:	79c50513          	addi	a0,a0,1948 # ffffffffc0202910 <commands+0x708>
ffffffffc020117c:	a5cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201180:	00002697          	auipc	a3,0x2
ffffffffc0201184:	80868693          	addi	a3,a3,-2040 # ffffffffc0202988 <commands+0x780>
ffffffffc0201188:	00001617          	auipc	a2,0x1
ffffffffc020118c:	77060613          	addi	a2,a2,1904 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201190:	0d400593          	li	a1,212
ffffffffc0201194:	00001517          	auipc	a0,0x1
ffffffffc0201198:	77c50513          	addi	a0,a0,1916 # ffffffffc0202910 <commands+0x708>
ffffffffc020119c:	a3cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02011a0:	00001697          	auipc	a3,0x1
ffffffffc02011a4:	7c868693          	addi	a3,a3,1992 # ffffffffc0202968 <commands+0x760>
ffffffffc02011a8:	00001617          	auipc	a2,0x1
ffffffffc02011ac:	75060613          	addi	a2,a2,1872 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02011b0:	0d300593          	li	a1,211
ffffffffc02011b4:	00001517          	auipc	a0,0x1
ffffffffc02011b8:	75c50513          	addi	a0,a0,1884 # ffffffffc0202910 <commands+0x708>
ffffffffc02011bc:	a1cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02011c0:	00001697          	auipc	a3,0x1
ffffffffc02011c4:	7c868693          	addi	a3,a3,1992 # ffffffffc0202988 <commands+0x780>
ffffffffc02011c8:	00001617          	auipc	a2,0x1
ffffffffc02011cc:	73060613          	addi	a2,a2,1840 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02011d0:	0bb00593          	li	a1,187
ffffffffc02011d4:	00001517          	auipc	a0,0x1
ffffffffc02011d8:	73c50513          	addi	a0,a0,1852 # ffffffffc0202910 <commands+0x708>
ffffffffc02011dc:	9fcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(count == 0);
ffffffffc02011e0:	00002697          	auipc	a3,0x2
ffffffffc02011e4:	a5068693          	addi	a3,a3,-1456 # ffffffffc0202c30 <commands+0xa28>
ffffffffc02011e8:	00001617          	auipc	a2,0x1
ffffffffc02011ec:	71060613          	addi	a2,a2,1808 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02011f0:	12500593          	li	a1,293
ffffffffc02011f4:	00001517          	auipc	a0,0x1
ffffffffc02011f8:	71c50513          	addi	a0,a0,1820 # ffffffffc0202910 <commands+0x708>
ffffffffc02011fc:	9dcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(nr_free == 0);
ffffffffc0201200:	00002697          	auipc	a3,0x2
ffffffffc0201204:	8d068693          	addi	a3,a3,-1840 # ffffffffc0202ad0 <commands+0x8c8>
ffffffffc0201208:	00001617          	auipc	a2,0x1
ffffffffc020120c:	6f060613          	addi	a2,a2,1776 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201210:	11a00593          	li	a1,282
ffffffffc0201214:	00001517          	auipc	a0,0x1
ffffffffc0201218:	6fc50513          	addi	a0,a0,1788 # ffffffffc0202910 <commands+0x708>
ffffffffc020121c:	9bcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201220:	00002697          	auipc	a3,0x2
ffffffffc0201224:	85068693          	addi	a3,a3,-1968 # ffffffffc0202a70 <commands+0x868>
ffffffffc0201228:	00001617          	auipc	a2,0x1
ffffffffc020122c:	6d060613          	addi	a2,a2,1744 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201230:	11800593          	li	a1,280
ffffffffc0201234:	00001517          	auipc	a0,0x1
ffffffffc0201238:	6dc50513          	addi	a0,a0,1756 # ffffffffc0202910 <commands+0x708>
ffffffffc020123c:	99cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201240:	00001697          	auipc	a3,0x1
ffffffffc0201244:	7f068693          	addi	a3,a3,2032 # ffffffffc0202a30 <commands+0x828>
ffffffffc0201248:	00001617          	auipc	a2,0x1
ffffffffc020124c:	6b060613          	addi	a2,a2,1712 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201250:	0c100593          	li	a1,193
ffffffffc0201254:	00001517          	auipc	a0,0x1
ffffffffc0201258:	6bc50513          	addi	a0,a0,1724 # ffffffffc0202910 <commands+0x708>
ffffffffc020125c:	97cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201260:	00002697          	auipc	a3,0x2
ffffffffc0201264:	99068693          	addi	a3,a3,-1648 # ffffffffc0202bf0 <commands+0x9e8>
ffffffffc0201268:	00001617          	auipc	a2,0x1
ffffffffc020126c:	69060613          	addi	a2,a2,1680 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201270:	11200593          	li	a1,274
ffffffffc0201274:	00001517          	auipc	a0,0x1
ffffffffc0201278:	69c50513          	addi	a0,a0,1692 # ffffffffc0202910 <commands+0x708>
ffffffffc020127c:	95cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0201280:	00002697          	auipc	a3,0x2
ffffffffc0201284:	95068693          	addi	a3,a3,-1712 # ffffffffc0202bd0 <commands+0x9c8>
ffffffffc0201288:	00001617          	auipc	a2,0x1
ffffffffc020128c:	67060613          	addi	a2,a2,1648 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201290:	11000593          	li	a1,272
ffffffffc0201294:	00001517          	auipc	a0,0x1
ffffffffc0201298:	67c50513          	addi	a0,a0,1660 # ffffffffc0202910 <commands+0x708>
ffffffffc020129c:	93cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc02012a0:	00002697          	auipc	a3,0x2
ffffffffc02012a4:	90868693          	addi	a3,a3,-1784 # ffffffffc0202ba8 <commands+0x9a0>
ffffffffc02012a8:	00001617          	auipc	a2,0x1
ffffffffc02012ac:	65060613          	addi	a2,a2,1616 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02012b0:	10e00593          	li	a1,270
ffffffffc02012b4:	00001517          	auipc	a0,0x1
ffffffffc02012b8:	65c50513          	addi	a0,a0,1628 # ffffffffc0202910 <commands+0x708>
ffffffffc02012bc:	91cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc02012c0:	00002697          	auipc	a3,0x2
ffffffffc02012c4:	8c068693          	addi	a3,a3,-1856 # ffffffffc0202b80 <commands+0x978>
ffffffffc02012c8:	00001617          	auipc	a2,0x1
ffffffffc02012cc:	63060613          	addi	a2,a2,1584 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02012d0:	10d00593          	li	a1,269
ffffffffc02012d4:	00001517          	auipc	a0,0x1
ffffffffc02012d8:	63c50513          	addi	a0,a0,1596 # ffffffffc0202910 <commands+0x708>
ffffffffc02012dc:	8fcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(p0 + 2 == p1);
ffffffffc02012e0:	00002697          	auipc	a3,0x2
ffffffffc02012e4:	89068693          	addi	a3,a3,-1904 # ffffffffc0202b70 <commands+0x968>
ffffffffc02012e8:	00001617          	auipc	a2,0x1
ffffffffc02012ec:	61060613          	addi	a2,a2,1552 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02012f0:	10800593          	li	a1,264
ffffffffc02012f4:	00001517          	auipc	a0,0x1
ffffffffc02012f8:	61c50513          	addi	a0,a0,1564 # ffffffffc0202910 <commands+0x708>
ffffffffc02012fc:	8dcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201300:	00001697          	auipc	a3,0x1
ffffffffc0201304:	77068693          	addi	a3,a3,1904 # ffffffffc0202a70 <commands+0x868>
ffffffffc0201308:	00001617          	auipc	a2,0x1
ffffffffc020130c:	5f060613          	addi	a2,a2,1520 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201310:	10700593          	li	a1,263
ffffffffc0201314:	00001517          	auipc	a0,0x1
ffffffffc0201318:	5fc50513          	addi	a0,a0,1532 # ffffffffc0202910 <commands+0x708>
ffffffffc020131c:	8bcff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201320:	00002697          	auipc	a3,0x2
ffffffffc0201324:	83068693          	addi	a3,a3,-2000 # ffffffffc0202b50 <commands+0x948>
ffffffffc0201328:	00001617          	auipc	a2,0x1
ffffffffc020132c:	5d060613          	addi	a2,a2,1488 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201330:	10600593          	li	a1,262
ffffffffc0201334:	00001517          	auipc	a0,0x1
ffffffffc0201338:	5dc50513          	addi	a0,a0,1500 # ffffffffc0202910 <commands+0x708>
ffffffffc020133c:	89cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201340:	00001697          	auipc	a3,0x1
ffffffffc0201344:	7e068693          	addi	a3,a3,2016 # ffffffffc0202b20 <commands+0x918>
ffffffffc0201348:	00001617          	auipc	a2,0x1
ffffffffc020134c:	5b060613          	addi	a2,a2,1456 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201350:	10500593          	li	a1,261
ffffffffc0201354:	00001517          	auipc	a0,0x1
ffffffffc0201358:	5bc50513          	addi	a0,a0,1468 # ffffffffc0202910 <commands+0x708>
ffffffffc020135c:	87cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc0201360:	00001697          	auipc	a3,0x1
ffffffffc0201364:	7a868693          	addi	a3,a3,1960 # ffffffffc0202b08 <commands+0x900>
ffffffffc0201368:	00001617          	auipc	a2,0x1
ffffffffc020136c:	59060613          	addi	a2,a2,1424 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201370:	10400593          	li	a1,260
ffffffffc0201374:	00001517          	auipc	a0,0x1
ffffffffc0201378:	59c50513          	addi	a0,a0,1436 # ffffffffc0202910 <commands+0x708>
ffffffffc020137c:	85cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201380:	00001697          	auipc	a3,0x1
ffffffffc0201384:	6f068693          	addi	a3,a3,1776 # ffffffffc0202a70 <commands+0x868>
ffffffffc0201388:	00001617          	auipc	a2,0x1
ffffffffc020138c:	57060613          	addi	a2,a2,1392 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201390:	0fe00593          	li	a1,254
ffffffffc0201394:	00001517          	auipc	a0,0x1
ffffffffc0201398:	57c50513          	addi	a0,a0,1404 # ffffffffc0202910 <commands+0x708>
ffffffffc020139c:	83cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(!PageProperty(p0));
ffffffffc02013a0:	00001697          	auipc	a3,0x1
ffffffffc02013a4:	75068693          	addi	a3,a3,1872 # ffffffffc0202af0 <commands+0x8e8>
ffffffffc02013a8:	00001617          	auipc	a2,0x1
ffffffffc02013ac:	55060613          	addi	a2,a2,1360 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02013b0:	0f900593          	li	a1,249
ffffffffc02013b4:	00001517          	auipc	a0,0x1
ffffffffc02013b8:	55c50513          	addi	a0,a0,1372 # ffffffffc0202910 <commands+0x708>
ffffffffc02013bc:	81cff0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc02013c0:	00002697          	auipc	a3,0x2
ffffffffc02013c4:	85068693          	addi	a3,a3,-1968 # ffffffffc0202c10 <commands+0xa08>
ffffffffc02013c8:	00001617          	auipc	a2,0x1
ffffffffc02013cc:	53060613          	addi	a2,a2,1328 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02013d0:	11700593          	li	a1,279
ffffffffc02013d4:	00001517          	auipc	a0,0x1
ffffffffc02013d8:	53c50513          	addi	a0,a0,1340 # ffffffffc0202910 <commands+0x708>
ffffffffc02013dc:	ffdfe0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(total == 0);
ffffffffc02013e0:	00002697          	auipc	a3,0x2
ffffffffc02013e4:	86068693          	addi	a3,a3,-1952 # ffffffffc0202c40 <commands+0xa38>
ffffffffc02013e8:	00001617          	auipc	a2,0x1
ffffffffc02013ec:	51060613          	addi	a2,a2,1296 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02013f0:	12600593          	li	a1,294
ffffffffc02013f4:	00001517          	auipc	a0,0x1
ffffffffc02013f8:	51c50513          	addi	a0,a0,1308 # ffffffffc0202910 <commands+0x708>
ffffffffc02013fc:	fddfe0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(total == nr_free_pages());
ffffffffc0201400:	00001697          	auipc	a3,0x1
ffffffffc0201404:	52868693          	addi	a3,a3,1320 # ffffffffc0202928 <commands+0x720>
ffffffffc0201408:	00001617          	auipc	a2,0x1
ffffffffc020140c:	4f060613          	addi	a2,a2,1264 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201410:	0f300593          	li	a1,243
ffffffffc0201414:	00001517          	auipc	a0,0x1
ffffffffc0201418:	4fc50513          	addi	a0,a0,1276 # ffffffffc0202910 <commands+0x708>
ffffffffc020141c:	fbdfe0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201420:	00001697          	auipc	a3,0x1
ffffffffc0201424:	54868693          	addi	a3,a3,1352 # ffffffffc0202968 <commands+0x760>
ffffffffc0201428:	00001617          	auipc	a2,0x1
ffffffffc020142c:	4d060613          	addi	a2,a2,1232 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201430:	0ba00593          	li	a1,186
ffffffffc0201434:	00001517          	auipc	a0,0x1
ffffffffc0201438:	4dc50513          	addi	a0,a0,1244 # ffffffffc0202910 <commands+0x708>
ffffffffc020143c:	f9dfe0ef          	jal	ra,ffffffffc02003d8 <__panic>

ffffffffc0201440 <default_free_pages>:
default_free_pages(struct Page *base, size_t n) {
ffffffffc0201440:	1141                	addi	sp,sp,-16
ffffffffc0201442:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201444:	14058a63          	beqz	a1,ffffffffc0201598 <default_free_pages+0x158>
    for (; p != base + n; p ++) {
ffffffffc0201448:	00259693          	slli	a3,a1,0x2
ffffffffc020144c:	96ae                	add	a3,a3,a1
ffffffffc020144e:	068e                	slli	a3,a3,0x3
ffffffffc0201450:	96aa                	add	a3,a3,a0
ffffffffc0201452:	87aa                	mv	a5,a0
ffffffffc0201454:	02d50263          	beq	a0,a3,ffffffffc0201478 <default_free_pages+0x38>
ffffffffc0201458:	6798                	ld	a4,8(a5)
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc020145a:	8b05                	andi	a4,a4,1
ffffffffc020145c:	10071e63          	bnez	a4,ffffffffc0201578 <default_free_pages+0x138>
ffffffffc0201460:	6798                	ld	a4,8(a5)
ffffffffc0201462:	8b09                	andi	a4,a4,2
ffffffffc0201464:	10071a63          	bnez	a4,ffffffffc0201578 <default_free_pages+0x138>
        p->flags = 0;
ffffffffc0201468:	0007b423          	sd	zero,8(a5)



static inline int page_ref(struct Page *page) { return page->ref; }

static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc020146c:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc0201470:	02878793          	addi	a5,a5,40
ffffffffc0201474:	fed792e3          	bne	a5,a3,ffffffffc0201458 <default_free_pages+0x18>
    base->property = n;
ffffffffc0201478:	2581                	sext.w	a1,a1
ffffffffc020147a:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc020147c:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201480:	4789                	li	a5,2
ffffffffc0201482:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc0201486:	00006697          	auipc	a3,0x6
ffffffffc020148a:	ba268693          	addi	a3,a3,-1118 # ffffffffc0207028 <free_area>
ffffffffc020148e:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc0201490:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc0201492:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc0201496:	9db9                	addw	a1,a1,a4
ffffffffc0201498:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc020149a:	0ad78863          	beq	a5,a3,ffffffffc020154a <default_free_pages+0x10a>
            struct Page* page = le2page(le, page_link);
ffffffffc020149e:	fe878713          	addi	a4,a5,-24
ffffffffc02014a2:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc02014a6:	4581                	li	a1,0
            if (base < page) {
ffffffffc02014a8:	00e56a63          	bltu	a0,a4,ffffffffc02014bc <default_free_pages+0x7c>
    return listelm->next;
ffffffffc02014ac:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc02014ae:	06d70263          	beq	a4,a3,ffffffffc0201512 <default_free_pages+0xd2>
    for (; p != base + n; p ++) {
ffffffffc02014b2:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc02014b4:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc02014b8:	fee57ae3          	bgeu	a0,a4,ffffffffc02014ac <default_free_pages+0x6c>
ffffffffc02014bc:	c199                	beqz	a1,ffffffffc02014c2 <default_free_pages+0x82>
ffffffffc02014be:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02014c2:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc02014c4:	e390                	sd	a2,0(a5)
ffffffffc02014c6:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc02014c8:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02014ca:	ed18                	sd	a4,24(a0)
    if (le != &free_list) {
ffffffffc02014cc:	02d70063          	beq	a4,a3,ffffffffc02014ec <default_free_pages+0xac>
        if (p + p->property == base) {
ffffffffc02014d0:	ff872803          	lw	a6,-8(a4)
        p = le2page(le, page_link);
ffffffffc02014d4:	fe870593          	addi	a1,a4,-24
        if (p + p->property == base) {
ffffffffc02014d8:	02081613          	slli	a2,a6,0x20
ffffffffc02014dc:	9201                	srli	a2,a2,0x20
ffffffffc02014de:	00261793          	slli	a5,a2,0x2
ffffffffc02014e2:	97b2                	add	a5,a5,a2
ffffffffc02014e4:	078e                	slli	a5,a5,0x3
ffffffffc02014e6:	97ae                	add	a5,a5,a1
ffffffffc02014e8:	02f50f63          	beq	a0,a5,ffffffffc0201526 <default_free_pages+0xe6>
    return listelm->next;
ffffffffc02014ec:	7118                	ld	a4,32(a0)
    if (le != &free_list) {
ffffffffc02014ee:	00d70f63          	beq	a4,a3,ffffffffc020150c <default_free_pages+0xcc>
        if (base + base->property == p) {
ffffffffc02014f2:	490c                	lw	a1,16(a0)
        p = le2page(le, page_link);
ffffffffc02014f4:	fe870693          	addi	a3,a4,-24
        if (base + base->property == p) {
ffffffffc02014f8:	02059613          	slli	a2,a1,0x20
ffffffffc02014fc:	9201                	srli	a2,a2,0x20
ffffffffc02014fe:	00261793          	slli	a5,a2,0x2
ffffffffc0201502:	97b2                	add	a5,a5,a2
ffffffffc0201504:	078e                	slli	a5,a5,0x3
ffffffffc0201506:	97aa                	add	a5,a5,a0
ffffffffc0201508:	04f68863          	beq	a3,a5,ffffffffc0201558 <default_free_pages+0x118>
}
ffffffffc020150c:	60a2                	ld	ra,8(sp)
ffffffffc020150e:	0141                	addi	sp,sp,16
ffffffffc0201510:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201512:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201514:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201516:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201518:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc020151a:	02d70563          	beq	a4,a3,ffffffffc0201544 <default_free_pages+0x104>
    prev->next = next->prev = elm;
ffffffffc020151e:	8832                	mv	a6,a2
ffffffffc0201520:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0201522:	87ba                	mv	a5,a4
ffffffffc0201524:	bf41                	j	ffffffffc02014b4 <default_free_pages+0x74>
            p->property += base->property;
ffffffffc0201526:	491c                	lw	a5,16(a0)
ffffffffc0201528:	0107883b          	addw	a6,a5,a6
ffffffffc020152c:	ff072c23          	sw	a6,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201530:	57f5                	li	a5,-3
ffffffffc0201532:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201536:	6d10                	ld	a2,24(a0)
ffffffffc0201538:	711c                	ld	a5,32(a0)
            base = p;
ffffffffc020153a:	852e                	mv	a0,a1
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc020153c:	e61c                	sd	a5,8(a2)
    return listelm->next;
ffffffffc020153e:	6718                	ld	a4,8(a4)
    next->prev = prev;
ffffffffc0201540:	e390                	sd	a2,0(a5)
ffffffffc0201542:	b775                	j	ffffffffc02014ee <default_free_pages+0xae>
ffffffffc0201544:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0201546:	873e                	mv	a4,a5
ffffffffc0201548:	b761                	j	ffffffffc02014d0 <default_free_pages+0x90>
}
ffffffffc020154a:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc020154c:	e390                	sd	a2,0(a5)
ffffffffc020154e:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201550:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201552:	ed1c                	sd	a5,24(a0)
ffffffffc0201554:	0141                	addi	sp,sp,16
ffffffffc0201556:	8082                	ret
            base->property += p->property;
ffffffffc0201558:	ff872783          	lw	a5,-8(a4)
ffffffffc020155c:	ff070693          	addi	a3,a4,-16
ffffffffc0201560:	9dbd                	addw	a1,a1,a5
ffffffffc0201562:	c90c                	sw	a1,16(a0)
ffffffffc0201564:	57f5                	li	a5,-3
ffffffffc0201566:	60f6b02f          	amoand.d	zero,a5,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc020156a:	6314                	ld	a3,0(a4)
ffffffffc020156c:	671c                	ld	a5,8(a4)
}
ffffffffc020156e:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc0201570:	e69c                	sd	a5,8(a3)
    next->prev = prev;
ffffffffc0201572:	e394                	sd	a3,0(a5)
ffffffffc0201574:	0141                	addi	sp,sp,16
ffffffffc0201576:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0201578:	00001697          	auipc	a3,0x1
ffffffffc020157c:	6e068693          	addi	a3,a3,1760 # ffffffffc0202c58 <commands+0xa50>
ffffffffc0201580:	00001617          	auipc	a2,0x1
ffffffffc0201584:	37860613          	addi	a2,a2,888 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201588:	08300593          	li	a1,131
ffffffffc020158c:	00001517          	auipc	a0,0x1
ffffffffc0201590:	38450513          	addi	a0,a0,900 # ffffffffc0202910 <commands+0x708>
ffffffffc0201594:	e45fe0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(n > 0);
ffffffffc0201598:	00001697          	auipc	a3,0x1
ffffffffc020159c:	6b868693          	addi	a3,a3,1720 # ffffffffc0202c50 <commands+0xa48>
ffffffffc02015a0:	00001617          	auipc	a2,0x1
ffffffffc02015a4:	35860613          	addi	a2,a2,856 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc02015a8:	08000593          	li	a1,128
ffffffffc02015ac:	00001517          	auipc	a0,0x1
ffffffffc02015b0:	36450513          	addi	a0,a0,868 # ffffffffc0202910 <commands+0x708>
ffffffffc02015b4:	e25fe0ef          	jal	ra,ffffffffc02003d8 <__panic>

ffffffffc02015b8 <default_alloc_pages>:
    assert(n > 0);
ffffffffc02015b8:	c959                	beqz	a0,ffffffffc020164e <default_alloc_pages+0x96>
    if (n > nr_free) {
ffffffffc02015ba:	00006597          	auipc	a1,0x6
ffffffffc02015be:	a6e58593          	addi	a1,a1,-1426 # ffffffffc0207028 <free_area>
ffffffffc02015c2:	0105a803          	lw	a6,16(a1)
ffffffffc02015c6:	862a                	mv	a2,a0
ffffffffc02015c8:	02081793          	slli	a5,a6,0x20
ffffffffc02015cc:	9381                	srli	a5,a5,0x20
ffffffffc02015ce:	00a7ee63          	bltu	a5,a0,ffffffffc02015ea <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc02015d2:	87ae                	mv	a5,a1
ffffffffc02015d4:	a801                	j	ffffffffc02015e4 <default_alloc_pages+0x2c>
        if (p->property >= n) {
ffffffffc02015d6:	ff87a703          	lw	a4,-8(a5)
ffffffffc02015da:	02071693          	slli	a3,a4,0x20
ffffffffc02015de:	9281                	srli	a3,a3,0x20
ffffffffc02015e0:	00c6f763          	bgeu	a3,a2,ffffffffc02015ee <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc02015e4:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list) {
ffffffffc02015e6:	feb798e3          	bne	a5,a1,ffffffffc02015d6 <default_alloc_pages+0x1e>
        return NULL;
ffffffffc02015ea:	4501                	li	a0,0
}
ffffffffc02015ec:	8082                	ret
    return listelm->prev;
ffffffffc02015ee:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc02015f2:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc02015f6:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc02015fa:	00060e1b          	sext.w	t3,a2
    prev->next = next;
ffffffffc02015fe:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc0201602:	01133023          	sd	a7,0(t1)
        if (page->property > n) {
ffffffffc0201606:	02d67b63          	bgeu	a2,a3,ffffffffc020163c <default_alloc_pages+0x84>
            struct Page *p = page + n;
ffffffffc020160a:	00261693          	slli	a3,a2,0x2
ffffffffc020160e:	96b2                	add	a3,a3,a2
ffffffffc0201610:	068e                	slli	a3,a3,0x3
ffffffffc0201612:	96aa                	add	a3,a3,a0
            p->property = page->property - n;
ffffffffc0201614:	41c7073b          	subw	a4,a4,t3
ffffffffc0201618:	ca98                	sw	a4,16(a3)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc020161a:	00868613          	addi	a2,a3,8
ffffffffc020161e:	4709                	li	a4,2
ffffffffc0201620:	40e6302f          	amoor.d	zero,a4,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0201624:	0088b703          	ld	a4,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0201628:	01868613          	addi	a2,a3,24
        nr_free -= n;
ffffffffc020162c:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc0201630:	e310                	sd	a2,0(a4)
ffffffffc0201632:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0201636:	f298                	sd	a4,32(a3)
    elm->prev = prev;
ffffffffc0201638:	0116bc23          	sd	a7,24(a3)
ffffffffc020163c:	41c8083b          	subw	a6,a6,t3
ffffffffc0201640:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201644:	5775                	li	a4,-3
ffffffffc0201646:	17c1                	addi	a5,a5,-16
ffffffffc0201648:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc020164c:	8082                	ret
default_alloc_pages(size_t n) {
ffffffffc020164e:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0201650:	00001697          	auipc	a3,0x1
ffffffffc0201654:	60068693          	addi	a3,a3,1536 # ffffffffc0202c50 <commands+0xa48>
ffffffffc0201658:	00001617          	auipc	a2,0x1
ffffffffc020165c:	2a060613          	addi	a2,a2,672 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201660:	06200593          	li	a1,98
ffffffffc0201664:	00001517          	auipc	a0,0x1
ffffffffc0201668:	2ac50513          	addi	a0,a0,684 # ffffffffc0202910 <commands+0x708>
default_alloc_pages(size_t n) {
ffffffffc020166c:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc020166e:	d6bfe0ef          	jal	ra,ffffffffc02003d8 <__panic>

ffffffffc0201672 <default_init_memmap>:
default_init_memmap(struct Page *base, size_t n) {
ffffffffc0201672:	1141                	addi	sp,sp,-16
ffffffffc0201674:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201676:	c9e1                	beqz	a1,ffffffffc0201746 <default_init_memmap+0xd4>
    for (; p != base + n; p ++) {
ffffffffc0201678:	00259693          	slli	a3,a1,0x2
ffffffffc020167c:	96ae                	add	a3,a3,a1
ffffffffc020167e:	068e                	slli	a3,a3,0x3
ffffffffc0201680:	96aa                	add	a3,a3,a0
ffffffffc0201682:	87aa                	mv	a5,a0
ffffffffc0201684:	00d50f63          	beq	a0,a3,ffffffffc02016a2 <default_init_memmap+0x30>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0201688:	6798                	ld	a4,8(a5)
        assert(PageReserved(p));
ffffffffc020168a:	8b05                	andi	a4,a4,1
ffffffffc020168c:	cf49                	beqz	a4,ffffffffc0201726 <default_init_memmap+0xb4>
        p->flags = p->property = 0;
ffffffffc020168e:	0007a823          	sw	zero,16(a5)
ffffffffc0201692:	0007b423          	sd	zero,8(a5)
ffffffffc0201696:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc020169a:	02878793          	addi	a5,a5,40
ffffffffc020169e:	fed795e3          	bne	a5,a3,ffffffffc0201688 <default_init_memmap+0x16>
    base->property = n;
ffffffffc02016a2:	2581                	sext.w	a1,a1
ffffffffc02016a4:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02016a6:	4789                	li	a5,2
ffffffffc02016a8:	00850713          	addi	a4,a0,8
ffffffffc02016ac:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc02016b0:	00006697          	auipc	a3,0x6
ffffffffc02016b4:	97868693          	addi	a3,a3,-1672 # ffffffffc0207028 <free_area>
ffffffffc02016b8:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02016ba:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02016bc:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02016c0:	9db9                	addw	a1,a1,a4
ffffffffc02016c2:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc02016c4:	04d78a63          	beq	a5,a3,ffffffffc0201718 <default_init_memmap+0xa6>
            struct Page* page = le2page(le, page_link);
ffffffffc02016c8:	fe878713          	addi	a4,a5,-24
ffffffffc02016cc:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc02016d0:	4581                	li	a1,0
            if (base < page) {
ffffffffc02016d2:	00e56a63          	bltu	a0,a4,ffffffffc02016e6 <default_init_memmap+0x74>
    return listelm->next;
ffffffffc02016d6:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc02016d8:	02d70263          	beq	a4,a3,ffffffffc02016fc <default_init_memmap+0x8a>
    for (; p != base + n; p ++) {
ffffffffc02016dc:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc02016de:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc02016e2:	fee57ae3          	bgeu	a0,a4,ffffffffc02016d6 <default_init_memmap+0x64>
ffffffffc02016e6:	c199                	beqz	a1,ffffffffc02016ec <default_init_memmap+0x7a>
ffffffffc02016e8:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02016ec:	6398                	ld	a4,0(a5)
}
ffffffffc02016ee:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc02016f0:	e390                	sd	a2,0(a5)
ffffffffc02016f2:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc02016f4:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02016f6:	ed18                	sd	a4,24(a0)
ffffffffc02016f8:	0141                	addi	sp,sp,16
ffffffffc02016fa:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc02016fc:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc02016fe:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201700:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201702:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0201704:	00d70663          	beq	a4,a3,ffffffffc0201710 <default_init_memmap+0x9e>
    prev->next = next->prev = elm;
ffffffffc0201708:	8832                	mv	a6,a2
ffffffffc020170a:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc020170c:	87ba                	mv	a5,a4
ffffffffc020170e:	bfc1                	j	ffffffffc02016de <default_init_memmap+0x6c>
}
ffffffffc0201710:	60a2                	ld	ra,8(sp)
ffffffffc0201712:	e290                	sd	a2,0(a3)
ffffffffc0201714:	0141                	addi	sp,sp,16
ffffffffc0201716:	8082                	ret
ffffffffc0201718:	60a2                	ld	ra,8(sp)
ffffffffc020171a:	e390                	sd	a2,0(a5)
ffffffffc020171c:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020171e:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201720:	ed1c                	sd	a5,24(a0)
ffffffffc0201722:	0141                	addi	sp,sp,16
ffffffffc0201724:	8082                	ret
        assert(PageReserved(p));
ffffffffc0201726:	00001697          	auipc	a3,0x1
ffffffffc020172a:	55a68693          	addi	a3,a3,1370 # ffffffffc0202c80 <commands+0xa78>
ffffffffc020172e:	00001617          	auipc	a2,0x1
ffffffffc0201732:	1ca60613          	addi	a2,a2,458 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201736:	04900593          	li	a1,73
ffffffffc020173a:	00001517          	auipc	a0,0x1
ffffffffc020173e:	1d650513          	addi	a0,a0,470 # ffffffffc0202910 <commands+0x708>
ffffffffc0201742:	c97fe0ef          	jal	ra,ffffffffc02003d8 <__panic>
    assert(n > 0);
ffffffffc0201746:	00001697          	auipc	a3,0x1
ffffffffc020174a:	50a68693          	addi	a3,a3,1290 # ffffffffc0202c50 <commands+0xa48>
ffffffffc020174e:	00001617          	auipc	a2,0x1
ffffffffc0201752:	1aa60613          	addi	a2,a2,426 # ffffffffc02028f8 <commands+0x6f0>
ffffffffc0201756:	04600593          	li	a1,70
ffffffffc020175a:	00001517          	auipc	a0,0x1
ffffffffc020175e:	1b650513          	addi	a0,a0,438 # ffffffffc0202910 <commands+0x708>
ffffffffc0201762:	c77fe0ef          	jal	ra,ffffffffc02003d8 <__panic>

ffffffffc0201766 <alloc_pages>:
#include <intr.h>
#include <riscv.h>

/*保存当前中断状态，并在必要时禁用中断*/
static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc0201766:	100027f3          	csrr	a5,sstatus
ffffffffc020176a:	8b89                	andi	a5,a5,2
ffffffffc020176c:	e799                	bnez	a5,ffffffffc020177a <alloc_pages+0x14>
struct Page *alloc_pages(size_t n) {
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc020176e:	00006797          	auipc	a5,0x6
ffffffffc0201772:	d0a7b783          	ld	a5,-758(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc0201776:	6f9c                	ld	a5,24(a5)
ffffffffc0201778:	8782                	jr	a5
struct Page *alloc_pages(size_t n) {
ffffffffc020177a:	1141                	addi	sp,sp,-16
ffffffffc020177c:	e406                	sd	ra,8(sp)
ffffffffc020177e:	e022                	sd	s0,0(sp)
ffffffffc0201780:	842a                	mv	s0,a0
        intr_disable();
ffffffffc0201782:	8b8ff0ef          	jal	ra,ffffffffc020083a <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201786:	00006797          	auipc	a5,0x6
ffffffffc020178a:	cf27b783          	ld	a5,-782(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc020178e:	6f9c                	ld	a5,24(a5)
ffffffffc0201790:	8522                	mv	a0,s0
ffffffffc0201792:	9782                	jalr	a5
ffffffffc0201794:	842a                	mv	s0,a0
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
        intr_enable();
ffffffffc0201796:	89eff0ef          	jal	ra,ffffffffc0200834 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc020179a:	60a2                	ld	ra,8(sp)
ffffffffc020179c:	8522                	mv	a0,s0
ffffffffc020179e:	6402                	ld	s0,0(sp)
ffffffffc02017a0:	0141                	addi	sp,sp,16
ffffffffc02017a2:	8082                	ret

ffffffffc02017a4 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02017a4:	100027f3          	csrr	a5,sstatus
ffffffffc02017a8:	8b89                	andi	a5,a5,2
ffffffffc02017aa:	e799                	bnez	a5,ffffffffc02017b8 <free_pages+0x14>
// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc02017ac:	00006797          	auipc	a5,0x6
ffffffffc02017b0:	ccc7b783          	ld	a5,-820(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017b4:	739c                	ld	a5,32(a5)
ffffffffc02017b6:	8782                	jr	a5
void free_pages(struct Page *base, size_t n) {
ffffffffc02017b8:	1101                	addi	sp,sp,-32
ffffffffc02017ba:	ec06                	sd	ra,24(sp)
ffffffffc02017bc:	e822                	sd	s0,16(sp)
ffffffffc02017be:	e426                	sd	s1,8(sp)
ffffffffc02017c0:	842a                	mv	s0,a0
ffffffffc02017c2:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc02017c4:	876ff0ef          	jal	ra,ffffffffc020083a <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc02017c8:	00006797          	auipc	a5,0x6
ffffffffc02017cc:	cb07b783          	ld	a5,-848(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017d0:	739c                	ld	a5,32(a5)
ffffffffc02017d2:	85a6                	mv	a1,s1
ffffffffc02017d4:	8522                	mv	a0,s0
ffffffffc02017d6:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc02017d8:	6442                	ld	s0,16(sp)
ffffffffc02017da:	60e2                	ld	ra,24(sp)
ffffffffc02017dc:	64a2                	ld	s1,8(sp)
ffffffffc02017de:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc02017e0:	854ff06f          	j	ffffffffc0200834 <intr_enable>

ffffffffc02017e4 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02017e4:	100027f3          	csrr	a5,sstatus
ffffffffc02017e8:	8b89                	andi	a5,a5,2
ffffffffc02017ea:	e799                	bnez	a5,ffffffffc02017f8 <nr_free_pages+0x14>
size_t nr_free_pages(void) {
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc02017ec:	00006797          	auipc	a5,0x6
ffffffffc02017f0:	c8c7b783          	ld	a5,-884(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017f4:	779c                	ld	a5,40(a5)
ffffffffc02017f6:	8782                	jr	a5
size_t nr_free_pages(void) {
ffffffffc02017f8:	1141                	addi	sp,sp,-16
ffffffffc02017fa:	e406                	sd	ra,8(sp)
ffffffffc02017fc:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc02017fe:	83cff0ef          	jal	ra,ffffffffc020083a <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0201802:	00006797          	auipc	a5,0x6
ffffffffc0201806:	c767b783          	ld	a5,-906(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc020180a:	779c                	ld	a5,40(a5)
ffffffffc020180c:	9782                	jalr	a5
ffffffffc020180e:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201810:	824ff0ef          	jal	ra,ffffffffc0200834 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0201814:	60a2                	ld	ra,8(sp)
ffffffffc0201816:	8522                	mv	a0,s0
ffffffffc0201818:	6402                	ld	s0,0(sp)
ffffffffc020181a:	0141                	addi	sp,sp,16
ffffffffc020181c:	8082                	ret

ffffffffc020181e <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc020181e:	00001797          	auipc	a5,0x1
ffffffffc0201822:	48a78793          	addi	a5,a5,1162 # ffffffffc0202ca8 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0201826:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc0201828:	7179                	addi	sp,sp,-48
ffffffffc020182a:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020182c:	00001517          	auipc	a0,0x1
ffffffffc0201830:	4b450513          	addi	a0,a0,1204 # ffffffffc0202ce0 <default_pmm_manager+0x38>
    pmm_manager = &default_pmm_manager;
ffffffffc0201834:	00006417          	auipc	s0,0x6
ffffffffc0201838:	c4440413          	addi	s0,s0,-956 # ffffffffc0207478 <pmm_manager>
void pmm_init(void) {
ffffffffc020183c:	f406                	sd	ra,40(sp)
ffffffffc020183e:	ec26                	sd	s1,24(sp)
ffffffffc0201840:	e44e                	sd	s3,8(sp)
ffffffffc0201842:	e84a                	sd	s2,16(sp)
ffffffffc0201844:	e052                	sd	s4,0(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0201846:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0201848:	897fe0ef          	jal	ra,ffffffffc02000de <cprintf>
    pmm_manager->init();
ffffffffc020184c:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc020184e:	00006497          	auipc	s1,0x6
ffffffffc0201852:	c4248493          	addi	s1,s1,-958 # ffffffffc0207490 <va_pa_offset>
    pmm_manager->init();
ffffffffc0201856:	679c                	ld	a5,8(a5)
ffffffffc0201858:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc020185a:	57f5                	li	a5,-3
ffffffffc020185c:	07fa                	slli	a5,a5,0x1e
ffffffffc020185e:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc0201860:	fc1fe0ef          	jal	ra,ffffffffc0200820 <get_memory_base>
ffffffffc0201864:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc0201866:	fc5fe0ef          	jal	ra,ffffffffc020082a <get_memory_size>
    if (mem_size == 0) {
ffffffffc020186a:	16050163          	beqz	a0,ffffffffc02019cc <pmm_init+0x1ae>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc020186e:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc0201870:	00001517          	auipc	a0,0x1
ffffffffc0201874:	4b850513          	addi	a0,a0,1208 # ffffffffc0202d28 <default_pmm_manager+0x80>
ffffffffc0201878:	867fe0ef          	jal	ra,ffffffffc02000de <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc020187c:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc0201880:	864e                	mv	a2,s3
ffffffffc0201882:	fffa0693          	addi	a3,s4,-1
ffffffffc0201886:	85ca                	mv	a1,s2
ffffffffc0201888:	00001517          	auipc	a0,0x1
ffffffffc020188c:	4b850513          	addi	a0,a0,1208 # ffffffffc0202d40 <default_pmm_manager+0x98>
ffffffffc0201890:	84ffe0ef          	jal	ra,ffffffffc02000de <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0201894:	c80007b7          	lui	a5,0xc8000
ffffffffc0201898:	8652                	mv	a2,s4
ffffffffc020189a:	0d47e863          	bltu	a5,s4,ffffffffc020196a <pmm_init+0x14c>
ffffffffc020189e:	00007797          	auipc	a5,0x7
ffffffffc02018a2:	c0178793          	addi	a5,a5,-1023 # ffffffffc020849f <end+0xfff>
ffffffffc02018a6:	757d                	lui	a0,0xfffff
ffffffffc02018a8:	8d7d                	and	a0,a0,a5
ffffffffc02018aa:	8231                	srli	a2,a2,0xc
ffffffffc02018ac:	00006597          	auipc	a1,0x6
ffffffffc02018b0:	bbc58593          	addi	a1,a1,-1092 # ffffffffc0207468 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02018b4:	00006817          	auipc	a6,0x6
ffffffffc02018b8:	bbc80813          	addi	a6,a6,-1092 # ffffffffc0207470 <pages>
    npage = maxpa / PGSIZE;
ffffffffc02018bc:	e190                	sd	a2,0(a1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02018be:	00a83023          	sd	a0,0(a6)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc02018c2:	000807b7          	lui	a5,0x80
ffffffffc02018c6:	02f60663          	beq	a2,a5,ffffffffc02018f2 <pmm_init+0xd4>
ffffffffc02018ca:	4701                	li	a4,0
ffffffffc02018cc:	4781                	li	a5,0
ffffffffc02018ce:	4305                	li	t1,1
ffffffffc02018d0:	fff808b7          	lui	a7,0xfff80
        SetPageReserved(pages + i);
ffffffffc02018d4:	953a                	add	a0,a0,a4
ffffffffc02018d6:	00850693          	addi	a3,a0,8 # fffffffffffff008 <end+0x3fdf7b68>
ffffffffc02018da:	4066b02f          	amoor.d	zero,t1,(a3)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc02018de:	6190                	ld	a2,0(a1)
ffffffffc02018e0:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc02018e2:	00083503          	ld	a0,0(a6)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc02018e6:	011606b3          	add	a3,a2,a7
ffffffffc02018ea:	02870713          	addi	a4,a4,40
ffffffffc02018ee:	fed7e3e3          	bltu	a5,a3,ffffffffc02018d4 <pmm_init+0xb6>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02018f2:	00261693          	slli	a3,a2,0x2
ffffffffc02018f6:	96b2                	add	a3,a3,a2
ffffffffc02018f8:	fec007b7          	lui	a5,0xfec00
ffffffffc02018fc:	97aa                	add	a5,a5,a0
ffffffffc02018fe:	068e                	slli	a3,a3,0x3
ffffffffc0201900:	96be                	add	a3,a3,a5
ffffffffc0201902:	c02007b7          	lui	a5,0xc0200
ffffffffc0201906:	0af6e763          	bltu	a3,a5,ffffffffc02019b4 <pmm_init+0x196>
ffffffffc020190a:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc020190c:	77fd                	lui	a5,0xfffff
ffffffffc020190e:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0201912:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc0201914:	04b6ee63          	bltu	a3,a1,ffffffffc0201970 <pmm_init+0x152>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc0201918:	601c                	ld	a5,0(s0)
ffffffffc020191a:	7b9c                	ld	a5,48(a5)
ffffffffc020191c:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc020191e:	00001517          	auipc	a0,0x1
ffffffffc0201922:	4aa50513          	addi	a0,a0,1194 # ffffffffc0202dc8 <default_pmm_manager+0x120>
ffffffffc0201926:	fb8fe0ef          	jal	ra,ffffffffc02000de <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc020192a:	00004597          	auipc	a1,0x4
ffffffffc020192e:	6d658593          	addi	a1,a1,1750 # ffffffffc0206000 <boot_page_table_sv39>
ffffffffc0201932:	00006797          	auipc	a5,0x6
ffffffffc0201936:	b4b7bb23          	sd	a1,-1194(a5) # ffffffffc0207488 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc020193a:	c02007b7          	lui	a5,0xc0200
ffffffffc020193e:	0af5e363          	bltu	a1,a5,ffffffffc02019e4 <pmm_init+0x1c6>
ffffffffc0201942:	6090                	ld	a2,0(s1)
}
ffffffffc0201944:	7402                	ld	s0,32(sp)
ffffffffc0201946:	70a2                	ld	ra,40(sp)
ffffffffc0201948:	64e2                	ld	s1,24(sp)
ffffffffc020194a:	6942                	ld	s2,16(sp)
ffffffffc020194c:	69a2                	ld	s3,8(sp)
ffffffffc020194e:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc0201950:	40c58633          	sub	a2,a1,a2
ffffffffc0201954:	00006797          	auipc	a5,0x6
ffffffffc0201958:	b2c7b623          	sd	a2,-1236(a5) # ffffffffc0207480 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc020195c:	00001517          	auipc	a0,0x1
ffffffffc0201960:	48c50513          	addi	a0,a0,1164 # ffffffffc0202de8 <default_pmm_manager+0x140>
}
ffffffffc0201964:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0201966:	f78fe06f          	j	ffffffffc02000de <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc020196a:	c8000637          	lui	a2,0xc8000
ffffffffc020196e:	bf05                	j	ffffffffc020189e <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0201970:	6705                	lui	a4,0x1
ffffffffc0201972:	177d                	addi	a4,a4,-1
ffffffffc0201974:	96ba                	add	a3,a3,a4
ffffffffc0201976:	8efd                	and	a3,a3,a5
static inline int page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
ffffffffc0201978:	00c6d793          	srli	a5,a3,0xc
ffffffffc020197c:	02c7f063          	bgeu	a5,a2,ffffffffc020199c <pmm_init+0x17e>
    pmm_manager->init_memmap(base, n);
ffffffffc0201980:	6010                	ld	a2,0(s0)
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc0201982:	fff80737          	lui	a4,0xfff80
ffffffffc0201986:	973e                	add	a4,a4,a5
ffffffffc0201988:	00271793          	slli	a5,a4,0x2
ffffffffc020198c:	97ba                	add	a5,a5,a4
ffffffffc020198e:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0201990:	8d95                	sub	a1,a1,a3
ffffffffc0201992:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc0201994:	81b1                	srli	a1,a1,0xc
ffffffffc0201996:	953e                	add	a0,a0,a5
ffffffffc0201998:	9702                	jalr	a4
}
ffffffffc020199a:	bfbd                	j	ffffffffc0201918 <pmm_init+0xfa>
        panic("pa2page called with invalid pa");
ffffffffc020199c:	00001617          	auipc	a2,0x1
ffffffffc02019a0:	3fc60613          	addi	a2,a2,1020 # ffffffffc0202d98 <default_pmm_manager+0xf0>
ffffffffc02019a4:	06b00593          	li	a1,107
ffffffffc02019a8:	00001517          	auipc	a0,0x1
ffffffffc02019ac:	41050513          	addi	a0,a0,1040 # ffffffffc0202db8 <default_pmm_manager+0x110>
ffffffffc02019b0:	a29fe0ef          	jal	ra,ffffffffc02003d8 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02019b4:	00001617          	auipc	a2,0x1
ffffffffc02019b8:	3bc60613          	addi	a2,a2,956 # ffffffffc0202d70 <default_pmm_manager+0xc8>
ffffffffc02019bc:	07100593          	li	a1,113
ffffffffc02019c0:	00001517          	auipc	a0,0x1
ffffffffc02019c4:	35850513          	addi	a0,a0,856 # ffffffffc0202d18 <default_pmm_manager+0x70>
ffffffffc02019c8:	a11fe0ef          	jal	ra,ffffffffc02003d8 <__panic>
        panic("DTB memory info not available");
ffffffffc02019cc:	00001617          	auipc	a2,0x1
ffffffffc02019d0:	32c60613          	addi	a2,a2,812 # ffffffffc0202cf8 <default_pmm_manager+0x50>
ffffffffc02019d4:	05a00593          	li	a1,90
ffffffffc02019d8:	00001517          	auipc	a0,0x1
ffffffffc02019dc:	34050513          	addi	a0,a0,832 # ffffffffc0202d18 <default_pmm_manager+0x70>
ffffffffc02019e0:	9f9fe0ef          	jal	ra,ffffffffc02003d8 <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc02019e4:	86ae                	mv	a3,a1
ffffffffc02019e6:	00001617          	auipc	a2,0x1
ffffffffc02019ea:	38a60613          	addi	a2,a2,906 # ffffffffc0202d70 <default_pmm_manager+0xc8>
ffffffffc02019ee:	08c00593          	li	a1,140
ffffffffc02019f2:	00001517          	auipc	a0,0x1
ffffffffc02019f6:	32650513          	addi	a0,a0,806 # ffffffffc0202d18 <default_pmm_manager+0x70>
ffffffffc02019fa:	9dffe0ef          	jal	ra,ffffffffc02003d8 <__panic>

ffffffffc02019fe <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02019fe:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a02:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0201a04:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a08:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0201a0a:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a0e:	f022                	sd	s0,32(sp)
ffffffffc0201a10:	ec26                	sd	s1,24(sp)
ffffffffc0201a12:	e84a                	sd	s2,16(sp)
ffffffffc0201a14:	f406                	sd	ra,40(sp)
ffffffffc0201a16:	e44e                	sd	s3,8(sp)
ffffffffc0201a18:	84aa                	mv	s1,a0
ffffffffc0201a1a:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0201a1c:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0201a20:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc0201a22:	03067e63          	bgeu	a2,a6,ffffffffc0201a5e <printnum+0x60>
ffffffffc0201a26:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0201a28:	00805763          	blez	s0,ffffffffc0201a36 <printnum+0x38>
ffffffffc0201a2c:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0201a2e:	85ca                	mv	a1,s2
ffffffffc0201a30:	854e                	mv	a0,s3
ffffffffc0201a32:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc0201a34:	fc65                	bnez	s0,ffffffffc0201a2c <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a36:	1a02                	slli	s4,s4,0x20
ffffffffc0201a38:	00001797          	auipc	a5,0x1
ffffffffc0201a3c:	3f078793          	addi	a5,a5,1008 # ffffffffc0202e28 <default_pmm_manager+0x180>
ffffffffc0201a40:	020a5a13          	srli	s4,s4,0x20
ffffffffc0201a44:	9a3e                	add	s4,s4,a5
}
ffffffffc0201a46:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a48:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0201a4c:	70a2                	ld	ra,40(sp)
ffffffffc0201a4e:	69a2                	ld	s3,8(sp)
ffffffffc0201a50:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a52:	85ca                	mv	a1,s2
ffffffffc0201a54:	87a6                	mv	a5,s1
}
ffffffffc0201a56:	6942                	ld	s2,16(sp)
ffffffffc0201a58:	64e2                	ld	s1,24(sp)
ffffffffc0201a5a:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a5c:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0201a5e:	03065633          	divu	a2,a2,a6
ffffffffc0201a62:	8722                	mv	a4,s0
ffffffffc0201a64:	f9bff0ef          	jal	ra,ffffffffc02019fe <printnum>
ffffffffc0201a68:	b7f9                	j	ffffffffc0201a36 <printnum+0x38>

ffffffffc0201a6a <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0201a6a:	7119                	addi	sp,sp,-128
ffffffffc0201a6c:	f4a6                	sd	s1,104(sp)
ffffffffc0201a6e:	f0ca                	sd	s2,96(sp)
ffffffffc0201a70:	ecce                	sd	s3,88(sp)
ffffffffc0201a72:	e8d2                	sd	s4,80(sp)
ffffffffc0201a74:	e4d6                	sd	s5,72(sp)
ffffffffc0201a76:	e0da                	sd	s6,64(sp)
ffffffffc0201a78:	fc5e                	sd	s7,56(sp)
ffffffffc0201a7a:	f06a                	sd	s10,32(sp)
ffffffffc0201a7c:	fc86                	sd	ra,120(sp)
ffffffffc0201a7e:	f8a2                	sd	s0,112(sp)
ffffffffc0201a80:	f862                	sd	s8,48(sp)
ffffffffc0201a82:	f466                	sd	s9,40(sp)
ffffffffc0201a84:	ec6e                	sd	s11,24(sp)
ffffffffc0201a86:	892a                	mv	s2,a0
ffffffffc0201a88:	84ae                	mv	s1,a1
ffffffffc0201a8a:	8d32                	mv	s10,a2
ffffffffc0201a8c:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201a8e:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0201a92:	5b7d                	li	s6,-1
ffffffffc0201a94:	00001a97          	auipc	s5,0x1
ffffffffc0201a98:	3c8a8a93          	addi	s5,s5,968 # ffffffffc0202e5c <default_pmm_manager+0x1b4>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201a9c:	00001b97          	auipc	s7,0x1
ffffffffc0201aa0:	59cb8b93          	addi	s7,s7,1436 # ffffffffc0203038 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201aa4:	000d4503          	lbu	a0,0(s10)
ffffffffc0201aa8:	001d0413          	addi	s0,s10,1
ffffffffc0201aac:	01350a63          	beq	a0,s3,ffffffffc0201ac0 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0201ab0:	c121                	beqz	a0,ffffffffc0201af0 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0201ab2:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201ab4:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0201ab6:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201ab8:	fff44503          	lbu	a0,-1(s0)
ffffffffc0201abc:	ff351ae3          	bne	a0,s3,ffffffffc0201ab0 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201ac0:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0201ac4:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0201ac8:	4c81                	li	s9,0
ffffffffc0201aca:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0201acc:	5c7d                	li	s8,-1
ffffffffc0201ace:	5dfd                	li	s11,-1
ffffffffc0201ad0:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0201ad4:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201ad6:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201ada:	0ff5f593          	zext.b	a1,a1
ffffffffc0201ade:	00140d13          	addi	s10,s0,1
ffffffffc0201ae2:	04b56263          	bltu	a0,a1,ffffffffc0201b26 <vprintfmt+0xbc>
ffffffffc0201ae6:	058a                	slli	a1,a1,0x2
ffffffffc0201ae8:	95d6                	add	a1,a1,s5
ffffffffc0201aea:	4194                	lw	a3,0(a1)
ffffffffc0201aec:	96d6                	add	a3,a3,s5
ffffffffc0201aee:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0201af0:	70e6                	ld	ra,120(sp)
ffffffffc0201af2:	7446                	ld	s0,112(sp)
ffffffffc0201af4:	74a6                	ld	s1,104(sp)
ffffffffc0201af6:	7906                	ld	s2,96(sp)
ffffffffc0201af8:	69e6                	ld	s3,88(sp)
ffffffffc0201afa:	6a46                	ld	s4,80(sp)
ffffffffc0201afc:	6aa6                	ld	s5,72(sp)
ffffffffc0201afe:	6b06                	ld	s6,64(sp)
ffffffffc0201b00:	7be2                	ld	s7,56(sp)
ffffffffc0201b02:	7c42                	ld	s8,48(sp)
ffffffffc0201b04:	7ca2                	ld	s9,40(sp)
ffffffffc0201b06:	7d02                	ld	s10,32(sp)
ffffffffc0201b08:	6de2                	ld	s11,24(sp)
ffffffffc0201b0a:	6109                	addi	sp,sp,128
ffffffffc0201b0c:	8082                	ret
            padc = '0';
ffffffffc0201b0e:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0201b10:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b14:	846a                	mv	s0,s10
ffffffffc0201b16:	00140d13          	addi	s10,s0,1
ffffffffc0201b1a:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201b1e:	0ff5f593          	zext.b	a1,a1
ffffffffc0201b22:	fcb572e3          	bgeu	a0,a1,ffffffffc0201ae6 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0201b26:	85a6                	mv	a1,s1
ffffffffc0201b28:	02500513          	li	a0,37
ffffffffc0201b2c:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0201b2e:	fff44783          	lbu	a5,-1(s0)
ffffffffc0201b32:	8d22                	mv	s10,s0
ffffffffc0201b34:	f73788e3          	beq	a5,s3,ffffffffc0201aa4 <vprintfmt+0x3a>
ffffffffc0201b38:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0201b3c:	1d7d                	addi	s10,s10,-1
ffffffffc0201b3e:	ff379de3          	bne	a5,s3,ffffffffc0201b38 <vprintfmt+0xce>
ffffffffc0201b42:	b78d                	j	ffffffffc0201aa4 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc0201b44:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0201b48:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b4c:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0201b4e:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0201b52:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201b56:	02d86463          	bltu	a6,a3,ffffffffc0201b7e <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0201b5a:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0201b5e:	002c169b          	slliw	a3,s8,0x2
ffffffffc0201b62:	0186873b          	addw	a4,a3,s8
ffffffffc0201b66:	0017171b          	slliw	a4,a4,0x1
ffffffffc0201b6a:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0201b6c:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0201b70:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0201b72:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0201b76:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201b7a:	fed870e3          	bgeu	a6,a3,ffffffffc0201b5a <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0201b7e:	f40ddce3          	bgez	s11,ffffffffc0201ad6 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0201b82:	8de2                	mv	s11,s8
ffffffffc0201b84:	5c7d                	li	s8,-1
ffffffffc0201b86:	bf81                	j	ffffffffc0201ad6 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0201b88:	fffdc693          	not	a3,s11
ffffffffc0201b8c:	96fd                	srai	a3,a3,0x3f
ffffffffc0201b8e:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b92:	00144603          	lbu	a2,1(s0)
ffffffffc0201b96:	2d81                	sext.w	s11,s11
ffffffffc0201b98:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201b9a:	bf35                	j	ffffffffc0201ad6 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0201b9c:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201ba0:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0201ba4:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201ba6:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0201ba8:	bfd9                	j	ffffffffc0201b7e <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0201baa:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201bac:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201bb0:	01174463          	blt	a4,a7,ffffffffc0201bb8 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0201bb4:	1a088e63          	beqz	a7,ffffffffc0201d70 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0201bb8:	000a3603          	ld	a2,0(s4)
ffffffffc0201bbc:	46c1                	li	a3,16
ffffffffc0201bbe:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0201bc0:	2781                	sext.w	a5,a5
ffffffffc0201bc2:	876e                	mv	a4,s11
ffffffffc0201bc4:	85a6                	mv	a1,s1
ffffffffc0201bc6:	854a                	mv	a0,s2
ffffffffc0201bc8:	e37ff0ef          	jal	ra,ffffffffc02019fe <printnum>
            break;
ffffffffc0201bcc:	bde1                	j	ffffffffc0201aa4 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0201bce:	000a2503          	lw	a0,0(s4)
ffffffffc0201bd2:	85a6                	mv	a1,s1
ffffffffc0201bd4:	0a21                	addi	s4,s4,8
ffffffffc0201bd6:	9902                	jalr	s2
            break;
ffffffffc0201bd8:	b5f1                	j	ffffffffc0201aa4 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201bda:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201bdc:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201be0:	01174463          	blt	a4,a7,ffffffffc0201be8 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0201be4:	18088163          	beqz	a7,ffffffffc0201d66 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0201be8:	000a3603          	ld	a2,0(s4)
ffffffffc0201bec:	46a9                	li	a3,10
ffffffffc0201bee:	8a2e                	mv	s4,a1
ffffffffc0201bf0:	bfc1                	j	ffffffffc0201bc0 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bf2:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0201bf6:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bf8:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201bfa:	bdf1                	j	ffffffffc0201ad6 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0201bfc:	85a6                	mv	a1,s1
ffffffffc0201bfe:	02500513          	li	a0,37
ffffffffc0201c02:	9902                	jalr	s2
            break;
ffffffffc0201c04:	b545                	j	ffffffffc0201aa4 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c06:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0201c0a:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c0c:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201c0e:	b5e1                	j	ffffffffc0201ad6 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0201c10:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201c12:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201c16:	01174463          	blt	a4,a7,ffffffffc0201c1e <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0201c1a:	14088163          	beqz	a7,ffffffffc0201d5c <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0201c1e:	000a3603          	ld	a2,0(s4)
ffffffffc0201c22:	46a1                	li	a3,8
ffffffffc0201c24:	8a2e                	mv	s4,a1
ffffffffc0201c26:	bf69                	j	ffffffffc0201bc0 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0201c28:	03000513          	li	a0,48
ffffffffc0201c2c:	85a6                	mv	a1,s1
ffffffffc0201c2e:	e03e                	sd	a5,0(sp)
ffffffffc0201c30:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0201c32:	85a6                	mv	a1,s1
ffffffffc0201c34:	07800513          	li	a0,120
ffffffffc0201c38:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201c3a:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0201c3c:	6782                	ld	a5,0(sp)
ffffffffc0201c3e:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201c40:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0201c44:	bfb5                	j	ffffffffc0201bc0 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201c46:	000a3403          	ld	s0,0(s4)
ffffffffc0201c4a:	008a0713          	addi	a4,s4,8
ffffffffc0201c4e:	e03a                	sd	a4,0(sp)
ffffffffc0201c50:	14040263          	beqz	s0,ffffffffc0201d94 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0201c54:	0fb05763          	blez	s11,ffffffffc0201d42 <vprintfmt+0x2d8>
ffffffffc0201c58:	02d00693          	li	a3,45
ffffffffc0201c5c:	0cd79163          	bne	a5,a3,ffffffffc0201d1e <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201c60:	00044783          	lbu	a5,0(s0)
ffffffffc0201c64:	0007851b          	sext.w	a0,a5
ffffffffc0201c68:	cf85                	beqz	a5,ffffffffc0201ca0 <vprintfmt+0x236>
ffffffffc0201c6a:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201c6e:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201c72:	000c4563          	bltz	s8,ffffffffc0201c7c <vprintfmt+0x212>
ffffffffc0201c76:	3c7d                	addiw	s8,s8,-1
ffffffffc0201c78:	036c0263          	beq	s8,s6,ffffffffc0201c9c <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0201c7c:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201c7e:	0e0c8e63          	beqz	s9,ffffffffc0201d7a <vprintfmt+0x310>
ffffffffc0201c82:	3781                	addiw	a5,a5,-32
ffffffffc0201c84:	0ef47b63          	bgeu	s0,a5,ffffffffc0201d7a <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0201c88:	03f00513          	li	a0,63
ffffffffc0201c8c:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201c8e:	000a4783          	lbu	a5,0(s4)
ffffffffc0201c92:	3dfd                	addiw	s11,s11,-1
ffffffffc0201c94:	0a05                	addi	s4,s4,1
ffffffffc0201c96:	0007851b          	sext.w	a0,a5
ffffffffc0201c9a:	ffe1                	bnez	a5,ffffffffc0201c72 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0201c9c:	01b05963          	blez	s11,ffffffffc0201cae <vprintfmt+0x244>
ffffffffc0201ca0:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0201ca2:	85a6                	mv	a1,s1
ffffffffc0201ca4:	02000513          	li	a0,32
ffffffffc0201ca8:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0201caa:	fe0d9be3          	bnez	s11,ffffffffc0201ca0 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201cae:	6a02                	ld	s4,0(sp)
ffffffffc0201cb0:	bbd5                	j	ffffffffc0201aa4 <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201cb2:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201cb4:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0201cb8:	01174463          	blt	a4,a7,ffffffffc0201cc0 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0201cbc:	08088d63          	beqz	a7,ffffffffc0201d56 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0201cc0:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0201cc4:	0a044d63          	bltz	s0,ffffffffc0201d7e <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0201cc8:	8622                	mv	a2,s0
ffffffffc0201cca:	8a66                	mv	s4,s9
ffffffffc0201ccc:	46a9                	li	a3,10
ffffffffc0201cce:	bdcd                	j	ffffffffc0201bc0 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0201cd0:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201cd4:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc0201cd6:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0201cd8:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0201cdc:	8fb5                	xor	a5,a5,a3
ffffffffc0201cde:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201ce2:	02d74163          	blt	a4,a3,ffffffffc0201d04 <vprintfmt+0x29a>
ffffffffc0201ce6:	00369793          	slli	a5,a3,0x3
ffffffffc0201cea:	97de                	add	a5,a5,s7
ffffffffc0201cec:	639c                	ld	a5,0(a5)
ffffffffc0201cee:	cb99                	beqz	a5,ffffffffc0201d04 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0201cf0:	86be                	mv	a3,a5
ffffffffc0201cf2:	00001617          	auipc	a2,0x1
ffffffffc0201cf6:	16660613          	addi	a2,a2,358 # ffffffffc0202e58 <default_pmm_manager+0x1b0>
ffffffffc0201cfa:	85a6                	mv	a1,s1
ffffffffc0201cfc:	854a                	mv	a0,s2
ffffffffc0201cfe:	0ce000ef          	jal	ra,ffffffffc0201dcc <printfmt>
ffffffffc0201d02:	b34d                	j	ffffffffc0201aa4 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0201d04:	00001617          	auipc	a2,0x1
ffffffffc0201d08:	14460613          	addi	a2,a2,324 # ffffffffc0202e48 <default_pmm_manager+0x1a0>
ffffffffc0201d0c:	85a6                	mv	a1,s1
ffffffffc0201d0e:	854a                	mv	a0,s2
ffffffffc0201d10:	0bc000ef          	jal	ra,ffffffffc0201dcc <printfmt>
ffffffffc0201d14:	bb41                	j	ffffffffc0201aa4 <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0201d16:	00001417          	auipc	s0,0x1
ffffffffc0201d1a:	12a40413          	addi	s0,s0,298 # ffffffffc0202e40 <default_pmm_manager+0x198>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d1e:	85e2                	mv	a1,s8
ffffffffc0201d20:	8522                	mv	a0,s0
ffffffffc0201d22:	e43e                	sd	a5,8(sp)
ffffffffc0201d24:	200000ef          	jal	ra,ffffffffc0201f24 <strnlen>
ffffffffc0201d28:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0201d2c:	01b05b63          	blez	s11,ffffffffc0201d42 <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0201d30:	67a2                	ld	a5,8(sp)
ffffffffc0201d32:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d36:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0201d38:	85a6                	mv	a1,s1
ffffffffc0201d3a:	8552                	mv	a0,s4
ffffffffc0201d3c:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d3e:	fe0d9ce3          	bnez	s11,ffffffffc0201d36 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201d42:	00044783          	lbu	a5,0(s0)
ffffffffc0201d46:	00140a13          	addi	s4,s0,1
ffffffffc0201d4a:	0007851b          	sext.w	a0,a5
ffffffffc0201d4e:	d3a5                	beqz	a5,ffffffffc0201cae <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201d50:	05e00413          	li	s0,94
ffffffffc0201d54:	bf39                	j	ffffffffc0201c72 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0201d56:	000a2403          	lw	s0,0(s4)
ffffffffc0201d5a:	b7ad                	j	ffffffffc0201cc4 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0201d5c:	000a6603          	lwu	a2,0(s4)
ffffffffc0201d60:	46a1                	li	a3,8
ffffffffc0201d62:	8a2e                	mv	s4,a1
ffffffffc0201d64:	bdb1                	j	ffffffffc0201bc0 <vprintfmt+0x156>
ffffffffc0201d66:	000a6603          	lwu	a2,0(s4)
ffffffffc0201d6a:	46a9                	li	a3,10
ffffffffc0201d6c:	8a2e                	mv	s4,a1
ffffffffc0201d6e:	bd89                	j	ffffffffc0201bc0 <vprintfmt+0x156>
ffffffffc0201d70:	000a6603          	lwu	a2,0(s4)
ffffffffc0201d74:	46c1                	li	a3,16
ffffffffc0201d76:	8a2e                	mv	s4,a1
ffffffffc0201d78:	b5a1                	j	ffffffffc0201bc0 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0201d7a:	9902                	jalr	s2
ffffffffc0201d7c:	bf09                	j	ffffffffc0201c8e <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0201d7e:	85a6                	mv	a1,s1
ffffffffc0201d80:	02d00513          	li	a0,45
ffffffffc0201d84:	e03e                	sd	a5,0(sp)
ffffffffc0201d86:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0201d88:	6782                	ld	a5,0(sp)
ffffffffc0201d8a:	8a66                	mv	s4,s9
ffffffffc0201d8c:	40800633          	neg	a2,s0
ffffffffc0201d90:	46a9                	li	a3,10
ffffffffc0201d92:	b53d                	j	ffffffffc0201bc0 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0201d94:	03b05163          	blez	s11,ffffffffc0201db6 <vprintfmt+0x34c>
ffffffffc0201d98:	02d00693          	li	a3,45
ffffffffc0201d9c:	f6d79de3          	bne	a5,a3,ffffffffc0201d16 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0201da0:	00001417          	auipc	s0,0x1
ffffffffc0201da4:	0a040413          	addi	s0,s0,160 # ffffffffc0202e40 <default_pmm_manager+0x198>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201da8:	02800793          	li	a5,40
ffffffffc0201dac:	02800513          	li	a0,40
ffffffffc0201db0:	00140a13          	addi	s4,s0,1
ffffffffc0201db4:	bd6d                	j	ffffffffc0201c6e <vprintfmt+0x204>
ffffffffc0201db6:	00001a17          	auipc	s4,0x1
ffffffffc0201dba:	08ba0a13          	addi	s4,s4,139 # ffffffffc0202e41 <default_pmm_manager+0x199>
ffffffffc0201dbe:	02800513          	li	a0,40
ffffffffc0201dc2:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201dc6:	05e00413          	li	s0,94
ffffffffc0201dca:	b565                	j	ffffffffc0201c72 <vprintfmt+0x208>

ffffffffc0201dcc <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201dcc:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0201dce:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201dd2:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201dd4:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201dd6:	ec06                	sd	ra,24(sp)
ffffffffc0201dd8:	f83a                	sd	a4,48(sp)
ffffffffc0201dda:	fc3e                	sd	a5,56(sp)
ffffffffc0201ddc:	e0c2                	sd	a6,64(sp)
ffffffffc0201dde:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0201de0:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201de2:	c89ff0ef          	jal	ra,ffffffffc0201a6a <vprintfmt>
}
ffffffffc0201de6:	60e2                	ld	ra,24(sp)
ffffffffc0201de8:	6161                	addi	sp,sp,80
ffffffffc0201dea:	8082                	ret

ffffffffc0201dec <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc0201dec:	715d                	addi	sp,sp,-80
ffffffffc0201dee:	e486                	sd	ra,72(sp)
ffffffffc0201df0:	e0a6                	sd	s1,64(sp)
ffffffffc0201df2:	fc4a                	sd	s2,56(sp)
ffffffffc0201df4:	f84e                	sd	s3,48(sp)
ffffffffc0201df6:	f452                	sd	s4,40(sp)
ffffffffc0201df8:	f056                	sd	s5,32(sp)
ffffffffc0201dfa:	ec5a                	sd	s6,24(sp)
ffffffffc0201dfc:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc0201dfe:	c901                	beqz	a0,ffffffffc0201e0e <readline+0x22>
ffffffffc0201e00:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc0201e02:	00001517          	auipc	a0,0x1
ffffffffc0201e06:	05650513          	addi	a0,a0,86 # ffffffffc0202e58 <default_pmm_manager+0x1b0>
ffffffffc0201e0a:	ad4fe0ef          	jal	ra,ffffffffc02000de <cprintf>
readline(const char *prompt) {
ffffffffc0201e0e:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e10:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0201e12:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0201e14:	4aa9                	li	s5,10
ffffffffc0201e16:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc0201e18:	00005b97          	auipc	s7,0x5
ffffffffc0201e1c:	228b8b93          	addi	s7,s7,552 # ffffffffc0207040 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e20:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc0201e24:	b32fe0ef          	jal	ra,ffffffffc0200156 <getchar>
        if (c < 0) {
ffffffffc0201e28:	00054a63          	bltz	a0,ffffffffc0201e3c <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e2c:	00a95a63          	bge	s2,a0,ffffffffc0201e40 <readline+0x54>
ffffffffc0201e30:	029a5263          	bge	s4,s1,ffffffffc0201e54 <readline+0x68>
        c = getchar();
ffffffffc0201e34:	b22fe0ef          	jal	ra,ffffffffc0200156 <getchar>
        if (c < 0) {
ffffffffc0201e38:	fe055ae3          	bgez	a0,ffffffffc0201e2c <readline+0x40>
            return NULL;
ffffffffc0201e3c:	4501                	li	a0,0
ffffffffc0201e3e:	a091                	j	ffffffffc0201e82 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc0201e40:	03351463          	bne	a0,s3,ffffffffc0201e68 <readline+0x7c>
ffffffffc0201e44:	e8a9                	bnez	s1,ffffffffc0201e96 <readline+0xaa>
        c = getchar();
ffffffffc0201e46:	b10fe0ef          	jal	ra,ffffffffc0200156 <getchar>
        if (c < 0) {
ffffffffc0201e4a:	fe0549e3          	bltz	a0,ffffffffc0201e3c <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e4e:	fea959e3          	bge	s2,a0,ffffffffc0201e40 <readline+0x54>
ffffffffc0201e52:	4481                	li	s1,0
            cputchar(c);
ffffffffc0201e54:	e42a                	sd	a0,8(sp)
ffffffffc0201e56:	abefe0ef          	jal	ra,ffffffffc0200114 <cputchar>
            buf[i ++] = c;
ffffffffc0201e5a:	6522                	ld	a0,8(sp)
ffffffffc0201e5c:	009b87b3          	add	a5,s7,s1
ffffffffc0201e60:	2485                	addiw	s1,s1,1
ffffffffc0201e62:	00a78023          	sb	a0,0(a5)
ffffffffc0201e66:	bf7d                	j	ffffffffc0201e24 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0201e68:	01550463          	beq	a0,s5,ffffffffc0201e70 <readline+0x84>
ffffffffc0201e6c:	fb651ce3          	bne	a0,s6,ffffffffc0201e24 <readline+0x38>
            cputchar(c);
ffffffffc0201e70:	aa4fe0ef          	jal	ra,ffffffffc0200114 <cputchar>
            buf[i] = '\0';
ffffffffc0201e74:	00005517          	auipc	a0,0x5
ffffffffc0201e78:	1cc50513          	addi	a0,a0,460 # ffffffffc0207040 <buf>
ffffffffc0201e7c:	94aa                	add	s1,s1,a0
ffffffffc0201e7e:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc0201e82:	60a6                	ld	ra,72(sp)
ffffffffc0201e84:	6486                	ld	s1,64(sp)
ffffffffc0201e86:	7962                	ld	s2,56(sp)
ffffffffc0201e88:	79c2                	ld	s3,48(sp)
ffffffffc0201e8a:	7a22                	ld	s4,40(sp)
ffffffffc0201e8c:	7a82                	ld	s5,32(sp)
ffffffffc0201e8e:	6b62                	ld	s6,24(sp)
ffffffffc0201e90:	6bc2                	ld	s7,16(sp)
ffffffffc0201e92:	6161                	addi	sp,sp,80
ffffffffc0201e94:	8082                	ret
            cputchar(c);
ffffffffc0201e96:	4521                	li	a0,8
ffffffffc0201e98:	a7cfe0ef          	jal	ra,ffffffffc0200114 <cputchar>
            i --;
ffffffffc0201e9c:	34fd                	addiw	s1,s1,-1
ffffffffc0201e9e:	b759                	j	ffffffffc0201e24 <readline+0x38>

ffffffffc0201ea0 <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc0201ea0:	4781                	li	a5,0
ffffffffc0201ea2:	00005717          	auipc	a4,0x5
ffffffffc0201ea6:	17673703          	ld	a4,374(a4) # ffffffffc0207018 <SBI_CONSOLE_PUTCHAR>
ffffffffc0201eaa:	88ba                	mv	a7,a4
ffffffffc0201eac:	852a                	mv	a0,a0
ffffffffc0201eae:	85be                	mv	a1,a5
ffffffffc0201eb0:	863e                	mv	a2,a5
ffffffffc0201eb2:	00000073          	ecall
ffffffffc0201eb6:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc0201eb8:	8082                	ret

ffffffffc0201eba <sbi_set_timer>:
    __asm__ volatile (
ffffffffc0201eba:	4781                	li	a5,0
ffffffffc0201ebc:	00005717          	auipc	a4,0x5
ffffffffc0201ec0:	5dc73703          	ld	a4,1500(a4) # ffffffffc0207498 <SBI_SET_TIMER>
ffffffffc0201ec4:	88ba                	mv	a7,a4
ffffffffc0201ec6:	852a                	mv	a0,a0
ffffffffc0201ec8:	85be                	mv	a1,a5
ffffffffc0201eca:	863e                	mv	a2,a5
ffffffffc0201ecc:	00000073          	ecall
ffffffffc0201ed0:	87aa                	mv	a5,a0

void sbi_set_timer(unsigned long long stime_value) {
    sbi_call(SBI_SET_TIMER, stime_value, 0, 0);
}
ffffffffc0201ed2:	8082                	ret

ffffffffc0201ed4 <sbi_console_getchar>:
    __asm__ volatile (
ffffffffc0201ed4:	4501                	li	a0,0
ffffffffc0201ed6:	00005797          	auipc	a5,0x5
ffffffffc0201eda:	13a7b783          	ld	a5,314(a5) # ffffffffc0207010 <SBI_CONSOLE_GETCHAR>
ffffffffc0201ede:	88be                	mv	a7,a5
ffffffffc0201ee0:	852a                	mv	a0,a0
ffffffffc0201ee2:	85aa                	mv	a1,a0
ffffffffc0201ee4:	862a                	mv	a2,a0
ffffffffc0201ee6:	00000073          	ecall
ffffffffc0201eea:	852a                	mv	a0,a0

int sbi_console_getchar(void) {
    return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
}
ffffffffc0201eec:	2501                	sext.w	a0,a0
ffffffffc0201eee:	8082                	ret

ffffffffc0201ef0 <sbi_shutdown>:
    __asm__ volatile (
ffffffffc0201ef0:	4781                	li	a5,0
ffffffffc0201ef2:	00005717          	auipc	a4,0x5
ffffffffc0201ef6:	12e73703          	ld	a4,302(a4) # ffffffffc0207020 <SBI_SHUTDOWN>
ffffffffc0201efa:	88ba                	mv	a7,a4
ffffffffc0201efc:	853e                	mv	a0,a5
ffffffffc0201efe:	85be                	mv	a1,a5
ffffffffc0201f00:	863e                	mv	a2,a5
ffffffffc0201f02:	00000073          	ecall
ffffffffc0201f06:	87aa                	mv	a5,a0

void sbi_shutdown(void)
{
	sbi_call(SBI_SHUTDOWN, 0, 0, 0);
ffffffffc0201f08:	8082                	ret

ffffffffc0201f0a <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0201f0a:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0201f0e:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0201f10:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0201f12:	cb81                	beqz	a5,ffffffffc0201f22 <strlen+0x18>
        cnt ++;
ffffffffc0201f14:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc0201f16:	00a707b3          	add	a5,a4,a0
ffffffffc0201f1a:	0007c783          	lbu	a5,0(a5)
ffffffffc0201f1e:	fbfd                	bnez	a5,ffffffffc0201f14 <strlen+0xa>
ffffffffc0201f20:	8082                	ret
    }
    return cnt;
}
ffffffffc0201f22:	8082                	ret

ffffffffc0201f24 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc0201f24:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f26:	e589                	bnez	a1,ffffffffc0201f30 <strnlen+0xc>
ffffffffc0201f28:	a811                	j	ffffffffc0201f3c <strnlen+0x18>
        cnt ++;
ffffffffc0201f2a:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f2c:	00f58863          	beq	a1,a5,ffffffffc0201f3c <strnlen+0x18>
ffffffffc0201f30:	00f50733          	add	a4,a0,a5
ffffffffc0201f34:	00074703          	lbu	a4,0(a4)
ffffffffc0201f38:	fb6d                	bnez	a4,ffffffffc0201f2a <strnlen+0x6>
ffffffffc0201f3a:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0201f3c:	852e                	mv	a0,a1
ffffffffc0201f3e:	8082                	ret

ffffffffc0201f40 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f40:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f44:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f48:	cb89                	beqz	a5,ffffffffc0201f5a <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0201f4a:	0505                	addi	a0,a0,1
ffffffffc0201f4c:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f4e:	fee789e3          	beq	a5,a4,ffffffffc0201f40 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f52:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0201f56:	9d19                	subw	a0,a0,a4
ffffffffc0201f58:	8082                	ret
ffffffffc0201f5a:	4501                	li	a0,0
ffffffffc0201f5c:	bfed                	j	ffffffffc0201f56 <strcmp+0x16>

ffffffffc0201f5e <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201f5e:	c20d                	beqz	a2,ffffffffc0201f80 <strncmp+0x22>
ffffffffc0201f60:	962e                	add	a2,a2,a1
ffffffffc0201f62:	a031                	j	ffffffffc0201f6e <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc0201f64:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201f66:	00e79a63          	bne	a5,a4,ffffffffc0201f7a <strncmp+0x1c>
ffffffffc0201f6a:	00b60b63          	beq	a2,a1,ffffffffc0201f80 <strncmp+0x22>
ffffffffc0201f6e:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc0201f72:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201f74:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0201f78:	f7f5                	bnez	a5,ffffffffc0201f64 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f7a:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0201f7e:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f80:	4501                	li	a0,0
ffffffffc0201f82:	8082                	ret

ffffffffc0201f84 <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc0201f84:	00054783          	lbu	a5,0(a0)
ffffffffc0201f88:	c799                	beqz	a5,ffffffffc0201f96 <strchr+0x12>
        if (*s == c) {
ffffffffc0201f8a:	00f58763          	beq	a1,a5,ffffffffc0201f98 <strchr+0x14>
    while (*s != '\0') {
ffffffffc0201f8e:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc0201f92:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc0201f94:	fbfd                	bnez	a5,ffffffffc0201f8a <strchr+0x6>
    }
    return NULL;
ffffffffc0201f96:	4501                	li	a0,0
}
ffffffffc0201f98:	8082                	ret

ffffffffc0201f9a <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0201f9a:	ca01                	beqz	a2,ffffffffc0201faa <memset+0x10>
ffffffffc0201f9c:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0201f9e:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0201fa0:	0785                	addi	a5,a5,1
ffffffffc0201fa2:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0201fa6:	fec79de3          	bne	a5,a2,ffffffffc0201fa0 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0201faa:	8082                	ret
