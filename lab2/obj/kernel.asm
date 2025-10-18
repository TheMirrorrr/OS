
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	00006297          	auipc	t0,0x6
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0206000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	00006297          	auipc	t0,0x6
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0206008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)

    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c02052b7          	lui	t0,0xc0205
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
ffffffffc020003c:	c0205137          	lui	sp,0xc0205

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc0200044:	0d828293          	addi	t0,t0,216 # ffffffffc02000d8 <kern_init>
    jr t0
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc020004a:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[];
    cprintf("Special kernel symbols:\n");
ffffffffc020004c:	00001517          	auipc	a0,0x1
ffffffffc0200050:	63450513          	addi	a0,a0,1588 # ffffffffc0201680 <etext+0x6>
void print_kerninfo(void) {
ffffffffc0200054:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200056:	0f6000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", (uintptr_t)kern_init);
ffffffffc020005a:	00000597          	auipc	a1,0x0
ffffffffc020005e:	07e58593          	addi	a1,a1,126 # ffffffffc02000d8 <kern_init>
ffffffffc0200062:	00001517          	auipc	a0,0x1
ffffffffc0200066:	63e50513          	addi	a0,a0,1598 # ffffffffc02016a0 <etext+0x26>
ffffffffc020006a:	0e2000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc020006e:	00001597          	auipc	a1,0x1
ffffffffc0200072:	60c58593          	addi	a1,a1,1548 # ffffffffc020167a <etext>
ffffffffc0200076:	00001517          	auipc	a0,0x1
ffffffffc020007a:	64a50513          	addi	a0,a0,1610 # ffffffffc02016c0 <etext+0x46>
ffffffffc020007e:	0ce000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc0200082:	00006597          	auipc	a1,0x6
ffffffffc0200086:	f9658593          	addi	a1,a1,-106 # ffffffffc0206018 <buddy_system>
ffffffffc020008a:	00001517          	auipc	a0,0x1
ffffffffc020008e:	65650513          	addi	a0,a0,1622 # ffffffffc02016e0 <etext+0x66>
ffffffffc0200092:	0ba000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc0200096:	00006597          	auipc	a1,0x6
ffffffffc020009a:	fe258593          	addi	a1,a1,-30 # ffffffffc0206078 <end>
ffffffffc020009e:	00001517          	auipc	a0,0x1
ffffffffc02000a2:	66250513          	addi	a0,a0,1634 # ffffffffc0201700 <etext+0x86>
ffffffffc02000a6:	0a6000ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - (char*)kern_init + 1023) / 1024);
ffffffffc02000aa:	00006597          	auipc	a1,0x6
ffffffffc02000ae:	3cd58593          	addi	a1,a1,973 # ffffffffc0206477 <end+0x3ff>
ffffffffc02000b2:	00000797          	auipc	a5,0x0
ffffffffc02000b6:	02678793          	addi	a5,a5,38 # ffffffffc02000d8 <kern_init>
ffffffffc02000ba:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000be:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc02000c2:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000c4:	3ff5f593          	andi	a1,a1,1023
ffffffffc02000c8:	95be                	add	a1,a1,a5
ffffffffc02000ca:	85a9                	srai	a1,a1,0xa
ffffffffc02000cc:	00001517          	auipc	a0,0x1
ffffffffc02000d0:	65450513          	addi	a0,a0,1620 # ffffffffc0201720 <etext+0xa6>
}
ffffffffc02000d4:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02000d6:	a89d                	j	ffffffffc020014c <cprintf>

ffffffffc02000d8 <kern_init>:

int kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc02000d8:	00006517          	auipc	a0,0x6
ffffffffc02000dc:	f4050513          	addi	a0,a0,-192 # ffffffffc0206018 <buddy_system>
ffffffffc02000e0:	00006617          	auipc	a2,0x6
ffffffffc02000e4:	f9860613          	addi	a2,a2,-104 # ffffffffc0206078 <end>
int kern_init(void) {
ffffffffc02000e8:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc02000ea:	8e09                	sub	a2,a2,a0
ffffffffc02000ec:	4581                	li	a1,0
int kern_init(void) {
ffffffffc02000ee:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc02000f0:	578010ef          	jal	ra,ffffffffc0201668 <memset>
    dtb_init();
ffffffffc02000f4:	12c000ef          	jal	ra,ffffffffc0200220 <dtb_init>
    cons_init();  // init the console
ffffffffc02000f8:	11e000ef          	jal	ra,ffffffffc0200216 <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc02000fc:	00001517          	auipc	a0,0x1
ffffffffc0200100:	65450513          	addi	a0,a0,1620 # ffffffffc0201750 <etext+0xd6>
ffffffffc0200104:	07e000ef          	jal	ra,ffffffffc0200182 <cputs>

    print_kerninfo();
ffffffffc0200108:	f43ff0ef          	jal	ra,ffffffffc020004a <print_kerninfo>

    // grade_backtrace();
    pmm_init();  // init physical memory management
ffffffffc020010c:	703000ef          	jal	ra,ffffffffc020100e <pmm_init>

    /* do nothing */
    while (1)
ffffffffc0200110:	a001                	j	ffffffffc0200110 <kern_init+0x38>

ffffffffc0200112 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc0200112:	1141                	addi	sp,sp,-16
ffffffffc0200114:	e022                	sd	s0,0(sp)
ffffffffc0200116:	e406                	sd	ra,8(sp)
ffffffffc0200118:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc020011a:	0fe000ef          	jal	ra,ffffffffc0200218 <cons_putc>
    (*cnt) ++;
ffffffffc020011e:	401c                	lw	a5,0(s0)
}
ffffffffc0200120:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc0200122:	2785                	addiw	a5,a5,1
ffffffffc0200124:	c01c                	sw	a5,0(s0)
}
ffffffffc0200126:	6402                	ld	s0,0(sp)
ffffffffc0200128:	0141                	addi	sp,sp,16
ffffffffc020012a:	8082                	ret

ffffffffc020012c <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc020012c:	1101                	addi	sp,sp,-32
ffffffffc020012e:	862a                	mv	a2,a0
ffffffffc0200130:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200132:	00000517          	auipc	a0,0x0
ffffffffc0200136:	fe050513          	addi	a0,a0,-32 # ffffffffc0200112 <cputch>
ffffffffc020013a:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc020013c:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc020013e:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200140:	112010ef          	jal	ra,ffffffffc0201252 <vprintfmt>
    return cnt;
}
ffffffffc0200144:	60e2                	ld	ra,24(sp)
ffffffffc0200146:	4532                	lw	a0,12(sp)
ffffffffc0200148:	6105                	addi	sp,sp,32
ffffffffc020014a:	8082                	ret

ffffffffc020014c <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc020014c:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc020014e:	02810313          	addi	t1,sp,40 # ffffffffc0205028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc0200152:	8e2a                	mv	t3,a0
ffffffffc0200154:	f42e                	sd	a1,40(sp)
ffffffffc0200156:	f832                	sd	a2,48(sp)
ffffffffc0200158:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc020015a:	00000517          	auipc	a0,0x0
ffffffffc020015e:	fb850513          	addi	a0,a0,-72 # ffffffffc0200112 <cputch>
ffffffffc0200162:	004c                	addi	a1,sp,4
ffffffffc0200164:	869a                	mv	a3,t1
ffffffffc0200166:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc0200168:	ec06                	sd	ra,24(sp)
ffffffffc020016a:	e0ba                	sd	a4,64(sp)
ffffffffc020016c:	e4be                	sd	a5,72(sp)
ffffffffc020016e:	e8c2                	sd	a6,80(sp)
ffffffffc0200170:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc0200172:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc0200174:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200176:	0dc010ef          	jal	ra,ffffffffc0201252 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc020017a:	60e2                	ld	ra,24(sp)
ffffffffc020017c:	4512                	lw	a0,4(sp)
ffffffffc020017e:	6125                	addi	sp,sp,96
ffffffffc0200180:	8082                	ret

ffffffffc0200182 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc0200182:	1101                	addi	sp,sp,-32
ffffffffc0200184:	e822                	sd	s0,16(sp)
ffffffffc0200186:	ec06                	sd	ra,24(sp)
ffffffffc0200188:	e426                	sd	s1,8(sp)
ffffffffc020018a:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc020018c:	00054503          	lbu	a0,0(a0)
ffffffffc0200190:	c51d                	beqz	a0,ffffffffc02001be <cputs+0x3c>
ffffffffc0200192:	0405                	addi	s0,s0,1
ffffffffc0200194:	4485                	li	s1,1
ffffffffc0200196:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200198:	080000ef          	jal	ra,ffffffffc0200218 <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc020019c:	00044503          	lbu	a0,0(s0)
ffffffffc02001a0:	008487bb          	addw	a5,s1,s0
ffffffffc02001a4:	0405                	addi	s0,s0,1
ffffffffc02001a6:	f96d                	bnez	a0,ffffffffc0200198 <cputs+0x16>
    (*cnt) ++;
ffffffffc02001a8:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc02001ac:	4529                	li	a0,10
ffffffffc02001ae:	06a000ef          	jal	ra,ffffffffc0200218 <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc02001b2:	60e2                	ld	ra,24(sp)
ffffffffc02001b4:	8522                	mv	a0,s0
ffffffffc02001b6:	6442                	ld	s0,16(sp)
ffffffffc02001b8:	64a2                	ld	s1,8(sp)
ffffffffc02001ba:	6105                	addi	sp,sp,32
ffffffffc02001bc:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc02001be:	4405                	li	s0,1
ffffffffc02001c0:	b7f5                	j	ffffffffc02001ac <cputs+0x2a>

ffffffffc02001c2 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc02001c2:	00006317          	auipc	t1,0x6
ffffffffc02001c6:	e6e30313          	addi	t1,t1,-402 # ffffffffc0206030 <is_panic>
ffffffffc02001ca:	00032e03          	lw	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc02001ce:	715d                	addi	sp,sp,-80
ffffffffc02001d0:	ec06                	sd	ra,24(sp)
ffffffffc02001d2:	e822                	sd	s0,16(sp)
ffffffffc02001d4:	f436                	sd	a3,40(sp)
ffffffffc02001d6:	f83a                	sd	a4,48(sp)
ffffffffc02001d8:	fc3e                	sd	a5,56(sp)
ffffffffc02001da:	e0c2                	sd	a6,64(sp)
ffffffffc02001dc:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc02001de:	000e0363          	beqz	t3,ffffffffc02001e4 <__panic+0x22>
    vcprintf(fmt, ap);
    cprintf("\n");
    va_end(ap);

panic_dead:
    while (1) {
ffffffffc02001e2:	a001                	j	ffffffffc02001e2 <__panic+0x20>
    is_panic = 1;
ffffffffc02001e4:	4785                	li	a5,1
ffffffffc02001e6:	00f32023          	sw	a5,0(t1)
    va_start(ap, fmt);
ffffffffc02001ea:	8432                	mv	s0,a2
ffffffffc02001ec:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02001ee:	862e                	mv	a2,a1
ffffffffc02001f0:	85aa                	mv	a1,a0
ffffffffc02001f2:	00001517          	auipc	a0,0x1
ffffffffc02001f6:	57e50513          	addi	a0,a0,1406 # ffffffffc0201770 <etext+0xf6>
    va_start(ap, fmt);
ffffffffc02001fa:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02001fc:	f51ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200200:	65a2                	ld	a1,8(sp)
ffffffffc0200202:	8522                	mv	a0,s0
ffffffffc0200204:	f29ff0ef          	jal	ra,ffffffffc020012c <vcprintf>
    cprintf("\n");
ffffffffc0200208:	00001517          	auipc	a0,0x1
ffffffffc020020c:	54050513          	addi	a0,a0,1344 # ffffffffc0201748 <etext+0xce>
ffffffffc0200210:	f3dff0ef          	jal	ra,ffffffffc020014c <cprintf>
ffffffffc0200214:	b7f9                	j	ffffffffc02001e2 <__panic+0x20>

ffffffffc0200216 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc0200216:	8082                	ret

ffffffffc0200218 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) { sbi_console_putchar((unsigned char)c); }
ffffffffc0200218:	0ff57513          	zext.b	a0,a0
ffffffffc020021c:	3b80106f          	j	ffffffffc02015d4 <sbi_console_putchar>

ffffffffc0200220 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc0200220:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200222:	00001517          	auipc	a0,0x1
ffffffffc0200226:	56e50513          	addi	a0,a0,1390 # ffffffffc0201790 <etext+0x116>
void dtb_init(void) {
ffffffffc020022a:	fc86                	sd	ra,120(sp)
ffffffffc020022c:	f8a2                	sd	s0,112(sp)
ffffffffc020022e:	e8d2                	sd	s4,80(sp)
ffffffffc0200230:	f4a6                	sd	s1,104(sp)
ffffffffc0200232:	f0ca                	sd	s2,96(sp)
ffffffffc0200234:	ecce                	sd	s3,88(sp)
ffffffffc0200236:	e4d6                	sd	s5,72(sp)
ffffffffc0200238:	e0da                	sd	s6,64(sp)
ffffffffc020023a:	fc5e                	sd	s7,56(sp)
ffffffffc020023c:	f862                	sd	s8,48(sp)
ffffffffc020023e:	f466                	sd	s9,40(sp)
ffffffffc0200240:	f06a                	sd	s10,32(sp)
ffffffffc0200242:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc0200244:	f09ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc0200248:	00006597          	auipc	a1,0x6
ffffffffc020024c:	db85b583          	ld	a1,-584(a1) # ffffffffc0206000 <boot_hartid>
ffffffffc0200250:	00001517          	auipc	a0,0x1
ffffffffc0200254:	55050513          	addi	a0,a0,1360 # ffffffffc02017a0 <etext+0x126>
ffffffffc0200258:	ef5ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc020025c:	00006417          	auipc	s0,0x6
ffffffffc0200260:	dac40413          	addi	s0,s0,-596 # ffffffffc0206008 <boot_dtb>
ffffffffc0200264:	600c                	ld	a1,0(s0)
ffffffffc0200266:	00001517          	auipc	a0,0x1
ffffffffc020026a:	54a50513          	addi	a0,a0,1354 # ffffffffc02017b0 <etext+0x136>
ffffffffc020026e:	edfff0ef          	jal	ra,ffffffffc020014c <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc0200272:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200276:	00001517          	auipc	a0,0x1
ffffffffc020027a:	55250513          	addi	a0,a0,1362 # ffffffffc02017c8 <etext+0x14e>
    if (boot_dtb == 0) {
ffffffffc020027e:	120a0463          	beqz	s4,ffffffffc02003a6 <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc0200282:	57f5                	li	a5,-3
ffffffffc0200284:	07fa                	slli	a5,a5,0x1e
ffffffffc0200286:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc020028a:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020028c:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200290:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200292:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200296:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020029a:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020029e:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002a2:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002a6:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002a8:	8ec9                	or	a3,a3,a0
ffffffffc02002aa:	0087979b          	slliw	a5,a5,0x8
ffffffffc02002ae:	1b7d                	addi	s6,s6,-1
ffffffffc02002b0:	0167f7b3          	and	a5,a5,s6
ffffffffc02002b4:	8dd5                	or	a1,a1,a3
ffffffffc02002b6:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc02002b8:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002bc:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc02002be:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfed9e75>
ffffffffc02002c2:	10f59163          	bne	a1,a5,ffffffffc02003c4 <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc02002c6:	471c                	lw	a5,8(a4)
ffffffffc02002c8:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc02002ca:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002cc:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02002d0:	0086d51b          	srliw	a0,a3,0x8
ffffffffc02002d4:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002d8:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002dc:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002e0:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002e4:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002e8:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002ec:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002f0:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02002f4:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02002f6:	01146433          	or	s0,s0,a7
ffffffffc02002fa:	0086969b          	slliw	a3,a3,0x8
ffffffffc02002fe:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200302:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200304:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200308:	8c49                	or	s0,s0,a0
ffffffffc020030a:	0166f6b3          	and	a3,a3,s6
ffffffffc020030e:	00ca6a33          	or	s4,s4,a2
ffffffffc0200312:	0167f7b3          	and	a5,a5,s6
ffffffffc0200316:	8c55                	or	s0,s0,a3
ffffffffc0200318:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc020031c:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc020031e:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200320:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200322:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200326:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200328:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020032a:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc020032e:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200330:	00001917          	auipc	s2,0x1
ffffffffc0200334:	4e890913          	addi	s2,s2,1256 # ffffffffc0201818 <etext+0x19e>
ffffffffc0200338:	49bd                	li	s3,15
        switch (token) {
ffffffffc020033a:	4d91                	li	s11,4
ffffffffc020033c:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020033e:	00001497          	auipc	s1,0x1
ffffffffc0200342:	4d248493          	addi	s1,s1,1234 # ffffffffc0201810 <etext+0x196>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200346:	000a2703          	lw	a4,0(s4)
ffffffffc020034a:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020034e:	0087569b          	srliw	a3,a4,0x8
ffffffffc0200352:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200356:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020035a:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020035e:	0107571b          	srliw	a4,a4,0x10
ffffffffc0200362:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200364:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200368:	0087171b          	slliw	a4,a4,0x8
ffffffffc020036c:	8fd5                	or	a5,a5,a3
ffffffffc020036e:	00eb7733          	and	a4,s6,a4
ffffffffc0200372:	8fd9                	or	a5,a5,a4
ffffffffc0200374:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc0200376:	09778c63          	beq	a5,s7,ffffffffc020040e <dtb_init+0x1ee>
ffffffffc020037a:	00fbea63          	bltu	s7,a5,ffffffffc020038e <dtb_init+0x16e>
ffffffffc020037e:	07a78663          	beq	a5,s10,ffffffffc02003ea <dtb_init+0x1ca>
ffffffffc0200382:	4709                	li	a4,2
ffffffffc0200384:	00e79763          	bne	a5,a4,ffffffffc0200392 <dtb_init+0x172>
ffffffffc0200388:	4c81                	li	s9,0
ffffffffc020038a:	8a56                	mv	s4,s5
ffffffffc020038c:	bf6d                	j	ffffffffc0200346 <dtb_init+0x126>
ffffffffc020038e:	ffb78ee3          	beq	a5,s11,ffffffffc020038a <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc0200392:	00001517          	auipc	a0,0x1
ffffffffc0200396:	4fe50513          	addi	a0,a0,1278 # ffffffffc0201890 <etext+0x216>
ffffffffc020039a:	db3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc020039e:	00001517          	auipc	a0,0x1
ffffffffc02003a2:	52a50513          	addi	a0,a0,1322 # ffffffffc02018c8 <etext+0x24e>
}
ffffffffc02003a6:	7446                	ld	s0,112(sp)
ffffffffc02003a8:	70e6                	ld	ra,120(sp)
ffffffffc02003aa:	74a6                	ld	s1,104(sp)
ffffffffc02003ac:	7906                	ld	s2,96(sp)
ffffffffc02003ae:	69e6                	ld	s3,88(sp)
ffffffffc02003b0:	6a46                	ld	s4,80(sp)
ffffffffc02003b2:	6aa6                	ld	s5,72(sp)
ffffffffc02003b4:	6b06                	ld	s6,64(sp)
ffffffffc02003b6:	7be2                	ld	s7,56(sp)
ffffffffc02003b8:	7c42                	ld	s8,48(sp)
ffffffffc02003ba:	7ca2                	ld	s9,40(sp)
ffffffffc02003bc:	7d02                	ld	s10,32(sp)
ffffffffc02003be:	6de2                	ld	s11,24(sp)
ffffffffc02003c0:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc02003c2:	b369                	j	ffffffffc020014c <cprintf>
}
ffffffffc02003c4:	7446                	ld	s0,112(sp)
ffffffffc02003c6:	70e6                	ld	ra,120(sp)
ffffffffc02003c8:	74a6                	ld	s1,104(sp)
ffffffffc02003ca:	7906                	ld	s2,96(sp)
ffffffffc02003cc:	69e6                	ld	s3,88(sp)
ffffffffc02003ce:	6a46                	ld	s4,80(sp)
ffffffffc02003d0:	6aa6                	ld	s5,72(sp)
ffffffffc02003d2:	6b06                	ld	s6,64(sp)
ffffffffc02003d4:	7be2                	ld	s7,56(sp)
ffffffffc02003d6:	7c42                	ld	s8,48(sp)
ffffffffc02003d8:	7ca2                	ld	s9,40(sp)
ffffffffc02003da:	7d02                	ld	s10,32(sp)
ffffffffc02003dc:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02003de:	00001517          	auipc	a0,0x1
ffffffffc02003e2:	40a50513          	addi	a0,a0,1034 # ffffffffc02017e8 <etext+0x16e>
}
ffffffffc02003e6:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02003e8:	b395                	j	ffffffffc020014c <cprintf>
                int name_len = strlen(name);
