
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	0000b297          	auipc	t0,0xb
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc020b000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	0000b297          	auipc	t0,0xb
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc020b008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c020a2b7          	lui	t0,0xc020a
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
ffffffffc020003c:	c020a137          	lui	sp,0xc020a

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
    jr t0
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
void grade_backtrace(void);

int kern_init(void)
{
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc020004a:	000a6517          	auipc	a0,0xa6
ffffffffc020004e:	27e50513          	addi	a0,a0,638 # ffffffffc02a62c8 <buf>
ffffffffc0200052:	000aa617          	auipc	a2,0xaa
ffffffffc0200056:	71a60613          	addi	a2,a2,1818 # ffffffffc02aa76c <end>
{
ffffffffc020005a:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
{
ffffffffc0200060:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc0200062:	616050ef          	jal	ra,ffffffffc0205678 <memset>
    dtb_init();
ffffffffc0200066:	598000ef          	jal	ra,ffffffffc02005fe <dtb_init>
    cons_init(); // init the console
ffffffffc020006a:	522000ef          	jal	ra,ffffffffc020058c <cons_init>

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);
ffffffffc020006e:	00005597          	auipc	a1,0x5
ffffffffc0200072:	63a58593          	addi	a1,a1,1594 # ffffffffc02056a8 <etext+0x6>
ffffffffc0200076:	00005517          	auipc	a0,0x5
ffffffffc020007a:	65250513          	addi	a0,a0,1618 # ffffffffc02056c8 <etext+0x26>
ffffffffc020007e:	116000ef          	jal	ra,ffffffffc0200194 <cprintf>

    print_kerninfo();
ffffffffc0200082:	19a000ef          	jal	ra,ffffffffc020021c <print_kerninfo>

    // grade_backtrace();

    pmm_init(); // init physical memory management
ffffffffc0200086:	690020ef          	jal	ra,ffffffffc0202716 <pmm_init>

    pic_init(); // init interrupt controller
ffffffffc020008a:	131000ef          	jal	ra,ffffffffc02009ba <pic_init>
    idt_init(); // init interrupt descriptor table
ffffffffc020008e:	12f000ef          	jal	ra,ffffffffc02009bc <idt_init>

    vmm_init();  // init virtual memory management
ffffffffc0200092:	191030ef          	jal	ra,ffffffffc0203a22 <vmm_init>
    proc_init(); // init process table
ffffffffc0200096:	535040ef          	jal	ra,ffffffffc0204dca <proc_init>

    clock_init();  // init clock interrupt
ffffffffc020009a:	4a0000ef          	jal	ra,ffffffffc020053a <clock_init>
    intr_enable(); // enable irq interrupt
ffffffffc020009e:	111000ef          	jal	ra,ffffffffc02009ae <intr_enable>

    cpu_idle(); // run idle process
ffffffffc02000a2:	6c1040ef          	jal	ra,ffffffffc0204f62 <cpu_idle>

ffffffffc02000a6 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc02000a6:	715d                	addi	sp,sp,-80
ffffffffc02000a8:	e486                	sd	ra,72(sp)
ffffffffc02000aa:	e0a6                	sd	s1,64(sp)
ffffffffc02000ac:	fc4a                	sd	s2,56(sp)
ffffffffc02000ae:	f84e                	sd	s3,48(sp)
ffffffffc02000b0:	f452                	sd	s4,40(sp)
ffffffffc02000b2:	f056                	sd	s5,32(sp)
ffffffffc02000b4:	ec5a                	sd	s6,24(sp)
ffffffffc02000b6:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc02000b8:	c901                	beqz	a0,ffffffffc02000c8 <readline+0x22>
ffffffffc02000ba:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc02000bc:	00005517          	auipc	a0,0x5
ffffffffc02000c0:	61450513          	addi	a0,a0,1556 # ffffffffc02056d0 <etext+0x2e>
ffffffffc02000c4:	0d0000ef          	jal	ra,ffffffffc0200194 <cprintf>
readline(const char *prompt) {
ffffffffc02000c8:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000ca:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc02000cc:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc02000ce:	4aa9                	li	s5,10
ffffffffc02000d0:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc02000d2:	000a6b97          	auipc	s7,0xa6
ffffffffc02000d6:	1f6b8b93          	addi	s7,s7,502 # ffffffffc02a62c8 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000da:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc02000de:	12e000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc02000e2:	00054a63          	bltz	a0,ffffffffc02000f6 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000e6:	00a95a63          	bge	s2,a0,ffffffffc02000fa <readline+0x54>
ffffffffc02000ea:	029a5263          	bge	s4,s1,ffffffffc020010e <readline+0x68>
        c = getchar();
ffffffffc02000ee:	11e000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc02000f2:	fe055ae3          	bgez	a0,ffffffffc02000e6 <readline+0x40>
            return NULL;
ffffffffc02000f6:	4501                	li	a0,0
ffffffffc02000f8:	a091                	j	ffffffffc020013c <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02000fa:	03351463          	bne	a0,s3,ffffffffc0200122 <readline+0x7c>
ffffffffc02000fe:	e8a9                	bnez	s1,ffffffffc0200150 <readline+0xaa>
        c = getchar();
ffffffffc0200100:	10c000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc0200104:	fe0549e3          	bltz	a0,ffffffffc02000f6 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200108:	fea959e3          	bge	s2,a0,ffffffffc02000fa <readline+0x54>
ffffffffc020010c:	4481                	li	s1,0
            cputchar(c);
ffffffffc020010e:	e42a                	sd	a0,8(sp)
ffffffffc0200110:	0ba000ef          	jal	ra,ffffffffc02001ca <cputchar>
            buf[i ++] = c;
ffffffffc0200114:	6522                	ld	a0,8(sp)
ffffffffc0200116:	009b87b3          	add	a5,s7,s1
ffffffffc020011a:	2485                	addiw	s1,s1,1
ffffffffc020011c:	00a78023          	sb	a0,0(a5)
ffffffffc0200120:	bf7d                	j	ffffffffc02000de <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0200122:	01550463          	beq	a0,s5,ffffffffc020012a <readline+0x84>
ffffffffc0200126:	fb651ce3          	bne	a0,s6,ffffffffc02000de <readline+0x38>
            cputchar(c);
ffffffffc020012a:	0a0000ef          	jal	ra,ffffffffc02001ca <cputchar>
            buf[i] = '\0';
ffffffffc020012e:	000a6517          	auipc	a0,0xa6
ffffffffc0200132:	19a50513          	addi	a0,a0,410 # ffffffffc02a62c8 <buf>
ffffffffc0200136:	94aa                	add	s1,s1,a0
ffffffffc0200138:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc020013c:	60a6                	ld	ra,72(sp)
ffffffffc020013e:	6486                	ld	s1,64(sp)
ffffffffc0200140:	7962                	ld	s2,56(sp)
ffffffffc0200142:	79c2                	ld	s3,48(sp)
ffffffffc0200144:	7a22                	ld	s4,40(sp)
ffffffffc0200146:	7a82                	ld	s5,32(sp)
ffffffffc0200148:	6b62                	ld	s6,24(sp)
ffffffffc020014a:	6bc2                	ld	s7,16(sp)
ffffffffc020014c:	6161                	addi	sp,sp,80
ffffffffc020014e:	8082                	ret
            cputchar(c);
ffffffffc0200150:	4521                	li	a0,8
ffffffffc0200152:	078000ef          	jal	ra,ffffffffc02001ca <cputchar>
            i --;
ffffffffc0200156:	34fd                	addiw	s1,s1,-1
ffffffffc0200158:	b759                	j	ffffffffc02000de <readline+0x38>

ffffffffc020015a <cputch>:
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt)
{
ffffffffc020015a:	1141                	addi	sp,sp,-16
ffffffffc020015c:	e022                	sd	s0,0(sp)
ffffffffc020015e:	e406                	sd	ra,8(sp)
ffffffffc0200160:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200162:	42c000ef          	jal	ra,ffffffffc020058e <cons_putc>
    (*cnt)++;
ffffffffc0200166:	401c                	lw	a5,0(s0)
}
ffffffffc0200168:	60a2                	ld	ra,8(sp)
    (*cnt)++;
ffffffffc020016a:	2785                	addiw	a5,a5,1
ffffffffc020016c:	c01c                	sw	a5,0(s0)
}
ffffffffc020016e:	6402                	ld	s0,0(sp)
ffffffffc0200170:	0141                	addi	sp,sp,16
ffffffffc0200172:	8082                	ret

ffffffffc0200174 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int vcprintf(const char *fmt, va_list ap)
{
ffffffffc0200174:	1101                	addi	sp,sp,-32
ffffffffc0200176:	862a                	mv	a2,a0
ffffffffc0200178:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc020017a:	00000517          	auipc	a0,0x0
ffffffffc020017e:	fe050513          	addi	a0,a0,-32 # ffffffffc020015a <cputch>
ffffffffc0200182:	006c                	addi	a1,sp,12
{
ffffffffc0200184:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc0200186:	c602                	sw	zero,12(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc0200188:	0cc050ef          	jal	ra,ffffffffc0205254 <vprintfmt>
    return cnt;
}
ffffffffc020018c:	60e2                	ld	ra,24(sp)
ffffffffc020018e:	4532                	lw	a0,12(sp)
ffffffffc0200190:	6105                	addi	sp,sp,32
ffffffffc0200192:	8082                	ret

ffffffffc0200194 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int cprintf(const char *fmt, ...)
{
ffffffffc0200194:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc0200196:	02810313          	addi	t1,sp,40 # ffffffffc020a028 <boot_page_table_sv39+0x28>
{
ffffffffc020019a:	8e2a                	mv	t3,a0
ffffffffc020019c:	f42e                	sd	a1,40(sp)
ffffffffc020019e:	f832                	sd	a2,48(sp)
ffffffffc02001a0:	fc36                	sd	a3,56(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001a2:	00000517          	auipc	a0,0x0
ffffffffc02001a6:	fb850513          	addi	a0,a0,-72 # ffffffffc020015a <cputch>
ffffffffc02001aa:	004c                	addi	a1,sp,4
ffffffffc02001ac:	869a                	mv	a3,t1
ffffffffc02001ae:	8672                	mv	a2,t3
{
ffffffffc02001b0:	ec06                	sd	ra,24(sp)
ffffffffc02001b2:	e0ba                	sd	a4,64(sp)
ffffffffc02001b4:	e4be                	sd	a5,72(sp)
ffffffffc02001b6:	e8c2                	sd	a6,80(sp)
ffffffffc02001b8:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02001ba:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02001bc:	c202                	sw	zero,4(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001be:	096050ef          	jal	ra,ffffffffc0205254 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02001c2:	60e2                	ld	ra,24(sp)
ffffffffc02001c4:	4512                	lw	a0,4(sp)
ffffffffc02001c6:	6125                	addi	sp,sp,96
ffffffffc02001c8:	8082                	ret

ffffffffc02001ca <cputchar>:

/* cputchar - writes a single character to stdout */
void cputchar(int c)
{
    cons_putc(c);
ffffffffc02001ca:	a6d1                	j	ffffffffc020058e <cons_putc>

ffffffffc02001cc <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int cputs(const char *str)
{
ffffffffc02001cc:	1101                	addi	sp,sp,-32
ffffffffc02001ce:	e822                	sd	s0,16(sp)
ffffffffc02001d0:	ec06                	sd	ra,24(sp)
ffffffffc02001d2:	e426                	sd	s1,8(sp)
ffffffffc02001d4:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str++) != '\0')
ffffffffc02001d6:	00054503          	lbu	a0,0(a0)
ffffffffc02001da:	c51d                	beqz	a0,ffffffffc0200208 <cputs+0x3c>
ffffffffc02001dc:	0405                	addi	s0,s0,1
ffffffffc02001de:	4485                	li	s1,1
ffffffffc02001e0:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc02001e2:	3ac000ef          	jal	ra,ffffffffc020058e <cons_putc>
    while ((c = *str++) != '\0')
ffffffffc02001e6:	00044503          	lbu	a0,0(s0)
ffffffffc02001ea:	008487bb          	addw	a5,s1,s0
ffffffffc02001ee:	0405                	addi	s0,s0,1
ffffffffc02001f0:	f96d                	bnez	a0,ffffffffc02001e2 <cputs+0x16>
    (*cnt)++;
ffffffffc02001f2:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc02001f6:	4529                	li	a0,10
ffffffffc02001f8:	396000ef          	jal	ra,ffffffffc020058e <cons_putc>
    {
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc02001fc:	60e2                	ld	ra,24(sp)
ffffffffc02001fe:	8522                	mv	a0,s0
ffffffffc0200200:	6442                	ld	s0,16(sp)
ffffffffc0200202:	64a2                	ld	s1,8(sp)
ffffffffc0200204:	6105                	addi	sp,sp,32
ffffffffc0200206:	8082                	ret
    while ((c = *str++) != '\0')
ffffffffc0200208:	4405                	li	s0,1
ffffffffc020020a:	b7f5                	j	ffffffffc02001f6 <cputs+0x2a>

ffffffffc020020c <getchar>:

/* getchar - reads a single non-zero character from stdin */
int getchar(void)
{
ffffffffc020020c:	1141                	addi	sp,sp,-16
ffffffffc020020e:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200210:	3b2000ef          	jal	ra,ffffffffc02005c2 <cons_getc>
ffffffffc0200214:	dd75                	beqz	a0,ffffffffc0200210 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc0200216:	60a2                	ld	ra,8(sp)
ffffffffc0200218:	0141                	addi	sp,sp,16
ffffffffc020021a:	8082                	ret

ffffffffc020021c <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void)
{
ffffffffc020021c:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc020021e:	00005517          	auipc	a0,0x5
ffffffffc0200222:	4ba50513          	addi	a0,a0,1210 # ffffffffc02056d8 <etext+0x36>
{
ffffffffc0200226:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200228:	f6dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc020022c:	00000597          	auipc	a1,0x0
ffffffffc0200230:	e1e58593          	addi	a1,a1,-482 # ffffffffc020004a <kern_init>
ffffffffc0200234:	00005517          	auipc	a0,0x5
ffffffffc0200238:	4c450513          	addi	a0,a0,1220 # ffffffffc02056f8 <etext+0x56>
ffffffffc020023c:	f59ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc0200240:	00005597          	auipc	a1,0x5
ffffffffc0200244:	46258593          	addi	a1,a1,1122 # ffffffffc02056a2 <etext>
ffffffffc0200248:	00005517          	auipc	a0,0x5
ffffffffc020024c:	4d050513          	addi	a0,a0,1232 # ffffffffc0205718 <etext+0x76>
ffffffffc0200250:	f45ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc0200254:	000a6597          	auipc	a1,0xa6
ffffffffc0200258:	07458593          	addi	a1,a1,116 # ffffffffc02a62c8 <buf>
ffffffffc020025c:	00005517          	auipc	a0,0x5
ffffffffc0200260:	4dc50513          	addi	a0,a0,1244 # ffffffffc0205738 <etext+0x96>
ffffffffc0200264:	f31ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc0200268:	000aa597          	auipc	a1,0xaa
ffffffffc020026c:	50458593          	addi	a1,a1,1284 # ffffffffc02aa76c <end>
ffffffffc0200270:	00005517          	auipc	a0,0x5
ffffffffc0200274:	4e850513          	addi	a0,a0,1256 # ffffffffc0205758 <etext+0xb6>
ffffffffc0200278:	f1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc020027c:	000ab597          	auipc	a1,0xab
ffffffffc0200280:	8ef58593          	addi	a1,a1,-1809 # ffffffffc02aab6b <end+0x3ff>
ffffffffc0200284:	00000797          	auipc	a5,0x0
ffffffffc0200288:	dc678793          	addi	a5,a5,-570 # ffffffffc020004a <kern_init>
ffffffffc020028c:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200290:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200294:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200296:	3ff5f593          	andi	a1,a1,1023
ffffffffc020029a:	95be                	add	a1,a1,a5
ffffffffc020029c:	85a9                	srai	a1,a1,0xa
ffffffffc020029e:	00005517          	auipc	a0,0x5
ffffffffc02002a2:	4da50513          	addi	a0,a0,1242 # ffffffffc0205778 <etext+0xd6>
}
ffffffffc02002a6:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02002a8:	b5f5                	j	ffffffffc0200194 <cprintf>

ffffffffc02002aa <print_stackframe>:
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void)
{
ffffffffc02002aa:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc02002ac:	00005617          	auipc	a2,0x5
ffffffffc02002b0:	4fc60613          	addi	a2,a2,1276 # ffffffffc02057a8 <etext+0x106>
ffffffffc02002b4:	04f00593          	li	a1,79
ffffffffc02002b8:	00005517          	auipc	a0,0x5
ffffffffc02002bc:	50850513          	addi	a0,a0,1288 # ffffffffc02057c0 <etext+0x11e>
{
ffffffffc02002c0:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc02002c2:	1cc000ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02002c6 <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int mon_help(int argc, char **argv, struct trapframe *tf)
{
ffffffffc02002c6:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i++)
    {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002c8:	00005617          	auipc	a2,0x5
ffffffffc02002cc:	51060613          	addi	a2,a2,1296 # ffffffffc02057d8 <etext+0x136>
ffffffffc02002d0:	00005597          	auipc	a1,0x5
ffffffffc02002d4:	52858593          	addi	a1,a1,1320 # ffffffffc02057f8 <etext+0x156>
ffffffffc02002d8:	00005517          	auipc	a0,0x5
ffffffffc02002dc:	52850513          	addi	a0,a0,1320 # ffffffffc0205800 <etext+0x15e>
{
ffffffffc02002e0:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002e2:	eb3ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc02002e6:	00005617          	auipc	a2,0x5
ffffffffc02002ea:	52a60613          	addi	a2,a2,1322 # ffffffffc0205810 <etext+0x16e>
ffffffffc02002ee:	00005597          	auipc	a1,0x5
ffffffffc02002f2:	54a58593          	addi	a1,a1,1354 # ffffffffc0205838 <etext+0x196>
ffffffffc02002f6:	00005517          	auipc	a0,0x5
ffffffffc02002fa:	50a50513          	addi	a0,a0,1290 # ffffffffc0205800 <etext+0x15e>
ffffffffc02002fe:	e97ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0200302:	00005617          	auipc	a2,0x5
ffffffffc0200306:	54660613          	addi	a2,a2,1350 # ffffffffc0205848 <etext+0x1a6>
ffffffffc020030a:	00005597          	auipc	a1,0x5
ffffffffc020030e:	55e58593          	addi	a1,a1,1374 # ffffffffc0205868 <etext+0x1c6>
ffffffffc0200312:	00005517          	auipc	a0,0x5
ffffffffc0200316:	4ee50513          	addi	a0,a0,1262 # ffffffffc0205800 <etext+0x15e>
ffffffffc020031a:	e7bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    }
    return 0;
}
ffffffffc020031e:	60a2                	ld	ra,8(sp)
ffffffffc0200320:	4501                	li	a0,0
ffffffffc0200322:	0141                	addi	sp,sp,16
ffffffffc0200324:	8082                	ret

ffffffffc0200326 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int mon_kerninfo(int argc, char **argv, struct trapframe *tf)
{
ffffffffc0200326:	1141                	addi	sp,sp,-16
ffffffffc0200328:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc020032a:	ef3ff0ef          	jal	ra,ffffffffc020021c <print_kerninfo>
    return 0;
}
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int mon_backtrace(int argc, char **argv, struct trapframe *tf)
{
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc020033a:	f71ff0ef          	jal	ra,ffffffffc02002aa <print_stackframe>
    return 0;
}
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <kmonitor>:
{
ffffffffc0200346:	7115                	addi	sp,sp,-224
ffffffffc0200348:	ed5e                	sd	s7,152(sp)
ffffffffc020034a:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc020034c:	00005517          	auipc	a0,0x5
ffffffffc0200350:	52c50513          	addi	a0,a0,1324 # ffffffffc0205878 <etext+0x1d6>
{
ffffffffc0200354:	ed86                	sd	ra,216(sp)
ffffffffc0200356:	e9a2                	sd	s0,208(sp)
ffffffffc0200358:	e5a6                	sd	s1,200(sp)
ffffffffc020035a:	e1ca                	sd	s2,192(sp)
ffffffffc020035c:	fd4e                	sd	s3,184(sp)
ffffffffc020035e:	f952                	sd	s4,176(sp)
ffffffffc0200360:	f556                	sd	s5,168(sp)
ffffffffc0200362:	f15a                	sd	s6,160(sp)
ffffffffc0200364:	e962                	sd	s8,144(sp)
ffffffffc0200366:	e566                	sd	s9,136(sp)
ffffffffc0200368:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc020036a:	e2bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc020036e:	00005517          	auipc	a0,0x5
ffffffffc0200372:	53250513          	addi	a0,a0,1330 # ffffffffc02058a0 <etext+0x1fe>
ffffffffc0200376:	e1fff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    if (tf != NULL)
ffffffffc020037a:	000b8563          	beqz	s7,ffffffffc0200384 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc020037e:	855e                	mv	a0,s7
ffffffffc0200380:	025000ef          	jal	ra,ffffffffc0200ba4 <print_trapframe>
ffffffffc0200384:	00005c17          	auipc	s8,0x5
ffffffffc0200388:	58cc0c13          	addi	s8,s8,1420 # ffffffffc0205910 <commands>
        if ((buf = readline("K> ")) != NULL)
ffffffffc020038c:	00005917          	auipc	s2,0x5
ffffffffc0200390:	53c90913          	addi	s2,s2,1340 # ffffffffc02058c8 <etext+0x226>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200394:	00005497          	auipc	s1,0x5
ffffffffc0200398:	53c48493          	addi	s1,s1,1340 # ffffffffc02058d0 <etext+0x22e>
        if (argc == MAXARGS - 1)
ffffffffc020039c:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc020039e:	00005b17          	auipc	s6,0x5
ffffffffc02003a2:	53ab0b13          	addi	s6,s6,1338 # ffffffffc02058d8 <etext+0x236>
        argv[argc++] = buf;
ffffffffc02003a6:	00005a17          	auipc	s4,0x5
ffffffffc02003aa:	452a0a13          	addi	s4,s4,1106 # ffffffffc02057f8 <etext+0x156>
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003ae:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL)
ffffffffc02003b0:	854a                	mv	a0,s2
ffffffffc02003b2:	cf5ff0ef          	jal	ra,ffffffffc02000a6 <readline>
ffffffffc02003b6:	842a                	mv	s0,a0
ffffffffc02003b8:	dd65                	beqz	a0,ffffffffc02003b0 <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc02003ba:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc02003be:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc02003c0:	e1bd                	bnez	a1,ffffffffc0200426 <kmonitor+0xe0>
    if (argc == 0)
ffffffffc02003c2:	fe0c87e3          	beqz	s9,ffffffffc02003b0 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003c6:	6582                	ld	a1,0(sp)
ffffffffc02003c8:	00005d17          	auipc	s10,0x5
ffffffffc02003cc:	548d0d13          	addi	s10,s10,1352 # ffffffffc0205910 <commands>
        argv[argc++] = buf;
ffffffffc02003d0:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003d2:	4401                	li	s0,0
ffffffffc02003d4:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003d6:	248050ef          	jal	ra,ffffffffc020561e <strcmp>
ffffffffc02003da:	c919                	beqz	a0,ffffffffc02003f0 <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003dc:	2405                	addiw	s0,s0,1
ffffffffc02003de:	0b540063          	beq	s0,s5,ffffffffc020047e <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003e2:	000d3503          	ld	a0,0(s10)
ffffffffc02003e6:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003e8:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003ea:	234050ef          	jal	ra,ffffffffc020561e <strcmp>
ffffffffc02003ee:	f57d                	bnez	a0,ffffffffc02003dc <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc02003f0:	00141793          	slli	a5,s0,0x1
ffffffffc02003f4:	97a2                	add	a5,a5,s0
ffffffffc02003f6:	078e                	slli	a5,a5,0x3
ffffffffc02003f8:	97e2                	add	a5,a5,s8
ffffffffc02003fa:	6b9c                	ld	a5,16(a5)
ffffffffc02003fc:	865e                	mv	a2,s7
ffffffffc02003fe:	002c                	addi	a1,sp,8
ffffffffc0200400:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200404:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0)
ffffffffc0200406:	fa0555e3          	bgez	a0,ffffffffc02003b0 <kmonitor+0x6a>
}
ffffffffc020040a:	60ee                	ld	ra,216(sp)
ffffffffc020040c:	644e                	ld	s0,208(sp)
ffffffffc020040e:	64ae                	ld	s1,200(sp)
ffffffffc0200410:	690e                	ld	s2,192(sp)
ffffffffc0200412:	79ea                	ld	s3,184(sp)
ffffffffc0200414:	7a4a                	ld	s4,176(sp)
ffffffffc0200416:	7aaa                	ld	s5,168(sp)
ffffffffc0200418:	7b0a                	ld	s6,160(sp)
ffffffffc020041a:	6bea                	ld	s7,152(sp)
ffffffffc020041c:	6c4a                	ld	s8,144(sp)
ffffffffc020041e:	6caa                	ld	s9,136(sp)
ffffffffc0200420:	6d0a                	ld	s10,128(sp)
ffffffffc0200422:	612d                	addi	sp,sp,224
ffffffffc0200424:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200426:	8526                	mv	a0,s1
ffffffffc0200428:	23a050ef          	jal	ra,ffffffffc0205662 <strchr>
ffffffffc020042c:	c901                	beqz	a0,ffffffffc020043c <kmonitor+0xf6>
ffffffffc020042e:	00144583          	lbu	a1,1(s0)
            *buf++ = '\0';
ffffffffc0200432:	00040023          	sb	zero,0(s0)
ffffffffc0200436:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200438:	d5c9                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc020043a:	b7f5                	j	ffffffffc0200426 <kmonitor+0xe0>
        if (*buf == '\0')
ffffffffc020043c:	00044783          	lbu	a5,0(s0)
ffffffffc0200440:	d3c9                	beqz	a5,ffffffffc02003c2 <kmonitor+0x7c>
        if (argc == MAXARGS - 1)
ffffffffc0200442:	033c8963          	beq	s9,s3,ffffffffc0200474 <kmonitor+0x12e>
        argv[argc++] = buf;
ffffffffc0200446:	003c9793          	slli	a5,s9,0x3
ffffffffc020044a:	0118                	addi	a4,sp,128
ffffffffc020044c:	97ba                	add	a5,a5,a4
ffffffffc020044e:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200452:	00044583          	lbu	a1,0(s0)
        argv[argc++] = buf;
ffffffffc0200456:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200458:	e591                	bnez	a1,ffffffffc0200464 <kmonitor+0x11e>
ffffffffc020045a:	b7b5                	j	ffffffffc02003c6 <kmonitor+0x80>
ffffffffc020045c:	00144583          	lbu	a1,1(s0)
            buf++;
ffffffffc0200460:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200462:	d1a5                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc0200464:	8526                	mv	a0,s1
ffffffffc0200466:	1fc050ef          	jal	ra,ffffffffc0205662 <strchr>
ffffffffc020046a:	d96d                	beqz	a0,ffffffffc020045c <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc020046c:	00044583          	lbu	a1,0(s0)
ffffffffc0200470:	d9a9                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc0200472:	bf55                	j	ffffffffc0200426 <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200474:	45c1                	li	a1,16
ffffffffc0200476:	855a                	mv	a0,s6
ffffffffc0200478:	d1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc020047c:	b7e9                	j	ffffffffc0200446 <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc020047e:	6582                	ld	a1,0(sp)
ffffffffc0200480:	00005517          	auipc	a0,0x5
ffffffffc0200484:	47850513          	addi	a0,a0,1144 # ffffffffc02058f8 <etext+0x256>
ffffffffc0200488:	d0dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return 0;
ffffffffc020048c:	b715                	j	ffffffffc02003b0 <kmonitor+0x6a>

ffffffffc020048e <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void __panic(const char *file, int line, const char *fmt, ...)
{
    if (is_panic)
ffffffffc020048e:	000aa317          	auipc	t1,0xaa
ffffffffc0200492:	26230313          	addi	t1,t1,610 # ffffffffc02aa6f0 <is_panic>
ffffffffc0200496:	00033e03          	ld	t3,0(t1)
{
ffffffffc020049a:	715d                	addi	sp,sp,-80
ffffffffc020049c:	ec06                	sd	ra,24(sp)
ffffffffc020049e:	e822                	sd	s0,16(sp)
ffffffffc02004a0:	f436                	sd	a3,40(sp)
ffffffffc02004a2:	f83a                	sd	a4,48(sp)
ffffffffc02004a4:	fc3e                	sd	a5,56(sp)
ffffffffc02004a6:	e0c2                	sd	a6,64(sp)
ffffffffc02004a8:	e4c6                	sd	a7,72(sp)
    if (is_panic)
ffffffffc02004aa:	020e1a63          	bnez	t3,ffffffffc02004de <__panic+0x50>
    {
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc02004ae:	4785                	li	a5,1
ffffffffc02004b0:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc02004b4:	8432                	mv	s0,a2
ffffffffc02004b6:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004b8:	862e                	mv	a2,a1
ffffffffc02004ba:	85aa                	mv	a1,a0
ffffffffc02004bc:	00005517          	auipc	a0,0x5
ffffffffc02004c0:	49c50513          	addi	a0,a0,1180 # ffffffffc0205958 <commands+0x48>
    va_start(ap, fmt);
ffffffffc02004c4:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004c6:	ccfff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    vcprintf(fmt, ap);
ffffffffc02004ca:	65a2                	ld	a1,8(sp)
ffffffffc02004cc:	8522                	mv	a0,s0
ffffffffc02004ce:	ca7ff0ef          	jal	ra,ffffffffc0200174 <vcprintf>
    cprintf("\n");
ffffffffc02004d2:	00006517          	auipc	a0,0x6
ffffffffc02004d6:	57e50513          	addi	a0,a0,1406 # ffffffffc0206a50 <default_pmm_manager+0x578>
ffffffffc02004da:	cbbff0ef          	jal	ra,ffffffffc0200194 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc02004de:	4501                	li	a0,0
ffffffffc02004e0:	4581                	li	a1,0
ffffffffc02004e2:	4601                	li	a2,0
ffffffffc02004e4:	48a1                	li	a7,8
ffffffffc02004e6:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc02004ea:	4ca000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
    while (1)
    {
        kmonitor(NULL);
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	e57ff0ef          	jal	ra,ffffffffc0200346 <kmonitor>
    while (1)
ffffffffc02004f4:	bfed                	j	ffffffffc02004ee <__panic+0x60>

ffffffffc02004f6 <__warn>:
    }
}

/* __warn - like panic, but don't */
void __warn(const char *file, int line, const char *fmt, ...)
{
ffffffffc02004f6:	715d                	addi	sp,sp,-80
ffffffffc02004f8:	832e                	mv	t1,a1
ffffffffc02004fa:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc02004fc:	85aa                	mv	a1,a0
{
ffffffffc02004fe:	8432                	mv	s0,a2
ffffffffc0200500:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200502:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc0200504:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200506:	00005517          	auipc	a0,0x5
ffffffffc020050a:	47250513          	addi	a0,a0,1138 # ffffffffc0205978 <commands+0x68>
{
ffffffffc020050e:	ec06                	sd	ra,24(sp)
ffffffffc0200510:	f436                	sd	a3,40(sp)
ffffffffc0200512:	f83a                	sd	a4,48(sp)
ffffffffc0200514:	e0c2                	sd	a6,64(sp)
ffffffffc0200516:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0200518:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020051a:	c7bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    vcprintf(fmt, ap);
ffffffffc020051e:	65a2                	ld	a1,8(sp)
ffffffffc0200520:	8522                	mv	a0,s0
ffffffffc0200522:	c53ff0ef          	jal	ra,ffffffffc0200174 <vcprintf>
    cprintf("\n");
ffffffffc0200526:	00006517          	auipc	a0,0x6
ffffffffc020052a:	52a50513          	addi	a0,a0,1322 # ffffffffc0206a50 <default_pmm_manager+0x578>
ffffffffc020052e:	c67ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    va_end(ap);
}
ffffffffc0200532:	60e2                	ld	ra,24(sp)
ffffffffc0200534:	6442                	ld	s0,16(sp)
ffffffffc0200536:	6161                	addi	sp,sp,80
ffffffffc0200538:	8082                	ret

ffffffffc020053a <clock_init>:
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
    // divided by 500 when using Spike(2MHz)
    // divided by 100 when using QEMU(10MHz)
    timebase = 1e7 / 100;
ffffffffc020053a:	67e1                	lui	a5,0x18
ffffffffc020053c:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_exit_out_size+0xd580>
ffffffffc0200540:	000aa717          	auipc	a4,0xaa
ffffffffc0200544:	1cf73023          	sd	a5,448(a4) # ffffffffc02aa700 <timebase>
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200548:	c0102573          	rdtime	a0
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc020054c:	4581                	li	a1,0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020054e:	953e                	add	a0,a0,a5
ffffffffc0200550:	4601                	li	a2,0
ffffffffc0200552:	4881                	li	a7,0
ffffffffc0200554:	00000073          	ecall
    set_csr(sie, MIP_STIP);
ffffffffc0200558:	02000793          	li	a5,32
ffffffffc020055c:	1047a7f3          	csrrs	a5,sie,a5
    cprintf("++ setup timer interrupts\n");
ffffffffc0200560:	00005517          	auipc	a0,0x5
ffffffffc0200564:	43850513          	addi	a0,a0,1080 # ffffffffc0205998 <commands+0x88>
    ticks = 0;
ffffffffc0200568:	000aa797          	auipc	a5,0xaa
ffffffffc020056c:	1807b823          	sd	zero,400(a5) # ffffffffc02aa6f8 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc0200570:	b115                	j	ffffffffc0200194 <cprintf>

ffffffffc0200572 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200572:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200576:	000aa797          	auipc	a5,0xaa
ffffffffc020057a:	18a7b783          	ld	a5,394(a5) # ffffffffc02aa700 <timebase>
ffffffffc020057e:	953e                	add	a0,a0,a5
ffffffffc0200580:	4581                	li	a1,0
ffffffffc0200582:	4601                	li	a2,0
ffffffffc0200584:	4881                	li	a7,0
ffffffffc0200586:	00000073          	ecall
ffffffffc020058a:	8082                	ret

ffffffffc020058c <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc020058c:	8082                	ret

ffffffffc020058e <cons_putc>:
#include <riscv.h>
#include <assert.h>

static inline bool __intr_save(void)
{
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020058e:	100027f3          	csrr	a5,sstatus
ffffffffc0200592:	8b89                	andi	a5,a5,2
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc0200594:	0ff57513          	zext.b	a0,a0
ffffffffc0200598:	e799                	bnez	a5,ffffffffc02005a6 <cons_putc+0x18>
ffffffffc020059a:	4581                	li	a1,0
ffffffffc020059c:	4601                	li	a2,0
ffffffffc020059e:	4885                	li	a7,1
ffffffffc02005a0:	00000073          	ecall
    return 0;
}

static inline void __intr_restore(bool flag)
{
    if (flag)
ffffffffc02005a4:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005a6:	1101                	addi	sp,sp,-32
ffffffffc02005a8:	ec06                	sd	ra,24(sp)
ffffffffc02005aa:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005ac:	408000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02005b0:	6522                	ld	a0,8(sp)
ffffffffc02005b2:	4581                	li	a1,0
ffffffffc02005b4:	4601                	li	a2,0
ffffffffc02005b6:	4885                	li	a7,1
ffffffffc02005b8:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005bc:	60e2                	ld	ra,24(sp)
ffffffffc02005be:	6105                	addi	sp,sp,32
    {
        intr_enable();
ffffffffc02005c0:	a6fd                	j	ffffffffc02009ae <intr_enable>

ffffffffc02005c2 <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02005c2:	100027f3          	csrr	a5,sstatus
ffffffffc02005c6:	8b89                	andi	a5,a5,2
ffffffffc02005c8:	eb89                	bnez	a5,ffffffffc02005da <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005ca:	4501                	li	a0,0
ffffffffc02005cc:	4581                	li	a1,0
ffffffffc02005ce:	4601                	li	a2,0
ffffffffc02005d0:	4889                	li	a7,2
ffffffffc02005d2:	00000073          	ecall
ffffffffc02005d6:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc02005d8:	8082                	ret
int cons_getc(void) {
ffffffffc02005da:	1101                	addi	sp,sp,-32
ffffffffc02005dc:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc02005de:	3d6000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02005e2:	4501                	li	a0,0
ffffffffc02005e4:	4581                	li	a1,0
ffffffffc02005e6:	4601                	li	a2,0
ffffffffc02005e8:	4889                	li	a7,2
ffffffffc02005ea:	00000073          	ecall
ffffffffc02005ee:	2501                	sext.w	a0,a0
ffffffffc02005f0:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc02005f2:	3bc000ef          	jal	ra,ffffffffc02009ae <intr_enable>
}
ffffffffc02005f6:	60e2                	ld	ra,24(sp)
ffffffffc02005f8:	6522                	ld	a0,8(sp)
ffffffffc02005fa:	6105                	addi	sp,sp,32
ffffffffc02005fc:	8082                	ret

ffffffffc02005fe <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc02005fe:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200600:	00005517          	auipc	a0,0x5
ffffffffc0200604:	3b850513          	addi	a0,a0,952 # ffffffffc02059b8 <commands+0xa8>
void dtb_init(void) {
ffffffffc0200608:	fc86                	sd	ra,120(sp)
ffffffffc020060a:	f8a2                	sd	s0,112(sp)
ffffffffc020060c:	e8d2                	sd	s4,80(sp)
ffffffffc020060e:	f4a6                	sd	s1,104(sp)
ffffffffc0200610:	f0ca                	sd	s2,96(sp)
ffffffffc0200612:	ecce                	sd	s3,88(sp)
ffffffffc0200614:	e4d6                	sd	s5,72(sp)
ffffffffc0200616:	e0da                	sd	s6,64(sp)
ffffffffc0200618:	fc5e                	sd	s7,56(sp)
ffffffffc020061a:	f862                	sd	s8,48(sp)
ffffffffc020061c:	f466                	sd	s9,40(sp)
ffffffffc020061e:	f06a                	sd	s10,32(sp)
ffffffffc0200620:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc0200622:	b73ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc0200626:	0000b597          	auipc	a1,0xb
ffffffffc020062a:	9da5b583          	ld	a1,-1574(a1) # ffffffffc020b000 <boot_hartid>
ffffffffc020062e:	00005517          	auipc	a0,0x5
ffffffffc0200632:	39a50513          	addi	a0,a0,922 # ffffffffc02059c8 <commands+0xb8>
ffffffffc0200636:	b5fff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc020063a:	0000b417          	auipc	s0,0xb
ffffffffc020063e:	9ce40413          	addi	s0,s0,-1586 # ffffffffc020b008 <boot_dtb>
ffffffffc0200642:	600c                	ld	a1,0(s0)
ffffffffc0200644:	00005517          	auipc	a0,0x5
ffffffffc0200648:	39450513          	addi	a0,a0,916 # ffffffffc02059d8 <commands+0xc8>
ffffffffc020064c:	b49ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc0200650:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200654:	00005517          	auipc	a0,0x5
ffffffffc0200658:	39c50513          	addi	a0,a0,924 # ffffffffc02059f0 <commands+0xe0>
    if (boot_dtb == 0) {
ffffffffc020065c:	120a0463          	beqz	s4,ffffffffc0200784 <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc0200660:	57f5                	li	a5,-3
ffffffffc0200662:	07fa                	slli	a5,a5,0x1e
ffffffffc0200664:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc0200668:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020066a:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020066e:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200670:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200674:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200678:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020067c:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200680:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200684:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200686:	8ec9                	or	a3,a3,a0
ffffffffc0200688:	0087979b          	slliw	a5,a5,0x8
ffffffffc020068c:	1b7d                	addi	s6,s6,-1
ffffffffc020068e:	0167f7b3          	and	a5,a5,s6
ffffffffc0200692:	8dd5                	or	a1,a1,a3
ffffffffc0200694:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc0200696:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020069a:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc020069c:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe35781>
ffffffffc02006a0:	10f59163          	bne	a1,a5,ffffffffc02007a2 <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc02006a4:	471c                	lw	a5,8(a4)
ffffffffc02006a6:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc02006a8:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006aa:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02006ae:	0086d51b          	srliw	a0,a3,0x8
ffffffffc02006b2:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b6:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ba:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006be:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006c2:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c6:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ca:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006ce:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006d2:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006d4:	01146433          	or	s0,s0,a7
ffffffffc02006d8:	0086969b          	slliw	a3,a3,0x8
ffffffffc02006dc:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006e0:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006e2:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006e6:	8c49                	or	s0,s0,a0
ffffffffc02006e8:	0166f6b3          	and	a3,a3,s6
ffffffffc02006ec:	00ca6a33          	or	s4,s4,a2
ffffffffc02006f0:	0167f7b3          	and	a5,a5,s6
ffffffffc02006f4:	8c55                	or	s0,s0,a3
ffffffffc02006f6:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006fa:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02006fc:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006fe:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200700:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200704:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200706:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200708:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc020070c:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020070e:	00005917          	auipc	s2,0x5
ffffffffc0200712:	33290913          	addi	s2,s2,818 # ffffffffc0205a40 <commands+0x130>
ffffffffc0200716:	49bd                	li	s3,15
        switch (token) {
ffffffffc0200718:	4d91                	li	s11,4
ffffffffc020071a:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020071c:	00005497          	auipc	s1,0x5
ffffffffc0200720:	31c48493          	addi	s1,s1,796 # ffffffffc0205a38 <commands+0x128>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200724:	000a2703          	lw	a4,0(s4)
ffffffffc0200728:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020072c:	0087569b          	srliw	a3,a4,0x8
ffffffffc0200730:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200734:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200738:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020073c:	0107571b          	srliw	a4,a4,0x10
ffffffffc0200740:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200742:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200746:	0087171b          	slliw	a4,a4,0x8
ffffffffc020074a:	8fd5                	or	a5,a5,a3
ffffffffc020074c:	00eb7733          	and	a4,s6,a4
ffffffffc0200750:	8fd9                	or	a5,a5,a4
ffffffffc0200752:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc0200754:	09778c63          	beq	a5,s7,ffffffffc02007ec <dtb_init+0x1ee>
ffffffffc0200758:	00fbea63          	bltu	s7,a5,ffffffffc020076c <dtb_init+0x16e>
ffffffffc020075c:	07a78663          	beq	a5,s10,ffffffffc02007c8 <dtb_init+0x1ca>
ffffffffc0200760:	4709                	li	a4,2
ffffffffc0200762:	00e79763          	bne	a5,a4,ffffffffc0200770 <dtb_init+0x172>
ffffffffc0200766:	4c81                	li	s9,0
ffffffffc0200768:	8a56                	mv	s4,s5
ffffffffc020076a:	bf6d                	j	ffffffffc0200724 <dtb_init+0x126>
ffffffffc020076c:	ffb78ee3          	beq	a5,s11,ffffffffc0200768 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc0200770:	00005517          	auipc	a0,0x5
ffffffffc0200774:	34850513          	addi	a0,a0,840 # ffffffffc0205ab8 <commands+0x1a8>
ffffffffc0200778:	a1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc020077c:	00005517          	auipc	a0,0x5
ffffffffc0200780:	37450513          	addi	a0,a0,884 # ffffffffc0205af0 <commands+0x1e0>
}
ffffffffc0200784:	7446                	ld	s0,112(sp)
ffffffffc0200786:	70e6                	ld	ra,120(sp)
ffffffffc0200788:	74a6                	ld	s1,104(sp)
ffffffffc020078a:	7906                	ld	s2,96(sp)
ffffffffc020078c:	69e6                	ld	s3,88(sp)
ffffffffc020078e:	6a46                	ld	s4,80(sp)
ffffffffc0200790:	6aa6                	ld	s5,72(sp)
ffffffffc0200792:	6b06                	ld	s6,64(sp)
ffffffffc0200794:	7be2                	ld	s7,56(sp)
ffffffffc0200796:	7c42                	ld	s8,48(sp)
ffffffffc0200798:	7ca2                	ld	s9,40(sp)
ffffffffc020079a:	7d02                	ld	s10,32(sp)
ffffffffc020079c:	6de2                	ld	s11,24(sp)
ffffffffc020079e:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc02007a0:	bad5                	j	ffffffffc0200194 <cprintf>
}
ffffffffc02007a2:	7446                	ld	s0,112(sp)
ffffffffc02007a4:	70e6                	ld	ra,120(sp)
ffffffffc02007a6:	74a6                	ld	s1,104(sp)
ffffffffc02007a8:	7906                	ld	s2,96(sp)
ffffffffc02007aa:	69e6                	ld	s3,88(sp)
ffffffffc02007ac:	6a46                	ld	s4,80(sp)
ffffffffc02007ae:	6aa6                	ld	s5,72(sp)
ffffffffc02007b0:	6b06                	ld	s6,64(sp)
ffffffffc02007b2:	7be2                	ld	s7,56(sp)
ffffffffc02007b4:	7c42                	ld	s8,48(sp)
ffffffffc02007b6:	7ca2                	ld	s9,40(sp)
ffffffffc02007b8:	7d02                	ld	s10,32(sp)
ffffffffc02007ba:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007bc:	00005517          	auipc	a0,0x5
ffffffffc02007c0:	25450513          	addi	a0,a0,596 # ffffffffc0205a10 <commands+0x100>
}
ffffffffc02007c4:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007c6:	b2f9                	j	ffffffffc0200194 <cprintf>
                int name_len = strlen(name);
ffffffffc02007c8:	8556                	mv	a0,s5
ffffffffc02007ca:	60d040ef          	jal	ra,ffffffffc02055d6 <strlen>
ffffffffc02007ce:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007d0:	4619                	li	a2,6
ffffffffc02007d2:	85a6                	mv	a1,s1
ffffffffc02007d4:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02007d6:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007d8:	665040ef          	jal	ra,ffffffffc020563c <strncmp>
ffffffffc02007dc:	e111                	bnez	a0,ffffffffc02007e0 <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc02007de:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc02007e0:	0a91                	addi	s5,s5,4
ffffffffc02007e2:	9ad2                	add	s5,s5,s4
ffffffffc02007e4:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02007e8:	8a56                	mv	s4,s5
ffffffffc02007ea:	bf2d                	j	ffffffffc0200724 <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007ec:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007f0:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007f4:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02007f8:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007fc:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200800:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200804:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200808:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020080c:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200810:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200814:	00eaeab3          	or	s5,s5,a4
ffffffffc0200818:	00fb77b3          	and	a5,s6,a5
ffffffffc020081c:	00faeab3          	or	s5,s5,a5
ffffffffc0200820:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200822:	000c9c63          	bnez	s9,ffffffffc020083a <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc0200826:	1a82                	slli	s5,s5,0x20
ffffffffc0200828:	00368793          	addi	a5,a3,3
ffffffffc020082c:	020ada93          	srli	s5,s5,0x20
ffffffffc0200830:	9abe                	add	s5,s5,a5
ffffffffc0200832:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200836:	8a56                	mv	s4,s5
ffffffffc0200838:	b5f5                	j	ffffffffc0200724 <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc020083a:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020083e:	85ca                	mv	a1,s2
ffffffffc0200840:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200842:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200846:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020084a:	0187971b          	slliw	a4,a5,0x18
ffffffffc020084e:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200852:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200856:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200858:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020085c:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200860:	8d59                	or	a0,a0,a4
ffffffffc0200862:	00fb77b3          	and	a5,s6,a5
ffffffffc0200866:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc0200868:	1502                	slli	a0,a0,0x20
ffffffffc020086a:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020086c:	9522                	add	a0,a0,s0
ffffffffc020086e:	5b1040ef          	jal	ra,ffffffffc020561e <strcmp>
ffffffffc0200872:	66a2                	ld	a3,8(sp)
ffffffffc0200874:	f94d                	bnez	a0,ffffffffc0200826 <dtb_init+0x228>
ffffffffc0200876:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200826 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc020087a:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc020087e:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200882:	00005517          	auipc	a0,0x5
ffffffffc0200886:	1c650513          	addi	a0,a0,454 # ffffffffc0205a48 <commands+0x138>
           fdt32_to_cpu(x >> 32);
ffffffffc020088a:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020088e:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc0200892:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200896:	0187de1b          	srliw	t3,a5,0x18
ffffffffc020089a:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020089e:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008a2:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008a6:	0187d693          	srli	a3,a5,0x18
ffffffffc02008aa:	01861f1b          	slliw	t5,a2,0x18
ffffffffc02008ae:	0087579b          	srliw	a5,a4,0x8
ffffffffc02008b2:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008b6:	0106561b          	srliw	a2,a2,0x10
ffffffffc02008ba:	010f6f33          	or	t5,t5,a6
ffffffffc02008be:	0187529b          	srliw	t0,a4,0x18
ffffffffc02008c2:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008c6:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008ca:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008ce:	0186f6b3          	and	a3,a3,s8
ffffffffc02008d2:	01859e1b          	slliw	t3,a1,0x18
ffffffffc02008d6:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008da:	0107581b          	srliw	a6,a4,0x10
ffffffffc02008de:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008e2:	8361                	srli	a4,a4,0x18
ffffffffc02008e4:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008e8:	0105d59b          	srliw	a1,a1,0x10
ffffffffc02008ec:	01e6e6b3          	or	a3,a3,t5
ffffffffc02008f0:	00cb7633          	and	a2,s6,a2
ffffffffc02008f4:	0088181b          	slliw	a6,a6,0x8
ffffffffc02008f8:	0085959b          	slliw	a1,a1,0x8
ffffffffc02008fc:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200900:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200904:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200908:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020090c:	0088989b          	slliw	a7,a7,0x8
ffffffffc0200910:	011b78b3          	and	a7,s6,a7
ffffffffc0200914:	005eeeb3          	or	t4,t4,t0
ffffffffc0200918:	00c6e733          	or	a4,a3,a2
ffffffffc020091c:	006c6c33          	or	s8,s8,t1
ffffffffc0200920:	010b76b3          	and	a3,s6,a6
ffffffffc0200924:	00bb7b33          	and	s6,s6,a1
ffffffffc0200928:	01d7e7b3          	or	a5,a5,t4
ffffffffc020092c:	016c6b33          	or	s6,s8,s6
ffffffffc0200930:	01146433          	or	s0,s0,a7
ffffffffc0200934:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc0200936:	1702                	slli	a4,a4,0x20
ffffffffc0200938:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020093a:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020093c:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020093e:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc0200940:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200944:	0167eb33          	or	s6,a5,s6
ffffffffc0200948:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc020094a:	84bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc020094e:	85a2                	mv	a1,s0
ffffffffc0200950:	00005517          	auipc	a0,0x5
ffffffffc0200954:	11850513          	addi	a0,a0,280 # ffffffffc0205a68 <commands+0x158>
ffffffffc0200958:	83dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc020095c:	014b5613          	srli	a2,s6,0x14
ffffffffc0200960:	85da                	mv	a1,s6
ffffffffc0200962:	00005517          	auipc	a0,0x5
ffffffffc0200966:	11e50513          	addi	a0,a0,286 # ffffffffc0205a80 <commands+0x170>
ffffffffc020096a:	82bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc020096e:	008b05b3          	add	a1,s6,s0
ffffffffc0200972:	15fd                	addi	a1,a1,-1
ffffffffc0200974:	00005517          	auipc	a0,0x5
ffffffffc0200978:	12c50513          	addi	a0,a0,300 # ffffffffc0205aa0 <commands+0x190>
ffffffffc020097c:	819ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc0200980:	00005517          	auipc	a0,0x5
ffffffffc0200984:	17050513          	addi	a0,a0,368 # ffffffffc0205af0 <commands+0x1e0>
        memory_base = mem_base;
ffffffffc0200988:	000aa797          	auipc	a5,0xaa
ffffffffc020098c:	d887b023          	sd	s0,-640(a5) # ffffffffc02aa708 <memory_base>
        memory_size = mem_size;
ffffffffc0200990:	000aa797          	auipc	a5,0xaa
ffffffffc0200994:	d967b023          	sd	s6,-640(a5) # ffffffffc02aa710 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc0200998:	b3f5                	j	ffffffffc0200784 <dtb_init+0x186>

ffffffffc020099a <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc020099a:	000aa517          	auipc	a0,0xaa
ffffffffc020099e:	d6e53503          	ld	a0,-658(a0) # ffffffffc02aa708 <memory_base>
ffffffffc02009a2:	8082                	ret

ffffffffc02009a4 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc02009a4:	000aa517          	auipc	a0,0xaa
ffffffffc02009a8:	d6c53503          	ld	a0,-660(a0) # ffffffffc02aa710 <memory_size>
ffffffffc02009ac:	8082                	ret

ffffffffc02009ae <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009ae:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02009b2:	8082                	ret

ffffffffc02009b4 <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009b4:	100177f3          	csrrci	a5,sstatus,2
ffffffffc02009b8:	8082                	ret

ffffffffc02009ba <pic_init>:
#include <picirq.h>

void pic_enable(unsigned int irq) {}

/* pic_init - initialize the 8259A interrupt controllers */
void pic_init(void) {}
ffffffffc02009ba:	8082                	ret

ffffffffc02009bc <idt_init>:
void idt_init(void)
{
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc02009bc:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc02009c0:	00000797          	auipc	a5,0x0
ffffffffc02009c4:	48478793          	addi	a5,a5,1156 # ffffffffc0200e44 <__alltraps>
ffffffffc02009c8:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc02009cc:	000407b7          	lui	a5,0x40
ffffffffc02009d0:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc02009d4:	8082                	ret

ffffffffc02009d6 <print_regs>:
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr)
{
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009d6:	610c                	ld	a1,0(a0)
{
ffffffffc02009d8:	1141                	addi	sp,sp,-16
ffffffffc02009da:	e022                	sd	s0,0(sp)
ffffffffc02009dc:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009de:	00005517          	auipc	a0,0x5
ffffffffc02009e2:	12a50513          	addi	a0,a0,298 # ffffffffc0205b08 <commands+0x1f8>
{
ffffffffc02009e6:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009e8:	facff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc02009ec:	640c                	ld	a1,8(s0)
ffffffffc02009ee:	00005517          	auipc	a0,0x5
ffffffffc02009f2:	13250513          	addi	a0,a0,306 # ffffffffc0205b20 <commands+0x210>
ffffffffc02009f6:	f9eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc02009fa:	680c                	ld	a1,16(s0)
ffffffffc02009fc:	00005517          	auipc	a0,0x5
ffffffffc0200a00:	13c50513          	addi	a0,a0,316 # ffffffffc0205b38 <commands+0x228>
ffffffffc0200a04:	f90ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200a08:	6c0c                	ld	a1,24(s0)
ffffffffc0200a0a:	00005517          	auipc	a0,0x5
ffffffffc0200a0e:	14650513          	addi	a0,a0,326 # ffffffffc0205b50 <commands+0x240>
ffffffffc0200a12:	f82ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200a16:	700c                	ld	a1,32(s0)
ffffffffc0200a18:	00005517          	auipc	a0,0x5
ffffffffc0200a1c:	15050513          	addi	a0,a0,336 # ffffffffc0205b68 <commands+0x258>
ffffffffc0200a20:	f74ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc0200a24:	740c                	ld	a1,40(s0)
ffffffffc0200a26:	00005517          	auipc	a0,0x5
ffffffffc0200a2a:	15a50513          	addi	a0,a0,346 # ffffffffc0205b80 <commands+0x270>
ffffffffc0200a2e:	f66ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc0200a32:	780c                	ld	a1,48(s0)
ffffffffc0200a34:	00005517          	auipc	a0,0x5
ffffffffc0200a38:	16450513          	addi	a0,a0,356 # ffffffffc0205b98 <commands+0x288>
ffffffffc0200a3c:	f58ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc0200a40:	7c0c                	ld	a1,56(s0)
ffffffffc0200a42:	00005517          	auipc	a0,0x5
ffffffffc0200a46:	16e50513          	addi	a0,a0,366 # ffffffffc0205bb0 <commands+0x2a0>
ffffffffc0200a4a:	f4aff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc0200a4e:	602c                	ld	a1,64(s0)
ffffffffc0200a50:	00005517          	auipc	a0,0x5
ffffffffc0200a54:	17850513          	addi	a0,a0,376 # ffffffffc0205bc8 <commands+0x2b8>
ffffffffc0200a58:	f3cff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc0200a5c:	642c                	ld	a1,72(s0)
ffffffffc0200a5e:	00005517          	auipc	a0,0x5
ffffffffc0200a62:	18250513          	addi	a0,a0,386 # ffffffffc0205be0 <commands+0x2d0>
ffffffffc0200a66:	f2eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc0200a6a:	682c                	ld	a1,80(s0)
ffffffffc0200a6c:	00005517          	auipc	a0,0x5
ffffffffc0200a70:	18c50513          	addi	a0,a0,396 # ffffffffc0205bf8 <commands+0x2e8>
ffffffffc0200a74:	f20ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc0200a78:	6c2c                	ld	a1,88(s0)
ffffffffc0200a7a:	00005517          	auipc	a0,0x5
ffffffffc0200a7e:	19650513          	addi	a0,a0,406 # ffffffffc0205c10 <commands+0x300>
ffffffffc0200a82:	f12ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200a86:	702c                	ld	a1,96(s0)
ffffffffc0200a88:	00005517          	auipc	a0,0x5
ffffffffc0200a8c:	1a050513          	addi	a0,a0,416 # ffffffffc0205c28 <commands+0x318>
ffffffffc0200a90:	f04ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200a94:	742c                	ld	a1,104(s0)
ffffffffc0200a96:	00005517          	auipc	a0,0x5
ffffffffc0200a9a:	1aa50513          	addi	a0,a0,426 # ffffffffc0205c40 <commands+0x330>
ffffffffc0200a9e:	ef6ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc0200aa2:	782c                	ld	a1,112(s0)
ffffffffc0200aa4:	00005517          	auipc	a0,0x5
ffffffffc0200aa8:	1b450513          	addi	a0,a0,436 # ffffffffc0205c58 <commands+0x348>
ffffffffc0200aac:	ee8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc0200ab0:	7c2c                	ld	a1,120(s0)
ffffffffc0200ab2:	00005517          	auipc	a0,0x5
ffffffffc0200ab6:	1be50513          	addi	a0,a0,446 # ffffffffc0205c70 <commands+0x360>
ffffffffc0200aba:	edaff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200abe:	604c                	ld	a1,128(s0)
ffffffffc0200ac0:	00005517          	auipc	a0,0x5
ffffffffc0200ac4:	1c850513          	addi	a0,a0,456 # ffffffffc0205c88 <commands+0x378>
ffffffffc0200ac8:	eccff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200acc:	644c                	ld	a1,136(s0)
ffffffffc0200ace:	00005517          	auipc	a0,0x5
ffffffffc0200ad2:	1d250513          	addi	a0,a0,466 # ffffffffc0205ca0 <commands+0x390>
ffffffffc0200ad6:	ebeff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200ada:	684c                	ld	a1,144(s0)
ffffffffc0200adc:	00005517          	auipc	a0,0x5
ffffffffc0200ae0:	1dc50513          	addi	a0,a0,476 # ffffffffc0205cb8 <commands+0x3a8>
ffffffffc0200ae4:	eb0ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200ae8:	6c4c                	ld	a1,152(s0)
ffffffffc0200aea:	00005517          	auipc	a0,0x5
ffffffffc0200aee:	1e650513          	addi	a0,a0,486 # ffffffffc0205cd0 <commands+0x3c0>
ffffffffc0200af2:	ea2ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200af6:	704c                	ld	a1,160(s0)
ffffffffc0200af8:	00005517          	auipc	a0,0x5
ffffffffc0200afc:	1f050513          	addi	a0,a0,496 # ffffffffc0205ce8 <commands+0x3d8>
ffffffffc0200b00:	e94ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200b04:	744c                	ld	a1,168(s0)
ffffffffc0200b06:	00005517          	auipc	a0,0x5
ffffffffc0200b0a:	1fa50513          	addi	a0,a0,506 # ffffffffc0205d00 <commands+0x3f0>
ffffffffc0200b0e:	e86ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc0200b12:	784c                	ld	a1,176(s0)
ffffffffc0200b14:	00005517          	auipc	a0,0x5
ffffffffc0200b18:	20450513          	addi	a0,a0,516 # ffffffffc0205d18 <commands+0x408>
ffffffffc0200b1c:	e78ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc0200b20:	7c4c                	ld	a1,184(s0)
ffffffffc0200b22:	00005517          	auipc	a0,0x5
ffffffffc0200b26:	20e50513          	addi	a0,a0,526 # ffffffffc0205d30 <commands+0x420>
ffffffffc0200b2a:	e6aff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc0200b2e:	606c                	ld	a1,192(s0)
ffffffffc0200b30:	00005517          	auipc	a0,0x5
ffffffffc0200b34:	21850513          	addi	a0,a0,536 # ffffffffc0205d48 <commands+0x438>
ffffffffc0200b38:	e5cff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc0200b3c:	646c                	ld	a1,200(s0)
ffffffffc0200b3e:	00005517          	auipc	a0,0x5
ffffffffc0200b42:	22250513          	addi	a0,a0,546 # ffffffffc0205d60 <commands+0x450>
ffffffffc0200b46:	e4eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc0200b4a:	686c                	ld	a1,208(s0)
ffffffffc0200b4c:	00005517          	auipc	a0,0x5
ffffffffc0200b50:	22c50513          	addi	a0,a0,556 # ffffffffc0205d78 <commands+0x468>
ffffffffc0200b54:	e40ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc0200b58:	6c6c                	ld	a1,216(s0)
ffffffffc0200b5a:	00005517          	auipc	a0,0x5
ffffffffc0200b5e:	23650513          	addi	a0,a0,566 # ffffffffc0205d90 <commands+0x480>
ffffffffc0200b62:	e32ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200b66:	706c                	ld	a1,224(s0)
ffffffffc0200b68:	00005517          	auipc	a0,0x5
ffffffffc0200b6c:	24050513          	addi	a0,a0,576 # ffffffffc0205da8 <commands+0x498>
ffffffffc0200b70:	e24ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc0200b74:	746c                	ld	a1,232(s0)
ffffffffc0200b76:	00005517          	auipc	a0,0x5
ffffffffc0200b7a:	24a50513          	addi	a0,a0,586 # ffffffffc0205dc0 <commands+0x4b0>
ffffffffc0200b7e:	e16ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc0200b82:	786c                	ld	a1,240(s0)
ffffffffc0200b84:	00005517          	auipc	a0,0x5
ffffffffc0200b88:	25450513          	addi	a0,a0,596 # ffffffffc0205dd8 <commands+0x4c8>
ffffffffc0200b8c:	e08ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b90:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200b92:	6402                	ld	s0,0(sp)
ffffffffc0200b94:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b96:	00005517          	auipc	a0,0x5
ffffffffc0200b9a:	25a50513          	addi	a0,a0,602 # ffffffffc0205df0 <commands+0x4e0>
}
ffffffffc0200b9e:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200ba0:	df4ff06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0200ba4 <print_trapframe>:
{
ffffffffc0200ba4:	1141                	addi	sp,sp,-16
ffffffffc0200ba6:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200ba8:	85aa                	mv	a1,a0
{
ffffffffc0200baa:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bac:	00005517          	auipc	a0,0x5
ffffffffc0200bb0:	25c50513          	addi	a0,a0,604 # ffffffffc0205e08 <commands+0x4f8>
{
ffffffffc0200bb4:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bb6:	ddeff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200bba:	8522                	mv	a0,s0
ffffffffc0200bbc:	e1bff0ef          	jal	ra,ffffffffc02009d6 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200bc0:	10043583          	ld	a1,256(s0)
ffffffffc0200bc4:	00005517          	auipc	a0,0x5
ffffffffc0200bc8:	25c50513          	addi	a0,a0,604 # ffffffffc0205e20 <commands+0x510>
ffffffffc0200bcc:	dc8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200bd0:	10843583          	ld	a1,264(s0)
ffffffffc0200bd4:	00005517          	auipc	a0,0x5
ffffffffc0200bd8:	26450513          	addi	a0,a0,612 # ffffffffc0205e38 <commands+0x528>
ffffffffc0200bdc:	db8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc0200be0:	11043583          	ld	a1,272(s0)
ffffffffc0200be4:	00005517          	auipc	a0,0x5
ffffffffc0200be8:	26c50513          	addi	a0,a0,620 # ffffffffc0205e50 <commands+0x540>
ffffffffc0200bec:	da8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf0:	11843583          	ld	a1,280(s0)
}
ffffffffc0200bf4:	6402                	ld	s0,0(sp)
ffffffffc0200bf6:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf8:	00005517          	auipc	a0,0x5
ffffffffc0200bfc:	26850513          	addi	a0,a0,616 # ffffffffc0205e60 <commands+0x550>
}
ffffffffc0200c00:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200c02:	d92ff06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0200c06 <interrupt_handler>:

extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf)
{
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200c06:	11853783          	ld	a5,280(a0)
ffffffffc0200c0a:	472d                	li	a4,11
ffffffffc0200c0c:	0786                	slli	a5,a5,0x1
ffffffffc0200c0e:	8385                	srli	a5,a5,0x1
ffffffffc0200c10:	08f76463          	bltu	a4,a5,ffffffffc0200c98 <interrupt_handler+0x92>
ffffffffc0200c14:	00005717          	auipc	a4,0x5
ffffffffc0200c18:	30470713          	addi	a4,a4,772 # ffffffffc0205f18 <commands+0x608>
ffffffffc0200c1c:	078a                	slli	a5,a5,0x2
ffffffffc0200c1e:	97ba                	add	a5,a5,a4
ffffffffc0200c20:	439c                	lw	a5,0(a5)
ffffffffc0200c22:	97ba                	add	a5,a5,a4
ffffffffc0200c24:	8782                	jr	a5
        break;
    case IRQ_H_SOFT:
        cprintf("Hypervisor software interrupt\n");
        break;
    case IRQ_M_SOFT:
        cprintf("Machine software interrupt\n");
ffffffffc0200c26:	00005517          	auipc	a0,0x5
ffffffffc0200c2a:	2b250513          	addi	a0,a0,690 # ffffffffc0205ed8 <commands+0x5c8>
ffffffffc0200c2e:	d66ff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Hypervisor software interrupt\n");
ffffffffc0200c32:	00005517          	auipc	a0,0x5
ffffffffc0200c36:	28650513          	addi	a0,a0,646 # ffffffffc0205eb8 <commands+0x5a8>
ffffffffc0200c3a:	d5aff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("User software interrupt\n");
ffffffffc0200c3e:	00005517          	auipc	a0,0x5
ffffffffc0200c42:	23a50513          	addi	a0,a0,570 # ffffffffc0205e78 <commands+0x568>
ffffffffc0200c46:	d4eff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Supervisor software interrupt\n");
ffffffffc0200c4a:	00005517          	auipc	a0,0x5
ffffffffc0200c4e:	24e50513          	addi	a0,a0,590 # ffffffffc0205e98 <commands+0x588>
ffffffffc0200c52:	d42ff06f          	j	ffffffffc0200194 <cprintf>
{
ffffffffc0200c56:	1141                	addi	sp,sp,-16
ffffffffc0200c58:	e406                	sd	ra,8(sp)
        /* 时间片轮转： 
        *(1) 设置下一次时钟中断（clock_set_next_event）
        *(2) ticks 计数器自增
        *(3) 每 TICK_NUM 次中断（如 100 次），进行判断当前是否有进程正在运行，如果有则标记该进程需要被重新调度（current->need_resched）
        */
        clock_set_next_event();
ffffffffc0200c5a:	919ff0ef          	jal	ra,ffffffffc0200572 <clock_set_next_event>
        ticks++;
ffffffffc0200c5e:	000aa797          	auipc	a5,0xaa
ffffffffc0200c62:	a9a78793          	addi	a5,a5,-1382 # ffffffffc02aa6f8 <ticks>
ffffffffc0200c66:	6398                	ld	a4,0(a5)
ffffffffc0200c68:	0705                	addi	a4,a4,1
ffffffffc0200c6a:	e398                	sd	a4,0(a5)
        if(ticks % TICK_NUM == 0){
ffffffffc0200c6c:	639c                	ld	a5,0(a5)
ffffffffc0200c6e:	06400713          	li	a4,100
ffffffffc0200c72:	02e7f7b3          	remu	a5,a5,a4
ffffffffc0200c76:	eb81                	bnez	a5,ffffffffc0200c86 <interrupt_handler+0x80>
            /*print_ticks();
            num++;
            if(num == 10){
                sbi_shutdown();
            }*/
            if(current != NULL){
ffffffffc0200c78:	000aa797          	auipc	a5,0xaa
ffffffffc0200c7c:	ad87b783          	ld	a5,-1320(a5) # ffffffffc02aa750 <current>
ffffffffc0200c80:	c399                	beqz	a5,ffffffffc0200c86 <interrupt_handler+0x80>
                current->need_resched = 1;
ffffffffc0200c82:	4705                	li	a4,1
ffffffffc0200c84:	ef98                	sd	a4,24(a5)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200c86:	60a2                	ld	ra,8(sp)
ffffffffc0200c88:	0141                	addi	sp,sp,16
ffffffffc0200c8a:	8082                	ret
        cprintf("Supervisor external interrupt\n");
ffffffffc0200c8c:	00005517          	auipc	a0,0x5
ffffffffc0200c90:	26c50513          	addi	a0,a0,620 # ffffffffc0205ef8 <commands+0x5e8>
ffffffffc0200c94:	d00ff06f          	j	ffffffffc0200194 <cprintf>
        print_trapframe(tf);
ffffffffc0200c98:	b731                	j	ffffffffc0200ba4 <print_trapframe>

ffffffffc0200c9a <exception_handler>:
void kernel_execve_ret(struct trapframe *tf, uintptr_t kstacktop);
void exception_handler(struct trapframe *tf)
{
    int ret;
    switch (tf->cause)
ffffffffc0200c9a:	11853783          	ld	a5,280(a0)
{
ffffffffc0200c9e:	1141                	addi	sp,sp,-16
ffffffffc0200ca0:	e022                	sd	s0,0(sp)
ffffffffc0200ca2:	e406                	sd	ra,8(sp)
ffffffffc0200ca4:	473d                	li	a4,15
ffffffffc0200ca6:	842a                	mv	s0,a0
ffffffffc0200ca8:	0cf76463          	bltu	a4,a5,ffffffffc0200d70 <exception_handler+0xd6>
ffffffffc0200cac:	00005717          	auipc	a4,0x5
ffffffffc0200cb0:	42c70713          	addi	a4,a4,1068 # ffffffffc02060d8 <commands+0x7c8>
ffffffffc0200cb4:	078a                	slli	a5,a5,0x2
ffffffffc0200cb6:	97ba                	add	a5,a5,a4
ffffffffc0200cb8:	439c                	lw	a5,0(a5)
ffffffffc0200cba:	97ba                	add	a5,a5,a4
ffffffffc0200cbc:	8782                	jr	a5
        //对于ecall, 我们希望sepc寄存器要指向产生异常的指令(ecall)的下一条指令
        //否则就会回到ecall执行再执行一次ecall, 无限循环
        syscall();
        break;
    case CAUSE_SUPERVISOR_ECALL:
        cprintf("Environment call from S-mode\n");
ffffffffc0200cbe:	00005517          	auipc	a0,0x5
ffffffffc0200cc2:	37250513          	addi	a0,a0,882 # ffffffffc0206030 <commands+0x720>
ffffffffc0200cc6:	cceff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        tf->epc += 4;
ffffffffc0200cca:	10843783          	ld	a5,264(s0)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200cce:	60a2                	ld	ra,8(sp)
        tf->epc += 4;
ffffffffc0200cd0:	0791                	addi	a5,a5,4
ffffffffc0200cd2:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200cd6:	6402                	ld	s0,0(sp)
ffffffffc0200cd8:	0141                	addi	sp,sp,16
        syscall();
ffffffffc0200cda:	4780406f          	j	ffffffffc0205152 <syscall>
        cprintf("Environment call from H-mode\n");
ffffffffc0200cde:	00005517          	auipc	a0,0x5
ffffffffc0200ce2:	37250513          	addi	a0,a0,882 # ffffffffc0206050 <commands+0x740>
}
ffffffffc0200ce6:	6402                	ld	s0,0(sp)
ffffffffc0200ce8:	60a2                	ld	ra,8(sp)
ffffffffc0200cea:	0141                	addi	sp,sp,16
        cprintf("Instruction access fault\n");
ffffffffc0200cec:	ca8ff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Environment call from M-mode\n");
ffffffffc0200cf0:	00005517          	auipc	a0,0x5
ffffffffc0200cf4:	38050513          	addi	a0,a0,896 # ffffffffc0206070 <commands+0x760>
ffffffffc0200cf8:	b7fd                	j	ffffffffc0200ce6 <exception_handler+0x4c>
        cprintf("Instruction page fault\n");
ffffffffc0200cfa:	00005517          	auipc	a0,0x5
ffffffffc0200cfe:	39650513          	addi	a0,a0,918 # ffffffffc0206090 <commands+0x780>
ffffffffc0200d02:	b7d5                	j	ffffffffc0200ce6 <exception_handler+0x4c>
        cprintf("Load page fault\n");
ffffffffc0200d04:	00005517          	auipc	a0,0x5
ffffffffc0200d08:	3a450513          	addi	a0,a0,932 # ffffffffc02060a8 <commands+0x798>
ffffffffc0200d0c:	bfe9                	j	ffffffffc0200ce6 <exception_handler+0x4c>
        cprintf("Store/AMO page fault\n");
ffffffffc0200d0e:	00005517          	auipc	a0,0x5
ffffffffc0200d12:	3b250513          	addi	a0,a0,946 # ffffffffc02060c0 <commands+0x7b0>
ffffffffc0200d16:	bfc1                	j	ffffffffc0200ce6 <exception_handler+0x4c>
        cprintf("Instruction address misaligned\n");
ffffffffc0200d18:	00005517          	auipc	a0,0x5
ffffffffc0200d1c:	23050513          	addi	a0,a0,560 # ffffffffc0205f48 <commands+0x638>
ffffffffc0200d20:	b7d9                	j	ffffffffc0200ce6 <exception_handler+0x4c>
        cprintf("Instruction access fault\n");
ffffffffc0200d22:	00005517          	auipc	a0,0x5
ffffffffc0200d26:	24650513          	addi	a0,a0,582 # ffffffffc0205f68 <commands+0x658>
ffffffffc0200d2a:	bf75                	j	ffffffffc0200ce6 <exception_handler+0x4c>
        cprintf("Illegal instruction\n");
ffffffffc0200d2c:	00005517          	auipc	a0,0x5
ffffffffc0200d30:	25c50513          	addi	a0,a0,604 # ffffffffc0205f88 <commands+0x678>
ffffffffc0200d34:	bf4d                	j	ffffffffc0200ce6 <exception_handler+0x4c>
        cprintf("Breakpoint\n");
ffffffffc0200d36:	00005517          	auipc	a0,0x5
ffffffffc0200d3a:	26a50513          	addi	a0,a0,618 # ffffffffc0205fa0 <commands+0x690>
ffffffffc0200d3e:	c56ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        if (tf->gpr.a7 == 10)
ffffffffc0200d42:	6458                	ld	a4,136(s0)
ffffffffc0200d44:	47a9                	li	a5,10
ffffffffc0200d46:	04f70663          	beq	a4,a5,ffffffffc0200d92 <exception_handler+0xf8>
}
ffffffffc0200d4a:	60a2                	ld	ra,8(sp)
ffffffffc0200d4c:	6402                	ld	s0,0(sp)
ffffffffc0200d4e:	0141                	addi	sp,sp,16
ffffffffc0200d50:	8082                	ret
        cprintf("Load address misaligned\n");
ffffffffc0200d52:	00005517          	auipc	a0,0x5
ffffffffc0200d56:	25e50513          	addi	a0,a0,606 # ffffffffc0205fb0 <commands+0x6a0>
ffffffffc0200d5a:	b771                	j	ffffffffc0200ce6 <exception_handler+0x4c>
        cprintf("Load access fault\n");
ffffffffc0200d5c:	00005517          	auipc	a0,0x5
ffffffffc0200d60:	27450513          	addi	a0,a0,628 # ffffffffc0205fd0 <commands+0x6c0>
ffffffffc0200d64:	b749                	j	ffffffffc0200ce6 <exception_handler+0x4c>
        cprintf("Store/AMO access fault\n");
ffffffffc0200d66:	00005517          	auipc	a0,0x5
ffffffffc0200d6a:	2b250513          	addi	a0,a0,690 # ffffffffc0206018 <commands+0x708>
ffffffffc0200d6e:	bfa5                	j	ffffffffc0200ce6 <exception_handler+0x4c>
        print_trapframe(tf);
ffffffffc0200d70:	8522                	mv	a0,s0
}
ffffffffc0200d72:	6402                	ld	s0,0(sp)
ffffffffc0200d74:	60a2                	ld	ra,8(sp)
ffffffffc0200d76:	0141                	addi	sp,sp,16
        print_trapframe(tf);
ffffffffc0200d78:	b535                	j	ffffffffc0200ba4 <print_trapframe>
        panic("AMO address misaligned\n");
ffffffffc0200d7a:	00005617          	auipc	a2,0x5
ffffffffc0200d7e:	26e60613          	addi	a2,a2,622 # ffffffffc0205fe8 <commands+0x6d8>
ffffffffc0200d82:	0ce00593          	li	a1,206
ffffffffc0200d86:	00005517          	auipc	a0,0x5
ffffffffc0200d8a:	27a50513          	addi	a0,a0,634 # ffffffffc0206000 <commands+0x6f0>
ffffffffc0200d8e:	f00ff0ef          	jal	ra,ffffffffc020048e <__panic>
            tf->epc += 4;
ffffffffc0200d92:	10843783          	ld	a5,264(s0)
ffffffffc0200d96:	0791                	addi	a5,a5,4
ffffffffc0200d98:	10f43423          	sd	a5,264(s0)
            syscall();
ffffffffc0200d9c:	3b6040ef          	jal	ra,ffffffffc0205152 <syscall>
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200da0:	000aa797          	auipc	a5,0xaa
ffffffffc0200da4:	9b07b783          	ld	a5,-1616(a5) # ffffffffc02aa750 <current>
ffffffffc0200da8:	6b9c                	ld	a5,16(a5)
ffffffffc0200daa:	8522                	mv	a0,s0
}
ffffffffc0200dac:	6402                	ld	s0,0(sp)
ffffffffc0200dae:	60a2                	ld	ra,8(sp)
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200db0:	6589                	lui	a1,0x2
ffffffffc0200db2:	95be                	add	a1,a1,a5
}
ffffffffc0200db4:	0141                	addi	sp,sp,16
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200db6:	aab1                	j	ffffffffc0200f12 <kernel_execve_ret>

ffffffffc0200db8 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void trap(struct trapframe *tf)
{
ffffffffc0200db8:	1101                	addi	sp,sp,-32
ffffffffc0200dba:	e822                	sd	s0,16(sp)
    // dispatch based on what type of trap occurred
    //    cputs("some trap");
    if (current == NULL)
ffffffffc0200dbc:	000aa417          	auipc	s0,0xaa
ffffffffc0200dc0:	99440413          	addi	s0,s0,-1644 # ffffffffc02aa750 <current>
ffffffffc0200dc4:	6018                	ld	a4,0(s0)
{
ffffffffc0200dc6:	ec06                	sd	ra,24(sp)
ffffffffc0200dc8:	e426                	sd	s1,8(sp)
ffffffffc0200dca:	e04a                	sd	s2,0(sp)
    if ((intptr_t)tf->cause < 0)
ffffffffc0200dcc:	11853683          	ld	a3,280(a0)
    if (current == NULL)
ffffffffc0200dd0:	cf1d                	beqz	a4,ffffffffc0200e0e <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200dd2:	10053483          	ld	s1,256(a0)
    {
        trap_dispatch(tf);
    }
    else
    {
        struct trapframe *otf = current->tf;
ffffffffc0200dd6:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200dda:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200ddc:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0)
ffffffffc0200de0:	0206c463          	bltz	a3,ffffffffc0200e08 <trap+0x50>
        exception_handler(tf);
ffffffffc0200de4:	eb7ff0ef          	jal	ra,ffffffffc0200c9a <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200de8:	601c                	ld	a5,0(s0)
ffffffffc0200dea:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel)
ffffffffc0200dee:	e499                	bnez	s1,ffffffffc0200dfc <trap+0x44>
        {
            if (current->flags & PF_EXITING)
ffffffffc0200df0:	0b07a703          	lw	a4,176(a5)
ffffffffc0200df4:	8b05                	andi	a4,a4,1
ffffffffc0200df6:	e329                	bnez	a4,ffffffffc0200e38 <trap+0x80>
            {
                do_exit(-E_KILLED);
            }
            if (current->need_resched)
ffffffffc0200df8:	6f9c                	ld	a5,24(a5)
ffffffffc0200dfa:	eb85                	bnez	a5,ffffffffc0200e2a <trap+0x72>
            {
                schedule();
            }
        }
    }
}
ffffffffc0200dfc:	60e2                	ld	ra,24(sp)
ffffffffc0200dfe:	6442                	ld	s0,16(sp)
ffffffffc0200e00:	64a2                	ld	s1,8(sp)
ffffffffc0200e02:	6902                	ld	s2,0(sp)
ffffffffc0200e04:	6105                	addi	sp,sp,32
ffffffffc0200e06:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200e08:	dffff0ef          	jal	ra,ffffffffc0200c06 <interrupt_handler>
ffffffffc0200e0c:	bff1                	j	ffffffffc0200de8 <trap+0x30>
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e0e:	0006c863          	bltz	a3,ffffffffc0200e1e <trap+0x66>
}
ffffffffc0200e12:	6442                	ld	s0,16(sp)
ffffffffc0200e14:	60e2                	ld	ra,24(sp)
ffffffffc0200e16:	64a2                	ld	s1,8(sp)
ffffffffc0200e18:	6902                	ld	s2,0(sp)
ffffffffc0200e1a:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200e1c:	bdbd                	j	ffffffffc0200c9a <exception_handler>
}
ffffffffc0200e1e:	6442                	ld	s0,16(sp)
ffffffffc0200e20:	60e2                	ld	ra,24(sp)
ffffffffc0200e22:	64a2                	ld	s1,8(sp)
ffffffffc0200e24:	6902                	ld	s2,0(sp)
ffffffffc0200e26:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200e28:	bbf9                	j	ffffffffc0200c06 <interrupt_handler>
}
ffffffffc0200e2a:	6442                	ld	s0,16(sp)
ffffffffc0200e2c:	60e2                	ld	ra,24(sp)
ffffffffc0200e2e:	64a2                	ld	s1,8(sp)
ffffffffc0200e30:	6902                	ld	s2,0(sp)
ffffffffc0200e32:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200e34:	2320406f          	j	ffffffffc0205066 <schedule>
                do_exit(-E_KILLED);
ffffffffc0200e38:	555d                	li	a0,-9
ffffffffc0200e3a:	572030ef          	jal	ra,ffffffffc02043ac <do_exit>
            if (current->need_resched)
ffffffffc0200e3e:	601c                	ld	a5,0(s0)
ffffffffc0200e40:	bf65                	j	ffffffffc0200df8 <trap+0x40>
	...

ffffffffc0200e44 <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200e44:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200e48:	00011463          	bnez	sp,ffffffffc0200e50 <__alltraps+0xc>
ffffffffc0200e4c:	14002173          	csrr	sp,sscratch
ffffffffc0200e50:	712d                	addi	sp,sp,-288
ffffffffc0200e52:	e002                	sd	zero,0(sp)
ffffffffc0200e54:	e406                	sd	ra,8(sp)
ffffffffc0200e56:	ec0e                	sd	gp,24(sp)
ffffffffc0200e58:	f012                	sd	tp,32(sp)
ffffffffc0200e5a:	f416                	sd	t0,40(sp)
ffffffffc0200e5c:	f81a                	sd	t1,48(sp)
ffffffffc0200e5e:	fc1e                	sd	t2,56(sp)
ffffffffc0200e60:	e0a2                	sd	s0,64(sp)
ffffffffc0200e62:	e4a6                	sd	s1,72(sp)
ffffffffc0200e64:	e8aa                	sd	a0,80(sp)
ffffffffc0200e66:	ecae                	sd	a1,88(sp)
ffffffffc0200e68:	f0b2                	sd	a2,96(sp)
ffffffffc0200e6a:	f4b6                	sd	a3,104(sp)
ffffffffc0200e6c:	f8ba                	sd	a4,112(sp)
ffffffffc0200e6e:	fcbe                	sd	a5,120(sp)
ffffffffc0200e70:	e142                	sd	a6,128(sp)
ffffffffc0200e72:	e546                	sd	a7,136(sp)
ffffffffc0200e74:	e94a                	sd	s2,144(sp)
ffffffffc0200e76:	ed4e                	sd	s3,152(sp)
ffffffffc0200e78:	f152                	sd	s4,160(sp)
ffffffffc0200e7a:	f556                	sd	s5,168(sp)
ffffffffc0200e7c:	f95a                	sd	s6,176(sp)
ffffffffc0200e7e:	fd5e                	sd	s7,184(sp)
ffffffffc0200e80:	e1e2                	sd	s8,192(sp)
ffffffffc0200e82:	e5e6                	sd	s9,200(sp)
ffffffffc0200e84:	e9ea                	sd	s10,208(sp)
ffffffffc0200e86:	edee                	sd	s11,216(sp)
ffffffffc0200e88:	f1f2                	sd	t3,224(sp)
ffffffffc0200e8a:	f5f6                	sd	t4,232(sp)
ffffffffc0200e8c:	f9fa                	sd	t5,240(sp)
ffffffffc0200e8e:	fdfe                	sd	t6,248(sp)
ffffffffc0200e90:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200e94:	100024f3          	csrr	s1,sstatus
ffffffffc0200e98:	14102973          	csrr	s2,sepc
ffffffffc0200e9c:	143029f3          	csrr	s3,stval
ffffffffc0200ea0:	14202a73          	csrr	s4,scause
ffffffffc0200ea4:	e822                	sd	s0,16(sp)
ffffffffc0200ea6:	e226                	sd	s1,256(sp)
ffffffffc0200ea8:	e64a                	sd	s2,264(sp)
ffffffffc0200eaa:	ea4e                	sd	s3,272(sp)
ffffffffc0200eac:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200eae:	850a                	mv	a0,sp
    jal trap
ffffffffc0200eb0:	f09ff0ef          	jal	ra,ffffffffc0200db8 <trap>

ffffffffc0200eb4 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200eb4:	6492                	ld	s1,256(sp)
ffffffffc0200eb6:	6932                	ld	s2,264(sp)
ffffffffc0200eb8:	1004f413          	andi	s0,s1,256
ffffffffc0200ebc:	e401                	bnez	s0,ffffffffc0200ec4 <__trapret+0x10>
ffffffffc0200ebe:	1200                	addi	s0,sp,288
ffffffffc0200ec0:	14041073          	csrw	sscratch,s0
ffffffffc0200ec4:	10049073          	csrw	sstatus,s1
ffffffffc0200ec8:	14191073          	csrw	sepc,s2
ffffffffc0200ecc:	60a2                	ld	ra,8(sp)
ffffffffc0200ece:	61e2                	ld	gp,24(sp)
ffffffffc0200ed0:	7202                	ld	tp,32(sp)
ffffffffc0200ed2:	72a2                	ld	t0,40(sp)
ffffffffc0200ed4:	7342                	ld	t1,48(sp)
ffffffffc0200ed6:	73e2                	ld	t2,56(sp)
ffffffffc0200ed8:	6406                	ld	s0,64(sp)
ffffffffc0200eda:	64a6                	ld	s1,72(sp)
ffffffffc0200edc:	6546                	ld	a0,80(sp)
ffffffffc0200ede:	65e6                	ld	a1,88(sp)
ffffffffc0200ee0:	7606                	ld	a2,96(sp)
ffffffffc0200ee2:	76a6                	ld	a3,104(sp)
ffffffffc0200ee4:	7746                	ld	a4,112(sp)
ffffffffc0200ee6:	77e6                	ld	a5,120(sp)
ffffffffc0200ee8:	680a                	ld	a6,128(sp)
ffffffffc0200eea:	68aa                	ld	a7,136(sp)
ffffffffc0200eec:	694a                	ld	s2,144(sp)
ffffffffc0200eee:	69ea                	ld	s3,152(sp)
ffffffffc0200ef0:	7a0a                	ld	s4,160(sp)
ffffffffc0200ef2:	7aaa                	ld	s5,168(sp)
ffffffffc0200ef4:	7b4a                	ld	s6,176(sp)
ffffffffc0200ef6:	7bea                	ld	s7,184(sp)
ffffffffc0200ef8:	6c0e                	ld	s8,192(sp)
ffffffffc0200efa:	6cae                	ld	s9,200(sp)
ffffffffc0200efc:	6d4e                	ld	s10,208(sp)
ffffffffc0200efe:	6dee                	ld	s11,216(sp)
ffffffffc0200f00:	7e0e                	ld	t3,224(sp)
ffffffffc0200f02:	7eae                	ld	t4,232(sp)
ffffffffc0200f04:	7f4e                	ld	t5,240(sp)
ffffffffc0200f06:	7fee                	ld	t6,248(sp)
ffffffffc0200f08:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200f0a:	10200073          	sret

ffffffffc0200f0e <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200f0e:	812a                	mv	sp,a0
    j __trapret
ffffffffc0200f10:	b755                	j	ffffffffc0200eb4 <__trapret>

ffffffffc0200f12 <kernel_execve_ret>:

    .global kernel_execve_ret
kernel_execve_ret:
    // adjust sp to beneath kstacktop of current process
    addi a1, a1, -36*REGBYTES
ffffffffc0200f12:	ee058593          	addi	a1,a1,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x7cd0>

    // copy from previous trapframe to new trapframe
    LOAD s1, 35*REGBYTES(a0)
ffffffffc0200f16:	11853483          	ld	s1,280(a0)
    STORE s1, 35*REGBYTES(a1)
ffffffffc0200f1a:	1095bc23          	sd	s1,280(a1)
    LOAD s1, 34*REGBYTES(a0)
ffffffffc0200f1e:	11053483          	ld	s1,272(a0)
    STORE s1, 34*REGBYTES(a1)
ffffffffc0200f22:	1095b823          	sd	s1,272(a1)
    LOAD s1, 33*REGBYTES(a0)
ffffffffc0200f26:	10853483          	ld	s1,264(a0)
    STORE s1, 33*REGBYTES(a1)
ffffffffc0200f2a:	1095b423          	sd	s1,264(a1)
    LOAD s1, 32*REGBYTES(a0)
ffffffffc0200f2e:	10053483          	ld	s1,256(a0)
    STORE s1, 32*REGBYTES(a1)
ffffffffc0200f32:	1095b023          	sd	s1,256(a1)
    LOAD s1, 31*REGBYTES(a0)
ffffffffc0200f36:	7d64                	ld	s1,248(a0)
    STORE s1, 31*REGBYTES(a1)
ffffffffc0200f38:	fde4                	sd	s1,248(a1)
    LOAD s1, 30*REGBYTES(a0)
ffffffffc0200f3a:	7964                	ld	s1,240(a0)
    STORE s1, 30*REGBYTES(a1)
ffffffffc0200f3c:	f9e4                	sd	s1,240(a1)
    LOAD s1, 29*REGBYTES(a0)
ffffffffc0200f3e:	7564                	ld	s1,232(a0)
    STORE s1, 29*REGBYTES(a1)
ffffffffc0200f40:	f5e4                	sd	s1,232(a1)
    LOAD s1, 28*REGBYTES(a0)
ffffffffc0200f42:	7164                	ld	s1,224(a0)
    STORE s1, 28*REGBYTES(a1)
ffffffffc0200f44:	f1e4                	sd	s1,224(a1)
    LOAD s1, 27*REGBYTES(a0)
ffffffffc0200f46:	6d64                	ld	s1,216(a0)
    STORE s1, 27*REGBYTES(a1)
ffffffffc0200f48:	ede4                	sd	s1,216(a1)
    LOAD s1, 26*REGBYTES(a0)
ffffffffc0200f4a:	6964                	ld	s1,208(a0)
    STORE s1, 26*REGBYTES(a1)
ffffffffc0200f4c:	e9e4                	sd	s1,208(a1)
    LOAD s1, 25*REGBYTES(a0)
ffffffffc0200f4e:	6564                	ld	s1,200(a0)
    STORE s1, 25*REGBYTES(a1)
ffffffffc0200f50:	e5e4                	sd	s1,200(a1)
    LOAD s1, 24*REGBYTES(a0)
ffffffffc0200f52:	6164                	ld	s1,192(a0)
    STORE s1, 24*REGBYTES(a1)
ffffffffc0200f54:	e1e4                	sd	s1,192(a1)
    LOAD s1, 23*REGBYTES(a0)
ffffffffc0200f56:	7d44                	ld	s1,184(a0)
    STORE s1, 23*REGBYTES(a1)
ffffffffc0200f58:	fdc4                	sd	s1,184(a1)
    LOAD s1, 22*REGBYTES(a0)
ffffffffc0200f5a:	7944                	ld	s1,176(a0)
    STORE s1, 22*REGBYTES(a1)
ffffffffc0200f5c:	f9c4                	sd	s1,176(a1)
    LOAD s1, 21*REGBYTES(a0)
ffffffffc0200f5e:	7544                	ld	s1,168(a0)
    STORE s1, 21*REGBYTES(a1)
ffffffffc0200f60:	f5c4                	sd	s1,168(a1)
    LOAD s1, 20*REGBYTES(a0)
ffffffffc0200f62:	7144                	ld	s1,160(a0)
    STORE s1, 20*REGBYTES(a1)
ffffffffc0200f64:	f1c4                	sd	s1,160(a1)
    LOAD s1, 19*REGBYTES(a0)
ffffffffc0200f66:	6d44                	ld	s1,152(a0)
    STORE s1, 19*REGBYTES(a1)
ffffffffc0200f68:	edc4                	sd	s1,152(a1)
    LOAD s1, 18*REGBYTES(a0)
ffffffffc0200f6a:	6944                	ld	s1,144(a0)
    STORE s1, 18*REGBYTES(a1)
ffffffffc0200f6c:	e9c4                	sd	s1,144(a1)
    LOAD s1, 17*REGBYTES(a0)
ffffffffc0200f6e:	6544                	ld	s1,136(a0)
    STORE s1, 17*REGBYTES(a1)
ffffffffc0200f70:	e5c4                	sd	s1,136(a1)
    LOAD s1, 16*REGBYTES(a0)
ffffffffc0200f72:	6144                	ld	s1,128(a0)
    STORE s1, 16*REGBYTES(a1)
ffffffffc0200f74:	e1c4                	sd	s1,128(a1)
    LOAD s1, 15*REGBYTES(a0)
ffffffffc0200f76:	7d24                	ld	s1,120(a0)
    STORE s1, 15*REGBYTES(a1)
ffffffffc0200f78:	fda4                	sd	s1,120(a1)
    LOAD s1, 14*REGBYTES(a0)
ffffffffc0200f7a:	7924                	ld	s1,112(a0)
    STORE s1, 14*REGBYTES(a1)
ffffffffc0200f7c:	f9a4                	sd	s1,112(a1)
    LOAD s1, 13*REGBYTES(a0)
ffffffffc0200f7e:	7524                	ld	s1,104(a0)
    STORE s1, 13*REGBYTES(a1)
ffffffffc0200f80:	f5a4                	sd	s1,104(a1)
    LOAD s1, 12*REGBYTES(a0)
ffffffffc0200f82:	7124                	ld	s1,96(a0)
    STORE s1, 12*REGBYTES(a1)
ffffffffc0200f84:	f1a4                	sd	s1,96(a1)
    LOAD s1, 11*REGBYTES(a0)
ffffffffc0200f86:	6d24                	ld	s1,88(a0)
    STORE s1, 11*REGBYTES(a1)
ffffffffc0200f88:	eda4                	sd	s1,88(a1)
    LOAD s1, 10*REGBYTES(a0)
ffffffffc0200f8a:	6924                	ld	s1,80(a0)
    STORE s1, 10*REGBYTES(a1)
ffffffffc0200f8c:	e9a4                	sd	s1,80(a1)
    LOAD s1, 9*REGBYTES(a0)
ffffffffc0200f8e:	6524                	ld	s1,72(a0)
    STORE s1, 9*REGBYTES(a1)
ffffffffc0200f90:	e5a4                	sd	s1,72(a1)
    LOAD s1, 8*REGBYTES(a0)
ffffffffc0200f92:	6124                	ld	s1,64(a0)
    STORE s1, 8*REGBYTES(a1)
ffffffffc0200f94:	e1a4                	sd	s1,64(a1)
    LOAD s1, 7*REGBYTES(a0)
ffffffffc0200f96:	7d04                	ld	s1,56(a0)
    STORE s1, 7*REGBYTES(a1)
ffffffffc0200f98:	fd84                	sd	s1,56(a1)
    LOAD s1, 6*REGBYTES(a0)
ffffffffc0200f9a:	7904                	ld	s1,48(a0)
    STORE s1, 6*REGBYTES(a1)
ffffffffc0200f9c:	f984                	sd	s1,48(a1)
    LOAD s1, 5*REGBYTES(a0)
ffffffffc0200f9e:	7504                	ld	s1,40(a0)
    STORE s1, 5*REGBYTES(a1)
ffffffffc0200fa0:	f584                	sd	s1,40(a1)
    LOAD s1, 4*REGBYTES(a0)
ffffffffc0200fa2:	7104                	ld	s1,32(a0)
    STORE s1, 4*REGBYTES(a1)
ffffffffc0200fa4:	f184                	sd	s1,32(a1)
    LOAD s1, 3*REGBYTES(a0)
ffffffffc0200fa6:	6d04                	ld	s1,24(a0)
    STORE s1, 3*REGBYTES(a1)
ffffffffc0200fa8:	ed84                	sd	s1,24(a1)
    LOAD s1, 2*REGBYTES(a0)
ffffffffc0200faa:	6904                	ld	s1,16(a0)
    STORE s1, 2*REGBYTES(a1)
ffffffffc0200fac:	e984                	sd	s1,16(a1)
    LOAD s1, 1*REGBYTES(a0)
ffffffffc0200fae:	6504                	ld	s1,8(a0)
    STORE s1, 1*REGBYTES(a1)
ffffffffc0200fb0:	e584                	sd	s1,8(a1)
    LOAD s1, 0*REGBYTES(a0)
ffffffffc0200fb2:	6104                	ld	s1,0(a0)
    STORE s1, 0*REGBYTES(a1)
ffffffffc0200fb4:	e184                	sd	s1,0(a1)

    // acutually adjust sp
    move sp, a1
ffffffffc0200fb6:	812e                	mv	sp,a1
ffffffffc0200fb8:	bdf5                	j	ffffffffc0200eb4 <__trapret>

ffffffffc0200fba <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200fba:	000a5797          	auipc	a5,0xa5
ffffffffc0200fbe:	70e78793          	addi	a5,a5,1806 # ffffffffc02a66c8 <free_area>
ffffffffc0200fc2:	e79c                	sd	a5,8(a5)
ffffffffc0200fc4:	e39c                	sd	a5,0(a5)

static void
default_init(void)
{
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200fc6:	0007a823          	sw	zero,16(a5)
}
ffffffffc0200fca:	8082                	ret

ffffffffc0200fcc <default_nr_free_pages>:

static size_t
default_nr_free_pages(void)
{
    return nr_free;
}
ffffffffc0200fcc:	000a5517          	auipc	a0,0xa5
ffffffffc0200fd0:	70c56503          	lwu	a0,1804(a0) # ffffffffc02a66d8 <free_area+0x10>
ffffffffc0200fd4:	8082                	ret

ffffffffc0200fd6 <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1)
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void)
{
ffffffffc0200fd6:	715d                	addi	sp,sp,-80
ffffffffc0200fd8:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200fda:	000a5417          	auipc	s0,0xa5
ffffffffc0200fde:	6ee40413          	addi	s0,s0,1774 # ffffffffc02a66c8 <free_area>
ffffffffc0200fe2:	641c                	ld	a5,8(s0)
ffffffffc0200fe4:	e486                	sd	ra,72(sp)
ffffffffc0200fe6:	fc26                	sd	s1,56(sp)
ffffffffc0200fe8:	f84a                	sd	s2,48(sp)
ffffffffc0200fea:	f44e                	sd	s3,40(sp)
ffffffffc0200fec:	f052                	sd	s4,32(sp)
ffffffffc0200fee:	ec56                	sd	s5,24(sp)
ffffffffc0200ff0:	e85a                	sd	s6,16(sp)
ffffffffc0200ff2:	e45e                	sd	s7,8(sp)
ffffffffc0200ff4:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc0200ff6:	2a878d63          	beq	a5,s0,ffffffffc02012b0 <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc0200ffa:	4481                	li	s1,0
ffffffffc0200ffc:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0200ffe:	ff07b703          	ld	a4,-16(a5)
    {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0201002:	8b09                	andi	a4,a4,2
ffffffffc0201004:	2a070a63          	beqz	a4,ffffffffc02012b8 <default_check+0x2e2>
        count++, total += p->property;
ffffffffc0201008:	ff87a703          	lw	a4,-8(a5)
ffffffffc020100c:	679c                	ld	a5,8(a5)
ffffffffc020100e:	2905                	addiw	s2,s2,1
ffffffffc0201010:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc0201012:	fe8796e3          	bne	a5,s0,ffffffffc0200ffe <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc0201016:	89a6                	mv	s3,s1
ffffffffc0201018:	6df000ef          	jal	ra,ffffffffc0201ef6 <nr_free_pages>
ffffffffc020101c:	6f351e63          	bne	a0,s3,ffffffffc0201718 <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201020:	4505                	li	a0,1
ffffffffc0201022:	657000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc0201026:	8aaa                	mv	s5,a0
ffffffffc0201028:	42050863          	beqz	a0,ffffffffc0201458 <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc020102c:	4505                	li	a0,1
ffffffffc020102e:	64b000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc0201032:	89aa                	mv	s3,a0
ffffffffc0201034:	70050263          	beqz	a0,ffffffffc0201738 <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201038:	4505                	li	a0,1
ffffffffc020103a:	63f000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc020103e:	8a2a                	mv	s4,a0
ffffffffc0201040:	48050c63          	beqz	a0,ffffffffc02014d8 <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201044:	293a8a63          	beq	s5,s3,ffffffffc02012d8 <default_check+0x302>
ffffffffc0201048:	28aa8863          	beq	s5,a0,ffffffffc02012d8 <default_check+0x302>
ffffffffc020104c:	28a98663          	beq	s3,a0,ffffffffc02012d8 <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201050:	000aa783          	lw	a5,0(s5)
ffffffffc0201054:	2a079263          	bnez	a5,ffffffffc02012f8 <default_check+0x322>
ffffffffc0201058:	0009a783          	lw	a5,0(s3)
ffffffffc020105c:	28079e63          	bnez	a5,ffffffffc02012f8 <default_check+0x322>
ffffffffc0201060:	411c                	lw	a5,0(a0)
ffffffffc0201062:	28079b63          	bnez	a5,ffffffffc02012f8 <default_check+0x322>
extern uint_t va_pa_offset;

static inline ppn_t
page2ppn(struct Page *page)
{
    return page - pages + nbase;
ffffffffc0201066:	000a9797          	auipc	a5,0xa9
ffffffffc020106a:	6d27b783          	ld	a5,1746(a5) # ffffffffc02aa738 <pages>
ffffffffc020106e:	40fa8733          	sub	a4,s5,a5
ffffffffc0201072:	00006617          	auipc	a2,0x6
ffffffffc0201076:	76663603          	ld	a2,1894(a2) # ffffffffc02077d8 <nbase>
ffffffffc020107a:	8719                	srai	a4,a4,0x6
ffffffffc020107c:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc020107e:	000a9697          	auipc	a3,0xa9
ffffffffc0201082:	6b26b683          	ld	a3,1714(a3) # ffffffffc02aa730 <npage>
ffffffffc0201086:	06b2                	slli	a3,a3,0xc
}

static inline uintptr_t
page2pa(struct Page *page)
{
    return page2ppn(page) << PGSHIFT;
ffffffffc0201088:	0732                	slli	a4,a4,0xc
ffffffffc020108a:	28d77763          	bgeu	a4,a3,ffffffffc0201318 <default_check+0x342>
    return page - pages + nbase;
ffffffffc020108e:	40f98733          	sub	a4,s3,a5
ffffffffc0201092:	8719                	srai	a4,a4,0x6
ffffffffc0201094:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0201096:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201098:	4cd77063          	bgeu	a4,a3,ffffffffc0201558 <default_check+0x582>
    return page - pages + nbase;
ffffffffc020109c:	40f507b3          	sub	a5,a0,a5
ffffffffc02010a0:	8799                	srai	a5,a5,0x6
ffffffffc02010a2:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02010a4:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02010a6:	30d7f963          	bgeu	a5,a3,ffffffffc02013b8 <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc02010aa:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02010ac:	00043c03          	ld	s8,0(s0)
ffffffffc02010b0:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc02010b4:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc02010b8:	e400                	sd	s0,8(s0)
ffffffffc02010ba:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc02010bc:	000a5797          	auipc	a5,0xa5
ffffffffc02010c0:	6007ae23          	sw	zero,1564(a5) # ffffffffc02a66d8 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc02010c4:	5b5000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc02010c8:	2c051863          	bnez	a0,ffffffffc0201398 <default_check+0x3c2>
    free_page(p0);
ffffffffc02010cc:	4585                	li	a1,1
ffffffffc02010ce:	8556                	mv	a0,s5
ffffffffc02010d0:	5e7000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    free_page(p1);
ffffffffc02010d4:	4585                	li	a1,1
ffffffffc02010d6:	854e                	mv	a0,s3
ffffffffc02010d8:	5df000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    free_page(p2);
ffffffffc02010dc:	4585                	li	a1,1
ffffffffc02010de:	8552                	mv	a0,s4
ffffffffc02010e0:	5d7000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    assert(nr_free == 3);
ffffffffc02010e4:	4818                	lw	a4,16(s0)
ffffffffc02010e6:	478d                	li	a5,3
ffffffffc02010e8:	28f71863          	bne	a4,a5,ffffffffc0201378 <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc02010ec:	4505                	li	a0,1
ffffffffc02010ee:	58b000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc02010f2:	89aa                	mv	s3,a0
ffffffffc02010f4:	26050263          	beqz	a0,ffffffffc0201358 <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02010f8:	4505                	li	a0,1
ffffffffc02010fa:	57f000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc02010fe:	8aaa                	mv	s5,a0
ffffffffc0201100:	3a050c63          	beqz	a0,ffffffffc02014b8 <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201104:	4505                	li	a0,1
ffffffffc0201106:	573000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc020110a:	8a2a                	mv	s4,a0
ffffffffc020110c:	38050663          	beqz	a0,ffffffffc0201498 <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc0201110:	4505                	li	a0,1
ffffffffc0201112:	567000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc0201116:	36051163          	bnez	a0,ffffffffc0201478 <default_check+0x4a2>
    free_page(p0);
ffffffffc020111a:	4585                	li	a1,1
ffffffffc020111c:	854e                	mv	a0,s3
ffffffffc020111e:	599000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0201122:	641c                	ld	a5,8(s0)
ffffffffc0201124:	20878a63          	beq	a5,s0,ffffffffc0201338 <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0201128:	4505                	li	a0,1
ffffffffc020112a:	54f000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc020112e:	30a99563          	bne	s3,a0,ffffffffc0201438 <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc0201132:	4505                	li	a0,1
ffffffffc0201134:	545000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc0201138:	2e051063          	bnez	a0,ffffffffc0201418 <default_check+0x442>
    assert(nr_free == 0);
ffffffffc020113c:	481c                	lw	a5,16(s0)
ffffffffc020113e:	2a079d63          	bnez	a5,ffffffffc02013f8 <default_check+0x422>
    free_page(p);
ffffffffc0201142:	854e                	mv	a0,s3
ffffffffc0201144:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0201146:	01843023          	sd	s8,0(s0)
ffffffffc020114a:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc020114e:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc0201152:	565000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    free_page(p1);
ffffffffc0201156:	4585                	li	a1,1
ffffffffc0201158:	8556                	mv	a0,s5
ffffffffc020115a:	55d000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    free_page(p2);
ffffffffc020115e:	4585                	li	a1,1
ffffffffc0201160:	8552                	mv	a0,s4
ffffffffc0201162:	555000ef          	jal	ra,ffffffffc0201eb6 <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc0201166:	4515                	li	a0,5
ffffffffc0201168:	511000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc020116c:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc020116e:	26050563          	beqz	a0,ffffffffc02013d8 <default_check+0x402>
ffffffffc0201172:	651c                	ld	a5,8(a0)
ffffffffc0201174:	8385                	srli	a5,a5,0x1
ffffffffc0201176:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc0201178:	54079063          	bnez	a5,ffffffffc02016b8 <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc020117c:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc020117e:	00043b03          	ld	s6,0(s0)
ffffffffc0201182:	00843a83          	ld	s5,8(s0)
ffffffffc0201186:	e000                	sd	s0,0(s0)
ffffffffc0201188:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc020118a:	4ef000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc020118e:	50051563          	bnez	a0,ffffffffc0201698 <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc0201192:	08098a13          	addi	s4,s3,128
ffffffffc0201196:	8552                	mv	a0,s4
ffffffffc0201198:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc020119a:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc020119e:	000a5797          	auipc	a5,0xa5
ffffffffc02011a2:	5207ad23          	sw	zero,1338(a5) # ffffffffc02a66d8 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc02011a6:	511000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc02011aa:	4511                	li	a0,4
ffffffffc02011ac:	4cd000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc02011b0:	4c051463          	bnez	a0,ffffffffc0201678 <default_check+0x6a2>
ffffffffc02011b4:	0889b783          	ld	a5,136(s3)
ffffffffc02011b8:	8385                	srli	a5,a5,0x1
ffffffffc02011ba:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc02011bc:	48078e63          	beqz	a5,ffffffffc0201658 <default_check+0x682>
ffffffffc02011c0:	0909a703          	lw	a4,144(s3)
ffffffffc02011c4:	478d                	li	a5,3
ffffffffc02011c6:	48f71963          	bne	a4,a5,ffffffffc0201658 <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc02011ca:	450d                	li	a0,3
ffffffffc02011cc:	4ad000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc02011d0:	8c2a                	mv	s8,a0
ffffffffc02011d2:	46050363          	beqz	a0,ffffffffc0201638 <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc02011d6:	4505                	li	a0,1
ffffffffc02011d8:	4a1000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc02011dc:	42051e63          	bnez	a0,ffffffffc0201618 <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc02011e0:	418a1c63          	bne	s4,s8,ffffffffc02015f8 <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc02011e4:	4585                	li	a1,1
ffffffffc02011e6:	854e                	mv	a0,s3
ffffffffc02011e8:	4cf000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    free_pages(p1, 3);
ffffffffc02011ec:	458d                	li	a1,3
ffffffffc02011ee:	8552                	mv	a0,s4
ffffffffc02011f0:	4c7000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
ffffffffc02011f4:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc02011f8:	04098c13          	addi	s8,s3,64
ffffffffc02011fc:	8385                	srli	a5,a5,0x1
ffffffffc02011fe:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201200:	3c078c63          	beqz	a5,ffffffffc02015d8 <default_check+0x602>
ffffffffc0201204:	0109a703          	lw	a4,16(s3)
ffffffffc0201208:	4785                	li	a5,1
ffffffffc020120a:	3cf71763          	bne	a4,a5,ffffffffc02015d8 <default_check+0x602>
ffffffffc020120e:	008a3783          	ld	a5,8(s4)
ffffffffc0201212:	8385                	srli	a5,a5,0x1
ffffffffc0201214:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0201216:	3a078163          	beqz	a5,ffffffffc02015b8 <default_check+0x5e2>
ffffffffc020121a:	010a2703          	lw	a4,16(s4)
ffffffffc020121e:	478d                	li	a5,3
ffffffffc0201220:	38f71c63          	bne	a4,a5,ffffffffc02015b8 <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0201224:	4505                	li	a0,1
ffffffffc0201226:	453000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc020122a:	36a99763          	bne	s3,a0,ffffffffc0201598 <default_check+0x5c2>
    free_page(p0);
ffffffffc020122e:	4585                	li	a1,1
ffffffffc0201230:	487000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201234:	4509                	li	a0,2
ffffffffc0201236:	443000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc020123a:	32aa1f63          	bne	s4,a0,ffffffffc0201578 <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc020123e:	4589                	li	a1,2
ffffffffc0201240:	477000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    free_page(p2);
ffffffffc0201244:	4585                	li	a1,1
ffffffffc0201246:	8562                	mv	a0,s8
ffffffffc0201248:	46f000ef          	jal	ra,ffffffffc0201eb6 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc020124c:	4515                	li	a0,5
ffffffffc020124e:	42b000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc0201252:	89aa                	mv	s3,a0
ffffffffc0201254:	48050263          	beqz	a0,ffffffffc02016d8 <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc0201258:	4505                	li	a0,1
ffffffffc020125a:	41f000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc020125e:	2c051d63          	bnez	a0,ffffffffc0201538 <default_check+0x562>

    assert(nr_free == 0);
ffffffffc0201262:	481c                	lw	a5,16(s0)
ffffffffc0201264:	2a079a63          	bnez	a5,ffffffffc0201518 <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0201268:	4595                	li	a1,5
ffffffffc020126a:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc020126c:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc0201270:	01643023          	sd	s6,0(s0)
ffffffffc0201274:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0201278:	43f000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    return listelm->next;
ffffffffc020127c:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc020127e:	00878963          	beq	a5,s0,ffffffffc0201290 <default_check+0x2ba>
    {
        struct Page *p = le2page(le, page_link);
        count--, total -= p->property;
ffffffffc0201282:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201286:	679c                	ld	a5,8(a5)
ffffffffc0201288:	397d                	addiw	s2,s2,-1
ffffffffc020128a:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc020128c:	fe879be3          	bne	a5,s0,ffffffffc0201282 <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc0201290:	26091463          	bnez	s2,ffffffffc02014f8 <default_check+0x522>
    assert(total == 0);
ffffffffc0201294:	46049263          	bnez	s1,ffffffffc02016f8 <default_check+0x722>
}
ffffffffc0201298:	60a6                	ld	ra,72(sp)
ffffffffc020129a:	6406                	ld	s0,64(sp)
ffffffffc020129c:	74e2                	ld	s1,56(sp)
ffffffffc020129e:	7942                	ld	s2,48(sp)
ffffffffc02012a0:	79a2                	ld	s3,40(sp)
ffffffffc02012a2:	7a02                	ld	s4,32(sp)
ffffffffc02012a4:	6ae2                	ld	s5,24(sp)
ffffffffc02012a6:	6b42                	ld	s6,16(sp)
ffffffffc02012a8:	6ba2                	ld	s7,8(sp)
ffffffffc02012aa:	6c02                	ld	s8,0(sp)
ffffffffc02012ac:	6161                	addi	sp,sp,80
ffffffffc02012ae:	8082                	ret
    while ((le = list_next(le)) != &free_list)
ffffffffc02012b0:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc02012b2:	4481                	li	s1,0
ffffffffc02012b4:	4901                	li	s2,0
ffffffffc02012b6:	b38d                	j	ffffffffc0201018 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc02012b8:	00005697          	auipc	a3,0x5
ffffffffc02012bc:	e6068693          	addi	a3,a3,-416 # ffffffffc0206118 <commands+0x808>
ffffffffc02012c0:	00005617          	auipc	a2,0x5
ffffffffc02012c4:	e6860613          	addi	a2,a2,-408 # ffffffffc0206128 <commands+0x818>
ffffffffc02012c8:	11000593          	li	a1,272
ffffffffc02012cc:	00005517          	auipc	a0,0x5
ffffffffc02012d0:	e7450513          	addi	a0,a0,-396 # ffffffffc0206140 <commands+0x830>
ffffffffc02012d4:	9baff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc02012d8:	00005697          	auipc	a3,0x5
ffffffffc02012dc:	f0068693          	addi	a3,a3,-256 # ffffffffc02061d8 <commands+0x8c8>
ffffffffc02012e0:	00005617          	auipc	a2,0x5
ffffffffc02012e4:	e4860613          	addi	a2,a2,-440 # ffffffffc0206128 <commands+0x818>
ffffffffc02012e8:	0db00593          	li	a1,219
ffffffffc02012ec:	00005517          	auipc	a0,0x5
ffffffffc02012f0:	e5450513          	addi	a0,a0,-428 # ffffffffc0206140 <commands+0x830>
ffffffffc02012f4:	99aff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc02012f8:	00005697          	auipc	a3,0x5
ffffffffc02012fc:	f0868693          	addi	a3,a3,-248 # ffffffffc0206200 <commands+0x8f0>
ffffffffc0201300:	00005617          	auipc	a2,0x5
ffffffffc0201304:	e2860613          	addi	a2,a2,-472 # ffffffffc0206128 <commands+0x818>
ffffffffc0201308:	0dc00593          	li	a1,220
ffffffffc020130c:	00005517          	auipc	a0,0x5
ffffffffc0201310:	e3450513          	addi	a0,a0,-460 # ffffffffc0206140 <commands+0x830>
ffffffffc0201314:	97aff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201318:	00005697          	auipc	a3,0x5
ffffffffc020131c:	f2868693          	addi	a3,a3,-216 # ffffffffc0206240 <commands+0x930>
ffffffffc0201320:	00005617          	auipc	a2,0x5
ffffffffc0201324:	e0860613          	addi	a2,a2,-504 # ffffffffc0206128 <commands+0x818>
ffffffffc0201328:	0de00593          	li	a1,222
ffffffffc020132c:	00005517          	auipc	a0,0x5
ffffffffc0201330:	e1450513          	addi	a0,a0,-492 # ffffffffc0206140 <commands+0x830>
ffffffffc0201334:	95aff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201338:	00005697          	auipc	a3,0x5
ffffffffc020133c:	f9068693          	addi	a3,a3,-112 # ffffffffc02062c8 <commands+0x9b8>
ffffffffc0201340:	00005617          	auipc	a2,0x5
ffffffffc0201344:	de860613          	addi	a2,a2,-536 # ffffffffc0206128 <commands+0x818>
ffffffffc0201348:	0f700593          	li	a1,247
ffffffffc020134c:	00005517          	auipc	a0,0x5
ffffffffc0201350:	df450513          	addi	a0,a0,-524 # ffffffffc0206140 <commands+0x830>
ffffffffc0201354:	93aff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201358:	00005697          	auipc	a3,0x5
ffffffffc020135c:	e2068693          	addi	a3,a3,-480 # ffffffffc0206178 <commands+0x868>
ffffffffc0201360:	00005617          	auipc	a2,0x5
ffffffffc0201364:	dc860613          	addi	a2,a2,-568 # ffffffffc0206128 <commands+0x818>
ffffffffc0201368:	0f000593          	li	a1,240
ffffffffc020136c:	00005517          	auipc	a0,0x5
ffffffffc0201370:	dd450513          	addi	a0,a0,-556 # ffffffffc0206140 <commands+0x830>
ffffffffc0201374:	91aff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 3);
ffffffffc0201378:	00005697          	auipc	a3,0x5
ffffffffc020137c:	f4068693          	addi	a3,a3,-192 # ffffffffc02062b8 <commands+0x9a8>
ffffffffc0201380:	00005617          	auipc	a2,0x5
ffffffffc0201384:	da860613          	addi	a2,a2,-600 # ffffffffc0206128 <commands+0x818>
ffffffffc0201388:	0ee00593          	li	a1,238
ffffffffc020138c:	00005517          	auipc	a0,0x5
ffffffffc0201390:	db450513          	addi	a0,a0,-588 # ffffffffc0206140 <commands+0x830>
ffffffffc0201394:	8faff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201398:	00005697          	auipc	a3,0x5
ffffffffc020139c:	f0868693          	addi	a3,a3,-248 # ffffffffc02062a0 <commands+0x990>
ffffffffc02013a0:	00005617          	auipc	a2,0x5
ffffffffc02013a4:	d8860613          	addi	a2,a2,-632 # ffffffffc0206128 <commands+0x818>
ffffffffc02013a8:	0e900593          	li	a1,233
ffffffffc02013ac:	00005517          	auipc	a0,0x5
ffffffffc02013b0:	d9450513          	addi	a0,a0,-620 # ffffffffc0206140 <commands+0x830>
ffffffffc02013b4:	8daff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02013b8:	00005697          	auipc	a3,0x5
ffffffffc02013bc:	ec868693          	addi	a3,a3,-312 # ffffffffc0206280 <commands+0x970>
ffffffffc02013c0:	00005617          	auipc	a2,0x5
ffffffffc02013c4:	d6860613          	addi	a2,a2,-664 # ffffffffc0206128 <commands+0x818>
ffffffffc02013c8:	0e000593          	li	a1,224
ffffffffc02013cc:	00005517          	auipc	a0,0x5
ffffffffc02013d0:	d7450513          	addi	a0,a0,-652 # ffffffffc0206140 <commands+0x830>
ffffffffc02013d4:	8baff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 != NULL);
ffffffffc02013d8:	00005697          	auipc	a3,0x5
ffffffffc02013dc:	f3868693          	addi	a3,a3,-200 # ffffffffc0206310 <commands+0xa00>
ffffffffc02013e0:	00005617          	auipc	a2,0x5
ffffffffc02013e4:	d4860613          	addi	a2,a2,-696 # ffffffffc0206128 <commands+0x818>
ffffffffc02013e8:	11800593          	li	a1,280
ffffffffc02013ec:	00005517          	auipc	a0,0x5
ffffffffc02013f0:	d5450513          	addi	a0,a0,-684 # ffffffffc0206140 <commands+0x830>
ffffffffc02013f4:	89aff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 0);
ffffffffc02013f8:	00005697          	auipc	a3,0x5
ffffffffc02013fc:	f0868693          	addi	a3,a3,-248 # ffffffffc0206300 <commands+0x9f0>
ffffffffc0201400:	00005617          	auipc	a2,0x5
ffffffffc0201404:	d2860613          	addi	a2,a2,-728 # ffffffffc0206128 <commands+0x818>
ffffffffc0201408:	0fd00593          	li	a1,253
ffffffffc020140c:	00005517          	auipc	a0,0x5
ffffffffc0201410:	d3450513          	addi	a0,a0,-716 # ffffffffc0206140 <commands+0x830>
ffffffffc0201414:	87aff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201418:	00005697          	auipc	a3,0x5
ffffffffc020141c:	e8868693          	addi	a3,a3,-376 # ffffffffc02062a0 <commands+0x990>
ffffffffc0201420:	00005617          	auipc	a2,0x5
ffffffffc0201424:	d0860613          	addi	a2,a2,-760 # ffffffffc0206128 <commands+0x818>
ffffffffc0201428:	0fb00593          	li	a1,251
ffffffffc020142c:	00005517          	auipc	a0,0x5
ffffffffc0201430:	d1450513          	addi	a0,a0,-748 # ffffffffc0206140 <commands+0x830>
ffffffffc0201434:	85aff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201438:	00005697          	auipc	a3,0x5
ffffffffc020143c:	ea868693          	addi	a3,a3,-344 # ffffffffc02062e0 <commands+0x9d0>
ffffffffc0201440:	00005617          	auipc	a2,0x5
ffffffffc0201444:	ce860613          	addi	a2,a2,-792 # ffffffffc0206128 <commands+0x818>
ffffffffc0201448:	0fa00593          	li	a1,250
ffffffffc020144c:	00005517          	auipc	a0,0x5
ffffffffc0201450:	cf450513          	addi	a0,a0,-780 # ffffffffc0206140 <commands+0x830>
ffffffffc0201454:	83aff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201458:	00005697          	auipc	a3,0x5
ffffffffc020145c:	d2068693          	addi	a3,a3,-736 # ffffffffc0206178 <commands+0x868>
ffffffffc0201460:	00005617          	auipc	a2,0x5
ffffffffc0201464:	cc860613          	addi	a2,a2,-824 # ffffffffc0206128 <commands+0x818>
ffffffffc0201468:	0d700593          	li	a1,215
ffffffffc020146c:	00005517          	auipc	a0,0x5
ffffffffc0201470:	cd450513          	addi	a0,a0,-812 # ffffffffc0206140 <commands+0x830>
ffffffffc0201474:	81aff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201478:	00005697          	auipc	a3,0x5
ffffffffc020147c:	e2868693          	addi	a3,a3,-472 # ffffffffc02062a0 <commands+0x990>
ffffffffc0201480:	00005617          	auipc	a2,0x5
ffffffffc0201484:	ca860613          	addi	a2,a2,-856 # ffffffffc0206128 <commands+0x818>
ffffffffc0201488:	0f400593          	li	a1,244
ffffffffc020148c:	00005517          	auipc	a0,0x5
ffffffffc0201490:	cb450513          	addi	a0,a0,-844 # ffffffffc0206140 <commands+0x830>
ffffffffc0201494:	ffbfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201498:	00005697          	auipc	a3,0x5
ffffffffc020149c:	d2068693          	addi	a3,a3,-736 # ffffffffc02061b8 <commands+0x8a8>
ffffffffc02014a0:	00005617          	auipc	a2,0x5
ffffffffc02014a4:	c8860613          	addi	a2,a2,-888 # ffffffffc0206128 <commands+0x818>
ffffffffc02014a8:	0f200593          	li	a1,242
ffffffffc02014ac:	00005517          	auipc	a0,0x5
ffffffffc02014b0:	c9450513          	addi	a0,a0,-876 # ffffffffc0206140 <commands+0x830>
ffffffffc02014b4:	fdbfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02014b8:	00005697          	auipc	a3,0x5
ffffffffc02014bc:	ce068693          	addi	a3,a3,-800 # ffffffffc0206198 <commands+0x888>
ffffffffc02014c0:	00005617          	auipc	a2,0x5
ffffffffc02014c4:	c6860613          	addi	a2,a2,-920 # ffffffffc0206128 <commands+0x818>
ffffffffc02014c8:	0f100593          	li	a1,241
ffffffffc02014cc:	00005517          	auipc	a0,0x5
ffffffffc02014d0:	c7450513          	addi	a0,a0,-908 # ffffffffc0206140 <commands+0x830>
ffffffffc02014d4:	fbbfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02014d8:	00005697          	auipc	a3,0x5
ffffffffc02014dc:	ce068693          	addi	a3,a3,-800 # ffffffffc02061b8 <commands+0x8a8>
ffffffffc02014e0:	00005617          	auipc	a2,0x5
ffffffffc02014e4:	c4860613          	addi	a2,a2,-952 # ffffffffc0206128 <commands+0x818>
ffffffffc02014e8:	0d900593          	li	a1,217
ffffffffc02014ec:	00005517          	auipc	a0,0x5
ffffffffc02014f0:	c5450513          	addi	a0,a0,-940 # ffffffffc0206140 <commands+0x830>
ffffffffc02014f4:	f9bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(count == 0);
ffffffffc02014f8:	00005697          	auipc	a3,0x5
ffffffffc02014fc:	f6868693          	addi	a3,a3,-152 # ffffffffc0206460 <commands+0xb50>
ffffffffc0201500:	00005617          	auipc	a2,0x5
ffffffffc0201504:	c2860613          	addi	a2,a2,-984 # ffffffffc0206128 <commands+0x818>
ffffffffc0201508:	14600593          	li	a1,326
ffffffffc020150c:	00005517          	auipc	a0,0x5
ffffffffc0201510:	c3450513          	addi	a0,a0,-972 # ffffffffc0206140 <commands+0x830>
ffffffffc0201514:	f7bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 0);
ffffffffc0201518:	00005697          	auipc	a3,0x5
ffffffffc020151c:	de868693          	addi	a3,a3,-536 # ffffffffc0206300 <commands+0x9f0>
ffffffffc0201520:	00005617          	auipc	a2,0x5
ffffffffc0201524:	c0860613          	addi	a2,a2,-1016 # ffffffffc0206128 <commands+0x818>
ffffffffc0201528:	13a00593          	li	a1,314
ffffffffc020152c:	00005517          	auipc	a0,0x5
ffffffffc0201530:	c1450513          	addi	a0,a0,-1004 # ffffffffc0206140 <commands+0x830>
ffffffffc0201534:	f5bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201538:	00005697          	auipc	a3,0x5
ffffffffc020153c:	d6868693          	addi	a3,a3,-664 # ffffffffc02062a0 <commands+0x990>
ffffffffc0201540:	00005617          	auipc	a2,0x5
ffffffffc0201544:	be860613          	addi	a2,a2,-1048 # ffffffffc0206128 <commands+0x818>
ffffffffc0201548:	13800593          	li	a1,312
ffffffffc020154c:	00005517          	auipc	a0,0x5
ffffffffc0201550:	bf450513          	addi	a0,a0,-1036 # ffffffffc0206140 <commands+0x830>
ffffffffc0201554:	f3bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201558:	00005697          	auipc	a3,0x5
ffffffffc020155c:	d0868693          	addi	a3,a3,-760 # ffffffffc0206260 <commands+0x950>
ffffffffc0201560:	00005617          	auipc	a2,0x5
ffffffffc0201564:	bc860613          	addi	a2,a2,-1080 # ffffffffc0206128 <commands+0x818>
ffffffffc0201568:	0df00593          	li	a1,223
ffffffffc020156c:	00005517          	auipc	a0,0x5
ffffffffc0201570:	bd450513          	addi	a0,a0,-1068 # ffffffffc0206140 <commands+0x830>
ffffffffc0201574:	f1bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0201578:	00005697          	auipc	a3,0x5
ffffffffc020157c:	ea868693          	addi	a3,a3,-344 # ffffffffc0206420 <commands+0xb10>
ffffffffc0201580:	00005617          	auipc	a2,0x5
ffffffffc0201584:	ba860613          	addi	a2,a2,-1112 # ffffffffc0206128 <commands+0x818>
ffffffffc0201588:	13200593          	li	a1,306
ffffffffc020158c:	00005517          	auipc	a0,0x5
ffffffffc0201590:	bb450513          	addi	a0,a0,-1100 # ffffffffc0206140 <commands+0x830>
ffffffffc0201594:	efbfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0201598:	00005697          	auipc	a3,0x5
ffffffffc020159c:	e6868693          	addi	a3,a3,-408 # ffffffffc0206400 <commands+0xaf0>
ffffffffc02015a0:	00005617          	auipc	a2,0x5
ffffffffc02015a4:	b8860613          	addi	a2,a2,-1144 # ffffffffc0206128 <commands+0x818>
ffffffffc02015a8:	13000593          	li	a1,304
ffffffffc02015ac:	00005517          	auipc	a0,0x5
ffffffffc02015b0:	b9450513          	addi	a0,a0,-1132 # ffffffffc0206140 <commands+0x830>
ffffffffc02015b4:	edbfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc02015b8:	00005697          	auipc	a3,0x5
ffffffffc02015bc:	e2068693          	addi	a3,a3,-480 # ffffffffc02063d8 <commands+0xac8>
ffffffffc02015c0:	00005617          	auipc	a2,0x5
ffffffffc02015c4:	b6860613          	addi	a2,a2,-1176 # ffffffffc0206128 <commands+0x818>
ffffffffc02015c8:	12e00593          	li	a1,302
ffffffffc02015cc:	00005517          	auipc	a0,0x5
ffffffffc02015d0:	b7450513          	addi	a0,a0,-1164 # ffffffffc0206140 <commands+0x830>
ffffffffc02015d4:	ebbfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc02015d8:	00005697          	auipc	a3,0x5
ffffffffc02015dc:	dd868693          	addi	a3,a3,-552 # ffffffffc02063b0 <commands+0xaa0>
ffffffffc02015e0:	00005617          	auipc	a2,0x5
ffffffffc02015e4:	b4860613          	addi	a2,a2,-1208 # ffffffffc0206128 <commands+0x818>
ffffffffc02015e8:	12d00593          	li	a1,301
ffffffffc02015ec:	00005517          	auipc	a0,0x5
ffffffffc02015f0:	b5450513          	addi	a0,a0,-1196 # ffffffffc0206140 <commands+0x830>
ffffffffc02015f4:	e9bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 + 2 == p1);
ffffffffc02015f8:	00005697          	auipc	a3,0x5
ffffffffc02015fc:	da868693          	addi	a3,a3,-600 # ffffffffc02063a0 <commands+0xa90>
ffffffffc0201600:	00005617          	auipc	a2,0x5
ffffffffc0201604:	b2860613          	addi	a2,a2,-1240 # ffffffffc0206128 <commands+0x818>
ffffffffc0201608:	12800593          	li	a1,296
ffffffffc020160c:	00005517          	auipc	a0,0x5
ffffffffc0201610:	b3450513          	addi	a0,a0,-1228 # ffffffffc0206140 <commands+0x830>
ffffffffc0201614:	e7bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201618:	00005697          	auipc	a3,0x5
ffffffffc020161c:	c8868693          	addi	a3,a3,-888 # ffffffffc02062a0 <commands+0x990>
ffffffffc0201620:	00005617          	auipc	a2,0x5
ffffffffc0201624:	b0860613          	addi	a2,a2,-1272 # ffffffffc0206128 <commands+0x818>
ffffffffc0201628:	12700593          	li	a1,295
ffffffffc020162c:	00005517          	auipc	a0,0x5
ffffffffc0201630:	b1450513          	addi	a0,a0,-1260 # ffffffffc0206140 <commands+0x830>
ffffffffc0201634:	e5bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201638:	00005697          	auipc	a3,0x5
ffffffffc020163c:	d4868693          	addi	a3,a3,-696 # ffffffffc0206380 <commands+0xa70>
ffffffffc0201640:	00005617          	auipc	a2,0x5
ffffffffc0201644:	ae860613          	addi	a2,a2,-1304 # ffffffffc0206128 <commands+0x818>
ffffffffc0201648:	12600593          	li	a1,294
ffffffffc020164c:	00005517          	auipc	a0,0x5
ffffffffc0201650:	af450513          	addi	a0,a0,-1292 # ffffffffc0206140 <commands+0x830>
ffffffffc0201654:	e3bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201658:	00005697          	auipc	a3,0x5
ffffffffc020165c:	cf868693          	addi	a3,a3,-776 # ffffffffc0206350 <commands+0xa40>
ffffffffc0201660:	00005617          	auipc	a2,0x5
ffffffffc0201664:	ac860613          	addi	a2,a2,-1336 # ffffffffc0206128 <commands+0x818>
ffffffffc0201668:	12500593          	li	a1,293
ffffffffc020166c:	00005517          	auipc	a0,0x5
ffffffffc0201670:	ad450513          	addi	a0,a0,-1324 # ffffffffc0206140 <commands+0x830>
ffffffffc0201674:	e1bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc0201678:	00005697          	auipc	a3,0x5
ffffffffc020167c:	cc068693          	addi	a3,a3,-832 # ffffffffc0206338 <commands+0xa28>
ffffffffc0201680:	00005617          	auipc	a2,0x5
ffffffffc0201684:	aa860613          	addi	a2,a2,-1368 # ffffffffc0206128 <commands+0x818>
ffffffffc0201688:	12400593          	li	a1,292
ffffffffc020168c:	00005517          	auipc	a0,0x5
ffffffffc0201690:	ab450513          	addi	a0,a0,-1356 # ffffffffc0206140 <commands+0x830>
ffffffffc0201694:	dfbfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201698:	00005697          	auipc	a3,0x5
ffffffffc020169c:	c0868693          	addi	a3,a3,-1016 # ffffffffc02062a0 <commands+0x990>
ffffffffc02016a0:	00005617          	auipc	a2,0x5
ffffffffc02016a4:	a8860613          	addi	a2,a2,-1400 # ffffffffc0206128 <commands+0x818>
ffffffffc02016a8:	11e00593          	li	a1,286
ffffffffc02016ac:	00005517          	auipc	a0,0x5
ffffffffc02016b0:	a9450513          	addi	a0,a0,-1388 # ffffffffc0206140 <commands+0x830>
ffffffffc02016b4:	ddbfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(!PageProperty(p0));
ffffffffc02016b8:	00005697          	auipc	a3,0x5
ffffffffc02016bc:	c6868693          	addi	a3,a3,-920 # ffffffffc0206320 <commands+0xa10>
ffffffffc02016c0:	00005617          	auipc	a2,0x5
ffffffffc02016c4:	a6860613          	addi	a2,a2,-1432 # ffffffffc0206128 <commands+0x818>
ffffffffc02016c8:	11900593          	li	a1,281
ffffffffc02016cc:	00005517          	auipc	a0,0x5
ffffffffc02016d0:	a7450513          	addi	a0,a0,-1420 # ffffffffc0206140 <commands+0x830>
ffffffffc02016d4:	dbbfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc02016d8:	00005697          	auipc	a3,0x5
ffffffffc02016dc:	d6868693          	addi	a3,a3,-664 # ffffffffc0206440 <commands+0xb30>
ffffffffc02016e0:	00005617          	auipc	a2,0x5
ffffffffc02016e4:	a4860613          	addi	a2,a2,-1464 # ffffffffc0206128 <commands+0x818>
ffffffffc02016e8:	13700593          	li	a1,311
ffffffffc02016ec:	00005517          	auipc	a0,0x5
ffffffffc02016f0:	a5450513          	addi	a0,a0,-1452 # ffffffffc0206140 <commands+0x830>
ffffffffc02016f4:	d9bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(total == 0);
ffffffffc02016f8:	00005697          	auipc	a3,0x5
ffffffffc02016fc:	d7868693          	addi	a3,a3,-648 # ffffffffc0206470 <commands+0xb60>
ffffffffc0201700:	00005617          	auipc	a2,0x5
ffffffffc0201704:	a2860613          	addi	a2,a2,-1496 # ffffffffc0206128 <commands+0x818>
ffffffffc0201708:	14700593          	li	a1,327
ffffffffc020170c:	00005517          	auipc	a0,0x5
ffffffffc0201710:	a3450513          	addi	a0,a0,-1484 # ffffffffc0206140 <commands+0x830>
ffffffffc0201714:	d7bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(total == nr_free_pages());
ffffffffc0201718:	00005697          	auipc	a3,0x5
ffffffffc020171c:	a4068693          	addi	a3,a3,-1472 # ffffffffc0206158 <commands+0x848>
ffffffffc0201720:	00005617          	auipc	a2,0x5
ffffffffc0201724:	a0860613          	addi	a2,a2,-1528 # ffffffffc0206128 <commands+0x818>
ffffffffc0201728:	11300593          	li	a1,275
ffffffffc020172c:	00005517          	auipc	a0,0x5
ffffffffc0201730:	a1450513          	addi	a0,a0,-1516 # ffffffffc0206140 <commands+0x830>
ffffffffc0201734:	d5bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201738:	00005697          	auipc	a3,0x5
ffffffffc020173c:	a6068693          	addi	a3,a3,-1440 # ffffffffc0206198 <commands+0x888>
ffffffffc0201740:	00005617          	auipc	a2,0x5
ffffffffc0201744:	9e860613          	addi	a2,a2,-1560 # ffffffffc0206128 <commands+0x818>
ffffffffc0201748:	0d800593          	li	a1,216
ffffffffc020174c:	00005517          	auipc	a0,0x5
ffffffffc0201750:	9f450513          	addi	a0,a0,-1548 # ffffffffc0206140 <commands+0x830>
ffffffffc0201754:	d3bfe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201758 <default_free_pages>:
{
ffffffffc0201758:	1141                	addi	sp,sp,-16
ffffffffc020175a:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc020175c:	14058463          	beqz	a1,ffffffffc02018a4 <default_free_pages+0x14c>
    for (; p != base + n; p++)
ffffffffc0201760:	00659693          	slli	a3,a1,0x6
ffffffffc0201764:	96aa                	add	a3,a3,a0
ffffffffc0201766:	87aa                	mv	a5,a0
ffffffffc0201768:	02d50263          	beq	a0,a3,ffffffffc020178c <default_free_pages+0x34>
ffffffffc020176c:	6798                	ld	a4,8(a5)
ffffffffc020176e:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0201770:	10071a63          	bnez	a4,ffffffffc0201884 <default_free_pages+0x12c>
ffffffffc0201774:	6798                	ld	a4,8(a5)
ffffffffc0201776:	8b09                	andi	a4,a4,2
ffffffffc0201778:	10071663          	bnez	a4,ffffffffc0201884 <default_free_pages+0x12c>
        p->flags = 0;
ffffffffc020177c:	0007b423          	sd	zero,8(a5)
}

static inline void
set_page_ref(struct Page *page, int val)
{
    page->ref = val;
ffffffffc0201780:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc0201784:	04078793          	addi	a5,a5,64
ffffffffc0201788:	fed792e3          	bne	a5,a3,ffffffffc020176c <default_free_pages+0x14>
    base->property = n;
ffffffffc020178c:	2581                	sext.w	a1,a1
ffffffffc020178e:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc0201790:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201794:	4789                	li	a5,2
ffffffffc0201796:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc020179a:	000a5697          	auipc	a3,0xa5
ffffffffc020179e:	f2e68693          	addi	a3,a3,-210 # ffffffffc02a66c8 <free_area>
ffffffffc02017a2:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02017a4:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02017a6:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02017aa:	9db9                	addw	a1,a1,a4
ffffffffc02017ac:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02017ae:	0ad78463          	beq	a5,a3,ffffffffc0201856 <default_free_pages+0xfe>
            struct Page *page = le2page(le, page_link);
ffffffffc02017b2:	fe878713          	addi	a4,a5,-24
ffffffffc02017b6:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc02017ba:	4581                	li	a1,0
            if (base < page)
ffffffffc02017bc:	00e56a63          	bltu	a0,a4,ffffffffc02017d0 <default_free_pages+0x78>
    return listelm->next;
ffffffffc02017c0:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc02017c2:	04d70c63          	beq	a4,a3,ffffffffc020181a <default_free_pages+0xc2>
    for (; p != base + n; p++)
ffffffffc02017c6:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc02017c8:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc02017cc:	fee57ae3          	bgeu	a0,a4,ffffffffc02017c0 <default_free_pages+0x68>
ffffffffc02017d0:	c199                	beqz	a1,ffffffffc02017d6 <default_free_pages+0x7e>
ffffffffc02017d2:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02017d6:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc02017d8:	e390                	sd	a2,0(a5)
ffffffffc02017da:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc02017dc:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02017de:	ed18                	sd	a4,24(a0)
    if (le != &free_list)
ffffffffc02017e0:	00d70d63          	beq	a4,a3,ffffffffc02017fa <default_free_pages+0xa2>
        if (p + p->property == base)
ffffffffc02017e4:	ff872583          	lw	a1,-8(a4)
        p = le2page(le, page_link);
ffffffffc02017e8:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base)
ffffffffc02017ec:	02059813          	slli	a6,a1,0x20
ffffffffc02017f0:	01a85793          	srli	a5,a6,0x1a
ffffffffc02017f4:	97b2                	add	a5,a5,a2
ffffffffc02017f6:	02f50c63          	beq	a0,a5,ffffffffc020182e <default_free_pages+0xd6>
    return listelm->next;
ffffffffc02017fa:	711c                	ld	a5,32(a0)
    if (le != &free_list)
ffffffffc02017fc:	00d78c63          	beq	a5,a3,ffffffffc0201814 <default_free_pages+0xbc>
        if (base + base->property == p)
ffffffffc0201800:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc0201802:	fe878693          	addi	a3,a5,-24
        if (base + base->property == p)
ffffffffc0201806:	02061593          	slli	a1,a2,0x20
ffffffffc020180a:	01a5d713          	srli	a4,a1,0x1a
ffffffffc020180e:	972a                	add	a4,a4,a0
ffffffffc0201810:	04e68a63          	beq	a3,a4,ffffffffc0201864 <default_free_pages+0x10c>
}
ffffffffc0201814:	60a2                	ld	ra,8(sp)
ffffffffc0201816:	0141                	addi	sp,sp,16
ffffffffc0201818:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc020181a:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020181c:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc020181e:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201820:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc0201822:	02d70763          	beq	a4,a3,ffffffffc0201850 <default_free_pages+0xf8>
    prev->next = next->prev = elm;
ffffffffc0201826:	8832                	mv	a6,a2
ffffffffc0201828:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc020182a:	87ba                	mv	a5,a4
ffffffffc020182c:	bf71                	j	ffffffffc02017c8 <default_free_pages+0x70>
            p->property += base->property;
ffffffffc020182e:	491c                	lw	a5,16(a0)
ffffffffc0201830:	9dbd                	addw	a1,a1,a5
ffffffffc0201832:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201836:	57f5                	li	a5,-3
ffffffffc0201838:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc020183c:	01853803          	ld	a6,24(a0)
ffffffffc0201840:	710c                	ld	a1,32(a0)
            base = p;
ffffffffc0201842:	8532                	mv	a0,a2
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0201844:	00b83423          	sd	a1,8(a6)
    return listelm->next;
ffffffffc0201848:	671c                	ld	a5,8(a4)
    next->prev = prev;
ffffffffc020184a:	0105b023          	sd	a6,0(a1)
ffffffffc020184e:	b77d                	j	ffffffffc02017fc <default_free_pages+0xa4>
ffffffffc0201850:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list)
ffffffffc0201852:	873e                	mv	a4,a5
ffffffffc0201854:	bf41                	j	ffffffffc02017e4 <default_free_pages+0x8c>
}
ffffffffc0201856:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201858:	e390                	sd	a2,0(a5)
ffffffffc020185a:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020185c:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020185e:	ed1c                	sd	a5,24(a0)
ffffffffc0201860:	0141                	addi	sp,sp,16
ffffffffc0201862:	8082                	ret
            base->property += p->property;
ffffffffc0201864:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201868:	ff078693          	addi	a3,a5,-16
ffffffffc020186c:	9e39                	addw	a2,a2,a4
ffffffffc020186e:	c910                	sw	a2,16(a0)
ffffffffc0201870:	5775                	li	a4,-3
ffffffffc0201872:	60e6b02f          	amoand.d	zero,a4,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201876:	6398                	ld	a4,0(a5)
ffffffffc0201878:	679c                	ld	a5,8(a5)
}
ffffffffc020187a:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc020187c:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc020187e:	e398                	sd	a4,0(a5)
ffffffffc0201880:	0141                	addi	sp,sp,16
ffffffffc0201882:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0201884:	00005697          	auipc	a3,0x5
ffffffffc0201888:	c0468693          	addi	a3,a3,-1020 # ffffffffc0206488 <commands+0xb78>
ffffffffc020188c:	00005617          	auipc	a2,0x5
ffffffffc0201890:	89c60613          	addi	a2,a2,-1892 # ffffffffc0206128 <commands+0x818>
ffffffffc0201894:	09400593          	li	a1,148
ffffffffc0201898:	00005517          	auipc	a0,0x5
ffffffffc020189c:	8a850513          	addi	a0,a0,-1880 # ffffffffc0206140 <commands+0x830>
ffffffffc02018a0:	beffe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(n > 0);
ffffffffc02018a4:	00005697          	auipc	a3,0x5
ffffffffc02018a8:	bdc68693          	addi	a3,a3,-1060 # ffffffffc0206480 <commands+0xb70>
ffffffffc02018ac:	00005617          	auipc	a2,0x5
ffffffffc02018b0:	87c60613          	addi	a2,a2,-1924 # ffffffffc0206128 <commands+0x818>
ffffffffc02018b4:	09000593          	li	a1,144
ffffffffc02018b8:	00005517          	auipc	a0,0x5
ffffffffc02018bc:	88850513          	addi	a0,a0,-1912 # ffffffffc0206140 <commands+0x830>
ffffffffc02018c0:	bcffe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02018c4 <default_alloc_pages>:
    assert(n > 0);
ffffffffc02018c4:	c941                	beqz	a0,ffffffffc0201954 <default_alloc_pages+0x90>
    if (n > nr_free)
ffffffffc02018c6:	000a5597          	auipc	a1,0xa5
ffffffffc02018ca:	e0258593          	addi	a1,a1,-510 # ffffffffc02a66c8 <free_area>
ffffffffc02018ce:	0105a803          	lw	a6,16(a1)
ffffffffc02018d2:	872a                	mv	a4,a0
ffffffffc02018d4:	02081793          	slli	a5,a6,0x20
ffffffffc02018d8:	9381                	srli	a5,a5,0x20
ffffffffc02018da:	00a7ee63          	bltu	a5,a0,ffffffffc02018f6 <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc02018de:	87ae                	mv	a5,a1
ffffffffc02018e0:	a801                	j	ffffffffc02018f0 <default_alloc_pages+0x2c>
        if (p->property >= n)
ffffffffc02018e2:	ff87a683          	lw	a3,-8(a5)
ffffffffc02018e6:	02069613          	slli	a2,a3,0x20
ffffffffc02018ea:	9201                	srli	a2,a2,0x20
ffffffffc02018ec:	00e67763          	bgeu	a2,a4,ffffffffc02018fa <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc02018f0:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list)
ffffffffc02018f2:	feb798e3          	bne	a5,a1,ffffffffc02018e2 <default_alloc_pages+0x1e>
        return NULL;
ffffffffc02018f6:	4501                	li	a0,0
}
ffffffffc02018f8:	8082                	ret
    return listelm->prev;
ffffffffc02018fa:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc02018fe:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc0201902:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc0201906:	00070e1b          	sext.w	t3,a4
    prev->next = next;
ffffffffc020190a:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc020190e:	01133023          	sd	a7,0(t1)
        if (page->property > n)
ffffffffc0201912:	02c77863          	bgeu	a4,a2,ffffffffc0201942 <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc0201916:	071a                	slli	a4,a4,0x6
ffffffffc0201918:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc020191a:	41c686bb          	subw	a3,a3,t3
ffffffffc020191e:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201920:	00870613          	addi	a2,a4,8
ffffffffc0201924:	4689                	li	a3,2
ffffffffc0201926:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc020192a:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc020192e:	01870613          	addi	a2,a4,24
        nr_free -= n;
ffffffffc0201932:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc0201936:	e290                	sd	a2,0(a3)
ffffffffc0201938:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc020193c:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc020193e:	01173c23          	sd	a7,24(a4)
ffffffffc0201942:	41c8083b          	subw	a6,a6,t3
ffffffffc0201946:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020194a:	5775                	li	a4,-3
ffffffffc020194c:	17c1                	addi	a5,a5,-16
ffffffffc020194e:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc0201952:	8082                	ret
{
ffffffffc0201954:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0201956:	00005697          	auipc	a3,0x5
ffffffffc020195a:	b2a68693          	addi	a3,a3,-1238 # ffffffffc0206480 <commands+0xb70>
ffffffffc020195e:	00004617          	auipc	a2,0x4
ffffffffc0201962:	7ca60613          	addi	a2,a2,1994 # ffffffffc0206128 <commands+0x818>
ffffffffc0201966:	06c00593          	li	a1,108
ffffffffc020196a:	00004517          	auipc	a0,0x4
ffffffffc020196e:	7d650513          	addi	a0,a0,2006 # ffffffffc0206140 <commands+0x830>
{
ffffffffc0201972:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201974:	b1bfe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201978 <default_init_memmap>:
{
ffffffffc0201978:	1141                	addi	sp,sp,-16
ffffffffc020197a:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc020197c:	c5f1                	beqz	a1,ffffffffc0201a48 <default_init_memmap+0xd0>
    for (; p != base + n; p++)
ffffffffc020197e:	00659693          	slli	a3,a1,0x6
ffffffffc0201982:	96aa                	add	a3,a3,a0
ffffffffc0201984:	87aa                	mv	a5,a0
ffffffffc0201986:	00d50f63          	beq	a0,a3,ffffffffc02019a4 <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc020198a:	6798                	ld	a4,8(a5)
ffffffffc020198c:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc020198e:	cf49                	beqz	a4,ffffffffc0201a28 <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc0201990:	0007a823          	sw	zero,16(a5)
ffffffffc0201994:	0007b423          	sd	zero,8(a5)
ffffffffc0201998:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc020199c:	04078793          	addi	a5,a5,64
ffffffffc02019a0:	fed795e3          	bne	a5,a3,ffffffffc020198a <default_init_memmap+0x12>
    base->property = n;
ffffffffc02019a4:	2581                	sext.w	a1,a1
ffffffffc02019a6:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02019a8:	4789                	li	a5,2
ffffffffc02019aa:	00850713          	addi	a4,a0,8
ffffffffc02019ae:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc02019b2:	000a5697          	auipc	a3,0xa5
ffffffffc02019b6:	d1668693          	addi	a3,a3,-746 # ffffffffc02a66c8 <free_area>
ffffffffc02019ba:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02019bc:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02019be:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02019c2:	9db9                	addw	a1,a1,a4
ffffffffc02019c4:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02019c6:	04d78a63          	beq	a5,a3,ffffffffc0201a1a <default_init_memmap+0xa2>
            struct Page *page = le2page(le, page_link);
ffffffffc02019ca:	fe878713          	addi	a4,a5,-24
ffffffffc02019ce:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc02019d2:	4581                	li	a1,0
            if (base < page)
ffffffffc02019d4:	00e56a63          	bltu	a0,a4,ffffffffc02019e8 <default_init_memmap+0x70>
    return listelm->next;
ffffffffc02019d8:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc02019da:	02d70263          	beq	a4,a3,ffffffffc02019fe <default_init_memmap+0x86>
    for (; p != base + n; p++)
ffffffffc02019de:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc02019e0:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc02019e4:	fee57ae3          	bgeu	a0,a4,ffffffffc02019d8 <default_init_memmap+0x60>
ffffffffc02019e8:	c199                	beqz	a1,ffffffffc02019ee <default_init_memmap+0x76>
ffffffffc02019ea:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02019ee:	6398                	ld	a4,0(a5)
}
ffffffffc02019f0:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc02019f2:	e390                	sd	a2,0(a5)
ffffffffc02019f4:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc02019f6:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc02019f8:	ed18                	sd	a4,24(a0)
ffffffffc02019fa:	0141                	addi	sp,sp,16
ffffffffc02019fc:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc02019fe:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201a00:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201a02:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201a04:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc0201a06:	00d70663          	beq	a4,a3,ffffffffc0201a12 <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc0201a0a:	8832                	mv	a6,a2
ffffffffc0201a0c:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0201a0e:	87ba                	mv	a5,a4
ffffffffc0201a10:	bfc1                	j	ffffffffc02019e0 <default_init_memmap+0x68>
}
ffffffffc0201a12:	60a2                	ld	ra,8(sp)
ffffffffc0201a14:	e290                	sd	a2,0(a3)
ffffffffc0201a16:	0141                	addi	sp,sp,16
ffffffffc0201a18:	8082                	ret
ffffffffc0201a1a:	60a2                	ld	ra,8(sp)
ffffffffc0201a1c:	e390                	sd	a2,0(a5)
ffffffffc0201a1e:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201a20:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201a22:	ed1c                	sd	a5,24(a0)
ffffffffc0201a24:	0141                	addi	sp,sp,16
ffffffffc0201a26:	8082                	ret
        assert(PageReserved(p));
ffffffffc0201a28:	00005697          	auipc	a3,0x5
ffffffffc0201a2c:	a8868693          	addi	a3,a3,-1400 # ffffffffc02064b0 <commands+0xba0>
ffffffffc0201a30:	00004617          	auipc	a2,0x4
ffffffffc0201a34:	6f860613          	addi	a2,a2,1784 # ffffffffc0206128 <commands+0x818>
ffffffffc0201a38:	04b00593          	li	a1,75
ffffffffc0201a3c:	00004517          	auipc	a0,0x4
ffffffffc0201a40:	70450513          	addi	a0,a0,1796 # ffffffffc0206140 <commands+0x830>
ffffffffc0201a44:	a4bfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(n > 0);
ffffffffc0201a48:	00005697          	auipc	a3,0x5
ffffffffc0201a4c:	a3868693          	addi	a3,a3,-1480 # ffffffffc0206480 <commands+0xb70>
ffffffffc0201a50:	00004617          	auipc	a2,0x4
ffffffffc0201a54:	6d860613          	addi	a2,a2,1752 # ffffffffc0206128 <commands+0x818>
ffffffffc0201a58:	04700593          	li	a1,71
ffffffffc0201a5c:	00004517          	auipc	a0,0x4
ffffffffc0201a60:	6e450513          	addi	a0,a0,1764 # ffffffffc0206140 <commands+0x830>
ffffffffc0201a64:	a2bfe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201a68 <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc0201a68:	c94d                	beqz	a0,ffffffffc0201b1a <slob_free+0xb2>
{
ffffffffc0201a6a:	1141                	addi	sp,sp,-16
ffffffffc0201a6c:	e022                	sd	s0,0(sp)
ffffffffc0201a6e:	e406                	sd	ra,8(sp)
ffffffffc0201a70:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc0201a72:	e9c1                	bnez	a1,ffffffffc0201b02 <slob_free+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201a74:	100027f3          	csrr	a5,sstatus
ffffffffc0201a78:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201a7a:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201a7c:	ebd9                	bnez	a5,ffffffffc0201b12 <slob_free+0xaa>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201a7e:	000a5617          	auipc	a2,0xa5
ffffffffc0201a82:	83a60613          	addi	a2,a2,-1990 # ffffffffc02a62b8 <slobfree>
ffffffffc0201a86:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201a88:	873e                	mv	a4,a5
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201a8a:	679c                	ld	a5,8(a5)
ffffffffc0201a8c:	02877a63          	bgeu	a4,s0,ffffffffc0201ac0 <slob_free+0x58>
ffffffffc0201a90:	00f46463          	bltu	s0,a5,ffffffffc0201a98 <slob_free+0x30>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201a94:	fef76ae3          	bltu	a4,a5,ffffffffc0201a88 <slob_free+0x20>
			break;

	if (b + b->units == cur->next)
ffffffffc0201a98:	400c                	lw	a1,0(s0)
ffffffffc0201a9a:	00459693          	slli	a3,a1,0x4
ffffffffc0201a9e:	96a2                	add	a3,a3,s0
ffffffffc0201aa0:	02d78a63          	beq	a5,a3,ffffffffc0201ad4 <slob_free+0x6c>
		b->next = cur->next->next;
	}
	else
		b->next = cur->next;

	if (cur + cur->units == b)
ffffffffc0201aa4:	4314                	lw	a3,0(a4)
		b->next = cur->next;
ffffffffc0201aa6:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc0201aa8:	00469793          	slli	a5,a3,0x4
ffffffffc0201aac:	97ba                	add	a5,a5,a4
ffffffffc0201aae:	02f40e63          	beq	s0,a5,ffffffffc0201aea <slob_free+0x82>
	{
		cur->units += b->units;
		cur->next = b->next;
	}
	else
		cur->next = b;
ffffffffc0201ab2:	e700                	sd	s0,8(a4)

	slobfree = cur;
ffffffffc0201ab4:	e218                	sd	a4,0(a2)
    if (flag)
ffffffffc0201ab6:	e129                	bnez	a0,ffffffffc0201af8 <slob_free+0x90>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc0201ab8:	60a2                	ld	ra,8(sp)
ffffffffc0201aba:	6402                	ld	s0,0(sp)
ffffffffc0201abc:	0141                	addi	sp,sp,16
ffffffffc0201abe:	8082                	ret
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201ac0:	fcf764e3          	bltu	a4,a5,ffffffffc0201a88 <slob_free+0x20>
ffffffffc0201ac4:	fcf472e3          	bgeu	s0,a5,ffffffffc0201a88 <slob_free+0x20>
	if (b + b->units == cur->next)
ffffffffc0201ac8:	400c                	lw	a1,0(s0)
ffffffffc0201aca:	00459693          	slli	a3,a1,0x4
ffffffffc0201ace:	96a2                	add	a3,a3,s0
ffffffffc0201ad0:	fcd79ae3          	bne	a5,a3,ffffffffc0201aa4 <slob_free+0x3c>
		b->units += cur->next->units;
ffffffffc0201ad4:	4394                	lw	a3,0(a5)
		b->next = cur->next->next;
ffffffffc0201ad6:	679c                	ld	a5,8(a5)
		b->units += cur->next->units;
ffffffffc0201ad8:	9db5                	addw	a1,a1,a3
ffffffffc0201ada:	c00c                	sw	a1,0(s0)
	if (cur + cur->units == b)
ffffffffc0201adc:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc0201ade:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc0201ae0:	00469793          	slli	a5,a3,0x4
ffffffffc0201ae4:	97ba                	add	a5,a5,a4
ffffffffc0201ae6:	fcf416e3          	bne	s0,a5,ffffffffc0201ab2 <slob_free+0x4a>
		cur->units += b->units;
ffffffffc0201aea:	401c                	lw	a5,0(s0)
		cur->next = b->next;
ffffffffc0201aec:	640c                	ld	a1,8(s0)
	slobfree = cur;
ffffffffc0201aee:	e218                	sd	a4,0(a2)
		cur->units += b->units;
ffffffffc0201af0:	9ebd                	addw	a3,a3,a5
ffffffffc0201af2:	c314                	sw	a3,0(a4)
		cur->next = b->next;
ffffffffc0201af4:	e70c                	sd	a1,8(a4)
ffffffffc0201af6:	d169                	beqz	a0,ffffffffc0201ab8 <slob_free+0x50>
}
ffffffffc0201af8:	6402                	ld	s0,0(sp)
ffffffffc0201afa:	60a2                	ld	ra,8(sp)
ffffffffc0201afc:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc0201afe:	eb1fe06f          	j	ffffffffc02009ae <intr_enable>
		b->units = SLOB_UNITS(size);
ffffffffc0201b02:	25bd                	addiw	a1,a1,15
ffffffffc0201b04:	8191                	srli	a1,a1,0x4
ffffffffc0201b06:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201b08:	100027f3          	csrr	a5,sstatus
ffffffffc0201b0c:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201b0e:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201b10:	d7bd                	beqz	a5,ffffffffc0201a7e <slob_free+0x16>
        intr_disable();
ffffffffc0201b12:	ea3fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0201b16:	4505                	li	a0,1
ffffffffc0201b18:	b79d                	j	ffffffffc0201a7e <slob_free+0x16>
ffffffffc0201b1a:	8082                	ret

ffffffffc0201b1c <__slob_get_free_pages.constprop.0>:
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b1c:	4785                	li	a5,1
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201b1e:	1141                	addi	sp,sp,-16
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b20:	00a7953b          	sllw	a0,a5,a0
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201b24:	e406                	sd	ra,8(sp)
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b26:	352000ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
	if (!page)
ffffffffc0201b2a:	c91d                	beqz	a0,ffffffffc0201b60 <__slob_get_free_pages.constprop.0+0x44>
    return page - pages + nbase;
ffffffffc0201b2c:	000a9697          	auipc	a3,0xa9
ffffffffc0201b30:	c0c6b683          	ld	a3,-1012(a3) # ffffffffc02aa738 <pages>
ffffffffc0201b34:	8d15                	sub	a0,a0,a3
ffffffffc0201b36:	8519                	srai	a0,a0,0x6
ffffffffc0201b38:	00006697          	auipc	a3,0x6
ffffffffc0201b3c:	ca06b683          	ld	a3,-864(a3) # ffffffffc02077d8 <nbase>
ffffffffc0201b40:	9536                	add	a0,a0,a3
    return KADDR(page2pa(page));
ffffffffc0201b42:	00c51793          	slli	a5,a0,0xc
ffffffffc0201b46:	83b1                	srli	a5,a5,0xc
ffffffffc0201b48:	000a9717          	auipc	a4,0xa9
ffffffffc0201b4c:	be873703          	ld	a4,-1048(a4) # ffffffffc02aa730 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0201b50:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc0201b52:	00e7fa63          	bgeu	a5,a4,ffffffffc0201b66 <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201b56:	000a9697          	auipc	a3,0xa9
ffffffffc0201b5a:	bf26b683          	ld	a3,-1038(a3) # ffffffffc02aa748 <va_pa_offset>
ffffffffc0201b5e:	9536                	add	a0,a0,a3
}
ffffffffc0201b60:	60a2                	ld	ra,8(sp)
ffffffffc0201b62:	0141                	addi	sp,sp,16
ffffffffc0201b64:	8082                	ret
ffffffffc0201b66:	86aa                	mv	a3,a0
ffffffffc0201b68:	00005617          	auipc	a2,0x5
ffffffffc0201b6c:	9a860613          	addi	a2,a2,-1624 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc0201b70:	07100593          	li	a1,113
ffffffffc0201b74:	00005517          	auipc	a0,0x5
ffffffffc0201b78:	9c450513          	addi	a0,a0,-1596 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0201b7c:	913fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201b80 <slob_alloc.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0201b80:	1101                	addi	sp,sp,-32
ffffffffc0201b82:	ec06                	sd	ra,24(sp)
ffffffffc0201b84:	e822                	sd	s0,16(sp)
ffffffffc0201b86:	e426                	sd	s1,8(sp)
ffffffffc0201b88:	e04a                	sd	s2,0(sp)
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201b8a:	01050713          	addi	a4,a0,16
ffffffffc0201b8e:	6785                	lui	a5,0x1
ffffffffc0201b90:	0cf77363          	bgeu	a4,a5,ffffffffc0201c56 <slob_alloc.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0201b94:	00f50493          	addi	s1,a0,15
ffffffffc0201b98:	8091                	srli	s1,s1,0x4
ffffffffc0201b9a:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201b9c:	10002673          	csrr	a2,sstatus
ffffffffc0201ba0:	8a09                	andi	a2,a2,2
ffffffffc0201ba2:	e25d                	bnez	a2,ffffffffc0201c48 <slob_alloc.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0201ba4:	000a4917          	auipc	s2,0xa4
ffffffffc0201ba8:	71490913          	addi	s2,s2,1812 # ffffffffc02a62b8 <slobfree>
ffffffffc0201bac:	00093683          	ld	a3,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201bb0:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta)
ffffffffc0201bb2:	4398                	lw	a4,0(a5)
ffffffffc0201bb4:	08975e63          	bge	a4,s1,ffffffffc0201c50 <slob_alloc.constprop.0+0xd0>
		if (cur == slobfree)
ffffffffc0201bb8:	00f68b63          	beq	a3,a5,ffffffffc0201bce <slob_alloc.constprop.0+0x4e>
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201bbc:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201bbe:	4018                	lw	a4,0(s0)
ffffffffc0201bc0:	02975a63          	bge	a4,s1,ffffffffc0201bf4 <slob_alloc.constprop.0+0x74>
		if (cur == slobfree)
ffffffffc0201bc4:	00093683          	ld	a3,0(s2)
ffffffffc0201bc8:	87a2                	mv	a5,s0
ffffffffc0201bca:	fef699e3          	bne	a3,a5,ffffffffc0201bbc <slob_alloc.constprop.0+0x3c>
    if (flag)
ffffffffc0201bce:	ee31                	bnez	a2,ffffffffc0201c2a <slob_alloc.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc0201bd0:	4501                	li	a0,0
ffffffffc0201bd2:	f4bff0ef          	jal	ra,ffffffffc0201b1c <__slob_get_free_pages.constprop.0>
ffffffffc0201bd6:	842a                	mv	s0,a0
			if (!cur)
ffffffffc0201bd8:	cd05                	beqz	a0,ffffffffc0201c10 <slob_alloc.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc0201bda:	6585                	lui	a1,0x1
ffffffffc0201bdc:	e8dff0ef          	jal	ra,ffffffffc0201a68 <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201be0:	10002673          	csrr	a2,sstatus
ffffffffc0201be4:	8a09                	andi	a2,a2,2
ffffffffc0201be6:	ee05                	bnez	a2,ffffffffc0201c1e <slob_alloc.constprop.0+0x9e>
			cur = slobfree;
ffffffffc0201be8:	00093783          	ld	a5,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201bec:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201bee:	4018                	lw	a4,0(s0)
ffffffffc0201bf0:	fc974ae3          	blt	a4,s1,ffffffffc0201bc4 <slob_alloc.constprop.0+0x44>
			if (cur->units == units)	/* exact fit? */
ffffffffc0201bf4:	04e48763          	beq	s1,a4,ffffffffc0201c42 <slob_alloc.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc0201bf8:	00449693          	slli	a3,s1,0x4
ffffffffc0201bfc:	96a2                	add	a3,a3,s0
ffffffffc0201bfe:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc0201c00:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc0201c02:	9f05                	subw	a4,a4,s1
ffffffffc0201c04:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc0201c06:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc0201c08:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc0201c0a:	00f93023          	sd	a5,0(s2)
    if (flag)
ffffffffc0201c0e:	e20d                	bnez	a2,ffffffffc0201c30 <slob_alloc.constprop.0+0xb0>
}
ffffffffc0201c10:	60e2                	ld	ra,24(sp)
ffffffffc0201c12:	8522                	mv	a0,s0
ffffffffc0201c14:	6442                	ld	s0,16(sp)
ffffffffc0201c16:	64a2                	ld	s1,8(sp)
ffffffffc0201c18:	6902                	ld	s2,0(sp)
ffffffffc0201c1a:	6105                	addi	sp,sp,32
ffffffffc0201c1c:	8082                	ret
        intr_disable();
ffffffffc0201c1e:	d97fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
			cur = slobfree;
ffffffffc0201c22:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc0201c26:	4605                	li	a2,1
ffffffffc0201c28:	b7d1                	j	ffffffffc0201bec <slob_alloc.constprop.0+0x6c>
        intr_enable();
ffffffffc0201c2a:	d85fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201c2e:	b74d                	j	ffffffffc0201bd0 <slob_alloc.constprop.0+0x50>
ffffffffc0201c30:	d7ffe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
}
ffffffffc0201c34:	60e2                	ld	ra,24(sp)
ffffffffc0201c36:	8522                	mv	a0,s0
ffffffffc0201c38:	6442                	ld	s0,16(sp)
ffffffffc0201c3a:	64a2                	ld	s1,8(sp)
ffffffffc0201c3c:	6902                	ld	s2,0(sp)
ffffffffc0201c3e:	6105                	addi	sp,sp,32
ffffffffc0201c40:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc0201c42:	6418                	ld	a4,8(s0)
ffffffffc0201c44:	e798                	sd	a4,8(a5)
ffffffffc0201c46:	b7d1                	j	ffffffffc0201c0a <slob_alloc.constprop.0+0x8a>
        intr_disable();
ffffffffc0201c48:	d6dfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0201c4c:	4605                	li	a2,1
ffffffffc0201c4e:	bf99                	j	ffffffffc0201ba4 <slob_alloc.constprop.0+0x24>
		if (cur->units >= units + delta)
ffffffffc0201c50:	843e                	mv	s0,a5
ffffffffc0201c52:	87b6                	mv	a5,a3
ffffffffc0201c54:	b745                	j	ffffffffc0201bf4 <slob_alloc.constprop.0+0x74>
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201c56:	00005697          	auipc	a3,0x5
ffffffffc0201c5a:	8f268693          	addi	a3,a3,-1806 # ffffffffc0206548 <default_pmm_manager+0x70>
ffffffffc0201c5e:	00004617          	auipc	a2,0x4
ffffffffc0201c62:	4ca60613          	addi	a2,a2,1226 # ffffffffc0206128 <commands+0x818>
ffffffffc0201c66:	06300593          	li	a1,99
ffffffffc0201c6a:	00005517          	auipc	a0,0x5
ffffffffc0201c6e:	8fe50513          	addi	a0,a0,-1794 # ffffffffc0206568 <default_pmm_manager+0x90>
ffffffffc0201c72:	81dfe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201c76 <kmalloc_init>:
	cprintf("use SLOB allocator\n");
}

inline void
kmalloc_init(void)
{
ffffffffc0201c76:	1141                	addi	sp,sp,-16
	cprintf("use SLOB allocator\n");
ffffffffc0201c78:	00005517          	auipc	a0,0x5
ffffffffc0201c7c:	90850513          	addi	a0,a0,-1784 # ffffffffc0206580 <default_pmm_manager+0xa8>
{
ffffffffc0201c80:	e406                	sd	ra,8(sp)
	cprintf("use SLOB allocator\n");
ffffffffc0201c82:	d12fe0ef          	jal	ra,ffffffffc0200194 <cprintf>
	slob_init();
	cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc0201c86:	60a2                	ld	ra,8(sp)
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201c88:	00005517          	auipc	a0,0x5
ffffffffc0201c8c:	91050513          	addi	a0,a0,-1776 # ffffffffc0206598 <default_pmm_manager+0xc0>
}
ffffffffc0201c90:	0141                	addi	sp,sp,16
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201c92:	d02fe06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0201c96 <kallocated>:

size_t
kallocated(void)
{
	return slob_allocated();
}
ffffffffc0201c96:	4501                	li	a0,0
ffffffffc0201c98:	8082                	ret

ffffffffc0201c9a <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc0201c9a:	1101                	addi	sp,sp,-32
ffffffffc0201c9c:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201c9e:	6905                	lui	s2,0x1
{
ffffffffc0201ca0:	e822                	sd	s0,16(sp)
ffffffffc0201ca2:	ec06                	sd	ra,24(sp)
ffffffffc0201ca4:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201ca6:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_faultread_out_size-0x8bc1>
{
ffffffffc0201caa:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201cac:	04a7f963          	bgeu	a5,a0,ffffffffc0201cfe <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc0201cb0:	4561                	li	a0,24
ffffffffc0201cb2:	ecfff0ef          	jal	ra,ffffffffc0201b80 <slob_alloc.constprop.0>
ffffffffc0201cb6:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc0201cb8:	c929                	beqz	a0,ffffffffc0201d0a <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc0201cba:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc0201cbe:	4501                	li	a0,0
	for (; size > 4096; size >>= 1)
ffffffffc0201cc0:	00f95763          	bge	s2,a5,ffffffffc0201cce <kmalloc+0x34>
ffffffffc0201cc4:	6705                	lui	a4,0x1
ffffffffc0201cc6:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc0201cc8:	2505                	addiw	a0,a0,1
	for (; size > 4096; size >>= 1)
ffffffffc0201cca:	fef74ee3          	blt	a4,a5,ffffffffc0201cc6 <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc0201cce:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc0201cd0:	e4dff0ef          	jal	ra,ffffffffc0201b1c <__slob_get_free_pages.constprop.0>
ffffffffc0201cd4:	e488                	sd	a0,8(s1)
ffffffffc0201cd6:	842a                	mv	s0,a0
	if (bb->pages)
ffffffffc0201cd8:	c525                	beqz	a0,ffffffffc0201d40 <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201cda:	100027f3          	csrr	a5,sstatus
ffffffffc0201cde:	8b89                	andi	a5,a5,2
ffffffffc0201ce0:	ef8d                	bnez	a5,ffffffffc0201d1a <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc0201ce2:	000a9797          	auipc	a5,0xa9
ffffffffc0201ce6:	a3678793          	addi	a5,a5,-1482 # ffffffffc02aa718 <bigblocks>
ffffffffc0201cea:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201cec:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201cee:	e898                	sd	a4,16(s1)
	return __kmalloc(size, 0);
}
ffffffffc0201cf0:	60e2                	ld	ra,24(sp)
ffffffffc0201cf2:	8522                	mv	a0,s0
ffffffffc0201cf4:	6442                	ld	s0,16(sp)
ffffffffc0201cf6:	64a2                	ld	s1,8(sp)
ffffffffc0201cf8:	6902                	ld	s2,0(sp)
ffffffffc0201cfa:	6105                	addi	sp,sp,32
ffffffffc0201cfc:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc0201cfe:	0541                	addi	a0,a0,16
ffffffffc0201d00:	e81ff0ef          	jal	ra,ffffffffc0201b80 <slob_alloc.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc0201d04:	01050413          	addi	s0,a0,16
ffffffffc0201d08:	f565                	bnez	a0,ffffffffc0201cf0 <kmalloc+0x56>
ffffffffc0201d0a:	4401                	li	s0,0
}
ffffffffc0201d0c:	60e2                	ld	ra,24(sp)
ffffffffc0201d0e:	8522                	mv	a0,s0
ffffffffc0201d10:	6442                	ld	s0,16(sp)
ffffffffc0201d12:	64a2                	ld	s1,8(sp)
ffffffffc0201d14:	6902                	ld	s2,0(sp)
ffffffffc0201d16:	6105                	addi	sp,sp,32
ffffffffc0201d18:	8082                	ret
        intr_disable();
ffffffffc0201d1a:	c9bfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
		bb->next = bigblocks;
ffffffffc0201d1e:	000a9797          	auipc	a5,0xa9
ffffffffc0201d22:	9fa78793          	addi	a5,a5,-1542 # ffffffffc02aa718 <bigblocks>
ffffffffc0201d26:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201d28:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201d2a:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc0201d2c:	c83fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
		return bb->pages;
ffffffffc0201d30:	6480                	ld	s0,8(s1)
}
ffffffffc0201d32:	60e2                	ld	ra,24(sp)
ffffffffc0201d34:	64a2                	ld	s1,8(sp)
ffffffffc0201d36:	8522                	mv	a0,s0
ffffffffc0201d38:	6442                	ld	s0,16(sp)
ffffffffc0201d3a:	6902                	ld	s2,0(sp)
ffffffffc0201d3c:	6105                	addi	sp,sp,32
ffffffffc0201d3e:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc0201d40:	45e1                	li	a1,24
ffffffffc0201d42:	8526                	mv	a0,s1
ffffffffc0201d44:	d25ff0ef          	jal	ra,ffffffffc0201a68 <slob_free>
	return __kmalloc(size, 0);
ffffffffc0201d48:	b765                	j	ffffffffc0201cf0 <kmalloc+0x56>

ffffffffc0201d4a <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc0201d4a:	c169                	beqz	a0,ffffffffc0201e0c <kfree+0xc2>
{
ffffffffc0201d4c:	1101                	addi	sp,sp,-32
ffffffffc0201d4e:	e822                	sd	s0,16(sp)
ffffffffc0201d50:	ec06                	sd	ra,24(sp)
ffffffffc0201d52:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE - 1)))
ffffffffc0201d54:	03451793          	slli	a5,a0,0x34
ffffffffc0201d58:	842a                	mv	s0,a0
ffffffffc0201d5a:	e3d9                	bnez	a5,ffffffffc0201de0 <kfree+0x96>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201d5c:	100027f3          	csrr	a5,sstatus
ffffffffc0201d60:	8b89                	andi	a5,a5,2
ffffffffc0201d62:	e7d9                	bnez	a5,ffffffffc0201df0 <kfree+0xa6>
	{
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201d64:	000a9797          	auipc	a5,0xa9
ffffffffc0201d68:	9b47b783          	ld	a5,-1612(a5) # ffffffffc02aa718 <bigblocks>
    return 0;
ffffffffc0201d6c:	4601                	li	a2,0
ffffffffc0201d6e:	cbad                	beqz	a5,ffffffffc0201de0 <kfree+0x96>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc0201d70:	000a9697          	auipc	a3,0xa9
ffffffffc0201d74:	9a868693          	addi	a3,a3,-1624 # ffffffffc02aa718 <bigblocks>
ffffffffc0201d78:	a021                	j	ffffffffc0201d80 <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201d7a:	01048693          	addi	a3,s1,16
ffffffffc0201d7e:	c3a5                	beqz	a5,ffffffffc0201dde <kfree+0x94>
		{
			if (bb->pages == block)
ffffffffc0201d80:	6798                	ld	a4,8(a5)
ffffffffc0201d82:	84be                	mv	s1,a5
			{
				*last = bb->next;
ffffffffc0201d84:	6b9c                	ld	a5,16(a5)
			if (bb->pages == block)
ffffffffc0201d86:	fe871ae3          	bne	a4,s0,ffffffffc0201d7a <kfree+0x30>
				*last = bb->next;
ffffffffc0201d8a:	e29c                	sd	a5,0(a3)
    if (flag)
ffffffffc0201d8c:	ee2d                	bnez	a2,ffffffffc0201e06 <kfree+0xbc>
    return pa2page(PADDR(kva));
ffffffffc0201d8e:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc0201d92:	4098                	lw	a4,0(s1)
ffffffffc0201d94:	08f46963          	bltu	s0,a5,ffffffffc0201e26 <kfree+0xdc>
ffffffffc0201d98:	000a9697          	auipc	a3,0xa9
ffffffffc0201d9c:	9b06b683          	ld	a3,-1616(a3) # ffffffffc02aa748 <va_pa_offset>
ffffffffc0201da0:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage)
ffffffffc0201da2:	8031                	srli	s0,s0,0xc
ffffffffc0201da4:	000a9797          	auipc	a5,0xa9
ffffffffc0201da8:	98c7b783          	ld	a5,-1652(a5) # ffffffffc02aa730 <npage>
ffffffffc0201dac:	06f47163          	bgeu	s0,a5,ffffffffc0201e0e <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc0201db0:	00006517          	auipc	a0,0x6
ffffffffc0201db4:	a2853503          	ld	a0,-1496(a0) # ffffffffc02077d8 <nbase>
ffffffffc0201db8:	8c09                	sub	s0,s0,a0
ffffffffc0201dba:	041a                	slli	s0,s0,0x6
	free_pages(kva2page(kva), 1 << order);
ffffffffc0201dbc:	000a9517          	auipc	a0,0xa9
ffffffffc0201dc0:	97c53503          	ld	a0,-1668(a0) # ffffffffc02aa738 <pages>
ffffffffc0201dc4:	4585                	li	a1,1
ffffffffc0201dc6:	9522                	add	a0,a0,s0
ffffffffc0201dc8:	00e595bb          	sllw	a1,a1,a4
ffffffffc0201dcc:	0ea000ef          	jal	ra,ffffffffc0201eb6 <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc0201dd0:	6442                	ld	s0,16(sp)
ffffffffc0201dd2:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201dd4:	8526                	mv	a0,s1
}
ffffffffc0201dd6:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201dd8:	45e1                	li	a1,24
}
ffffffffc0201dda:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201ddc:	b171                	j	ffffffffc0201a68 <slob_free>
ffffffffc0201dde:	e20d                	bnez	a2,ffffffffc0201e00 <kfree+0xb6>
ffffffffc0201de0:	ff040513          	addi	a0,s0,-16
}
ffffffffc0201de4:	6442                	ld	s0,16(sp)
ffffffffc0201de6:	60e2                	ld	ra,24(sp)
ffffffffc0201de8:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201dea:	4581                	li	a1,0
}
ffffffffc0201dec:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201dee:	b9ad                	j	ffffffffc0201a68 <slob_free>
        intr_disable();
ffffffffc0201df0:	bc5fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201df4:	000a9797          	auipc	a5,0xa9
ffffffffc0201df8:	9247b783          	ld	a5,-1756(a5) # ffffffffc02aa718 <bigblocks>
        return 1;
ffffffffc0201dfc:	4605                	li	a2,1
ffffffffc0201dfe:	fbad                	bnez	a5,ffffffffc0201d70 <kfree+0x26>
        intr_enable();
ffffffffc0201e00:	baffe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201e04:	bff1                	j	ffffffffc0201de0 <kfree+0x96>
ffffffffc0201e06:	ba9fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201e0a:	b751                	j	ffffffffc0201d8e <kfree+0x44>
ffffffffc0201e0c:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0201e0e:	00004617          	auipc	a2,0x4
ffffffffc0201e12:	7d260613          	addi	a2,a2,2002 # ffffffffc02065e0 <default_pmm_manager+0x108>
ffffffffc0201e16:	06900593          	li	a1,105
ffffffffc0201e1a:	00004517          	auipc	a0,0x4
ffffffffc0201e1e:	71e50513          	addi	a0,a0,1822 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0201e22:	e6cfe0ef          	jal	ra,ffffffffc020048e <__panic>
    return pa2page(PADDR(kva));
ffffffffc0201e26:	86a2                	mv	a3,s0
ffffffffc0201e28:	00004617          	auipc	a2,0x4
ffffffffc0201e2c:	79060613          	addi	a2,a2,1936 # ffffffffc02065b8 <default_pmm_manager+0xe0>
ffffffffc0201e30:	07700593          	li	a1,119
ffffffffc0201e34:	00004517          	auipc	a0,0x4
ffffffffc0201e38:	70450513          	addi	a0,a0,1796 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0201e3c:	e52fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201e40 <pa2page.part.0>:
pa2page(uintptr_t pa)
ffffffffc0201e40:	1141                	addi	sp,sp,-16
        panic("pa2page called with invalid pa");
ffffffffc0201e42:	00004617          	auipc	a2,0x4
ffffffffc0201e46:	79e60613          	addi	a2,a2,1950 # ffffffffc02065e0 <default_pmm_manager+0x108>
ffffffffc0201e4a:	06900593          	li	a1,105
ffffffffc0201e4e:	00004517          	auipc	a0,0x4
ffffffffc0201e52:	6ea50513          	addi	a0,a0,1770 # ffffffffc0206538 <default_pmm_manager+0x60>
pa2page(uintptr_t pa)
ffffffffc0201e56:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc0201e58:	e36fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201e5c <pte2page.part.0>:
pte2page(pte_t pte)
ffffffffc0201e5c:	1141                	addi	sp,sp,-16
        panic("pte2page called with invalid pte");
ffffffffc0201e5e:	00004617          	auipc	a2,0x4
ffffffffc0201e62:	7a260613          	addi	a2,a2,1954 # ffffffffc0206600 <default_pmm_manager+0x128>
ffffffffc0201e66:	07f00593          	li	a1,127
ffffffffc0201e6a:	00004517          	auipc	a0,0x4
ffffffffc0201e6e:	6ce50513          	addi	a0,a0,1742 # ffffffffc0206538 <default_pmm_manager+0x60>
pte2page(pte_t pte)
ffffffffc0201e72:	e406                	sd	ra,8(sp)
        panic("pte2page called with invalid pte");
ffffffffc0201e74:	e1afe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201e78 <alloc_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201e78:	100027f3          	csrr	a5,sstatus
ffffffffc0201e7c:	8b89                	andi	a5,a5,2
ffffffffc0201e7e:	e799                	bnez	a5,ffffffffc0201e8c <alloc_pages+0x14>
{
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc0201e80:	000a9797          	auipc	a5,0xa9
ffffffffc0201e84:	8c07b783          	ld	a5,-1856(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc0201e88:	6f9c                	ld	a5,24(a5)
ffffffffc0201e8a:	8782                	jr	a5
{
ffffffffc0201e8c:	1141                	addi	sp,sp,-16
ffffffffc0201e8e:	e406                	sd	ra,8(sp)
ffffffffc0201e90:	e022                	sd	s0,0(sp)
ffffffffc0201e92:	842a                	mv	s0,a0
        intr_disable();
ffffffffc0201e94:	b21fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201e98:	000a9797          	auipc	a5,0xa9
ffffffffc0201e9c:	8a87b783          	ld	a5,-1880(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc0201ea0:	6f9c                	ld	a5,24(a5)
ffffffffc0201ea2:	8522                	mv	a0,s0
ffffffffc0201ea4:	9782                	jalr	a5
ffffffffc0201ea6:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201ea8:	b07fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc0201eac:	60a2                	ld	ra,8(sp)
ffffffffc0201eae:	8522                	mv	a0,s0
ffffffffc0201eb0:	6402                	ld	s0,0(sp)
ffffffffc0201eb2:	0141                	addi	sp,sp,16
ffffffffc0201eb4:	8082                	ret

ffffffffc0201eb6 <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201eb6:	100027f3          	csrr	a5,sstatus
ffffffffc0201eba:	8b89                	andi	a5,a5,2
ffffffffc0201ebc:	e799                	bnez	a5,ffffffffc0201eca <free_pages+0x14>
void free_pages(struct Page *base, size_t n)
{
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0201ebe:	000a9797          	auipc	a5,0xa9
ffffffffc0201ec2:	8827b783          	ld	a5,-1918(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc0201ec6:	739c                	ld	a5,32(a5)
ffffffffc0201ec8:	8782                	jr	a5
{
ffffffffc0201eca:	1101                	addi	sp,sp,-32
ffffffffc0201ecc:	ec06                	sd	ra,24(sp)
ffffffffc0201ece:	e822                	sd	s0,16(sp)
ffffffffc0201ed0:	e426                	sd	s1,8(sp)
ffffffffc0201ed2:	842a                	mv	s0,a0
ffffffffc0201ed4:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0201ed6:	adffe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0201eda:	000a9797          	auipc	a5,0xa9
ffffffffc0201ede:	8667b783          	ld	a5,-1946(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc0201ee2:	739c                	ld	a5,32(a5)
ffffffffc0201ee4:	85a6                	mv	a1,s1
ffffffffc0201ee6:	8522                	mv	a0,s0
ffffffffc0201ee8:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0201eea:	6442                	ld	s0,16(sp)
ffffffffc0201eec:	60e2                	ld	ra,24(sp)
ffffffffc0201eee:	64a2                	ld	s1,8(sp)
ffffffffc0201ef0:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0201ef2:	abdfe06f          	j	ffffffffc02009ae <intr_enable>

ffffffffc0201ef6 <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201ef6:	100027f3          	csrr	a5,sstatus
ffffffffc0201efa:	8b89                	andi	a5,a5,2
ffffffffc0201efc:	e799                	bnez	a5,ffffffffc0201f0a <nr_free_pages+0x14>
{
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0201efe:	000a9797          	auipc	a5,0xa9
ffffffffc0201f02:	8427b783          	ld	a5,-1982(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc0201f06:	779c                	ld	a5,40(a5)
ffffffffc0201f08:	8782                	jr	a5
{
ffffffffc0201f0a:	1141                	addi	sp,sp,-16
ffffffffc0201f0c:	e406                	sd	ra,8(sp)
ffffffffc0201f0e:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0201f10:	aa5fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0201f14:	000a9797          	auipc	a5,0xa9
ffffffffc0201f18:	82c7b783          	ld	a5,-2004(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc0201f1c:	779c                	ld	a5,40(a5)
ffffffffc0201f1e:	9782                	jalr	a5
ffffffffc0201f20:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201f22:	a8dfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0201f26:	60a2                	ld	ra,8(sp)
ffffffffc0201f28:	8522                	mv	a0,s0
ffffffffc0201f2a:	6402                	ld	s0,0(sp)
ffffffffc0201f2c:	0141                	addi	sp,sp,16
ffffffffc0201f2e:	8082                	ret

ffffffffc0201f30 <get_pte>:
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create)
{
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f30:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0201f34:	1ff7f793          	andi	a5,a5,511
{
ffffffffc0201f38:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f3a:	078e                	slli	a5,a5,0x3
{
ffffffffc0201f3c:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f3e:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V))
ffffffffc0201f42:	6094                	ld	a3,0(s1)
{
ffffffffc0201f44:	f04a                	sd	s2,32(sp)
ffffffffc0201f46:	ec4e                	sd	s3,24(sp)
ffffffffc0201f48:	e852                	sd	s4,16(sp)
ffffffffc0201f4a:	fc06                	sd	ra,56(sp)
ffffffffc0201f4c:	f822                	sd	s0,48(sp)
ffffffffc0201f4e:	e456                	sd	s5,8(sp)
ffffffffc0201f50:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V))
ffffffffc0201f52:	0016f793          	andi	a5,a3,1
{
ffffffffc0201f56:	892e                	mv	s2,a1
ffffffffc0201f58:	8a32                	mv	s4,a2
ffffffffc0201f5a:	000a8997          	auipc	s3,0xa8
ffffffffc0201f5e:	7d698993          	addi	s3,s3,2006 # ffffffffc02aa730 <npage>
    if (!(*pdep1 & PTE_V))
ffffffffc0201f62:	efbd                	bnez	a5,ffffffffc0201fe0 <get_pte+0xb0>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f64:	14060c63          	beqz	a2,ffffffffc02020bc <get_pte+0x18c>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201f68:	100027f3          	csrr	a5,sstatus
ffffffffc0201f6c:	8b89                	andi	a5,a5,2
ffffffffc0201f6e:	14079963          	bnez	a5,ffffffffc02020c0 <get_pte+0x190>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201f72:	000a8797          	auipc	a5,0xa8
ffffffffc0201f76:	7ce7b783          	ld	a5,1998(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc0201f7a:	6f9c                	ld	a5,24(a5)
ffffffffc0201f7c:	4505                	li	a0,1
ffffffffc0201f7e:	9782                	jalr	a5
ffffffffc0201f80:	842a                	mv	s0,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f82:	12040d63          	beqz	s0,ffffffffc02020bc <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0201f86:	000a8b17          	auipc	s6,0xa8
ffffffffc0201f8a:	7b2b0b13          	addi	s6,s6,1970 # ffffffffc02aa738 <pages>
ffffffffc0201f8e:	000b3503          	ld	a0,0(s6)
ffffffffc0201f92:	00080ab7          	lui	s5,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201f96:	000a8997          	auipc	s3,0xa8
ffffffffc0201f9a:	79a98993          	addi	s3,s3,1946 # ffffffffc02aa730 <npage>
ffffffffc0201f9e:	40a40533          	sub	a0,s0,a0
ffffffffc0201fa2:	8519                	srai	a0,a0,0x6
ffffffffc0201fa4:	9556                	add	a0,a0,s5
ffffffffc0201fa6:	0009b703          	ld	a4,0(s3)
ffffffffc0201faa:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0201fae:	4685                	li	a3,1
ffffffffc0201fb0:	c014                	sw	a3,0(s0)
ffffffffc0201fb2:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201fb4:	0532                	slli	a0,a0,0xc
ffffffffc0201fb6:	16e7f763          	bgeu	a5,a4,ffffffffc0202124 <get_pte+0x1f4>
ffffffffc0201fba:	000a8797          	auipc	a5,0xa8
ffffffffc0201fbe:	78e7b783          	ld	a5,1934(a5) # ffffffffc02aa748 <va_pa_offset>
ffffffffc0201fc2:	6605                	lui	a2,0x1
ffffffffc0201fc4:	4581                	li	a1,0
ffffffffc0201fc6:	953e                	add	a0,a0,a5
ffffffffc0201fc8:	6b0030ef          	jal	ra,ffffffffc0205678 <memset>
    return page - pages + nbase;
ffffffffc0201fcc:	000b3683          	ld	a3,0(s6)
ffffffffc0201fd0:	40d406b3          	sub	a3,s0,a3
ffffffffc0201fd4:	8699                	srai	a3,a3,0x6
ffffffffc0201fd6:	96d6                	add	a3,a3,s5
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type)
{
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0201fd8:	06aa                	slli	a3,a3,0xa
ffffffffc0201fda:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0201fde:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0201fe0:	77fd                	lui	a5,0xfffff
ffffffffc0201fe2:	068a                	slli	a3,a3,0x2
ffffffffc0201fe4:	0009b703          	ld	a4,0(s3)
ffffffffc0201fe8:	8efd                	and	a3,a3,a5
ffffffffc0201fea:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201fee:	10e7ff63          	bgeu	a5,a4,ffffffffc020210c <get_pte+0x1dc>
ffffffffc0201ff2:	000a8a97          	auipc	s5,0xa8
ffffffffc0201ff6:	756a8a93          	addi	s5,s5,1878 # ffffffffc02aa748 <va_pa_offset>
ffffffffc0201ffa:	000ab403          	ld	s0,0(s5)
ffffffffc0201ffe:	01595793          	srli	a5,s2,0x15
ffffffffc0202002:	1ff7f793          	andi	a5,a5,511
ffffffffc0202006:	96a2                	add	a3,a3,s0
ffffffffc0202008:	00379413          	slli	s0,a5,0x3
ffffffffc020200c:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V))
ffffffffc020200e:	6014                	ld	a3,0(s0)
ffffffffc0202010:	0016f793          	andi	a5,a3,1
ffffffffc0202014:	ebad                	bnez	a5,ffffffffc0202086 <get_pte+0x156>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0202016:	0a0a0363          	beqz	s4,ffffffffc02020bc <get_pte+0x18c>
ffffffffc020201a:	100027f3          	csrr	a5,sstatus
ffffffffc020201e:	8b89                	andi	a5,a5,2
ffffffffc0202020:	efcd                	bnez	a5,ffffffffc02020da <get_pte+0x1aa>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202022:	000a8797          	auipc	a5,0xa8
ffffffffc0202026:	71e7b783          	ld	a5,1822(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc020202a:	6f9c                	ld	a5,24(a5)
ffffffffc020202c:	4505                	li	a0,1
ffffffffc020202e:	9782                	jalr	a5
ffffffffc0202030:	84aa                	mv	s1,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0202032:	c4c9                	beqz	s1,ffffffffc02020bc <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0202034:	000a8b17          	auipc	s6,0xa8
ffffffffc0202038:	704b0b13          	addi	s6,s6,1796 # ffffffffc02aa738 <pages>
ffffffffc020203c:	000b3503          	ld	a0,0(s6)
ffffffffc0202040:	00080a37          	lui	s4,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202044:	0009b703          	ld	a4,0(s3)
ffffffffc0202048:	40a48533          	sub	a0,s1,a0
ffffffffc020204c:	8519                	srai	a0,a0,0x6
ffffffffc020204e:	9552                	add	a0,a0,s4
ffffffffc0202050:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0202054:	4685                	li	a3,1
ffffffffc0202056:	c094                	sw	a3,0(s1)
ffffffffc0202058:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc020205a:	0532                	slli	a0,a0,0xc
ffffffffc020205c:	0ee7f163          	bgeu	a5,a4,ffffffffc020213e <get_pte+0x20e>
ffffffffc0202060:	000ab783          	ld	a5,0(s5)
ffffffffc0202064:	6605                	lui	a2,0x1
ffffffffc0202066:	4581                	li	a1,0
ffffffffc0202068:	953e                	add	a0,a0,a5
ffffffffc020206a:	60e030ef          	jal	ra,ffffffffc0205678 <memset>
    return page - pages + nbase;
ffffffffc020206e:	000b3683          	ld	a3,0(s6)
ffffffffc0202072:	40d486b3          	sub	a3,s1,a3
ffffffffc0202076:	8699                	srai	a3,a3,0x6
ffffffffc0202078:	96d2                	add	a3,a3,s4
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc020207a:	06aa                	slli	a3,a3,0xa
ffffffffc020207c:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0202080:	e014                	sd	a3,0(s0)
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0202082:	0009b703          	ld	a4,0(s3)
ffffffffc0202086:	068a                	slli	a3,a3,0x2
ffffffffc0202088:	757d                	lui	a0,0xfffff
ffffffffc020208a:	8ee9                	and	a3,a3,a0
ffffffffc020208c:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202090:	06e7f263          	bgeu	a5,a4,ffffffffc02020f4 <get_pte+0x1c4>
ffffffffc0202094:	000ab503          	ld	a0,0(s5)
ffffffffc0202098:	00c95913          	srli	s2,s2,0xc
ffffffffc020209c:	1ff97913          	andi	s2,s2,511
ffffffffc02020a0:	96aa                	add	a3,a3,a0
ffffffffc02020a2:	00391513          	slli	a0,s2,0x3
ffffffffc02020a6:	9536                	add	a0,a0,a3
}
ffffffffc02020a8:	70e2                	ld	ra,56(sp)
ffffffffc02020aa:	7442                	ld	s0,48(sp)
ffffffffc02020ac:	74a2                	ld	s1,40(sp)
ffffffffc02020ae:	7902                	ld	s2,32(sp)
ffffffffc02020b0:	69e2                	ld	s3,24(sp)
ffffffffc02020b2:	6a42                	ld	s4,16(sp)
ffffffffc02020b4:	6aa2                	ld	s5,8(sp)
ffffffffc02020b6:	6b02                	ld	s6,0(sp)
ffffffffc02020b8:	6121                	addi	sp,sp,64
ffffffffc02020ba:	8082                	ret
            return NULL;
ffffffffc02020bc:	4501                	li	a0,0
ffffffffc02020be:	b7ed                	j	ffffffffc02020a8 <get_pte+0x178>
        intr_disable();
ffffffffc02020c0:	8f5fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc02020c4:	000a8797          	auipc	a5,0xa8
ffffffffc02020c8:	67c7b783          	ld	a5,1660(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc02020cc:	6f9c                	ld	a5,24(a5)
ffffffffc02020ce:	4505                	li	a0,1
ffffffffc02020d0:	9782                	jalr	a5
ffffffffc02020d2:	842a                	mv	s0,a0
        intr_enable();
ffffffffc02020d4:	8dbfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02020d8:	b56d                	j	ffffffffc0201f82 <get_pte+0x52>
        intr_disable();
ffffffffc02020da:	8dbfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02020de:	000a8797          	auipc	a5,0xa8
ffffffffc02020e2:	6627b783          	ld	a5,1634(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc02020e6:	6f9c                	ld	a5,24(a5)
ffffffffc02020e8:	4505                	li	a0,1
ffffffffc02020ea:	9782                	jalr	a5
ffffffffc02020ec:	84aa                	mv	s1,a0
        intr_enable();
ffffffffc02020ee:	8c1fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02020f2:	b781                	j	ffffffffc0202032 <get_pte+0x102>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc02020f4:	00004617          	auipc	a2,0x4
ffffffffc02020f8:	41c60613          	addi	a2,a2,1052 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc02020fc:	0fa00593          	li	a1,250
ffffffffc0202100:	00004517          	auipc	a0,0x4
ffffffffc0202104:	52850513          	addi	a0,a0,1320 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202108:	b86fe0ef          	jal	ra,ffffffffc020048e <__panic>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc020210c:	00004617          	auipc	a2,0x4
ffffffffc0202110:	40460613          	addi	a2,a2,1028 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc0202114:	0ed00593          	li	a1,237
ffffffffc0202118:	00004517          	auipc	a0,0x4
ffffffffc020211c:	51050513          	addi	a0,a0,1296 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202120:	b6efe0ef          	jal	ra,ffffffffc020048e <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202124:	86aa                	mv	a3,a0
ffffffffc0202126:	00004617          	auipc	a2,0x4
ffffffffc020212a:	3ea60613          	addi	a2,a2,1002 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc020212e:	0e900593          	li	a1,233
ffffffffc0202132:	00004517          	auipc	a0,0x4
ffffffffc0202136:	4f650513          	addi	a0,a0,1270 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc020213a:	b54fe0ef          	jal	ra,ffffffffc020048e <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc020213e:	86aa                	mv	a3,a0
ffffffffc0202140:	00004617          	auipc	a2,0x4
ffffffffc0202144:	3d060613          	addi	a2,a2,976 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc0202148:	0f700593          	li	a1,247
ffffffffc020214c:	00004517          	auipc	a0,0x4
ffffffffc0202150:	4dc50513          	addi	a0,a0,1244 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202154:	b3afe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0202158 <get_page>:

// get_page - get related Page struct for linear address la using PDT pgdir
struct Page *get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store)
{
ffffffffc0202158:	1141                	addi	sp,sp,-16
ffffffffc020215a:	e022                	sd	s0,0(sp)
ffffffffc020215c:	8432                	mv	s0,a2
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc020215e:	4601                	li	a2,0
{
ffffffffc0202160:	e406                	sd	ra,8(sp)
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc0202162:	dcfff0ef          	jal	ra,ffffffffc0201f30 <get_pte>
    if (ptep_store != NULL)
ffffffffc0202166:	c011                	beqz	s0,ffffffffc020216a <get_page+0x12>
    {
        *ptep_store = ptep;
ffffffffc0202168:	e008                	sd	a0,0(s0)
    }
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc020216a:	c511                	beqz	a0,ffffffffc0202176 <get_page+0x1e>
ffffffffc020216c:	611c                	ld	a5,0(a0)
    {
        return pte2page(*ptep);
    }
    return NULL;
ffffffffc020216e:	4501                	li	a0,0
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc0202170:	0017f713          	andi	a4,a5,1
ffffffffc0202174:	e709                	bnez	a4,ffffffffc020217e <get_page+0x26>
}
ffffffffc0202176:	60a2                	ld	ra,8(sp)
ffffffffc0202178:	6402                	ld	s0,0(sp)
ffffffffc020217a:	0141                	addi	sp,sp,16
ffffffffc020217c:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc020217e:	078a                	slli	a5,a5,0x2
ffffffffc0202180:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202182:	000a8717          	auipc	a4,0xa8
ffffffffc0202186:	5ae73703          	ld	a4,1454(a4) # ffffffffc02aa730 <npage>
ffffffffc020218a:	00e7ff63          	bgeu	a5,a4,ffffffffc02021a8 <get_page+0x50>
ffffffffc020218e:	60a2                	ld	ra,8(sp)
ffffffffc0202190:	6402                	ld	s0,0(sp)
    return &pages[PPN(pa) - nbase];
ffffffffc0202192:	fff80537          	lui	a0,0xfff80
ffffffffc0202196:	97aa                	add	a5,a5,a0
ffffffffc0202198:	079a                	slli	a5,a5,0x6
ffffffffc020219a:	000a8517          	auipc	a0,0xa8
ffffffffc020219e:	59e53503          	ld	a0,1438(a0) # ffffffffc02aa738 <pages>
ffffffffc02021a2:	953e                	add	a0,a0,a5
ffffffffc02021a4:	0141                	addi	sp,sp,16
ffffffffc02021a6:	8082                	ret
ffffffffc02021a8:	c99ff0ef          	jal	ra,ffffffffc0201e40 <pa2page.part.0>

ffffffffc02021ac <unmap_range>:
        tlb_invalidate(pgdir, la);
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end)
{
ffffffffc02021ac:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02021ae:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc02021b2:	f486                	sd	ra,104(sp)
ffffffffc02021b4:	f0a2                	sd	s0,96(sp)
ffffffffc02021b6:	eca6                	sd	s1,88(sp)
ffffffffc02021b8:	e8ca                	sd	s2,80(sp)
ffffffffc02021ba:	e4ce                	sd	s3,72(sp)
ffffffffc02021bc:	e0d2                	sd	s4,64(sp)
ffffffffc02021be:	fc56                	sd	s5,56(sp)
ffffffffc02021c0:	f85a                	sd	s6,48(sp)
ffffffffc02021c2:	f45e                	sd	s7,40(sp)
ffffffffc02021c4:	f062                	sd	s8,32(sp)
ffffffffc02021c6:	ec66                	sd	s9,24(sp)
ffffffffc02021c8:	e86a                	sd	s10,16(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02021ca:	17d2                	slli	a5,a5,0x34
ffffffffc02021cc:	e3ed                	bnez	a5,ffffffffc02022ae <unmap_range+0x102>
    assert(USER_ACCESS(start, end));
ffffffffc02021ce:	002007b7          	lui	a5,0x200
ffffffffc02021d2:	842e                	mv	s0,a1
ffffffffc02021d4:	0ef5ed63          	bltu	a1,a5,ffffffffc02022ce <unmap_range+0x122>
ffffffffc02021d8:	8932                	mv	s2,a2
ffffffffc02021da:	0ec5fa63          	bgeu	a1,a2,ffffffffc02022ce <unmap_range+0x122>
ffffffffc02021de:	4785                	li	a5,1
ffffffffc02021e0:	07fe                	slli	a5,a5,0x1f
ffffffffc02021e2:	0ec7e663          	bltu	a5,a2,ffffffffc02022ce <unmap_range+0x122>
ffffffffc02021e6:	89aa                	mv	s3,a0
        }
        if (*ptep != 0)
        {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc02021e8:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc02021ea:	000a8c97          	auipc	s9,0xa8
ffffffffc02021ee:	546c8c93          	addi	s9,s9,1350 # ffffffffc02aa730 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02021f2:	000a8c17          	auipc	s8,0xa8
ffffffffc02021f6:	546c0c13          	addi	s8,s8,1350 # ffffffffc02aa738 <pages>
ffffffffc02021fa:	fff80bb7          	lui	s7,0xfff80
        pmm_manager->free_pages(base, n);
ffffffffc02021fe:	000a8d17          	auipc	s10,0xa8
ffffffffc0202202:	542d0d13          	addi	s10,s10,1346 # ffffffffc02aa740 <pmm_manager>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202206:	00200b37          	lui	s6,0x200
ffffffffc020220a:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc020220e:	4601                	li	a2,0
ffffffffc0202210:	85a2                	mv	a1,s0
ffffffffc0202212:	854e                	mv	a0,s3
ffffffffc0202214:	d1dff0ef          	jal	ra,ffffffffc0201f30 <get_pte>
ffffffffc0202218:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc020221a:	cd29                	beqz	a0,ffffffffc0202274 <unmap_range+0xc8>
        if (*ptep != 0)
ffffffffc020221c:	611c                	ld	a5,0(a0)
ffffffffc020221e:	e395                	bnez	a5,ffffffffc0202242 <unmap_range+0x96>
        start += PGSIZE;
ffffffffc0202220:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0202222:	ff2466e3          	bltu	s0,s2,ffffffffc020220e <unmap_range+0x62>
}
ffffffffc0202226:	70a6                	ld	ra,104(sp)
ffffffffc0202228:	7406                	ld	s0,96(sp)
ffffffffc020222a:	64e6                	ld	s1,88(sp)
ffffffffc020222c:	6946                	ld	s2,80(sp)
ffffffffc020222e:	69a6                	ld	s3,72(sp)
ffffffffc0202230:	6a06                	ld	s4,64(sp)
ffffffffc0202232:	7ae2                	ld	s5,56(sp)
ffffffffc0202234:	7b42                	ld	s6,48(sp)
ffffffffc0202236:	7ba2                	ld	s7,40(sp)
ffffffffc0202238:	7c02                	ld	s8,32(sp)
ffffffffc020223a:	6ce2                	ld	s9,24(sp)
ffffffffc020223c:	6d42                	ld	s10,16(sp)
ffffffffc020223e:	6165                	addi	sp,sp,112
ffffffffc0202240:	8082                	ret
    if (*ptep & PTE_V)
ffffffffc0202242:	0017f713          	andi	a4,a5,1
ffffffffc0202246:	df69                	beqz	a4,ffffffffc0202220 <unmap_range+0x74>
    if (PPN(pa) >= npage)
ffffffffc0202248:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc020224c:	078a                	slli	a5,a5,0x2
ffffffffc020224e:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202250:	08e7ff63          	bgeu	a5,a4,ffffffffc02022ee <unmap_range+0x142>
    return &pages[PPN(pa) - nbase];
ffffffffc0202254:	000c3503          	ld	a0,0(s8)
ffffffffc0202258:	97de                	add	a5,a5,s7
ffffffffc020225a:	079a                	slli	a5,a5,0x6
ffffffffc020225c:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc020225e:	411c                	lw	a5,0(a0)
ffffffffc0202260:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202264:	c118                	sw	a4,0(a0)
        if (page_ref(page) == 0)
ffffffffc0202266:	cf11                	beqz	a4,ffffffffc0202282 <unmap_range+0xd6>
        *ptep = 0;
ffffffffc0202268:	0004b023          	sd	zero,0(s1)

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la)
{
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020226c:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc0202270:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0202272:	bf45                	j	ffffffffc0202222 <unmap_range+0x76>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0202274:	945a                	add	s0,s0,s6
ffffffffc0202276:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc020227a:	d455                	beqz	s0,ffffffffc0202226 <unmap_range+0x7a>
ffffffffc020227c:	f92469e3          	bltu	s0,s2,ffffffffc020220e <unmap_range+0x62>
ffffffffc0202280:	b75d                	j	ffffffffc0202226 <unmap_range+0x7a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202282:	100027f3          	csrr	a5,sstatus
ffffffffc0202286:	8b89                	andi	a5,a5,2
ffffffffc0202288:	e799                	bnez	a5,ffffffffc0202296 <unmap_range+0xea>
        pmm_manager->free_pages(base, n);
ffffffffc020228a:	000d3783          	ld	a5,0(s10)
ffffffffc020228e:	4585                	li	a1,1
ffffffffc0202290:	739c                	ld	a5,32(a5)
ffffffffc0202292:	9782                	jalr	a5
    if (flag)
ffffffffc0202294:	bfd1                	j	ffffffffc0202268 <unmap_range+0xbc>
ffffffffc0202296:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202298:	f1cfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc020229c:	000d3783          	ld	a5,0(s10)
ffffffffc02022a0:	6522                	ld	a0,8(sp)
ffffffffc02022a2:	4585                	li	a1,1
ffffffffc02022a4:	739c                	ld	a5,32(a5)
ffffffffc02022a6:	9782                	jalr	a5
        intr_enable();
ffffffffc02022a8:	f06fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02022ac:	bf75                	j	ffffffffc0202268 <unmap_range+0xbc>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02022ae:	00004697          	auipc	a3,0x4
ffffffffc02022b2:	38a68693          	addi	a3,a3,906 # ffffffffc0206638 <default_pmm_manager+0x160>
ffffffffc02022b6:	00004617          	auipc	a2,0x4
ffffffffc02022ba:	e7260613          	addi	a2,a2,-398 # ffffffffc0206128 <commands+0x818>
ffffffffc02022be:	12000593          	li	a1,288
ffffffffc02022c2:	00004517          	auipc	a0,0x4
ffffffffc02022c6:	36650513          	addi	a0,a0,870 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02022ca:	9c4fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc02022ce:	00004697          	auipc	a3,0x4
ffffffffc02022d2:	39a68693          	addi	a3,a3,922 # ffffffffc0206668 <default_pmm_manager+0x190>
ffffffffc02022d6:	00004617          	auipc	a2,0x4
ffffffffc02022da:	e5260613          	addi	a2,a2,-430 # ffffffffc0206128 <commands+0x818>
ffffffffc02022de:	12100593          	li	a1,289
ffffffffc02022e2:	00004517          	auipc	a0,0x4
ffffffffc02022e6:	34650513          	addi	a0,a0,838 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02022ea:	9a4fe0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc02022ee:	b53ff0ef          	jal	ra,ffffffffc0201e40 <pa2page.part.0>

ffffffffc02022f2 <exit_range>:
{
ffffffffc02022f2:	7119                	addi	sp,sp,-128
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02022f4:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc02022f8:	fc86                	sd	ra,120(sp)
ffffffffc02022fa:	f8a2                	sd	s0,112(sp)
ffffffffc02022fc:	f4a6                	sd	s1,104(sp)
ffffffffc02022fe:	f0ca                	sd	s2,96(sp)
ffffffffc0202300:	ecce                	sd	s3,88(sp)
ffffffffc0202302:	e8d2                	sd	s4,80(sp)
ffffffffc0202304:	e4d6                	sd	s5,72(sp)
ffffffffc0202306:	e0da                	sd	s6,64(sp)
ffffffffc0202308:	fc5e                	sd	s7,56(sp)
ffffffffc020230a:	f862                	sd	s8,48(sp)
ffffffffc020230c:	f466                	sd	s9,40(sp)
ffffffffc020230e:	f06a                	sd	s10,32(sp)
ffffffffc0202310:	ec6e                	sd	s11,24(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202312:	17d2                	slli	a5,a5,0x34
ffffffffc0202314:	20079a63          	bnez	a5,ffffffffc0202528 <exit_range+0x236>
    assert(USER_ACCESS(start, end));
ffffffffc0202318:	002007b7          	lui	a5,0x200
ffffffffc020231c:	24f5e463          	bltu	a1,a5,ffffffffc0202564 <exit_range+0x272>
ffffffffc0202320:	8ab2                	mv	s5,a2
ffffffffc0202322:	24c5f163          	bgeu	a1,a2,ffffffffc0202564 <exit_range+0x272>
ffffffffc0202326:	4785                	li	a5,1
ffffffffc0202328:	07fe                	slli	a5,a5,0x1f
ffffffffc020232a:	22c7ed63          	bltu	a5,a2,ffffffffc0202564 <exit_range+0x272>
    d1start = ROUNDDOWN(start, PDSIZE);
ffffffffc020232e:	c00009b7          	lui	s3,0xc0000
ffffffffc0202332:	0135f9b3          	and	s3,a1,s3
    d0start = ROUNDDOWN(start, PTSIZE);
ffffffffc0202336:	ffe00937          	lui	s2,0xffe00
ffffffffc020233a:	400007b7          	lui	a5,0x40000
    return KADDR(page2pa(page));
ffffffffc020233e:	5cfd                	li	s9,-1
ffffffffc0202340:	8c2a                	mv	s8,a0
ffffffffc0202342:	0125f933          	and	s2,a1,s2
ffffffffc0202346:	99be                	add	s3,s3,a5
    if (PPN(pa) >= npage)
ffffffffc0202348:	000a8d17          	auipc	s10,0xa8
ffffffffc020234c:	3e8d0d13          	addi	s10,s10,1000 # ffffffffc02aa730 <npage>
    return KADDR(page2pa(page));
ffffffffc0202350:	00ccdc93          	srli	s9,s9,0xc
    return &pages[PPN(pa) - nbase];
ffffffffc0202354:	000a8717          	auipc	a4,0xa8
ffffffffc0202358:	3e470713          	addi	a4,a4,996 # ffffffffc02aa738 <pages>
        pmm_manager->free_pages(base, n);
ffffffffc020235c:	000a8d97          	auipc	s11,0xa8
ffffffffc0202360:	3e4d8d93          	addi	s11,s11,996 # ffffffffc02aa740 <pmm_manager>
        pde1 = pgdir[PDX1(d1start)];
ffffffffc0202364:	c0000437          	lui	s0,0xc0000
ffffffffc0202368:	944e                	add	s0,s0,s3
ffffffffc020236a:	8079                	srli	s0,s0,0x1e
ffffffffc020236c:	1ff47413          	andi	s0,s0,511
ffffffffc0202370:	040e                	slli	s0,s0,0x3
ffffffffc0202372:	9462                	add	s0,s0,s8
ffffffffc0202374:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_obj___user_exit_out_size+0xffffffffbfff4ee0>
        if (pde1 & PTE_V)
ffffffffc0202378:	001a7793          	andi	a5,s4,1
ffffffffc020237c:	eb99                	bnez	a5,ffffffffc0202392 <exit_range+0xa0>
    } while (d1start != 0 && d1start < end);
ffffffffc020237e:	12098463          	beqz	s3,ffffffffc02024a6 <exit_range+0x1b4>
ffffffffc0202382:	400007b7          	lui	a5,0x40000
ffffffffc0202386:	97ce                	add	a5,a5,s3
ffffffffc0202388:	894e                	mv	s2,s3
ffffffffc020238a:	1159fe63          	bgeu	s3,s5,ffffffffc02024a6 <exit_range+0x1b4>
ffffffffc020238e:	89be                	mv	s3,a5
ffffffffc0202390:	bfd1                	j	ffffffffc0202364 <exit_range+0x72>
    if (PPN(pa) >= npage)
ffffffffc0202392:	000d3783          	ld	a5,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202396:	0a0a                	slli	s4,s4,0x2
ffffffffc0202398:	00ca5a13          	srli	s4,s4,0xc
    if (PPN(pa) >= npage)
ffffffffc020239c:	1cfa7263          	bgeu	s4,a5,ffffffffc0202560 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc02023a0:	fff80637          	lui	a2,0xfff80
ffffffffc02023a4:	9652                	add	a2,a2,s4
    return page - pages + nbase;
ffffffffc02023a6:	000806b7          	lui	a3,0x80
ffffffffc02023aa:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc02023ac:	0196f5b3          	and	a1,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc02023b0:	061a                	slli	a2,a2,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc02023b2:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02023b4:	18f5fa63          	bgeu	a1,a5,ffffffffc0202548 <exit_range+0x256>
ffffffffc02023b8:	000a8817          	auipc	a6,0xa8
ffffffffc02023bc:	39080813          	addi	a6,a6,912 # ffffffffc02aa748 <va_pa_offset>
ffffffffc02023c0:	00083b03          	ld	s6,0(a6)
            free_pd0 = 1;
ffffffffc02023c4:	4b85                	li	s7,1
    return &pages[PPN(pa) - nbase];
ffffffffc02023c6:	fff80e37          	lui	t3,0xfff80
    return KADDR(page2pa(page));
ffffffffc02023ca:	9b36                	add	s6,s6,a3
    return page - pages + nbase;
ffffffffc02023cc:	00080337          	lui	t1,0x80
ffffffffc02023d0:	6885                	lui	a7,0x1
ffffffffc02023d2:	a819                	j	ffffffffc02023e8 <exit_range+0xf6>
                    free_pd0 = 0;
ffffffffc02023d4:	4b81                	li	s7,0
                d0start += PTSIZE;
ffffffffc02023d6:	002007b7          	lui	a5,0x200
ffffffffc02023da:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc02023dc:	08090c63          	beqz	s2,ffffffffc0202474 <exit_range+0x182>
ffffffffc02023e0:	09397a63          	bgeu	s2,s3,ffffffffc0202474 <exit_range+0x182>
ffffffffc02023e4:	0f597063          	bgeu	s2,s5,ffffffffc02024c4 <exit_range+0x1d2>
                pde0 = pd0[PDX0(d0start)];
ffffffffc02023e8:	01595493          	srli	s1,s2,0x15
ffffffffc02023ec:	1ff4f493          	andi	s1,s1,511
ffffffffc02023f0:	048e                	slli	s1,s1,0x3
ffffffffc02023f2:	94da                	add	s1,s1,s6
ffffffffc02023f4:	609c                	ld	a5,0(s1)
                if (pde0 & PTE_V)
ffffffffc02023f6:	0017f693          	andi	a3,a5,1
ffffffffc02023fa:	dee9                	beqz	a3,ffffffffc02023d4 <exit_range+0xe2>
    if (PPN(pa) >= npage)
ffffffffc02023fc:	000d3583          	ld	a1,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202400:	078a                	slli	a5,a5,0x2
ffffffffc0202402:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202404:	14b7fe63          	bgeu	a5,a1,ffffffffc0202560 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc0202408:	97f2                	add	a5,a5,t3
    return page - pages + nbase;
ffffffffc020240a:	006786b3          	add	a3,a5,t1
    return KADDR(page2pa(page));
ffffffffc020240e:	0196feb3          	and	t4,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc0202412:	00679513          	slli	a0,a5,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc0202416:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202418:	12bef863          	bgeu	t4,a1,ffffffffc0202548 <exit_range+0x256>
ffffffffc020241c:	00083783          	ld	a5,0(a6)
ffffffffc0202420:	96be                	add	a3,a3,a5
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc0202422:	011685b3          	add	a1,a3,a7
                        if (pt[i] & PTE_V)
ffffffffc0202426:	629c                	ld	a5,0(a3)
ffffffffc0202428:	8b85                	andi	a5,a5,1
ffffffffc020242a:	f7d5                	bnez	a5,ffffffffc02023d6 <exit_range+0xe4>
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc020242c:	06a1                	addi	a3,a3,8
ffffffffc020242e:	fed59ce3          	bne	a1,a3,ffffffffc0202426 <exit_range+0x134>
    return &pages[PPN(pa) - nbase];
ffffffffc0202432:	631c                	ld	a5,0(a4)
ffffffffc0202434:	953e                	add	a0,a0,a5
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202436:	100027f3          	csrr	a5,sstatus
ffffffffc020243a:	8b89                	andi	a5,a5,2
ffffffffc020243c:	e7d9                	bnez	a5,ffffffffc02024ca <exit_range+0x1d8>
        pmm_manager->free_pages(base, n);
ffffffffc020243e:	000db783          	ld	a5,0(s11)
ffffffffc0202442:	4585                	li	a1,1
ffffffffc0202444:	e032                	sd	a2,0(sp)
ffffffffc0202446:	739c                	ld	a5,32(a5)
ffffffffc0202448:	9782                	jalr	a5
    if (flag)
ffffffffc020244a:	6602                	ld	a2,0(sp)
ffffffffc020244c:	000a8817          	auipc	a6,0xa8
ffffffffc0202450:	2fc80813          	addi	a6,a6,764 # ffffffffc02aa748 <va_pa_offset>
ffffffffc0202454:	fff80e37          	lui	t3,0xfff80
ffffffffc0202458:	00080337          	lui	t1,0x80
ffffffffc020245c:	6885                	lui	a7,0x1
ffffffffc020245e:	000a8717          	auipc	a4,0xa8
ffffffffc0202462:	2da70713          	addi	a4,a4,730 # ffffffffc02aa738 <pages>
                        pd0[PDX0(d0start)] = 0;
ffffffffc0202466:	0004b023          	sd	zero,0(s1)
                d0start += PTSIZE;
ffffffffc020246a:	002007b7          	lui	a5,0x200
ffffffffc020246e:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc0202470:	f60918e3          	bnez	s2,ffffffffc02023e0 <exit_range+0xee>
            if (free_pd0)
ffffffffc0202474:	f00b85e3          	beqz	s7,ffffffffc020237e <exit_range+0x8c>
    if (PPN(pa) >= npage)
ffffffffc0202478:	000d3783          	ld	a5,0(s10)
ffffffffc020247c:	0efa7263          	bgeu	s4,a5,ffffffffc0202560 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc0202480:	6308                	ld	a0,0(a4)
ffffffffc0202482:	9532                	add	a0,a0,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202484:	100027f3          	csrr	a5,sstatus
ffffffffc0202488:	8b89                	andi	a5,a5,2
ffffffffc020248a:	efad                	bnez	a5,ffffffffc0202504 <exit_range+0x212>
        pmm_manager->free_pages(base, n);
ffffffffc020248c:	000db783          	ld	a5,0(s11)
ffffffffc0202490:	4585                	li	a1,1
ffffffffc0202492:	739c                	ld	a5,32(a5)
ffffffffc0202494:	9782                	jalr	a5
ffffffffc0202496:	000a8717          	auipc	a4,0xa8
ffffffffc020249a:	2a270713          	addi	a4,a4,674 # ffffffffc02aa738 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc020249e:	00043023          	sd	zero,0(s0)
    } while (d1start != 0 && d1start < end);
ffffffffc02024a2:	ee0990e3          	bnez	s3,ffffffffc0202382 <exit_range+0x90>
}
ffffffffc02024a6:	70e6                	ld	ra,120(sp)
ffffffffc02024a8:	7446                	ld	s0,112(sp)
ffffffffc02024aa:	74a6                	ld	s1,104(sp)
ffffffffc02024ac:	7906                	ld	s2,96(sp)
ffffffffc02024ae:	69e6                	ld	s3,88(sp)
ffffffffc02024b0:	6a46                	ld	s4,80(sp)
ffffffffc02024b2:	6aa6                	ld	s5,72(sp)
ffffffffc02024b4:	6b06                	ld	s6,64(sp)
ffffffffc02024b6:	7be2                	ld	s7,56(sp)
ffffffffc02024b8:	7c42                	ld	s8,48(sp)
ffffffffc02024ba:	7ca2                	ld	s9,40(sp)
ffffffffc02024bc:	7d02                	ld	s10,32(sp)
ffffffffc02024be:	6de2                	ld	s11,24(sp)
ffffffffc02024c0:	6109                	addi	sp,sp,128
ffffffffc02024c2:	8082                	ret
            if (free_pd0)
ffffffffc02024c4:	ea0b8fe3          	beqz	s7,ffffffffc0202382 <exit_range+0x90>
ffffffffc02024c8:	bf45                	j	ffffffffc0202478 <exit_range+0x186>
ffffffffc02024ca:	e032                	sd	a2,0(sp)
        intr_disable();
ffffffffc02024cc:	e42a                	sd	a0,8(sp)
ffffffffc02024ce:	ce6fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc02024d2:	000db783          	ld	a5,0(s11)
ffffffffc02024d6:	6522                	ld	a0,8(sp)
ffffffffc02024d8:	4585                	li	a1,1
ffffffffc02024da:	739c                	ld	a5,32(a5)
ffffffffc02024dc:	9782                	jalr	a5
        intr_enable();
ffffffffc02024de:	cd0fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02024e2:	6602                	ld	a2,0(sp)
ffffffffc02024e4:	000a8717          	auipc	a4,0xa8
ffffffffc02024e8:	25470713          	addi	a4,a4,596 # ffffffffc02aa738 <pages>
ffffffffc02024ec:	6885                	lui	a7,0x1
ffffffffc02024ee:	00080337          	lui	t1,0x80
ffffffffc02024f2:	fff80e37          	lui	t3,0xfff80
ffffffffc02024f6:	000a8817          	auipc	a6,0xa8
ffffffffc02024fa:	25280813          	addi	a6,a6,594 # ffffffffc02aa748 <va_pa_offset>
                        pd0[PDX0(d0start)] = 0;
ffffffffc02024fe:	0004b023          	sd	zero,0(s1)
ffffffffc0202502:	b7a5                	j	ffffffffc020246a <exit_range+0x178>
ffffffffc0202504:	e02a                	sd	a0,0(sp)
        intr_disable();
ffffffffc0202506:	caefe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc020250a:	000db783          	ld	a5,0(s11)
ffffffffc020250e:	6502                	ld	a0,0(sp)
ffffffffc0202510:	4585                	li	a1,1
ffffffffc0202512:	739c                	ld	a5,32(a5)
ffffffffc0202514:	9782                	jalr	a5
        intr_enable();
ffffffffc0202516:	c98fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020251a:	000a8717          	auipc	a4,0xa8
ffffffffc020251e:	21e70713          	addi	a4,a4,542 # ffffffffc02aa738 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc0202522:	00043023          	sd	zero,0(s0)
ffffffffc0202526:	bfb5                	j	ffffffffc02024a2 <exit_range+0x1b0>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202528:	00004697          	auipc	a3,0x4
ffffffffc020252c:	11068693          	addi	a3,a3,272 # ffffffffc0206638 <default_pmm_manager+0x160>
ffffffffc0202530:	00004617          	auipc	a2,0x4
ffffffffc0202534:	bf860613          	addi	a2,a2,-1032 # ffffffffc0206128 <commands+0x818>
ffffffffc0202538:	13500593          	li	a1,309
ffffffffc020253c:	00004517          	auipc	a0,0x4
ffffffffc0202540:	0ec50513          	addi	a0,a0,236 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202544:	f4bfd0ef          	jal	ra,ffffffffc020048e <__panic>
    return KADDR(page2pa(page));
ffffffffc0202548:	00004617          	auipc	a2,0x4
ffffffffc020254c:	fc860613          	addi	a2,a2,-56 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc0202550:	07100593          	li	a1,113
ffffffffc0202554:	00004517          	auipc	a0,0x4
ffffffffc0202558:	fe450513          	addi	a0,a0,-28 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc020255c:	f33fd0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0202560:	8e1ff0ef          	jal	ra,ffffffffc0201e40 <pa2page.part.0>
    assert(USER_ACCESS(start, end));
ffffffffc0202564:	00004697          	auipc	a3,0x4
ffffffffc0202568:	10468693          	addi	a3,a3,260 # ffffffffc0206668 <default_pmm_manager+0x190>
ffffffffc020256c:	00004617          	auipc	a2,0x4
ffffffffc0202570:	bbc60613          	addi	a2,a2,-1092 # ffffffffc0206128 <commands+0x818>
ffffffffc0202574:	13600593          	li	a1,310
ffffffffc0202578:	00004517          	auipc	a0,0x4
ffffffffc020257c:	0b050513          	addi	a0,a0,176 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202580:	f0ffd0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0202584 <page_remove>:
{
ffffffffc0202584:	7179                	addi	sp,sp,-48
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc0202586:	4601                	li	a2,0
{
ffffffffc0202588:	ec26                	sd	s1,24(sp)
ffffffffc020258a:	f406                	sd	ra,40(sp)
ffffffffc020258c:	f022                	sd	s0,32(sp)
ffffffffc020258e:	84ae                	mv	s1,a1
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc0202590:	9a1ff0ef          	jal	ra,ffffffffc0201f30 <get_pte>
    if (ptep != NULL)
ffffffffc0202594:	c511                	beqz	a0,ffffffffc02025a0 <page_remove+0x1c>
    if (*ptep & PTE_V)
ffffffffc0202596:	611c                	ld	a5,0(a0)
ffffffffc0202598:	842a                	mv	s0,a0
ffffffffc020259a:	0017f713          	andi	a4,a5,1
ffffffffc020259e:	e711                	bnez	a4,ffffffffc02025aa <page_remove+0x26>
}
ffffffffc02025a0:	70a2                	ld	ra,40(sp)
ffffffffc02025a2:	7402                	ld	s0,32(sp)
ffffffffc02025a4:	64e2                	ld	s1,24(sp)
ffffffffc02025a6:	6145                	addi	sp,sp,48
ffffffffc02025a8:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02025aa:	078a                	slli	a5,a5,0x2
ffffffffc02025ac:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02025ae:	000a8717          	auipc	a4,0xa8
ffffffffc02025b2:	18273703          	ld	a4,386(a4) # ffffffffc02aa730 <npage>
ffffffffc02025b6:	06e7f363          	bgeu	a5,a4,ffffffffc020261c <page_remove+0x98>
    return &pages[PPN(pa) - nbase];
ffffffffc02025ba:	fff80537          	lui	a0,0xfff80
ffffffffc02025be:	97aa                	add	a5,a5,a0
ffffffffc02025c0:	079a                	slli	a5,a5,0x6
ffffffffc02025c2:	000a8517          	auipc	a0,0xa8
ffffffffc02025c6:	17653503          	ld	a0,374(a0) # ffffffffc02aa738 <pages>
ffffffffc02025ca:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc02025cc:	411c                	lw	a5,0(a0)
ffffffffc02025ce:	fff7871b          	addiw	a4,a5,-1
ffffffffc02025d2:	c118                	sw	a4,0(a0)
        if (page_ref(page) == 0)
ffffffffc02025d4:	cb11                	beqz	a4,ffffffffc02025e8 <page_remove+0x64>
        *ptep = 0;
ffffffffc02025d6:	00043023          	sd	zero,0(s0)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02025da:	12048073          	sfence.vma	s1
}
ffffffffc02025de:	70a2                	ld	ra,40(sp)
ffffffffc02025e0:	7402                	ld	s0,32(sp)
ffffffffc02025e2:	64e2                	ld	s1,24(sp)
ffffffffc02025e4:	6145                	addi	sp,sp,48
ffffffffc02025e6:	8082                	ret
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02025e8:	100027f3          	csrr	a5,sstatus
ffffffffc02025ec:	8b89                	andi	a5,a5,2
ffffffffc02025ee:	eb89                	bnez	a5,ffffffffc0202600 <page_remove+0x7c>
        pmm_manager->free_pages(base, n);
ffffffffc02025f0:	000a8797          	auipc	a5,0xa8
ffffffffc02025f4:	1507b783          	ld	a5,336(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc02025f8:	739c                	ld	a5,32(a5)
ffffffffc02025fa:	4585                	li	a1,1
ffffffffc02025fc:	9782                	jalr	a5
    if (flag)
ffffffffc02025fe:	bfe1                	j	ffffffffc02025d6 <page_remove+0x52>
        intr_disable();
ffffffffc0202600:	e42a                	sd	a0,8(sp)
ffffffffc0202602:	bb2fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202606:	000a8797          	auipc	a5,0xa8
ffffffffc020260a:	13a7b783          	ld	a5,314(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc020260e:	739c                	ld	a5,32(a5)
ffffffffc0202610:	6522                	ld	a0,8(sp)
ffffffffc0202612:	4585                	li	a1,1
ffffffffc0202614:	9782                	jalr	a5
        intr_enable();
ffffffffc0202616:	b98fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020261a:	bf75                	j	ffffffffc02025d6 <page_remove+0x52>
ffffffffc020261c:	825ff0ef          	jal	ra,ffffffffc0201e40 <pa2page.part.0>

ffffffffc0202620 <page_insert>:
{
ffffffffc0202620:	7139                	addi	sp,sp,-64
ffffffffc0202622:	e852                	sd	s4,16(sp)
ffffffffc0202624:	8a32                	mv	s4,a2
ffffffffc0202626:	f822                	sd	s0,48(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202628:	4605                	li	a2,1
{
ffffffffc020262a:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc020262c:	85d2                	mv	a1,s4
{
ffffffffc020262e:	f426                	sd	s1,40(sp)
ffffffffc0202630:	fc06                	sd	ra,56(sp)
ffffffffc0202632:	f04a                	sd	s2,32(sp)
ffffffffc0202634:	ec4e                	sd	s3,24(sp)
ffffffffc0202636:	e456                	sd	s5,8(sp)
ffffffffc0202638:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc020263a:	8f7ff0ef          	jal	ra,ffffffffc0201f30 <get_pte>
    if (ptep == NULL)
ffffffffc020263e:	c961                	beqz	a0,ffffffffc020270e <page_insert+0xee>
    page->ref += 1;
ffffffffc0202640:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V)
ffffffffc0202642:	611c                	ld	a5,0(a0)
ffffffffc0202644:	89aa                	mv	s3,a0
ffffffffc0202646:	0016871b          	addiw	a4,a3,1
ffffffffc020264a:	c018                	sw	a4,0(s0)
ffffffffc020264c:	0017f713          	andi	a4,a5,1
ffffffffc0202650:	ef05                	bnez	a4,ffffffffc0202688 <page_insert+0x68>
    return page - pages + nbase;
ffffffffc0202652:	000a8717          	auipc	a4,0xa8
ffffffffc0202656:	0e673703          	ld	a4,230(a4) # ffffffffc02aa738 <pages>
ffffffffc020265a:	8c19                	sub	s0,s0,a4
ffffffffc020265c:	000807b7          	lui	a5,0x80
ffffffffc0202660:	8419                	srai	s0,s0,0x6
ffffffffc0202662:	943e                	add	s0,s0,a5
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0202664:	042a                	slli	s0,s0,0xa
ffffffffc0202666:	8cc1                	or	s1,s1,s0
ffffffffc0202668:	0014e493          	ori	s1,s1,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc020266c:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_obj___user_exit_out_size+0xffffffffbfff4ee0>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202670:	120a0073          	sfence.vma	s4
    return 0;
ffffffffc0202674:	4501                	li	a0,0
}
ffffffffc0202676:	70e2                	ld	ra,56(sp)
ffffffffc0202678:	7442                	ld	s0,48(sp)
ffffffffc020267a:	74a2                	ld	s1,40(sp)
ffffffffc020267c:	7902                	ld	s2,32(sp)
ffffffffc020267e:	69e2                	ld	s3,24(sp)
ffffffffc0202680:	6a42                	ld	s4,16(sp)
ffffffffc0202682:	6aa2                	ld	s5,8(sp)
ffffffffc0202684:	6121                	addi	sp,sp,64
ffffffffc0202686:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc0202688:	078a                	slli	a5,a5,0x2
ffffffffc020268a:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020268c:	000a8717          	auipc	a4,0xa8
ffffffffc0202690:	0a473703          	ld	a4,164(a4) # ffffffffc02aa730 <npage>
ffffffffc0202694:	06e7ff63          	bgeu	a5,a4,ffffffffc0202712 <page_insert+0xf2>
    return &pages[PPN(pa) - nbase];
ffffffffc0202698:	000a8a97          	auipc	s5,0xa8
ffffffffc020269c:	0a0a8a93          	addi	s5,s5,160 # ffffffffc02aa738 <pages>
ffffffffc02026a0:	000ab703          	ld	a4,0(s5)
ffffffffc02026a4:	fff80937          	lui	s2,0xfff80
ffffffffc02026a8:	993e                	add	s2,s2,a5
ffffffffc02026aa:	091a                	slli	s2,s2,0x6
ffffffffc02026ac:	993a                	add	s2,s2,a4
        if (p == page)
ffffffffc02026ae:	01240c63          	beq	s0,s2,ffffffffc02026c6 <page_insert+0xa6>
    page->ref -= 1;
ffffffffc02026b2:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fcd5894>
ffffffffc02026b6:	fff7869b          	addiw	a3,a5,-1
ffffffffc02026ba:	00d92023          	sw	a3,0(s2)
        if (page_ref(page) == 0)
ffffffffc02026be:	c691                	beqz	a3,ffffffffc02026ca <page_insert+0xaa>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02026c0:	120a0073          	sfence.vma	s4
}
ffffffffc02026c4:	bf59                	j	ffffffffc020265a <page_insert+0x3a>
ffffffffc02026c6:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc02026c8:	bf49                	j	ffffffffc020265a <page_insert+0x3a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02026ca:	100027f3          	csrr	a5,sstatus
ffffffffc02026ce:	8b89                	andi	a5,a5,2
ffffffffc02026d0:	ef91                	bnez	a5,ffffffffc02026ec <page_insert+0xcc>
        pmm_manager->free_pages(base, n);
ffffffffc02026d2:	000a8797          	auipc	a5,0xa8
ffffffffc02026d6:	06e7b783          	ld	a5,110(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc02026da:	739c                	ld	a5,32(a5)
ffffffffc02026dc:	4585                	li	a1,1
ffffffffc02026de:	854a                	mv	a0,s2
ffffffffc02026e0:	9782                	jalr	a5
    return page - pages + nbase;
ffffffffc02026e2:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02026e6:	120a0073          	sfence.vma	s4
ffffffffc02026ea:	bf85                	j	ffffffffc020265a <page_insert+0x3a>
        intr_disable();
ffffffffc02026ec:	ac8fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc02026f0:	000a8797          	auipc	a5,0xa8
ffffffffc02026f4:	0507b783          	ld	a5,80(a5) # ffffffffc02aa740 <pmm_manager>
ffffffffc02026f8:	739c                	ld	a5,32(a5)
ffffffffc02026fa:	4585                	li	a1,1
ffffffffc02026fc:	854a                	mv	a0,s2
ffffffffc02026fe:	9782                	jalr	a5
        intr_enable();
ffffffffc0202700:	aaefe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202704:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202708:	120a0073          	sfence.vma	s4
ffffffffc020270c:	b7b9                	j	ffffffffc020265a <page_insert+0x3a>
        return -E_NO_MEM;
ffffffffc020270e:	5571                	li	a0,-4
ffffffffc0202710:	b79d                	j	ffffffffc0202676 <page_insert+0x56>
ffffffffc0202712:	f2eff0ef          	jal	ra,ffffffffc0201e40 <pa2page.part.0>

ffffffffc0202716 <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc0202716:	00004797          	auipc	a5,0x4
ffffffffc020271a:	dc278793          	addi	a5,a5,-574 # ffffffffc02064d8 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020271e:	638c                	ld	a1,0(a5)
{
ffffffffc0202720:	7159                	addi	sp,sp,-112
ffffffffc0202722:	f85a                	sd	s6,48(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202724:	00004517          	auipc	a0,0x4
ffffffffc0202728:	f5c50513          	addi	a0,a0,-164 # ffffffffc0206680 <default_pmm_manager+0x1a8>
    pmm_manager = &default_pmm_manager;
ffffffffc020272c:	000a8b17          	auipc	s6,0xa8
ffffffffc0202730:	014b0b13          	addi	s6,s6,20 # ffffffffc02aa740 <pmm_manager>
{
ffffffffc0202734:	f486                	sd	ra,104(sp)
ffffffffc0202736:	e8ca                	sd	s2,80(sp)
ffffffffc0202738:	e4ce                	sd	s3,72(sp)
ffffffffc020273a:	f0a2                	sd	s0,96(sp)
ffffffffc020273c:	eca6                	sd	s1,88(sp)
ffffffffc020273e:	e0d2                	sd	s4,64(sp)
ffffffffc0202740:	fc56                	sd	s5,56(sp)
ffffffffc0202742:	f45e                	sd	s7,40(sp)
ffffffffc0202744:	f062                	sd	s8,32(sp)
ffffffffc0202746:	ec66                	sd	s9,24(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0202748:	00fb3023          	sd	a5,0(s6)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020274c:	a49fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    pmm_manager->init();
ffffffffc0202750:	000b3783          	ld	a5,0(s6)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0202754:	000a8997          	auipc	s3,0xa8
ffffffffc0202758:	ff498993          	addi	s3,s3,-12 # ffffffffc02aa748 <va_pa_offset>
    pmm_manager->init();
ffffffffc020275c:	679c                	ld	a5,8(a5)
ffffffffc020275e:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0202760:	57f5                	li	a5,-3
ffffffffc0202762:	07fa                	slli	a5,a5,0x1e
ffffffffc0202764:	00f9b023          	sd	a5,0(s3)
    uint64_t mem_begin = get_memory_base();
ffffffffc0202768:	a32fe0ef          	jal	ra,ffffffffc020099a <get_memory_base>
ffffffffc020276c:	892a                	mv	s2,a0
    uint64_t mem_size = get_memory_size();
ffffffffc020276e:	a36fe0ef          	jal	ra,ffffffffc02009a4 <get_memory_size>
    if (mem_size == 0)
ffffffffc0202772:	200505e3          	beqz	a0,ffffffffc020317c <pmm_init+0xa66>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc0202776:	84aa                	mv	s1,a0
    cprintf("physcial memory map:\n");
ffffffffc0202778:	00004517          	auipc	a0,0x4
ffffffffc020277c:	f4050513          	addi	a0,a0,-192 # ffffffffc02066b8 <default_pmm_manager+0x1e0>
ffffffffc0202780:	a15fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc0202784:	00990433          	add	s0,s2,s1
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc0202788:	fff40693          	addi	a3,s0,-1
ffffffffc020278c:	864a                	mv	a2,s2
ffffffffc020278e:	85a6                	mv	a1,s1
ffffffffc0202790:	00004517          	auipc	a0,0x4
ffffffffc0202794:	f4050513          	addi	a0,a0,-192 # ffffffffc02066d0 <default_pmm_manager+0x1f8>
ffffffffc0202798:	9fdfd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc020279c:	c8000737          	lui	a4,0xc8000
ffffffffc02027a0:	87a2                	mv	a5,s0
ffffffffc02027a2:	54876163          	bltu	a4,s0,ffffffffc0202ce4 <pmm_init+0x5ce>
ffffffffc02027a6:	757d                	lui	a0,0xfffff
ffffffffc02027a8:	000a9617          	auipc	a2,0xa9
ffffffffc02027ac:	fc360613          	addi	a2,a2,-61 # ffffffffc02ab76b <end+0xfff>
ffffffffc02027b0:	8e69                	and	a2,a2,a0
ffffffffc02027b2:	000a8497          	auipc	s1,0xa8
ffffffffc02027b6:	f7e48493          	addi	s1,s1,-130 # ffffffffc02aa730 <npage>
ffffffffc02027ba:	00c7d513          	srli	a0,a5,0xc
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02027be:	000a8b97          	auipc	s7,0xa8
ffffffffc02027c2:	f7ab8b93          	addi	s7,s7,-134 # ffffffffc02aa738 <pages>
    npage = maxpa / PGSIZE;
ffffffffc02027c6:	e088                	sd	a0,0(s1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02027c8:	00cbb023          	sd	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02027cc:	000807b7          	lui	a5,0x80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02027d0:	86b2                	mv	a3,a2
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02027d2:	02f50863          	beq	a0,a5,ffffffffc0202802 <pmm_init+0xec>
ffffffffc02027d6:	4781                	li	a5,0
ffffffffc02027d8:	4585                	li	a1,1
ffffffffc02027da:	fff806b7          	lui	a3,0xfff80
        SetPageReserved(pages + i);
ffffffffc02027de:	00679513          	slli	a0,a5,0x6
ffffffffc02027e2:	9532                	add	a0,a0,a2
ffffffffc02027e4:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd5489c>
ffffffffc02027e8:	40b7302f          	amoor.d	zero,a1,(a4)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02027ec:	6088                	ld	a0,0(s1)
ffffffffc02027ee:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc02027f0:	000bb603          	ld	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02027f4:	00d50733          	add	a4,a0,a3
ffffffffc02027f8:	fee7e3e3          	bltu	a5,a4,ffffffffc02027de <pmm_init+0xc8>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02027fc:	071a                	slli	a4,a4,0x6
ffffffffc02027fe:	00e606b3          	add	a3,a2,a4
ffffffffc0202802:	c02007b7          	lui	a5,0xc0200
ffffffffc0202806:	2ef6ece3          	bltu	a3,a5,ffffffffc02032fe <pmm_init+0xbe8>
ffffffffc020280a:	0009b583          	ld	a1,0(s3)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc020280e:	77fd                	lui	a5,0xfffff
ffffffffc0202810:	8c7d                	and	s0,s0,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202812:	8e8d                	sub	a3,a3,a1
    if (freemem < mem_end)
ffffffffc0202814:	5086eb63          	bltu	a3,s0,ffffffffc0202d2a <pmm_init+0x614>
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202818:	00004517          	auipc	a0,0x4
ffffffffc020281c:	ee050513          	addi	a0,a0,-288 # ffffffffc02066f8 <default_pmm_manager+0x220>
ffffffffc0202820:	975fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return page;
}

static void check_alloc_page(void)
{
    pmm_manager->check();
ffffffffc0202824:	000b3783          	ld	a5,0(s6)
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202828:	000a8917          	auipc	s2,0xa8
ffffffffc020282c:	f0090913          	addi	s2,s2,-256 # ffffffffc02aa728 <boot_pgdir_va>
    pmm_manager->check();
ffffffffc0202830:	7b9c                	ld	a5,48(a5)
ffffffffc0202832:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0202834:	00004517          	auipc	a0,0x4
ffffffffc0202838:	edc50513          	addi	a0,a0,-292 # ffffffffc0206710 <default_pmm_manager+0x238>
ffffffffc020283c:	959fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202840:	00007697          	auipc	a3,0x7
ffffffffc0202844:	7c068693          	addi	a3,a3,1984 # ffffffffc020a000 <boot_page_table_sv39>
ffffffffc0202848:	00d93023          	sd	a3,0(s2)
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc020284c:	c02007b7          	lui	a5,0xc0200
ffffffffc0202850:	28f6ebe3          	bltu	a3,a5,ffffffffc02032e6 <pmm_init+0xbd0>
ffffffffc0202854:	0009b783          	ld	a5,0(s3)
ffffffffc0202858:	8e9d                	sub	a3,a3,a5
ffffffffc020285a:	000a8797          	auipc	a5,0xa8
ffffffffc020285e:	ecd7b323          	sd	a3,-314(a5) # ffffffffc02aa720 <boot_pgdir_pa>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202862:	100027f3          	csrr	a5,sstatus
ffffffffc0202866:	8b89                	andi	a5,a5,2
ffffffffc0202868:	4a079763          	bnez	a5,ffffffffc0202d16 <pmm_init+0x600>
        ret = pmm_manager->nr_free_pages();
ffffffffc020286c:	000b3783          	ld	a5,0(s6)
ffffffffc0202870:	779c                	ld	a5,40(a5)
ffffffffc0202872:	9782                	jalr	a5
ffffffffc0202874:	842a                	mv	s0,a0
    // so npage is always larger than KMEMSIZE / PGSIZE
    size_t nr_free_store;

    nr_free_store = nr_free_pages();

    assert(npage <= KERNTOP / PGSIZE);
ffffffffc0202876:	6098                	ld	a4,0(s1)
ffffffffc0202878:	c80007b7          	lui	a5,0xc8000
ffffffffc020287c:	83b1                	srli	a5,a5,0xc
ffffffffc020287e:	66e7e363          	bltu	a5,a4,ffffffffc0202ee4 <pmm_init+0x7ce>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc0202882:	00093503          	ld	a0,0(s2)
ffffffffc0202886:	62050f63          	beqz	a0,ffffffffc0202ec4 <pmm_init+0x7ae>
ffffffffc020288a:	03451793          	slli	a5,a0,0x34
ffffffffc020288e:	62079b63          	bnez	a5,ffffffffc0202ec4 <pmm_init+0x7ae>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc0202892:	4601                	li	a2,0
ffffffffc0202894:	4581                	li	a1,0
ffffffffc0202896:	8c3ff0ef          	jal	ra,ffffffffc0202158 <get_page>
ffffffffc020289a:	60051563          	bnez	a0,ffffffffc0202ea4 <pmm_init+0x78e>
ffffffffc020289e:	100027f3          	csrr	a5,sstatus
ffffffffc02028a2:	8b89                	andi	a5,a5,2
ffffffffc02028a4:	44079e63          	bnez	a5,ffffffffc0202d00 <pmm_init+0x5ea>
        page = pmm_manager->alloc_pages(n);
ffffffffc02028a8:	000b3783          	ld	a5,0(s6)
ffffffffc02028ac:	4505                	li	a0,1
ffffffffc02028ae:	6f9c                	ld	a5,24(a5)
ffffffffc02028b0:	9782                	jalr	a5
ffffffffc02028b2:	8a2a                	mv	s4,a0

    struct Page *p1, *p2;
    p1 = alloc_page();
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc02028b4:	00093503          	ld	a0,0(s2)
ffffffffc02028b8:	4681                	li	a3,0
ffffffffc02028ba:	4601                	li	a2,0
ffffffffc02028bc:	85d2                	mv	a1,s4
ffffffffc02028be:	d63ff0ef          	jal	ra,ffffffffc0202620 <page_insert>
ffffffffc02028c2:	26051ae3          	bnez	a0,ffffffffc0203336 <pmm_init+0xc20>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc02028c6:	00093503          	ld	a0,0(s2)
ffffffffc02028ca:	4601                	li	a2,0
ffffffffc02028cc:	4581                	li	a1,0
ffffffffc02028ce:	e62ff0ef          	jal	ra,ffffffffc0201f30 <get_pte>
ffffffffc02028d2:	240502e3          	beqz	a0,ffffffffc0203316 <pmm_init+0xc00>
    assert(pte2page(*ptep) == p1);
ffffffffc02028d6:	611c                	ld	a5,0(a0)
    if (!(pte & PTE_V))
ffffffffc02028d8:	0017f713          	andi	a4,a5,1
ffffffffc02028dc:	5a070263          	beqz	a4,ffffffffc0202e80 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc02028e0:	6098                	ld	a4,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc02028e2:	078a                	slli	a5,a5,0x2
ffffffffc02028e4:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02028e6:	58e7fb63          	bgeu	a5,a4,ffffffffc0202e7c <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02028ea:	000bb683          	ld	a3,0(s7)
ffffffffc02028ee:	fff80637          	lui	a2,0xfff80
ffffffffc02028f2:	97b2                	add	a5,a5,a2
ffffffffc02028f4:	079a                	slli	a5,a5,0x6
ffffffffc02028f6:	97b6                	add	a5,a5,a3
ffffffffc02028f8:	14fa17e3          	bne	s4,a5,ffffffffc0203246 <pmm_init+0xb30>
    assert(page_ref(p1) == 1);
ffffffffc02028fc:	000a2683          	lw	a3,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8bb0>
ffffffffc0202900:	4785                	li	a5,1
ffffffffc0202902:	12f692e3          	bne	a3,a5,ffffffffc0203226 <pmm_init+0xb10>

    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc0202906:	00093503          	ld	a0,0(s2)
ffffffffc020290a:	77fd                	lui	a5,0xfffff
ffffffffc020290c:	6114                	ld	a3,0(a0)
ffffffffc020290e:	068a                	slli	a3,a3,0x2
ffffffffc0202910:	8efd                	and	a3,a3,a5
ffffffffc0202912:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202916:	0ee67ce3          	bgeu	a2,a4,ffffffffc020320e <pmm_init+0xaf8>
ffffffffc020291a:	0009bc03          	ld	s8,0(s3)
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc020291e:	96e2                	add	a3,a3,s8
ffffffffc0202920:	0006ba83          	ld	s5,0(a3)
ffffffffc0202924:	0a8a                	slli	s5,s5,0x2
ffffffffc0202926:	00fafab3          	and	s5,s5,a5
ffffffffc020292a:	00cad793          	srli	a5,s5,0xc
ffffffffc020292e:	0ce7f3e3          	bgeu	a5,a4,ffffffffc02031f4 <pmm_init+0xade>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202932:	4601                	li	a2,0
ffffffffc0202934:	6585                	lui	a1,0x1
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202936:	9ae2                	add	s5,s5,s8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202938:	df8ff0ef          	jal	ra,ffffffffc0201f30 <get_pte>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc020293c:	0aa1                	addi	s5,s5,8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc020293e:	55551363          	bne	a0,s5,ffffffffc0202e84 <pmm_init+0x76e>
ffffffffc0202942:	100027f3          	csrr	a5,sstatus
ffffffffc0202946:	8b89                	andi	a5,a5,2
ffffffffc0202948:	3a079163          	bnez	a5,ffffffffc0202cea <pmm_init+0x5d4>
        page = pmm_manager->alloc_pages(n);
ffffffffc020294c:	000b3783          	ld	a5,0(s6)
ffffffffc0202950:	4505                	li	a0,1
ffffffffc0202952:	6f9c                	ld	a5,24(a5)
ffffffffc0202954:	9782                	jalr	a5
ffffffffc0202956:	8c2a                	mv	s8,a0

    p2 = alloc_page();
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc0202958:	00093503          	ld	a0,0(s2)
ffffffffc020295c:	46d1                	li	a3,20
ffffffffc020295e:	6605                	lui	a2,0x1
ffffffffc0202960:	85e2                	mv	a1,s8
ffffffffc0202962:	cbfff0ef          	jal	ra,ffffffffc0202620 <page_insert>
ffffffffc0202966:	060517e3          	bnez	a0,ffffffffc02031d4 <pmm_init+0xabe>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc020296a:	00093503          	ld	a0,0(s2)
ffffffffc020296e:	4601                	li	a2,0
ffffffffc0202970:	6585                	lui	a1,0x1
ffffffffc0202972:	dbeff0ef          	jal	ra,ffffffffc0201f30 <get_pte>
ffffffffc0202976:	02050fe3          	beqz	a0,ffffffffc02031b4 <pmm_init+0xa9e>
    assert(*ptep & PTE_U);
ffffffffc020297a:	611c                	ld	a5,0(a0)
ffffffffc020297c:	0107f713          	andi	a4,a5,16
ffffffffc0202980:	7c070e63          	beqz	a4,ffffffffc020315c <pmm_init+0xa46>
    assert(*ptep & PTE_W);
ffffffffc0202984:	8b91                	andi	a5,a5,4
ffffffffc0202986:	7a078b63          	beqz	a5,ffffffffc020313c <pmm_init+0xa26>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc020298a:	00093503          	ld	a0,0(s2)
ffffffffc020298e:	611c                	ld	a5,0(a0)
ffffffffc0202990:	8bc1                	andi	a5,a5,16
ffffffffc0202992:	78078563          	beqz	a5,ffffffffc020311c <pmm_init+0xa06>
    assert(page_ref(p2) == 1);
ffffffffc0202996:	000c2703          	lw	a4,0(s8)
ffffffffc020299a:	4785                	li	a5,1
ffffffffc020299c:	76f71063          	bne	a4,a5,ffffffffc02030fc <pmm_init+0x9e6>

    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc02029a0:	4681                	li	a3,0
ffffffffc02029a2:	6605                	lui	a2,0x1
ffffffffc02029a4:	85d2                	mv	a1,s4
ffffffffc02029a6:	c7bff0ef          	jal	ra,ffffffffc0202620 <page_insert>
ffffffffc02029aa:	72051963          	bnez	a0,ffffffffc02030dc <pmm_init+0x9c6>
    assert(page_ref(p1) == 2);
ffffffffc02029ae:	000a2703          	lw	a4,0(s4)
ffffffffc02029b2:	4789                	li	a5,2
ffffffffc02029b4:	70f71463          	bne	a4,a5,ffffffffc02030bc <pmm_init+0x9a6>
    assert(page_ref(p2) == 0);
ffffffffc02029b8:	000c2783          	lw	a5,0(s8)
ffffffffc02029bc:	6e079063          	bnez	a5,ffffffffc020309c <pmm_init+0x986>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02029c0:	00093503          	ld	a0,0(s2)
ffffffffc02029c4:	4601                	li	a2,0
ffffffffc02029c6:	6585                	lui	a1,0x1
ffffffffc02029c8:	d68ff0ef          	jal	ra,ffffffffc0201f30 <get_pte>
ffffffffc02029cc:	6a050863          	beqz	a0,ffffffffc020307c <pmm_init+0x966>
    assert(pte2page(*ptep) == p1);
ffffffffc02029d0:	6118                	ld	a4,0(a0)
    if (!(pte & PTE_V))
ffffffffc02029d2:	00177793          	andi	a5,a4,1
ffffffffc02029d6:	4a078563          	beqz	a5,ffffffffc0202e80 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc02029da:	6094                	ld	a3,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc02029dc:	00271793          	slli	a5,a4,0x2
ffffffffc02029e0:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02029e2:	48d7fd63          	bgeu	a5,a3,ffffffffc0202e7c <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02029e6:	000bb683          	ld	a3,0(s7)
ffffffffc02029ea:	fff80ab7          	lui	s5,0xfff80
ffffffffc02029ee:	97d6                	add	a5,a5,s5
ffffffffc02029f0:	079a                	slli	a5,a5,0x6
ffffffffc02029f2:	97b6                	add	a5,a5,a3
ffffffffc02029f4:	66fa1463          	bne	s4,a5,ffffffffc020305c <pmm_init+0x946>
    assert((*ptep & PTE_U) == 0);
ffffffffc02029f8:	8b41                	andi	a4,a4,16
ffffffffc02029fa:	64071163          	bnez	a4,ffffffffc020303c <pmm_init+0x926>

    page_remove(boot_pgdir_va, 0x0);
ffffffffc02029fe:	00093503          	ld	a0,0(s2)
ffffffffc0202a02:	4581                	li	a1,0
ffffffffc0202a04:	b81ff0ef          	jal	ra,ffffffffc0202584 <page_remove>
    assert(page_ref(p1) == 1);
ffffffffc0202a08:	000a2c83          	lw	s9,0(s4)
ffffffffc0202a0c:	4785                	li	a5,1
ffffffffc0202a0e:	60fc9763          	bne	s9,a5,ffffffffc020301c <pmm_init+0x906>
    assert(page_ref(p2) == 0);
ffffffffc0202a12:	000c2783          	lw	a5,0(s8)
ffffffffc0202a16:	5e079363          	bnez	a5,ffffffffc0202ffc <pmm_init+0x8e6>

    page_remove(boot_pgdir_va, PGSIZE);
ffffffffc0202a1a:	00093503          	ld	a0,0(s2)
ffffffffc0202a1e:	6585                	lui	a1,0x1
ffffffffc0202a20:	b65ff0ef          	jal	ra,ffffffffc0202584 <page_remove>
    assert(page_ref(p1) == 0);
ffffffffc0202a24:	000a2783          	lw	a5,0(s4)
ffffffffc0202a28:	52079a63          	bnez	a5,ffffffffc0202f5c <pmm_init+0x846>
    assert(page_ref(p2) == 0);
ffffffffc0202a2c:	000c2783          	lw	a5,0(s8)
ffffffffc0202a30:	50079663          	bnez	a5,ffffffffc0202f3c <pmm_init+0x826>

    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202a34:	00093a03          	ld	s4,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202a38:	608c                	ld	a1,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202a3a:	000a3683          	ld	a3,0(s4)
ffffffffc0202a3e:	068a                	slli	a3,a3,0x2
ffffffffc0202a40:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202a42:	42b6fd63          	bgeu	a3,a1,ffffffffc0202e7c <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202a46:	000bb503          	ld	a0,0(s7)
ffffffffc0202a4a:	96d6                	add	a3,a3,s5
ffffffffc0202a4c:	069a                	slli	a3,a3,0x6
    return page->ref;
ffffffffc0202a4e:	00d507b3          	add	a5,a0,a3
ffffffffc0202a52:	439c                	lw	a5,0(a5)
ffffffffc0202a54:	4d979463          	bne	a5,s9,ffffffffc0202f1c <pmm_init+0x806>
    return page - pages + nbase;
ffffffffc0202a58:	8699                	srai	a3,a3,0x6
ffffffffc0202a5a:	00080637          	lui	a2,0x80
ffffffffc0202a5e:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc0202a60:	00c69713          	slli	a4,a3,0xc
ffffffffc0202a64:	8331                	srli	a4,a4,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0202a66:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202a68:	48b77e63          	bgeu	a4,a1,ffffffffc0202f04 <pmm_init+0x7ee>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
    free_page(pde2page(pd0[0]));
ffffffffc0202a6c:	0009b703          	ld	a4,0(s3)
ffffffffc0202a70:	96ba                	add	a3,a3,a4
    return pa2page(PDE_ADDR(pde));
ffffffffc0202a72:	629c                	ld	a5,0(a3)
ffffffffc0202a74:	078a                	slli	a5,a5,0x2
ffffffffc0202a76:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202a78:	40b7f263          	bgeu	a5,a1,ffffffffc0202e7c <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202a7c:	8f91                	sub	a5,a5,a2
ffffffffc0202a7e:	079a                	slli	a5,a5,0x6
ffffffffc0202a80:	953e                	add	a0,a0,a5
ffffffffc0202a82:	100027f3          	csrr	a5,sstatus
ffffffffc0202a86:	8b89                	andi	a5,a5,2
ffffffffc0202a88:	30079963          	bnez	a5,ffffffffc0202d9a <pmm_init+0x684>
        pmm_manager->free_pages(base, n);
ffffffffc0202a8c:	000b3783          	ld	a5,0(s6)
ffffffffc0202a90:	4585                	li	a1,1
ffffffffc0202a92:	739c                	ld	a5,32(a5)
ffffffffc0202a94:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202a96:	000a3783          	ld	a5,0(s4)
    if (PPN(pa) >= npage)
ffffffffc0202a9a:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202a9c:	078a                	slli	a5,a5,0x2
ffffffffc0202a9e:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202aa0:	3ce7fe63          	bgeu	a5,a4,ffffffffc0202e7c <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202aa4:	000bb503          	ld	a0,0(s7)
ffffffffc0202aa8:	fff80737          	lui	a4,0xfff80
ffffffffc0202aac:	97ba                	add	a5,a5,a4
ffffffffc0202aae:	079a                	slli	a5,a5,0x6
ffffffffc0202ab0:	953e                	add	a0,a0,a5
ffffffffc0202ab2:	100027f3          	csrr	a5,sstatus
ffffffffc0202ab6:	8b89                	andi	a5,a5,2
ffffffffc0202ab8:	2c079563          	bnez	a5,ffffffffc0202d82 <pmm_init+0x66c>
ffffffffc0202abc:	000b3783          	ld	a5,0(s6)
ffffffffc0202ac0:	4585                	li	a1,1
ffffffffc0202ac2:	739c                	ld	a5,32(a5)
ffffffffc0202ac4:	9782                	jalr	a5
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202ac6:	00093783          	ld	a5,0(s2)
ffffffffc0202aca:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd54894>
    asm volatile("sfence.vma");
ffffffffc0202ace:	12000073          	sfence.vma
ffffffffc0202ad2:	100027f3          	csrr	a5,sstatus
ffffffffc0202ad6:	8b89                	andi	a5,a5,2
ffffffffc0202ad8:	28079b63          	bnez	a5,ffffffffc0202d6e <pmm_init+0x658>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202adc:	000b3783          	ld	a5,0(s6)
ffffffffc0202ae0:	779c                	ld	a5,40(a5)
ffffffffc0202ae2:	9782                	jalr	a5
ffffffffc0202ae4:	8a2a                	mv	s4,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202ae6:	4b441b63          	bne	s0,s4,ffffffffc0202f9c <pmm_init+0x886>

    cprintf("check_pgdir() succeeded!\n");
ffffffffc0202aea:	00004517          	auipc	a0,0x4
ffffffffc0202aee:	f4e50513          	addi	a0,a0,-178 # ffffffffc0206a38 <default_pmm_manager+0x560>
ffffffffc0202af2:	ea2fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0202af6:	100027f3          	csrr	a5,sstatus
ffffffffc0202afa:	8b89                	andi	a5,a5,2
ffffffffc0202afc:	24079f63          	bnez	a5,ffffffffc0202d5a <pmm_init+0x644>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202b00:	000b3783          	ld	a5,0(s6)
ffffffffc0202b04:	779c                	ld	a5,40(a5)
ffffffffc0202b06:	9782                	jalr	a5
ffffffffc0202b08:	8c2a                	mv	s8,a0
    pte_t *ptep;
    int i;

    nr_free_store = nr_free_pages();

    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b0a:	6098                	ld	a4,0(s1)
ffffffffc0202b0c:	c0200437          	lui	s0,0xc0200
    {
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202b10:	7afd                	lui	s5,0xfffff
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b12:	00c71793          	slli	a5,a4,0xc
ffffffffc0202b16:	6a05                	lui	s4,0x1
ffffffffc0202b18:	02f47c63          	bgeu	s0,a5,ffffffffc0202b50 <pmm_init+0x43a>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202b1c:	00c45793          	srli	a5,s0,0xc
ffffffffc0202b20:	00093503          	ld	a0,0(s2)
ffffffffc0202b24:	2ee7ff63          	bgeu	a5,a4,ffffffffc0202e22 <pmm_init+0x70c>
ffffffffc0202b28:	0009b583          	ld	a1,0(s3)
ffffffffc0202b2c:	4601                	li	a2,0
ffffffffc0202b2e:	95a2                	add	a1,a1,s0
ffffffffc0202b30:	c00ff0ef          	jal	ra,ffffffffc0201f30 <get_pte>
ffffffffc0202b34:	32050463          	beqz	a0,ffffffffc0202e5c <pmm_init+0x746>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202b38:	611c                	ld	a5,0(a0)
ffffffffc0202b3a:	078a                	slli	a5,a5,0x2
ffffffffc0202b3c:	0157f7b3          	and	a5,a5,s5
ffffffffc0202b40:	2e879e63          	bne	a5,s0,ffffffffc0202e3c <pmm_init+0x726>
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b44:	6098                	ld	a4,0(s1)
ffffffffc0202b46:	9452                	add	s0,s0,s4
ffffffffc0202b48:	00c71793          	slli	a5,a4,0xc
ffffffffc0202b4c:	fcf468e3          	bltu	s0,a5,ffffffffc0202b1c <pmm_init+0x406>
    }

    assert(boot_pgdir_va[0] == 0);
ffffffffc0202b50:	00093783          	ld	a5,0(s2)
ffffffffc0202b54:	639c                	ld	a5,0(a5)
ffffffffc0202b56:	42079363          	bnez	a5,ffffffffc0202f7c <pmm_init+0x866>
ffffffffc0202b5a:	100027f3          	csrr	a5,sstatus
ffffffffc0202b5e:	8b89                	andi	a5,a5,2
ffffffffc0202b60:	24079963          	bnez	a5,ffffffffc0202db2 <pmm_init+0x69c>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202b64:	000b3783          	ld	a5,0(s6)
ffffffffc0202b68:	4505                	li	a0,1
ffffffffc0202b6a:	6f9c                	ld	a5,24(a5)
ffffffffc0202b6c:	9782                	jalr	a5
ffffffffc0202b6e:	8a2a                	mv	s4,a0

    struct Page *p;
    p = alloc_page();
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202b70:	00093503          	ld	a0,0(s2)
ffffffffc0202b74:	4699                	li	a3,6
ffffffffc0202b76:	10000613          	li	a2,256
ffffffffc0202b7a:	85d2                	mv	a1,s4
ffffffffc0202b7c:	aa5ff0ef          	jal	ra,ffffffffc0202620 <page_insert>
ffffffffc0202b80:	44051e63          	bnez	a0,ffffffffc0202fdc <pmm_init+0x8c6>
    assert(page_ref(p) == 1);
ffffffffc0202b84:	000a2703          	lw	a4,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8bb0>
ffffffffc0202b88:	4785                	li	a5,1
ffffffffc0202b8a:	42f71963          	bne	a4,a5,ffffffffc0202fbc <pmm_init+0x8a6>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc0202b8e:	00093503          	ld	a0,0(s2)
ffffffffc0202b92:	6405                	lui	s0,0x1
ffffffffc0202b94:	4699                	li	a3,6
ffffffffc0202b96:	10040613          	addi	a2,s0,256 # 1100 <_binary_obj___user_faultread_out_size-0x8ab0>
ffffffffc0202b9a:	85d2                	mv	a1,s4
ffffffffc0202b9c:	a85ff0ef          	jal	ra,ffffffffc0202620 <page_insert>
ffffffffc0202ba0:	72051363          	bnez	a0,ffffffffc02032c6 <pmm_init+0xbb0>
    assert(page_ref(p) == 2);
ffffffffc0202ba4:	000a2703          	lw	a4,0(s4)
ffffffffc0202ba8:	4789                	li	a5,2
ffffffffc0202baa:	6ef71e63          	bne	a4,a5,ffffffffc02032a6 <pmm_init+0xb90>

    const char *str = "ucore: Hello world!!";
    strcpy((void *)0x100, str);
ffffffffc0202bae:	00004597          	auipc	a1,0x4
ffffffffc0202bb2:	fd258593          	addi	a1,a1,-46 # ffffffffc0206b80 <default_pmm_manager+0x6a8>
ffffffffc0202bb6:	10000513          	li	a0,256
ffffffffc0202bba:	253020ef          	jal	ra,ffffffffc020560c <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc0202bbe:	10040593          	addi	a1,s0,256
ffffffffc0202bc2:	10000513          	li	a0,256
ffffffffc0202bc6:	259020ef          	jal	ra,ffffffffc020561e <strcmp>
ffffffffc0202bca:	6a051e63          	bnez	a0,ffffffffc0203286 <pmm_init+0xb70>
    return page - pages + nbase;
ffffffffc0202bce:	000bb683          	ld	a3,0(s7)
ffffffffc0202bd2:	00080737          	lui	a4,0x80
    return KADDR(page2pa(page));
ffffffffc0202bd6:	547d                	li	s0,-1
    return page - pages + nbase;
ffffffffc0202bd8:	40da06b3          	sub	a3,s4,a3
ffffffffc0202bdc:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0202bde:	609c                	ld	a5,0(s1)
    return page - pages + nbase;
ffffffffc0202be0:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0202be2:	8031                	srli	s0,s0,0xc
ffffffffc0202be4:	0086f733          	and	a4,a3,s0
    return page2ppn(page) << PGSHIFT;
ffffffffc0202be8:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202bea:	30f77d63          	bgeu	a4,a5,ffffffffc0202f04 <pmm_init+0x7ee>

    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202bee:	0009b783          	ld	a5,0(s3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202bf2:	10000513          	li	a0,256
    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202bf6:	96be                	add	a3,a3,a5
ffffffffc0202bf8:	10068023          	sb	zero,256(a3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202bfc:	1db020ef          	jal	ra,ffffffffc02055d6 <strlen>
ffffffffc0202c00:	66051363          	bnez	a0,ffffffffc0203266 <pmm_init+0xb50>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
ffffffffc0202c04:	00093a83          	ld	s5,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202c08:	609c                	ld	a5,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c0a:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd54894>
ffffffffc0202c0e:	068a                	slli	a3,a3,0x2
ffffffffc0202c10:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202c12:	26f6f563          	bgeu	a3,a5,ffffffffc0202e7c <pmm_init+0x766>
    return KADDR(page2pa(page));
ffffffffc0202c16:	8c75                	and	s0,s0,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc0202c18:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202c1a:	2ef47563          	bgeu	s0,a5,ffffffffc0202f04 <pmm_init+0x7ee>
ffffffffc0202c1e:	0009b403          	ld	s0,0(s3)
ffffffffc0202c22:	9436                	add	s0,s0,a3
ffffffffc0202c24:	100027f3          	csrr	a5,sstatus
ffffffffc0202c28:	8b89                	andi	a5,a5,2
ffffffffc0202c2a:	1e079163          	bnez	a5,ffffffffc0202e0c <pmm_init+0x6f6>
        pmm_manager->free_pages(base, n);
ffffffffc0202c2e:	000b3783          	ld	a5,0(s6)
ffffffffc0202c32:	4585                	li	a1,1
ffffffffc0202c34:	8552                	mv	a0,s4
ffffffffc0202c36:	739c                	ld	a5,32(a5)
ffffffffc0202c38:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c3a:	601c                	ld	a5,0(s0)
    if (PPN(pa) >= npage)
ffffffffc0202c3c:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c3e:	078a                	slli	a5,a5,0x2
ffffffffc0202c40:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202c42:	22e7fd63          	bgeu	a5,a4,ffffffffc0202e7c <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202c46:	000bb503          	ld	a0,0(s7)
ffffffffc0202c4a:	fff80737          	lui	a4,0xfff80
ffffffffc0202c4e:	97ba                	add	a5,a5,a4
ffffffffc0202c50:	079a                	slli	a5,a5,0x6
ffffffffc0202c52:	953e                	add	a0,a0,a5
ffffffffc0202c54:	100027f3          	csrr	a5,sstatus
ffffffffc0202c58:	8b89                	andi	a5,a5,2
ffffffffc0202c5a:	18079d63          	bnez	a5,ffffffffc0202df4 <pmm_init+0x6de>
ffffffffc0202c5e:	000b3783          	ld	a5,0(s6)
ffffffffc0202c62:	4585                	li	a1,1
ffffffffc0202c64:	739c                	ld	a5,32(a5)
ffffffffc0202c66:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c68:	000ab783          	ld	a5,0(s5)
    if (PPN(pa) >= npage)
ffffffffc0202c6c:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c6e:	078a                	slli	a5,a5,0x2
ffffffffc0202c70:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202c72:	20e7f563          	bgeu	a5,a4,ffffffffc0202e7c <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202c76:	000bb503          	ld	a0,0(s7)
ffffffffc0202c7a:	fff80737          	lui	a4,0xfff80
ffffffffc0202c7e:	97ba                	add	a5,a5,a4
ffffffffc0202c80:	079a                	slli	a5,a5,0x6
ffffffffc0202c82:	953e                	add	a0,a0,a5
ffffffffc0202c84:	100027f3          	csrr	a5,sstatus
ffffffffc0202c88:	8b89                	andi	a5,a5,2
ffffffffc0202c8a:	14079963          	bnez	a5,ffffffffc0202ddc <pmm_init+0x6c6>
ffffffffc0202c8e:	000b3783          	ld	a5,0(s6)
ffffffffc0202c92:	4585                	li	a1,1
ffffffffc0202c94:	739c                	ld	a5,32(a5)
ffffffffc0202c96:	9782                	jalr	a5
    free_page(p);
    free_page(pde2page(pd0[0]));
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202c98:	00093783          	ld	a5,0(s2)
ffffffffc0202c9c:	0007b023          	sd	zero,0(a5)
    asm volatile("sfence.vma");
ffffffffc0202ca0:	12000073          	sfence.vma
ffffffffc0202ca4:	100027f3          	csrr	a5,sstatus
ffffffffc0202ca8:	8b89                	andi	a5,a5,2
ffffffffc0202caa:	10079f63          	bnez	a5,ffffffffc0202dc8 <pmm_init+0x6b2>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202cae:	000b3783          	ld	a5,0(s6)
ffffffffc0202cb2:	779c                	ld	a5,40(a5)
ffffffffc0202cb4:	9782                	jalr	a5
ffffffffc0202cb6:	842a                	mv	s0,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202cb8:	4c8c1e63          	bne	s8,s0,ffffffffc0203194 <pmm_init+0xa7e>

    cprintf("check_boot_pgdir() succeeded!\n");
ffffffffc0202cbc:	00004517          	auipc	a0,0x4
ffffffffc0202cc0:	f3c50513          	addi	a0,a0,-196 # ffffffffc0206bf8 <default_pmm_manager+0x720>
ffffffffc0202cc4:	cd0fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
}
ffffffffc0202cc8:	7406                	ld	s0,96(sp)
ffffffffc0202cca:	70a6                	ld	ra,104(sp)
ffffffffc0202ccc:	64e6                	ld	s1,88(sp)
ffffffffc0202cce:	6946                	ld	s2,80(sp)
ffffffffc0202cd0:	69a6                	ld	s3,72(sp)
ffffffffc0202cd2:	6a06                	ld	s4,64(sp)
ffffffffc0202cd4:	7ae2                	ld	s5,56(sp)
ffffffffc0202cd6:	7b42                	ld	s6,48(sp)
ffffffffc0202cd8:	7ba2                	ld	s7,40(sp)
ffffffffc0202cda:	7c02                	ld	s8,32(sp)
ffffffffc0202cdc:	6ce2                	ld	s9,24(sp)
ffffffffc0202cde:	6165                	addi	sp,sp,112
    kmalloc_init();
ffffffffc0202ce0:	f97fe06f          	j	ffffffffc0201c76 <kmalloc_init>
    npage = maxpa / PGSIZE;
ffffffffc0202ce4:	c80007b7          	lui	a5,0xc8000
ffffffffc0202ce8:	bc7d                	j	ffffffffc02027a6 <pmm_init+0x90>
        intr_disable();
ffffffffc0202cea:	ccbfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202cee:	000b3783          	ld	a5,0(s6)
ffffffffc0202cf2:	4505                	li	a0,1
ffffffffc0202cf4:	6f9c                	ld	a5,24(a5)
ffffffffc0202cf6:	9782                	jalr	a5
ffffffffc0202cf8:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202cfa:	cb5fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202cfe:	b9a9                	j	ffffffffc0202958 <pmm_init+0x242>
        intr_disable();
ffffffffc0202d00:	cb5fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202d04:	000b3783          	ld	a5,0(s6)
ffffffffc0202d08:	4505                	li	a0,1
ffffffffc0202d0a:	6f9c                	ld	a5,24(a5)
ffffffffc0202d0c:	9782                	jalr	a5
ffffffffc0202d0e:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202d10:	c9ffd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d14:	b645                	j	ffffffffc02028b4 <pmm_init+0x19e>
        intr_disable();
ffffffffc0202d16:	c9ffd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202d1a:	000b3783          	ld	a5,0(s6)
ffffffffc0202d1e:	779c                	ld	a5,40(a5)
ffffffffc0202d20:	9782                	jalr	a5
ffffffffc0202d22:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202d24:	c8bfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d28:	b6b9                	j	ffffffffc0202876 <pmm_init+0x160>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0202d2a:	6705                	lui	a4,0x1
ffffffffc0202d2c:	177d                	addi	a4,a4,-1
ffffffffc0202d2e:	96ba                	add	a3,a3,a4
ffffffffc0202d30:	8ff5                	and	a5,a5,a3
    if (PPN(pa) >= npage)
ffffffffc0202d32:	00c7d713          	srli	a4,a5,0xc
ffffffffc0202d36:	14a77363          	bgeu	a4,a0,ffffffffc0202e7c <pmm_init+0x766>
    pmm_manager->init_memmap(base, n);
ffffffffc0202d3a:	000b3683          	ld	a3,0(s6)
    return &pages[PPN(pa) - nbase];
ffffffffc0202d3e:	fff80537          	lui	a0,0xfff80
ffffffffc0202d42:	972a                	add	a4,a4,a0
ffffffffc0202d44:	6a94                	ld	a3,16(a3)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0202d46:	8c1d                	sub	s0,s0,a5
ffffffffc0202d48:	00671513          	slli	a0,a4,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc0202d4c:	00c45593          	srli	a1,s0,0xc
ffffffffc0202d50:	9532                	add	a0,a0,a2
ffffffffc0202d52:	9682                	jalr	a3
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202d54:	0009b583          	ld	a1,0(s3)
}
ffffffffc0202d58:	b4c1                	j	ffffffffc0202818 <pmm_init+0x102>
        intr_disable();
ffffffffc0202d5a:	c5bfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202d5e:	000b3783          	ld	a5,0(s6)
ffffffffc0202d62:	779c                	ld	a5,40(a5)
ffffffffc0202d64:	9782                	jalr	a5
ffffffffc0202d66:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202d68:	c47fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d6c:	bb79                	j	ffffffffc0202b0a <pmm_init+0x3f4>
        intr_disable();
ffffffffc0202d6e:	c47fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202d72:	000b3783          	ld	a5,0(s6)
ffffffffc0202d76:	779c                	ld	a5,40(a5)
ffffffffc0202d78:	9782                	jalr	a5
ffffffffc0202d7a:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202d7c:	c33fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d80:	b39d                	j	ffffffffc0202ae6 <pmm_init+0x3d0>
ffffffffc0202d82:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202d84:	c31fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202d88:	000b3783          	ld	a5,0(s6)
ffffffffc0202d8c:	6522                	ld	a0,8(sp)
ffffffffc0202d8e:	4585                	li	a1,1
ffffffffc0202d90:	739c                	ld	a5,32(a5)
ffffffffc0202d92:	9782                	jalr	a5
        intr_enable();
ffffffffc0202d94:	c1bfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d98:	b33d                	j	ffffffffc0202ac6 <pmm_init+0x3b0>
ffffffffc0202d9a:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202d9c:	c19fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202da0:	000b3783          	ld	a5,0(s6)
ffffffffc0202da4:	6522                	ld	a0,8(sp)
ffffffffc0202da6:	4585                	li	a1,1
ffffffffc0202da8:	739c                	ld	a5,32(a5)
ffffffffc0202daa:	9782                	jalr	a5
        intr_enable();
ffffffffc0202dac:	c03fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202db0:	b1dd                	j	ffffffffc0202a96 <pmm_init+0x380>
        intr_disable();
ffffffffc0202db2:	c03fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202db6:	000b3783          	ld	a5,0(s6)
ffffffffc0202dba:	4505                	li	a0,1
ffffffffc0202dbc:	6f9c                	ld	a5,24(a5)
ffffffffc0202dbe:	9782                	jalr	a5
ffffffffc0202dc0:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202dc2:	bedfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202dc6:	b36d                	j	ffffffffc0202b70 <pmm_init+0x45a>
        intr_disable();
ffffffffc0202dc8:	bedfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202dcc:	000b3783          	ld	a5,0(s6)
ffffffffc0202dd0:	779c                	ld	a5,40(a5)
ffffffffc0202dd2:	9782                	jalr	a5
ffffffffc0202dd4:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202dd6:	bd9fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202dda:	bdf9                	j	ffffffffc0202cb8 <pmm_init+0x5a2>
ffffffffc0202ddc:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202dde:	bd7fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202de2:	000b3783          	ld	a5,0(s6)
ffffffffc0202de6:	6522                	ld	a0,8(sp)
ffffffffc0202de8:	4585                	li	a1,1
ffffffffc0202dea:	739c                	ld	a5,32(a5)
ffffffffc0202dec:	9782                	jalr	a5
        intr_enable();
ffffffffc0202dee:	bc1fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202df2:	b55d                	j	ffffffffc0202c98 <pmm_init+0x582>
ffffffffc0202df4:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202df6:	bbffd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202dfa:	000b3783          	ld	a5,0(s6)
ffffffffc0202dfe:	6522                	ld	a0,8(sp)
ffffffffc0202e00:	4585                	li	a1,1
ffffffffc0202e02:	739c                	ld	a5,32(a5)
ffffffffc0202e04:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e06:	ba9fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e0a:	bdb9                	j	ffffffffc0202c68 <pmm_init+0x552>
        intr_disable();
ffffffffc0202e0c:	ba9fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202e10:	000b3783          	ld	a5,0(s6)
ffffffffc0202e14:	4585                	li	a1,1
ffffffffc0202e16:	8552                	mv	a0,s4
ffffffffc0202e18:	739c                	ld	a5,32(a5)
ffffffffc0202e1a:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e1c:	b93fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e20:	bd29                	j	ffffffffc0202c3a <pmm_init+0x524>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202e22:	86a2                	mv	a3,s0
ffffffffc0202e24:	00003617          	auipc	a2,0x3
ffffffffc0202e28:	6ec60613          	addi	a2,a2,1772 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc0202e2c:	25500593          	li	a1,597
ffffffffc0202e30:	00003517          	auipc	a0,0x3
ffffffffc0202e34:	7f850513          	addi	a0,a0,2040 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202e38:	e56fd0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202e3c:	00004697          	auipc	a3,0x4
ffffffffc0202e40:	c5c68693          	addi	a3,a3,-932 # ffffffffc0206a98 <default_pmm_manager+0x5c0>
ffffffffc0202e44:	00003617          	auipc	a2,0x3
ffffffffc0202e48:	2e460613          	addi	a2,a2,740 # ffffffffc0206128 <commands+0x818>
ffffffffc0202e4c:	25600593          	li	a1,598
ffffffffc0202e50:	00003517          	auipc	a0,0x3
ffffffffc0202e54:	7d850513          	addi	a0,a0,2008 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202e58:	e36fd0ef          	jal	ra,ffffffffc020048e <__panic>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202e5c:	00004697          	auipc	a3,0x4
ffffffffc0202e60:	bfc68693          	addi	a3,a3,-1028 # ffffffffc0206a58 <default_pmm_manager+0x580>
ffffffffc0202e64:	00003617          	auipc	a2,0x3
ffffffffc0202e68:	2c460613          	addi	a2,a2,708 # ffffffffc0206128 <commands+0x818>
ffffffffc0202e6c:	25500593          	li	a1,597
ffffffffc0202e70:	00003517          	auipc	a0,0x3
ffffffffc0202e74:	7b850513          	addi	a0,a0,1976 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202e78:	e16fd0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0202e7c:	fc5fe0ef          	jal	ra,ffffffffc0201e40 <pa2page.part.0>
ffffffffc0202e80:	fddfe0ef          	jal	ra,ffffffffc0201e5c <pte2page.part.0>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202e84:	00004697          	auipc	a3,0x4
ffffffffc0202e88:	9cc68693          	addi	a3,a3,-1588 # ffffffffc0206850 <default_pmm_manager+0x378>
ffffffffc0202e8c:	00003617          	auipc	a2,0x3
ffffffffc0202e90:	29c60613          	addi	a2,a2,668 # ffffffffc0206128 <commands+0x818>
ffffffffc0202e94:	22500593          	li	a1,549
ffffffffc0202e98:	00003517          	auipc	a0,0x3
ffffffffc0202e9c:	79050513          	addi	a0,a0,1936 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202ea0:	deefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc0202ea4:	00004697          	auipc	a3,0x4
ffffffffc0202ea8:	8ec68693          	addi	a3,a3,-1812 # ffffffffc0206790 <default_pmm_manager+0x2b8>
ffffffffc0202eac:	00003617          	auipc	a2,0x3
ffffffffc0202eb0:	27c60613          	addi	a2,a2,636 # ffffffffc0206128 <commands+0x818>
ffffffffc0202eb4:	21800593          	li	a1,536
ffffffffc0202eb8:	00003517          	auipc	a0,0x3
ffffffffc0202ebc:	77050513          	addi	a0,a0,1904 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202ec0:	dcefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc0202ec4:	00004697          	auipc	a3,0x4
ffffffffc0202ec8:	88c68693          	addi	a3,a3,-1908 # ffffffffc0206750 <default_pmm_manager+0x278>
ffffffffc0202ecc:	00003617          	auipc	a2,0x3
ffffffffc0202ed0:	25c60613          	addi	a2,a2,604 # ffffffffc0206128 <commands+0x818>
ffffffffc0202ed4:	21700593          	li	a1,535
ffffffffc0202ed8:	00003517          	auipc	a0,0x3
ffffffffc0202edc:	75050513          	addi	a0,a0,1872 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202ee0:	daefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(npage <= KERNTOP / PGSIZE);
ffffffffc0202ee4:	00004697          	auipc	a3,0x4
ffffffffc0202ee8:	84c68693          	addi	a3,a3,-1972 # ffffffffc0206730 <default_pmm_manager+0x258>
ffffffffc0202eec:	00003617          	auipc	a2,0x3
ffffffffc0202ef0:	23c60613          	addi	a2,a2,572 # ffffffffc0206128 <commands+0x818>
ffffffffc0202ef4:	21600593          	li	a1,534
ffffffffc0202ef8:	00003517          	auipc	a0,0x3
ffffffffc0202efc:	73050513          	addi	a0,a0,1840 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202f00:	d8efd0ef          	jal	ra,ffffffffc020048e <__panic>
    return KADDR(page2pa(page));
ffffffffc0202f04:	00003617          	auipc	a2,0x3
ffffffffc0202f08:	60c60613          	addi	a2,a2,1548 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc0202f0c:	07100593          	li	a1,113
ffffffffc0202f10:	00003517          	auipc	a0,0x3
ffffffffc0202f14:	62850513          	addi	a0,a0,1576 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0202f18:	d76fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202f1c:	00004697          	auipc	a3,0x4
ffffffffc0202f20:	ac468693          	addi	a3,a3,-1340 # ffffffffc02069e0 <default_pmm_manager+0x508>
ffffffffc0202f24:	00003617          	auipc	a2,0x3
ffffffffc0202f28:	20460613          	addi	a2,a2,516 # ffffffffc0206128 <commands+0x818>
ffffffffc0202f2c:	23e00593          	li	a1,574
ffffffffc0202f30:	00003517          	auipc	a0,0x3
ffffffffc0202f34:	6f850513          	addi	a0,a0,1784 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202f38:	d56fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202f3c:	00004697          	auipc	a3,0x4
ffffffffc0202f40:	a5c68693          	addi	a3,a3,-1444 # ffffffffc0206998 <default_pmm_manager+0x4c0>
ffffffffc0202f44:	00003617          	auipc	a2,0x3
ffffffffc0202f48:	1e460613          	addi	a2,a2,484 # ffffffffc0206128 <commands+0x818>
ffffffffc0202f4c:	23c00593          	li	a1,572
ffffffffc0202f50:	00003517          	auipc	a0,0x3
ffffffffc0202f54:	6d850513          	addi	a0,a0,1752 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202f58:	d36fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 0);
ffffffffc0202f5c:	00004697          	auipc	a3,0x4
ffffffffc0202f60:	a6c68693          	addi	a3,a3,-1428 # ffffffffc02069c8 <default_pmm_manager+0x4f0>
ffffffffc0202f64:	00003617          	auipc	a2,0x3
ffffffffc0202f68:	1c460613          	addi	a2,a2,452 # ffffffffc0206128 <commands+0x818>
ffffffffc0202f6c:	23b00593          	li	a1,571
ffffffffc0202f70:	00003517          	auipc	a0,0x3
ffffffffc0202f74:	6b850513          	addi	a0,a0,1720 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202f78:	d16fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va[0] == 0);
ffffffffc0202f7c:	00004697          	auipc	a3,0x4
ffffffffc0202f80:	b3468693          	addi	a3,a3,-1228 # ffffffffc0206ab0 <default_pmm_manager+0x5d8>
ffffffffc0202f84:	00003617          	auipc	a2,0x3
ffffffffc0202f88:	1a460613          	addi	a2,a2,420 # ffffffffc0206128 <commands+0x818>
ffffffffc0202f8c:	25900593          	li	a1,601
ffffffffc0202f90:	00003517          	auipc	a0,0x3
ffffffffc0202f94:	69850513          	addi	a0,a0,1688 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202f98:	cf6fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc0202f9c:	00004697          	auipc	a3,0x4
ffffffffc0202fa0:	a7468693          	addi	a3,a3,-1420 # ffffffffc0206a10 <default_pmm_manager+0x538>
ffffffffc0202fa4:	00003617          	auipc	a2,0x3
ffffffffc0202fa8:	18460613          	addi	a2,a2,388 # ffffffffc0206128 <commands+0x818>
ffffffffc0202fac:	24600593          	li	a1,582
ffffffffc0202fb0:	00003517          	auipc	a0,0x3
ffffffffc0202fb4:	67850513          	addi	a0,a0,1656 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202fb8:	cd6fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p) == 1);
ffffffffc0202fbc:	00004697          	auipc	a3,0x4
ffffffffc0202fc0:	b4c68693          	addi	a3,a3,-1204 # ffffffffc0206b08 <default_pmm_manager+0x630>
ffffffffc0202fc4:	00003617          	auipc	a2,0x3
ffffffffc0202fc8:	16460613          	addi	a2,a2,356 # ffffffffc0206128 <commands+0x818>
ffffffffc0202fcc:	25e00593          	li	a1,606
ffffffffc0202fd0:	00003517          	auipc	a0,0x3
ffffffffc0202fd4:	65850513          	addi	a0,a0,1624 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202fd8:	cb6fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202fdc:	00004697          	auipc	a3,0x4
ffffffffc0202fe0:	aec68693          	addi	a3,a3,-1300 # ffffffffc0206ac8 <default_pmm_manager+0x5f0>
ffffffffc0202fe4:	00003617          	auipc	a2,0x3
ffffffffc0202fe8:	14460613          	addi	a2,a2,324 # ffffffffc0206128 <commands+0x818>
ffffffffc0202fec:	25d00593          	li	a1,605
ffffffffc0202ff0:	00003517          	auipc	a0,0x3
ffffffffc0202ff4:	63850513          	addi	a0,a0,1592 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0202ff8:	c96fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202ffc:	00004697          	auipc	a3,0x4
ffffffffc0203000:	99c68693          	addi	a3,a3,-1636 # ffffffffc0206998 <default_pmm_manager+0x4c0>
ffffffffc0203004:	00003617          	auipc	a2,0x3
ffffffffc0203008:	12460613          	addi	a2,a2,292 # ffffffffc0206128 <commands+0x818>
ffffffffc020300c:	23800593          	li	a1,568
ffffffffc0203010:	00003517          	auipc	a0,0x3
ffffffffc0203014:	61850513          	addi	a0,a0,1560 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203018:	c76fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 1);
ffffffffc020301c:	00004697          	auipc	a3,0x4
ffffffffc0203020:	81c68693          	addi	a3,a3,-2020 # ffffffffc0206838 <default_pmm_manager+0x360>
ffffffffc0203024:	00003617          	auipc	a2,0x3
ffffffffc0203028:	10460613          	addi	a2,a2,260 # ffffffffc0206128 <commands+0x818>
ffffffffc020302c:	23700593          	li	a1,567
ffffffffc0203030:	00003517          	auipc	a0,0x3
ffffffffc0203034:	5f850513          	addi	a0,a0,1528 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203038:	c56fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((*ptep & PTE_U) == 0);
ffffffffc020303c:	00004697          	auipc	a3,0x4
ffffffffc0203040:	97468693          	addi	a3,a3,-1676 # ffffffffc02069b0 <default_pmm_manager+0x4d8>
ffffffffc0203044:	00003617          	auipc	a2,0x3
ffffffffc0203048:	0e460613          	addi	a2,a2,228 # ffffffffc0206128 <commands+0x818>
ffffffffc020304c:	23400593          	li	a1,564
ffffffffc0203050:	00003517          	auipc	a0,0x3
ffffffffc0203054:	5d850513          	addi	a0,a0,1496 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203058:	c36fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc020305c:	00003697          	auipc	a3,0x3
ffffffffc0203060:	7c468693          	addi	a3,a3,1988 # ffffffffc0206820 <default_pmm_manager+0x348>
ffffffffc0203064:	00003617          	auipc	a2,0x3
ffffffffc0203068:	0c460613          	addi	a2,a2,196 # ffffffffc0206128 <commands+0x818>
ffffffffc020306c:	23300593          	li	a1,563
ffffffffc0203070:	00003517          	auipc	a0,0x3
ffffffffc0203074:	5b850513          	addi	a0,a0,1464 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203078:	c16fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc020307c:	00004697          	auipc	a3,0x4
ffffffffc0203080:	84468693          	addi	a3,a3,-1980 # ffffffffc02068c0 <default_pmm_manager+0x3e8>
ffffffffc0203084:	00003617          	auipc	a2,0x3
ffffffffc0203088:	0a460613          	addi	a2,a2,164 # ffffffffc0206128 <commands+0x818>
ffffffffc020308c:	23200593          	li	a1,562
ffffffffc0203090:	00003517          	auipc	a0,0x3
ffffffffc0203094:	59850513          	addi	a0,a0,1432 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203098:	bf6fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc020309c:	00004697          	auipc	a3,0x4
ffffffffc02030a0:	8fc68693          	addi	a3,a3,-1796 # ffffffffc0206998 <default_pmm_manager+0x4c0>
ffffffffc02030a4:	00003617          	auipc	a2,0x3
ffffffffc02030a8:	08460613          	addi	a2,a2,132 # ffffffffc0206128 <commands+0x818>
ffffffffc02030ac:	23100593          	li	a1,561
ffffffffc02030b0:	00003517          	auipc	a0,0x3
ffffffffc02030b4:	57850513          	addi	a0,a0,1400 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02030b8:	bd6fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 2);
ffffffffc02030bc:	00004697          	auipc	a3,0x4
ffffffffc02030c0:	8c468693          	addi	a3,a3,-1852 # ffffffffc0206980 <default_pmm_manager+0x4a8>
ffffffffc02030c4:	00003617          	auipc	a2,0x3
ffffffffc02030c8:	06460613          	addi	a2,a2,100 # ffffffffc0206128 <commands+0x818>
ffffffffc02030cc:	23000593          	li	a1,560
ffffffffc02030d0:	00003517          	auipc	a0,0x3
ffffffffc02030d4:	55850513          	addi	a0,a0,1368 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02030d8:	bb6fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc02030dc:	00004697          	auipc	a3,0x4
ffffffffc02030e0:	87468693          	addi	a3,a3,-1932 # ffffffffc0206950 <default_pmm_manager+0x478>
ffffffffc02030e4:	00003617          	auipc	a2,0x3
ffffffffc02030e8:	04460613          	addi	a2,a2,68 # ffffffffc0206128 <commands+0x818>
ffffffffc02030ec:	22f00593          	li	a1,559
ffffffffc02030f0:	00003517          	auipc	a0,0x3
ffffffffc02030f4:	53850513          	addi	a0,a0,1336 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02030f8:	b96fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 1);
ffffffffc02030fc:	00004697          	auipc	a3,0x4
ffffffffc0203100:	83c68693          	addi	a3,a3,-1988 # ffffffffc0206938 <default_pmm_manager+0x460>
ffffffffc0203104:	00003617          	auipc	a2,0x3
ffffffffc0203108:	02460613          	addi	a2,a2,36 # ffffffffc0206128 <commands+0x818>
ffffffffc020310c:	22d00593          	li	a1,557
ffffffffc0203110:	00003517          	auipc	a0,0x3
ffffffffc0203114:	51850513          	addi	a0,a0,1304 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203118:	b76fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc020311c:	00003697          	auipc	a3,0x3
ffffffffc0203120:	7fc68693          	addi	a3,a3,2044 # ffffffffc0206918 <default_pmm_manager+0x440>
ffffffffc0203124:	00003617          	auipc	a2,0x3
ffffffffc0203128:	00460613          	addi	a2,a2,4 # ffffffffc0206128 <commands+0x818>
ffffffffc020312c:	22c00593          	li	a1,556
ffffffffc0203130:	00003517          	auipc	a0,0x3
ffffffffc0203134:	4f850513          	addi	a0,a0,1272 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203138:	b56fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(*ptep & PTE_W);
ffffffffc020313c:	00003697          	auipc	a3,0x3
ffffffffc0203140:	7cc68693          	addi	a3,a3,1996 # ffffffffc0206908 <default_pmm_manager+0x430>
ffffffffc0203144:	00003617          	auipc	a2,0x3
ffffffffc0203148:	fe460613          	addi	a2,a2,-28 # ffffffffc0206128 <commands+0x818>
ffffffffc020314c:	22b00593          	li	a1,555
ffffffffc0203150:	00003517          	auipc	a0,0x3
ffffffffc0203154:	4d850513          	addi	a0,a0,1240 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203158:	b36fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(*ptep & PTE_U);
ffffffffc020315c:	00003697          	auipc	a3,0x3
ffffffffc0203160:	79c68693          	addi	a3,a3,1948 # ffffffffc02068f8 <default_pmm_manager+0x420>
ffffffffc0203164:	00003617          	auipc	a2,0x3
ffffffffc0203168:	fc460613          	addi	a2,a2,-60 # ffffffffc0206128 <commands+0x818>
ffffffffc020316c:	22a00593          	li	a1,554
ffffffffc0203170:	00003517          	auipc	a0,0x3
ffffffffc0203174:	4b850513          	addi	a0,a0,1208 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203178:	b16fd0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("DTB memory info not available");
ffffffffc020317c:	00003617          	auipc	a2,0x3
ffffffffc0203180:	51c60613          	addi	a2,a2,1308 # ffffffffc0206698 <default_pmm_manager+0x1c0>
ffffffffc0203184:	06500593          	li	a1,101
ffffffffc0203188:	00003517          	auipc	a0,0x3
ffffffffc020318c:	4a050513          	addi	a0,a0,1184 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203190:	afefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc0203194:	00004697          	auipc	a3,0x4
ffffffffc0203198:	87c68693          	addi	a3,a3,-1924 # ffffffffc0206a10 <default_pmm_manager+0x538>
ffffffffc020319c:	00003617          	auipc	a2,0x3
ffffffffc02031a0:	f8c60613          	addi	a2,a2,-116 # ffffffffc0206128 <commands+0x818>
ffffffffc02031a4:	27000593          	li	a1,624
ffffffffc02031a8:	00003517          	auipc	a0,0x3
ffffffffc02031ac:	48050513          	addi	a0,a0,1152 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02031b0:	adefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02031b4:	00003697          	auipc	a3,0x3
ffffffffc02031b8:	70c68693          	addi	a3,a3,1804 # ffffffffc02068c0 <default_pmm_manager+0x3e8>
ffffffffc02031bc:	00003617          	auipc	a2,0x3
ffffffffc02031c0:	f6c60613          	addi	a2,a2,-148 # ffffffffc0206128 <commands+0x818>
ffffffffc02031c4:	22900593          	li	a1,553
ffffffffc02031c8:	00003517          	auipc	a0,0x3
ffffffffc02031cc:	46050513          	addi	a0,a0,1120 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02031d0:	abefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc02031d4:	00003697          	auipc	a3,0x3
ffffffffc02031d8:	6ac68693          	addi	a3,a3,1708 # ffffffffc0206880 <default_pmm_manager+0x3a8>
ffffffffc02031dc:	00003617          	auipc	a2,0x3
ffffffffc02031e0:	f4c60613          	addi	a2,a2,-180 # ffffffffc0206128 <commands+0x818>
ffffffffc02031e4:	22800593          	li	a1,552
ffffffffc02031e8:	00003517          	auipc	a0,0x3
ffffffffc02031ec:	44050513          	addi	a0,a0,1088 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02031f0:	a9efd0ef          	jal	ra,ffffffffc020048e <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc02031f4:	86d6                	mv	a3,s5
ffffffffc02031f6:	00003617          	auipc	a2,0x3
ffffffffc02031fa:	31a60613          	addi	a2,a2,794 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc02031fe:	22400593          	li	a1,548
ffffffffc0203202:	00003517          	auipc	a0,0x3
ffffffffc0203206:	42650513          	addi	a0,a0,1062 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc020320a:	a84fd0ef          	jal	ra,ffffffffc020048e <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc020320e:	00003617          	auipc	a2,0x3
ffffffffc0203212:	30260613          	addi	a2,a2,770 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc0203216:	22300593          	li	a1,547
ffffffffc020321a:	00003517          	auipc	a0,0x3
ffffffffc020321e:	40e50513          	addi	a0,a0,1038 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203222:	a6cfd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 1);
ffffffffc0203226:	00003697          	auipc	a3,0x3
ffffffffc020322a:	61268693          	addi	a3,a3,1554 # ffffffffc0206838 <default_pmm_manager+0x360>
ffffffffc020322e:	00003617          	auipc	a2,0x3
ffffffffc0203232:	efa60613          	addi	a2,a2,-262 # ffffffffc0206128 <commands+0x818>
ffffffffc0203236:	22100593          	li	a1,545
ffffffffc020323a:	00003517          	auipc	a0,0x3
ffffffffc020323e:	3ee50513          	addi	a0,a0,1006 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203242:	a4cfd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc0203246:	00003697          	auipc	a3,0x3
ffffffffc020324a:	5da68693          	addi	a3,a3,1498 # ffffffffc0206820 <default_pmm_manager+0x348>
ffffffffc020324e:	00003617          	auipc	a2,0x3
ffffffffc0203252:	eda60613          	addi	a2,a2,-294 # ffffffffc0206128 <commands+0x818>
ffffffffc0203256:	22000593          	li	a1,544
ffffffffc020325a:	00003517          	auipc	a0,0x3
ffffffffc020325e:	3ce50513          	addi	a0,a0,974 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203262:	a2cfd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(strlen((const char *)0x100) == 0);
ffffffffc0203266:	00004697          	auipc	a3,0x4
ffffffffc020326a:	96a68693          	addi	a3,a3,-1686 # ffffffffc0206bd0 <default_pmm_manager+0x6f8>
ffffffffc020326e:	00003617          	auipc	a2,0x3
ffffffffc0203272:	eba60613          	addi	a2,a2,-326 # ffffffffc0206128 <commands+0x818>
ffffffffc0203276:	26700593          	li	a1,615
ffffffffc020327a:	00003517          	auipc	a0,0x3
ffffffffc020327e:	3ae50513          	addi	a0,a0,942 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203282:	a0cfd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc0203286:	00004697          	auipc	a3,0x4
ffffffffc020328a:	91268693          	addi	a3,a3,-1774 # ffffffffc0206b98 <default_pmm_manager+0x6c0>
ffffffffc020328e:	00003617          	auipc	a2,0x3
ffffffffc0203292:	e9a60613          	addi	a2,a2,-358 # ffffffffc0206128 <commands+0x818>
ffffffffc0203296:	26400593          	li	a1,612
ffffffffc020329a:	00003517          	auipc	a0,0x3
ffffffffc020329e:	38e50513          	addi	a0,a0,910 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02032a2:	9ecfd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p) == 2);
ffffffffc02032a6:	00004697          	auipc	a3,0x4
ffffffffc02032aa:	8c268693          	addi	a3,a3,-1854 # ffffffffc0206b68 <default_pmm_manager+0x690>
ffffffffc02032ae:	00003617          	auipc	a2,0x3
ffffffffc02032b2:	e7a60613          	addi	a2,a2,-390 # ffffffffc0206128 <commands+0x818>
ffffffffc02032b6:	26000593          	li	a1,608
ffffffffc02032ba:	00003517          	auipc	a0,0x3
ffffffffc02032be:	36e50513          	addi	a0,a0,878 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02032c2:	9ccfd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc02032c6:	00004697          	auipc	a3,0x4
ffffffffc02032ca:	85a68693          	addi	a3,a3,-1958 # ffffffffc0206b20 <default_pmm_manager+0x648>
ffffffffc02032ce:	00003617          	auipc	a2,0x3
ffffffffc02032d2:	e5a60613          	addi	a2,a2,-422 # ffffffffc0206128 <commands+0x818>
ffffffffc02032d6:	25f00593          	li	a1,607
ffffffffc02032da:	00003517          	auipc	a0,0x3
ffffffffc02032de:	34e50513          	addi	a0,a0,846 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02032e2:	9acfd0ef          	jal	ra,ffffffffc020048e <__panic>
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc02032e6:	00003617          	auipc	a2,0x3
ffffffffc02032ea:	2d260613          	addi	a2,a2,722 # ffffffffc02065b8 <default_pmm_manager+0xe0>
ffffffffc02032ee:	0c900593          	li	a1,201
ffffffffc02032f2:	00003517          	auipc	a0,0x3
ffffffffc02032f6:	33650513          	addi	a0,a0,822 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02032fa:	994fd0ef          	jal	ra,ffffffffc020048e <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02032fe:	00003617          	auipc	a2,0x3
ffffffffc0203302:	2ba60613          	addi	a2,a2,698 # ffffffffc02065b8 <default_pmm_manager+0xe0>
ffffffffc0203306:	08100593          	li	a1,129
ffffffffc020330a:	00003517          	auipc	a0,0x3
ffffffffc020330e:	31e50513          	addi	a0,a0,798 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203312:	97cfd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc0203316:	00003697          	auipc	a3,0x3
ffffffffc020331a:	4da68693          	addi	a3,a3,1242 # ffffffffc02067f0 <default_pmm_manager+0x318>
ffffffffc020331e:	00003617          	auipc	a2,0x3
ffffffffc0203322:	e0a60613          	addi	a2,a2,-502 # ffffffffc0206128 <commands+0x818>
ffffffffc0203326:	21f00593          	li	a1,543
ffffffffc020332a:	00003517          	auipc	a0,0x3
ffffffffc020332e:	2fe50513          	addi	a0,a0,766 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203332:	95cfd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc0203336:	00003697          	auipc	a3,0x3
ffffffffc020333a:	48a68693          	addi	a3,a3,1162 # ffffffffc02067c0 <default_pmm_manager+0x2e8>
ffffffffc020333e:	00003617          	auipc	a2,0x3
ffffffffc0203342:	dea60613          	addi	a2,a2,-534 # ffffffffc0206128 <commands+0x818>
ffffffffc0203346:	21c00593          	li	a1,540
ffffffffc020334a:	00003517          	auipc	a0,0x3
ffffffffc020334e:	2de50513          	addi	a0,a0,734 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203352:	93cfd0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203356 <copy_range>:
{
ffffffffc0203356:	7119                	addi	sp,sp,-128
ffffffffc0203358:	f4a6                	sd	s1,104(sp)
ffffffffc020335a:	84b6                	mv	s1,a3
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020335c:	8ed1                	or	a3,a3,a2
{
ffffffffc020335e:	fc86                	sd	ra,120(sp)
ffffffffc0203360:	f8a2                	sd	s0,112(sp)
ffffffffc0203362:	f0ca                	sd	s2,96(sp)
ffffffffc0203364:	ecce                	sd	s3,88(sp)
ffffffffc0203366:	e8d2                	sd	s4,80(sp)
ffffffffc0203368:	e4d6                	sd	s5,72(sp)
ffffffffc020336a:	e0da                	sd	s6,64(sp)
ffffffffc020336c:	fc5e                	sd	s7,56(sp)
ffffffffc020336e:	f862                	sd	s8,48(sp)
ffffffffc0203370:	f466                	sd	s9,40(sp)
ffffffffc0203372:	f06a                	sd	s10,32(sp)
ffffffffc0203374:	ec6e                	sd	s11,24(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203376:	16d2                	slli	a3,a3,0x34
{
ffffffffc0203378:	e43a                	sd	a4,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020337a:	24069863          	bnez	a3,ffffffffc02035ca <copy_range+0x274>
    assert(USER_ACCESS(start, end));
ffffffffc020337e:	00200737          	lui	a4,0x200
ffffffffc0203382:	8db2                	mv	s11,a2
ffffffffc0203384:	1ae66a63          	bltu	a2,a4,ffffffffc0203538 <copy_range+0x1e2>
ffffffffc0203388:	1a967863          	bgeu	a2,s1,ffffffffc0203538 <copy_range+0x1e2>
ffffffffc020338c:	4705                	li	a4,1
ffffffffc020338e:	077e                	slli	a4,a4,0x1f
ffffffffc0203390:	1a976463          	bltu	a4,s1,ffffffffc0203538 <copy_range+0x1e2>
ffffffffc0203394:	5bfd                	li	s7,-1
ffffffffc0203396:	8a2a                	mv	s4,a0
ffffffffc0203398:	842e                	mv	s0,a1
        start += PGSIZE;
ffffffffc020339a:	6985                	lui	s3,0x1
    if (PPN(pa) >= npage)
ffffffffc020339c:	000a7b17          	auipc	s6,0xa7
ffffffffc02033a0:	394b0b13          	addi	s6,s6,916 # ffffffffc02aa730 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02033a4:	000a7a97          	auipc	s5,0xa7
ffffffffc02033a8:	394a8a93          	addi	s5,s5,916 # ffffffffc02aa738 <pages>
    return KADDR(page2pa(page));
ffffffffc02033ac:	00cbdb93          	srli	s7,s7,0xc
        page = pmm_manager->alloc_pages(n);
ffffffffc02033b0:	000a7c97          	auipc	s9,0xa7
ffffffffc02033b4:	390c8c93          	addi	s9,s9,912 # ffffffffc02aa740 <pmm_manager>
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc02033b8:	4601                	li	a2,0
ffffffffc02033ba:	85ee                	mv	a1,s11
ffffffffc02033bc:	8522                	mv	a0,s0
ffffffffc02033be:	b73fe0ef          	jal	ra,ffffffffc0201f30 <get_pte>
ffffffffc02033c2:	892a                	mv	s2,a0
        if (ptep == NULL)
ffffffffc02033c4:	c579                	beqz	a0,ffffffffc0203492 <copy_range+0x13c>
        if (*ptep & PTE_V)
ffffffffc02033c6:	6118                	ld	a4,0(a0)
ffffffffc02033c8:	8b05                	andi	a4,a4,1
ffffffffc02033ca:	e705                	bnez	a4,ffffffffc02033f2 <copy_range+0x9c>
        start += PGSIZE;
ffffffffc02033cc:	9dce                	add	s11,s11,s3
    } while (start != 0 && start < end);
ffffffffc02033ce:	fe9de5e3          	bltu	s11,s1,ffffffffc02033b8 <copy_range+0x62>
    return 0;
ffffffffc02033d2:	4501                	li	a0,0
}
ffffffffc02033d4:	70e6                	ld	ra,120(sp)
ffffffffc02033d6:	7446                	ld	s0,112(sp)
ffffffffc02033d8:	74a6                	ld	s1,104(sp)
ffffffffc02033da:	7906                	ld	s2,96(sp)
ffffffffc02033dc:	69e6                	ld	s3,88(sp)
ffffffffc02033de:	6a46                	ld	s4,80(sp)
ffffffffc02033e0:	6aa6                	ld	s5,72(sp)
ffffffffc02033e2:	6b06                	ld	s6,64(sp)
ffffffffc02033e4:	7be2                	ld	s7,56(sp)
ffffffffc02033e6:	7c42                	ld	s8,48(sp)
ffffffffc02033e8:	7ca2                	ld	s9,40(sp)
ffffffffc02033ea:	7d02                	ld	s10,32(sp)
ffffffffc02033ec:	6de2                	ld	s11,24(sp)
ffffffffc02033ee:	6109                	addi	sp,sp,128
ffffffffc02033f0:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL)
ffffffffc02033f2:	4605                	li	a2,1
ffffffffc02033f4:	85ee                	mv	a1,s11
ffffffffc02033f6:	8552                	mv	a0,s4
ffffffffc02033f8:	b39fe0ef          	jal	ra,ffffffffc0201f30 <get_pte>
ffffffffc02033fc:	12050063          	beqz	a0,ffffffffc020351c <copy_range+0x1c6>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc0203400:	00093703          	ld	a4,0(s2)
    if (!(pte & PTE_V))
ffffffffc0203404:	00177693          	andi	a3,a4,1
ffffffffc0203408:	0007091b          	sext.w	s2,a4
ffffffffc020340c:	16068363          	beqz	a3,ffffffffc0203572 <copy_range+0x21c>
    if (PPN(pa) >= npage)
ffffffffc0203410:	000b3683          	ld	a3,0(s6)
    return pa2page(PTE_ADDR(pte));
ffffffffc0203414:	070a                	slli	a4,a4,0x2
ffffffffc0203416:	8331                	srli	a4,a4,0xc
    if (PPN(pa) >= npage)
ffffffffc0203418:	10d77463          	bgeu	a4,a3,ffffffffc0203520 <copy_range+0x1ca>
    return &pages[PPN(pa) - nbase];
ffffffffc020341c:	000ab583          	ld	a1,0(s5)
ffffffffc0203420:	fff807b7          	lui	a5,0xfff80
ffffffffc0203424:	973e                	add	a4,a4,a5
ffffffffc0203426:	071a                	slli	a4,a4,0x6
ffffffffc0203428:	00e58d33          	add	s10,a1,a4
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020342c:	10002773          	csrr	a4,sstatus
ffffffffc0203430:	8b09                	andi	a4,a4,2
ffffffffc0203432:	eb71                	bnez	a4,ffffffffc0203506 <copy_range+0x1b0>
        page = pmm_manager->alloc_pages(n);
ffffffffc0203434:	000cb703          	ld	a4,0(s9)
ffffffffc0203438:	4505                	li	a0,1
ffffffffc020343a:	6f18                	ld	a4,24(a4)
ffffffffc020343c:	9702                	jalr	a4
ffffffffc020343e:	8c2a                	mv	s8,a0
            assert(page != NULL);
ffffffffc0203440:	140d0563          	beqz	s10,ffffffffc020358a <copy_range+0x234>
            assert(npage != NULL);
ffffffffc0203444:	160c0363          	beqz	s8,ffffffffc02035aa <copy_range+0x254>
            if(share){
ffffffffc0203448:	67a2                	ld	a5,8(sp)
ffffffffc020344a:	c3ad                	beqz	a5,ffffffffc02034ac <copy_range+0x156>
                ret |= page_insert(to, page, start, perm & ~PTE_W);
ffffffffc020344c:	01b97c13          	andi	s8,s2,27
ffffffffc0203450:	86e2                	mv	a3,s8
ffffffffc0203452:	866e                	mv	a2,s11
ffffffffc0203454:	85ea                	mv	a1,s10
ffffffffc0203456:	8552                	mv	a0,s4
ffffffffc0203458:	9c8ff0ef          	jal	ra,ffffffffc0202620 <page_insert>
ffffffffc020345c:	892a                	mv	s2,a0
                ret |= page_insert(from, page, start, perm & ~PTE_W);
ffffffffc020345e:	86e2                	mv	a3,s8
ffffffffc0203460:	866e                	mv	a2,s11
ffffffffc0203462:	85ea                	mv	a1,s10
ffffffffc0203464:	8522                	mv	a0,s0
ffffffffc0203466:	9baff0ef          	jal	ra,ffffffffc0202620 <page_insert>
ffffffffc020346a:	00a96533          	or	a0,s2,a0
ffffffffc020346e:	2501                	sext.w	a0,a0
            assert(ret == 0);
ffffffffc0203470:	dd31                	beqz	a0,ffffffffc02033cc <copy_range+0x76>
ffffffffc0203472:	00003697          	auipc	a3,0x3
ffffffffc0203476:	7c668693          	addi	a3,a3,1990 # ffffffffc0206c38 <default_pmm_manager+0x760>
ffffffffc020347a:	00003617          	auipc	a2,0x3
ffffffffc020347e:	cae60613          	addi	a2,a2,-850 # ffffffffc0206128 <commands+0x818>
ffffffffc0203482:	1b400593          	li	a1,436
ffffffffc0203486:	00003517          	auipc	a0,0x3
ffffffffc020348a:	1a250513          	addi	a0,a0,418 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc020348e:	800fd0ef          	jal	ra,ffffffffc020048e <__panic>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc0203492:	00200637          	lui	a2,0x200
ffffffffc0203496:	00cd87b3          	add	a5,s11,a2
ffffffffc020349a:	ffe00637          	lui	a2,0xffe00
ffffffffc020349e:	00c7fdb3          	and	s11,a5,a2
    } while (start != 0 && start < end);
ffffffffc02034a2:	f20d88e3          	beqz	s11,ffffffffc02033d2 <copy_range+0x7c>
ffffffffc02034a6:	f09de9e3          	bltu	s11,s1,ffffffffc02033b8 <copy_range+0x62>
ffffffffc02034aa:	b725                	j	ffffffffc02033d2 <copy_range+0x7c>
    return page - pages + nbase;
ffffffffc02034ac:	000ab703          	ld	a4,0(s5)
ffffffffc02034b0:	000808b7          	lui	a7,0x80
    return KADDR(page2pa(page));
ffffffffc02034b4:	000b3603          	ld	a2,0(s6)
    return page - pages + nbase;
ffffffffc02034b8:	40ed06b3          	sub	a3,s10,a4
ffffffffc02034bc:	8699                	srai	a3,a3,0x6
ffffffffc02034be:	96c6                	add	a3,a3,a7
    return KADDR(page2pa(page));
ffffffffc02034c0:	0176f5b3          	and	a1,a3,s7
    return page2ppn(page) << PGSHIFT;
ffffffffc02034c4:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02034c6:	08c5fa63          	bgeu	a1,a2,ffffffffc020355a <copy_range+0x204>
    return page - pages + nbase;
ffffffffc02034ca:	40ec0733          	sub	a4,s8,a4
    return KADDR(page2pa(page));
ffffffffc02034ce:	000a7797          	auipc	a5,0xa7
ffffffffc02034d2:	27a78793          	addi	a5,a5,634 # ffffffffc02aa748 <va_pa_offset>
ffffffffc02034d6:	6388                	ld	a0,0(a5)
    return page - pages + nbase;
ffffffffc02034d8:	8719                	srai	a4,a4,0x6
ffffffffc02034da:	9746                	add	a4,a4,a7
    return KADDR(page2pa(page));
ffffffffc02034dc:	017778b3          	and	a7,a4,s7
ffffffffc02034e0:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc02034e4:	0732                	slli	a4,a4,0xc
    return KADDR(page2pa(page));
ffffffffc02034e6:	06c8f963          	bgeu	a7,a2,ffffffffc0203558 <copy_range+0x202>
                memcpy((void *)dst_kvaddr, (void *)src_kvaddr, PGSIZE);
ffffffffc02034ea:	6605                	lui	a2,0x1
ffffffffc02034ec:	953a                	add	a0,a0,a4
ffffffffc02034ee:	19c020ef          	jal	ra,ffffffffc020568a <memcpy>
                ret = page_insert(to, npage, start, perm);
ffffffffc02034f2:	01f97693          	andi	a3,s2,31
ffffffffc02034f6:	866e                	mv	a2,s11
ffffffffc02034f8:	85e2                	mv	a1,s8
ffffffffc02034fa:	8552                	mv	a0,s4
ffffffffc02034fc:	924ff0ef          	jal	ra,ffffffffc0202620 <page_insert>
            assert(ret == 0);
ffffffffc0203500:	ec0506e3          	beqz	a0,ffffffffc02033cc <copy_range+0x76>
ffffffffc0203504:	b7bd                	j	ffffffffc0203472 <copy_range+0x11c>
        intr_disable();
ffffffffc0203506:	caefd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc020350a:	000cb703          	ld	a4,0(s9)
ffffffffc020350e:	4505                	li	a0,1
ffffffffc0203510:	6f18                	ld	a4,24(a4)
ffffffffc0203512:	9702                	jalr	a4
ffffffffc0203514:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0203516:	c98fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020351a:	b71d                	j	ffffffffc0203440 <copy_range+0xea>
                return -E_NO_MEM;
ffffffffc020351c:	5571                	li	a0,-4
ffffffffc020351e:	bd5d                	j	ffffffffc02033d4 <copy_range+0x7e>
        panic("pa2page called with invalid pa");
ffffffffc0203520:	00003617          	auipc	a2,0x3
ffffffffc0203524:	0c060613          	addi	a2,a2,192 # ffffffffc02065e0 <default_pmm_manager+0x108>
ffffffffc0203528:	06900593          	li	a1,105
ffffffffc020352c:	00003517          	auipc	a0,0x3
ffffffffc0203530:	00c50513          	addi	a0,a0,12 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0203534:	f5bfc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc0203538:	00003697          	auipc	a3,0x3
ffffffffc020353c:	13068693          	addi	a3,a3,304 # ffffffffc0206668 <default_pmm_manager+0x190>
ffffffffc0203540:	00003617          	auipc	a2,0x3
ffffffffc0203544:	be860613          	addi	a2,a2,-1048 # ffffffffc0206128 <commands+0x818>
ffffffffc0203548:	17c00593          	li	a1,380
ffffffffc020354c:	00003517          	auipc	a0,0x3
ffffffffc0203550:	0dc50513          	addi	a0,a0,220 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc0203554:	f3bfc0ef          	jal	ra,ffffffffc020048e <__panic>
    return KADDR(page2pa(page));
ffffffffc0203558:	86ba                	mv	a3,a4
ffffffffc020355a:	00003617          	auipc	a2,0x3
ffffffffc020355e:	fb660613          	addi	a2,a2,-74 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc0203562:	07100593          	li	a1,113
ffffffffc0203566:	00003517          	auipc	a0,0x3
ffffffffc020356a:	fd250513          	addi	a0,a0,-46 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc020356e:	f21fc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pte2page called with invalid pte");
ffffffffc0203572:	00003617          	auipc	a2,0x3
ffffffffc0203576:	08e60613          	addi	a2,a2,142 # ffffffffc0206600 <default_pmm_manager+0x128>
ffffffffc020357a:	07f00593          	li	a1,127
ffffffffc020357e:	00003517          	auipc	a0,0x3
ffffffffc0203582:	fba50513          	addi	a0,a0,-70 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0203586:	f09fc0ef          	jal	ra,ffffffffc020048e <__panic>
            assert(page != NULL);
ffffffffc020358a:	00003697          	auipc	a3,0x3
ffffffffc020358e:	68e68693          	addi	a3,a3,1678 # ffffffffc0206c18 <default_pmm_manager+0x740>
ffffffffc0203592:	00003617          	auipc	a2,0x3
ffffffffc0203596:	b9660613          	addi	a2,a2,-1130 # ffffffffc0206128 <commands+0x818>
ffffffffc020359a:	19400593          	li	a1,404
ffffffffc020359e:	00003517          	auipc	a0,0x3
ffffffffc02035a2:	08a50513          	addi	a0,a0,138 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02035a6:	ee9fc0ef          	jal	ra,ffffffffc020048e <__panic>
            assert(npage != NULL);
ffffffffc02035aa:	00003697          	auipc	a3,0x3
ffffffffc02035ae:	67e68693          	addi	a3,a3,1662 # ffffffffc0206c28 <default_pmm_manager+0x750>
ffffffffc02035b2:	00003617          	auipc	a2,0x3
ffffffffc02035b6:	b7660613          	addi	a2,a2,-1162 # ffffffffc0206128 <commands+0x818>
ffffffffc02035ba:	19500593          	li	a1,405
ffffffffc02035be:	00003517          	auipc	a0,0x3
ffffffffc02035c2:	06a50513          	addi	a0,a0,106 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02035c6:	ec9fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02035ca:	00003697          	auipc	a3,0x3
ffffffffc02035ce:	06e68693          	addi	a3,a3,110 # ffffffffc0206638 <default_pmm_manager+0x160>
ffffffffc02035d2:	00003617          	auipc	a2,0x3
ffffffffc02035d6:	b5660613          	addi	a2,a2,-1194 # ffffffffc0206128 <commands+0x818>
ffffffffc02035da:	17b00593          	li	a1,379
ffffffffc02035de:	00003517          	auipc	a0,0x3
ffffffffc02035e2:	04a50513          	addi	a0,a0,74 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02035e6:	ea9fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02035ea <pgdir_alloc_page>:
{
ffffffffc02035ea:	7179                	addi	sp,sp,-48
ffffffffc02035ec:	ec26                	sd	s1,24(sp)
ffffffffc02035ee:	e84a                	sd	s2,16(sp)
ffffffffc02035f0:	e052                	sd	s4,0(sp)
ffffffffc02035f2:	f406                	sd	ra,40(sp)
ffffffffc02035f4:	f022                	sd	s0,32(sp)
ffffffffc02035f6:	e44e                	sd	s3,8(sp)
ffffffffc02035f8:	8a2a                	mv	s4,a0
ffffffffc02035fa:	84ae                	mv	s1,a1
ffffffffc02035fc:	8932                	mv	s2,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02035fe:	100027f3          	csrr	a5,sstatus
ffffffffc0203602:	8b89                	andi	a5,a5,2
        page = pmm_manager->alloc_pages(n);
ffffffffc0203604:	000a7997          	auipc	s3,0xa7
ffffffffc0203608:	13c98993          	addi	s3,s3,316 # ffffffffc02aa740 <pmm_manager>
ffffffffc020360c:	ef8d                	bnez	a5,ffffffffc0203646 <pgdir_alloc_page+0x5c>
ffffffffc020360e:	0009b783          	ld	a5,0(s3)
ffffffffc0203612:	4505                	li	a0,1
ffffffffc0203614:	6f9c                	ld	a5,24(a5)
ffffffffc0203616:	9782                	jalr	a5
ffffffffc0203618:	842a                	mv	s0,a0
    if (page != NULL)
ffffffffc020361a:	cc09                	beqz	s0,ffffffffc0203634 <pgdir_alloc_page+0x4a>
        if (page_insert(pgdir, page, la, perm) != 0)
ffffffffc020361c:	86ca                	mv	a3,s2
ffffffffc020361e:	8626                	mv	a2,s1
ffffffffc0203620:	85a2                	mv	a1,s0
ffffffffc0203622:	8552                	mv	a0,s4
ffffffffc0203624:	ffdfe0ef          	jal	ra,ffffffffc0202620 <page_insert>
ffffffffc0203628:	e915                	bnez	a0,ffffffffc020365c <pgdir_alloc_page+0x72>
        assert(page_ref(page) == 1);
ffffffffc020362a:	4018                	lw	a4,0(s0)
        page->pra_vaddr = la;
ffffffffc020362c:	fc04                	sd	s1,56(s0)
        assert(page_ref(page) == 1);
ffffffffc020362e:	4785                	li	a5,1
ffffffffc0203630:	04f71e63          	bne	a4,a5,ffffffffc020368c <pgdir_alloc_page+0xa2>
}
ffffffffc0203634:	70a2                	ld	ra,40(sp)
ffffffffc0203636:	8522                	mv	a0,s0
ffffffffc0203638:	7402                	ld	s0,32(sp)
ffffffffc020363a:	64e2                	ld	s1,24(sp)
ffffffffc020363c:	6942                	ld	s2,16(sp)
ffffffffc020363e:	69a2                	ld	s3,8(sp)
ffffffffc0203640:	6a02                	ld	s4,0(sp)
ffffffffc0203642:	6145                	addi	sp,sp,48
ffffffffc0203644:	8082                	ret
        intr_disable();
ffffffffc0203646:	b6efd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc020364a:	0009b783          	ld	a5,0(s3)
ffffffffc020364e:	4505                	li	a0,1
ffffffffc0203650:	6f9c                	ld	a5,24(a5)
ffffffffc0203652:	9782                	jalr	a5
ffffffffc0203654:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0203656:	b58fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020365a:	b7c1                	j	ffffffffc020361a <pgdir_alloc_page+0x30>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020365c:	100027f3          	csrr	a5,sstatus
ffffffffc0203660:	8b89                	andi	a5,a5,2
ffffffffc0203662:	eb89                	bnez	a5,ffffffffc0203674 <pgdir_alloc_page+0x8a>
        pmm_manager->free_pages(base, n);
ffffffffc0203664:	0009b783          	ld	a5,0(s3)
ffffffffc0203668:	8522                	mv	a0,s0
ffffffffc020366a:	4585                	li	a1,1
ffffffffc020366c:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc020366e:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc0203670:	9782                	jalr	a5
    if (flag)
ffffffffc0203672:	b7c9                	j	ffffffffc0203634 <pgdir_alloc_page+0x4a>
        intr_disable();
ffffffffc0203674:	b40fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0203678:	0009b783          	ld	a5,0(s3)
ffffffffc020367c:	8522                	mv	a0,s0
ffffffffc020367e:	4585                	li	a1,1
ffffffffc0203680:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc0203682:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc0203684:	9782                	jalr	a5
        intr_enable();
ffffffffc0203686:	b28fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020368a:	b76d                	j	ffffffffc0203634 <pgdir_alloc_page+0x4a>
        assert(page_ref(page) == 1);
ffffffffc020368c:	00003697          	auipc	a3,0x3
ffffffffc0203690:	5bc68693          	addi	a3,a3,1468 # ffffffffc0206c48 <default_pmm_manager+0x770>
ffffffffc0203694:	00003617          	auipc	a2,0x3
ffffffffc0203698:	a9460613          	addi	a2,a2,-1388 # ffffffffc0206128 <commands+0x818>
ffffffffc020369c:	1fd00593          	li	a1,509
ffffffffc02036a0:	00003517          	auipc	a0,0x3
ffffffffc02036a4:	f8850513          	addi	a0,a0,-120 # ffffffffc0206628 <default_pmm_manager+0x150>
ffffffffc02036a8:	de7fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02036ac <check_vma_overlap.part.0>:
    return vma;
}

// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc02036ac:	1141                	addi	sp,sp,-16
{
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc02036ae:	00003697          	auipc	a3,0x3
ffffffffc02036b2:	5b268693          	addi	a3,a3,1458 # ffffffffc0206c60 <default_pmm_manager+0x788>
ffffffffc02036b6:	00003617          	auipc	a2,0x3
ffffffffc02036ba:	a7260613          	addi	a2,a2,-1422 # ffffffffc0206128 <commands+0x818>
ffffffffc02036be:	07400593          	li	a1,116
ffffffffc02036c2:	00003517          	auipc	a0,0x3
ffffffffc02036c6:	5be50513          	addi	a0,a0,1470 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc02036ca:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc02036cc:	dc3fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02036d0 <mm_create>:
{
ffffffffc02036d0:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc02036d2:	04000513          	li	a0,64
{
ffffffffc02036d6:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc02036d8:	dc2fe0ef          	jal	ra,ffffffffc0201c9a <kmalloc>
    if (mm != NULL)
ffffffffc02036dc:	cd19                	beqz	a0,ffffffffc02036fa <mm_create+0x2a>
    elm->prev = elm->next = elm;
ffffffffc02036de:	e508                	sd	a0,8(a0)
ffffffffc02036e0:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc02036e2:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc02036e6:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc02036ea:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc02036ee:	02053423          	sd	zero,40(a0)
}

static inline void
set_mm_count(struct mm_struct *mm, int val)
{
    mm->mm_count = val;
ffffffffc02036f2:	02052823          	sw	zero,48(a0)
typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock)
{
    *lock = 0;
ffffffffc02036f6:	02053c23          	sd	zero,56(a0)
}
ffffffffc02036fa:	60a2                	ld	ra,8(sp)
ffffffffc02036fc:	0141                	addi	sp,sp,16
ffffffffc02036fe:	8082                	ret

ffffffffc0203700 <find_vma>:
{
ffffffffc0203700:	86aa                	mv	a3,a0
    if (mm != NULL)
ffffffffc0203702:	c505                	beqz	a0,ffffffffc020372a <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc0203704:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc0203706:	c501                	beqz	a0,ffffffffc020370e <find_vma+0xe>
ffffffffc0203708:	651c                	ld	a5,8(a0)
ffffffffc020370a:	02f5f263          	bgeu	a1,a5,ffffffffc020372e <find_vma+0x2e>
    return listelm->next;
ffffffffc020370e:	669c                	ld	a5,8(a3)
            while ((le = list_next(le)) != list)
ffffffffc0203710:	00f68d63          	beq	a3,a5,ffffffffc020372a <find_vma+0x2a>
                if (vma->vm_start <= addr && addr < vma->vm_end)
ffffffffc0203714:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203718:	00e5e663          	bltu	a1,a4,ffffffffc0203724 <find_vma+0x24>
ffffffffc020371c:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203720:	00e5ec63          	bltu	a1,a4,ffffffffc0203738 <find_vma+0x38>
ffffffffc0203724:	679c                	ld	a5,8(a5)
            while ((le = list_next(le)) != list)
ffffffffc0203726:	fef697e3          	bne	a3,a5,ffffffffc0203714 <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc020372a:	4501                	li	a0,0
}
ffffffffc020372c:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc020372e:	691c                	ld	a5,16(a0)
ffffffffc0203730:	fcf5ffe3          	bgeu	a1,a5,ffffffffc020370e <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc0203734:	ea88                	sd	a0,16(a3)
ffffffffc0203736:	8082                	ret
                vma = le2vma(le, list_link);
ffffffffc0203738:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc020373c:	ea88                	sd	a0,16(a3)
ffffffffc020373e:	8082                	ret

ffffffffc0203740 <insert_vma_struct>:
}

// insert_vma_struct -insert vma in mm's list link
void insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma)
{
    assert(vma->vm_start < vma->vm_end);
ffffffffc0203740:	6590                	ld	a2,8(a1)
ffffffffc0203742:	0105b803          	ld	a6,16(a1)
{
ffffffffc0203746:	1141                	addi	sp,sp,-16
ffffffffc0203748:	e406                	sd	ra,8(sp)
ffffffffc020374a:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc020374c:	01066763          	bltu	a2,a6,ffffffffc020375a <insert_vma_struct+0x1a>
ffffffffc0203750:	a085                	j	ffffffffc02037b0 <insert_vma_struct+0x70>

    list_entry_t *le = list;
    while ((le = list_next(le)) != list)
    {
        struct vma_struct *mmap_prev = le2vma(le, list_link);
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc0203752:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203756:	04e66863          	bltu	a2,a4,ffffffffc02037a6 <insert_vma_struct+0x66>
ffffffffc020375a:	86be                	mv	a3,a5
ffffffffc020375c:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != list)
ffffffffc020375e:	fef51ae3          	bne	a0,a5,ffffffffc0203752 <insert_vma_struct+0x12>
    }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list)
ffffffffc0203762:	02a68463          	beq	a3,a0,ffffffffc020378a <insert_vma_struct+0x4a>
    {
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc0203766:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc020376a:	fe86b883          	ld	a7,-24(a3)
ffffffffc020376e:	08e8f163          	bgeu	a7,a4,ffffffffc02037f0 <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0203772:	04e66f63          	bltu	a2,a4,ffffffffc02037d0 <insert_vma_struct+0x90>
    }
    if (le_next != list)
ffffffffc0203776:	00f50a63          	beq	a0,a5,ffffffffc020378a <insert_vma_struct+0x4a>
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc020377a:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc020377e:	05076963          	bltu	a4,a6,ffffffffc02037d0 <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc0203782:	ff07b603          	ld	a2,-16(a5)
ffffffffc0203786:	02c77363          	bgeu	a4,a2,ffffffffc02037ac <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count++;
ffffffffc020378a:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc020378c:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc020378e:	02058613          	addi	a2,a1,32
    prev->next = next->prev = elm;
ffffffffc0203792:	e390                	sd	a2,0(a5)
ffffffffc0203794:	e690                	sd	a2,8(a3)
}
ffffffffc0203796:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc0203798:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc020379a:	f194                	sd	a3,32(a1)
    mm->map_count++;
ffffffffc020379c:	0017079b          	addiw	a5,a4,1
ffffffffc02037a0:	d11c                	sw	a5,32(a0)
}
ffffffffc02037a2:	0141                	addi	sp,sp,16
ffffffffc02037a4:	8082                	ret
    if (le_prev != list)
ffffffffc02037a6:	fca690e3          	bne	a3,a0,ffffffffc0203766 <insert_vma_struct+0x26>
ffffffffc02037aa:	bfd1                	j	ffffffffc020377e <insert_vma_struct+0x3e>
ffffffffc02037ac:	f01ff0ef          	jal	ra,ffffffffc02036ac <check_vma_overlap.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc02037b0:	00003697          	auipc	a3,0x3
ffffffffc02037b4:	4e068693          	addi	a3,a3,1248 # ffffffffc0206c90 <default_pmm_manager+0x7b8>
ffffffffc02037b8:	00003617          	auipc	a2,0x3
ffffffffc02037bc:	97060613          	addi	a2,a2,-1680 # ffffffffc0206128 <commands+0x818>
ffffffffc02037c0:	07a00593          	li	a1,122
ffffffffc02037c4:	00003517          	auipc	a0,0x3
ffffffffc02037c8:	4bc50513          	addi	a0,a0,1212 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc02037cc:	cc3fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc02037d0:	00003697          	auipc	a3,0x3
ffffffffc02037d4:	50068693          	addi	a3,a3,1280 # ffffffffc0206cd0 <default_pmm_manager+0x7f8>
ffffffffc02037d8:	00003617          	auipc	a2,0x3
ffffffffc02037dc:	95060613          	addi	a2,a2,-1712 # ffffffffc0206128 <commands+0x818>
ffffffffc02037e0:	07300593          	li	a1,115
ffffffffc02037e4:	00003517          	auipc	a0,0x3
ffffffffc02037e8:	49c50513          	addi	a0,a0,1180 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc02037ec:	ca3fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc02037f0:	00003697          	auipc	a3,0x3
ffffffffc02037f4:	4c068693          	addi	a3,a3,1216 # ffffffffc0206cb0 <default_pmm_manager+0x7d8>
ffffffffc02037f8:	00003617          	auipc	a2,0x3
ffffffffc02037fc:	93060613          	addi	a2,a2,-1744 # ffffffffc0206128 <commands+0x818>
ffffffffc0203800:	07200593          	li	a1,114
ffffffffc0203804:	00003517          	auipc	a0,0x3
ffffffffc0203808:	47c50513          	addi	a0,a0,1148 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc020380c:	c83fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203810 <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void mm_destroy(struct mm_struct *mm)
{
    assert(mm_count(mm) == 0);
ffffffffc0203810:	591c                	lw	a5,48(a0)
{
ffffffffc0203812:	1141                	addi	sp,sp,-16
ffffffffc0203814:	e406                	sd	ra,8(sp)
ffffffffc0203816:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc0203818:	e78d                	bnez	a5,ffffffffc0203842 <mm_destroy+0x32>
ffffffffc020381a:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc020381c:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list)
ffffffffc020381e:	00a40c63          	beq	s0,a0,ffffffffc0203836 <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc0203822:	6118                	ld	a4,0(a0)
ffffffffc0203824:	651c                	ld	a5,8(a0)
    {
        list_del(le);
        kfree(le2vma(le, list_link)); // kfree vma
ffffffffc0203826:	1501                	addi	a0,a0,-32
    prev->next = next;
ffffffffc0203828:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc020382a:	e398                	sd	a4,0(a5)
ffffffffc020382c:	d1efe0ef          	jal	ra,ffffffffc0201d4a <kfree>
    return listelm->next;
ffffffffc0203830:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list)
ffffffffc0203832:	fea418e3          	bne	s0,a0,ffffffffc0203822 <mm_destroy+0x12>
    }
    kfree(mm); // kfree mm
ffffffffc0203836:	8522                	mv	a0,s0
    mm = NULL;
}
ffffffffc0203838:	6402                	ld	s0,0(sp)
ffffffffc020383a:	60a2                	ld	ra,8(sp)
ffffffffc020383c:	0141                	addi	sp,sp,16
    kfree(mm); // kfree mm
ffffffffc020383e:	d0cfe06f          	j	ffffffffc0201d4a <kfree>
    assert(mm_count(mm) == 0);
ffffffffc0203842:	00003697          	auipc	a3,0x3
ffffffffc0203846:	4ae68693          	addi	a3,a3,1198 # ffffffffc0206cf0 <default_pmm_manager+0x818>
ffffffffc020384a:	00003617          	auipc	a2,0x3
ffffffffc020384e:	8de60613          	addi	a2,a2,-1826 # ffffffffc0206128 <commands+0x818>
ffffffffc0203852:	09e00593          	li	a1,158
ffffffffc0203856:	00003517          	auipc	a0,0x3
ffffffffc020385a:	42a50513          	addi	a0,a0,1066 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc020385e:	c31fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203862 <mm_map>:

int mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
           struct vma_struct **vma_store)
{
ffffffffc0203862:	7139                	addi	sp,sp,-64
ffffffffc0203864:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0203866:	6405                	lui	s0,0x1
ffffffffc0203868:	147d                	addi	s0,s0,-1
ffffffffc020386a:	77fd                	lui	a5,0xfffff
ffffffffc020386c:	9622                	add	a2,a2,s0
ffffffffc020386e:	962e                	add	a2,a2,a1
{
ffffffffc0203870:	f426                	sd	s1,40(sp)
ffffffffc0203872:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0203874:	00f5f4b3          	and	s1,a1,a5
{
ffffffffc0203878:	f04a                	sd	s2,32(sp)
ffffffffc020387a:	ec4e                	sd	s3,24(sp)
ffffffffc020387c:	e852                	sd	s4,16(sp)
ffffffffc020387e:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end))
ffffffffc0203880:	002005b7          	lui	a1,0x200
ffffffffc0203884:	00f67433          	and	s0,a2,a5
ffffffffc0203888:	06b4e363          	bltu	s1,a1,ffffffffc02038ee <mm_map+0x8c>
ffffffffc020388c:	0684f163          	bgeu	s1,s0,ffffffffc02038ee <mm_map+0x8c>
ffffffffc0203890:	4785                	li	a5,1
ffffffffc0203892:	07fe                	slli	a5,a5,0x1f
ffffffffc0203894:	0487ed63          	bltu	a5,s0,ffffffffc02038ee <mm_map+0x8c>
ffffffffc0203898:	89aa                	mv	s3,a0
    {
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc020389a:	cd21                	beqz	a0,ffffffffc02038f2 <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start)
ffffffffc020389c:	85a6                	mv	a1,s1
ffffffffc020389e:	8ab6                	mv	s5,a3
ffffffffc02038a0:	8a3a                	mv	s4,a4
ffffffffc02038a2:	e5fff0ef          	jal	ra,ffffffffc0203700 <find_vma>
ffffffffc02038a6:	c501                	beqz	a0,ffffffffc02038ae <mm_map+0x4c>
ffffffffc02038a8:	651c                	ld	a5,8(a0)
ffffffffc02038aa:	0487e263          	bltu	a5,s0,ffffffffc02038ee <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02038ae:	03000513          	li	a0,48
ffffffffc02038b2:	be8fe0ef          	jal	ra,ffffffffc0201c9a <kmalloc>
ffffffffc02038b6:	892a                	mv	s2,a0
    {
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc02038b8:	5571                	li	a0,-4
    if (vma != NULL)
ffffffffc02038ba:	02090163          	beqz	s2,ffffffffc02038dc <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL)
    {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc02038be:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc02038c0:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc02038c4:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc02038c8:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc02038cc:	85ca                	mv	a1,s2
ffffffffc02038ce:	e73ff0ef          	jal	ra,ffffffffc0203740 <insert_vma_struct>
    if (vma_store != NULL)
    {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc02038d2:	4501                	li	a0,0
    if (vma_store != NULL)
ffffffffc02038d4:	000a0463          	beqz	s4,ffffffffc02038dc <mm_map+0x7a>
        *vma_store = vma;
ffffffffc02038d8:	012a3023          	sd	s2,0(s4)

out:
    return ret;
}
ffffffffc02038dc:	70e2                	ld	ra,56(sp)
ffffffffc02038de:	7442                	ld	s0,48(sp)
ffffffffc02038e0:	74a2                	ld	s1,40(sp)
ffffffffc02038e2:	7902                	ld	s2,32(sp)
ffffffffc02038e4:	69e2                	ld	s3,24(sp)
ffffffffc02038e6:	6a42                	ld	s4,16(sp)
ffffffffc02038e8:	6aa2                	ld	s5,8(sp)
ffffffffc02038ea:	6121                	addi	sp,sp,64
ffffffffc02038ec:	8082                	ret
        return -E_INVAL;
ffffffffc02038ee:	5575                	li	a0,-3
ffffffffc02038f0:	b7f5                	j	ffffffffc02038dc <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc02038f2:	00003697          	auipc	a3,0x3
ffffffffc02038f6:	41668693          	addi	a3,a3,1046 # ffffffffc0206d08 <default_pmm_manager+0x830>
ffffffffc02038fa:	00003617          	auipc	a2,0x3
ffffffffc02038fe:	82e60613          	addi	a2,a2,-2002 # ffffffffc0206128 <commands+0x818>
ffffffffc0203902:	0b300593          	li	a1,179
ffffffffc0203906:	00003517          	auipc	a0,0x3
ffffffffc020390a:	37a50513          	addi	a0,a0,890 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc020390e:	b81fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203912 <dup_mmap>:

int dup_mmap(struct mm_struct *to, struct mm_struct *from)
{
ffffffffc0203912:	7139                	addi	sp,sp,-64
ffffffffc0203914:	fc06                	sd	ra,56(sp)
ffffffffc0203916:	f822                	sd	s0,48(sp)
ffffffffc0203918:	f426                	sd	s1,40(sp)
ffffffffc020391a:	f04a                	sd	s2,32(sp)
ffffffffc020391c:	ec4e                	sd	s3,24(sp)
ffffffffc020391e:	e852                	sd	s4,16(sp)
ffffffffc0203920:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc0203922:	c52d                	beqz	a0,ffffffffc020398c <dup_mmap+0x7a>
ffffffffc0203924:	892a                	mv	s2,a0
ffffffffc0203926:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc0203928:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc020392a:	e595                	bnez	a1,ffffffffc0203956 <dup_mmap+0x44>
ffffffffc020392c:	a085                	j	ffffffffc020398c <dup_mmap+0x7a>
        if (nvma == NULL)
        {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc020392e:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc0203930:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_exit_out_size+0x1f4ee8>
        vma->vm_end = vm_end;
ffffffffc0203934:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc0203938:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc020393c:	e05ff0ef          	jal	ra,ffffffffc0203740 <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0)
ffffffffc0203940:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_faultread_out_size-0x8bc0>
ffffffffc0203944:	fe843603          	ld	a2,-24(s0)
ffffffffc0203948:	6c8c                	ld	a1,24(s1)
ffffffffc020394a:	01893503          	ld	a0,24(s2)
ffffffffc020394e:	4701                	li	a4,0
ffffffffc0203950:	a07ff0ef          	jal	ra,ffffffffc0203356 <copy_range>
ffffffffc0203954:	e105                	bnez	a0,ffffffffc0203974 <dup_mmap+0x62>
    return listelm->prev;
ffffffffc0203956:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list)
ffffffffc0203958:	02848863          	beq	s1,s0,ffffffffc0203988 <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc020395c:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc0203960:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203964:	ff043a03          	ld	s4,-16(s0)
ffffffffc0203968:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc020396c:	b2efe0ef          	jal	ra,ffffffffc0201c9a <kmalloc>
ffffffffc0203970:	85aa                	mv	a1,a0
    if (vma != NULL)
ffffffffc0203972:	fd55                	bnez	a0,ffffffffc020392e <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc0203974:	5571                	li	a0,-4
        {
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc0203976:	70e2                	ld	ra,56(sp)
ffffffffc0203978:	7442                	ld	s0,48(sp)
ffffffffc020397a:	74a2                	ld	s1,40(sp)
ffffffffc020397c:	7902                	ld	s2,32(sp)
ffffffffc020397e:	69e2                	ld	s3,24(sp)
ffffffffc0203980:	6a42                	ld	s4,16(sp)
ffffffffc0203982:	6aa2                	ld	s5,8(sp)
ffffffffc0203984:	6121                	addi	sp,sp,64
ffffffffc0203986:	8082                	ret
    return 0;
ffffffffc0203988:	4501                	li	a0,0
ffffffffc020398a:	b7f5                	j	ffffffffc0203976 <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc020398c:	00003697          	auipc	a3,0x3
ffffffffc0203990:	38c68693          	addi	a3,a3,908 # ffffffffc0206d18 <default_pmm_manager+0x840>
ffffffffc0203994:	00002617          	auipc	a2,0x2
ffffffffc0203998:	79460613          	addi	a2,a2,1940 # ffffffffc0206128 <commands+0x818>
ffffffffc020399c:	0cf00593          	li	a1,207
ffffffffc02039a0:	00003517          	auipc	a0,0x3
ffffffffc02039a4:	2e050513          	addi	a0,a0,736 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc02039a8:	ae7fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02039ac <exit_mmap>:

void exit_mmap(struct mm_struct *mm)
{
ffffffffc02039ac:	1101                	addi	sp,sp,-32
ffffffffc02039ae:	ec06                	sd	ra,24(sp)
ffffffffc02039b0:	e822                	sd	s0,16(sp)
ffffffffc02039b2:	e426                	sd	s1,8(sp)
ffffffffc02039b4:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc02039b6:	c531                	beqz	a0,ffffffffc0203a02 <exit_mmap+0x56>
ffffffffc02039b8:	591c                	lw	a5,48(a0)
ffffffffc02039ba:	84aa                	mv	s1,a0
ffffffffc02039bc:	e3b9                	bnez	a5,ffffffffc0203a02 <exit_mmap+0x56>
    return listelm->next;
ffffffffc02039be:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc02039c0:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list)
ffffffffc02039c4:	02850663          	beq	a0,s0,ffffffffc02039f0 <exit_mmap+0x44>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc02039c8:	ff043603          	ld	a2,-16(s0)
ffffffffc02039cc:	fe843583          	ld	a1,-24(s0)
ffffffffc02039d0:	854a                	mv	a0,s2
ffffffffc02039d2:	fdafe0ef          	jal	ra,ffffffffc02021ac <unmap_range>
ffffffffc02039d6:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc02039d8:	fe8498e3          	bne	s1,s0,ffffffffc02039c8 <exit_mmap+0x1c>
ffffffffc02039dc:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list)
ffffffffc02039de:	00848c63          	beq	s1,s0,ffffffffc02039f6 <exit_mmap+0x4a>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc02039e2:	ff043603          	ld	a2,-16(s0)
ffffffffc02039e6:	fe843583          	ld	a1,-24(s0)
ffffffffc02039ea:	854a                	mv	a0,s2
ffffffffc02039ec:	907fe0ef          	jal	ra,ffffffffc02022f2 <exit_range>
ffffffffc02039f0:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc02039f2:	fe8498e3          	bne	s1,s0,ffffffffc02039e2 <exit_mmap+0x36>
    }
}
ffffffffc02039f6:	60e2                	ld	ra,24(sp)
ffffffffc02039f8:	6442                	ld	s0,16(sp)
ffffffffc02039fa:	64a2                	ld	s1,8(sp)
ffffffffc02039fc:	6902                	ld	s2,0(sp)
ffffffffc02039fe:	6105                	addi	sp,sp,32
ffffffffc0203a00:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0203a02:	00003697          	auipc	a3,0x3
ffffffffc0203a06:	33668693          	addi	a3,a3,822 # ffffffffc0206d38 <default_pmm_manager+0x860>
ffffffffc0203a0a:	00002617          	auipc	a2,0x2
ffffffffc0203a0e:	71e60613          	addi	a2,a2,1822 # ffffffffc0206128 <commands+0x818>
ffffffffc0203a12:	0e800593          	li	a1,232
ffffffffc0203a16:	00003517          	auipc	a0,0x3
ffffffffc0203a1a:	26a50513          	addi	a0,a0,618 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203a1e:	a71fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203a22 <vmm_init>:
}

// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void vmm_init(void)
{
ffffffffc0203a22:	7139                	addi	sp,sp,-64
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203a24:	04000513          	li	a0,64
{
ffffffffc0203a28:	fc06                	sd	ra,56(sp)
ffffffffc0203a2a:	f822                	sd	s0,48(sp)
ffffffffc0203a2c:	f426                	sd	s1,40(sp)
ffffffffc0203a2e:	f04a                	sd	s2,32(sp)
ffffffffc0203a30:	ec4e                	sd	s3,24(sp)
ffffffffc0203a32:	e852                	sd	s4,16(sp)
ffffffffc0203a34:	e456                	sd	s5,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203a36:	a64fe0ef          	jal	ra,ffffffffc0201c9a <kmalloc>
    if (mm != NULL)
ffffffffc0203a3a:	2e050663          	beqz	a0,ffffffffc0203d26 <vmm_init+0x304>
ffffffffc0203a3e:	84aa                	mv	s1,a0
    elm->prev = elm->next = elm;
ffffffffc0203a40:	e508                	sd	a0,8(a0)
ffffffffc0203a42:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc0203a44:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0203a48:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0203a4c:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc0203a50:	02053423          	sd	zero,40(a0)
ffffffffc0203a54:	02052823          	sw	zero,48(a0)
ffffffffc0203a58:	02053c23          	sd	zero,56(a0)
ffffffffc0203a5c:	03200413          	li	s0,50
ffffffffc0203a60:	a811                	j	ffffffffc0203a74 <vmm_init+0x52>
        vma->vm_start = vm_start;
ffffffffc0203a62:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc0203a64:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc0203a66:	00052c23          	sw	zero,24(a0)
    assert(mm != NULL);

    int step1 = 10, step2 = step1 * 10;

    int i;
    for (i = step1; i >= 1; i--)
ffffffffc0203a6a:	146d                	addi	s0,s0,-5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc0203a6c:	8526                	mv	a0,s1
ffffffffc0203a6e:	cd3ff0ef          	jal	ra,ffffffffc0203740 <insert_vma_struct>
    for (i = step1; i >= 1; i--)
ffffffffc0203a72:	c80d                	beqz	s0,ffffffffc0203aa4 <vmm_init+0x82>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203a74:	03000513          	li	a0,48
ffffffffc0203a78:	a22fe0ef          	jal	ra,ffffffffc0201c9a <kmalloc>
ffffffffc0203a7c:	85aa                	mv	a1,a0
ffffffffc0203a7e:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0203a82:	f165                	bnez	a0,ffffffffc0203a62 <vmm_init+0x40>
        assert(vma != NULL);
ffffffffc0203a84:	00003697          	auipc	a3,0x3
ffffffffc0203a88:	44c68693          	addi	a3,a3,1100 # ffffffffc0206ed0 <default_pmm_manager+0x9f8>
ffffffffc0203a8c:	00002617          	auipc	a2,0x2
ffffffffc0203a90:	69c60613          	addi	a2,a2,1692 # ffffffffc0206128 <commands+0x818>
ffffffffc0203a94:	12c00593          	li	a1,300
ffffffffc0203a98:	00003517          	auipc	a0,0x3
ffffffffc0203a9c:	1e850513          	addi	a0,a0,488 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203aa0:	9effc0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0203aa4:	03700413          	li	s0,55
    }

    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203aa8:	1f900913          	li	s2,505
ffffffffc0203aac:	a819                	j	ffffffffc0203ac2 <vmm_init+0xa0>
        vma->vm_start = vm_start;
ffffffffc0203aae:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc0203ab0:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc0203ab2:	00052c23          	sw	zero,24(a0)
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203ab6:	0415                	addi	s0,s0,5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc0203ab8:	8526                	mv	a0,s1
ffffffffc0203aba:	c87ff0ef          	jal	ra,ffffffffc0203740 <insert_vma_struct>
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203abe:	03240a63          	beq	s0,s2,ffffffffc0203af2 <vmm_init+0xd0>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203ac2:	03000513          	li	a0,48
ffffffffc0203ac6:	9d4fe0ef          	jal	ra,ffffffffc0201c9a <kmalloc>
ffffffffc0203aca:	85aa                	mv	a1,a0
ffffffffc0203acc:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0203ad0:	fd79                	bnez	a0,ffffffffc0203aae <vmm_init+0x8c>
        assert(vma != NULL);
ffffffffc0203ad2:	00003697          	auipc	a3,0x3
ffffffffc0203ad6:	3fe68693          	addi	a3,a3,1022 # ffffffffc0206ed0 <default_pmm_manager+0x9f8>
ffffffffc0203ada:	00002617          	auipc	a2,0x2
ffffffffc0203ade:	64e60613          	addi	a2,a2,1614 # ffffffffc0206128 <commands+0x818>
ffffffffc0203ae2:	13300593          	li	a1,307
ffffffffc0203ae6:	00003517          	auipc	a0,0x3
ffffffffc0203aea:	19a50513          	addi	a0,a0,410 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203aee:	9a1fc0ef          	jal	ra,ffffffffc020048e <__panic>
    return listelm->next;
ffffffffc0203af2:	649c                	ld	a5,8(s1)
ffffffffc0203af4:	471d                	li	a4,7
    }

    list_entry_t *le = list_next(&(mm->mmap_list));

    for (i = 1; i <= step2; i++)
ffffffffc0203af6:	1fb00593          	li	a1,507
    {
        assert(le != &(mm->mmap_list));
ffffffffc0203afa:	16f48663          	beq	s1,a5,ffffffffc0203c66 <vmm_init+0x244>
        struct vma_struct *mmap = le2vma(le, list_link);
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203afe:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd5487c>
ffffffffc0203b02:	ffe70693          	addi	a3,a4,-2 # 1ffffe <_binary_obj___user_exit_out_size+0x1f4ede>
ffffffffc0203b06:	10d61063          	bne	a2,a3,ffffffffc0203c06 <vmm_init+0x1e4>
ffffffffc0203b0a:	ff07b683          	ld	a3,-16(a5)
ffffffffc0203b0e:	0ed71c63          	bne	a4,a3,ffffffffc0203c06 <vmm_init+0x1e4>
    for (i = 1; i <= step2; i++)
ffffffffc0203b12:	0715                	addi	a4,a4,5
ffffffffc0203b14:	679c                	ld	a5,8(a5)
ffffffffc0203b16:	feb712e3          	bne	a4,a1,ffffffffc0203afa <vmm_init+0xd8>
ffffffffc0203b1a:	4a1d                	li	s4,7
ffffffffc0203b1c:	4415                	li	s0,5
        le = list_next(le);
    }

    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203b1e:	1f900a93          	li	s5,505
    {
        struct vma_struct *vma1 = find_vma(mm, i);
ffffffffc0203b22:	85a2                	mv	a1,s0
ffffffffc0203b24:	8526                	mv	a0,s1
ffffffffc0203b26:	bdbff0ef          	jal	ra,ffffffffc0203700 <find_vma>
ffffffffc0203b2a:	892a                	mv	s2,a0
        assert(vma1 != NULL);
ffffffffc0203b2c:	16050d63          	beqz	a0,ffffffffc0203ca6 <vmm_init+0x284>
        struct vma_struct *vma2 = find_vma(mm, i + 1);
ffffffffc0203b30:	00140593          	addi	a1,s0,1
ffffffffc0203b34:	8526                	mv	a0,s1
ffffffffc0203b36:	bcbff0ef          	jal	ra,ffffffffc0203700 <find_vma>
ffffffffc0203b3a:	89aa                	mv	s3,a0
        assert(vma2 != NULL);
ffffffffc0203b3c:	14050563          	beqz	a0,ffffffffc0203c86 <vmm_init+0x264>
        struct vma_struct *vma3 = find_vma(mm, i + 2);
ffffffffc0203b40:	85d2                	mv	a1,s4
ffffffffc0203b42:	8526                	mv	a0,s1
ffffffffc0203b44:	bbdff0ef          	jal	ra,ffffffffc0203700 <find_vma>
        assert(vma3 == NULL);
ffffffffc0203b48:	16051f63          	bnez	a0,ffffffffc0203cc6 <vmm_init+0x2a4>
        struct vma_struct *vma4 = find_vma(mm, i + 3);
ffffffffc0203b4c:	00340593          	addi	a1,s0,3
ffffffffc0203b50:	8526                	mv	a0,s1
ffffffffc0203b52:	bafff0ef          	jal	ra,ffffffffc0203700 <find_vma>
        assert(vma4 == NULL);
ffffffffc0203b56:	1a051863          	bnez	a0,ffffffffc0203d06 <vmm_init+0x2e4>
        struct vma_struct *vma5 = find_vma(mm, i + 4);
ffffffffc0203b5a:	00440593          	addi	a1,s0,4
ffffffffc0203b5e:	8526                	mv	a0,s1
ffffffffc0203b60:	ba1ff0ef          	jal	ra,ffffffffc0203700 <find_vma>
        assert(vma5 == NULL);
ffffffffc0203b64:	18051163          	bnez	a0,ffffffffc0203ce6 <vmm_init+0x2c4>

        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203b68:	00893783          	ld	a5,8(s2)
ffffffffc0203b6c:	0a879d63          	bne	a5,s0,ffffffffc0203c26 <vmm_init+0x204>
ffffffffc0203b70:	01093783          	ld	a5,16(s2)
ffffffffc0203b74:	0b479963          	bne	a5,s4,ffffffffc0203c26 <vmm_init+0x204>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203b78:	0089b783          	ld	a5,8(s3)
ffffffffc0203b7c:	0c879563          	bne	a5,s0,ffffffffc0203c46 <vmm_init+0x224>
ffffffffc0203b80:	0109b783          	ld	a5,16(s3)
ffffffffc0203b84:	0d479163          	bne	a5,s4,ffffffffc0203c46 <vmm_init+0x224>
    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203b88:	0415                	addi	s0,s0,5
ffffffffc0203b8a:	0a15                	addi	s4,s4,5
ffffffffc0203b8c:	f9541be3          	bne	s0,s5,ffffffffc0203b22 <vmm_init+0x100>
ffffffffc0203b90:	4411                	li	s0,4
    }

    for (i = 4; i >= 0; i--)
ffffffffc0203b92:	597d                	li	s2,-1
    {
        struct vma_struct *vma_below_5 = find_vma(mm, i);
ffffffffc0203b94:	85a2                	mv	a1,s0
ffffffffc0203b96:	8526                	mv	a0,s1
ffffffffc0203b98:	b69ff0ef          	jal	ra,ffffffffc0203700 <find_vma>
ffffffffc0203b9c:	0004059b          	sext.w	a1,s0
        if (vma_below_5 != NULL)
ffffffffc0203ba0:	c90d                	beqz	a0,ffffffffc0203bd2 <vmm_init+0x1b0>
        {
            cprintf("vma_below_5: i %x, start %x, end %x\n", i, vma_below_5->vm_start, vma_below_5->vm_end);
ffffffffc0203ba2:	6914                	ld	a3,16(a0)
ffffffffc0203ba4:	6510                	ld	a2,8(a0)
ffffffffc0203ba6:	00003517          	auipc	a0,0x3
ffffffffc0203baa:	2b250513          	addi	a0,a0,690 # ffffffffc0206e58 <default_pmm_manager+0x980>
ffffffffc0203bae:	de6fc0ef          	jal	ra,ffffffffc0200194 <cprintf>
        }
        assert(vma_below_5 == NULL);
ffffffffc0203bb2:	00003697          	auipc	a3,0x3
ffffffffc0203bb6:	2ce68693          	addi	a3,a3,718 # ffffffffc0206e80 <default_pmm_manager+0x9a8>
ffffffffc0203bba:	00002617          	auipc	a2,0x2
ffffffffc0203bbe:	56e60613          	addi	a2,a2,1390 # ffffffffc0206128 <commands+0x818>
ffffffffc0203bc2:	15900593          	li	a1,345
ffffffffc0203bc6:	00003517          	auipc	a0,0x3
ffffffffc0203bca:	0ba50513          	addi	a0,a0,186 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203bce:	8c1fc0ef          	jal	ra,ffffffffc020048e <__panic>
    for (i = 4; i >= 0; i--)
ffffffffc0203bd2:	147d                	addi	s0,s0,-1
ffffffffc0203bd4:	fd2410e3          	bne	s0,s2,ffffffffc0203b94 <vmm_init+0x172>
    }

    mm_destroy(mm);
ffffffffc0203bd8:	8526                	mv	a0,s1
ffffffffc0203bda:	c37ff0ef          	jal	ra,ffffffffc0203810 <mm_destroy>

    cprintf("check_vma_struct() succeeded!\n");
ffffffffc0203bde:	00003517          	auipc	a0,0x3
ffffffffc0203be2:	2ba50513          	addi	a0,a0,698 # ffffffffc0206e98 <default_pmm_manager+0x9c0>
ffffffffc0203be6:	daefc0ef          	jal	ra,ffffffffc0200194 <cprintf>
}
ffffffffc0203bea:	7442                	ld	s0,48(sp)
ffffffffc0203bec:	70e2                	ld	ra,56(sp)
ffffffffc0203bee:	74a2                	ld	s1,40(sp)
ffffffffc0203bf0:	7902                	ld	s2,32(sp)
ffffffffc0203bf2:	69e2                	ld	s3,24(sp)
ffffffffc0203bf4:	6a42                	ld	s4,16(sp)
ffffffffc0203bf6:	6aa2                	ld	s5,8(sp)
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203bf8:	00003517          	auipc	a0,0x3
ffffffffc0203bfc:	2c050513          	addi	a0,a0,704 # ffffffffc0206eb8 <default_pmm_manager+0x9e0>
}
ffffffffc0203c00:	6121                	addi	sp,sp,64
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203c02:	d92fc06f          	j	ffffffffc0200194 <cprintf>
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203c06:	00003697          	auipc	a3,0x3
ffffffffc0203c0a:	16a68693          	addi	a3,a3,362 # ffffffffc0206d70 <default_pmm_manager+0x898>
ffffffffc0203c0e:	00002617          	auipc	a2,0x2
ffffffffc0203c12:	51a60613          	addi	a2,a2,1306 # ffffffffc0206128 <commands+0x818>
ffffffffc0203c16:	13d00593          	li	a1,317
ffffffffc0203c1a:	00003517          	auipc	a0,0x3
ffffffffc0203c1e:	06650513          	addi	a0,a0,102 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203c22:	86dfc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203c26:	00003697          	auipc	a3,0x3
ffffffffc0203c2a:	1d268693          	addi	a3,a3,466 # ffffffffc0206df8 <default_pmm_manager+0x920>
ffffffffc0203c2e:	00002617          	auipc	a2,0x2
ffffffffc0203c32:	4fa60613          	addi	a2,a2,1274 # ffffffffc0206128 <commands+0x818>
ffffffffc0203c36:	14e00593          	li	a1,334
ffffffffc0203c3a:	00003517          	auipc	a0,0x3
ffffffffc0203c3e:	04650513          	addi	a0,a0,70 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203c42:	84dfc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203c46:	00003697          	auipc	a3,0x3
ffffffffc0203c4a:	1e268693          	addi	a3,a3,482 # ffffffffc0206e28 <default_pmm_manager+0x950>
ffffffffc0203c4e:	00002617          	auipc	a2,0x2
ffffffffc0203c52:	4da60613          	addi	a2,a2,1242 # ffffffffc0206128 <commands+0x818>
ffffffffc0203c56:	14f00593          	li	a1,335
ffffffffc0203c5a:	00003517          	auipc	a0,0x3
ffffffffc0203c5e:	02650513          	addi	a0,a0,38 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203c62:	82dfc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(le != &(mm->mmap_list));
ffffffffc0203c66:	00003697          	auipc	a3,0x3
ffffffffc0203c6a:	0f268693          	addi	a3,a3,242 # ffffffffc0206d58 <default_pmm_manager+0x880>
ffffffffc0203c6e:	00002617          	auipc	a2,0x2
ffffffffc0203c72:	4ba60613          	addi	a2,a2,1210 # ffffffffc0206128 <commands+0x818>
ffffffffc0203c76:	13b00593          	li	a1,315
ffffffffc0203c7a:	00003517          	auipc	a0,0x3
ffffffffc0203c7e:	00650513          	addi	a0,a0,6 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203c82:	80dfc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma2 != NULL);
ffffffffc0203c86:	00003697          	auipc	a3,0x3
ffffffffc0203c8a:	13268693          	addi	a3,a3,306 # ffffffffc0206db8 <default_pmm_manager+0x8e0>
ffffffffc0203c8e:	00002617          	auipc	a2,0x2
ffffffffc0203c92:	49a60613          	addi	a2,a2,1178 # ffffffffc0206128 <commands+0x818>
ffffffffc0203c96:	14600593          	li	a1,326
ffffffffc0203c9a:	00003517          	auipc	a0,0x3
ffffffffc0203c9e:	fe650513          	addi	a0,a0,-26 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203ca2:	fecfc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma1 != NULL);
ffffffffc0203ca6:	00003697          	auipc	a3,0x3
ffffffffc0203caa:	10268693          	addi	a3,a3,258 # ffffffffc0206da8 <default_pmm_manager+0x8d0>
ffffffffc0203cae:	00002617          	auipc	a2,0x2
ffffffffc0203cb2:	47a60613          	addi	a2,a2,1146 # ffffffffc0206128 <commands+0x818>
ffffffffc0203cb6:	14400593          	li	a1,324
ffffffffc0203cba:	00003517          	auipc	a0,0x3
ffffffffc0203cbe:	fc650513          	addi	a0,a0,-58 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203cc2:	fccfc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma3 == NULL);
ffffffffc0203cc6:	00003697          	auipc	a3,0x3
ffffffffc0203cca:	10268693          	addi	a3,a3,258 # ffffffffc0206dc8 <default_pmm_manager+0x8f0>
ffffffffc0203cce:	00002617          	auipc	a2,0x2
ffffffffc0203cd2:	45a60613          	addi	a2,a2,1114 # ffffffffc0206128 <commands+0x818>
ffffffffc0203cd6:	14800593          	li	a1,328
ffffffffc0203cda:	00003517          	auipc	a0,0x3
ffffffffc0203cde:	fa650513          	addi	a0,a0,-90 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203ce2:	facfc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma5 == NULL);
ffffffffc0203ce6:	00003697          	auipc	a3,0x3
ffffffffc0203cea:	10268693          	addi	a3,a3,258 # ffffffffc0206de8 <default_pmm_manager+0x910>
ffffffffc0203cee:	00002617          	auipc	a2,0x2
ffffffffc0203cf2:	43a60613          	addi	a2,a2,1082 # ffffffffc0206128 <commands+0x818>
ffffffffc0203cf6:	14c00593          	li	a1,332
ffffffffc0203cfa:	00003517          	auipc	a0,0x3
ffffffffc0203cfe:	f8650513          	addi	a0,a0,-122 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203d02:	f8cfc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma4 == NULL);
ffffffffc0203d06:	00003697          	auipc	a3,0x3
ffffffffc0203d0a:	0d268693          	addi	a3,a3,210 # ffffffffc0206dd8 <default_pmm_manager+0x900>
ffffffffc0203d0e:	00002617          	auipc	a2,0x2
ffffffffc0203d12:	41a60613          	addi	a2,a2,1050 # ffffffffc0206128 <commands+0x818>
ffffffffc0203d16:	14a00593          	li	a1,330
ffffffffc0203d1a:	00003517          	auipc	a0,0x3
ffffffffc0203d1e:	f6650513          	addi	a0,a0,-154 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203d22:	f6cfc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(mm != NULL);
ffffffffc0203d26:	00003697          	auipc	a3,0x3
ffffffffc0203d2a:	fe268693          	addi	a3,a3,-30 # ffffffffc0206d08 <default_pmm_manager+0x830>
ffffffffc0203d2e:	00002617          	auipc	a2,0x2
ffffffffc0203d32:	3fa60613          	addi	a2,a2,1018 # ffffffffc0206128 <commands+0x818>
ffffffffc0203d36:	12400593          	li	a1,292
ffffffffc0203d3a:	00003517          	auipc	a0,0x3
ffffffffc0203d3e:	f4650513          	addi	a0,a0,-186 # ffffffffc0206c80 <default_pmm_manager+0x7a8>
ffffffffc0203d42:	f4cfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203d46 <user_mem_check>:
}
bool user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write)
{
ffffffffc0203d46:	7179                	addi	sp,sp,-48
ffffffffc0203d48:	f022                	sd	s0,32(sp)
ffffffffc0203d4a:	f406                	sd	ra,40(sp)
ffffffffc0203d4c:	ec26                	sd	s1,24(sp)
ffffffffc0203d4e:	e84a                	sd	s2,16(sp)
ffffffffc0203d50:	e44e                	sd	s3,8(sp)
ffffffffc0203d52:	e052                	sd	s4,0(sp)
ffffffffc0203d54:	842e                	mv	s0,a1
    if (mm != NULL)
ffffffffc0203d56:	c135                	beqz	a0,ffffffffc0203dba <user_mem_check+0x74>
    {
        if (!USER_ACCESS(addr, addr + len))
ffffffffc0203d58:	002007b7          	lui	a5,0x200
ffffffffc0203d5c:	04f5e663          	bltu	a1,a5,ffffffffc0203da8 <user_mem_check+0x62>
ffffffffc0203d60:	00c584b3          	add	s1,a1,a2
ffffffffc0203d64:	0495f263          	bgeu	a1,s1,ffffffffc0203da8 <user_mem_check+0x62>
ffffffffc0203d68:	4785                	li	a5,1
ffffffffc0203d6a:	07fe                	slli	a5,a5,0x1f
ffffffffc0203d6c:	0297ee63          	bltu	a5,s1,ffffffffc0203da8 <user_mem_check+0x62>
ffffffffc0203d70:	892a                	mv	s2,a0
ffffffffc0203d72:	89b6                	mv	s3,a3
            {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK))
            {
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d74:	6a05                	lui	s4,0x1
ffffffffc0203d76:	a821                	j	ffffffffc0203d8e <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203d78:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d7c:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203d7e:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203d80:	c685                	beqz	a3,ffffffffc0203da8 <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203d82:	c399                	beqz	a5,ffffffffc0203d88 <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d84:	02e46263          	bltu	s0,a4,ffffffffc0203da8 <user_mem_check+0x62>
                { // check stack start & size
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc0203d88:	6900                	ld	s0,16(a0)
        while (start < end)
ffffffffc0203d8a:	04947663          	bgeu	s0,s1,ffffffffc0203dd6 <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start)
ffffffffc0203d8e:	85a2                	mv	a1,s0
ffffffffc0203d90:	854a                	mv	a0,s2
ffffffffc0203d92:	96fff0ef          	jal	ra,ffffffffc0203700 <find_vma>
ffffffffc0203d96:	c909                	beqz	a0,ffffffffc0203da8 <user_mem_check+0x62>
ffffffffc0203d98:	6518                	ld	a4,8(a0)
ffffffffc0203d9a:	00e46763          	bltu	s0,a4,ffffffffc0203da8 <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203d9e:	4d1c                	lw	a5,24(a0)
ffffffffc0203da0:	fc099ce3          	bnez	s3,ffffffffc0203d78 <user_mem_check+0x32>
ffffffffc0203da4:	8b85                	andi	a5,a5,1
ffffffffc0203da6:	f3ed                	bnez	a5,ffffffffc0203d88 <user_mem_check+0x42>
            return 0;
ffffffffc0203da8:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
ffffffffc0203daa:	70a2                	ld	ra,40(sp)
ffffffffc0203dac:	7402                	ld	s0,32(sp)
ffffffffc0203dae:	64e2                	ld	s1,24(sp)
ffffffffc0203db0:	6942                	ld	s2,16(sp)
ffffffffc0203db2:	69a2                	ld	s3,8(sp)
ffffffffc0203db4:	6a02                	ld	s4,0(sp)
ffffffffc0203db6:	6145                	addi	sp,sp,48
ffffffffc0203db8:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc0203dba:	c02007b7          	lui	a5,0xc0200
ffffffffc0203dbe:	4501                	li	a0,0
ffffffffc0203dc0:	fef5e5e3          	bltu	a1,a5,ffffffffc0203daa <user_mem_check+0x64>
ffffffffc0203dc4:	962e                	add	a2,a2,a1
ffffffffc0203dc6:	fec5f2e3          	bgeu	a1,a2,ffffffffc0203daa <user_mem_check+0x64>
ffffffffc0203dca:	c8000537          	lui	a0,0xc8000
ffffffffc0203dce:	0505                	addi	a0,a0,1
ffffffffc0203dd0:	00a63533          	sltu	a0,a2,a0
ffffffffc0203dd4:	bfd9                	j	ffffffffc0203daa <user_mem_check+0x64>
        return 1;
ffffffffc0203dd6:	4505                	li	a0,1
ffffffffc0203dd8:	bfc9                	j	ffffffffc0203daa <user_mem_check+0x64>

ffffffffc0203dda <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc0203dda:	8526                	mv	a0,s1
	jalr s0
ffffffffc0203ddc:	9402                	jalr	s0

	jal do_exit
ffffffffc0203dde:	5ce000ef          	jal	ra,ffffffffc02043ac <do_exit>

ffffffffc0203de2 <alloc_proc>:
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void)
{
ffffffffc0203de2:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203de4:	10800513          	li	a0,264
{
ffffffffc0203de8:	e022                	sd	s0,0(sp)
ffffffffc0203dea:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203dec:	eaffd0ef          	jal	ra,ffffffffc0201c9a <kmalloc>
ffffffffc0203df0:	842a                	mv	s0,a0
    if (proc != NULL)
ffffffffc0203df2:	cd21                	beqz	a0,ffffffffc0203e4a <alloc_proc+0x68>
         *       uintptr_t pgdir;                            // the base addr of Page Directroy Table(PDT)
         *       uint32_t flags;                             // Process flag
         *       char name[PROC_NAME_LEN + 1];               // Process name
         */

        proc->pgdir = boot_pgdir_pa;
ffffffffc0203df4:	000a7797          	auipc	a5,0xa7
ffffffffc0203df8:	92c7b783          	ld	a5,-1748(a5) # ffffffffc02aa720 <boot_pgdir_pa>
ffffffffc0203dfc:	f55c                	sd	a5,168(a0)
        proc->tf = NULL;
        proc->state = PROC_UNINIT;
ffffffffc0203dfe:	57fd                	li	a5,-1
ffffffffc0203e00:	1782                	slli	a5,a5,0x20
ffffffffc0203e02:	e11c                	sd	a5,0(a0)
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        proc->flags = 0;
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc0203e04:	07000613          	li	a2,112
ffffffffc0203e08:	4581                	li	a1,0
        proc->tf = NULL;
ffffffffc0203e0a:	0a053023          	sd	zero,160(a0) # ffffffffc80000a0 <end+0x7d55934>
        proc->runs = 0;
ffffffffc0203e0e:	00052423          	sw	zero,8(a0)
        proc->kstack = 0;
ffffffffc0203e12:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0;
ffffffffc0203e16:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL;
ffffffffc0203e1a:	02053023          	sd	zero,32(a0)
        proc->mm = NULL;
ffffffffc0203e1e:	02053423          	sd	zero,40(a0)
        proc->flags = 0;
ffffffffc0203e22:	0a052823          	sw	zero,176(a0)
        memset(&(proc->context), 0, sizeof(struct context));
ffffffffc0203e26:	03050513          	addi	a0,a0,48
ffffffffc0203e2a:	04f010ef          	jal	ra,ffffffffc0205678 <memset>
        memset(proc->name, 0, PROC_NAME_LEN + 1);
ffffffffc0203e2e:	4641                	li	a2,16
ffffffffc0203e30:	4581                	li	a1,0
ffffffffc0203e32:	0b440513          	addi	a0,s0,180
ffffffffc0203e36:	043010ef          	jal	ra,ffffffffc0205678 <memset>
        /*
         * below fields(add in LAB5) in proc_struct need to be initialized
         *       uint32_t wait_state;                        // waiting state
         *       struct proc_struct *cptr, *yptr, *optr;     // relations between processes
         */
        proc->wait_state = 0;
ffffffffc0203e3a:	0e042623          	sw	zero,236(s0)
        proc->cptr = NULL;
ffffffffc0203e3e:	0e043823          	sd	zero,240(s0)
        proc->yptr = NULL;
ffffffffc0203e42:	0e043c23          	sd	zero,248(s0)
        proc->optr = NULL;
ffffffffc0203e46:	10043023          	sd	zero,256(s0)
    }
    return proc;
}
ffffffffc0203e4a:	60a2                	ld	ra,8(sp)
ffffffffc0203e4c:	8522                	mv	a0,s0
ffffffffc0203e4e:	6402                	ld	s0,0(sp)
ffffffffc0203e50:	0141                	addi	sp,sp,16
ffffffffc0203e52:	8082                	ret

ffffffffc0203e54 <forkret>:
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void)
{
    forkrets(current->tf);
ffffffffc0203e54:	000a7797          	auipc	a5,0xa7
ffffffffc0203e58:	8fc7b783          	ld	a5,-1796(a5) # ffffffffc02aa750 <current>
ffffffffc0203e5c:	73c8                	ld	a0,160(a5)
ffffffffc0203e5e:	8b0fd06f          	j	ffffffffc0200f0e <forkrets>

ffffffffc0203e62 <user_main>:
user_main(void *arg)
{
#ifdef TEST
    KERNEL_EXECVE2(TEST, TESTSTART, TESTSIZE);
#else
    KERNEL_EXECVE(exit);
ffffffffc0203e62:	000a7797          	auipc	a5,0xa7
ffffffffc0203e66:	8ee7b783          	ld	a5,-1810(a5) # ffffffffc02aa750 <current>
ffffffffc0203e6a:	43cc                	lw	a1,4(a5)
{
ffffffffc0203e6c:	7139                	addi	sp,sp,-64
    KERNEL_EXECVE(exit);
ffffffffc0203e6e:	00003617          	auipc	a2,0x3
ffffffffc0203e72:	07260613          	addi	a2,a2,114 # ffffffffc0206ee0 <default_pmm_manager+0xa08>
ffffffffc0203e76:	00003517          	auipc	a0,0x3
ffffffffc0203e7a:	07250513          	addi	a0,a0,114 # ffffffffc0206ee8 <default_pmm_manager+0xa10>
{
ffffffffc0203e7e:	fc06                	sd	ra,56(sp)
    KERNEL_EXECVE(exit);
ffffffffc0203e80:	b14fc0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0203e84:	3fe07797          	auipc	a5,0x3fe07
ffffffffc0203e88:	29c78793          	addi	a5,a5,668 # b120 <_binary_obj___user_exit_out_size>
ffffffffc0203e8c:	e43e                	sd	a5,8(sp)
ffffffffc0203e8e:	00003517          	auipc	a0,0x3
ffffffffc0203e92:	05250513          	addi	a0,a0,82 # ffffffffc0206ee0 <default_pmm_manager+0xa08>
ffffffffc0203e96:	00026797          	auipc	a5,0x26
ffffffffc0203e9a:	69278793          	addi	a5,a5,1682 # ffffffffc022a528 <_binary_obj___user_exit_out_start>
ffffffffc0203e9e:	f03e                	sd	a5,32(sp)
ffffffffc0203ea0:	f42a                	sd	a0,40(sp)
    int64_t ret = 0, len = strlen(name);
ffffffffc0203ea2:	e802                	sd	zero,16(sp)
ffffffffc0203ea4:	732010ef          	jal	ra,ffffffffc02055d6 <strlen>
ffffffffc0203ea8:	ec2a                	sd	a0,24(sp)
    asm volatile(
ffffffffc0203eaa:	4511                	li	a0,4
ffffffffc0203eac:	55a2                	lw	a1,40(sp)
ffffffffc0203eae:	4662                	lw	a2,24(sp)
ffffffffc0203eb0:	5682                	lw	a3,32(sp)
ffffffffc0203eb2:	4722                	lw	a4,8(sp)
ffffffffc0203eb4:	48a9                	li	a7,10
ffffffffc0203eb6:	9002                	ebreak
ffffffffc0203eb8:	c82a                	sw	a0,16(sp)
    cprintf("ret = %d\n", ret);
ffffffffc0203eba:	65c2                	ld	a1,16(sp)
ffffffffc0203ebc:	00003517          	auipc	a0,0x3
ffffffffc0203ec0:	05450513          	addi	a0,a0,84 # ffffffffc0206f10 <default_pmm_manager+0xa38>
ffffffffc0203ec4:	ad0fc0ef          	jal	ra,ffffffffc0200194 <cprintf>
#endif
    panic("user_main execve failed.\n");
ffffffffc0203ec8:	00003617          	auipc	a2,0x3
ffffffffc0203ecc:	05860613          	addi	a2,a2,88 # ffffffffc0206f20 <default_pmm_manager+0xa48>
ffffffffc0203ed0:	3bf00593          	li	a1,959
ffffffffc0203ed4:	00003517          	auipc	a0,0x3
ffffffffc0203ed8:	06c50513          	addi	a0,a0,108 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0203edc:	db2fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203ee0 <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc0203ee0:	6d14                	ld	a3,24(a0)
{
ffffffffc0203ee2:	1141                	addi	sp,sp,-16
ffffffffc0203ee4:	e406                	sd	ra,8(sp)
ffffffffc0203ee6:	c02007b7          	lui	a5,0xc0200
ffffffffc0203eea:	02f6ee63          	bltu	a3,a5,ffffffffc0203f26 <put_pgdir+0x46>
ffffffffc0203eee:	000a7517          	auipc	a0,0xa7
ffffffffc0203ef2:	85a53503          	ld	a0,-1958(a0) # ffffffffc02aa748 <va_pa_offset>
ffffffffc0203ef6:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage)
ffffffffc0203ef8:	82b1                	srli	a3,a3,0xc
ffffffffc0203efa:	000a7797          	auipc	a5,0xa7
ffffffffc0203efe:	8367b783          	ld	a5,-1994(a5) # ffffffffc02aa730 <npage>
ffffffffc0203f02:	02f6fe63          	bgeu	a3,a5,ffffffffc0203f3e <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc0203f06:	00004517          	auipc	a0,0x4
ffffffffc0203f0a:	8d253503          	ld	a0,-1838(a0) # ffffffffc02077d8 <nbase>
}
ffffffffc0203f0e:	60a2                	ld	ra,8(sp)
ffffffffc0203f10:	8e89                	sub	a3,a3,a0
ffffffffc0203f12:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc0203f14:	000a7517          	auipc	a0,0xa7
ffffffffc0203f18:	82453503          	ld	a0,-2012(a0) # ffffffffc02aa738 <pages>
ffffffffc0203f1c:	4585                	li	a1,1
ffffffffc0203f1e:	9536                	add	a0,a0,a3
}
ffffffffc0203f20:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc0203f22:	f95fd06f          	j	ffffffffc0201eb6 <free_pages>
    return pa2page(PADDR(kva));
ffffffffc0203f26:	00002617          	auipc	a2,0x2
ffffffffc0203f2a:	69260613          	addi	a2,a2,1682 # ffffffffc02065b8 <default_pmm_manager+0xe0>
ffffffffc0203f2e:	07700593          	li	a1,119
ffffffffc0203f32:	00002517          	auipc	a0,0x2
ffffffffc0203f36:	60650513          	addi	a0,a0,1542 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0203f3a:	d54fc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203f3e:	00002617          	auipc	a2,0x2
ffffffffc0203f42:	6a260613          	addi	a2,a2,1698 # ffffffffc02065e0 <default_pmm_manager+0x108>
ffffffffc0203f46:	06900593          	li	a1,105
ffffffffc0203f4a:	00002517          	auipc	a0,0x2
ffffffffc0203f4e:	5ee50513          	addi	a0,a0,1518 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0203f52:	d3cfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203f56 <proc_run>:
{
ffffffffc0203f56:	7179                	addi	sp,sp,-48
ffffffffc0203f58:	f026                	sd	s1,32(sp)
    if (proc != current)
ffffffffc0203f5a:	000a6497          	auipc	s1,0xa6
ffffffffc0203f5e:	7f648493          	addi	s1,s1,2038 # ffffffffc02aa750 <current>
ffffffffc0203f62:	6098                	ld	a4,0(s1)
{
ffffffffc0203f64:	f406                	sd	ra,40(sp)
ffffffffc0203f66:	ec4a                	sd	s2,24(sp)
    if (proc != current)
ffffffffc0203f68:	02a70763          	beq	a4,a0,ffffffffc0203f96 <proc_run+0x40>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203f6c:	100027f3          	csrr	a5,sstatus
ffffffffc0203f70:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203f72:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203f74:	ef85                	bnez	a5,ffffffffc0203fac <proc_run+0x56>
#define barrier() __asm__ __volatile__("fence" ::: "memory")

static inline void
lsatp(unsigned long pgdir)
{
  write_csr(satp, 0x8000000000000000 | (pgdir >> RISCV_PGSHIFT));
ffffffffc0203f76:	755c                	ld	a5,168(a0)
ffffffffc0203f78:	56fd                	li	a3,-1
ffffffffc0203f7a:	16fe                	slli	a3,a3,0x3f
ffffffffc0203f7c:	83b1                	srli	a5,a5,0xc
        current = proc;
ffffffffc0203f7e:	e088                	sd	a0,0(s1)
ffffffffc0203f80:	8fd5                	or	a5,a5,a3
ffffffffc0203f82:	18079073          	csrw	satp,a5
        switch_to(&current_proc->context, &proc->context);//进行进程上下文切换，使用指针以修改原始值
ffffffffc0203f86:	03050593          	addi	a1,a0,48
ffffffffc0203f8a:	03070513          	addi	a0,a4,48
ffffffffc0203f8e:	7ef000ef          	jal	ra,ffffffffc0204f7c <switch_to>
    if (flag)
ffffffffc0203f92:	00091763          	bnez	s2,ffffffffc0203fa0 <proc_run+0x4a>
}
ffffffffc0203f96:	70a2                	ld	ra,40(sp)
ffffffffc0203f98:	7482                	ld	s1,32(sp)
ffffffffc0203f9a:	6962                	ld	s2,24(sp)
ffffffffc0203f9c:	6145                	addi	sp,sp,48
ffffffffc0203f9e:	8082                	ret
ffffffffc0203fa0:	70a2                	ld	ra,40(sp)
ffffffffc0203fa2:	7482                	ld	s1,32(sp)
ffffffffc0203fa4:	6962                	ld	s2,24(sp)
ffffffffc0203fa6:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0203fa8:	a07fc06f          	j	ffffffffc02009ae <intr_enable>
ffffffffc0203fac:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0203fae:	a07fc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        struct proc_struct *current_proc = current;
ffffffffc0203fb2:	6098                	ld	a4,0(s1)
        return 1;
ffffffffc0203fb4:	6522                	ld	a0,8(sp)
ffffffffc0203fb6:	4905                	li	s2,1
ffffffffc0203fb8:	bf7d                	j	ffffffffc0203f76 <proc_run+0x20>

ffffffffc0203fba <do_fork>:
{
ffffffffc0203fba:	7119                	addi	sp,sp,-128
ffffffffc0203fbc:	f0ca                	sd	s2,96(sp)
    if (nr_process >= MAX_PROCESS)
ffffffffc0203fbe:	000a6917          	auipc	s2,0xa6
ffffffffc0203fc2:	7aa90913          	addi	s2,s2,1962 # ffffffffc02aa768 <nr_process>
ffffffffc0203fc6:	00092703          	lw	a4,0(s2)
{
ffffffffc0203fca:	fc86                	sd	ra,120(sp)
ffffffffc0203fcc:	f8a2                	sd	s0,112(sp)
ffffffffc0203fce:	f4a6                	sd	s1,104(sp)
ffffffffc0203fd0:	ecce                	sd	s3,88(sp)
ffffffffc0203fd2:	e8d2                	sd	s4,80(sp)
ffffffffc0203fd4:	e4d6                	sd	s5,72(sp)
ffffffffc0203fd6:	e0da                	sd	s6,64(sp)
ffffffffc0203fd8:	fc5e                	sd	s7,56(sp)
ffffffffc0203fda:	f862                	sd	s8,48(sp)
ffffffffc0203fdc:	f466                	sd	s9,40(sp)
ffffffffc0203fde:	f06a                	sd	s10,32(sp)
ffffffffc0203fe0:	ec6e                	sd	s11,24(sp)
    if (nr_process >= MAX_PROCESS)
ffffffffc0203fe2:	6785                	lui	a5,0x1
ffffffffc0203fe4:	2ef75a63          	bge	a4,a5,ffffffffc02042d8 <do_fork+0x31e>
ffffffffc0203fe8:	8a2a                	mv	s4,a0
ffffffffc0203fea:	89ae                	mv	s3,a1
ffffffffc0203fec:	8432                	mv	s0,a2
    if ((proc = alloc_proc()) == NULL) {
ffffffffc0203fee:	df5ff0ef          	jal	ra,ffffffffc0203de2 <alloc_proc>
ffffffffc0203ff2:	84aa                	mv	s1,a0
ffffffffc0203ff4:	2c050663          	beqz	a0,ffffffffc02042c0 <do_fork+0x306>
    proc->parent = current;
ffffffffc0203ff8:	000a6c17          	auipc	s8,0xa6
ffffffffc0203ffc:	758c0c13          	addi	s8,s8,1880 # ffffffffc02aa750 <current>
ffffffffc0204000:	000c3783          	ld	a5,0(s8)
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0204004:	4509                	li	a0,2
    proc->parent = current;
ffffffffc0204006:	f09c                	sd	a5,32(s1)
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0204008:	e71fd0ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
    if (page != NULL)
ffffffffc020400c:	2a050763          	beqz	a0,ffffffffc02042ba <do_fork+0x300>
    return page - pages + nbase;
ffffffffc0204010:	000a6a97          	auipc	s5,0xa6
ffffffffc0204014:	728a8a93          	addi	s5,s5,1832 # ffffffffc02aa738 <pages>
ffffffffc0204018:	000ab683          	ld	a3,0(s5)
ffffffffc020401c:	00003b17          	auipc	s6,0x3
ffffffffc0204020:	7bcb0b13          	addi	s6,s6,1980 # ffffffffc02077d8 <nbase>
ffffffffc0204024:	000b3783          	ld	a5,0(s6)
ffffffffc0204028:	40d506b3          	sub	a3,a0,a3
    return KADDR(page2pa(page));
ffffffffc020402c:	000a6b97          	auipc	s7,0xa6
ffffffffc0204030:	704b8b93          	addi	s7,s7,1796 # ffffffffc02aa730 <npage>
    return page - pages + nbase;
ffffffffc0204034:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204036:	5dfd                	li	s11,-1
ffffffffc0204038:	000bb703          	ld	a4,0(s7)
    return page - pages + nbase;
ffffffffc020403c:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc020403e:	00cddd93          	srli	s11,s11,0xc
ffffffffc0204042:	01b6f633          	and	a2,a3,s11
    return page2ppn(page) << PGSHIFT;
ffffffffc0204046:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204048:	2ce67563          	bgeu	a2,a4,ffffffffc0204312 <do_fork+0x358>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc020404c:	000c3603          	ld	a2,0(s8)
ffffffffc0204050:	000a6c17          	auipc	s8,0xa6
ffffffffc0204054:	6f8c0c13          	addi	s8,s8,1784 # ffffffffc02aa748 <va_pa_offset>
ffffffffc0204058:	000c3703          	ld	a4,0(s8)
ffffffffc020405c:	02863d03          	ld	s10,40(a2)
ffffffffc0204060:	e43e                	sd	a5,8(sp)
ffffffffc0204062:	96ba                	add	a3,a3,a4
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc0204064:	e894                	sd	a3,16(s1)
    if (oldmm == NULL)
ffffffffc0204066:	020d0863          	beqz	s10,ffffffffc0204096 <do_fork+0xdc>
    if (clone_flags & CLONE_VM)
ffffffffc020406a:	100a7a13          	andi	s4,s4,256
ffffffffc020406e:	180a0863          	beqz	s4,ffffffffc02041fe <do_fork+0x244>
}

static inline int
mm_count_inc(struct mm_struct *mm)
{
    mm->mm_count += 1;
ffffffffc0204072:	030d2703          	lw	a4,48(s10)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0204076:	018d3783          	ld	a5,24(s10)
ffffffffc020407a:	c02006b7          	lui	a3,0xc0200
ffffffffc020407e:	2705                	addiw	a4,a4,1
ffffffffc0204080:	02ed2823          	sw	a4,48(s10)
    proc->mm = mm;
ffffffffc0204084:	03a4b423          	sd	s10,40(s1)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0204088:	2ad7e163          	bltu	a5,a3,ffffffffc020432a <do_fork+0x370>
ffffffffc020408c:	000c3703          	ld	a4,0(s8)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0204090:	6894                	ld	a3,16(s1)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0204092:	8f99                	sub	a5,a5,a4
ffffffffc0204094:	f4dc                	sd	a5,168(s1)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0204096:	6789                	lui	a5,0x2
ffffffffc0204098:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x7cd0>
ffffffffc020409c:	96be                	add	a3,a3,a5
    *(proc->tf) = *tf;
ffffffffc020409e:	8622                	mv	a2,s0
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc02040a0:	f0d4                	sd	a3,160(s1)
    *(proc->tf) = *tf;
ffffffffc02040a2:	87b6                	mv	a5,a3
ffffffffc02040a4:	12040893          	addi	a7,s0,288
ffffffffc02040a8:	00063803          	ld	a6,0(a2)
ffffffffc02040ac:	6608                	ld	a0,8(a2)
ffffffffc02040ae:	6a0c                	ld	a1,16(a2)
ffffffffc02040b0:	6e18                	ld	a4,24(a2)
ffffffffc02040b2:	0107b023          	sd	a6,0(a5)
ffffffffc02040b6:	e788                	sd	a0,8(a5)
ffffffffc02040b8:	eb8c                	sd	a1,16(a5)
ffffffffc02040ba:	ef98                	sd	a4,24(a5)
ffffffffc02040bc:	02060613          	addi	a2,a2,32
ffffffffc02040c0:	02078793          	addi	a5,a5,32
ffffffffc02040c4:	ff1612e3          	bne	a2,a7,ffffffffc02040a8 <do_fork+0xee>
    proc->tf->gpr.a0 = 0;
ffffffffc02040c8:	0406b823          	sd	zero,80(a3) # ffffffffc0200050 <kern_init+0x6>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc02040cc:	12098763          	beqz	s3,ffffffffc02041fa <do_fork+0x240>
    if (++last_pid >= MAX_PID)
ffffffffc02040d0:	000a2817          	auipc	a6,0xa2
ffffffffc02040d4:	1f080813          	addi	a6,a6,496 # ffffffffc02a62c0 <last_pid.1>
ffffffffc02040d8:	00082783          	lw	a5,0(a6)
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc02040dc:	0136b823          	sd	s3,16(a3)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc02040e0:	00000717          	auipc	a4,0x0
ffffffffc02040e4:	d7470713          	addi	a4,a4,-652 # ffffffffc0203e54 <forkret>
    if (++last_pid >= MAX_PID)
ffffffffc02040e8:	0017851b          	addiw	a0,a5,1
    proc->context.ra = (uintptr_t)forkret;
ffffffffc02040ec:	f898                	sd	a4,48(s1)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc02040ee:	fc94                	sd	a3,56(s1)
    if (++last_pid >= MAX_PID)
ffffffffc02040f0:	00a82023          	sw	a0,0(a6)
ffffffffc02040f4:	6789                	lui	a5,0x2
ffffffffc02040f6:	08f55b63          	bge	a0,a5,ffffffffc020418c <do_fork+0x1d2>
    if (last_pid >= next_safe)
ffffffffc02040fa:	000a2317          	auipc	t1,0xa2
ffffffffc02040fe:	1ca30313          	addi	t1,t1,458 # ffffffffc02a62c4 <next_safe.0>
ffffffffc0204102:	00032783          	lw	a5,0(t1)
ffffffffc0204106:	000a6417          	auipc	s0,0xa6
ffffffffc020410a:	5da40413          	addi	s0,s0,1498 # ffffffffc02aa6e0 <proc_list>
ffffffffc020410e:	08f55763          	bge	a0,a5,ffffffffc020419c <do_fork+0x1e2>
    proc->pid = get_pid();
ffffffffc0204112:	c0c8                	sw	a0,4(s1)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204114:	45a9                	li	a1,10
ffffffffc0204116:	2501                	sext.w	a0,a0
ffffffffc0204118:	0ba010ef          	jal	ra,ffffffffc02051d2 <hash32>
ffffffffc020411c:	02051793          	slli	a5,a0,0x20
ffffffffc0204120:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204124:	000a2797          	auipc	a5,0xa2
ffffffffc0204128:	5bc78793          	addi	a5,a5,1468 # ffffffffc02a66e0 <hash_list>
ffffffffc020412c:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc020412e:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0204130:	7094                	ld	a3,32(s1)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204132:	0d848793          	addi	a5,s1,216
    prev->next = next->prev = elm;
ffffffffc0204136:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc0204138:	6410                	ld	a2,8(s0)
    prev->next = next->prev = elm;
ffffffffc020413a:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc020413c:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc020413e:	0c848793          	addi	a5,s1,200
    elm->next = next;
ffffffffc0204142:	f0ec                	sd	a1,224(s1)
    elm->prev = prev;
ffffffffc0204144:	ece8                	sd	a0,216(s1)
    prev->next = next->prev = elm;
ffffffffc0204146:	e21c                	sd	a5,0(a2)
ffffffffc0204148:	e41c                	sd	a5,8(s0)
    elm->next = next;
ffffffffc020414a:	e8f0                	sd	a2,208(s1)
    elm->prev = prev;
ffffffffc020414c:	e4e0                	sd	s0,200(s1)
    proc->yptr = NULL;
ffffffffc020414e:	0e04bc23          	sd	zero,248(s1)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0204152:	10e4b023          	sd	a4,256(s1)
ffffffffc0204156:	c311                	beqz	a4,ffffffffc020415a <do_fork+0x1a0>
        proc->optr->yptr = proc;
ffffffffc0204158:	ff64                	sd	s1,248(a4)
    nr_process++;
ffffffffc020415a:	00092783          	lw	a5,0(s2)
    wakeup_proc(proc);
ffffffffc020415e:	8526                	mv	a0,s1
    proc->parent->cptr = proc;
ffffffffc0204160:	fae4                	sd	s1,240(a3)
    nr_process++;
ffffffffc0204162:	2785                	addiw	a5,a5,1
ffffffffc0204164:	00f92023          	sw	a5,0(s2)
    wakeup_proc(proc);
ffffffffc0204168:	67f000ef          	jal	ra,ffffffffc0204fe6 <wakeup_proc>
    ret = proc->pid;
ffffffffc020416c:	40c8                	lw	a0,4(s1)
}
ffffffffc020416e:	70e6                	ld	ra,120(sp)
ffffffffc0204170:	7446                	ld	s0,112(sp)
ffffffffc0204172:	74a6                	ld	s1,104(sp)
ffffffffc0204174:	7906                	ld	s2,96(sp)
ffffffffc0204176:	69e6                	ld	s3,88(sp)
ffffffffc0204178:	6a46                	ld	s4,80(sp)
ffffffffc020417a:	6aa6                	ld	s5,72(sp)
ffffffffc020417c:	6b06                	ld	s6,64(sp)
ffffffffc020417e:	7be2                	ld	s7,56(sp)
ffffffffc0204180:	7c42                	ld	s8,48(sp)
ffffffffc0204182:	7ca2                	ld	s9,40(sp)
ffffffffc0204184:	7d02                	ld	s10,32(sp)
ffffffffc0204186:	6de2                	ld	s11,24(sp)
ffffffffc0204188:	6109                	addi	sp,sp,128
ffffffffc020418a:	8082                	ret
        last_pid = 1;
ffffffffc020418c:	4785                	li	a5,1
ffffffffc020418e:	00f82023          	sw	a5,0(a6)
        goto inside;
ffffffffc0204192:	4505                	li	a0,1
ffffffffc0204194:	000a2317          	auipc	t1,0xa2
ffffffffc0204198:	13030313          	addi	t1,t1,304 # ffffffffc02a62c4 <next_safe.0>
    return listelm->next;
ffffffffc020419c:	000a6417          	auipc	s0,0xa6
ffffffffc02041a0:	54440413          	addi	s0,s0,1348 # ffffffffc02aa6e0 <proc_list>
ffffffffc02041a4:	00843e03          	ld	t3,8(s0)
        next_safe = MAX_PID;
ffffffffc02041a8:	6789                	lui	a5,0x2
ffffffffc02041aa:	00f32023          	sw	a5,0(t1)
ffffffffc02041ae:	86aa                	mv	a3,a0
ffffffffc02041b0:	4581                	li	a1,0
        while ((le = list_next(le)) != list)
ffffffffc02041b2:	6e89                	lui	t4,0x2
ffffffffc02041b4:	108e0d63          	beq	t3,s0,ffffffffc02042ce <do_fork+0x314>
ffffffffc02041b8:	88ae                	mv	a7,a1
ffffffffc02041ba:	87f2                	mv	a5,t3
ffffffffc02041bc:	6609                	lui	a2,0x2
ffffffffc02041be:	a811                	j	ffffffffc02041d2 <do_fork+0x218>
            else if (proc->pid > last_pid && next_safe > proc->pid)
ffffffffc02041c0:	00e6d663          	bge	a3,a4,ffffffffc02041cc <do_fork+0x212>
ffffffffc02041c4:	00c75463          	bge	a4,a2,ffffffffc02041cc <do_fork+0x212>
ffffffffc02041c8:	863a                	mv	a2,a4
ffffffffc02041ca:	4885                	li	a7,1
ffffffffc02041cc:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc02041ce:	00878d63          	beq	a5,s0,ffffffffc02041e8 <do_fork+0x22e>
            if (proc->pid == last_pid)
ffffffffc02041d2:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_obj___user_faultread_out_size-0x7c74>
ffffffffc02041d6:	fed715e3          	bne	a4,a3,ffffffffc02041c0 <do_fork+0x206>
                if (++last_pid >= next_safe)
ffffffffc02041da:	2685                	addiw	a3,a3,1
ffffffffc02041dc:	0ec6d463          	bge	a3,a2,ffffffffc02042c4 <do_fork+0x30a>
ffffffffc02041e0:	679c                	ld	a5,8(a5)
ffffffffc02041e2:	4585                	li	a1,1
        while ((le = list_next(le)) != list)
ffffffffc02041e4:	fe8797e3          	bne	a5,s0,ffffffffc02041d2 <do_fork+0x218>
ffffffffc02041e8:	c581                	beqz	a1,ffffffffc02041f0 <do_fork+0x236>
ffffffffc02041ea:	00d82023          	sw	a3,0(a6)
ffffffffc02041ee:	8536                	mv	a0,a3
ffffffffc02041f0:	f20881e3          	beqz	a7,ffffffffc0204112 <do_fork+0x158>
ffffffffc02041f4:	00c32023          	sw	a2,0(t1)
ffffffffc02041f8:	bf29                	j	ffffffffc0204112 <do_fork+0x158>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc02041fa:	89b6                	mv	s3,a3
ffffffffc02041fc:	bdd1                	j	ffffffffc02040d0 <do_fork+0x116>
    if ((mm = mm_create()) == NULL)
ffffffffc02041fe:	cd2ff0ef          	jal	ra,ffffffffc02036d0 <mm_create>
ffffffffc0204202:	8caa                	mv	s9,a0
ffffffffc0204204:	c159                	beqz	a0,ffffffffc020428a <do_fork+0x2d0>
    if ((page = alloc_page()) == NULL)
ffffffffc0204206:	4505                	li	a0,1
ffffffffc0204208:	c71fd0ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc020420c:	cd25                	beqz	a0,ffffffffc0204284 <do_fork+0x2ca>
    return page - pages + nbase;
ffffffffc020420e:	000ab683          	ld	a3,0(s5)
ffffffffc0204212:	67a2                	ld	a5,8(sp)
    return KADDR(page2pa(page));
ffffffffc0204214:	000bb703          	ld	a4,0(s7)
    return page - pages + nbase;
ffffffffc0204218:	40d506b3          	sub	a3,a0,a3
ffffffffc020421c:	8699                	srai	a3,a3,0x6
ffffffffc020421e:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204220:	01b6fdb3          	and	s11,a3,s11
    return page2ppn(page) << PGSHIFT;
ffffffffc0204224:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204226:	0eedf663          	bgeu	s11,a4,ffffffffc0204312 <do_fork+0x358>
ffffffffc020422a:	000c3a03          	ld	s4,0(s8)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc020422e:	6605                	lui	a2,0x1
ffffffffc0204230:	000a6597          	auipc	a1,0xa6
ffffffffc0204234:	4f85b583          	ld	a1,1272(a1) # ffffffffc02aa728 <boot_pgdir_va>
ffffffffc0204238:	9a36                	add	s4,s4,a3
ffffffffc020423a:	8552                	mv	a0,s4
ffffffffc020423c:	44e010ef          	jal	ra,ffffffffc020568a <memcpy>
static inline void
lock_mm(struct mm_struct *mm)
{
    if (mm != NULL)
    {
        lock(&(mm->mm_lock));
ffffffffc0204240:	038d0d93          	addi	s11,s10,56
    mm->pgdir = pgdir;
ffffffffc0204244:	014cbc23          	sd	s4,24(s9)
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0204248:	4785                	li	a5,1
ffffffffc020424a:	40fdb7af          	amoor.d	a5,a5,(s11)
}

static inline void
lock(lock_t *lock)
{
    while (!try_lock(lock))
ffffffffc020424e:	8b85                	andi	a5,a5,1
ffffffffc0204250:	4a05                	li	s4,1
ffffffffc0204252:	c799                	beqz	a5,ffffffffc0204260 <do_fork+0x2a6>
    {
        schedule();
ffffffffc0204254:	613000ef          	jal	ra,ffffffffc0205066 <schedule>
ffffffffc0204258:	414db7af          	amoor.d	a5,s4,(s11)
    while (!try_lock(lock))
ffffffffc020425c:	8b85                	andi	a5,a5,1
ffffffffc020425e:	fbfd                	bnez	a5,ffffffffc0204254 <do_fork+0x29a>
        ret = dup_mmap(mm, oldmm);
ffffffffc0204260:	85ea                	mv	a1,s10
ffffffffc0204262:	8566                	mv	a0,s9
ffffffffc0204264:	eaeff0ef          	jal	ra,ffffffffc0203912 <dup_mmap>
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0204268:	57f9                	li	a5,-2
ffffffffc020426a:	60fdb7af          	amoand.d	a5,a5,(s11)
ffffffffc020426e:	8b85                	andi	a5,a5,1
}

static inline void
unlock(lock_t *lock)
{
    if (!test_and_clear_bit(0, lock))
ffffffffc0204270:	cbad                	beqz	a5,ffffffffc02042e2 <do_fork+0x328>
good_mm:
ffffffffc0204272:	8d66                	mv	s10,s9
    if (ret != 0)
ffffffffc0204274:	de050fe3          	beqz	a0,ffffffffc0204072 <do_fork+0xb8>
    exit_mmap(mm);
ffffffffc0204278:	8566                	mv	a0,s9
ffffffffc020427a:	f32ff0ef          	jal	ra,ffffffffc02039ac <exit_mmap>
    put_pgdir(mm);
ffffffffc020427e:	8566                	mv	a0,s9
ffffffffc0204280:	c61ff0ef          	jal	ra,ffffffffc0203ee0 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204284:	8566                	mv	a0,s9
ffffffffc0204286:	d8aff0ef          	jal	ra,ffffffffc0203810 <mm_destroy>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc020428a:	6894                	ld	a3,16(s1)
    return pa2page(PADDR(kva));
ffffffffc020428c:	c02007b7          	lui	a5,0xc0200
ffffffffc0204290:	0af6ea63          	bltu	a3,a5,ffffffffc0204344 <do_fork+0x38a>
ffffffffc0204294:	000c3783          	ld	a5,0(s8)
    if (PPN(pa) >= npage)
ffffffffc0204298:	000bb703          	ld	a4,0(s7)
    return pa2page(PADDR(kva));
ffffffffc020429c:	40f687b3          	sub	a5,a3,a5
    if (PPN(pa) >= npage)
ffffffffc02042a0:	83b1                	srli	a5,a5,0xc
ffffffffc02042a2:	04e7fc63          	bgeu	a5,a4,ffffffffc02042fa <do_fork+0x340>
    return &pages[PPN(pa) - nbase];
ffffffffc02042a6:	000b3703          	ld	a4,0(s6)
ffffffffc02042aa:	000ab503          	ld	a0,0(s5)
ffffffffc02042ae:	4589                	li	a1,2
ffffffffc02042b0:	8f99                	sub	a5,a5,a4
ffffffffc02042b2:	079a                	slli	a5,a5,0x6
ffffffffc02042b4:	953e                	add	a0,a0,a5
ffffffffc02042b6:	c01fd0ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    kfree(proc);
ffffffffc02042ba:	8526                	mv	a0,s1
ffffffffc02042bc:	a8ffd0ef          	jal	ra,ffffffffc0201d4a <kfree>
    ret = -E_NO_MEM;
ffffffffc02042c0:	5571                	li	a0,-4
    return ret;
ffffffffc02042c2:	b575                	j	ffffffffc020416e <do_fork+0x1b4>
                    if (last_pid >= MAX_PID)
ffffffffc02042c4:	01d6c363          	blt	a3,t4,ffffffffc02042ca <do_fork+0x310>
                        last_pid = 1;
ffffffffc02042c8:	4685                	li	a3,1
                    goto repeat;
ffffffffc02042ca:	4585                	li	a1,1
ffffffffc02042cc:	b5e5                	j	ffffffffc02041b4 <do_fork+0x1fa>
ffffffffc02042ce:	c599                	beqz	a1,ffffffffc02042dc <do_fork+0x322>
ffffffffc02042d0:	00d82023          	sw	a3,0(a6)
    return last_pid;
ffffffffc02042d4:	8536                	mv	a0,a3
ffffffffc02042d6:	bd35                	j	ffffffffc0204112 <do_fork+0x158>
    int ret = -E_NO_FREE_PROC;
ffffffffc02042d8:	556d                	li	a0,-5
ffffffffc02042da:	bd51                	j	ffffffffc020416e <do_fork+0x1b4>
    return last_pid;
ffffffffc02042dc:	00082503          	lw	a0,0(a6)
ffffffffc02042e0:	bd0d                	j	ffffffffc0204112 <do_fork+0x158>
    {
        panic("Unlock failed.\n");
ffffffffc02042e2:	00003617          	auipc	a2,0x3
ffffffffc02042e6:	c7660613          	addi	a2,a2,-906 # ffffffffc0206f58 <default_pmm_manager+0xa80>
ffffffffc02042ea:	03f00593          	li	a1,63
ffffffffc02042ee:	00003517          	auipc	a0,0x3
ffffffffc02042f2:	c7a50513          	addi	a0,a0,-902 # ffffffffc0206f68 <default_pmm_manager+0xa90>
ffffffffc02042f6:	998fc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02042fa:	00002617          	auipc	a2,0x2
ffffffffc02042fe:	2e660613          	addi	a2,a2,742 # ffffffffc02065e0 <default_pmm_manager+0x108>
ffffffffc0204302:	06900593          	li	a1,105
ffffffffc0204306:	00002517          	auipc	a0,0x2
ffffffffc020430a:	23250513          	addi	a0,a0,562 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc020430e:	980fc0ef          	jal	ra,ffffffffc020048e <__panic>
    return KADDR(page2pa(page));
ffffffffc0204312:	00002617          	auipc	a2,0x2
ffffffffc0204316:	1fe60613          	addi	a2,a2,510 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc020431a:	07100593          	li	a1,113
ffffffffc020431e:	00002517          	auipc	a0,0x2
ffffffffc0204322:	21a50513          	addi	a0,a0,538 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0204326:	968fc0ef          	jal	ra,ffffffffc020048e <__panic>
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc020432a:	86be                	mv	a3,a5
ffffffffc020432c:	00002617          	auipc	a2,0x2
ffffffffc0204330:	28c60613          	addi	a2,a2,652 # ffffffffc02065b8 <default_pmm_manager+0xe0>
ffffffffc0204334:	18e00593          	li	a1,398
ffffffffc0204338:	00003517          	auipc	a0,0x3
ffffffffc020433c:	c0850513          	addi	a0,a0,-1016 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204340:	94efc0ef          	jal	ra,ffffffffc020048e <__panic>
    return pa2page(PADDR(kva));
ffffffffc0204344:	00002617          	auipc	a2,0x2
ffffffffc0204348:	27460613          	addi	a2,a2,628 # ffffffffc02065b8 <default_pmm_manager+0xe0>
ffffffffc020434c:	07700593          	li	a1,119
ffffffffc0204350:	00002517          	auipc	a0,0x2
ffffffffc0204354:	1e850513          	addi	a0,a0,488 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0204358:	936fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc020435c <kernel_thread>:
{
ffffffffc020435c:	7129                	addi	sp,sp,-320
ffffffffc020435e:	fa22                	sd	s0,304(sp)
ffffffffc0204360:	f626                	sd	s1,296(sp)
ffffffffc0204362:	f24a                	sd	s2,288(sp)
ffffffffc0204364:	84ae                	mv	s1,a1
ffffffffc0204366:	892a                	mv	s2,a0
ffffffffc0204368:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc020436a:	4581                	li	a1,0
ffffffffc020436c:	12000613          	li	a2,288
ffffffffc0204370:	850a                	mv	a0,sp
{
ffffffffc0204372:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0204374:	304010ef          	jal	ra,ffffffffc0205678 <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc0204378:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc020437a:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc020437c:	100027f3          	csrr	a5,sstatus
ffffffffc0204380:	edd7f793          	andi	a5,a5,-291
ffffffffc0204384:	1207e793          	ori	a5,a5,288
ffffffffc0204388:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020438a:	860a                	mv	a2,sp
ffffffffc020438c:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0204390:	00000797          	auipc	a5,0x0
ffffffffc0204394:	a4a78793          	addi	a5,a5,-1462 # ffffffffc0203dda <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc0204398:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc020439a:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020439c:	c1fff0ef          	jal	ra,ffffffffc0203fba <do_fork>
}
ffffffffc02043a0:	70f2                	ld	ra,312(sp)
ffffffffc02043a2:	7452                	ld	s0,304(sp)
ffffffffc02043a4:	74b2                	ld	s1,296(sp)
ffffffffc02043a6:	7912                	ld	s2,288(sp)
ffffffffc02043a8:	6131                	addi	sp,sp,320
ffffffffc02043aa:	8082                	ret

ffffffffc02043ac <do_exit>:
{
ffffffffc02043ac:	7179                	addi	sp,sp,-48
ffffffffc02043ae:	f022                	sd	s0,32(sp)
    if (current == idleproc)
ffffffffc02043b0:	000a6417          	auipc	s0,0xa6
ffffffffc02043b4:	3a040413          	addi	s0,s0,928 # ffffffffc02aa750 <current>
ffffffffc02043b8:	601c                	ld	a5,0(s0)
{
ffffffffc02043ba:	f406                	sd	ra,40(sp)
ffffffffc02043bc:	ec26                	sd	s1,24(sp)
ffffffffc02043be:	e84a                	sd	s2,16(sp)
ffffffffc02043c0:	e44e                	sd	s3,8(sp)
ffffffffc02043c2:	e052                	sd	s4,0(sp)
    if (current == idleproc)
ffffffffc02043c4:	000a6717          	auipc	a4,0xa6
ffffffffc02043c8:	39473703          	ld	a4,916(a4) # ffffffffc02aa758 <idleproc>
ffffffffc02043cc:	0ce78c63          	beq	a5,a4,ffffffffc02044a4 <do_exit+0xf8>
    if (current == initproc)
ffffffffc02043d0:	000a6497          	auipc	s1,0xa6
ffffffffc02043d4:	39048493          	addi	s1,s1,912 # ffffffffc02aa760 <initproc>
ffffffffc02043d8:	6098                	ld	a4,0(s1)
ffffffffc02043da:	0ee78b63          	beq	a5,a4,ffffffffc02044d0 <do_exit+0x124>
    struct mm_struct *mm = current->mm;
ffffffffc02043de:	0287b983          	ld	s3,40(a5)
ffffffffc02043e2:	892a                	mv	s2,a0
    if (mm != NULL)
ffffffffc02043e4:	02098663          	beqz	s3,ffffffffc0204410 <do_exit+0x64>
ffffffffc02043e8:	000a6797          	auipc	a5,0xa6
ffffffffc02043ec:	3387b783          	ld	a5,824(a5) # ffffffffc02aa720 <boot_pgdir_pa>
ffffffffc02043f0:	577d                	li	a4,-1
ffffffffc02043f2:	177e                	slli	a4,a4,0x3f
ffffffffc02043f4:	83b1                	srli	a5,a5,0xc
ffffffffc02043f6:	8fd9                	or	a5,a5,a4
ffffffffc02043f8:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc02043fc:	0309a783          	lw	a5,48(s3)
ffffffffc0204400:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204404:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0)
ffffffffc0204408:	cb55                	beqz	a4,ffffffffc02044bc <do_exit+0x110>
        current->mm = NULL;
ffffffffc020440a:	601c                	ld	a5,0(s0)
ffffffffc020440c:	0207b423          	sd	zero,40(a5)
    current->state = PROC_ZOMBIE;
ffffffffc0204410:	601c                	ld	a5,0(s0)
ffffffffc0204412:	470d                	li	a4,3
ffffffffc0204414:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc0204416:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020441a:	100027f3          	csrr	a5,sstatus
ffffffffc020441e:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0204420:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204422:	e3f9                	bnez	a5,ffffffffc02044e8 <do_exit+0x13c>
        proc = current->parent;
ffffffffc0204424:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD)
ffffffffc0204426:	800007b7          	lui	a5,0x80000
ffffffffc020442a:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc020442c:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD)
ffffffffc020442e:	0ec52703          	lw	a4,236(a0)
ffffffffc0204432:	0af70f63          	beq	a4,a5,ffffffffc02044f0 <do_exit+0x144>
        while (current->cptr != NULL)
ffffffffc0204436:	6018                	ld	a4,0(s0)
ffffffffc0204438:	7b7c                	ld	a5,240(a4)
ffffffffc020443a:	c3a1                	beqz	a5,ffffffffc020447a <do_exit+0xce>
                if (initproc->wait_state == WT_CHILD)
ffffffffc020443c:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204440:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD)
ffffffffc0204442:	0985                	addi	s3,s3,1
ffffffffc0204444:	a021                	j	ffffffffc020444c <do_exit+0xa0>
        while (current->cptr != NULL)
ffffffffc0204446:	6018                	ld	a4,0(s0)
ffffffffc0204448:	7b7c                	ld	a5,240(a4)
ffffffffc020444a:	cb85                	beqz	a5,ffffffffc020447a <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc020444c:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_exit_out_size+0xffffffff7fff4fe0>
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc0204450:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc0204452:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc0204454:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc0204456:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc020445a:	10e7b023          	sd	a4,256(a5)
ffffffffc020445e:	c311                	beqz	a4,ffffffffc0204462 <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc0204460:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204462:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc0204464:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc0204466:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204468:	fd271fe3          	bne	a4,s2,ffffffffc0204446 <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD)
ffffffffc020446c:	0ec52783          	lw	a5,236(a0)
ffffffffc0204470:	fd379be3          	bne	a5,s3,ffffffffc0204446 <do_exit+0x9a>
                    wakeup_proc(initproc);
ffffffffc0204474:	373000ef          	jal	ra,ffffffffc0204fe6 <wakeup_proc>
ffffffffc0204478:	b7f9                	j	ffffffffc0204446 <do_exit+0x9a>
    if (flag)
ffffffffc020447a:	020a1263          	bnez	s4,ffffffffc020449e <do_exit+0xf2>
    schedule();
ffffffffc020447e:	3e9000ef          	jal	ra,ffffffffc0205066 <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc0204482:	601c                	ld	a5,0(s0)
ffffffffc0204484:	00003617          	auipc	a2,0x3
ffffffffc0204488:	b1c60613          	addi	a2,a2,-1252 # ffffffffc0206fa0 <default_pmm_manager+0xac8>
ffffffffc020448c:	23c00593          	li	a1,572
ffffffffc0204490:	43d4                	lw	a3,4(a5)
ffffffffc0204492:	00003517          	auipc	a0,0x3
ffffffffc0204496:	aae50513          	addi	a0,a0,-1362 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc020449a:	ff5fb0ef          	jal	ra,ffffffffc020048e <__panic>
        intr_enable();
ffffffffc020449e:	d10fc0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02044a2:	bff1                	j	ffffffffc020447e <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc02044a4:	00003617          	auipc	a2,0x3
ffffffffc02044a8:	adc60613          	addi	a2,a2,-1316 # ffffffffc0206f80 <default_pmm_manager+0xaa8>
ffffffffc02044ac:	20800593          	li	a1,520
ffffffffc02044b0:	00003517          	auipc	a0,0x3
ffffffffc02044b4:	a9050513          	addi	a0,a0,-1392 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc02044b8:	fd7fb0ef          	jal	ra,ffffffffc020048e <__panic>
            exit_mmap(mm);
ffffffffc02044bc:	854e                	mv	a0,s3
ffffffffc02044be:	ceeff0ef          	jal	ra,ffffffffc02039ac <exit_mmap>
            put_pgdir(mm);
ffffffffc02044c2:	854e                	mv	a0,s3
ffffffffc02044c4:	a1dff0ef          	jal	ra,ffffffffc0203ee0 <put_pgdir>
            mm_destroy(mm);
ffffffffc02044c8:	854e                	mv	a0,s3
ffffffffc02044ca:	b46ff0ef          	jal	ra,ffffffffc0203810 <mm_destroy>
ffffffffc02044ce:	bf35                	j	ffffffffc020440a <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc02044d0:	00003617          	auipc	a2,0x3
ffffffffc02044d4:	ac060613          	addi	a2,a2,-1344 # ffffffffc0206f90 <default_pmm_manager+0xab8>
ffffffffc02044d8:	20c00593          	li	a1,524
ffffffffc02044dc:	00003517          	auipc	a0,0x3
ffffffffc02044e0:	a6450513          	addi	a0,a0,-1436 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc02044e4:	fabfb0ef          	jal	ra,ffffffffc020048e <__panic>
        intr_disable();
ffffffffc02044e8:	cccfc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc02044ec:	4a05                	li	s4,1
ffffffffc02044ee:	bf1d                	j	ffffffffc0204424 <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc02044f0:	2f7000ef          	jal	ra,ffffffffc0204fe6 <wakeup_proc>
ffffffffc02044f4:	b789                	j	ffffffffc0204436 <do_exit+0x8a>

ffffffffc02044f6 <do_wait.part.0>:
int do_wait(int pid, int *code_store)
ffffffffc02044f6:	715d                	addi	sp,sp,-80
ffffffffc02044f8:	f84a                	sd	s2,48(sp)
ffffffffc02044fa:	f44e                	sd	s3,40(sp)
        current->wait_state = WT_CHILD;
ffffffffc02044fc:	80000937          	lui	s2,0x80000
    if (0 < pid && pid < MAX_PID)
ffffffffc0204500:	6989                	lui	s3,0x2
int do_wait(int pid, int *code_store)
ffffffffc0204502:	fc26                	sd	s1,56(sp)
ffffffffc0204504:	f052                	sd	s4,32(sp)
ffffffffc0204506:	ec56                	sd	s5,24(sp)
ffffffffc0204508:	e85a                	sd	s6,16(sp)
ffffffffc020450a:	e45e                	sd	s7,8(sp)
ffffffffc020450c:	e486                	sd	ra,72(sp)
ffffffffc020450e:	e0a2                	sd	s0,64(sp)
ffffffffc0204510:	84aa                	mv	s1,a0
ffffffffc0204512:	8a2e                	mv	s4,a1
        proc = current->cptr;
ffffffffc0204514:	000a6b97          	auipc	s7,0xa6
ffffffffc0204518:	23cb8b93          	addi	s7,s7,572 # ffffffffc02aa750 <current>
    if (0 < pid && pid < MAX_PID)
ffffffffc020451c:	00050b1b          	sext.w	s6,a0
ffffffffc0204520:	fff50a9b          	addiw	s5,a0,-1
ffffffffc0204524:	19f9                	addi	s3,s3,-2
        current->wait_state = WT_CHILD;
ffffffffc0204526:	0905                	addi	s2,s2,1
    if (pid != 0)
ffffffffc0204528:	ccbd                	beqz	s1,ffffffffc02045a6 <do_wait.part.0+0xb0>
    if (0 < pid && pid < MAX_PID)
ffffffffc020452a:	0359e863          	bltu	s3,s5,ffffffffc020455a <do_wait.part.0+0x64>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc020452e:	45a9                	li	a1,10
ffffffffc0204530:	855a                	mv	a0,s6
ffffffffc0204532:	4a1000ef          	jal	ra,ffffffffc02051d2 <hash32>
ffffffffc0204536:	02051793          	slli	a5,a0,0x20
ffffffffc020453a:	01c7d513          	srli	a0,a5,0x1c
ffffffffc020453e:	000a2797          	auipc	a5,0xa2
ffffffffc0204542:	1a278793          	addi	a5,a5,418 # ffffffffc02a66e0 <hash_list>
ffffffffc0204546:	953e                	add	a0,a0,a5
ffffffffc0204548:	842a                	mv	s0,a0
        while ((le = list_next(le)) != list)
ffffffffc020454a:	a029                	j	ffffffffc0204554 <do_wait.part.0+0x5e>
            if (proc->pid == pid)
ffffffffc020454c:	f2c42783          	lw	a5,-212(s0)
ffffffffc0204550:	02978163          	beq	a5,s1,ffffffffc0204572 <do_wait.part.0+0x7c>
ffffffffc0204554:	6400                	ld	s0,8(s0)
        while ((le = list_next(le)) != list)
ffffffffc0204556:	fe851be3          	bne	a0,s0,ffffffffc020454c <do_wait.part.0+0x56>
    return -E_BAD_PROC;
ffffffffc020455a:	5579                	li	a0,-2
}
ffffffffc020455c:	60a6                	ld	ra,72(sp)
ffffffffc020455e:	6406                	ld	s0,64(sp)
ffffffffc0204560:	74e2                	ld	s1,56(sp)
ffffffffc0204562:	7942                	ld	s2,48(sp)
ffffffffc0204564:	79a2                	ld	s3,40(sp)
ffffffffc0204566:	7a02                	ld	s4,32(sp)
ffffffffc0204568:	6ae2                	ld	s5,24(sp)
ffffffffc020456a:	6b42                	ld	s6,16(sp)
ffffffffc020456c:	6ba2                	ld	s7,8(sp)
ffffffffc020456e:	6161                	addi	sp,sp,80
ffffffffc0204570:	8082                	ret
        if (proc != NULL && proc->parent == current)
ffffffffc0204572:	000bb683          	ld	a3,0(s7)
ffffffffc0204576:	f4843783          	ld	a5,-184(s0)
ffffffffc020457a:	fed790e3          	bne	a5,a3,ffffffffc020455a <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc020457e:	f2842703          	lw	a4,-216(s0)
ffffffffc0204582:	478d                	li	a5,3
ffffffffc0204584:	0ef70b63          	beq	a4,a5,ffffffffc020467a <do_wait.part.0+0x184>
        current->state = PROC_SLEEPING;
ffffffffc0204588:	4785                	li	a5,1
ffffffffc020458a:	c29c                	sw	a5,0(a3)
        current->wait_state = WT_CHILD;
ffffffffc020458c:	0f26a623          	sw	s2,236(a3)
        schedule();
ffffffffc0204590:	2d7000ef          	jal	ra,ffffffffc0205066 <schedule>
        if (current->flags & PF_EXITING)
ffffffffc0204594:	000bb783          	ld	a5,0(s7)
ffffffffc0204598:	0b07a783          	lw	a5,176(a5)
ffffffffc020459c:	8b85                	andi	a5,a5,1
ffffffffc020459e:	d7c9                	beqz	a5,ffffffffc0204528 <do_wait.part.0+0x32>
            do_exit(-E_KILLED);
ffffffffc02045a0:	555d                	li	a0,-9
ffffffffc02045a2:	e0bff0ef          	jal	ra,ffffffffc02043ac <do_exit>
        proc = current->cptr;
ffffffffc02045a6:	000bb683          	ld	a3,0(s7)
ffffffffc02045aa:	7ae0                	ld	s0,240(a3)
        for (; proc != NULL; proc = proc->optr)
ffffffffc02045ac:	d45d                	beqz	s0,ffffffffc020455a <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02045ae:	470d                	li	a4,3
ffffffffc02045b0:	a021                	j	ffffffffc02045b8 <do_wait.part.0+0xc2>
        for (; proc != NULL; proc = proc->optr)
ffffffffc02045b2:	10043403          	ld	s0,256(s0)
ffffffffc02045b6:	d869                	beqz	s0,ffffffffc0204588 <do_wait.part.0+0x92>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02045b8:	401c                	lw	a5,0(s0)
ffffffffc02045ba:	fee79ce3          	bne	a5,a4,ffffffffc02045b2 <do_wait.part.0+0xbc>
    if (proc == idleproc || proc == initproc)
ffffffffc02045be:	000a6797          	auipc	a5,0xa6
ffffffffc02045c2:	19a7b783          	ld	a5,410(a5) # ffffffffc02aa758 <idleproc>
ffffffffc02045c6:	0c878963          	beq	a5,s0,ffffffffc0204698 <do_wait.part.0+0x1a2>
ffffffffc02045ca:	000a6797          	auipc	a5,0xa6
ffffffffc02045ce:	1967b783          	ld	a5,406(a5) # ffffffffc02aa760 <initproc>
ffffffffc02045d2:	0cf40363          	beq	s0,a5,ffffffffc0204698 <do_wait.part.0+0x1a2>
    if (code_store != NULL)
ffffffffc02045d6:	000a0663          	beqz	s4,ffffffffc02045e2 <do_wait.part.0+0xec>
        *code_store = proc->exit_code;
ffffffffc02045da:	0e842783          	lw	a5,232(s0)
ffffffffc02045de:	00fa2023          	sw	a5,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8bb0>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02045e2:	100027f3          	csrr	a5,sstatus
ffffffffc02045e6:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02045e8:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02045ea:	e7c1                	bnez	a5,ffffffffc0204672 <do_wait.part.0+0x17c>
    __list_del(listelm->prev, listelm->next);
ffffffffc02045ec:	6c70                	ld	a2,216(s0)
ffffffffc02045ee:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL)
ffffffffc02045f0:	10043703          	ld	a4,256(s0)
        proc->optr->yptr = proc->yptr;
ffffffffc02045f4:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc02045f6:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc02045f8:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc02045fa:	6470                	ld	a2,200(s0)
ffffffffc02045fc:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc02045fe:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0204600:	e290                	sd	a2,0(a3)
    if (proc->optr != NULL)
ffffffffc0204602:	c319                	beqz	a4,ffffffffc0204608 <do_wait.part.0+0x112>
        proc->optr->yptr = proc->yptr;
ffffffffc0204604:	ff7c                	sd	a5,248(a4)
    if (proc->yptr != NULL)
ffffffffc0204606:	7c7c                	ld	a5,248(s0)
ffffffffc0204608:	c3b5                	beqz	a5,ffffffffc020466c <do_wait.part.0+0x176>
        proc->yptr->optr = proc->optr;
ffffffffc020460a:	10e7b023          	sd	a4,256(a5)
    nr_process--;
ffffffffc020460e:	000a6717          	auipc	a4,0xa6
ffffffffc0204612:	15a70713          	addi	a4,a4,346 # ffffffffc02aa768 <nr_process>
ffffffffc0204616:	431c                	lw	a5,0(a4)
ffffffffc0204618:	37fd                	addiw	a5,a5,-1
ffffffffc020461a:	c31c                	sw	a5,0(a4)
    if (flag)
ffffffffc020461c:	e5a9                	bnez	a1,ffffffffc0204666 <do_wait.part.0+0x170>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc020461e:	6814                	ld	a3,16(s0)
ffffffffc0204620:	c02007b7          	lui	a5,0xc0200
ffffffffc0204624:	04f6ee63          	bltu	a3,a5,ffffffffc0204680 <do_wait.part.0+0x18a>
ffffffffc0204628:	000a6797          	auipc	a5,0xa6
ffffffffc020462c:	1207b783          	ld	a5,288(a5) # ffffffffc02aa748 <va_pa_offset>
ffffffffc0204630:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage)
ffffffffc0204632:	82b1                	srli	a3,a3,0xc
ffffffffc0204634:	000a6797          	auipc	a5,0xa6
ffffffffc0204638:	0fc7b783          	ld	a5,252(a5) # ffffffffc02aa730 <npage>
ffffffffc020463c:	06f6fa63          	bgeu	a3,a5,ffffffffc02046b0 <do_wait.part.0+0x1ba>
    return &pages[PPN(pa) - nbase];
ffffffffc0204640:	00003517          	auipc	a0,0x3
ffffffffc0204644:	19853503          	ld	a0,408(a0) # ffffffffc02077d8 <nbase>
ffffffffc0204648:	8e89                	sub	a3,a3,a0
ffffffffc020464a:	069a                	slli	a3,a3,0x6
ffffffffc020464c:	000a6517          	auipc	a0,0xa6
ffffffffc0204650:	0ec53503          	ld	a0,236(a0) # ffffffffc02aa738 <pages>
ffffffffc0204654:	9536                	add	a0,a0,a3
ffffffffc0204656:	4589                	li	a1,2
ffffffffc0204658:	85ffd0ef          	jal	ra,ffffffffc0201eb6 <free_pages>
    kfree(proc);
ffffffffc020465c:	8522                	mv	a0,s0
ffffffffc020465e:	eecfd0ef          	jal	ra,ffffffffc0201d4a <kfree>
    return 0;
ffffffffc0204662:	4501                	li	a0,0
ffffffffc0204664:	bde5                	j	ffffffffc020455c <do_wait.part.0+0x66>
        intr_enable();
ffffffffc0204666:	b48fc0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020466a:	bf55                	j	ffffffffc020461e <do_wait.part.0+0x128>
        proc->parent->cptr = proc->optr;
ffffffffc020466c:	701c                	ld	a5,32(s0)
ffffffffc020466e:	fbf8                	sd	a4,240(a5)
ffffffffc0204670:	bf79                	j	ffffffffc020460e <do_wait.part.0+0x118>
        intr_disable();
ffffffffc0204672:	b42fc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0204676:	4585                	li	a1,1
ffffffffc0204678:	bf95                	j	ffffffffc02045ec <do_wait.part.0+0xf6>
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc020467a:	f2840413          	addi	s0,s0,-216
ffffffffc020467e:	b781                	j	ffffffffc02045be <do_wait.part.0+0xc8>
    return pa2page(PADDR(kva));
ffffffffc0204680:	00002617          	auipc	a2,0x2
ffffffffc0204684:	f3860613          	addi	a2,a2,-200 # ffffffffc02065b8 <default_pmm_manager+0xe0>
ffffffffc0204688:	07700593          	li	a1,119
ffffffffc020468c:	00002517          	auipc	a0,0x2
ffffffffc0204690:	eac50513          	addi	a0,a0,-340 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0204694:	dfbfb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("wait idleproc or initproc.\n");
ffffffffc0204698:	00003617          	auipc	a2,0x3
ffffffffc020469c:	92860613          	addi	a2,a2,-1752 # ffffffffc0206fc0 <default_pmm_manager+0xae8>
ffffffffc02046a0:	36700593          	li	a1,871
ffffffffc02046a4:	00003517          	auipc	a0,0x3
ffffffffc02046a8:	89c50513          	addi	a0,a0,-1892 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc02046ac:	de3fb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02046b0:	00002617          	auipc	a2,0x2
ffffffffc02046b4:	f3060613          	addi	a2,a2,-208 # ffffffffc02065e0 <default_pmm_manager+0x108>
ffffffffc02046b8:	06900593          	li	a1,105
ffffffffc02046bc:	00002517          	auipc	a0,0x2
ffffffffc02046c0:	e7c50513          	addi	a0,a0,-388 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc02046c4:	dcbfb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02046c8 <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg)
{
ffffffffc02046c8:	1141                	addi	sp,sp,-16
ffffffffc02046ca:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc02046cc:	82bfd0ef          	jal	ra,ffffffffc0201ef6 <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc02046d0:	dc6fd0ef          	jal	ra,ffffffffc0201c96 <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc02046d4:	4601                	li	a2,0
ffffffffc02046d6:	4581                	li	a1,0
ffffffffc02046d8:	fffff517          	auipc	a0,0xfffff
ffffffffc02046dc:	78a50513          	addi	a0,a0,1930 # ffffffffc0203e62 <user_main>
ffffffffc02046e0:	c7dff0ef          	jal	ra,ffffffffc020435c <kernel_thread>
    if (pid <= 0)
ffffffffc02046e4:	00a04563          	bgtz	a0,ffffffffc02046ee <init_main+0x26>
ffffffffc02046e8:	a071                	j	ffffffffc0204774 <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0)
    {
        schedule();
ffffffffc02046ea:	17d000ef          	jal	ra,ffffffffc0205066 <schedule>
    if (code_store != NULL)
ffffffffc02046ee:	4581                	li	a1,0
ffffffffc02046f0:	4501                	li	a0,0
ffffffffc02046f2:	e05ff0ef          	jal	ra,ffffffffc02044f6 <do_wait.part.0>
    while (do_wait(0, NULL) == 0)
ffffffffc02046f6:	d975                	beqz	a0,ffffffffc02046ea <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc02046f8:	00003517          	auipc	a0,0x3
ffffffffc02046fc:	90850513          	addi	a0,a0,-1784 # ffffffffc0207000 <default_pmm_manager+0xb28>
ffffffffc0204700:	a95fb0ef          	jal	ra,ffffffffc0200194 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0204704:	000a6797          	auipc	a5,0xa6
ffffffffc0204708:	05c7b783          	ld	a5,92(a5) # ffffffffc02aa760 <initproc>
ffffffffc020470c:	7bf8                	ld	a4,240(a5)
ffffffffc020470e:	e339                	bnez	a4,ffffffffc0204754 <init_main+0x8c>
ffffffffc0204710:	7ff8                	ld	a4,248(a5)
ffffffffc0204712:	e329                	bnez	a4,ffffffffc0204754 <init_main+0x8c>
ffffffffc0204714:	1007b703          	ld	a4,256(a5)
ffffffffc0204718:	ef15                	bnez	a4,ffffffffc0204754 <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc020471a:	000a6697          	auipc	a3,0xa6
ffffffffc020471e:	04e6a683          	lw	a3,78(a3) # ffffffffc02aa768 <nr_process>
ffffffffc0204722:	4709                	li	a4,2
ffffffffc0204724:	0ae69463          	bne	a3,a4,ffffffffc02047cc <init_main+0x104>
    return listelm->next;
ffffffffc0204728:	000a6697          	auipc	a3,0xa6
ffffffffc020472c:	fb868693          	addi	a3,a3,-72 # ffffffffc02aa6e0 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0204730:	6698                	ld	a4,8(a3)
ffffffffc0204732:	0c878793          	addi	a5,a5,200
ffffffffc0204736:	06f71b63          	bne	a4,a5,ffffffffc02047ac <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc020473a:	629c                	ld	a5,0(a3)
ffffffffc020473c:	04f71863          	bne	a4,a5,ffffffffc020478c <init_main+0xc4>

    cprintf("init check memory pass.\n");
ffffffffc0204740:	00003517          	auipc	a0,0x3
ffffffffc0204744:	9a850513          	addi	a0,a0,-1624 # ffffffffc02070e8 <default_pmm_manager+0xc10>
ffffffffc0204748:	a4dfb0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return 0;
}
ffffffffc020474c:	60a2                	ld	ra,8(sp)
ffffffffc020474e:	4501                	li	a0,0
ffffffffc0204750:	0141                	addi	sp,sp,16
ffffffffc0204752:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0204754:	00003697          	auipc	a3,0x3
ffffffffc0204758:	8d468693          	addi	a3,a3,-1836 # ffffffffc0207028 <default_pmm_manager+0xb50>
ffffffffc020475c:	00002617          	auipc	a2,0x2
ffffffffc0204760:	9cc60613          	addi	a2,a2,-1588 # ffffffffc0206128 <commands+0x818>
ffffffffc0204764:	3d500593          	li	a1,981
ffffffffc0204768:	00002517          	auipc	a0,0x2
ffffffffc020476c:	7d850513          	addi	a0,a0,2008 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204770:	d1ffb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("create user_main failed.\n");
ffffffffc0204774:	00003617          	auipc	a2,0x3
ffffffffc0204778:	86c60613          	addi	a2,a2,-1940 # ffffffffc0206fe0 <default_pmm_manager+0xb08>
ffffffffc020477c:	3cc00593          	li	a1,972
ffffffffc0204780:	00002517          	auipc	a0,0x2
ffffffffc0204784:	7c050513          	addi	a0,a0,1984 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204788:	d07fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc020478c:	00003697          	auipc	a3,0x3
ffffffffc0204790:	92c68693          	addi	a3,a3,-1748 # ffffffffc02070b8 <default_pmm_manager+0xbe0>
ffffffffc0204794:	00002617          	auipc	a2,0x2
ffffffffc0204798:	99460613          	addi	a2,a2,-1644 # ffffffffc0206128 <commands+0x818>
ffffffffc020479c:	3d800593          	li	a1,984
ffffffffc02047a0:	00002517          	auipc	a0,0x2
ffffffffc02047a4:	7a050513          	addi	a0,a0,1952 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc02047a8:	ce7fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc02047ac:	00003697          	auipc	a3,0x3
ffffffffc02047b0:	8dc68693          	addi	a3,a3,-1828 # ffffffffc0207088 <default_pmm_manager+0xbb0>
ffffffffc02047b4:	00002617          	auipc	a2,0x2
ffffffffc02047b8:	97460613          	addi	a2,a2,-1676 # ffffffffc0206128 <commands+0x818>
ffffffffc02047bc:	3d700593          	li	a1,983
ffffffffc02047c0:	00002517          	auipc	a0,0x2
ffffffffc02047c4:	78050513          	addi	a0,a0,1920 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc02047c8:	cc7fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_process == 2);
ffffffffc02047cc:	00003697          	auipc	a3,0x3
ffffffffc02047d0:	8ac68693          	addi	a3,a3,-1876 # ffffffffc0207078 <default_pmm_manager+0xba0>
ffffffffc02047d4:	00002617          	auipc	a2,0x2
ffffffffc02047d8:	95460613          	addi	a2,a2,-1708 # ffffffffc0206128 <commands+0x818>
ffffffffc02047dc:	3d600593          	li	a1,982
ffffffffc02047e0:	00002517          	auipc	a0,0x2
ffffffffc02047e4:	76050513          	addi	a0,a0,1888 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc02047e8:	ca7fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02047ec <do_execve>:
{
ffffffffc02047ec:	7171                	addi	sp,sp,-176
ffffffffc02047ee:	e4ee                	sd	s11,72(sp)
    struct mm_struct *mm = current->mm;
ffffffffc02047f0:	000a6d97          	auipc	s11,0xa6
ffffffffc02047f4:	f60d8d93          	addi	s11,s11,-160 # ffffffffc02aa750 <current>
ffffffffc02047f8:	000db783          	ld	a5,0(s11)
{
ffffffffc02047fc:	e54e                	sd	s3,136(sp)
ffffffffc02047fe:	ed26                	sd	s1,152(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0204800:	0287b983          	ld	s3,40(a5)
{
ffffffffc0204804:	e94a                	sd	s2,144(sp)
ffffffffc0204806:	f4de                	sd	s7,104(sp)
ffffffffc0204808:	892a                	mv	s2,a0
ffffffffc020480a:	8bb2                	mv	s7,a2
ffffffffc020480c:	84ae                	mv	s1,a1
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) //检查name的内存空间能否被访问
ffffffffc020480e:	862e                	mv	a2,a1
ffffffffc0204810:	4681                	li	a3,0
ffffffffc0204812:	85aa                	mv	a1,a0
ffffffffc0204814:	854e                	mv	a0,s3
{
ffffffffc0204816:	f506                	sd	ra,168(sp)
ffffffffc0204818:	f122                	sd	s0,160(sp)
ffffffffc020481a:	e152                	sd	s4,128(sp)
ffffffffc020481c:	fcd6                	sd	s5,120(sp)
ffffffffc020481e:	f8da                	sd	s6,112(sp)
ffffffffc0204820:	f0e2                	sd	s8,96(sp)
ffffffffc0204822:	ece6                	sd	s9,88(sp)
ffffffffc0204824:	e8ea                	sd	s10,80(sp)
ffffffffc0204826:	f05e                	sd	s7,32(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0)) //检查name的内存空间能否被访问
ffffffffc0204828:	d1eff0ef          	jal	ra,ffffffffc0203d46 <user_mem_check>
ffffffffc020482c:	40050a63          	beqz	a0,ffffffffc0204c40 <do_execve+0x454>
    memset(local_name, 0, sizeof(local_name));
ffffffffc0204830:	4641                	li	a2,16
ffffffffc0204832:	4581                	li	a1,0
ffffffffc0204834:	1808                	addi	a0,sp,48
ffffffffc0204836:	643000ef          	jal	ra,ffffffffc0205678 <memset>
    memcpy(local_name, name, len);
ffffffffc020483a:	47bd                	li	a5,15
ffffffffc020483c:	8626                	mv	a2,s1
ffffffffc020483e:	1e97e263          	bltu	a5,s1,ffffffffc0204a22 <do_execve+0x236>
ffffffffc0204842:	85ca                	mv	a1,s2
ffffffffc0204844:	1808                	addi	a0,sp,48
ffffffffc0204846:	645000ef          	jal	ra,ffffffffc020568a <memcpy>
    if (mm != NULL)
ffffffffc020484a:	1e098363          	beqz	s3,ffffffffc0204a30 <do_execve+0x244>
        cputs("mm != NULL");
ffffffffc020484e:	00002517          	auipc	a0,0x2
ffffffffc0204852:	4ba50513          	addi	a0,a0,1210 # ffffffffc0206d08 <default_pmm_manager+0x830>
ffffffffc0204856:	977fb0ef          	jal	ra,ffffffffc02001cc <cputs>
ffffffffc020485a:	000a6797          	auipc	a5,0xa6
ffffffffc020485e:	ec67b783          	ld	a5,-314(a5) # ffffffffc02aa720 <boot_pgdir_pa>
ffffffffc0204862:	577d                	li	a4,-1
ffffffffc0204864:	177e                	slli	a4,a4,0x3f
ffffffffc0204866:	83b1                	srli	a5,a5,0xc
ffffffffc0204868:	8fd9                	or	a5,a5,a4
ffffffffc020486a:	18079073          	csrw	satp,a5
ffffffffc020486e:	0309a783          	lw	a5,48(s3) # 2030 <_binary_obj___user_faultread_out_size-0x7b80>
ffffffffc0204872:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204876:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0)
ffffffffc020487a:	2c070463          	beqz	a4,ffffffffc0204b42 <do_execve+0x356>
        current->mm = NULL;
ffffffffc020487e:	000db783          	ld	a5,0(s11)
ffffffffc0204882:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL)
ffffffffc0204886:	e4bfe0ef          	jal	ra,ffffffffc02036d0 <mm_create>
ffffffffc020488a:	84aa                	mv	s1,a0
ffffffffc020488c:	1c050d63          	beqz	a0,ffffffffc0204a66 <do_execve+0x27a>
    if ((page = alloc_page()) == NULL)
ffffffffc0204890:	4505                	li	a0,1
ffffffffc0204892:	de6fd0ef          	jal	ra,ffffffffc0201e78 <alloc_pages>
ffffffffc0204896:	3a050963          	beqz	a0,ffffffffc0204c48 <do_execve+0x45c>
    return page - pages + nbase;
ffffffffc020489a:	000a6c97          	auipc	s9,0xa6
ffffffffc020489e:	e9ec8c93          	addi	s9,s9,-354 # ffffffffc02aa738 <pages>
ffffffffc02048a2:	000cb683          	ld	a3,0(s9)
    return KADDR(page2pa(page));
ffffffffc02048a6:	000a6c17          	auipc	s8,0xa6
ffffffffc02048aa:	e8ac0c13          	addi	s8,s8,-374 # ffffffffc02aa730 <npage>
    return page - pages + nbase;
ffffffffc02048ae:	00003717          	auipc	a4,0x3
ffffffffc02048b2:	f2a73703          	ld	a4,-214(a4) # ffffffffc02077d8 <nbase>
ffffffffc02048b6:	40d506b3          	sub	a3,a0,a3
ffffffffc02048ba:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02048bc:	5afd                	li	s5,-1
ffffffffc02048be:	000c3783          	ld	a5,0(s8)
    return page - pages + nbase;
ffffffffc02048c2:	96ba                	add	a3,a3,a4
ffffffffc02048c4:	e83a                	sd	a4,16(sp)
    return KADDR(page2pa(page));
ffffffffc02048c6:	00cad713          	srli	a4,s5,0xc
ffffffffc02048ca:	ec3a                	sd	a4,24(sp)
ffffffffc02048cc:	8f75                	and	a4,a4,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc02048ce:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02048d0:	38f77063          	bgeu	a4,a5,ffffffffc0204c50 <do_execve+0x464>
ffffffffc02048d4:	000a6b17          	auipc	s6,0xa6
ffffffffc02048d8:	e74b0b13          	addi	s6,s6,-396 # ffffffffc02aa748 <va_pa_offset>
ffffffffc02048dc:	000b3903          	ld	s2,0(s6)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc02048e0:	6605                	lui	a2,0x1
ffffffffc02048e2:	000a6597          	auipc	a1,0xa6
ffffffffc02048e6:	e465b583          	ld	a1,-442(a1) # ffffffffc02aa728 <boot_pgdir_va>
ffffffffc02048ea:	9936                	add	s2,s2,a3
ffffffffc02048ec:	854a                	mv	a0,s2
ffffffffc02048ee:	59d000ef          	jal	ra,ffffffffc020568a <memcpy>
    if (elf->e_magic != ELF_MAGIC)
ffffffffc02048f2:	7782                	ld	a5,32(sp)
ffffffffc02048f4:	4398                	lw	a4,0(a5)
ffffffffc02048f6:	464c47b7          	lui	a5,0x464c4
    mm->pgdir = pgdir;
ffffffffc02048fa:	0124bc23          	sd	s2,24(s1)
    if (elf->e_magic != ELF_MAGIC)
ffffffffc02048fe:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_exit_out_size+0x464b945f>
ffffffffc0204902:	14f71863          	bne	a4,a5,ffffffffc0204a52 <do_execve+0x266>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204906:	7682                	ld	a3,32(sp)
ffffffffc0204908:	0386d703          	lhu	a4,56(a3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc020490c:	0206b983          	ld	s3,32(a3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204910:	00371793          	slli	a5,a4,0x3
ffffffffc0204914:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0204916:	99b6                	add	s3,s3,a3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204918:	078e                	slli	a5,a5,0x3
ffffffffc020491a:	97ce                	add	a5,a5,s3
ffffffffc020491c:	f43e                	sd	a5,40(sp)
    for (; ph < ph_end; ph++)
ffffffffc020491e:	00f9fc63          	bgeu	s3,a5,ffffffffc0204936 <do_execve+0x14a>
        if (ph->p_type != ELF_PT_LOAD)
ffffffffc0204922:	0009a783          	lw	a5,0(s3)
ffffffffc0204926:	4705                	li	a4,1
ffffffffc0204928:	14e78163          	beq	a5,a4,ffffffffc0204a6a <do_execve+0x27e>
    for (; ph < ph_end; ph++)
ffffffffc020492c:	77a2                	ld	a5,40(sp)
ffffffffc020492e:	03898993          	addi	s3,s3,56
ffffffffc0204932:	fef9e8e3          	bltu	s3,a5,ffffffffc0204922 <do_execve+0x136>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0)
ffffffffc0204936:	4701                	li	a4,0
ffffffffc0204938:	46ad                	li	a3,11
ffffffffc020493a:	00100637          	lui	a2,0x100
ffffffffc020493e:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0204942:	8526                	mv	a0,s1
ffffffffc0204944:	f1ffe0ef          	jal	ra,ffffffffc0203862 <mm_map>
ffffffffc0204948:	8a2a                	mv	s4,a0
ffffffffc020494a:	1e051263          	bnez	a0,ffffffffc0204b2e <do_execve+0x342>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc020494e:	6c88                	ld	a0,24(s1)
ffffffffc0204950:	467d                	li	a2,31
ffffffffc0204952:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0204956:	c95fe0ef          	jal	ra,ffffffffc02035ea <pgdir_alloc_page>
ffffffffc020495a:	38050363          	beqz	a0,ffffffffc0204ce0 <do_execve+0x4f4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc020495e:	6c88                	ld	a0,24(s1)
ffffffffc0204960:	467d                	li	a2,31
ffffffffc0204962:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0204966:	c85fe0ef          	jal	ra,ffffffffc02035ea <pgdir_alloc_page>
ffffffffc020496a:	34050b63          	beqz	a0,ffffffffc0204cc0 <do_execve+0x4d4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc020496e:	6c88                	ld	a0,24(s1)
ffffffffc0204970:	467d                	li	a2,31
ffffffffc0204972:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0204976:	c75fe0ef          	jal	ra,ffffffffc02035ea <pgdir_alloc_page>
ffffffffc020497a:	32050363          	beqz	a0,ffffffffc0204ca0 <do_execve+0x4b4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc020497e:	6c88                	ld	a0,24(s1)
ffffffffc0204980:	467d                	li	a2,31
ffffffffc0204982:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc0204986:	c65fe0ef          	jal	ra,ffffffffc02035ea <pgdir_alloc_page>
ffffffffc020498a:	2e050b63          	beqz	a0,ffffffffc0204c80 <do_execve+0x494>
    mm->mm_count += 1;
ffffffffc020498e:	589c                	lw	a5,48(s1)
    current->mm = mm;
ffffffffc0204990:	000db603          	ld	a2,0(s11)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204994:	6c94                	ld	a3,24(s1)
ffffffffc0204996:	2785                	addiw	a5,a5,1
ffffffffc0204998:	d89c                	sw	a5,48(s1)
    current->mm = mm;
ffffffffc020499a:	f604                	sd	s1,40(a2)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc020499c:	c02007b7          	lui	a5,0xc0200
ffffffffc02049a0:	2cf6e463          	bltu	a3,a5,ffffffffc0204c68 <do_execve+0x47c>
ffffffffc02049a4:	000b3783          	ld	a5,0(s6)
ffffffffc02049a8:	577d                	li	a4,-1
ffffffffc02049aa:	177e                	slli	a4,a4,0x3f
ffffffffc02049ac:	8e9d                	sub	a3,a3,a5
ffffffffc02049ae:	00c6d793          	srli	a5,a3,0xc
ffffffffc02049b2:	f654                	sd	a3,168(a2)
ffffffffc02049b4:	8fd9                	or	a5,a5,a4
ffffffffc02049b6:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc02049ba:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc02049bc:	4581                	li	a1,0
ffffffffc02049be:	12000613          	li	a2,288
ffffffffc02049c2:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc02049c4:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc02049c8:	4b1000ef          	jal	ra,ffffffffc0205678 <memset>
    tf->epc = elf->e_entry;
ffffffffc02049cc:	7782                	ld	a5,32(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049ce:	000db903          	ld	s2,0(s11)
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02049d2:	edf4f493          	andi	s1,s1,-289
    tf->epc = elf->e_entry;
ffffffffc02049d6:	6f98                	ld	a4,24(a5)
    tf->gpr.sp = USTACKTOP;
ffffffffc02049d8:	4785                	li	a5,1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049da:	0b490913          	addi	s2,s2,180 # ffffffff800000b4 <_binary_obj___user_exit_out_size+0xffffffff7fff4f94>
    tf->gpr.sp = USTACKTOP;
ffffffffc02049de:	07fe                	slli	a5,a5,0x1f
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02049e0:	0204e493          	ori	s1,s1,32
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049e4:	4641                	li	a2,16
ffffffffc02049e6:	4581                	li	a1,0
    tf->gpr.sp = USTACKTOP;
ffffffffc02049e8:	e81c                	sd	a5,16(s0)
    tf->epc = elf->e_entry;
ffffffffc02049ea:	10e43423          	sd	a4,264(s0)
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02049ee:	10943023          	sd	s1,256(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02049f2:	854a                	mv	a0,s2
ffffffffc02049f4:	485000ef          	jal	ra,ffffffffc0205678 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc02049f8:	463d                	li	a2,15
ffffffffc02049fa:	180c                	addi	a1,sp,48
ffffffffc02049fc:	854a                	mv	a0,s2
ffffffffc02049fe:	48d000ef          	jal	ra,ffffffffc020568a <memcpy>
}
ffffffffc0204a02:	70aa                	ld	ra,168(sp)
ffffffffc0204a04:	740a                	ld	s0,160(sp)
ffffffffc0204a06:	64ea                	ld	s1,152(sp)
ffffffffc0204a08:	694a                	ld	s2,144(sp)
ffffffffc0204a0a:	69aa                	ld	s3,136(sp)
ffffffffc0204a0c:	7ae6                	ld	s5,120(sp)
ffffffffc0204a0e:	7b46                	ld	s6,112(sp)
ffffffffc0204a10:	7ba6                	ld	s7,104(sp)
ffffffffc0204a12:	7c06                	ld	s8,96(sp)
ffffffffc0204a14:	6ce6                	ld	s9,88(sp)
ffffffffc0204a16:	6d46                	ld	s10,80(sp)
ffffffffc0204a18:	6da6                	ld	s11,72(sp)
ffffffffc0204a1a:	8552                	mv	a0,s4
ffffffffc0204a1c:	6a0a                	ld	s4,128(sp)
ffffffffc0204a1e:	614d                	addi	sp,sp,176
ffffffffc0204a20:	8082                	ret
    memcpy(local_name, name, len);
ffffffffc0204a22:	463d                	li	a2,15
ffffffffc0204a24:	85ca                	mv	a1,s2
ffffffffc0204a26:	1808                	addi	a0,sp,48
ffffffffc0204a28:	463000ef          	jal	ra,ffffffffc020568a <memcpy>
    if (mm != NULL)
ffffffffc0204a2c:	e20991e3          	bnez	s3,ffffffffc020484e <do_execve+0x62>
    if (current->mm != NULL)
ffffffffc0204a30:	000db783          	ld	a5,0(s11)
ffffffffc0204a34:	779c                	ld	a5,40(a5)
ffffffffc0204a36:	e40788e3          	beqz	a5,ffffffffc0204886 <do_execve+0x9a>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc0204a3a:	00002617          	auipc	a2,0x2
ffffffffc0204a3e:	6ce60613          	addi	a2,a2,1742 # ffffffffc0207108 <default_pmm_manager+0xc30>
ffffffffc0204a42:	24800593          	li	a1,584
ffffffffc0204a46:	00002517          	auipc	a0,0x2
ffffffffc0204a4a:	4fa50513          	addi	a0,a0,1274 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204a4e:	a41fb0ef          	jal	ra,ffffffffc020048e <__panic>
    put_pgdir(mm);
ffffffffc0204a52:	8526                	mv	a0,s1
ffffffffc0204a54:	c8cff0ef          	jal	ra,ffffffffc0203ee0 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204a58:	8526                	mv	a0,s1
ffffffffc0204a5a:	db7fe0ef          	jal	ra,ffffffffc0203810 <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0204a5e:	5a61                	li	s4,-8
    do_exit(ret);
ffffffffc0204a60:	8552                	mv	a0,s4
ffffffffc0204a62:	94bff0ef          	jal	ra,ffffffffc02043ac <do_exit>
    int ret = -E_NO_MEM;
ffffffffc0204a66:	5a71                	li	s4,-4
ffffffffc0204a68:	bfe5                	j	ffffffffc0204a60 <do_execve+0x274>
        if (ph->p_filesz > ph->p_memsz)
ffffffffc0204a6a:	0289b603          	ld	a2,40(s3)
ffffffffc0204a6e:	0209b783          	ld	a5,32(s3)
ffffffffc0204a72:	1cf66d63          	bltu	a2,a5,ffffffffc0204c4c <do_execve+0x460>
        if (ph->p_flags & ELF_PF_X)
ffffffffc0204a76:	0049a783          	lw	a5,4(s3)
ffffffffc0204a7a:	0017f693          	andi	a3,a5,1
ffffffffc0204a7e:	c291                	beqz	a3,ffffffffc0204a82 <do_execve+0x296>
            vm_flags |= VM_EXEC;
ffffffffc0204a80:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204a82:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204a86:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204a88:	e779                	bnez	a4,ffffffffc0204b56 <do_execve+0x36a>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc0204a8a:	4d45                	li	s10,17
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204a8c:	c781                	beqz	a5,ffffffffc0204a94 <do_execve+0x2a8>
            vm_flags |= VM_READ;
ffffffffc0204a8e:	0016e693          	ori	a3,a3,1
            perm |= PTE_R;
ffffffffc0204a92:	4d4d                	li	s10,19
        if (vm_flags & VM_WRITE)
ffffffffc0204a94:	0026f793          	andi	a5,a3,2
ffffffffc0204a98:	e3f1                	bnez	a5,ffffffffc0204b5c <do_execve+0x370>
        if (vm_flags & VM_EXEC)
ffffffffc0204a9a:	0046f793          	andi	a5,a3,4
ffffffffc0204a9e:	c399                	beqz	a5,ffffffffc0204aa4 <do_execve+0x2b8>
            perm |= PTE_X;
ffffffffc0204aa0:	008d6d13          	ori	s10,s10,8
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0)
ffffffffc0204aa4:	0109b583          	ld	a1,16(s3)
ffffffffc0204aa8:	4701                	li	a4,0
ffffffffc0204aaa:	8526                	mv	a0,s1
ffffffffc0204aac:	db7fe0ef          	jal	ra,ffffffffc0203862 <mm_map>
ffffffffc0204ab0:	8a2a                	mv	s4,a0
ffffffffc0204ab2:	ed35                	bnez	a0,ffffffffc0204b2e <do_execve+0x342>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204ab4:	0109bb83          	ld	s7,16(s3)
ffffffffc0204ab8:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc0204aba:	0209ba03          	ld	s4,32(s3)
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204abe:	0089b903          	ld	s2,8(s3)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204ac2:	00fbfab3          	and	s5,s7,a5
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204ac6:	7782                	ld	a5,32(sp)
        end = ph->p_va + ph->p_filesz;
ffffffffc0204ac8:	9a5e                	add	s4,s4,s7
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204aca:	993e                	add	s2,s2,a5
        while (start < end)
ffffffffc0204acc:	054be963          	bltu	s7,s4,ffffffffc0204b1e <do_execve+0x332>
ffffffffc0204ad0:	aa95                	j	ffffffffc0204c44 <do_execve+0x458>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204ad2:	6785                	lui	a5,0x1
ffffffffc0204ad4:	415b8533          	sub	a0,s7,s5
ffffffffc0204ad8:	9abe                	add	s5,s5,a5
ffffffffc0204ada:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc0204ade:	015a7463          	bgeu	s4,s5,ffffffffc0204ae6 <do_execve+0x2fa>
                size -= la - end;
ffffffffc0204ae2:	417a0633          	sub	a2,s4,s7
    return page - pages + nbase;
ffffffffc0204ae6:	000cb683          	ld	a3,0(s9)
ffffffffc0204aea:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204aec:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204af0:	40d406b3          	sub	a3,s0,a3
ffffffffc0204af4:	8699                	srai	a3,a3,0x6
ffffffffc0204af6:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204af8:	67e2                	ld	a5,24(sp)
ffffffffc0204afa:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204afe:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204b00:	14b87863          	bgeu	a6,a1,ffffffffc0204c50 <do_execve+0x464>
ffffffffc0204b04:	000b3803          	ld	a6,0(s6)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b08:	85ca                	mv	a1,s2
            start += size, from += size;
ffffffffc0204b0a:	9bb2                	add	s7,s7,a2
ffffffffc0204b0c:	96c2                	add	a3,a3,a6
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b0e:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc0204b10:	e432                	sd	a2,8(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b12:	379000ef          	jal	ra,ffffffffc020568a <memcpy>
            start += size, from += size;
ffffffffc0204b16:	6622                	ld	a2,8(sp)
ffffffffc0204b18:	9932                	add	s2,s2,a2
        while (start < end)
ffffffffc0204b1a:	054bf363          	bgeu	s7,s4,ffffffffc0204b60 <do_execve+0x374>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204b1e:	6c88                	ld	a0,24(s1)
ffffffffc0204b20:	866a                	mv	a2,s10
ffffffffc0204b22:	85d6                	mv	a1,s5
ffffffffc0204b24:	ac7fe0ef          	jal	ra,ffffffffc02035ea <pgdir_alloc_page>
ffffffffc0204b28:	842a                	mv	s0,a0
ffffffffc0204b2a:	f545                	bnez	a0,ffffffffc0204ad2 <do_execve+0x2e6>
        ret = -E_NO_MEM;
ffffffffc0204b2c:	5a71                	li	s4,-4
    exit_mmap(mm);
ffffffffc0204b2e:	8526                	mv	a0,s1
ffffffffc0204b30:	e7dfe0ef          	jal	ra,ffffffffc02039ac <exit_mmap>
    put_pgdir(mm);
ffffffffc0204b34:	8526                	mv	a0,s1
ffffffffc0204b36:	baaff0ef          	jal	ra,ffffffffc0203ee0 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204b3a:	8526                	mv	a0,s1
ffffffffc0204b3c:	cd5fe0ef          	jal	ra,ffffffffc0203810 <mm_destroy>
    return ret;
ffffffffc0204b40:	b705                	j	ffffffffc0204a60 <do_execve+0x274>
            exit_mmap(mm);
ffffffffc0204b42:	854e                	mv	a0,s3
ffffffffc0204b44:	e69fe0ef          	jal	ra,ffffffffc02039ac <exit_mmap>
            put_pgdir(mm);
ffffffffc0204b48:	854e                	mv	a0,s3
ffffffffc0204b4a:	b96ff0ef          	jal	ra,ffffffffc0203ee0 <put_pgdir>
            mm_destroy(mm);//把进程当前占用的内存释放，之后重新分配内存
ffffffffc0204b4e:	854e                	mv	a0,s3
ffffffffc0204b50:	cc1fe0ef          	jal	ra,ffffffffc0203810 <mm_destroy>
ffffffffc0204b54:	b32d                	j	ffffffffc020487e <do_execve+0x92>
            vm_flags |= VM_WRITE;
ffffffffc0204b56:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204b5a:	fb95                	bnez	a5,ffffffffc0204a8e <do_execve+0x2a2>
            perm |= (PTE_W | PTE_R);
ffffffffc0204b5c:	4d5d                	li	s10,23
ffffffffc0204b5e:	bf35                	j	ffffffffc0204a9a <do_execve+0x2ae>
        end = ph->p_va + ph->p_memsz;
ffffffffc0204b60:	0109b683          	ld	a3,16(s3)
ffffffffc0204b64:	0289b903          	ld	s2,40(s3)
ffffffffc0204b68:	9936                	add	s2,s2,a3
        if (start < la)
ffffffffc0204b6a:	075bfd63          	bgeu	s7,s5,ffffffffc0204be4 <do_execve+0x3f8>
            if (start == end)
ffffffffc0204b6e:	db790fe3          	beq	s2,s7,ffffffffc020492c <do_execve+0x140>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204b72:	6785                	lui	a5,0x1
ffffffffc0204b74:	00fb8533          	add	a0,s7,a5
ffffffffc0204b78:	41550533          	sub	a0,a0,s5
                size -= la - end;
ffffffffc0204b7c:	41790a33          	sub	s4,s2,s7
            if (end < la)
ffffffffc0204b80:	0b597d63          	bgeu	s2,s5,ffffffffc0204c3a <do_execve+0x44e>
    return page - pages + nbase;
ffffffffc0204b84:	000cb683          	ld	a3,0(s9)
ffffffffc0204b88:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204b8a:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc0204b8e:	40d406b3          	sub	a3,s0,a3
ffffffffc0204b92:	8699                	srai	a3,a3,0x6
ffffffffc0204b94:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204b96:	67e2                	ld	a5,24(sp)
ffffffffc0204b98:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204b9c:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204b9e:	0ac5f963          	bgeu	a1,a2,ffffffffc0204c50 <do_execve+0x464>
ffffffffc0204ba2:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204ba6:	8652                	mv	a2,s4
ffffffffc0204ba8:	4581                	li	a1,0
ffffffffc0204baa:	96c2                	add	a3,a3,a6
ffffffffc0204bac:	9536                	add	a0,a0,a3
ffffffffc0204bae:	2cb000ef          	jal	ra,ffffffffc0205678 <memset>
            start += size;
ffffffffc0204bb2:	017a0733          	add	a4,s4,s7
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc0204bb6:	03597463          	bgeu	s2,s5,ffffffffc0204bde <do_execve+0x3f2>
ffffffffc0204bba:	d6e909e3          	beq	s2,a4,ffffffffc020492c <do_execve+0x140>
ffffffffc0204bbe:	00002697          	auipc	a3,0x2
ffffffffc0204bc2:	57268693          	addi	a3,a3,1394 # ffffffffc0207130 <default_pmm_manager+0xc58>
ffffffffc0204bc6:	00001617          	auipc	a2,0x1
ffffffffc0204bca:	56260613          	addi	a2,a2,1378 # ffffffffc0206128 <commands+0x818>
ffffffffc0204bce:	2b300593          	li	a1,691
ffffffffc0204bd2:	00002517          	auipc	a0,0x2
ffffffffc0204bd6:	36e50513          	addi	a0,a0,878 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204bda:	8b5fb0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0204bde:	ff5710e3          	bne	a4,s5,ffffffffc0204bbe <do_execve+0x3d2>
ffffffffc0204be2:	8bd6                	mv	s7,s5
        while (start < end)
ffffffffc0204be4:	d52bf4e3          	bgeu	s7,s2,ffffffffc020492c <do_execve+0x140>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204be8:	6c88                	ld	a0,24(s1)
ffffffffc0204bea:	866a                	mv	a2,s10
ffffffffc0204bec:	85d6                	mv	a1,s5
ffffffffc0204bee:	9fdfe0ef          	jal	ra,ffffffffc02035ea <pgdir_alloc_page>
ffffffffc0204bf2:	842a                	mv	s0,a0
ffffffffc0204bf4:	dd05                	beqz	a0,ffffffffc0204b2c <do_execve+0x340>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204bf6:	6785                	lui	a5,0x1
ffffffffc0204bf8:	415b8533          	sub	a0,s7,s5
ffffffffc0204bfc:	9abe                	add	s5,s5,a5
ffffffffc0204bfe:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc0204c02:	01597463          	bgeu	s2,s5,ffffffffc0204c0a <do_execve+0x41e>
                size -= la - end;
ffffffffc0204c06:	41790633          	sub	a2,s2,s7
    return page - pages + nbase;
ffffffffc0204c0a:	000cb683          	ld	a3,0(s9)
ffffffffc0204c0e:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204c10:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204c14:	40d406b3          	sub	a3,s0,a3
ffffffffc0204c18:	8699                	srai	a3,a3,0x6
ffffffffc0204c1a:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204c1c:	67e2                	ld	a5,24(sp)
ffffffffc0204c1e:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204c22:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204c24:	02b87663          	bgeu	a6,a1,ffffffffc0204c50 <do_execve+0x464>
ffffffffc0204c28:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c2c:	4581                	li	a1,0
            start += size;
ffffffffc0204c2e:	9bb2                	add	s7,s7,a2
ffffffffc0204c30:	96c2                	add	a3,a3,a6
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c32:	9536                	add	a0,a0,a3
ffffffffc0204c34:	245000ef          	jal	ra,ffffffffc0205678 <memset>
ffffffffc0204c38:	b775                	j	ffffffffc0204be4 <do_execve+0x3f8>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204c3a:	417a8a33          	sub	s4,s5,s7
ffffffffc0204c3e:	b799                	j	ffffffffc0204b84 <do_execve+0x398>
        return -E_INVAL;
ffffffffc0204c40:	5a75                	li	s4,-3
ffffffffc0204c42:	b3c1                	j	ffffffffc0204a02 <do_execve+0x216>
        while (start < end)
ffffffffc0204c44:	86de                	mv	a3,s7
ffffffffc0204c46:	bf39                	j	ffffffffc0204b64 <do_execve+0x378>
    int ret = -E_NO_MEM;
ffffffffc0204c48:	5a71                	li	s4,-4
ffffffffc0204c4a:	bdc5                	j	ffffffffc0204b3a <do_execve+0x34e>
            ret = -E_INVAL_ELF;
ffffffffc0204c4c:	5a61                	li	s4,-8
ffffffffc0204c4e:	b5c5                	j	ffffffffc0204b2e <do_execve+0x342>
ffffffffc0204c50:	00002617          	auipc	a2,0x2
ffffffffc0204c54:	8c060613          	addi	a2,a2,-1856 # ffffffffc0206510 <default_pmm_manager+0x38>
ffffffffc0204c58:	07100593          	li	a1,113
ffffffffc0204c5c:	00002517          	auipc	a0,0x2
ffffffffc0204c60:	8dc50513          	addi	a0,a0,-1828 # ffffffffc0206538 <default_pmm_manager+0x60>
ffffffffc0204c64:	82bfb0ef          	jal	ra,ffffffffc020048e <__panic>
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204c68:	00002617          	auipc	a2,0x2
ffffffffc0204c6c:	95060613          	addi	a2,a2,-1712 # ffffffffc02065b8 <default_pmm_manager+0xe0>
ffffffffc0204c70:	2d200593          	li	a1,722
ffffffffc0204c74:	00002517          	auipc	a0,0x2
ffffffffc0204c78:	2cc50513          	addi	a0,a0,716 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204c7c:	813fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204c80:	00002697          	auipc	a3,0x2
ffffffffc0204c84:	5c868693          	addi	a3,a3,1480 # ffffffffc0207248 <default_pmm_manager+0xd70>
ffffffffc0204c88:	00001617          	auipc	a2,0x1
ffffffffc0204c8c:	4a060613          	addi	a2,a2,1184 # ffffffffc0206128 <commands+0x818>
ffffffffc0204c90:	2cd00593          	li	a1,717
ffffffffc0204c94:	00002517          	auipc	a0,0x2
ffffffffc0204c98:	2ac50513          	addi	a0,a0,684 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204c9c:	ff2fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204ca0:	00002697          	auipc	a3,0x2
ffffffffc0204ca4:	56068693          	addi	a3,a3,1376 # ffffffffc0207200 <default_pmm_manager+0xd28>
ffffffffc0204ca8:	00001617          	auipc	a2,0x1
ffffffffc0204cac:	48060613          	addi	a2,a2,1152 # ffffffffc0206128 <commands+0x818>
ffffffffc0204cb0:	2cc00593          	li	a1,716
ffffffffc0204cb4:	00002517          	auipc	a0,0x2
ffffffffc0204cb8:	28c50513          	addi	a0,a0,652 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204cbc:	fd2fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204cc0:	00002697          	auipc	a3,0x2
ffffffffc0204cc4:	4f868693          	addi	a3,a3,1272 # ffffffffc02071b8 <default_pmm_manager+0xce0>
ffffffffc0204cc8:	00001617          	auipc	a2,0x1
ffffffffc0204ccc:	46060613          	addi	a2,a2,1120 # ffffffffc0206128 <commands+0x818>
ffffffffc0204cd0:	2cb00593          	li	a1,715
ffffffffc0204cd4:	00002517          	auipc	a0,0x2
ffffffffc0204cd8:	26c50513          	addi	a0,a0,620 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204cdc:	fb2fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc0204ce0:	00002697          	auipc	a3,0x2
ffffffffc0204ce4:	49068693          	addi	a3,a3,1168 # ffffffffc0207170 <default_pmm_manager+0xc98>
ffffffffc0204ce8:	00001617          	auipc	a2,0x1
ffffffffc0204cec:	44060613          	addi	a2,a2,1088 # ffffffffc0206128 <commands+0x818>
ffffffffc0204cf0:	2ca00593          	li	a1,714
ffffffffc0204cf4:	00002517          	auipc	a0,0x2
ffffffffc0204cf8:	24c50513          	addi	a0,a0,588 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204cfc:	f92fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204d00 <do_yield>:
    current->need_resched = 1;
ffffffffc0204d00:	000a6797          	auipc	a5,0xa6
ffffffffc0204d04:	a507b783          	ld	a5,-1456(a5) # ffffffffc02aa750 <current>
ffffffffc0204d08:	4705                	li	a4,1
ffffffffc0204d0a:	ef98                	sd	a4,24(a5)
}
ffffffffc0204d0c:	4501                	li	a0,0
ffffffffc0204d0e:	8082                	ret

ffffffffc0204d10 <do_wait>:
{
ffffffffc0204d10:	1101                	addi	sp,sp,-32
ffffffffc0204d12:	e822                	sd	s0,16(sp)
ffffffffc0204d14:	e426                	sd	s1,8(sp)
ffffffffc0204d16:	ec06                	sd	ra,24(sp)
ffffffffc0204d18:	842e                	mv	s0,a1
ffffffffc0204d1a:	84aa                	mv	s1,a0
    if (code_store != NULL)
ffffffffc0204d1c:	c999                	beqz	a1,ffffffffc0204d32 <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc0204d1e:	000a6797          	auipc	a5,0xa6
ffffffffc0204d22:	a327b783          	ld	a5,-1486(a5) # ffffffffc02aa750 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1))
ffffffffc0204d26:	7788                	ld	a0,40(a5)
ffffffffc0204d28:	4685                	li	a3,1
ffffffffc0204d2a:	4611                	li	a2,4
ffffffffc0204d2c:	81aff0ef          	jal	ra,ffffffffc0203d46 <user_mem_check>
ffffffffc0204d30:	c909                	beqz	a0,ffffffffc0204d42 <do_wait+0x32>
ffffffffc0204d32:	85a2                	mv	a1,s0
}
ffffffffc0204d34:	6442                	ld	s0,16(sp)
ffffffffc0204d36:	60e2                	ld	ra,24(sp)
ffffffffc0204d38:	8526                	mv	a0,s1
ffffffffc0204d3a:	64a2                	ld	s1,8(sp)
ffffffffc0204d3c:	6105                	addi	sp,sp,32
ffffffffc0204d3e:	fb8ff06f          	j	ffffffffc02044f6 <do_wait.part.0>
ffffffffc0204d42:	60e2                	ld	ra,24(sp)
ffffffffc0204d44:	6442                	ld	s0,16(sp)
ffffffffc0204d46:	64a2                	ld	s1,8(sp)
ffffffffc0204d48:	5575                	li	a0,-3
ffffffffc0204d4a:	6105                	addi	sp,sp,32
ffffffffc0204d4c:	8082                	ret

ffffffffc0204d4e <do_kill>:
{
ffffffffc0204d4e:	1141                	addi	sp,sp,-16
    if (0 < pid && pid < MAX_PID)
ffffffffc0204d50:	6789                	lui	a5,0x2
{
ffffffffc0204d52:	e406                	sd	ra,8(sp)
ffffffffc0204d54:	e022                	sd	s0,0(sp)
    if (0 < pid && pid < MAX_PID)
ffffffffc0204d56:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204d5a:	17f9                	addi	a5,a5,-2
ffffffffc0204d5c:	02e7e963          	bltu	a5,a4,ffffffffc0204d8e <do_kill+0x40>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204d60:	842a                	mv	s0,a0
ffffffffc0204d62:	45a9                	li	a1,10
ffffffffc0204d64:	2501                	sext.w	a0,a0
ffffffffc0204d66:	46c000ef          	jal	ra,ffffffffc02051d2 <hash32>
ffffffffc0204d6a:	02051793          	slli	a5,a0,0x20
ffffffffc0204d6e:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204d72:	000a2797          	auipc	a5,0xa2
ffffffffc0204d76:	96e78793          	addi	a5,a5,-1682 # ffffffffc02a66e0 <hash_list>
ffffffffc0204d7a:	953e                	add	a0,a0,a5
ffffffffc0204d7c:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list)
ffffffffc0204d7e:	a029                	j	ffffffffc0204d88 <do_kill+0x3a>
            if (proc->pid == pid)
ffffffffc0204d80:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0204d84:	00870b63          	beq	a4,s0,ffffffffc0204d9a <do_kill+0x4c>
ffffffffc0204d88:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204d8a:	fef51be3          	bne	a0,a5,ffffffffc0204d80 <do_kill+0x32>
    return -E_INVAL;
ffffffffc0204d8e:	5475                	li	s0,-3
}
ffffffffc0204d90:	60a2                	ld	ra,8(sp)
ffffffffc0204d92:	8522                	mv	a0,s0
ffffffffc0204d94:	6402                	ld	s0,0(sp)
ffffffffc0204d96:	0141                	addi	sp,sp,16
ffffffffc0204d98:	8082                	ret
        if (!(proc->flags & PF_EXITING))
ffffffffc0204d9a:	fd87a703          	lw	a4,-40(a5)
ffffffffc0204d9e:	00177693          	andi	a3,a4,1
ffffffffc0204da2:	e295                	bnez	a3,ffffffffc0204dc6 <do_kill+0x78>
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204da4:	4bd4                	lw	a3,20(a5)
            proc->flags |= PF_EXITING;
ffffffffc0204da6:	00176713          	ori	a4,a4,1
ffffffffc0204daa:	fce7ac23          	sw	a4,-40(a5)
            return 0;
ffffffffc0204dae:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204db0:	fe06d0e3          	bgez	a3,ffffffffc0204d90 <do_kill+0x42>
                wakeup_proc(proc);
ffffffffc0204db4:	f2878513          	addi	a0,a5,-216
ffffffffc0204db8:	22e000ef          	jal	ra,ffffffffc0204fe6 <wakeup_proc>
}
ffffffffc0204dbc:	60a2                	ld	ra,8(sp)
ffffffffc0204dbe:	8522                	mv	a0,s0
ffffffffc0204dc0:	6402                	ld	s0,0(sp)
ffffffffc0204dc2:	0141                	addi	sp,sp,16
ffffffffc0204dc4:	8082                	ret
        return -E_KILLED;
ffffffffc0204dc6:	545d                	li	s0,-9
ffffffffc0204dc8:	b7e1                	j	ffffffffc0204d90 <do_kill+0x42>

ffffffffc0204dca <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and
//           - create the second kernel thread init_main
void proc_init(void)
{
ffffffffc0204dca:	1101                	addi	sp,sp,-32
ffffffffc0204dcc:	e426                	sd	s1,8(sp)
    elm->prev = elm->next = elm;
ffffffffc0204dce:	000a6797          	auipc	a5,0xa6
ffffffffc0204dd2:	91278793          	addi	a5,a5,-1774 # ffffffffc02aa6e0 <proc_list>
ffffffffc0204dd6:	ec06                	sd	ra,24(sp)
ffffffffc0204dd8:	e822                	sd	s0,16(sp)
ffffffffc0204dda:	e04a                	sd	s2,0(sp)
ffffffffc0204ddc:	000a2497          	auipc	s1,0xa2
ffffffffc0204de0:	90448493          	addi	s1,s1,-1788 # ffffffffc02a66e0 <hash_list>
ffffffffc0204de4:	e79c                	sd	a5,8(a5)
ffffffffc0204de6:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i++)
ffffffffc0204de8:	000a6717          	auipc	a4,0xa6
ffffffffc0204dec:	8f870713          	addi	a4,a4,-1800 # ffffffffc02aa6e0 <proc_list>
ffffffffc0204df0:	87a6                	mv	a5,s1
ffffffffc0204df2:	e79c                	sd	a5,8(a5)
ffffffffc0204df4:	e39c                	sd	a5,0(a5)
ffffffffc0204df6:	07c1                	addi	a5,a5,16
ffffffffc0204df8:	fef71de3          	bne	a4,a5,ffffffffc0204df2 <proc_init+0x28>
    {
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL)
ffffffffc0204dfc:	fe7fe0ef          	jal	ra,ffffffffc0203de2 <alloc_proc>
ffffffffc0204e00:	000a6917          	auipc	s2,0xa6
ffffffffc0204e04:	95890913          	addi	s2,s2,-1704 # ffffffffc02aa758 <idleproc>
ffffffffc0204e08:	00a93023          	sd	a0,0(s2)
ffffffffc0204e0c:	0e050f63          	beqz	a0,ffffffffc0204f0a <proc_init+0x140>
    {
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204e10:	4789                	li	a5,2
ffffffffc0204e12:	e11c                	sd	a5,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204e14:	00003797          	auipc	a5,0x3
ffffffffc0204e18:	1ec78793          	addi	a5,a5,492 # ffffffffc0208000 <bootstack>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e1c:	0b450413          	addi	s0,a0,180
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204e20:	e91c                	sd	a5,16(a0)
    idleproc->need_resched = 1;
ffffffffc0204e22:	4785                	li	a5,1
ffffffffc0204e24:	ed1c                	sd	a5,24(a0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e26:	4641                	li	a2,16
ffffffffc0204e28:	4581                	li	a1,0
ffffffffc0204e2a:	8522                	mv	a0,s0
ffffffffc0204e2c:	04d000ef          	jal	ra,ffffffffc0205678 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204e30:	463d                	li	a2,15
ffffffffc0204e32:	00002597          	auipc	a1,0x2
ffffffffc0204e36:	47658593          	addi	a1,a1,1142 # ffffffffc02072a8 <default_pmm_manager+0xdd0>
ffffffffc0204e3a:	8522                	mv	a0,s0
ffffffffc0204e3c:	04f000ef          	jal	ra,ffffffffc020568a <memcpy>
    set_proc_name(idleproc, "idle");
    nr_process++;
ffffffffc0204e40:	000a6717          	auipc	a4,0xa6
ffffffffc0204e44:	92870713          	addi	a4,a4,-1752 # ffffffffc02aa768 <nr_process>
ffffffffc0204e48:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc0204e4a:	00093683          	ld	a3,0(s2)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204e4e:	4601                	li	a2,0
    nr_process++;
ffffffffc0204e50:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204e52:	4581                	li	a1,0
ffffffffc0204e54:	00000517          	auipc	a0,0x0
ffffffffc0204e58:	87450513          	addi	a0,a0,-1932 # ffffffffc02046c8 <init_main>
    nr_process++;
ffffffffc0204e5c:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc0204e5e:	000a6797          	auipc	a5,0xa6
ffffffffc0204e62:	8ed7b923          	sd	a3,-1806(a5) # ffffffffc02aa750 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204e66:	cf6ff0ef          	jal	ra,ffffffffc020435c <kernel_thread>
ffffffffc0204e6a:	842a                	mv	s0,a0
    if (pid <= 0)
ffffffffc0204e6c:	08a05363          	blez	a0,ffffffffc0204ef2 <proc_init+0x128>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204e70:	6789                	lui	a5,0x2
ffffffffc0204e72:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204e76:	17f9                	addi	a5,a5,-2
ffffffffc0204e78:	2501                	sext.w	a0,a0
ffffffffc0204e7a:	02e7e363          	bltu	a5,a4,ffffffffc0204ea0 <proc_init+0xd6>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204e7e:	45a9                	li	a1,10
ffffffffc0204e80:	352000ef          	jal	ra,ffffffffc02051d2 <hash32>
ffffffffc0204e84:	02051793          	slli	a5,a0,0x20
ffffffffc0204e88:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0204e8c:	96a6                	add	a3,a3,s1
ffffffffc0204e8e:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list)
ffffffffc0204e90:	a029                	j	ffffffffc0204e9a <proc_init+0xd0>
            if (proc->pid == pid)
ffffffffc0204e92:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_obj___user_faultread_out_size-0x7c84>
ffffffffc0204e96:	04870b63          	beq	a4,s0,ffffffffc0204eec <proc_init+0x122>
    return listelm->next;
ffffffffc0204e9a:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204e9c:	fef69be3          	bne	a3,a5,ffffffffc0204e92 <proc_init+0xc8>
    return NULL;
ffffffffc0204ea0:	4781                	li	a5,0
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204ea2:	0b478493          	addi	s1,a5,180
ffffffffc0204ea6:	4641                	li	a2,16
ffffffffc0204ea8:	4581                	li	a1,0
    {
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc0204eaa:	000a6417          	auipc	s0,0xa6
ffffffffc0204eae:	8b640413          	addi	s0,s0,-1866 # ffffffffc02aa760 <initproc>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204eb2:	8526                	mv	a0,s1
    initproc = find_proc(pid);
ffffffffc0204eb4:	e01c                	sd	a5,0(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204eb6:	7c2000ef          	jal	ra,ffffffffc0205678 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204eba:	463d                	li	a2,15
ffffffffc0204ebc:	00002597          	auipc	a1,0x2
ffffffffc0204ec0:	41458593          	addi	a1,a1,1044 # ffffffffc02072d0 <default_pmm_manager+0xdf8>
ffffffffc0204ec4:	8526                	mv	a0,s1
ffffffffc0204ec6:	7c4000ef          	jal	ra,ffffffffc020568a <memcpy>
    set_proc_name(initproc, "init");

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204eca:	00093783          	ld	a5,0(s2)
ffffffffc0204ece:	cbb5                	beqz	a5,ffffffffc0204f42 <proc_init+0x178>
ffffffffc0204ed0:	43dc                	lw	a5,4(a5)
ffffffffc0204ed2:	eba5                	bnez	a5,ffffffffc0204f42 <proc_init+0x178>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204ed4:	601c                	ld	a5,0(s0)
ffffffffc0204ed6:	c7b1                	beqz	a5,ffffffffc0204f22 <proc_init+0x158>
ffffffffc0204ed8:	43d8                	lw	a4,4(a5)
ffffffffc0204eda:	4785                	li	a5,1
ffffffffc0204edc:	04f71363          	bne	a4,a5,ffffffffc0204f22 <proc_init+0x158>
}
ffffffffc0204ee0:	60e2                	ld	ra,24(sp)
ffffffffc0204ee2:	6442                	ld	s0,16(sp)
ffffffffc0204ee4:	64a2                	ld	s1,8(sp)
ffffffffc0204ee6:	6902                	ld	s2,0(sp)
ffffffffc0204ee8:	6105                	addi	sp,sp,32
ffffffffc0204eea:	8082                	ret
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0204eec:	f2878793          	addi	a5,a5,-216
ffffffffc0204ef0:	bf4d                	j	ffffffffc0204ea2 <proc_init+0xd8>
        panic("create init_main failed.\n");
ffffffffc0204ef2:	00002617          	auipc	a2,0x2
ffffffffc0204ef6:	3be60613          	addi	a2,a2,958 # ffffffffc02072b0 <default_pmm_manager+0xdd8>
ffffffffc0204efa:	3fb00593          	li	a1,1019
ffffffffc0204efe:	00002517          	auipc	a0,0x2
ffffffffc0204f02:	04250513          	addi	a0,a0,66 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204f06:	d88fb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("cannot alloc idleproc.\n");
ffffffffc0204f0a:	00002617          	auipc	a2,0x2
ffffffffc0204f0e:	38660613          	addi	a2,a2,902 # ffffffffc0207290 <default_pmm_manager+0xdb8>
ffffffffc0204f12:	3ec00593          	li	a1,1004
ffffffffc0204f16:	00002517          	auipc	a0,0x2
ffffffffc0204f1a:	02a50513          	addi	a0,a0,42 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204f1e:	d70fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204f22:	00002697          	auipc	a3,0x2
ffffffffc0204f26:	3de68693          	addi	a3,a3,990 # ffffffffc0207300 <default_pmm_manager+0xe28>
ffffffffc0204f2a:	00001617          	auipc	a2,0x1
ffffffffc0204f2e:	1fe60613          	addi	a2,a2,510 # ffffffffc0206128 <commands+0x818>
ffffffffc0204f32:	40200593          	li	a1,1026
ffffffffc0204f36:	00002517          	auipc	a0,0x2
ffffffffc0204f3a:	00a50513          	addi	a0,a0,10 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204f3e:	d50fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204f42:	00002697          	auipc	a3,0x2
ffffffffc0204f46:	39668693          	addi	a3,a3,918 # ffffffffc02072d8 <default_pmm_manager+0xe00>
ffffffffc0204f4a:	00001617          	auipc	a2,0x1
ffffffffc0204f4e:	1de60613          	addi	a2,a2,478 # ffffffffc0206128 <commands+0x818>
ffffffffc0204f52:	40100593          	li	a1,1025
ffffffffc0204f56:	00002517          	auipc	a0,0x2
ffffffffc0204f5a:	fea50513          	addi	a0,a0,-22 # ffffffffc0206f40 <default_pmm_manager+0xa68>
ffffffffc0204f5e:	d30fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204f62 <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void cpu_idle(void)
{
ffffffffc0204f62:	1141                	addi	sp,sp,-16
ffffffffc0204f64:	e022                	sd	s0,0(sp)
ffffffffc0204f66:	e406                	sd	ra,8(sp)
ffffffffc0204f68:	000a5417          	auipc	s0,0xa5
ffffffffc0204f6c:	7e840413          	addi	s0,s0,2024 # ffffffffc02aa750 <current>
    while (1)
    {
        if (current->need_resched)
ffffffffc0204f70:	6018                	ld	a4,0(s0)
ffffffffc0204f72:	6f1c                	ld	a5,24(a4)
ffffffffc0204f74:	dffd                	beqz	a5,ffffffffc0204f72 <cpu_idle+0x10>
        {
            schedule();
ffffffffc0204f76:	0f0000ef          	jal	ra,ffffffffc0205066 <schedule>
ffffffffc0204f7a:	bfdd                	j	ffffffffc0204f70 <cpu_idle+0xe>

ffffffffc0204f7c <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc0204f7c:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc0204f80:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc0204f84:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc0204f86:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc0204f88:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc0204f8c:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc0204f90:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc0204f94:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc0204f98:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc0204f9c:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc0204fa0:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc0204fa4:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc0204fa8:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc0204fac:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc0204fb0:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc0204fb4:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc0204fb8:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc0204fba:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc0204fbc:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc0204fc0:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc0204fc4:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc0204fc8:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc0204fcc:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc0204fd0:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc0204fd4:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc0204fd8:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc0204fdc:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc0204fe0:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc0204fe4:	8082                	ret

ffffffffc0204fe6 <wakeup_proc>:
#include <sched.h>
#include <assert.h>

void wakeup_proc(struct proc_struct *proc)
{
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0204fe6:	4118                	lw	a4,0(a0)
{
ffffffffc0204fe8:	1101                	addi	sp,sp,-32
ffffffffc0204fea:	ec06                	sd	ra,24(sp)
ffffffffc0204fec:	e822                	sd	s0,16(sp)
ffffffffc0204fee:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0204ff0:	478d                	li	a5,3
ffffffffc0204ff2:	04f70b63          	beq	a4,a5,ffffffffc0205048 <wakeup_proc+0x62>
ffffffffc0204ff6:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204ff8:	100027f3          	csrr	a5,sstatus
ffffffffc0204ffc:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0204ffe:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0205000:	ef9d                	bnez	a5,ffffffffc020503e <wakeup_proc+0x58>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE)
ffffffffc0205002:	4789                	li	a5,2
ffffffffc0205004:	02f70163          	beq	a4,a5,ffffffffc0205026 <wakeup_proc+0x40>
        {
            proc->state = PROC_RUNNABLE;
ffffffffc0205008:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc020500a:	0e042623          	sw	zero,236(s0)
    if (flag)
ffffffffc020500e:	e491                	bnez	s1,ffffffffc020501a <wakeup_proc+0x34>
        {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc0205010:	60e2                	ld	ra,24(sp)
ffffffffc0205012:	6442                	ld	s0,16(sp)
ffffffffc0205014:	64a2                	ld	s1,8(sp)
ffffffffc0205016:	6105                	addi	sp,sp,32
ffffffffc0205018:	8082                	ret
ffffffffc020501a:	6442                	ld	s0,16(sp)
ffffffffc020501c:	60e2                	ld	ra,24(sp)
ffffffffc020501e:	64a2                	ld	s1,8(sp)
ffffffffc0205020:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0205022:	98dfb06f          	j	ffffffffc02009ae <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc0205026:	00002617          	auipc	a2,0x2
ffffffffc020502a:	33a60613          	addi	a2,a2,826 # ffffffffc0207360 <default_pmm_manager+0xe88>
ffffffffc020502e:	45d1                	li	a1,20
ffffffffc0205030:	00002517          	auipc	a0,0x2
ffffffffc0205034:	31850513          	addi	a0,a0,792 # ffffffffc0207348 <default_pmm_manager+0xe70>
ffffffffc0205038:	cbefb0ef          	jal	ra,ffffffffc02004f6 <__warn>
ffffffffc020503c:	bfc9                	j	ffffffffc020500e <wakeup_proc+0x28>
        intr_disable();
ffffffffc020503e:	977fb0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        if (proc->state != PROC_RUNNABLE)
ffffffffc0205042:	4018                	lw	a4,0(s0)
        return 1;
ffffffffc0205044:	4485                	li	s1,1
ffffffffc0205046:	bf75                	j	ffffffffc0205002 <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205048:	00002697          	auipc	a3,0x2
ffffffffc020504c:	2e068693          	addi	a3,a3,736 # ffffffffc0207328 <default_pmm_manager+0xe50>
ffffffffc0205050:	00001617          	auipc	a2,0x1
ffffffffc0205054:	0d860613          	addi	a2,a2,216 # ffffffffc0206128 <commands+0x818>
ffffffffc0205058:	45a5                	li	a1,9
ffffffffc020505a:	00002517          	auipc	a0,0x2
ffffffffc020505e:	2ee50513          	addi	a0,a0,750 # ffffffffc0207348 <default_pmm_manager+0xe70>
ffffffffc0205062:	c2cfb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0205066 <schedule>:

void schedule(void)
{
ffffffffc0205066:	1141                	addi	sp,sp,-16
ffffffffc0205068:	e406                	sd	ra,8(sp)
ffffffffc020506a:	e022                	sd	s0,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020506c:	100027f3          	csrr	a5,sstatus
ffffffffc0205070:	8b89                	andi	a5,a5,2
ffffffffc0205072:	4401                	li	s0,0
ffffffffc0205074:	efbd                	bnez	a5,ffffffffc02050f2 <schedule+0x8c>
    bool intr_flag;
    list_entry_t *le, *last;
    struct proc_struct *next = NULL;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc0205076:	000a5897          	auipc	a7,0xa5
ffffffffc020507a:	6da8b883          	ld	a7,1754(a7) # ffffffffc02aa750 <current>
ffffffffc020507e:	0008bc23          	sd	zero,24(a7)
        last = (current == idleproc) ? &proc_list : &(current->list_link);
ffffffffc0205082:	000a5517          	auipc	a0,0xa5
ffffffffc0205086:	6d653503          	ld	a0,1750(a0) # ffffffffc02aa758 <idleproc>
ffffffffc020508a:	04a88e63          	beq	a7,a0,ffffffffc02050e6 <schedule+0x80>
ffffffffc020508e:	0c888693          	addi	a3,a7,200
ffffffffc0205092:	000a5617          	auipc	a2,0xa5
ffffffffc0205096:	64e60613          	addi	a2,a2,1614 # ffffffffc02aa6e0 <proc_list>
        le = last;
ffffffffc020509a:	87b6                	mv	a5,a3
    struct proc_struct *next = NULL;
ffffffffc020509c:	4581                	li	a1,0
        do
        {
            if ((le = list_next(le)) != &proc_list)
            {
                next = le2proc(le, list_link);
                if (next->state == PROC_RUNNABLE)
ffffffffc020509e:	4809                	li	a6,2
ffffffffc02050a0:	679c                	ld	a5,8(a5)
            if ((le = list_next(le)) != &proc_list)
ffffffffc02050a2:	00c78863          	beq	a5,a2,ffffffffc02050b2 <schedule+0x4c>
                if (next->state == PROC_RUNNABLE)
ffffffffc02050a6:	f387a703          	lw	a4,-200(a5)
                next = le2proc(le, list_link);
ffffffffc02050aa:	f3878593          	addi	a1,a5,-200
                if (next->state == PROC_RUNNABLE)
ffffffffc02050ae:	03070163          	beq	a4,a6,ffffffffc02050d0 <schedule+0x6a>
                {
                    break;
                }
            }
        } while (le != last);
ffffffffc02050b2:	fef697e3          	bne	a3,a5,ffffffffc02050a0 <schedule+0x3a>
        if (next == NULL || next->state != PROC_RUNNABLE)
ffffffffc02050b6:	ed89                	bnez	a1,ffffffffc02050d0 <schedule+0x6a>
        {
            next = idleproc;
        }
        next->runs++;
ffffffffc02050b8:	451c                	lw	a5,8(a0)
ffffffffc02050ba:	2785                	addiw	a5,a5,1
ffffffffc02050bc:	c51c                	sw	a5,8(a0)
        if (next != current)
ffffffffc02050be:	00a88463          	beq	a7,a0,ffffffffc02050c6 <schedule+0x60>
        {
            proc_run(next);
ffffffffc02050c2:	e95fe0ef          	jal	ra,ffffffffc0203f56 <proc_run>
    if (flag)
ffffffffc02050c6:	e819                	bnez	s0,ffffffffc02050dc <schedule+0x76>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc02050c8:	60a2                	ld	ra,8(sp)
ffffffffc02050ca:	6402                	ld	s0,0(sp)
ffffffffc02050cc:	0141                	addi	sp,sp,16
ffffffffc02050ce:	8082                	ret
        if (next == NULL || next->state != PROC_RUNNABLE)
ffffffffc02050d0:	4198                	lw	a4,0(a1)
ffffffffc02050d2:	4789                	li	a5,2
ffffffffc02050d4:	fef712e3          	bne	a4,a5,ffffffffc02050b8 <schedule+0x52>
ffffffffc02050d8:	852e                	mv	a0,a1
ffffffffc02050da:	bff9                	j	ffffffffc02050b8 <schedule+0x52>
}
ffffffffc02050dc:	6402                	ld	s0,0(sp)
ffffffffc02050de:	60a2                	ld	ra,8(sp)
ffffffffc02050e0:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc02050e2:	8cdfb06f          	j	ffffffffc02009ae <intr_enable>
        last = (current == idleproc) ? &proc_list : &(current->list_link);
ffffffffc02050e6:	000a5617          	auipc	a2,0xa5
ffffffffc02050ea:	5fa60613          	addi	a2,a2,1530 # ffffffffc02aa6e0 <proc_list>
ffffffffc02050ee:	86b2                	mv	a3,a2
ffffffffc02050f0:	b76d                	j	ffffffffc020509a <schedule+0x34>
        intr_disable();
ffffffffc02050f2:	8c3fb0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc02050f6:	4405                	li	s0,1
ffffffffc02050f8:	bfbd                	j	ffffffffc0205076 <schedule+0x10>

ffffffffc02050fa <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc02050fa:	000a5797          	auipc	a5,0xa5
ffffffffc02050fe:	6567b783          	ld	a5,1622(a5) # ffffffffc02aa750 <current>
}
ffffffffc0205102:	43c8                	lw	a0,4(a5)
ffffffffc0205104:	8082                	ret

ffffffffc0205106 <sys_pgdir>:

static int
sys_pgdir(uint64_t arg[]) {
    //print_pgdir();
    return 0;
}
ffffffffc0205106:	4501                	li	a0,0
ffffffffc0205108:	8082                	ret

ffffffffc020510a <sys_putc>:
    cputchar(c);
ffffffffc020510a:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc020510c:	1141                	addi	sp,sp,-16
ffffffffc020510e:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc0205110:	8bafb0ef          	jal	ra,ffffffffc02001ca <cputchar>
}
ffffffffc0205114:	60a2                	ld	ra,8(sp)
ffffffffc0205116:	4501                	li	a0,0
ffffffffc0205118:	0141                	addi	sp,sp,16
ffffffffc020511a:	8082                	ret

ffffffffc020511c <sys_kill>:
    return do_kill(pid);
ffffffffc020511c:	4108                	lw	a0,0(a0)
ffffffffc020511e:	c31ff06f          	j	ffffffffc0204d4e <do_kill>

ffffffffc0205122 <sys_yield>:
    return do_yield();
ffffffffc0205122:	bdfff06f          	j	ffffffffc0204d00 <do_yield>

ffffffffc0205126 <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc0205126:	6d14                	ld	a3,24(a0)
ffffffffc0205128:	6910                	ld	a2,16(a0)
ffffffffc020512a:	650c                	ld	a1,8(a0)
ffffffffc020512c:	6108                	ld	a0,0(a0)
ffffffffc020512e:	ebeff06f          	j	ffffffffc02047ec <do_execve>

ffffffffc0205132 <sys_wait>:
    return do_wait(pid, store);
ffffffffc0205132:	650c                	ld	a1,8(a0)
ffffffffc0205134:	4108                	lw	a0,0(a0)
ffffffffc0205136:	bdbff06f          	j	ffffffffc0204d10 <do_wait>

ffffffffc020513a <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc020513a:	000a5797          	auipc	a5,0xa5
ffffffffc020513e:	6167b783          	ld	a5,1558(a5) # ffffffffc02aa750 <current>
ffffffffc0205142:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc0205144:	4501                	li	a0,0
ffffffffc0205146:	6a0c                	ld	a1,16(a2)
ffffffffc0205148:	e73fe06f          	j	ffffffffc0203fba <do_fork>

ffffffffc020514c <sys_exit>:
    return do_exit(error_code);
ffffffffc020514c:	4108                	lw	a0,0(a0)
ffffffffc020514e:	a5eff06f          	j	ffffffffc02043ac <do_exit>

ffffffffc0205152 <syscall>:

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

// 系统调用处理函数，由陷入处理程序调用，根据系统调用号找到对应的系统调用处理函数并调用
void
syscall(void) {
ffffffffc0205152:	715d                	addi	sp,sp,-80
ffffffffc0205154:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205156:	000a5497          	auipc	s1,0xa5
ffffffffc020515a:	5fa48493          	addi	s1,s1,1530 # ffffffffc02aa750 <current>
ffffffffc020515e:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc0205160:	e0a2                	sd	s0,64(sp)
ffffffffc0205162:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205164:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc0205166:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;//a0寄存器保存了系统调用编号
    if (num >= 0 && num < NUM_SYSCALLS) {//防止syscalls[num]下标越界
ffffffffc0205168:	47fd                	li	a5,31
    int num = tf->gpr.a0;//a0寄存器保存了系统调用编号
ffffffffc020516a:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {//防止syscalls[num]下标越界
ffffffffc020516e:	0327ee63          	bltu	a5,s2,ffffffffc02051aa <syscall+0x58>
        if (syscalls[num] != NULL) {
ffffffffc0205172:	00391713          	slli	a4,s2,0x3
ffffffffc0205176:	00002797          	auipc	a5,0x2
ffffffffc020517a:	25278793          	addi	a5,a5,594 # ffffffffc02073c8 <syscalls>
ffffffffc020517e:	97ba                	add	a5,a5,a4
ffffffffc0205180:	639c                	ld	a5,0(a5)
ffffffffc0205182:	c785                	beqz	a5,ffffffffc02051aa <syscall+0x58>
            arg[0] = tf->gpr.a1;
ffffffffc0205184:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc0205186:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc0205188:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc020518a:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc020518c:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc020518e:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc0205190:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc0205192:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc0205194:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc0205196:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc0205198:	0028                	addi	a0,sp,8
ffffffffc020519a:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc020519c:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc020519e:	e828                	sd	a0,80(s0)
}
ffffffffc02051a0:	6406                	ld	s0,64(sp)
ffffffffc02051a2:	74e2                	ld	s1,56(sp)
ffffffffc02051a4:	7942                	ld	s2,48(sp)
ffffffffc02051a6:	6161                	addi	sp,sp,80
ffffffffc02051a8:	8082                	ret
    print_trapframe(tf);
ffffffffc02051aa:	8522                	mv	a0,s0
ffffffffc02051ac:	9f9fb0ef          	jal	ra,ffffffffc0200ba4 <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc02051b0:	609c                	ld	a5,0(s1)
ffffffffc02051b2:	86ca                	mv	a3,s2
ffffffffc02051b4:	00002617          	auipc	a2,0x2
ffffffffc02051b8:	1cc60613          	addi	a2,a2,460 # ffffffffc0207380 <default_pmm_manager+0xea8>
ffffffffc02051bc:	43d8                	lw	a4,4(a5)
ffffffffc02051be:	06400593          	li	a1,100
ffffffffc02051c2:	0b478793          	addi	a5,a5,180
ffffffffc02051c6:	00002517          	auipc	a0,0x2
ffffffffc02051ca:	1ea50513          	addi	a0,a0,490 # ffffffffc02073b0 <default_pmm_manager+0xed8>
ffffffffc02051ce:	ac0fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02051d2 <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc02051d2:	9e3707b7          	lui	a5,0x9e370
ffffffffc02051d6:	2785                	addiw	a5,a5,1
ffffffffc02051d8:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc02051dc:	02000793          	li	a5,32
ffffffffc02051e0:	9f8d                	subw	a5,a5,a1
}
ffffffffc02051e2:	00f5553b          	srlw	a0,a0,a5
ffffffffc02051e6:	8082                	ret

ffffffffc02051e8 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02051e8:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02051ec:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc02051ee:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02051f2:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc02051f4:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02051f8:	f022                	sd	s0,32(sp)
ffffffffc02051fa:	ec26                	sd	s1,24(sp)
ffffffffc02051fc:	e84a                	sd	s2,16(sp)
ffffffffc02051fe:	f406                	sd	ra,40(sp)
ffffffffc0205200:	e44e                	sd	s3,8(sp)
ffffffffc0205202:	84aa                	mv	s1,a0
ffffffffc0205204:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0205206:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc020520a:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc020520c:	03067e63          	bgeu	a2,a6,ffffffffc0205248 <printnum+0x60>
ffffffffc0205210:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0205212:	00805763          	blez	s0,ffffffffc0205220 <printnum+0x38>
ffffffffc0205216:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0205218:	85ca                	mv	a1,s2
ffffffffc020521a:	854e                	mv	a0,s3
ffffffffc020521c:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc020521e:	fc65                	bnez	s0,ffffffffc0205216 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205220:	1a02                	slli	s4,s4,0x20
ffffffffc0205222:	00002797          	auipc	a5,0x2
ffffffffc0205226:	2a678793          	addi	a5,a5,678 # ffffffffc02074c8 <syscalls+0x100>
ffffffffc020522a:	020a5a13          	srli	s4,s4,0x20
ffffffffc020522e:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc0205230:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205232:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0205236:	70a2                	ld	ra,40(sp)
ffffffffc0205238:	69a2                	ld	s3,8(sp)
ffffffffc020523a:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020523c:	85ca                	mv	a1,s2
ffffffffc020523e:	87a6                	mv	a5,s1
}
ffffffffc0205240:	6942                	ld	s2,16(sp)
ffffffffc0205242:	64e2                	ld	s1,24(sp)
ffffffffc0205244:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205246:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0205248:	03065633          	divu	a2,a2,a6
ffffffffc020524c:	8722                	mv	a4,s0
ffffffffc020524e:	f9bff0ef          	jal	ra,ffffffffc02051e8 <printnum>
ffffffffc0205252:	b7f9                	j	ffffffffc0205220 <printnum+0x38>

ffffffffc0205254 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0205254:	7119                	addi	sp,sp,-128
ffffffffc0205256:	f4a6                	sd	s1,104(sp)
ffffffffc0205258:	f0ca                	sd	s2,96(sp)
ffffffffc020525a:	ecce                	sd	s3,88(sp)
ffffffffc020525c:	e8d2                	sd	s4,80(sp)
ffffffffc020525e:	e4d6                	sd	s5,72(sp)
ffffffffc0205260:	e0da                	sd	s6,64(sp)
ffffffffc0205262:	fc5e                	sd	s7,56(sp)
ffffffffc0205264:	f06a                	sd	s10,32(sp)
ffffffffc0205266:	fc86                	sd	ra,120(sp)
ffffffffc0205268:	f8a2                	sd	s0,112(sp)
ffffffffc020526a:	f862                	sd	s8,48(sp)
ffffffffc020526c:	f466                	sd	s9,40(sp)
ffffffffc020526e:	ec6e                	sd	s11,24(sp)
ffffffffc0205270:	892a                	mv	s2,a0
ffffffffc0205272:	84ae                	mv	s1,a1
ffffffffc0205274:	8d32                	mv	s10,a2
ffffffffc0205276:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205278:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc020527c:	5b7d                	li	s6,-1
ffffffffc020527e:	00002a97          	auipc	s5,0x2
ffffffffc0205282:	276a8a93          	addi	s5,s5,630 # ffffffffc02074f4 <syscalls+0x12c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0205286:	00002b97          	auipc	s7,0x2
ffffffffc020528a:	48ab8b93          	addi	s7,s7,1162 # ffffffffc0207710 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020528e:	000d4503          	lbu	a0,0(s10)
ffffffffc0205292:	001d0413          	addi	s0,s10,1
ffffffffc0205296:	01350a63          	beq	a0,s3,ffffffffc02052aa <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc020529a:	c121                	beqz	a0,ffffffffc02052da <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc020529c:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020529e:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc02052a0:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02052a2:	fff44503          	lbu	a0,-1(s0)
ffffffffc02052a6:	ff351ae3          	bne	a0,s3,ffffffffc020529a <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02052aa:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc02052ae:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc02052b2:	4c81                	li	s9,0
ffffffffc02052b4:	4881                	li	a7,0
        width = precision = -1;
ffffffffc02052b6:	5c7d                	li	s8,-1
ffffffffc02052b8:	5dfd                	li	s11,-1
ffffffffc02052ba:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc02052be:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02052c0:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02052c4:	0ff5f593          	zext.b	a1,a1
ffffffffc02052c8:	00140d13          	addi	s10,s0,1
ffffffffc02052cc:	04b56263          	bltu	a0,a1,ffffffffc0205310 <vprintfmt+0xbc>
ffffffffc02052d0:	058a                	slli	a1,a1,0x2
ffffffffc02052d2:	95d6                	add	a1,a1,s5
ffffffffc02052d4:	4194                	lw	a3,0(a1)
ffffffffc02052d6:	96d6                	add	a3,a3,s5
ffffffffc02052d8:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc02052da:	70e6                	ld	ra,120(sp)
ffffffffc02052dc:	7446                	ld	s0,112(sp)
ffffffffc02052de:	74a6                	ld	s1,104(sp)
ffffffffc02052e0:	7906                	ld	s2,96(sp)
ffffffffc02052e2:	69e6                	ld	s3,88(sp)
ffffffffc02052e4:	6a46                	ld	s4,80(sp)
ffffffffc02052e6:	6aa6                	ld	s5,72(sp)
ffffffffc02052e8:	6b06                	ld	s6,64(sp)
ffffffffc02052ea:	7be2                	ld	s7,56(sp)
ffffffffc02052ec:	7c42                	ld	s8,48(sp)
ffffffffc02052ee:	7ca2                	ld	s9,40(sp)
ffffffffc02052f0:	7d02                	ld	s10,32(sp)
ffffffffc02052f2:	6de2                	ld	s11,24(sp)
ffffffffc02052f4:	6109                	addi	sp,sp,128
ffffffffc02052f6:	8082                	ret
            padc = '0';
ffffffffc02052f8:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc02052fa:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02052fe:	846a                	mv	s0,s10
ffffffffc0205300:	00140d13          	addi	s10,s0,1
ffffffffc0205304:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0205308:	0ff5f593          	zext.b	a1,a1
ffffffffc020530c:	fcb572e3          	bgeu	a0,a1,ffffffffc02052d0 <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0205310:	85a6                	mv	a1,s1
ffffffffc0205312:	02500513          	li	a0,37
ffffffffc0205316:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0205318:	fff44783          	lbu	a5,-1(s0)
ffffffffc020531c:	8d22                	mv	s10,s0
ffffffffc020531e:	f73788e3          	beq	a5,s3,ffffffffc020528e <vprintfmt+0x3a>
ffffffffc0205322:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0205326:	1d7d                	addi	s10,s10,-1
ffffffffc0205328:	ff379de3          	bne	a5,s3,ffffffffc0205322 <vprintfmt+0xce>
ffffffffc020532c:	b78d                	j	ffffffffc020528e <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc020532e:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0205332:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205336:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0205338:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc020533c:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0205340:	02d86463          	bltu	a6,a3,ffffffffc0205368 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0205344:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0205348:	002c169b          	slliw	a3,s8,0x2
ffffffffc020534c:	0186873b          	addw	a4,a3,s8
ffffffffc0205350:	0017171b          	slliw	a4,a4,0x1
ffffffffc0205354:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0205356:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc020535a:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc020535c:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0205360:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0205364:	fed870e3          	bgeu	a6,a3,ffffffffc0205344 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0205368:	f40ddce3          	bgez	s11,ffffffffc02052c0 <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc020536c:	8de2                	mv	s11,s8
ffffffffc020536e:	5c7d                	li	s8,-1
ffffffffc0205370:	bf81                	j	ffffffffc02052c0 <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0205372:	fffdc693          	not	a3,s11
ffffffffc0205376:	96fd                	srai	a3,a3,0x3f
ffffffffc0205378:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020537c:	00144603          	lbu	a2,1(s0)
ffffffffc0205380:	2d81                	sext.w	s11,s11
ffffffffc0205382:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205384:	bf35                	j	ffffffffc02052c0 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0205386:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020538a:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc020538e:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205390:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0205392:	bfd9                	j	ffffffffc0205368 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0205394:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205396:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc020539a:	01174463          	blt	a4,a7,ffffffffc02053a2 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc020539e:	1a088e63          	beqz	a7,ffffffffc020555a <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc02053a2:	000a3603          	ld	a2,0(s4)
ffffffffc02053a6:	46c1                	li	a3,16
ffffffffc02053a8:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc02053aa:	2781                	sext.w	a5,a5
ffffffffc02053ac:	876e                	mv	a4,s11
ffffffffc02053ae:	85a6                	mv	a1,s1
ffffffffc02053b0:	854a                	mv	a0,s2
ffffffffc02053b2:	e37ff0ef          	jal	ra,ffffffffc02051e8 <printnum>
            break;
ffffffffc02053b6:	bde1                	j	ffffffffc020528e <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc02053b8:	000a2503          	lw	a0,0(s4)
ffffffffc02053bc:	85a6                	mv	a1,s1
ffffffffc02053be:	0a21                	addi	s4,s4,8
ffffffffc02053c0:	9902                	jalr	s2
            break;
ffffffffc02053c2:	b5f1                	j	ffffffffc020528e <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc02053c4:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02053c6:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02053ca:	01174463          	blt	a4,a7,ffffffffc02053d2 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc02053ce:	18088163          	beqz	a7,ffffffffc0205550 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc02053d2:	000a3603          	ld	a2,0(s4)
ffffffffc02053d6:	46a9                	li	a3,10
ffffffffc02053d8:	8a2e                	mv	s4,a1
ffffffffc02053da:	bfc1                	j	ffffffffc02053aa <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053dc:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc02053e0:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053e2:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02053e4:	bdf1                	j	ffffffffc02052c0 <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc02053e6:	85a6                	mv	a1,s1
ffffffffc02053e8:	02500513          	li	a0,37
ffffffffc02053ec:	9902                	jalr	s2
            break;
ffffffffc02053ee:	b545                	j	ffffffffc020528e <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053f0:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc02053f4:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053f6:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02053f8:	b5e1                	j	ffffffffc02052c0 <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc02053fa:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02053fc:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0205400:	01174463          	blt	a4,a7,ffffffffc0205408 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0205404:	14088163          	beqz	a7,ffffffffc0205546 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0205408:	000a3603          	ld	a2,0(s4)
ffffffffc020540c:	46a1                	li	a3,8
ffffffffc020540e:	8a2e                	mv	s4,a1
ffffffffc0205410:	bf69                	j	ffffffffc02053aa <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0205412:	03000513          	li	a0,48
ffffffffc0205416:	85a6                	mv	a1,s1
ffffffffc0205418:	e03e                	sd	a5,0(sp)
ffffffffc020541a:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc020541c:	85a6                	mv	a1,s1
ffffffffc020541e:	07800513          	li	a0,120
ffffffffc0205422:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0205424:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0205426:	6782                	ld	a5,0(sp)
ffffffffc0205428:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc020542a:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc020542e:	bfb5                	j	ffffffffc02053aa <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0205430:	000a3403          	ld	s0,0(s4)
ffffffffc0205434:	008a0713          	addi	a4,s4,8
ffffffffc0205438:	e03a                	sd	a4,0(sp)
ffffffffc020543a:	14040263          	beqz	s0,ffffffffc020557e <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc020543e:	0fb05763          	blez	s11,ffffffffc020552c <vprintfmt+0x2d8>
ffffffffc0205442:	02d00693          	li	a3,45
ffffffffc0205446:	0cd79163          	bne	a5,a3,ffffffffc0205508 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020544a:	00044783          	lbu	a5,0(s0)
ffffffffc020544e:	0007851b          	sext.w	a0,a5
ffffffffc0205452:	cf85                	beqz	a5,ffffffffc020548a <vprintfmt+0x236>
ffffffffc0205454:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205458:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020545c:	000c4563          	bltz	s8,ffffffffc0205466 <vprintfmt+0x212>
ffffffffc0205460:	3c7d                	addiw	s8,s8,-1
ffffffffc0205462:	036c0263          	beq	s8,s6,ffffffffc0205486 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0205466:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205468:	0e0c8e63          	beqz	s9,ffffffffc0205564 <vprintfmt+0x310>
ffffffffc020546c:	3781                	addiw	a5,a5,-32
ffffffffc020546e:	0ef47b63          	bgeu	s0,a5,ffffffffc0205564 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0205472:	03f00513          	li	a0,63
ffffffffc0205476:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205478:	000a4783          	lbu	a5,0(s4)
ffffffffc020547c:	3dfd                	addiw	s11,s11,-1
ffffffffc020547e:	0a05                	addi	s4,s4,1
ffffffffc0205480:	0007851b          	sext.w	a0,a5
ffffffffc0205484:	ffe1                	bnez	a5,ffffffffc020545c <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0205486:	01b05963          	blez	s11,ffffffffc0205498 <vprintfmt+0x244>
ffffffffc020548a:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc020548c:	85a6                	mv	a1,s1
ffffffffc020548e:	02000513          	li	a0,32
ffffffffc0205492:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0205494:	fe0d9be3          	bnez	s11,ffffffffc020548a <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0205498:	6a02                	ld	s4,0(sp)
ffffffffc020549a:	bbd5                	j	ffffffffc020528e <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc020549c:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020549e:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc02054a2:	01174463          	blt	a4,a7,ffffffffc02054aa <vprintfmt+0x256>
    else if (lflag) {
ffffffffc02054a6:	08088d63          	beqz	a7,ffffffffc0205540 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc02054aa:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc02054ae:	0a044d63          	bltz	s0,ffffffffc0205568 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc02054b2:	8622                	mv	a2,s0
ffffffffc02054b4:	8a66                	mv	s4,s9
ffffffffc02054b6:	46a9                	li	a3,10
ffffffffc02054b8:	bdcd                	j	ffffffffc02053aa <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc02054ba:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02054be:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc02054c0:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc02054c2:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc02054c6:	8fb5                	xor	a5,a5,a3
ffffffffc02054c8:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02054cc:	02d74163          	blt	a4,a3,ffffffffc02054ee <vprintfmt+0x29a>
ffffffffc02054d0:	00369793          	slli	a5,a3,0x3
ffffffffc02054d4:	97de                	add	a5,a5,s7
ffffffffc02054d6:	639c                	ld	a5,0(a5)
ffffffffc02054d8:	cb99                	beqz	a5,ffffffffc02054ee <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc02054da:	86be                	mv	a3,a5
ffffffffc02054dc:	00000617          	auipc	a2,0x0
ffffffffc02054e0:	1f460613          	addi	a2,a2,500 # ffffffffc02056d0 <etext+0x2e>
ffffffffc02054e4:	85a6                	mv	a1,s1
ffffffffc02054e6:	854a                	mv	a0,s2
ffffffffc02054e8:	0ce000ef          	jal	ra,ffffffffc02055b6 <printfmt>
ffffffffc02054ec:	b34d                	j	ffffffffc020528e <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc02054ee:	00002617          	auipc	a2,0x2
ffffffffc02054f2:	ffa60613          	addi	a2,a2,-6 # ffffffffc02074e8 <syscalls+0x120>
ffffffffc02054f6:	85a6                	mv	a1,s1
ffffffffc02054f8:	854a                	mv	a0,s2
ffffffffc02054fa:	0bc000ef          	jal	ra,ffffffffc02055b6 <printfmt>
ffffffffc02054fe:	bb41                	j	ffffffffc020528e <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0205500:	00002417          	auipc	s0,0x2
ffffffffc0205504:	fe040413          	addi	s0,s0,-32 # ffffffffc02074e0 <syscalls+0x118>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205508:	85e2                	mv	a1,s8
ffffffffc020550a:	8522                	mv	a0,s0
ffffffffc020550c:	e43e                	sd	a5,8(sp)
ffffffffc020550e:	0e2000ef          	jal	ra,ffffffffc02055f0 <strnlen>
ffffffffc0205512:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0205516:	01b05b63          	blez	s11,ffffffffc020552c <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc020551a:	67a2                	ld	a5,8(sp)
ffffffffc020551c:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205520:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0205522:	85a6                	mv	a1,s1
ffffffffc0205524:	8552                	mv	a0,s4
ffffffffc0205526:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205528:	fe0d9ce3          	bnez	s11,ffffffffc0205520 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020552c:	00044783          	lbu	a5,0(s0)
ffffffffc0205530:	00140a13          	addi	s4,s0,1
ffffffffc0205534:	0007851b          	sext.w	a0,a5
ffffffffc0205538:	d3a5                	beqz	a5,ffffffffc0205498 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc020553a:	05e00413          	li	s0,94
ffffffffc020553e:	bf39                	j	ffffffffc020545c <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0205540:	000a2403          	lw	s0,0(s4)
ffffffffc0205544:	b7ad                	j	ffffffffc02054ae <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0205546:	000a6603          	lwu	a2,0(s4)
ffffffffc020554a:	46a1                	li	a3,8
ffffffffc020554c:	8a2e                	mv	s4,a1
ffffffffc020554e:	bdb1                	j	ffffffffc02053aa <vprintfmt+0x156>
ffffffffc0205550:	000a6603          	lwu	a2,0(s4)
ffffffffc0205554:	46a9                	li	a3,10
ffffffffc0205556:	8a2e                	mv	s4,a1
ffffffffc0205558:	bd89                	j	ffffffffc02053aa <vprintfmt+0x156>
ffffffffc020555a:	000a6603          	lwu	a2,0(s4)
ffffffffc020555e:	46c1                	li	a3,16
ffffffffc0205560:	8a2e                	mv	s4,a1
ffffffffc0205562:	b5a1                	j	ffffffffc02053aa <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0205564:	9902                	jalr	s2
ffffffffc0205566:	bf09                	j	ffffffffc0205478 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0205568:	85a6                	mv	a1,s1
ffffffffc020556a:	02d00513          	li	a0,45
ffffffffc020556e:	e03e                	sd	a5,0(sp)
ffffffffc0205570:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0205572:	6782                	ld	a5,0(sp)
ffffffffc0205574:	8a66                	mv	s4,s9
ffffffffc0205576:	40800633          	neg	a2,s0
ffffffffc020557a:	46a9                	li	a3,10
ffffffffc020557c:	b53d                	j	ffffffffc02053aa <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc020557e:	03b05163          	blez	s11,ffffffffc02055a0 <vprintfmt+0x34c>
ffffffffc0205582:	02d00693          	li	a3,45
ffffffffc0205586:	f6d79de3          	bne	a5,a3,ffffffffc0205500 <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc020558a:	00002417          	auipc	s0,0x2
ffffffffc020558e:	f5640413          	addi	s0,s0,-170 # ffffffffc02074e0 <syscalls+0x118>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205592:	02800793          	li	a5,40
ffffffffc0205596:	02800513          	li	a0,40
ffffffffc020559a:	00140a13          	addi	s4,s0,1
ffffffffc020559e:	bd6d                	j	ffffffffc0205458 <vprintfmt+0x204>
ffffffffc02055a0:	00002a17          	auipc	s4,0x2
ffffffffc02055a4:	f41a0a13          	addi	s4,s4,-191 # ffffffffc02074e1 <syscalls+0x119>
ffffffffc02055a8:	02800513          	li	a0,40
ffffffffc02055ac:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02055b0:	05e00413          	li	s0,94
ffffffffc02055b4:	b565                	j	ffffffffc020545c <vprintfmt+0x208>

ffffffffc02055b6 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02055b6:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc02055b8:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02055bc:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02055be:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02055c0:	ec06                	sd	ra,24(sp)
ffffffffc02055c2:	f83a                	sd	a4,48(sp)
ffffffffc02055c4:	fc3e                	sd	a5,56(sp)
ffffffffc02055c6:	e0c2                	sd	a6,64(sp)
ffffffffc02055c8:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc02055ca:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02055cc:	c89ff0ef          	jal	ra,ffffffffc0205254 <vprintfmt>
}
ffffffffc02055d0:	60e2                	ld	ra,24(sp)
ffffffffc02055d2:	6161                	addi	sp,sp,80
ffffffffc02055d4:	8082                	ret

ffffffffc02055d6 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc02055d6:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc02055da:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc02055dc:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc02055de:	cb81                	beqz	a5,ffffffffc02055ee <strlen+0x18>
        cnt ++;
ffffffffc02055e0:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc02055e2:	00a707b3          	add	a5,a4,a0
ffffffffc02055e6:	0007c783          	lbu	a5,0(a5)
ffffffffc02055ea:	fbfd                	bnez	a5,ffffffffc02055e0 <strlen+0xa>
ffffffffc02055ec:	8082                	ret
    }
    return cnt;
}
ffffffffc02055ee:	8082                	ret

ffffffffc02055f0 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc02055f0:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc02055f2:	e589                	bnez	a1,ffffffffc02055fc <strnlen+0xc>
ffffffffc02055f4:	a811                	j	ffffffffc0205608 <strnlen+0x18>
        cnt ++;
ffffffffc02055f6:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc02055f8:	00f58863          	beq	a1,a5,ffffffffc0205608 <strnlen+0x18>
ffffffffc02055fc:	00f50733          	add	a4,a0,a5
ffffffffc0205600:	00074703          	lbu	a4,0(a4)
ffffffffc0205604:	fb6d                	bnez	a4,ffffffffc02055f6 <strnlen+0x6>
ffffffffc0205606:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0205608:	852e                	mv	a0,a1
ffffffffc020560a:	8082                	ret

ffffffffc020560c <strcpy>:
char *
strcpy(char *dst, const char *src) {
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
#else
    char *p = dst;
ffffffffc020560c:	87aa                	mv	a5,a0
    while ((*p ++ = *src ++) != '\0')
ffffffffc020560e:	0005c703          	lbu	a4,0(a1)
ffffffffc0205612:	0785                	addi	a5,a5,1
ffffffffc0205614:	0585                	addi	a1,a1,1
ffffffffc0205616:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020561a:	fb75                	bnez	a4,ffffffffc020560e <strcpy+0x2>
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
ffffffffc020561c:	8082                	ret

ffffffffc020561e <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020561e:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205622:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205626:	cb89                	beqz	a5,ffffffffc0205638 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0205628:	0505                	addi	a0,a0,1
ffffffffc020562a:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020562c:	fee789e3          	beq	a5,a4,ffffffffc020561e <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205630:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0205634:	9d19                	subw	a0,a0,a4
ffffffffc0205636:	8082                	ret
ffffffffc0205638:	4501                	li	a0,0
ffffffffc020563a:	bfed                	j	ffffffffc0205634 <strcmp+0x16>

ffffffffc020563c <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc020563c:	c20d                	beqz	a2,ffffffffc020565e <strncmp+0x22>
ffffffffc020563e:	962e                	add	a2,a2,a1
ffffffffc0205640:	a031                	j	ffffffffc020564c <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc0205642:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205644:	00e79a63          	bne	a5,a4,ffffffffc0205658 <strncmp+0x1c>
ffffffffc0205648:	00b60b63          	beq	a2,a1,ffffffffc020565e <strncmp+0x22>
ffffffffc020564c:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc0205650:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205652:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0205656:	f7f5                	bnez	a5,ffffffffc0205642 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205658:	40e7853b          	subw	a0,a5,a4
}
ffffffffc020565c:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020565e:	4501                	li	a0,0
ffffffffc0205660:	8082                	ret

ffffffffc0205662 <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc0205662:	00054783          	lbu	a5,0(a0)
ffffffffc0205666:	c799                	beqz	a5,ffffffffc0205674 <strchr+0x12>
        if (*s == c) {
ffffffffc0205668:	00f58763          	beq	a1,a5,ffffffffc0205676 <strchr+0x14>
    while (*s != '\0') {
ffffffffc020566c:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc0205670:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc0205672:	fbfd                	bnez	a5,ffffffffc0205668 <strchr+0x6>
    }
    return NULL;
ffffffffc0205674:	4501                	li	a0,0
}
ffffffffc0205676:	8082                	ret

ffffffffc0205678 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0205678:	ca01                	beqz	a2,ffffffffc0205688 <memset+0x10>
ffffffffc020567a:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc020567c:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc020567e:	0785                	addi	a5,a5,1
ffffffffc0205680:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0205684:	fec79de3          	bne	a5,a2,ffffffffc020567e <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0205688:	8082                	ret

ffffffffc020568a <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc020568a:	ca19                	beqz	a2,ffffffffc02056a0 <memcpy+0x16>
ffffffffc020568c:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc020568e:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc0205690:	0005c703          	lbu	a4,0(a1)
ffffffffc0205694:	0585                	addi	a1,a1,1
ffffffffc0205696:	0785                	addi	a5,a5,1
ffffffffc0205698:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc020569c:	fec59ae3          	bne	a1,a2,ffffffffc0205690 <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc02056a0:	8082                	ret