ffffffffc02003ea:	8556                	mv	a0,s5
ffffffffc02003ec:	202010ef          	jal	ra,ffffffffc02015ee <strlen>
ffffffffc02003f0:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003f2:	4619                	li	a2,6
ffffffffc02003f4:	85a6                	mv	a1,s1
ffffffffc02003f6:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02003f8:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02003fa:	248010ef          	jal	ra,ffffffffc0201642 <strncmp>
ffffffffc02003fe:	e111                	bnez	a0,ffffffffc0200402 <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc0200400:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc0200402:	0a91                	addi	s5,s5,4
ffffffffc0200404:	9ad2                	add	s5,s5,s4
ffffffffc0200406:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc020040a:	8a56                	mv	s4,s5
ffffffffc020040c:	bf2d                	j	ffffffffc0200346 <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc020040e:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200412:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200416:	0087d71b          	srliw	a4,a5,0x8
ffffffffc020041a:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020041e:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200422:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200426:	0107d79b          	srliw	a5,a5,0x10
ffffffffc020042a:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020042e:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200432:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200436:	00eaeab3          	or	s5,s5,a4
ffffffffc020043a:	00fb77b3          	and	a5,s6,a5
ffffffffc020043e:	00faeab3          	or	s5,s5,a5
ffffffffc0200442:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200444:	000c9c63          	bnez	s9,ffffffffc020045c <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc0200448:	1a82                	slli	s5,s5,0x20
ffffffffc020044a:	00368793          	addi	a5,a3,3
ffffffffc020044e:	020ada93          	srli	s5,s5,0x20
ffffffffc0200452:	9abe                	add	s5,s5,a5
ffffffffc0200454:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200458:	8a56                	mv	s4,s5
ffffffffc020045a:	b5f5                	j	ffffffffc0200346 <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc020045c:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200460:	85ca                	mv	a1,s2
ffffffffc0200462:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200464:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200468:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020046c:	0187971b          	slliw	a4,a5,0x18
ffffffffc0200470:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200474:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200478:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020047a:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020047e:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200482:	8d59                	or	a0,a0,a4
ffffffffc0200484:	00fb77b3          	and	a5,s6,a5
ffffffffc0200488:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc020048a:	1502                	slli	a0,a0,0x20
ffffffffc020048c:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020048e:	9522                	add	a0,a0,s0
ffffffffc0200490:	194010ef          	jal	ra,ffffffffc0201624 <strcmp>
ffffffffc0200494:	66a2                	ld	a3,8(sp)
ffffffffc0200496:	f94d                	bnez	a0,ffffffffc0200448 <dtb_init+0x228>
ffffffffc0200498:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200448 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc020049c:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc02004a0:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc02004a4:	00001517          	auipc	a0,0x1
ffffffffc02004a8:	37c50513          	addi	a0,a0,892 # ffffffffc0201820 <etext+0x1a6>
           fdt32_to_cpu(x >> 32);
ffffffffc02004ac:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004b0:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc02004b4:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004b8:	0187de1b          	srliw	t3,a5,0x18
ffffffffc02004bc:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004c0:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004c4:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004c8:	0187d693          	srli	a3,a5,0x18
ffffffffc02004cc:	01861f1b          	slliw	t5,a2,0x18
ffffffffc02004d0:	0087579b          	srliw	a5,a4,0x8
ffffffffc02004d4:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004d8:	0106561b          	srliw	a2,a2,0x10
ffffffffc02004dc:	010f6f33          	or	t5,t5,a6
ffffffffc02004e0:	0187529b          	srliw	t0,a4,0x18
ffffffffc02004e4:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004e8:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004ec:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02004f0:	0186f6b3          	and	a3,a3,s8
ffffffffc02004f4:	01859e1b          	slliw	t3,a1,0x18
ffffffffc02004f8:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02004fc:	0107581b          	srliw	a6,a4,0x10
ffffffffc0200500:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200504:	8361                	srli	a4,a4,0x18
ffffffffc0200506:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020050a:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020050e:	01e6e6b3          	or	a3,a3,t5
ffffffffc0200512:	00cb7633          	and	a2,s6,a2
ffffffffc0200516:	0088181b          	slliw	a6,a6,0x8
ffffffffc020051a:	0085959b          	slliw	a1,a1,0x8
ffffffffc020051e:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200522:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200526:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020052a:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020052e:	0088989b          	slliw	a7,a7,0x8
ffffffffc0200532:	011b78b3          	and	a7,s6,a7
ffffffffc0200536:	005eeeb3          	or	t4,t4,t0
ffffffffc020053a:	00c6e733          	or	a4,a3,a2
ffffffffc020053e:	006c6c33          	or	s8,s8,t1
ffffffffc0200542:	010b76b3          	and	a3,s6,a6
ffffffffc0200546:	00bb7b33          	and	s6,s6,a1
ffffffffc020054a:	01d7e7b3          	or	a5,a5,t4
ffffffffc020054e:	016c6b33          	or	s6,s8,s6
ffffffffc0200552:	01146433          	or	s0,s0,a7
ffffffffc0200556:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc0200558:	1702                	slli	a4,a4,0x20
ffffffffc020055a:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020055c:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020055e:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200560:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc0200562:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200566:	0167eb33          	or	s6,a5,s6
ffffffffc020056a:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc020056c:	be1ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc0200570:	85a2                	mv	a1,s0
ffffffffc0200572:	00001517          	auipc	a0,0x1
ffffffffc0200576:	2ce50513          	addi	a0,a0,718 # ffffffffc0201840 <etext+0x1c6>
ffffffffc020057a:	bd3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc020057e:	014b5613          	srli	a2,s6,0x14
ffffffffc0200582:	85da                	mv	a1,s6
ffffffffc0200584:	00001517          	auipc	a0,0x1
ffffffffc0200588:	2d450513          	addi	a0,a0,724 # ffffffffc0201858 <etext+0x1de>
ffffffffc020058c:	bc1ff0ef          	jal	ra,ffffffffc020014c <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc0200590:	008b05b3          	add	a1,s6,s0
ffffffffc0200594:	15fd                	addi	a1,a1,-1
ffffffffc0200596:	00001517          	auipc	a0,0x1
ffffffffc020059a:	2e250513          	addi	a0,a0,738 # ffffffffc0201878 <etext+0x1fe>
ffffffffc020059e:	bafff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("DTB init completed\n");
ffffffffc02005a2:	00001517          	auipc	a0,0x1
ffffffffc02005a6:	32650513          	addi	a0,a0,806 # ffffffffc02018c8 <etext+0x24e>
        memory_base = mem_base;
ffffffffc02005aa:	00006797          	auipc	a5,0x6
ffffffffc02005ae:	a887b723          	sd	s0,-1394(a5) # ffffffffc0206038 <memory_base>
        memory_size = mem_size;
ffffffffc02005b2:	00006797          	auipc	a5,0x6
ffffffffc02005b6:	a967b723          	sd	s6,-1394(a5) # ffffffffc0206040 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc02005ba:	b3f5                	j	ffffffffc02003a6 <dtb_init+0x186>

ffffffffc02005bc <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc02005bc:	00006517          	auipc	a0,0x6
ffffffffc02005c0:	a7c53503          	ld	a0,-1412(a0) # ffffffffc0206038 <memory_base>
ffffffffc02005c4:	8082                	ret

ffffffffc02005c6 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
ffffffffc02005c6:	00006517          	auipc	a0,0x6
ffffffffc02005ca:	a7a53503          	ld	a0,-1414(a0) # ffffffffc0206040 <memory_size>
ffffffffc02005ce:	8082                	ret

ffffffffc02005d0 <buddy_system_init>:
}

static void
buddy_system_init(void)
{
    buddy_base = NULL;
ffffffffc02005d0:	00006797          	auipc	a5,0x6
ffffffffc02005d4:	a4878793          	addi	a5,a5,-1464 # ffffffffc0206018 <buddy_system>
ffffffffc02005d8:	0007b023          	sd	zero,0(a5)
    buddy_root = NULL;
ffffffffc02005dc:	0007b423          	sd	zero,8(a5)
    buddy_nr_free = 0;
ffffffffc02005e0:	0007b823          	sd	zero,16(a5)
    buddy_total_size = 0;
    //cprintf("Buddy System Physical Memory Manager Init\n");
}
ffffffffc02005e4:	8082                	ret

ffffffffc02005e6 <test_tree_structure>:
打印所有longest=buddy_root->size/对应层级的节点，若节点的父节点longest值为子节点的两倍或0，则不打印子节点
并且打印对应页的地址
*/
static void
test_tree_structure(void)
{
ffffffffc02005e6:	7179                	addi	sp,sp,-48
    cprintf("Buddy System Tree Structure:\n");
ffffffffc02005e8:	00001517          	auipc	a0,0x1
ffffffffc02005ec:	2f850513          	addi	a0,a0,760 # ffffffffc02018e0 <etext+0x266>
{
ffffffffc02005f0:	ec26                	sd	s1,24(sp)
ffffffffc02005f2:	e84a                	sd	s2,16(sp)
ffffffffc02005f4:	e44e                	sd	s3,8(sp)
ffffffffc02005f6:	e052                	sd	s4,0(sp)
ffffffffc02005f8:	f406                	sd	ra,40(sp)
ffffffffc02005fa:	f022                	sd	s0,32(sp)
    unsigned int size = buddy_root->size;
ffffffffc02005fc:	00006917          	auipc	s2,0x6
ffffffffc0200600:	a1c90913          	addi	s2,s2,-1508 # ffffffffc0206018 <buddy_system>
    cprintf("Buddy System Tree Structure:\n");
ffffffffc0200604:	b49ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    unsigned int size = buddy_root->size;
ffffffffc0200608:	00893503          	ld	a0,8(s2)
    return res >> 1;
ffffffffc020060c:	800009b7          	lui	s3,0x80000
    unsigned int len = size * 2 - 1;
    for (unsigned int i = 0; i < len; i++)
ffffffffc0200610:	4581                	li	a1,0
    unsigned int size = buddy_root->size;
ffffffffc0200612:	00052883          	lw	a7,0(a0)
    return res >> 1;
ffffffffc0200616:	fff9c993          	not	s3,s3
            unsigned int parent = PARENT(i);
            if (i == 0 || ((buddy_root->longest[parent] != buddy_root->longest[i] * 2)&& (buddy_root->longest[parent] != 0)))
            {
                unsigned int offset = (i + 1) * buddy_root->longest[i] - buddy_root->size;
                struct Page* page = buddy_base + offset;
                cprintf("Node %u: longest = %u, 地址为: %p\n", i, buddy_root->longest[i], page);
ffffffffc020061a:	00001a17          	auipc	s4,0x1
ffffffffc020061e:	2e6a0a13          	addi	s4,s4,742 # ffffffffc0201900 <etext+0x286>
    unsigned int len = size * 2 - 1;
ffffffffc0200622:	0018949b          	slliw	s1,a7,0x1
ffffffffc0200626:	34fd                	addiw	s1,s1,-1
        if ((buddy_root->longest[i] == buddy_root->size/alt_fixsize(i+1)))
ffffffffc0200628:	02059713          	slli	a4,a1,0x20
ffffffffc020062c:	01e75793          	srli	a5,a4,0x1e
ffffffffc0200630:	97aa                	add	a5,a5,a0
ffffffffc0200632:	0015841b          	addiw	s0,a1,1
ffffffffc0200636:	43d0                	lw	a2,4(a5)
ffffffffc0200638:	8822                	mv	a6,s0
    unsigned res = 1;
ffffffffc020063a:	4785                	li	a5,1
        res <<= 1;
ffffffffc020063c:	0017971b          	slliw	a4,a5,0x1
ffffffffc0200640:	0007869b          	sext.w	a3,a5
ffffffffc0200644:	0007079b          	sext.w	a5,a4
    while (res <= size)
ffffffffc0200648:	fef47ae3          	bgeu	s0,a5,ffffffffc020063c <test_tree_structure+0x56>
    return res >> 1;
ffffffffc020064c:	0136f6b3          	and	a3,a3,s3
        if ((buddy_root->longest[i] == buddy_root->size/alt_fixsize(i+1)))
ffffffffc0200650:	02d8d6bb          	divuw	a3,a7,a3
ffffffffc0200654:	00c68a63          	beq	a3,a2,ffffffffc0200668 <test_tree_structure+0x82>
    for (unsigned int i = 0; i < len; i++)
ffffffffc0200658:	04940a63          	beq	s0,s1,ffffffffc02006ac <test_tree_structure+0xc6>
        if ((buddy_root->longest[i] == buddy_root->size/alt_fixsize(i+1)))
ffffffffc020065c:	00893503          	ld	a0,8(s2)
ffffffffc0200660:	85a2                	mv	a1,s0
ffffffffc0200662:	00052883          	lw	a7,0(a0)
ffffffffc0200666:	b7c9                	j	ffffffffc0200628 <test_tree_structure+0x42>
            unsigned int parent = PARENT(i);
ffffffffc0200668:	0018579b          	srliw	a5,a6,0x1
ffffffffc020066c:	37fd                	addiw	a5,a5,-1
            if (i == 0 || ((buddy_root->longest[parent] != buddy_root->longest[i] * 2)&& (buddy_root->longest[parent] != 0)))
ffffffffc020066e:	cd81                	beqz	a1,ffffffffc0200686 <test_tree_structure+0xa0>
ffffffffc0200670:	02079713          	slli	a4,a5,0x20
ffffffffc0200674:	01e75793          	srli	a5,a4,0x1e
ffffffffc0200678:	953e                	add	a0,a0,a5
ffffffffc020067a:	4158                	lw	a4,4(a0)
ffffffffc020067c:	0016179b          	slliw	a5,a2,0x1
ffffffffc0200680:	fce78ce3          	beq	a5,a4,ffffffffc0200658 <test_tree_structure+0x72>
ffffffffc0200684:	db71                	beqz	a4,ffffffffc0200658 <test_tree_structure+0x72>
                unsigned int offset = (i + 1) * buddy_root->longest[i] - buddy_root->size;
ffffffffc0200686:	0306083b          	mulw	a6,a2,a6
                struct Page* page = buddy_base + offset;
ffffffffc020068a:	00093683          	ld	a3,0(s2)
                cprintf("Node %u: longest = %u, 地址为: %p\n", i, buddy_root->longest[i], page);
ffffffffc020068e:	8552                	mv	a0,s4
                unsigned int offset = (i + 1) * buddy_root->longest[i] - buddy_root->size;
ffffffffc0200690:	4118083b          	subw	a6,a6,a7
                struct Page* page = buddy_base + offset;
ffffffffc0200694:	02081793          	slli	a5,a6,0x20
ffffffffc0200698:	9381                	srli	a5,a5,0x20
ffffffffc020069a:	00279713          	slli	a4,a5,0x2
ffffffffc020069e:	97ba                	add	a5,a5,a4
ffffffffc02006a0:	078e                	slli	a5,a5,0x3
                cprintf("Node %u: longest = %u, 地址为: %p\n", i, buddy_root->longest[i], page);
ffffffffc02006a2:	96be                	add	a3,a3,a5
ffffffffc02006a4:	aa9ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    for (unsigned int i = 0; i < len; i++)
ffffffffc02006a8:	fa941ae3          	bne	s0,s1,ffffffffc020065c <test_tree_structure+0x76>
            }
        }
    }
    cprintf("\n");
}
ffffffffc02006ac:	7402                	ld	s0,32(sp)
ffffffffc02006ae:	70a2                	ld	ra,40(sp)
ffffffffc02006b0:	64e2                	ld	s1,24(sp)
ffffffffc02006b2:	6942                	ld	s2,16(sp)
ffffffffc02006b4:	69a2                	ld	s3,8(sp)
ffffffffc02006b6:	6a02                	ld	s4,0(sp)
    cprintf("\n");
ffffffffc02006b8:	00001517          	auipc	a0,0x1
ffffffffc02006bc:	09050513          	addi	a0,a0,144 # ffffffffc0201748 <etext+0xce>
}
ffffffffc02006c0:	6145                	addi	sp,sp,48
    cprintf("\n");
ffffffffc02006c2:	b469                	j	ffffffffc020014c <cprintf>

ffffffffc02006c4 <buddy_system_nr_free_pages>:
{
ffffffffc02006c4:	1141                	addi	sp,sp,-16
    cprintf("Buddy System Physical Memory Manager Nr Free OK\n");
ffffffffc02006c6:	00001517          	auipc	a0,0x1
ffffffffc02006ca:	26250513          	addi	a0,a0,610 # ffffffffc0201928 <etext+0x2ae>
{
ffffffffc02006ce:	e406                	sd	ra,8(sp)
ffffffffc02006d0:	e022                	sd	s0,0(sp)
    cprintf("Buddy System Physical Memory Manager Nr Free OK\n");
ffffffffc02006d2:	a7bff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("Buddy System Free Pages: %d\n", buddy_nr_free);
ffffffffc02006d6:	00006417          	auipc	s0,0x6
ffffffffc02006da:	94240413          	addi	s0,s0,-1726 # ffffffffc0206018 <buddy_system>
ffffffffc02006de:	480c                	lw	a1,16(s0)
ffffffffc02006e0:	00001517          	auipc	a0,0x1
ffffffffc02006e4:	28050513          	addi	a0,a0,640 # ffffffffc0201960 <etext+0x2e6>
ffffffffc02006e8:	a65ff0ef          	jal	ra,ffffffffc020014c <cprintf>
}
ffffffffc02006ec:	01046503          	lwu	a0,16(s0)
ffffffffc02006f0:	60a2                	ld	ra,8(sp)
ffffffffc02006f2:	6402                	ld	s0,0(sp)
ffffffffc02006f4:	0141                	addi	sp,sp,16
ffffffffc02006f6:	8082                	ret

ffffffffc02006f8 <buddy_system_alloc_pages>:
{
ffffffffc02006f8:	7139                	addi	sp,sp,-64
ffffffffc02006fa:	fc06                	sd	ra,56(sp)
ffffffffc02006fc:	f822                	sd	s0,48(sp)
ffffffffc02006fe:	f426                	sd	s1,40(sp)
ffffffffc0200700:	f04a                	sd	s2,32(sp)
ffffffffc0200702:	ec4e                	sd	s3,24(sp)
ffffffffc0200704:	e852                	sd	s4,16(sp)
ffffffffc0200706:	e456                	sd	s5,8(sp)
ffffffffc0200708:	e05a                	sd	s6,0(sp)
    assert(n > 0);
ffffffffc020070a:	22050c63          	beqz	a0,ffffffffc0200942 <buddy_system_alloc_pages+0x24a>
    if (n > buddy_nr_free)
ffffffffc020070e:	00006a17          	auipc	s4,0x6
ffffffffc0200712:	90aa0a13          	addi	s4,s4,-1782 # ffffffffc0206018 <buddy_system>
ffffffffc0200716:	010a6783          	lwu	a5,16(s4)
ffffffffc020071a:	89aa                	mv	s3,a0
ffffffffc020071c:	16a7ed63          	bltu	a5,a0,ffffffffc0200896 <buddy_system_alloc_pages+0x19e>
    if (!IS_POWER_OF_2(n))
ffffffffc0200720:	fff50793          	addi	a5,a0,-1
ffffffffc0200724:	8fe9                	and	a5,a5,a0
ffffffffc0200726:	12079a63          	bnez	a5,ffffffffc020085a <buddy_system_alloc_pages+0x162>
    if (buddy_root->longest[index] < n)
ffffffffc020072a:	008a3683          	ld	a3,8(s4)
ffffffffc020072e:	0046e783          	lwu	a5,4(a3)
ffffffffc0200732:	1737e263          	bltu	a5,s3,ffffffffc0200896 <buddy_system_alloc_pages+0x19e>
    for(node_size = buddy_root->size; node_size != n; node_size /= 2)
ffffffffc0200736:	4290                	lw	a2,0(a3)
ffffffffc0200738:	02061793          	slli	a5,a2,0x20
ffffffffc020073c:	9381                	srli	a5,a5,0x20
ffffffffc020073e:	1cf98363          	beq	s3,a5,ffffffffc0200904 <buddy_system_alloc_pages+0x20c>
ffffffffc0200742:	8932                	mv	s2,a2
    unsigned int index = 0;
ffffffffc0200744:	4481                	li	s1,0
        if(buddy_root->longest[LEFT_LEAF(index)] >= n)
ffffffffc0200746:	0014971b          	slliw	a4,s1,0x1
ffffffffc020074a:	0017049b          	addiw	s1,a4,1
ffffffffc020074e:	02049593          	slli	a1,s1,0x20
ffffffffc0200752:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0200756:	97b6                	add	a5,a5,a3
ffffffffc0200758:	0047e783          	lwu	a5,4(a5)
ffffffffc020075c:	0137f463          	bgeu	a5,s3,ffffffffc0200764 <buddy_system_alloc_pages+0x6c>
            index = RIGHT_LEAF(index);
ffffffffc0200760:	0027049b          	addiw	s1,a4,2
    for(node_size = buddy_root->size; node_size != n; node_size /= 2)
ffffffffc0200764:	0019591b          	srliw	s2,s2,0x1
ffffffffc0200768:	02091793          	slli	a5,s2,0x20
ffffffffc020076c:	9381                	srli	a5,a5,0x20
ffffffffc020076e:	fd379ce3          	bne	a5,s3,ffffffffc0200746 <buddy_system_alloc_pages+0x4e>
    offset = (index + 1) * node_size - buddy_root->size;
ffffffffc0200772:	0014841b          	addiw	s0,s1,1
ffffffffc0200776:	03240abb          	mulw	s5,s0,s2
    buddy_root->longest[index] = 0;
ffffffffc020077a:	02049713          	slli	a4,s1,0x20
ffffffffc020077e:	01e75793          	srli	a5,a4,0x1e
ffffffffc0200782:	96be                	add	a3,a3,a5
ffffffffc0200784:	0006a223          	sw	zero,4(a3)
    cprintf("index:%u\n", index);
ffffffffc0200788:	85a6                	mv	a1,s1
ffffffffc020078a:	00001517          	auipc	a0,0x1
ffffffffc020078e:	23650513          	addi	a0,a0,566 # ffffffffc02019c0 <etext+0x346>
    offset = (index + 1) * node_size - buddy_root->size;
ffffffffc0200792:	40ca8abb          	subw	s5,s5,a2
ffffffffc0200796:	000a8b1b          	sext.w	s6,s5
    cprintf("index:%u\n", index);
ffffffffc020079a:	9b3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    page = buddy_base + offset;
ffffffffc020079e:	1a82                	slli	s5,s5,0x20
    cprintf("offset:%u\n", offset);
ffffffffc02007a0:	85da                	mv	a1,s6
ffffffffc02007a2:	00001517          	auipc	a0,0x1
ffffffffc02007a6:	22e50513          	addi	a0,a0,558 # ffffffffc02019d0 <etext+0x356>
ffffffffc02007aa:	9a3ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    page = buddy_base + offset;
ffffffffc02007ae:	020ada93          	srli	s5,s5,0x20
ffffffffc02007b2:	000a3803          	ld	a6,0(s4)
ffffffffc02007b6:	002a9513          	slli	a0,s5,0x2
ffffffffc02007ba:	9556                	add	a0,a0,s5
ffffffffc02007bc:	050e                	slli	a0,a0,0x3
ffffffffc02007be:	9542                	add	a0,a0,a6
    ClearPageProperty(page);
ffffffffc02007c0:	6518                	ld	a4,8(a0)
    buddy_nr_free -= n;
ffffffffc02007c2:	010a2783          	lw	a5,16(s4)
    page->property = 0;
ffffffffc02007c6:	00052823          	sw	zero,16(a0)
    ClearPageProperty(page);
ffffffffc02007ca:	9b75                	andi	a4,a4,-3
    buddy_nr_free -= n;
ffffffffc02007cc:	413787bb          	subw	a5,a5,s3
ffffffffc02007d0:	00fa2823          	sw	a5,16(s4)
    ClearPageProperty(page);
ffffffffc02007d4:	e518                	sd	a4,8(a0)
    if( index%2==1 && buddy_root->longest[index+1]==node_size) 
ffffffffc02007d6:	0014f793          	andi	a5,s1,1
ffffffffc02007da:	c3e1                	beqz	a5,ffffffffc020089a <buddy_system_alloc_pages+0x1a2>
ffffffffc02007dc:	008a3603          	ld	a2,8(s4)
ffffffffc02007e0:	02041713          	slli	a4,s0,0x20
ffffffffc02007e4:	01e75793          	srli	a5,a4,0x1e
ffffffffc02007e8:	97b2                	add	a5,a5,a2
ffffffffc02007ea:	43dc                	lw	a5,4(a5)
ffffffffc02007ec:	0f278e63          	beq	a5,s2,ffffffffc02008e8 <buddy_system_alloc_pages+0x1f0>
        offset = (index + 1) * node_size - buddy_root->size;
ffffffffc02007f0:	00062883          	lw	a7,0(a2) # ff0000 <kern_entry-0xffffffffbf210000>
        index = PARENT(index);
ffffffffc02007f4:	0014569b          	srliw	a3,s0,0x1
ffffffffc02007f8:	fff6871b          	addiw	a4,a3,-1
        buddy_root->longest[index] = MAX(buddy_root->longest[LEFT_LEAF(index)], buddy_root->longest[RIGHT_LEAF(index)]);
ffffffffc02007fc:	0017179b          	slliw	a5,a4,0x1
ffffffffc0200800:	9879                	andi	s0,s0,-2
ffffffffc0200802:	2785                	addiw	a5,a5,1
ffffffffc0200804:	1402                	slli	s0,s0,0x20
ffffffffc0200806:	02079593          	slli	a1,a5,0x20
ffffffffc020080a:	9001                	srli	s0,s0,0x20
ffffffffc020080c:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0200810:	040a                	slli	s0,s0,0x2
ffffffffc0200812:	97b2                	add	a5,a5,a2
ffffffffc0200814:	9432                	add	s0,s0,a2
ffffffffc0200816:	00442e03          	lw	t3,4(s0)
ffffffffc020081a:	43cc                	lw	a1,4(a5)
ffffffffc020081c:	02071413          	slli	s0,a4,0x20
        node_size *= 2;
ffffffffc0200820:	0019131b          	slliw	t1,s2,0x1
        buddy_root->longest[index] = MAX(buddy_root->longest[LEFT_LEAF(index)], buddy_root->longest[RIGHT_LEAF(index)]);
ffffffffc0200824:	01e45793          	srli	a5,s0,0x1e
ffffffffc0200828:	00058f1b          	sext.w	t5,a1
ffffffffc020082c:	000e0e9b          	sext.w	t4,t3
        index = PARENT(index);
ffffffffc0200830:	0007049b          	sext.w	s1,a4
        node_size *= 2;
ffffffffc0200834:	0003091b          	sext.w	s2,t1
        buddy_root->longest[index] = MAX(buddy_root->longest[LEFT_LEAF(index)], buddy_root->longest[RIGHT_LEAF(index)]);
ffffffffc0200838:	97b2                	add	a5,a5,a2
ffffffffc020083a:	01df7363          	bgeu	t5,t4,ffffffffc0200840 <buddy_system_alloc_pages+0x148>
ffffffffc020083e:	85f2                	mv	a1,t3
ffffffffc0200840:	c3cc                	sw	a1,4(a5)
        if( index%2==1 && buddy_root->longest[index+1]==node_size) 
ffffffffc0200842:	8b05                	andi	a4,a4,1
ffffffffc0200844:	c759                	beqz	a4,ffffffffc02008d2 <buddy_system_alloc_pages+0x1da>
ffffffffc0200846:	02069793          	slli	a5,a3,0x20
ffffffffc020084a:	83f9                	srli	a5,a5,0x1e
ffffffffc020084c:	97b2                	add	a5,a5,a2
ffffffffc020084e:	43dc                	lw	a5,4(a5)
ffffffffc0200850:	05278963          	beq	a5,s2,ffffffffc02008a2 <buddy_system_alloc_pages+0x1aa>
    while(index)
ffffffffc0200854:	0014841b          	addiw	s0,s1,1
ffffffffc0200858:	bf71                	j	ffffffffc02007f4 <buddy_system_alloc_pages+0xfc>
    size |= size >> 1;
ffffffffc020085a:	0015551b          	srliw	a0,a0,0x1
ffffffffc020085e:	00a9e9b3          	or	s3,s3,a0
    size |= size >> 2;
ffffffffc0200862:	0029d79b          	srliw	a5,s3,0x2
ffffffffc0200866:	00f9e9b3          	or	s3,s3,a5
    size |= size >> 4;
ffffffffc020086a:	0049d79b          	srliw	a5,s3,0x4
ffffffffc020086e:	00f9e9b3          	or	s3,s3,a5
    size |= size >> 8;
ffffffffc0200872:	0089d79b          	srliw	a5,s3,0x8
ffffffffc0200876:	00f9e9b3          	or	s3,s3,a5
    if (buddy_root->longest[index] < n)
ffffffffc020087a:	008a3683          	ld	a3,8(s4)
    size |= size >> 16;
ffffffffc020087e:	0109d79b          	srliw	a5,s3,0x10
ffffffffc0200882:	00f9e9b3          	or	s3,s3,a5
    return size + 1;
ffffffffc0200886:	2985                	addiw	s3,s3,1
    if (buddy_root->longest[index] < n)
ffffffffc0200888:	0046e783          	lwu	a5,4(a3)
        n = fixsize(n);
ffffffffc020088c:	1982                	slli	s3,s3,0x20
ffffffffc020088e:	0209d993          	srli	s3,s3,0x20
    if (buddy_root->longest[index] < n)
ffffffffc0200892:	eb37f2e3          	bgeu	a5,s3,ffffffffc0200736 <buddy_system_alloc_pages+0x3e>
        return NULL;
ffffffffc0200896:	4501                	li	a0,0
ffffffffc0200898:	a835                	j	ffffffffc02008d4 <buddy_system_alloc_pages+0x1dc>
    while(index)
ffffffffc020089a:	cc8d                	beqz	s1,ffffffffc02008d4 <buddy_system_alloc_pages+0x1dc>
    if( index%2==1 && buddy_root->longest[index+1]==node_size) 
ffffffffc020089c:	008a3603          	ld	a2,8(s4)
ffffffffc02008a0:	bf81                	j	ffffffffc02007f0 <buddy_system_alloc_pages+0xf8>
        offset = (index + 1) * node_size - buddy_root->size;
ffffffffc02008a2:	026687bb          	mulw	a5,a3,t1
            struct Page* right = buddy_base + offset + node_size;
ffffffffc02008a6:	02031713          	slli	a4,t1,0x20
ffffffffc02008aa:	9301                	srli	a4,a4,0x20
ffffffffc02008ac:	0014841b          	addiw	s0,s1,1
        offset = (index + 1) * node_size - buddy_root->size;
ffffffffc02008b0:	411787bb          	subw	a5,a5,a7
            struct Page* right = buddy_base + offset + node_size;
ffffffffc02008b4:	1782                	slli	a5,a5,0x20
ffffffffc02008b6:	9381                	srli	a5,a5,0x20
ffffffffc02008b8:	97ba                	add	a5,a5,a4
ffffffffc02008ba:	00279713          	slli	a4,a5,0x2
ffffffffc02008be:	97ba                	add	a5,a5,a4
ffffffffc02008c0:	078e                	slli	a5,a5,0x3
ffffffffc02008c2:	97c2                	add	a5,a5,a6
            SetPageProperty(right);            
ffffffffc02008c4:	6798                	ld	a4,8(a5)
            right->property = node_size;
ffffffffc02008c6:	0067a823          	sw	t1,16(a5)
            SetPageProperty(right);            
ffffffffc02008ca:	00276713          	ori	a4,a4,2
ffffffffc02008ce:	e798                	sd	a4,8(a5)
    while(index)
ffffffffc02008d0:	b715                	j	ffffffffc02007f4 <buddy_system_alloc_pages+0xfc>
ffffffffc02008d2:	f0c9                	bnez	s1,ffffffffc0200854 <buddy_system_alloc_pages+0x15c>
}
ffffffffc02008d4:	70e2                	ld	ra,56(sp)
ffffffffc02008d6:	7442                	ld	s0,48(sp)
ffffffffc02008d8:	74a2                	ld	s1,40(sp)
ffffffffc02008da:	7902                	ld	s2,32(sp)
ffffffffc02008dc:	69e2                	ld	s3,24(sp)
ffffffffc02008de:	6a42                	ld	s4,16(sp)
ffffffffc02008e0:	6aa2                	ld	s5,8(sp)
ffffffffc02008e2:	6b02                	ld	s6,0(sp)
ffffffffc02008e4:	6121                	addi	sp,sp,64
ffffffffc02008e6:	8082                	ret
            struct Page* right = buddy_base + offset + node_size;
ffffffffc02008e8:	99d6                	add	s3,s3,s5
ffffffffc02008ea:	00299793          	slli	a5,s3,0x2
ffffffffc02008ee:	99be                	add	s3,s3,a5
ffffffffc02008f0:	00399793          	slli	a5,s3,0x3
ffffffffc02008f4:	97c2                	add	a5,a5,a6
            SetPageProperty(right);            
ffffffffc02008f6:	6798                	ld	a4,8(a5)
            right->property = node_size;
ffffffffc02008f8:	0127a823          	sw	s2,16(a5)
            SetPageProperty(right);            
ffffffffc02008fc:	00276713          	ori	a4,a4,2
ffffffffc0200900:	e798                	sd	a4,8(a5)
ffffffffc0200902:	b5fd                	j	ffffffffc02007f0 <buddy_system_alloc_pages+0xf8>
    cprintf("index:%u\n", index);
ffffffffc0200904:	4581                	li	a1,0
    buddy_root->longest[index] = 0;
ffffffffc0200906:	0006a223          	sw	zero,4(a3)
    cprintf("index:%u\n", index);
ffffffffc020090a:	00001517          	auipc	a0,0x1
ffffffffc020090e:	0b650513          	addi	a0,a0,182 # ffffffffc02019c0 <etext+0x346>
ffffffffc0200912:	83bff0ef          	jal	ra,ffffffffc020014c <cprintf>
    cprintf("offset:%u\n", offset);
ffffffffc0200916:	4581                	li	a1,0
ffffffffc0200918:	00001517          	auipc	a0,0x1
ffffffffc020091c:	0b850513          	addi	a0,a0,184 # ffffffffc02019d0 <etext+0x356>
ffffffffc0200920:	82dff0ef          	jal	ra,ffffffffc020014c <cprintf>
    page = buddy_base + offset;
ffffffffc0200924:	000a3503          	ld	a0,0(s4)
    buddy_nr_free -= n;
ffffffffc0200928:	010a2783          	lw	a5,16(s4)
    ClearPageProperty(page);
ffffffffc020092c:	6518                	ld	a4,8(a0)
    buddy_nr_free -= n;
ffffffffc020092e:	413789bb          	subw	s3,a5,s3
    page->property = 0;
ffffffffc0200932:	00052823          	sw	zero,16(a0)
    ClearPageProperty(page);
ffffffffc0200936:	ffd77793          	andi	a5,a4,-3
ffffffffc020093a:	e51c                	sd	a5,8(a0)
    buddy_nr_free -= n;
ffffffffc020093c:	013a2823          	sw	s3,16(s4)
    if( index%2==1 && buddy_root->longest[index+1]==node_size) 
ffffffffc0200940:	bf51                	j	ffffffffc02008d4 <buddy_system_alloc_pages+0x1dc>
    assert(n > 0);
ffffffffc0200942:	00001697          	auipc	a3,0x1
ffffffffc0200946:	03e68693          	addi	a3,a3,62 # ffffffffc0201980 <etext+0x306>
ffffffffc020094a:	00001617          	auipc	a2,0x1
ffffffffc020094e:	03e60613          	addi	a2,a2,62 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200952:	07000593          	li	a1,112
ffffffffc0200956:	00001517          	auipc	a0,0x1
ffffffffc020095a:	04a50513          	addi	a0,a0,74 # ffffffffc02019a0 <etext+0x326>
ffffffffc020095e:	865ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200962 <buddy_system_check>:

static void
buddy_system_check(void)
{
ffffffffc0200962:	1101                	addi	sp,sp,-32
    cprintf("Buddy System Physical Memory Manager Check Start\n");
ffffffffc0200964:	00001517          	auipc	a0,0x1
ffffffffc0200968:	07c50513          	addi	a0,a0,124 # ffffffffc02019e0 <etext+0x366>
{
ffffffffc020096c:	ec06                	sd	ra,24(sp)
ffffffffc020096e:	e822                	sd	s0,16(sp)
ffffffffc0200970:	e426                	sd	s1,8(sp)
    cprintf("Buddy System Physical Memory Manager Check Start\n");
ffffffffc0200972:	fdaff0ef          	jal	ra,ffffffffc020014c <cprintf>
    test_tree_structure();
ffffffffc0200976:	c71ff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>
    struct Page *p1, *p2, *p3, *p4;

    //分配非兄弟节点测试
    p1 = alloc_pages(10);
ffffffffc020097a:	4529                	li	a0,10
ffffffffc020097c:	67a000ef          	jal	ra,ffffffffc0200ff6 <alloc_pages>
    assert(p1 != NULL);
ffffffffc0200980:	28050663          	beqz	a0,ffffffffc0200c0c <buddy_system_check+0x2aa>
    cprintf("Allocated 10 pages at %p\n", p1);
ffffffffc0200984:	85aa                	mv	a1,a0
ffffffffc0200986:	842a                	mv	s0,a0
ffffffffc0200988:	00001517          	auipc	a0,0x1
ffffffffc020098c:	0a050513          	addi	a0,a0,160 # ffffffffc0201a28 <etext+0x3ae>
ffffffffc0200990:	fbcff0ef          	jal	ra,ffffffffc020014c <cprintf>
    test_tree_structure();
ffffffffc0200994:	c53ff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>

    p2 = alloc_pages(20);
ffffffffc0200998:	4551                	li	a0,20
ffffffffc020099a:	65c000ef          	jal	ra,ffffffffc0200ff6 <alloc_pages>
ffffffffc020099e:	84aa                	mv	s1,a0
    assert(p2 != NULL);
ffffffffc02009a0:	24050663          	beqz	a0,ffffffffc0200bec <buddy_system_check+0x28a>
    cprintf("Allocated 20 pages at %p\n", p2);
ffffffffc02009a4:	85aa                	mv	a1,a0
ffffffffc02009a6:	00001517          	auipc	a0,0x1
ffffffffc02009aa:	0b250513          	addi	a0,a0,178 # ffffffffc0201a58 <etext+0x3de>
ffffffffc02009ae:	f9eff0ef          	jal	ra,ffffffffc020014c <cprintf>
    test_tree_structure();
ffffffffc02009b2:	c35ff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>

    assert(page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc02009b6:	401c                	lw	a5,0(s0)
ffffffffc02009b8:	18079a63          	bnez	a5,ffffffffc0200b4c <buddy_system_check+0x1ea>
ffffffffc02009bc:	409c                	lw	a5,0(s1)
ffffffffc02009be:	18079763          	bnez	a5,ffffffffc0200b4c <buddy_system_check+0x1ea>
extern struct Page *pages;
extern size_t npage;
extern const size_t nbase;
extern uint64_t va_pa_offset;

static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02009c2:	00005797          	auipc	a5,0x5
ffffffffc02009c6:	68e7b783          	ld	a5,1678(a5) # ffffffffc0206050 <pages>
ffffffffc02009ca:	40f40733          	sub	a4,s0,a5
ffffffffc02009ce:	870d                	srai	a4,a4,0x3
ffffffffc02009d0:	00001597          	auipc	a1,0x1
ffffffffc02009d4:	6f05b583          	ld	a1,1776(a1) # ffffffffc02020c0 <error_string+0x38>
ffffffffc02009d8:	02b70733          	mul	a4,a4,a1
ffffffffc02009dc:	00001617          	auipc	a2,0x1
ffffffffc02009e0:	6ec63603          	ld	a2,1772(a2) # ffffffffc02020c8 <nbase>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc02009e4:	00005697          	auipc	a3,0x5
ffffffffc02009e8:	6646b683          	ld	a3,1636(a3) # ffffffffc0206048 <npage>
ffffffffc02009ec:	06b2                	slli	a3,a3,0xc
ffffffffc02009ee:	9732                	add	a4,a4,a2

static inline uintptr_t page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
ffffffffc02009f0:	0732                	slli	a4,a4,0xc
ffffffffc02009f2:	2cd77d63          	bgeu	a4,a3,ffffffffc0200ccc <buddy_system_check+0x36a>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc02009f6:	40f487b3          	sub	a5,s1,a5
ffffffffc02009fa:	878d                	srai	a5,a5,0x3
ffffffffc02009fc:	02b787b3          	mul	a5,a5,a1
ffffffffc0200a00:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200a02:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0200a04:	2ad7f463          	bgeu	a5,a3,ffffffffc0200cac <buddy_system_check+0x34a>
    assert(p2 == p1 + 32);
ffffffffc0200a08:	50040793          	addi	a5,s0,1280
ffffffffc0200a0c:	28f49063          	bne	s1,a5,ffffffffc0200c8c <buddy_system_check+0x32a>
    assert(!PageReserved(p1) && !PageProperty(p1));
ffffffffc0200a10:	641c                	ld	a5,8(s0)
ffffffffc0200a12:	8b8d                	andi	a5,a5,3
ffffffffc0200a14:	24079c63          	bnez	a5,ffffffffc0200c6c <buddy_system_check+0x30a>
    assert(!PageReserved(p2) && !PageProperty(p2));
ffffffffc0200a18:	649c                	ld	a5,8(s1)
ffffffffc0200a1a:	8b8d                	andi	a5,a5,3
ffffffffc0200a1c:	1a079863          	bnez	a5,ffffffffc0200bcc <buddy_system_check+0x26a>

    //释放后分配测试
    free_pages(p1, 10);
ffffffffc0200a20:	8522                	mv	a0,s0
ffffffffc0200a22:	45a9                	li	a1,10
ffffffffc0200a24:	5de000ef          	jal	ra,ffffffffc0201002 <free_pages>
    cprintf("Freed 10 pages at %p\n", p1);
ffffffffc0200a28:	85a2                	mv	a1,s0
ffffffffc0200a2a:	00001517          	auipc	a0,0x1
ffffffffc0200a2e:	11650513          	addi	a0,a0,278 # ffffffffc0201b40 <etext+0x4c6>
ffffffffc0200a32:	f1aff0ef          	jal	ra,ffffffffc020014c <cprintf>
    test_tree_structure();
ffffffffc0200a36:	bb1ff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>

    p3 = alloc_pages(5);
ffffffffc0200a3a:	4515                	li	a0,5
ffffffffc0200a3c:	5ba000ef          	jal	ra,ffffffffc0200ff6 <alloc_pages>
ffffffffc0200a40:	842a                	mv	s0,a0
    assert(p3 != NULL);
ffffffffc0200a42:	16050563          	beqz	a0,ffffffffc0200bac <buddy_system_check+0x24a>
    cprintf("Allocated 5 pages at %p\n", p3);
ffffffffc0200a46:	85aa                	mv	a1,a0
ffffffffc0200a48:	00001517          	auipc	a0,0x1
ffffffffc0200a4c:	12050513          	addi	a0,a0,288 # ffffffffc0201b68 <etext+0x4ee>
ffffffffc0200a50:	efcff0ef          	jal	ra,ffffffffc020014c <cprintf>
    test_tree_structure();
ffffffffc0200a54:	b93ff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>

    free_pages(p3, 5);
ffffffffc0200a58:	8522                	mv	a0,s0
ffffffffc0200a5a:	4595                	li	a1,5
ffffffffc0200a5c:	5a6000ef          	jal	ra,ffffffffc0201002 <free_pages>
    cprintf("Freed 5 pages at %p\n", p3);
ffffffffc0200a60:	85a2                	mv	a1,s0
ffffffffc0200a62:	00001517          	auipc	a0,0x1
ffffffffc0200a66:	12650513          	addi	a0,a0,294 # ffffffffc0201b88 <etext+0x50e>
ffffffffc0200a6a:	ee2ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    test_tree_structure();
ffffffffc0200a6e:	b79ff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>

    free_pages(p2, 20);
ffffffffc0200a72:	8526                	mv	a0,s1
ffffffffc0200a74:	45d1                	li	a1,20
ffffffffc0200a76:	58c000ef          	jal	ra,ffffffffc0201002 <free_pages>
    cprintf("Freed 20 pages at %p\n", p2);
ffffffffc0200a7a:	85a6                	mv	a1,s1
ffffffffc0200a7c:	00001517          	auipc	a0,0x1
ffffffffc0200a80:	12450513          	addi	a0,a0,292 # ffffffffc0201ba0 <etext+0x526>
ffffffffc0200a84:	ec8ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    test_tree_structure();
ffffffffc0200a88:	b5fff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>

    //分配兄弟节点测试
    p3 = alloc_pages(1);
ffffffffc0200a8c:	4505                	li	a0,1
ffffffffc0200a8e:	568000ef          	jal	ra,ffffffffc0200ff6 <alloc_pages>
ffffffffc0200a92:	842a                	mv	s0,a0
    assert(p3 != NULL);
ffffffffc0200a94:	0e050c63          	beqz	a0,ffffffffc0200b8c <buddy_system_check+0x22a>
    cprintf("Allocated 1 page at %p\n", p3);
ffffffffc0200a98:	85aa                	mv	a1,a0
ffffffffc0200a9a:	00001517          	auipc	a0,0x1
ffffffffc0200a9e:	11e50513          	addi	a0,a0,286 # ffffffffc0201bb8 <etext+0x53e>
ffffffffc0200aa2:	eaaff0ef          	jal	ra,ffffffffc020014c <cprintf>
    test_tree_structure();
ffffffffc0200aa6:	b41ff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>
    assert(!PageProperty(p3) && PageProperty(p3 + 1));
ffffffffc0200aaa:	641c                	ld	a5,8(s0)
ffffffffc0200aac:	8b89                	andi	a5,a5,2
ffffffffc0200aae:	efdd                	bnez	a5,ffffffffc0200b6c <buddy_system_check+0x20a>
ffffffffc0200ab0:	781c                	ld	a5,48(s0)
ffffffffc0200ab2:	8b89                	andi	a5,a5,2
ffffffffc0200ab4:	cfc5                	beqz	a5,ffffffffc0200b6c <buddy_system_check+0x20a>

    p4 = alloc_pages(1);
ffffffffc0200ab6:	4505                	li	a0,1
ffffffffc0200ab8:	53e000ef          	jal	ra,ffffffffc0200ff6 <alloc_pages>
ffffffffc0200abc:	84aa                	mv	s1,a0
    assert(p4 != NULL);
ffffffffc0200abe:	18050763          	beqz	a0,ffffffffc0200c4c <buddy_system_check+0x2ea>
    cprintf("Allocated 1 page at %p\n", p4);
ffffffffc0200ac2:	85aa                	mv	a1,a0
ffffffffc0200ac4:	00001517          	auipc	a0,0x1
ffffffffc0200ac8:	0f450513          	addi	a0,a0,244 # ffffffffc0201bb8 <etext+0x53e>
ffffffffc0200acc:	e80ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    test_tree_structure();
ffffffffc0200ad0:	b17ff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>

    free_pages(p3, 1);
ffffffffc0200ad4:	8522                	mv	a0,s0
ffffffffc0200ad6:	4585                	li	a1,1
ffffffffc0200ad8:	52a000ef          	jal	ra,ffffffffc0201002 <free_pages>
    free_pages(p4, 1);
ffffffffc0200adc:	8526                	mv	a0,s1
ffffffffc0200ade:	4585                	li	a1,1
ffffffffc0200ae0:	522000ef          	jal	ra,ffffffffc0201002 <free_pages>
    test_tree_structure();

    //分配最大块测试
    p1 = alloc_pages(buddy_root->size);
ffffffffc0200ae4:	00005497          	auipc	s1,0x5
ffffffffc0200ae8:	53448493          	addi	s1,s1,1332 # ffffffffc0206018 <buddy_system>
    test_tree_structure();
ffffffffc0200aec:	afbff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>
    p1 = alloc_pages(buddy_root->size);
ffffffffc0200af0:	649c                	ld	a5,8(s1)
ffffffffc0200af2:	0007e503          	lwu	a0,0(a5)
ffffffffc0200af6:	500000ef          	jal	ra,ffffffffc0200ff6 <alloc_pages>
ffffffffc0200afa:	842a                	mv	s0,a0
    assert(p1 != NULL);
ffffffffc0200afc:	12050863          	beqz	a0,ffffffffc0200c2c <buddy_system_check+0x2ca>
    cprintf("Allocated %u pages at %p\n", buddy_root->size, p1);
ffffffffc0200b00:	649c                	ld	a5,8(s1)
ffffffffc0200b02:	862a                	mv	a2,a0
ffffffffc0200b04:	00001517          	auipc	a0,0x1
ffffffffc0200b08:	10c50513          	addi	a0,a0,268 # ffffffffc0201c10 <etext+0x596>
ffffffffc0200b0c:	438c                	lw	a1,0(a5)
ffffffffc0200b0e:	e3eff0ef          	jal	ra,ffffffffc020014c <cprintf>
    test_tree_structure();
ffffffffc0200b12:	ad5ff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>
    free_pages(p1, buddy_root->size);
ffffffffc0200b16:	649c                	ld	a5,8(s1)
ffffffffc0200b18:	8522                	mv	a0,s0
ffffffffc0200b1a:	0007e583          	lwu	a1,0(a5)
ffffffffc0200b1e:	4e4000ef          	jal	ra,ffffffffc0201002 <free_pages>
    cprintf("Freed %u pages at %p\n", buddy_root->size, p1);
ffffffffc0200b22:	649c                	ld	a5,8(s1)
ffffffffc0200b24:	8622                	mv	a2,s0
ffffffffc0200b26:	00001517          	auipc	a0,0x1
ffffffffc0200b2a:	10a50513          	addi	a0,a0,266 # ffffffffc0201c30 <etext+0x5b6>
ffffffffc0200b2e:	438c                	lw	a1,0(a5)
ffffffffc0200b30:	e1cff0ef          	jal	ra,ffffffffc020014c <cprintf>
    test_tree_structure();
ffffffffc0200b34:	ab3ff0ef          	jal	ra,ffffffffc02005e6 <test_tree_structure>

    cprintf("Buddy System Physical Memory Manager Check OK\n");
}
ffffffffc0200b38:	6442                	ld	s0,16(sp)
ffffffffc0200b3a:	60e2                	ld	ra,24(sp)
ffffffffc0200b3c:	64a2                	ld	s1,8(sp)
    cprintf("Buddy System Physical Memory Manager Check OK\n");
ffffffffc0200b3e:	00001517          	auipc	a0,0x1
ffffffffc0200b42:	10a50513          	addi	a0,a0,266 # ffffffffc0201c48 <etext+0x5ce>
}
ffffffffc0200b46:	6105                	addi	sp,sp,32
    cprintf("Buddy System Physical Memory Manager Check OK\n");
ffffffffc0200b48:	e04ff06f          	j	ffffffffc020014c <cprintf>
    assert(page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200b4c:	00001697          	auipc	a3,0x1
ffffffffc0200b50:	f2c68693          	addi	a3,a3,-212 # ffffffffc0201a78 <etext+0x3fe>
ffffffffc0200b54:	00001617          	auipc	a2,0x1
ffffffffc0200b58:	e3460613          	addi	a2,a2,-460 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200b5c:	10f00593          	li	a1,271
ffffffffc0200b60:	00001517          	auipc	a0,0x1
ffffffffc0200b64:	e4050513          	addi	a0,a0,-448 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200b68:	e5aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(!PageProperty(p3) && PageProperty(p3 + 1));
ffffffffc0200b6c:	00001697          	auipc	a3,0x1
ffffffffc0200b70:	06468693          	addi	a3,a3,100 # ffffffffc0201bd0 <etext+0x556>
ffffffffc0200b74:	00001617          	auipc	a2,0x1
ffffffffc0200b78:	e1460613          	addi	a2,a2,-492 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200b7c:	12d00593          	li	a1,301
ffffffffc0200b80:	00001517          	auipc	a0,0x1
ffffffffc0200b84:	e2050513          	addi	a0,a0,-480 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200b88:	e3aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(p3 != NULL);
ffffffffc0200b8c:	00001697          	auipc	a3,0x1
ffffffffc0200b90:	fcc68693          	addi	a3,a3,-52 # ffffffffc0201b58 <etext+0x4de>
ffffffffc0200b94:	00001617          	auipc	a2,0x1
ffffffffc0200b98:	df460613          	addi	a2,a2,-524 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200b9c:	12a00593          	li	a1,298
ffffffffc0200ba0:	00001517          	auipc	a0,0x1
ffffffffc0200ba4:	e0050513          	addi	a0,a0,-512 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200ba8:	e1aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(p3 != NULL);
ffffffffc0200bac:	00001697          	auipc	a3,0x1
ffffffffc0200bb0:	fac68693          	addi	a3,a3,-84 # ffffffffc0201b58 <etext+0x4de>
ffffffffc0200bb4:	00001617          	auipc	a2,0x1
ffffffffc0200bb8:	dd460613          	addi	a2,a2,-556 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200bbc:	11c00593          	li	a1,284
ffffffffc0200bc0:	00001517          	auipc	a0,0x1
ffffffffc0200bc4:	de050513          	addi	a0,a0,-544 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200bc8:	dfaff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(!PageReserved(p2) && !PageProperty(p2));
ffffffffc0200bcc:	00001697          	auipc	a3,0x1
ffffffffc0200bd0:	f4c68693          	addi	a3,a3,-180 # ffffffffc0201b18 <etext+0x49e>
ffffffffc0200bd4:	00001617          	auipc	a2,0x1
ffffffffc0200bd8:	db460613          	addi	a2,a2,-588 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200bdc:	11400593          	li	a1,276
ffffffffc0200be0:	00001517          	auipc	a0,0x1
ffffffffc0200be4:	dc050513          	addi	a0,a0,-576 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200be8:	ddaff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(p2 != NULL);
ffffffffc0200bec:	00001697          	auipc	a3,0x1
ffffffffc0200bf0:	e5c68693          	addi	a3,a3,-420 # ffffffffc0201a48 <etext+0x3ce>
ffffffffc0200bf4:	00001617          	auipc	a2,0x1
ffffffffc0200bf8:	d9460613          	addi	a2,a2,-620 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200bfc:	10b00593          	li	a1,267
ffffffffc0200c00:	00001517          	auipc	a0,0x1
ffffffffc0200c04:	da050513          	addi	a0,a0,-608 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200c08:	dbaff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(p1 != NULL);
ffffffffc0200c0c:	00001697          	auipc	a3,0x1
ffffffffc0200c10:	e0c68693          	addi	a3,a3,-500 # ffffffffc0201a18 <etext+0x39e>
ffffffffc0200c14:	00001617          	auipc	a2,0x1
ffffffffc0200c18:	d7460613          	addi	a2,a2,-652 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200c1c:	10600593          	li	a1,262
ffffffffc0200c20:	00001517          	auipc	a0,0x1
ffffffffc0200c24:	d8050513          	addi	a0,a0,-640 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200c28:	d9aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(p1 != NULL);
ffffffffc0200c2c:	00001697          	auipc	a3,0x1
ffffffffc0200c30:	dec68693          	addi	a3,a3,-532 # ffffffffc0201a18 <etext+0x39e>
ffffffffc0200c34:	00001617          	auipc	a2,0x1
ffffffffc0200c38:	d5460613          	addi	a2,a2,-684 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200c3c:	13a00593          	li	a1,314
ffffffffc0200c40:	00001517          	auipc	a0,0x1
ffffffffc0200c44:	d6050513          	addi	a0,a0,-672 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200c48:	d7aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(p4 != NULL);
ffffffffc0200c4c:	00001697          	auipc	a3,0x1
ffffffffc0200c50:	fb468693          	addi	a3,a3,-76 # ffffffffc0201c00 <etext+0x586>
ffffffffc0200c54:	00001617          	auipc	a2,0x1
ffffffffc0200c58:	d3460613          	addi	a2,a2,-716 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200c5c:	13000593          	li	a1,304
ffffffffc0200c60:	00001517          	auipc	a0,0x1
ffffffffc0200c64:	d4050513          	addi	a0,a0,-704 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200c68:	d5aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(!PageReserved(p1) && !PageProperty(p1));
ffffffffc0200c6c:	00001697          	auipc	a3,0x1
ffffffffc0200c70:	e8468693          	addi	a3,a3,-380 # ffffffffc0201af0 <etext+0x476>
ffffffffc0200c74:	00001617          	auipc	a2,0x1
ffffffffc0200c78:	d1460613          	addi	a2,a2,-748 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200c7c:	11300593          	li	a1,275
ffffffffc0200c80:	00001517          	auipc	a0,0x1
ffffffffc0200c84:	d2050513          	addi	a0,a0,-736 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200c88:	d3aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(p2 == p1 + 32);
ffffffffc0200c8c:	00001697          	auipc	a3,0x1
ffffffffc0200c90:	e5468693          	addi	a3,a3,-428 # ffffffffc0201ae0 <etext+0x466>
ffffffffc0200c94:	00001617          	auipc	a2,0x1
ffffffffc0200c98:	cf460613          	addi	a2,a2,-780 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200c9c:	11200593          	li	a1,274
ffffffffc0200ca0:	00001517          	auipc	a0,0x1
ffffffffc0200ca4:	d0050513          	addi	a0,a0,-768 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200ca8:	d1aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0200cac:	00001697          	auipc	a3,0x1
ffffffffc0200cb0:	e1468693          	addi	a3,a3,-492 # ffffffffc0201ac0 <etext+0x446>
ffffffffc0200cb4:	00001617          	auipc	a2,0x1
ffffffffc0200cb8:	cd460613          	addi	a2,a2,-812 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200cbc:	11100593          	li	a1,273
ffffffffc0200cc0:	00001517          	auipc	a0,0x1
ffffffffc0200cc4:	ce050513          	addi	a0,a0,-800 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200cc8:	cfaff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0200ccc:	00001697          	auipc	a3,0x1
ffffffffc0200cd0:	dd468693          	addi	a3,a3,-556 # ffffffffc0201aa0 <etext+0x426>
ffffffffc0200cd4:	00001617          	auipc	a2,0x1
ffffffffc0200cd8:	cb460613          	addi	a2,a2,-844 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200cdc:	11000593          	li	a1,272
ffffffffc0200ce0:	00001517          	auipc	a0,0x1
ffffffffc0200ce4:	cc050513          	addi	a0,a0,-832 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200ce8:	cdaff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200cec <buddy_system_init_memmap>:
{
ffffffffc0200cec:	1141                	addi	sp,sp,-16
ffffffffc0200cee:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0200cf0:	10058e63          	beqz	a1,ffffffffc0200e0c <buddy_system_init_memmap+0x120>
    for (; p != base + n; p++)
ffffffffc0200cf4:	00259693          	slli	a3,a1,0x2
ffffffffc0200cf8:	96ae                	add	a3,a3,a1
ffffffffc0200cfa:	068e                	slli	a3,a3,0x3
ffffffffc0200cfc:	96aa                	add	a3,a3,a0
ffffffffc0200cfe:	87aa                	mv	a5,a0
ffffffffc0200d00:	00a68f63          	beq	a3,a0,ffffffffc0200d1e <buddy_system_init_memmap+0x32>
        assert(PageReserved(p));
ffffffffc0200d04:	6798                	ld	a4,8(a5)
ffffffffc0200d06:	8b05                	andi	a4,a4,1
ffffffffc0200d08:	c375                	beqz	a4,ffffffffc0200dec <buddy_system_init_memmap+0x100>
        p->flags = p->property = 0;
ffffffffc0200d0a:	0007a823          	sw	zero,16(a5)
ffffffffc0200d0e:	0007b423          	sd	zero,8(a5)



static inline int page_ref(struct Page *page) { return page->ref; }

static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc0200d12:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc0200d16:	02878793          	addi	a5,a5,40
ffffffffc0200d1a:	fef695e3          	bne	a3,a5,ffffffffc0200d04 <buddy_system_init_memmap+0x18>
    buddy_base = base;
ffffffffc0200d1e:	00005817          	auipc	a6,0x5
ffffffffc0200d22:	2fa80813          	addi	a6,a6,762 # ffffffffc0206018 <buddy_system>
    buddy_total_size = n;
ffffffffc0200d26:	2581                	sext.w	a1,a1
    buddy_base = base;
ffffffffc0200d28:	00a83023          	sd	a0,0(a6)
    buddy_total_size = n;
ffffffffc0200d2c:	00b82a23          	sw	a1,20(a6)
    unsigned res = 1;
ffffffffc0200d30:	4785                	li	a5,1
    while (res <= size)
ffffffffc0200d32:	567d                	li	a2,-1
ffffffffc0200d34:	cd99                	beqz	a1,ffffffffc0200d52 <buddy_system_init_memmap+0x66>
        res <<= 1;
ffffffffc0200d36:	0017971b          	slliw	a4,a5,0x1
ffffffffc0200d3a:	0007869b          	sext.w	a3,a5
ffffffffc0200d3e:	0007079b          	sext.w	a5,a4
    while (res <= size)
ffffffffc0200d42:	fef5fae3          	bgeu	a1,a5,ffffffffc0200d36 <buddy_system_init_memmap+0x4a>
    return res >> 1;
ffffffffc0200d46:	1686                	slli	a3,a3,0x21
ffffffffc0200d48:	0216d593          	srli	a1,a3,0x21
    unsigned int len = size * 2 - 1;
ffffffffc0200d4c:	0015961b          	slliw	a2,a1,0x1
ffffffffc0200d50:	367d                	addiw	a2,a2,-1
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200d52:	00005797          	auipc	a5,0x5
ffffffffc0200d56:	2fe7b783          	ld	a5,766(a5) # ffffffffc0206050 <pages>
ffffffffc0200d5a:	40f507b3          	sub	a5,a0,a5
ffffffffc0200d5e:	00001717          	auipc	a4,0x1
ffffffffc0200d62:	36273703          	ld	a4,866(a4) # ffffffffc02020c0 <error_string+0x38>
ffffffffc0200d66:	878d                	srai	a5,a5,0x3
ffffffffc0200d68:	02e787b3          	mul	a5,a5,a4
ffffffffc0200d6c:	00001717          	auipc	a4,0x1
ffffffffc0200d70:	35c73703          	ld	a4,860(a4) # ffffffffc02020c8 <nbase>
    buddy_nr_free = size;
ffffffffc0200d74:	00b82823          	sw	a1,16(a6)
    buddy_root = (buddy2 *)KADDR(page2pa(base)); // buddy2结构紧跟在Page数组后面
ffffffffc0200d78:	00005697          	auipc	a3,0x5
ffffffffc0200d7c:	2d06b683          	ld	a3,720(a3) # ffffffffc0206048 <npage>
ffffffffc0200d80:	97ba                	add	a5,a5,a4
ffffffffc0200d82:	00c79713          	slli	a4,a5,0xc
ffffffffc0200d86:	8331                	srli	a4,a4,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0200d88:	07b2                	slli	a5,a5,0xc
ffffffffc0200d8a:	0ad77163          	bgeu	a4,a3,ffffffffc0200e2c <buddy_system_init_memmap+0x140>
ffffffffc0200d8e:	00005697          	auipc	a3,0x5
ffffffffc0200d92:	2e26b683          	ld	a3,738(a3) # ffffffffc0206070 <va_pa_offset>
ffffffffc0200d96:	97b6                	add	a5,a5,a3
ffffffffc0200d98:	00f83423          	sd	a5,8(a6)
    buddy_root->size = size;
ffffffffc0200d9c:	c38c                	sw	a1,0(a5)
    for (unsigned int i = 0; i < len; i++)
ffffffffc0200d9e:	00478693          	addi	a3,a5,4
ffffffffc0200da2:	4701                	li	a4,0
        buddy_root->longest[i] = 1;
ffffffffc0200da4:	4805                	li	a6,1
ffffffffc0200da6:	0106a023          	sw	a6,0(a3)
    for (unsigned int i = 0; i < len; i++)
ffffffffc0200daa:	2705                	addiw	a4,a4,1
ffffffffc0200dac:	0691                	addi	a3,a3,4
ffffffffc0200dae:	fec76ce3          	bltu	a4,a2,ffffffffc0200da6 <buddy_system_init_memmap+0xba>
    for (int i = size - 2; i >= 0; i--)
ffffffffc0200db2:	ffe5861b          	addiw	a2,a1,-2
ffffffffc0200db6:	02064363          	bltz	a2,ffffffffc0200ddc <buddy_system_init_memmap+0xf0>
ffffffffc0200dba:	fff5871b          	addiw	a4,a1,-1
ffffffffc0200dbe:	00371693          	slli	a3,a4,0x3
ffffffffc0200dc2:	070a                	slli	a4,a4,0x2
ffffffffc0200dc4:	96be                	add	a3,a3,a5
ffffffffc0200dc6:	587d                	li	a6,-1
ffffffffc0200dc8:	97ba                	add	a5,a5,a4
        buddy_root->longest[i] = buddy_root->longest[LEFT_LEAF(i)] * 2;
ffffffffc0200dca:	4298                	lw	a4,0(a3)
    for (int i = size - 2; i >= 0; i--)
ffffffffc0200dcc:	367d                	addiw	a2,a2,-1
ffffffffc0200dce:	16e1                	addi	a3,a3,-8
        buddy_root->longest[i] = buddy_root->longest[LEFT_LEAF(i)] * 2;
ffffffffc0200dd0:	0017171b          	slliw	a4,a4,0x1
ffffffffc0200dd4:	c398                	sw	a4,0(a5)
    for (int i = size - 2; i >= 0; i--)
ffffffffc0200dd6:	17f1                	addi	a5,a5,-4
ffffffffc0200dd8:	ff0619e3          	bne	a2,a6,ffffffffc0200dca <buddy_system_init_memmap+0xde>
    SetPageProperty(buddy_base);
ffffffffc0200ddc:	651c                	ld	a5,8(a0)
}
ffffffffc0200dde:	60a2                	ld	ra,8(sp)
    buddy_base->property = size;
ffffffffc0200de0:	c90c                	sw	a1,16(a0)
    SetPageProperty(buddy_base);
ffffffffc0200de2:	0027e793          	ori	a5,a5,2
ffffffffc0200de6:	e51c                	sd	a5,8(a0)
}
ffffffffc0200de8:	0141                	addi	sp,sp,16
ffffffffc0200dea:	8082                	ret
        assert(PageReserved(p));
ffffffffc0200dec:	00001697          	auipc	a3,0x1
ffffffffc0200df0:	e8c68693          	addi	a3,a3,-372 # ffffffffc0201c78 <etext+0x5fe>
ffffffffc0200df4:	00001617          	auipc	a2,0x1
ffffffffc0200df8:	b9460613          	addi	a2,a2,-1132 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200dfc:	04200593          	li	a1,66
ffffffffc0200e00:	00001517          	auipc	a0,0x1
ffffffffc0200e04:	ba050513          	addi	a0,a0,-1120 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200e08:	bbaff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200e0c:	00001697          	auipc	a3,0x1
ffffffffc0200e10:	b7468693          	addi	a3,a3,-1164 # ffffffffc0201980 <etext+0x306>
ffffffffc0200e14:	00001617          	auipc	a2,0x1
ffffffffc0200e18:	b7460613          	addi	a2,a2,-1164 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200e1c:	03e00593          	li	a1,62
ffffffffc0200e20:	00001517          	auipc	a0,0x1
ffffffffc0200e24:	b8050513          	addi	a0,a0,-1152 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200e28:	b9aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    buddy_root = (buddy2 *)KADDR(page2pa(base)); // buddy2结构紧跟在Page数组后面
ffffffffc0200e2c:	86be                	mv	a3,a5
ffffffffc0200e2e:	00001617          	auipc	a2,0x1
ffffffffc0200e32:	e5a60613          	addi	a2,a2,-422 # ffffffffc0201c88 <etext+0x60e>
ffffffffc0200e36:	04f00593          	li	a1,79
ffffffffc0200e3a:	00001517          	auipc	a0,0x1
ffffffffc0200e3e:	b6650513          	addi	a0,a0,-1178 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200e42:	b80ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200e46 <buddy_system_free_pages>:
{
ffffffffc0200e46:	1141                	addi	sp,sp,-16
ffffffffc0200e48:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0200e4a:	18058663          	beqz	a1,ffffffffc0200fd6 <buddy_system_free_pages+0x190>
    if (!IS_POWER_OF_2(n))
ffffffffc0200e4e:	fff58793          	addi	a5,a1,-1
ffffffffc0200e52:	8fed                	and	a5,a5,a1
ffffffffc0200e54:	0005881b          	sext.w	a6,a1
ffffffffc0200e58:	12079863          	bnez	a5,ffffffffc0200f88 <buddy_system_free_pages+0x142>
    for (; p != base + n; p++)
ffffffffc0200e5c:	00259693          	slli	a3,a1,0x2
ffffffffc0200e60:	96ae                	add	a3,a3,a1
ffffffffc0200e62:	068e                	slli	a3,a3,0x3
ffffffffc0200e64:	96aa                	add	a3,a3,a0
ffffffffc0200e66:	87aa                	mv	a5,a0
ffffffffc0200e68:	00d50e63          	beq	a0,a3,ffffffffc0200e84 <buddy_system_free_pages+0x3e>
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0200e6c:	6798                	ld	a4,8(a5)
ffffffffc0200e6e:	8b0d                	andi	a4,a4,3
ffffffffc0200e70:	14071363          	bnez	a4,ffffffffc0200fb6 <buddy_system_free_pages+0x170>
        p->flags = 0;
ffffffffc0200e74:	0007b423          	sd	zero,8(a5)
static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc0200e78:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc0200e7c:	02878793          	addi	a5,a5,40
ffffffffc0200e80:	fed796e3          	bne	a5,a3,ffffffffc0200e6c <buddy_system_free_pages+0x26>
    buddy_nr_free += n;
ffffffffc0200e84:	00005717          	auipc	a4,0x5
ffffffffc0200e88:	19470713          	addi	a4,a4,404 # ffffffffc0206018 <buddy_system>
    offset = base - buddy_base;
ffffffffc0200e8c:	00073303          	ld	t1,0(a4)
ffffffffc0200e90:	00001697          	auipc	a3,0x1
ffffffffc0200e94:	2306b683          	ld	a3,560(a3) # ffffffffc02020c0 <error_string+0x38>
    index = (offset + buddy_root->size) / n - 1;
ffffffffc0200e98:	6710                	ld	a2,8(a4)
    offset = base - buddy_base;
ffffffffc0200e9a:	406507b3          	sub	a5,a0,t1
ffffffffc0200e9e:	878d                	srai	a5,a5,0x3
ffffffffc0200ea0:	02d787b3          	mul	a5,a5,a3
    index = (offset + buddy_root->size) / n - 1;
ffffffffc0200ea4:	00062883          	lw	a7,0(a2)
    SetPageProperty(base);
ffffffffc0200ea8:	00853e83          	ld	t4,8(a0)
    buddy_nr_free += n;
ffffffffc0200eac:	01072e03          	lw	t3,16(a4)
    base->property = n;
ffffffffc0200eb0:	0005869b          	sext.w	a3,a1
    SetPageProperty(base);
ffffffffc0200eb4:	002eee93          	ori	t4,t4,2
    base->property = n;
ffffffffc0200eb8:	c914                	sw	a3,16(a0)
    SetPageProperty(base);
ffffffffc0200eba:	01d53423          	sd	t4,8(a0)
    buddy_nr_free += n;
ffffffffc0200ebe:	00de053b          	addw	a0,t3,a3
ffffffffc0200ec2:	cb08                	sw	a0,16(a4)
    index = (offset + buddy_root->size) / n - 1;
ffffffffc0200ec4:	011787bb          	addw	a5,a5,a7
ffffffffc0200ec8:	1782                	slli	a5,a5,0x20
ffffffffc0200eca:	9381                	srli	a5,a5,0x20
ffffffffc0200ecc:	02b7d7b3          	divu	a5,a5,a1
ffffffffc0200ed0:	37fd                	addiw	a5,a5,-1
    buddy_root->longest[index] = n;
ffffffffc0200ed2:	02079593          	slli	a1,a5,0x20
ffffffffc0200ed6:	01e5d713          	srli	a4,a1,0x1e
ffffffffc0200eda:	9732                	add	a4,a4,a2
ffffffffc0200edc:	c354                	sw	a3,4(a4)
    while (index)
ffffffffc0200ede:	cbb1                	beqz	a5,ffffffffc0200f32 <buddy_system_free_pages+0xec>
        index = PARENT(index);
ffffffffc0200ee0:	2785                	addiw	a5,a5,1
ffffffffc0200ee2:	0017d51b          	srliw	a0,a5,0x1
ffffffffc0200ee6:	fff5069b          	addiw	a3,a0,-1
        if(buddy_root->longest[LEFT_LEAF(index)] == buddy_root->longest[RIGHT_LEAF(index)] && buddy_root->longest[LEFT_LEAF(index)] == node_size)
ffffffffc0200eea:	0016971b          	slliw	a4,a3,0x1
ffffffffc0200eee:	9bf9                	andi	a5,a5,-2
ffffffffc0200ef0:	2705                	addiw	a4,a4,1
ffffffffc0200ef2:	1782                	slli	a5,a5,0x20
ffffffffc0200ef4:	02071593          	slli	a1,a4,0x20
ffffffffc0200ef8:	9381                	srli	a5,a5,0x20
ffffffffc0200efa:	01e5d713          	srli	a4,a1,0x1e
ffffffffc0200efe:	078a                	slli	a5,a5,0x2
ffffffffc0200f00:	97b2                	add	a5,a5,a2
ffffffffc0200f02:	9732                	add	a4,a4,a2
ffffffffc0200f04:	43cc                	lw	a1,4(a5)
ffffffffc0200f06:	4358                	lw	a4,4(a4)
                buddy_root->longest[index] = buddy_root->longest[LEFT_LEAF(index)] * 2;
ffffffffc0200f08:	00181e1b          	slliw	t3,a6,0x1
ffffffffc0200f0c:	00080e9b          	sext.w	t4,a6
        index = PARENT(index);
ffffffffc0200f10:	0006879b          	sext.w	a5,a3
                buddy_root->longest[index] = buddy_root->longest[LEFT_LEAF(index)] * 2;
ffffffffc0200f14:	000e081b          	sext.w	a6,t3
        if(buddy_root->longest[LEFT_LEAF(index)] == buddy_root->longest[RIGHT_LEAF(index)] && buddy_root->longest[LEFT_LEAF(index)] == node_size)
ffffffffc0200f18:	02b70063          	beq	a4,a1,ffffffffc0200f38 <buddy_system_free_pages+0xf2>
            buddy_root->longest[index] = MAX(buddy_root->longest[LEFT_LEAF(index)], buddy_root->longest[RIGHT_LEAF(index)]);
ffffffffc0200f1c:	02069513          	slli	a0,a3,0x20
ffffffffc0200f20:	01e55693          	srli	a3,a0,0x1e
ffffffffc0200f24:	96b2                	add	a3,a3,a2
ffffffffc0200f26:	853a                	mv	a0,a4
ffffffffc0200f28:	00b77363          	bgeu	a4,a1,ffffffffc0200f2e <buddy_system_free_pages+0xe8>
ffffffffc0200f2c:	852e                	mv	a0,a1
ffffffffc0200f2e:	c2c8                	sw	a0,4(a3)
    while (index)
ffffffffc0200f30:	fbc5                	bnez	a5,ffffffffc0200ee0 <buddy_system_free_pages+0x9a>
}
ffffffffc0200f32:	60a2                	ld	ra,8(sp)
ffffffffc0200f34:	0141                	addi	sp,sp,16
ffffffffc0200f36:	8082                	ret
        if(buddy_root->longest[LEFT_LEAF(index)] == buddy_root->longest[RIGHT_LEAF(index)] && buddy_root->longest[LEFT_LEAF(index)] == node_size)
ffffffffc0200f38:	ffd712e3          	bne	a4,t4,ffffffffc0200f1c <buddy_system_free_pages+0xd6>
                offset = (index + 1) * node_size * 2 - buddy_root->size;
ffffffffc0200f3c:	02e5053b          	mulw	a0,a0,a4
                buddy_root->longest[index] = buddy_root->longest[LEFT_LEAF(index)] * 2;
ffffffffc0200f40:	02069593          	slli	a1,a3,0x20
ffffffffc0200f44:	01e5d693          	srli	a3,a1,0x1e
ffffffffc0200f48:	96b2                	add	a3,a3,a2
ffffffffc0200f4a:	01c6a223          	sw	t3,4(a3)
                struct Page* RPage = LPage + node_size;
ffffffffc0200f4e:	1702                	slli	a4,a4,0x20
ffffffffc0200f50:	9301                	srli	a4,a4,0x20
ffffffffc0200f52:	00271593          	slli	a1,a4,0x2
ffffffffc0200f56:	972e                	add	a4,a4,a1
ffffffffc0200f58:	070e                	slli	a4,a4,0x3
                offset = (index + 1) * node_size * 2 - buddy_root->size;
ffffffffc0200f5a:	0015169b          	slliw	a3,a0,0x1
ffffffffc0200f5e:	411686bb          	subw	a3,a3,a7
                struct Page* LPage = buddy_base + offset;
ffffffffc0200f62:	1682                	slli	a3,a3,0x20
ffffffffc0200f64:	9281                	srli	a3,a3,0x20
ffffffffc0200f66:	00269593          	slli	a1,a3,0x2
ffffffffc0200f6a:	96ae                	add	a3,a3,a1
ffffffffc0200f6c:	068e                	slli	a3,a3,0x3
ffffffffc0200f6e:	969a                	add	a3,a3,t1
                SetPageProperty(LPage);
ffffffffc0200f70:	668c                	ld	a1,8(a3)
                struct Page* RPage = LPage + node_size;
ffffffffc0200f72:	9736                	add	a4,a4,a3
                LPage->property = node_size * 2;
ffffffffc0200f74:	01c6a823          	sw	t3,16(a3)
                SetPageProperty(LPage);
ffffffffc0200f78:	0025e593          	ori	a1,a1,2
ffffffffc0200f7c:	e68c                	sd	a1,8(a3)
                ClearPageProperty(RPage);
ffffffffc0200f7e:	6714                	ld	a3,8(a4)
ffffffffc0200f80:	9af5                	andi	a3,a3,-3
ffffffffc0200f82:	e714                	sd	a3,8(a4)
    while (index)
ffffffffc0200f84:	ffb1                	bnez	a5,ffffffffc0200ee0 <buddy_system_free_pages+0x9a>
ffffffffc0200f86:	b775                	j	ffffffffc0200f32 <buddy_system_free_pages+0xec>
    size |= size >> 1;
ffffffffc0200f88:	0018559b          	srliw	a1,a6,0x1
ffffffffc0200f8c:	00b865b3          	or	a1,a6,a1
    size |= size >> 2;
ffffffffc0200f90:	0025d81b          	srliw	a6,a1,0x2
ffffffffc0200f94:	0105e5b3          	or	a1,a1,a6
    size |= size >> 4;
ffffffffc0200f98:	0045d79b          	srliw	a5,a1,0x4
ffffffffc0200f9c:	8ddd                	or	a1,a1,a5
    size |= size >> 8;
ffffffffc0200f9e:	0085d79b          	srliw	a5,a1,0x8
ffffffffc0200fa2:	8ddd                	or	a1,a1,a5
    size |= size >> 16;
ffffffffc0200fa4:	0105d79b          	srliw	a5,a1,0x10
ffffffffc0200fa8:	8ddd                	or	a1,a1,a5
    return size + 1;
ffffffffc0200faa:	2585                	addiw	a1,a1,1
ffffffffc0200fac:	0005881b          	sext.w	a6,a1
        n = fixsize(n);
ffffffffc0200fb0:	1582                	slli	a1,a1,0x20
ffffffffc0200fb2:	9181                	srli	a1,a1,0x20
        node_size = n;
ffffffffc0200fb4:	b565                	j	ffffffffc0200e5c <buddy_system_free_pages+0x16>
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0200fb6:	00001697          	auipc	a3,0x1
ffffffffc0200fba:	cfa68693          	addi	a3,a3,-774 # ffffffffc0201cb0 <etext+0x636>
ffffffffc0200fbe:	00001617          	auipc	a2,0x1
ffffffffc0200fc2:	9ca60613          	addi	a2,a2,-1590 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200fc6:	0ba00593          	li	a1,186
ffffffffc0200fca:	00001517          	auipc	a0,0x1
ffffffffc0200fce:	9d650513          	addi	a0,a0,-1578 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200fd2:	9f0ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    assert(n > 0);
ffffffffc0200fd6:	00001697          	auipc	a3,0x1
ffffffffc0200fda:	9aa68693          	addi	a3,a3,-1622 # ffffffffc0201980 <etext+0x306>
ffffffffc0200fde:	00001617          	auipc	a2,0x1
ffffffffc0200fe2:	9aa60613          	addi	a2,a2,-1622 # ffffffffc0201988 <etext+0x30e>
ffffffffc0200fe6:	0b200593          	li	a1,178
ffffffffc0200fea:	00001517          	auipc	a0,0x1
ffffffffc0200fee:	9b650513          	addi	a0,a0,-1610 # ffffffffc02019a0 <etext+0x326>
ffffffffc0200ff2:	9d0ff0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc0200ff6 <alloc_pages>:
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
struct Page *alloc_pages(size_t n) {
    return pmm_manager->alloc_pages(n);
ffffffffc0200ff6:	00005797          	auipc	a5,0x5
ffffffffc0200ffa:	0627b783          	ld	a5,98(a5) # ffffffffc0206058 <pmm_manager>
ffffffffc0200ffe:	6f9c                	ld	a5,24(a5)
ffffffffc0201000:	8782                	jr	a5

ffffffffc0201002 <free_pages>:
}

// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    pmm_manager->free_pages(base, n);
ffffffffc0201002:	00005797          	auipc	a5,0x5
ffffffffc0201006:	0567b783          	ld	a5,86(a5) # ffffffffc0206058 <pmm_manager>
ffffffffc020100a:	739c                	ld	a5,32(a5)
ffffffffc020100c:	8782                	jr	a5

ffffffffc020100e <pmm_init>:
    pmm_manager = &buddy_system_pmm_manager;
ffffffffc020100e:	00001797          	auipc	a5,0x1
ffffffffc0201012:	cea78793          	addi	a5,a5,-790 # ffffffffc0201cf8 <buddy_system_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0201016:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc0201018:	7179                	addi	sp,sp,-48
ffffffffc020101a:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020101c:	00001517          	auipc	a0,0x1
ffffffffc0201020:	d1450513          	addi	a0,a0,-748 # ffffffffc0201d30 <buddy_system_pmm_manager+0x38>
    pmm_manager = &buddy_system_pmm_manager;
ffffffffc0201024:	00005417          	auipc	s0,0x5
ffffffffc0201028:	03440413          	addi	s0,s0,52 # ffffffffc0206058 <pmm_manager>
void pmm_init(void) {
ffffffffc020102c:	f406                	sd	ra,40(sp)
ffffffffc020102e:	ec26                	sd	s1,24(sp)
ffffffffc0201030:	e44e                	sd	s3,8(sp)
ffffffffc0201032:	e84a                	sd	s2,16(sp)
ffffffffc0201034:	e052                	sd	s4,0(sp)
    pmm_manager = &buddy_system_pmm_manager;
ffffffffc0201036:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0201038:	914ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    pmm_manager->init();
ffffffffc020103c:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc020103e:	00005497          	auipc	s1,0x5
ffffffffc0201042:	03248493          	addi	s1,s1,50 # ffffffffc0206070 <va_pa_offset>
    pmm_manager->init();
ffffffffc0201046:	679c                	ld	a5,8(a5)
ffffffffc0201048:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc020104a:	57f5                	li	a5,-3
ffffffffc020104c:	07fa                	slli	a5,a5,0x1e
ffffffffc020104e:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc0201050:	d6cff0ef          	jal	ra,ffffffffc02005bc <get_memory_base>
ffffffffc0201054:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc0201056:	d70ff0ef          	jal	ra,ffffffffc02005c6 <get_memory_size>
    if (mem_size == 0) {
ffffffffc020105a:	14050d63          	beqz	a0,ffffffffc02011b4 <pmm_init+0x1a6>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc020105e:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc0201060:	00001517          	auipc	a0,0x1
ffffffffc0201064:	d1850513          	addi	a0,a0,-744 # ffffffffc0201d78 <buddy_system_pmm_manager+0x80>
ffffffffc0201068:	8e4ff0ef          	jal	ra,ffffffffc020014c <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc020106c:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc0201070:	864e                	mv	a2,s3
ffffffffc0201072:	fffa0693          	addi	a3,s4,-1
ffffffffc0201076:	85ca                	mv	a1,s2
ffffffffc0201078:	00001517          	auipc	a0,0x1
ffffffffc020107c:	d1850513          	addi	a0,a0,-744 # ffffffffc0201d90 <buddy_system_pmm_manager+0x98>
ffffffffc0201080:	8ccff0ef          	jal	ra,ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0201084:	c80007b7          	lui	a5,0xc8000
ffffffffc0201088:	8652                	mv	a2,s4
ffffffffc020108a:	0d47e463          	bltu	a5,s4,ffffffffc0201152 <pmm_init+0x144>
ffffffffc020108e:	00006797          	auipc	a5,0x6
ffffffffc0201092:	fe978793          	addi	a5,a5,-23 # ffffffffc0207077 <end+0xfff>
ffffffffc0201096:	757d                	lui	a0,0xfffff
ffffffffc0201098:	8d7d                	and	a0,a0,a5
ffffffffc020109a:	8231                	srli	a2,a2,0xc
ffffffffc020109c:	00005797          	auipc	a5,0x5
ffffffffc02010a0:	fac7b623          	sd	a2,-84(a5) # ffffffffc0206048 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02010a4:	00005797          	auipc	a5,0x5
ffffffffc02010a8:	faa7b623          	sd	a0,-84(a5) # ffffffffc0206050 <pages>
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc02010ac:	000807b7          	lui	a5,0x80
ffffffffc02010b0:	002005b7          	lui	a1,0x200
ffffffffc02010b4:	02f60563          	beq	a2,a5,ffffffffc02010de <pmm_init+0xd0>
ffffffffc02010b8:	00261593          	slli	a1,a2,0x2
ffffffffc02010bc:	00c586b3          	add	a3,a1,a2
ffffffffc02010c0:	fec007b7          	lui	a5,0xfec00
ffffffffc02010c4:	97aa                	add	a5,a5,a0
ffffffffc02010c6:	068e                	slli	a3,a3,0x3
ffffffffc02010c8:	96be                	add	a3,a3,a5
ffffffffc02010ca:	87aa                	mv	a5,a0
        SetPageReserved(pages + i);
ffffffffc02010cc:	6798                	ld	a4,8(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc02010ce:	02878793          	addi	a5,a5,40 # fffffffffec00028 <end+0x3e9f9fb0>
        SetPageReserved(pages + i);
ffffffffc02010d2:	00176713          	ori	a4,a4,1
ffffffffc02010d6:	fee7b023          	sd	a4,-32(a5)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc02010da:	fef699e3          	bne	a3,a5,ffffffffc02010cc <pmm_init+0xbe>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02010de:	95b2                	add	a1,a1,a2
ffffffffc02010e0:	fec006b7          	lui	a3,0xfec00
ffffffffc02010e4:	96aa                	add	a3,a3,a0
ffffffffc02010e6:	058e                	slli	a1,a1,0x3
ffffffffc02010e8:	96ae                	add	a3,a3,a1
ffffffffc02010ea:	c02007b7          	lui	a5,0xc0200
ffffffffc02010ee:	0af6e763          	bltu	a3,a5,ffffffffc020119c <pmm_init+0x18e>
ffffffffc02010f2:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc02010f4:	77fd                	lui	a5,0xfffff
ffffffffc02010f6:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02010fa:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc02010fc:	04b6ee63          	bltu	a3,a1,ffffffffc0201158 <pmm_init+0x14a>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc0201100:	601c                	ld	a5,0(s0)
ffffffffc0201102:	7b9c                	ld	a5,48(a5)
ffffffffc0201104:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0201106:	00001517          	auipc	a0,0x1
ffffffffc020110a:	d1250513          	addi	a0,a0,-750 # ffffffffc0201e18 <buddy_system_pmm_manager+0x120>
ffffffffc020110e:	83eff0ef          	jal	ra,ffffffffc020014c <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc0201112:	00004597          	auipc	a1,0x4
ffffffffc0201116:	eee58593          	addi	a1,a1,-274 # ffffffffc0205000 <boot_page_table_sv39>
ffffffffc020111a:	00005797          	auipc	a5,0x5
ffffffffc020111e:	f4b7b723          	sd	a1,-178(a5) # ffffffffc0206068 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc0201122:	c02007b7          	lui	a5,0xc0200
ffffffffc0201126:	0af5e363          	bltu	a1,a5,ffffffffc02011cc <pmm_init+0x1be>
ffffffffc020112a:	6090                	ld	a2,0(s1)
}
ffffffffc020112c:	7402                	ld	s0,32(sp)
ffffffffc020112e:	70a2                	ld	ra,40(sp)
ffffffffc0201130:	64e2                	ld	s1,24(sp)
ffffffffc0201132:	6942                	ld	s2,16(sp)
ffffffffc0201134:	69a2                	ld	s3,8(sp)
ffffffffc0201136:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc0201138:	40c58633          	sub	a2,a1,a2
ffffffffc020113c:	00005797          	auipc	a5,0x5
ffffffffc0201140:	f2c7b223          	sd	a2,-220(a5) # ffffffffc0206060 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc0201144:	00001517          	auipc	a0,0x1
ffffffffc0201148:	cf450513          	addi	a0,a0,-780 # ffffffffc0201e38 <buddy_system_pmm_manager+0x140>
}
ffffffffc020114c:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc020114e:	ffffe06f          	j	ffffffffc020014c <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc0201152:	c8000637          	lui	a2,0xc8000
ffffffffc0201156:	bf25                	j	ffffffffc020108e <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0201158:	6705                	lui	a4,0x1
ffffffffc020115a:	177d                	addi	a4,a4,-1
ffffffffc020115c:	96ba                	add	a3,a3,a4
ffffffffc020115e:	8efd                	and	a3,a3,a5
    * pa2page - 接受一个物理地址并返回相应的 Page 结构。
    * 如果传入无效的物理地址则会触发 panic。
    *
*/
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
ffffffffc0201160:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201164:	02c7f063          	bgeu	a5,a2,ffffffffc0201184 <pmm_init+0x176>
    pmm_manager->init_memmap(base, n);
ffffffffc0201168:	6010                	ld	a2,0(s0)
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc020116a:	fff80737          	lui	a4,0xfff80
ffffffffc020116e:	973e                	add	a4,a4,a5
ffffffffc0201170:	00271793          	slli	a5,a4,0x2
ffffffffc0201174:	97ba                	add	a5,a5,a4
ffffffffc0201176:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0201178:	8d95                	sub	a1,a1,a3
ffffffffc020117a:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc020117c:	81b1                	srli	a1,a1,0xc
ffffffffc020117e:	953e                	add	a0,a0,a5
ffffffffc0201180:	9702                	jalr	a4
}
ffffffffc0201182:	bfbd                	j	ffffffffc0201100 <pmm_init+0xf2>
        panic("pa2page called with invalid pa");
ffffffffc0201184:	00001617          	auipc	a2,0x1
ffffffffc0201188:	c6460613          	addi	a2,a2,-924 # ffffffffc0201de8 <buddy_system_pmm_manager+0xf0>
ffffffffc020118c:	06600593          	li	a1,102
ffffffffc0201190:	00001517          	auipc	a0,0x1
ffffffffc0201194:	c7850513          	addi	a0,a0,-904 # ffffffffc0201e08 <buddy_system_pmm_manager+0x110>
ffffffffc0201198:	82aff0ef          	jal	ra,ffffffffc02001c2 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020119c:	00001617          	auipc	a2,0x1
ffffffffc02011a0:	c2460613          	addi	a2,a2,-988 # ffffffffc0201dc0 <buddy_system_pmm_manager+0xc8>
ffffffffc02011a4:	06100593          	li	a1,97
ffffffffc02011a8:	00001517          	auipc	a0,0x1
ffffffffc02011ac:	bc050513          	addi	a0,a0,-1088 # ffffffffc0201d68 <buddy_system_pmm_manager+0x70>
ffffffffc02011b0:	812ff0ef          	jal	ra,ffffffffc02001c2 <__panic>
        panic("DTB memory info not available");
ffffffffc02011b4:	00001617          	auipc	a2,0x1
ffffffffc02011b8:	b9460613          	addi	a2,a2,-1132 # ffffffffc0201d48 <buddy_system_pmm_manager+0x50>
ffffffffc02011bc:	04900593          	li	a1,73
ffffffffc02011c0:	00001517          	auipc	a0,0x1
ffffffffc02011c4:	ba850513          	addi	a0,a0,-1112 # ffffffffc0201d68 <buddy_system_pmm_manager+0x70>
ffffffffc02011c8:	ffbfe0ef          	jal	ra,ffffffffc02001c2 <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc02011cc:	86ae                	mv	a3,a1
ffffffffc02011ce:	00001617          	auipc	a2,0x1
ffffffffc02011d2:	bf260613          	addi	a2,a2,-1038 # ffffffffc0201dc0 <buddy_system_pmm_manager+0xc8>
ffffffffc02011d6:	07c00593          	li	a1,124
ffffffffc02011da:	00001517          	auipc	a0,0x1
ffffffffc02011de:	b8e50513          	addi	a0,a0,-1138 # ffffffffc0201d68 <buddy_system_pmm_manager+0x70>
ffffffffc02011e2:	fe1fe0ef          	jal	ra,ffffffffc02001c2 <__panic>

ffffffffc02011e6 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02011e6:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02011ea:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc02011ec:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02011f0:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc02011f2:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02011f6:	f022                	sd	s0,32(sp)
ffffffffc02011f8:	ec26                	sd	s1,24(sp)
ffffffffc02011fa:	e84a                	sd	s2,16(sp)
ffffffffc02011fc:	f406                	sd	ra,40(sp)
ffffffffc02011fe:	e44e                	sd	s3,8(sp)
ffffffffc0201200:	84aa                	mv	s1,a0
ffffffffc0201202:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0201204:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0201208:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc020120a:	03067e63          	bgeu	a2,a6,ffffffffc0201246 <printnum+0x60>
ffffffffc020120e:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0201210:	00805763          	blez	s0,ffffffffc020121e <printnum+0x38>
ffffffffc0201214:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0201216:	85ca                	mv	a1,s2
ffffffffc0201218:	854e                	mv	a0,s3
ffffffffc020121a:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc020121c:	fc65                	bnez	s0,ffffffffc0201214 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020121e:	1a02                	slli	s4,s4,0x20
ffffffffc0201220:	00001797          	auipc	a5,0x1
ffffffffc0201224:	c5878793          	addi	a5,a5,-936 # ffffffffc0201e78 <buddy_system_pmm_manager+0x180>
ffffffffc0201228:	020a5a13          	srli	s4,s4,0x20
ffffffffc020122c:	9a3e                	add	s4,s4,a5
}
ffffffffc020122e:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201230:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0201234:	70a2                	ld	ra,40(sp)
ffffffffc0201236:	69a2                	ld	s3,8(sp)
ffffffffc0201238:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020123a:	85ca                	mv	a1,s2
ffffffffc020123c:	87a6                	mv	a5,s1
}
ffffffffc020123e:	6942                	ld	s2,16(sp)
ffffffffc0201240:	64e2                	ld	s1,24(sp)
ffffffffc0201242:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201244:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0201246:	03065633          	divu	a2,a2,a6
ffffffffc020124a:	8722                	mv	a4,s0
ffffffffc020124c:	f9bff0ef          	jal	ra,ffffffffc02011e6 <printnum>
ffffffffc0201250:	b7f9                	j	ffffffffc020121e <printnum+0x38>

ffffffffc0201252 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0201252:	7119                	addi	sp,sp,-128
ffffffffc0201254:	f4a6                	sd	s1,104(sp)
ffffffffc0201256:	f0ca                	sd	s2,96(sp)
ffffffffc0201258:	ecce                	sd	s3,88(sp)
ffffffffc020125a:	e8d2                	sd	s4,80(sp)
ffffffffc020125c:	e4d6                	sd	s5,72(sp)
ffffffffc020125e:	e0da                	sd	s6,64(sp)
ffffffffc0201260:	fc5e                	sd	s7,56(sp)
ffffffffc0201262:	f06a                	sd	s10,32(sp)
ffffffffc0201264:	fc86                	sd	ra,120(sp)
ffffffffc0201266:	f8a2                	sd	s0,112(sp)
ffffffffc0201268:	f862                	sd	s8,48(sp)
ffffffffc020126a:	f466                	sd	s9,40(sp)
ffffffffc020126c:	ec6e                	sd	s11,24(sp)
ffffffffc020126e:	892a                	mv	s2,a0
ffffffffc0201270:	84ae                	mv	s1,a1
ffffffffc0201272:	8d32                	mv	s10,a2
ffffffffc0201274:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201276:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc020127a:	5b7d                	li	s6,-1
ffffffffc020127c:	00001a97          	auipc	s5,0x1
ffffffffc0201280:	c30a8a93          	addi	s5,s5,-976 # ffffffffc0201eac <buddy_system_pmm_manager+0x1b4>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201284:	00001b97          	auipc	s7,0x1
ffffffffc0201288:	e04b8b93          	addi	s7,s7,-508 # ffffffffc0202088 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020128c:	000d4503          	lbu	a0,0(s10)
ffffffffc0201290:	001d0413          	addi	s0,s10,1
ffffffffc0201294:	01350a63          	beq	a0,s3,ffffffffc02012a8 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0201298:	c121                	beqz	a0,ffffffffc02012d8 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc020129a:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020129c:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc020129e:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02012a0:	fff44503          	lbu	a0,-1(s0)
ffffffffc02012a4:	ff351ae3          	bne	a0,s3,ffffffffc0201298 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02012a8:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc02012ac:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc02012b0:	4c81                	li	s9,0
ffffffffc02012b2:	4881                	li	a7,0
        width = precision = -1;
ffffffffc02012b4:	5c7d                	li	s8,-1
ffffffffc02012b6:	5dfd                	li	s11,-1
ffffffffc02012b8:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc02012bc:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02012be:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02012c2:	0ff5f593          	zext.b	a1,a1
ffffffffc02012c6:	00140d13          	addi	s10,s0,1
ffffffffc02012ca:	04b56263          	bltu	a0,a1,ffffffffc020130e <vprintfmt+0xbc>
ffffffffc02012ce:	058a                	slli	a1,a1,0x2
ffffffffc02012d0:	95d6                	add	a1,a1,s5
ffffffffc02012d2:	4194                	lw	a3,0(a1)
ffffffffc02012d4:	96d6                	add	a3,a3,s5
ffffffffc02012d6:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc02012d8:	70e6                	ld	ra,120(sp)
ffffffffc02012da:	7446                	ld	s0,112(sp)
ffffffffc02012dc:	74a6                	ld	s1,104(sp)
ffffffffc02012de:	7906                	ld	s2,96(sp)
ffffffffc02012e0:	69e6                	ld	s3,88(sp)
ffffffffc02012e2:	6a46                	ld	s4,80(sp)
ffffffffc02012e4:	6aa6                	ld	s5,72(sp)
ffffffffc02012e6:	6b06                	ld	s6,64(sp)
ffffffffc02012e8:	7be2                	ld	s7,56(sp)
ffffffffc02012ea:	7c42                	ld	s8,48(sp)
ffffffffc02012ec:	7ca2                	ld	s9,40(sp)
ffffffffc02012ee:	7d02                	ld	s10,32(sp)
ffffffffc02012f0:	6de2                	ld	s11,24(sp)
ffffffffc02012f2:	6109                	addi	sp,sp,128
ffffffffc02012f4:	8082                	ret
            padc = '0';
ffffffffc02012f6:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc02012f8:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02012fc:	846a                	mv	s0,s10
ffffffffc02012fe:	00140d13          	addi	s10,s0,1
ffffffffc0201302:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201306:	0ff5f593          	zext.b	a1,a1
ffffffffc020130a:	fcb572e3          	bgeu	a0,a1,ffffffffc02012ce <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc020130e:	85a6                	mv	a1,s1
ffffffffc0201310:	02500513          	li	a0,37
ffffffffc0201314:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0201316:	fff44783          	lbu	a5,-1(s0)
ffffffffc020131a:	8d22                	mv	s10,s0
ffffffffc020131c:	f73788e3          	beq	a5,s3,ffffffffc020128c <vprintfmt+0x3a>
ffffffffc0201320:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0201324:	1d7d                	addi	s10,s10,-1
ffffffffc0201326:	ff379de3          	bne	a5,s3,ffffffffc0201320 <vprintfmt+0xce>
ffffffffc020132a:	b78d                	j	ffffffffc020128c <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc020132c:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0201330:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201334:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0201336:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc020133a:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc020133e:	02d86463          	bltu	a6,a3,ffffffffc0201366 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0201342:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0201346:	002c169b          	slliw	a3,s8,0x2
ffffffffc020134a:	0186873b          	addw	a4,a3,s8
ffffffffc020134e:	0017171b          	slliw	a4,a4,0x1
ffffffffc0201352:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0201354:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0201358:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc020135a:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc020135e:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201362:	fed870e3          	bgeu	a6,a3,ffffffffc0201342 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0201366:	f40ddce3          	bgez	s11,ffffffffc02012be <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc020136a:	8de2                	mv	s11,s8
ffffffffc020136c:	5c7d                	li	s8,-1
ffffffffc020136e:	bf81                	j	ffffffffc02012be <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0201370:	fffdc693          	not	a3,s11
ffffffffc0201374:	96fd                	srai	a3,a3,0x3f
ffffffffc0201376:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020137a:	00144603          	lbu	a2,1(s0)
ffffffffc020137e:	2d81                	sext.w	s11,s11
ffffffffc0201380:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201382:	bf35                	j	ffffffffc02012be <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0201384:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201388:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc020138c:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020138e:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0201390:	bfd9                	j	ffffffffc0201366 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0201392:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201394:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201398:	01174463          	blt	a4,a7,ffffffffc02013a0 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc020139c:	1a088e63          	beqz	a7,ffffffffc0201558 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc02013a0:	000a3603          	ld	a2,0(s4)
ffffffffc02013a4:	46c1                	li	a3,16
ffffffffc02013a6:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc02013a8:	2781                	sext.w	a5,a5
ffffffffc02013aa:	876e                	mv	a4,s11
ffffffffc02013ac:	85a6                	mv	a1,s1
ffffffffc02013ae:	854a                	mv	a0,s2
ffffffffc02013b0:	e37ff0ef          	jal	ra,ffffffffc02011e6 <printnum>
            break;
ffffffffc02013b4:	bde1                	j	ffffffffc020128c <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc02013b6:	000a2503          	lw	a0,0(s4)
ffffffffc02013ba:	85a6                	mv	a1,s1
ffffffffc02013bc:	0a21                	addi	s4,s4,8
ffffffffc02013be:	9902                	jalr	s2
            break;
ffffffffc02013c0:	b5f1                	j	ffffffffc020128c <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc02013c2:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02013c4:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02013c8:	01174463          	blt	a4,a7,ffffffffc02013d0 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc02013cc:	18088163          	beqz	a7,ffffffffc020154e <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc02013d0:	000a3603          	ld	a2,0(s4)
ffffffffc02013d4:	46a9                	li	a3,10
ffffffffc02013d6:	8a2e                	mv	s4,a1
ffffffffc02013d8:	bfc1                	j	ffffffffc02013a8 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02013da:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc02013de:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02013e0:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02013e2:	bdf1                	j	ffffffffc02012be <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc02013e4:	85a6                	mv	a1,s1
ffffffffc02013e6:	02500513          	li	a0,37
ffffffffc02013ea:	9902                	jalr	s2
            break;
ffffffffc02013ec:	b545                	j	ffffffffc020128c <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02013ee:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc02013f2:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02013f4:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02013f6:	b5e1                	j	ffffffffc02012be <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc02013f8:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02013fa:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02013fe:	01174463          	blt	a4,a7,ffffffffc0201406 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0201402:	14088163          	beqz	a7,ffffffffc0201544 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0201406:	000a3603          	ld	a2,0(s4)
ffffffffc020140a:	46a1                	li	a3,8
ffffffffc020140c:	8a2e                	mv	s4,a1
ffffffffc020140e:	bf69                	j	ffffffffc02013a8 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0201410:	03000513          	li	a0,48
ffffffffc0201414:	85a6                	mv	a1,s1
ffffffffc0201416:	e03e                	sd	a5,0(sp)
ffffffffc0201418:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc020141a:	85a6                	mv	a1,s1
ffffffffc020141c:	07800513          	li	a0,120
ffffffffc0201420:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201422:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0201424:	6782                	ld	a5,0(sp)
ffffffffc0201426:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201428:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc020142c:	bfb5                	j	ffffffffc02013a8 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc020142e:	000a3403          	ld	s0,0(s4)
ffffffffc0201432:	008a0713          	addi	a4,s4,8
ffffffffc0201436:	e03a                	sd	a4,0(sp)
ffffffffc0201438:	14040263          	beqz	s0,ffffffffc020157c <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc020143c:	0fb05763          	blez	s11,ffffffffc020152a <vprintfmt+0x2d8>
ffffffffc0201440:	02d00693          	li	a3,45
ffffffffc0201444:	0cd79163          	bne	a5,a3,ffffffffc0201506 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201448:	00044783          	lbu	a5,0(s0)
ffffffffc020144c:	0007851b          	sext.w	a0,a5
ffffffffc0201450:	cf85                	beqz	a5,ffffffffc0201488 <vprintfmt+0x236>
ffffffffc0201452:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201456:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020145a:	000c4563          	bltz	s8,ffffffffc0201464 <vprintfmt+0x212>
ffffffffc020145e:	3c7d                	addiw	s8,s8,-1
ffffffffc0201460:	036c0263          	beq	s8,s6,ffffffffc0201484 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0201464:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201466:	0e0c8e63          	beqz	s9,ffffffffc0201562 <vprintfmt+0x310>
ffffffffc020146a:	3781                	addiw	a5,a5,-32
ffffffffc020146c:	0ef47b63          	bgeu	s0,a5,ffffffffc0201562 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0201470:	03f00513          	li	a0,63
ffffffffc0201474:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201476:	000a4783          	lbu	a5,0(s4)
ffffffffc020147a:	3dfd                	addiw	s11,s11,-1
ffffffffc020147c:	0a05                	addi	s4,s4,1
ffffffffc020147e:	0007851b          	sext.w	a0,a5
ffffffffc0201482:	ffe1                	bnez	a5,ffffffffc020145a <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0201484:	01b05963          	blez	s11,ffffffffc0201496 <vprintfmt+0x244>
ffffffffc0201488:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc020148a:	85a6                	mv	a1,s1
ffffffffc020148c:	02000513          	li	a0,32
ffffffffc0201490:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0201492:	fe0d9be3          	bnez	s11,ffffffffc0201488 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201496:	6a02                	ld	s4,0(sp)
ffffffffc0201498:	bbd5                	j	ffffffffc020128c <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc020149a:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020149c:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc02014a0:	01174463          	blt	a4,a7,ffffffffc02014a8 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc02014a4:	08088d63          	beqz	a7,ffffffffc020153e <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc02014a8:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc02014ac:	0a044d63          	bltz	s0,ffffffffc0201566 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc02014b0:	8622                	mv	a2,s0
ffffffffc02014b2:	8a66                	mv	s4,s9
ffffffffc02014b4:	46a9                	li	a3,10
ffffffffc02014b6:	bdcd                	j	ffffffffc02013a8 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc02014b8:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02014bc:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc02014be:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc02014c0:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc02014c4:	8fb5                	xor	a5,a5,a3
ffffffffc02014c6:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02014ca:	02d74163          	blt	a4,a3,ffffffffc02014ec <vprintfmt+0x29a>
ffffffffc02014ce:	00369793          	slli	a5,a3,0x3
ffffffffc02014d2:	97de                	add	a5,a5,s7
ffffffffc02014d4:	639c                	ld	a5,0(a5)
ffffffffc02014d6:	cb99                	beqz	a5,ffffffffc02014ec <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc02014d8:	86be                	mv	a3,a5
ffffffffc02014da:	00001617          	auipc	a2,0x1
ffffffffc02014de:	9ce60613          	addi	a2,a2,-1586 # ffffffffc0201ea8 <buddy_system_pmm_manager+0x1b0>
ffffffffc02014e2:	85a6                	mv	a1,s1
ffffffffc02014e4:	854a                	mv	a0,s2
ffffffffc02014e6:	0ce000ef          	jal	ra,ffffffffc02015b4 <printfmt>
ffffffffc02014ea:	b34d                	j	ffffffffc020128c <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc02014ec:	00001617          	auipc	a2,0x1
ffffffffc02014f0:	9ac60613          	addi	a2,a2,-1620 # ffffffffc0201e98 <buddy_system_pmm_manager+0x1a0>
ffffffffc02014f4:	85a6                	mv	a1,s1
ffffffffc02014f6:	854a                	mv	a0,s2
ffffffffc02014f8:	0bc000ef          	jal	ra,ffffffffc02015b4 <printfmt>
ffffffffc02014fc:	bb41                	j	ffffffffc020128c <vprintfmt+0x3a>
                p = "(null)";
ffffffffc02014fe:	00001417          	auipc	s0,0x1
ffffffffc0201502:	99240413          	addi	s0,s0,-1646 # ffffffffc0201e90 <buddy_system_pmm_manager+0x198>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201506:	85e2                	mv	a1,s8
ffffffffc0201508:	8522                	mv	a0,s0
ffffffffc020150a:	e43e                	sd	a5,8(sp)
ffffffffc020150c:	0fc000ef          	jal	ra,ffffffffc0201608 <strnlen>
ffffffffc0201510:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0201514:	01b05b63          	blez	s11,ffffffffc020152a <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0201518:	67a2                	ld	a5,8(sp)
ffffffffc020151a:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc020151e:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0201520:	85a6                	mv	a1,s1
ffffffffc0201522:	8552                	mv	a0,s4
ffffffffc0201524:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201526:	fe0d9ce3          	bnez	s11,ffffffffc020151e <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020152a:	00044783          	lbu	a5,0(s0)
ffffffffc020152e:	00140a13          	addi	s4,s0,1
ffffffffc0201532:	0007851b          	sext.w	a0,a5
ffffffffc0201536:	d3a5                	beqz	a5,ffffffffc0201496 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201538:	05e00413          	li	s0,94
ffffffffc020153c:	bf39                	j	ffffffffc020145a <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc020153e:	000a2403          	lw	s0,0(s4)
ffffffffc0201542:	b7ad                	j	ffffffffc02014ac <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0201544:	000a6603          	lwu	a2,0(s4)
ffffffffc0201548:	46a1                	li	a3,8
ffffffffc020154a:	8a2e                	mv	s4,a1
ffffffffc020154c:	bdb1                	j	ffffffffc02013a8 <vprintfmt+0x156>
ffffffffc020154e:	000a6603          	lwu	a2,0(s4)
ffffffffc0201552:	46a9                	li	a3,10
ffffffffc0201554:	8a2e                	mv	s4,a1
ffffffffc0201556:	bd89                	j	ffffffffc02013a8 <vprintfmt+0x156>
ffffffffc0201558:	000a6603          	lwu	a2,0(s4)
ffffffffc020155c:	46c1                	li	a3,16
ffffffffc020155e:	8a2e                	mv	s4,a1
ffffffffc0201560:	b5a1                	j	ffffffffc02013a8 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0201562:	9902                	jalr	s2
ffffffffc0201564:	bf09                	j	ffffffffc0201476 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0201566:	85a6                	mv	a1,s1
ffffffffc0201568:	02d00513          	li	a0,45
ffffffffc020156c:	e03e                	sd	a5,0(sp)
ffffffffc020156e:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0201570:	6782                	ld	a5,0(sp)
ffffffffc0201572:	8a66                	mv	s4,s9
ffffffffc0201574:	40800633          	neg	a2,s0
ffffffffc0201578:	46a9                	li	a3,10
ffffffffc020157a:	b53d                	j	ffffffffc02013a8 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc020157c:	03b05163          	blez	s11,ffffffffc020159e <vprintfmt+0x34c>
ffffffffc0201580:	02d00693          	li	a3,45
ffffffffc0201584:	f6d79de3          	bne	a5,a3,ffffffffc02014fe <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0201588:	00001417          	auipc	s0,0x1
ffffffffc020158c:	90840413          	addi	s0,s0,-1784 # ffffffffc0201e90 <buddy_system_pmm_manager+0x198>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201590:	02800793          	li	a5,40
ffffffffc0201594:	02800513          	li	a0,40
ffffffffc0201598:	00140a13          	addi	s4,s0,1
ffffffffc020159c:	bd6d                	j	ffffffffc0201456 <vprintfmt+0x204>
ffffffffc020159e:	00001a17          	auipc	s4,0x1
ffffffffc02015a2:	8f3a0a13          	addi	s4,s4,-1805 # ffffffffc0201e91 <buddy_system_pmm_manager+0x199>
ffffffffc02015a6:	02800513          	li	a0,40
ffffffffc02015aa:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02015ae:	05e00413          	li	s0,94
ffffffffc02015b2:	b565                	j	ffffffffc020145a <vprintfmt+0x208>

ffffffffc02015b4 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02015b4:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc02015b6:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02015ba:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02015bc:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02015be:	ec06                	sd	ra,24(sp)
ffffffffc02015c0:	f83a                	sd	a4,48(sp)
ffffffffc02015c2:	fc3e                	sd	a5,56(sp)
ffffffffc02015c4:	e0c2                	sd	a6,64(sp)
ffffffffc02015c6:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc02015c8:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02015ca:	c89ff0ef          	jal	ra,ffffffffc0201252 <vprintfmt>
}
ffffffffc02015ce:	60e2                	ld	ra,24(sp)
ffffffffc02015d0:	6161                	addi	sp,sp,80
ffffffffc02015d2:	8082                	ret

ffffffffc02015d4 <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc02015d4:	4781                	li	a5,0
ffffffffc02015d6:	00005717          	auipc	a4,0x5
ffffffffc02015da:	a3a73703          	ld	a4,-1478(a4) # ffffffffc0206010 <SBI_CONSOLE_PUTCHAR>
ffffffffc02015de:	88ba                	mv	a7,a4
ffffffffc02015e0:	852a                	mv	a0,a0
ffffffffc02015e2:	85be                	mv	a1,a5
ffffffffc02015e4:	863e                	mv	a2,a5
ffffffffc02015e6:	00000073          	ecall
ffffffffc02015ea:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc02015ec:	8082                	ret

ffffffffc02015ee <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc02015ee:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc02015f2:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc02015f4:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc02015f6:	cb81                	beqz	a5,ffffffffc0201606 <strlen+0x18>
        cnt ++;
ffffffffc02015f8:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc02015fa:	00a707b3          	add	a5,a4,a0
ffffffffc02015fe:	0007c783          	lbu	a5,0(a5)
ffffffffc0201602:	fbfd                	bnez	a5,ffffffffc02015f8 <strlen+0xa>
ffffffffc0201604:	8082                	ret
    }
    return cnt;
}
ffffffffc0201606:	8082                	ret

ffffffffc0201608 <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc0201608:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc020160a:	e589                	bnez	a1,ffffffffc0201614 <strnlen+0xc>
ffffffffc020160c:	a811                	j	ffffffffc0201620 <strnlen+0x18>
        cnt ++;
ffffffffc020160e:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201610:	00f58863          	beq	a1,a5,ffffffffc0201620 <strnlen+0x18>
ffffffffc0201614:	00f50733          	add	a4,a0,a5
ffffffffc0201618:	00074703          	lbu	a4,0(a4)
ffffffffc020161c:	fb6d                	bnez	a4,ffffffffc020160e <strnlen+0x6>
ffffffffc020161e:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0201620:	852e                	mv	a0,a1
ffffffffc0201622:	8082                	ret

ffffffffc0201624 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201624:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201628:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020162c:	cb89                	beqz	a5,ffffffffc020163e <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc020162e:	0505                	addi	a0,a0,1
ffffffffc0201630:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201632:	fee789e3          	beq	a5,a4,ffffffffc0201624 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201636:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc020163a:	9d19                	subw	a0,a0,a4
ffffffffc020163c:	8082                	ret
ffffffffc020163e:	4501                	li	a0,0
ffffffffc0201640:	bfed                	j	ffffffffc020163a <strcmp+0x16>

ffffffffc0201642 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201642:	c20d                	beqz	a2,ffffffffc0201664 <strncmp+0x22>
ffffffffc0201644:	962e                	add	a2,a2,a1
ffffffffc0201646:	a031                	j	ffffffffc0201652 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc0201648:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc020164a:	00e79a63          	bne	a5,a4,ffffffffc020165e <strncmp+0x1c>
ffffffffc020164e:	00b60b63          	beq	a2,a1,ffffffffc0201664 <strncmp+0x22>
ffffffffc0201652:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc0201656:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201658:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020165c:	f7f5                	bnez	a5,ffffffffc0201648 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020165e:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0201662:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201664:	4501                	li	a0,0
ffffffffc0201666:	8082                	ret

ffffffffc0201668 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0201668:	ca01                	beqz	a2,ffffffffc0201678 <memset+0x10>
ffffffffc020166a:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc020166c:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc020166e:	0785                	addi	a5,a5,1
ffffffffc0201670:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0201674:	fec79de3          	bne	a5,a2,ffffffffc020166e <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0201678:	8082                	ret
