
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	00014297          	auipc	t0,0x14
ffffffffc0200004:	00028293          	mv	t0,t0
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0214000 <boot_hartid>
ffffffffc020000c:	00014297          	auipc	t0,0x14
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0214008 <boot_dtb>
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
ffffffffc0200018:	c02132b7          	lui	t0,0xc0213
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
ffffffffc0200034:	18029073          	csrw	satp,t0
ffffffffc0200038:	12000073          	sfence.vma
ffffffffc020003c:	c0213137          	lui	sp,0xc0213
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
ffffffffc020004a:	00091517          	auipc	a0,0x91
ffffffffc020004e:	01650513          	addi	a0,a0,22 # ffffffffc0291060 <buf>
ffffffffc0200052:	00097617          	auipc	a2,0x97
ffffffffc0200056:	8be60613          	addi	a2,a2,-1858 # ffffffffc0296910 <end>
ffffffffc020005a:	1141                	addi	sp,sp,-16
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
ffffffffc0200060:	e406                	sd	ra,8(sp)
ffffffffc0200062:	3540b0ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0200066:	52c000ef          	jal	ra,ffffffffc0200592 <cons_init>
ffffffffc020006a:	0000b597          	auipc	a1,0xb
ffffffffc020006e:	3b658593          	addi	a1,a1,950 # ffffffffc020b420 <etext>
ffffffffc0200072:	0000b517          	auipc	a0,0xb
ffffffffc0200076:	3ce50513          	addi	a0,a0,974 # ffffffffc020b440 <etext+0x20>
ffffffffc020007a:	12c000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020007e:	1ae000ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc0200082:	62a000ef          	jal	ra,ffffffffc02006ac <dtb_init>
ffffffffc0200086:	24b020ef          	jal	ra,ffffffffc0202ad0 <pmm_init>
ffffffffc020008a:	3ef000ef          	jal	ra,ffffffffc0200c78 <pic_init>
ffffffffc020008e:	515000ef          	jal	ra,ffffffffc0200da2 <idt_init>
ffffffffc0200092:	6d7030ef          	jal	ra,ffffffffc0203f68 <vmm_init>
ffffffffc0200096:	0c0070ef          	jal	ra,ffffffffc0207156 <sched_init>
ffffffffc020009a:	4c7060ef          	jal	ra,ffffffffc0206d60 <proc_init>
ffffffffc020009e:	1bf000ef          	jal	ra,ffffffffc0200a5c <ide_init>
ffffffffc02000a2:	108050ef          	jal	ra,ffffffffc02051aa <fs_init>
ffffffffc02000a6:	4a4000ef          	jal	ra,ffffffffc020054a <clock_init>
ffffffffc02000aa:	3c3000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02000ae:	67f060ef          	jal	ra,ffffffffc0206f2c <cpu_idle>

ffffffffc02000b2 <readline>:
ffffffffc02000b2:	715d                	addi	sp,sp,-80
ffffffffc02000b4:	e486                	sd	ra,72(sp)
ffffffffc02000b6:	e0a6                	sd	s1,64(sp)
ffffffffc02000b8:	fc4a                	sd	s2,56(sp)
ffffffffc02000ba:	f84e                	sd	s3,48(sp)
ffffffffc02000bc:	f452                	sd	s4,40(sp)
ffffffffc02000be:	f056                	sd	s5,32(sp)
ffffffffc02000c0:	ec5a                	sd	s6,24(sp)
ffffffffc02000c2:	e85e                	sd	s7,16(sp)
ffffffffc02000c4:	c901                	beqz	a0,ffffffffc02000d4 <readline+0x22>
ffffffffc02000c6:	85aa                	mv	a1,a0
ffffffffc02000c8:	0000b517          	auipc	a0,0xb
ffffffffc02000cc:	38050513          	addi	a0,a0,896 # ffffffffc020b448 <etext+0x28>
ffffffffc02000d0:	0d6000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02000d4:	4481                	li	s1,0
ffffffffc02000d6:	497d                	li	s2,31
ffffffffc02000d8:	49a1                	li	s3,8
ffffffffc02000da:	4aa9                	li	s5,10
ffffffffc02000dc:	4b35                	li	s6,13
ffffffffc02000de:	00091b97          	auipc	s7,0x91
ffffffffc02000e2:	f82b8b93          	addi	s7,s7,-126 # ffffffffc0291060 <buf>
ffffffffc02000e6:	3fe00a13          	li	s4,1022
ffffffffc02000ea:	0fa000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000ee:	00054a63          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc02000f2:	00a95a63          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc02000f6:	029a5263          	bge	s4,s1,ffffffffc020011a <readline+0x68>
ffffffffc02000fa:	0ea000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000fe:	fe055ae3          	bgez	a0,ffffffffc02000f2 <readline+0x40>
ffffffffc0200102:	4501                	li	a0,0
ffffffffc0200104:	a091                	j	ffffffffc0200148 <readline+0x96>
ffffffffc0200106:	03351463          	bne	a0,s3,ffffffffc020012e <readline+0x7c>
ffffffffc020010a:	e8a9                	bnez	s1,ffffffffc020015c <readline+0xaa>
ffffffffc020010c:	0d8000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc0200110:	fe0549e3          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc0200114:	fea959e3          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc0200118:	4481                	li	s1,0
ffffffffc020011a:	e42a                	sd	a0,8(sp)
ffffffffc020011c:	0c6000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200120:	6522                	ld	a0,8(sp)
ffffffffc0200122:	009b87b3          	add	a5,s7,s1
ffffffffc0200126:	2485                	addiw	s1,s1,1
ffffffffc0200128:	00a78023          	sb	a0,0(a5)
ffffffffc020012c:	bf7d                	j	ffffffffc02000ea <readline+0x38>
ffffffffc020012e:	01550463          	beq	a0,s5,ffffffffc0200136 <readline+0x84>
ffffffffc0200132:	fb651ce3          	bne	a0,s6,ffffffffc02000ea <readline+0x38>
ffffffffc0200136:	0ac000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc020013a:	00091517          	auipc	a0,0x91
ffffffffc020013e:	f2650513          	addi	a0,a0,-218 # ffffffffc0291060 <buf>
ffffffffc0200142:	94aa                	add	s1,s1,a0
ffffffffc0200144:	00048023          	sb	zero,0(s1)
ffffffffc0200148:	60a6                	ld	ra,72(sp)
ffffffffc020014a:	6486                	ld	s1,64(sp)
ffffffffc020014c:	7962                	ld	s2,56(sp)
ffffffffc020014e:	79c2                	ld	s3,48(sp)
ffffffffc0200150:	7a22                	ld	s4,40(sp)
ffffffffc0200152:	7a82                	ld	s5,32(sp)
ffffffffc0200154:	6b62                	ld	s6,24(sp)
ffffffffc0200156:	6bc2                	ld	s7,16(sp)
ffffffffc0200158:	6161                	addi	sp,sp,80
ffffffffc020015a:	8082                	ret
ffffffffc020015c:	4521                	li	a0,8
ffffffffc020015e:	084000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200162:	34fd                	addiw	s1,s1,-1
ffffffffc0200164:	b759                	j	ffffffffc02000ea <readline+0x38>

ffffffffc0200166 <cputch>:
ffffffffc0200166:	1141                	addi	sp,sp,-16
ffffffffc0200168:	e022                	sd	s0,0(sp)
ffffffffc020016a:	e406                	sd	ra,8(sp)
ffffffffc020016c:	842e                	mv	s0,a1
ffffffffc020016e:	432000ef          	jal	ra,ffffffffc02005a0 <cons_putc>
ffffffffc0200172:	401c                	lw	a5,0(s0)
ffffffffc0200174:	60a2                	ld	ra,8(sp)
ffffffffc0200176:	2785                	addiw	a5,a5,1
ffffffffc0200178:	c01c                	sw	a5,0(s0)
ffffffffc020017a:	6402                	ld	s0,0(sp)
ffffffffc020017c:	0141                	addi	sp,sp,16
ffffffffc020017e:	8082                	ret

ffffffffc0200180 <vcprintf>:
ffffffffc0200180:	1101                	addi	sp,sp,-32
ffffffffc0200182:	872e                	mv	a4,a1
ffffffffc0200184:	75dd                	lui	a1,0xffff7
ffffffffc0200186:	86aa                	mv	a3,a0
ffffffffc0200188:	0070                	addi	a2,sp,12
ffffffffc020018a:	00000517          	auipc	a0,0x0
ffffffffc020018e:	fdc50513          	addi	a0,a0,-36 # ffffffffc0200166 <cputch>
ffffffffc0200192:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0200196:	ec06                	sd	ra,24(sp)
ffffffffc0200198:	c602                	sw	zero,12(sp)
ffffffffc020019a:	58f0a0ef          	jal	ra,ffffffffc020af28 <vprintfmt>
ffffffffc020019e:	60e2                	ld	ra,24(sp)
ffffffffc02001a0:	4532                	lw	a0,12(sp)
ffffffffc02001a2:	6105                	addi	sp,sp,32
ffffffffc02001a4:	8082                	ret

ffffffffc02001a6 <cprintf>:
ffffffffc02001a6:	711d                	addi	sp,sp,-96
ffffffffc02001a8:	02810313          	addi	t1,sp,40 # ffffffffc0213028 <boot_page_table_sv39+0x28>
ffffffffc02001ac:	8e2a                	mv	t3,a0
ffffffffc02001ae:	f42e                	sd	a1,40(sp)
ffffffffc02001b0:	75dd                	lui	a1,0xffff7
ffffffffc02001b2:	f832                	sd	a2,48(sp)
ffffffffc02001b4:	fc36                	sd	a3,56(sp)
ffffffffc02001b6:	e0ba                	sd	a4,64(sp)
ffffffffc02001b8:	00000517          	auipc	a0,0x0
ffffffffc02001bc:	fae50513          	addi	a0,a0,-82 # ffffffffc0200166 <cputch>
ffffffffc02001c0:	0050                	addi	a2,sp,4
ffffffffc02001c2:	871a                	mv	a4,t1
ffffffffc02001c4:	86f2                	mv	a3,t3
ffffffffc02001c6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc02001ca:	ec06                	sd	ra,24(sp)
ffffffffc02001cc:	e4be                	sd	a5,72(sp)
ffffffffc02001ce:	e8c2                	sd	a6,80(sp)
ffffffffc02001d0:	ecc6                	sd	a7,88(sp)
ffffffffc02001d2:	e41a                	sd	t1,8(sp)
ffffffffc02001d4:	c202                	sw	zero,4(sp)
ffffffffc02001d6:	5530a0ef          	jal	ra,ffffffffc020af28 <vprintfmt>
ffffffffc02001da:	60e2                	ld	ra,24(sp)
ffffffffc02001dc:	4512                	lw	a0,4(sp)
ffffffffc02001de:	6125                	addi	sp,sp,96
ffffffffc02001e0:	8082                	ret

ffffffffc02001e2 <cputchar>:
ffffffffc02001e2:	ae7d                	j	ffffffffc02005a0 <cons_putc>

ffffffffc02001e4 <getchar>:
ffffffffc02001e4:	1141                	addi	sp,sp,-16
ffffffffc02001e6:	e406                	sd	ra,8(sp)
ffffffffc02001e8:	40c000ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc02001ec:	dd75                	beqz	a0,ffffffffc02001e8 <getchar+0x4>
ffffffffc02001ee:	60a2                	ld	ra,8(sp)
ffffffffc02001f0:	0141                	addi	sp,sp,16
ffffffffc02001f2:	8082                	ret

ffffffffc02001f4 <strdup>:
ffffffffc02001f4:	1101                	addi	sp,sp,-32
ffffffffc02001f6:	ec06                	sd	ra,24(sp)
ffffffffc02001f8:	e822                	sd	s0,16(sp)
ffffffffc02001fa:	e426                	sd	s1,8(sp)
ffffffffc02001fc:	e04a                	sd	s2,0(sp)
ffffffffc02001fe:	892a                	mv	s2,a0
ffffffffc0200200:	1140b0ef          	jal	ra,ffffffffc020b314 <strlen>
ffffffffc0200204:	842a                	mv	s0,a0
ffffffffc0200206:	0505                	addi	a0,a0,1
ffffffffc0200208:	587010ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020020c:	84aa                	mv	s1,a0
ffffffffc020020e:	c901                	beqz	a0,ffffffffc020021e <strdup+0x2a>
ffffffffc0200210:	8622                	mv	a2,s0
ffffffffc0200212:	85ca                	mv	a1,s2
ffffffffc0200214:	9426                	add	s0,s0,s1
ffffffffc0200216:	1f20b0ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc020021a:	00040023          	sb	zero,0(s0)
ffffffffc020021e:	60e2                	ld	ra,24(sp)
ffffffffc0200220:	6442                	ld	s0,16(sp)
ffffffffc0200222:	6902                	ld	s2,0(sp)
ffffffffc0200224:	8526                	mv	a0,s1
ffffffffc0200226:	64a2                	ld	s1,8(sp)
ffffffffc0200228:	6105                	addi	sp,sp,32
ffffffffc020022a:	8082                	ret

ffffffffc020022c <print_kerninfo>:
ffffffffc020022c:	1141                	addi	sp,sp,-16
ffffffffc020022e:	0000b517          	auipc	a0,0xb
ffffffffc0200232:	22250513          	addi	a0,a0,546 # ffffffffc020b450 <etext+0x30>
ffffffffc0200236:	e406                	sd	ra,8(sp)
ffffffffc0200238:	f6fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020023c:	00000597          	auipc	a1,0x0
ffffffffc0200240:	e0e58593          	addi	a1,a1,-498 # ffffffffc020004a <kern_init>
ffffffffc0200244:	0000b517          	auipc	a0,0xb
ffffffffc0200248:	22c50513          	addi	a0,a0,556 # ffffffffc020b470 <etext+0x50>
ffffffffc020024c:	f5bff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200250:	0000b597          	auipc	a1,0xb
ffffffffc0200254:	1d058593          	addi	a1,a1,464 # ffffffffc020b420 <etext>
ffffffffc0200258:	0000b517          	auipc	a0,0xb
ffffffffc020025c:	23850513          	addi	a0,a0,568 # ffffffffc020b490 <etext+0x70>
ffffffffc0200260:	f47ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200264:	00091597          	auipc	a1,0x91
ffffffffc0200268:	dfc58593          	addi	a1,a1,-516 # ffffffffc0291060 <buf>
ffffffffc020026c:	0000b517          	auipc	a0,0xb
ffffffffc0200270:	24450513          	addi	a0,a0,580 # ffffffffc020b4b0 <etext+0x90>
ffffffffc0200274:	f33ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200278:	00096597          	auipc	a1,0x96
ffffffffc020027c:	69858593          	addi	a1,a1,1688 # ffffffffc0296910 <end>
ffffffffc0200280:	0000b517          	auipc	a0,0xb
ffffffffc0200284:	25050513          	addi	a0,a0,592 # ffffffffc020b4d0 <etext+0xb0>
ffffffffc0200288:	f1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020028c:	00097597          	auipc	a1,0x97
ffffffffc0200290:	a8358593          	addi	a1,a1,-1405 # ffffffffc0296d0f <end+0x3ff>
ffffffffc0200294:	00000797          	auipc	a5,0x0
ffffffffc0200298:	db678793          	addi	a5,a5,-586 # ffffffffc020004a <kern_init>
ffffffffc020029c:	40f587b3          	sub	a5,a1,a5
ffffffffc02002a0:	43f7d593          	srai	a1,a5,0x3f
ffffffffc02002a4:	60a2                	ld	ra,8(sp)
ffffffffc02002a6:	3ff5f593          	andi	a1,a1,1023
ffffffffc02002aa:	95be                	add	a1,a1,a5
ffffffffc02002ac:	85a9                	srai	a1,a1,0xa
ffffffffc02002ae:	0000b517          	auipc	a0,0xb
ffffffffc02002b2:	24250513          	addi	a0,a0,578 # ffffffffc020b4f0 <etext+0xd0>
ffffffffc02002b6:	0141                	addi	sp,sp,16
ffffffffc02002b8:	b5fd                	j	ffffffffc02001a6 <cprintf>

ffffffffc02002ba <print_stackframe>:
ffffffffc02002ba:	1141                	addi	sp,sp,-16
ffffffffc02002bc:	0000b617          	auipc	a2,0xb
ffffffffc02002c0:	26460613          	addi	a2,a2,612 # ffffffffc020b520 <etext+0x100>
ffffffffc02002c4:	04e00593          	li	a1,78
ffffffffc02002c8:	0000b517          	auipc	a0,0xb
ffffffffc02002cc:	27050513          	addi	a0,a0,624 # ffffffffc020b538 <etext+0x118>
ffffffffc02002d0:	e406                	sd	ra,8(sp)
ffffffffc02002d2:	1cc000ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02002d6 <mon_help>:
ffffffffc02002d6:	1141                	addi	sp,sp,-16
ffffffffc02002d8:	0000b617          	auipc	a2,0xb
ffffffffc02002dc:	27860613          	addi	a2,a2,632 # ffffffffc020b550 <etext+0x130>
ffffffffc02002e0:	0000b597          	auipc	a1,0xb
ffffffffc02002e4:	29058593          	addi	a1,a1,656 # ffffffffc020b570 <etext+0x150>
ffffffffc02002e8:	0000b517          	auipc	a0,0xb
ffffffffc02002ec:	29050513          	addi	a0,a0,656 # ffffffffc020b578 <etext+0x158>
ffffffffc02002f0:	e406                	sd	ra,8(sp)
ffffffffc02002f2:	eb5ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02002f6:	0000b617          	auipc	a2,0xb
ffffffffc02002fa:	29260613          	addi	a2,a2,658 # ffffffffc020b588 <etext+0x168>
ffffffffc02002fe:	0000b597          	auipc	a1,0xb
ffffffffc0200302:	2b258593          	addi	a1,a1,690 # ffffffffc020b5b0 <etext+0x190>
ffffffffc0200306:	0000b517          	auipc	a0,0xb
ffffffffc020030a:	27250513          	addi	a0,a0,626 # ffffffffc020b578 <etext+0x158>
ffffffffc020030e:	e99ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200312:	0000b617          	auipc	a2,0xb
ffffffffc0200316:	2ae60613          	addi	a2,a2,686 # ffffffffc020b5c0 <etext+0x1a0>
ffffffffc020031a:	0000b597          	auipc	a1,0xb
ffffffffc020031e:	2c658593          	addi	a1,a1,710 # ffffffffc020b5e0 <etext+0x1c0>
ffffffffc0200322:	0000b517          	auipc	a0,0xb
ffffffffc0200326:	25650513          	addi	a0,a0,598 # ffffffffc020b578 <etext+0x158>
ffffffffc020032a:	e7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_kerninfo>:
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
ffffffffc020033a:	ef3ff0ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <mon_backtrace>:
ffffffffc0200346:	1141                	addi	sp,sp,-16
ffffffffc0200348:	e406                	sd	ra,8(sp)
ffffffffc020034a:	f71ff0ef          	jal	ra,ffffffffc02002ba <print_stackframe>
ffffffffc020034e:	60a2                	ld	ra,8(sp)
ffffffffc0200350:	4501                	li	a0,0
ffffffffc0200352:	0141                	addi	sp,sp,16
ffffffffc0200354:	8082                	ret

ffffffffc0200356 <kmonitor>:
ffffffffc0200356:	7115                	addi	sp,sp,-224
ffffffffc0200358:	ed5e                	sd	s7,152(sp)
ffffffffc020035a:	8baa                	mv	s7,a0
ffffffffc020035c:	0000b517          	auipc	a0,0xb
ffffffffc0200360:	29450513          	addi	a0,a0,660 # ffffffffc020b5f0 <etext+0x1d0>
ffffffffc0200364:	ed86                	sd	ra,216(sp)
ffffffffc0200366:	e9a2                	sd	s0,208(sp)
ffffffffc0200368:	e5a6                	sd	s1,200(sp)
ffffffffc020036a:	e1ca                	sd	s2,192(sp)
ffffffffc020036c:	fd4e                	sd	s3,184(sp)
ffffffffc020036e:	f952                	sd	s4,176(sp)
ffffffffc0200370:	f556                	sd	s5,168(sp)
ffffffffc0200372:	f15a                	sd	s6,160(sp)
ffffffffc0200374:	e962                	sd	s8,144(sp)
ffffffffc0200376:	e566                	sd	s9,136(sp)
ffffffffc0200378:	e16a                	sd	s10,128(sp)
ffffffffc020037a:	e2dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020037e:	0000b517          	auipc	a0,0xb
ffffffffc0200382:	29a50513          	addi	a0,a0,666 # ffffffffc020b618 <etext+0x1f8>
ffffffffc0200386:	e21ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020038a:	000b8563          	beqz	s7,ffffffffc0200394 <kmonitor+0x3e>
ffffffffc020038e:	855e                	mv	a0,s7
ffffffffc0200390:	3fb000ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0200394:	0000bc17          	auipc	s8,0xb
ffffffffc0200398:	2f4c0c13          	addi	s8,s8,756 # ffffffffc020b688 <commands>
ffffffffc020039c:	0000b917          	auipc	s2,0xb
ffffffffc02003a0:	2a490913          	addi	s2,s2,676 # ffffffffc020b640 <etext+0x220>
ffffffffc02003a4:	0000b497          	auipc	s1,0xb
ffffffffc02003a8:	2a448493          	addi	s1,s1,676 # ffffffffc020b648 <etext+0x228>
ffffffffc02003ac:	49bd                	li	s3,15
ffffffffc02003ae:	0000bb17          	auipc	s6,0xb
ffffffffc02003b2:	2a2b0b13          	addi	s6,s6,674 # ffffffffc020b650 <etext+0x230>
ffffffffc02003b6:	0000ba17          	auipc	s4,0xb
ffffffffc02003ba:	1baa0a13          	addi	s4,s4,442 # ffffffffc020b570 <etext+0x150>
ffffffffc02003be:	4a8d                	li	s5,3
ffffffffc02003c0:	854a                	mv	a0,s2
ffffffffc02003c2:	cf1ff0ef          	jal	ra,ffffffffc02000b2 <readline>
ffffffffc02003c6:	842a                	mv	s0,a0
ffffffffc02003c8:	dd65                	beqz	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003ca:	00054583          	lbu	a1,0(a0)
ffffffffc02003ce:	4c81                	li	s9,0
ffffffffc02003d0:	e1bd                	bnez	a1,ffffffffc0200436 <kmonitor+0xe0>
ffffffffc02003d2:	fe0c87e3          	beqz	s9,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003d6:	6582                	ld	a1,0(sp)
ffffffffc02003d8:	0000bd17          	auipc	s10,0xb
ffffffffc02003dc:	2b0d0d13          	addi	s10,s10,688 # ffffffffc020b688 <commands>
ffffffffc02003e0:	8552                	mv	a0,s4
ffffffffc02003e2:	4401                	li	s0,0
ffffffffc02003e4:	0d61                	addi	s10,s10,24
ffffffffc02003e6:	7770a0ef          	jal	ra,ffffffffc020b35c <strcmp>
ffffffffc02003ea:	c919                	beqz	a0,ffffffffc0200400 <kmonitor+0xaa>
ffffffffc02003ec:	2405                	addiw	s0,s0,1
ffffffffc02003ee:	0b540063          	beq	s0,s5,ffffffffc020048e <kmonitor+0x138>
ffffffffc02003f2:	000d3503          	ld	a0,0(s10)
ffffffffc02003f6:	6582                	ld	a1,0(sp)
ffffffffc02003f8:	0d61                	addi	s10,s10,24
ffffffffc02003fa:	7630a0ef          	jal	ra,ffffffffc020b35c <strcmp>
ffffffffc02003fe:	f57d                	bnez	a0,ffffffffc02003ec <kmonitor+0x96>
ffffffffc0200400:	00141793          	slli	a5,s0,0x1
ffffffffc0200404:	97a2                	add	a5,a5,s0
ffffffffc0200406:	078e                	slli	a5,a5,0x3
ffffffffc0200408:	97e2                	add	a5,a5,s8
ffffffffc020040a:	6b9c                	ld	a5,16(a5)
ffffffffc020040c:	865e                	mv	a2,s7
ffffffffc020040e:	002c                	addi	a1,sp,8
ffffffffc0200410:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200414:	9782                	jalr	a5
ffffffffc0200416:	fa0555e3          	bgez	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc020041a:	60ee                	ld	ra,216(sp)
ffffffffc020041c:	644e                	ld	s0,208(sp)
ffffffffc020041e:	64ae                	ld	s1,200(sp)
ffffffffc0200420:	690e                	ld	s2,192(sp)
ffffffffc0200422:	79ea                	ld	s3,184(sp)
ffffffffc0200424:	7a4a                	ld	s4,176(sp)
ffffffffc0200426:	7aaa                	ld	s5,168(sp)
ffffffffc0200428:	7b0a                	ld	s6,160(sp)
ffffffffc020042a:	6bea                	ld	s7,152(sp)
ffffffffc020042c:	6c4a                	ld	s8,144(sp)
ffffffffc020042e:	6caa                	ld	s9,136(sp)
ffffffffc0200430:	6d0a                	ld	s10,128(sp)
ffffffffc0200432:	612d                	addi	sp,sp,224
ffffffffc0200434:	8082                	ret
ffffffffc0200436:	8526                	mv	a0,s1
ffffffffc0200438:	7690a0ef          	jal	ra,ffffffffc020b3a0 <strchr>
ffffffffc020043c:	c901                	beqz	a0,ffffffffc020044c <kmonitor+0xf6>
ffffffffc020043e:	00144583          	lbu	a1,1(s0)
ffffffffc0200442:	00040023          	sb	zero,0(s0)
ffffffffc0200446:	0405                	addi	s0,s0,1
ffffffffc0200448:	d5c9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc020044a:	b7f5                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc020044c:	00044783          	lbu	a5,0(s0)
ffffffffc0200450:	d3c9                	beqz	a5,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200452:	033c8963          	beq	s9,s3,ffffffffc0200484 <kmonitor+0x12e>
ffffffffc0200456:	003c9793          	slli	a5,s9,0x3
ffffffffc020045a:	0118                	addi	a4,sp,128
ffffffffc020045c:	97ba                	add	a5,a5,a4
ffffffffc020045e:	f887b023          	sd	s0,-128(a5)
ffffffffc0200462:	00044583          	lbu	a1,0(s0)
ffffffffc0200466:	2c85                	addiw	s9,s9,1
ffffffffc0200468:	e591                	bnez	a1,ffffffffc0200474 <kmonitor+0x11e>
ffffffffc020046a:	b7b5                	j	ffffffffc02003d6 <kmonitor+0x80>
ffffffffc020046c:	00144583          	lbu	a1,1(s0)
ffffffffc0200470:	0405                	addi	s0,s0,1
ffffffffc0200472:	d1a5                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200474:	8526                	mv	a0,s1
ffffffffc0200476:	72b0a0ef          	jal	ra,ffffffffc020b3a0 <strchr>
ffffffffc020047a:	d96d                	beqz	a0,ffffffffc020046c <kmonitor+0x116>
ffffffffc020047c:	00044583          	lbu	a1,0(s0)
ffffffffc0200480:	d9a9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200482:	bf55                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc0200484:	45c1                	li	a1,16
ffffffffc0200486:	855a                	mv	a0,s6
ffffffffc0200488:	d1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020048c:	b7e9                	j	ffffffffc0200456 <kmonitor+0x100>
ffffffffc020048e:	6582                	ld	a1,0(sp)
ffffffffc0200490:	0000b517          	auipc	a0,0xb
ffffffffc0200494:	1e050513          	addi	a0,a0,480 # ffffffffc020b670 <etext+0x250>
ffffffffc0200498:	d0fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020049c:	b715                	j	ffffffffc02003c0 <kmonitor+0x6a>

ffffffffc020049e <__panic>:
ffffffffc020049e:	00096317          	auipc	t1,0x96
ffffffffc02004a2:	3ca30313          	addi	t1,t1,970 # ffffffffc0296868 <is_panic>
ffffffffc02004a6:	00033e03          	ld	t3,0(t1)
ffffffffc02004aa:	715d                	addi	sp,sp,-80
ffffffffc02004ac:	ec06                	sd	ra,24(sp)
ffffffffc02004ae:	e822                	sd	s0,16(sp)
ffffffffc02004b0:	f436                	sd	a3,40(sp)
ffffffffc02004b2:	f83a                	sd	a4,48(sp)
ffffffffc02004b4:	fc3e                	sd	a5,56(sp)
ffffffffc02004b6:	e0c2                	sd	a6,64(sp)
ffffffffc02004b8:	e4c6                	sd	a7,72(sp)
ffffffffc02004ba:	020e1a63          	bnez	t3,ffffffffc02004ee <__panic+0x50>
ffffffffc02004be:	4785                	li	a5,1
ffffffffc02004c0:	00f33023          	sd	a5,0(t1)
ffffffffc02004c4:	8432                	mv	s0,a2
ffffffffc02004c6:	103c                	addi	a5,sp,40
ffffffffc02004c8:	862e                	mv	a2,a1
ffffffffc02004ca:	85aa                	mv	a1,a0
ffffffffc02004cc:	0000b517          	auipc	a0,0xb
ffffffffc02004d0:	20450513          	addi	a0,a0,516 # ffffffffc020b6d0 <commands+0x48>
ffffffffc02004d4:	e43e                	sd	a5,8(sp)
ffffffffc02004d6:	cd1ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004da:	65a2                	ld	a1,8(sp)
ffffffffc02004dc:	8522                	mv	a0,s0
ffffffffc02004de:	ca3ff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc02004e2:	0000c517          	auipc	a0,0xc
ffffffffc02004e6:	4ae50513          	addi	a0,a0,1198 # ffffffffc020c990 <default_pmm_manager+0x610>
ffffffffc02004ea:	cbdff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	4581                	li	a1,0
ffffffffc02004f2:	4601                	li	a2,0
ffffffffc02004f4:	48a1                	li	a7,8
ffffffffc02004f6:	00000073          	ecall
ffffffffc02004fa:	778000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02004fe:	4501                	li	a0,0
ffffffffc0200500:	e57ff0ef          	jal	ra,ffffffffc0200356 <kmonitor>
ffffffffc0200504:	bfed                	j	ffffffffc02004fe <__panic+0x60>

ffffffffc0200506 <__warn>:
ffffffffc0200506:	715d                	addi	sp,sp,-80
ffffffffc0200508:	832e                	mv	t1,a1
ffffffffc020050a:	e822                	sd	s0,16(sp)
ffffffffc020050c:	85aa                	mv	a1,a0
ffffffffc020050e:	8432                	mv	s0,a2
ffffffffc0200510:	fc3e                	sd	a5,56(sp)
ffffffffc0200512:	861a                	mv	a2,t1
ffffffffc0200514:	103c                	addi	a5,sp,40
ffffffffc0200516:	0000b517          	auipc	a0,0xb
ffffffffc020051a:	1da50513          	addi	a0,a0,474 # ffffffffc020b6f0 <commands+0x68>
ffffffffc020051e:	ec06                	sd	ra,24(sp)
ffffffffc0200520:	f436                	sd	a3,40(sp)
ffffffffc0200522:	f83a                	sd	a4,48(sp)
ffffffffc0200524:	e0c2                	sd	a6,64(sp)
ffffffffc0200526:	e4c6                	sd	a7,72(sp)
ffffffffc0200528:	e43e                	sd	a5,8(sp)
ffffffffc020052a:	c7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020052e:	65a2                	ld	a1,8(sp)
ffffffffc0200530:	8522                	mv	a0,s0
ffffffffc0200532:	c4fff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc0200536:	0000c517          	auipc	a0,0xc
ffffffffc020053a:	45a50513          	addi	a0,a0,1114 # ffffffffc020c990 <default_pmm_manager+0x610>
ffffffffc020053e:	c69ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200542:	60e2                	ld	ra,24(sp)
ffffffffc0200544:	6442                	ld	s0,16(sp)
ffffffffc0200546:	6161                	addi	sp,sp,80
ffffffffc0200548:	8082                	ret

ffffffffc020054a <clock_init>:
ffffffffc020054a:	02000793          	li	a5,32
ffffffffc020054e:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc0200552:	c0102573          	rdtime	a0
ffffffffc0200556:	67e1                	lui	a5,0x18
ffffffffc0200558:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc020055c:	953e                	add	a0,a0,a5
ffffffffc020055e:	4581                	li	a1,0
ffffffffc0200560:	4601                	li	a2,0
ffffffffc0200562:	4881                	li	a7,0
ffffffffc0200564:	00000073          	ecall
ffffffffc0200568:	0000b517          	auipc	a0,0xb
ffffffffc020056c:	1a850513          	addi	a0,a0,424 # ffffffffc020b710 <commands+0x88>
ffffffffc0200570:	00096797          	auipc	a5,0x96
ffffffffc0200574:	3007b023          	sd	zero,768(a5) # ffffffffc0296870 <ticks>
ffffffffc0200578:	b13d                	j	ffffffffc02001a6 <cprintf>

ffffffffc020057a <clock_set_next_event>:
ffffffffc020057a:	c0102573          	rdtime	a0
ffffffffc020057e:	67e1                	lui	a5,0x18
ffffffffc0200580:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc0200584:	953e                	add	a0,a0,a5
ffffffffc0200586:	4581                	li	a1,0
ffffffffc0200588:	4601                	li	a2,0
ffffffffc020058a:	4881                	li	a7,0
ffffffffc020058c:	00000073          	ecall
ffffffffc0200590:	8082                	ret

ffffffffc0200592 <cons_init>:
ffffffffc0200592:	4501                	li	a0,0
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4889                	li	a7,2
ffffffffc020059a:	00000073          	ecall
ffffffffc020059e:	8082                	ret

ffffffffc02005a0 <cons_putc>:
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	100027f3          	csrr	a5,sstatus
ffffffffc02005a8:	8b89                	andi	a5,a5,2
ffffffffc02005aa:	4701                	li	a4,0
ffffffffc02005ac:	ef95                	bnez	a5,ffffffffc02005e8 <cons_putc+0x48>
ffffffffc02005ae:	47a1                	li	a5,8
ffffffffc02005b0:	00f50b63          	beq	a0,a5,ffffffffc02005c6 <cons_putc+0x26>
ffffffffc02005b4:	4581                	li	a1,0
ffffffffc02005b6:	4601                	li	a2,0
ffffffffc02005b8:	4885                	li	a7,1
ffffffffc02005ba:	00000073          	ecall
ffffffffc02005be:	e315                	bnez	a4,ffffffffc02005e2 <cons_putc+0x42>
ffffffffc02005c0:	60e2                	ld	ra,24(sp)
ffffffffc02005c2:	6105                	addi	sp,sp,32
ffffffffc02005c4:	8082                	ret
ffffffffc02005c6:	4521                	li	a0,8
ffffffffc02005c8:	4581                	li	a1,0
ffffffffc02005ca:	4601                	li	a2,0
ffffffffc02005cc:	4885                	li	a7,1
ffffffffc02005ce:	00000073          	ecall
ffffffffc02005d2:	02000513          	li	a0,32
ffffffffc02005d6:	00000073          	ecall
ffffffffc02005da:	4521                	li	a0,8
ffffffffc02005dc:	00000073          	ecall
ffffffffc02005e0:	d365                	beqz	a4,ffffffffc02005c0 <cons_putc+0x20>
ffffffffc02005e2:	60e2                	ld	ra,24(sp)
ffffffffc02005e4:	6105                	addi	sp,sp,32
ffffffffc02005e6:	a559                	j	ffffffffc0200c6c <intr_enable>
ffffffffc02005e8:	e42a                	sd	a0,8(sp)
ffffffffc02005ea:	688000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02005ee:	6522                	ld	a0,8(sp)
ffffffffc02005f0:	4705                	li	a4,1
ffffffffc02005f2:	bf75                	j	ffffffffc02005ae <cons_putc+0xe>

ffffffffc02005f4 <cons_getc>:
ffffffffc02005f4:	1101                	addi	sp,sp,-32
ffffffffc02005f6:	ec06                	sd	ra,24(sp)
ffffffffc02005f8:	100027f3          	csrr	a5,sstatus
ffffffffc02005fc:	8b89                	andi	a5,a5,2
ffffffffc02005fe:	4801                	li	a6,0
ffffffffc0200600:	e3d5                	bnez	a5,ffffffffc02006a4 <cons_getc+0xb0>
ffffffffc0200602:	00091697          	auipc	a3,0x91
ffffffffc0200606:	e5e68693          	addi	a3,a3,-418 # ffffffffc0291460 <cons>
ffffffffc020060a:	07f00713          	li	a4,127
ffffffffc020060e:	20000313          	li	t1,512
ffffffffc0200612:	a021                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200614:	0ff57513          	zext.b	a0,a0
ffffffffc0200618:	ef91                	bnez	a5,ffffffffc0200634 <cons_getc+0x40>
ffffffffc020061a:	4501                	li	a0,0
ffffffffc020061c:	4581                	li	a1,0
ffffffffc020061e:	4601                	li	a2,0
ffffffffc0200620:	4889                	li	a7,2
ffffffffc0200622:	00000073          	ecall
ffffffffc0200626:	0005079b          	sext.w	a5,a0
ffffffffc020062a:	0207c763          	bltz	a5,ffffffffc0200658 <cons_getc+0x64>
ffffffffc020062e:	fee793e3          	bne	a5,a4,ffffffffc0200614 <cons_getc+0x20>
ffffffffc0200632:	4521                	li	a0,8
ffffffffc0200634:	2046a783          	lw	a5,516(a3)
ffffffffc0200638:	02079613          	slli	a2,a5,0x20
ffffffffc020063c:	9201                	srli	a2,a2,0x20
ffffffffc020063e:	2785                	addiw	a5,a5,1
ffffffffc0200640:	9636                	add	a2,a2,a3
ffffffffc0200642:	20f6a223          	sw	a5,516(a3)
ffffffffc0200646:	00a60023          	sb	a0,0(a2)
ffffffffc020064a:	fc6798e3          	bne	a5,t1,ffffffffc020061a <cons_getc+0x26>
ffffffffc020064e:	00091797          	auipc	a5,0x91
ffffffffc0200652:	0007ab23          	sw	zero,22(a5) # ffffffffc0291664 <cons+0x204>
ffffffffc0200656:	b7d1                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200658:	2006a783          	lw	a5,512(a3)
ffffffffc020065c:	2046a703          	lw	a4,516(a3)
ffffffffc0200660:	4501                	li	a0,0
ffffffffc0200662:	00f70f63          	beq	a4,a5,ffffffffc0200680 <cons_getc+0x8c>
ffffffffc0200666:	0017861b          	addiw	a2,a5,1
ffffffffc020066a:	1782                	slli	a5,a5,0x20
ffffffffc020066c:	9381                	srli	a5,a5,0x20
ffffffffc020066e:	97b6                	add	a5,a5,a3
ffffffffc0200670:	20c6a023          	sw	a2,512(a3)
ffffffffc0200674:	20000713          	li	a4,512
ffffffffc0200678:	0007c503          	lbu	a0,0(a5)
ffffffffc020067c:	00e60763          	beq	a2,a4,ffffffffc020068a <cons_getc+0x96>
ffffffffc0200680:	00081b63          	bnez	a6,ffffffffc0200696 <cons_getc+0xa2>
ffffffffc0200684:	60e2                	ld	ra,24(sp)
ffffffffc0200686:	6105                	addi	sp,sp,32
ffffffffc0200688:	8082                	ret
ffffffffc020068a:	00091797          	auipc	a5,0x91
ffffffffc020068e:	fc07ab23          	sw	zero,-42(a5) # ffffffffc0291660 <cons+0x200>
ffffffffc0200692:	fe0809e3          	beqz	a6,ffffffffc0200684 <cons_getc+0x90>
ffffffffc0200696:	e42a                	sd	a0,8(sp)
ffffffffc0200698:	5d4000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020069c:	60e2                	ld	ra,24(sp)
ffffffffc020069e:	6522                	ld	a0,8(sp)
ffffffffc02006a0:	6105                	addi	sp,sp,32
ffffffffc02006a2:	8082                	ret
ffffffffc02006a4:	5ce000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02006a8:	4805                	li	a6,1
ffffffffc02006aa:	bfa1                	j	ffffffffc0200602 <cons_getc+0xe>

ffffffffc02006ac <dtb_init>:
ffffffffc02006ac:	7119                	addi	sp,sp,-128
ffffffffc02006ae:	0000b517          	auipc	a0,0xb
ffffffffc02006b2:	08250513          	addi	a0,a0,130 # ffffffffc020b730 <commands+0xa8>
ffffffffc02006b6:	fc86                	sd	ra,120(sp)
ffffffffc02006b8:	f8a2                	sd	s0,112(sp)
ffffffffc02006ba:	e8d2                	sd	s4,80(sp)
ffffffffc02006bc:	f4a6                	sd	s1,104(sp)
ffffffffc02006be:	f0ca                	sd	s2,96(sp)
ffffffffc02006c0:	ecce                	sd	s3,88(sp)
ffffffffc02006c2:	e4d6                	sd	s5,72(sp)
ffffffffc02006c4:	e0da                	sd	s6,64(sp)
ffffffffc02006c6:	fc5e                	sd	s7,56(sp)
ffffffffc02006c8:	f862                	sd	s8,48(sp)
ffffffffc02006ca:	f466                	sd	s9,40(sp)
ffffffffc02006cc:	f06a                	sd	s10,32(sp)
ffffffffc02006ce:	ec6e                	sd	s11,24(sp)
ffffffffc02006d0:	ad7ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006d4:	00014597          	auipc	a1,0x14
ffffffffc02006d8:	92c5b583          	ld	a1,-1748(a1) # ffffffffc0214000 <boot_hartid>
ffffffffc02006dc:	0000b517          	auipc	a0,0xb
ffffffffc02006e0:	06450513          	addi	a0,a0,100 # ffffffffc020b740 <commands+0xb8>
ffffffffc02006e4:	ac3ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006e8:	00014417          	auipc	s0,0x14
ffffffffc02006ec:	92040413          	addi	s0,s0,-1760 # ffffffffc0214008 <boot_dtb>
ffffffffc02006f0:	600c                	ld	a1,0(s0)
ffffffffc02006f2:	0000b517          	auipc	a0,0xb
ffffffffc02006f6:	05e50513          	addi	a0,a0,94 # ffffffffc020b750 <commands+0xc8>
ffffffffc02006fa:	aadff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006fe:	00043a03          	ld	s4,0(s0)
ffffffffc0200702:	0000b517          	auipc	a0,0xb
ffffffffc0200706:	06650513          	addi	a0,a0,102 # ffffffffc020b768 <commands+0xe0>
ffffffffc020070a:	120a0463          	beqz	s4,ffffffffc0200832 <dtb_init+0x186>
ffffffffc020070e:	57f5                	li	a5,-3
ffffffffc0200710:	07fa                	slli	a5,a5,0x1e
ffffffffc0200712:	00fa0733          	add	a4,s4,a5
ffffffffc0200716:	431c                	lw	a5,0(a4)
ffffffffc0200718:	00ff0637          	lui	a2,0xff0
ffffffffc020071c:	6b41                	lui	s6,0x10
ffffffffc020071e:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200722:	0187969b          	slliw	a3,a5,0x18
ffffffffc0200726:	0187d51b          	srliw	a0,a5,0x18
ffffffffc020072a:	0105959b          	slliw	a1,a1,0x10
ffffffffc020072e:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200732:	8df1                	and	a1,a1,a2
ffffffffc0200734:	8ec9                	or	a3,a3,a0
ffffffffc0200736:	0087979b          	slliw	a5,a5,0x8
ffffffffc020073a:	1b7d                	addi	s6,s6,-1
ffffffffc020073c:	0167f7b3          	and	a5,a5,s6
ffffffffc0200740:	8dd5                	or	a1,a1,a3
ffffffffc0200742:	8ddd                	or	a1,a1,a5
ffffffffc0200744:	d00e07b7          	lui	a5,0xd00e0
ffffffffc0200748:	2581                	sext.w	a1,a1
ffffffffc020074a:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe495dd>
ffffffffc020074e:	10f59163          	bne	a1,a5,ffffffffc0200850 <dtb_init+0x1a4>
ffffffffc0200752:	471c                	lw	a5,8(a4)
ffffffffc0200754:	4754                	lw	a3,12(a4)
ffffffffc0200756:	4c81                	li	s9,0
ffffffffc0200758:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020075c:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200760:	0186941b          	slliw	s0,a3,0x18
ffffffffc0200764:	0186d89b          	srliw	a7,a3,0x18
ffffffffc0200768:	01879a1b          	slliw	s4,a5,0x18
ffffffffc020076c:	0187d81b          	srliw	a6,a5,0x18
ffffffffc0200770:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200774:	0106d69b          	srliw	a3,a3,0x10
ffffffffc0200778:	0105959b          	slliw	a1,a1,0x10
ffffffffc020077c:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200780:	8d71                	and	a0,a0,a2
ffffffffc0200782:	01146433          	or	s0,s0,a7
ffffffffc0200786:	0086969b          	slliw	a3,a3,0x8
ffffffffc020078a:	010a6a33          	or	s4,s4,a6
ffffffffc020078e:	8e6d                	and	a2,a2,a1
ffffffffc0200790:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200794:	8c49                	or	s0,s0,a0
ffffffffc0200796:	0166f6b3          	and	a3,a3,s6
ffffffffc020079a:	00ca6a33          	or	s4,s4,a2
ffffffffc020079e:	0167f7b3          	and	a5,a5,s6
ffffffffc02007a2:	8c55                	or	s0,s0,a3
ffffffffc02007a4:	00fa6a33          	or	s4,s4,a5
ffffffffc02007a8:	1402                	slli	s0,s0,0x20
ffffffffc02007aa:	1a02                	slli	s4,s4,0x20
ffffffffc02007ac:	9001                	srli	s0,s0,0x20
ffffffffc02007ae:	020a5a13          	srli	s4,s4,0x20
ffffffffc02007b2:	943a                	add	s0,s0,a4
ffffffffc02007b4:	9a3a                	add	s4,s4,a4
ffffffffc02007b6:	00ff0c37          	lui	s8,0xff0
ffffffffc02007ba:	4b8d                	li	s7,3
ffffffffc02007bc:	0000b917          	auipc	s2,0xb
ffffffffc02007c0:	ffc90913          	addi	s2,s2,-4 # ffffffffc020b7b8 <commands+0x130>
ffffffffc02007c4:	49bd                	li	s3,15
ffffffffc02007c6:	4d91                	li	s11,4
ffffffffc02007c8:	4d05                	li	s10,1
ffffffffc02007ca:	0000b497          	auipc	s1,0xb
ffffffffc02007ce:	fe648493          	addi	s1,s1,-26 # ffffffffc020b7b0 <commands+0x128>
ffffffffc02007d2:	000a2703          	lw	a4,0(s4)
ffffffffc02007d6:	004a0a93          	addi	s5,s4,4
ffffffffc02007da:	0087569b          	srliw	a3,a4,0x8
ffffffffc02007de:	0187179b          	slliw	a5,a4,0x18
ffffffffc02007e2:	0187561b          	srliw	a2,a4,0x18
ffffffffc02007e6:	0106969b          	slliw	a3,a3,0x10
ffffffffc02007ea:	0107571b          	srliw	a4,a4,0x10
ffffffffc02007ee:	8fd1                	or	a5,a5,a2
ffffffffc02007f0:	0186f6b3          	and	a3,a3,s8
ffffffffc02007f4:	0087171b          	slliw	a4,a4,0x8
ffffffffc02007f8:	8fd5                	or	a5,a5,a3
ffffffffc02007fa:	00eb7733          	and	a4,s6,a4
ffffffffc02007fe:	8fd9                	or	a5,a5,a4
ffffffffc0200800:	2781                	sext.w	a5,a5
ffffffffc0200802:	09778c63          	beq	a5,s7,ffffffffc020089a <dtb_init+0x1ee>
ffffffffc0200806:	00fbea63          	bltu	s7,a5,ffffffffc020081a <dtb_init+0x16e>
ffffffffc020080a:	07a78663          	beq	a5,s10,ffffffffc0200876 <dtb_init+0x1ca>
ffffffffc020080e:	4709                	li	a4,2
ffffffffc0200810:	00e79763          	bne	a5,a4,ffffffffc020081e <dtb_init+0x172>
ffffffffc0200814:	4c81                	li	s9,0
ffffffffc0200816:	8a56                	mv	s4,s5
ffffffffc0200818:	bf6d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020081a:	ffb78ee3          	beq	a5,s11,ffffffffc0200816 <dtb_init+0x16a>
ffffffffc020081e:	0000b517          	auipc	a0,0xb
ffffffffc0200822:	01250513          	addi	a0,a0,18 # ffffffffc020b830 <commands+0x1a8>
ffffffffc0200826:	981ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020082a:	0000b517          	auipc	a0,0xb
ffffffffc020082e:	03e50513          	addi	a0,a0,62 # ffffffffc020b868 <commands+0x1e0>
ffffffffc0200832:	7446                	ld	s0,112(sp)
ffffffffc0200834:	70e6                	ld	ra,120(sp)
ffffffffc0200836:	74a6                	ld	s1,104(sp)
ffffffffc0200838:	7906                	ld	s2,96(sp)
ffffffffc020083a:	69e6                	ld	s3,88(sp)
ffffffffc020083c:	6a46                	ld	s4,80(sp)
ffffffffc020083e:	6aa6                	ld	s5,72(sp)
ffffffffc0200840:	6b06                	ld	s6,64(sp)
ffffffffc0200842:	7be2                	ld	s7,56(sp)
ffffffffc0200844:	7c42                	ld	s8,48(sp)
ffffffffc0200846:	7ca2                	ld	s9,40(sp)
ffffffffc0200848:	7d02                	ld	s10,32(sp)
ffffffffc020084a:	6de2                	ld	s11,24(sp)
ffffffffc020084c:	6109                	addi	sp,sp,128
ffffffffc020084e:	baa1                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200850:	7446                	ld	s0,112(sp)
ffffffffc0200852:	70e6                	ld	ra,120(sp)
ffffffffc0200854:	74a6                	ld	s1,104(sp)
ffffffffc0200856:	7906                	ld	s2,96(sp)
ffffffffc0200858:	69e6                	ld	s3,88(sp)
ffffffffc020085a:	6a46                	ld	s4,80(sp)
ffffffffc020085c:	6aa6                	ld	s5,72(sp)
ffffffffc020085e:	6b06                	ld	s6,64(sp)
ffffffffc0200860:	7be2                	ld	s7,56(sp)
ffffffffc0200862:	7c42                	ld	s8,48(sp)
ffffffffc0200864:	7ca2                	ld	s9,40(sp)
ffffffffc0200866:	7d02                	ld	s10,32(sp)
ffffffffc0200868:	6de2                	ld	s11,24(sp)
ffffffffc020086a:	0000b517          	auipc	a0,0xb
ffffffffc020086e:	f1e50513          	addi	a0,a0,-226 # ffffffffc020b788 <commands+0x100>
ffffffffc0200872:	6109                	addi	sp,sp,128
ffffffffc0200874:	ba0d                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200876:	8556                	mv	a0,s5
ffffffffc0200878:	29d0a0ef          	jal	ra,ffffffffc020b314 <strlen>
ffffffffc020087c:	8a2a                	mv	s4,a0
ffffffffc020087e:	4619                	li	a2,6
ffffffffc0200880:	85a6                	mv	a1,s1
ffffffffc0200882:	8556                	mv	a0,s5
ffffffffc0200884:	2a01                	sext.w	s4,s4
ffffffffc0200886:	2f50a0ef          	jal	ra,ffffffffc020b37a <strncmp>
ffffffffc020088a:	e111                	bnez	a0,ffffffffc020088e <dtb_init+0x1e2>
ffffffffc020088c:	4c85                	li	s9,1
ffffffffc020088e:	0a91                	addi	s5,s5,4
ffffffffc0200890:	9ad2                	add	s5,s5,s4
ffffffffc0200892:	ffcafa93          	andi	s5,s5,-4
ffffffffc0200896:	8a56                	mv	s4,s5
ffffffffc0200898:	bf2d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020089a:	004a2783          	lw	a5,4(s4)
ffffffffc020089e:	00ca0693          	addi	a3,s4,12
ffffffffc02008a2:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02008a6:	01879a9b          	slliw	s5,a5,0x18
ffffffffc02008aa:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008ae:	0107171b          	slliw	a4,a4,0x10
ffffffffc02008b2:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02008b6:	00caeab3          	or	s5,s5,a2
ffffffffc02008ba:	01877733          	and	a4,a4,s8
ffffffffc02008be:	0087979b          	slliw	a5,a5,0x8
ffffffffc02008c2:	00eaeab3          	or	s5,s5,a4
ffffffffc02008c6:	00fb77b3          	and	a5,s6,a5
ffffffffc02008ca:	00faeab3          	or	s5,s5,a5
ffffffffc02008ce:	2a81                	sext.w	s5,s5
ffffffffc02008d0:	000c9c63          	bnez	s9,ffffffffc02008e8 <dtb_init+0x23c>
ffffffffc02008d4:	1a82                	slli	s5,s5,0x20
ffffffffc02008d6:	00368793          	addi	a5,a3,3
ffffffffc02008da:	020ada93          	srli	s5,s5,0x20
ffffffffc02008de:	9abe                	add	s5,s5,a5
ffffffffc02008e0:	ffcafa93          	andi	s5,s5,-4
ffffffffc02008e4:	8a56                	mv	s4,s5
ffffffffc02008e6:	b5f5                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc02008e8:	008a2783          	lw	a5,8(s4)
ffffffffc02008ec:	85ca                	mv	a1,s2
ffffffffc02008ee:	e436                	sd	a3,8(sp)
ffffffffc02008f0:	0087d51b          	srliw	a0,a5,0x8
ffffffffc02008f4:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008f8:	0187971b          	slliw	a4,a5,0x18
ffffffffc02008fc:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200900:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200904:	8f51                	or	a4,a4,a2
ffffffffc0200906:	01857533          	and	a0,a0,s8
ffffffffc020090a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020090e:	8d59                	or	a0,a0,a4
ffffffffc0200910:	00fb77b3          	and	a5,s6,a5
ffffffffc0200914:	8d5d                	or	a0,a0,a5
ffffffffc0200916:	1502                	slli	a0,a0,0x20
ffffffffc0200918:	9101                	srli	a0,a0,0x20
ffffffffc020091a:	9522                	add	a0,a0,s0
ffffffffc020091c:	2410a0ef          	jal	ra,ffffffffc020b35c <strcmp>
ffffffffc0200920:	66a2                	ld	a3,8(sp)
ffffffffc0200922:	f94d                	bnez	a0,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200924:	fb59f8e3          	bgeu	s3,s5,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200928:	00ca3783          	ld	a5,12(s4)
ffffffffc020092c:	014a3703          	ld	a4,20(s4)
ffffffffc0200930:	0000b517          	auipc	a0,0xb
ffffffffc0200934:	e9050513          	addi	a0,a0,-368 # ffffffffc020b7c0 <commands+0x138>
ffffffffc0200938:	4207d613          	srai	a2,a5,0x20
ffffffffc020093c:	0087d31b          	srliw	t1,a5,0x8
ffffffffc0200940:	42075593          	srai	a1,a4,0x20
ffffffffc0200944:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200948:	0186581b          	srliw	a6,a2,0x18
ffffffffc020094c:	0187941b          	slliw	s0,a5,0x18
ffffffffc0200950:	0107d89b          	srliw	a7,a5,0x10
ffffffffc0200954:	0187d693          	srli	a3,a5,0x18
ffffffffc0200958:	01861f1b          	slliw	t5,a2,0x18
ffffffffc020095c:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200960:	0103131b          	slliw	t1,t1,0x10
ffffffffc0200964:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200968:	010f6f33          	or	t5,t5,a6
ffffffffc020096c:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200970:	0185df9b          	srliw	t6,a1,0x18
ffffffffc0200974:	01837333          	and	t1,t1,s8
ffffffffc0200978:	01c46433          	or	s0,s0,t3
ffffffffc020097c:	0186f6b3          	and	a3,a3,s8
ffffffffc0200980:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200984:	01871e9b          	slliw	t4,a4,0x18
ffffffffc0200988:	0107581b          	srliw	a6,a4,0x10
ffffffffc020098c:	0086161b          	slliw	a2,a2,0x8
ffffffffc0200990:	8361                	srli	a4,a4,0x18
ffffffffc0200992:	0107979b          	slliw	a5,a5,0x10
ffffffffc0200996:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020099a:	01e6e6b3          	or	a3,a3,t5
ffffffffc020099e:	00cb7633          	and	a2,s6,a2
ffffffffc02009a2:	0088181b          	slliw	a6,a6,0x8
ffffffffc02009a6:	0085959b          	slliw	a1,a1,0x8
ffffffffc02009aa:	00646433          	or	s0,s0,t1
ffffffffc02009ae:	0187f7b3          	and	a5,a5,s8
ffffffffc02009b2:	01fe6333          	or	t1,t3,t6
ffffffffc02009b6:	01877c33          	and	s8,a4,s8
ffffffffc02009ba:	0088989b          	slliw	a7,a7,0x8
ffffffffc02009be:	011b78b3          	and	a7,s6,a7
ffffffffc02009c2:	005eeeb3          	or	t4,t4,t0
ffffffffc02009c6:	00c6e733          	or	a4,a3,a2
ffffffffc02009ca:	006c6c33          	or	s8,s8,t1
ffffffffc02009ce:	010b76b3          	and	a3,s6,a6
ffffffffc02009d2:	00bb7b33          	and	s6,s6,a1
ffffffffc02009d6:	01d7e7b3          	or	a5,a5,t4
ffffffffc02009da:	016c6b33          	or	s6,s8,s6
ffffffffc02009de:	01146433          	or	s0,s0,a7
ffffffffc02009e2:	8fd5                	or	a5,a5,a3
ffffffffc02009e4:	1702                	slli	a4,a4,0x20
ffffffffc02009e6:	1b02                	slli	s6,s6,0x20
ffffffffc02009e8:	1782                	slli	a5,a5,0x20
ffffffffc02009ea:	9301                	srli	a4,a4,0x20
ffffffffc02009ec:	1402                	slli	s0,s0,0x20
ffffffffc02009ee:	020b5b13          	srli	s6,s6,0x20
ffffffffc02009f2:	0167eb33          	or	s6,a5,s6
ffffffffc02009f6:	8c59                	or	s0,s0,a4
ffffffffc02009f8:	faeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02009fc:	85a2                	mv	a1,s0
ffffffffc02009fe:	0000b517          	auipc	a0,0xb
ffffffffc0200a02:	de250513          	addi	a0,a0,-542 # ffffffffc020b7e0 <commands+0x158>
ffffffffc0200a06:	fa0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a0a:	014b5613          	srli	a2,s6,0x14
ffffffffc0200a0e:	85da                	mv	a1,s6
ffffffffc0200a10:	0000b517          	auipc	a0,0xb
ffffffffc0200a14:	de850513          	addi	a0,a0,-536 # ffffffffc020b7f8 <commands+0x170>
ffffffffc0200a18:	f8eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a1c:	008b05b3          	add	a1,s6,s0
ffffffffc0200a20:	15fd                	addi	a1,a1,-1
ffffffffc0200a22:	0000b517          	auipc	a0,0xb
ffffffffc0200a26:	df650513          	addi	a0,a0,-522 # ffffffffc020b818 <commands+0x190>
ffffffffc0200a2a:	f7cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a2e:	0000b517          	auipc	a0,0xb
ffffffffc0200a32:	e3a50513          	addi	a0,a0,-454 # ffffffffc020b868 <commands+0x1e0>
ffffffffc0200a36:	00096797          	auipc	a5,0x96
ffffffffc0200a3a:	e487b123          	sd	s0,-446(a5) # ffffffffc0296878 <memory_base>
ffffffffc0200a3e:	00096797          	auipc	a5,0x96
ffffffffc0200a42:	e567b123          	sd	s6,-446(a5) # ffffffffc0296880 <memory_size>
ffffffffc0200a46:	b3f5                	j	ffffffffc0200832 <dtb_init+0x186>

ffffffffc0200a48 <get_memory_base>:
ffffffffc0200a48:	00096517          	auipc	a0,0x96
ffffffffc0200a4c:	e3053503          	ld	a0,-464(a0) # ffffffffc0296878 <memory_base>
ffffffffc0200a50:	8082                	ret

ffffffffc0200a52 <get_memory_size>:
ffffffffc0200a52:	00096517          	auipc	a0,0x96
ffffffffc0200a56:	e2e53503          	ld	a0,-466(a0) # ffffffffc0296880 <memory_size>
ffffffffc0200a5a:	8082                	ret

ffffffffc0200a5c <ide_init>:
ffffffffc0200a5c:	1141                	addi	sp,sp,-16
ffffffffc0200a5e:	00091597          	auipc	a1,0x91
ffffffffc0200a62:	c5a58593          	addi	a1,a1,-934 # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a66:	4505                	li	a0,1
ffffffffc0200a68:	e022                	sd	s0,0(sp)
ffffffffc0200a6a:	00091797          	auipc	a5,0x91
ffffffffc0200a6e:	be07af23          	sw	zero,-1026(a5) # ffffffffc0291668 <ide_devices>
ffffffffc0200a72:	00091797          	auipc	a5,0x91
ffffffffc0200a76:	c407a323          	sw	zero,-954(a5) # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a7a:	00091797          	auipc	a5,0x91
ffffffffc0200a7e:	c807a723          	sw	zero,-882(a5) # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200a82:	00091797          	auipc	a5,0x91
ffffffffc0200a86:	cc07ab23          	sw	zero,-810(a5) # ffffffffc0291758 <ide_devices+0xf0>
ffffffffc0200a8a:	e406                	sd	ra,8(sp)
ffffffffc0200a8c:	00091417          	auipc	s0,0x91
ffffffffc0200a90:	bdc40413          	addi	s0,s0,-1060 # ffffffffc0291668 <ide_devices>
ffffffffc0200a94:	23a000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200a98:	483c                	lw	a5,80(s0)
ffffffffc0200a9a:	cf99                	beqz	a5,ffffffffc0200ab8 <ide_init+0x5c>
ffffffffc0200a9c:	00091597          	auipc	a1,0x91
ffffffffc0200aa0:	c6c58593          	addi	a1,a1,-916 # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200aa4:	4509                	li	a0,2
ffffffffc0200aa6:	228000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200aaa:	0a042783          	lw	a5,160(s0)
ffffffffc0200aae:	c785                	beqz	a5,ffffffffc0200ad6 <ide_init+0x7a>
ffffffffc0200ab0:	60a2                	ld	ra,8(sp)
ffffffffc0200ab2:	6402                	ld	s0,0(sp)
ffffffffc0200ab4:	0141                	addi	sp,sp,16
ffffffffc0200ab6:	8082                	ret
ffffffffc0200ab8:	0000b697          	auipc	a3,0xb
ffffffffc0200abc:	dc868693          	addi	a3,a3,-568 # ffffffffc020b880 <commands+0x1f8>
ffffffffc0200ac0:	0000b617          	auipc	a2,0xb
ffffffffc0200ac4:	dd860613          	addi	a2,a2,-552 # ffffffffc020b898 <commands+0x210>
ffffffffc0200ac8:	45c5                	li	a1,17
ffffffffc0200aca:	0000b517          	auipc	a0,0xb
ffffffffc0200ace:	de650513          	addi	a0,a0,-538 # ffffffffc020b8b0 <commands+0x228>
ffffffffc0200ad2:	9cdff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200ad6:	0000b697          	auipc	a3,0xb
ffffffffc0200ada:	df268693          	addi	a3,a3,-526 # ffffffffc020b8c8 <commands+0x240>
ffffffffc0200ade:	0000b617          	auipc	a2,0xb
ffffffffc0200ae2:	dba60613          	addi	a2,a2,-582 # ffffffffc020b898 <commands+0x210>
ffffffffc0200ae6:	45d1                	li	a1,20
ffffffffc0200ae8:	0000b517          	auipc	a0,0xb
ffffffffc0200aec:	dc850513          	addi	a0,a0,-568 # ffffffffc020b8b0 <commands+0x228>
ffffffffc0200af0:	9afff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200af4 <ide_device_valid>:
ffffffffc0200af4:	478d                	li	a5,3
ffffffffc0200af6:	00a7ef63          	bltu	a5,a0,ffffffffc0200b14 <ide_device_valid+0x20>
ffffffffc0200afa:	00251793          	slli	a5,a0,0x2
ffffffffc0200afe:	953e                	add	a0,a0,a5
ffffffffc0200b00:	0512                	slli	a0,a0,0x4
ffffffffc0200b02:	00091797          	auipc	a5,0x91
ffffffffc0200b06:	b6678793          	addi	a5,a5,-1178 # ffffffffc0291668 <ide_devices>
ffffffffc0200b0a:	953e                	add	a0,a0,a5
ffffffffc0200b0c:	4108                	lw	a0,0(a0)
ffffffffc0200b0e:	00a03533          	snez	a0,a0
ffffffffc0200b12:	8082                	ret
ffffffffc0200b14:	4501                	li	a0,0
ffffffffc0200b16:	8082                	ret

ffffffffc0200b18 <ide_device_size>:
ffffffffc0200b18:	478d                	li	a5,3
ffffffffc0200b1a:	02a7e163          	bltu	a5,a0,ffffffffc0200b3c <ide_device_size+0x24>
ffffffffc0200b1e:	00251793          	slli	a5,a0,0x2
ffffffffc0200b22:	953e                	add	a0,a0,a5
ffffffffc0200b24:	0512                	slli	a0,a0,0x4
ffffffffc0200b26:	00091797          	auipc	a5,0x91
ffffffffc0200b2a:	b4278793          	addi	a5,a5,-1214 # ffffffffc0291668 <ide_devices>
ffffffffc0200b2e:	97aa                	add	a5,a5,a0
ffffffffc0200b30:	4398                	lw	a4,0(a5)
ffffffffc0200b32:	4501                	li	a0,0
ffffffffc0200b34:	c709                	beqz	a4,ffffffffc0200b3e <ide_device_size+0x26>
ffffffffc0200b36:	0087e503          	lwu	a0,8(a5)
ffffffffc0200b3a:	8082                	ret
ffffffffc0200b3c:	4501                	li	a0,0
ffffffffc0200b3e:	8082                	ret

ffffffffc0200b40 <ide_read_secs>:
ffffffffc0200b40:	1141                	addi	sp,sp,-16
ffffffffc0200b42:	e406                	sd	ra,8(sp)
ffffffffc0200b44:	08000793          	li	a5,128
ffffffffc0200b48:	04d7e763          	bltu	a5,a3,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b4c:	478d                	li	a5,3
ffffffffc0200b4e:	0005081b          	sext.w	a6,a0
ffffffffc0200b52:	04a7e263          	bltu	a5,a0,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b56:	00281793          	slli	a5,a6,0x2
ffffffffc0200b5a:	97c2                	add	a5,a5,a6
ffffffffc0200b5c:	0792                	slli	a5,a5,0x4
ffffffffc0200b5e:	00091817          	auipc	a6,0x91
ffffffffc0200b62:	b0a80813          	addi	a6,a6,-1270 # ffffffffc0291668 <ide_devices>
ffffffffc0200b66:	97c2                	add	a5,a5,a6
ffffffffc0200b68:	0007a883          	lw	a7,0(a5)
ffffffffc0200b6c:	02088563          	beqz	a7,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b70:	100008b7          	lui	a7,0x10000
ffffffffc0200b74:	0515f163          	bgeu	a1,a7,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b78:	1582                	slli	a1,a1,0x20
ffffffffc0200b7a:	9181                	srli	a1,a1,0x20
ffffffffc0200b7c:	00d58733          	add	a4,a1,a3
ffffffffc0200b80:	02e8eb63          	bltu	a7,a4,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b84:	00251713          	slli	a4,a0,0x2
ffffffffc0200b88:	60a2                	ld	ra,8(sp)
ffffffffc0200b8a:	63bc                	ld	a5,64(a5)
ffffffffc0200b8c:	953a                	add	a0,a0,a4
ffffffffc0200b8e:	0512                	slli	a0,a0,0x4
ffffffffc0200b90:	9542                	add	a0,a0,a6
ffffffffc0200b92:	0141                	addi	sp,sp,16
ffffffffc0200b94:	8782                	jr	a5
ffffffffc0200b96:	0000b697          	auipc	a3,0xb
ffffffffc0200b9a:	d4a68693          	addi	a3,a3,-694 # ffffffffc020b8e0 <commands+0x258>
ffffffffc0200b9e:	0000b617          	auipc	a2,0xb
ffffffffc0200ba2:	cfa60613          	addi	a2,a2,-774 # ffffffffc020b898 <commands+0x210>
ffffffffc0200ba6:	02200593          	li	a1,34
ffffffffc0200baa:	0000b517          	auipc	a0,0xb
ffffffffc0200bae:	d0650513          	addi	a0,a0,-762 # ffffffffc020b8b0 <commands+0x228>
ffffffffc0200bb2:	8edff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200bb6:	0000b697          	auipc	a3,0xb
ffffffffc0200bba:	d5268693          	addi	a3,a3,-686 # ffffffffc020b908 <commands+0x280>
ffffffffc0200bbe:	0000b617          	auipc	a2,0xb
ffffffffc0200bc2:	cda60613          	addi	a2,a2,-806 # ffffffffc020b898 <commands+0x210>
ffffffffc0200bc6:	02300593          	li	a1,35
ffffffffc0200bca:	0000b517          	auipc	a0,0xb
ffffffffc0200bce:	ce650513          	addi	a0,a0,-794 # ffffffffc020b8b0 <commands+0x228>
ffffffffc0200bd2:	8cdff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200bd6 <ide_write_secs>:
ffffffffc0200bd6:	1141                	addi	sp,sp,-16
ffffffffc0200bd8:	e406                	sd	ra,8(sp)
ffffffffc0200bda:	08000793          	li	a5,128
ffffffffc0200bde:	04d7e763          	bltu	a5,a3,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200be2:	478d                	li	a5,3
ffffffffc0200be4:	0005081b          	sext.w	a6,a0
ffffffffc0200be8:	04a7e263          	bltu	a5,a0,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200bec:	00281793          	slli	a5,a6,0x2
ffffffffc0200bf0:	97c2                	add	a5,a5,a6
ffffffffc0200bf2:	0792                	slli	a5,a5,0x4
ffffffffc0200bf4:	00091817          	auipc	a6,0x91
ffffffffc0200bf8:	a7480813          	addi	a6,a6,-1420 # ffffffffc0291668 <ide_devices>
ffffffffc0200bfc:	97c2                	add	a5,a5,a6
ffffffffc0200bfe:	0007a883          	lw	a7,0(a5)
ffffffffc0200c02:	02088563          	beqz	a7,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200c06:	100008b7          	lui	a7,0x10000
ffffffffc0200c0a:	0515f163          	bgeu	a1,a7,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c0e:	1582                	slli	a1,a1,0x20
ffffffffc0200c10:	9181                	srli	a1,a1,0x20
ffffffffc0200c12:	00d58733          	add	a4,a1,a3
ffffffffc0200c16:	02e8eb63          	bltu	a7,a4,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c1a:	00251713          	slli	a4,a0,0x2
ffffffffc0200c1e:	60a2                	ld	ra,8(sp)
ffffffffc0200c20:	67bc                	ld	a5,72(a5)
ffffffffc0200c22:	953a                	add	a0,a0,a4
ffffffffc0200c24:	0512                	slli	a0,a0,0x4
ffffffffc0200c26:	9542                	add	a0,a0,a6
ffffffffc0200c28:	0141                	addi	sp,sp,16
ffffffffc0200c2a:	8782                	jr	a5
ffffffffc0200c2c:	0000b697          	auipc	a3,0xb
ffffffffc0200c30:	cb468693          	addi	a3,a3,-844 # ffffffffc020b8e0 <commands+0x258>
ffffffffc0200c34:	0000b617          	auipc	a2,0xb
ffffffffc0200c38:	c6460613          	addi	a2,a2,-924 # ffffffffc020b898 <commands+0x210>
ffffffffc0200c3c:	02900593          	li	a1,41
ffffffffc0200c40:	0000b517          	auipc	a0,0xb
ffffffffc0200c44:	c7050513          	addi	a0,a0,-912 # ffffffffc020b8b0 <commands+0x228>
ffffffffc0200c48:	857ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200c4c:	0000b697          	auipc	a3,0xb
ffffffffc0200c50:	cbc68693          	addi	a3,a3,-836 # ffffffffc020b908 <commands+0x280>
ffffffffc0200c54:	0000b617          	auipc	a2,0xb
ffffffffc0200c58:	c4460613          	addi	a2,a2,-956 # ffffffffc020b898 <commands+0x210>
ffffffffc0200c5c:	02a00593          	li	a1,42
ffffffffc0200c60:	0000b517          	auipc	a0,0xb
ffffffffc0200c64:	c5050513          	addi	a0,a0,-944 # ffffffffc020b8b0 <commands+0x228>
ffffffffc0200c68:	837ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200c6c <intr_enable>:
ffffffffc0200c6c:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200c70:	8082                	ret

ffffffffc0200c72 <intr_disable>:
ffffffffc0200c72:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200c76:	8082                	ret

ffffffffc0200c78 <pic_init>:
ffffffffc0200c78:	8082                	ret

ffffffffc0200c7a <ramdisk_write>:
ffffffffc0200c7a:	00856703          	lwu	a4,8(a0)
ffffffffc0200c7e:	1141                	addi	sp,sp,-16
ffffffffc0200c80:	e406                	sd	ra,8(sp)
ffffffffc0200c82:	8f0d                	sub	a4,a4,a1
ffffffffc0200c84:	87ae                	mv	a5,a1
ffffffffc0200c86:	85b2                	mv	a1,a2
ffffffffc0200c88:	00e6f363          	bgeu	a3,a4,ffffffffc0200c8e <ramdisk_write+0x14>
ffffffffc0200c8c:	8736                	mv	a4,a3
ffffffffc0200c8e:	6908                	ld	a0,16(a0)
ffffffffc0200c90:	07a6                	slli	a5,a5,0x9
ffffffffc0200c92:	00971613          	slli	a2,a4,0x9
ffffffffc0200c96:	953e                	add	a0,a0,a5
ffffffffc0200c98:	7700a0ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc0200c9c:	60a2                	ld	ra,8(sp)
ffffffffc0200c9e:	4501                	li	a0,0
ffffffffc0200ca0:	0141                	addi	sp,sp,16
ffffffffc0200ca2:	8082                	ret

ffffffffc0200ca4 <ramdisk_read>:
ffffffffc0200ca4:	00856783          	lwu	a5,8(a0)
ffffffffc0200ca8:	1141                	addi	sp,sp,-16
ffffffffc0200caa:	e406                	sd	ra,8(sp)
ffffffffc0200cac:	8f8d                	sub	a5,a5,a1
ffffffffc0200cae:	872a                	mv	a4,a0
ffffffffc0200cb0:	8532                	mv	a0,a2
ffffffffc0200cb2:	00f6f363          	bgeu	a3,a5,ffffffffc0200cb8 <ramdisk_read+0x14>
ffffffffc0200cb6:	87b6                	mv	a5,a3
ffffffffc0200cb8:	6b18                	ld	a4,16(a4)
ffffffffc0200cba:	05a6                	slli	a1,a1,0x9
ffffffffc0200cbc:	00979613          	slli	a2,a5,0x9
ffffffffc0200cc0:	95ba                	add	a1,a1,a4
ffffffffc0200cc2:	7460a0ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc0200cc6:	60a2                	ld	ra,8(sp)
ffffffffc0200cc8:	4501                	li	a0,0
ffffffffc0200cca:	0141                	addi	sp,sp,16
ffffffffc0200ccc:	8082                	ret

ffffffffc0200cce <ramdisk_init>:
ffffffffc0200cce:	1101                	addi	sp,sp,-32
ffffffffc0200cd0:	e822                	sd	s0,16(sp)
ffffffffc0200cd2:	842e                	mv	s0,a1
ffffffffc0200cd4:	e426                	sd	s1,8(sp)
ffffffffc0200cd6:	05000613          	li	a2,80
ffffffffc0200cda:	84aa                	mv	s1,a0
ffffffffc0200cdc:	4581                	li	a1,0
ffffffffc0200cde:	8522                	mv	a0,s0
ffffffffc0200ce0:	ec06                	sd	ra,24(sp)
ffffffffc0200ce2:	e04a                	sd	s2,0(sp)
ffffffffc0200ce4:	6d20a0ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0200ce8:	4785                	li	a5,1
ffffffffc0200cea:	06f48b63          	beq	s1,a5,ffffffffc0200d60 <ramdisk_init+0x92>
ffffffffc0200cee:	4789                	li	a5,2
ffffffffc0200cf0:	00090617          	auipc	a2,0x90
ffffffffc0200cf4:	32060613          	addi	a2,a2,800 # ffffffffc0291010 <arena>
ffffffffc0200cf8:	0001b917          	auipc	s2,0x1b
ffffffffc0200cfc:	01890913          	addi	s2,s2,24 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d00:	08f49563          	bne	s1,a5,ffffffffc0200d8a <ramdisk_init+0xbc>
ffffffffc0200d04:	06c90863          	beq	s2,a2,ffffffffc0200d74 <ramdisk_init+0xa6>
ffffffffc0200d08:	412604b3          	sub	s1,a2,s2
ffffffffc0200d0c:	86a6                	mv	a3,s1
ffffffffc0200d0e:	85ca                	mv	a1,s2
ffffffffc0200d10:	167d                	addi	a2,a2,-1
ffffffffc0200d12:	0000b517          	auipc	a0,0xb
ffffffffc0200d16:	c4e50513          	addi	a0,a0,-946 # ffffffffc020b960 <commands+0x2d8>
ffffffffc0200d1a:	c8cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200d1e:	57fd                	li	a5,-1
ffffffffc0200d20:	1782                	slli	a5,a5,0x20
ffffffffc0200d22:	0785                	addi	a5,a5,1
ffffffffc0200d24:	0094d49b          	srliw	s1,s1,0x9
ffffffffc0200d28:	e01c                	sd	a5,0(s0)
ffffffffc0200d2a:	c404                	sw	s1,8(s0)
ffffffffc0200d2c:	01243823          	sd	s2,16(s0)
ffffffffc0200d30:	02040513          	addi	a0,s0,32
ffffffffc0200d34:	0000b597          	auipc	a1,0xb
ffffffffc0200d38:	c8458593          	addi	a1,a1,-892 # ffffffffc020b9b8 <commands+0x330>
ffffffffc0200d3c:	60e0a0ef          	jal	ra,ffffffffc020b34a <strcpy>
ffffffffc0200d40:	00000797          	auipc	a5,0x0
ffffffffc0200d44:	f6478793          	addi	a5,a5,-156 # ffffffffc0200ca4 <ramdisk_read>
ffffffffc0200d48:	e03c                	sd	a5,64(s0)
ffffffffc0200d4a:	00000797          	auipc	a5,0x0
ffffffffc0200d4e:	f3078793          	addi	a5,a5,-208 # ffffffffc0200c7a <ramdisk_write>
ffffffffc0200d52:	60e2                	ld	ra,24(sp)
ffffffffc0200d54:	e43c                	sd	a5,72(s0)
ffffffffc0200d56:	6442                	ld	s0,16(sp)
ffffffffc0200d58:	64a2                	ld	s1,8(sp)
ffffffffc0200d5a:	6902                	ld	s2,0(sp)
ffffffffc0200d5c:	6105                	addi	sp,sp,32
ffffffffc0200d5e:	8082                	ret
ffffffffc0200d60:	0001b617          	auipc	a2,0x1b
ffffffffc0200d64:	fb060613          	addi	a2,a2,-80 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d68:	00013917          	auipc	s2,0x13
ffffffffc0200d6c:	2a890913          	addi	s2,s2,680 # ffffffffc0214010 <_binary_bin_swap_img_start>
ffffffffc0200d70:	f8c91ce3          	bne	s2,a2,ffffffffc0200d08 <ramdisk_init+0x3a>
ffffffffc0200d74:	6442                	ld	s0,16(sp)
ffffffffc0200d76:	60e2                	ld	ra,24(sp)
ffffffffc0200d78:	64a2                	ld	s1,8(sp)
ffffffffc0200d7a:	6902                	ld	s2,0(sp)
ffffffffc0200d7c:	0000b517          	auipc	a0,0xb
ffffffffc0200d80:	bcc50513          	addi	a0,a0,-1076 # ffffffffc020b948 <commands+0x2c0>
ffffffffc0200d84:	6105                	addi	sp,sp,32
ffffffffc0200d86:	c20ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0200d8a:	0000b617          	auipc	a2,0xb
ffffffffc0200d8e:	bfe60613          	addi	a2,a2,-1026 # ffffffffc020b988 <commands+0x300>
ffffffffc0200d92:	03200593          	li	a1,50
ffffffffc0200d96:	0000b517          	auipc	a0,0xb
ffffffffc0200d9a:	c0a50513          	addi	a0,a0,-1014 # ffffffffc020b9a0 <commands+0x318>
ffffffffc0200d9e:	f00ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200da2 <idt_init>:
ffffffffc0200da2:	14005073          	csrwi	sscratch,0
ffffffffc0200da6:	00000797          	auipc	a5,0x0
ffffffffc0200daa:	43a78793          	addi	a5,a5,1082 # ffffffffc02011e0 <__alltraps>
ffffffffc0200dae:	10579073          	csrw	stvec,a5
ffffffffc0200db2:	000407b7          	lui	a5,0x40
ffffffffc0200db6:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200dba:	8082                	ret

ffffffffc0200dbc <print_regs>:
ffffffffc0200dbc:	610c                	ld	a1,0(a0)
ffffffffc0200dbe:	1141                	addi	sp,sp,-16
ffffffffc0200dc0:	e022                	sd	s0,0(sp)
ffffffffc0200dc2:	842a                	mv	s0,a0
ffffffffc0200dc4:	0000b517          	auipc	a0,0xb
ffffffffc0200dc8:	c0450513          	addi	a0,a0,-1020 # ffffffffc020b9c8 <commands+0x340>
ffffffffc0200dcc:	e406                	sd	ra,8(sp)
ffffffffc0200dce:	bd8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dd2:	640c                	ld	a1,8(s0)
ffffffffc0200dd4:	0000b517          	auipc	a0,0xb
ffffffffc0200dd8:	c0c50513          	addi	a0,a0,-1012 # ffffffffc020b9e0 <commands+0x358>
ffffffffc0200ddc:	bcaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200de0:	680c                	ld	a1,16(s0)
ffffffffc0200de2:	0000b517          	auipc	a0,0xb
ffffffffc0200de6:	c1650513          	addi	a0,a0,-1002 # ffffffffc020b9f8 <commands+0x370>
ffffffffc0200dea:	bbcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dee:	6c0c                	ld	a1,24(s0)
ffffffffc0200df0:	0000b517          	auipc	a0,0xb
ffffffffc0200df4:	c2050513          	addi	a0,a0,-992 # ffffffffc020ba10 <commands+0x388>
ffffffffc0200df8:	baeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dfc:	700c                	ld	a1,32(s0)
ffffffffc0200dfe:	0000b517          	auipc	a0,0xb
ffffffffc0200e02:	c2a50513          	addi	a0,a0,-982 # ffffffffc020ba28 <commands+0x3a0>
ffffffffc0200e06:	ba0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e0a:	740c                	ld	a1,40(s0)
ffffffffc0200e0c:	0000b517          	auipc	a0,0xb
ffffffffc0200e10:	c3450513          	addi	a0,a0,-972 # ffffffffc020ba40 <commands+0x3b8>
ffffffffc0200e14:	b92ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e18:	780c                	ld	a1,48(s0)
ffffffffc0200e1a:	0000b517          	auipc	a0,0xb
ffffffffc0200e1e:	c3e50513          	addi	a0,a0,-962 # ffffffffc020ba58 <commands+0x3d0>
ffffffffc0200e22:	b84ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e26:	7c0c                	ld	a1,56(s0)
ffffffffc0200e28:	0000b517          	auipc	a0,0xb
ffffffffc0200e2c:	c4850513          	addi	a0,a0,-952 # ffffffffc020ba70 <commands+0x3e8>
ffffffffc0200e30:	b76ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e34:	602c                	ld	a1,64(s0)
ffffffffc0200e36:	0000b517          	auipc	a0,0xb
ffffffffc0200e3a:	c5250513          	addi	a0,a0,-942 # ffffffffc020ba88 <commands+0x400>
ffffffffc0200e3e:	b68ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e42:	642c                	ld	a1,72(s0)
ffffffffc0200e44:	0000b517          	auipc	a0,0xb
ffffffffc0200e48:	c5c50513          	addi	a0,a0,-932 # ffffffffc020baa0 <commands+0x418>
ffffffffc0200e4c:	b5aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e50:	682c                	ld	a1,80(s0)
ffffffffc0200e52:	0000b517          	auipc	a0,0xb
ffffffffc0200e56:	c6650513          	addi	a0,a0,-922 # ffffffffc020bab8 <commands+0x430>
ffffffffc0200e5a:	b4cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e5e:	6c2c                	ld	a1,88(s0)
ffffffffc0200e60:	0000b517          	auipc	a0,0xb
ffffffffc0200e64:	c7050513          	addi	a0,a0,-912 # ffffffffc020bad0 <commands+0x448>
ffffffffc0200e68:	b3eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e6c:	702c                	ld	a1,96(s0)
ffffffffc0200e6e:	0000b517          	auipc	a0,0xb
ffffffffc0200e72:	c7a50513          	addi	a0,a0,-902 # ffffffffc020bae8 <commands+0x460>
ffffffffc0200e76:	b30ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e7a:	742c                	ld	a1,104(s0)
ffffffffc0200e7c:	0000b517          	auipc	a0,0xb
ffffffffc0200e80:	c8450513          	addi	a0,a0,-892 # ffffffffc020bb00 <commands+0x478>
ffffffffc0200e84:	b22ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e88:	782c                	ld	a1,112(s0)
ffffffffc0200e8a:	0000b517          	auipc	a0,0xb
ffffffffc0200e8e:	c8e50513          	addi	a0,a0,-882 # ffffffffc020bb18 <commands+0x490>
ffffffffc0200e92:	b14ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e96:	7c2c                	ld	a1,120(s0)
ffffffffc0200e98:	0000b517          	auipc	a0,0xb
ffffffffc0200e9c:	c9850513          	addi	a0,a0,-872 # ffffffffc020bb30 <commands+0x4a8>
ffffffffc0200ea0:	b06ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ea4:	604c                	ld	a1,128(s0)
ffffffffc0200ea6:	0000b517          	auipc	a0,0xb
ffffffffc0200eaa:	ca250513          	addi	a0,a0,-862 # ffffffffc020bb48 <commands+0x4c0>
ffffffffc0200eae:	af8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eb2:	644c                	ld	a1,136(s0)
ffffffffc0200eb4:	0000b517          	auipc	a0,0xb
ffffffffc0200eb8:	cac50513          	addi	a0,a0,-852 # ffffffffc020bb60 <commands+0x4d8>
ffffffffc0200ebc:	aeaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ec0:	684c                	ld	a1,144(s0)
ffffffffc0200ec2:	0000b517          	auipc	a0,0xb
ffffffffc0200ec6:	cb650513          	addi	a0,a0,-842 # ffffffffc020bb78 <commands+0x4f0>
ffffffffc0200eca:	adcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ece:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed0:	0000b517          	auipc	a0,0xb
ffffffffc0200ed4:	cc050513          	addi	a0,a0,-832 # ffffffffc020bb90 <commands+0x508>
ffffffffc0200ed8:	aceff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200edc:	704c                	ld	a1,160(s0)
ffffffffc0200ede:	0000b517          	auipc	a0,0xb
ffffffffc0200ee2:	cca50513          	addi	a0,a0,-822 # ffffffffc020bba8 <commands+0x520>
ffffffffc0200ee6:	ac0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eea:	744c                	ld	a1,168(s0)
ffffffffc0200eec:	0000b517          	auipc	a0,0xb
ffffffffc0200ef0:	cd450513          	addi	a0,a0,-812 # ffffffffc020bbc0 <commands+0x538>
ffffffffc0200ef4:	ab2ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ef8:	784c                	ld	a1,176(s0)
ffffffffc0200efa:	0000b517          	auipc	a0,0xb
ffffffffc0200efe:	cde50513          	addi	a0,a0,-802 # ffffffffc020bbd8 <commands+0x550>
ffffffffc0200f02:	aa4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f06:	7c4c                	ld	a1,184(s0)
ffffffffc0200f08:	0000b517          	auipc	a0,0xb
ffffffffc0200f0c:	ce850513          	addi	a0,a0,-792 # ffffffffc020bbf0 <commands+0x568>
ffffffffc0200f10:	a96ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f14:	606c                	ld	a1,192(s0)
ffffffffc0200f16:	0000b517          	auipc	a0,0xb
ffffffffc0200f1a:	cf250513          	addi	a0,a0,-782 # ffffffffc020bc08 <commands+0x580>
ffffffffc0200f1e:	a88ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f22:	646c                	ld	a1,200(s0)
ffffffffc0200f24:	0000b517          	auipc	a0,0xb
ffffffffc0200f28:	cfc50513          	addi	a0,a0,-772 # ffffffffc020bc20 <commands+0x598>
ffffffffc0200f2c:	a7aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f30:	686c                	ld	a1,208(s0)
ffffffffc0200f32:	0000b517          	auipc	a0,0xb
ffffffffc0200f36:	d0650513          	addi	a0,a0,-762 # ffffffffc020bc38 <commands+0x5b0>
ffffffffc0200f3a:	a6cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f3e:	6c6c                	ld	a1,216(s0)
ffffffffc0200f40:	0000b517          	auipc	a0,0xb
ffffffffc0200f44:	d1050513          	addi	a0,a0,-752 # ffffffffc020bc50 <commands+0x5c8>
ffffffffc0200f48:	a5eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f4c:	706c                	ld	a1,224(s0)
ffffffffc0200f4e:	0000b517          	auipc	a0,0xb
ffffffffc0200f52:	d1a50513          	addi	a0,a0,-742 # ffffffffc020bc68 <commands+0x5e0>
ffffffffc0200f56:	a50ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f5a:	746c                	ld	a1,232(s0)
ffffffffc0200f5c:	0000b517          	auipc	a0,0xb
ffffffffc0200f60:	d2450513          	addi	a0,a0,-732 # ffffffffc020bc80 <commands+0x5f8>
ffffffffc0200f64:	a42ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f68:	786c                	ld	a1,240(s0)
ffffffffc0200f6a:	0000b517          	auipc	a0,0xb
ffffffffc0200f6e:	d2e50513          	addi	a0,a0,-722 # ffffffffc020bc98 <commands+0x610>
ffffffffc0200f72:	a34ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f76:	7c6c                	ld	a1,248(s0)
ffffffffc0200f78:	6402                	ld	s0,0(sp)
ffffffffc0200f7a:	60a2                	ld	ra,8(sp)
ffffffffc0200f7c:	0000b517          	auipc	a0,0xb
ffffffffc0200f80:	d3450513          	addi	a0,a0,-716 # ffffffffc020bcb0 <commands+0x628>
ffffffffc0200f84:	0141                	addi	sp,sp,16
ffffffffc0200f86:	a20ff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200f8a <print_trapframe>:
ffffffffc0200f8a:	1141                	addi	sp,sp,-16
ffffffffc0200f8c:	e022                	sd	s0,0(sp)
ffffffffc0200f8e:	85aa                	mv	a1,a0
ffffffffc0200f90:	842a                	mv	s0,a0
ffffffffc0200f92:	0000b517          	auipc	a0,0xb
ffffffffc0200f96:	d3650513          	addi	a0,a0,-714 # ffffffffc020bcc8 <commands+0x640>
ffffffffc0200f9a:	e406                	sd	ra,8(sp)
ffffffffc0200f9c:	a0aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fa0:	8522                	mv	a0,s0
ffffffffc0200fa2:	e1bff0ef          	jal	ra,ffffffffc0200dbc <print_regs>
ffffffffc0200fa6:	10043583          	ld	a1,256(s0)
ffffffffc0200faa:	0000b517          	auipc	a0,0xb
ffffffffc0200fae:	d3650513          	addi	a0,a0,-714 # ffffffffc020bce0 <commands+0x658>
ffffffffc0200fb2:	9f4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fb6:	10843583          	ld	a1,264(s0)
ffffffffc0200fba:	0000b517          	auipc	a0,0xb
ffffffffc0200fbe:	d3e50513          	addi	a0,a0,-706 # ffffffffc020bcf8 <commands+0x670>
ffffffffc0200fc2:	9e4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fc6:	11043583          	ld	a1,272(s0)
ffffffffc0200fca:	0000b517          	auipc	a0,0xb
ffffffffc0200fce:	d4650513          	addi	a0,a0,-698 # ffffffffc020bd10 <commands+0x688>
ffffffffc0200fd2:	9d4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fd6:	11843583          	ld	a1,280(s0)
ffffffffc0200fda:	6402                	ld	s0,0(sp)
ffffffffc0200fdc:	60a2                	ld	ra,8(sp)
ffffffffc0200fde:	0000b517          	auipc	a0,0xb
ffffffffc0200fe2:	d4250513          	addi	a0,a0,-702 # ffffffffc020bd20 <commands+0x698>
ffffffffc0200fe6:	0141                	addi	sp,sp,16
ffffffffc0200fe8:	9beff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200fec <interrupt_handler>:
ffffffffc0200fec:	11853783          	ld	a5,280(a0)
ffffffffc0200ff0:	472d                	li	a4,11
ffffffffc0200ff2:	0786                	slli	a5,a5,0x1
ffffffffc0200ff4:	8385                	srli	a5,a5,0x1
ffffffffc0200ff6:	06f76c63          	bltu	a4,a5,ffffffffc020106e <interrupt_handler+0x82>
ffffffffc0200ffa:	0000b717          	auipc	a4,0xb
ffffffffc0200ffe:	dde70713          	addi	a4,a4,-546 # ffffffffc020bdd8 <commands+0x750>
ffffffffc0201002:	078a                	slli	a5,a5,0x2
ffffffffc0201004:	97ba                	add	a5,a5,a4
ffffffffc0201006:	439c                	lw	a5,0(a5)
ffffffffc0201008:	97ba                	add	a5,a5,a4
ffffffffc020100a:	8782                	jr	a5
ffffffffc020100c:	0000b517          	auipc	a0,0xb
ffffffffc0201010:	d8c50513          	addi	a0,a0,-628 # ffffffffc020bd98 <commands+0x710>
ffffffffc0201014:	992ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201018:	0000b517          	auipc	a0,0xb
ffffffffc020101c:	d6050513          	addi	a0,a0,-672 # ffffffffc020bd78 <commands+0x6f0>
ffffffffc0201020:	986ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201024:	0000b517          	auipc	a0,0xb
ffffffffc0201028:	d1450513          	addi	a0,a0,-748 # ffffffffc020bd38 <commands+0x6b0>
ffffffffc020102c:	97aff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201030:	0000b517          	auipc	a0,0xb
ffffffffc0201034:	d2850513          	addi	a0,a0,-728 # ffffffffc020bd58 <commands+0x6d0>
ffffffffc0201038:	96eff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020103c:	1141                	addi	sp,sp,-16
ffffffffc020103e:	e406                	sd	ra,8(sp)
ffffffffc0201040:	d3aff0ef          	jal	ra,ffffffffc020057a <clock_set_next_event>
ffffffffc0201044:	00096717          	auipc	a4,0x96
ffffffffc0201048:	82c70713          	addi	a4,a4,-2004 # ffffffffc0296870 <ticks>
ffffffffc020104c:	631c                	ld	a5,0(a4)
ffffffffc020104e:	0785                	addi	a5,a5,1
ffffffffc0201050:	e31c                	sd	a5,0(a4)
ffffffffc0201052:	414060ef          	jal	ra,ffffffffc0207466 <run_timer_list>
ffffffffc0201056:	d9eff0ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc020105a:	60a2                	ld	ra,8(sp)
ffffffffc020105c:	0141                	addi	sp,sp,16
ffffffffc020105e:	2d90706f          	j	ffffffffc0208b36 <dev_stdin_write>
ffffffffc0201062:	0000b517          	auipc	a0,0xb
ffffffffc0201066:	d5650513          	addi	a0,a0,-682 # ffffffffc020bdb8 <commands+0x730>
ffffffffc020106a:	93cff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020106e:	bf31                	j	ffffffffc0200f8a <print_trapframe>

ffffffffc0201070 <exception_handler>:
ffffffffc0201070:	11853783          	ld	a5,280(a0)
ffffffffc0201074:	1141                	addi	sp,sp,-16
ffffffffc0201076:	e022                	sd	s0,0(sp)
ffffffffc0201078:	e406                	sd	ra,8(sp)
ffffffffc020107a:	473d                	li	a4,15
ffffffffc020107c:	842a                	mv	s0,a0
ffffffffc020107e:	0af76b63          	bltu	a4,a5,ffffffffc0201134 <exception_handler+0xc4>
ffffffffc0201082:	0000b717          	auipc	a4,0xb
ffffffffc0201086:	f1670713          	addi	a4,a4,-234 # ffffffffc020bf98 <commands+0x910>
ffffffffc020108a:	078a                	slli	a5,a5,0x2
ffffffffc020108c:	97ba                	add	a5,a5,a4
ffffffffc020108e:	439c                	lw	a5,0(a5)
ffffffffc0201090:	97ba                	add	a5,a5,a4
ffffffffc0201092:	8782                	jr	a5
ffffffffc0201094:	0000b517          	auipc	a0,0xb
ffffffffc0201098:	e5c50513          	addi	a0,a0,-420 # ffffffffc020bef0 <commands+0x868>
ffffffffc020109c:	90aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02010a0:	10843783          	ld	a5,264(s0)
ffffffffc02010a4:	60a2                	ld	ra,8(sp)
ffffffffc02010a6:	0791                	addi	a5,a5,4
ffffffffc02010a8:	10f43423          	sd	a5,264(s0)
ffffffffc02010ac:	6402                	ld	s0,0(sp)
ffffffffc02010ae:	0141                	addi	sp,sp,16
ffffffffc02010b0:	5cc0606f          	j	ffffffffc020767c <syscall>
ffffffffc02010b4:	0000b517          	auipc	a0,0xb
ffffffffc02010b8:	e5c50513          	addi	a0,a0,-420 # ffffffffc020bf10 <commands+0x888>
ffffffffc02010bc:	6402                	ld	s0,0(sp)
ffffffffc02010be:	60a2                	ld	ra,8(sp)
ffffffffc02010c0:	0141                	addi	sp,sp,16
ffffffffc02010c2:	8e4ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010c6:	0000b517          	auipc	a0,0xb
ffffffffc02010ca:	e6a50513          	addi	a0,a0,-406 # ffffffffc020bf30 <commands+0x8a8>
ffffffffc02010ce:	b7fd                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010d0:	0000b517          	auipc	a0,0xb
ffffffffc02010d4:	e8050513          	addi	a0,a0,-384 # ffffffffc020bf50 <commands+0x8c8>
ffffffffc02010d8:	b7d5                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010da:	0000b517          	auipc	a0,0xb
ffffffffc02010de:	e8e50513          	addi	a0,a0,-370 # ffffffffc020bf68 <commands+0x8e0>
ffffffffc02010e2:	bfe9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010e4:	0000b517          	auipc	a0,0xb
ffffffffc02010e8:	e9c50513          	addi	a0,a0,-356 # ffffffffc020bf80 <commands+0x8f8>
ffffffffc02010ec:	bfc1                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010ee:	0000b517          	auipc	a0,0xb
ffffffffc02010f2:	d1a50513          	addi	a0,a0,-742 # ffffffffc020be08 <commands+0x780>
ffffffffc02010f6:	b7d9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010f8:	0000b517          	auipc	a0,0xb
ffffffffc02010fc:	d3050513          	addi	a0,a0,-720 # ffffffffc020be28 <commands+0x7a0>
ffffffffc0201100:	bf75                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201102:	0000b517          	auipc	a0,0xb
ffffffffc0201106:	d4650513          	addi	a0,a0,-698 # ffffffffc020be48 <commands+0x7c0>
ffffffffc020110a:	bf4d                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020110c:	0000b517          	auipc	a0,0xb
ffffffffc0201110:	d5450513          	addi	a0,a0,-684 # ffffffffc020be60 <commands+0x7d8>
ffffffffc0201114:	b765                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201116:	0000b517          	auipc	a0,0xb
ffffffffc020111a:	d5a50513          	addi	a0,a0,-678 # ffffffffc020be70 <commands+0x7e8>
ffffffffc020111e:	bf79                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201120:	0000b517          	auipc	a0,0xb
ffffffffc0201124:	d7050513          	addi	a0,a0,-656 # ffffffffc020be90 <commands+0x808>
ffffffffc0201128:	bf51                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020112a:	0000b517          	auipc	a0,0xb
ffffffffc020112e:	dae50513          	addi	a0,a0,-594 # ffffffffc020bed8 <commands+0x850>
ffffffffc0201132:	b769                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201134:	8522                	mv	a0,s0
ffffffffc0201136:	6402                	ld	s0,0(sp)
ffffffffc0201138:	60a2                	ld	ra,8(sp)
ffffffffc020113a:	0141                	addi	sp,sp,16
ffffffffc020113c:	b5b9                	j	ffffffffc0200f8a <print_trapframe>
ffffffffc020113e:	0000b617          	auipc	a2,0xb
ffffffffc0201142:	d6a60613          	addi	a2,a2,-662 # ffffffffc020bea8 <commands+0x820>
ffffffffc0201146:	0b100593          	li	a1,177
ffffffffc020114a:	0000b517          	auipc	a0,0xb
ffffffffc020114e:	d7650513          	addi	a0,a0,-650 # ffffffffc020bec0 <commands+0x838>
ffffffffc0201152:	b4cff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201156 <trap>:
ffffffffc0201156:	1101                	addi	sp,sp,-32
ffffffffc0201158:	e822                	sd	s0,16(sp)
ffffffffc020115a:	00095417          	auipc	s0,0x95
ffffffffc020115e:	76640413          	addi	s0,s0,1894 # ffffffffc02968c0 <current>
ffffffffc0201162:	6018                	ld	a4,0(s0)
ffffffffc0201164:	ec06                	sd	ra,24(sp)
ffffffffc0201166:	e426                	sd	s1,8(sp)
ffffffffc0201168:	e04a                	sd	s2,0(sp)
ffffffffc020116a:	11853683          	ld	a3,280(a0)
ffffffffc020116e:	cf1d                	beqz	a4,ffffffffc02011ac <trap+0x56>
ffffffffc0201170:	10053483          	ld	s1,256(a0)
ffffffffc0201174:	0a073903          	ld	s2,160(a4)
ffffffffc0201178:	f348                	sd	a0,160(a4)
ffffffffc020117a:	1004f493          	andi	s1,s1,256
ffffffffc020117e:	0206c463          	bltz	a3,ffffffffc02011a6 <trap+0x50>
ffffffffc0201182:	eefff0ef          	jal	ra,ffffffffc0201070 <exception_handler>
ffffffffc0201186:	601c                	ld	a5,0(s0)
ffffffffc0201188:	0b27b023          	sd	s2,160(a5) # 400a0 <_binary_bin_swap_img_size+0x383a0>
ffffffffc020118c:	e499                	bnez	s1,ffffffffc020119a <trap+0x44>
ffffffffc020118e:	0b07a703          	lw	a4,176(a5)
ffffffffc0201192:	8b05                	andi	a4,a4,1
ffffffffc0201194:	e329                	bnez	a4,ffffffffc02011d6 <trap+0x80>
ffffffffc0201196:	6f9c                	ld	a5,24(a5)
ffffffffc0201198:	eb85                	bnez	a5,ffffffffc02011c8 <trap+0x72>
ffffffffc020119a:	60e2                	ld	ra,24(sp)
ffffffffc020119c:	6442                	ld	s0,16(sp)
ffffffffc020119e:	64a2                	ld	s1,8(sp)
ffffffffc02011a0:	6902                	ld	s2,0(sp)
ffffffffc02011a2:	6105                	addi	sp,sp,32
ffffffffc02011a4:	8082                	ret
ffffffffc02011a6:	e47ff0ef          	jal	ra,ffffffffc0200fec <interrupt_handler>
ffffffffc02011aa:	bff1                	j	ffffffffc0201186 <trap+0x30>
ffffffffc02011ac:	0006c863          	bltz	a3,ffffffffc02011bc <trap+0x66>
ffffffffc02011b0:	6442                	ld	s0,16(sp)
ffffffffc02011b2:	60e2                	ld	ra,24(sp)
ffffffffc02011b4:	64a2                	ld	s1,8(sp)
ffffffffc02011b6:	6902                	ld	s2,0(sp)
ffffffffc02011b8:	6105                	addi	sp,sp,32
ffffffffc02011ba:	bd5d                	j	ffffffffc0201070 <exception_handler>
ffffffffc02011bc:	6442                	ld	s0,16(sp)
ffffffffc02011be:	60e2                	ld	ra,24(sp)
ffffffffc02011c0:	64a2                	ld	s1,8(sp)
ffffffffc02011c2:	6902                	ld	s2,0(sp)
ffffffffc02011c4:	6105                	addi	sp,sp,32
ffffffffc02011c6:	b51d                	j	ffffffffc0200fec <interrupt_handler>
ffffffffc02011c8:	6442                	ld	s0,16(sp)
ffffffffc02011ca:	60e2                	ld	ra,24(sp)
ffffffffc02011cc:	64a2                	ld	s1,8(sp)
ffffffffc02011ce:	6902                	ld	s2,0(sp)
ffffffffc02011d0:	6105                	addi	sp,sp,32
ffffffffc02011d2:	0880606f          	j	ffffffffc020725a <schedule>
ffffffffc02011d6:	555d                	li	a0,-9
ffffffffc02011d8:	63f040ef          	jal	ra,ffffffffc0206016 <do_exit>
ffffffffc02011dc:	601c                	ld	a5,0(s0)
ffffffffc02011de:	bf65                	j	ffffffffc0201196 <trap+0x40>

ffffffffc02011e0 <__alltraps>:
ffffffffc02011e0:	14011173          	csrrw	sp,sscratch,sp
ffffffffc02011e4:	00011463          	bnez	sp,ffffffffc02011ec <__alltraps+0xc>
ffffffffc02011e8:	14002173          	csrr	sp,sscratch
ffffffffc02011ec:	712d                	addi	sp,sp,-288
ffffffffc02011ee:	e002                	sd	zero,0(sp)
ffffffffc02011f0:	e406                	sd	ra,8(sp)
ffffffffc02011f2:	ec0e                	sd	gp,24(sp)
ffffffffc02011f4:	f012                	sd	tp,32(sp)
ffffffffc02011f6:	f416                	sd	t0,40(sp)
ffffffffc02011f8:	f81a                	sd	t1,48(sp)
ffffffffc02011fa:	fc1e                	sd	t2,56(sp)
ffffffffc02011fc:	e0a2                	sd	s0,64(sp)
ffffffffc02011fe:	e4a6                	sd	s1,72(sp)
ffffffffc0201200:	e8aa                	sd	a0,80(sp)
ffffffffc0201202:	ecae                	sd	a1,88(sp)
ffffffffc0201204:	f0b2                	sd	a2,96(sp)
ffffffffc0201206:	f4b6                	sd	a3,104(sp)
ffffffffc0201208:	f8ba                	sd	a4,112(sp)
ffffffffc020120a:	fcbe                	sd	a5,120(sp)
ffffffffc020120c:	e142                	sd	a6,128(sp)
ffffffffc020120e:	e546                	sd	a7,136(sp)
ffffffffc0201210:	e94a                	sd	s2,144(sp)
ffffffffc0201212:	ed4e                	sd	s3,152(sp)
ffffffffc0201214:	f152                	sd	s4,160(sp)
ffffffffc0201216:	f556                	sd	s5,168(sp)
ffffffffc0201218:	f95a                	sd	s6,176(sp)
ffffffffc020121a:	fd5e                	sd	s7,184(sp)
ffffffffc020121c:	e1e2                	sd	s8,192(sp)
ffffffffc020121e:	e5e6                	sd	s9,200(sp)
ffffffffc0201220:	e9ea                	sd	s10,208(sp)
ffffffffc0201222:	edee                	sd	s11,216(sp)
ffffffffc0201224:	f1f2                	sd	t3,224(sp)
ffffffffc0201226:	f5f6                	sd	t4,232(sp)
ffffffffc0201228:	f9fa                	sd	t5,240(sp)
ffffffffc020122a:	fdfe                	sd	t6,248(sp)
ffffffffc020122c:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0201230:	100024f3          	csrr	s1,sstatus
ffffffffc0201234:	14102973          	csrr	s2,sepc
ffffffffc0201238:	143029f3          	csrr	s3,stval
ffffffffc020123c:	14202a73          	csrr	s4,scause
ffffffffc0201240:	e822                	sd	s0,16(sp)
ffffffffc0201242:	e226                	sd	s1,256(sp)
ffffffffc0201244:	e64a                	sd	s2,264(sp)
ffffffffc0201246:	ea4e                	sd	s3,272(sp)
ffffffffc0201248:	ee52                	sd	s4,280(sp)
ffffffffc020124a:	850a                	mv	a0,sp
ffffffffc020124c:	f0bff0ef          	jal	ra,ffffffffc0201156 <trap>

ffffffffc0201250 <__trapret>:
ffffffffc0201250:	6492                	ld	s1,256(sp)
ffffffffc0201252:	6932                	ld	s2,264(sp)
ffffffffc0201254:	1004f413          	andi	s0,s1,256
ffffffffc0201258:	e401                	bnez	s0,ffffffffc0201260 <__trapret+0x10>
ffffffffc020125a:	1200                	addi	s0,sp,288
ffffffffc020125c:	14041073          	csrw	sscratch,s0
ffffffffc0201260:	10049073          	csrw	sstatus,s1
ffffffffc0201264:	14191073          	csrw	sepc,s2
ffffffffc0201268:	60a2                	ld	ra,8(sp)
ffffffffc020126a:	61e2                	ld	gp,24(sp)
ffffffffc020126c:	7202                	ld	tp,32(sp)
ffffffffc020126e:	72a2                	ld	t0,40(sp)
ffffffffc0201270:	7342                	ld	t1,48(sp)
ffffffffc0201272:	73e2                	ld	t2,56(sp)
ffffffffc0201274:	6406                	ld	s0,64(sp)
ffffffffc0201276:	64a6                	ld	s1,72(sp)
ffffffffc0201278:	6546                	ld	a0,80(sp)
ffffffffc020127a:	65e6                	ld	a1,88(sp)
ffffffffc020127c:	7606                	ld	a2,96(sp)
ffffffffc020127e:	76a6                	ld	a3,104(sp)
ffffffffc0201280:	7746                	ld	a4,112(sp)
ffffffffc0201282:	77e6                	ld	a5,120(sp)
ffffffffc0201284:	680a                	ld	a6,128(sp)
ffffffffc0201286:	68aa                	ld	a7,136(sp)
ffffffffc0201288:	694a                	ld	s2,144(sp)
ffffffffc020128a:	69ea                	ld	s3,152(sp)
ffffffffc020128c:	7a0a                	ld	s4,160(sp)
ffffffffc020128e:	7aaa                	ld	s5,168(sp)
ffffffffc0201290:	7b4a                	ld	s6,176(sp)
ffffffffc0201292:	7bea                	ld	s7,184(sp)
ffffffffc0201294:	6c0e                	ld	s8,192(sp)
ffffffffc0201296:	6cae                	ld	s9,200(sp)
ffffffffc0201298:	6d4e                	ld	s10,208(sp)
ffffffffc020129a:	6dee                	ld	s11,216(sp)
ffffffffc020129c:	7e0e                	ld	t3,224(sp)
ffffffffc020129e:	7eae                	ld	t4,232(sp)
ffffffffc02012a0:	7f4e                	ld	t5,240(sp)
ffffffffc02012a2:	7fee                	ld	t6,248(sp)
ffffffffc02012a4:	6142                	ld	sp,16(sp)
ffffffffc02012a6:	10200073          	sret

ffffffffc02012aa <forkrets>:
ffffffffc02012aa:	812a                	mv	sp,a0
ffffffffc02012ac:	b755                	j	ffffffffc0201250 <__trapret>

ffffffffc02012ae <default_init>:
ffffffffc02012ae:	00090797          	auipc	a5,0x90
ffffffffc02012b2:	4fa78793          	addi	a5,a5,1274 # ffffffffc02917a8 <free_area>
ffffffffc02012b6:	e79c                	sd	a5,8(a5)
ffffffffc02012b8:	e39c                	sd	a5,0(a5)
ffffffffc02012ba:	0007a823          	sw	zero,16(a5)
ffffffffc02012be:	8082                	ret

ffffffffc02012c0 <default_nr_free_pages>:
ffffffffc02012c0:	00090517          	auipc	a0,0x90
ffffffffc02012c4:	4f856503          	lwu	a0,1272(a0) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02012c8:	8082                	ret

ffffffffc02012ca <default_check>:
ffffffffc02012ca:	715d                	addi	sp,sp,-80
ffffffffc02012cc:	e0a2                	sd	s0,64(sp)
ffffffffc02012ce:	00090417          	auipc	s0,0x90
ffffffffc02012d2:	4da40413          	addi	s0,s0,1242 # ffffffffc02917a8 <free_area>
ffffffffc02012d6:	641c                	ld	a5,8(s0)
ffffffffc02012d8:	e486                	sd	ra,72(sp)
ffffffffc02012da:	fc26                	sd	s1,56(sp)
ffffffffc02012dc:	f84a                	sd	s2,48(sp)
ffffffffc02012de:	f44e                	sd	s3,40(sp)
ffffffffc02012e0:	f052                	sd	s4,32(sp)
ffffffffc02012e2:	ec56                	sd	s5,24(sp)
ffffffffc02012e4:	e85a                	sd	s6,16(sp)
ffffffffc02012e6:	e45e                	sd	s7,8(sp)
ffffffffc02012e8:	e062                	sd	s8,0(sp)
ffffffffc02012ea:	2a878d63          	beq	a5,s0,ffffffffc02015a4 <default_check+0x2da>
ffffffffc02012ee:	4481                	li	s1,0
ffffffffc02012f0:	4901                	li	s2,0
ffffffffc02012f2:	ff07b703          	ld	a4,-16(a5)
ffffffffc02012f6:	8b09                	andi	a4,a4,2
ffffffffc02012f8:	2a070a63          	beqz	a4,ffffffffc02015ac <default_check+0x2e2>
ffffffffc02012fc:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201300:	679c                	ld	a5,8(a5)
ffffffffc0201302:	2905                	addiw	s2,s2,1
ffffffffc0201304:	9cb9                	addw	s1,s1,a4
ffffffffc0201306:	fe8796e3          	bne	a5,s0,ffffffffc02012f2 <default_check+0x28>
ffffffffc020130a:	89a6                	mv	s3,s1
ffffffffc020130c:	6df000ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0201310:	6f351e63          	bne	a0,s3,ffffffffc0201a0c <default_check+0x742>
ffffffffc0201314:	4505                	li	a0,1
ffffffffc0201316:	657000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020131a:	8aaa                	mv	s5,a0
ffffffffc020131c:	42050863          	beqz	a0,ffffffffc020174c <default_check+0x482>
ffffffffc0201320:	4505                	li	a0,1
ffffffffc0201322:	64b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201326:	89aa                	mv	s3,a0
ffffffffc0201328:	70050263          	beqz	a0,ffffffffc0201a2c <default_check+0x762>
ffffffffc020132c:	4505                	li	a0,1
ffffffffc020132e:	63f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201332:	8a2a                	mv	s4,a0
ffffffffc0201334:	48050c63          	beqz	a0,ffffffffc02017cc <default_check+0x502>
ffffffffc0201338:	293a8a63          	beq	s5,s3,ffffffffc02015cc <default_check+0x302>
ffffffffc020133c:	28aa8863          	beq	s5,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201340:	28a98663          	beq	s3,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201344:	000aa783          	lw	a5,0(s5)
ffffffffc0201348:	2a079263          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020134c:	0009a783          	lw	a5,0(s3)
ffffffffc0201350:	28079e63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc0201354:	411c                	lw	a5,0(a0)
ffffffffc0201356:	28079b63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020135a:	00095797          	auipc	a5,0x95
ffffffffc020135e:	54e7b783          	ld	a5,1358(a5) # ffffffffc02968a8 <pages>
ffffffffc0201362:	40fa8733          	sub	a4,s5,a5
ffffffffc0201366:	0000e617          	auipc	a2,0xe
ffffffffc020136a:	31a63603          	ld	a2,794(a2) # ffffffffc020f680 <nbase>
ffffffffc020136e:	8719                	srai	a4,a4,0x6
ffffffffc0201370:	9732                	add	a4,a4,a2
ffffffffc0201372:	00095697          	auipc	a3,0x95
ffffffffc0201376:	52e6b683          	ld	a3,1326(a3) # ffffffffc02968a0 <npage>
ffffffffc020137a:	06b2                	slli	a3,a3,0xc
ffffffffc020137c:	0732                	slli	a4,a4,0xc
ffffffffc020137e:	28d77763          	bgeu	a4,a3,ffffffffc020160c <default_check+0x342>
ffffffffc0201382:	40f98733          	sub	a4,s3,a5
ffffffffc0201386:	8719                	srai	a4,a4,0x6
ffffffffc0201388:	9732                	add	a4,a4,a2
ffffffffc020138a:	0732                	slli	a4,a4,0xc
ffffffffc020138c:	4cd77063          	bgeu	a4,a3,ffffffffc020184c <default_check+0x582>
ffffffffc0201390:	40f507b3          	sub	a5,a0,a5
ffffffffc0201394:	8799                	srai	a5,a5,0x6
ffffffffc0201396:	97b2                	add	a5,a5,a2
ffffffffc0201398:	07b2                	slli	a5,a5,0xc
ffffffffc020139a:	30d7f963          	bgeu	a5,a3,ffffffffc02016ac <default_check+0x3e2>
ffffffffc020139e:	4505                	li	a0,1
ffffffffc02013a0:	00043c03          	ld	s8,0(s0)
ffffffffc02013a4:	00843b83          	ld	s7,8(s0)
ffffffffc02013a8:	01042b03          	lw	s6,16(s0)
ffffffffc02013ac:	e400                	sd	s0,8(s0)
ffffffffc02013ae:	e000                	sd	s0,0(s0)
ffffffffc02013b0:	00090797          	auipc	a5,0x90
ffffffffc02013b4:	4007a423          	sw	zero,1032(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02013b8:	5b5000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013bc:	2c051863          	bnez	a0,ffffffffc020168c <default_check+0x3c2>
ffffffffc02013c0:	4585                	li	a1,1
ffffffffc02013c2:	8556                	mv	a0,s5
ffffffffc02013c4:	5e7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013c8:	4585                	li	a1,1
ffffffffc02013ca:	854e                	mv	a0,s3
ffffffffc02013cc:	5df000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d0:	4585                	li	a1,1
ffffffffc02013d2:	8552                	mv	a0,s4
ffffffffc02013d4:	5d7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d8:	4818                	lw	a4,16(s0)
ffffffffc02013da:	478d                	li	a5,3
ffffffffc02013dc:	28f71863          	bne	a4,a5,ffffffffc020166c <default_check+0x3a2>
ffffffffc02013e0:	4505                	li	a0,1
ffffffffc02013e2:	58b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013e6:	89aa                	mv	s3,a0
ffffffffc02013e8:	26050263          	beqz	a0,ffffffffc020164c <default_check+0x382>
ffffffffc02013ec:	4505                	li	a0,1
ffffffffc02013ee:	57f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013f2:	8aaa                	mv	s5,a0
ffffffffc02013f4:	3a050c63          	beqz	a0,ffffffffc02017ac <default_check+0x4e2>
ffffffffc02013f8:	4505                	li	a0,1
ffffffffc02013fa:	573000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013fe:	8a2a                	mv	s4,a0
ffffffffc0201400:	38050663          	beqz	a0,ffffffffc020178c <default_check+0x4c2>
ffffffffc0201404:	4505                	li	a0,1
ffffffffc0201406:	567000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020140a:	36051163          	bnez	a0,ffffffffc020176c <default_check+0x4a2>
ffffffffc020140e:	4585                	li	a1,1
ffffffffc0201410:	854e                	mv	a0,s3
ffffffffc0201412:	599000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201416:	641c                	ld	a5,8(s0)
ffffffffc0201418:	20878a63          	beq	a5,s0,ffffffffc020162c <default_check+0x362>
ffffffffc020141c:	4505                	li	a0,1
ffffffffc020141e:	54f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201422:	30a99563          	bne	s3,a0,ffffffffc020172c <default_check+0x462>
ffffffffc0201426:	4505                	li	a0,1
ffffffffc0201428:	545000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020142c:	2e051063          	bnez	a0,ffffffffc020170c <default_check+0x442>
ffffffffc0201430:	481c                	lw	a5,16(s0)
ffffffffc0201432:	2a079d63          	bnez	a5,ffffffffc02016ec <default_check+0x422>
ffffffffc0201436:	854e                	mv	a0,s3
ffffffffc0201438:	4585                	li	a1,1
ffffffffc020143a:	01843023          	sd	s8,0(s0)
ffffffffc020143e:	01743423          	sd	s7,8(s0)
ffffffffc0201442:	01642823          	sw	s6,16(s0)
ffffffffc0201446:	565000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020144a:	4585                	li	a1,1
ffffffffc020144c:	8556                	mv	a0,s5
ffffffffc020144e:	55d000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201452:	4585                	li	a1,1
ffffffffc0201454:	8552                	mv	a0,s4
ffffffffc0201456:	555000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020145a:	4515                	li	a0,5
ffffffffc020145c:	511000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201460:	89aa                	mv	s3,a0
ffffffffc0201462:	26050563          	beqz	a0,ffffffffc02016cc <default_check+0x402>
ffffffffc0201466:	651c                	ld	a5,8(a0)
ffffffffc0201468:	8385                	srli	a5,a5,0x1
ffffffffc020146a:	8b85                	andi	a5,a5,1
ffffffffc020146c:	54079063          	bnez	a5,ffffffffc02019ac <default_check+0x6e2>
ffffffffc0201470:	4505                	li	a0,1
ffffffffc0201472:	00043b03          	ld	s6,0(s0)
ffffffffc0201476:	00843a83          	ld	s5,8(s0)
ffffffffc020147a:	e000                	sd	s0,0(s0)
ffffffffc020147c:	e400                	sd	s0,8(s0)
ffffffffc020147e:	4ef000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201482:	50051563          	bnez	a0,ffffffffc020198c <default_check+0x6c2>
ffffffffc0201486:	08098a13          	addi	s4,s3,128
ffffffffc020148a:	8552                	mv	a0,s4
ffffffffc020148c:	458d                	li	a1,3
ffffffffc020148e:	01042b83          	lw	s7,16(s0)
ffffffffc0201492:	00090797          	auipc	a5,0x90
ffffffffc0201496:	3207a323          	sw	zero,806(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc020149a:	511000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020149e:	4511                	li	a0,4
ffffffffc02014a0:	4cd000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014a4:	4c051463          	bnez	a0,ffffffffc020196c <default_check+0x6a2>
ffffffffc02014a8:	0889b783          	ld	a5,136(s3)
ffffffffc02014ac:	8385                	srli	a5,a5,0x1
ffffffffc02014ae:	8b85                	andi	a5,a5,1
ffffffffc02014b0:	48078e63          	beqz	a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014b4:	0909a703          	lw	a4,144(s3)
ffffffffc02014b8:	478d                	li	a5,3
ffffffffc02014ba:	48f71963          	bne	a4,a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014be:	450d                	li	a0,3
ffffffffc02014c0:	4ad000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014c4:	8c2a                	mv	s8,a0
ffffffffc02014c6:	46050363          	beqz	a0,ffffffffc020192c <default_check+0x662>
ffffffffc02014ca:	4505                	li	a0,1
ffffffffc02014cc:	4a1000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014d0:	42051e63          	bnez	a0,ffffffffc020190c <default_check+0x642>
ffffffffc02014d4:	418a1c63          	bne	s4,s8,ffffffffc02018ec <default_check+0x622>
ffffffffc02014d8:	4585                	li	a1,1
ffffffffc02014da:	854e                	mv	a0,s3
ffffffffc02014dc:	4cf000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e0:	458d                	li	a1,3
ffffffffc02014e2:	8552                	mv	a0,s4
ffffffffc02014e4:	4c7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e8:	0089b783          	ld	a5,8(s3)
ffffffffc02014ec:	04098c13          	addi	s8,s3,64
ffffffffc02014f0:	8385                	srli	a5,a5,0x1
ffffffffc02014f2:	8b85                	andi	a5,a5,1
ffffffffc02014f4:	3c078c63          	beqz	a5,ffffffffc02018cc <default_check+0x602>
ffffffffc02014f8:	0109a703          	lw	a4,16(s3)
ffffffffc02014fc:	4785                	li	a5,1
ffffffffc02014fe:	3cf71763          	bne	a4,a5,ffffffffc02018cc <default_check+0x602>
ffffffffc0201502:	008a3783          	ld	a5,8(s4)
ffffffffc0201506:	8385                	srli	a5,a5,0x1
ffffffffc0201508:	8b85                	andi	a5,a5,1
ffffffffc020150a:	3a078163          	beqz	a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc020150e:	010a2703          	lw	a4,16(s4)
ffffffffc0201512:	478d                	li	a5,3
ffffffffc0201514:	38f71c63          	bne	a4,a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc0201518:	4505                	li	a0,1
ffffffffc020151a:	453000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020151e:	36a99763          	bne	s3,a0,ffffffffc020188c <default_check+0x5c2>
ffffffffc0201522:	4585                	li	a1,1
ffffffffc0201524:	487000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201528:	4509                	li	a0,2
ffffffffc020152a:	443000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020152e:	32aa1f63          	bne	s4,a0,ffffffffc020186c <default_check+0x5a2>
ffffffffc0201532:	4589                	li	a1,2
ffffffffc0201534:	477000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201538:	4585                	li	a1,1
ffffffffc020153a:	8562                	mv	a0,s8
ffffffffc020153c:	46f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201540:	4515                	li	a0,5
ffffffffc0201542:	42b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201546:	89aa                	mv	s3,a0
ffffffffc0201548:	48050263          	beqz	a0,ffffffffc02019cc <default_check+0x702>
ffffffffc020154c:	4505                	li	a0,1
ffffffffc020154e:	41f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201552:	2c051d63          	bnez	a0,ffffffffc020182c <default_check+0x562>
ffffffffc0201556:	481c                	lw	a5,16(s0)
ffffffffc0201558:	2a079a63          	bnez	a5,ffffffffc020180c <default_check+0x542>
ffffffffc020155c:	4595                	li	a1,5
ffffffffc020155e:	854e                	mv	a0,s3
ffffffffc0201560:	01742823          	sw	s7,16(s0)
ffffffffc0201564:	01643023          	sd	s6,0(s0)
ffffffffc0201568:	01543423          	sd	s5,8(s0)
ffffffffc020156c:	43f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201570:	641c                	ld	a5,8(s0)
ffffffffc0201572:	00878963          	beq	a5,s0,ffffffffc0201584 <default_check+0x2ba>
ffffffffc0201576:	ff87a703          	lw	a4,-8(a5)
ffffffffc020157a:	679c                	ld	a5,8(a5)
ffffffffc020157c:	397d                	addiw	s2,s2,-1
ffffffffc020157e:	9c99                	subw	s1,s1,a4
ffffffffc0201580:	fe879be3          	bne	a5,s0,ffffffffc0201576 <default_check+0x2ac>
ffffffffc0201584:	26091463          	bnez	s2,ffffffffc02017ec <default_check+0x522>
ffffffffc0201588:	46049263          	bnez	s1,ffffffffc02019ec <default_check+0x722>
ffffffffc020158c:	60a6                	ld	ra,72(sp)
ffffffffc020158e:	6406                	ld	s0,64(sp)
ffffffffc0201590:	74e2                	ld	s1,56(sp)
ffffffffc0201592:	7942                	ld	s2,48(sp)
ffffffffc0201594:	79a2                	ld	s3,40(sp)
ffffffffc0201596:	7a02                	ld	s4,32(sp)
ffffffffc0201598:	6ae2                	ld	s5,24(sp)
ffffffffc020159a:	6b42                	ld	s6,16(sp)
ffffffffc020159c:	6ba2                	ld	s7,8(sp)
ffffffffc020159e:	6c02                	ld	s8,0(sp)
ffffffffc02015a0:	6161                	addi	sp,sp,80
ffffffffc02015a2:	8082                	ret
ffffffffc02015a4:	4981                	li	s3,0
ffffffffc02015a6:	4481                	li	s1,0
ffffffffc02015a8:	4901                	li	s2,0
ffffffffc02015aa:	b38d                	j	ffffffffc020130c <default_check+0x42>
ffffffffc02015ac:	0000b697          	auipc	a3,0xb
ffffffffc02015b0:	a2c68693          	addi	a3,a3,-1492 # ffffffffc020bfd8 <commands+0x950>
ffffffffc02015b4:	0000a617          	auipc	a2,0xa
ffffffffc02015b8:	2e460613          	addi	a2,a2,740 # ffffffffc020b898 <commands+0x210>
ffffffffc02015bc:	0ef00593          	li	a1,239
ffffffffc02015c0:	0000b517          	auipc	a0,0xb
ffffffffc02015c4:	a2850513          	addi	a0,a0,-1496 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02015c8:	ed7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015cc:	0000b697          	auipc	a3,0xb
ffffffffc02015d0:	ab468693          	addi	a3,a3,-1356 # ffffffffc020c080 <commands+0x9f8>
ffffffffc02015d4:	0000a617          	auipc	a2,0xa
ffffffffc02015d8:	2c460613          	addi	a2,a2,708 # ffffffffc020b898 <commands+0x210>
ffffffffc02015dc:	0bc00593          	li	a1,188
ffffffffc02015e0:	0000b517          	auipc	a0,0xb
ffffffffc02015e4:	a0850513          	addi	a0,a0,-1528 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02015e8:	eb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015ec:	0000b697          	auipc	a3,0xb
ffffffffc02015f0:	abc68693          	addi	a3,a3,-1348 # ffffffffc020c0a8 <commands+0xa20>
ffffffffc02015f4:	0000a617          	auipc	a2,0xa
ffffffffc02015f8:	2a460613          	addi	a2,a2,676 # ffffffffc020b898 <commands+0x210>
ffffffffc02015fc:	0bd00593          	li	a1,189
ffffffffc0201600:	0000b517          	auipc	a0,0xb
ffffffffc0201604:	9e850513          	addi	a0,a0,-1560 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201608:	e97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020160c:	0000b697          	auipc	a3,0xb
ffffffffc0201610:	adc68693          	addi	a3,a3,-1316 # ffffffffc020c0e8 <commands+0xa60>
ffffffffc0201614:	0000a617          	auipc	a2,0xa
ffffffffc0201618:	28460613          	addi	a2,a2,644 # ffffffffc020b898 <commands+0x210>
ffffffffc020161c:	0bf00593          	li	a1,191
ffffffffc0201620:	0000b517          	auipc	a0,0xb
ffffffffc0201624:	9c850513          	addi	a0,a0,-1592 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201628:	e77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020162c:	0000b697          	auipc	a3,0xb
ffffffffc0201630:	b4468693          	addi	a3,a3,-1212 # ffffffffc020c170 <commands+0xae8>
ffffffffc0201634:	0000a617          	auipc	a2,0xa
ffffffffc0201638:	26460613          	addi	a2,a2,612 # ffffffffc020b898 <commands+0x210>
ffffffffc020163c:	0d800593          	li	a1,216
ffffffffc0201640:	0000b517          	auipc	a0,0xb
ffffffffc0201644:	9a850513          	addi	a0,a0,-1624 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201648:	e57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020164c:	0000b697          	auipc	a3,0xb
ffffffffc0201650:	9d468693          	addi	a3,a3,-1580 # ffffffffc020c020 <commands+0x998>
ffffffffc0201654:	0000a617          	auipc	a2,0xa
ffffffffc0201658:	24460613          	addi	a2,a2,580 # ffffffffc020b898 <commands+0x210>
ffffffffc020165c:	0d100593          	li	a1,209
ffffffffc0201660:	0000b517          	auipc	a0,0xb
ffffffffc0201664:	98850513          	addi	a0,a0,-1656 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201668:	e37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020166c:	0000b697          	auipc	a3,0xb
ffffffffc0201670:	af468693          	addi	a3,a3,-1292 # ffffffffc020c160 <commands+0xad8>
ffffffffc0201674:	0000a617          	auipc	a2,0xa
ffffffffc0201678:	22460613          	addi	a2,a2,548 # ffffffffc020b898 <commands+0x210>
ffffffffc020167c:	0cf00593          	li	a1,207
ffffffffc0201680:	0000b517          	auipc	a0,0xb
ffffffffc0201684:	96850513          	addi	a0,a0,-1688 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201688:	e17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020168c:	0000b697          	auipc	a3,0xb
ffffffffc0201690:	abc68693          	addi	a3,a3,-1348 # ffffffffc020c148 <commands+0xac0>
ffffffffc0201694:	0000a617          	auipc	a2,0xa
ffffffffc0201698:	20460613          	addi	a2,a2,516 # ffffffffc020b898 <commands+0x210>
ffffffffc020169c:	0ca00593          	li	a1,202
ffffffffc02016a0:	0000b517          	auipc	a0,0xb
ffffffffc02016a4:	94850513          	addi	a0,a0,-1720 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02016a8:	df7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ac:	0000b697          	auipc	a3,0xb
ffffffffc02016b0:	a7c68693          	addi	a3,a3,-1412 # ffffffffc020c128 <commands+0xaa0>
ffffffffc02016b4:	0000a617          	auipc	a2,0xa
ffffffffc02016b8:	1e460613          	addi	a2,a2,484 # ffffffffc020b898 <commands+0x210>
ffffffffc02016bc:	0c100593          	li	a1,193
ffffffffc02016c0:	0000b517          	auipc	a0,0xb
ffffffffc02016c4:	92850513          	addi	a0,a0,-1752 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02016c8:	dd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016cc:	0000b697          	auipc	a3,0xb
ffffffffc02016d0:	aec68693          	addi	a3,a3,-1300 # ffffffffc020c1b8 <commands+0xb30>
ffffffffc02016d4:	0000a617          	auipc	a2,0xa
ffffffffc02016d8:	1c460613          	addi	a2,a2,452 # ffffffffc020b898 <commands+0x210>
ffffffffc02016dc:	0f700593          	li	a1,247
ffffffffc02016e0:	0000b517          	auipc	a0,0xb
ffffffffc02016e4:	90850513          	addi	a0,a0,-1784 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02016e8:	db7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ec:	0000b697          	auipc	a3,0xb
ffffffffc02016f0:	abc68693          	addi	a3,a3,-1348 # ffffffffc020c1a8 <commands+0xb20>
ffffffffc02016f4:	0000a617          	auipc	a2,0xa
ffffffffc02016f8:	1a460613          	addi	a2,a2,420 # ffffffffc020b898 <commands+0x210>
ffffffffc02016fc:	0de00593          	li	a1,222
ffffffffc0201700:	0000b517          	auipc	a0,0xb
ffffffffc0201704:	8e850513          	addi	a0,a0,-1816 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201708:	d97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020170c:	0000b697          	auipc	a3,0xb
ffffffffc0201710:	a3c68693          	addi	a3,a3,-1476 # ffffffffc020c148 <commands+0xac0>
ffffffffc0201714:	0000a617          	auipc	a2,0xa
ffffffffc0201718:	18460613          	addi	a2,a2,388 # ffffffffc020b898 <commands+0x210>
ffffffffc020171c:	0dc00593          	li	a1,220
ffffffffc0201720:	0000b517          	auipc	a0,0xb
ffffffffc0201724:	8c850513          	addi	a0,a0,-1848 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201728:	d77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020172c:	0000b697          	auipc	a3,0xb
ffffffffc0201730:	a5c68693          	addi	a3,a3,-1444 # ffffffffc020c188 <commands+0xb00>
ffffffffc0201734:	0000a617          	auipc	a2,0xa
ffffffffc0201738:	16460613          	addi	a2,a2,356 # ffffffffc020b898 <commands+0x210>
ffffffffc020173c:	0db00593          	li	a1,219
ffffffffc0201740:	0000b517          	auipc	a0,0xb
ffffffffc0201744:	8a850513          	addi	a0,a0,-1880 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201748:	d57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020174c:	0000b697          	auipc	a3,0xb
ffffffffc0201750:	8d468693          	addi	a3,a3,-1836 # ffffffffc020c020 <commands+0x998>
ffffffffc0201754:	0000a617          	auipc	a2,0xa
ffffffffc0201758:	14460613          	addi	a2,a2,324 # ffffffffc020b898 <commands+0x210>
ffffffffc020175c:	0b800593          	li	a1,184
ffffffffc0201760:	0000b517          	auipc	a0,0xb
ffffffffc0201764:	88850513          	addi	a0,a0,-1912 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201768:	d37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020176c:	0000b697          	auipc	a3,0xb
ffffffffc0201770:	9dc68693          	addi	a3,a3,-1572 # ffffffffc020c148 <commands+0xac0>
ffffffffc0201774:	0000a617          	auipc	a2,0xa
ffffffffc0201778:	12460613          	addi	a2,a2,292 # ffffffffc020b898 <commands+0x210>
ffffffffc020177c:	0d500593          	li	a1,213
ffffffffc0201780:	0000b517          	auipc	a0,0xb
ffffffffc0201784:	86850513          	addi	a0,a0,-1944 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201788:	d17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020178c:	0000b697          	auipc	a3,0xb
ffffffffc0201790:	8d468693          	addi	a3,a3,-1836 # ffffffffc020c060 <commands+0x9d8>
ffffffffc0201794:	0000a617          	auipc	a2,0xa
ffffffffc0201798:	10460613          	addi	a2,a2,260 # ffffffffc020b898 <commands+0x210>
ffffffffc020179c:	0d300593          	li	a1,211
ffffffffc02017a0:	0000b517          	auipc	a0,0xb
ffffffffc02017a4:	84850513          	addi	a0,a0,-1976 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02017a8:	cf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ac:	0000b697          	auipc	a3,0xb
ffffffffc02017b0:	89468693          	addi	a3,a3,-1900 # ffffffffc020c040 <commands+0x9b8>
ffffffffc02017b4:	0000a617          	auipc	a2,0xa
ffffffffc02017b8:	0e460613          	addi	a2,a2,228 # ffffffffc020b898 <commands+0x210>
ffffffffc02017bc:	0d200593          	li	a1,210
ffffffffc02017c0:	0000b517          	auipc	a0,0xb
ffffffffc02017c4:	82850513          	addi	a0,a0,-2008 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02017c8:	cd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017cc:	0000b697          	auipc	a3,0xb
ffffffffc02017d0:	89468693          	addi	a3,a3,-1900 # ffffffffc020c060 <commands+0x9d8>
ffffffffc02017d4:	0000a617          	auipc	a2,0xa
ffffffffc02017d8:	0c460613          	addi	a2,a2,196 # ffffffffc020b898 <commands+0x210>
ffffffffc02017dc:	0ba00593          	li	a1,186
ffffffffc02017e0:	0000b517          	auipc	a0,0xb
ffffffffc02017e4:	80850513          	addi	a0,a0,-2040 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02017e8:	cb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ec:	0000b697          	auipc	a3,0xb
ffffffffc02017f0:	b1c68693          	addi	a3,a3,-1252 # ffffffffc020c308 <commands+0xc80>
ffffffffc02017f4:	0000a617          	auipc	a2,0xa
ffffffffc02017f8:	0a460613          	addi	a2,a2,164 # ffffffffc020b898 <commands+0x210>
ffffffffc02017fc:	12400593          	li	a1,292
ffffffffc0201800:	0000a517          	auipc	a0,0xa
ffffffffc0201804:	7e850513          	addi	a0,a0,2024 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201808:	c97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020180c:	0000b697          	auipc	a3,0xb
ffffffffc0201810:	99c68693          	addi	a3,a3,-1636 # ffffffffc020c1a8 <commands+0xb20>
ffffffffc0201814:	0000a617          	auipc	a2,0xa
ffffffffc0201818:	08460613          	addi	a2,a2,132 # ffffffffc020b898 <commands+0x210>
ffffffffc020181c:	11900593          	li	a1,281
ffffffffc0201820:	0000a517          	auipc	a0,0xa
ffffffffc0201824:	7c850513          	addi	a0,a0,1992 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201828:	c77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020182c:	0000b697          	auipc	a3,0xb
ffffffffc0201830:	91c68693          	addi	a3,a3,-1764 # ffffffffc020c148 <commands+0xac0>
ffffffffc0201834:	0000a617          	auipc	a2,0xa
ffffffffc0201838:	06460613          	addi	a2,a2,100 # ffffffffc020b898 <commands+0x210>
ffffffffc020183c:	11700593          	li	a1,279
ffffffffc0201840:	0000a517          	auipc	a0,0xa
ffffffffc0201844:	7a850513          	addi	a0,a0,1960 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201848:	c57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020184c:	0000b697          	auipc	a3,0xb
ffffffffc0201850:	8bc68693          	addi	a3,a3,-1860 # ffffffffc020c108 <commands+0xa80>
ffffffffc0201854:	0000a617          	auipc	a2,0xa
ffffffffc0201858:	04460613          	addi	a2,a2,68 # ffffffffc020b898 <commands+0x210>
ffffffffc020185c:	0c000593          	li	a1,192
ffffffffc0201860:	0000a517          	auipc	a0,0xa
ffffffffc0201864:	78850513          	addi	a0,a0,1928 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201868:	c37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020186c:	0000b697          	auipc	a3,0xb
ffffffffc0201870:	a5c68693          	addi	a3,a3,-1444 # ffffffffc020c2c8 <commands+0xc40>
ffffffffc0201874:	0000a617          	auipc	a2,0xa
ffffffffc0201878:	02460613          	addi	a2,a2,36 # ffffffffc020b898 <commands+0x210>
ffffffffc020187c:	11100593          	li	a1,273
ffffffffc0201880:	0000a517          	auipc	a0,0xa
ffffffffc0201884:	76850513          	addi	a0,a0,1896 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201888:	c17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020188c:	0000b697          	auipc	a3,0xb
ffffffffc0201890:	a1c68693          	addi	a3,a3,-1508 # ffffffffc020c2a8 <commands+0xc20>
ffffffffc0201894:	0000a617          	auipc	a2,0xa
ffffffffc0201898:	00460613          	addi	a2,a2,4 # ffffffffc020b898 <commands+0x210>
ffffffffc020189c:	10f00593          	li	a1,271
ffffffffc02018a0:	0000a517          	auipc	a0,0xa
ffffffffc02018a4:	74850513          	addi	a0,a0,1864 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02018a8:	bf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ac:	0000b697          	auipc	a3,0xb
ffffffffc02018b0:	9d468693          	addi	a3,a3,-1580 # ffffffffc020c280 <commands+0xbf8>
ffffffffc02018b4:	0000a617          	auipc	a2,0xa
ffffffffc02018b8:	fe460613          	addi	a2,a2,-28 # ffffffffc020b898 <commands+0x210>
ffffffffc02018bc:	10d00593          	li	a1,269
ffffffffc02018c0:	0000a517          	auipc	a0,0xa
ffffffffc02018c4:	72850513          	addi	a0,a0,1832 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02018c8:	bd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018cc:	0000b697          	auipc	a3,0xb
ffffffffc02018d0:	98c68693          	addi	a3,a3,-1652 # ffffffffc020c258 <commands+0xbd0>
ffffffffc02018d4:	0000a617          	auipc	a2,0xa
ffffffffc02018d8:	fc460613          	addi	a2,a2,-60 # ffffffffc020b898 <commands+0x210>
ffffffffc02018dc:	10c00593          	li	a1,268
ffffffffc02018e0:	0000a517          	auipc	a0,0xa
ffffffffc02018e4:	70850513          	addi	a0,a0,1800 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02018e8:	bb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ec:	0000b697          	auipc	a3,0xb
ffffffffc02018f0:	95c68693          	addi	a3,a3,-1700 # ffffffffc020c248 <commands+0xbc0>
ffffffffc02018f4:	0000a617          	auipc	a2,0xa
ffffffffc02018f8:	fa460613          	addi	a2,a2,-92 # ffffffffc020b898 <commands+0x210>
ffffffffc02018fc:	10700593          	li	a1,263
ffffffffc0201900:	0000a517          	auipc	a0,0xa
ffffffffc0201904:	6e850513          	addi	a0,a0,1768 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201908:	b97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020190c:	0000b697          	auipc	a3,0xb
ffffffffc0201910:	83c68693          	addi	a3,a3,-1988 # ffffffffc020c148 <commands+0xac0>
ffffffffc0201914:	0000a617          	auipc	a2,0xa
ffffffffc0201918:	f8460613          	addi	a2,a2,-124 # ffffffffc020b898 <commands+0x210>
ffffffffc020191c:	10600593          	li	a1,262
ffffffffc0201920:	0000a517          	auipc	a0,0xa
ffffffffc0201924:	6c850513          	addi	a0,a0,1736 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201928:	b77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020192c:	0000b697          	auipc	a3,0xb
ffffffffc0201930:	8fc68693          	addi	a3,a3,-1796 # ffffffffc020c228 <commands+0xba0>
ffffffffc0201934:	0000a617          	auipc	a2,0xa
ffffffffc0201938:	f6460613          	addi	a2,a2,-156 # ffffffffc020b898 <commands+0x210>
ffffffffc020193c:	10500593          	li	a1,261
ffffffffc0201940:	0000a517          	auipc	a0,0xa
ffffffffc0201944:	6a850513          	addi	a0,a0,1704 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201948:	b57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020194c:	0000b697          	auipc	a3,0xb
ffffffffc0201950:	8ac68693          	addi	a3,a3,-1876 # ffffffffc020c1f8 <commands+0xb70>
ffffffffc0201954:	0000a617          	auipc	a2,0xa
ffffffffc0201958:	f4460613          	addi	a2,a2,-188 # ffffffffc020b898 <commands+0x210>
ffffffffc020195c:	10400593          	li	a1,260
ffffffffc0201960:	0000a517          	auipc	a0,0xa
ffffffffc0201964:	68850513          	addi	a0,a0,1672 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201968:	b37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020196c:	0000b697          	auipc	a3,0xb
ffffffffc0201970:	87468693          	addi	a3,a3,-1932 # ffffffffc020c1e0 <commands+0xb58>
ffffffffc0201974:	0000a617          	auipc	a2,0xa
ffffffffc0201978:	f2460613          	addi	a2,a2,-220 # ffffffffc020b898 <commands+0x210>
ffffffffc020197c:	10300593          	li	a1,259
ffffffffc0201980:	0000a517          	auipc	a0,0xa
ffffffffc0201984:	66850513          	addi	a0,a0,1640 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201988:	b17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020198c:	0000a697          	auipc	a3,0xa
ffffffffc0201990:	7bc68693          	addi	a3,a3,1980 # ffffffffc020c148 <commands+0xac0>
ffffffffc0201994:	0000a617          	auipc	a2,0xa
ffffffffc0201998:	f0460613          	addi	a2,a2,-252 # ffffffffc020b898 <commands+0x210>
ffffffffc020199c:	0fd00593          	li	a1,253
ffffffffc02019a0:	0000a517          	auipc	a0,0xa
ffffffffc02019a4:	64850513          	addi	a0,a0,1608 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02019a8:	af7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ac:	0000b697          	auipc	a3,0xb
ffffffffc02019b0:	81c68693          	addi	a3,a3,-2020 # ffffffffc020c1c8 <commands+0xb40>
ffffffffc02019b4:	0000a617          	auipc	a2,0xa
ffffffffc02019b8:	ee460613          	addi	a2,a2,-284 # ffffffffc020b898 <commands+0x210>
ffffffffc02019bc:	0f800593          	li	a1,248
ffffffffc02019c0:	0000a517          	auipc	a0,0xa
ffffffffc02019c4:	62850513          	addi	a0,a0,1576 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02019c8:	ad7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019cc:	0000b697          	auipc	a3,0xb
ffffffffc02019d0:	91c68693          	addi	a3,a3,-1764 # ffffffffc020c2e8 <commands+0xc60>
ffffffffc02019d4:	0000a617          	auipc	a2,0xa
ffffffffc02019d8:	ec460613          	addi	a2,a2,-316 # ffffffffc020b898 <commands+0x210>
ffffffffc02019dc:	11600593          	li	a1,278
ffffffffc02019e0:	0000a517          	auipc	a0,0xa
ffffffffc02019e4:	60850513          	addi	a0,a0,1544 # ffffffffc020bfe8 <commands+0x960>
ffffffffc02019e8:	ab7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ec:	0000b697          	auipc	a3,0xb
ffffffffc02019f0:	92c68693          	addi	a3,a3,-1748 # ffffffffc020c318 <commands+0xc90>
ffffffffc02019f4:	0000a617          	auipc	a2,0xa
ffffffffc02019f8:	ea460613          	addi	a2,a2,-348 # ffffffffc020b898 <commands+0x210>
ffffffffc02019fc:	12500593          	li	a1,293
ffffffffc0201a00:	0000a517          	auipc	a0,0xa
ffffffffc0201a04:	5e850513          	addi	a0,a0,1512 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201a08:	a97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a0c:	0000a697          	auipc	a3,0xa
ffffffffc0201a10:	5f468693          	addi	a3,a3,1524 # ffffffffc020c000 <commands+0x978>
ffffffffc0201a14:	0000a617          	auipc	a2,0xa
ffffffffc0201a18:	e8460613          	addi	a2,a2,-380 # ffffffffc020b898 <commands+0x210>
ffffffffc0201a1c:	0f200593          	li	a1,242
ffffffffc0201a20:	0000a517          	auipc	a0,0xa
ffffffffc0201a24:	5c850513          	addi	a0,a0,1480 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201a28:	a77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a2c:	0000a697          	auipc	a3,0xa
ffffffffc0201a30:	61468693          	addi	a3,a3,1556 # ffffffffc020c040 <commands+0x9b8>
ffffffffc0201a34:	0000a617          	auipc	a2,0xa
ffffffffc0201a38:	e6460613          	addi	a2,a2,-412 # ffffffffc020b898 <commands+0x210>
ffffffffc0201a3c:	0b900593          	li	a1,185
ffffffffc0201a40:	0000a517          	auipc	a0,0xa
ffffffffc0201a44:	5a850513          	addi	a0,a0,1448 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201a48:	a57fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201a4c <default_free_pages>:
ffffffffc0201a4c:	1141                	addi	sp,sp,-16
ffffffffc0201a4e:	e406                	sd	ra,8(sp)
ffffffffc0201a50:	14058463          	beqz	a1,ffffffffc0201b98 <default_free_pages+0x14c>
ffffffffc0201a54:	00659693          	slli	a3,a1,0x6
ffffffffc0201a58:	96aa                	add	a3,a3,a0
ffffffffc0201a5a:	87aa                	mv	a5,a0
ffffffffc0201a5c:	02d50263          	beq	a0,a3,ffffffffc0201a80 <default_free_pages+0x34>
ffffffffc0201a60:	6798                	ld	a4,8(a5)
ffffffffc0201a62:	8b05                	andi	a4,a4,1
ffffffffc0201a64:	10071a63          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a68:	6798                	ld	a4,8(a5)
ffffffffc0201a6a:	8b09                	andi	a4,a4,2
ffffffffc0201a6c:	10071663          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a70:	0007b423          	sd	zero,8(a5)
ffffffffc0201a74:	0007a023          	sw	zero,0(a5)
ffffffffc0201a78:	04078793          	addi	a5,a5,64
ffffffffc0201a7c:	fed792e3          	bne	a5,a3,ffffffffc0201a60 <default_free_pages+0x14>
ffffffffc0201a80:	2581                	sext.w	a1,a1
ffffffffc0201a82:	c90c                	sw	a1,16(a0)
ffffffffc0201a84:	00850893          	addi	a7,a0,8
ffffffffc0201a88:	4789                	li	a5,2
ffffffffc0201a8a:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0201a8e:	00090697          	auipc	a3,0x90
ffffffffc0201a92:	d1a68693          	addi	a3,a3,-742 # ffffffffc02917a8 <free_area>
ffffffffc0201a96:	4a98                	lw	a4,16(a3)
ffffffffc0201a98:	669c                	ld	a5,8(a3)
ffffffffc0201a9a:	01850613          	addi	a2,a0,24
ffffffffc0201a9e:	9db9                	addw	a1,a1,a4
ffffffffc0201aa0:	ca8c                	sw	a1,16(a3)
ffffffffc0201aa2:	0ad78463          	beq	a5,a3,ffffffffc0201b4a <default_free_pages+0xfe>
ffffffffc0201aa6:	fe878713          	addi	a4,a5,-24
ffffffffc0201aaa:	0006b803          	ld	a6,0(a3)
ffffffffc0201aae:	4581                	li	a1,0
ffffffffc0201ab0:	00e56a63          	bltu	a0,a4,ffffffffc0201ac4 <default_free_pages+0x78>
ffffffffc0201ab4:	6798                	ld	a4,8(a5)
ffffffffc0201ab6:	04d70c63          	beq	a4,a3,ffffffffc0201b0e <default_free_pages+0xc2>
ffffffffc0201aba:	87ba                	mv	a5,a4
ffffffffc0201abc:	fe878713          	addi	a4,a5,-24
ffffffffc0201ac0:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ab4 <default_free_pages+0x68>
ffffffffc0201ac4:	c199                	beqz	a1,ffffffffc0201aca <default_free_pages+0x7e>
ffffffffc0201ac6:	0106b023          	sd	a6,0(a3)
ffffffffc0201aca:	6398                	ld	a4,0(a5)
ffffffffc0201acc:	e390                	sd	a2,0(a5)
ffffffffc0201ace:	e710                	sd	a2,8(a4)
ffffffffc0201ad0:	f11c                	sd	a5,32(a0)
ffffffffc0201ad2:	ed18                	sd	a4,24(a0)
ffffffffc0201ad4:	00d70d63          	beq	a4,a3,ffffffffc0201aee <default_free_pages+0xa2>
ffffffffc0201ad8:	ff872583          	lw	a1,-8(a4)
ffffffffc0201adc:	fe870613          	addi	a2,a4,-24
ffffffffc0201ae0:	02059813          	slli	a6,a1,0x20
ffffffffc0201ae4:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201ae8:	97b2                	add	a5,a5,a2
ffffffffc0201aea:	02f50c63          	beq	a0,a5,ffffffffc0201b22 <default_free_pages+0xd6>
ffffffffc0201aee:	711c                	ld	a5,32(a0)
ffffffffc0201af0:	00d78c63          	beq	a5,a3,ffffffffc0201b08 <default_free_pages+0xbc>
ffffffffc0201af4:	4910                	lw	a2,16(a0)
ffffffffc0201af6:	fe878693          	addi	a3,a5,-24
ffffffffc0201afa:	02061593          	slli	a1,a2,0x20
ffffffffc0201afe:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201b02:	972a                	add	a4,a4,a0
ffffffffc0201b04:	04e68a63          	beq	a3,a4,ffffffffc0201b58 <default_free_pages+0x10c>
ffffffffc0201b08:	60a2                	ld	ra,8(sp)
ffffffffc0201b0a:	0141                	addi	sp,sp,16
ffffffffc0201b0c:	8082                	ret
ffffffffc0201b0e:	e790                	sd	a2,8(a5)
ffffffffc0201b10:	f114                	sd	a3,32(a0)
ffffffffc0201b12:	6798                	ld	a4,8(a5)
ffffffffc0201b14:	ed1c                	sd	a5,24(a0)
ffffffffc0201b16:	02d70763          	beq	a4,a3,ffffffffc0201b44 <default_free_pages+0xf8>
ffffffffc0201b1a:	8832                	mv	a6,a2
ffffffffc0201b1c:	4585                	li	a1,1
ffffffffc0201b1e:	87ba                	mv	a5,a4
ffffffffc0201b20:	bf71                	j	ffffffffc0201abc <default_free_pages+0x70>
ffffffffc0201b22:	491c                	lw	a5,16(a0)
ffffffffc0201b24:	9dbd                	addw	a1,a1,a5
ffffffffc0201b26:	feb72c23          	sw	a1,-8(a4)
ffffffffc0201b2a:	57f5                	li	a5,-3
ffffffffc0201b2c:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0201b30:	01853803          	ld	a6,24(a0)
ffffffffc0201b34:	710c                	ld	a1,32(a0)
ffffffffc0201b36:	8532                	mv	a0,a2
ffffffffc0201b38:	00b83423          	sd	a1,8(a6)
ffffffffc0201b3c:	671c                	ld	a5,8(a4)
ffffffffc0201b3e:	0105b023          	sd	a6,0(a1)
ffffffffc0201b42:	b77d                	j	ffffffffc0201af0 <default_free_pages+0xa4>
ffffffffc0201b44:	e290                	sd	a2,0(a3)
ffffffffc0201b46:	873e                	mv	a4,a5
ffffffffc0201b48:	bf41                	j	ffffffffc0201ad8 <default_free_pages+0x8c>
ffffffffc0201b4a:	60a2                	ld	ra,8(sp)
ffffffffc0201b4c:	e390                	sd	a2,0(a5)
ffffffffc0201b4e:	e790                	sd	a2,8(a5)
ffffffffc0201b50:	f11c                	sd	a5,32(a0)
ffffffffc0201b52:	ed1c                	sd	a5,24(a0)
ffffffffc0201b54:	0141                	addi	sp,sp,16
ffffffffc0201b56:	8082                	ret
ffffffffc0201b58:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201b5c:	ff078693          	addi	a3,a5,-16
ffffffffc0201b60:	9e39                	addw	a2,a2,a4
ffffffffc0201b62:	c910                	sw	a2,16(a0)
ffffffffc0201b64:	5775                	li	a4,-3
ffffffffc0201b66:	60e6b02f          	amoand.d	zero,a4,(a3)
ffffffffc0201b6a:	6398                	ld	a4,0(a5)
ffffffffc0201b6c:	679c                	ld	a5,8(a5)
ffffffffc0201b6e:	60a2                	ld	ra,8(sp)
ffffffffc0201b70:	e71c                	sd	a5,8(a4)
ffffffffc0201b72:	e398                	sd	a4,0(a5)
ffffffffc0201b74:	0141                	addi	sp,sp,16
ffffffffc0201b76:	8082                	ret
ffffffffc0201b78:	0000a697          	auipc	a3,0xa
ffffffffc0201b7c:	7b868693          	addi	a3,a3,1976 # ffffffffc020c330 <commands+0xca8>
ffffffffc0201b80:	0000a617          	auipc	a2,0xa
ffffffffc0201b84:	d1860613          	addi	a2,a2,-744 # ffffffffc020b898 <commands+0x210>
ffffffffc0201b88:	08200593          	li	a1,130
ffffffffc0201b8c:	0000a517          	auipc	a0,0xa
ffffffffc0201b90:	45c50513          	addi	a0,a0,1116 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201b94:	90bfe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201b98:	0000a697          	auipc	a3,0xa
ffffffffc0201b9c:	79068693          	addi	a3,a3,1936 # ffffffffc020c328 <commands+0xca0>
ffffffffc0201ba0:	0000a617          	auipc	a2,0xa
ffffffffc0201ba4:	cf860613          	addi	a2,a2,-776 # ffffffffc020b898 <commands+0x210>
ffffffffc0201ba8:	07f00593          	li	a1,127
ffffffffc0201bac:	0000a517          	auipc	a0,0xa
ffffffffc0201bb0:	43c50513          	addi	a0,a0,1084 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201bb4:	8ebfe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201bb8 <default_alloc_pages>:
ffffffffc0201bb8:	c941                	beqz	a0,ffffffffc0201c48 <default_alloc_pages+0x90>
ffffffffc0201bba:	00090597          	auipc	a1,0x90
ffffffffc0201bbe:	bee58593          	addi	a1,a1,-1042 # ffffffffc02917a8 <free_area>
ffffffffc0201bc2:	0105a803          	lw	a6,16(a1)
ffffffffc0201bc6:	872a                	mv	a4,a0
ffffffffc0201bc8:	02081793          	slli	a5,a6,0x20
ffffffffc0201bcc:	9381                	srli	a5,a5,0x20
ffffffffc0201bce:	00a7ee63          	bltu	a5,a0,ffffffffc0201bea <default_alloc_pages+0x32>
ffffffffc0201bd2:	87ae                	mv	a5,a1
ffffffffc0201bd4:	a801                	j	ffffffffc0201be4 <default_alloc_pages+0x2c>
ffffffffc0201bd6:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201bda:	02069613          	slli	a2,a3,0x20
ffffffffc0201bde:	9201                	srli	a2,a2,0x20
ffffffffc0201be0:	00e67763          	bgeu	a2,a4,ffffffffc0201bee <default_alloc_pages+0x36>
ffffffffc0201be4:	679c                	ld	a5,8(a5)
ffffffffc0201be6:	feb798e3          	bne	a5,a1,ffffffffc0201bd6 <default_alloc_pages+0x1e>
ffffffffc0201bea:	4501                	li	a0,0
ffffffffc0201bec:	8082                	ret
ffffffffc0201bee:	0007b883          	ld	a7,0(a5)
ffffffffc0201bf2:	0087b303          	ld	t1,8(a5)
ffffffffc0201bf6:	fe878513          	addi	a0,a5,-24
ffffffffc0201bfa:	00070e1b          	sext.w	t3,a4
ffffffffc0201bfe:	0068b423          	sd	t1,8(a7) # 10000008 <_binary_bin_sfs_img_size+0xff8ad08>
ffffffffc0201c02:	01133023          	sd	a7,0(t1)
ffffffffc0201c06:	02c77863          	bgeu	a4,a2,ffffffffc0201c36 <default_alloc_pages+0x7e>
ffffffffc0201c0a:	071a                	slli	a4,a4,0x6
ffffffffc0201c0c:	972a                	add	a4,a4,a0
ffffffffc0201c0e:	41c686bb          	subw	a3,a3,t3
ffffffffc0201c12:	cb14                	sw	a3,16(a4)
ffffffffc0201c14:	00870613          	addi	a2,a4,8
ffffffffc0201c18:	4689                	li	a3,2
ffffffffc0201c1a:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0201c1e:	0088b683          	ld	a3,8(a7)
ffffffffc0201c22:	01870613          	addi	a2,a4,24
ffffffffc0201c26:	0105a803          	lw	a6,16(a1)
ffffffffc0201c2a:	e290                	sd	a2,0(a3)
ffffffffc0201c2c:	00c8b423          	sd	a2,8(a7)
ffffffffc0201c30:	f314                	sd	a3,32(a4)
ffffffffc0201c32:	01173c23          	sd	a7,24(a4)
ffffffffc0201c36:	41c8083b          	subw	a6,a6,t3
ffffffffc0201c3a:	0105a823          	sw	a6,16(a1)
ffffffffc0201c3e:	5775                	li	a4,-3
ffffffffc0201c40:	17c1                	addi	a5,a5,-16
ffffffffc0201c42:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0201c46:	8082                	ret
ffffffffc0201c48:	1141                	addi	sp,sp,-16
ffffffffc0201c4a:	0000a697          	auipc	a3,0xa
ffffffffc0201c4e:	6de68693          	addi	a3,a3,1758 # ffffffffc020c328 <commands+0xca0>
ffffffffc0201c52:	0000a617          	auipc	a2,0xa
ffffffffc0201c56:	c4660613          	addi	a2,a2,-954 # ffffffffc020b898 <commands+0x210>
ffffffffc0201c5a:	06100593          	li	a1,97
ffffffffc0201c5e:	0000a517          	auipc	a0,0xa
ffffffffc0201c62:	38a50513          	addi	a0,a0,906 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201c66:	e406                	sd	ra,8(sp)
ffffffffc0201c68:	837fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201c6c <default_init_memmap>:
ffffffffc0201c6c:	1141                	addi	sp,sp,-16
ffffffffc0201c6e:	e406                	sd	ra,8(sp)
ffffffffc0201c70:	c5f1                	beqz	a1,ffffffffc0201d3c <default_init_memmap+0xd0>
ffffffffc0201c72:	00659693          	slli	a3,a1,0x6
ffffffffc0201c76:	96aa                	add	a3,a3,a0
ffffffffc0201c78:	87aa                	mv	a5,a0
ffffffffc0201c7a:	00d50f63          	beq	a0,a3,ffffffffc0201c98 <default_init_memmap+0x2c>
ffffffffc0201c7e:	6798                	ld	a4,8(a5)
ffffffffc0201c80:	8b05                	andi	a4,a4,1
ffffffffc0201c82:	cf49                	beqz	a4,ffffffffc0201d1c <default_init_memmap+0xb0>
ffffffffc0201c84:	0007a823          	sw	zero,16(a5)
ffffffffc0201c88:	0007b423          	sd	zero,8(a5)
ffffffffc0201c8c:	0007a023          	sw	zero,0(a5)
ffffffffc0201c90:	04078793          	addi	a5,a5,64
ffffffffc0201c94:	fed795e3          	bne	a5,a3,ffffffffc0201c7e <default_init_memmap+0x12>
ffffffffc0201c98:	2581                	sext.w	a1,a1
ffffffffc0201c9a:	c90c                	sw	a1,16(a0)
ffffffffc0201c9c:	4789                	li	a5,2
ffffffffc0201c9e:	00850713          	addi	a4,a0,8
ffffffffc0201ca2:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0201ca6:	00090697          	auipc	a3,0x90
ffffffffc0201caa:	b0268693          	addi	a3,a3,-1278 # ffffffffc02917a8 <free_area>
ffffffffc0201cae:	4a98                	lw	a4,16(a3)
ffffffffc0201cb0:	669c                	ld	a5,8(a3)
ffffffffc0201cb2:	01850613          	addi	a2,a0,24
ffffffffc0201cb6:	9db9                	addw	a1,a1,a4
ffffffffc0201cb8:	ca8c                	sw	a1,16(a3)
ffffffffc0201cba:	04d78a63          	beq	a5,a3,ffffffffc0201d0e <default_init_memmap+0xa2>
ffffffffc0201cbe:	fe878713          	addi	a4,a5,-24
ffffffffc0201cc2:	0006b803          	ld	a6,0(a3)
ffffffffc0201cc6:	4581                	li	a1,0
ffffffffc0201cc8:	00e56a63          	bltu	a0,a4,ffffffffc0201cdc <default_init_memmap+0x70>
ffffffffc0201ccc:	6798                	ld	a4,8(a5)
ffffffffc0201cce:	02d70263          	beq	a4,a3,ffffffffc0201cf2 <default_init_memmap+0x86>
ffffffffc0201cd2:	87ba                	mv	a5,a4
ffffffffc0201cd4:	fe878713          	addi	a4,a5,-24
ffffffffc0201cd8:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ccc <default_init_memmap+0x60>
ffffffffc0201cdc:	c199                	beqz	a1,ffffffffc0201ce2 <default_init_memmap+0x76>
ffffffffc0201cde:	0106b023          	sd	a6,0(a3)
ffffffffc0201ce2:	6398                	ld	a4,0(a5)
ffffffffc0201ce4:	60a2                	ld	ra,8(sp)
ffffffffc0201ce6:	e390                	sd	a2,0(a5)
ffffffffc0201ce8:	e710                	sd	a2,8(a4)
ffffffffc0201cea:	f11c                	sd	a5,32(a0)
ffffffffc0201cec:	ed18                	sd	a4,24(a0)
ffffffffc0201cee:	0141                	addi	sp,sp,16
ffffffffc0201cf0:	8082                	ret
ffffffffc0201cf2:	e790                	sd	a2,8(a5)
ffffffffc0201cf4:	f114                	sd	a3,32(a0)
ffffffffc0201cf6:	6798                	ld	a4,8(a5)
ffffffffc0201cf8:	ed1c                	sd	a5,24(a0)
ffffffffc0201cfa:	00d70663          	beq	a4,a3,ffffffffc0201d06 <default_init_memmap+0x9a>
ffffffffc0201cfe:	8832                	mv	a6,a2
ffffffffc0201d00:	4585                	li	a1,1
ffffffffc0201d02:	87ba                	mv	a5,a4
ffffffffc0201d04:	bfc1                	j	ffffffffc0201cd4 <default_init_memmap+0x68>
ffffffffc0201d06:	60a2                	ld	ra,8(sp)
ffffffffc0201d08:	e290                	sd	a2,0(a3)
ffffffffc0201d0a:	0141                	addi	sp,sp,16
ffffffffc0201d0c:	8082                	ret
ffffffffc0201d0e:	60a2                	ld	ra,8(sp)
ffffffffc0201d10:	e390                	sd	a2,0(a5)
ffffffffc0201d12:	e790                	sd	a2,8(a5)
ffffffffc0201d14:	f11c                	sd	a5,32(a0)
ffffffffc0201d16:	ed1c                	sd	a5,24(a0)
ffffffffc0201d18:	0141                	addi	sp,sp,16
ffffffffc0201d1a:	8082                	ret
ffffffffc0201d1c:	0000a697          	auipc	a3,0xa
ffffffffc0201d20:	63c68693          	addi	a3,a3,1596 # ffffffffc020c358 <commands+0xcd0>
ffffffffc0201d24:	0000a617          	auipc	a2,0xa
ffffffffc0201d28:	b7460613          	addi	a2,a2,-1164 # ffffffffc020b898 <commands+0x210>
ffffffffc0201d2c:	04800593          	li	a1,72
ffffffffc0201d30:	0000a517          	auipc	a0,0xa
ffffffffc0201d34:	2b850513          	addi	a0,a0,696 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201d38:	f66fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201d3c:	0000a697          	auipc	a3,0xa
ffffffffc0201d40:	5ec68693          	addi	a3,a3,1516 # ffffffffc020c328 <commands+0xca0>
ffffffffc0201d44:	0000a617          	auipc	a2,0xa
ffffffffc0201d48:	b5460613          	addi	a2,a2,-1196 # ffffffffc020b898 <commands+0x210>
ffffffffc0201d4c:	04500593          	li	a1,69
ffffffffc0201d50:	0000a517          	auipc	a0,0xa
ffffffffc0201d54:	29850513          	addi	a0,a0,664 # ffffffffc020bfe8 <commands+0x960>
ffffffffc0201d58:	f46fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201d5c <slob_free>:
ffffffffc0201d5c:	c94d                	beqz	a0,ffffffffc0201e0e <slob_free+0xb2>
ffffffffc0201d5e:	1141                	addi	sp,sp,-16
ffffffffc0201d60:	e022                	sd	s0,0(sp)
ffffffffc0201d62:	e406                	sd	ra,8(sp)
ffffffffc0201d64:	842a                	mv	s0,a0
ffffffffc0201d66:	e9c1                	bnez	a1,ffffffffc0201df6 <slob_free+0x9a>
ffffffffc0201d68:	100027f3          	csrr	a5,sstatus
ffffffffc0201d6c:	8b89                	andi	a5,a5,2
ffffffffc0201d6e:	4501                	li	a0,0
ffffffffc0201d70:	ebd9                	bnez	a5,ffffffffc0201e06 <slob_free+0xaa>
ffffffffc0201d72:	0008f617          	auipc	a2,0x8f
ffffffffc0201d76:	2de60613          	addi	a2,a2,734 # ffffffffc0291050 <slobfree>
ffffffffc0201d7a:	621c                	ld	a5,0(a2)
ffffffffc0201d7c:	873e                	mv	a4,a5
ffffffffc0201d7e:	679c                	ld	a5,8(a5)
ffffffffc0201d80:	02877a63          	bgeu	a4,s0,ffffffffc0201db4 <slob_free+0x58>
ffffffffc0201d84:	00f46463          	bltu	s0,a5,ffffffffc0201d8c <slob_free+0x30>
ffffffffc0201d88:	fef76ae3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201d8c:	400c                	lw	a1,0(s0)
ffffffffc0201d8e:	00459693          	slli	a3,a1,0x4
ffffffffc0201d92:	96a2                	add	a3,a3,s0
ffffffffc0201d94:	02d78a63          	beq	a5,a3,ffffffffc0201dc8 <slob_free+0x6c>
ffffffffc0201d98:	4314                	lw	a3,0(a4)
ffffffffc0201d9a:	e41c                	sd	a5,8(s0)
ffffffffc0201d9c:	00469793          	slli	a5,a3,0x4
ffffffffc0201da0:	97ba                	add	a5,a5,a4
ffffffffc0201da2:	02f40e63          	beq	s0,a5,ffffffffc0201dde <slob_free+0x82>
ffffffffc0201da6:	e700                	sd	s0,8(a4)
ffffffffc0201da8:	e218                	sd	a4,0(a2)
ffffffffc0201daa:	e129                	bnez	a0,ffffffffc0201dec <slob_free+0x90>
ffffffffc0201dac:	60a2                	ld	ra,8(sp)
ffffffffc0201dae:	6402                	ld	s0,0(sp)
ffffffffc0201db0:	0141                	addi	sp,sp,16
ffffffffc0201db2:	8082                	ret
ffffffffc0201db4:	fcf764e3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201db8:	fcf472e3          	bgeu	s0,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201dbc:	400c                	lw	a1,0(s0)
ffffffffc0201dbe:	00459693          	slli	a3,a1,0x4
ffffffffc0201dc2:	96a2                	add	a3,a3,s0
ffffffffc0201dc4:	fcd79ae3          	bne	a5,a3,ffffffffc0201d98 <slob_free+0x3c>
ffffffffc0201dc8:	4394                	lw	a3,0(a5)
ffffffffc0201dca:	679c                	ld	a5,8(a5)
ffffffffc0201dcc:	9db5                	addw	a1,a1,a3
ffffffffc0201dce:	c00c                	sw	a1,0(s0)
ffffffffc0201dd0:	4314                	lw	a3,0(a4)
ffffffffc0201dd2:	e41c                	sd	a5,8(s0)
ffffffffc0201dd4:	00469793          	slli	a5,a3,0x4
ffffffffc0201dd8:	97ba                	add	a5,a5,a4
ffffffffc0201dda:	fcf416e3          	bne	s0,a5,ffffffffc0201da6 <slob_free+0x4a>
ffffffffc0201dde:	401c                	lw	a5,0(s0)
ffffffffc0201de0:	640c                	ld	a1,8(s0)
ffffffffc0201de2:	e218                	sd	a4,0(a2)
ffffffffc0201de4:	9ebd                	addw	a3,a3,a5
ffffffffc0201de6:	c314                	sw	a3,0(a4)
ffffffffc0201de8:	e70c                	sd	a1,8(a4)
ffffffffc0201dea:	d169                	beqz	a0,ffffffffc0201dac <slob_free+0x50>
ffffffffc0201dec:	6402                	ld	s0,0(sp)
ffffffffc0201dee:	60a2                	ld	ra,8(sp)
ffffffffc0201df0:	0141                	addi	sp,sp,16
ffffffffc0201df2:	e7bfe06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0201df6:	25bd                	addiw	a1,a1,15
ffffffffc0201df8:	8191                	srli	a1,a1,0x4
ffffffffc0201dfa:	c10c                	sw	a1,0(a0)
ffffffffc0201dfc:	100027f3          	csrr	a5,sstatus
ffffffffc0201e00:	8b89                	andi	a5,a5,2
ffffffffc0201e02:	4501                	li	a0,0
ffffffffc0201e04:	d7bd                	beqz	a5,ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e06:	e6dfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201e0a:	4505                	li	a0,1
ffffffffc0201e0c:	b79d                	j	ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e0e:	8082                	ret

ffffffffc0201e10 <__slob_get_free_pages.constprop.0>:
ffffffffc0201e10:	4785                	li	a5,1
ffffffffc0201e12:	1141                	addi	sp,sp,-16
ffffffffc0201e14:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201e18:	e406                	sd	ra,8(sp)
ffffffffc0201e1a:	352000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201e1e:	c91d                	beqz	a0,ffffffffc0201e54 <__slob_get_free_pages.constprop.0+0x44>
ffffffffc0201e20:	00095697          	auipc	a3,0x95
ffffffffc0201e24:	a886b683          	ld	a3,-1400(a3) # ffffffffc02968a8 <pages>
ffffffffc0201e28:	8d15                	sub	a0,a0,a3
ffffffffc0201e2a:	8519                	srai	a0,a0,0x6
ffffffffc0201e2c:	0000e697          	auipc	a3,0xe
ffffffffc0201e30:	8546b683          	ld	a3,-1964(a3) # ffffffffc020f680 <nbase>
ffffffffc0201e34:	9536                	add	a0,a0,a3
ffffffffc0201e36:	00c51793          	slli	a5,a0,0xc
ffffffffc0201e3a:	83b1                	srli	a5,a5,0xc
ffffffffc0201e3c:	00095717          	auipc	a4,0x95
ffffffffc0201e40:	a6473703          	ld	a4,-1436(a4) # ffffffffc02968a0 <npage>
ffffffffc0201e44:	0532                	slli	a0,a0,0xc
ffffffffc0201e46:	00e7fa63          	bgeu	a5,a4,ffffffffc0201e5a <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201e4a:	00095697          	auipc	a3,0x95
ffffffffc0201e4e:	a6e6b683          	ld	a3,-1426(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0201e52:	9536                	add	a0,a0,a3
ffffffffc0201e54:	60a2                	ld	ra,8(sp)
ffffffffc0201e56:	0141                	addi	sp,sp,16
ffffffffc0201e58:	8082                	ret
ffffffffc0201e5a:	86aa                	mv	a3,a0
ffffffffc0201e5c:	0000a617          	auipc	a2,0xa
ffffffffc0201e60:	55c60613          	addi	a2,a2,1372 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc0201e64:	07100593          	li	a1,113
ffffffffc0201e68:	0000a517          	auipc	a0,0xa
ffffffffc0201e6c:	57850513          	addi	a0,a0,1400 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0201e70:	e2efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201e74 <slob_alloc.constprop.0>:
ffffffffc0201e74:	1101                	addi	sp,sp,-32
ffffffffc0201e76:	ec06                	sd	ra,24(sp)
ffffffffc0201e78:	e822                	sd	s0,16(sp)
ffffffffc0201e7a:	e426                	sd	s1,8(sp)
ffffffffc0201e7c:	e04a                	sd	s2,0(sp)
ffffffffc0201e7e:	01050713          	addi	a4,a0,16
ffffffffc0201e82:	6785                	lui	a5,0x1
ffffffffc0201e84:	0cf77363          	bgeu	a4,a5,ffffffffc0201f4a <slob_alloc.constprop.0+0xd6>
ffffffffc0201e88:	00f50493          	addi	s1,a0,15
ffffffffc0201e8c:	8091                	srli	s1,s1,0x4
ffffffffc0201e8e:	2481                	sext.w	s1,s1
ffffffffc0201e90:	10002673          	csrr	a2,sstatus
ffffffffc0201e94:	8a09                	andi	a2,a2,2
ffffffffc0201e96:	e25d                	bnez	a2,ffffffffc0201f3c <slob_alloc.constprop.0+0xc8>
ffffffffc0201e98:	0008f917          	auipc	s2,0x8f
ffffffffc0201e9c:	1b890913          	addi	s2,s2,440 # ffffffffc0291050 <slobfree>
ffffffffc0201ea0:	00093683          	ld	a3,0(s2)
ffffffffc0201ea4:	669c                	ld	a5,8(a3)
ffffffffc0201ea6:	4398                	lw	a4,0(a5)
ffffffffc0201ea8:	08975e63          	bge	a4,s1,ffffffffc0201f44 <slob_alloc.constprop.0+0xd0>
ffffffffc0201eac:	00f68b63          	beq	a3,a5,ffffffffc0201ec2 <slob_alloc.constprop.0+0x4e>
ffffffffc0201eb0:	6780                	ld	s0,8(a5)
ffffffffc0201eb2:	4018                	lw	a4,0(s0)
ffffffffc0201eb4:	02975a63          	bge	a4,s1,ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201eb8:	00093683          	ld	a3,0(s2)
ffffffffc0201ebc:	87a2                	mv	a5,s0
ffffffffc0201ebe:	fef699e3          	bne	a3,a5,ffffffffc0201eb0 <slob_alloc.constprop.0+0x3c>
ffffffffc0201ec2:	ee31                	bnez	a2,ffffffffc0201f1e <slob_alloc.constprop.0+0xaa>
ffffffffc0201ec4:	4501                	li	a0,0
ffffffffc0201ec6:	f4bff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201eca:	842a                	mv	s0,a0
ffffffffc0201ecc:	cd05                	beqz	a0,ffffffffc0201f04 <slob_alloc.constprop.0+0x90>
ffffffffc0201ece:	6585                	lui	a1,0x1
ffffffffc0201ed0:	e8dff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc0201ed4:	10002673          	csrr	a2,sstatus
ffffffffc0201ed8:	8a09                	andi	a2,a2,2
ffffffffc0201eda:	ee05                	bnez	a2,ffffffffc0201f12 <slob_alloc.constprop.0+0x9e>
ffffffffc0201edc:	00093783          	ld	a5,0(s2)
ffffffffc0201ee0:	6780                	ld	s0,8(a5)
ffffffffc0201ee2:	4018                	lw	a4,0(s0)
ffffffffc0201ee4:	fc974ae3          	blt	a4,s1,ffffffffc0201eb8 <slob_alloc.constprop.0+0x44>
ffffffffc0201ee8:	04e48763          	beq	s1,a4,ffffffffc0201f36 <slob_alloc.constprop.0+0xc2>
ffffffffc0201eec:	00449693          	slli	a3,s1,0x4
ffffffffc0201ef0:	96a2                	add	a3,a3,s0
ffffffffc0201ef2:	e794                	sd	a3,8(a5)
ffffffffc0201ef4:	640c                	ld	a1,8(s0)
ffffffffc0201ef6:	9f05                	subw	a4,a4,s1
ffffffffc0201ef8:	c298                	sw	a4,0(a3)
ffffffffc0201efa:	e68c                	sd	a1,8(a3)
ffffffffc0201efc:	c004                	sw	s1,0(s0)
ffffffffc0201efe:	00f93023          	sd	a5,0(s2)
ffffffffc0201f02:	e20d                	bnez	a2,ffffffffc0201f24 <slob_alloc.constprop.0+0xb0>
ffffffffc0201f04:	60e2                	ld	ra,24(sp)
ffffffffc0201f06:	8522                	mv	a0,s0
ffffffffc0201f08:	6442                	ld	s0,16(sp)
ffffffffc0201f0a:	64a2                	ld	s1,8(sp)
ffffffffc0201f0c:	6902                	ld	s2,0(sp)
ffffffffc0201f0e:	6105                	addi	sp,sp,32
ffffffffc0201f10:	8082                	ret
ffffffffc0201f12:	d61fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f16:	00093783          	ld	a5,0(s2)
ffffffffc0201f1a:	4605                	li	a2,1
ffffffffc0201f1c:	b7d1                	j	ffffffffc0201ee0 <slob_alloc.constprop.0+0x6c>
ffffffffc0201f1e:	d4ffe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f22:	b74d                	j	ffffffffc0201ec4 <slob_alloc.constprop.0+0x50>
ffffffffc0201f24:	d49fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f28:	60e2                	ld	ra,24(sp)
ffffffffc0201f2a:	8522                	mv	a0,s0
ffffffffc0201f2c:	6442                	ld	s0,16(sp)
ffffffffc0201f2e:	64a2                	ld	s1,8(sp)
ffffffffc0201f30:	6902                	ld	s2,0(sp)
ffffffffc0201f32:	6105                	addi	sp,sp,32
ffffffffc0201f34:	8082                	ret
ffffffffc0201f36:	6418                	ld	a4,8(s0)
ffffffffc0201f38:	e798                	sd	a4,8(a5)
ffffffffc0201f3a:	b7d1                	j	ffffffffc0201efe <slob_alloc.constprop.0+0x8a>
ffffffffc0201f3c:	d37fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f40:	4605                	li	a2,1
ffffffffc0201f42:	bf99                	j	ffffffffc0201e98 <slob_alloc.constprop.0+0x24>
ffffffffc0201f44:	843e                	mv	s0,a5
ffffffffc0201f46:	87b6                	mv	a5,a3
ffffffffc0201f48:	b745                	j	ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201f4a:	0000a697          	auipc	a3,0xa
ffffffffc0201f4e:	4a668693          	addi	a3,a3,1190 # ffffffffc020c3f0 <default_pmm_manager+0x70>
ffffffffc0201f52:	0000a617          	auipc	a2,0xa
ffffffffc0201f56:	94660613          	addi	a2,a2,-1722 # ffffffffc020b898 <commands+0x210>
ffffffffc0201f5a:	06300593          	li	a1,99
ffffffffc0201f5e:	0000a517          	auipc	a0,0xa
ffffffffc0201f62:	4b250513          	addi	a0,a0,1202 # ffffffffc020c410 <default_pmm_manager+0x90>
ffffffffc0201f66:	d38fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201f6a <kmalloc_init>:
ffffffffc0201f6a:	1141                	addi	sp,sp,-16
ffffffffc0201f6c:	0000a517          	auipc	a0,0xa
ffffffffc0201f70:	4bc50513          	addi	a0,a0,1212 # ffffffffc020c428 <default_pmm_manager+0xa8>
ffffffffc0201f74:	e406                	sd	ra,8(sp)
ffffffffc0201f76:	a30fe0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201f7a:	60a2                	ld	ra,8(sp)
ffffffffc0201f7c:	0000a517          	auipc	a0,0xa
ffffffffc0201f80:	4c450513          	addi	a0,a0,1220 # ffffffffc020c440 <default_pmm_manager+0xc0>
ffffffffc0201f84:	0141                	addi	sp,sp,16
ffffffffc0201f86:	a20fe06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0201f8a <kallocated>:
ffffffffc0201f8a:	4501                	li	a0,0
ffffffffc0201f8c:	8082                	ret

ffffffffc0201f8e <kmalloc>:
ffffffffc0201f8e:	1101                	addi	sp,sp,-32
ffffffffc0201f90:	e04a                	sd	s2,0(sp)
ffffffffc0201f92:	6905                	lui	s2,0x1
ffffffffc0201f94:	e822                	sd	s0,16(sp)
ffffffffc0201f96:	ec06                	sd	ra,24(sp)
ffffffffc0201f98:	e426                	sd	s1,8(sp)
ffffffffc0201f9a:	fef90793          	addi	a5,s2,-17 # fef <_binary_bin_swap_img_size-0x6d11>
ffffffffc0201f9e:	842a                	mv	s0,a0
ffffffffc0201fa0:	04a7f963          	bgeu	a5,a0,ffffffffc0201ff2 <kmalloc+0x64>
ffffffffc0201fa4:	4561                	li	a0,24
ffffffffc0201fa6:	ecfff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201faa:	84aa                	mv	s1,a0
ffffffffc0201fac:	c929                	beqz	a0,ffffffffc0201ffe <kmalloc+0x70>
ffffffffc0201fae:	0004079b          	sext.w	a5,s0
ffffffffc0201fb2:	4501                	li	a0,0
ffffffffc0201fb4:	00f95763          	bge	s2,a5,ffffffffc0201fc2 <kmalloc+0x34>
ffffffffc0201fb8:	6705                	lui	a4,0x1
ffffffffc0201fba:	8785                	srai	a5,a5,0x1
ffffffffc0201fbc:	2505                	addiw	a0,a0,1
ffffffffc0201fbe:	fef74ee3          	blt	a4,a5,ffffffffc0201fba <kmalloc+0x2c>
ffffffffc0201fc2:	c088                	sw	a0,0(s1)
ffffffffc0201fc4:	e4dff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201fc8:	e488                	sd	a0,8(s1)
ffffffffc0201fca:	842a                	mv	s0,a0
ffffffffc0201fcc:	c525                	beqz	a0,ffffffffc0202034 <kmalloc+0xa6>
ffffffffc0201fce:	100027f3          	csrr	a5,sstatus
ffffffffc0201fd2:	8b89                	andi	a5,a5,2
ffffffffc0201fd4:	ef8d                	bnez	a5,ffffffffc020200e <kmalloc+0x80>
ffffffffc0201fd6:	00095797          	auipc	a5,0x95
ffffffffc0201fda:	8b278793          	addi	a5,a5,-1870 # ffffffffc0296888 <bigblocks>
ffffffffc0201fde:	6398                	ld	a4,0(a5)
ffffffffc0201fe0:	e384                	sd	s1,0(a5)
ffffffffc0201fe2:	e898                	sd	a4,16(s1)
ffffffffc0201fe4:	60e2                	ld	ra,24(sp)
ffffffffc0201fe6:	8522                	mv	a0,s0
ffffffffc0201fe8:	6442                	ld	s0,16(sp)
ffffffffc0201fea:	64a2                	ld	s1,8(sp)
ffffffffc0201fec:	6902                	ld	s2,0(sp)
ffffffffc0201fee:	6105                	addi	sp,sp,32
ffffffffc0201ff0:	8082                	ret
ffffffffc0201ff2:	0541                	addi	a0,a0,16
ffffffffc0201ff4:	e81ff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201ff8:	01050413          	addi	s0,a0,16
ffffffffc0201ffc:	f565                	bnez	a0,ffffffffc0201fe4 <kmalloc+0x56>
ffffffffc0201ffe:	4401                	li	s0,0
ffffffffc0202000:	60e2                	ld	ra,24(sp)
ffffffffc0202002:	8522                	mv	a0,s0
ffffffffc0202004:	6442                	ld	s0,16(sp)
ffffffffc0202006:	64a2                	ld	s1,8(sp)
ffffffffc0202008:	6902                	ld	s2,0(sp)
ffffffffc020200a:	6105                	addi	sp,sp,32
ffffffffc020200c:	8082                	ret
ffffffffc020200e:	c65fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202012:	00095797          	auipc	a5,0x95
ffffffffc0202016:	87678793          	addi	a5,a5,-1930 # ffffffffc0296888 <bigblocks>
ffffffffc020201a:	6398                	ld	a4,0(a5)
ffffffffc020201c:	e384                	sd	s1,0(a5)
ffffffffc020201e:	e898                	sd	a4,16(s1)
ffffffffc0202020:	c4dfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202024:	6480                	ld	s0,8(s1)
ffffffffc0202026:	60e2                	ld	ra,24(sp)
ffffffffc0202028:	64a2                	ld	s1,8(sp)
ffffffffc020202a:	8522                	mv	a0,s0
ffffffffc020202c:	6442                	ld	s0,16(sp)
ffffffffc020202e:	6902                	ld	s2,0(sp)
ffffffffc0202030:	6105                	addi	sp,sp,32
ffffffffc0202032:	8082                	ret
ffffffffc0202034:	45e1                	li	a1,24
ffffffffc0202036:	8526                	mv	a0,s1
ffffffffc0202038:	d25ff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc020203c:	b765                	j	ffffffffc0201fe4 <kmalloc+0x56>

ffffffffc020203e <kfree>:
ffffffffc020203e:	c169                	beqz	a0,ffffffffc0202100 <kfree+0xc2>
ffffffffc0202040:	1101                	addi	sp,sp,-32
ffffffffc0202042:	e822                	sd	s0,16(sp)
ffffffffc0202044:	ec06                	sd	ra,24(sp)
ffffffffc0202046:	e426                	sd	s1,8(sp)
ffffffffc0202048:	03451793          	slli	a5,a0,0x34
ffffffffc020204c:	842a                	mv	s0,a0
ffffffffc020204e:	e3d9                	bnez	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202050:	100027f3          	csrr	a5,sstatus
ffffffffc0202054:	8b89                	andi	a5,a5,2
ffffffffc0202056:	e7d9                	bnez	a5,ffffffffc02020e4 <kfree+0xa6>
ffffffffc0202058:	00095797          	auipc	a5,0x95
ffffffffc020205c:	8307b783          	ld	a5,-2000(a5) # ffffffffc0296888 <bigblocks>
ffffffffc0202060:	4601                	li	a2,0
ffffffffc0202062:	cbad                	beqz	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202064:	00095697          	auipc	a3,0x95
ffffffffc0202068:	82468693          	addi	a3,a3,-2012 # ffffffffc0296888 <bigblocks>
ffffffffc020206c:	a021                	j	ffffffffc0202074 <kfree+0x36>
ffffffffc020206e:	01048693          	addi	a3,s1,16
ffffffffc0202072:	c3a5                	beqz	a5,ffffffffc02020d2 <kfree+0x94>
ffffffffc0202074:	6798                	ld	a4,8(a5)
ffffffffc0202076:	84be                	mv	s1,a5
ffffffffc0202078:	6b9c                	ld	a5,16(a5)
ffffffffc020207a:	fe871ae3          	bne	a4,s0,ffffffffc020206e <kfree+0x30>
ffffffffc020207e:	e29c                	sd	a5,0(a3)
ffffffffc0202080:	ee2d                	bnez	a2,ffffffffc02020fa <kfree+0xbc>
ffffffffc0202082:	c02007b7          	lui	a5,0xc0200
ffffffffc0202086:	4098                	lw	a4,0(s1)
ffffffffc0202088:	08f46963          	bltu	s0,a5,ffffffffc020211a <kfree+0xdc>
ffffffffc020208c:	00095697          	auipc	a3,0x95
ffffffffc0202090:	82c6b683          	ld	a3,-2004(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202094:	8c15                	sub	s0,s0,a3
ffffffffc0202096:	8031                	srli	s0,s0,0xc
ffffffffc0202098:	00095797          	auipc	a5,0x95
ffffffffc020209c:	8087b783          	ld	a5,-2040(a5) # ffffffffc02968a0 <npage>
ffffffffc02020a0:	06f47163          	bgeu	s0,a5,ffffffffc0202102 <kfree+0xc4>
ffffffffc02020a4:	0000d517          	auipc	a0,0xd
ffffffffc02020a8:	5dc53503          	ld	a0,1500(a0) # ffffffffc020f680 <nbase>
ffffffffc02020ac:	8c09                	sub	s0,s0,a0
ffffffffc02020ae:	041a                	slli	s0,s0,0x6
ffffffffc02020b0:	00094517          	auipc	a0,0x94
ffffffffc02020b4:	7f853503          	ld	a0,2040(a0) # ffffffffc02968a8 <pages>
ffffffffc02020b8:	4585                	li	a1,1
ffffffffc02020ba:	9522                	add	a0,a0,s0
ffffffffc02020bc:	00e595bb          	sllw	a1,a1,a4
ffffffffc02020c0:	0ea000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02020c4:	6442                	ld	s0,16(sp)
ffffffffc02020c6:	60e2                	ld	ra,24(sp)
ffffffffc02020c8:	8526                	mv	a0,s1
ffffffffc02020ca:	64a2                	ld	s1,8(sp)
ffffffffc02020cc:	45e1                	li	a1,24
ffffffffc02020ce:	6105                	addi	sp,sp,32
ffffffffc02020d0:	b171                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020d2:	e20d                	bnez	a2,ffffffffc02020f4 <kfree+0xb6>
ffffffffc02020d4:	ff040513          	addi	a0,s0,-16
ffffffffc02020d8:	6442                	ld	s0,16(sp)
ffffffffc02020da:	60e2                	ld	ra,24(sp)
ffffffffc02020dc:	64a2                	ld	s1,8(sp)
ffffffffc02020de:	4581                	li	a1,0
ffffffffc02020e0:	6105                	addi	sp,sp,32
ffffffffc02020e2:	b9ad                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020e4:	b8ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02020e8:	00094797          	auipc	a5,0x94
ffffffffc02020ec:	7a07b783          	ld	a5,1952(a5) # ffffffffc0296888 <bigblocks>
ffffffffc02020f0:	4605                	li	a2,1
ffffffffc02020f2:	fbad                	bnez	a5,ffffffffc0202064 <kfree+0x26>
ffffffffc02020f4:	b79fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020f8:	bff1                	j	ffffffffc02020d4 <kfree+0x96>
ffffffffc02020fa:	b73fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020fe:	b751                	j	ffffffffc0202082 <kfree+0x44>
ffffffffc0202100:	8082                	ret
ffffffffc0202102:	0000a617          	auipc	a2,0xa
ffffffffc0202106:	38660613          	addi	a2,a2,902 # ffffffffc020c488 <default_pmm_manager+0x108>
ffffffffc020210a:	06900593          	li	a1,105
ffffffffc020210e:	0000a517          	auipc	a0,0xa
ffffffffc0202112:	2d250513          	addi	a0,a0,722 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0202116:	b88fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020211a:	86a2                	mv	a3,s0
ffffffffc020211c:	0000a617          	auipc	a2,0xa
ffffffffc0202120:	34460613          	addi	a2,a2,836 # ffffffffc020c460 <default_pmm_manager+0xe0>
ffffffffc0202124:	07700593          	li	a1,119
ffffffffc0202128:	0000a517          	auipc	a0,0xa
ffffffffc020212c:	2b850513          	addi	a0,a0,696 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0202130:	b6efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202134 <pa2page.part.0>:
ffffffffc0202134:	1141                	addi	sp,sp,-16
ffffffffc0202136:	0000a617          	auipc	a2,0xa
ffffffffc020213a:	35260613          	addi	a2,a2,850 # ffffffffc020c488 <default_pmm_manager+0x108>
ffffffffc020213e:	06900593          	li	a1,105
ffffffffc0202142:	0000a517          	auipc	a0,0xa
ffffffffc0202146:	29e50513          	addi	a0,a0,670 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc020214a:	e406                	sd	ra,8(sp)
ffffffffc020214c:	b52fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202150 <pte2page.part.0>:
ffffffffc0202150:	1141                	addi	sp,sp,-16
ffffffffc0202152:	0000a617          	auipc	a2,0xa
ffffffffc0202156:	35660613          	addi	a2,a2,854 # ffffffffc020c4a8 <default_pmm_manager+0x128>
ffffffffc020215a:	07f00593          	li	a1,127
ffffffffc020215e:	0000a517          	auipc	a0,0xa
ffffffffc0202162:	28250513          	addi	a0,a0,642 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0202166:	e406                	sd	ra,8(sp)
ffffffffc0202168:	b36fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020216c <alloc_pages>:
ffffffffc020216c:	100027f3          	csrr	a5,sstatus
ffffffffc0202170:	8b89                	andi	a5,a5,2
ffffffffc0202172:	e799                	bnez	a5,ffffffffc0202180 <alloc_pages+0x14>
ffffffffc0202174:	00094797          	auipc	a5,0x94
ffffffffc0202178:	73c7b783          	ld	a5,1852(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020217c:	6f9c                	ld	a5,24(a5)
ffffffffc020217e:	8782                	jr	a5
ffffffffc0202180:	1141                	addi	sp,sp,-16
ffffffffc0202182:	e406                	sd	ra,8(sp)
ffffffffc0202184:	e022                	sd	s0,0(sp)
ffffffffc0202186:	842a                	mv	s0,a0
ffffffffc0202188:	aebfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020218c:	00094797          	auipc	a5,0x94
ffffffffc0202190:	7247b783          	ld	a5,1828(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202194:	6f9c                	ld	a5,24(a5)
ffffffffc0202196:	8522                	mv	a0,s0
ffffffffc0202198:	9782                	jalr	a5
ffffffffc020219a:	842a                	mv	s0,a0
ffffffffc020219c:	ad1fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02021a0:	60a2                	ld	ra,8(sp)
ffffffffc02021a2:	8522                	mv	a0,s0
ffffffffc02021a4:	6402                	ld	s0,0(sp)
ffffffffc02021a6:	0141                	addi	sp,sp,16
ffffffffc02021a8:	8082                	ret

ffffffffc02021aa <free_pages>:
ffffffffc02021aa:	100027f3          	csrr	a5,sstatus
ffffffffc02021ae:	8b89                	andi	a5,a5,2
ffffffffc02021b0:	e799                	bnez	a5,ffffffffc02021be <free_pages+0x14>
ffffffffc02021b2:	00094797          	auipc	a5,0x94
ffffffffc02021b6:	6fe7b783          	ld	a5,1790(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021ba:	739c                	ld	a5,32(a5)
ffffffffc02021bc:	8782                	jr	a5
ffffffffc02021be:	1101                	addi	sp,sp,-32
ffffffffc02021c0:	ec06                	sd	ra,24(sp)
ffffffffc02021c2:	e822                	sd	s0,16(sp)
ffffffffc02021c4:	e426                	sd	s1,8(sp)
ffffffffc02021c6:	842a                	mv	s0,a0
ffffffffc02021c8:	84ae                	mv	s1,a1
ffffffffc02021ca:	aa9fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02021ce:	00094797          	auipc	a5,0x94
ffffffffc02021d2:	6e27b783          	ld	a5,1762(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021d6:	739c                	ld	a5,32(a5)
ffffffffc02021d8:	85a6                	mv	a1,s1
ffffffffc02021da:	8522                	mv	a0,s0
ffffffffc02021dc:	9782                	jalr	a5
ffffffffc02021de:	6442                	ld	s0,16(sp)
ffffffffc02021e0:	60e2                	ld	ra,24(sp)
ffffffffc02021e2:	64a2                	ld	s1,8(sp)
ffffffffc02021e4:	6105                	addi	sp,sp,32
ffffffffc02021e6:	a87fe06f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02021ea <nr_free_pages>:
ffffffffc02021ea:	100027f3          	csrr	a5,sstatus
ffffffffc02021ee:	8b89                	andi	a5,a5,2
ffffffffc02021f0:	e799                	bnez	a5,ffffffffc02021fe <nr_free_pages+0x14>
ffffffffc02021f2:	00094797          	auipc	a5,0x94
ffffffffc02021f6:	6be7b783          	ld	a5,1726(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021fa:	779c                	ld	a5,40(a5)
ffffffffc02021fc:	8782                	jr	a5
ffffffffc02021fe:	1141                	addi	sp,sp,-16
ffffffffc0202200:	e406                	sd	ra,8(sp)
ffffffffc0202202:	e022                	sd	s0,0(sp)
ffffffffc0202204:	a6ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202208:	00094797          	auipc	a5,0x94
ffffffffc020220c:	6a87b783          	ld	a5,1704(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202210:	779c                	ld	a5,40(a5)
ffffffffc0202212:	9782                	jalr	a5
ffffffffc0202214:	842a                	mv	s0,a0
ffffffffc0202216:	a57fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020221a:	60a2                	ld	ra,8(sp)
ffffffffc020221c:	8522                	mv	a0,s0
ffffffffc020221e:	6402                	ld	s0,0(sp)
ffffffffc0202220:	0141                	addi	sp,sp,16
ffffffffc0202222:	8082                	ret

ffffffffc0202224 <get_pte>:
ffffffffc0202224:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0202228:	1ff7f793          	andi	a5,a5,511
ffffffffc020222c:	7139                	addi	sp,sp,-64
ffffffffc020222e:	078e                	slli	a5,a5,0x3
ffffffffc0202230:	f426                	sd	s1,40(sp)
ffffffffc0202232:	00f504b3          	add	s1,a0,a5
ffffffffc0202236:	6094                	ld	a3,0(s1)
ffffffffc0202238:	f04a                	sd	s2,32(sp)
ffffffffc020223a:	ec4e                	sd	s3,24(sp)
ffffffffc020223c:	e852                	sd	s4,16(sp)
ffffffffc020223e:	fc06                	sd	ra,56(sp)
ffffffffc0202240:	f822                	sd	s0,48(sp)
ffffffffc0202242:	e456                	sd	s5,8(sp)
ffffffffc0202244:	e05a                	sd	s6,0(sp)
ffffffffc0202246:	0016f793          	andi	a5,a3,1
ffffffffc020224a:	892e                	mv	s2,a1
ffffffffc020224c:	8a32                	mv	s4,a2
ffffffffc020224e:	00094997          	auipc	s3,0x94
ffffffffc0202252:	65298993          	addi	s3,s3,1618 # ffffffffc02968a0 <npage>
ffffffffc0202256:	efbd                	bnez	a5,ffffffffc02022d4 <get_pte+0xb0>
ffffffffc0202258:	14060c63          	beqz	a2,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020225c:	100027f3          	csrr	a5,sstatus
ffffffffc0202260:	8b89                	andi	a5,a5,2
ffffffffc0202262:	14079963          	bnez	a5,ffffffffc02023b4 <get_pte+0x190>
ffffffffc0202266:	00094797          	auipc	a5,0x94
ffffffffc020226a:	64a7b783          	ld	a5,1610(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020226e:	6f9c                	ld	a5,24(a5)
ffffffffc0202270:	4505                	li	a0,1
ffffffffc0202272:	9782                	jalr	a5
ffffffffc0202274:	842a                	mv	s0,a0
ffffffffc0202276:	12040d63          	beqz	s0,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020227a:	00094b17          	auipc	s6,0x94
ffffffffc020227e:	62eb0b13          	addi	s6,s6,1582 # ffffffffc02968a8 <pages>
ffffffffc0202282:	000b3503          	ld	a0,0(s6)
ffffffffc0202286:	00080ab7          	lui	s5,0x80
ffffffffc020228a:	00094997          	auipc	s3,0x94
ffffffffc020228e:	61698993          	addi	s3,s3,1558 # ffffffffc02968a0 <npage>
ffffffffc0202292:	40a40533          	sub	a0,s0,a0
ffffffffc0202296:	8519                	srai	a0,a0,0x6
ffffffffc0202298:	9556                	add	a0,a0,s5
ffffffffc020229a:	0009b703          	ld	a4,0(s3)
ffffffffc020229e:	00c51793          	slli	a5,a0,0xc
ffffffffc02022a2:	4685                	li	a3,1
ffffffffc02022a4:	c014                	sw	a3,0(s0)
ffffffffc02022a6:	83b1                	srli	a5,a5,0xc
ffffffffc02022a8:	0532                	slli	a0,a0,0xc
ffffffffc02022aa:	16e7f763          	bgeu	a5,a4,ffffffffc0202418 <get_pte+0x1f4>
ffffffffc02022ae:	00094797          	auipc	a5,0x94
ffffffffc02022b2:	60a7b783          	ld	a5,1546(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022b6:	6605                	lui	a2,0x1
ffffffffc02022b8:	4581                	li	a1,0
ffffffffc02022ba:	953e                	add	a0,a0,a5
ffffffffc02022bc:	0fa090ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc02022c0:	000b3683          	ld	a3,0(s6)
ffffffffc02022c4:	40d406b3          	sub	a3,s0,a3
ffffffffc02022c8:	8699                	srai	a3,a3,0x6
ffffffffc02022ca:	96d6                	add	a3,a3,s5
ffffffffc02022cc:	06aa                	slli	a3,a3,0xa
ffffffffc02022ce:	0116e693          	ori	a3,a3,17
ffffffffc02022d2:	e094                	sd	a3,0(s1)
ffffffffc02022d4:	77fd                	lui	a5,0xfffff
ffffffffc02022d6:	068a                	slli	a3,a3,0x2
ffffffffc02022d8:	0009b703          	ld	a4,0(s3)
ffffffffc02022dc:	8efd                	and	a3,a3,a5
ffffffffc02022de:	00c6d793          	srli	a5,a3,0xc
ffffffffc02022e2:	10e7ff63          	bgeu	a5,a4,ffffffffc0202400 <get_pte+0x1dc>
ffffffffc02022e6:	00094a97          	auipc	s5,0x94
ffffffffc02022ea:	5d2a8a93          	addi	s5,s5,1490 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022ee:	000ab403          	ld	s0,0(s5)
ffffffffc02022f2:	01595793          	srli	a5,s2,0x15
ffffffffc02022f6:	1ff7f793          	andi	a5,a5,511
ffffffffc02022fa:	96a2                	add	a3,a3,s0
ffffffffc02022fc:	00379413          	slli	s0,a5,0x3
ffffffffc0202300:	9436                	add	s0,s0,a3
ffffffffc0202302:	6014                	ld	a3,0(s0)
ffffffffc0202304:	0016f793          	andi	a5,a3,1
ffffffffc0202308:	ebad                	bnez	a5,ffffffffc020237a <get_pte+0x156>
ffffffffc020230a:	0a0a0363          	beqz	s4,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020230e:	100027f3          	csrr	a5,sstatus
ffffffffc0202312:	8b89                	andi	a5,a5,2
ffffffffc0202314:	efcd                	bnez	a5,ffffffffc02023ce <get_pte+0x1aa>
ffffffffc0202316:	00094797          	auipc	a5,0x94
ffffffffc020231a:	59a7b783          	ld	a5,1434(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020231e:	6f9c                	ld	a5,24(a5)
ffffffffc0202320:	4505                	li	a0,1
ffffffffc0202322:	9782                	jalr	a5
ffffffffc0202324:	84aa                	mv	s1,a0
ffffffffc0202326:	c4c9                	beqz	s1,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc0202328:	00094b17          	auipc	s6,0x94
ffffffffc020232c:	580b0b13          	addi	s6,s6,1408 # ffffffffc02968a8 <pages>
ffffffffc0202330:	000b3503          	ld	a0,0(s6)
ffffffffc0202334:	00080a37          	lui	s4,0x80
ffffffffc0202338:	0009b703          	ld	a4,0(s3)
ffffffffc020233c:	40a48533          	sub	a0,s1,a0
ffffffffc0202340:	8519                	srai	a0,a0,0x6
ffffffffc0202342:	9552                	add	a0,a0,s4
ffffffffc0202344:	00c51793          	slli	a5,a0,0xc
ffffffffc0202348:	4685                	li	a3,1
ffffffffc020234a:	c094                	sw	a3,0(s1)
ffffffffc020234c:	83b1                	srli	a5,a5,0xc
ffffffffc020234e:	0532                	slli	a0,a0,0xc
ffffffffc0202350:	0ee7f163          	bgeu	a5,a4,ffffffffc0202432 <get_pte+0x20e>
ffffffffc0202354:	000ab783          	ld	a5,0(s5)
ffffffffc0202358:	6605                	lui	a2,0x1
ffffffffc020235a:	4581                	li	a1,0
ffffffffc020235c:	953e                	add	a0,a0,a5
ffffffffc020235e:	058090ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0202362:	000b3683          	ld	a3,0(s6)
ffffffffc0202366:	40d486b3          	sub	a3,s1,a3
ffffffffc020236a:	8699                	srai	a3,a3,0x6
ffffffffc020236c:	96d2                	add	a3,a3,s4
ffffffffc020236e:	06aa                	slli	a3,a3,0xa
ffffffffc0202370:	0116e693          	ori	a3,a3,17
ffffffffc0202374:	e014                	sd	a3,0(s0)
ffffffffc0202376:	0009b703          	ld	a4,0(s3)
ffffffffc020237a:	068a                	slli	a3,a3,0x2
ffffffffc020237c:	757d                	lui	a0,0xfffff
ffffffffc020237e:	8ee9                	and	a3,a3,a0
ffffffffc0202380:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202384:	06e7f263          	bgeu	a5,a4,ffffffffc02023e8 <get_pte+0x1c4>
ffffffffc0202388:	000ab503          	ld	a0,0(s5)
ffffffffc020238c:	00c95913          	srli	s2,s2,0xc
ffffffffc0202390:	1ff97913          	andi	s2,s2,511
ffffffffc0202394:	96aa                	add	a3,a3,a0
ffffffffc0202396:	00391513          	slli	a0,s2,0x3
ffffffffc020239a:	9536                	add	a0,a0,a3
ffffffffc020239c:	70e2                	ld	ra,56(sp)
ffffffffc020239e:	7442                	ld	s0,48(sp)
ffffffffc02023a0:	74a2                	ld	s1,40(sp)
ffffffffc02023a2:	7902                	ld	s2,32(sp)
ffffffffc02023a4:	69e2                	ld	s3,24(sp)
ffffffffc02023a6:	6a42                	ld	s4,16(sp)
ffffffffc02023a8:	6aa2                	ld	s5,8(sp)
ffffffffc02023aa:	6b02                	ld	s6,0(sp)
ffffffffc02023ac:	6121                	addi	sp,sp,64
ffffffffc02023ae:	8082                	ret
ffffffffc02023b0:	4501                	li	a0,0
ffffffffc02023b2:	b7ed                	j	ffffffffc020239c <get_pte+0x178>
ffffffffc02023b4:	8bffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023b8:	00094797          	auipc	a5,0x94
ffffffffc02023bc:	4f87b783          	ld	a5,1272(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023c0:	6f9c                	ld	a5,24(a5)
ffffffffc02023c2:	4505                	li	a0,1
ffffffffc02023c4:	9782                	jalr	a5
ffffffffc02023c6:	842a                	mv	s0,a0
ffffffffc02023c8:	8a5fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023cc:	b56d                	j	ffffffffc0202276 <get_pte+0x52>
ffffffffc02023ce:	8a5fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023d2:	00094797          	auipc	a5,0x94
ffffffffc02023d6:	4de7b783          	ld	a5,1246(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023da:	6f9c                	ld	a5,24(a5)
ffffffffc02023dc:	4505                	li	a0,1
ffffffffc02023de:	9782                	jalr	a5
ffffffffc02023e0:	84aa                	mv	s1,a0
ffffffffc02023e2:	88bfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023e6:	b781                	j	ffffffffc0202326 <get_pte+0x102>
ffffffffc02023e8:	0000a617          	auipc	a2,0xa
ffffffffc02023ec:	fd060613          	addi	a2,a2,-48 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc02023f0:	13200593          	li	a1,306
ffffffffc02023f4:	0000a517          	auipc	a0,0xa
ffffffffc02023f8:	0dc50513          	addi	a0,a0,220 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02023fc:	8a2fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202400:	0000a617          	auipc	a2,0xa
ffffffffc0202404:	fb860613          	addi	a2,a2,-72 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc0202408:	12500593          	li	a1,293
ffffffffc020240c:	0000a517          	auipc	a0,0xa
ffffffffc0202410:	0c450513          	addi	a0,a0,196 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0202414:	88afe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202418:	86aa                	mv	a3,a0
ffffffffc020241a:	0000a617          	auipc	a2,0xa
ffffffffc020241e:	f9e60613          	addi	a2,a2,-98 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc0202422:	12100593          	li	a1,289
ffffffffc0202426:	0000a517          	auipc	a0,0xa
ffffffffc020242a:	0aa50513          	addi	a0,a0,170 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020242e:	870fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202432:	86aa                	mv	a3,a0
ffffffffc0202434:	0000a617          	auipc	a2,0xa
ffffffffc0202438:	f8460613          	addi	a2,a2,-124 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc020243c:	12f00593          	li	a1,303
ffffffffc0202440:	0000a517          	auipc	a0,0xa
ffffffffc0202444:	09050513          	addi	a0,a0,144 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0202448:	856fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020244c <boot_map_segment>:
ffffffffc020244c:	6785                	lui	a5,0x1
ffffffffc020244e:	7139                	addi	sp,sp,-64
ffffffffc0202450:	00d5c833          	xor	a6,a1,a3
ffffffffc0202454:	17fd                	addi	a5,a5,-1
ffffffffc0202456:	fc06                	sd	ra,56(sp)
ffffffffc0202458:	f822                	sd	s0,48(sp)
ffffffffc020245a:	f426                	sd	s1,40(sp)
ffffffffc020245c:	f04a                	sd	s2,32(sp)
ffffffffc020245e:	ec4e                	sd	s3,24(sp)
ffffffffc0202460:	e852                	sd	s4,16(sp)
ffffffffc0202462:	e456                	sd	s5,8(sp)
ffffffffc0202464:	00f87833          	and	a6,a6,a5
ffffffffc0202468:	08081563          	bnez	a6,ffffffffc02024f2 <boot_map_segment+0xa6>
ffffffffc020246c:	00f5f4b3          	and	s1,a1,a5
ffffffffc0202470:	963e                	add	a2,a2,a5
ffffffffc0202472:	94b2                	add	s1,s1,a2
ffffffffc0202474:	797d                	lui	s2,0xfffff
ffffffffc0202476:	80b1                	srli	s1,s1,0xc
ffffffffc0202478:	0125f5b3          	and	a1,a1,s2
ffffffffc020247c:	0126f6b3          	and	a3,a3,s2
ffffffffc0202480:	c0a1                	beqz	s1,ffffffffc02024c0 <boot_map_segment+0x74>
ffffffffc0202482:	00176713          	ori	a4,a4,1
ffffffffc0202486:	04b2                	slli	s1,s1,0xc
ffffffffc0202488:	02071993          	slli	s3,a4,0x20
ffffffffc020248c:	8a2a                	mv	s4,a0
ffffffffc020248e:	842e                	mv	s0,a1
ffffffffc0202490:	94ae                	add	s1,s1,a1
ffffffffc0202492:	40b68933          	sub	s2,a3,a1
ffffffffc0202496:	0209d993          	srli	s3,s3,0x20
ffffffffc020249a:	6a85                	lui	s5,0x1
ffffffffc020249c:	4605                	li	a2,1
ffffffffc020249e:	85a2                	mv	a1,s0
ffffffffc02024a0:	8552                	mv	a0,s4
ffffffffc02024a2:	d83ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02024a6:	008907b3          	add	a5,s2,s0
ffffffffc02024aa:	c505                	beqz	a0,ffffffffc02024d2 <boot_map_segment+0x86>
ffffffffc02024ac:	83b1                	srli	a5,a5,0xc
ffffffffc02024ae:	07aa                	slli	a5,a5,0xa
ffffffffc02024b0:	0137e7b3          	or	a5,a5,s3
ffffffffc02024b4:	0017e793          	ori	a5,a5,1
ffffffffc02024b8:	e11c                	sd	a5,0(a0)
ffffffffc02024ba:	9456                	add	s0,s0,s5
ffffffffc02024bc:	fe8490e3          	bne	s1,s0,ffffffffc020249c <boot_map_segment+0x50>
ffffffffc02024c0:	70e2                	ld	ra,56(sp)
ffffffffc02024c2:	7442                	ld	s0,48(sp)
ffffffffc02024c4:	74a2                	ld	s1,40(sp)
ffffffffc02024c6:	7902                	ld	s2,32(sp)
ffffffffc02024c8:	69e2                	ld	s3,24(sp)
ffffffffc02024ca:	6a42                	ld	s4,16(sp)
ffffffffc02024cc:	6aa2                	ld	s5,8(sp)
ffffffffc02024ce:	6121                	addi	sp,sp,64
ffffffffc02024d0:	8082                	ret
ffffffffc02024d2:	0000a697          	auipc	a3,0xa
ffffffffc02024d6:	02668693          	addi	a3,a3,38 # ffffffffc020c4f8 <default_pmm_manager+0x178>
ffffffffc02024da:	00009617          	auipc	a2,0x9
ffffffffc02024de:	3be60613          	addi	a2,a2,958 # ffffffffc020b898 <commands+0x210>
ffffffffc02024e2:	09c00593          	li	a1,156
ffffffffc02024e6:	0000a517          	auipc	a0,0xa
ffffffffc02024ea:	fea50513          	addi	a0,a0,-22 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02024ee:	fb1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024f2:	0000a697          	auipc	a3,0xa
ffffffffc02024f6:	fee68693          	addi	a3,a3,-18 # ffffffffc020c4e0 <default_pmm_manager+0x160>
ffffffffc02024fa:	00009617          	auipc	a2,0x9
ffffffffc02024fe:	39e60613          	addi	a2,a2,926 # ffffffffc020b898 <commands+0x210>
ffffffffc0202502:	09500593          	li	a1,149
ffffffffc0202506:	0000a517          	auipc	a0,0xa
ffffffffc020250a:	fca50513          	addi	a0,a0,-54 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020250e:	f91fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202512 <get_page>:
ffffffffc0202512:	1141                	addi	sp,sp,-16
ffffffffc0202514:	e022                	sd	s0,0(sp)
ffffffffc0202516:	8432                	mv	s0,a2
ffffffffc0202518:	4601                	li	a2,0
ffffffffc020251a:	e406                	sd	ra,8(sp)
ffffffffc020251c:	d09ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202520:	c011                	beqz	s0,ffffffffc0202524 <get_page+0x12>
ffffffffc0202522:	e008                	sd	a0,0(s0)
ffffffffc0202524:	c511                	beqz	a0,ffffffffc0202530 <get_page+0x1e>
ffffffffc0202526:	611c                	ld	a5,0(a0)
ffffffffc0202528:	4501                	li	a0,0
ffffffffc020252a:	0017f713          	andi	a4,a5,1
ffffffffc020252e:	e709                	bnez	a4,ffffffffc0202538 <get_page+0x26>
ffffffffc0202530:	60a2                	ld	ra,8(sp)
ffffffffc0202532:	6402                	ld	s0,0(sp)
ffffffffc0202534:	0141                	addi	sp,sp,16
ffffffffc0202536:	8082                	ret
ffffffffc0202538:	078a                	slli	a5,a5,0x2
ffffffffc020253a:	83b1                	srli	a5,a5,0xc
ffffffffc020253c:	00094717          	auipc	a4,0x94
ffffffffc0202540:	36473703          	ld	a4,868(a4) # ffffffffc02968a0 <npage>
ffffffffc0202544:	00e7ff63          	bgeu	a5,a4,ffffffffc0202562 <get_page+0x50>
ffffffffc0202548:	60a2                	ld	ra,8(sp)
ffffffffc020254a:	6402                	ld	s0,0(sp)
ffffffffc020254c:	fff80537          	lui	a0,0xfff80
ffffffffc0202550:	97aa                	add	a5,a5,a0
ffffffffc0202552:	079a                	slli	a5,a5,0x6
ffffffffc0202554:	00094517          	auipc	a0,0x94
ffffffffc0202558:	35453503          	ld	a0,852(a0) # ffffffffc02968a8 <pages>
ffffffffc020255c:	953e                	add	a0,a0,a5
ffffffffc020255e:	0141                	addi	sp,sp,16
ffffffffc0202560:	8082                	ret
ffffffffc0202562:	bd3ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202566 <unmap_range>:
ffffffffc0202566:	7159                	addi	sp,sp,-112
ffffffffc0202568:	00c5e7b3          	or	a5,a1,a2
ffffffffc020256c:	f486                	sd	ra,104(sp)
ffffffffc020256e:	f0a2                	sd	s0,96(sp)
ffffffffc0202570:	eca6                	sd	s1,88(sp)
ffffffffc0202572:	e8ca                	sd	s2,80(sp)
ffffffffc0202574:	e4ce                	sd	s3,72(sp)
ffffffffc0202576:	e0d2                	sd	s4,64(sp)
ffffffffc0202578:	fc56                	sd	s5,56(sp)
ffffffffc020257a:	f85a                	sd	s6,48(sp)
ffffffffc020257c:	f45e                	sd	s7,40(sp)
ffffffffc020257e:	f062                	sd	s8,32(sp)
ffffffffc0202580:	ec66                	sd	s9,24(sp)
ffffffffc0202582:	e86a                	sd	s10,16(sp)
ffffffffc0202584:	17d2                	slli	a5,a5,0x34
ffffffffc0202586:	e3ed                	bnez	a5,ffffffffc0202668 <unmap_range+0x102>
ffffffffc0202588:	002007b7          	lui	a5,0x200
ffffffffc020258c:	842e                	mv	s0,a1
ffffffffc020258e:	0ef5ed63          	bltu	a1,a5,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202592:	8932                	mv	s2,a2
ffffffffc0202594:	0ec5fa63          	bgeu	a1,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202598:	4785                	li	a5,1
ffffffffc020259a:	07fe                	slli	a5,a5,0x1f
ffffffffc020259c:	0ec7e663          	bltu	a5,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc02025a0:	89aa                	mv	s3,a0
ffffffffc02025a2:	6a05                	lui	s4,0x1
ffffffffc02025a4:	00094c97          	auipc	s9,0x94
ffffffffc02025a8:	2fcc8c93          	addi	s9,s9,764 # ffffffffc02968a0 <npage>
ffffffffc02025ac:	00094c17          	auipc	s8,0x94
ffffffffc02025b0:	2fcc0c13          	addi	s8,s8,764 # ffffffffc02968a8 <pages>
ffffffffc02025b4:	fff80bb7          	lui	s7,0xfff80
ffffffffc02025b8:	00094d17          	auipc	s10,0x94
ffffffffc02025bc:	2f8d0d13          	addi	s10,s10,760 # ffffffffc02968b0 <pmm_manager>
ffffffffc02025c0:	00200b37          	lui	s6,0x200
ffffffffc02025c4:	ffe00ab7          	lui	s5,0xffe00
ffffffffc02025c8:	4601                	li	a2,0
ffffffffc02025ca:	85a2                	mv	a1,s0
ffffffffc02025cc:	854e                	mv	a0,s3
ffffffffc02025ce:	c57ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02025d2:	84aa                	mv	s1,a0
ffffffffc02025d4:	cd29                	beqz	a0,ffffffffc020262e <unmap_range+0xc8>
ffffffffc02025d6:	611c                	ld	a5,0(a0)
ffffffffc02025d8:	e395                	bnez	a5,ffffffffc02025fc <unmap_range+0x96>
ffffffffc02025da:	9452                	add	s0,s0,s4
ffffffffc02025dc:	ff2466e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc02025e0:	70a6                	ld	ra,104(sp)
ffffffffc02025e2:	7406                	ld	s0,96(sp)
ffffffffc02025e4:	64e6                	ld	s1,88(sp)
ffffffffc02025e6:	6946                	ld	s2,80(sp)
ffffffffc02025e8:	69a6                	ld	s3,72(sp)
ffffffffc02025ea:	6a06                	ld	s4,64(sp)
ffffffffc02025ec:	7ae2                	ld	s5,56(sp)
ffffffffc02025ee:	7b42                	ld	s6,48(sp)
ffffffffc02025f0:	7ba2                	ld	s7,40(sp)
ffffffffc02025f2:	7c02                	ld	s8,32(sp)
ffffffffc02025f4:	6ce2                	ld	s9,24(sp)
ffffffffc02025f6:	6d42                	ld	s10,16(sp)
ffffffffc02025f8:	6165                	addi	sp,sp,112
ffffffffc02025fa:	8082                	ret
ffffffffc02025fc:	0017f713          	andi	a4,a5,1
ffffffffc0202600:	df69                	beqz	a4,ffffffffc02025da <unmap_range+0x74>
ffffffffc0202602:	000cb703          	ld	a4,0(s9)
ffffffffc0202606:	078a                	slli	a5,a5,0x2
ffffffffc0202608:	83b1                	srli	a5,a5,0xc
ffffffffc020260a:	08e7ff63          	bgeu	a5,a4,ffffffffc02026a8 <unmap_range+0x142>
ffffffffc020260e:	000c3503          	ld	a0,0(s8)
ffffffffc0202612:	97de                	add	a5,a5,s7
ffffffffc0202614:	079a                	slli	a5,a5,0x6
ffffffffc0202616:	953e                	add	a0,a0,a5
ffffffffc0202618:	411c                	lw	a5,0(a0)
ffffffffc020261a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020261e:	c118                	sw	a4,0(a0)
ffffffffc0202620:	cf11                	beqz	a4,ffffffffc020263c <unmap_range+0xd6>
ffffffffc0202622:	0004b023          	sd	zero,0(s1)
ffffffffc0202626:	12040073          	sfence.vma	s0
ffffffffc020262a:	9452                	add	s0,s0,s4
ffffffffc020262c:	bf45                	j	ffffffffc02025dc <unmap_range+0x76>
ffffffffc020262e:	945a                	add	s0,s0,s6
ffffffffc0202630:	01547433          	and	s0,s0,s5
ffffffffc0202634:	d455                	beqz	s0,ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc0202636:	f92469e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc020263a:	b75d                	j	ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc020263c:	100027f3          	csrr	a5,sstatus
ffffffffc0202640:	8b89                	andi	a5,a5,2
ffffffffc0202642:	e799                	bnez	a5,ffffffffc0202650 <unmap_range+0xea>
ffffffffc0202644:	000d3783          	ld	a5,0(s10)
ffffffffc0202648:	4585                	li	a1,1
ffffffffc020264a:	739c                	ld	a5,32(a5)
ffffffffc020264c:	9782                	jalr	a5
ffffffffc020264e:	bfd1                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202650:	e42a                	sd	a0,8(sp)
ffffffffc0202652:	e20fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202656:	000d3783          	ld	a5,0(s10)
ffffffffc020265a:	6522                	ld	a0,8(sp)
ffffffffc020265c:	4585                	li	a1,1
ffffffffc020265e:	739c                	ld	a5,32(a5)
ffffffffc0202660:	9782                	jalr	a5
ffffffffc0202662:	e0afe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202666:	bf75                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202668:	0000a697          	auipc	a3,0xa
ffffffffc020266c:	ea068693          	addi	a3,a3,-352 # ffffffffc020c508 <default_pmm_manager+0x188>
ffffffffc0202670:	00009617          	auipc	a2,0x9
ffffffffc0202674:	22860613          	addi	a2,a2,552 # ffffffffc020b898 <commands+0x210>
ffffffffc0202678:	15a00593          	li	a1,346
ffffffffc020267c:	0000a517          	auipc	a0,0xa
ffffffffc0202680:	e5450513          	addi	a0,a0,-428 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0202684:	e1bfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202688:	0000a697          	auipc	a3,0xa
ffffffffc020268c:	eb068693          	addi	a3,a3,-336 # ffffffffc020c538 <default_pmm_manager+0x1b8>
ffffffffc0202690:	00009617          	auipc	a2,0x9
ffffffffc0202694:	20860613          	addi	a2,a2,520 # ffffffffc020b898 <commands+0x210>
ffffffffc0202698:	15b00593          	li	a1,347
ffffffffc020269c:	0000a517          	auipc	a0,0xa
ffffffffc02026a0:	e3450513          	addi	a0,a0,-460 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02026a4:	dfbfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02026a8:	a8dff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02026ac <exit_range>:
ffffffffc02026ac:	7119                	addi	sp,sp,-128
ffffffffc02026ae:	00c5e7b3          	or	a5,a1,a2
ffffffffc02026b2:	fc86                	sd	ra,120(sp)
ffffffffc02026b4:	f8a2                	sd	s0,112(sp)
ffffffffc02026b6:	f4a6                	sd	s1,104(sp)
ffffffffc02026b8:	f0ca                	sd	s2,96(sp)
ffffffffc02026ba:	ecce                	sd	s3,88(sp)
ffffffffc02026bc:	e8d2                	sd	s4,80(sp)
ffffffffc02026be:	e4d6                	sd	s5,72(sp)
ffffffffc02026c0:	e0da                	sd	s6,64(sp)
ffffffffc02026c2:	fc5e                	sd	s7,56(sp)
ffffffffc02026c4:	f862                	sd	s8,48(sp)
ffffffffc02026c6:	f466                	sd	s9,40(sp)
ffffffffc02026c8:	f06a                	sd	s10,32(sp)
ffffffffc02026ca:	ec6e                	sd	s11,24(sp)
ffffffffc02026cc:	17d2                	slli	a5,a5,0x34
ffffffffc02026ce:	20079a63          	bnez	a5,ffffffffc02028e2 <exit_range+0x236>
ffffffffc02026d2:	002007b7          	lui	a5,0x200
ffffffffc02026d6:	24f5e463          	bltu	a1,a5,ffffffffc020291e <exit_range+0x272>
ffffffffc02026da:	8ab2                	mv	s5,a2
ffffffffc02026dc:	24c5f163          	bgeu	a1,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e0:	4785                	li	a5,1
ffffffffc02026e2:	07fe                	slli	a5,a5,0x1f
ffffffffc02026e4:	22c7ed63          	bltu	a5,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e8:	c00009b7          	lui	s3,0xc0000
ffffffffc02026ec:	0135f9b3          	and	s3,a1,s3
ffffffffc02026f0:	ffe00937          	lui	s2,0xffe00
ffffffffc02026f4:	400007b7          	lui	a5,0x40000
ffffffffc02026f8:	5cfd                	li	s9,-1
ffffffffc02026fa:	8c2a                	mv	s8,a0
ffffffffc02026fc:	0125f933          	and	s2,a1,s2
ffffffffc0202700:	99be                	add	s3,s3,a5
ffffffffc0202702:	00094d17          	auipc	s10,0x94
ffffffffc0202706:	19ed0d13          	addi	s10,s10,414 # ffffffffc02968a0 <npage>
ffffffffc020270a:	00ccdc93          	srli	s9,s9,0xc
ffffffffc020270e:	00094717          	auipc	a4,0x94
ffffffffc0202712:	19a70713          	addi	a4,a4,410 # ffffffffc02968a8 <pages>
ffffffffc0202716:	00094d97          	auipc	s11,0x94
ffffffffc020271a:	19ad8d93          	addi	s11,s11,410 # ffffffffc02968b0 <pmm_manager>
ffffffffc020271e:	c0000437          	lui	s0,0xc0000
ffffffffc0202722:	944e                	add	s0,s0,s3
ffffffffc0202724:	8079                	srli	s0,s0,0x1e
ffffffffc0202726:	1ff47413          	andi	s0,s0,511
ffffffffc020272a:	040e                	slli	s0,s0,0x3
ffffffffc020272c:	9462                	add	s0,s0,s8
ffffffffc020272e:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202732:	001a7793          	andi	a5,s4,1
ffffffffc0202736:	eb99                	bnez	a5,ffffffffc020274c <exit_range+0xa0>
ffffffffc0202738:	12098463          	beqz	s3,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc020273c:	400007b7          	lui	a5,0x40000
ffffffffc0202740:	97ce                	add	a5,a5,s3
ffffffffc0202742:	894e                	mv	s2,s3
ffffffffc0202744:	1159fe63          	bgeu	s3,s5,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc0202748:	89be                	mv	s3,a5
ffffffffc020274a:	bfd1                	j	ffffffffc020271e <exit_range+0x72>
ffffffffc020274c:	000d3783          	ld	a5,0(s10)
ffffffffc0202750:	0a0a                	slli	s4,s4,0x2
ffffffffc0202752:	00ca5a13          	srli	s4,s4,0xc
ffffffffc0202756:	1cfa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020275a:	fff80637          	lui	a2,0xfff80
ffffffffc020275e:	9652                	add	a2,a2,s4
ffffffffc0202760:	000806b7          	lui	a3,0x80
ffffffffc0202764:	96b2                	add	a3,a3,a2
ffffffffc0202766:	0196f5b3          	and	a1,a3,s9
ffffffffc020276a:	061a                	slli	a2,a2,0x6
ffffffffc020276c:	06b2                	slli	a3,a3,0xc
ffffffffc020276e:	18f5fa63          	bgeu	a1,a5,ffffffffc0202902 <exit_range+0x256>
ffffffffc0202772:	00094817          	auipc	a6,0x94
ffffffffc0202776:	14680813          	addi	a6,a6,326 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020277a:	00083b03          	ld	s6,0(a6)
ffffffffc020277e:	4b85                	li	s7,1
ffffffffc0202780:	fff80e37          	lui	t3,0xfff80
ffffffffc0202784:	9b36                	add	s6,s6,a3
ffffffffc0202786:	00080337          	lui	t1,0x80
ffffffffc020278a:	6885                	lui	a7,0x1
ffffffffc020278c:	a819                	j	ffffffffc02027a2 <exit_range+0xf6>
ffffffffc020278e:	4b81                	li	s7,0
ffffffffc0202790:	002007b7          	lui	a5,0x200
ffffffffc0202794:	993e                	add	s2,s2,a5
ffffffffc0202796:	08090c63          	beqz	s2,ffffffffc020282e <exit_range+0x182>
ffffffffc020279a:	09397a63          	bgeu	s2,s3,ffffffffc020282e <exit_range+0x182>
ffffffffc020279e:	0f597063          	bgeu	s2,s5,ffffffffc020287e <exit_range+0x1d2>
ffffffffc02027a2:	01595493          	srli	s1,s2,0x15
ffffffffc02027a6:	1ff4f493          	andi	s1,s1,511
ffffffffc02027aa:	048e                	slli	s1,s1,0x3
ffffffffc02027ac:	94da                	add	s1,s1,s6
ffffffffc02027ae:	609c                	ld	a5,0(s1)
ffffffffc02027b0:	0017f693          	andi	a3,a5,1
ffffffffc02027b4:	dee9                	beqz	a3,ffffffffc020278e <exit_range+0xe2>
ffffffffc02027b6:	000d3583          	ld	a1,0(s10)
ffffffffc02027ba:	078a                	slli	a5,a5,0x2
ffffffffc02027bc:	83b1                	srli	a5,a5,0xc
ffffffffc02027be:	14b7fe63          	bgeu	a5,a1,ffffffffc020291a <exit_range+0x26e>
ffffffffc02027c2:	97f2                	add	a5,a5,t3
ffffffffc02027c4:	006786b3          	add	a3,a5,t1
ffffffffc02027c8:	0196feb3          	and	t4,a3,s9
ffffffffc02027cc:	00679513          	slli	a0,a5,0x6
ffffffffc02027d0:	06b2                	slli	a3,a3,0xc
ffffffffc02027d2:	12bef863          	bgeu	t4,a1,ffffffffc0202902 <exit_range+0x256>
ffffffffc02027d6:	00083783          	ld	a5,0(a6)
ffffffffc02027da:	96be                	add	a3,a3,a5
ffffffffc02027dc:	011685b3          	add	a1,a3,a7
ffffffffc02027e0:	629c                	ld	a5,0(a3)
ffffffffc02027e2:	8b85                	andi	a5,a5,1
ffffffffc02027e4:	f7d5                	bnez	a5,ffffffffc0202790 <exit_range+0xe4>
ffffffffc02027e6:	06a1                	addi	a3,a3,8
ffffffffc02027e8:	fed59ce3          	bne	a1,a3,ffffffffc02027e0 <exit_range+0x134>
ffffffffc02027ec:	631c                	ld	a5,0(a4)
ffffffffc02027ee:	953e                	add	a0,a0,a5
ffffffffc02027f0:	100027f3          	csrr	a5,sstatus
ffffffffc02027f4:	8b89                	andi	a5,a5,2
ffffffffc02027f6:	e7d9                	bnez	a5,ffffffffc0202884 <exit_range+0x1d8>
ffffffffc02027f8:	000db783          	ld	a5,0(s11)
ffffffffc02027fc:	4585                	li	a1,1
ffffffffc02027fe:	e032                	sd	a2,0(sp)
ffffffffc0202800:	739c                	ld	a5,32(a5)
ffffffffc0202802:	9782                	jalr	a5
ffffffffc0202804:	6602                	ld	a2,0(sp)
ffffffffc0202806:	00094817          	auipc	a6,0x94
ffffffffc020280a:	0b280813          	addi	a6,a6,178 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020280e:	fff80e37          	lui	t3,0xfff80
ffffffffc0202812:	00080337          	lui	t1,0x80
ffffffffc0202816:	6885                	lui	a7,0x1
ffffffffc0202818:	00094717          	auipc	a4,0x94
ffffffffc020281c:	09070713          	addi	a4,a4,144 # ffffffffc02968a8 <pages>
ffffffffc0202820:	0004b023          	sd	zero,0(s1)
ffffffffc0202824:	002007b7          	lui	a5,0x200
ffffffffc0202828:	993e                	add	s2,s2,a5
ffffffffc020282a:	f60918e3          	bnez	s2,ffffffffc020279a <exit_range+0xee>
ffffffffc020282e:	f00b85e3          	beqz	s7,ffffffffc0202738 <exit_range+0x8c>
ffffffffc0202832:	000d3783          	ld	a5,0(s10)
ffffffffc0202836:	0efa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020283a:	6308                	ld	a0,0(a4)
ffffffffc020283c:	9532                	add	a0,a0,a2
ffffffffc020283e:	100027f3          	csrr	a5,sstatus
ffffffffc0202842:	8b89                	andi	a5,a5,2
ffffffffc0202844:	efad                	bnez	a5,ffffffffc02028be <exit_range+0x212>
ffffffffc0202846:	000db783          	ld	a5,0(s11)
ffffffffc020284a:	4585                	li	a1,1
ffffffffc020284c:	739c                	ld	a5,32(a5)
ffffffffc020284e:	9782                	jalr	a5
ffffffffc0202850:	00094717          	auipc	a4,0x94
ffffffffc0202854:	05870713          	addi	a4,a4,88 # ffffffffc02968a8 <pages>
ffffffffc0202858:	00043023          	sd	zero,0(s0)
ffffffffc020285c:	ee0990e3          	bnez	s3,ffffffffc020273c <exit_range+0x90>
ffffffffc0202860:	70e6                	ld	ra,120(sp)
ffffffffc0202862:	7446                	ld	s0,112(sp)
ffffffffc0202864:	74a6                	ld	s1,104(sp)
ffffffffc0202866:	7906                	ld	s2,96(sp)
ffffffffc0202868:	69e6                	ld	s3,88(sp)
ffffffffc020286a:	6a46                	ld	s4,80(sp)
ffffffffc020286c:	6aa6                	ld	s5,72(sp)
ffffffffc020286e:	6b06                	ld	s6,64(sp)
ffffffffc0202870:	7be2                	ld	s7,56(sp)
ffffffffc0202872:	7c42                	ld	s8,48(sp)
ffffffffc0202874:	7ca2                	ld	s9,40(sp)
ffffffffc0202876:	7d02                	ld	s10,32(sp)
ffffffffc0202878:	6de2                	ld	s11,24(sp)
ffffffffc020287a:	6109                	addi	sp,sp,128
ffffffffc020287c:	8082                	ret
ffffffffc020287e:	ea0b8fe3          	beqz	s7,ffffffffc020273c <exit_range+0x90>
ffffffffc0202882:	bf45                	j	ffffffffc0202832 <exit_range+0x186>
ffffffffc0202884:	e032                	sd	a2,0(sp)
ffffffffc0202886:	e42a                	sd	a0,8(sp)
ffffffffc0202888:	beafe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020288c:	000db783          	ld	a5,0(s11)
ffffffffc0202890:	6522                	ld	a0,8(sp)
ffffffffc0202892:	4585                	li	a1,1
ffffffffc0202894:	739c                	ld	a5,32(a5)
ffffffffc0202896:	9782                	jalr	a5
ffffffffc0202898:	bd4fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020289c:	6602                	ld	a2,0(sp)
ffffffffc020289e:	00094717          	auipc	a4,0x94
ffffffffc02028a2:	00a70713          	addi	a4,a4,10 # ffffffffc02968a8 <pages>
ffffffffc02028a6:	6885                	lui	a7,0x1
ffffffffc02028a8:	00080337          	lui	t1,0x80
ffffffffc02028ac:	fff80e37          	lui	t3,0xfff80
ffffffffc02028b0:	00094817          	auipc	a6,0x94
ffffffffc02028b4:	00880813          	addi	a6,a6,8 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02028b8:	0004b023          	sd	zero,0(s1)
ffffffffc02028bc:	b7a5                	j	ffffffffc0202824 <exit_range+0x178>
ffffffffc02028be:	e02a                	sd	a0,0(sp)
ffffffffc02028c0:	bb2fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02028c4:	000db783          	ld	a5,0(s11)
ffffffffc02028c8:	6502                	ld	a0,0(sp)
ffffffffc02028ca:	4585                	li	a1,1
ffffffffc02028cc:	739c                	ld	a5,32(a5)
ffffffffc02028ce:	9782                	jalr	a5
ffffffffc02028d0:	b9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02028d4:	00094717          	auipc	a4,0x94
ffffffffc02028d8:	fd470713          	addi	a4,a4,-44 # ffffffffc02968a8 <pages>
ffffffffc02028dc:	00043023          	sd	zero,0(s0)
ffffffffc02028e0:	bfb5                	j	ffffffffc020285c <exit_range+0x1b0>
ffffffffc02028e2:	0000a697          	auipc	a3,0xa
ffffffffc02028e6:	c2668693          	addi	a3,a3,-986 # ffffffffc020c508 <default_pmm_manager+0x188>
ffffffffc02028ea:	00009617          	auipc	a2,0x9
ffffffffc02028ee:	fae60613          	addi	a2,a2,-82 # ffffffffc020b898 <commands+0x210>
ffffffffc02028f2:	16f00593          	li	a1,367
ffffffffc02028f6:	0000a517          	auipc	a0,0xa
ffffffffc02028fa:	bda50513          	addi	a0,a0,-1062 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02028fe:	ba1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202902:	0000a617          	auipc	a2,0xa
ffffffffc0202906:	ab660613          	addi	a2,a2,-1354 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc020290a:	07100593          	li	a1,113
ffffffffc020290e:	0000a517          	auipc	a0,0xa
ffffffffc0202912:	ad250513          	addi	a0,a0,-1326 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0202916:	b89fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020291a:	81bff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc020291e:	0000a697          	auipc	a3,0xa
ffffffffc0202922:	c1a68693          	addi	a3,a3,-998 # ffffffffc020c538 <default_pmm_manager+0x1b8>
ffffffffc0202926:	00009617          	auipc	a2,0x9
ffffffffc020292a:	f7260613          	addi	a2,a2,-142 # ffffffffc020b898 <commands+0x210>
ffffffffc020292e:	17000593          	li	a1,368
ffffffffc0202932:	0000a517          	auipc	a0,0xa
ffffffffc0202936:	b9e50513          	addi	a0,a0,-1122 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020293a:	b65fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020293e <page_remove>:
ffffffffc020293e:	7179                	addi	sp,sp,-48
ffffffffc0202940:	4601                	li	a2,0
ffffffffc0202942:	ec26                	sd	s1,24(sp)
ffffffffc0202944:	f406                	sd	ra,40(sp)
ffffffffc0202946:	f022                	sd	s0,32(sp)
ffffffffc0202948:	84ae                	mv	s1,a1
ffffffffc020294a:	8dbff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020294e:	c511                	beqz	a0,ffffffffc020295a <page_remove+0x1c>
ffffffffc0202950:	611c                	ld	a5,0(a0)
ffffffffc0202952:	842a                	mv	s0,a0
ffffffffc0202954:	0017f713          	andi	a4,a5,1
ffffffffc0202958:	e711                	bnez	a4,ffffffffc0202964 <page_remove+0x26>
ffffffffc020295a:	70a2                	ld	ra,40(sp)
ffffffffc020295c:	7402                	ld	s0,32(sp)
ffffffffc020295e:	64e2                	ld	s1,24(sp)
ffffffffc0202960:	6145                	addi	sp,sp,48
ffffffffc0202962:	8082                	ret
ffffffffc0202964:	078a                	slli	a5,a5,0x2
ffffffffc0202966:	83b1                	srli	a5,a5,0xc
ffffffffc0202968:	00094717          	auipc	a4,0x94
ffffffffc020296c:	f3873703          	ld	a4,-200(a4) # ffffffffc02968a0 <npage>
ffffffffc0202970:	06e7f363          	bgeu	a5,a4,ffffffffc02029d6 <page_remove+0x98>
ffffffffc0202974:	fff80537          	lui	a0,0xfff80
ffffffffc0202978:	97aa                	add	a5,a5,a0
ffffffffc020297a:	079a                	slli	a5,a5,0x6
ffffffffc020297c:	00094517          	auipc	a0,0x94
ffffffffc0202980:	f2c53503          	ld	a0,-212(a0) # ffffffffc02968a8 <pages>
ffffffffc0202984:	953e                	add	a0,a0,a5
ffffffffc0202986:	411c                	lw	a5,0(a0)
ffffffffc0202988:	fff7871b          	addiw	a4,a5,-1
ffffffffc020298c:	c118                	sw	a4,0(a0)
ffffffffc020298e:	cb11                	beqz	a4,ffffffffc02029a2 <page_remove+0x64>
ffffffffc0202990:	00043023          	sd	zero,0(s0)
ffffffffc0202994:	12048073          	sfence.vma	s1
ffffffffc0202998:	70a2                	ld	ra,40(sp)
ffffffffc020299a:	7402                	ld	s0,32(sp)
ffffffffc020299c:	64e2                	ld	s1,24(sp)
ffffffffc020299e:	6145                	addi	sp,sp,48
ffffffffc02029a0:	8082                	ret
ffffffffc02029a2:	100027f3          	csrr	a5,sstatus
ffffffffc02029a6:	8b89                	andi	a5,a5,2
ffffffffc02029a8:	eb89                	bnez	a5,ffffffffc02029ba <page_remove+0x7c>
ffffffffc02029aa:	00094797          	auipc	a5,0x94
ffffffffc02029ae:	f067b783          	ld	a5,-250(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02029b2:	739c                	ld	a5,32(a5)
ffffffffc02029b4:	4585                	li	a1,1
ffffffffc02029b6:	9782                	jalr	a5
ffffffffc02029b8:	bfe1                	j	ffffffffc0202990 <page_remove+0x52>
ffffffffc02029ba:	e42a                	sd	a0,8(sp)
ffffffffc02029bc:	ab6fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02029c0:	00094797          	auipc	a5,0x94
ffffffffc02029c4:	ef07b783          	ld	a5,-272(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02029c8:	739c                	ld	a5,32(a5)
ffffffffc02029ca:	6522                	ld	a0,8(sp)
ffffffffc02029cc:	4585                	li	a1,1
ffffffffc02029ce:	9782                	jalr	a5
ffffffffc02029d0:	a9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02029d4:	bf75                	j	ffffffffc0202990 <page_remove+0x52>
ffffffffc02029d6:	f5eff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02029da <page_insert>:
ffffffffc02029da:	7139                	addi	sp,sp,-64
ffffffffc02029dc:	e852                	sd	s4,16(sp)
ffffffffc02029de:	8a32                	mv	s4,a2
ffffffffc02029e0:	f822                	sd	s0,48(sp)
ffffffffc02029e2:	4605                	li	a2,1
ffffffffc02029e4:	842e                	mv	s0,a1
ffffffffc02029e6:	85d2                	mv	a1,s4
ffffffffc02029e8:	f426                	sd	s1,40(sp)
ffffffffc02029ea:	fc06                	sd	ra,56(sp)
ffffffffc02029ec:	f04a                	sd	s2,32(sp)
ffffffffc02029ee:	ec4e                	sd	s3,24(sp)
ffffffffc02029f0:	e456                	sd	s5,8(sp)
ffffffffc02029f2:	84b6                	mv	s1,a3
ffffffffc02029f4:	831ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02029f8:	c961                	beqz	a0,ffffffffc0202ac8 <page_insert+0xee>
ffffffffc02029fa:	4014                	lw	a3,0(s0)
ffffffffc02029fc:	611c                	ld	a5,0(a0)
ffffffffc02029fe:	89aa                	mv	s3,a0
ffffffffc0202a00:	0016871b          	addiw	a4,a3,1
ffffffffc0202a04:	c018                	sw	a4,0(s0)
ffffffffc0202a06:	0017f713          	andi	a4,a5,1
ffffffffc0202a0a:	ef05                	bnez	a4,ffffffffc0202a42 <page_insert+0x68>
ffffffffc0202a0c:	00094717          	auipc	a4,0x94
ffffffffc0202a10:	e9c73703          	ld	a4,-356(a4) # ffffffffc02968a8 <pages>
ffffffffc0202a14:	8c19                	sub	s0,s0,a4
ffffffffc0202a16:	000807b7          	lui	a5,0x80
ffffffffc0202a1a:	8419                	srai	s0,s0,0x6
ffffffffc0202a1c:	943e                	add	s0,s0,a5
ffffffffc0202a1e:	042a                	slli	s0,s0,0xa
ffffffffc0202a20:	8cc1                	or	s1,s1,s0
ffffffffc0202a22:	0014e493          	ori	s1,s1,1
ffffffffc0202a26:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202a2a:	120a0073          	sfence.vma	s4
ffffffffc0202a2e:	4501                	li	a0,0
ffffffffc0202a30:	70e2                	ld	ra,56(sp)
ffffffffc0202a32:	7442                	ld	s0,48(sp)
ffffffffc0202a34:	74a2                	ld	s1,40(sp)
ffffffffc0202a36:	7902                	ld	s2,32(sp)
ffffffffc0202a38:	69e2                	ld	s3,24(sp)
ffffffffc0202a3a:	6a42                	ld	s4,16(sp)
ffffffffc0202a3c:	6aa2                	ld	s5,8(sp)
ffffffffc0202a3e:	6121                	addi	sp,sp,64
ffffffffc0202a40:	8082                	ret
ffffffffc0202a42:	078a                	slli	a5,a5,0x2
ffffffffc0202a44:	83b1                	srli	a5,a5,0xc
ffffffffc0202a46:	00094717          	auipc	a4,0x94
ffffffffc0202a4a:	e5a73703          	ld	a4,-422(a4) # ffffffffc02968a0 <npage>
ffffffffc0202a4e:	06e7ff63          	bgeu	a5,a4,ffffffffc0202acc <page_insert+0xf2>
ffffffffc0202a52:	00094a97          	auipc	s5,0x94
ffffffffc0202a56:	e56a8a93          	addi	s5,s5,-426 # ffffffffc02968a8 <pages>
ffffffffc0202a5a:	000ab703          	ld	a4,0(s5)
ffffffffc0202a5e:	fff80937          	lui	s2,0xfff80
ffffffffc0202a62:	993e                	add	s2,s2,a5
ffffffffc0202a64:	091a                	slli	s2,s2,0x6
ffffffffc0202a66:	993a                	add	s2,s2,a4
ffffffffc0202a68:	01240c63          	beq	s0,s2,ffffffffc0202a80 <page_insert+0xa6>
ffffffffc0202a6c:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202a70:	fff7869b          	addiw	a3,a5,-1
ffffffffc0202a74:	00d92023          	sw	a3,0(s2)
ffffffffc0202a78:	c691                	beqz	a3,ffffffffc0202a84 <page_insert+0xaa>
ffffffffc0202a7a:	120a0073          	sfence.vma	s4
ffffffffc0202a7e:	bf59                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202a80:	c014                	sw	a3,0(s0)
ffffffffc0202a82:	bf49                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202a84:	100027f3          	csrr	a5,sstatus
ffffffffc0202a88:	8b89                	andi	a5,a5,2
ffffffffc0202a8a:	ef91                	bnez	a5,ffffffffc0202aa6 <page_insert+0xcc>
ffffffffc0202a8c:	00094797          	auipc	a5,0x94
ffffffffc0202a90:	e247b783          	ld	a5,-476(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202a94:	739c                	ld	a5,32(a5)
ffffffffc0202a96:	4585                	li	a1,1
ffffffffc0202a98:	854a                	mv	a0,s2
ffffffffc0202a9a:	9782                	jalr	a5
ffffffffc0202a9c:	000ab703          	ld	a4,0(s5)
ffffffffc0202aa0:	120a0073          	sfence.vma	s4
ffffffffc0202aa4:	bf85                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202aa6:	9ccfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202aaa:	00094797          	auipc	a5,0x94
ffffffffc0202aae:	e067b783          	ld	a5,-506(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202ab2:	739c                	ld	a5,32(a5)
ffffffffc0202ab4:	4585                	li	a1,1
ffffffffc0202ab6:	854a                	mv	a0,s2
ffffffffc0202ab8:	9782                	jalr	a5
ffffffffc0202aba:	9b2fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202abe:	000ab703          	ld	a4,0(s5)
ffffffffc0202ac2:	120a0073          	sfence.vma	s4
ffffffffc0202ac6:	b7b9                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202ac8:	5571                	li	a0,-4
ffffffffc0202aca:	b79d                	j	ffffffffc0202a30 <page_insert+0x56>
ffffffffc0202acc:	e68ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202ad0 <pmm_init>:
ffffffffc0202ad0:	0000a797          	auipc	a5,0xa
ffffffffc0202ad4:	8b078793          	addi	a5,a5,-1872 # ffffffffc020c380 <default_pmm_manager>
ffffffffc0202ad8:	638c                	ld	a1,0(a5)
ffffffffc0202ada:	7159                	addi	sp,sp,-112
ffffffffc0202adc:	f85a                	sd	s6,48(sp)
ffffffffc0202ade:	0000a517          	auipc	a0,0xa
ffffffffc0202ae2:	a7250513          	addi	a0,a0,-1422 # ffffffffc020c550 <default_pmm_manager+0x1d0>
ffffffffc0202ae6:	00094b17          	auipc	s6,0x94
ffffffffc0202aea:	dcab0b13          	addi	s6,s6,-566 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202aee:	f486                	sd	ra,104(sp)
ffffffffc0202af0:	e8ca                	sd	s2,80(sp)
ffffffffc0202af2:	e4ce                	sd	s3,72(sp)
ffffffffc0202af4:	f0a2                	sd	s0,96(sp)
ffffffffc0202af6:	eca6                	sd	s1,88(sp)
ffffffffc0202af8:	e0d2                	sd	s4,64(sp)
ffffffffc0202afa:	fc56                	sd	s5,56(sp)
ffffffffc0202afc:	f45e                	sd	s7,40(sp)
ffffffffc0202afe:	f062                	sd	s8,32(sp)
ffffffffc0202b00:	ec66                	sd	s9,24(sp)
ffffffffc0202b02:	00fb3023          	sd	a5,0(s6)
ffffffffc0202b06:	ea0fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b0a:	000b3783          	ld	a5,0(s6)
ffffffffc0202b0e:	00094997          	auipc	s3,0x94
ffffffffc0202b12:	daa98993          	addi	s3,s3,-598 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202b16:	679c                	ld	a5,8(a5)
ffffffffc0202b18:	9782                	jalr	a5
ffffffffc0202b1a:	57f5                	li	a5,-3
ffffffffc0202b1c:	07fa                	slli	a5,a5,0x1e
ffffffffc0202b1e:	00f9b023          	sd	a5,0(s3)
ffffffffc0202b22:	f27fd0ef          	jal	ra,ffffffffc0200a48 <get_memory_base>
ffffffffc0202b26:	892a                	mv	s2,a0
ffffffffc0202b28:	f2bfd0ef          	jal	ra,ffffffffc0200a52 <get_memory_size>
ffffffffc0202b2c:	280502e3          	beqz	a0,ffffffffc02035b0 <pmm_init+0xae0>
ffffffffc0202b30:	84aa                	mv	s1,a0
ffffffffc0202b32:	0000a517          	auipc	a0,0xa
ffffffffc0202b36:	a5650513          	addi	a0,a0,-1450 # ffffffffc020c588 <default_pmm_manager+0x208>
ffffffffc0202b3a:	e6cfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b3e:	00990433          	add	s0,s2,s1
ffffffffc0202b42:	fff40693          	addi	a3,s0,-1
ffffffffc0202b46:	864a                	mv	a2,s2
ffffffffc0202b48:	85a6                	mv	a1,s1
ffffffffc0202b4a:	0000a517          	auipc	a0,0xa
ffffffffc0202b4e:	a5650513          	addi	a0,a0,-1450 # ffffffffc020c5a0 <default_pmm_manager+0x220>
ffffffffc0202b52:	e54fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b56:	c8000737          	lui	a4,0xc8000
ffffffffc0202b5a:	87a2                	mv	a5,s0
ffffffffc0202b5c:	5e876e63          	bltu	a4,s0,ffffffffc0203158 <pmm_init+0x688>
ffffffffc0202b60:	757d                	lui	a0,0xfffff
ffffffffc0202b62:	00095617          	auipc	a2,0x95
ffffffffc0202b66:	dad60613          	addi	a2,a2,-595 # ffffffffc029790f <end+0xfff>
ffffffffc0202b6a:	8e69                	and	a2,a2,a0
ffffffffc0202b6c:	00094497          	auipc	s1,0x94
ffffffffc0202b70:	d3448493          	addi	s1,s1,-716 # ffffffffc02968a0 <npage>
ffffffffc0202b74:	00c7d513          	srli	a0,a5,0xc
ffffffffc0202b78:	00094b97          	auipc	s7,0x94
ffffffffc0202b7c:	d30b8b93          	addi	s7,s7,-720 # ffffffffc02968a8 <pages>
ffffffffc0202b80:	e088                	sd	a0,0(s1)
ffffffffc0202b82:	00cbb023          	sd	a2,0(s7)
ffffffffc0202b86:	000807b7          	lui	a5,0x80
ffffffffc0202b8a:	86b2                	mv	a3,a2
ffffffffc0202b8c:	02f50863          	beq	a0,a5,ffffffffc0202bbc <pmm_init+0xec>
ffffffffc0202b90:	4781                	li	a5,0
ffffffffc0202b92:	4585                	li	a1,1
ffffffffc0202b94:	fff806b7          	lui	a3,0xfff80
ffffffffc0202b98:	00679513          	slli	a0,a5,0x6
ffffffffc0202b9c:	9532                	add	a0,a0,a2
ffffffffc0202b9e:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd686f8>
ffffffffc0202ba2:	40b7302f          	amoor.d	zero,a1,(a4)
ffffffffc0202ba6:	6088                	ld	a0,0(s1)
ffffffffc0202ba8:	0785                	addi	a5,a5,1
ffffffffc0202baa:	000bb603          	ld	a2,0(s7)
ffffffffc0202bae:	00d50733          	add	a4,a0,a3
ffffffffc0202bb2:	fee7e3e3          	bltu	a5,a4,ffffffffc0202b98 <pmm_init+0xc8>
ffffffffc0202bb6:	071a                	slli	a4,a4,0x6
ffffffffc0202bb8:	00e606b3          	add	a3,a2,a4
ffffffffc0202bbc:	c02007b7          	lui	a5,0xc0200
ffffffffc0202bc0:	3af6eae3          	bltu	a3,a5,ffffffffc0203774 <pmm_init+0xca4>
ffffffffc0202bc4:	0009b583          	ld	a1,0(s3)
ffffffffc0202bc8:	77fd                	lui	a5,0xfffff
ffffffffc0202bca:	8c7d                	and	s0,s0,a5
ffffffffc0202bcc:	8e8d                	sub	a3,a3,a1
ffffffffc0202bce:	5e86e363          	bltu	a3,s0,ffffffffc02031b4 <pmm_init+0x6e4>
ffffffffc0202bd2:	0000a517          	auipc	a0,0xa
ffffffffc0202bd6:	9f650513          	addi	a0,a0,-1546 # ffffffffc020c5c8 <default_pmm_manager+0x248>
ffffffffc0202bda:	dccfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bde:	000b3783          	ld	a5,0(s6)
ffffffffc0202be2:	7b9c                	ld	a5,48(a5)
ffffffffc0202be4:	9782                	jalr	a5
ffffffffc0202be6:	0000a517          	auipc	a0,0xa
ffffffffc0202bea:	9fa50513          	addi	a0,a0,-1542 # ffffffffc020c5e0 <default_pmm_manager+0x260>
ffffffffc0202bee:	db8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bf2:	100027f3          	csrr	a5,sstatus
ffffffffc0202bf6:	8b89                	andi	a5,a5,2
ffffffffc0202bf8:	5a079363          	bnez	a5,ffffffffc020319e <pmm_init+0x6ce>
ffffffffc0202bfc:	000b3783          	ld	a5,0(s6)
ffffffffc0202c00:	4505                	li	a0,1
ffffffffc0202c02:	6f9c                	ld	a5,24(a5)
ffffffffc0202c04:	9782                	jalr	a5
ffffffffc0202c06:	842a                	mv	s0,a0
ffffffffc0202c08:	180408e3          	beqz	s0,ffffffffc0203598 <pmm_init+0xac8>
ffffffffc0202c0c:	000bb683          	ld	a3,0(s7)
ffffffffc0202c10:	5a7d                	li	s4,-1
ffffffffc0202c12:	6098                	ld	a4,0(s1)
ffffffffc0202c14:	40d406b3          	sub	a3,s0,a3
ffffffffc0202c18:	8699                	srai	a3,a3,0x6
ffffffffc0202c1a:	00080437          	lui	s0,0x80
ffffffffc0202c1e:	96a2                	add	a3,a3,s0
ffffffffc0202c20:	00ca5793          	srli	a5,s4,0xc
ffffffffc0202c24:	8ff5                	and	a5,a5,a3
ffffffffc0202c26:	06b2                	slli	a3,a3,0xc
ffffffffc0202c28:	30e7fde3          	bgeu	a5,a4,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0202c2c:	0009b403          	ld	s0,0(s3)
ffffffffc0202c30:	6605                	lui	a2,0x1
ffffffffc0202c32:	4581                	li	a1,0
ffffffffc0202c34:	9436                	add	s0,s0,a3
ffffffffc0202c36:	8522                	mv	a0,s0
ffffffffc0202c38:	77e080ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0202c3c:	0009b683          	ld	a3,0(s3)
ffffffffc0202c40:	77fd                	lui	a5,0xfffff
ffffffffc0202c42:	00009917          	auipc	s2,0x9
ffffffffc0202c46:	7dd90913          	addi	s2,s2,2013 # ffffffffc020c41f <default_pmm_manager+0x9f>
ffffffffc0202c4a:	00f97933          	and	s2,s2,a5
ffffffffc0202c4e:	c0200ab7          	lui	s5,0xc0200
ffffffffc0202c52:	3fe00637          	lui	a2,0x3fe00
ffffffffc0202c56:	964a                	add	a2,a2,s2
ffffffffc0202c58:	4729                	li	a4,10
ffffffffc0202c5a:	40da86b3          	sub	a3,s5,a3
ffffffffc0202c5e:	c02005b7          	lui	a1,0xc0200
ffffffffc0202c62:	8522                	mv	a0,s0
ffffffffc0202c64:	fe8ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202c68:	c8000637          	lui	a2,0xc8000
ffffffffc0202c6c:	41260633          	sub	a2,a2,s2
ffffffffc0202c70:	3f596ce3          	bltu	s2,s5,ffffffffc0203868 <pmm_init+0xd98>
ffffffffc0202c74:	0009b683          	ld	a3,0(s3)
ffffffffc0202c78:	85ca                	mv	a1,s2
ffffffffc0202c7a:	4719                	li	a4,6
ffffffffc0202c7c:	40d906b3          	sub	a3,s2,a3
ffffffffc0202c80:	8522                	mv	a0,s0
ffffffffc0202c82:	00094917          	auipc	s2,0x94
ffffffffc0202c86:	c1690913          	addi	s2,s2,-1002 # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0202c8a:	fc2ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202c8e:	00893023          	sd	s0,0(s2)
ffffffffc0202c92:	2d5464e3          	bltu	s0,s5,ffffffffc020375a <pmm_init+0xc8a>
ffffffffc0202c96:	0009b783          	ld	a5,0(s3)
ffffffffc0202c9a:	1a7e                	slli	s4,s4,0x3f
ffffffffc0202c9c:	8c1d                	sub	s0,s0,a5
ffffffffc0202c9e:	00c45793          	srli	a5,s0,0xc
ffffffffc0202ca2:	00094717          	auipc	a4,0x94
ffffffffc0202ca6:	be873723          	sd	s0,-1042(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0202caa:	0147ea33          	or	s4,a5,s4
ffffffffc0202cae:	180a1073          	csrw	satp,s4
ffffffffc0202cb2:	12000073          	sfence.vma
ffffffffc0202cb6:	0000a517          	auipc	a0,0xa
ffffffffc0202cba:	96a50513          	addi	a0,a0,-1686 # ffffffffc020c620 <default_pmm_manager+0x2a0>
ffffffffc0202cbe:	ce8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202cc2:	0000e717          	auipc	a4,0xe
ffffffffc0202cc6:	33e70713          	addi	a4,a4,830 # ffffffffc0211000 <bootstack>
ffffffffc0202cca:	0000e797          	auipc	a5,0xe
ffffffffc0202cce:	33678793          	addi	a5,a5,822 # ffffffffc0211000 <bootstack>
ffffffffc0202cd2:	5cf70d63          	beq	a4,a5,ffffffffc02032ac <pmm_init+0x7dc>
ffffffffc0202cd6:	100027f3          	csrr	a5,sstatus
ffffffffc0202cda:	8b89                	andi	a5,a5,2
ffffffffc0202cdc:	4a079763          	bnez	a5,ffffffffc020318a <pmm_init+0x6ba>
ffffffffc0202ce0:	000b3783          	ld	a5,0(s6)
ffffffffc0202ce4:	779c                	ld	a5,40(a5)
ffffffffc0202ce6:	9782                	jalr	a5
ffffffffc0202ce8:	842a                	mv	s0,a0
ffffffffc0202cea:	6098                	ld	a4,0(s1)
ffffffffc0202cec:	c80007b7          	lui	a5,0xc8000
ffffffffc0202cf0:	83b1                	srli	a5,a5,0xc
ffffffffc0202cf2:	08e7e3e3          	bltu	a5,a4,ffffffffc0203578 <pmm_init+0xaa8>
ffffffffc0202cf6:	00093503          	ld	a0,0(s2)
ffffffffc0202cfa:	04050fe3          	beqz	a0,ffffffffc0203558 <pmm_init+0xa88>
ffffffffc0202cfe:	03451793          	slli	a5,a0,0x34
ffffffffc0202d02:	04079be3          	bnez	a5,ffffffffc0203558 <pmm_init+0xa88>
ffffffffc0202d06:	4601                	li	a2,0
ffffffffc0202d08:	4581                	li	a1,0
ffffffffc0202d0a:	809ff0ef          	jal	ra,ffffffffc0202512 <get_page>
ffffffffc0202d0e:	2e0511e3          	bnez	a0,ffffffffc02037f0 <pmm_init+0xd20>
ffffffffc0202d12:	100027f3          	csrr	a5,sstatus
ffffffffc0202d16:	8b89                	andi	a5,a5,2
ffffffffc0202d18:	44079e63          	bnez	a5,ffffffffc0203174 <pmm_init+0x6a4>
ffffffffc0202d1c:	000b3783          	ld	a5,0(s6)
ffffffffc0202d20:	4505                	li	a0,1
ffffffffc0202d22:	6f9c                	ld	a5,24(a5)
ffffffffc0202d24:	9782                	jalr	a5
ffffffffc0202d26:	8a2a                	mv	s4,a0
ffffffffc0202d28:	00093503          	ld	a0,0(s2)
ffffffffc0202d2c:	4681                	li	a3,0
ffffffffc0202d2e:	4601                	li	a2,0
ffffffffc0202d30:	85d2                	mv	a1,s4
ffffffffc0202d32:	ca9ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202d36:	26051be3          	bnez	a0,ffffffffc02037ac <pmm_init+0xcdc>
ffffffffc0202d3a:	00093503          	ld	a0,0(s2)
ffffffffc0202d3e:	4601                	li	a2,0
ffffffffc0202d40:	4581                	li	a1,0
ffffffffc0202d42:	ce2ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202d46:	280505e3          	beqz	a0,ffffffffc02037d0 <pmm_init+0xd00>
ffffffffc0202d4a:	611c                	ld	a5,0(a0)
ffffffffc0202d4c:	0017f713          	andi	a4,a5,1
ffffffffc0202d50:	26070ee3          	beqz	a4,ffffffffc02037cc <pmm_init+0xcfc>
ffffffffc0202d54:	6098                	ld	a4,0(s1)
ffffffffc0202d56:	078a                	slli	a5,a5,0x2
ffffffffc0202d58:	83b1                	srli	a5,a5,0xc
ffffffffc0202d5a:	62e7f363          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202d5e:	000bb683          	ld	a3,0(s7)
ffffffffc0202d62:	fff80637          	lui	a2,0xfff80
ffffffffc0202d66:	97b2                	add	a5,a5,a2
ffffffffc0202d68:	079a                	slli	a5,a5,0x6
ffffffffc0202d6a:	97b6                	add	a5,a5,a3
ffffffffc0202d6c:	2afa12e3          	bne	s4,a5,ffffffffc0203810 <pmm_init+0xd40>
ffffffffc0202d70:	000a2683          	lw	a3,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202d74:	4785                	li	a5,1
ffffffffc0202d76:	2cf699e3          	bne	a3,a5,ffffffffc0203848 <pmm_init+0xd78>
ffffffffc0202d7a:	00093503          	ld	a0,0(s2)
ffffffffc0202d7e:	77fd                	lui	a5,0xfffff
ffffffffc0202d80:	6114                	ld	a3,0(a0)
ffffffffc0202d82:	068a                	slli	a3,a3,0x2
ffffffffc0202d84:	8efd                	and	a3,a3,a5
ffffffffc0202d86:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202d8a:	2ae673e3          	bgeu	a2,a4,ffffffffc0203830 <pmm_init+0xd60>
ffffffffc0202d8e:	0009bc03          	ld	s8,0(s3)
ffffffffc0202d92:	96e2                	add	a3,a3,s8
ffffffffc0202d94:	0006ba83          	ld	s5,0(a3) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202d98:	0a8a                	slli	s5,s5,0x2
ffffffffc0202d9a:	00fafab3          	and	s5,s5,a5
ffffffffc0202d9e:	00cad793          	srli	a5,s5,0xc
ffffffffc0202da2:	06e7f3e3          	bgeu	a5,a4,ffffffffc0203608 <pmm_init+0xb38>
ffffffffc0202da6:	4601                	li	a2,0
ffffffffc0202da8:	6585                	lui	a1,0x1
ffffffffc0202daa:	9ae2                	add	s5,s5,s8
ffffffffc0202dac:	c78ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202db0:	0aa1                	addi	s5,s5,8
ffffffffc0202db2:	03551be3          	bne	a0,s5,ffffffffc02035e8 <pmm_init+0xb18>
ffffffffc0202db6:	100027f3          	csrr	a5,sstatus
ffffffffc0202dba:	8b89                	andi	a5,a5,2
ffffffffc0202dbc:	3a079163          	bnez	a5,ffffffffc020315e <pmm_init+0x68e>
ffffffffc0202dc0:	000b3783          	ld	a5,0(s6)
ffffffffc0202dc4:	4505                	li	a0,1
ffffffffc0202dc6:	6f9c                	ld	a5,24(a5)
ffffffffc0202dc8:	9782                	jalr	a5
ffffffffc0202dca:	8c2a                	mv	s8,a0
ffffffffc0202dcc:	00093503          	ld	a0,0(s2)
ffffffffc0202dd0:	46d1                	li	a3,20
ffffffffc0202dd2:	6605                	lui	a2,0x1
ffffffffc0202dd4:	85e2                	mv	a1,s8
ffffffffc0202dd6:	c05ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202dda:	1a0519e3          	bnez	a0,ffffffffc020378c <pmm_init+0xcbc>
ffffffffc0202dde:	00093503          	ld	a0,0(s2)
ffffffffc0202de2:	4601                	li	a2,0
ffffffffc0202de4:	6585                	lui	a1,0x1
ffffffffc0202de6:	c3eff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202dea:	10050ce3          	beqz	a0,ffffffffc0203702 <pmm_init+0xc32>
ffffffffc0202dee:	611c                	ld	a5,0(a0)
ffffffffc0202df0:	0107f713          	andi	a4,a5,16
ffffffffc0202df4:	0e0707e3          	beqz	a4,ffffffffc02036e2 <pmm_init+0xc12>
ffffffffc0202df8:	8b91                	andi	a5,a5,4
ffffffffc0202dfa:	0c0784e3          	beqz	a5,ffffffffc02036c2 <pmm_init+0xbf2>
ffffffffc0202dfe:	00093503          	ld	a0,0(s2)
ffffffffc0202e02:	611c                	ld	a5,0(a0)
ffffffffc0202e04:	8bc1                	andi	a5,a5,16
ffffffffc0202e06:	08078ee3          	beqz	a5,ffffffffc02036a2 <pmm_init+0xbd2>
ffffffffc0202e0a:	000c2703          	lw	a4,0(s8)
ffffffffc0202e0e:	4785                	li	a5,1
ffffffffc0202e10:	06f719e3          	bne	a4,a5,ffffffffc0203682 <pmm_init+0xbb2>
ffffffffc0202e14:	4681                	li	a3,0
ffffffffc0202e16:	6605                	lui	a2,0x1
ffffffffc0202e18:	85d2                	mv	a1,s4
ffffffffc0202e1a:	bc1ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202e1e:	040512e3          	bnez	a0,ffffffffc0203662 <pmm_init+0xb92>
ffffffffc0202e22:	000a2703          	lw	a4,0(s4)
ffffffffc0202e26:	4789                	li	a5,2
ffffffffc0202e28:	00f71de3          	bne	a4,a5,ffffffffc0203642 <pmm_init+0xb72>
ffffffffc0202e2c:	000c2783          	lw	a5,0(s8)
ffffffffc0202e30:	7e079963          	bnez	a5,ffffffffc0203622 <pmm_init+0xb52>
ffffffffc0202e34:	00093503          	ld	a0,0(s2)
ffffffffc0202e38:	4601                	li	a2,0
ffffffffc0202e3a:	6585                	lui	a1,0x1
ffffffffc0202e3c:	be8ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202e40:	54050263          	beqz	a0,ffffffffc0203384 <pmm_init+0x8b4>
ffffffffc0202e44:	6118                	ld	a4,0(a0)
ffffffffc0202e46:	00177793          	andi	a5,a4,1
ffffffffc0202e4a:	180781e3          	beqz	a5,ffffffffc02037cc <pmm_init+0xcfc>
ffffffffc0202e4e:	6094                	ld	a3,0(s1)
ffffffffc0202e50:	00271793          	slli	a5,a4,0x2
ffffffffc0202e54:	83b1                	srli	a5,a5,0xc
ffffffffc0202e56:	52d7f563          	bgeu	a5,a3,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202e5a:	000bb683          	ld	a3,0(s7)
ffffffffc0202e5e:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202e62:	97d6                	add	a5,a5,s5
ffffffffc0202e64:	079a                	slli	a5,a5,0x6
ffffffffc0202e66:	97b6                	add	a5,a5,a3
ffffffffc0202e68:	58fa1e63          	bne	s4,a5,ffffffffc0203404 <pmm_init+0x934>
ffffffffc0202e6c:	8b41                	andi	a4,a4,16
ffffffffc0202e6e:	56071b63          	bnez	a4,ffffffffc02033e4 <pmm_init+0x914>
ffffffffc0202e72:	00093503          	ld	a0,0(s2)
ffffffffc0202e76:	4581                	li	a1,0
ffffffffc0202e78:	ac7ff0ef          	jal	ra,ffffffffc020293e <page_remove>
ffffffffc0202e7c:	000a2c83          	lw	s9,0(s4)
ffffffffc0202e80:	4785                	li	a5,1
ffffffffc0202e82:	5cfc9163          	bne	s9,a5,ffffffffc0203444 <pmm_init+0x974>
ffffffffc0202e86:	000c2783          	lw	a5,0(s8)
ffffffffc0202e8a:	58079d63          	bnez	a5,ffffffffc0203424 <pmm_init+0x954>
ffffffffc0202e8e:	00093503          	ld	a0,0(s2)
ffffffffc0202e92:	6585                	lui	a1,0x1
ffffffffc0202e94:	aabff0ef          	jal	ra,ffffffffc020293e <page_remove>
ffffffffc0202e98:	000a2783          	lw	a5,0(s4)
ffffffffc0202e9c:	200793e3          	bnez	a5,ffffffffc02038a2 <pmm_init+0xdd2>
ffffffffc0202ea0:	000c2783          	lw	a5,0(s8)
ffffffffc0202ea4:	1c079fe3          	bnez	a5,ffffffffc0203882 <pmm_init+0xdb2>
ffffffffc0202ea8:	00093a03          	ld	s4,0(s2)
ffffffffc0202eac:	608c                	ld	a1,0(s1)
ffffffffc0202eae:	000a3683          	ld	a3,0(s4)
ffffffffc0202eb2:	068a                	slli	a3,a3,0x2
ffffffffc0202eb4:	82b1                	srli	a3,a3,0xc
ffffffffc0202eb6:	4cb6f563          	bgeu	a3,a1,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202eba:	000bb503          	ld	a0,0(s7)
ffffffffc0202ebe:	96d6                	add	a3,a3,s5
ffffffffc0202ec0:	069a                	slli	a3,a3,0x6
ffffffffc0202ec2:	00d507b3          	add	a5,a0,a3
ffffffffc0202ec6:	439c                	lw	a5,0(a5)
ffffffffc0202ec8:	4f979e63          	bne	a5,s9,ffffffffc02033c4 <pmm_init+0x8f4>
ffffffffc0202ecc:	8699                	srai	a3,a3,0x6
ffffffffc0202ece:	00080637          	lui	a2,0x80
ffffffffc0202ed2:	96b2                	add	a3,a3,a2
ffffffffc0202ed4:	00c69713          	slli	a4,a3,0xc
ffffffffc0202ed8:	8331                	srli	a4,a4,0xc
ffffffffc0202eda:	06b2                	slli	a3,a3,0xc
ffffffffc0202edc:	06b773e3          	bgeu	a4,a1,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0202ee0:	0009b703          	ld	a4,0(s3)
ffffffffc0202ee4:	96ba                	add	a3,a3,a4
ffffffffc0202ee6:	629c                	ld	a5,0(a3)
ffffffffc0202ee8:	078a                	slli	a5,a5,0x2
ffffffffc0202eea:	83b1                	srli	a5,a5,0xc
ffffffffc0202eec:	48b7fa63          	bgeu	a5,a1,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202ef0:	8f91                	sub	a5,a5,a2
ffffffffc0202ef2:	079a                	slli	a5,a5,0x6
ffffffffc0202ef4:	953e                	add	a0,a0,a5
ffffffffc0202ef6:	100027f3          	csrr	a5,sstatus
ffffffffc0202efa:	8b89                	andi	a5,a5,2
ffffffffc0202efc:	32079463          	bnez	a5,ffffffffc0203224 <pmm_init+0x754>
ffffffffc0202f00:	000b3783          	ld	a5,0(s6)
ffffffffc0202f04:	4585                	li	a1,1
ffffffffc0202f06:	739c                	ld	a5,32(a5)
ffffffffc0202f08:	9782                	jalr	a5
ffffffffc0202f0a:	000a3783          	ld	a5,0(s4)
ffffffffc0202f0e:	6098                	ld	a4,0(s1)
ffffffffc0202f10:	078a                	slli	a5,a5,0x2
ffffffffc0202f12:	83b1                	srli	a5,a5,0xc
ffffffffc0202f14:	46e7f663          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202f18:	000bb503          	ld	a0,0(s7)
ffffffffc0202f1c:	fff80737          	lui	a4,0xfff80
ffffffffc0202f20:	97ba                	add	a5,a5,a4
ffffffffc0202f22:	079a                	slli	a5,a5,0x6
ffffffffc0202f24:	953e                	add	a0,a0,a5
ffffffffc0202f26:	100027f3          	csrr	a5,sstatus
ffffffffc0202f2a:	8b89                	andi	a5,a5,2
ffffffffc0202f2c:	2e079063          	bnez	a5,ffffffffc020320c <pmm_init+0x73c>
ffffffffc0202f30:	000b3783          	ld	a5,0(s6)
ffffffffc0202f34:	4585                	li	a1,1
ffffffffc0202f36:	739c                	ld	a5,32(a5)
ffffffffc0202f38:	9782                	jalr	a5
ffffffffc0202f3a:	00093783          	ld	a5,0(s2)
ffffffffc0202f3e:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0202f42:	12000073          	sfence.vma
ffffffffc0202f46:	100027f3          	csrr	a5,sstatus
ffffffffc0202f4a:	8b89                	andi	a5,a5,2
ffffffffc0202f4c:	2a079663          	bnez	a5,ffffffffc02031f8 <pmm_init+0x728>
ffffffffc0202f50:	000b3783          	ld	a5,0(s6)
ffffffffc0202f54:	779c                	ld	a5,40(a5)
ffffffffc0202f56:	9782                	jalr	a5
ffffffffc0202f58:	8a2a                	mv	s4,a0
ffffffffc0202f5a:	7d441463          	bne	s0,s4,ffffffffc0203722 <pmm_init+0xc52>
ffffffffc0202f5e:	0000a517          	auipc	a0,0xa
ffffffffc0202f62:	a1a50513          	addi	a0,a0,-1510 # ffffffffc020c978 <default_pmm_manager+0x5f8>
ffffffffc0202f66:	a40fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202f6a:	100027f3          	csrr	a5,sstatus
ffffffffc0202f6e:	8b89                	andi	a5,a5,2
ffffffffc0202f70:	26079a63          	bnez	a5,ffffffffc02031e4 <pmm_init+0x714>
ffffffffc0202f74:	000b3783          	ld	a5,0(s6)
ffffffffc0202f78:	779c                	ld	a5,40(a5)
ffffffffc0202f7a:	9782                	jalr	a5
ffffffffc0202f7c:	8c2a                	mv	s8,a0
ffffffffc0202f7e:	6098                	ld	a4,0(s1)
ffffffffc0202f80:	c0200437          	lui	s0,0xc0200
ffffffffc0202f84:	7afd                	lui	s5,0xfffff
ffffffffc0202f86:	00c71793          	slli	a5,a4,0xc
ffffffffc0202f8a:	6a05                	lui	s4,0x1
ffffffffc0202f8c:	02f47c63          	bgeu	s0,a5,ffffffffc0202fc4 <pmm_init+0x4f4>
ffffffffc0202f90:	00c45793          	srli	a5,s0,0xc
ffffffffc0202f94:	00093503          	ld	a0,0(s2)
ffffffffc0202f98:	3ae7f763          	bgeu	a5,a4,ffffffffc0203346 <pmm_init+0x876>
ffffffffc0202f9c:	0009b583          	ld	a1,0(s3)
ffffffffc0202fa0:	4601                	li	a2,0
ffffffffc0202fa2:	95a2                	add	a1,a1,s0
ffffffffc0202fa4:	a80ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202fa8:	36050f63          	beqz	a0,ffffffffc0203326 <pmm_init+0x856>
ffffffffc0202fac:	611c                	ld	a5,0(a0)
ffffffffc0202fae:	078a                	slli	a5,a5,0x2
ffffffffc0202fb0:	0157f7b3          	and	a5,a5,s5
ffffffffc0202fb4:	3a879663          	bne	a5,s0,ffffffffc0203360 <pmm_init+0x890>
ffffffffc0202fb8:	6098                	ld	a4,0(s1)
ffffffffc0202fba:	9452                	add	s0,s0,s4
ffffffffc0202fbc:	00c71793          	slli	a5,a4,0xc
ffffffffc0202fc0:	fcf468e3          	bltu	s0,a5,ffffffffc0202f90 <pmm_init+0x4c0>
ffffffffc0202fc4:	00093783          	ld	a5,0(s2)
ffffffffc0202fc8:	639c                	ld	a5,0(a5)
ffffffffc0202fca:	48079d63          	bnez	a5,ffffffffc0203464 <pmm_init+0x994>
ffffffffc0202fce:	100027f3          	csrr	a5,sstatus
ffffffffc0202fd2:	8b89                	andi	a5,a5,2
ffffffffc0202fd4:	26079463          	bnez	a5,ffffffffc020323c <pmm_init+0x76c>
ffffffffc0202fd8:	000b3783          	ld	a5,0(s6)
ffffffffc0202fdc:	4505                	li	a0,1
ffffffffc0202fde:	6f9c                	ld	a5,24(a5)
ffffffffc0202fe0:	9782                	jalr	a5
ffffffffc0202fe2:	8a2a                	mv	s4,a0
ffffffffc0202fe4:	00093503          	ld	a0,0(s2)
ffffffffc0202fe8:	4699                	li	a3,6
ffffffffc0202fea:	10000613          	li	a2,256
ffffffffc0202fee:	85d2                	mv	a1,s4
ffffffffc0202ff0:	9ebff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202ff4:	4a051863          	bnez	a0,ffffffffc02034a4 <pmm_init+0x9d4>
ffffffffc0202ff8:	000a2703          	lw	a4,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202ffc:	4785                	li	a5,1
ffffffffc0202ffe:	48f71363          	bne	a4,a5,ffffffffc0203484 <pmm_init+0x9b4>
ffffffffc0203002:	00093503          	ld	a0,0(s2)
ffffffffc0203006:	6405                	lui	s0,0x1
ffffffffc0203008:	4699                	li	a3,6
ffffffffc020300a:	10040613          	addi	a2,s0,256 # 1100 <_binary_bin_swap_img_size-0x6c00>
ffffffffc020300e:	85d2                	mv	a1,s4
ffffffffc0203010:	9cbff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203014:	38051863          	bnez	a0,ffffffffc02033a4 <pmm_init+0x8d4>
ffffffffc0203018:	000a2703          	lw	a4,0(s4)
ffffffffc020301c:	4789                	li	a5,2
ffffffffc020301e:	4ef71363          	bne	a4,a5,ffffffffc0203504 <pmm_init+0xa34>
ffffffffc0203022:	0000a597          	auipc	a1,0xa
ffffffffc0203026:	a9e58593          	addi	a1,a1,-1378 # ffffffffc020cac0 <default_pmm_manager+0x740>
ffffffffc020302a:	10000513          	li	a0,256
ffffffffc020302e:	31c080ef          	jal	ra,ffffffffc020b34a <strcpy>
ffffffffc0203032:	10040593          	addi	a1,s0,256
ffffffffc0203036:	10000513          	li	a0,256
ffffffffc020303a:	322080ef          	jal	ra,ffffffffc020b35c <strcmp>
ffffffffc020303e:	4a051363          	bnez	a0,ffffffffc02034e4 <pmm_init+0xa14>
ffffffffc0203042:	000bb683          	ld	a3,0(s7)
ffffffffc0203046:	00080737          	lui	a4,0x80
ffffffffc020304a:	547d                	li	s0,-1
ffffffffc020304c:	40da06b3          	sub	a3,s4,a3
ffffffffc0203050:	8699                	srai	a3,a3,0x6
ffffffffc0203052:	609c                	ld	a5,0(s1)
ffffffffc0203054:	96ba                	add	a3,a3,a4
ffffffffc0203056:	8031                	srli	s0,s0,0xc
ffffffffc0203058:	0086f733          	and	a4,a3,s0
ffffffffc020305c:	06b2                	slli	a3,a3,0xc
ffffffffc020305e:	6ef77263          	bgeu	a4,a5,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0203062:	0009b783          	ld	a5,0(s3)
ffffffffc0203066:	10000513          	li	a0,256
ffffffffc020306a:	96be                	add	a3,a3,a5
ffffffffc020306c:	10068023          	sb	zero,256(a3)
ffffffffc0203070:	2a4080ef          	jal	ra,ffffffffc020b314 <strlen>
ffffffffc0203074:	44051863          	bnez	a0,ffffffffc02034c4 <pmm_init+0x9f4>
ffffffffc0203078:	00093a83          	ld	s5,0(s2)
ffffffffc020307c:	609c                	ld	a5,0(s1)
ffffffffc020307e:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0203082:	068a                	slli	a3,a3,0x2
ffffffffc0203084:	82b1                	srli	a3,a3,0xc
ffffffffc0203086:	2ef6fd63          	bgeu	a3,a5,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc020308a:	8c75                	and	s0,s0,a3
ffffffffc020308c:	06b2                	slli	a3,a3,0xc
ffffffffc020308e:	6af47a63          	bgeu	s0,a5,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0203092:	0009b403          	ld	s0,0(s3)
ffffffffc0203096:	9436                	add	s0,s0,a3
ffffffffc0203098:	100027f3          	csrr	a5,sstatus
ffffffffc020309c:	8b89                	andi	a5,a5,2
ffffffffc020309e:	1e079c63          	bnez	a5,ffffffffc0203296 <pmm_init+0x7c6>
ffffffffc02030a2:	000b3783          	ld	a5,0(s6)
ffffffffc02030a6:	4585                	li	a1,1
ffffffffc02030a8:	8552                	mv	a0,s4
ffffffffc02030aa:	739c                	ld	a5,32(a5)
ffffffffc02030ac:	9782                	jalr	a5
ffffffffc02030ae:	601c                	ld	a5,0(s0)
ffffffffc02030b0:	6098                	ld	a4,0(s1)
ffffffffc02030b2:	078a                	slli	a5,a5,0x2
ffffffffc02030b4:	83b1                	srli	a5,a5,0xc
ffffffffc02030b6:	2ce7f563          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02030ba:	000bb503          	ld	a0,0(s7)
ffffffffc02030be:	fff80737          	lui	a4,0xfff80
ffffffffc02030c2:	97ba                	add	a5,a5,a4
ffffffffc02030c4:	079a                	slli	a5,a5,0x6
ffffffffc02030c6:	953e                	add	a0,a0,a5
ffffffffc02030c8:	100027f3          	csrr	a5,sstatus
ffffffffc02030cc:	8b89                	andi	a5,a5,2
ffffffffc02030ce:	1a079863          	bnez	a5,ffffffffc020327e <pmm_init+0x7ae>
ffffffffc02030d2:	000b3783          	ld	a5,0(s6)
ffffffffc02030d6:	4585                	li	a1,1
ffffffffc02030d8:	739c                	ld	a5,32(a5)
ffffffffc02030da:	9782                	jalr	a5
ffffffffc02030dc:	000ab783          	ld	a5,0(s5)
ffffffffc02030e0:	6098                	ld	a4,0(s1)
ffffffffc02030e2:	078a                	slli	a5,a5,0x2
ffffffffc02030e4:	83b1                	srli	a5,a5,0xc
ffffffffc02030e6:	28e7fd63          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02030ea:	000bb503          	ld	a0,0(s7)
ffffffffc02030ee:	fff80737          	lui	a4,0xfff80
ffffffffc02030f2:	97ba                	add	a5,a5,a4
ffffffffc02030f4:	079a                	slli	a5,a5,0x6
ffffffffc02030f6:	953e                	add	a0,a0,a5
ffffffffc02030f8:	100027f3          	csrr	a5,sstatus
ffffffffc02030fc:	8b89                	andi	a5,a5,2
ffffffffc02030fe:	16079463          	bnez	a5,ffffffffc0203266 <pmm_init+0x796>
ffffffffc0203102:	000b3783          	ld	a5,0(s6)
ffffffffc0203106:	4585                	li	a1,1
ffffffffc0203108:	739c                	ld	a5,32(a5)
ffffffffc020310a:	9782                	jalr	a5
ffffffffc020310c:	00093783          	ld	a5,0(s2)
ffffffffc0203110:	0007b023          	sd	zero,0(a5)
ffffffffc0203114:	12000073          	sfence.vma
ffffffffc0203118:	100027f3          	csrr	a5,sstatus
ffffffffc020311c:	8b89                	andi	a5,a5,2
ffffffffc020311e:	12079a63          	bnez	a5,ffffffffc0203252 <pmm_init+0x782>
ffffffffc0203122:	000b3783          	ld	a5,0(s6)
ffffffffc0203126:	779c                	ld	a5,40(a5)
ffffffffc0203128:	9782                	jalr	a5
ffffffffc020312a:	842a                	mv	s0,a0
ffffffffc020312c:	488c1e63          	bne	s8,s0,ffffffffc02035c8 <pmm_init+0xaf8>
ffffffffc0203130:	0000a517          	auipc	a0,0xa
ffffffffc0203134:	a0850513          	addi	a0,a0,-1528 # ffffffffc020cb38 <default_pmm_manager+0x7b8>
ffffffffc0203138:	86efd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020313c:	7406                	ld	s0,96(sp)
ffffffffc020313e:	70a6                	ld	ra,104(sp)
ffffffffc0203140:	64e6                	ld	s1,88(sp)
ffffffffc0203142:	6946                	ld	s2,80(sp)
ffffffffc0203144:	69a6                	ld	s3,72(sp)
ffffffffc0203146:	6a06                	ld	s4,64(sp)
ffffffffc0203148:	7ae2                	ld	s5,56(sp)
ffffffffc020314a:	7b42                	ld	s6,48(sp)
ffffffffc020314c:	7ba2                	ld	s7,40(sp)
ffffffffc020314e:	7c02                	ld	s8,32(sp)
ffffffffc0203150:	6ce2                	ld	s9,24(sp)
ffffffffc0203152:	6165                	addi	sp,sp,112
ffffffffc0203154:	e17fe06f          	j	ffffffffc0201f6a <kmalloc_init>
ffffffffc0203158:	c80007b7          	lui	a5,0xc8000
ffffffffc020315c:	b411                	j	ffffffffc0202b60 <pmm_init+0x90>
ffffffffc020315e:	b15fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203162:	000b3783          	ld	a5,0(s6)
ffffffffc0203166:	4505                	li	a0,1
ffffffffc0203168:	6f9c                	ld	a5,24(a5)
ffffffffc020316a:	9782                	jalr	a5
ffffffffc020316c:	8c2a                	mv	s8,a0
ffffffffc020316e:	afffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203172:	b9a9                	j	ffffffffc0202dcc <pmm_init+0x2fc>
ffffffffc0203174:	afffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203178:	000b3783          	ld	a5,0(s6)
ffffffffc020317c:	4505                	li	a0,1
ffffffffc020317e:	6f9c                	ld	a5,24(a5)
ffffffffc0203180:	9782                	jalr	a5
ffffffffc0203182:	8a2a                	mv	s4,a0
ffffffffc0203184:	ae9fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203188:	b645                	j	ffffffffc0202d28 <pmm_init+0x258>
ffffffffc020318a:	ae9fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020318e:	000b3783          	ld	a5,0(s6)
ffffffffc0203192:	779c                	ld	a5,40(a5)
ffffffffc0203194:	9782                	jalr	a5
ffffffffc0203196:	842a                	mv	s0,a0
ffffffffc0203198:	ad5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020319c:	b6b9                	j	ffffffffc0202cea <pmm_init+0x21a>
ffffffffc020319e:	ad5fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031a2:	000b3783          	ld	a5,0(s6)
ffffffffc02031a6:	4505                	li	a0,1
ffffffffc02031a8:	6f9c                	ld	a5,24(a5)
ffffffffc02031aa:	9782                	jalr	a5
ffffffffc02031ac:	842a                	mv	s0,a0
ffffffffc02031ae:	abffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031b2:	bc99                	j	ffffffffc0202c08 <pmm_init+0x138>
ffffffffc02031b4:	6705                	lui	a4,0x1
ffffffffc02031b6:	177d                	addi	a4,a4,-1
ffffffffc02031b8:	96ba                	add	a3,a3,a4
ffffffffc02031ba:	8ff5                	and	a5,a5,a3
ffffffffc02031bc:	00c7d713          	srli	a4,a5,0xc
ffffffffc02031c0:	1ca77063          	bgeu	a4,a0,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02031c4:	000b3683          	ld	a3,0(s6)
ffffffffc02031c8:	fff80537          	lui	a0,0xfff80
ffffffffc02031cc:	972a                	add	a4,a4,a0
ffffffffc02031ce:	6a94                	ld	a3,16(a3)
ffffffffc02031d0:	8c1d                	sub	s0,s0,a5
ffffffffc02031d2:	00671513          	slli	a0,a4,0x6
ffffffffc02031d6:	00c45593          	srli	a1,s0,0xc
ffffffffc02031da:	9532                	add	a0,a0,a2
ffffffffc02031dc:	9682                	jalr	a3
ffffffffc02031de:	0009b583          	ld	a1,0(s3)
ffffffffc02031e2:	bac5                	j	ffffffffc0202bd2 <pmm_init+0x102>
ffffffffc02031e4:	a8ffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031e8:	000b3783          	ld	a5,0(s6)
ffffffffc02031ec:	779c                	ld	a5,40(a5)
ffffffffc02031ee:	9782                	jalr	a5
ffffffffc02031f0:	8c2a                	mv	s8,a0
ffffffffc02031f2:	a7bfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031f6:	b361                	j	ffffffffc0202f7e <pmm_init+0x4ae>
ffffffffc02031f8:	a7bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031fc:	000b3783          	ld	a5,0(s6)
ffffffffc0203200:	779c                	ld	a5,40(a5)
ffffffffc0203202:	9782                	jalr	a5
ffffffffc0203204:	8a2a                	mv	s4,a0
ffffffffc0203206:	a67fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020320a:	bb81                	j	ffffffffc0202f5a <pmm_init+0x48a>
ffffffffc020320c:	e42a                	sd	a0,8(sp)
ffffffffc020320e:	a65fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203212:	000b3783          	ld	a5,0(s6)
ffffffffc0203216:	6522                	ld	a0,8(sp)
ffffffffc0203218:	4585                	li	a1,1
ffffffffc020321a:	739c                	ld	a5,32(a5)
ffffffffc020321c:	9782                	jalr	a5
ffffffffc020321e:	a4ffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203222:	bb21                	j	ffffffffc0202f3a <pmm_init+0x46a>
ffffffffc0203224:	e42a                	sd	a0,8(sp)
ffffffffc0203226:	a4dfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020322a:	000b3783          	ld	a5,0(s6)
ffffffffc020322e:	6522                	ld	a0,8(sp)
ffffffffc0203230:	4585                	li	a1,1
ffffffffc0203232:	739c                	ld	a5,32(a5)
ffffffffc0203234:	9782                	jalr	a5
ffffffffc0203236:	a37fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020323a:	b9c1                	j	ffffffffc0202f0a <pmm_init+0x43a>
ffffffffc020323c:	a37fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203240:	000b3783          	ld	a5,0(s6)
ffffffffc0203244:	4505                	li	a0,1
ffffffffc0203246:	6f9c                	ld	a5,24(a5)
ffffffffc0203248:	9782                	jalr	a5
ffffffffc020324a:	8a2a                	mv	s4,a0
ffffffffc020324c:	a21fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203250:	bb51                	j	ffffffffc0202fe4 <pmm_init+0x514>
ffffffffc0203252:	a21fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203256:	000b3783          	ld	a5,0(s6)
ffffffffc020325a:	779c                	ld	a5,40(a5)
ffffffffc020325c:	9782                	jalr	a5
ffffffffc020325e:	842a                	mv	s0,a0
ffffffffc0203260:	a0dfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203264:	b5e1                	j	ffffffffc020312c <pmm_init+0x65c>
ffffffffc0203266:	e42a                	sd	a0,8(sp)
ffffffffc0203268:	a0bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020326c:	000b3783          	ld	a5,0(s6)
ffffffffc0203270:	6522                	ld	a0,8(sp)
ffffffffc0203272:	4585                	li	a1,1
ffffffffc0203274:	739c                	ld	a5,32(a5)
ffffffffc0203276:	9782                	jalr	a5
ffffffffc0203278:	9f5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020327c:	bd41                	j	ffffffffc020310c <pmm_init+0x63c>
ffffffffc020327e:	e42a                	sd	a0,8(sp)
ffffffffc0203280:	9f3fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203284:	000b3783          	ld	a5,0(s6)
ffffffffc0203288:	6522                	ld	a0,8(sp)
ffffffffc020328a:	4585                	li	a1,1
ffffffffc020328c:	739c                	ld	a5,32(a5)
ffffffffc020328e:	9782                	jalr	a5
ffffffffc0203290:	9ddfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203294:	b5a1                	j	ffffffffc02030dc <pmm_init+0x60c>
ffffffffc0203296:	9ddfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020329a:	000b3783          	ld	a5,0(s6)
ffffffffc020329e:	4585                	li	a1,1
ffffffffc02032a0:	8552                	mv	a0,s4
ffffffffc02032a2:	739c                	ld	a5,32(a5)
ffffffffc02032a4:	9782                	jalr	a5
ffffffffc02032a6:	9c7fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032aa:	b511                	j	ffffffffc02030ae <pmm_init+0x5de>
ffffffffc02032ac:	00010417          	auipc	s0,0x10
ffffffffc02032b0:	d5440413          	addi	s0,s0,-684 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc02032b4:	00010797          	auipc	a5,0x10
ffffffffc02032b8:	d4c78793          	addi	a5,a5,-692 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc02032bc:	a0f41de3          	bne	s0,a5,ffffffffc0202cd6 <pmm_init+0x206>
ffffffffc02032c0:	4581                	li	a1,0
ffffffffc02032c2:	6605                	lui	a2,0x1
ffffffffc02032c4:	8522                	mv	a0,s0
ffffffffc02032c6:	0f0080ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc02032ca:	0000d597          	auipc	a1,0xd
ffffffffc02032ce:	d3658593          	addi	a1,a1,-714 # ffffffffc0210000 <bootstackguard>
ffffffffc02032d2:	0000e797          	auipc	a5,0xe
ffffffffc02032d6:	d20786a3          	sb	zero,-723(a5) # ffffffffc0210fff <bootstackguard+0xfff>
ffffffffc02032da:	0000d797          	auipc	a5,0xd
ffffffffc02032de:	d2078323          	sb	zero,-730(a5) # ffffffffc0210000 <bootstackguard>
ffffffffc02032e2:	00093503          	ld	a0,0(s2)
ffffffffc02032e6:	2555ec63          	bltu	a1,s5,ffffffffc020353e <pmm_init+0xa6e>
ffffffffc02032ea:	0009b683          	ld	a3,0(s3)
ffffffffc02032ee:	4701                	li	a4,0
ffffffffc02032f0:	6605                	lui	a2,0x1
ffffffffc02032f2:	40d586b3          	sub	a3,a1,a3
ffffffffc02032f6:	956ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc02032fa:	00093503          	ld	a0,0(s2)
ffffffffc02032fe:	23546363          	bltu	s0,s5,ffffffffc0203524 <pmm_init+0xa54>
ffffffffc0203302:	0009b683          	ld	a3,0(s3)
ffffffffc0203306:	4701                	li	a4,0
ffffffffc0203308:	6605                	lui	a2,0x1
ffffffffc020330a:	40d406b3          	sub	a3,s0,a3
ffffffffc020330e:	85a2                	mv	a1,s0
ffffffffc0203310:	93cff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0203314:	12000073          	sfence.vma
ffffffffc0203318:	00009517          	auipc	a0,0x9
ffffffffc020331c:	33050513          	addi	a0,a0,816 # ffffffffc020c648 <default_pmm_manager+0x2c8>
ffffffffc0203320:	e87fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203324:	ba4d                	j	ffffffffc0202cd6 <pmm_init+0x206>
ffffffffc0203326:	00009697          	auipc	a3,0x9
ffffffffc020332a:	67268693          	addi	a3,a3,1650 # ffffffffc020c998 <default_pmm_manager+0x618>
ffffffffc020332e:	00008617          	auipc	a2,0x8
ffffffffc0203332:	56a60613          	addi	a2,a2,1386 # ffffffffc020b898 <commands+0x210>
ffffffffc0203336:	28a00593          	li	a1,650
ffffffffc020333a:	00009517          	auipc	a0,0x9
ffffffffc020333e:	19650513          	addi	a0,a0,406 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203342:	95cfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203346:	86a2                	mv	a3,s0
ffffffffc0203348:	00009617          	auipc	a2,0x9
ffffffffc020334c:	07060613          	addi	a2,a2,112 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc0203350:	28a00593          	li	a1,650
ffffffffc0203354:	00009517          	auipc	a0,0x9
ffffffffc0203358:	17c50513          	addi	a0,a0,380 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020335c:	942fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203360:	00009697          	auipc	a3,0x9
ffffffffc0203364:	67868693          	addi	a3,a3,1656 # ffffffffc020c9d8 <default_pmm_manager+0x658>
ffffffffc0203368:	00008617          	auipc	a2,0x8
ffffffffc020336c:	53060613          	addi	a2,a2,1328 # ffffffffc020b898 <commands+0x210>
ffffffffc0203370:	28b00593          	li	a1,651
ffffffffc0203374:	00009517          	auipc	a0,0x9
ffffffffc0203378:	15c50513          	addi	a0,a0,348 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020337c:	922fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203380:	db5fe0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc0203384:	00009697          	auipc	a3,0x9
ffffffffc0203388:	47c68693          	addi	a3,a3,1148 # ffffffffc020c800 <default_pmm_manager+0x480>
ffffffffc020338c:	00008617          	auipc	a2,0x8
ffffffffc0203390:	50c60613          	addi	a2,a2,1292 # ffffffffc020b898 <commands+0x210>
ffffffffc0203394:	26700593          	li	a1,615
ffffffffc0203398:	00009517          	auipc	a0,0x9
ffffffffc020339c:	13850513          	addi	a0,a0,312 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02033a0:	8fefd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033a4:	00009697          	auipc	a3,0x9
ffffffffc02033a8:	6bc68693          	addi	a3,a3,1724 # ffffffffc020ca60 <default_pmm_manager+0x6e0>
ffffffffc02033ac:	00008617          	auipc	a2,0x8
ffffffffc02033b0:	4ec60613          	addi	a2,a2,1260 # ffffffffc020b898 <commands+0x210>
ffffffffc02033b4:	29400593          	li	a1,660
ffffffffc02033b8:	00009517          	auipc	a0,0x9
ffffffffc02033bc:	11850513          	addi	a0,a0,280 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02033c0:	8defd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033c4:	00009697          	auipc	a3,0x9
ffffffffc02033c8:	55c68693          	addi	a3,a3,1372 # ffffffffc020c920 <default_pmm_manager+0x5a0>
ffffffffc02033cc:	00008617          	auipc	a2,0x8
ffffffffc02033d0:	4cc60613          	addi	a2,a2,1228 # ffffffffc020b898 <commands+0x210>
ffffffffc02033d4:	27300593          	li	a1,627
ffffffffc02033d8:	00009517          	auipc	a0,0x9
ffffffffc02033dc:	0f850513          	addi	a0,a0,248 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02033e0:	8befd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033e4:	00009697          	auipc	a3,0x9
ffffffffc02033e8:	50c68693          	addi	a3,a3,1292 # ffffffffc020c8f0 <default_pmm_manager+0x570>
ffffffffc02033ec:	00008617          	auipc	a2,0x8
ffffffffc02033f0:	4ac60613          	addi	a2,a2,1196 # ffffffffc020b898 <commands+0x210>
ffffffffc02033f4:	26900593          	li	a1,617
ffffffffc02033f8:	00009517          	auipc	a0,0x9
ffffffffc02033fc:	0d850513          	addi	a0,a0,216 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203400:	89efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203404:	00009697          	auipc	a3,0x9
ffffffffc0203408:	35c68693          	addi	a3,a3,860 # ffffffffc020c760 <default_pmm_manager+0x3e0>
ffffffffc020340c:	00008617          	auipc	a2,0x8
ffffffffc0203410:	48c60613          	addi	a2,a2,1164 # ffffffffc020b898 <commands+0x210>
ffffffffc0203414:	26800593          	li	a1,616
ffffffffc0203418:	00009517          	auipc	a0,0x9
ffffffffc020341c:	0b850513          	addi	a0,a0,184 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203420:	87efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203424:	00009697          	auipc	a3,0x9
ffffffffc0203428:	4b468693          	addi	a3,a3,1204 # ffffffffc020c8d8 <default_pmm_manager+0x558>
ffffffffc020342c:	00008617          	auipc	a2,0x8
ffffffffc0203430:	46c60613          	addi	a2,a2,1132 # ffffffffc020b898 <commands+0x210>
ffffffffc0203434:	26d00593          	li	a1,621
ffffffffc0203438:	00009517          	auipc	a0,0x9
ffffffffc020343c:	09850513          	addi	a0,a0,152 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203440:	85efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203444:	00009697          	auipc	a3,0x9
ffffffffc0203448:	33468693          	addi	a3,a3,820 # ffffffffc020c778 <default_pmm_manager+0x3f8>
ffffffffc020344c:	00008617          	auipc	a2,0x8
ffffffffc0203450:	44c60613          	addi	a2,a2,1100 # ffffffffc020b898 <commands+0x210>
ffffffffc0203454:	26c00593          	li	a1,620
ffffffffc0203458:	00009517          	auipc	a0,0x9
ffffffffc020345c:	07850513          	addi	a0,a0,120 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203460:	83efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203464:	00009697          	auipc	a3,0x9
ffffffffc0203468:	58c68693          	addi	a3,a3,1420 # ffffffffc020c9f0 <default_pmm_manager+0x670>
ffffffffc020346c:	00008617          	auipc	a2,0x8
ffffffffc0203470:	42c60613          	addi	a2,a2,1068 # ffffffffc020b898 <commands+0x210>
ffffffffc0203474:	28e00593          	li	a1,654
ffffffffc0203478:	00009517          	auipc	a0,0x9
ffffffffc020347c:	05850513          	addi	a0,a0,88 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203480:	81efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203484:	00009697          	auipc	a3,0x9
ffffffffc0203488:	5c468693          	addi	a3,a3,1476 # ffffffffc020ca48 <default_pmm_manager+0x6c8>
ffffffffc020348c:	00008617          	auipc	a2,0x8
ffffffffc0203490:	40c60613          	addi	a2,a2,1036 # ffffffffc020b898 <commands+0x210>
ffffffffc0203494:	29300593          	li	a1,659
ffffffffc0203498:	00009517          	auipc	a0,0x9
ffffffffc020349c:	03850513          	addi	a0,a0,56 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02034a0:	ffffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034a4:	00009697          	auipc	a3,0x9
ffffffffc02034a8:	56468693          	addi	a3,a3,1380 # ffffffffc020ca08 <default_pmm_manager+0x688>
ffffffffc02034ac:	00008617          	auipc	a2,0x8
ffffffffc02034b0:	3ec60613          	addi	a2,a2,1004 # ffffffffc020b898 <commands+0x210>
ffffffffc02034b4:	29200593          	li	a1,658
ffffffffc02034b8:	00009517          	auipc	a0,0x9
ffffffffc02034bc:	01850513          	addi	a0,a0,24 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02034c0:	fdffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034c4:	00009697          	auipc	a3,0x9
ffffffffc02034c8:	64c68693          	addi	a3,a3,1612 # ffffffffc020cb10 <default_pmm_manager+0x790>
ffffffffc02034cc:	00008617          	auipc	a2,0x8
ffffffffc02034d0:	3cc60613          	addi	a2,a2,972 # ffffffffc020b898 <commands+0x210>
ffffffffc02034d4:	29c00593          	li	a1,668
ffffffffc02034d8:	00009517          	auipc	a0,0x9
ffffffffc02034dc:	ff850513          	addi	a0,a0,-8 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02034e0:	fbffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034e4:	00009697          	auipc	a3,0x9
ffffffffc02034e8:	5f468693          	addi	a3,a3,1524 # ffffffffc020cad8 <default_pmm_manager+0x758>
ffffffffc02034ec:	00008617          	auipc	a2,0x8
ffffffffc02034f0:	3ac60613          	addi	a2,a2,940 # ffffffffc020b898 <commands+0x210>
ffffffffc02034f4:	29900593          	li	a1,665
ffffffffc02034f8:	00009517          	auipc	a0,0x9
ffffffffc02034fc:	fd850513          	addi	a0,a0,-40 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203500:	f9ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203504:	00009697          	auipc	a3,0x9
ffffffffc0203508:	5a468693          	addi	a3,a3,1444 # ffffffffc020caa8 <default_pmm_manager+0x728>
ffffffffc020350c:	00008617          	auipc	a2,0x8
ffffffffc0203510:	38c60613          	addi	a2,a2,908 # ffffffffc020b898 <commands+0x210>
ffffffffc0203514:	29500593          	li	a1,661
ffffffffc0203518:	00009517          	auipc	a0,0x9
ffffffffc020351c:	fb850513          	addi	a0,a0,-72 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203520:	f7ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203524:	86a2                	mv	a3,s0
ffffffffc0203526:	00009617          	auipc	a2,0x9
ffffffffc020352a:	f3a60613          	addi	a2,a2,-198 # ffffffffc020c460 <default_pmm_manager+0xe0>
ffffffffc020352e:	0dc00593          	li	a1,220
ffffffffc0203532:	00009517          	auipc	a0,0x9
ffffffffc0203536:	f9e50513          	addi	a0,a0,-98 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020353a:	f65fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020353e:	86ae                	mv	a3,a1
ffffffffc0203540:	00009617          	auipc	a2,0x9
ffffffffc0203544:	f2060613          	addi	a2,a2,-224 # ffffffffc020c460 <default_pmm_manager+0xe0>
ffffffffc0203548:	0db00593          	li	a1,219
ffffffffc020354c:	00009517          	auipc	a0,0x9
ffffffffc0203550:	f8450513          	addi	a0,a0,-124 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203554:	f4bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203558:	00009697          	auipc	a3,0x9
ffffffffc020355c:	13868693          	addi	a3,a3,312 # ffffffffc020c690 <default_pmm_manager+0x310>
ffffffffc0203560:	00008617          	auipc	a2,0x8
ffffffffc0203564:	33860613          	addi	a2,a2,824 # ffffffffc020b898 <commands+0x210>
ffffffffc0203568:	24c00593          	li	a1,588
ffffffffc020356c:	00009517          	auipc	a0,0x9
ffffffffc0203570:	f6450513          	addi	a0,a0,-156 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203574:	f2bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203578:	00009697          	auipc	a3,0x9
ffffffffc020357c:	0f868693          	addi	a3,a3,248 # ffffffffc020c670 <default_pmm_manager+0x2f0>
ffffffffc0203580:	00008617          	auipc	a2,0x8
ffffffffc0203584:	31860613          	addi	a2,a2,792 # ffffffffc020b898 <commands+0x210>
ffffffffc0203588:	24b00593          	li	a1,587
ffffffffc020358c:	00009517          	auipc	a0,0x9
ffffffffc0203590:	f4450513          	addi	a0,a0,-188 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203594:	f0bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203598:	00009617          	auipc	a2,0x9
ffffffffc020359c:	06860613          	addi	a2,a2,104 # ffffffffc020c600 <default_pmm_manager+0x280>
ffffffffc02035a0:	0aa00593          	li	a1,170
ffffffffc02035a4:	00009517          	auipc	a0,0x9
ffffffffc02035a8:	f2c50513          	addi	a0,a0,-212 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02035ac:	ef3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035b0:	00009617          	auipc	a2,0x9
ffffffffc02035b4:	fb860613          	addi	a2,a2,-72 # ffffffffc020c568 <default_pmm_manager+0x1e8>
ffffffffc02035b8:	06500593          	li	a1,101
ffffffffc02035bc:	00009517          	auipc	a0,0x9
ffffffffc02035c0:	f1450513          	addi	a0,a0,-236 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02035c4:	edbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035c8:	00009697          	auipc	a3,0x9
ffffffffc02035cc:	38868693          	addi	a3,a3,904 # ffffffffc020c950 <default_pmm_manager+0x5d0>
ffffffffc02035d0:	00008617          	auipc	a2,0x8
ffffffffc02035d4:	2c860613          	addi	a2,a2,712 # ffffffffc020b898 <commands+0x210>
ffffffffc02035d8:	2a500593          	li	a1,677
ffffffffc02035dc:	00009517          	auipc	a0,0x9
ffffffffc02035e0:	ef450513          	addi	a0,a0,-268 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02035e4:	ebbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035e8:	00009697          	auipc	a3,0x9
ffffffffc02035ec:	1a868693          	addi	a3,a3,424 # ffffffffc020c790 <default_pmm_manager+0x410>
ffffffffc02035f0:	00008617          	auipc	a2,0x8
ffffffffc02035f4:	2a860613          	addi	a2,a2,680 # ffffffffc020b898 <commands+0x210>
ffffffffc02035f8:	25a00593          	li	a1,602
ffffffffc02035fc:	00009517          	auipc	a0,0x9
ffffffffc0203600:	ed450513          	addi	a0,a0,-300 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203604:	e9bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203608:	86d6                	mv	a3,s5
ffffffffc020360a:	00009617          	auipc	a2,0x9
ffffffffc020360e:	dae60613          	addi	a2,a2,-594 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc0203612:	25900593          	li	a1,601
ffffffffc0203616:	00009517          	auipc	a0,0x9
ffffffffc020361a:	eba50513          	addi	a0,a0,-326 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020361e:	e81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203622:	00009697          	auipc	a3,0x9
ffffffffc0203626:	2b668693          	addi	a3,a3,694 # ffffffffc020c8d8 <default_pmm_manager+0x558>
ffffffffc020362a:	00008617          	auipc	a2,0x8
ffffffffc020362e:	26e60613          	addi	a2,a2,622 # ffffffffc020b898 <commands+0x210>
ffffffffc0203632:	26600593          	li	a1,614
ffffffffc0203636:	00009517          	auipc	a0,0x9
ffffffffc020363a:	e9a50513          	addi	a0,a0,-358 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020363e:	e61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203642:	00009697          	auipc	a3,0x9
ffffffffc0203646:	27e68693          	addi	a3,a3,638 # ffffffffc020c8c0 <default_pmm_manager+0x540>
ffffffffc020364a:	00008617          	auipc	a2,0x8
ffffffffc020364e:	24e60613          	addi	a2,a2,590 # ffffffffc020b898 <commands+0x210>
ffffffffc0203652:	26500593          	li	a1,613
ffffffffc0203656:	00009517          	auipc	a0,0x9
ffffffffc020365a:	e7a50513          	addi	a0,a0,-390 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020365e:	e41fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203662:	00009697          	auipc	a3,0x9
ffffffffc0203666:	22e68693          	addi	a3,a3,558 # ffffffffc020c890 <default_pmm_manager+0x510>
ffffffffc020366a:	00008617          	auipc	a2,0x8
ffffffffc020366e:	22e60613          	addi	a2,a2,558 # ffffffffc020b898 <commands+0x210>
ffffffffc0203672:	26400593          	li	a1,612
ffffffffc0203676:	00009517          	auipc	a0,0x9
ffffffffc020367a:	e5a50513          	addi	a0,a0,-422 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020367e:	e21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203682:	00009697          	auipc	a3,0x9
ffffffffc0203686:	1f668693          	addi	a3,a3,502 # ffffffffc020c878 <default_pmm_manager+0x4f8>
ffffffffc020368a:	00008617          	auipc	a2,0x8
ffffffffc020368e:	20e60613          	addi	a2,a2,526 # ffffffffc020b898 <commands+0x210>
ffffffffc0203692:	26200593          	li	a1,610
ffffffffc0203696:	00009517          	auipc	a0,0x9
ffffffffc020369a:	e3a50513          	addi	a0,a0,-454 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020369e:	e01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036a2:	00009697          	auipc	a3,0x9
ffffffffc02036a6:	1b668693          	addi	a3,a3,438 # ffffffffc020c858 <default_pmm_manager+0x4d8>
ffffffffc02036aa:	00008617          	auipc	a2,0x8
ffffffffc02036ae:	1ee60613          	addi	a2,a2,494 # ffffffffc020b898 <commands+0x210>
ffffffffc02036b2:	26100593          	li	a1,609
ffffffffc02036b6:	00009517          	auipc	a0,0x9
ffffffffc02036ba:	e1a50513          	addi	a0,a0,-486 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02036be:	de1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036c2:	00009697          	auipc	a3,0x9
ffffffffc02036c6:	18668693          	addi	a3,a3,390 # ffffffffc020c848 <default_pmm_manager+0x4c8>
ffffffffc02036ca:	00008617          	auipc	a2,0x8
ffffffffc02036ce:	1ce60613          	addi	a2,a2,462 # ffffffffc020b898 <commands+0x210>
ffffffffc02036d2:	26000593          	li	a1,608
ffffffffc02036d6:	00009517          	auipc	a0,0x9
ffffffffc02036da:	dfa50513          	addi	a0,a0,-518 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02036de:	dc1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036e2:	00009697          	auipc	a3,0x9
ffffffffc02036e6:	15668693          	addi	a3,a3,342 # ffffffffc020c838 <default_pmm_manager+0x4b8>
ffffffffc02036ea:	00008617          	auipc	a2,0x8
ffffffffc02036ee:	1ae60613          	addi	a2,a2,430 # ffffffffc020b898 <commands+0x210>
ffffffffc02036f2:	25f00593          	li	a1,607
ffffffffc02036f6:	00009517          	auipc	a0,0x9
ffffffffc02036fa:	dda50513          	addi	a0,a0,-550 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02036fe:	da1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203702:	00009697          	auipc	a3,0x9
ffffffffc0203706:	0fe68693          	addi	a3,a3,254 # ffffffffc020c800 <default_pmm_manager+0x480>
ffffffffc020370a:	00008617          	auipc	a2,0x8
ffffffffc020370e:	18e60613          	addi	a2,a2,398 # ffffffffc020b898 <commands+0x210>
ffffffffc0203712:	25e00593          	li	a1,606
ffffffffc0203716:	00009517          	auipc	a0,0x9
ffffffffc020371a:	dba50513          	addi	a0,a0,-582 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020371e:	d81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203722:	00009697          	auipc	a3,0x9
ffffffffc0203726:	22e68693          	addi	a3,a3,558 # ffffffffc020c950 <default_pmm_manager+0x5d0>
ffffffffc020372a:	00008617          	auipc	a2,0x8
ffffffffc020372e:	16e60613          	addi	a2,a2,366 # ffffffffc020b898 <commands+0x210>
ffffffffc0203732:	27b00593          	li	a1,635
ffffffffc0203736:	00009517          	auipc	a0,0x9
ffffffffc020373a:	d9a50513          	addi	a0,a0,-614 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020373e:	d61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203742:	00009617          	auipc	a2,0x9
ffffffffc0203746:	c7660613          	addi	a2,a2,-906 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc020374a:	07100593          	li	a1,113
ffffffffc020374e:	00009517          	auipc	a0,0x9
ffffffffc0203752:	c9250513          	addi	a0,a0,-878 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0203756:	d49fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020375a:	86a2                	mv	a3,s0
ffffffffc020375c:	00009617          	auipc	a2,0x9
ffffffffc0203760:	d0460613          	addi	a2,a2,-764 # ffffffffc020c460 <default_pmm_manager+0xe0>
ffffffffc0203764:	0ca00593          	li	a1,202
ffffffffc0203768:	00009517          	auipc	a0,0x9
ffffffffc020376c:	d6850513          	addi	a0,a0,-664 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203770:	d2ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203774:	00009617          	auipc	a2,0x9
ffffffffc0203778:	cec60613          	addi	a2,a2,-788 # ffffffffc020c460 <default_pmm_manager+0xe0>
ffffffffc020377c:	08100593          	li	a1,129
ffffffffc0203780:	00009517          	auipc	a0,0x9
ffffffffc0203784:	d5050513          	addi	a0,a0,-688 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203788:	d17fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020378c:	00009697          	auipc	a3,0x9
ffffffffc0203790:	03468693          	addi	a3,a3,52 # ffffffffc020c7c0 <default_pmm_manager+0x440>
ffffffffc0203794:	00008617          	auipc	a2,0x8
ffffffffc0203798:	10460613          	addi	a2,a2,260 # ffffffffc020b898 <commands+0x210>
ffffffffc020379c:	25d00593          	li	a1,605
ffffffffc02037a0:	00009517          	auipc	a0,0x9
ffffffffc02037a4:	d3050513          	addi	a0,a0,-720 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02037a8:	cf7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037ac:	00009697          	auipc	a3,0x9
ffffffffc02037b0:	f5468693          	addi	a3,a3,-172 # ffffffffc020c700 <default_pmm_manager+0x380>
ffffffffc02037b4:	00008617          	auipc	a2,0x8
ffffffffc02037b8:	0e460613          	addi	a2,a2,228 # ffffffffc020b898 <commands+0x210>
ffffffffc02037bc:	25100593          	li	a1,593
ffffffffc02037c0:	00009517          	auipc	a0,0x9
ffffffffc02037c4:	d1050513          	addi	a0,a0,-752 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02037c8:	cd7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037cc:	985fe0ef          	jal	ra,ffffffffc0202150 <pte2page.part.0>
ffffffffc02037d0:	00009697          	auipc	a3,0x9
ffffffffc02037d4:	f6068693          	addi	a3,a3,-160 # ffffffffc020c730 <default_pmm_manager+0x3b0>
ffffffffc02037d8:	00008617          	auipc	a2,0x8
ffffffffc02037dc:	0c060613          	addi	a2,a2,192 # ffffffffc020b898 <commands+0x210>
ffffffffc02037e0:	25400593          	li	a1,596
ffffffffc02037e4:	00009517          	auipc	a0,0x9
ffffffffc02037e8:	cec50513          	addi	a0,a0,-788 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02037ec:	cb3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037f0:	00009697          	auipc	a3,0x9
ffffffffc02037f4:	ee068693          	addi	a3,a3,-288 # ffffffffc020c6d0 <default_pmm_manager+0x350>
ffffffffc02037f8:	00008617          	auipc	a2,0x8
ffffffffc02037fc:	0a060613          	addi	a2,a2,160 # ffffffffc020b898 <commands+0x210>
ffffffffc0203800:	24d00593          	li	a1,589
ffffffffc0203804:	00009517          	auipc	a0,0x9
ffffffffc0203808:	ccc50513          	addi	a0,a0,-820 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020380c:	c93fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203810:	00009697          	auipc	a3,0x9
ffffffffc0203814:	f5068693          	addi	a3,a3,-176 # ffffffffc020c760 <default_pmm_manager+0x3e0>
ffffffffc0203818:	00008617          	auipc	a2,0x8
ffffffffc020381c:	08060613          	addi	a2,a2,128 # ffffffffc020b898 <commands+0x210>
ffffffffc0203820:	25500593          	li	a1,597
ffffffffc0203824:	00009517          	auipc	a0,0x9
ffffffffc0203828:	cac50513          	addi	a0,a0,-852 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020382c:	c73fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203830:	00009617          	auipc	a2,0x9
ffffffffc0203834:	b8860613          	addi	a2,a2,-1144 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc0203838:	25800593          	li	a1,600
ffffffffc020383c:	00009517          	auipc	a0,0x9
ffffffffc0203840:	c9450513          	addi	a0,a0,-876 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203844:	c5bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203848:	00009697          	auipc	a3,0x9
ffffffffc020384c:	f3068693          	addi	a3,a3,-208 # ffffffffc020c778 <default_pmm_manager+0x3f8>
ffffffffc0203850:	00008617          	auipc	a2,0x8
ffffffffc0203854:	04860613          	addi	a2,a2,72 # ffffffffc020b898 <commands+0x210>
ffffffffc0203858:	25600593          	li	a1,598
ffffffffc020385c:	00009517          	auipc	a0,0x9
ffffffffc0203860:	c7450513          	addi	a0,a0,-908 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203864:	c3bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203868:	86ca                	mv	a3,s2
ffffffffc020386a:	00009617          	auipc	a2,0x9
ffffffffc020386e:	bf660613          	addi	a2,a2,-1034 # ffffffffc020c460 <default_pmm_manager+0xe0>
ffffffffc0203872:	0c600593          	li	a1,198
ffffffffc0203876:	00009517          	auipc	a0,0x9
ffffffffc020387a:	c5a50513          	addi	a0,a0,-934 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020387e:	c21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203882:	00009697          	auipc	a3,0x9
ffffffffc0203886:	05668693          	addi	a3,a3,86 # ffffffffc020c8d8 <default_pmm_manager+0x558>
ffffffffc020388a:	00008617          	auipc	a2,0x8
ffffffffc020388e:	00e60613          	addi	a2,a2,14 # ffffffffc020b898 <commands+0x210>
ffffffffc0203892:	27100593          	li	a1,625
ffffffffc0203896:	00009517          	auipc	a0,0x9
ffffffffc020389a:	c3a50513          	addi	a0,a0,-966 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc020389e:	c01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038a2:	00009697          	auipc	a3,0x9
ffffffffc02038a6:	06668693          	addi	a3,a3,102 # ffffffffc020c908 <default_pmm_manager+0x588>
ffffffffc02038aa:	00008617          	auipc	a2,0x8
ffffffffc02038ae:	fee60613          	addi	a2,a2,-18 # ffffffffc020b898 <commands+0x210>
ffffffffc02038b2:	27000593          	li	a1,624
ffffffffc02038b6:	00009517          	auipc	a0,0x9
ffffffffc02038ba:	c1a50513          	addi	a0,a0,-998 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc02038be:	be1fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02038c2 <copy_range>:
ffffffffc02038c2:	7159                	addi	sp,sp,-112
ffffffffc02038c4:	00d667b3          	or	a5,a2,a3
ffffffffc02038c8:	f486                	sd	ra,104(sp)
ffffffffc02038ca:	f0a2                	sd	s0,96(sp)
ffffffffc02038cc:	eca6                	sd	s1,88(sp)
ffffffffc02038ce:	e8ca                	sd	s2,80(sp)
ffffffffc02038d0:	e4ce                	sd	s3,72(sp)
ffffffffc02038d2:	e0d2                	sd	s4,64(sp)
ffffffffc02038d4:	fc56                	sd	s5,56(sp)
ffffffffc02038d6:	f85a                	sd	s6,48(sp)
ffffffffc02038d8:	f45e                	sd	s7,40(sp)
ffffffffc02038da:	f062                	sd	s8,32(sp)
ffffffffc02038dc:	ec66                	sd	s9,24(sp)
ffffffffc02038de:	e86a                	sd	s10,16(sp)
ffffffffc02038e0:	e46e                	sd	s11,8(sp)
ffffffffc02038e2:	17d2                	slli	a5,a5,0x34
ffffffffc02038e4:	20079f63          	bnez	a5,ffffffffc0203b02 <copy_range+0x240>
ffffffffc02038e8:	002007b7          	lui	a5,0x200
ffffffffc02038ec:	8432                	mv	s0,a2
ffffffffc02038ee:	1af66263          	bltu	a2,a5,ffffffffc0203a92 <copy_range+0x1d0>
ffffffffc02038f2:	8936                	mv	s2,a3
ffffffffc02038f4:	18d67f63          	bgeu	a2,a3,ffffffffc0203a92 <copy_range+0x1d0>
ffffffffc02038f8:	4785                	li	a5,1
ffffffffc02038fa:	07fe                	slli	a5,a5,0x1f
ffffffffc02038fc:	18d7eb63          	bltu	a5,a3,ffffffffc0203a92 <copy_range+0x1d0>
ffffffffc0203900:	5b7d                	li	s6,-1
ffffffffc0203902:	8aaa                	mv	s5,a0
ffffffffc0203904:	89ae                	mv	s3,a1
ffffffffc0203906:	6a05                	lui	s4,0x1
ffffffffc0203908:	00093c17          	auipc	s8,0x93
ffffffffc020390c:	f98c0c13          	addi	s8,s8,-104 # ffffffffc02968a0 <npage>
ffffffffc0203910:	00093b97          	auipc	s7,0x93
ffffffffc0203914:	f98b8b93          	addi	s7,s7,-104 # ffffffffc02968a8 <pages>
ffffffffc0203918:	00cb5b13          	srli	s6,s6,0xc
ffffffffc020391c:	00093c97          	auipc	s9,0x93
ffffffffc0203920:	f94c8c93          	addi	s9,s9,-108 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203924:	4601                	li	a2,0
ffffffffc0203926:	85a2                	mv	a1,s0
ffffffffc0203928:	854e                	mv	a0,s3
ffffffffc020392a:	8fbfe0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020392e:	84aa                	mv	s1,a0
ffffffffc0203930:	0e050c63          	beqz	a0,ffffffffc0203a28 <copy_range+0x166>
ffffffffc0203934:	611c                	ld	a5,0(a0)
ffffffffc0203936:	8b85                	andi	a5,a5,1
ffffffffc0203938:	e785                	bnez	a5,ffffffffc0203960 <copy_range+0x9e>
ffffffffc020393a:	9452                	add	s0,s0,s4
ffffffffc020393c:	ff2464e3          	bltu	s0,s2,ffffffffc0203924 <copy_range+0x62>
ffffffffc0203940:	4501                	li	a0,0
ffffffffc0203942:	70a6                	ld	ra,104(sp)
ffffffffc0203944:	7406                	ld	s0,96(sp)
ffffffffc0203946:	64e6                	ld	s1,88(sp)
ffffffffc0203948:	6946                	ld	s2,80(sp)
ffffffffc020394a:	69a6                	ld	s3,72(sp)
ffffffffc020394c:	6a06                	ld	s4,64(sp)
ffffffffc020394e:	7ae2                	ld	s5,56(sp)
ffffffffc0203950:	7b42                	ld	s6,48(sp)
ffffffffc0203952:	7ba2                	ld	s7,40(sp)
ffffffffc0203954:	7c02                	ld	s8,32(sp)
ffffffffc0203956:	6ce2                	ld	s9,24(sp)
ffffffffc0203958:	6d42                	ld	s10,16(sp)
ffffffffc020395a:	6da2                	ld	s11,8(sp)
ffffffffc020395c:	6165                	addi	sp,sp,112
ffffffffc020395e:	8082                	ret
ffffffffc0203960:	4605                	li	a2,1
ffffffffc0203962:	85a2                	mv	a1,s0
ffffffffc0203964:	8556                	mv	a0,s5
ffffffffc0203966:	8bffe0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020396a:	c56d                	beqz	a0,ffffffffc0203a54 <copy_range+0x192>
ffffffffc020396c:	609c                	ld	a5,0(s1)
ffffffffc020396e:	0017f713          	andi	a4,a5,1
ffffffffc0203972:	01f7f493          	andi	s1,a5,31
ffffffffc0203976:	16070a63          	beqz	a4,ffffffffc0203aea <copy_range+0x228>
ffffffffc020397a:	000c3683          	ld	a3,0(s8)
ffffffffc020397e:	078a                	slli	a5,a5,0x2
ffffffffc0203980:	00c7d713          	srli	a4,a5,0xc
ffffffffc0203984:	14d77763          	bgeu	a4,a3,ffffffffc0203ad2 <copy_range+0x210>
ffffffffc0203988:	000bb783          	ld	a5,0(s7)
ffffffffc020398c:	fff806b7          	lui	a3,0xfff80
ffffffffc0203990:	9736                	add	a4,a4,a3
ffffffffc0203992:	071a                	slli	a4,a4,0x6
ffffffffc0203994:	00e78db3          	add	s11,a5,a4
ffffffffc0203998:	10002773          	csrr	a4,sstatus
ffffffffc020399c:	8b09                	andi	a4,a4,2
ffffffffc020399e:	e345                	bnez	a4,ffffffffc0203a3e <copy_range+0x17c>
ffffffffc02039a0:	000cb703          	ld	a4,0(s9)
ffffffffc02039a4:	4505                	li	a0,1
ffffffffc02039a6:	6f18                	ld	a4,24(a4)
ffffffffc02039a8:	9702                	jalr	a4
ffffffffc02039aa:	8d2a                	mv	s10,a0
ffffffffc02039ac:	0c0d8363          	beqz	s11,ffffffffc0203a72 <copy_range+0x1b0>
ffffffffc02039b0:	100d0163          	beqz	s10,ffffffffc0203ab2 <copy_range+0x1f0>
ffffffffc02039b4:	000bb703          	ld	a4,0(s7)
ffffffffc02039b8:	000805b7          	lui	a1,0x80
ffffffffc02039bc:	000c3603          	ld	a2,0(s8)
ffffffffc02039c0:	40ed86b3          	sub	a3,s11,a4
ffffffffc02039c4:	8699                	srai	a3,a3,0x6
ffffffffc02039c6:	96ae                	add	a3,a3,a1
ffffffffc02039c8:	0166f7b3          	and	a5,a3,s6
ffffffffc02039cc:	06b2                	slli	a3,a3,0xc
ffffffffc02039ce:	08c7f663          	bgeu	a5,a2,ffffffffc0203a5a <copy_range+0x198>
ffffffffc02039d2:	40ed07b3          	sub	a5,s10,a4
ffffffffc02039d6:	00093717          	auipc	a4,0x93
ffffffffc02039da:	ee270713          	addi	a4,a4,-286 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02039de:	6308                	ld	a0,0(a4)
ffffffffc02039e0:	8799                	srai	a5,a5,0x6
ffffffffc02039e2:	97ae                	add	a5,a5,a1
ffffffffc02039e4:	0167f733          	and	a4,a5,s6
ffffffffc02039e8:	00a685b3          	add	a1,a3,a0
ffffffffc02039ec:	07b2                	slli	a5,a5,0xc
ffffffffc02039ee:	06c77563          	bgeu	a4,a2,ffffffffc0203a58 <copy_range+0x196>
ffffffffc02039f2:	6605                	lui	a2,0x1
ffffffffc02039f4:	953e                	add	a0,a0,a5
ffffffffc02039f6:	213070ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc02039fa:	86a6                	mv	a3,s1
ffffffffc02039fc:	8622                	mv	a2,s0
ffffffffc02039fe:	85ea                	mv	a1,s10
ffffffffc0203a00:	8556                	mv	a0,s5
ffffffffc0203a02:	fd9fe0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203a06:	d915                	beqz	a0,ffffffffc020393a <copy_range+0x78>
ffffffffc0203a08:	00009697          	auipc	a3,0x9
ffffffffc0203a0c:	17068693          	addi	a3,a3,368 # ffffffffc020cb78 <default_pmm_manager+0x7f8>
ffffffffc0203a10:	00008617          	auipc	a2,0x8
ffffffffc0203a14:	e8860613          	addi	a2,a2,-376 # ffffffffc020b898 <commands+0x210>
ffffffffc0203a18:	1e900593          	li	a1,489
ffffffffc0203a1c:	00009517          	auipc	a0,0x9
ffffffffc0203a20:	ab450513          	addi	a0,a0,-1356 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203a24:	a7bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a28:	00200637          	lui	a2,0x200
ffffffffc0203a2c:	9432                	add	s0,s0,a2
ffffffffc0203a2e:	ffe00637          	lui	a2,0xffe00
ffffffffc0203a32:	8c71                	and	s0,s0,a2
ffffffffc0203a34:	f00406e3          	beqz	s0,ffffffffc0203940 <copy_range+0x7e>
ffffffffc0203a38:	ef2466e3          	bltu	s0,s2,ffffffffc0203924 <copy_range+0x62>
ffffffffc0203a3c:	b711                	j	ffffffffc0203940 <copy_range+0x7e>
ffffffffc0203a3e:	a34fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203a42:	000cb703          	ld	a4,0(s9)
ffffffffc0203a46:	4505                	li	a0,1
ffffffffc0203a48:	6f18                	ld	a4,24(a4)
ffffffffc0203a4a:	9702                	jalr	a4
ffffffffc0203a4c:	8d2a                	mv	s10,a0
ffffffffc0203a4e:	a1efd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203a52:	bfa9                	j	ffffffffc02039ac <copy_range+0xea>
ffffffffc0203a54:	5571                	li	a0,-4
ffffffffc0203a56:	b5f5                	j	ffffffffc0203942 <copy_range+0x80>
ffffffffc0203a58:	86be                	mv	a3,a5
ffffffffc0203a5a:	00009617          	auipc	a2,0x9
ffffffffc0203a5e:	95e60613          	addi	a2,a2,-1698 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc0203a62:	07100593          	li	a1,113
ffffffffc0203a66:	00009517          	auipc	a0,0x9
ffffffffc0203a6a:	97a50513          	addi	a0,a0,-1670 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0203a6e:	a31fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a72:	00009697          	auipc	a3,0x9
ffffffffc0203a76:	0e668693          	addi	a3,a3,230 # ffffffffc020cb58 <default_pmm_manager+0x7d8>
ffffffffc0203a7a:	00008617          	auipc	a2,0x8
ffffffffc0203a7e:	e1e60613          	addi	a2,a2,-482 # ffffffffc020b898 <commands+0x210>
ffffffffc0203a82:	1ce00593          	li	a1,462
ffffffffc0203a86:	00009517          	auipc	a0,0x9
ffffffffc0203a8a:	a4a50513          	addi	a0,a0,-1462 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203a8e:	a11fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a92:	00009697          	auipc	a3,0x9
ffffffffc0203a96:	aa668693          	addi	a3,a3,-1370 # ffffffffc020c538 <default_pmm_manager+0x1b8>
ffffffffc0203a9a:	00008617          	auipc	a2,0x8
ffffffffc0203a9e:	dfe60613          	addi	a2,a2,-514 # ffffffffc020b898 <commands+0x210>
ffffffffc0203aa2:	1b600593          	li	a1,438
ffffffffc0203aa6:	00009517          	auipc	a0,0x9
ffffffffc0203aaa:	a2a50513          	addi	a0,a0,-1494 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203aae:	9f1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ab2:	00009697          	auipc	a3,0x9
ffffffffc0203ab6:	0b668693          	addi	a3,a3,182 # ffffffffc020cb68 <default_pmm_manager+0x7e8>
ffffffffc0203aba:	00008617          	auipc	a2,0x8
ffffffffc0203abe:	dde60613          	addi	a2,a2,-546 # ffffffffc020b898 <commands+0x210>
ffffffffc0203ac2:	1cf00593          	li	a1,463
ffffffffc0203ac6:	00009517          	auipc	a0,0x9
ffffffffc0203aca:	a0a50513          	addi	a0,a0,-1526 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203ace:	9d1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ad2:	00009617          	auipc	a2,0x9
ffffffffc0203ad6:	9b660613          	addi	a2,a2,-1610 # ffffffffc020c488 <default_pmm_manager+0x108>
ffffffffc0203ada:	06900593          	li	a1,105
ffffffffc0203ade:	00009517          	auipc	a0,0x9
ffffffffc0203ae2:	90250513          	addi	a0,a0,-1790 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0203ae6:	9b9fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203aea:	00009617          	auipc	a2,0x9
ffffffffc0203aee:	9be60613          	addi	a2,a2,-1602 # ffffffffc020c4a8 <default_pmm_manager+0x128>
ffffffffc0203af2:	07f00593          	li	a1,127
ffffffffc0203af6:	00009517          	auipc	a0,0x9
ffffffffc0203afa:	8ea50513          	addi	a0,a0,-1814 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0203afe:	9a1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b02:	00009697          	auipc	a3,0x9
ffffffffc0203b06:	a0668693          	addi	a3,a3,-1530 # ffffffffc020c508 <default_pmm_manager+0x188>
ffffffffc0203b0a:	00008617          	auipc	a2,0x8
ffffffffc0203b0e:	d8e60613          	addi	a2,a2,-626 # ffffffffc020b898 <commands+0x210>
ffffffffc0203b12:	1b500593          	li	a1,437
ffffffffc0203b16:	00009517          	auipc	a0,0x9
ffffffffc0203b1a:	9ba50513          	addi	a0,a0,-1606 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203b1e:	981fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203b22 <pgdir_alloc_page>:
ffffffffc0203b22:	7179                	addi	sp,sp,-48
ffffffffc0203b24:	ec26                	sd	s1,24(sp)
ffffffffc0203b26:	e84a                	sd	s2,16(sp)
ffffffffc0203b28:	e052                	sd	s4,0(sp)
ffffffffc0203b2a:	f406                	sd	ra,40(sp)
ffffffffc0203b2c:	f022                	sd	s0,32(sp)
ffffffffc0203b2e:	e44e                	sd	s3,8(sp)
ffffffffc0203b30:	8a2a                	mv	s4,a0
ffffffffc0203b32:	84ae                	mv	s1,a1
ffffffffc0203b34:	8932                	mv	s2,a2
ffffffffc0203b36:	100027f3          	csrr	a5,sstatus
ffffffffc0203b3a:	8b89                	andi	a5,a5,2
ffffffffc0203b3c:	00093997          	auipc	s3,0x93
ffffffffc0203b40:	d7498993          	addi	s3,s3,-652 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203b44:	ef8d                	bnez	a5,ffffffffc0203b7e <pgdir_alloc_page+0x5c>
ffffffffc0203b46:	0009b783          	ld	a5,0(s3)
ffffffffc0203b4a:	4505                	li	a0,1
ffffffffc0203b4c:	6f9c                	ld	a5,24(a5)
ffffffffc0203b4e:	9782                	jalr	a5
ffffffffc0203b50:	842a                	mv	s0,a0
ffffffffc0203b52:	cc09                	beqz	s0,ffffffffc0203b6c <pgdir_alloc_page+0x4a>
ffffffffc0203b54:	86ca                	mv	a3,s2
ffffffffc0203b56:	8626                	mv	a2,s1
ffffffffc0203b58:	85a2                	mv	a1,s0
ffffffffc0203b5a:	8552                	mv	a0,s4
ffffffffc0203b5c:	e7ffe0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203b60:	e915                	bnez	a0,ffffffffc0203b94 <pgdir_alloc_page+0x72>
ffffffffc0203b62:	4018                	lw	a4,0(s0)
ffffffffc0203b64:	fc04                	sd	s1,56(s0)
ffffffffc0203b66:	4785                	li	a5,1
ffffffffc0203b68:	04f71e63          	bne	a4,a5,ffffffffc0203bc4 <pgdir_alloc_page+0xa2>
ffffffffc0203b6c:	70a2                	ld	ra,40(sp)
ffffffffc0203b6e:	8522                	mv	a0,s0
ffffffffc0203b70:	7402                	ld	s0,32(sp)
ffffffffc0203b72:	64e2                	ld	s1,24(sp)
ffffffffc0203b74:	6942                	ld	s2,16(sp)
ffffffffc0203b76:	69a2                	ld	s3,8(sp)
ffffffffc0203b78:	6a02                	ld	s4,0(sp)
ffffffffc0203b7a:	6145                	addi	sp,sp,48
ffffffffc0203b7c:	8082                	ret
ffffffffc0203b7e:	8f4fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203b82:	0009b783          	ld	a5,0(s3)
ffffffffc0203b86:	4505                	li	a0,1
ffffffffc0203b88:	6f9c                	ld	a5,24(a5)
ffffffffc0203b8a:	9782                	jalr	a5
ffffffffc0203b8c:	842a                	mv	s0,a0
ffffffffc0203b8e:	8defd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203b92:	b7c1                	j	ffffffffc0203b52 <pgdir_alloc_page+0x30>
ffffffffc0203b94:	100027f3          	csrr	a5,sstatus
ffffffffc0203b98:	8b89                	andi	a5,a5,2
ffffffffc0203b9a:	eb89                	bnez	a5,ffffffffc0203bac <pgdir_alloc_page+0x8a>
ffffffffc0203b9c:	0009b783          	ld	a5,0(s3)
ffffffffc0203ba0:	8522                	mv	a0,s0
ffffffffc0203ba2:	4585                	li	a1,1
ffffffffc0203ba4:	739c                	ld	a5,32(a5)
ffffffffc0203ba6:	4401                	li	s0,0
ffffffffc0203ba8:	9782                	jalr	a5
ffffffffc0203baa:	b7c9                	j	ffffffffc0203b6c <pgdir_alloc_page+0x4a>
ffffffffc0203bac:	8c6fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203bb0:	0009b783          	ld	a5,0(s3)
ffffffffc0203bb4:	8522                	mv	a0,s0
ffffffffc0203bb6:	4585                	li	a1,1
ffffffffc0203bb8:	739c                	ld	a5,32(a5)
ffffffffc0203bba:	4401                	li	s0,0
ffffffffc0203bbc:	9782                	jalr	a5
ffffffffc0203bbe:	8aefd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203bc2:	b76d                	j	ffffffffc0203b6c <pgdir_alloc_page+0x4a>
ffffffffc0203bc4:	00009697          	auipc	a3,0x9
ffffffffc0203bc8:	fc468693          	addi	a3,a3,-60 # ffffffffc020cb88 <default_pmm_manager+0x808>
ffffffffc0203bcc:	00008617          	auipc	a2,0x8
ffffffffc0203bd0:	ccc60613          	addi	a2,a2,-820 # ffffffffc020b898 <commands+0x210>
ffffffffc0203bd4:	23200593          	li	a1,562
ffffffffc0203bd8:	00009517          	auipc	a0,0x9
ffffffffc0203bdc:	8f850513          	addi	a0,a0,-1800 # ffffffffc020c4d0 <default_pmm_manager+0x150>
ffffffffc0203be0:	8bffc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203be4 <check_vma_overlap.part.0>:
ffffffffc0203be4:	1141                	addi	sp,sp,-16
ffffffffc0203be6:	00009697          	auipc	a3,0x9
ffffffffc0203bea:	fba68693          	addi	a3,a3,-70 # ffffffffc020cba0 <default_pmm_manager+0x820>
ffffffffc0203bee:	00008617          	auipc	a2,0x8
ffffffffc0203bf2:	caa60613          	addi	a2,a2,-854 # ffffffffc020b898 <commands+0x210>
ffffffffc0203bf6:	07400593          	li	a1,116
ffffffffc0203bfa:	00009517          	auipc	a0,0x9
ffffffffc0203bfe:	fc650513          	addi	a0,a0,-58 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc0203c02:	e406                	sd	ra,8(sp)
ffffffffc0203c04:	89bfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203c08 <mm_create>:
ffffffffc0203c08:	1141                	addi	sp,sp,-16
ffffffffc0203c0a:	05800513          	li	a0,88
ffffffffc0203c0e:	e022                	sd	s0,0(sp)
ffffffffc0203c10:	e406                	sd	ra,8(sp)
ffffffffc0203c12:	b7cfe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203c16:	842a                	mv	s0,a0
ffffffffc0203c18:	c115                	beqz	a0,ffffffffc0203c3c <mm_create+0x34>
ffffffffc0203c1a:	e408                	sd	a0,8(s0)
ffffffffc0203c1c:	e008                	sd	a0,0(s0)
ffffffffc0203c1e:	00053823          	sd	zero,16(a0)
ffffffffc0203c22:	00053c23          	sd	zero,24(a0)
ffffffffc0203c26:	02052023          	sw	zero,32(a0)
ffffffffc0203c2a:	02053423          	sd	zero,40(a0)
ffffffffc0203c2e:	02052823          	sw	zero,48(a0)
ffffffffc0203c32:	4585                	li	a1,1
ffffffffc0203c34:	03850513          	addi	a0,a0,56
ffffffffc0203c38:	123000ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc0203c3c:	60a2                	ld	ra,8(sp)
ffffffffc0203c3e:	8522                	mv	a0,s0
ffffffffc0203c40:	6402                	ld	s0,0(sp)
ffffffffc0203c42:	0141                	addi	sp,sp,16
ffffffffc0203c44:	8082                	ret

ffffffffc0203c46 <find_vma>:
ffffffffc0203c46:	86aa                	mv	a3,a0
ffffffffc0203c48:	c505                	beqz	a0,ffffffffc0203c70 <find_vma+0x2a>
ffffffffc0203c4a:	6908                	ld	a0,16(a0)
ffffffffc0203c4c:	c501                	beqz	a0,ffffffffc0203c54 <find_vma+0xe>
ffffffffc0203c4e:	651c                	ld	a5,8(a0)
ffffffffc0203c50:	02f5f263          	bgeu	a1,a5,ffffffffc0203c74 <find_vma+0x2e>
ffffffffc0203c54:	669c                	ld	a5,8(a3)
ffffffffc0203c56:	00f68d63          	beq	a3,a5,ffffffffc0203c70 <find_vma+0x2a>
ffffffffc0203c5a:	fe87b703          	ld	a4,-24(a5) # 1fffe8 <_binary_bin_sfs_img_size+0x18ace8>
ffffffffc0203c5e:	00e5e663          	bltu	a1,a4,ffffffffc0203c6a <find_vma+0x24>
ffffffffc0203c62:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203c66:	00e5ec63          	bltu	a1,a4,ffffffffc0203c7e <find_vma+0x38>
ffffffffc0203c6a:	679c                	ld	a5,8(a5)
ffffffffc0203c6c:	fef697e3          	bne	a3,a5,ffffffffc0203c5a <find_vma+0x14>
ffffffffc0203c70:	4501                	li	a0,0
ffffffffc0203c72:	8082                	ret
ffffffffc0203c74:	691c                	ld	a5,16(a0)
ffffffffc0203c76:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0203c54 <find_vma+0xe>
ffffffffc0203c7a:	ea88                	sd	a0,16(a3)
ffffffffc0203c7c:	8082                	ret
ffffffffc0203c7e:	fe078513          	addi	a0,a5,-32
ffffffffc0203c82:	ea88                	sd	a0,16(a3)
ffffffffc0203c84:	8082                	ret

ffffffffc0203c86 <insert_vma_struct>:
ffffffffc0203c86:	6590                	ld	a2,8(a1)
ffffffffc0203c88:	0105b803          	ld	a6,16(a1) # 80010 <_binary_bin_sfs_img_size+0xad10>
ffffffffc0203c8c:	1141                	addi	sp,sp,-16
ffffffffc0203c8e:	e406                	sd	ra,8(sp)
ffffffffc0203c90:	87aa                	mv	a5,a0
ffffffffc0203c92:	01066763          	bltu	a2,a6,ffffffffc0203ca0 <insert_vma_struct+0x1a>
ffffffffc0203c96:	a085                	j	ffffffffc0203cf6 <insert_vma_struct+0x70>
ffffffffc0203c98:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203c9c:	04e66863          	bltu	a2,a4,ffffffffc0203cec <insert_vma_struct+0x66>
ffffffffc0203ca0:	86be                	mv	a3,a5
ffffffffc0203ca2:	679c                	ld	a5,8(a5)
ffffffffc0203ca4:	fef51ae3          	bne	a0,a5,ffffffffc0203c98 <insert_vma_struct+0x12>
ffffffffc0203ca8:	02a68463          	beq	a3,a0,ffffffffc0203cd0 <insert_vma_struct+0x4a>
ffffffffc0203cac:	ff06b703          	ld	a4,-16(a3)
ffffffffc0203cb0:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203cb4:	08e8f163          	bgeu	a7,a4,ffffffffc0203d36 <insert_vma_struct+0xb0>
ffffffffc0203cb8:	04e66f63          	bltu	a2,a4,ffffffffc0203d16 <insert_vma_struct+0x90>
ffffffffc0203cbc:	00f50a63          	beq	a0,a5,ffffffffc0203cd0 <insert_vma_struct+0x4a>
ffffffffc0203cc0:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203cc4:	05076963          	bltu	a4,a6,ffffffffc0203d16 <insert_vma_struct+0x90>
ffffffffc0203cc8:	ff07b603          	ld	a2,-16(a5)
ffffffffc0203ccc:	02c77363          	bgeu	a4,a2,ffffffffc0203cf2 <insert_vma_struct+0x6c>
ffffffffc0203cd0:	5118                	lw	a4,32(a0)
ffffffffc0203cd2:	e188                	sd	a0,0(a1)
ffffffffc0203cd4:	02058613          	addi	a2,a1,32
ffffffffc0203cd8:	e390                	sd	a2,0(a5)
ffffffffc0203cda:	e690                	sd	a2,8(a3)
ffffffffc0203cdc:	60a2                	ld	ra,8(sp)
ffffffffc0203cde:	f59c                	sd	a5,40(a1)
ffffffffc0203ce0:	f194                	sd	a3,32(a1)
ffffffffc0203ce2:	0017079b          	addiw	a5,a4,1
ffffffffc0203ce6:	d11c                	sw	a5,32(a0)
ffffffffc0203ce8:	0141                	addi	sp,sp,16
ffffffffc0203cea:	8082                	ret
ffffffffc0203cec:	fca690e3          	bne	a3,a0,ffffffffc0203cac <insert_vma_struct+0x26>
ffffffffc0203cf0:	bfd1                	j	ffffffffc0203cc4 <insert_vma_struct+0x3e>
ffffffffc0203cf2:	ef3ff0ef          	jal	ra,ffffffffc0203be4 <check_vma_overlap.part.0>
ffffffffc0203cf6:	00009697          	auipc	a3,0x9
ffffffffc0203cfa:	eda68693          	addi	a3,a3,-294 # ffffffffc020cbd0 <default_pmm_manager+0x850>
ffffffffc0203cfe:	00008617          	auipc	a2,0x8
ffffffffc0203d02:	b9a60613          	addi	a2,a2,-1126 # ffffffffc020b898 <commands+0x210>
ffffffffc0203d06:	07a00593          	li	a1,122
ffffffffc0203d0a:	00009517          	auipc	a0,0x9
ffffffffc0203d0e:	eb650513          	addi	a0,a0,-330 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc0203d12:	f8cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d16:	00009697          	auipc	a3,0x9
ffffffffc0203d1a:	efa68693          	addi	a3,a3,-262 # ffffffffc020cc10 <default_pmm_manager+0x890>
ffffffffc0203d1e:	00008617          	auipc	a2,0x8
ffffffffc0203d22:	b7a60613          	addi	a2,a2,-1158 # ffffffffc020b898 <commands+0x210>
ffffffffc0203d26:	07300593          	li	a1,115
ffffffffc0203d2a:	00009517          	auipc	a0,0x9
ffffffffc0203d2e:	e9650513          	addi	a0,a0,-362 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc0203d32:	f6cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d36:	00009697          	auipc	a3,0x9
ffffffffc0203d3a:	eba68693          	addi	a3,a3,-326 # ffffffffc020cbf0 <default_pmm_manager+0x870>
ffffffffc0203d3e:	00008617          	auipc	a2,0x8
ffffffffc0203d42:	b5a60613          	addi	a2,a2,-1190 # ffffffffc020b898 <commands+0x210>
ffffffffc0203d46:	07200593          	li	a1,114
ffffffffc0203d4a:	00009517          	auipc	a0,0x9
ffffffffc0203d4e:	e7650513          	addi	a0,a0,-394 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc0203d52:	f4cfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203d56 <mm_destroy>:
ffffffffc0203d56:	591c                	lw	a5,48(a0)
ffffffffc0203d58:	1141                	addi	sp,sp,-16
ffffffffc0203d5a:	e406                	sd	ra,8(sp)
ffffffffc0203d5c:	e022                	sd	s0,0(sp)
ffffffffc0203d5e:	e78d                	bnez	a5,ffffffffc0203d88 <mm_destroy+0x32>
ffffffffc0203d60:	842a                	mv	s0,a0
ffffffffc0203d62:	6508                	ld	a0,8(a0)
ffffffffc0203d64:	00a40c63          	beq	s0,a0,ffffffffc0203d7c <mm_destroy+0x26>
ffffffffc0203d68:	6118                	ld	a4,0(a0)
ffffffffc0203d6a:	651c                	ld	a5,8(a0)
ffffffffc0203d6c:	1501                	addi	a0,a0,-32
ffffffffc0203d6e:	e71c                	sd	a5,8(a4)
ffffffffc0203d70:	e398                	sd	a4,0(a5)
ffffffffc0203d72:	accfe0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0203d76:	6408                	ld	a0,8(s0)
ffffffffc0203d78:	fea418e3          	bne	s0,a0,ffffffffc0203d68 <mm_destroy+0x12>
ffffffffc0203d7c:	8522                	mv	a0,s0
ffffffffc0203d7e:	6402                	ld	s0,0(sp)
ffffffffc0203d80:	60a2                	ld	ra,8(sp)
ffffffffc0203d82:	0141                	addi	sp,sp,16
ffffffffc0203d84:	abafe06f          	j	ffffffffc020203e <kfree>
ffffffffc0203d88:	00009697          	auipc	a3,0x9
ffffffffc0203d8c:	ea868693          	addi	a3,a3,-344 # ffffffffc020cc30 <default_pmm_manager+0x8b0>
ffffffffc0203d90:	00008617          	auipc	a2,0x8
ffffffffc0203d94:	b0860613          	addi	a2,a2,-1272 # ffffffffc020b898 <commands+0x210>
ffffffffc0203d98:	09e00593          	li	a1,158
ffffffffc0203d9c:	00009517          	auipc	a0,0x9
ffffffffc0203da0:	e2450513          	addi	a0,a0,-476 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc0203da4:	efafc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203da8 <mm_map>:
ffffffffc0203da8:	7139                	addi	sp,sp,-64
ffffffffc0203daa:	f822                	sd	s0,48(sp)
ffffffffc0203dac:	6405                	lui	s0,0x1
ffffffffc0203dae:	147d                	addi	s0,s0,-1
ffffffffc0203db0:	77fd                	lui	a5,0xfffff
ffffffffc0203db2:	9622                	add	a2,a2,s0
ffffffffc0203db4:	962e                	add	a2,a2,a1
ffffffffc0203db6:	f426                	sd	s1,40(sp)
ffffffffc0203db8:	fc06                	sd	ra,56(sp)
ffffffffc0203dba:	00f5f4b3          	and	s1,a1,a5
ffffffffc0203dbe:	f04a                	sd	s2,32(sp)
ffffffffc0203dc0:	ec4e                	sd	s3,24(sp)
ffffffffc0203dc2:	e852                	sd	s4,16(sp)
ffffffffc0203dc4:	e456                	sd	s5,8(sp)
ffffffffc0203dc6:	002005b7          	lui	a1,0x200
ffffffffc0203dca:	00f67433          	and	s0,a2,a5
ffffffffc0203dce:	06b4e363          	bltu	s1,a1,ffffffffc0203e34 <mm_map+0x8c>
ffffffffc0203dd2:	0684f163          	bgeu	s1,s0,ffffffffc0203e34 <mm_map+0x8c>
ffffffffc0203dd6:	4785                	li	a5,1
ffffffffc0203dd8:	07fe                	slli	a5,a5,0x1f
ffffffffc0203dda:	0487ed63          	bltu	a5,s0,ffffffffc0203e34 <mm_map+0x8c>
ffffffffc0203dde:	89aa                	mv	s3,a0
ffffffffc0203de0:	cd21                	beqz	a0,ffffffffc0203e38 <mm_map+0x90>
ffffffffc0203de2:	85a6                	mv	a1,s1
ffffffffc0203de4:	8ab6                	mv	s5,a3
ffffffffc0203de6:	8a3a                	mv	s4,a4
ffffffffc0203de8:	e5fff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc0203dec:	c501                	beqz	a0,ffffffffc0203df4 <mm_map+0x4c>
ffffffffc0203dee:	651c                	ld	a5,8(a0)
ffffffffc0203df0:	0487e263          	bltu	a5,s0,ffffffffc0203e34 <mm_map+0x8c>
ffffffffc0203df4:	03000513          	li	a0,48
ffffffffc0203df8:	996fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203dfc:	892a                	mv	s2,a0
ffffffffc0203dfe:	5571                	li	a0,-4
ffffffffc0203e00:	02090163          	beqz	s2,ffffffffc0203e22 <mm_map+0x7a>
ffffffffc0203e04:	854e                	mv	a0,s3
ffffffffc0203e06:	00993423          	sd	s1,8(s2)
ffffffffc0203e0a:	00893823          	sd	s0,16(s2)
ffffffffc0203e0e:	01592c23          	sw	s5,24(s2)
ffffffffc0203e12:	85ca                	mv	a1,s2
ffffffffc0203e14:	e73ff0ef          	jal	ra,ffffffffc0203c86 <insert_vma_struct>
ffffffffc0203e18:	4501                	li	a0,0
ffffffffc0203e1a:	000a0463          	beqz	s4,ffffffffc0203e22 <mm_map+0x7a>
ffffffffc0203e1e:	012a3023          	sd	s2,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0203e22:	70e2                	ld	ra,56(sp)
ffffffffc0203e24:	7442                	ld	s0,48(sp)
ffffffffc0203e26:	74a2                	ld	s1,40(sp)
ffffffffc0203e28:	7902                	ld	s2,32(sp)
ffffffffc0203e2a:	69e2                	ld	s3,24(sp)
ffffffffc0203e2c:	6a42                	ld	s4,16(sp)
ffffffffc0203e2e:	6aa2                	ld	s5,8(sp)
ffffffffc0203e30:	6121                	addi	sp,sp,64
ffffffffc0203e32:	8082                	ret
ffffffffc0203e34:	5575                	li	a0,-3
ffffffffc0203e36:	b7f5                	j	ffffffffc0203e22 <mm_map+0x7a>
ffffffffc0203e38:	00009697          	auipc	a3,0x9
ffffffffc0203e3c:	e1068693          	addi	a3,a3,-496 # ffffffffc020cc48 <default_pmm_manager+0x8c8>
ffffffffc0203e40:	00008617          	auipc	a2,0x8
ffffffffc0203e44:	a5860613          	addi	a2,a2,-1448 # ffffffffc020b898 <commands+0x210>
ffffffffc0203e48:	0b300593          	li	a1,179
ffffffffc0203e4c:	00009517          	auipc	a0,0x9
ffffffffc0203e50:	d7450513          	addi	a0,a0,-652 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc0203e54:	e4afc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203e58 <dup_mmap>:
ffffffffc0203e58:	7139                	addi	sp,sp,-64
ffffffffc0203e5a:	fc06                	sd	ra,56(sp)
ffffffffc0203e5c:	f822                	sd	s0,48(sp)
ffffffffc0203e5e:	f426                	sd	s1,40(sp)
ffffffffc0203e60:	f04a                	sd	s2,32(sp)
ffffffffc0203e62:	ec4e                	sd	s3,24(sp)
ffffffffc0203e64:	e852                	sd	s4,16(sp)
ffffffffc0203e66:	e456                	sd	s5,8(sp)
ffffffffc0203e68:	c52d                	beqz	a0,ffffffffc0203ed2 <dup_mmap+0x7a>
ffffffffc0203e6a:	892a                	mv	s2,a0
ffffffffc0203e6c:	84ae                	mv	s1,a1
ffffffffc0203e6e:	842e                	mv	s0,a1
ffffffffc0203e70:	e595                	bnez	a1,ffffffffc0203e9c <dup_mmap+0x44>
ffffffffc0203e72:	a085                	j	ffffffffc0203ed2 <dup_mmap+0x7a>
ffffffffc0203e74:	854a                	mv	a0,s2
ffffffffc0203e76:	0155b423          	sd	s5,8(a1) # 200008 <_binary_bin_sfs_img_size+0x18ad08>
ffffffffc0203e7a:	0145b823          	sd	s4,16(a1)
ffffffffc0203e7e:	0135ac23          	sw	s3,24(a1)
ffffffffc0203e82:	e05ff0ef          	jal	ra,ffffffffc0203c86 <insert_vma_struct>
ffffffffc0203e86:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_bin_swap_img_size-0x6d10>
ffffffffc0203e8a:	fe843603          	ld	a2,-24(s0)
ffffffffc0203e8e:	6c8c                	ld	a1,24(s1)
ffffffffc0203e90:	01893503          	ld	a0,24(s2)
ffffffffc0203e94:	4701                	li	a4,0
ffffffffc0203e96:	a2dff0ef          	jal	ra,ffffffffc02038c2 <copy_range>
ffffffffc0203e9a:	e105                	bnez	a0,ffffffffc0203eba <dup_mmap+0x62>
ffffffffc0203e9c:	6000                	ld	s0,0(s0)
ffffffffc0203e9e:	02848863          	beq	s1,s0,ffffffffc0203ece <dup_mmap+0x76>
ffffffffc0203ea2:	03000513          	li	a0,48
ffffffffc0203ea6:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203eaa:	ff043a03          	ld	s4,-16(s0)
ffffffffc0203eae:	ff842983          	lw	s3,-8(s0)
ffffffffc0203eb2:	8dcfe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203eb6:	85aa                	mv	a1,a0
ffffffffc0203eb8:	fd55                	bnez	a0,ffffffffc0203e74 <dup_mmap+0x1c>
ffffffffc0203eba:	5571                	li	a0,-4
ffffffffc0203ebc:	70e2                	ld	ra,56(sp)
ffffffffc0203ebe:	7442                	ld	s0,48(sp)
ffffffffc0203ec0:	74a2                	ld	s1,40(sp)
ffffffffc0203ec2:	7902                	ld	s2,32(sp)
ffffffffc0203ec4:	69e2                	ld	s3,24(sp)
ffffffffc0203ec6:	6a42                	ld	s4,16(sp)
ffffffffc0203ec8:	6aa2                	ld	s5,8(sp)
ffffffffc0203eca:	6121                	addi	sp,sp,64
ffffffffc0203ecc:	8082                	ret
ffffffffc0203ece:	4501                	li	a0,0
ffffffffc0203ed0:	b7f5                	j	ffffffffc0203ebc <dup_mmap+0x64>
ffffffffc0203ed2:	00009697          	auipc	a3,0x9
ffffffffc0203ed6:	d8668693          	addi	a3,a3,-634 # ffffffffc020cc58 <default_pmm_manager+0x8d8>
ffffffffc0203eda:	00008617          	auipc	a2,0x8
ffffffffc0203ede:	9be60613          	addi	a2,a2,-1602 # ffffffffc020b898 <commands+0x210>
ffffffffc0203ee2:	0cf00593          	li	a1,207
ffffffffc0203ee6:	00009517          	auipc	a0,0x9
ffffffffc0203eea:	cda50513          	addi	a0,a0,-806 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc0203eee:	db0fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203ef2 <exit_mmap>:
ffffffffc0203ef2:	1101                	addi	sp,sp,-32
ffffffffc0203ef4:	ec06                	sd	ra,24(sp)
ffffffffc0203ef6:	e822                	sd	s0,16(sp)
ffffffffc0203ef8:	e426                	sd	s1,8(sp)
ffffffffc0203efa:	e04a                	sd	s2,0(sp)
ffffffffc0203efc:	c531                	beqz	a0,ffffffffc0203f48 <exit_mmap+0x56>
ffffffffc0203efe:	591c                	lw	a5,48(a0)
ffffffffc0203f00:	84aa                	mv	s1,a0
ffffffffc0203f02:	e3b9                	bnez	a5,ffffffffc0203f48 <exit_mmap+0x56>
ffffffffc0203f04:	6500                	ld	s0,8(a0)
ffffffffc0203f06:	01853903          	ld	s2,24(a0)
ffffffffc0203f0a:	02850663          	beq	a0,s0,ffffffffc0203f36 <exit_mmap+0x44>
ffffffffc0203f0e:	ff043603          	ld	a2,-16(s0)
ffffffffc0203f12:	fe843583          	ld	a1,-24(s0)
ffffffffc0203f16:	854a                	mv	a0,s2
ffffffffc0203f18:	e4efe0ef          	jal	ra,ffffffffc0202566 <unmap_range>
ffffffffc0203f1c:	6400                	ld	s0,8(s0)
ffffffffc0203f1e:	fe8498e3          	bne	s1,s0,ffffffffc0203f0e <exit_mmap+0x1c>
ffffffffc0203f22:	6400                	ld	s0,8(s0)
ffffffffc0203f24:	00848c63          	beq	s1,s0,ffffffffc0203f3c <exit_mmap+0x4a>
ffffffffc0203f28:	ff043603          	ld	a2,-16(s0)
ffffffffc0203f2c:	fe843583          	ld	a1,-24(s0)
ffffffffc0203f30:	854a                	mv	a0,s2
ffffffffc0203f32:	f7afe0ef          	jal	ra,ffffffffc02026ac <exit_range>
ffffffffc0203f36:	6400                	ld	s0,8(s0)
ffffffffc0203f38:	fe8498e3          	bne	s1,s0,ffffffffc0203f28 <exit_mmap+0x36>
ffffffffc0203f3c:	60e2                	ld	ra,24(sp)
ffffffffc0203f3e:	6442                	ld	s0,16(sp)
ffffffffc0203f40:	64a2                	ld	s1,8(sp)
ffffffffc0203f42:	6902                	ld	s2,0(sp)
ffffffffc0203f44:	6105                	addi	sp,sp,32
ffffffffc0203f46:	8082                	ret
ffffffffc0203f48:	00009697          	auipc	a3,0x9
ffffffffc0203f4c:	d3068693          	addi	a3,a3,-720 # ffffffffc020cc78 <default_pmm_manager+0x8f8>
ffffffffc0203f50:	00008617          	auipc	a2,0x8
ffffffffc0203f54:	94860613          	addi	a2,a2,-1720 # ffffffffc020b898 <commands+0x210>
ffffffffc0203f58:	0e800593          	li	a1,232
ffffffffc0203f5c:	00009517          	auipc	a0,0x9
ffffffffc0203f60:	c6450513          	addi	a0,a0,-924 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc0203f64:	d3afc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203f68 <vmm_init>:
ffffffffc0203f68:	7139                	addi	sp,sp,-64
ffffffffc0203f6a:	05800513          	li	a0,88
ffffffffc0203f6e:	fc06                	sd	ra,56(sp)
ffffffffc0203f70:	f822                	sd	s0,48(sp)
ffffffffc0203f72:	f426                	sd	s1,40(sp)
ffffffffc0203f74:	f04a                	sd	s2,32(sp)
ffffffffc0203f76:	ec4e                	sd	s3,24(sp)
ffffffffc0203f78:	e852                	sd	s4,16(sp)
ffffffffc0203f7a:	e456                	sd	s5,8(sp)
ffffffffc0203f7c:	812fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203f80:	2e050963          	beqz	a0,ffffffffc0204272 <vmm_init+0x30a>
ffffffffc0203f84:	e508                	sd	a0,8(a0)
ffffffffc0203f86:	e108                	sd	a0,0(a0)
ffffffffc0203f88:	00053823          	sd	zero,16(a0)
ffffffffc0203f8c:	00053c23          	sd	zero,24(a0)
ffffffffc0203f90:	02052023          	sw	zero,32(a0)
ffffffffc0203f94:	02053423          	sd	zero,40(a0)
ffffffffc0203f98:	02052823          	sw	zero,48(a0)
ffffffffc0203f9c:	84aa                	mv	s1,a0
ffffffffc0203f9e:	4585                	li	a1,1
ffffffffc0203fa0:	03850513          	addi	a0,a0,56
ffffffffc0203fa4:	5b6000ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc0203fa8:	03200413          	li	s0,50
ffffffffc0203fac:	a811                	j	ffffffffc0203fc0 <vmm_init+0x58>
ffffffffc0203fae:	e500                	sd	s0,8(a0)
ffffffffc0203fb0:	e91c                	sd	a5,16(a0)
ffffffffc0203fb2:	00052c23          	sw	zero,24(a0)
ffffffffc0203fb6:	146d                	addi	s0,s0,-5
ffffffffc0203fb8:	8526                	mv	a0,s1
ffffffffc0203fba:	ccdff0ef          	jal	ra,ffffffffc0203c86 <insert_vma_struct>
ffffffffc0203fbe:	c80d                	beqz	s0,ffffffffc0203ff0 <vmm_init+0x88>
ffffffffc0203fc0:	03000513          	li	a0,48
ffffffffc0203fc4:	fcbfd0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203fc8:	85aa                	mv	a1,a0
ffffffffc0203fca:	00240793          	addi	a5,s0,2
ffffffffc0203fce:	f165                	bnez	a0,ffffffffc0203fae <vmm_init+0x46>
ffffffffc0203fd0:	00009697          	auipc	a3,0x9
ffffffffc0203fd4:	e4068693          	addi	a3,a3,-448 # ffffffffc020ce10 <default_pmm_manager+0xa90>
ffffffffc0203fd8:	00008617          	auipc	a2,0x8
ffffffffc0203fdc:	8c060613          	addi	a2,a2,-1856 # ffffffffc020b898 <commands+0x210>
ffffffffc0203fe0:	12c00593          	li	a1,300
ffffffffc0203fe4:	00009517          	auipc	a0,0x9
ffffffffc0203fe8:	bdc50513          	addi	a0,a0,-1060 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc0203fec:	cb2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ff0:	03700413          	li	s0,55
ffffffffc0203ff4:	1f900913          	li	s2,505
ffffffffc0203ff8:	a819                	j	ffffffffc020400e <vmm_init+0xa6>
ffffffffc0203ffa:	e500                	sd	s0,8(a0)
ffffffffc0203ffc:	e91c                	sd	a5,16(a0)
ffffffffc0203ffe:	00052c23          	sw	zero,24(a0)
ffffffffc0204002:	0415                	addi	s0,s0,5
ffffffffc0204004:	8526                	mv	a0,s1
ffffffffc0204006:	c81ff0ef          	jal	ra,ffffffffc0203c86 <insert_vma_struct>
ffffffffc020400a:	03240a63          	beq	s0,s2,ffffffffc020403e <vmm_init+0xd6>
ffffffffc020400e:	03000513          	li	a0,48
ffffffffc0204012:	f7dfd0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0204016:	85aa                	mv	a1,a0
ffffffffc0204018:	00240793          	addi	a5,s0,2
ffffffffc020401c:	fd79                	bnez	a0,ffffffffc0203ffa <vmm_init+0x92>
ffffffffc020401e:	00009697          	auipc	a3,0x9
ffffffffc0204022:	df268693          	addi	a3,a3,-526 # ffffffffc020ce10 <default_pmm_manager+0xa90>
ffffffffc0204026:	00008617          	auipc	a2,0x8
ffffffffc020402a:	87260613          	addi	a2,a2,-1934 # ffffffffc020b898 <commands+0x210>
ffffffffc020402e:	13300593          	li	a1,307
ffffffffc0204032:	00009517          	auipc	a0,0x9
ffffffffc0204036:	b8e50513          	addi	a0,a0,-1138 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc020403a:	c64fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020403e:	649c                	ld	a5,8(s1)
ffffffffc0204040:	471d                	li	a4,7
ffffffffc0204042:	1fb00593          	li	a1,507
ffffffffc0204046:	16f48663          	beq	s1,a5,ffffffffc02041b2 <vmm_init+0x24a>
ffffffffc020404a:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd686d8>
ffffffffc020404e:	ffe70693          	addi	a3,a4,-2
ffffffffc0204052:	10d61063          	bne	a2,a3,ffffffffc0204152 <vmm_init+0x1ea>
ffffffffc0204056:	ff07b683          	ld	a3,-16(a5)
ffffffffc020405a:	0ed71c63          	bne	a4,a3,ffffffffc0204152 <vmm_init+0x1ea>
ffffffffc020405e:	0715                	addi	a4,a4,5
ffffffffc0204060:	679c                	ld	a5,8(a5)
ffffffffc0204062:	feb712e3          	bne	a4,a1,ffffffffc0204046 <vmm_init+0xde>
ffffffffc0204066:	4a1d                	li	s4,7
ffffffffc0204068:	4415                	li	s0,5
ffffffffc020406a:	1f900a93          	li	s5,505
ffffffffc020406e:	85a2                	mv	a1,s0
ffffffffc0204070:	8526                	mv	a0,s1
ffffffffc0204072:	bd5ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc0204076:	892a                	mv	s2,a0
ffffffffc0204078:	16050d63          	beqz	a0,ffffffffc02041f2 <vmm_init+0x28a>
ffffffffc020407c:	00140593          	addi	a1,s0,1
ffffffffc0204080:	8526                	mv	a0,s1
ffffffffc0204082:	bc5ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc0204086:	89aa                	mv	s3,a0
ffffffffc0204088:	14050563          	beqz	a0,ffffffffc02041d2 <vmm_init+0x26a>
ffffffffc020408c:	85d2                	mv	a1,s4
ffffffffc020408e:	8526                	mv	a0,s1
ffffffffc0204090:	bb7ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc0204094:	16051f63          	bnez	a0,ffffffffc0204212 <vmm_init+0x2aa>
ffffffffc0204098:	00340593          	addi	a1,s0,3
ffffffffc020409c:	8526                	mv	a0,s1
ffffffffc020409e:	ba9ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc02040a2:	1a051863          	bnez	a0,ffffffffc0204252 <vmm_init+0x2ea>
ffffffffc02040a6:	00440593          	addi	a1,s0,4
ffffffffc02040aa:	8526                	mv	a0,s1
ffffffffc02040ac:	b9bff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc02040b0:	18051163          	bnez	a0,ffffffffc0204232 <vmm_init+0x2ca>
ffffffffc02040b4:	00893783          	ld	a5,8(s2)
ffffffffc02040b8:	0a879d63          	bne	a5,s0,ffffffffc0204172 <vmm_init+0x20a>
ffffffffc02040bc:	01093783          	ld	a5,16(s2)
ffffffffc02040c0:	0b479963          	bne	a5,s4,ffffffffc0204172 <vmm_init+0x20a>
ffffffffc02040c4:	0089b783          	ld	a5,8(s3)
ffffffffc02040c8:	0c879563          	bne	a5,s0,ffffffffc0204192 <vmm_init+0x22a>
ffffffffc02040cc:	0109b783          	ld	a5,16(s3)
ffffffffc02040d0:	0d479163          	bne	a5,s4,ffffffffc0204192 <vmm_init+0x22a>
ffffffffc02040d4:	0415                	addi	s0,s0,5
ffffffffc02040d6:	0a15                	addi	s4,s4,5
ffffffffc02040d8:	f9541be3          	bne	s0,s5,ffffffffc020406e <vmm_init+0x106>
ffffffffc02040dc:	4411                	li	s0,4
ffffffffc02040de:	597d                	li	s2,-1
ffffffffc02040e0:	85a2                	mv	a1,s0
ffffffffc02040e2:	8526                	mv	a0,s1
ffffffffc02040e4:	b63ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc02040e8:	0004059b          	sext.w	a1,s0
ffffffffc02040ec:	c90d                	beqz	a0,ffffffffc020411e <vmm_init+0x1b6>
ffffffffc02040ee:	6914                	ld	a3,16(a0)
ffffffffc02040f0:	6510                	ld	a2,8(a0)
ffffffffc02040f2:	00009517          	auipc	a0,0x9
ffffffffc02040f6:	ca650513          	addi	a0,a0,-858 # ffffffffc020cd98 <default_pmm_manager+0xa18>
ffffffffc02040fa:	8acfc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02040fe:	00009697          	auipc	a3,0x9
ffffffffc0204102:	cc268693          	addi	a3,a3,-830 # ffffffffc020cdc0 <default_pmm_manager+0xa40>
ffffffffc0204106:	00007617          	auipc	a2,0x7
ffffffffc020410a:	79260613          	addi	a2,a2,1938 # ffffffffc020b898 <commands+0x210>
ffffffffc020410e:	15900593          	li	a1,345
ffffffffc0204112:	00009517          	auipc	a0,0x9
ffffffffc0204116:	aae50513          	addi	a0,a0,-1362 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc020411a:	b84fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020411e:	147d                	addi	s0,s0,-1
ffffffffc0204120:	fd2410e3          	bne	s0,s2,ffffffffc02040e0 <vmm_init+0x178>
ffffffffc0204124:	8526                	mv	a0,s1
ffffffffc0204126:	c31ff0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc020412a:	00009517          	auipc	a0,0x9
ffffffffc020412e:	cae50513          	addi	a0,a0,-850 # ffffffffc020cdd8 <default_pmm_manager+0xa58>
ffffffffc0204132:	874fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0204136:	7442                	ld	s0,48(sp)
ffffffffc0204138:	70e2                	ld	ra,56(sp)
ffffffffc020413a:	74a2                	ld	s1,40(sp)
ffffffffc020413c:	7902                	ld	s2,32(sp)
ffffffffc020413e:	69e2                	ld	s3,24(sp)
ffffffffc0204140:	6a42                	ld	s4,16(sp)
ffffffffc0204142:	6aa2                	ld	s5,8(sp)
ffffffffc0204144:	00009517          	auipc	a0,0x9
ffffffffc0204148:	cb450513          	addi	a0,a0,-844 # ffffffffc020cdf8 <default_pmm_manager+0xa78>
ffffffffc020414c:	6121                	addi	sp,sp,64
ffffffffc020414e:	858fc06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0204152:	00009697          	auipc	a3,0x9
ffffffffc0204156:	b5e68693          	addi	a3,a3,-1186 # ffffffffc020ccb0 <default_pmm_manager+0x930>
ffffffffc020415a:	00007617          	auipc	a2,0x7
ffffffffc020415e:	73e60613          	addi	a2,a2,1854 # ffffffffc020b898 <commands+0x210>
ffffffffc0204162:	13d00593          	li	a1,317
ffffffffc0204166:	00009517          	auipc	a0,0x9
ffffffffc020416a:	a5a50513          	addi	a0,a0,-1446 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc020416e:	b30fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204172:	00009697          	auipc	a3,0x9
ffffffffc0204176:	bc668693          	addi	a3,a3,-1082 # ffffffffc020cd38 <default_pmm_manager+0x9b8>
ffffffffc020417a:	00007617          	auipc	a2,0x7
ffffffffc020417e:	71e60613          	addi	a2,a2,1822 # ffffffffc020b898 <commands+0x210>
ffffffffc0204182:	14e00593          	li	a1,334
ffffffffc0204186:	00009517          	auipc	a0,0x9
ffffffffc020418a:	a3a50513          	addi	a0,a0,-1478 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc020418e:	b10fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204192:	00009697          	auipc	a3,0x9
ffffffffc0204196:	bd668693          	addi	a3,a3,-1066 # ffffffffc020cd68 <default_pmm_manager+0x9e8>
ffffffffc020419a:	00007617          	auipc	a2,0x7
ffffffffc020419e:	6fe60613          	addi	a2,a2,1790 # ffffffffc020b898 <commands+0x210>
ffffffffc02041a2:	14f00593          	li	a1,335
ffffffffc02041a6:	00009517          	auipc	a0,0x9
ffffffffc02041aa:	a1a50513          	addi	a0,a0,-1510 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc02041ae:	af0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041b2:	00009697          	auipc	a3,0x9
ffffffffc02041b6:	ae668693          	addi	a3,a3,-1306 # ffffffffc020cc98 <default_pmm_manager+0x918>
ffffffffc02041ba:	00007617          	auipc	a2,0x7
ffffffffc02041be:	6de60613          	addi	a2,a2,1758 # ffffffffc020b898 <commands+0x210>
ffffffffc02041c2:	13b00593          	li	a1,315
ffffffffc02041c6:	00009517          	auipc	a0,0x9
ffffffffc02041ca:	9fa50513          	addi	a0,a0,-1542 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc02041ce:	ad0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041d2:	00009697          	auipc	a3,0x9
ffffffffc02041d6:	b2668693          	addi	a3,a3,-1242 # ffffffffc020ccf8 <default_pmm_manager+0x978>
ffffffffc02041da:	00007617          	auipc	a2,0x7
ffffffffc02041de:	6be60613          	addi	a2,a2,1726 # ffffffffc020b898 <commands+0x210>
ffffffffc02041e2:	14600593          	li	a1,326
ffffffffc02041e6:	00009517          	auipc	a0,0x9
ffffffffc02041ea:	9da50513          	addi	a0,a0,-1574 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc02041ee:	ab0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041f2:	00009697          	auipc	a3,0x9
ffffffffc02041f6:	af668693          	addi	a3,a3,-1290 # ffffffffc020cce8 <default_pmm_manager+0x968>
ffffffffc02041fa:	00007617          	auipc	a2,0x7
ffffffffc02041fe:	69e60613          	addi	a2,a2,1694 # ffffffffc020b898 <commands+0x210>
ffffffffc0204202:	14400593          	li	a1,324
ffffffffc0204206:	00009517          	auipc	a0,0x9
ffffffffc020420a:	9ba50513          	addi	a0,a0,-1606 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc020420e:	a90fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204212:	00009697          	auipc	a3,0x9
ffffffffc0204216:	af668693          	addi	a3,a3,-1290 # ffffffffc020cd08 <default_pmm_manager+0x988>
ffffffffc020421a:	00007617          	auipc	a2,0x7
ffffffffc020421e:	67e60613          	addi	a2,a2,1662 # ffffffffc020b898 <commands+0x210>
ffffffffc0204222:	14800593          	li	a1,328
ffffffffc0204226:	00009517          	auipc	a0,0x9
ffffffffc020422a:	99a50513          	addi	a0,a0,-1638 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc020422e:	a70fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204232:	00009697          	auipc	a3,0x9
ffffffffc0204236:	af668693          	addi	a3,a3,-1290 # ffffffffc020cd28 <default_pmm_manager+0x9a8>
ffffffffc020423a:	00007617          	auipc	a2,0x7
ffffffffc020423e:	65e60613          	addi	a2,a2,1630 # ffffffffc020b898 <commands+0x210>
ffffffffc0204242:	14c00593          	li	a1,332
ffffffffc0204246:	00009517          	auipc	a0,0x9
ffffffffc020424a:	97a50513          	addi	a0,a0,-1670 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc020424e:	a50fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204252:	00009697          	auipc	a3,0x9
ffffffffc0204256:	ac668693          	addi	a3,a3,-1338 # ffffffffc020cd18 <default_pmm_manager+0x998>
ffffffffc020425a:	00007617          	auipc	a2,0x7
ffffffffc020425e:	63e60613          	addi	a2,a2,1598 # ffffffffc020b898 <commands+0x210>
ffffffffc0204262:	14a00593          	li	a1,330
ffffffffc0204266:	00009517          	auipc	a0,0x9
ffffffffc020426a:	95a50513          	addi	a0,a0,-1702 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc020426e:	a30fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204272:	00009697          	auipc	a3,0x9
ffffffffc0204276:	9d668693          	addi	a3,a3,-1578 # ffffffffc020cc48 <default_pmm_manager+0x8c8>
ffffffffc020427a:	00007617          	auipc	a2,0x7
ffffffffc020427e:	61e60613          	addi	a2,a2,1566 # ffffffffc020b898 <commands+0x210>
ffffffffc0204282:	12400593          	li	a1,292
ffffffffc0204286:	00009517          	auipc	a0,0x9
ffffffffc020428a:	93a50513          	addi	a0,a0,-1734 # ffffffffc020cbc0 <default_pmm_manager+0x840>
ffffffffc020428e:	a10fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204292 <user_mem_check>:
ffffffffc0204292:	7179                	addi	sp,sp,-48
ffffffffc0204294:	f022                	sd	s0,32(sp)
ffffffffc0204296:	f406                	sd	ra,40(sp)
ffffffffc0204298:	ec26                	sd	s1,24(sp)
ffffffffc020429a:	e84a                	sd	s2,16(sp)
ffffffffc020429c:	e44e                	sd	s3,8(sp)
ffffffffc020429e:	e052                	sd	s4,0(sp)
ffffffffc02042a0:	842e                	mv	s0,a1
ffffffffc02042a2:	c135                	beqz	a0,ffffffffc0204306 <user_mem_check+0x74>
ffffffffc02042a4:	002007b7          	lui	a5,0x200
ffffffffc02042a8:	04f5e663          	bltu	a1,a5,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042ac:	00c584b3          	add	s1,a1,a2
ffffffffc02042b0:	0495f263          	bgeu	a1,s1,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042b4:	4785                	li	a5,1
ffffffffc02042b6:	07fe                	slli	a5,a5,0x1f
ffffffffc02042b8:	0297ee63          	bltu	a5,s1,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042bc:	892a                	mv	s2,a0
ffffffffc02042be:	89b6                	mv	s3,a3
ffffffffc02042c0:	6a05                	lui	s4,0x1
ffffffffc02042c2:	a821                	j	ffffffffc02042da <user_mem_check+0x48>
ffffffffc02042c4:	0027f693          	andi	a3,a5,2
ffffffffc02042c8:	9752                	add	a4,a4,s4
ffffffffc02042ca:	8ba1                	andi	a5,a5,8
ffffffffc02042cc:	c685                	beqz	a3,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042ce:	c399                	beqz	a5,ffffffffc02042d4 <user_mem_check+0x42>
ffffffffc02042d0:	02e46263          	bltu	s0,a4,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042d4:	6900                	ld	s0,16(a0)
ffffffffc02042d6:	04947663          	bgeu	s0,s1,ffffffffc0204322 <user_mem_check+0x90>
ffffffffc02042da:	85a2                	mv	a1,s0
ffffffffc02042dc:	854a                	mv	a0,s2
ffffffffc02042de:	969ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc02042e2:	c909                	beqz	a0,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042e4:	6518                	ld	a4,8(a0)
ffffffffc02042e6:	00e46763          	bltu	s0,a4,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042ea:	4d1c                	lw	a5,24(a0)
ffffffffc02042ec:	fc099ce3          	bnez	s3,ffffffffc02042c4 <user_mem_check+0x32>
ffffffffc02042f0:	8b85                	andi	a5,a5,1
ffffffffc02042f2:	f3ed                	bnez	a5,ffffffffc02042d4 <user_mem_check+0x42>
ffffffffc02042f4:	4501                	li	a0,0
ffffffffc02042f6:	70a2                	ld	ra,40(sp)
ffffffffc02042f8:	7402                	ld	s0,32(sp)
ffffffffc02042fa:	64e2                	ld	s1,24(sp)
ffffffffc02042fc:	6942                	ld	s2,16(sp)
ffffffffc02042fe:	69a2                	ld	s3,8(sp)
ffffffffc0204300:	6a02                	ld	s4,0(sp)
ffffffffc0204302:	6145                	addi	sp,sp,48
ffffffffc0204304:	8082                	ret
ffffffffc0204306:	c02007b7          	lui	a5,0xc0200
ffffffffc020430a:	4501                	li	a0,0
ffffffffc020430c:	fef5e5e3          	bltu	a1,a5,ffffffffc02042f6 <user_mem_check+0x64>
ffffffffc0204310:	962e                	add	a2,a2,a1
ffffffffc0204312:	fec5f2e3          	bgeu	a1,a2,ffffffffc02042f6 <user_mem_check+0x64>
ffffffffc0204316:	c8000537          	lui	a0,0xc8000
ffffffffc020431a:	0505                	addi	a0,a0,1
ffffffffc020431c:	00a63533          	sltu	a0,a2,a0
ffffffffc0204320:	bfd9                	j	ffffffffc02042f6 <user_mem_check+0x64>
ffffffffc0204322:	4505                	li	a0,1
ffffffffc0204324:	bfc9                	j	ffffffffc02042f6 <user_mem_check+0x64>

ffffffffc0204326 <copy_from_user>:
ffffffffc0204326:	1101                	addi	sp,sp,-32
ffffffffc0204328:	e822                	sd	s0,16(sp)
ffffffffc020432a:	e426                	sd	s1,8(sp)
ffffffffc020432c:	8432                	mv	s0,a2
ffffffffc020432e:	84b6                	mv	s1,a3
ffffffffc0204330:	e04a                	sd	s2,0(sp)
ffffffffc0204332:	86ba                	mv	a3,a4
ffffffffc0204334:	892e                	mv	s2,a1
ffffffffc0204336:	8626                	mv	a2,s1
ffffffffc0204338:	85a2                	mv	a1,s0
ffffffffc020433a:	ec06                	sd	ra,24(sp)
ffffffffc020433c:	f57ff0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc0204340:	c519                	beqz	a0,ffffffffc020434e <copy_from_user+0x28>
ffffffffc0204342:	8626                	mv	a2,s1
ffffffffc0204344:	85a2                	mv	a1,s0
ffffffffc0204346:	854a                	mv	a0,s2
ffffffffc0204348:	0c0070ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc020434c:	4505                	li	a0,1
ffffffffc020434e:	60e2                	ld	ra,24(sp)
ffffffffc0204350:	6442                	ld	s0,16(sp)
ffffffffc0204352:	64a2                	ld	s1,8(sp)
ffffffffc0204354:	6902                	ld	s2,0(sp)
ffffffffc0204356:	6105                	addi	sp,sp,32
ffffffffc0204358:	8082                	ret

ffffffffc020435a <copy_to_user>:
ffffffffc020435a:	1101                	addi	sp,sp,-32
ffffffffc020435c:	e822                	sd	s0,16(sp)
ffffffffc020435e:	8436                	mv	s0,a3
ffffffffc0204360:	e04a                	sd	s2,0(sp)
ffffffffc0204362:	4685                	li	a3,1
ffffffffc0204364:	8932                	mv	s2,a2
ffffffffc0204366:	8622                	mv	a2,s0
ffffffffc0204368:	e426                	sd	s1,8(sp)
ffffffffc020436a:	ec06                	sd	ra,24(sp)
ffffffffc020436c:	84ae                	mv	s1,a1
ffffffffc020436e:	f25ff0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc0204372:	c519                	beqz	a0,ffffffffc0204380 <copy_to_user+0x26>
ffffffffc0204374:	8622                	mv	a2,s0
ffffffffc0204376:	85ca                	mv	a1,s2
ffffffffc0204378:	8526                	mv	a0,s1
ffffffffc020437a:	08e070ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc020437e:	4505                	li	a0,1
ffffffffc0204380:	60e2                	ld	ra,24(sp)
ffffffffc0204382:	6442                	ld	s0,16(sp)
ffffffffc0204384:	64a2                	ld	s1,8(sp)
ffffffffc0204386:	6902                	ld	s2,0(sp)
ffffffffc0204388:	6105                	addi	sp,sp,32
ffffffffc020438a:	8082                	ret

ffffffffc020438c <copy_string>:
ffffffffc020438c:	7139                	addi	sp,sp,-64
ffffffffc020438e:	ec4e                	sd	s3,24(sp)
ffffffffc0204390:	6985                	lui	s3,0x1
ffffffffc0204392:	99b2                	add	s3,s3,a2
ffffffffc0204394:	77fd                	lui	a5,0xfffff
ffffffffc0204396:	00f9f9b3          	and	s3,s3,a5
ffffffffc020439a:	f426                	sd	s1,40(sp)
ffffffffc020439c:	f04a                	sd	s2,32(sp)
ffffffffc020439e:	e852                	sd	s4,16(sp)
ffffffffc02043a0:	e456                	sd	s5,8(sp)
ffffffffc02043a2:	fc06                	sd	ra,56(sp)
ffffffffc02043a4:	f822                	sd	s0,48(sp)
ffffffffc02043a6:	84b2                	mv	s1,a2
ffffffffc02043a8:	8aaa                	mv	s5,a0
ffffffffc02043aa:	8a2e                	mv	s4,a1
ffffffffc02043ac:	8936                	mv	s2,a3
ffffffffc02043ae:	40c989b3          	sub	s3,s3,a2
ffffffffc02043b2:	a015                	j	ffffffffc02043d6 <copy_string+0x4a>
ffffffffc02043b4:	77b060ef          	jal	ra,ffffffffc020b32e <strnlen>
ffffffffc02043b8:	87aa                	mv	a5,a0
ffffffffc02043ba:	85a6                	mv	a1,s1
ffffffffc02043bc:	8552                	mv	a0,s4
ffffffffc02043be:	8622                	mv	a2,s0
ffffffffc02043c0:	0487e363          	bltu	a5,s0,ffffffffc0204406 <copy_string+0x7a>
ffffffffc02043c4:	0329f763          	bgeu	s3,s2,ffffffffc02043f2 <copy_string+0x66>
ffffffffc02043c8:	040070ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc02043cc:	9a22                	add	s4,s4,s0
ffffffffc02043ce:	94a2                	add	s1,s1,s0
ffffffffc02043d0:	40890933          	sub	s2,s2,s0
ffffffffc02043d4:	6985                	lui	s3,0x1
ffffffffc02043d6:	4681                	li	a3,0
ffffffffc02043d8:	85a6                	mv	a1,s1
ffffffffc02043da:	8556                	mv	a0,s5
ffffffffc02043dc:	844a                	mv	s0,s2
ffffffffc02043de:	0129f363          	bgeu	s3,s2,ffffffffc02043e4 <copy_string+0x58>
ffffffffc02043e2:	844e                	mv	s0,s3
ffffffffc02043e4:	8622                	mv	a2,s0
ffffffffc02043e6:	eadff0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc02043ea:	87aa                	mv	a5,a0
ffffffffc02043ec:	85a2                	mv	a1,s0
ffffffffc02043ee:	8526                	mv	a0,s1
ffffffffc02043f0:	f3f1                	bnez	a5,ffffffffc02043b4 <copy_string+0x28>
ffffffffc02043f2:	4501                	li	a0,0
ffffffffc02043f4:	70e2                	ld	ra,56(sp)
ffffffffc02043f6:	7442                	ld	s0,48(sp)
ffffffffc02043f8:	74a2                	ld	s1,40(sp)
ffffffffc02043fa:	7902                	ld	s2,32(sp)
ffffffffc02043fc:	69e2                	ld	s3,24(sp)
ffffffffc02043fe:	6a42                	ld	s4,16(sp)
ffffffffc0204400:	6aa2                	ld	s5,8(sp)
ffffffffc0204402:	6121                	addi	sp,sp,64
ffffffffc0204404:	8082                	ret
ffffffffc0204406:	00178613          	addi	a2,a5,1 # fffffffffffff001 <end+0x3fd686f1>
ffffffffc020440a:	7ff060ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc020440e:	4505                	li	a0,1
ffffffffc0204410:	b7d5                	j	ffffffffc02043f4 <copy_string+0x68>

ffffffffc0204412 <__down.constprop.0>:
ffffffffc0204412:	715d                	addi	sp,sp,-80
ffffffffc0204414:	e0a2                	sd	s0,64(sp)
ffffffffc0204416:	e486                	sd	ra,72(sp)
ffffffffc0204418:	fc26                	sd	s1,56(sp)
ffffffffc020441a:	842a                	mv	s0,a0
ffffffffc020441c:	100027f3          	csrr	a5,sstatus
ffffffffc0204420:	8b89                	andi	a5,a5,2
ffffffffc0204422:	ebb1                	bnez	a5,ffffffffc0204476 <__down.constprop.0+0x64>
ffffffffc0204424:	411c                	lw	a5,0(a0)
ffffffffc0204426:	00f05a63          	blez	a5,ffffffffc020443a <__down.constprop.0+0x28>
ffffffffc020442a:	37fd                	addiw	a5,a5,-1
ffffffffc020442c:	c11c                	sw	a5,0(a0)
ffffffffc020442e:	4501                	li	a0,0
ffffffffc0204430:	60a6                	ld	ra,72(sp)
ffffffffc0204432:	6406                	ld	s0,64(sp)
ffffffffc0204434:	74e2                	ld	s1,56(sp)
ffffffffc0204436:	6161                	addi	sp,sp,80
ffffffffc0204438:	8082                	ret
ffffffffc020443a:	00850413          	addi	s0,a0,8 # ffffffffc8000008 <end+0x7d696f8>
ffffffffc020443e:	0024                	addi	s1,sp,8
ffffffffc0204440:	10000613          	li	a2,256
ffffffffc0204444:	85a6                	mv	a1,s1
ffffffffc0204446:	8522                	mv	a0,s0
ffffffffc0204448:	2d8000ef          	jal	ra,ffffffffc0204720 <wait_current_set>
ffffffffc020444c:	60f020ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc0204450:	100027f3          	csrr	a5,sstatus
ffffffffc0204454:	8b89                	andi	a5,a5,2
ffffffffc0204456:	efb9                	bnez	a5,ffffffffc02044b4 <__down.constprop.0+0xa2>
ffffffffc0204458:	8526                	mv	a0,s1
ffffffffc020445a:	19c000ef          	jal	ra,ffffffffc02045f6 <wait_in_queue>
ffffffffc020445e:	e531                	bnez	a0,ffffffffc02044aa <__down.constprop.0+0x98>
ffffffffc0204460:	4542                	lw	a0,16(sp)
ffffffffc0204462:	10000793          	li	a5,256
ffffffffc0204466:	fcf515e3          	bne	a0,a5,ffffffffc0204430 <__down.constprop.0+0x1e>
ffffffffc020446a:	60a6                	ld	ra,72(sp)
ffffffffc020446c:	6406                	ld	s0,64(sp)
ffffffffc020446e:	74e2                	ld	s1,56(sp)
ffffffffc0204470:	4501                	li	a0,0
ffffffffc0204472:	6161                	addi	sp,sp,80
ffffffffc0204474:	8082                	ret
ffffffffc0204476:	ffcfc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020447a:	401c                	lw	a5,0(s0)
ffffffffc020447c:	00f05c63          	blez	a5,ffffffffc0204494 <__down.constprop.0+0x82>
ffffffffc0204480:	37fd                	addiw	a5,a5,-1
ffffffffc0204482:	c01c                	sw	a5,0(s0)
ffffffffc0204484:	fe8fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204488:	60a6                	ld	ra,72(sp)
ffffffffc020448a:	6406                	ld	s0,64(sp)
ffffffffc020448c:	74e2                	ld	s1,56(sp)
ffffffffc020448e:	4501                	li	a0,0
ffffffffc0204490:	6161                	addi	sp,sp,80
ffffffffc0204492:	8082                	ret
ffffffffc0204494:	0421                	addi	s0,s0,8
ffffffffc0204496:	0024                	addi	s1,sp,8
ffffffffc0204498:	10000613          	li	a2,256
ffffffffc020449c:	85a6                	mv	a1,s1
ffffffffc020449e:	8522                	mv	a0,s0
ffffffffc02044a0:	280000ef          	jal	ra,ffffffffc0204720 <wait_current_set>
ffffffffc02044a4:	fc8fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02044a8:	b755                	j	ffffffffc020444c <__down.constprop.0+0x3a>
ffffffffc02044aa:	85a6                	mv	a1,s1
ffffffffc02044ac:	8522                	mv	a0,s0
ffffffffc02044ae:	0ee000ef          	jal	ra,ffffffffc020459c <wait_queue_del>
ffffffffc02044b2:	b77d                	j	ffffffffc0204460 <__down.constprop.0+0x4e>
ffffffffc02044b4:	fbefc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02044b8:	8526                	mv	a0,s1
ffffffffc02044ba:	13c000ef          	jal	ra,ffffffffc02045f6 <wait_in_queue>
ffffffffc02044be:	e501                	bnez	a0,ffffffffc02044c6 <__down.constprop.0+0xb4>
ffffffffc02044c0:	facfc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02044c4:	bf71                	j	ffffffffc0204460 <__down.constprop.0+0x4e>
ffffffffc02044c6:	85a6                	mv	a1,s1
ffffffffc02044c8:	8522                	mv	a0,s0
ffffffffc02044ca:	0d2000ef          	jal	ra,ffffffffc020459c <wait_queue_del>
ffffffffc02044ce:	bfcd                	j	ffffffffc02044c0 <__down.constprop.0+0xae>

ffffffffc02044d0 <__up.constprop.0>:
ffffffffc02044d0:	1101                	addi	sp,sp,-32
ffffffffc02044d2:	e822                	sd	s0,16(sp)
ffffffffc02044d4:	ec06                	sd	ra,24(sp)
ffffffffc02044d6:	e426                	sd	s1,8(sp)
ffffffffc02044d8:	e04a                	sd	s2,0(sp)
ffffffffc02044da:	842a                	mv	s0,a0
ffffffffc02044dc:	100027f3          	csrr	a5,sstatus
ffffffffc02044e0:	8b89                	andi	a5,a5,2
ffffffffc02044e2:	4901                	li	s2,0
ffffffffc02044e4:	eba1                	bnez	a5,ffffffffc0204534 <__up.constprop.0+0x64>
ffffffffc02044e6:	00840493          	addi	s1,s0,8
ffffffffc02044ea:	8526                	mv	a0,s1
ffffffffc02044ec:	0ee000ef          	jal	ra,ffffffffc02045da <wait_queue_first>
ffffffffc02044f0:	85aa                	mv	a1,a0
ffffffffc02044f2:	cd0d                	beqz	a0,ffffffffc020452c <__up.constprop.0+0x5c>
ffffffffc02044f4:	6118                	ld	a4,0(a0)
ffffffffc02044f6:	10000793          	li	a5,256
ffffffffc02044fa:	0ec72703          	lw	a4,236(a4)
ffffffffc02044fe:	02f71f63          	bne	a4,a5,ffffffffc020453c <__up.constprop.0+0x6c>
ffffffffc0204502:	4685                	li	a3,1
ffffffffc0204504:	10000613          	li	a2,256
ffffffffc0204508:	8526                	mv	a0,s1
ffffffffc020450a:	0fa000ef          	jal	ra,ffffffffc0204604 <wakeup_wait>
ffffffffc020450e:	00091863          	bnez	s2,ffffffffc020451e <__up.constprop.0+0x4e>
ffffffffc0204512:	60e2                	ld	ra,24(sp)
ffffffffc0204514:	6442                	ld	s0,16(sp)
ffffffffc0204516:	64a2                	ld	s1,8(sp)
ffffffffc0204518:	6902                	ld	s2,0(sp)
ffffffffc020451a:	6105                	addi	sp,sp,32
ffffffffc020451c:	8082                	ret
ffffffffc020451e:	6442                	ld	s0,16(sp)
ffffffffc0204520:	60e2                	ld	ra,24(sp)
ffffffffc0204522:	64a2                	ld	s1,8(sp)
ffffffffc0204524:	6902                	ld	s2,0(sp)
ffffffffc0204526:	6105                	addi	sp,sp,32
ffffffffc0204528:	f44fc06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020452c:	401c                	lw	a5,0(s0)
ffffffffc020452e:	2785                	addiw	a5,a5,1
ffffffffc0204530:	c01c                	sw	a5,0(s0)
ffffffffc0204532:	bff1                	j	ffffffffc020450e <__up.constprop.0+0x3e>
ffffffffc0204534:	f3efc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204538:	4905                	li	s2,1
ffffffffc020453a:	b775                	j	ffffffffc02044e6 <__up.constprop.0+0x16>
ffffffffc020453c:	00009697          	auipc	a3,0x9
ffffffffc0204540:	8e468693          	addi	a3,a3,-1820 # ffffffffc020ce20 <default_pmm_manager+0xaa0>
ffffffffc0204544:	00007617          	auipc	a2,0x7
ffffffffc0204548:	35460613          	addi	a2,a2,852 # ffffffffc020b898 <commands+0x210>
ffffffffc020454c:	45e5                	li	a1,25
ffffffffc020454e:	00009517          	auipc	a0,0x9
ffffffffc0204552:	8fa50513          	addi	a0,a0,-1798 # ffffffffc020ce48 <default_pmm_manager+0xac8>
ffffffffc0204556:	f49fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020455a <sem_init>:
ffffffffc020455a:	c10c                	sw	a1,0(a0)
ffffffffc020455c:	0521                	addi	a0,a0,8
ffffffffc020455e:	a825                	j	ffffffffc0204596 <wait_queue_init>

ffffffffc0204560 <up>:
ffffffffc0204560:	f71ff06f          	j	ffffffffc02044d0 <__up.constprop.0>

ffffffffc0204564 <down>:
ffffffffc0204564:	1141                	addi	sp,sp,-16
ffffffffc0204566:	e406                	sd	ra,8(sp)
ffffffffc0204568:	eabff0ef          	jal	ra,ffffffffc0204412 <__down.constprop.0>
ffffffffc020456c:	2501                	sext.w	a0,a0
ffffffffc020456e:	e501                	bnez	a0,ffffffffc0204576 <down+0x12>
ffffffffc0204570:	60a2                	ld	ra,8(sp)
ffffffffc0204572:	0141                	addi	sp,sp,16
ffffffffc0204574:	8082                	ret
ffffffffc0204576:	00009697          	auipc	a3,0x9
ffffffffc020457a:	8e268693          	addi	a3,a3,-1822 # ffffffffc020ce58 <default_pmm_manager+0xad8>
ffffffffc020457e:	00007617          	auipc	a2,0x7
ffffffffc0204582:	31a60613          	addi	a2,a2,794 # ffffffffc020b898 <commands+0x210>
ffffffffc0204586:	04000593          	li	a1,64
ffffffffc020458a:	00009517          	auipc	a0,0x9
ffffffffc020458e:	8be50513          	addi	a0,a0,-1858 # ffffffffc020ce48 <default_pmm_manager+0xac8>
ffffffffc0204592:	f0dfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204596 <wait_queue_init>:
ffffffffc0204596:	e508                	sd	a0,8(a0)
ffffffffc0204598:	e108                	sd	a0,0(a0)
ffffffffc020459a:	8082                	ret

ffffffffc020459c <wait_queue_del>:
ffffffffc020459c:	7198                	ld	a4,32(a1)
ffffffffc020459e:	01858793          	addi	a5,a1,24
ffffffffc02045a2:	00e78b63          	beq	a5,a4,ffffffffc02045b8 <wait_queue_del+0x1c>
ffffffffc02045a6:	6994                	ld	a3,16(a1)
ffffffffc02045a8:	00a69863          	bne	a3,a0,ffffffffc02045b8 <wait_queue_del+0x1c>
ffffffffc02045ac:	6d94                	ld	a3,24(a1)
ffffffffc02045ae:	e698                	sd	a4,8(a3)
ffffffffc02045b0:	e314                	sd	a3,0(a4)
ffffffffc02045b2:	f19c                	sd	a5,32(a1)
ffffffffc02045b4:	ed9c                	sd	a5,24(a1)
ffffffffc02045b6:	8082                	ret
ffffffffc02045b8:	1141                	addi	sp,sp,-16
ffffffffc02045ba:	00009697          	auipc	a3,0x9
ffffffffc02045be:	8fe68693          	addi	a3,a3,-1794 # ffffffffc020ceb8 <default_pmm_manager+0xb38>
ffffffffc02045c2:	00007617          	auipc	a2,0x7
ffffffffc02045c6:	2d660613          	addi	a2,a2,726 # ffffffffc020b898 <commands+0x210>
ffffffffc02045ca:	45f1                	li	a1,28
ffffffffc02045cc:	00009517          	auipc	a0,0x9
ffffffffc02045d0:	8d450513          	addi	a0,a0,-1836 # ffffffffc020cea0 <default_pmm_manager+0xb20>
ffffffffc02045d4:	e406                	sd	ra,8(sp)
ffffffffc02045d6:	ec9fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02045da <wait_queue_first>:
ffffffffc02045da:	651c                	ld	a5,8(a0)
ffffffffc02045dc:	00f50563          	beq	a0,a5,ffffffffc02045e6 <wait_queue_first+0xc>
ffffffffc02045e0:	fe878513          	addi	a0,a5,-24
ffffffffc02045e4:	8082                	ret
ffffffffc02045e6:	4501                	li	a0,0
ffffffffc02045e8:	8082                	ret

ffffffffc02045ea <wait_queue_empty>:
ffffffffc02045ea:	651c                	ld	a5,8(a0)
ffffffffc02045ec:	40a78533          	sub	a0,a5,a0
ffffffffc02045f0:	00153513          	seqz	a0,a0
ffffffffc02045f4:	8082                	ret

ffffffffc02045f6 <wait_in_queue>:
ffffffffc02045f6:	711c                	ld	a5,32(a0)
ffffffffc02045f8:	0561                	addi	a0,a0,24
ffffffffc02045fa:	40a78533          	sub	a0,a5,a0
ffffffffc02045fe:	00a03533          	snez	a0,a0
ffffffffc0204602:	8082                	ret

ffffffffc0204604 <wakeup_wait>:
ffffffffc0204604:	e689                	bnez	a3,ffffffffc020460e <wakeup_wait+0xa>
ffffffffc0204606:	6188                	ld	a0,0(a1)
ffffffffc0204608:	c590                	sw	a2,8(a1)
ffffffffc020460a:	39f0206f          	j	ffffffffc02071a8 <wakeup_proc>
ffffffffc020460e:	7198                	ld	a4,32(a1)
ffffffffc0204610:	01858793          	addi	a5,a1,24
ffffffffc0204614:	00e78e63          	beq	a5,a4,ffffffffc0204630 <wakeup_wait+0x2c>
ffffffffc0204618:	6994                	ld	a3,16(a1)
ffffffffc020461a:	00d51b63          	bne	a0,a3,ffffffffc0204630 <wakeup_wait+0x2c>
ffffffffc020461e:	6d94                	ld	a3,24(a1)
ffffffffc0204620:	6188                	ld	a0,0(a1)
ffffffffc0204622:	e698                	sd	a4,8(a3)
ffffffffc0204624:	e314                	sd	a3,0(a4)
ffffffffc0204626:	f19c                	sd	a5,32(a1)
ffffffffc0204628:	ed9c                	sd	a5,24(a1)
ffffffffc020462a:	c590                	sw	a2,8(a1)
ffffffffc020462c:	37d0206f          	j	ffffffffc02071a8 <wakeup_proc>
ffffffffc0204630:	1141                	addi	sp,sp,-16
ffffffffc0204632:	00009697          	auipc	a3,0x9
ffffffffc0204636:	88668693          	addi	a3,a3,-1914 # ffffffffc020ceb8 <default_pmm_manager+0xb38>
ffffffffc020463a:	00007617          	auipc	a2,0x7
ffffffffc020463e:	25e60613          	addi	a2,a2,606 # ffffffffc020b898 <commands+0x210>
ffffffffc0204642:	45f1                	li	a1,28
ffffffffc0204644:	00009517          	auipc	a0,0x9
ffffffffc0204648:	85c50513          	addi	a0,a0,-1956 # ffffffffc020cea0 <default_pmm_manager+0xb20>
ffffffffc020464c:	e406                	sd	ra,8(sp)
ffffffffc020464e:	e51fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204652 <wakeup_queue>:
ffffffffc0204652:	651c                	ld	a5,8(a0)
ffffffffc0204654:	0ca78563          	beq	a5,a0,ffffffffc020471e <wakeup_queue+0xcc>
ffffffffc0204658:	1101                	addi	sp,sp,-32
ffffffffc020465a:	e822                	sd	s0,16(sp)
ffffffffc020465c:	e426                	sd	s1,8(sp)
ffffffffc020465e:	e04a                	sd	s2,0(sp)
ffffffffc0204660:	ec06                	sd	ra,24(sp)
ffffffffc0204662:	84aa                	mv	s1,a0
ffffffffc0204664:	892e                	mv	s2,a1
ffffffffc0204666:	fe878413          	addi	s0,a5,-24
ffffffffc020466a:	e23d                	bnez	a2,ffffffffc02046d0 <wakeup_queue+0x7e>
ffffffffc020466c:	6008                	ld	a0,0(s0)
ffffffffc020466e:	01242423          	sw	s2,8(s0)
ffffffffc0204672:	337020ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc0204676:	701c                	ld	a5,32(s0)
ffffffffc0204678:	01840713          	addi	a4,s0,24
ffffffffc020467c:	02e78463          	beq	a5,a4,ffffffffc02046a4 <wakeup_queue+0x52>
ffffffffc0204680:	6818                	ld	a4,16(s0)
ffffffffc0204682:	02e49163          	bne	s1,a4,ffffffffc02046a4 <wakeup_queue+0x52>
ffffffffc0204686:	02f48f63          	beq	s1,a5,ffffffffc02046c4 <wakeup_queue+0x72>
ffffffffc020468a:	fe87b503          	ld	a0,-24(a5)
ffffffffc020468e:	ff27a823          	sw	s2,-16(a5)
ffffffffc0204692:	fe878413          	addi	s0,a5,-24
ffffffffc0204696:	313020ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc020469a:	701c                	ld	a5,32(s0)
ffffffffc020469c:	01840713          	addi	a4,s0,24
ffffffffc02046a0:	fee790e3          	bne	a5,a4,ffffffffc0204680 <wakeup_queue+0x2e>
ffffffffc02046a4:	00009697          	auipc	a3,0x9
ffffffffc02046a8:	81468693          	addi	a3,a3,-2028 # ffffffffc020ceb8 <default_pmm_manager+0xb38>
ffffffffc02046ac:	00007617          	auipc	a2,0x7
ffffffffc02046b0:	1ec60613          	addi	a2,a2,492 # ffffffffc020b898 <commands+0x210>
ffffffffc02046b4:	02200593          	li	a1,34
ffffffffc02046b8:	00008517          	auipc	a0,0x8
ffffffffc02046bc:	7e850513          	addi	a0,a0,2024 # ffffffffc020cea0 <default_pmm_manager+0xb20>
ffffffffc02046c0:	ddffb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02046c4:	60e2                	ld	ra,24(sp)
ffffffffc02046c6:	6442                	ld	s0,16(sp)
ffffffffc02046c8:	64a2                	ld	s1,8(sp)
ffffffffc02046ca:	6902                	ld	s2,0(sp)
ffffffffc02046cc:	6105                	addi	sp,sp,32
ffffffffc02046ce:	8082                	ret
ffffffffc02046d0:	6798                	ld	a4,8(a5)
ffffffffc02046d2:	02f70763          	beq	a4,a5,ffffffffc0204700 <wakeup_queue+0xae>
ffffffffc02046d6:	6814                	ld	a3,16(s0)
ffffffffc02046d8:	02d49463          	bne	s1,a3,ffffffffc0204700 <wakeup_queue+0xae>
ffffffffc02046dc:	6c14                	ld	a3,24(s0)
ffffffffc02046de:	6008                	ld	a0,0(s0)
ffffffffc02046e0:	e698                	sd	a4,8(a3)
ffffffffc02046e2:	e314                	sd	a3,0(a4)
ffffffffc02046e4:	f01c                	sd	a5,32(s0)
ffffffffc02046e6:	ec1c                	sd	a5,24(s0)
ffffffffc02046e8:	01242423          	sw	s2,8(s0)
ffffffffc02046ec:	2bd020ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc02046f0:	6480                	ld	s0,8(s1)
ffffffffc02046f2:	fc8489e3          	beq	s1,s0,ffffffffc02046c4 <wakeup_queue+0x72>
ffffffffc02046f6:	6418                	ld	a4,8(s0)
ffffffffc02046f8:	87a2                	mv	a5,s0
ffffffffc02046fa:	1421                	addi	s0,s0,-24
ffffffffc02046fc:	fce79de3          	bne	a5,a4,ffffffffc02046d6 <wakeup_queue+0x84>
ffffffffc0204700:	00008697          	auipc	a3,0x8
ffffffffc0204704:	7b868693          	addi	a3,a3,1976 # ffffffffc020ceb8 <default_pmm_manager+0xb38>
ffffffffc0204708:	00007617          	auipc	a2,0x7
ffffffffc020470c:	19060613          	addi	a2,a2,400 # ffffffffc020b898 <commands+0x210>
ffffffffc0204710:	45f1                	li	a1,28
ffffffffc0204712:	00008517          	auipc	a0,0x8
ffffffffc0204716:	78e50513          	addi	a0,a0,1934 # ffffffffc020cea0 <default_pmm_manager+0xb20>
ffffffffc020471a:	d85fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020471e:	8082                	ret

ffffffffc0204720 <wait_current_set>:
ffffffffc0204720:	00092797          	auipc	a5,0x92
ffffffffc0204724:	1a07b783          	ld	a5,416(a5) # ffffffffc02968c0 <current>
ffffffffc0204728:	c39d                	beqz	a5,ffffffffc020474e <wait_current_set+0x2e>
ffffffffc020472a:	01858713          	addi	a4,a1,24
ffffffffc020472e:	800006b7          	lui	a3,0x80000
ffffffffc0204732:	ed98                	sd	a4,24(a1)
ffffffffc0204734:	e19c                	sd	a5,0(a1)
ffffffffc0204736:	c594                	sw	a3,8(a1)
ffffffffc0204738:	4685                	li	a3,1
ffffffffc020473a:	c394                	sw	a3,0(a5)
ffffffffc020473c:	0ec7a623          	sw	a2,236(a5)
ffffffffc0204740:	611c                	ld	a5,0(a0)
ffffffffc0204742:	e988                	sd	a0,16(a1)
ffffffffc0204744:	e118                	sd	a4,0(a0)
ffffffffc0204746:	e798                	sd	a4,8(a5)
ffffffffc0204748:	f188                	sd	a0,32(a1)
ffffffffc020474a:	ed9c                	sd	a5,24(a1)
ffffffffc020474c:	8082                	ret
ffffffffc020474e:	1141                	addi	sp,sp,-16
ffffffffc0204750:	00008697          	auipc	a3,0x8
ffffffffc0204754:	7a868693          	addi	a3,a3,1960 # ffffffffc020cef8 <default_pmm_manager+0xb78>
ffffffffc0204758:	00007617          	auipc	a2,0x7
ffffffffc020475c:	14060613          	addi	a2,a2,320 # ffffffffc020b898 <commands+0x210>
ffffffffc0204760:	07400593          	li	a1,116
ffffffffc0204764:	00008517          	auipc	a0,0x8
ffffffffc0204768:	73c50513          	addi	a0,a0,1852 # ffffffffc020cea0 <default_pmm_manager+0xb20>
ffffffffc020476c:	e406                	sd	ra,8(sp)
ffffffffc020476e:	d31fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204772 <get_fd_array.part.0>:
ffffffffc0204772:	1141                	addi	sp,sp,-16
ffffffffc0204774:	00008697          	auipc	a3,0x8
ffffffffc0204778:	79468693          	addi	a3,a3,1940 # ffffffffc020cf08 <default_pmm_manager+0xb88>
ffffffffc020477c:	00007617          	auipc	a2,0x7
ffffffffc0204780:	11c60613          	addi	a2,a2,284 # ffffffffc020b898 <commands+0x210>
ffffffffc0204784:	45d1                	li	a1,20
ffffffffc0204786:	00008517          	auipc	a0,0x8
ffffffffc020478a:	7b250513          	addi	a0,a0,1970 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc020478e:	e406                	sd	ra,8(sp)
ffffffffc0204790:	d0ffb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204794 <fd_array_alloc>:
ffffffffc0204794:	00092797          	auipc	a5,0x92
ffffffffc0204798:	12c7b783          	ld	a5,300(a5) # ffffffffc02968c0 <current>
ffffffffc020479c:	1487b783          	ld	a5,328(a5)
ffffffffc02047a0:	1141                	addi	sp,sp,-16
ffffffffc02047a2:	e406                	sd	ra,8(sp)
ffffffffc02047a4:	c3a5                	beqz	a5,ffffffffc0204804 <fd_array_alloc+0x70>
ffffffffc02047a6:	4b98                	lw	a4,16(a5)
ffffffffc02047a8:	04e05e63          	blez	a4,ffffffffc0204804 <fd_array_alloc+0x70>
ffffffffc02047ac:	775d                	lui	a4,0xffff7
ffffffffc02047ae:	ad970713          	addi	a4,a4,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc02047b2:	679c                	ld	a5,8(a5)
ffffffffc02047b4:	02e50863          	beq	a0,a4,ffffffffc02047e4 <fd_array_alloc+0x50>
ffffffffc02047b8:	04700713          	li	a4,71
ffffffffc02047bc:	04a76263          	bltu	a4,a0,ffffffffc0204800 <fd_array_alloc+0x6c>
ffffffffc02047c0:	00351713          	slli	a4,a0,0x3
ffffffffc02047c4:	40a70533          	sub	a0,a4,a0
ffffffffc02047c8:	050e                	slli	a0,a0,0x3
ffffffffc02047ca:	97aa                	add	a5,a5,a0
ffffffffc02047cc:	4398                	lw	a4,0(a5)
ffffffffc02047ce:	e71d                	bnez	a4,ffffffffc02047fc <fd_array_alloc+0x68>
ffffffffc02047d0:	5b88                	lw	a0,48(a5)
ffffffffc02047d2:	e91d                	bnez	a0,ffffffffc0204808 <fd_array_alloc+0x74>
ffffffffc02047d4:	4705                	li	a4,1
ffffffffc02047d6:	c398                	sw	a4,0(a5)
ffffffffc02047d8:	0207b423          	sd	zero,40(a5)
ffffffffc02047dc:	e19c                	sd	a5,0(a1)
ffffffffc02047de:	60a2                	ld	ra,8(sp)
ffffffffc02047e0:	0141                	addi	sp,sp,16
ffffffffc02047e2:	8082                	ret
ffffffffc02047e4:	6685                	lui	a3,0x1
ffffffffc02047e6:	fc068693          	addi	a3,a3,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02047ea:	96be                	add	a3,a3,a5
ffffffffc02047ec:	4398                	lw	a4,0(a5)
ffffffffc02047ee:	d36d                	beqz	a4,ffffffffc02047d0 <fd_array_alloc+0x3c>
ffffffffc02047f0:	03878793          	addi	a5,a5,56
ffffffffc02047f4:	fef69ce3          	bne	a3,a5,ffffffffc02047ec <fd_array_alloc+0x58>
ffffffffc02047f8:	5529                	li	a0,-22
ffffffffc02047fa:	b7d5                	j	ffffffffc02047de <fd_array_alloc+0x4a>
ffffffffc02047fc:	5545                	li	a0,-15
ffffffffc02047fe:	b7c5                	j	ffffffffc02047de <fd_array_alloc+0x4a>
ffffffffc0204800:	5575                	li	a0,-3
ffffffffc0204802:	bff1                	j	ffffffffc02047de <fd_array_alloc+0x4a>
ffffffffc0204804:	f6fff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>
ffffffffc0204808:	00008697          	auipc	a3,0x8
ffffffffc020480c:	74068693          	addi	a3,a3,1856 # ffffffffc020cf48 <default_pmm_manager+0xbc8>
ffffffffc0204810:	00007617          	auipc	a2,0x7
ffffffffc0204814:	08860613          	addi	a2,a2,136 # ffffffffc020b898 <commands+0x210>
ffffffffc0204818:	03b00593          	li	a1,59
ffffffffc020481c:	00008517          	auipc	a0,0x8
ffffffffc0204820:	71c50513          	addi	a0,a0,1820 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc0204824:	c7bfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204828 <fd_array_free>:
ffffffffc0204828:	411c                	lw	a5,0(a0)
ffffffffc020482a:	1141                	addi	sp,sp,-16
ffffffffc020482c:	e022                	sd	s0,0(sp)
ffffffffc020482e:	e406                	sd	ra,8(sp)
ffffffffc0204830:	4705                	li	a4,1
ffffffffc0204832:	842a                	mv	s0,a0
ffffffffc0204834:	04e78063          	beq	a5,a4,ffffffffc0204874 <fd_array_free+0x4c>
ffffffffc0204838:	470d                	li	a4,3
ffffffffc020483a:	04e79563          	bne	a5,a4,ffffffffc0204884 <fd_array_free+0x5c>
ffffffffc020483e:	591c                	lw	a5,48(a0)
ffffffffc0204840:	c38d                	beqz	a5,ffffffffc0204862 <fd_array_free+0x3a>
ffffffffc0204842:	00008697          	auipc	a3,0x8
ffffffffc0204846:	70668693          	addi	a3,a3,1798 # ffffffffc020cf48 <default_pmm_manager+0xbc8>
ffffffffc020484a:	00007617          	auipc	a2,0x7
ffffffffc020484e:	04e60613          	addi	a2,a2,78 # ffffffffc020b898 <commands+0x210>
ffffffffc0204852:	04500593          	li	a1,69
ffffffffc0204856:	00008517          	auipc	a0,0x8
ffffffffc020485a:	6e250513          	addi	a0,a0,1762 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc020485e:	c41fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204862:	7408                	ld	a0,40(s0)
ffffffffc0204864:	7ba030ef          	jal	ra,ffffffffc020801e <vfs_close>
ffffffffc0204868:	60a2                	ld	ra,8(sp)
ffffffffc020486a:	00042023          	sw	zero,0(s0)
ffffffffc020486e:	6402                	ld	s0,0(sp)
ffffffffc0204870:	0141                	addi	sp,sp,16
ffffffffc0204872:	8082                	ret
ffffffffc0204874:	591c                	lw	a5,48(a0)
ffffffffc0204876:	f7f1                	bnez	a5,ffffffffc0204842 <fd_array_free+0x1a>
ffffffffc0204878:	60a2                	ld	ra,8(sp)
ffffffffc020487a:	00042023          	sw	zero,0(s0)
ffffffffc020487e:	6402                	ld	s0,0(sp)
ffffffffc0204880:	0141                	addi	sp,sp,16
ffffffffc0204882:	8082                	ret
ffffffffc0204884:	00008697          	auipc	a3,0x8
ffffffffc0204888:	6fc68693          	addi	a3,a3,1788 # ffffffffc020cf80 <default_pmm_manager+0xc00>
ffffffffc020488c:	00007617          	auipc	a2,0x7
ffffffffc0204890:	00c60613          	addi	a2,a2,12 # ffffffffc020b898 <commands+0x210>
ffffffffc0204894:	04400593          	li	a1,68
ffffffffc0204898:	00008517          	auipc	a0,0x8
ffffffffc020489c:	6a050513          	addi	a0,a0,1696 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc02048a0:	bfffb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02048a4 <fd_array_release>:
ffffffffc02048a4:	4118                	lw	a4,0(a0)
ffffffffc02048a6:	1141                	addi	sp,sp,-16
ffffffffc02048a8:	e406                	sd	ra,8(sp)
ffffffffc02048aa:	4685                	li	a3,1
ffffffffc02048ac:	3779                	addiw	a4,a4,-2
ffffffffc02048ae:	04e6e063          	bltu	a3,a4,ffffffffc02048ee <fd_array_release+0x4a>
ffffffffc02048b2:	5918                	lw	a4,48(a0)
ffffffffc02048b4:	00e05d63          	blez	a4,ffffffffc02048ce <fd_array_release+0x2a>
ffffffffc02048b8:	fff7069b          	addiw	a3,a4,-1
ffffffffc02048bc:	d914                	sw	a3,48(a0)
ffffffffc02048be:	c681                	beqz	a3,ffffffffc02048c6 <fd_array_release+0x22>
ffffffffc02048c0:	60a2                	ld	ra,8(sp)
ffffffffc02048c2:	0141                	addi	sp,sp,16
ffffffffc02048c4:	8082                	ret
ffffffffc02048c6:	60a2                	ld	ra,8(sp)
ffffffffc02048c8:	0141                	addi	sp,sp,16
ffffffffc02048ca:	f5fff06f          	j	ffffffffc0204828 <fd_array_free>
ffffffffc02048ce:	00008697          	auipc	a3,0x8
ffffffffc02048d2:	72268693          	addi	a3,a3,1826 # ffffffffc020cff0 <default_pmm_manager+0xc70>
ffffffffc02048d6:	00007617          	auipc	a2,0x7
ffffffffc02048da:	fc260613          	addi	a2,a2,-62 # ffffffffc020b898 <commands+0x210>
ffffffffc02048de:	05600593          	li	a1,86
ffffffffc02048e2:	00008517          	auipc	a0,0x8
ffffffffc02048e6:	65650513          	addi	a0,a0,1622 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc02048ea:	bb5fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02048ee:	00008697          	auipc	a3,0x8
ffffffffc02048f2:	6ca68693          	addi	a3,a3,1738 # ffffffffc020cfb8 <default_pmm_manager+0xc38>
ffffffffc02048f6:	00007617          	auipc	a2,0x7
ffffffffc02048fa:	fa260613          	addi	a2,a2,-94 # ffffffffc020b898 <commands+0x210>
ffffffffc02048fe:	05500593          	li	a1,85
ffffffffc0204902:	00008517          	auipc	a0,0x8
ffffffffc0204906:	63650513          	addi	a0,a0,1590 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc020490a:	b95fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020490e <fd_array_open.part.0>:
ffffffffc020490e:	1141                	addi	sp,sp,-16
ffffffffc0204910:	00008697          	auipc	a3,0x8
ffffffffc0204914:	6f868693          	addi	a3,a3,1784 # ffffffffc020d008 <default_pmm_manager+0xc88>
ffffffffc0204918:	00007617          	auipc	a2,0x7
ffffffffc020491c:	f8060613          	addi	a2,a2,-128 # ffffffffc020b898 <commands+0x210>
ffffffffc0204920:	05f00593          	li	a1,95
ffffffffc0204924:	00008517          	auipc	a0,0x8
ffffffffc0204928:	61450513          	addi	a0,a0,1556 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc020492c:	e406                	sd	ra,8(sp)
ffffffffc020492e:	b71fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204932 <fd_array_init>:
ffffffffc0204932:	4781                	li	a5,0
ffffffffc0204934:	04800713          	li	a4,72
ffffffffc0204938:	cd1c                	sw	a5,24(a0)
ffffffffc020493a:	02052823          	sw	zero,48(a0)
ffffffffc020493e:	00052023          	sw	zero,0(a0)
ffffffffc0204942:	2785                	addiw	a5,a5,1
ffffffffc0204944:	03850513          	addi	a0,a0,56
ffffffffc0204948:	fee798e3          	bne	a5,a4,ffffffffc0204938 <fd_array_init+0x6>
ffffffffc020494c:	8082                	ret

ffffffffc020494e <fd_array_close>:
ffffffffc020494e:	4118                	lw	a4,0(a0)
ffffffffc0204950:	1141                	addi	sp,sp,-16
ffffffffc0204952:	e406                	sd	ra,8(sp)
ffffffffc0204954:	e022                	sd	s0,0(sp)
ffffffffc0204956:	4789                	li	a5,2
ffffffffc0204958:	04f71a63          	bne	a4,a5,ffffffffc02049ac <fd_array_close+0x5e>
ffffffffc020495c:	591c                	lw	a5,48(a0)
ffffffffc020495e:	842a                	mv	s0,a0
ffffffffc0204960:	02f05663          	blez	a5,ffffffffc020498c <fd_array_close+0x3e>
ffffffffc0204964:	37fd                	addiw	a5,a5,-1
ffffffffc0204966:	470d                	li	a4,3
ffffffffc0204968:	c118                	sw	a4,0(a0)
ffffffffc020496a:	d91c                	sw	a5,48(a0)
ffffffffc020496c:	0007871b          	sext.w	a4,a5
ffffffffc0204970:	c709                	beqz	a4,ffffffffc020497a <fd_array_close+0x2c>
ffffffffc0204972:	60a2                	ld	ra,8(sp)
ffffffffc0204974:	6402                	ld	s0,0(sp)
ffffffffc0204976:	0141                	addi	sp,sp,16
ffffffffc0204978:	8082                	ret
ffffffffc020497a:	7508                	ld	a0,40(a0)
ffffffffc020497c:	6a2030ef          	jal	ra,ffffffffc020801e <vfs_close>
ffffffffc0204980:	60a2                	ld	ra,8(sp)
ffffffffc0204982:	00042023          	sw	zero,0(s0)
ffffffffc0204986:	6402                	ld	s0,0(sp)
ffffffffc0204988:	0141                	addi	sp,sp,16
ffffffffc020498a:	8082                	ret
ffffffffc020498c:	00008697          	auipc	a3,0x8
ffffffffc0204990:	66468693          	addi	a3,a3,1636 # ffffffffc020cff0 <default_pmm_manager+0xc70>
ffffffffc0204994:	00007617          	auipc	a2,0x7
ffffffffc0204998:	f0460613          	addi	a2,a2,-252 # ffffffffc020b898 <commands+0x210>
ffffffffc020499c:	06800593          	li	a1,104
ffffffffc02049a0:	00008517          	auipc	a0,0x8
ffffffffc02049a4:	59850513          	addi	a0,a0,1432 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc02049a8:	af7fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02049ac:	00008697          	auipc	a3,0x8
ffffffffc02049b0:	5b468693          	addi	a3,a3,1460 # ffffffffc020cf60 <default_pmm_manager+0xbe0>
ffffffffc02049b4:	00007617          	auipc	a2,0x7
ffffffffc02049b8:	ee460613          	addi	a2,a2,-284 # ffffffffc020b898 <commands+0x210>
ffffffffc02049bc:	06700593          	li	a1,103
ffffffffc02049c0:	00008517          	auipc	a0,0x8
ffffffffc02049c4:	57850513          	addi	a0,a0,1400 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc02049c8:	ad7fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02049cc <fd_array_dup>:
ffffffffc02049cc:	7179                	addi	sp,sp,-48
ffffffffc02049ce:	e84a                	sd	s2,16(sp)
ffffffffc02049d0:	00052903          	lw	s2,0(a0)
ffffffffc02049d4:	f406                	sd	ra,40(sp)
ffffffffc02049d6:	f022                	sd	s0,32(sp)
ffffffffc02049d8:	ec26                	sd	s1,24(sp)
ffffffffc02049da:	e44e                	sd	s3,8(sp)
ffffffffc02049dc:	4785                	li	a5,1
ffffffffc02049de:	04f91663          	bne	s2,a5,ffffffffc0204a2a <fd_array_dup+0x5e>
ffffffffc02049e2:	0005a983          	lw	s3,0(a1)
ffffffffc02049e6:	4789                	li	a5,2
ffffffffc02049e8:	04f99163          	bne	s3,a5,ffffffffc0204a2a <fd_array_dup+0x5e>
ffffffffc02049ec:	7584                	ld	s1,40(a1)
ffffffffc02049ee:	699c                	ld	a5,16(a1)
ffffffffc02049f0:	7194                	ld	a3,32(a1)
ffffffffc02049f2:	6598                	ld	a4,8(a1)
ffffffffc02049f4:	842a                	mv	s0,a0
ffffffffc02049f6:	e91c                	sd	a5,16(a0)
ffffffffc02049f8:	f114                	sd	a3,32(a0)
ffffffffc02049fa:	e518                	sd	a4,8(a0)
ffffffffc02049fc:	8526                	mv	a0,s1
ffffffffc02049fe:	57f020ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc0204a02:	8526                	mv	a0,s1
ffffffffc0204a04:	585020ef          	jal	ra,ffffffffc0207788 <inode_open_inc>
ffffffffc0204a08:	401c                	lw	a5,0(s0)
ffffffffc0204a0a:	f404                	sd	s1,40(s0)
ffffffffc0204a0c:	03279f63          	bne	a5,s2,ffffffffc0204a4a <fd_array_dup+0x7e>
ffffffffc0204a10:	cc8d                	beqz	s1,ffffffffc0204a4a <fd_array_dup+0x7e>
ffffffffc0204a12:	581c                	lw	a5,48(s0)
ffffffffc0204a14:	01342023          	sw	s3,0(s0)
ffffffffc0204a18:	70a2                	ld	ra,40(sp)
ffffffffc0204a1a:	2785                	addiw	a5,a5,1
ffffffffc0204a1c:	d81c                	sw	a5,48(s0)
ffffffffc0204a1e:	7402                	ld	s0,32(sp)
ffffffffc0204a20:	64e2                	ld	s1,24(sp)
ffffffffc0204a22:	6942                	ld	s2,16(sp)
ffffffffc0204a24:	69a2                	ld	s3,8(sp)
ffffffffc0204a26:	6145                	addi	sp,sp,48
ffffffffc0204a28:	8082                	ret
ffffffffc0204a2a:	00008697          	auipc	a3,0x8
ffffffffc0204a2e:	60e68693          	addi	a3,a3,1550 # ffffffffc020d038 <default_pmm_manager+0xcb8>
ffffffffc0204a32:	00007617          	auipc	a2,0x7
ffffffffc0204a36:	e6660613          	addi	a2,a2,-410 # ffffffffc020b898 <commands+0x210>
ffffffffc0204a3a:	07300593          	li	a1,115
ffffffffc0204a3e:	00008517          	auipc	a0,0x8
ffffffffc0204a42:	4fa50513          	addi	a0,a0,1274 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc0204a46:	a59fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204a4a:	ec5ff0ef          	jal	ra,ffffffffc020490e <fd_array_open.part.0>

ffffffffc0204a4e <file_testfd>:
ffffffffc0204a4e:	04700793          	li	a5,71
ffffffffc0204a52:	04a7e263          	bltu	a5,a0,ffffffffc0204a96 <file_testfd+0x48>
ffffffffc0204a56:	00092797          	auipc	a5,0x92
ffffffffc0204a5a:	e6a7b783          	ld	a5,-406(a5) # ffffffffc02968c0 <current>
ffffffffc0204a5e:	1487b783          	ld	a5,328(a5)
ffffffffc0204a62:	cf85                	beqz	a5,ffffffffc0204a9a <file_testfd+0x4c>
ffffffffc0204a64:	4b98                	lw	a4,16(a5)
ffffffffc0204a66:	02e05a63          	blez	a4,ffffffffc0204a9a <file_testfd+0x4c>
ffffffffc0204a6a:	6798                	ld	a4,8(a5)
ffffffffc0204a6c:	00351793          	slli	a5,a0,0x3
ffffffffc0204a70:	8f89                	sub	a5,a5,a0
ffffffffc0204a72:	078e                	slli	a5,a5,0x3
ffffffffc0204a74:	97ba                	add	a5,a5,a4
ffffffffc0204a76:	4394                	lw	a3,0(a5)
ffffffffc0204a78:	4709                	li	a4,2
ffffffffc0204a7a:	00e69e63          	bne	a3,a4,ffffffffc0204a96 <file_testfd+0x48>
ffffffffc0204a7e:	4f98                	lw	a4,24(a5)
ffffffffc0204a80:	00a71b63          	bne	a4,a0,ffffffffc0204a96 <file_testfd+0x48>
ffffffffc0204a84:	c199                	beqz	a1,ffffffffc0204a8a <file_testfd+0x3c>
ffffffffc0204a86:	6788                	ld	a0,8(a5)
ffffffffc0204a88:	c901                	beqz	a0,ffffffffc0204a98 <file_testfd+0x4a>
ffffffffc0204a8a:	4505                	li	a0,1
ffffffffc0204a8c:	c611                	beqz	a2,ffffffffc0204a98 <file_testfd+0x4a>
ffffffffc0204a8e:	6b88                	ld	a0,16(a5)
ffffffffc0204a90:	00a03533          	snez	a0,a0
ffffffffc0204a94:	8082                	ret
ffffffffc0204a96:	4501                	li	a0,0
ffffffffc0204a98:	8082                	ret
ffffffffc0204a9a:	1141                	addi	sp,sp,-16
ffffffffc0204a9c:	e406                	sd	ra,8(sp)
ffffffffc0204a9e:	cd5ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc0204aa2 <file_open>:
ffffffffc0204aa2:	711d                	addi	sp,sp,-96
ffffffffc0204aa4:	ec86                	sd	ra,88(sp)
ffffffffc0204aa6:	e8a2                	sd	s0,80(sp)
ffffffffc0204aa8:	e4a6                	sd	s1,72(sp)
ffffffffc0204aaa:	e0ca                	sd	s2,64(sp)
ffffffffc0204aac:	fc4e                	sd	s3,56(sp)
ffffffffc0204aae:	f852                	sd	s4,48(sp)
ffffffffc0204ab0:	0035f793          	andi	a5,a1,3
ffffffffc0204ab4:	470d                	li	a4,3
ffffffffc0204ab6:	0ce78163          	beq	a5,a4,ffffffffc0204b78 <file_open+0xd6>
ffffffffc0204aba:	078e                	slli	a5,a5,0x3
ffffffffc0204abc:	00008717          	auipc	a4,0x8
ffffffffc0204ac0:	7ec70713          	addi	a4,a4,2028 # ffffffffc020d2a8 <CSWTCH.79>
ffffffffc0204ac4:	892a                	mv	s2,a0
ffffffffc0204ac6:	00008697          	auipc	a3,0x8
ffffffffc0204aca:	7ca68693          	addi	a3,a3,1994 # ffffffffc020d290 <CSWTCH.78>
ffffffffc0204ace:	755d                	lui	a0,0xffff7
ffffffffc0204ad0:	96be                	add	a3,a3,a5
ffffffffc0204ad2:	84ae                	mv	s1,a1
ffffffffc0204ad4:	97ba                	add	a5,a5,a4
ffffffffc0204ad6:	858a                	mv	a1,sp
ffffffffc0204ad8:	ad950513          	addi	a0,a0,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204adc:	0006ba03          	ld	s4,0(a3)
ffffffffc0204ae0:	0007b983          	ld	s3,0(a5)
ffffffffc0204ae4:	cb1ff0ef          	jal	ra,ffffffffc0204794 <fd_array_alloc>
ffffffffc0204ae8:	842a                	mv	s0,a0
ffffffffc0204aea:	c911                	beqz	a0,ffffffffc0204afe <file_open+0x5c>
ffffffffc0204aec:	60e6                	ld	ra,88(sp)
ffffffffc0204aee:	8522                	mv	a0,s0
ffffffffc0204af0:	6446                	ld	s0,80(sp)
ffffffffc0204af2:	64a6                	ld	s1,72(sp)
ffffffffc0204af4:	6906                	ld	s2,64(sp)
ffffffffc0204af6:	79e2                	ld	s3,56(sp)
ffffffffc0204af8:	7a42                	ld	s4,48(sp)
ffffffffc0204afa:	6125                	addi	sp,sp,96
ffffffffc0204afc:	8082                	ret
ffffffffc0204afe:	0030                	addi	a2,sp,8
ffffffffc0204b00:	85a6                	mv	a1,s1
ffffffffc0204b02:	854a                	mv	a0,s2
ffffffffc0204b04:	374030ef          	jal	ra,ffffffffc0207e78 <vfs_open>
ffffffffc0204b08:	842a                	mv	s0,a0
ffffffffc0204b0a:	e13d                	bnez	a0,ffffffffc0204b70 <file_open+0xce>
ffffffffc0204b0c:	6782                	ld	a5,0(sp)
ffffffffc0204b0e:	0204f493          	andi	s1,s1,32
ffffffffc0204b12:	6422                	ld	s0,8(sp)
ffffffffc0204b14:	0207b023          	sd	zero,32(a5)
ffffffffc0204b18:	c885                	beqz	s1,ffffffffc0204b48 <file_open+0xa6>
ffffffffc0204b1a:	c03d                	beqz	s0,ffffffffc0204b80 <file_open+0xde>
ffffffffc0204b1c:	783c                	ld	a5,112(s0)
ffffffffc0204b1e:	c3ad                	beqz	a5,ffffffffc0204b80 <file_open+0xde>
ffffffffc0204b20:	779c                	ld	a5,40(a5)
ffffffffc0204b22:	cfb9                	beqz	a5,ffffffffc0204b80 <file_open+0xde>
ffffffffc0204b24:	8522                	mv	a0,s0
ffffffffc0204b26:	00008597          	auipc	a1,0x8
ffffffffc0204b2a:	59a58593          	addi	a1,a1,1434 # ffffffffc020d0c0 <default_pmm_manager+0xd40>
ffffffffc0204b2e:	467020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204b32:	783c                	ld	a5,112(s0)
ffffffffc0204b34:	6522                	ld	a0,8(sp)
ffffffffc0204b36:	080c                	addi	a1,sp,16
ffffffffc0204b38:	779c                	ld	a5,40(a5)
ffffffffc0204b3a:	9782                	jalr	a5
ffffffffc0204b3c:	842a                	mv	s0,a0
ffffffffc0204b3e:	e515                	bnez	a0,ffffffffc0204b6a <file_open+0xc8>
ffffffffc0204b40:	6782                	ld	a5,0(sp)
ffffffffc0204b42:	7722                	ld	a4,40(sp)
ffffffffc0204b44:	6422                	ld	s0,8(sp)
ffffffffc0204b46:	f398                	sd	a4,32(a5)
ffffffffc0204b48:	4394                	lw	a3,0(a5)
ffffffffc0204b4a:	f780                	sd	s0,40(a5)
ffffffffc0204b4c:	0147b423          	sd	s4,8(a5)
ffffffffc0204b50:	0137b823          	sd	s3,16(a5)
ffffffffc0204b54:	4705                	li	a4,1
ffffffffc0204b56:	02e69363          	bne	a3,a4,ffffffffc0204b7c <file_open+0xda>
ffffffffc0204b5a:	c00d                	beqz	s0,ffffffffc0204b7c <file_open+0xda>
ffffffffc0204b5c:	5b98                	lw	a4,48(a5)
ffffffffc0204b5e:	4689                	li	a3,2
ffffffffc0204b60:	4f80                	lw	s0,24(a5)
ffffffffc0204b62:	2705                	addiw	a4,a4,1
ffffffffc0204b64:	c394                	sw	a3,0(a5)
ffffffffc0204b66:	db98                	sw	a4,48(a5)
ffffffffc0204b68:	b751                	j	ffffffffc0204aec <file_open+0x4a>
ffffffffc0204b6a:	6522                	ld	a0,8(sp)
ffffffffc0204b6c:	4b2030ef          	jal	ra,ffffffffc020801e <vfs_close>
ffffffffc0204b70:	6502                	ld	a0,0(sp)
ffffffffc0204b72:	cb7ff0ef          	jal	ra,ffffffffc0204828 <fd_array_free>
ffffffffc0204b76:	bf9d                	j	ffffffffc0204aec <file_open+0x4a>
ffffffffc0204b78:	5475                	li	s0,-3
ffffffffc0204b7a:	bf8d                	j	ffffffffc0204aec <file_open+0x4a>
ffffffffc0204b7c:	d93ff0ef          	jal	ra,ffffffffc020490e <fd_array_open.part.0>
ffffffffc0204b80:	00008697          	auipc	a3,0x8
ffffffffc0204b84:	4f068693          	addi	a3,a3,1264 # ffffffffc020d070 <default_pmm_manager+0xcf0>
ffffffffc0204b88:	00007617          	auipc	a2,0x7
ffffffffc0204b8c:	d1060613          	addi	a2,a2,-752 # ffffffffc020b898 <commands+0x210>
ffffffffc0204b90:	0b500593          	li	a1,181
ffffffffc0204b94:	00008517          	auipc	a0,0x8
ffffffffc0204b98:	3a450513          	addi	a0,a0,932 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc0204b9c:	903fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204ba0 <file_close>:
ffffffffc0204ba0:	04700713          	li	a4,71
ffffffffc0204ba4:	04a76563          	bltu	a4,a0,ffffffffc0204bee <file_close+0x4e>
ffffffffc0204ba8:	00092717          	auipc	a4,0x92
ffffffffc0204bac:	d1873703          	ld	a4,-744(a4) # ffffffffc02968c0 <current>
ffffffffc0204bb0:	14873703          	ld	a4,328(a4)
ffffffffc0204bb4:	1141                	addi	sp,sp,-16
ffffffffc0204bb6:	e406                	sd	ra,8(sp)
ffffffffc0204bb8:	cf0d                	beqz	a4,ffffffffc0204bf2 <file_close+0x52>
ffffffffc0204bba:	4b14                	lw	a3,16(a4)
ffffffffc0204bbc:	02d05b63          	blez	a3,ffffffffc0204bf2 <file_close+0x52>
ffffffffc0204bc0:	6718                	ld	a4,8(a4)
ffffffffc0204bc2:	87aa                	mv	a5,a0
ffffffffc0204bc4:	050e                	slli	a0,a0,0x3
ffffffffc0204bc6:	8d1d                	sub	a0,a0,a5
ffffffffc0204bc8:	050e                	slli	a0,a0,0x3
ffffffffc0204bca:	953a                	add	a0,a0,a4
ffffffffc0204bcc:	4114                	lw	a3,0(a0)
ffffffffc0204bce:	4709                	li	a4,2
ffffffffc0204bd0:	00e69b63          	bne	a3,a4,ffffffffc0204be6 <file_close+0x46>
ffffffffc0204bd4:	4d18                	lw	a4,24(a0)
ffffffffc0204bd6:	00f71863          	bne	a4,a5,ffffffffc0204be6 <file_close+0x46>
ffffffffc0204bda:	d75ff0ef          	jal	ra,ffffffffc020494e <fd_array_close>
ffffffffc0204bde:	60a2                	ld	ra,8(sp)
ffffffffc0204be0:	4501                	li	a0,0
ffffffffc0204be2:	0141                	addi	sp,sp,16
ffffffffc0204be4:	8082                	ret
ffffffffc0204be6:	60a2                	ld	ra,8(sp)
ffffffffc0204be8:	5575                	li	a0,-3
ffffffffc0204bea:	0141                	addi	sp,sp,16
ffffffffc0204bec:	8082                	ret
ffffffffc0204bee:	5575                	li	a0,-3
ffffffffc0204bf0:	8082                	ret
ffffffffc0204bf2:	b81ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc0204bf6 <file_read>:
ffffffffc0204bf6:	715d                	addi	sp,sp,-80
ffffffffc0204bf8:	e486                	sd	ra,72(sp)
ffffffffc0204bfa:	e0a2                	sd	s0,64(sp)
ffffffffc0204bfc:	fc26                	sd	s1,56(sp)
ffffffffc0204bfe:	f84a                	sd	s2,48(sp)
ffffffffc0204c00:	f44e                	sd	s3,40(sp)
ffffffffc0204c02:	f052                	sd	s4,32(sp)
ffffffffc0204c04:	0006b023          	sd	zero,0(a3)
ffffffffc0204c08:	04700793          	li	a5,71
ffffffffc0204c0c:	0aa7e463          	bltu	a5,a0,ffffffffc0204cb4 <file_read+0xbe>
ffffffffc0204c10:	00092797          	auipc	a5,0x92
ffffffffc0204c14:	cb07b783          	ld	a5,-848(a5) # ffffffffc02968c0 <current>
ffffffffc0204c18:	1487b783          	ld	a5,328(a5)
ffffffffc0204c1c:	cfd1                	beqz	a5,ffffffffc0204cb8 <file_read+0xc2>
ffffffffc0204c1e:	4b98                	lw	a4,16(a5)
ffffffffc0204c20:	08e05c63          	blez	a4,ffffffffc0204cb8 <file_read+0xc2>
ffffffffc0204c24:	6780                	ld	s0,8(a5)
ffffffffc0204c26:	00351793          	slli	a5,a0,0x3
ffffffffc0204c2a:	8f89                	sub	a5,a5,a0
ffffffffc0204c2c:	078e                	slli	a5,a5,0x3
ffffffffc0204c2e:	943e                	add	s0,s0,a5
ffffffffc0204c30:	00042983          	lw	s3,0(s0)
ffffffffc0204c34:	4789                	li	a5,2
ffffffffc0204c36:	06f99f63          	bne	s3,a5,ffffffffc0204cb4 <file_read+0xbe>
ffffffffc0204c3a:	4c1c                	lw	a5,24(s0)
ffffffffc0204c3c:	06a79c63          	bne	a5,a0,ffffffffc0204cb4 <file_read+0xbe>
ffffffffc0204c40:	641c                	ld	a5,8(s0)
ffffffffc0204c42:	cbad                	beqz	a5,ffffffffc0204cb4 <file_read+0xbe>
ffffffffc0204c44:	581c                	lw	a5,48(s0)
ffffffffc0204c46:	8a36                	mv	s4,a3
ffffffffc0204c48:	7014                	ld	a3,32(s0)
ffffffffc0204c4a:	2785                	addiw	a5,a5,1
ffffffffc0204c4c:	850a                	mv	a0,sp
ffffffffc0204c4e:	d81c                	sw	a5,48(s0)
ffffffffc0204c50:	792000ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc0204c54:	02843903          	ld	s2,40(s0)
ffffffffc0204c58:	84aa                	mv	s1,a0
ffffffffc0204c5a:	06090163          	beqz	s2,ffffffffc0204cbc <file_read+0xc6>
ffffffffc0204c5e:	07093783          	ld	a5,112(s2)
ffffffffc0204c62:	cfa9                	beqz	a5,ffffffffc0204cbc <file_read+0xc6>
ffffffffc0204c64:	6f9c                	ld	a5,24(a5)
ffffffffc0204c66:	cbb9                	beqz	a5,ffffffffc0204cbc <file_read+0xc6>
ffffffffc0204c68:	00008597          	auipc	a1,0x8
ffffffffc0204c6c:	4b058593          	addi	a1,a1,1200 # ffffffffc020d118 <default_pmm_manager+0xd98>
ffffffffc0204c70:	854a                	mv	a0,s2
ffffffffc0204c72:	323020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204c76:	07093783          	ld	a5,112(s2)
ffffffffc0204c7a:	7408                	ld	a0,40(s0)
ffffffffc0204c7c:	85a6                	mv	a1,s1
ffffffffc0204c7e:	6f9c                	ld	a5,24(a5)
ffffffffc0204c80:	9782                	jalr	a5
ffffffffc0204c82:	689c                	ld	a5,16(s1)
ffffffffc0204c84:	6c94                	ld	a3,24(s1)
ffffffffc0204c86:	4018                	lw	a4,0(s0)
ffffffffc0204c88:	84aa                	mv	s1,a0
ffffffffc0204c8a:	8f95                	sub	a5,a5,a3
ffffffffc0204c8c:	03370063          	beq	a4,s3,ffffffffc0204cac <file_read+0xb6>
ffffffffc0204c90:	00fa3023          	sd	a5,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0204c94:	8522                	mv	a0,s0
ffffffffc0204c96:	c0fff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc0204c9a:	60a6                	ld	ra,72(sp)
ffffffffc0204c9c:	6406                	ld	s0,64(sp)
ffffffffc0204c9e:	7942                	ld	s2,48(sp)
ffffffffc0204ca0:	79a2                	ld	s3,40(sp)
ffffffffc0204ca2:	7a02                	ld	s4,32(sp)
ffffffffc0204ca4:	8526                	mv	a0,s1
ffffffffc0204ca6:	74e2                	ld	s1,56(sp)
ffffffffc0204ca8:	6161                	addi	sp,sp,80
ffffffffc0204caa:	8082                	ret
ffffffffc0204cac:	7018                	ld	a4,32(s0)
ffffffffc0204cae:	973e                	add	a4,a4,a5
ffffffffc0204cb0:	f018                	sd	a4,32(s0)
ffffffffc0204cb2:	bff9                	j	ffffffffc0204c90 <file_read+0x9a>
ffffffffc0204cb4:	54f5                	li	s1,-3
ffffffffc0204cb6:	b7d5                	j	ffffffffc0204c9a <file_read+0xa4>
ffffffffc0204cb8:	abbff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>
ffffffffc0204cbc:	00008697          	auipc	a3,0x8
ffffffffc0204cc0:	40c68693          	addi	a3,a3,1036 # ffffffffc020d0c8 <default_pmm_manager+0xd48>
ffffffffc0204cc4:	00007617          	auipc	a2,0x7
ffffffffc0204cc8:	bd460613          	addi	a2,a2,-1068 # ffffffffc020b898 <commands+0x210>
ffffffffc0204ccc:	0de00593          	li	a1,222
ffffffffc0204cd0:	00008517          	auipc	a0,0x8
ffffffffc0204cd4:	26850513          	addi	a0,a0,616 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc0204cd8:	fc6fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204cdc <file_write>:
ffffffffc0204cdc:	715d                	addi	sp,sp,-80
ffffffffc0204cde:	e486                	sd	ra,72(sp)
ffffffffc0204ce0:	e0a2                	sd	s0,64(sp)
ffffffffc0204ce2:	fc26                	sd	s1,56(sp)
ffffffffc0204ce4:	f84a                	sd	s2,48(sp)
ffffffffc0204ce6:	f44e                	sd	s3,40(sp)
ffffffffc0204ce8:	f052                	sd	s4,32(sp)
ffffffffc0204cea:	0006b023          	sd	zero,0(a3)
ffffffffc0204cee:	04700793          	li	a5,71
ffffffffc0204cf2:	0aa7e463          	bltu	a5,a0,ffffffffc0204d9a <file_write+0xbe>
ffffffffc0204cf6:	00092797          	auipc	a5,0x92
ffffffffc0204cfa:	bca7b783          	ld	a5,-1078(a5) # ffffffffc02968c0 <current>
ffffffffc0204cfe:	1487b783          	ld	a5,328(a5)
ffffffffc0204d02:	cfd1                	beqz	a5,ffffffffc0204d9e <file_write+0xc2>
ffffffffc0204d04:	4b98                	lw	a4,16(a5)
ffffffffc0204d06:	08e05c63          	blez	a4,ffffffffc0204d9e <file_write+0xc2>
ffffffffc0204d0a:	6780                	ld	s0,8(a5)
ffffffffc0204d0c:	00351793          	slli	a5,a0,0x3
ffffffffc0204d10:	8f89                	sub	a5,a5,a0
ffffffffc0204d12:	078e                	slli	a5,a5,0x3
ffffffffc0204d14:	943e                	add	s0,s0,a5
ffffffffc0204d16:	00042983          	lw	s3,0(s0)
ffffffffc0204d1a:	4789                	li	a5,2
ffffffffc0204d1c:	06f99f63          	bne	s3,a5,ffffffffc0204d9a <file_write+0xbe>
ffffffffc0204d20:	4c1c                	lw	a5,24(s0)
ffffffffc0204d22:	06a79c63          	bne	a5,a0,ffffffffc0204d9a <file_write+0xbe>
ffffffffc0204d26:	681c                	ld	a5,16(s0)
ffffffffc0204d28:	cbad                	beqz	a5,ffffffffc0204d9a <file_write+0xbe>
ffffffffc0204d2a:	581c                	lw	a5,48(s0)
ffffffffc0204d2c:	8a36                	mv	s4,a3
ffffffffc0204d2e:	7014                	ld	a3,32(s0)
ffffffffc0204d30:	2785                	addiw	a5,a5,1
ffffffffc0204d32:	850a                	mv	a0,sp
ffffffffc0204d34:	d81c                	sw	a5,48(s0)
ffffffffc0204d36:	6ac000ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc0204d3a:	02843903          	ld	s2,40(s0)
ffffffffc0204d3e:	84aa                	mv	s1,a0
ffffffffc0204d40:	06090163          	beqz	s2,ffffffffc0204da2 <file_write+0xc6>
ffffffffc0204d44:	07093783          	ld	a5,112(s2)
ffffffffc0204d48:	cfa9                	beqz	a5,ffffffffc0204da2 <file_write+0xc6>
ffffffffc0204d4a:	739c                	ld	a5,32(a5)
ffffffffc0204d4c:	cbb9                	beqz	a5,ffffffffc0204da2 <file_write+0xc6>
ffffffffc0204d4e:	00008597          	auipc	a1,0x8
ffffffffc0204d52:	42258593          	addi	a1,a1,1058 # ffffffffc020d170 <default_pmm_manager+0xdf0>
ffffffffc0204d56:	854a                	mv	a0,s2
ffffffffc0204d58:	23d020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204d5c:	07093783          	ld	a5,112(s2)
ffffffffc0204d60:	7408                	ld	a0,40(s0)
ffffffffc0204d62:	85a6                	mv	a1,s1
ffffffffc0204d64:	739c                	ld	a5,32(a5)
ffffffffc0204d66:	9782                	jalr	a5
ffffffffc0204d68:	689c                	ld	a5,16(s1)
ffffffffc0204d6a:	6c94                	ld	a3,24(s1)
ffffffffc0204d6c:	4018                	lw	a4,0(s0)
ffffffffc0204d6e:	84aa                	mv	s1,a0
ffffffffc0204d70:	8f95                	sub	a5,a5,a3
ffffffffc0204d72:	03370063          	beq	a4,s3,ffffffffc0204d92 <file_write+0xb6>
ffffffffc0204d76:	00fa3023          	sd	a5,0(s4)
ffffffffc0204d7a:	8522                	mv	a0,s0
ffffffffc0204d7c:	b29ff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc0204d80:	60a6                	ld	ra,72(sp)
ffffffffc0204d82:	6406                	ld	s0,64(sp)
ffffffffc0204d84:	7942                	ld	s2,48(sp)
ffffffffc0204d86:	79a2                	ld	s3,40(sp)
ffffffffc0204d88:	7a02                	ld	s4,32(sp)
ffffffffc0204d8a:	8526                	mv	a0,s1
ffffffffc0204d8c:	74e2                	ld	s1,56(sp)
ffffffffc0204d8e:	6161                	addi	sp,sp,80
ffffffffc0204d90:	8082                	ret
ffffffffc0204d92:	7018                	ld	a4,32(s0)
ffffffffc0204d94:	973e                	add	a4,a4,a5
ffffffffc0204d96:	f018                	sd	a4,32(s0)
ffffffffc0204d98:	bff9                	j	ffffffffc0204d76 <file_write+0x9a>
ffffffffc0204d9a:	54f5                	li	s1,-3
ffffffffc0204d9c:	b7d5                	j	ffffffffc0204d80 <file_write+0xa4>
ffffffffc0204d9e:	9d5ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>
ffffffffc0204da2:	00008697          	auipc	a3,0x8
ffffffffc0204da6:	37e68693          	addi	a3,a3,894 # ffffffffc020d120 <default_pmm_manager+0xda0>
ffffffffc0204daa:	00007617          	auipc	a2,0x7
ffffffffc0204dae:	aee60613          	addi	a2,a2,-1298 # ffffffffc020b898 <commands+0x210>
ffffffffc0204db2:	0f800593          	li	a1,248
ffffffffc0204db6:	00008517          	auipc	a0,0x8
ffffffffc0204dba:	18250513          	addi	a0,a0,386 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc0204dbe:	ee0fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204dc2 <file_seek>:
ffffffffc0204dc2:	7139                	addi	sp,sp,-64
ffffffffc0204dc4:	fc06                	sd	ra,56(sp)
ffffffffc0204dc6:	f822                	sd	s0,48(sp)
ffffffffc0204dc8:	f426                	sd	s1,40(sp)
ffffffffc0204dca:	f04a                	sd	s2,32(sp)
ffffffffc0204dcc:	04700793          	li	a5,71
ffffffffc0204dd0:	08a7e863          	bltu	a5,a0,ffffffffc0204e60 <file_seek+0x9e>
ffffffffc0204dd4:	00092797          	auipc	a5,0x92
ffffffffc0204dd8:	aec7b783          	ld	a5,-1300(a5) # ffffffffc02968c0 <current>
ffffffffc0204ddc:	1487b783          	ld	a5,328(a5)
ffffffffc0204de0:	cfdd                	beqz	a5,ffffffffc0204e9e <file_seek+0xdc>
ffffffffc0204de2:	4b98                	lw	a4,16(a5)
ffffffffc0204de4:	0ae05d63          	blez	a4,ffffffffc0204e9e <file_seek+0xdc>
ffffffffc0204de8:	6780                	ld	s0,8(a5)
ffffffffc0204dea:	00351793          	slli	a5,a0,0x3
ffffffffc0204dee:	8f89                	sub	a5,a5,a0
ffffffffc0204df0:	078e                	slli	a5,a5,0x3
ffffffffc0204df2:	943e                	add	s0,s0,a5
ffffffffc0204df4:	4018                	lw	a4,0(s0)
ffffffffc0204df6:	4789                	li	a5,2
ffffffffc0204df8:	06f71463          	bne	a4,a5,ffffffffc0204e60 <file_seek+0x9e>
ffffffffc0204dfc:	4c1c                	lw	a5,24(s0)
ffffffffc0204dfe:	06a79163          	bne	a5,a0,ffffffffc0204e60 <file_seek+0x9e>
ffffffffc0204e02:	581c                	lw	a5,48(s0)
ffffffffc0204e04:	4685                	li	a3,1
ffffffffc0204e06:	892e                	mv	s2,a1
ffffffffc0204e08:	2785                	addiw	a5,a5,1
ffffffffc0204e0a:	d81c                	sw	a5,48(s0)
ffffffffc0204e0c:	02d60063          	beq	a2,a3,ffffffffc0204e2c <file_seek+0x6a>
ffffffffc0204e10:	06e60063          	beq	a2,a4,ffffffffc0204e70 <file_seek+0xae>
ffffffffc0204e14:	54f5                	li	s1,-3
ffffffffc0204e16:	ce11                	beqz	a2,ffffffffc0204e32 <file_seek+0x70>
ffffffffc0204e18:	8522                	mv	a0,s0
ffffffffc0204e1a:	a8bff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc0204e1e:	70e2                	ld	ra,56(sp)
ffffffffc0204e20:	7442                	ld	s0,48(sp)
ffffffffc0204e22:	7902                	ld	s2,32(sp)
ffffffffc0204e24:	8526                	mv	a0,s1
ffffffffc0204e26:	74a2                	ld	s1,40(sp)
ffffffffc0204e28:	6121                	addi	sp,sp,64
ffffffffc0204e2a:	8082                	ret
ffffffffc0204e2c:	701c                	ld	a5,32(s0)
ffffffffc0204e2e:	00f58933          	add	s2,a1,a5
ffffffffc0204e32:	7404                	ld	s1,40(s0)
ffffffffc0204e34:	c4bd                	beqz	s1,ffffffffc0204ea2 <file_seek+0xe0>
ffffffffc0204e36:	78bc                	ld	a5,112(s1)
ffffffffc0204e38:	c7ad                	beqz	a5,ffffffffc0204ea2 <file_seek+0xe0>
ffffffffc0204e3a:	6fbc                	ld	a5,88(a5)
ffffffffc0204e3c:	c3bd                	beqz	a5,ffffffffc0204ea2 <file_seek+0xe0>
ffffffffc0204e3e:	8526                	mv	a0,s1
ffffffffc0204e40:	00008597          	auipc	a1,0x8
ffffffffc0204e44:	38858593          	addi	a1,a1,904 # ffffffffc020d1c8 <default_pmm_manager+0xe48>
ffffffffc0204e48:	14d020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204e4c:	78bc                	ld	a5,112(s1)
ffffffffc0204e4e:	7408                	ld	a0,40(s0)
ffffffffc0204e50:	85ca                	mv	a1,s2
ffffffffc0204e52:	6fbc                	ld	a5,88(a5)
ffffffffc0204e54:	9782                	jalr	a5
ffffffffc0204e56:	84aa                	mv	s1,a0
ffffffffc0204e58:	f161                	bnez	a0,ffffffffc0204e18 <file_seek+0x56>
ffffffffc0204e5a:	03243023          	sd	s2,32(s0)
ffffffffc0204e5e:	bf6d                	j	ffffffffc0204e18 <file_seek+0x56>
ffffffffc0204e60:	70e2                	ld	ra,56(sp)
ffffffffc0204e62:	7442                	ld	s0,48(sp)
ffffffffc0204e64:	54f5                	li	s1,-3
ffffffffc0204e66:	7902                	ld	s2,32(sp)
ffffffffc0204e68:	8526                	mv	a0,s1
ffffffffc0204e6a:	74a2                	ld	s1,40(sp)
ffffffffc0204e6c:	6121                	addi	sp,sp,64
ffffffffc0204e6e:	8082                	ret
ffffffffc0204e70:	7404                	ld	s1,40(s0)
ffffffffc0204e72:	c8a1                	beqz	s1,ffffffffc0204ec2 <file_seek+0x100>
ffffffffc0204e74:	78bc                	ld	a5,112(s1)
ffffffffc0204e76:	c7b1                	beqz	a5,ffffffffc0204ec2 <file_seek+0x100>
ffffffffc0204e78:	779c                	ld	a5,40(a5)
ffffffffc0204e7a:	c7a1                	beqz	a5,ffffffffc0204ec2 <file_seek+0x100>
ffffffffc0204e7c:	8526                	mv	a0,s1
ffffffffc0204e7e:	00008597          	auipc	a1,0x8
ffffffffc0204e82:	24258593          	addi	a1,a1,578 # ffffffffc020d0c0 <default_pmm_manager+0xd40>
ffffffffc0204e86:	10f020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204e8a:	78bc                	ld	a5,112(s1)
ffffffffc0204e8c:	7408                	ld	a0,40(s0)
ffffffffc0204e8e:	858a                	mv	a1,sp
ffffffffc0204e90:	779c                	ld	a5,40(a5)
ffffffffc0204e92:	9782                	jalr	a5
ffffffffc0204e94:	84aa                	mv	s1,a0
ffffffffc0204e96:	f149                	bnez	a0,ffffffffc0204e18 <file_seek+0x56>
ffffffffc0204e98:	67e2                	ld	a5,24(sp)
ffffffffc0204e9a:	993e                	add	s2,s2,a5
ffffffffc0204e9c:	bf59                	j	ffffffffc0204e32 <file_seek+0x70>
ffffffffc0204e9e:	8d5ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>
ffffffffc0204ea2:	00008697          	auipc	a3,0x8
ffffffffc0204ea6:	2d668693          	addi	a3,a3,726 # ffffffffc020d178 <default_pmm_manager+0xdf8>
ffffffffc0204eaa:	00007617          	auipc	a2,0x7
ffffffffc0204eae:	9ee60613          	addi	a2,a2,-1554 # ffffffffc020b898 <commands+0x210>
ffffffffc0204eb2:	11a00593          	li	a1,282
ffffffffc0204eb6:	00008517          	auipc	a0,0x8
ffffffffc0204eba:	08250513          	addi	a0,a0,130 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc0204ebe:	de0fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204ec2:	00008697          	auipc	a3,0x8
ffffffffc0204ec6:	1ae68693          	addi	a3,a3,430 # ffffffffc020d070 <default_pmm_manager+0xcf0>
ffffffffc0204eca:	00007617          	auipc	a2,0x7
ffffffffc0204ece:	9ce60613          	addi	a2,a2,-1586 # ffffffffc020b898 <commands+0x210>
ffffffffc0204ed2:	11200593          	li	a1,274
ffffffffc0204ed6:	00008517          	auipc	a0,0x8
ffffffffc0204eda:	06250513          	addi	a0,a0,98 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc0204ede:	dc0fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204ee2 <file_fstat>:
ffffffffc0204ee2:	1101                	addi	sp,sp,-32
ffffffffc0204ee4:	ec06                	sd	ra,24(sp)
ffffffffc0204ee6:	e822                	sd	s0,16(sp)
ffffffffc0204ee8:	e426                	sd	s1,8(sp)
ffffffffc0204eea:	e04a                	sd	s2,0(sp)
ffffffffc0204eec:	04700793          	li	a5,71
ffffffffc0204ef0:	06a7ef63          	bltu	a5,a0,ffffffffc0204f6e <file_fstat+0x8c>
ffffffffc0204ef4:	00092797          	auipc	a5,0x92
ffffffffc0204ef8:	9cc7b783          	ld	a5,-1588(a5) # ffffffffc02968c0 <current>
ffffffffc0204efc:	1487b783          	ld	a5,328(a5)
ffffffffc0204f00:	cfd9                	beqz	a5,ffffffffc0204f9e <file_fstat+0xbc>
ffffffffc0204f02:	4b98                	lw	a4,16(a5)
ffffffffc0204f04:	08e05d63          	blez	a4,ffffffffc0204f9e <file_fstat+0xbc>
ffffffffc0204f08:	6780                	ld	s0,8(a5)
ffffffffc0204f0a:	00351793          	slli	a5,a0,0x3
ffffffffc0204f0e:	8f89                	sub	a5,a5,a0
ffffffffc0204f10:	078e                	slli	a5,a5,0x3
ffffffffc0204f12:	943e                	add	s0,s0,a5
ffffffffc0204f14:	4018                	lw	a4,0(s0)
ffffffffc0204f16:	4789                	li	a5,2
ffffffffc0204f18:	04f71b63          	bne	a4,a5,ffffffffc0204f6e <file_fstat+0x8c>
ffffffffc0204f1c:	4c1c                	lw	a5,24(s0)
ffffffffc0204f1e:	04a79863          	bne	a5,a0,ffffffffc0204f6e <file_fstat+0x8c>
ffffffffc0204f22:	581c                	lw	a5,48(s0)
ffffffffc0204f24:	02843903          	ld	s2,40(s0)
ffffffffc0204f28:	2785                	addiw	a5,a5,1
ffffffffc0204f2a:	d81c                	sw	a5,48(s0)
ffffffffc0204f2c:	04090963          	beqz	s2,ffffffffc0204f7e <file_fstat+0x9c>
ffffffffc0204f30:	07093783          	ld	a5,112(s2)
ffffffffc0204f34:	c7a9                	beqz	a5,ffffffffc0204f7e <file_fstat+0x9c>
ffffffffc0204f36:	779c                	ld	a5,40(a5)
ffffffffc0204f38:	c3b9                	beqz	a5,ffffffffc0204f7e <file_fstat+0x9c>
ffffffffc0204f3a:	84ae                	mv	s1,a1
ffffffffc0204f3c:	854a                	mv	a0,s2
ffffffffc0204f3e:	00008597          	auipc	a1,0x8
ffffffffc0204f42:	18258593          	addi	a1,a1,386 # ffffffffc020d0c0 <default_pmm_manager+0xd40>
ffffffffc0204f46:	04f020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204f4a:	07093783          	ld	a5,112(s2)
ffffffffc0204f4e:	7408                	ld	a0,40(s0)
ffffffffc0204f50:	85a6                	mv	a1,s1
ffffffffc0204f52:	779c                	ld	a5,40(a5)
ffffffffc0204f54:	9782                	jalr	a5
ffffffffc0204f56:	87aa                	mv	a5,a0
ffffffffc0204f58:	8522                	mv	a0,s0
ffffffffc0204f5a:	843e                	mv	s0,a5
ffffffffc0204f5c:	949ff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc0204f60:	60e2                	ld	ra,24(sp)
ffffffffc0204f62:	8522                	mv	a0,s0
ffffffffc0204f64:	6442                	ld	s0,16(sp)
ffffffffc0204f66:	64a2                	ld	s1,8(sp)
ffffffffc0204f68:	6902                	ld	s2,0(sp)
ffffffffc0204f6a:	6105                	addi	sp,sp,32
ffffffffc0204f6c:	8082                	ret
ffffffffc0204f6e:	5475                	li	s0,-3
ffffffffc0204f70:	60e2                	ld	ra,24(sp)
ffffffffc0204f72:	8522                	mv	a0,s0
ffffffffc0204f74:	6442                	ld	s0,16(sp)
ffffffffc0204f76:	64a2                	ld	s1,8(sp)
ffffffffc0204f78:	6902                	ld	s2,0(sp)
ffffffffc0204f7a:	6105                	addi	sp,sp,32
ffffffffc0204f7c:	8082                	ret
ffffffffc0204f7e:	00008697          	auipc	a3,0x8
ffffffffc0204f82:	0f268693          	addi	a3,a3,242 # ffffffffc020d070 <default_pmm_manager+0xcf0>
ffffffffc0204f86:	00007617          	auipc	a2,0x7
ffffffffc0204f8a:	91260613          	addi	a2,a2,-1774 # ffffffffc020b898 <commands+0x210>
ffffffffc0204f8e:	12c00593          	li	a1,300
ffffffffc0204f92:	00008517          	auipc	a0,0x8
ffffffffc0204f96:	fa650513          	addi	a0,a0,-90 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc0204f9a:	d04fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204f9e:	fd4ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc0204fa2 <file_fsync>:
ffffffffc0204fa2:	1101                	addi	sp,sp,-32
ffffffffc0204fa4:	ec06                	sd	ra,24(sp)
ffffffffc0204fa6:	e822                	sd	s0,16(sp)
ffffffffc0204fa8:	e426                	sd	s1,8(sp)
ffffffffc0204faa:	04700793          	li	a5,71
ffffffffc0204fae:	06a7e863          	bltu	a5,a0,ffffffffc020501e <file_fsync+0x7c>
ffffffffc0204fb2:	00092797          	auipc	a5,0x92
ffffffffc0204fb6:	90e7b783          	ld	a5,-1778(a5) # ffffffffc02968c0 <current>
ffffffffc0204fba:	1487b783          	ld	a5,328(a5)
ffffffffc0204fbe:	c7d9                	beqz	a5,ffffffffc020504c <file_fsync+0xaa>
ffffffffc0204fc0:	4b98                	lw	a4,16(a5)
ffffffffc0204fc2:	08e05563          	blez	a4,ffffffffc020504c <file_fsync+0xaa>
ffffffffc0204fc6:	6780                	ld	s0,8(a5)
ffffffffc0204fc8:	00351793          	slli	a5,a0,0x3
ffffffffc0204fcc:	8f89                	sub	a5,a5,a0
ffffffffc0204fce:	078e                	slli	a5,a5,0x3
ffffffffc0204fd0:	943e                	add	s0,s0,a5
ffffffffc0204fd2:	4018                	lw	a4,0(s0)
ffffffffc0204fd4:	4789                	li	a5,2
ffffffffc0204fd6:	04f71463          	bne	a4,a5,ffffffffc020501e <file_fsync+0x7c>
ffffffffc0204fda:	4c1c                	lw	a5,24(s0)
ffffffffc0204fdc:	04a79163          	bne	a5,a0,ffffffffc020501e <file_fsync+0x7c>
ffffffffc0204fe0:	581c                	lw	a5,48(s0)
ffffffffc0204fe2:	7404                	ld	s1,40(s0)
ffffffffc0204fe4:	2785                	addiw	a5,a5,1
ffffffffc0204fe6:	d81c                	sw	a5,48(s0)
ffffffffc0204fe8:	c0b1                	beqz	s1,ffffffffc020502c <file_fsync+0x8a>
ffffffffc0204fea:	78bc                	ld	a5,112(s1)
ffffffffc0204fec:	c3a1                	beqz	a5,ffffffffc020502c <file_fsync+0x8a>
ffffffffc0204fee:	7b9c                	ld	a5,48(a5)
ffffffffc0204ff0:	cf95                	beqz	a5,ffffffffc020502c <file_fsync+0x8a>
ffffffffc0204ff2:	00008597          	auipc	a1,0x8
ffffffffc0204ff6:	22e58593          	addi	a1,a1,558 # ffffffffc020d220 <default_pmm_manager+0xea0>
ffffffffc0204ffa:	8526                	mv	a0,s1
ffffffffc0204ffc:	798020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0205000:	78bc                	ld	a5,112(s1)
ffffffffc0205002:	7408                	ld	a0,40(s0)
ffffffffc0205004:	7b9c                	ld	a5,48(a5)
ffffffffc0205006:	9782                	jalr	a5
ffffffffc0205008:	87aa                	mv	a5,a0
ffffffffc020500a:	8522                	mv	a0,s0
ffffffffc020500c:	843e                	mv	s0,a5
ffffffffc020500e:	897ff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc0205012:	60e2                	ld	ra,24(sp)
ffffffffc0205014:	8522                	mv	a0,s0
ffffffffc0205016:	6442                	ld	s0,16(sp)
ffffffffc0205018:	64a2                	ld	s1,8(sp)
ffffffffc020501a:	6105                	addi	sp,sp,32
ffffffffc020501c:	8082                	ret
ffffffffc020501e:	5475                	li	s0,-3
ffffffffc0205020:	60e2                	ld	ra,24(sp)
ffffffffc0205022:	8522                	mv	a0,s0
ffffffffc0205024:	6442                	ld	s0,16(sp)
ffffffffc0205026:	64a2                	ld	s1,8(sp)
ffffffffc0205028:	6105                	addi	sp,sp,32
ffffffffc020502a:	8082                	ret
ffffffffc020502c:	00008697          	auipc	a3,0x8
ffffffffc0205030:	1a468693          	addi	a3,a3,420 # ffffffffc020d1d0 <default_pmm_manager+0xe50>
ffffffffc0205034:	00007617          	auipc	a2,0x7
ffffffffc0205038:	86460613          	addi	a2,a2,-1948 # ffffffffc020b898 <commands+0x210>
ffffffffc020503c:	13a00593          	li	a1,314
ffffffffc0205040:	00008517          	auipc	a0,0x8
ffffffffc0205044:	ef850513          	addi	a0,a0,-264 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc0205048:	c56fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020504c:	f26ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc0205050 <file_getdirentry>:
ffffffffc0205050:	715d                	addi	sp,sp,-80
ffffffffc0205052:	e486                	sd	ra,72(sp)
ffffffffc0205054:	e0a2                	sd	s0,64(sp)
ffffffffc0205056:	fc26                	sd	s1,56(sp)
ffffffffc0205058:	f84a                	sd	s2,48(sp)
ffffffffc020505a:	f44e                	sd	s3,40(sp)
ffffffffc020505c:	04700793          	li	a5,71
ffffffffc0205060:	0aa7e063          	bltu	a5,a0,ffffffffc0205100 <file_getdirentry+0xb0>
ffffffffc0205064:	00092797          	auipc	a5,0x92
ffffffffc0205068:	85c7b783          	ld	a5,-1956(a5) # ffffffffc02968c0 <current>
ffffffffc020506c:	1487b783          	ld	a5,328(a5)
ffffffffc0205070:	c3e9                	beqz	a5,ffffffffc0205132 <file_getdirentry+0xe2>
ffffffffc0205072:	4b98                	lw	a4,16(a5)
ffffffffc0205074:	0ae05f63          	blez	a4,ffffffffc0205132 <file_getdirentry+0xe2>
ffffffffc0205078:	6780                	ld	s0,8(a5)
ffffffffc020507a:	00351793          	slli	a5,a0,0x3
ffffffffc020507e:	8f89                	sub	a5,a5,a0
ffffffffc0205080:	078e                	slli	a5,a5,0x3
ffffffffc0205082:	943e                	add	s0,s0,a5
ffffffffc0205084:	4018                	lw	a4,0(s0)
ffffffffc0205086:	4789                	li	a5,2
ffffffffc0205088:	06f71c63          	bne	a4,a5,ffffffffc0205100 <file_getdirentry+0xb0>
ffffffffc020508c:	4c1c                	lw	a5,24(s0)
ffffffffc020508e:	06a79963          	bne	a5,a0,ffffffffc0205100 <file_getdirentry+0xb0>
ffffffffc0205092:	581c                	lw	a5,48(s0)
ffffffffc0205094:	6194                	ld	a3,0(a1)
ffffffffc0205096:	84ae                	mv	s1,a1
ffffffffc0205098:	2785                	addiw	a5,a5,1
ffffffffc020509a:	10000613          	li	a2,256
ffffffffc020509e:	d81c                	sw	a5,48(s0)
ffffffffc02050a0:	05a1                	addi	a1,a1,8
ffffffffc02050a2:	850a                	mv	a0,sp
ffffffffc02050a4:	33e000ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc02050a8:	02843983          	ld	s3,40(s0)
ffffffffc02050ac:	892a                	mv	s2,a0
ffffffffc02050ae:	06098263          	beqz	s3,ffffffffc0205112 <file_getdirentry+0xc2>
ffffffffc02050b2:	0709b783          	ld	a5,112(s3) # 1070 <_binary_bin_swap_img_size-0x6c90>
ffffffffc02050b6:	cfb1                	beqz	a5,ffffffffc0205112 <file_getdirentry+0xc2>
ffffffffc02050b8:	63bc                	ld	a5,64(a5)
ffffffffc02050ba:	cfa1                	beqz	a5,ffffffffc0205112 <file_getdirentry+0xc2>
ffffffffc02050bc:	854e                	mv	a0,s3
ffffffffc02050be:	00008597          	auipc	a1,0x8
ffffffffc02050c2:	1c258593          	addi	a1,a1,450 # ffffffffc020d280 <default_pmm_manager+0xf00>
ffffffffc02050c6:	6ce020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc02050ca:	0709b783          	ld	a5,112(s3)
ffffffffc02050ce:	7408                	ld	a0,40(s0)
ffffffffc02050d0:	85ca                	mv	a1,s2
ffffffffc02050d2:	63bc                	ld	a5,64(a5)
ffffffffc02050d4:	9782                	jalr	a5
ffffffffc02050d6:	89aa                	mv	s3,a0
ffffffffc02050d8:	e909                	bnez	a0,ffffffffc02050ea <file_getdirentry+0x9a>
ffffffffc02050da:	609c                	ld	a5,0(s1)
ffffffffc02050dc:	01093683          	ld	a3,16(s2)
ffffffffc02050e0:	01893703          	ld	a4,24(s2)
ffffffffc02050e4:	97b6                	add	a5,a5,a3
ffffffffc02050e6:	8f99                	sub	a5,a5,a4
ffffffffc02050e8:	e09c                	sd	a5,0(s1)
ffffffffc02050ea:	8522                	mv	a0,s0
ffffffffc02050ec:	fb8ff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc02050f0:	60a6                	ld	ra,72(sp)
ffffffffc02050f2:	6406                	ld	s0,64(sp)
ffffffffc02050f4:	74e2                	ld	s1,56(sp)
ffffffffc02050f6:	7942                	ld	s2,48(sp)
ffffffffc02050f8:	854e                	mv	a0,s3
ffffffffc02050fa:	79a2                	ld	s3,40(sp)
ffffffffc02050fc:	6161                	addi	sp,sp,80
ffffffffc02050fe:	8082                	ret
ffffffffc0205100:	60a6                	ld	ra,72(sp)
ffffffffc0205102:	6406                	ld	s0,64(sp)
ffffffffc0205104:	59f5                	li	s3,-3
ffffffffc0205106:	74e2                	ld	s1,56(sp)
ffffffffc0205108:	7942                	ld	s2,48(sp)
ffffffffc020510a:	854e                	mv	a0,s3
ffffffffc020510c:	79a2                	ld	s3,40(sp)
ffffffffc020510e:	6161                	addi	sp,sp,80
ffffffffc0205110:	8082                	ret
ffffffffc0205112:	00008697          	auipc	a3,0x8
ffffffffc0205116:	11668693          	addi	a3,a3,278 # ffffffffc020d228 <default_pmm_manager+0xea8>
ffffffffc020511a:	00006617          	auipc	a2,0x6
ffffffffc020511e:	77e60613          	addi	a2,a2,1918 # ffffffffc020b898 <commands+0x210>
ffffffffc0205122:	14a00593          	li	a1,330
ffffffffc0205126:	00008517          	auipc	a0,0x8
ffffffffc020512a:	e1250513          	addi	a0,a0,-494 # ffffffffc020cf38 <default_pmm_manager+0xbb8>
ffffffffc020512e:	b70fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205132:	e40ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc0205136 <file_dup>:
ffffffffc0205136:	04700713          	li	a4,71
ffffffffc020513a:	06a76463          	bltu	a4,a0,ffffffffc02051a2 <file_dup+0x6c>
ffffffffc020513e:	00091717          	auipc	a4,0x91
ffffffffc0205142:	78273703          	ld	a4,1922(a4) # ffffffffc02968c0 <current>
ffffffffc0205146:	14873703          	ld	a4,328(a4)
ffffffffc020514a:	1101                	addi	sp,sp,-32
ffffffffc020514c:	ec06                	sd	ra,24(sp)
ffffffffc020514e:	e822                	sd	s0,16(sp)
ffffffffc0205150:	cb39                	beqz	a4,ffffffffc02051a6 <file_dup+0x70>
ffffffffc0205152:	4b14                	lw	a3,16(a4)
ffffffffc0205154:	04d05963          	blez	a3,ffffffffc02051a6 <file_dup+0x70>
ffffffffc0205158:	6700                	ld	s0,8(a4)
ffffffffc020515a:	00351713          	slli	a4,a0,0x3
ffffffffc020515e:	8f09                	sub	a4,a4,a0
ffffffffc0205160:	070e                	slli	a4,a4,0x3
ffffffffc0205162:	943a                	add	s0,s0,a4
ffffffffc0205164:	4014                	lw	a3,0(s0)
ffffffffc0205166:	4709                	li	a4,2
ffffffffc0205168:	02e69863          	bne	a3,a4,ffffffffc0205198 <file_dup+0x62>
ffffffffc020516c:	4c18                	lw	a4,24(s0)
ffffffffc020516e:	02a71563          	bne	a4,a0,ffffffffc0205198 <file_dup+0x62>
ffffffffc0205172:	852e                	mv	a0,a1
ffffffffc0205174:	002c                	addi	a1,sp,8
ffffffffc0205176:	e1eff0ef          	jal	ra,ffffffffc0204794 <fd_array_alloc>
ffffffffc020517a:	c509                	beqz	a0,ffffffffc0205184 <file_dup+0x4e>
ffffffffc020517c:	60e2                	ld	ra,24(sp)
ffffffffc020517e:	6442                	ld	s0,16(sp)
ffffffffc0205180:	6105                	addi	sp,sp,32
ffffffffc0205182:	8082                	ret
ffffffffc0205184:	6522                	ld	a0,8(sp)
ffffffffc0205186:	85a2                	mv	a1,s0
ffffffffc0205188:	845ff0ef          	jal	ra,ffffffffc02049cc <fd_array_dup>
ffffffffc020518c:	67a2                	ld	a5,8(sp)
ffffffffc020518e:	60e2                	ld	ra,24(sp)
ffffffffc0205190:	6442                	ld	s0,16(sp)
ffffffffc0205192:	4f88                	lw	a0,24(a5)
ffffffffc0205194:	6105                	addi	sp,sp,32
ffffffffc0205196:	8082                	ret
ffffffffc0205198:	60e2                	ld	ra,24(sp)
ffffffffc020519a:	6442                	ld	s0,16(sp)
ffffffffc020519c:	5575                	li	a0,-3
ffffffffc020519e:	6105                	addi	sp,sp,32
ffffffffc02051a0:	8082                	ret
ffffffffc02051a2:	5575                	li	a0,-3
ffffffffc02051a4:	8082                	ret
ffffffffc02051a6:	dccff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc02051aa <fs_init>:
ffffffffc02051aa:	1141                	addi	sp,sp,-16
ffffffffc02051ac:	e406                	sd	ra,8(sp)
ffffffffc02051ae:	005020ef          	jal	ra,ffffffffc02079b2 <vfs_init>
ffffffffc02051b2:	4dc030ef          	jal	ra,ffffffffc020868e <dev_init>
ffffffffc02051b6:	60a2                	ld	ra,8(sp)
ffffffffc02051b8:	0141                	addi	sp,sp,16
ffffffffc02051ba:	62d0306f          	j	ffffffffc0208fe6 <sfs_init>

ffffffffc02051be <fs_cleanup>:
ffffffffc02051be:	2470206f          	j	ffffffffc0207c04 <vfs_cleanup>

ffffffffc02051c2 <lock_files>:
ffffffffc02051c2:	0561                	addi	a0,a0,24
ffffffffc02051c4:	ba0ff06f          	j	ffffffffc0204564 <down>

ffffffffc02051c8 <unlock_files>:
ffffffffc02051c8:	0561                	addi	a0,a0,24
ffffffffc02051ca:	b96ff06f          	j	ffffffffc0204560 <up>

ffffffffc02051ce <files_create>:
ffffffffc02051ce:	1141                	addi	sp,sp,-16
ffffffffc02051d0:	6505                	lui	a0,0x1
ffffffffc02051d2:	e022                	sd	s0,0(sp)
ffffffffc02051d4:	e406                	sd	ra,8(sp)
ffffffffc02051d6:	db9fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02051da:	842a                	mv	s0,a0
ffffffffc02051dc:	cd19                	beqz	a0,ffffffffc02051fa <files_create+0x2c>
ffffffffc02051de:	03050793          	addi	a5,a0,48 # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc02051e2:	00043023          	sd	zero,0(s0)
ffffffffc02051e6:	0561                	addi	a0,a0,24
ffffffffc02051e8:	e41c                	sd	a5,8(s0)
ffffffffc02051ea:	00042823          	sw	zero,16(s0)
ffffffffc02051ee:	4585                	li	a1,1
ffffffffc02051f0:	b6aff0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc02051f4:	6408                	ld	a0,8(s0)
ffffffffc02051f6:	f3cff0ef          	jal	ra,ffffffffc0204932 <fd_array_init>
ffffffffc02051fa:	60a2                	ld	ra,8(sp)
ffffffffc02051fc:	8522                	mv	a0,s0
ffffffffc02051fe:	6402                	ld	s0,0(sp)
ffffffffc0205200:	0141                	addi	sp,sp,16
ffffffffc0205202:	8082                	ret

ffffffffc0205204 <files_destroy>:
ffffffffc0205204:	7179                	addi	sp,sp,-48
ffffffffc0205206:	f406                	sd	ra,40(sp)
ffffffffc0205208:	f022                	sd	s0,32(sp)
ffffffffc020520a:	ec26                	sd	s1,24(sp)
ffffffffc020520c:	e84a                	sd	s2,16(sp)
ffffffffc020520e:	e44e                	sd	s3,8(sp)
ffffffffc0205210:	c52d                	beqz	a0,ffffffffc020527a <files_destroy+0x76>
ffffffffc0205212:	491c                	lw	a5,16(a0)
ffffffffc0205214:	89aa                	mv	s3,a0
ffffffffc0205216:	e3b5                	bnez	a5,ffffffffc020527a <files_destroy+0x76>
ffffffffc0205218:	6108                	ld	a0,0(a0)
ffffffffc020521a:	c119                	beqz	a0,ffffffffc0205220 <files_destroy+0x1c>
ffffffffc020521c:	62e020ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc0205220:	0089b403          	ld	s0,8(s3)
ffffffffc0205224:	6485                	lui	s1,0x1
ffffffffc0205226:	fc048493          	addi	s1,s1,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc020522a:	94a2                	add	s1,s1,s0
ffffffffc020522c:	4909                	li	s2,2
ffffffffc020522e:	401c                	lw	a5,0(s0)
ffffffffc0205230:	03278063          	beq	a5,s2,ffffffffc0205250 <files_destroy+0x4c>
ffffffffc0205234:	e39d                	bnez	a5,ffffffffc020525a <files_destroy+0x56>
ffffffffc0205236:	03840413          	addi	s0,s0,56
ffffffffc020523a:	fe849ae3          	bne	s1,s0,ffffffffc020522e <files_destroy+0x2a>
ffffffffc020523e:	7402                	ld	s0,32(sp)
ffffffffc0205240:	70a2                	ld	ra,40(sp)
ffffffffc0205242:	64e2                	ld	s1,24(sp)
ffffffffc0205244:	6942                	ld	s2,16(sp)
ffffffffc0205246:	854e                	mv	a0,s3
ffffffffc0205248:	69a2                	ld	s3,8(sp)
ffffffffc020524a:	6145                	addi	sp,sp,48
ffffffffc020524c:	df3fc06f          	j	ffffffffc020203e <kfree>
ffffffffc0205250:	8522                	mv	a0,s0
ffffffffc0205252:	efcff0ef          	jal	ra,ffffffffc020494e <fd_array_close>
ffffffffc0205256:	401c                	lw	a5,0(s0)
ffffffffc0205258:	bff1                	j	ffffffffc0205234 <files_destroy+0x30>
ffffffffc020525a:	00008697          	auipc	a3,0x8
ffffffffc020525e:	0a668693          	addi	a3,a3,166 # ffffffffc020d300 <CSWTCH.79+0x58>
ffffffffc0205262:	00006617          	auipc	a2,0x6
ffffffffc0205266:	63660613          	addi	a2,a2,1590 # ffffffffc020b898 <commands+0x210>
ffffffffc020526a:	03d00593          	li	a1,61
ffffffffc020526e:	00008517          	auipc	a0,0x8
ffffffffc0205272:	08250513          	addi	a0,a0,130 # ffffffffc020d2f0 <CSWTCH.79+0x48>
ffffffffc0205276:	a28fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020527a:	00008697          	auipc	a3,0x8
ffffffffc020527e:	04668693          	addi	a3,a3,70 # ffffffffc020d2c0 <CSWTCH.79+0x18>
ffffffffc0205282:	00006617          	auipc	a2,0x6
ffffffffc0205286:	61660613          	addi	a2,a2,1558 # ffffffffc020b898 <commands+0x210>
ffffffffc020528a:	03300593          	li	a1,51
ffffffffc020528e:	00008517          	auipc	a0,0x8
ffffffffc0205292:	06250513          	addi	a0,a0,98 # ffffffffc020d2f0 <CSWTCH.79+0x48>
ffffffffc0205296:	a08fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020529a <files_closeall>:
ffffffffc020529a:	1101                	addi	sp,sp,-32
ffffffffc020529c:	ec06                	sd	ra,24(sp)
ffffffffc020529e:	e822                	sd	s0,16(sp)
ffffffffc02052a0:	e426                	sd	s1,8(sp)
ffffffffc02052a2:	e04a                	sd	s2,0(sp)
ffffffffc02052a4:	c129                	beqz	a0,ffffffffc02052e6 <files_closeall+0x4c>
ffffffffc02052a6:	491c                	lw	a5,16(a0)
ffffffffc02052a8:	02f05f63          	blez	a5,ffffffffc02052e6 <files_closeall+0x4c>
ffffffffc02052ac:	6504                	ld	s1,8(a0)
ffffffffc02052ae:	6785                	lui	a5,0x1
ffffffffc02052b0:	fc078793          	addi	a5,a5,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02052b4:	07048413          	addi	s0,s1,112
ffffffffc02052b8:	4909                	li	s2,2
ffffffffc02052ba:	94be                	add	s1,s1,a5
ffffffffc02052bc:	a029                	j	ffffffffc02052c6 <files_closeall+0x2c>
ffffffffc02052be:	03840413          	addi	s0,s0,56
ffffffffc02052c2:	00848c63          	beq	s1,s0,ffffffffc02052da <files_closeall+0x40>
ffffffffc02052c6:	401c                	lw	a5,0(s0)
ffffffffc02052c8:	ff279be3          	bne	a5,s2,ffffffffc02052be <files_closeall+0x24>
ffffffffc02052cc:	8522                	mv	a0,s0
ffffffffc02052ce:	03840413          	addi	s0,s0,56
ffffffffc02052d2:	e7cff0ef          	jal	ra,ffffffffc020494e <fd_array_close>
ffffffffc02052d6:	fe8498e3          	bne	s1,s0,ffffffffc02052c6 <files_closeall+0x2c>
ffffffffc02052da:	60e2                	ld	ra,24(sp)
ffffffffc02052dc:	6442                	ld	s0,16(sp)
ffffffffc02052de:	64a2                	ld	s1,8(sp)
ffffffffc02052e0:	6902                	ld	s2,0(sp)
ffffffffc02052e2:	6105                	addi	sp,sp,32
ffffffffc02052e4:	8082                	ret
ffffffffc02052e6:	00008697          	auipc	a3,0x8
ffffffffc02052ea:	c2268693          	addi	a3,a3,-990 # ffffffffc020cf08 <default_pmm_manager+0xb88>
ffffffffc02052ee:	00006617          	auipc	a2,0x6
ffffffffc02052f2:	5aa60613          	addi	a2,a2,1450 # ffffffffc020b898 <commands+0x210>
ffffffffc02052f6:	04500593          	li	a1,69
ffffffffc02052fa:	00008517          	auipc	a0,0x8
ffffffffc02052fe:	ff650513          	addi	a0,a0,-10 # ffffffffc020d2f0 <CSWTCH.79+0x48>
ffffffffc0205302:	99cfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205306 <dup_files>:
ffffffffc0205306:	7179                	addi	sp,sp,-48
ffffffffc0205308:	f406                	sd	ra,40(sp)
ffffffffc020530a:	f022                	sd	s0,32(sp)
ffffffffc020530c:	ec26                	sd	s1,24(sp)
ffffffffc020530e:	e84a                	sd	s2,16(sp)
ffffffffc0205310:	e44e                	sd	s3,8(sp)
ffffffffc0205312:	e052                	sd	s4,0(sp)
ffffffffc0205314:	c52d                	beqz	a0,ffffffffc020537e <dup_files+0x78>
ffffffffc0205316:	842e                	mv	s0,a1
ffffffffc0205318:	c1bd                	beqz	a1,ffffffffc020537e <dup_files+0x78>
ffffffffc020531a:	491c                	lw	a5,16(a0)
ffffffffc020531c:	84aa                	mv	s1,a0
ffffffffc020531e:	e3c1                	bnez	a5,ffffffffc020539e <dup_files+0x98>
ffffffffc0205320:	499c                	lw	a5,16(a1)
ffffffffc0205322:	06f05e63          	blez	a5,ffffffffc020539e <dup_files+0x98>
ffffffffc0205326:	6188                	ld	a0,0(a1)
ffffffffc0205328:	e088                	sd	a0,0(s1)
ffffffffc020532a:	c119                	beqz	a0,ffffffffc0205330 <dup_files+0x2a>
ffffffffc020532c:	450020ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc0205330:	6400                	ld	s0,8(s0)
ffffffffc0205332:	6905                	lui	s2,0x1
ffffffffc0205334:	fc090913          	addi	s2,s2,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205338:	6484                	ld	s1,8(s1)
ffffffffc020533a:	9922                	add	s2,s2,s0
ffffffffc020533c:	4989                	li	s3,2
ffffffffc020533e:	4a05                	li	s4,1
ffffffffc0205340:	a039                	j	ffffffffc020534e <dup_files+0x48>
ffffffffc0205342:	03840413          	addi	s0,s0,56
ffffffffc0205346:	03848493          	addi	s1,s1,56
ffffffffc020534a:	02890163          	beq	s2,s0,ffffffffc020536c <dup_files+0x66>
ffffffffc020534e:	401c                	lw	a5,0(s0)
ffffffffc0205350:	ff3799e3          	bne	a5,s3,ffffffffc0205342 <dup_files+0x3c>
ffffffffc0205354:	0144a023          	sw	s4,0(s1)
ffffffffc0205358:	85a2                	mv	a1,s0
ffffffffc020535a:	8526                	mv	a0,s1
ffffffffc020535c:	03840413          	addi	s0,s0,56
ffffffffc0205360:	e6cff0ef          	jal	ra,ffffffffc02049cc <fd_array_dup>
ffffffffc0205364:	03848493          	addi	s1,s1,56
ffffffffc0205368:	fe8913e3          	bne	s2,s0,ffffffffc020534e <dup_files+0x48>
ffffffffc020536c:	70a2                	ld	ra,40(sp)
ffffffffc020536e:	7402                	ld	s0,32(sp)
ffffffffc0205370:	64e2                	ld	s1,24(sp)
ffffffffc0205372:	6942                	ld	s2,16(sp)
ffffffffc0205374:	69a2                	ld	s3,8(sp)
ffffffffc0205376:	6a02                	ld	s4,0(sp)
ffffffffc0205378:	4501                	li	a0,0
ffffffffc020537a:	6145                	addi	sp,sp,48
ffffffffc020537c:	8082                	ret
ffffffffc020537e:	00008697          	auipc	a3,0x8
ffffffffc0205382:	8da68693          	addi	a3,a3,-1830 # ffffffffc020cc58 <default_pmm_manager+0x8d8>
ffffffffc0205386:	00006617          	auipc	a2,0x6
ffffffffc020538a:	51260613          	addi	a2,a2,1298 # ffffffffc020b898 <commands+0x210>
ffffffffc020538e:	05300593          	li	a1,83
ffffffffc0205392:	00008517          	auipc	a0,0x8
ffffffffc0205396:	f5e50513          	addi	a0,a0,-162 # ffffffffc020d2f0 <CSWTCH.79+0x48>
ffffffffc020539a:	904fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020539e:	00008697          	auipc	a3,0x8
ffffffffc02053a2:	f7a68693          	addi	a3,a3,-134 # ffffffffc020d318 <CSWTCH.79+0x70>
ffffffffc02053a6:	00006617          	auipc	a2,0x6
ffffffffc02053aa:	4f260613          	addi	a2,a2,1266 # ffffffffc020b898 <commands+0x210>
ffffffffc02053ae:	05400593          	li	a1,84
ffffffffc02053b2:	00008517          	auipc	a0,0x8
ffffffffc02053b6:	f3e50513          	addi	a0,a0,-194 # ffffffffc020d2f0 <CSWTCH.79+0x48>
ffffffffc02053ba:	8e4fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02053be <iobuf_skip.part.0>:
ffffffffc02053be:	1141                	addi	sp,sp,-16
ffffffffc02053c0:	00008697          	auipc	a3,0x8
ffffffffc02053c4:	f8868693          	addi	a3,a3,-120 # ffffffffc020d348 <CSWTCH.79+0xa0>
ffffffffc02053c8:	00006617          	auipc	a2,0x6
ffffffffc02053cc:	4d060613          	addi	a2,a2,1232 # ffffffffc020b898 <commands+0x210>
ffffffffc02053d0:	04a00593          	li	a1,74
ffffffffc02053d4:	00008517          	auipc	a0,0x8
ffffffffc02053d8:	f8c50513          	addi	a0,a0,-116 # ffffffffc020d360 <CSWTCH.79+0xb8>
ffffffffc02053dc:	e406                	sd	ra,8(sp)
ffffffffc02053de:	8c0fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02053e2 <iobuf_init>:
ffffffffc02053e2:	e10c                	sd	a1,0(a0)
ffffffffc02053e4:	e514                	sd	a3,8(a0)
ffffffffc02053e6:	ed10                	sd	a2,24(a0)
ffffffffc02053e8:	e910                	sd	a2,16(a0)
ffffffffc02053ea:	8082                	ret

ffffffffc02053ec <iobuf_move>:
ffffffffc02053ec:	7179                	addi	sp,sp,-48
ffffffffc02053ee:	ec26                	sd	s1,24(sp)
ffffffffc02053f0:	6d04                	ld	s1,24(a0)
ffffffffc02053f2:	f022                	sd	s0,32(sp)
ffffffffc02053f4:	e84a                	sd	s2,16(sp)
ffffffffc02053f6:	e44e                	sd	s3,8(sp)
ffffffffc02053f8:	f406                	sd	ra,40(sp)
ffffffffc02053fa:	842a                	mv	s0,a0
ffffffffc02053fc:	8932                	mv	s2,a2
ffffffffc02053fe:	852e                	mv	a0,a1
ffffffffc0205400:	89ba                	mv	s3,a4
ffffffffc0205402:	00967363          	bgeu	a2,s1,ffffffffc0205408 <iobuf_move+0x1c>
ffffffffc0205406:	84b2                	mv	s1,a2
ffffffffc0205408:	c495                	beqz	s1,ffffffffc0205434 <iobuf_move+0x48>
ffffffffc020540a:	600c                	ld	a1,0(s0)
ffffffffc020540c:	c681                	beqz	a3,ffffffffc0205414 <iobuf_move+0x28>
ffffffffc020540e:	87ae                	mv	a5,a1
ffffffffc0205410:	85aa                	mv	a1,a0
ffffffffc0205412:	853e                	mv	a0,a5
ffffffffc0205414:	8626                	mv	a2,s1
ffffffffc0205416:	7b3050ef          	jal	ra,ffffffffc020b3c8 <memmove>
ffffffffc020541a:	6c1c                	ld	a5,24(s0)
ffffffffc020541c:	0297ea63          	bltu	a5,s1,ffffffffc0205450 <iobuf_move+0x64>
ffffffffc0205420:	6014                	ld	a3,0(s0)
ffffffffc0205422:	6418                	ld	a4,8(s0)
ffffffffc0205424:	8f85                	sub	a5,a5,s1
ffffffffc0205426:	96a6                	add	a3,a3,s1
ffffffffc0205428:	9726                	add	a4,a4,s1
ffffffffc020542a:	e014                	sd	a3,0(s0)
ffffffffc020542c:	e418                	sd	a4,8(s0)
ffffffffc020542e:	ec1c                	sd	a5,24(s0)
ffffffffc0205430:	40990933          	sub	s2,s2,s1
ffffffffc0205434:	00098463          	beqz	s3,ffffffffc020543c <iobuf_move+0x50>
ffffffffc0205438:	0099b023          	sd	s1,0(s3)
ffffffffc020543c:	4501                	li	a0,0
ffffffffc020543e:	00091b63          	bnez	s2,ffffffffc0205454 <iobuf_move+0x68>
ffffffffc0205442:	70a2                	ld	ra,40(sp)
ffffffffc0205444:	7402                	ld	s0,32(sp)
ffffffffc0205446:	64e2                	ld	s1,24(sp)
ffffffffc0205448:	6942                	ld	s2,16(sp)
ffffffffc020544a:	69a2                	ld	s3,8(sp)
ffffffffc020544c:	6145                	addi	sp,sp,48
ffffffffc020544e:	8082                	ret
ffffffffc0205450:	f6fff0ef          	jal	ra,ffffffffc02053be <iobuf_skip.part.0>
ffffffffc0205454:	5571                	li	a0,-4
ffffffffc0205456:	b7f5                	j	ffffffffc0205442 <iobuf_move+0x56>

ffffffffc0205458 <iobuf_skip>:
ffffffffc0205458:	6d1c                	ld	a5,24(a0)
ffffffffc020545a:	00b7eb63          	bltu	a5,a1,ffffffffc0205470 <iobuf_skip+0x18>
ffffffffc020545e:	6114                	ld	a3,0(a0)
ffffffffc0205460:	6518                	ld	a4,8(a0)
ffffffffc0205462:	8f8d                	sub	a5,a5,a1
ffffffffc0205464:	96ae                	add	a3,a3,a1
ffffffffc0205466:	95ba                	add	a1,a1,a4
ffffffffc0205468:	e114                	sd	a3,0(a0)
ffffffffc020546a:	e50c                	sd	a1,8(a0)
ffffffffc020546c:	ed1c                	sd	a5,24(a0)
ffffffffc020546e:	8082                	ret
ffffffffc0205470:	1141                	addi	sp,sp,-16
ffffffffc0205472:	e406                	sd	ra,8(sp)
ffffffffc0205474:	f4bff0ef          	jal	ra,ffffffffc02053be <iobuf_skip.part.0>

ffffffffc0205478 <copy_path>:
ffffffffc0205478:	7139                	addi	sp,sp,-64
ffffffffc020547a:	f04a                	sd	s2,32(sp)
ffffffffc020547c:	00091917          	auipc	s2,0x91
ffffffffc0205480:	44490913          	addi	s2,s2,1092 # ffffffffc02968c0 <current>
ffffffffc0205484:	00093703          	ld	a4,0(s2)
ffffffffc0205488:	ec4e                	sd	s3,24(sp)
ffffffffc020548a:	89aa                	mv	s3,a0
ffffffffc020548c:	6505                	lui	a0,0x1
ffffffffc020548e:	f426                	sd	s1,40(sp)
ffffffffc0205490:	e852                	sd	s4,16(sp)
ffffffffc0205492:	fc06                	sd	ra,56(sp)
ffffffffc0205494:	f822                	sd	s0,48(sp)
ffffffffc0205496:	e456                	sd	s5,8(sp)
ffffffffc0205498:	02873a03          	ld	s4,40(a4)
ffffffffc020549c:	84ae                	mv	s1,a1
ffffffffc020549e:	af1fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02054a2:	c141                	beqz	a0,ffffffffc0205522 <copy_path+0xaa>
ffffffffc02054a4:	842a                	mv	s0,a0
ffffffffc02054a6:	040a0563          	beqz	s4,ffffffffc02054f0 <copy_path+0x78>
ffffffffc02054aa:	038a0a93          	addi	s5,s4,56
ffffffffc02054ae:	8556                	mv	a0,s5
ffffffffc02054b0:	8b4ff0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc02054b4:	00093783          	ld	a5,0(s2)
ffffffffc02054b8:	cba1                	beqz	a5,ffffffffc0205508 <copy_path+0x90>
ffffffffc02054ba:	43dc                	lw	a5,4(a5)
ffffffffc02054bc:	6685                	lui	a3,0x1
ffffffffc02054be:	8626                	mv	a2,s1
ffffffffc02054c0:	04fa2823          	sw	a5,80(s4)
ffffffffc02054c4:	85a2                	mv	a1,s0
ffffffffc02054c6:	8552                	mv	a0,s4
ffffffffc02054c8:	ec5fe0ef          	jal	ra,ffffffffc020438c <copy_string>
ffffffffc02054cc:	c529                	beqz	a0,ffffffffc0205516 <copy_path+0x9e>
ffffffffc02054ce:	8556                	mv	a0,s5
ffffffffc02054d0:	890ff0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc02054d4:	040a2823          	sw	zero,80(s4)
ffffffffc02054d8:	0089b023          	sd	s0,0(s3)
ffffffffc02054dc:	4501                	li	a0,0
ffffffffc02054de:	70e2                	ld	ra,56(sp)
ffffffffc02054e0:	7442                	ld	s0,48(sp)
ffffffffc02054e2:	74a2                	ld	s1,40(sp)
ffffffffc02054e4:	7902                	ld	s2,32(sp)
ffffffffc02054e6:	69e2                	ld	s3,24(sp)
ffffffffc02054e8:	6a42                	ld	s4,16(sp)
ffffffffc02054ea:	6aa2                	ld	s5,8(sp)
ffffffffc02054ec:	6121                	addi	sp,sp,64
ffffffffc02054ee:	8082                	ret
ffffffffc02054f0:	85aa                	mv	a1,a0
ffffffffc02054f2:	6685                	lui	a3,0x1
ffffffffc02054f4:	8626                	mv	a2,s1
ffffffffc02054f6:	4501                	li	a0,0
ffffffffc02054f8:	e95fe0ef          	jal	ra,ffffffffc020438c <copy_string>
ffffffffc02054fc:	fd71                	bnez	a0,ffffffffc02054d8 <copy_path+0x60>
ffffffffc02054fe:	8522                	mv	a0,s0
ffffffffc0205500:	b3ffc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205504:	5575                	li	a0,-3
ffffffffc0205506:	bfe1                	j	ffffffffc02054de <copy_path+0x66>
ffffffffc0205508:	6685                	lui	a3,0x1
ffffffffc020550a:	8626                	mv	a2,s1
ffffffffc020550c:	85a2                	mv	a1,s0
ffffffffc020550e:	8552                	mv	a0,s4
ffffffffc0205510:	e7dfe0ef          	jal	ra,ffffffffc020438c <copy_string>
ffffffffc0205514:	fd4d                	bnez	a0,ffffffffc02054ce <copy_path+0x56>
ffffffffc0205516:	8556                	mv	a0,s5
ffffffffc0205518:	848ff0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020551c:	040a2823          	sw	zero,80(s4)
ffffffffc0205520:	bff9                	j	ffffffffc02054fe <copy_path+0x86>
ffffffffc0205522:	5571                	li	a0,-4
ffffffffc0205524:	bf6d                	j	ffffffffc02054de <copy_path+0x66>

ffffffffc0205526 <sysfile_open>:
ffffffffc0205526:	7179                	addi	sp,sp,-48
ffffffffc0205528:	872a                	mv	a4,a0
ffffffffc020552a:	ec26                	sd	s1,24(sp)
ffffffffc020552c:	0028                	addi	a0,sp,8
ffffffffc020552e:	84ae                	mv	s1,a1
ffffffffc0205530:	85ba                	mv	a1,a4
ffffffffc0205532:	f022                	sd	s0,32(sp)
ffffffffc0205534:	f406                	sd	ra,40(sp)
ffffffffc0205536:	f43ff0ef          	jal	ra,ffffffffc0205478 <copy_path>
ffffffffc020553a:	842a                	mv	s0,a0
ffffffffc020553c:	e909                	bnez	a0,ffffffffc020554e <sysfile_open+0x28>
ffffffffc020553e:	6522                	ld	a0,8(sp)
ffffffffc0205540:	85a6                	mv	a1,s1
ffffffffc0205542:	d60ff0ef          	jal	ra,ffffffffc0204aa2 <file_open>
ffffffffc0205546:	842a                	mv	s0,a0
ffffffffc0205548:	6522                	ld	a0,8(sp)
ffffffffc020554a:	af5fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020554e:	70a2                	ld	ra,40(sp)
ffffffffc0205550:	8522                	mv	a0,s0
ffffffffc0205552:	7402                	ld	s0,32(sp)
ffffffffc0205554:	64e2                	ld	s1,24(sp)
ffffffffc0205556:	6145                	addi	sp,sp,48
ffffffffc0205558:	8082                	ret

ffffffffc020555a <sysfile_close>:
ffffffffc020555a:	e46ff06f          	j	ffffffffc0204ba0 <file_close>

ffffffffc020555e <sysfile_read>:
ffffffffc020555e:	7159                	addi	sp,sp,-112
ffffffffc0205560:	f0a2                	sd	s0,96(sp)
ffffffffc0205562:	f486                	sd	ra,104(sp)
ffffffffc0205564:	eca6                	sd	s1,88(sp)
ffffffffc0205566:	e8ca                	sd	s2,80(sp)
ffffffffc0205568:	e4ce                	sd	s3,72(sp)
ffffffffc020556a:	e0d2                	sd	s4,64(sp)
ffffffffc020556c:	fc56                	sd	s5,56(sp)
ffffffffc020556e:	f85a                	sd	s6,48(sp)
ffffffffc0205570:	f45e                	sd	s7,40(sp)
ffffffffc0205572:	f062                	sd	s8,32(sp)
ffffffffc0205574:	ec66                	sd	s9,24(sp)
ffffffffc0205576:	4401                	li	s0,0
ffffffffc0205578:	ee19                	bnez	a2,ffffffffc0205596 <sysfile_read+0x38>
ffffffffc020557a:	70a6                	ld	ra,104(sp)
ffffffffc020557c:	8522                	mv	a0,s0
ffffffffc020557e:	7406                	ld	s0,96(sp)
ffffffffc0205580:	64e6                	ld	s1,88(sp)
ffffffffc0205582:	6946                	ld	s2,80(sp)
ffffffffc0205584:	69a6                	ld	s3,72(sp)
ffffffffc0205586:	6a06                	ld	s4,64(sp)
ffffffffc0205588:	7ae2                	ld	s5,56(sp)
ffffffffc020558a:	7b42                	ld	s6,48(sp)
ffffffffc020558c:	7ba2                	ld	s7,40(sp)
ffffffffc020558e:	7c02                	ld	s8,32(sp)
ffffffffc0205590:	6ce2                	ld	s9,24(sp)
ffffffffc0205592:	6165                	addi	sp,sp,112
ffffffffc0205594:	8082                	ret
ffffffffc0205596:	00091c97          	auipc	s9,0x91
ffffffffc020559a:	32ac8c93          	addi	s9,s9,810 # ffffffffc02968c0 <current>
ffffffffc020559e:	000cb783          	ld	a5,0(s9)
ffffffffc02055a2:	84b2                	mv	s1,a2
ffffffffc02055a4:	8b2e                	mv	s6,a1
ffffffffc02055a6:	4601                	li	a2,0
ffffffffc02055a8:	4585                	li	a1,1
ffffffffc02055aa:	0287b903          	ld	s2,40(a5)
ffffffffc02055ae:	8aaa                	mv	s5,a0
ffffffffc02055b0:	c9eff0ef          	jal	ra,ffffffffc0204a4e <file_testfd>
ffffffffc02055b4:	c959                	beqz	a0,ffffffffc020564a <sysfile_read+0xec>
ffffffffc02055b6:	6505                	lui	a0,0x1
ffffffffc02055b8:	9d7fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02055bc:	89aa                	mv	s3,a0
ffffffffc02055be:	c941                	beqz	a0,ffffffffc020564e <sysfile_read+0xf0>
ffffffffc02055c0:	4b81                	li	s7,0
ffffffffc02055c2:	6a05                	lui	s4,0x1
ffffffffc02055c4:	03890c13          	addi	s8,s2,56
ffffffffc02055c8:	0744ec63          	bltu	s1,s4,ffffffffc0205640 <sysfile_read+0xe2>
ffffffffc02055cc:	e452                	sd	s4,8(sp)
ffffffffc02055ce:	6605                	lui	a2,0x1
ffffffffc02055d0:	0034                	addi	a3,sp,8
ffffffffc02055d2:	85ce                	mv	a1,s3
ffffffffc02055d4:	8556                	mv	a0,s5
ffffffffc02055d6:	e20ff0ef          	jal	ra,ffffffffc0204bf6 <file_read>
ffffffffc02055da:	66a2                	ld	a3,8(sp)
ffffffffc02055dc:	842a                	mv	s0,a0
ffffffffc02055de:	ca9d                	beqz	a3,ffffffffc0205614 <sysfile_read+0xb6>
ffffffffc02055e0:	00090c63          	beqz	s2,ffffffffc02055f8 <sysfile_read+0x9a>
ffffffffc02055e4:	8562                	mv	a0,s8
ffffffffc02055e6:	f7ffe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc02055ea:	000cb783          	ld	a5,0(s9)
ffffffffc02055ee:	cfa1                	beqz	a5,ffffffffc0205646 <sysfile_read+0xe8>
ffffffffc02055f0:	43dc                	lw	a5,4(a5)
ffffffffc02055f2:	66a2                	ld	a3,8(sp)
ffffffffc02055f4:	04f92823          	sw	a5,80(s2)
ffffffffc02055f8:	864e                	mv	a2,s3
ffffffffc02055fa:	85da                	mv	a1,s6
ffffffffc02055fc:	854a                	mv	a0,s2
ffffffffc02055fe:	d5dfe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc0205602:	c50d                	beqz	a0,ffffffffc020562c <sysfile_read+0xce>
ffffffffc0205604:	67a2                	ld	a5,8(sp)
ffffffffc0205606:	04f4e663          	bltu	s1,a5,ffffffffc0205652 <sysfile_read+0xf4>
ffffffffc020560a:	9b3e                	add	s6,s6,a5
ffffffffc020560c:	8c9d                	sub	s1,s1,a5
ffffffffc020560e:	9bbe                	add	s7,s7,a5
ffffffffc0205610:	02091263          	bnez	s2,ffffffffc0205634 <sysfile_read+0xd6>
ffffffffc0205614:	e401                	bnez	s0,ffffffffc020561c <sysfile_read+0xbe>
ffffffffc0205616:	67a2                	ld	a5,8(sp)
ffffffffc0205618:	c391                	beqz	a5,ffffffffc020561c <sysfile_read+0xbe>
ffffffffc020561a:	f4dd                	bnez	s1,ffffffffc02055c8 <sysfile_read+0x6a>
ffffffffc020561c:	854e                	mv	a0,s3
ffffffffc020561e:	a21fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205622:	f40b8ce3          	beqz	s7,ffffffffc020557a <sysfile_read+0x1c>
ffffffffc0205626:	000b841b          	sext.w	s0,s7
ffffffffc020562a:	bf81                	j	ffffffffc020557a <sysfile_read+0x1c>
ffffffffc020562c:	e011                	bnez	s0,ffffffffc0205630 <sysfile_read+0xd2>
ffffffffc020562e:	5475                	li	s0,-3
ffffffffc0205630:	fe0906e3          	beqz	s2,ffffffffc020561c <sysfile_read+0xbe>
ffffffffc0205634:	8562                	mv	a0,s8
ffffffffc0205636:	f2bfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020563a:	04092823          	sw	zero,80(s2)
ffffffffc020563e:	bfd9                	j	ffffffffc0205614 <sysfile_read+0xb6>
ffffffffc0205640:	e426                	sd	s1,8(sp)
ffffffffc0205642:	8626                	mv	a2,s1
ffffffffc0205644:	b771                	j	ffffffffc02055d0 <sysfile_read+0x72>
ffffffffc0205646:	66a2                	ld	a3,8(sp)
ffffffffc0205648:	bf45                	j	ffffffffc02055f8 <sysfile_read+0x9a>
ffffffffc020564a:	5475                	li	s0,-3
ffffffffc020564c:	b73d                	j	ffffffffc020557a <sysfile_read+0x1c>
ffffffffc020564e:	5471                	li	s0,-4
ffffffffc0205650:	b72d                	j	ffffffffc020557a <sysfile_read+0x1c>
ffffffffc0205652:	00008697          	auipc	a3,0x8
ffffffffc0205656:	d1e68693          	addi	a3,a3,-738 # ffffffffc020d370 <CSWTCH.79+0xc8>
ffffffffc020565a:	00006617          	auipc	a2,0x6
ffffffffc020565e:	23e60613          	addi	a2,a2,574 # ffffffffc020b898 <commands+0x210>
ffffffffc0205662:	05500593          	li	a1,85
ffffffffc0205666:	00008517          	auipc	a0,0x8
ffffffffc020566a:	d1a50513          	addi	a0,a0,-742 # ffffffffc020d380 <CSWTCH.79+0xd8>
ffffffffc020566e:	e31fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205672 <sysfile_write>:
ffffffffc0205672:	7159                	addi	sp,sp,-112
ffffffffc0205674:	e8ca                	sd	s2,80(sp)
ffffffffc0205676:	f486                	sd	ra,104(sp)
ffffffffc0205678:	f0a2                	sd	s0,96(sp)
ffffffffc020567a:	eca6                	sd	s1,88(sp)
ffffffffc020567c:	e4ce                	sd	s3,72(sp)
ffffffffc020567e:	e0d2                	sd	s4,64(sp)
ffffffffc0205680:	fc56                	sd	s5,56(sp)
ffffffffc0205682:	f85a                	sd	s6,48(sp)
ffffffffc0205684:	f45e                	sd	s7,40(sp)
ffffffffc0205686:	f062                	sd	s8,32(sp)
ffffffffc0205688:	ec66                	sd	s9,24(sp)
ffffffffc020568a:	4901                	li	s2,0
ffffffffc020568c:	ee19                	bnez	a2,ffffffffc02056aa <sysfile_write+0x38>
ffffffffc020568e:	70a6                	ld	ra,104(sp)
ffffffffc0205690:	7406                	ld	s0,96(sp)
ffffffffc0205692:	64e6                	ld	s1,88(sp)
ffffffffc0205694:	69a6                	ld	s3,72(sp)
ffffffffc0205696:	6a06                	ld	s4,64(sp)
ffffffffc0205698:	7ae2                	ld	s5,56(sp)
ffffffffc020569a:	7b42                	ld	s6,48(sp)
ffffffffc020569c:	7ba2                	ld	s7,40(sp)
ffffffffc020569e:	7c02                	ld	s8,32(sp)
ffffffffc02056a0:	6ce2                	ld	s9,24(sp)
ffffffffc02056a2:	854a                	mv	a0,s2
ffffffffc02056a4:	6946                	ld	s2,80(sp)
ffffffffc02056a6:	6165                	addi	sp,sp,112
ffffffffc02056a8:	8082                	ret
ffffffffc02056aa:	00091c17          	auipc	s8,0x91
ffffffffc02056ae:	216c0c13          	addi	s8,s8,534 # ffffffffc02968c0 <current>
ffffffffc02056b2:	000c3783          	ld	a5,0(s8)
ffffffffc02056b6:	8432                	mv	s0,a2
ffffffffc02056b8:	89ae                	mv	s3,a1
ffffffffc02056ba:	4605                	li	a2,1
ffffffffc02056bc:	4581                	li	a1,0
ffffffffc02056be:	7784                	ld	s1,40(a5)
ffffffffc02056c0:	8baa                	mv	s7,a0
ffffffffc02056c2:	b8cff0ef          	jal	ra,ffffffffc0204a4e <file_testfd>
ffffffffc02056c6:	cd59                	beqz	a0,ffffffffc0205764 <sysfile_write+0xf2>
ffffffffc02056c8:	6505                	lui	a0,0x1
ffffffffc02056ca:	8c5fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02056ce:	8a2a                	mv	s4,a0
ffffffffc02056d0:	cd41                	beqz	a0,ffffffffc0205768 <sysfile_write+0xf6>
ffffffffc02056d2:	4c81                	li	s9,0
ffffffffc02056d4:	6a85                	lui	s5,0x1
ffffffffc02056d6:	03848b13          	addi	s6,s1,56
ffffffffc02056da:	05546a63          	bltu	s0,s5,ffffffffc020572e <sysfile_write+0xbc>
ffffffffc02056de:	e456                	sd	s5,8(sp)
ffffffffc02056e0:	c8a9                	beqz	s1,ffffffffc0205732 <sysfile_write+0xc0>
ffffffffc02056e2:	855a                	mv	a0,s6
ffffffffc02056e4:	e81fe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc02056e8:	000c3783          	ld	a5,0(s8)
ffffffffc02056ec:	c399                	beqz	a5,ffffffffc02056f2 <sysfile_write+0x80>
ffffffffc02056ee:	43dc                	lw	a5,4(a5)
ffffffffc02056f0:	c8bc                	sw	a5,80(s1)
ffffffffc02056f2:	66a2                	ld	a3,8(sp)
ffffffffc02056f4:	4701                	li	a4,0
ffffffffc02056f6:	864e                	mv	a2,s3
ffffffffc02056f8:	85d2                	mv	a1,s4
ffffffffc02056fa:	8526                	mv	a0,s1
ffffffffc02056fc:	c2bfe0ef          	jal	ra,ffffffffc0204326 <copy_from_user>
ffffffffc0205700:	c139                	beqz	a0,ffffffffc0205746 <sysfile_write+0xd4>
ffffffffc0205702:	855a                	mv	a0,s6
ffffffffc0205704:	e5dfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205708:	0404a823          	sw	zero,80(s1)
ffffffffc020570c:	6622                	ld	a2,8(sp)
ffffffffc020570e:	0034                	addi	a3,sp,8
ffffffffc0205710:	85d2                	mv	a1,s4
ffffffffc0205712:	855e                	mv	a0,s7
ffffffffc0205714:	dc8ff0ef          	jal	ra,ffffffffc0204cdc <file_write>
ffffffffc0205718:	67a2                	ld	a5,8(sp)
ffffffffc020571a:	892a                	mv	s2,a0
ffffffffc020571c:	ef85                	bnez	a5,ffffffffc0205754 <sysfile_write+0xe2>
ffffffffc020571e:	8552                	mv	a0,s4
ffffffffc0205720:	91ffc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205724:	f60c85e3          	beqz	s9,ffffffffc020568e <sysfile_write+0x1c>
ffffffffc0205728:	000c891b          	sext.w	s2,s9
ffffffffc020572c:	b78d                	j	ffffffffc020568e <sysfile_write+0x1c>
ffffffffc020572e:	e422                	sd	s0,8(sp)
ffffffffc0205730:	f8cd                	bnez	s1,ffffffffc02056e2 <sysfile_write+0x70>
ffffffffc0205732:	66a2                	ld	a3,8(sp)
ffffffffc0205734:	4701                	li	a4,0
ffffffffc0205736:	864e                	mv	a2,s3
ffffffffc0205738:	85d2                	mv	a1,s4
ffffffffc020573a:	4501                	li	a0,0
ffffffffc020573c:	bebfe0ef          	jal	ra,ffffffffc0204326 <copy_from_user>
ffffffffc0205740:	f571                	bnez	a0,ffffffffc020570c <sysfile_write+0x9a>
ffffffffc0205742:	5975                	li	s2,-3
ffffffffc0205744:	bfe9                	j	ffffffffc020571e <sysfile_write+0xac>
ffffffffc0205746:	855a                	mv	a0,s6
ffffffffc0205748:	e19fe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020574c:	5975                	li	s2,-3
ffffffffc020574e:	0404a823          	sw	zero,80(s1)
ffffffffc0205752:	b7f1                	j	ffffffffc020571e <sysfile_write+0xac>
ffffffffc0205754:	00f46c63          	bltu	s0,a5,ffffffffc020576c <sysfile_write+0xfa>
ffffffffc0205758:	99be                	add	s3,s3,a5
ffffffffc020575a:	8c1d                	sub	s0,s0,a5
ffffffffc020575c:	9cbe                	add	s9,s9,a5
ffffffffc020575e:	f161                	bnez	a0,ffffffffc020571e <sysfile_write+0xac>
ffffffffc0205760:	fc2d                	bnez	s0,ffffffffc02056da <sysfile_write+0x68>
ffffffffc0205762:	bf75                	j	ffffffffc020571e <sysfile_write+0xac>
ffffffffc0205764:	5975                	li	s2,-3
ffffffffc0205766:	b725                	j	ffffffffc020568e <sysfile_write+0x1c>
ffffffffc0205768:	5971                	li	s2,-4
ffffffffc020576a:	b715                	j	ffffffffc020568e <sysfile_write+0x1c>
ffffffffc020576c:	00008697          	auipc	a3,0x8
ffffffffc0205770:	c0468693          	addi	a3,a3,-1020 # ffffffffc020d370 <CSWTCH.79+0xc8>
ffffffffc0205774:	00006617          	auipc	a2,0x6
ffffffffc0205778:	12460613          	addi	a2,a2,292 # ffffffffc020b898 <commands+0x210>
ffffffffc020577c:	08a00593          	li	a1,138
ffffffffc0205780:	00008517          	auipc	a0,0x8
ffffffffc0205784:	c0050513          	addi	a0,a0,-1024 # ffffffffc020d380 <CSWTCH.79+0xd8>
ffffffffc0205788:	d17fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020578c <sysfile_seek>:
ffffffffc020578c:	e36ff06f          	j	ffffffffc0204dc2 <file_seek>

ffffffffc0205790 <sysfile_fstat>:
ffffffffc0205790:	715d                	addi	sp,sp,-80
ffffffffc0205792:	f44e                	sd	s3,40(sp)
ffffffffc0205794:	00091997          	auipc	s3,0x91
ffffffffc0205798:	12c98993          	addi	s3,s3,300 # ffffffffc02968c0 <current>
ffffffffc020579c:	0009b703          	ld	a4,0(s3)
ffffffffc02057a0:	fc26                	sd	s1,56(sp)
ffffffffc02057a2:	84ae                	mv	s1,a1
ffffffffc02057a4:	858a                	mv	a1,sp
ffffffffc02057a6:	e0a2                	sd	s0,64(sp)
ffffffffc02057a8:	f84a                	sd	s2,48(sp)
ffffffffc02057aa:	e486                	sd	ra,72(sp)
ffffffffc02057ac:	02873903          	ld	s2,40(a4)
ffffffffc02057b0:	f052                	sd	s4,32(sp)
ffffffffc02057b2:	f30ff0ef          	jal	ra,ffffffffc0204ee2 <file_fstat>
ffffffffc02057b6:	842a                	mv	s0,a0
ffffffffc02057b8:	e91d                	bnez	a0,ffffffffc02057ee <sysfile_fstat+0x5e>
ffffffffc02057ba:	04090363          	beqz	s2,ffffffffc0205800 <sysfile_fstat+0x70>
ffffffffc02057be:	03890a13          	addi	s4,s2,56
ffffffffc02057c2:	8552                	mv	a0,s4
ffffffffc02057c4:	da1fe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc02057c8:	0009b783          	ld	a5,0(s3)
ffffffffc02057cc:	c3b9                	beqz	a5,ffffffffc0205812 <sysfile_fstat+0x82>
ffffffffc02057ce:	43dc                	lw	a5,4(a5)
ffffffffc02057d0:	02000693          	li	a3,32
ffffffffc02057d4:	860a                	mv	a2,sp
ffffffffc02057d6:	04f92823          	sw	a5,80(s2)
ffffffffc02057da:	85a6                	mv	a1,s1
ffffffffc02057dc:	854a                	mv	a0,s2
ffffffffc02057de:	b7dfe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc02057e2:	c121                	beqz	a0,ffffffffc0205822 <sysfile_fstat+0x92>
ffffffffc02057e4:	8552                	mv	a0,s4
ffffffffc02057e6:	d7bfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc02057ea:	04092823          	sw	zero,80(s2)
ffffffffc02057ee:	60a6                	ld	ra,72(sp)
ffffffffc02057f0:	8522                	mv	a0,s0
ffffffffc02057f2:	6406                	ld	s0,64(sp)
ffffffffc02057f4:	74e2                	ld	s1,56(sp)
ffffffffc02057f6:	7942                	ld	s2,48(sp)
ffffffffc02057f8:	79a2                	ld	s3,40(sp)
ffffffffc02057fa:	7a02                	ld	s4,32(sp)
ffffffffc02057fc:	6161                	addi	sp,sp,80
ffffffffc02057fe:	8082                	ret
ffffffffc0205800:	02000693          	li	a3,32
ffffffffc0205804:	860a                	mv	a2,sp
ffffffffc0205806:	85a6                	mv	a1,s1
ffffffffc0205808:	b53fe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc020580c:	f16d                	bnez	a0,ffffffffc02057ee <sysfile_fstat+0x5e>
ffffffffc020580e:	5475                	li	s0,-3
ffffffffc0205810:	bff9                	j	ffffffffc02057ee <sysfile_fstat+0x5e>
ffffffffc0205812:	02000693          	li	a3,32
ffffffffc0205816:	860a                	mv	a2,sp
ffffffffc0205818:	85a6                	mv	a1,s1
ffffffffc020581a:	854a                	mv	a0,s2
ffffffffc020581c:	b3ffe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc0205820:	f171                	bnez	a0,ffffffffc02057e4 <sysfile_fstat+0x54>
ffffffffc0205822:	8552                	mv	a0,s4
ffffffffc0205824:	d3dfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205828:	5475                	li	s0,-3
ffffffffc020582a:	04092823          	sw	zero,80(s2)
ffffffffc020582e:	b7c1                	j	ffffffffc02057ee <sysfile_fstat+0x5e>

ffffffffc0205830 <sysfile_fsync>:
ffffffffc0205830:	f72ff06f          	j	ffffffffc0204fa2 <file_fsync>

ffffffffc0205834 <sysfile_getcwd>:
ffffffffc0205834:	715d                	addi	sp,sp,-80
ffffffffc0205836:	f44e                	sd	s3,40(sp)
ffffffffc0205838:	00091997          	auipc	s3,0x91
ffffffffc020583c:	08898993          	addi	s3,s3,136 # ffffffffc02968c0 <current>
ffffffffc0205840:	0009b783          	ld	a5,0(s3)
ffffffffc0205844:	f84a                	sd	s2,48(sp)
ffffffffc0205846:	e486                	sd	ra,72(sp)
ffffffffc0205848:	e0a2                	sd	s0,64(sp)
ffffffffc020584a:	fc26                	sd	s1,56(sp)
ffffffffc020584c:	f052                	sd	s4,32(sp)
ffffffffc020584e:	0287b903          	ld	s2,40(a5)
ffffffffc0205852:	cda9                	beqz	a1,ffffffffc02058ac <sysfile_getcwd+0x78>
ffffffffc0205854:	842e                	mv	s0,a1
ffffffffc0205856:	84aa                	mv	s1,a0
ffffffffc0205858:	04090363          	beqz	s2,ffffffffc020589e <sysfile_getcwd+0x6a>
ffffffffc020585c:	03890a13          	addi	s4,s2,56
ffffffffc0205860:	8552                	mv	a0,s4
ffffffffc0205862:	d03fe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0205866:	0009b783          	ld	a5,0(s3)
ffffffffc020586a:	c781                	beqz	a5,ffffffffc0205872 <sysfile_getcwd+0x3e>
ffffffffc020586c:	43dc                	lw	a5,4(a5)
ffffffffc020586e:	04f92823          	sw	a5,80(s2)
ffffffffc0205872:	4685                	li	a3,1
ffffffffc0205874:	8622                	mv	a2,s0
ffffffffc0205876:	85a6                	mv	a1,s1
ffffffffc0205878:	854a                	mv	a0,s2
ffffffffc020587a:	a19fe0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc020587e:	e90d                	bnez	a0,ffffffffc02058b0 <sysfile_getcwd+0x7c>
ffffffffc0205880:	5475                	li	s0,-3
ffffffffc0205882:	8552                	mv	a0,s4
ffffffffc0205884:	cddfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205888:	04092823          	sw	zero,80(s2)
ffffffffc020588c:	60a6                	ld	ra,72(sp)
ffffffffc020588e:	8522                	mv	a0,s0
ffffffffc0205890:	6406                	ld	s0,64(sp)
ffffffffc0205892:	74e2                	ld	s1,56(sp)
ffffffffc0205894:	7942                	ld	s2,48(sp)
ffffffffc0205896:	79a2                	ld	s3,40(sp)
ffffffffc0205898:	7a02                	ld	s4,32(sp)
ffffffffc020589a:	6161                	addi	sp,sp,80
ffffffffc020589c:	8082                	ret
ffffffffc020589e:	862e                	mv	a2,a1
ffffffffc02058a0:	4685                	li	a3,1
ffffffffc02058a2:	85aa                	mv	a1,a0
ffffffffc02058a4:	4501                	li	a0,0
ffffffffc02058a6:	9edfe0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc02058aa:	ed09                	bnez	a0,ffffffffc02058c4 <sysfile_getcwd+0x90>
ffffffffc02058ac:	5475                	li	s0,-3
ffffffffc02058ae:	bff9                	j	ffffffffc020588c <sysfile_getcwd+0x58>
ffffffffc02058b0:	8622                	mv	a2,s0
ffffffffc02058b2:	4681                	li	a3,0
ffffffffc02058b4:	85a6                	mv	a1,s1
ffffffffc02058b6:	850a                	mv	a0,sp
ffffffffc02058b8:	b2bff0ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc02058bc:	27f020ef          	jal	ra,ffffffffc020833a <vfs_getcwd>
ffffffffc02058c0:	842a                	mv	s0,a0
ffffffffc02058c2:	b7c1                	j	ffffffffc0205882 <sysfile_getcwd+0x4e>
ffffffffc02058c4:	8622                	mv	a2,s0
ffffffffc02058c6:	4681                	li	a3,0
ffffffffc02058c8:	85a6                	mv	a1,s1
ffffffffc02058ca:	850a                	mv	a0,sp
ffffffffc02058cc:	b17ff0ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc02058d0:	26b020ef          	jal	ra,ffffffffc020833a <vfs_getcwd>
ffffffffc02058d4:	842a                	mv	s0,a0
ffffffffc02058d6:	bf5d                	j	ffffffffc020588c <sysfile_getcwd+0x58>

ffffffffc02058d8 <sysfile_getdirentry>:
ffffffffc02058d8:	7139                	addi	sp,sp,-64
ffffffffc02058da:	e852                	sd	s4,16(sp)
ffffffffc02058dc:	00091a17          	auipc	s4,0x91
ffffffffc02058e0:	fe4a0a13          	addi	s4,s4,-28 # ffffffffc02968c0 <current>
ffffffffc02058e4:	000a3703          	ld	a4,0(s4)
ffffffffc02058e8:	ec4e                	sd	s3,24(sp)
ffffffffc02058ea:	89aa                	mv	s3,a0
ffffffffc02058ec:	10800513          	li	a0,264
ffffffffc02058f0:	f426                	sd	s1,40(sp)
ffffffffc02058f2:	f04a                	sd	s2,32(sp)
ffffffffc02058f4:	fc06                	sd	ra,56(sp)
ffffffffc02058f6:	f822                	sd	s0,48(sp)
ffffffffc02058f8:	e456                	sd	s5,8(sp)
ffffffffc02058fa:	7704                	ld	s1,40(a4)
ffffffffc02058fc:	892e                	mv	s2,a1
ffffffffc02058fe:	e90fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205902:	c169                	beqz	a0,ffffffffc02059c4 <sysfile_getdirentry+0xec>
ffffffffc0205904:	842a                	mv	s0,a0
ffffffffc0205906:	c8c1                	beqz	s1,ffffffffc0205996 <sysfile_getdirentry+0xbe>
ffffffffc0205908:	03848a93          	addi	s5,s1,56
ffffffffc020590c:	8556                	mv	a0,s5
ffffffffc020590e:	c57fe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0205912:	000a3783          	ld	a5,0(s4)
ffffffffc0205916:	c399                	beqz	a5,ffffffffc020591c <sysfile_getdirentry+0x44>
ffffffffc0205918:	43dc                	lw	a5,4(a5)
ffffffffc020591a:	c8bc                	sw	a5,80(s1)
ffffffffc020591c:	4705                	li	a4,1
ffffffffc020591e:	46a1                	li	a3,8
ffffffffc0205920:	864a                	mv	a2,s2
ffffffffc0205922:	85a2                	mv	a1,s0
ffffffffc0205924:	8526                	mv	a0,s1
ffffffffc0205926:	a01fe0ef          	jal	ra,ffffffffc0204326 <copy_from_user>
ffffffffc020592a:	e505                	bnez	a0,ffffffffc0205952 <sysfile_getdirentry+0x7a>
ffffffffc020592c:	8556                	mv	a0,s5
ffffffffc020592e:	c33fe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205932:	59f5                	li	s3,-3
ffffffffc0205934:	0404a823          	sw	zero,80(s1)
ffffffffc0205938:	8522                	mv	a0,s0
ffffffffc020593a:	f04fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020593e:	70e2                	ld	ra,56(sp)
ffffffffc0205940:	7442                	ld	s0,48(sp)
ffffffffc0205942:	74a2                	ld	s1,40(sp)
ffffffffc0205944:	7902                	ld	s2,32(sp)
ffffffffc0205946:	6a42                	ld	s4,16(sp)
ffffffffc0205948:	6aa2                	ld	s5,8(sp)
ffffffffc020594a:	854e                	mv	a0,s3
ffffffffc020594c:	69e2                	ld	s3,24(sp)
ffffffffc020594e:	6121                	addi	sp,sp,64
ffffffffc0205950:	8082                	ret
ffffffffc0205952:	8556                	mv	a0,s5
ffffffffc0205954:	c0dfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205958:	854e                	mv	a0,s3
ffffffffc020595a:	85a2                	mv	a1,s0
ffffffffc020595c:	0404a823          	sw	zero,80(s1)
ffffffffc0205960:	ef0ff0ef          	jal	ra,ffffffffc0205050 <file_getdirentry>
ffffffffc0205964:	89aa                	mv	s3,a0
ffffffffc0205966:	f969                	bnez	a0,ffffffffc0205938 <sysfile_getdirentry+0x60>
ffffffffc0205968:	8556                	mv	a0,s5
ffffffffc020596a:	bfbfe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020596e:	000a3783          	ld	a5,0(s4)
ffffffffc0205972:	c399                	beqz	a5,ffffffffc0205978 <sysfile_getdirentry+0xa0>
ffffffffc0205974:	43dc                	lw	a5,4(a5)
ffffffffc0205976:	c8bc                	sw	a5,80(s1)
ffffffffc0205978:	10800693          	li	a3,264
ffffffffc020597c:	8622                	mv	a2,s0
ffffffffc020597e:	85ca                	mv	a1,s2
ffffffffc0205980:	8526                	mv	a0,s1
ffffffffc0205982:	9d9fe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc0205986:	e111                	bnez	a0,ffffffffc020598a <sysfile_getdirentry+0xb2>
ffffffffc0205988:	59f5                	li	s3,-3
ffffffffc020598a:	8556                	mv	a0,s5
ffffffffc020598c:	bd5fe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205990:	0404a823          	sw	zero,80(s1)
ffffffffc0205994:	b755                	j	ffffffffc0205938 <sysfile_getdirentry+0x60>
ffffffffc0205996:	85aa                	mv	a1,a0
ffffffffc0205998:	4705                	li	a4,1
ffffffffc020599a:	46a1                	li	a3,8
ffffffffc020599c:	864a                	mv	a2,s2
ffffffffc020599e:	4501                	li	a0,0
ffffffffc02059a0:	987fe0ef          	jal	ra,ffffffffc0204326 <copy_from_user>
ffffffffc02059a4:	cd11                	beqz	a0,ffffffffc02059c0 <sysfile_getdirentry+0xe8>
ffffffffc02059a6:	854e                	mv	a0,s3
ffffffffc02059a8:	85a2                	mv	a1,s0
ffffffffc02059aa:	ea6ff0ef          	jal	ra,ffffffffc0205050 <file_getdirentry>
ffffffffc02059ae:	89aa                	mv	s3,a0
ffffffffc02059b0:	f541                	bnez	a0,ffffffffc0205938 <sysfile_getdirentry+0x60>
ffffffffc02059b2:	10800693          	li	a3,264
ffffffffc02059b6:	8622                	mv	a2,s0
ffffffffc02059b8:	85ca                	mv	a1,s2
ffffffffc02059ba:	9a1fe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc02059be:	fd2d                	bnez	a0,ffffffffc0205938 <sysfile_getdirentry+0x60>
ffffffffc02059c0:	59f5                	li	s3,-3
ffffffffc02059c2:	bf9d                	j	ffffffffc0205938 <sysfile_getdirentry+0x60>
ffffffffc02059c4:	59f1                	li	s3,-4
ffffffffc02059c6:	bfa5                	j	ffffffffc020593e <sysfile_getdirentry+0x66>

ffffffffc02059c8 <sysfile_dup>:
ffffffffc02059c8:	f6eff06f          	j	ffffffffc0205136 <file_dup>

ffffffffc02059cc <kernel_thread_entry>:
ffffffffc02059cc:	8526                	mv	a0,s1
ffffffffc02059ce:	9402                	jalr	s0
ffffffffc02059d0:	646000ef          	jal	ra,ffffffffc0206016 <do_exit>

ffffffffc02059d4 <alloc_proc>:
ffffffffc02059d4:	1141                	addi	sp,sp,-16
ffffffffc02059d6:	15000513          	li	a0,336
ffffffffc02059da:	e022                	sd	s0,0(sp)
ffffffffc02059dc:	e406                	sd	ra,8(sp)
ffffffffc02059de:	db0fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02059e2:	842a                	mv	s0,a0
ffffffffc02059e4:	c141                	beqz	a0,ffffffffc0205a64 <alloc_proc+0x90>
ffffffffc02059e6:	57fd                	li	a5,-1
ffffffffc02059e8:	1782                	slli	a5,a5,0x20
ffffffffc02059ea:	e11c                	sd	a5,0(a0)
ffffffffc02059ec:	07000613          	li	a2,112
ffffffffc02059f0:	4581                	li	a1,0
ffffffffc02059f2:	00052423          	sw	zero,8(a0)
ffffffffc02059f6:	00053823          	sd	zero,16(a0)
ffffffffc02059fa:	00053c23          	sd	zero,24(a0)
ffffffffc02059fe:	02053023          	sd	zero,32(a0)
ffffffffc0205a02:	02053423          	sd	zero,40(a0)
ffffffffc0205a06:	03050513          	addi	a0,a0,48
ffffffffc0205a0a:	1ad050ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0205a0e:	00091797          	auipc	a5,0x91
ffffffffc0205a12:	e827b783          	ld	a5,-382(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0205a16:	f45c                	sd	a5,168(s0)
ffffffffc0205a18:	0a043023          	sd	zero,160(s0)
ffffffffc0205a1c:	0a042823          	sw	zero,176(s0)
ffffffffc0205a20:	463d                	li	a2,15
ffffffffc0205a22:	4581                	li	a1,0
ffffffffc0205a24:	0b440513          	addi	a0,s0,180
ffffffffc0205a28:	18f050ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0205a2c:	11040793          	addi	a5,s0,272
ffffffffc0205a30:	0e042623          	sw	zero,236(s0)
ffffffffc0205a34:	0e043c23          	sd	zero,248(s0)
ffffffffc0205a38:	10043023          	sd	zero,256(s0)
ffffffffc0205a3c:	0e043823          	sd	zero,240(s0)
ffffffffc0205a40:	10043423          	sd	zero,264(s0)
ffffffffc0205a44:	10f43c23          	sd	a5,280(s0)
ffffffffc0205a48:	10f43823          	sd	a5,272(s0)
ffffffffc0205a4c:	12042023          	sw	zero,288(s0)
ffffffffc0205a50:	12043423          	sd	zero,296(s0)
ffffffffc0205a54:	12043823          	sd	zero,304(s0)
ffffffffc0205a58:	12043c23          	sd	zero,312(s0)
ffffffffc0205a5c:	14043023          	sd	zero,320(s0)
ffffffffc0205a60:	14043423          	sd	zero,328(s0)
ffffffffc0205a64:	60a2                	ld	ra,8(sp)
ffffffffc0205a66:	8522                	mv	a0,s0
ffffffffc0205a68:	6402                	ld	s0,0(sp)
ffffffffc0205a6a:	0141                	addi	sp,sp,16
ffffffffc0205a6c:	8082                	ret

ffffffffc0205a6e <forkret>:
ffffffffc0205a6e:	00091797          	auipc	a5,0x91
ffffffffc0205a72:	e527b783          	ld	a5,-430(a5) # ffffffffc02968c0 <current>
ffffffffc0205a76:	73c8                	ld	a0,160(a5)
ffffffffc0205a78:	833fb06f          	j	ffffffffc02012aa <forkrets>

ffffffffc0205a7c <load_icode_read>:
ffffffffc0205a7c:	7139                	addi	sp,sp,-64
ffffffffc0205a7e:	f822                	sd	s0,48(sp)
ffffffffc0205a80:	f426                	sd	s1,40(sp)
ffffffffc0205a82:	8432                	mv	s0,a2
ffffffffc0205a84:	84ae                	mv	s1,a1
ffffffffc0205a86:	4601                	li	a2,0
ffffffffc0205a88:	85b6                	mv	a1,a3
ffffffffc0205a8a:	f04a                	sd	s2,32(sp)
ffffffffc0205a8c:	ec4e                	sd	s3,24(sp)
ffffffffc0205a8e:	fc06                	sd	ra,56(sp)
ffffffffc0205a90:	892a                	mv	s2,a0
ffffffffc0205a92:	cfbff0ef          	jal	ra,ffffffffc020578c <sysfile_seek>
ffffffffc0205a96:	89aa                	mv	s3,a0
ffffffffc0205a98:	e105                	bnez	a0,ffffffffc0205ab8 <load_icode_read+0x3c>
ffffffffc0205a9a:	e419                	bnez	s0,ffffffffc0205aa8 <load_icode_read+0x2c>
ffffffffc0205a9c:	a831                	j	ffffffffc0205ab8 <load_icode_read+0x3c>
ffffffffc0205a9e:	67a2                	ld	a5,8(sp)
ffffffffc0205aa0:	8c1d                	sub	s0,s0,a5
ffffffffc0205aa2:	c39d                	beqz	a5,ffffffffc0205ac8 <load_icode_read+0x4c>
ffffffffc0205aa4:	94be                	add	s1,s1,a5
ffffffffc0205aa6:	c809                	beqz	s0,ffffffffc0205ab8 <load_icode_read+0x3c>
ffffffffc0205aa8:	8622                	mv	a2,s0
ffffffffc0205aaa:	85a6                	mv	a1,s1
ffffffffc0205aac:	0034                	addi	a3,sp,8
ffffffffc0205aae:	854a                	mv	a0,s2
ffffffffc0205ab0:	946ff0ef          	jal	ra,ffffffffc0204bf6 <file_read>
ffffffffc0205ab4:	d56d                	beqz	a0,ffffffffc0205a9e <load_icode_read+0x22>
ffffffffc0205ab6:	89aa                	mv	s3,a0
ffffffffc0205ab8:	70e2                	ld	ra,56(sp)
ffffffffc0205aba:	7442                	ld	s0,48(sp)
ffffffffc0205abc:	74a2                	ld	s1,40(sp)
ffffffffc0205abe:	7902                	ld	s2,32(sp)
ffffffffc0205ac0:	854e                	mv	a0,s3
ffffffffc0205ac2:	69e2                	ld	s3,24(sp)
ffffffffc0205ac4:	6121                	addi	sp,sp,64
ffffffffc0205ac6:	8082                	ret
ffffffffc0205ac8:	70e2                	ld	ra,56(sp)
ffffffffc0205aca:	7442                	ld	s0,48(sp)
ffffffffc0205acc:	59fd                	li	s3,-1
ffffffffc0205ace:	74a2                	ld	s1,40(sp)
ffffffffc0205ad0:	7902                	ld	s2,32(sp)
ffffffffc0205ad2:	854e                	mv	a0,s3
ffffffffc0205ad4:	69e2                	ld	s3,24(sp)
ffffffffc0205ad6:	6121                	addi	sp,sp,64
ffffffffc0205ad8:	8082                	ret

ffffffffc0205ada <put_pgdir.isra.0>:
ffffffffc0205ada:	1141                	addi	sp,sp,-16
ffffffffc0205adc:	e406                	sd	ra,8(sp)
ffffffffc0205ade:	c02007b7          	lui	a5,0xc0200
ffffffffc0205ae2:	02f56e63          	bltu	a0,a5,ffffffffc0205b1e <put_pgdir.isra.0+0x44>
ffffffffc0205ae6:	00091697          	auipc	a3,0x91
ffffffffc0205aea:	dd26b683          	ld	a3,-558(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205aee:	8d15                	sub	a0,a0,a3
ffffffffc0205af0:	8131                	srli	a0,a0,0xc
ffffffffc0205af2:	00091797          	auipc	a5,0x91
ffffffffc0205af6:	dae7b783          	ld	a5,-594(a5) # ffffffffc02968a0 <npage>
ffffffffc0205afa:	02f57f63          	bgeu	a0,a5,ffffffffc0205b38 <put_pgdir.isra.0+0x5e>
ffffffffc0205afe:	0000a697          	auipc	a3,0xa
ffffffffc0205b02:	b826b683          	ld	a3,-1150(a3) # ffffffffc020f680 <nbase>
ffffffffc0205b06:	60a2                	ld	ra,8(sp)
ffffffffc0205b08:	8d15                	sub	a0,a0,a3
ffffffffc0205b0a:	00091797          	auipc	a5,0x91
ffffffffc0205b0e:	d9e7b783          	ld	a5,-610(a5) # ffffffffc02968a8 <pages>
ffffffffc0205b12:	051a                	slli	a0,a0,0x6
ffffffffc0205b14:	4585                	li	a1,1
ffffffffc0205b16:	953e                	add	a0,a0,a5
ffffffffc0205b18:	0141                	addi	sp,sp,16
ffffffffc0205b1a:	e90fc06f          	j	ffffffffc02021aa <free_pages>
ffffffffc0205b1e:	86aa                	mv	a3,a0
ffffffffc0205b20:	00007617          	auipc	a2,0x7
ffffffffc0205b24:	94060613          	addi	a2,a2,-1728 # ffffffffc020c460 <default_pmm_manager+0xe0>
ffffffffc0205b28:	07700593          	li	a1,119
ffffffffc0205b2c:	00007517          	auipc	a0,0x7
ffffffffc0205b30:	8b450513          	addi	a0,a0,-1868 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0205b34:	96bfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205b38:	00007617          	auipc	a2,0x7
ffffffffc0205b3c:	95060613          	addi	a2,a2,-1712 # ffffffffc020c488 <default_pmm_manager+0x108>
ffffffffc0205b40:	06900593          	li	a1,105
ffffffffc0205b44:	00007517          	auipc	a0,0x7
ffffffffc0205b48:	89c50513          	addi	a0,a0,-1892 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0205b4c:	953fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205b50 <proc_run>:
ffffffffc0205b50:	1101                	addi	sp,sp,-32
ffffffffc0205b52:	e822                	sd	s0,16(sp)
ffffffffc0205b54:	ec06                	sd	ra,24(sp)
ffffffffc0205b56:	e426                	sd	s1,8(sp)
ffffffffc0205b58:	842a                	mv	s0,a0
ffffffffc0205b5a:	100027f3          	csrr	a5,sstatus
ffffffffc0205b5e:	8b89                	andi	a5,a5,2
ffffffffc0205b60:	4481                	li	s1,0
ffffffffc0205b62:	e3b1                	bnez	a5,ffffffffc0205ba6 <proc_run+0x56>
ffffffffc0205b64:	745c                	ld	a5,168(s0)
ffffffffc0205b66:	577d                	li	a4,-1
ffffffffc0205b68:	00091697          	auipc	a3,0x91
ffffffffc0205b6c:	d5868693          	addi	a3,a3,-680 # ffffffffc02968c0 <current>
ffffffffc0205b70:	177e                	slli	a4,a4,0x3f
ffffffffc0205b72:	83b1                	srli	a5,a5,0xc
ffffffffc0205b74:	6288                	ld	a0,0(a3)
ffffffffc0205b76:	8fd9                	or	a5,a5,a4
ffffffffc0205b78:	e280                	sd	s0,0(a3)
ffffffffc0205b7a:	18079073          	csrw	satp,a5
ffffffffc0205b7e:	12000073          	sfence.vma
ffffffffc0205b82:	03040593          	addi	a1,s0,48
ffffffffc0205b86:	03050513          	addi	a0,a0,48
ffffffffc0205b8a:	47a010ef          	jal	ra,ffffffffc0207004 <switch_to>
ffffffffc0205b8e:	e491                	bnez	s1,ffffffffc0205b9a <proc_run+0x4a>
ffffffffc0205b90:	60e2                	ld	ra,24(sp)
ffffffffc0205b92:	6442                	ld	s0,16(sp)
ffffffffc0205b94:	64a2                	ld	s1,8(sp)
ffffffffc0205b96:	6105                	addi	sp,sp,32
ffffffffc0205b98:	8082                	ret
ffffffffc0205b9a:	6442                	ld	s0,16(sp)
ffffffffc0205b9c:	60e2                	ld	ra,24(sp)
ffffffffc0205b9e:	64a2                	ld	s1,8(sp)
ffffffffc0205ba0:	6105                	addi	sp,sp,32
ffffffffc0205ba2:	8cafb06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0205ba6:	8ccfb0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205baa:	4485                	li	s1,1
ffffffffc0205bac:	bf65                	j	ffffffffc0205b64 <proc_run+0x14>

ffffffffc0205bae <do_fork>:
ffffffffc0205bae:	7119                	addi	sp,sp,-128
ffffffffc0205bb0:	ecce                	sd	s3,88(sp)
ffffffffc0205bb2:	00091997          	auipc	s3,0x91
ffffffffc0205bb6:	d2698993          	addi	s3,s3,-730 # ffffffffc02968d8 <nr_process>
ffffffffc0205bba:	0009a703          	lw	a4,0(s3)
ffffffffc0205bbe:	fc86                	sd	ra,120(sp)
ffffffffc0205bc0:	f8a2                	sd	s0,112(sp)
ffffffffc0205bc2:	f4a6                	sd	s1,104(sp)
ffffffffc0205bc4:	f0ca                	sd	s2,96(sp)
ffffffffc0205bc6:	e8d2                	sd	s4,80(sp)
ffffffffc0205bc8:	e4d6                	sd	s5,72(sp)
ffffffffc0205bca:	e0da                	sd	s6,64(sp)
ffffffffc0205bcc:	fc5e                	sd	s7,56(sp)
ffffffffc0205bce:	f862                	sd	s8,48(sp)
ffffffffc0205bd0:	f466                	sd	s9,40(sp)
ffffffffc0205bd2:	f06a                	sd	s10,32(sp)
ffffffffc0205bd4:	ec6e                	sd	s11,24(sp)
ffffffffc0205bd6:	6785                	lui	a5,0x1
ffffffffc0205bd8:	32f75c63          	bge	a4,a5,ffffffffc0205f10 <do_fork+0x362>
ffffffffc0205bdc:	84aa                	mv	s1,a0
ffffffffc0205bde:	892e                	mv	s2,a1
ffffffffc0205be0:	8432                	mv	s0,a2
ffffffffc0205be2:	df3ff0ef          	jal	ra,ffffffffc02059d4 <alloc_proc>
ffffffffc0205be6:	8aaa                	mv	s5,a0
ffffffffc0205be8:	34050763          	beqz	a0,ffffffffc0205f36 <do_fork+0x388>
ffffffffc0205bec:	00091b97          	auipc	s7,0x91
ffffffffc0205bf0:	cd4b8b93          	addi	s7,s7,-812 # ffffffffc02968c0 <current>
ffffffffc0205bf4:	000bb783          	ld	a5,0(s7)
ffffffffc0205bf8:	4509                	li	a0,2
ffffffffc0205bfa:	02fab023          	sd	a5,32(s5) # 1020 <_binary_bin_swap_img_size-0x6ce0>
ffffffffc0205bfe:	d6efc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205c02:	30050163          	beqz	a0,ffffffffc0205f04 <do_fork+0x356>
ffffffffc0205c06:	00091c17          	auipc	s8,0x91
ffffffffc0205c0a:	ca2c0c13          	addi	s8,s8,-862 # ffffffffc02968a8 <pages>
ffffffffc0205c0e:	000c3683          	ld	a3,0(s8)
ffffffffc0205c12:	00091c97          	auipc	s9,0x91
ffffffffc0205c16:	c8ec8c93          	addi	s9,s9,-882 # ffffffffc02968a0 <npage>
ffffffffc0205c1a:	0000aa17          	auipc	s4,0xa
ffffffffc0205c1e:	a66a3a03          	ld	s4,-1434(s4) # ffffffffc020f680 <nbase>
ffffffffc0205c22:	40d506b3          	sub	a3,a0,a3
ffffffffc0205c26:	8699                	srai	a3,a3,0x6
ffffffffc0205c28:	5b7d                	li	s6,-1
ffffffffc0205c2a:	000cb783          	ld	a5,0(s9)
ffffffffc0205c2e:	96d2                	add	a3,a3,s4
ffffffffc0205c30:	00cb5b13          	srli	s6,s6,0xc
ffffffffc0205c34:	0166f733          	and	a4,a3,s6
ffffffffc0205c38:	06b2                	slli	a3,a3,0xc
ffffffffc0205c3a:	30f77563          	bgeu	a4,a5,ffffffffc0205f44 <do_fork+0x396>
ffffffffc0205c3e:	000bb703          	ld	a4,0(s7)
ffffffffc0205c42:	00091d97          	auipc	s11,0x91
ffffffffc0205c46:	c76d8d93          	addi	s11,s11,-906 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205c4a:	000db783          	ld	a5,0(s11)
ffffffffc0205c4e:	02873d03          	ld	s10,40(a4)
ffffffffc0205c52:	96be                	add	a3,a3,a5
ffffffffc0205c54:	00dab823          	sd	a3,16(s5)
ffffffffc0205c58:	020d0a63          	beqz	s10,ffffffffc0205c8c <do_fork+0xde>
ffffffffc0205c5c:	1004f793          	andi	a5,s1,256
ffffffffc0205c60:	1c078463          	beqz	a5,ffffffffc0205e28 <do_fork+0x27a>
ffffffffc0205c64:	030d2683          	lw	a3,48(s10)
ffffffffc0205c68:	018d3783          	ld	a5,24(s10)
ffffffffc0205c6c:	c0200637          	lui	a2,0xc0200
ffffffffc0205c70:	2685                	addiw	a3,a3,1
ffffffffc0205c72:	02dd2823          	sw	a3,48(s10)
ffffffffc0205c76:	03aab423          	sd	s10,40(s5)
ffffffffc0205c7a:	2ec7e163          	bltu	a5,a2,ffffffffc0205f5c <do_fork+0x3ae>
ffffffffc0205c7e:	000db703          	ld	a4,0(s11)
ffffffffc0205c82:	010ab683          	ld	a3,16(s5)
ffffffffc0205c86:	8f99                	sub	a5,a5,a4
ffffffffc0205c88:	0afab423          	sd	a5,168(s5)
ffffffffc0205c8c:	6789                	lui	a5,0x2
ffffffffc0205c8e:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0205c92:	96be                	add	a3,a3,a5
ffffffffc0205c94:	0adab023          	sd	a3,160(s5)
ffffffffc0205c98:	87b6                	mv	a5,a3
ffffffffc0205c9a:	12040813          	addi	a6,s0,288
ffffffffc0205c9e:	6008                	ld	a0,0(s0)
ffffffffc0205ca0:	640c                	ld	a1,8(s0)
ffffffffc0205ca2:	6810                	ld	a2,16(s0)
ffffffffc0205ca4:	6c18                	ld	a4,24(s0)
ffffffffc0205ca6:	e388                	sd	a0,0(a5)
ffffffffc0205ca8:	e78c                	sd	a1,8(a5)
ffffffffc0205caa:	eb90                	sd	a2,16(a5)
ffffffffc0205cac:	ef98                	sd	a4,24(a5)
ffffffffc0205cae:	02040413          	addi	s0,s0,32
ffffffffc0205cb2:	02078793          	addi	a5,a5,32
ffffffffc0205cb6:	ff0414e3          	bne	s0,a6,ffffffffc0205c9e <do_fork+0xf0>
ffffffffc0205cba:	0406b823          	sd	zero,80(a3)
ffffffffc0205cbe:	00091363          	bnez	s2,ffffffffc0205cc4 <do_fork+0x116>
ffffffffc0205cc2:	8936                	mv	s2,a3
ffffffffc0205cc4:	0008b817          	auipc	a6,0x8b
ffffffffc0205cc8:	39480813          	addi	a6,a6,916 # ffffffffc0291058 <last_pid.1>
ffffffffc0205ccc:	00082783          	lw	a5,0(a6)
ffffffffc0205cd0:	0126b823          	sd	s2,16(a3)
ffffffffc0205cd4:	00000717          	auipc	a4,0x0
ffffffffc0205cd8:	d9a70713          	addi	a4,a4,-614 # ffffffffc0205a6e <forkret>
ffffffffc0205cdc:	0017851b          	addiw	a0,a5,1
ffffffffc0205ce0:	02eab823          	sd	a4,48(s5)
ffffffffc0205ce4:	02dabc23          	sd	a3,56(s5)
ffffffffc0205ce8:	00a82023          	sw	a0,0(a6)
ffffffffc0205cec:	6789                	lui	a5,0x2
ffffffffc0205cee:	1af55e63          	bge	a0,a5,ffffffffc0205eaa <do_fork+0x2fc>
ffffffffc0205cf2:	0008b317          	auipc	t1,0x8b
ffffffffc0205cf6:	36a30313          	addi	t1,t1,874 # ffffffffc029105c <next_safe.0>
ffffffffc0205cfa:	00032783          	lw	a5,0(t1)
ffffffffc0205cfe:	00090417          	auipc	s0,0x90
ffffffffc0205d02:	ac240413          	addi	s0,s0,-1342 # ffffffffc02957c0 <proc_list>
ffffffffc0205d06:	06f54063          	blt	a0,a5,ffffffffc0205d66 <do_fork+0x1b8>
ffffffffc0205d0a:	00090417          	auipc	s0,0x90
ffffffffc0205d0e:	ab640413          	addi	s0,s0,-1354 # ffffffffc02957c0 <proc_list>
ffffffffc0205d12:	00843e03          	ld	t3,8(s0)
ffffffffc0205d16:	6789                	lui	a5,0x2
ffffffffc0205d18:	00f32023          	sw	a5,0(t1)
ffffffffc0205d1c:	86aa                	mv	a3,a0
ffffffffc0205d1e:	4581                	li	a1,0
ffffffffc0205d20:	6e89                	lui	t4,0x2
ffffffffc0205d22:	208e0563          	beq	t3,s0,ffffffffc0205f2c <do_fork+0x37e>
ffffffffc0205d26:	88ae                	mv	a7,a1
ffffffffc0205d28:	87f2                	mv	a5,t3
ffffffffc0205d2a:	6609                	lui	a2,0x2
ffffffffc0205d2c:	a811                	j	ffffffffc0205d40 <do_fork+0x192>
ffffffffc0205d2e:	00e6d663          	bge	a3,a4,ffffffffc0205d3a <do_fork+0x18c>
ffffffffc0205d32:	00c75463          	bge	a4,a2,ffffffffc0205d3a <do_fork+0x18c>
ffffffffc0205d36:	863a                	mv	a2,a4
ffffffffc0205d38:	4885                	li	a7,1
ffffffffc0205d3a:	679c                	ld	a5,8(a5)
ffffffffc0205d3c:	00878d63          	beq	a5,s0,ffffffffc0205d56 <do_fork+0x1a8>
ffffffffc0205d40:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_bin_swap_img_size-0x5dc4>
ffffffffc0205d44:	fed715e3          	bne	a4,a3,ffffffffc0205d2e <do_fork+0x180>
ffffffffc0205d48:	2685                	addiw	a3,a3,1
ffffffffc0205d4a:	1ac6d863          	bge	a3,a2,ffffffffc0205efa <do_fork+0x34c>
ffffffffc0205d4e:	679c                	ld	a5,8(a5)
ffffffffc0205d50:	4585                	li	a1,1
ffffffffc0205d52:	fe8797e3          	bne	a5,s0,ffffffffc0205d40 <do_fork+0x192>
ffffffffc0205d56:	c581                	beqz	a1,ffffffffc0205d5e <do_fork+0x1b0>
ffffffffc0205d58:	00d82023          	sw	a3,0(a6)
ffffffffc0205d5c:	8536                	mv	a0,a3
ffffffffc0205d5e:	00088463          	beqz	a7,ffffffffc0205d66 <do_fork+0x1b8>
ffffffffc0205d62:	00c32023          	sw	a2,0(t1)
ffffffffc0205d66:	00aaa223          	sw	a0,4(s5)
ffffffffc0205d6a:	45a9                	li	a1,10
ffffffffc0205d6c:	2501                	sext.w	a0,a0
ffffffffc0205d6e:	114050ef          	jal	ra,ffffffffc020ae82 <hash32>
ffffffffc0205d72:	02051793          	slli	a5,a0,0x20
ffffffffc0205d76:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0205d7a:	0008c797          	auipc	a5,0x8c
ffffffffc0205d7e:	a4678793          	addi	a5,a5,-1466 # ffffffffc02917c0 <hash_list>
ffffffffc0205d82:	953e                	add	a0,a0,a5
ffffffffc0205d84:	650c                	ld	a1,8(a0)
ffffffffc0205d86:	020ab683          	ld	a3,32(s5)
ffffffffc0205d8a:	0d8a8793          	addi	a5,s5,216
ffffffffc0205d8e:	e19c                	sd	a5,0(a1)
ffffffffc0205d90:	6410                	ld	a2,8(s0)
ffffffffc0205d92:	e51c                	sd	a5,8(a0)
ffffffffc0205d94:	7af8                	ld	a4,240(a3)
ffffffffc0205d96:	0c8a8793          	addi	a5,s5,200
ffffffffc0205d9a:	0ebab023          	sd	a1,224(s5)
ffffffffc0205d9e:	0caabc23          	sd	a0,216(s5)
ffffffffc0205da2:	e21c                	sd	a5,0(a2)
ffffffffc0205da4:	e41c                	sd	a5,8(s0)
ffffffffc0205da6:	0ccab823          	sd	a2,208(s5)
ffffffffc0205daa:	0c8ab423          	sd	s0,200(s5)
ffffffffc0205dae:	0e0abc23          	sd	zero,248(s5)
ffffffffc0205db2:	10eab023          	sd	a4,256(s5)
ffffffffc0205db6:	c319                	beqz	a4,ffffffffc0205dbc <do_fork+0x20e>
ffffffffc0205db8:	0f573c23          	sd	s5,248(a4)
ffffffffc0205dbc:	0009a783          	lw	a5,0(s3)
ffffffffc0205dc0:	0f56b823          	sd	s5,240(a3)
ffffffffc0205dc4:	8556                	mv	a0,s5
ffffffffc0205dc6:	2785                	addiw	a5,a5,1
ffffffffc0205dc8:	00f9a023          	sw	a5,0(s3)
ffffffffc0205dcc:	3dc010ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc0205dd0:	000bb783          	ld	a5,0(s7)
ffffffffc0205dd4:	004aa403          	lw	s0,4(s5)
ffffffffc0205dd8:	1487b903          	ld	s2,328(a5)
ffffffffc0205ddc:	18090d63          	beqz	s2,ffffffffc0205f76 <do_fork+0x3c8>
ffffffffc0205de0:	80ad                	srli	s1,s1,0xb
ffffffffc0205de2:	8885                	andi	s1,s1,1
ffffffffc0205de4:	e899                	bnez	s1,ffffffffc0205dfa <do_fork+0x24c>
ffffffffc0205de6:	be8ff0ef          	jal	ra,ffffffffc02051ce <files_create>
ffffffffc0205dea:	84aa                	mv	s1,a0
ffffffffc0205dec:	cd61                	beqz	a0,ffffffffc0205ec4 <do_fork+0x316>
ffffffffc0205dee:	85ca                	mv	a1,s2
ffffffffc0205df0:	d16ff0ef          	jal	ra,ffffffffc0205306 <dup_files>
ffffffffc0205df4:	8926                	mv	s2,s1
ffffffffc0205df6:	10051963          	bnez	a0,ffffffffc0205f08 <do_fork+0x35a>
ffffffffc0205dfa:	01092783          	lw	a5,16(s2)
ffffffffc0205dfe:	2785                	addiw	a5,a5,1
ffffffffc0205e00:	00f92823          	sw	a5,16(s2)
ffffffffc0205e04:	152ab423          	sd	s2,328(s5)
ffffffffc0205e08:	70e6                	ld	ra,120(sp)
ffffffffc0205e0a:	8522                	mv	a0,s0
ffffffffc0205e0c:	7446                	ld	s0,112(sp)
ffffffffc0205e0e:	74a6                	ld	s1,104(sp)
ffffffffc0205e10:	7906                	ld	s2,96(sp)
ffffffffc0205e12:	69e6                	ld	s3,88(sp)
ffffffffc0205e14:	6a46                	ld	s4,80(sp)
ffffffffc0205e16:	6aa6                	ld	s5,72(sp)
ffffffffc0205e18:	6b06                	ld	s6,64(sp)
ffffffffc0205e1a:	7be2                	ld	s7,56(sp)
ffffffffc0205e1c:	7c42                	ld	s8,48(sp)
ffffffffc0205e1e:	7ca2                	ld	s9,40(sp)
ffffffffc0205e20:	7d02                	ld	s10,32(sp)
ffffffffc0205e22:	6de2                	ld	s11,24(sp)
ffffffffc0205e24:	6109                	addi	sp,sp,128
ffffffffc0205e26:	8082                	ret
ffffffffc0205e28:	de1fd0ef          	jal	ra,ffffffffc0203c08 <mm_create>
ffffffffc0205e2c:	e02a                	sd	a0,0(sp)
ffffffffc0205e2e:	10050963          	beqz	a0,ffffffffc0205f40 <do_fork+0x392>
ffffffffc0205e32:	4505                	li	a0,1
ffffffffc0205e34:	b38fc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205e38:	c151                	beqz	a0,ffffffffc0205ebc <do_fork+0x30e>
ffffffffc0205e3a:	000c3683          	ld	a3,0(s8)
ffffffffc0205e3e:	000cb783          	ld	a5,0(s9)
ffffffffc0205e42:	40d506b3          	sub	a3,a0,a3
ffffffffc0205e46:	8699                	srai	a3,a3,0x6
ffffffffc0205e48:	96d2                	add	a3,a3,s4
ffffffffc0205e4a:	0166fb33          	and	s6,a3,s6
ffffffffc0205e4e:	06b2                	slli	a3,a3,0xc
ffffffffc0205e50:	0efb7a63          	bgeu	s6,a5,ffffffffc0205f44 <do_fork+0x396>
ffffffffc0205e54:	000dbb03          	ld	s6,0(s11)
ffffffffc0205e58:	6605                	lui	a2,0x1
ffffffffc0205e5a:	00091597          	auipc	a1,0x91
ffffffffc0205e5e:	a3e5b583          	ld	a1,-1474(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0205e62:	9b36                	add	s6,s6,a3
ffffffffc0205e64:	855a                	mv	a0,s6
ffffffffc0205e66:	5a2050ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc0205e6a:	6702                	ld	a4,0(sp)
ffffffffc0205e6c:	038d0793          	addi	a5,s10,56
ffffffffc0205e70:	853e                	mv	a0,a5
ffffffffc0205e72:	01673c23          	sd	s6,24(a4)
ffffffffc0205e76:	e43e                	sd	a5,8(sp)
ffffffffc0205e78:	eecfe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0205e7c:	000bb683          	ld	a3,0(s7)
ffffffffc0205e80:	67a2                	ld	a5,8(sp)
ffffffffc0205e82:	c681                	beqz	a3,ffffffffc0205e8a <do_fork+0x2dc>
ffffffffc0205e84:	42d4                	lw	a3,4(a3)
ffffffffc0205e86:	04dd2823          	sw	a3,80(s10)
ffffffffc0205e8a:	6502                	ld	a0,0(sp)
ffffffffc0205e8c:	85ea                	mv	a1,s10
ffffffffc0205e8e:	e43e                	sd	a5,8(sp)
ffffffffc0205e90:	fc9fd0ef          	jal	ra,ffffffffc0203e58 <dup_mmap>
ffffffffc0205e94:	67a2                	ld	a5,8(sp)
ffffffffc0205e96:	8b2a                	mv	s6,a0
ffffffffc0205e98:	853e                	mv	a0,a5
ffffffffc0205e9a:	ec6fe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205e9e:	040d2823          	sw	zero,80(s10)
ffffffffc0205ea2:	060b1963          	bnez	s6,ffffffffc0205f14 <do_fork+0x366>
ffffffffc0205ea6:	6d02                	ld	s10,0(sp)
ffffffffc0205ea8:	bb75                	j	ffffffffc0205c64 <do_fork+0xb6>
ffffffffc0205eaa:	4785                	li	a5,1
ffffffffc0205eac:	00f82023          	sw	a5,0(a6)
ffffffffc0205eb0:	4505                	li	a0,1
ffffffffc0205eb2:	0008b317          	auipc	t1,0x8b
ffffffffc0205eb6:	1aa30313          	addi	t1,t1,426 # ffffffffc029105c <next_safe.0>
ffffffffc0205eba:	bd81                	j	ffffffffc0205d0a <do_fork+0x15c>
ffffffffc0205ebc:	6502                	ld	a0,0(sp)
ffffffffc0205ebe:	5471                	li	s0,-4
ffffffffc0205ec0:	e97fd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0205ec4:	010ab683          	ld	a3,16(s5)
ffffffffc0205ec8:	c02007b7          	lui	a5,0xc0200
ffffffffc0205ecc:	0ef6e163          	bltu	a3,a5,ffffffffc0205fae <do_fork+0x400>
ffffffffc0205ed0:	000db703          	ld	a4,0(s11)
ffffffffc0205ed4:	000cb783          	ld	a5,0(s9)
ffffffffc0205ed8:	8e99                	sub	a3,a3,a4
ffffffffc0205eda:	82b1                	srli	a3,a3,0xc
ffffffffc0205edc:	0af6fd63          	bgeu	a3,a5,ffffffffc0205f96 <do_fork+0x3e8>
ffffffffc0205ee0:	000c3503          	ld	a0,0(s8)
ffffffffc0205ee4:	414686b3          	sub	a3,a3,s4
ffffffffc0205ee8:	069a                	slli	a3,a3,0x6
ffffffffc0205eea:	4589                	li	a1,2
ffffffffc0205eec:	9536                	add	a0,a0,a3
ffffffffc0205eee:	abcfc0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0205ef2:	8556                	mv	a0,s5
ffffffffc0205ef4:	94afc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205ef8:	bf01                	j	ffffffffc0205e08 <do_fork+0x25a>
ffffffffc0205efa:	01d6c363          	blt	a3,t4,ffffffffc0205f00 <do_fork+0x352>
ffffffffc0205efe:	4685                	li	a3,1
ffffffffc0205f00:	4585                	li	a1,1
ffffffffc0205f02:	b505                	j	ffffffffc0205d22 <do_fork+0x174>
ffffffffc0205f04:	5471                	li	s0,-4
ffffffffc0205f06:	b7f5                	j	ffffffffc0205ef2 <do_fork+0x344>
ffffffffc0205f08:	8526                	mv	a0,s1
ffffffffc0205f0a:	afaff0ef          	jal	ra,ffffffffc0205204 <files_destroy>
ffffffffc0205f0e:	bf5d                	j	ffffffffc0205ec4 <do_fork+0x316>
ffffffffc0205f10:	546d                	li	s0,-5
ffffffffc0205f12:	bddd                	j	ffffffffc0205e08 <do_fork+0x25a>
ffffffffc0205f14:	6482                	ld	s1,0(sp)
ffffffffc0205f16:	5471                	li	s0,-4
ffffffffc0205f18:	8526                	mv	a0,s1
ffffffffc0205f1a:	fd9fd0ef          	jal	ra,ffffffffc0203ef2 <exit_mmap>
ffffffffc0205f1e:	6c88                	ld	a0,24(s1)
ffffffffc0205f20:	bbbff0ef          	jal	ra,ffffffffc0205ada <put_pgdir.isra.0>
ffffffffc0205f24:	8526                	mv	a0,s1
ffffffffc0205f26:	e31fd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0205f2a:	bf69                	j	ffffffffc0205ec4 <do_fork+0x316>
ffffffffc0205f2c:	c599                	beqz	a1,ffffffffc0205f3a <do_fork+0x38c>
ffffffffc0205f2e:	00d82023          	sw	a3,0(a6)
ffffffffc0205f32:	8536                	mv	a0,a3
ffffffffc0205f34:	bd0d                	j	ffffffffc0205d66 <do_fork+0x1b8>
ffffffffc0205f36:	5471                	li	s0,-4
ffffffffc0205f38:	bdc1                	j	ffffffffc0205e08 <do_fork+0x25a>
ffffffffc0205f3a:	00082503          	lw	a0,0(a6)
ffffffffc0205f3e:	b525                	j	ffffffffc0205d66 <do_fork+0x1b8>
ffffffffc0205f40:	5471                	li	s0,-4
ffffffffc0205f42:	b749                	j	ffffffffc0205ec4 <do_fork+0x316>
ffffffffc0205f44:	00006617          	auipc	a2,0x6
ffffffffc0205f48:	47460613          	addi	a2,a2,1140 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc0205f4c:	07100593          	li	a1,113
ffffffffc0205f50:	00006517          	auipc	a0,0x6
ffffffffc0205f54:	49050513          	addi	a0,a0,1168 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0205f58:	d46fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f5c:	86be                	mv	a3,a5
ffffffffc0205f5e:	00006617          	auipc	a2,0x6
ffffffffc0205f62:	50260613          	addi	a2,a2,1282 # ffffffffc020c460 <default_pmm_manager+0xe0>
ffffffffc0205f66:	1b100593          	li	a1,433
ffffffffc0205f6a:	00007517          	auipc	a0,0x7
ffffffffc0205f6e:	42e50513          	addi	a0,a0,1070 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0205f72:	d2cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f76:	00007697          	auipc	a3,0x7
ffffffffc0205f7a:	43a68693          	addi	a3,a3,1082 # ffffffffc020d3b0 <CSWTCH.79+0x108>
ffffffffc0205f7e:	00006617          	auipc	a2,0x6
ffffffffc0205f82:	91a60613          	addi	a2,a2,-1766 # ffffffffc020b898 <commands+0x210>
ffffffffc0205f86:	1d100593          	li	a1,465
ffffffffc0205f8a:	00007517          	auipc	a0,0x7
ffffffffc0205f8e:	40e50513          	addi	a0,a0,1038 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0205f92:	d0cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f96:	00006617          	auipc	a2,0x6
ffffffffc0205f9a:	4f260613          	addi	a2,a2,1266 # ffffffffc020c488 <default_pmm_manager+0x108>
ffffffffc0205f9e:	06900593          	li	a1,105
ffffffffc0205fa2:	00006517          	auipc	a0,0x6
ffffffffc0205fa6:	43e50513          	addi	a0,a0,1086 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0205faa:	cf4fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205fae:	00006617          	auipc	a2,0x6
ffffffffc0205fb2:	4b260613          	addi	a2,a2,1202 # ffffffffc020c460 <default_pmm_manager+0xe0>
ffffffffc0205fb6:	07700593          	li	a1,119
ffffffffc0205fba:	00006517          	auipc	a0,0x6
ffffffffc0205fbe:	42650513          	addi	a0,a0,1062 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0205fc2:	cdcfa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205fc6 <kernel_thread>:
ffffffffc0205fc6:	7129                	addi	sp,sp,-320
ffffffffc0205fc8:	fa22                	sd	s0,304(sp)
ffffffffc0205fca:	f626                	sd	s1,296(sp)
ffffffffc0205fcc:	f24a                	sd	s2,288(sp)
ffffffffc0205fce:	84ae                	mv	s1,a1
ffffffffc0205fd0:	892a                	mv	s2,a0
ffffffffc0205fd2:	8432                	mv	s0,a2
ffffffffc0205fd4:	4581                	li	a1,0
ffffffffc0205fd6:	12000613          	li	a2,288
ffffffffc0205fda:	850a                	mv	a0,sp
ffffffffc0205fdc:	fe06                	sd	ra,312(sp)
ffffffffc0205fde:	3d8050ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0205fe2:	e0ca                	sd	s2,64(sp)
ffffffffc0205fe4:	e4a6                	sd	s1,72(sp)
ffffffffc0205fe6:	100027f3          	csrr	a5,sstatus
ffffffffc0205fea:	edd7f793          	andi	a5,a5,-291
ffffffffc0205fee:	1207e793          	ori	a5,a5,288
ffffffffc0205ff2:	e23e                	sd	a5,256(sp)
ffffffffc0205ff4:	860a                	mv	a2,sp
ffffffffc0205ff6:	10046513          	ori	a0,s0,256
ffffffffc0205ffa:	00000797          	auipc	a5,0x0
ffffffffc0205ffe:	9d278793          	addi	a5,a5,-1582 # ffffffffc02059cc <kernel_thread_entry>
ffffffffc0206002:	4581                	li	a1,0
ffffffffc0206004:	e63e                	sd	a5,264(sp)
ffffffffc0206006:	ba9ff0ef          	jal	ra,ffffffffc0205bae <do_fork>
ffffffffc020600a:	70f2                	ld	ra,312(sp)
ffffffffc020600c:	7452                	ld	s0,304(sp)
ffffffffc020600e:	74b2                	ld	s1,296(sp)
ffffffffc0206010:	7912                	ld	s2,288(sp)
ffffffffc0206012:	6131                	addi	sp,sp,320
ffffffffc0206014:	8082                	ret

ffffffffc0206016 <do_exit>:
ffffffffc0206016:	7179                	addi	sp,sp,-48
ffffffffc0206018:	f022                	sd	s0,32(sp)
ffffffffc020601a:	00091417          	auipc	s0,0x91
ffffffffc020601e:	8a640413          	addi	s0,s0,-1882 # ffffffffc02968c0 <current>
ffffffffc0206022:	601c                	ld	a5,0(s0)
ffffffffc0206024:	f406                	sd	ra,40(sp)
ffffffffc0206026:	ec26                	sd	s1,24(sp)
ffffffffc0206028:	e84a                	sd	s2,16(sp)
ffffffffc020602a:	e44e                	sd	s3,8(sp)
ffffffffc020602c:	e052                	sd	s4,0(sp)
ffffffffc020602e:	00091717          	auipc	a4,0x91
ffffffffc0206032:	89a73703          	ld	a4,-1894(a4) # ffffffffc02968c8 <idleproc>
ffffffffc0206036:	0ee78763          	beq	a5,a4,ffffffffc0206124 <do_exit+0x10e>
ffffffffc020603a:	00091497          	auipc	s1,0x91
ffffffffc020603e:	89648493          	addi	s1,s1,-1898 # ffffffffc02968d0 <initproc>
ffffffffc0206042:	6098                	ld	a4,0(s1)
ffffffffc0206044:	10e78763          	beq	a5,a4,ffffffffc0206152 <do_exit+0x13c>
ffffffffc0206048:	0287b983          	ld	s3,40(a5)
ffffffffc020604c:	892a                	mv	s2,a0
ffffffffc020604e:	02098e63          	beqz	s3,ffffffffc020608a <do_exit+0x74>
ffffffffc0206052:	00091797          	auipc	a5,0x91
ffffffffc0206056:	83e7b783          	ld	a5,-1986(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc020605a:	577d                	li	a4,-1
ffffffffc020605c:	177e                	slli	a4,a4,0x3f
ffffffffc020605e:	83b1                	srli	a5,a5,0xc
ffffffffc0206060:	8fd9                	or	a5,a5,a4
ffffffffc0206062:	18079073          	csrw	satp,a5
ffffffffc0206066:	0309a783          	lw	a5,48(s3)
ffffffffc020606a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020606e:	02e9a823          	sw	a4,48(s3)
ffffffffc0206072:	c769                	beqz	a4,ffffffffc020613c <do_exit+0x126>
ffffffffc0206074:	601c                	ld	a5,0(s0)
ffffffffc0206076:	1487b503          	ld	a0,328(a5)
ffffffffc020607a:	0207b423          	sd	zero,40(a5)
ffffffffc020607e:	c511                	beqz	a0,ffffffffc020608a <do_exit+0x74>
ffffffffc0206080:	491c                	lw	a5,16(a0)
ffffffffc0206082:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206086:	c918                	sw	a4,16(a0)
ffffffffc0206088:	cb59                	beqz	a4,ffffffffc020611e <do_exit+0x108>
ffffffffc020608a:	601c                	ld	a5,0(s0)
ffffffffc020608c:	470d                	li	a4,3
ffffffffc020608e:	c398                	sw	a4,0(a5)
ffffffffc0206090:	0f27a423          	sw	s2,232(a5)
ffffffffc0206094:	100027f3          	csrr	a5,sstatus
ffffffffc0206098:	8b89                	andi	a5,a5,2
ffffffffc020609a:	4a01                	li	s4,0
ffffffffc020609c:	e7f9                	bnez	a5,ffffffffc020616a <do_exit+0x154>
ffffffffc020609e:	6018                	ld	a4,0(s0)
ffffffffc02060a0:	800007b7          	lui	a5,0x80000
ffffffffc02060a4:	0785                	addi	a5,a5,1
ffffffffc02060a6:	7308                	ld	a0,32(a4)
ffffffffc02060a8:	0ec52703          	lw	a4,236(a0)
ffffffffc02060ac:	0cf70363          	beq	a4,a5,ffffffffc0206172 <do_exit+0x15c>
ffffffffc02060b0:	6018                	ld	a4,0(s0)
ffffffffc02060b2:	7b7c                	ld	a5,240(a4)
ffffffffc02060b4:	c3a1                	beqz	a5,ffffffffc02060f4 <do_exit+0xde>
ffffffffc02060b6:	800009b7          	lui	s3,0x80000
ffffffffc02060ba:	490d                	li	s2,3
ffffffffc02060bc:	0985                	addi	s3,s3,1
ffffffffc02060be:	a021                	j	ffffffffc02060c6 <do_exit+0xb0>
ffffffffc02060c0:	6018                	ld	a4,0(s0)
ffffffffc02060c2:	7b7c                	ld	a5,240(a4)
ffffffffc02060c4:	cb85                	beqz	a5,ffffffffc02060f4 <do_exit+0xde>
ffffffffc02060c6:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_bin_sfs_img_size+0xffffffff7ff8ae00>
ffffffffc02060ca:	6088                	ld	a0,0(s1)
ffffffffc02060cc:	fb74                	sd	a3,240(a4)
ffffffffc02060ce:	7978                	ld	a4,240(a0)
ffffffffc02060d0:	0e07bc23          	sd	zero,248(a5)
ffffffffc02060d4:	10e7b023          	sd	a4,256(a5)
ffffffffc02060d8:	c311                	beqz	a4,ffffffffc02060dc <do_exit+0xc6>
ffffffffc02060da:	ff7c                	sd	a5,248(a4)
ffffffffc02060dc:	4398                	lw	a4,0(a5)
ffffffffc02060de:	f388                	sd	a0,32(a5)
ffffffffc02060e0:	f97c                	sd	a5,240(a0)
ffffffffc02060e2:	fd271fe3          	bne	a4,s2,ffffffffc02060c0 <do_exit+0xaa>
ffffffffc02060e6:	0ec52783          	lw	a5,236(a0)
ffffffffc02060ea:	fd379be3          	bne	a5,s3,ffffffffc02060c0 <do_exit+0xaa>
ffffffffc02060ee:	0ba010ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc02060f2:	b7f9                	j	ffffffffc02060c0 <do_exit+0xaa>
ffffffffc02060f4:	020a1263          	bnez	s4,ffffffffc0206118 <do_exit+0x102>
ffffffffc02060f8:	162010ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc02060fc:	601c                	ld	a5,0(s0)
ffffffffc02060fe:	00007617          	auipc	a2,0x7
ffffffffc0206102:	2ea60613          	addi	a2,a2,746 # ffffffffc020d3e8 <CSWTCH.79+0x140>
ffffffffc0206106:	29600593          	li	a1,662
ffffffffc020610a:	43d4                	lw	a3,4(a5)
ffffffffc020610c:	00007517          	auipc	a0,0x7
ffffffffc0206110:	28c50513          	addi	a0,a0,652 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206114:	b8afa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206118:	b55fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020611c:	bff1                	j	ffffffffc02060f8 <do_exit+0xe2>
ffffffffc020611e:	8e6ff0ef          	jal	ra,ffffffffc0205204 <files_destroy>
ffffffffc0206122:	b7a5                	j	ffffffffc020608a <do_exit+0x74>
ffffffffc0206124:	00007617          	auipc	a2,0x7
ffffffffc0206128:	2a460613          	addi	a2,a2,676 # ffffffffc020d3c8 <CSWTCH.79+0x120>
ffffffffc020612c:	26100593          	li	a1,609
ffffffffc0206130:	00007517          	auipc	a0,0x7
ffffffffc0206134:	26850513          	addi	a0,a0,616 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206138:	b66fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020613c:	854e                	mv	a0,s3
ffffffffc020613e:	db5fd0ef          	jal	ra,ffffffffc0203ef2 <exit_mmap>
ffffffffc0206142:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc0206146:	995ff0ef          	jal	ra,ffffffffc0205ada <put_pgdir.isra.0>
ffffffffc020614a:	854e                	mv	a0,s3
ffffffffc020614c:	c0bfd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0206150:	b715                	j	ffffffffc0206074 <do_exit+0x5e>
ffffffffc0206152:	00007617          	auipc	a2,0x7
ffffffffc0206156:	28660613          	addi	a2,a2,646 # ffffffffc020d3d8 <CSWTCH.79+0x130>
ffffffffc020615a:	26500593          	li	a1,613
ffffffffc020615e:	00007517          	auipc	a0,0x7
ffffffffc0206162:	23a50513          	addi	a0,a0,570 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206166:	b38fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020616a:	b09fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020616e:	4a05                	li	s4,1
ffffffffc0206170:	b73d                	j	ffffffffc020609e <do_exit+0x88>
ffffffffc0206172:	036010ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc0206176:	bf2d                	j	ffffffffc02060b0 <do_exit+0x9a>

ffffffffc0206178 <do_wait.part.0>:
ffffffffc0206178:	715d                	addi	sp,sp,-80
ffffffffc020617a:	f84a                	sd	s2,48(sp)
ffffffffc020617c:	f44e                	sd	s3,40(sp)
ffffffffc020617e:	80000937          	lui	s2,0x80000
ffffffffc0206182:	6989                	lui	s3,0x2
ffffffffc0206184:	fc26                	sd	s1,56(sp)
ffffffffc0206186:	f052                	sd	s4,32(sp)
ffffffffc0206188:	ec56                	sd	s5,24(sp)
ffffffffc020618a:	e85a                	sd	s6,16(sp)
ffffffffc020618c:	e45e                	sd	s7,8(sp)
ffffffffc020618e:	e486                	sd	ra,72(sp)
ffffffffc0206190:	e0a2                	sd	s0,64(sp)
ffffffffc0206192:	84aa                	mv	s1,a0
ffffffffc0206194:	8a2e                	mv	s4,a1
ffffffffc0206196:	00090b97          	auipc	s7,0x90
ffffffffc020619a:	72ab8b93          	addi	s7,s7,1834 # ffffffffc02968c0 <current>
ffffffffc020619e:	00050b1b          	sext.w	s6,a0
ffffffffc02061a2:	fff50a9b          	addiw	s5,a0,-1
ffffffffc02061a6:	19f9                	addi	s3,s3,-2
ffffffffc02061a8:	0905                	addi	s2,s2,1
ffffffffc02061aa:	ccbd                	beqz	s1,ffffffffc0206228 <do_wait.part.0+0xb0>
ffffffffc02061ac:	0359e863          	bltu	s3,s5,ffffffffc02061dc <do_wait.part.0+0x64>
ffffffffc02061b0:	45a9                	li	a1,10
ffffffffc02061b2:	855a                	mv	a0,s6
ffffffffc02061b4:	4cf040ef          	jal	ra,ffffffffc020ae82 <hash32>
ffffffffc02061b8:	02051793          	slli	a5,a0,0x20
ffffffffc02061bc:	01c7d513          	srli	a0,a5,0x1c
ffffffffc02061c0:	0008b797          	auipc	a5,0x8b
ffffffffc02061c4:	60078793          	addi	a5,a5,1536 # ffffffffc02917c0 <hash_list>
ffffffffc02061c8:	953e                	add	a0,a0,a5
ffffffffc02061ca:	842a                	mv	s0,a0
ffffffffc02061cc:	a029                	j	ffffffffc02061d6 <do_wait.part.0+0x5e>
ffffffffc02061ce:	f2c42783          	lw	a5,-212(s0)
ffffffffc02061d2:	02978163          	beq	a5,s1,ffffffffc02061f4 <do_wait.part.0+0x7c>
ffffffffc02061d6:	6400                	ld	s0,8(s0)
ffffffffc02061d8:	fe851be3          	bne	a0,s0,ffffffffc02061ce <do_wait.part.0+0x56>
ffffffffc02061dc:	5579                	li	a0,-2
ffffffffc02061de:	60a6                	ld	ra,72(sp)
ffffffffc02061e0:	6406                	ld	s0,64(sp)
ffffffffc02061e2:	74e2                	ld	s1,56(sp)
ffffffffc02061e4:	7942                	ld	s2,48(sp)
ffffffffc02061e6:	79a2                	ld	s3,40(sp)
ffffffffc02061e8:	7a02                	ld	s4,32(sp)
ffffffffc02061ea:	6ae2                	ld	s5,24(sp)
ffffffffc02061ec:	6b42                	ld	s6,16(sp)
ffffffffc02061ee:	6ba2                	ld	s7,8(sp)
ffffffffc02061f0:	6161                	addi	sp,sp,80
ffffffffc02061f2:	8082                	ret
ffffffffc02061f4:	000bb683          	ld	a3,0(s7)
ffffffffc02061f8:	f4843783          	ld	a5,-184(s0)
ffffffffc02061fc:	fed790e3          	bne	a5,a3,ffffffffc02061dc <do_wait.part.0+0x64>
ffffffffc0206200:	f2842703          	lw	a4,-216(s0)
ffffffffc0206204:	478d                	li	a5,3
ffffffffc0206206:	0ef70b63          	beq	a4,a5,ffffffffc02062fc <do_wait.part.0+0x184>
ffffffffc020620a:	4785                	li	a5,1
ffffffffc020620c:	c29c                	sw	a5,0(a3)
ffffffffc020620e:	0f26a623          	sw	s2,236(a3)
ffffffffc0206212:	048010ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc0206216:	000bb783          	ld	a5,0(s7)
ffffffffc020621a:	0b07a783          	lw	a5,176(a5)
ffffffffc020621e:	8b85                	andi	a5,a5,1
ffffffffc0206220:	d7c9                	beqz	a5,ffffffffc02061aa <do_wait.part.0+0x32>
ffffffffc0206222:	555d                	li	a0,-9
ffffffffc0206224:	df3ff0ef          	jal	ra,ffffffffc0206016 <do_exit>
ffffffffc0206228:	000bb683          	ld	a3,0(s7)
ffffffffc020622c:	7ae0                	ld	s0,240(a3)
ffffffffc020622e:	d45d                	beqz	s0,ffffffffc02061dc <do_wait.part.0+0x64>
ffffffffc0206230:	470d                	li	a4,3
ffffffffc0206232:	a021                	j	ffffffffc020623a <do_wait.part.0+0xc2>
ffffffffc0206234:	10043403          	ld	s0,256(s0)
ffffffffc0206238:	d869                	beqz	s0,ffffffffc020620a <do_wait.part.0+0x92>
ffffffffc020623a:	401c                	lw	a5,0(s0)
ffffffffc020623c:	fee79ce3          	bne	a5,a4,ffffffffc0206234 <do_wait.part.0+0xbc>
ffffffffc0206240:	00090797          	auipc	a5,0x90
ffffffffc0206244:	6887b783          	ld	a5,1672(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0206248:	0c878963          	beq	a5,s0,ffffffffc020631a <do_wait.part.0+0x1a2>
ffffffffc020624c:	00090797          	auipc	a5,0x90
ffffffffc0206250:	6847b783          	ld	a5,1668(a5) # ffffffffc02968d0 <initproc>
ffffffffc0206254:	0cf40363          	beq	s0,a5,ffffffffc020631a <do_wait.part.0+0x1a2>
ffffffffc0206258:	000a0663          	beqz	s4,ffffffffc0206264 <do_wait.part.0+0xec>
ffffffffc020625c:	0e842783          	lw	a5,232(s0)
ffffffffc0206260:	00fa2023          	sw	a5,0(s4)
ffffffffc0206264:	100027f3          	csrr	a5,sstatus
ffffffffc0206268:	8b89                	andi	a5,a5,2
ffffffffc020626a:	4581                	li	a1,0
ffffffffc020626c:	e7c1                	bnez	a5,ffffffffc02062f4 <do_wait.part.0+0x17c>
ffffffffc020626e:	6c70                	ld	a2,216(s0)
ffffffffc0206270:	7074                	ld	a3,224(s0)
ffffffffc0206272:	10043703          	ld	a4,256(s0)
ffffffffc0206276:	7c7c                	ld	a5,248(s0)
ffffffffc0206278:	e614                	sd	a3,8(a2)
ffffffffc020627a:	e290                	sd	a2,0(a3)
ffffffffc020627c:	6470                	ld	a2,200(s0)
ffffffffc020627e:	6874                	ld	a3,208(s0)
ffffffffc0206280:	e614                	sd	a3,8(a2)
ffffffffc0206282:	e290                	sd	a2,0(a3)
ffffffffc0206284:	c319                	beqz	a4,ffffffffc020628a <do_wait.part.0+0x112>
ffffffffc0206286:	ff7c                	sd	a5,248(a4)
ffffffffc0206288:	7c7c                	ld	a5,248(s0)
ffffffffc020628a:	c3b5                	beqz	a5,ffffffffc02062ee <do_wait.part.0+0x176>
ffffffffc020628c:	10e7b023          	sd	a4,256(a5)
ffffffffc0206290:	00090717          	auipc	a4,0x90
ffffffffc0206294:	64870713          	addi	a4,a4,1608 # ffffffffc02968d8 <nr_process>
ffffffffc0206298:	431c                	lw	a5,0(a4)
ffffffffc020629a:	37fd                	addiw	a5,a5,-1
ffffffffc020629c:	c31c                	sw	a5,0(a4)
ffffffffc020629e:	e5a9                	bnez	a1,ffffffffc02062e8 <do_wait.part.0+0x170>
ffffffffc02062a0:	6814                	ld	a3,16(s0)
ffffffffc02062a2:	c02007b7          	lui	a5,0xc0200
ffffffffc02062a6:	04f6ee63          	bltu	a3,a5,ffffffffc0206302 <do_wait.part.0+0x18a>
ffffffffc02062aa:	00090797          	auipc	a5,0x90
ffffffffc02062ae:	60e7b783          	ld	a5,1550(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc02062b2:	8e9d                	sub	a3,a3,a5
ffffffffc02062b4:	82b1                	srli	a3,a3,0xc
ffffffffc02062b6:	00090797          	auipc	a5,0x90
ffffffffc02062ba:	5ea7b783          	ld	a5,1514(a5) # ffffffffc02968a0 <npage>
ffffffffc02062be:	06f6fa63          	bgeu	a3,a5,ffffffffc0206332 <do_wait.part.0+0x1ba>
ffffffffc02062c2:	00009517          	auipc	a0,0x9
ffffffffc02062c6:	3be53503          	ld	a0,958(a0) # ffffffffc020f680 <nbase>
ffffffffc02062ca:	8e89                	sub	a3,a3,a0
ffffffffc02062cc:	069a                	slli	a3,a3,0x6
ffffffffc02062ce:	00090517          	auipc	a0,0x90
ffffffffc02062d2:	5da53503          	ld	a0,1498(a0) # ffffffffc02968a8 <pages>
ffffffffc02062d6:	9536                	add	a0,a0,a3
ffffffffc02062d8:	4589                	li	a1,2
ffffffffc02062da:	ed1fb0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02062de:	8522                	mv	a0,s0
ffffffffc02062e0:	d5ffb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02062e4:	4501                	li	a0,0
ffffffffc02062e6:	bde5                	j	ffffffffc02061de <do_wait.part.0+0x66>
ffffffffc02062e8:	985fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02062ec:	bf55                	j	ffffffffc02062a0 <do_wait.part.0+0x128>
ffffffffc02062ee:	701c                	ld	a5,32(s0)
ffffffffc02062f0:	fbf8                	sd	a4,240(a5)
ffffffffc02062f2:	bf79                	j	ffffffffc0206290 <do_wait.part.0+0x118>
ffffffffc02062f4:	97ffa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02062f8:	4585                	li	a1,1
ffffffffc02062fa:	bf95                	j	ffffffffc020626e <do_wait.part.0+0xf6>
ffffffffc02062fc:	f2840413          	addi	s0,s0,-216
ffffffffc0206300:	b781                	j	ffffffffc0206240 <do_wait.part.0+0xc8>
ffffffffc0206302:	00006617          	auipc	a2,0x6
ffffffffc0206306:	15e60613          	addi	a2,a2,350 # ffffffffc020c460 <default_pmm_manager+0xe0>
ffffffffc020630a:	07700593          	li	a1,119
ffffffffc020630e:	00006517          	auipc	a0,0x6
ffffffffc0206312:	0d250513          	addi	a0,a0,210 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0206316:	988fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020631a:	00007617          	auipc	a2,0x7
ffffffffc020631e:	0ee60613          	addi	a2,a2,238 # ffffffffc020d408 <CSWTCH.79+0x160>
ffffffffc0206322:	42800593          	li	a1,1064
ffffffffc0206326:	00007517          	auipc	a0,0x7
ffffffffc020632a:	07250513          	addi	a0,a0,114 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc020632e:	970fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206332:	00006617          	auipc	a2,0x6
ffffffffc0206336:	15660613          	addi	a2,a2,342 # ffffffffc020c488 <default_pmm_manager+0x108>
ffffffffc020633a:	06900593          	li	a1,105
ffffffffc020633e:	00006517          	auipc	a0,0x6
ffffffffc0206342:	0a250513          	addi	a0,a0,162 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0206346:	958fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020634a <init_main>:
ffffffffc020634a:	1141                	addi	sp,sp,-16
ffffffffc020634c:	00007517          	auipc	a0,0x7
ffffffffc0206350:	0dc50513          	addi	a0,a0,220 # ffffffffc020d428 <CSWTCH.79+0x180>
ffffffffc0206354:	e406                	sd	ra,8(sp)
ffffffffc0206356:	674010ef          	jal	ra,ffffffffc02079ca <vfs_set_bootfs>
ffffffffc020635a:	e179                	bnez	a0,ffffffffc0206420 <init_main+0xd6>
ffffffffc020635c:	e8ffb0ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0206360:	c2bfb0ef          	jal	ra,ffffffffc0201f8a <kallocated>
ffffffffc0206364:	4601                	li	a2,0
ffffffffc0206366:	4581                	li	a1,0
ffffffffc0206368:	00001517          	auipc	a0,0x1
ffffffffc020636c:	89a50513          	addi	a0,a0,-1894 # ffffffffc0206c02 <user_main>
ffffffffc0206370:	c57ff0ef          	jal	ra,ffffffffc0205fc6 <kernel_thread>
ffffffffc0206374:	00a04563          	bgtz	a0,ffffffffc020637e <init_main+0x34>
ffffffffc0206378:	a841                	j	ffffffffc0206408 <init_main+0xbe>
ffffffffc020637a:	6e1000ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc020637e:	4581                	li	a1,0
ffffffffc0206380:	4501                	li	a0,0
ffffffffc0206382:	df7ff0ef          	jal	ra,ffffffffc0206178 <do_wait.part.0>
ffffffffc0206386:	d975                	beqz	a0,ffffffffc020637a <init_main+0x30>
ffffffffc0206388:	e37fe0ef          	jal	ra,ffffffffc02051be <fs_cleanup>
ffffffffc020638c:	00007517          	auipc	a0,0x7
ffffffffc0206390:	0e450513          	addi	a0,a0,228 # ffffffffc020d470 <CSWTCH.79+0x1c8>
ffffffffc0206394:	e13f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206398:	00090797          	auipc	a5,0x90
ffffffffc020639c:	5387b783          	ld	a5,1336(a5) # ffffffffc02968d0 <initproc>
ffffffffc02063a0:	7bf8                	ld	a4,240(a5)
ffffffffc02063a2:	e339                	bnez	a4,ffffffffc02063e8 <init_main+0x9e>
ffffffffc02063a4:	7ff8                	ld	a4,248(a5)
ffffffffc02063a6:	e329                	bnez	a4,ffffffffc02063e8 <init_main+0x9e>
ffffffffc02063a8:	1007b703          	ld	a4,256(a5)
ffffffffc02063ac:	ef15                	bnez	a4,ffffffffc02063e8 <init_main+0x9e>
ffffffffc02063ae:	00090697          	auipc	a3,0x90
ffffffffc02063b2:	52a6a683          	lw	a3,1322(a3) # ffffffffc02968d8 <nr_process>
ffffffffc02063b6:	4709                	li	a4,2
ffffffffc02063b8:	0ce69163          	bne	a3,a4,ffffffffc020647a <init_main+0x130>
ffffffffc02063bc:	0008f717          	auipc	a4,0x8f
ffffffffc02063c0:	40470713          	addi	a4,a4,1028 # ffffffffc02957c0 <proc_list>
ffffffffc02063c4:	6714                	ld	a3,8(a4)
ffffffffc02063c6:	0c878793          	addi	a5,a5,200
ffffffffc02063ca:	08d79863          	bne	a5,a3,ffffffffc020645a <init_main+0x110>
ffffffffc02063ce:	6318                	ld	a4,0(a4)
ffffffffc02063d0:	06e79563          	bne	a5,a4,ffffffffc020643a <init_main+0xf0>
ffffffffc02063d4:	00007517          	auipc	a0,0x7
ffffffffc02063d8:	18450513          	addi	a0,a0,388 # ffffffffc020d558 <CSWTCH.79+0x2b0>
ffffffffc02063dc:	dcbf90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02063e0:	60a2                	ld	ra,8(sp)
ffffffffc02063e2:	4501                	li	a0,0
ffffffffc02063e4:	0141                	addi	sp,sp,16
ffffffffc02063e6:	8082                	ret
ffffffffc02063e8:	00007697          	auipc	a3,0x7
ffffffffc02063ec:	0b068693          	addi	a3,a3,176 # ffffffffc020d498 <CSWTCH.79+0x1f0>
ffffffffc02063f0:	00005617          	auipc	a2,0x5
ffffffffc02063f4:	4a860613          	addi	a2,a2,1192 # ffffffffc020b898 <commands+0x210>
ffffffffc02063f8:	49e00593          	li	a1,1182
ffffffffc02063fc:	00007517          	auipc	a0,0x7
ffffffffc0206400:	f9c50513          	addi	a0,a0,-100 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206404:	89afa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206408:	00007617          	auipc	a2,0x7
ffffffffc020640c:	04860613          	addi	a2,a2,72 # ffffffffc020d450 <CSWTCH.79+0x1a8>
ffffffffc0206410:	49100593          	li	a1,1169
ffffffffc0206414:	00007517          	auipc	a0,0x7
ffffffffc0206418:	f8450513          	addi	a0,a0,-124 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc020641c:	882fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206420:	86aa                	mv	a3,a0
ffffffffc0206422:	00007617          	auipc	a2,0x7
ffffffffc0206426:	00e60613          	addi	a2,a2,14 # ffffffffc020d430 <CSWTCH.79+0x188>
ffffffffc020642a:	48900593          	li	a1,1161
ffffffffc020642e:	00007517          	auipc	a0,0x7
ffffffffc0206432:	f6a50513          	addi	a0,a0,-150 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206436:	868fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020643a:	00007697          	auipc	a3,0x7
ffffffffc020643e:	0ee68693          	addi	a3,a3,238 # ffffffffc020d528 <CSWTCH.79+0x280>
ffffffffc0206442:	00005617          	auipc	a2,0x5
ffffffffc0206446:	45660613          	addi	a2,a2,1110 # ffffffffc020b898 <commands+0x210>
ffffffffc020644a:	4a100593          	li	a1,1185
ffffffffc020644e:	00007517          	auipc	a0,0x7
ffffffffc0206452:	f4a50513          	addi	a0,a0,-182 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206456:	848fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020645a:	00007697          	auipc	a3,0x7
ffffffffc020645e:	09e68693          	addi	a3,a3,158 # ffffffffc020d4f8 <CSWTCH.79+0x250>
ffffffffc0206462:	00005617          	auipc	a2,0x5
ffffffffc0206466:	43660613          	addi	a2,a2,1078 # ffffffffc020b898 <commands+0x210>
ffffffffc020646a:	4a000593          	li	a1,1184
ffffffffc020646e:	00007517          	auipc	a0,0x7
ffffffffc0206472:	f2a50513          	addi	a0,a0,-214 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206476:	828fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020647a:	00007697          	auipc	a3,0x7
ffffffffc020647e:	06e68693          	addi	a3,a3,110 # ffffffffc020d4e8 <CSWTCH.79+0x240>
ffffffffc0206482:	00005617          	auipc	a2,0x5
ffffffffc0206486:	41660613          	addi	a2,a2,1046 # ffffffffc020b898 <commands+0x210>
ffffffffc020648a:	49f00593          	li	a1,1183
ffffffffc020648e:	00007517          	auipc	a0,0x7
ffffffffc0206492:	f0a50513          	addi	a0,a0,-246 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206496:	808fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020649a <do_execve>:
ffffffffc020649a:	cb010113          	addi	sp,sp,-848
ffffffffc020649e:	33313423          	sd	s3,808(sp)
ffffffffc02064a2:	00090997          	auipc	s3,0x90
ffffffffc02064a6:	41e98993          	addi	s3,s3,1054 # ffffffffc02968c0 <current>
ffffffffc02064aa:	0009b683          	ld	a3,0(s3)
ffffffffc02064ae:	fff5871b          	addiw	a4,a1,-1
ffffffffc02064b2:	31613823          	sd	s6,784(sp)
ffffffffc02064b6:	34113423          	sd	ra,840(sp)
ffffffffc02064ba:	34813023          	sd	s0,832(sp)
ffffffffc02064be:	32913c23          	sd	s1,824(sp)
ffffffffc02064c2:	33213823          	sd	s2,816(sp)
ffffffffc02064c6:	33413023          	sd	s4,800(sp)
ffffffffc02064ca:	31513c23          	sd	s5,792(sp)
ffffffffc02064ce:	31713423          	sd	s7,776(sp)
ffffffffc02064d2:	31813023          	sd	s8,768(sp)
ffffffffc02064d6:	2f913c23          	sd	s9,760(sp)
ffffffffc02064da:	2fa13823          	sd	s10,752(sp)
ffffffffc02064de:	2fb13423          	sd	s11,744(sp)
ffffffffc02064e2:	d43a                	sw	a4,40(sp)
ffffffffc02064e4:	47fd                	li	a5,31
ffffffffc02064e6:	0286bb03          	ld	s6,40(a3)
ffffffffc02064ea:	5ae7e363          	bltu	a5,a4,ffffffffc0206a90 <do_execve+0x5f6>
ffffffffc02064ee:	84ae                	mv	s1,a1
ffffffffc02064f0:	842a                	mv	s0,a0
ffffffffc02064f2:	8bb2                	mv	s7,a2
ffffffffc02064f4:	4581                	li	a1,0
ffffffffc02064f6:	4641                	li	a2,16
ffffffffc02064f8:	08a8                	addi	a0,sp,88
ffffffffc02064fa:	6bd040ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc02064fe:	000b0c63          	beqz	s6,ffffffffc0206516 <do_execve+0x7c>
ffffffffc0206502:	038b0513          	addi	a0,s6,56
ffffffffc0206506:	85efe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020650a:	0009b783          	ld	a5,0(s3)
ffffffffc020650e:	c781                	beqz	a5,ffffffffc0206516 <do_execve+0x7c>
ffffffffc0206510:	43dc                	lw	a5,4(a5)
ffffffffc0206512:	04fb2823          	sw	a5,80(s6)
ffffffffc0206516:	3e040e63          	beqz	s0,ffffffffc0206912 <do_execve+0x478>
ffffffffc020651a:	46c1                	li	a3,16
ffffffffc020651c:	8622                	mv	a2,s0
ffffffffc020651e:	08ac                	addi	a1,sp,88
ffffffffc0206520:	855a                	mv	a0,s6
ffffffffc0206522:	e6bfd0ef          	jal	ra,ffffffffc020438c <copy_string>
ffffffffc0206526:	5e050763          	beqz	a0,ffffffffc0206b14 <do_execve+0x67a>
ffffffffc020652a:	00349793          	slli	a5,s1,0x3
ffffffffc020652e:	4681                	li	a3,0
ffffffffc0206530:	863e                	mv	a2,a5
ffffffffc0206532:	85de                	mv	a1,s7
ffffffffc0206534:	855a                	mv	a0,s6
ffffffffc0206536:	e43e                	sd	a5,8(sp)
ffffffffc0206538:	d5bfd0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc020653c:	8a5e                	mv	s4,s7
ffffffffc020653e:	5c050763          	beqz	a0,ffffffffc0206b0c <do_execve+0x672>
ffffffffc0206542:	0e010a93          	addi	s5,sp,224
ffffffffc0206546:	4401                	li	s0,0
ffffffffc0206548:	a011                	j	ffffffffc020654c <do_execve+0xb2>
ffffffffc020654a:	846e                	mv	s0,s11
ffffffffc020654c:	6505                	lui	a0,0x1
ffffffffc020654e:	a41fb0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0206552:	892a                	mv	s2,a0
ffffffffc0206554:	36050963          	beqz	a0,ffffffffc02068c6 <do_execve+0x42c>
ffffffffc0206558:	000a3603          	ld	a2,0(s4)
ffffffffc020655c:	85aa                	mv	a1,a0
ffffffffc020655e:	6685                	lui	a3,0x1
ffffffffc0206560:	855a                	mv	a0,s6
ffffffffc0206562:	e2bfd0ef          	jal	ra,ffffffffc020438c <copy_string>
ffffffffc0206566:	3a050163          	beqz	a0,ffffffffc0206908 <do_execve+0x46e>
ffffffffc020656a:	012ab023          	sd	s2,0(s5)
ffffffffc020656e:	00140d9b          	addiw	s11,s0,1
ffffffffc0206572:	0aa1                	addi	s5,s5,8
ffffffffc0206574:	0a21                	addi	s4,s4,8
ffffffffc0206576:	fdb49ae3          	bne	s1,s11,ffffffffc020654a <do_execve+0xb0>
ffffffffc020657a:	000bb903          	ld	s2,0(s7)
ffffffffc020657e:	2e0b0b63          	beqz	s6,ffffffffc0206874 <do_execve+0x3da>
ffffffffc0206582:	038b0513          	addi	a0,s6,56
ffffffffc0206586:	fdbfd0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020658a:	0009b703          	ld	a4,0(s3)
ffffffffc020658e:	040b2823          	sw	zero,80(s6)
ffffffffc0206592:	14873503          	ld	a0,328(a4)
ffffffffc0206596:	d05fe0ef          	jal	ra,ffffffffc020529a <files_closeall>
ffffffffc020659a:	4581                	li	a1,0
ffffffffc020659c:	854a                	mv	a0,s2
ffffffffc020659e:	f89fe0ef          	jal	ra,ffffffffc0205526 <sysfile_open>
ffffffffc02065a2:	8aaa                	mv	s5,a0
ffffffffc02065a4:	2e054a63          	bltz	a0,ffffffffc0206898 <do_execve+0x3fe>
ffffffffc02065a8:	00090717          	auipc	a4,0x90
ffffffffc02065ac:	2e873703          	ld	a4,744(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc02065b0:	56fd                	li	a3,-1
ffffffffc02065b2:	16fe                	slli	a3,a3,0x3f
ffffffffc02065b4:	8331                	srli	a4,a4,0xc
ffffffffc02065b6:	8f55                	or	a4,a4,a3
ffffffffc02065b8:	18071073          	csrw	satp,a4
ffffffffc02065bc:	030b2703          	lw	a4,48(s6)
ffffffffc02065c0:	fff7069b          	addiw	a3,a4,-1
ffffffffc02065c4:	02db2823          	sw	a3,48(s6)
ffffffffc02065c8:	36068a63          	beqz	a3,ffffffffc020693c <do_execve+0x4a2>
ffffffffc02065cc:	0009b703          	ld	a4,0(s3)
ffffffffc02065d0:	02073423          	sd	zero,40(a4)
ffffffffc02065d4:	e34fd0ef          	jal	ra,ffffffffc0203c08 <mm_create>
ffffffffc02065d8:	8a2a                	mv	s4,a0
ffffffffc02065da:	2a050e63          	beqz	a0,ffffffffc0206896 <do_execve+0x3fc>
ffffffffc02065de:	4505                	li	a0,1
ffffffffc02065e0:	b8dfb0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02065e4:	2a050663          	beqz	a0,ffffffffc0206890 <do_execve+0x3f6>
ffffffffc02065e8:	00090d17          	auipc	s10,0x90
ffffffffc02065ec:	2c0d0d13          	addi	s10,s10,704 # ffffffffc02968a8 <pages>
ffffffffc02065f0:	000d3683          	ld	a3,0(s10)
ffffffffc02065f4:	00090c97          	auipc	s9,0x90
ffffffffc02065f8:	2acc8c93          	addi	s9,s9,684 # ffffffffc02968a0 <npage>
ffffffffc02065fc:	00009797          	auipc	a5,0x9
ffffffffc0206600:	0847b783          	ld	a5,132(a5) # ffffffffc020f680 <nbase>
ffffffffc0206604:	40d506b3          	sub	a3,a0,a3
ffffffffc0206608:	567d                	li	a2,-1
ffffffffc020660a:	8699                	srai	a3,a3,0x6
ffffffffc020660c:	000cb703          	ld	a4,0(s9)
ffffffffc0206610:	96be                	add	a3,a3,a5
ffffffffc0206612:	e83e                	sd	a5,16(sp)
ffffffffc0206614:	00c65793          	srli	a5,a2,0xc
ffffffffc0206618:	00f6f633          	and	a2,a3,a5
ffffffffc020661c:	e03e                	sd	a5,0(sp)
ffffffffc020661e:	06b2                	slli	a3,a3,0xc
ffffffffc0206620:	50e67c63          	bgeu	a2,a4,ffffffffc0206b38 <do_execve+0x69e>
ffffffffc0206624:	00090c17          	auipc	s8,0x90
ffffffffc0206628:	294c0c13          	addi	s8,s8,660 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020662c:	000c3903          	ld	s2,0(s8)
ffffffffc0206630:	6605                	lui	a2,0x1
ffffffffc0206632:	00090597          	auipc	a1,0x90
ffffffffc0206636:	2665b583          	ld	a1,614(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc020663a:	9936                	add	s2,s2,a3
ffffffffc020663c:	854a                	mv	a0,s2
ffffffffc020663e:	5cb040ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc0206642:	4681                	li	a3,0
ffffffffc0206644:	012a3c23          	sd	s2,24(s4)
ffffffffc0206648:	04000613          	li	a2,64
ffffffffc020664c:	110c                	addi	a1,sp,160
ffffffffc020664e:	8556                	mv	a0,s5
ffffffffc0206650:	c2cff0ef          	jal	ra,ffffffffc0205a7c <load_icode_read>
ffffffffc0206654:	892a                	mv	s2,a0
ffffffffc0206656:	3c051663          	bnez	a0,ffffffffc0206a22 <do_execve+0x588>
ffffffffc020665a:	568a                	lw	a3,160(sp)
ffffffffc020665c:	464c4737          	lui	a4,0x464c4
ffffffffc0206660:	57f70713          	addi	a4,a4,1407 # 464c457f <_binary_bin_sfs_img_size+0x4644f27f>
ffffffffc0206664:	2ce69363          	bne	a3,a4,ffffffffc020692a <do_execve+0x490>
ffffffffc0206668:	0d815703          	lhu	a4,216(sp)
ffffffffc020666c:	f002                	sd	zero,32(sp)
ffffffffc020666e:	c331                	beqz	a4,ffffffffc02066b2 <do_execve+0x218>
ffffffffc0206670:	e0ee                	sd	s11,64(sp)
ffffffffc0206672:	e4a2                	sd	s0,72(sp)
ffffffffc0206674:	f82a                	sd	a0,48(sp)
ffffffffc0206676:	fc26                	sd	s1,56(sp)
ffffffffc0206678:	668e                	ld	a3,192(sp)
ffffffffc020667a:	7782                	ld	a5,32(sp)
ffffffffc020667c:	03800613          	li	a2,56
ffffffffc0206680:	10ac                	addi	a1,sp,104
ffffffffc0206682:	96be                	add	a3,a3,a5
ffffffffc0206684:	8556                	mv	a0,s5
ffffffffc0206686:	bf6ff0ef          	jal	ra,ffffffffc0205a7c <load_icode_read>
ffffffffc020668a:	3a051663          	bnez	a0,ffffffffc0206a36 <do_execve+0x59c>
ffffffffc020668e:	57a6                	lw	a5,104(sp)
ffffffffc0206690:	4705                	li	a4,1
ffffffffc0206692:	2ce78063          	beq	a5,a4,ffffffffc0206952 <do_execve+0x4b8>
ffffffffc0206696:	7742                	ld	a4,48(sp)
ffffffffc0206698:	7682                	ld	a3,32(sp)
ffffffffc020669a:	0d815783          	lhu	a5,216(sp)
ffffffffc020669e:	2705                	addiw	a4,a4,1
ffffffffc02066a0:	03868693          	addi	a3,a3,56 # 1038 <_binary_bin_swap_img_size-0x6cc8>
ffffffffc02066a4:	f83a                	sd	a4,48(sp)
ffffffffc02066a6:	f036                	sd	a3,32(sp)
ffffffffc02066a8:	fcf748e3          	blt	a4,a5,ffffffffc0206678 <do_execve+0x1de>
ffffffffc02066ac:	6d86                	ld	s11,64(sp)
ffffffffc02066ae:	6426                	ld	s0,72(sp)
ffffffffc02066b0:	74e2                	ld	s1,56(sp)
ffffffffc02066b2:	4701                	li	a4,0
ffffffffc02066b4:	46ad                	li	a3,11
ffffffffc02066b6:	00100637          	lui	a2,0x100
ffffffffc02066ba:	7ff005b7          	lui	a1,0x7ff00
ffffffffc02066be:	8552                	mv	a0,s4
ffffffffc02066c0:	ee8fd0ef          	jal	ra,ffffffffc0203da8 <mm_map>
ffffffffc02066c4:	892a                	mv	s2,a0
ffffffffc02066c6:	34051b63          	bnez	a0,ffffffffc0206a1c <do_execve+0x582>
ffffffffc02066ca:	018a3503          	ld	a0,24(s4)
ffffffffc02066ce:	467d                	li	a2,31
ffffffffc02066d0:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc02066d4:	c4efd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc02066d8:	4a050963          	beqz	a0,ffffffffc0206b8a <do_execve+0x6f0>
ffffffffc02066dc:	018a3503          	ld	a0,24(s4)
ffffffffc02066e0:	467d                	li	a2,31
ffffffffc02066e2:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc02066e6:	c3cfd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc02066ea:	48050063          	beqz	a0,ffffffffc0206b6a <do_execve+0x6d0>
ffffffffc02066ee:	018a3503          	ld	a0,24(s4)
ffffffffc02066f2:	467d                	li	a2,31
ffffffffc02066f4:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc02066f8:	c2afd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc02066fc:	4c050763          	beqz	a0,ffffffffc0206bca <do_execve+0x730>
ffffffffc0206700:	018a3503          	ld	a0,24(s4)
ffffffffc0206704:	467d                	li	a2,31
ffffffffc0206706:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc020670a:	c18fd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc020670e:	48050e63          	beqz	a0,ffffffffc0206baa <do_execve+0x710>
ffffffffc0206712:	030a2703          	lw	a4,48(s4)
ffffffffc0206716:	0009b603          	ld	a2,0(s3)
ffffffffc020671a:	018a3683          	ld	a3,24(s4)
ffffffffc020671e:	2705                	addiw	a4,a4,1
ffffffffc0206720:	02ea2823          	sw	a4,48(s4)
ffffffffc0206724:	03463423          	sd	s4,40(a2) # 100028 <_binary_bin_sfs_img_size+0x8ad28>
ffffffffc0206728:	c0200737          	lui	a4,0xc0200
ffffffffc020672c:	4ae6ef63          	bltu	a3,a4,ffffffffc0206bea <do_execve+0x750>
ffffffffc0206730:	000c3703          	ld	a4,0(s8)
ffffffffc0206734:	8e99                	sub	a3,a3,a4
ffffffffc0206736:	00c6d713          	srli	a4,a3,0xc
ffffffffc020673a:	f654                	sd	a3,168(a2)
ffffffffc020673c:	56fd                	li	a3,-1
ffffffffc020673e:	16fe                	slli	a3,a3,0x3f
ffffffffc0206740:	8f55                	or	a4,a4,a3
ffffffffc0206742:	18071073          	csrw	satp,a4
ffffffffc0206746:	4a05                	li	s4,1
ffffffffc0206748:	1e010b93          	addi	s7,sp,480
ffffffffc020674c:	0e010b13          	addi	s6,sp,224
ffffffffc0206750:	4a81                	li	s5,0
ffffffffc0206752:	0a7e                	slli	s4,s4,0x1f
ffffffffc0206754:	000b3c03          	ld	s8,0(s6)
ffffffffc0206758:	0ba1                	addi	s7,s7,8
ffffffffc020675a:	0b21                	addi	s6,s6,8
ffffffffc020675c:	8562                	mv	a0,s8
ffffffffc020675e:	3b7040ef          	jal	ra,ffffffffc020b314 <strlen>
ffffffffc0206762:	0015079b          	addiw	a5,a0,1
ffffffffc0206766:	40fa0a33          	sub	s4,s4,a5
ffffffffc020676a:	85e2                	mv	a1,s8
ffffffffc020676c:	8552                	mv	a0,s4
ffffffffc020676e:	3dd040ef          	jal	ra,ffffffffc020b34a <strcpy>
ffffffffc0206772:	87d6                	mv	a5,s5
ffffffffc0206774:	ff4bbc23          	sd	s4,-8(s7)
ffffffffc0206778:	2a85                	addiw	s5,s5,1
ffffffffc020677a:	fc87cde3          	blt	a5,s0,ffffffffc0206754 <do_execve+0x2ba>
ffffffffc020677e:	02816703          	lwu	a4,40(sp)
ffffffffc0206782:	67a2                	ld	a5,8(sp)
ffffffffc0206784:	ff8a7693          	andi	a3,s4,-8
ffffffffc0206788:	00371a13          	slli	s4,a4,0x3
ffffffffc020678c:	ff868a93          	addi	s5,a3,-8
ffffffffc0206790:	41468533          	sub	a0,a3,s4
ffffffffc0206794:	fe06bc23          	sd	zero,-8(a3)
ffffffffc0206798:	1541                	addi	a0,a0,-16
ffffffffc020679a:	40d786b3          	sub	a3,a5,a3
ffffffffc020679e:	8656                	mv	a2,s5
ffffffffc02067a0:	1661                	addi	a2,a2,-8
ffffffffc02067a2:	00d607b3          	add	a5,a2,a3
ffffffffc02067a6:	138c                	addi	a1,sp,480
ffffffffc02067a8:	97ae                	add	a5,a5,a1
ffffffffc02067aa:	679c                	ld	a5,8(a5)
ffffffffc02067ac:	e21c                	sd	a5,0(a2)
ffffffffc02067ae:	fea619e3          	bne	a2,a0,ffffffffc02067a0 <do_execve+0x306>
ffffffffc02067b2:	0009b683          	ld	a3,0(s3)
ffffffffc02067b6:	40e00733          	neg	a4,a4
ffffffffc02067ba:	070e                	slli	a4,a4,0x3
ffffffffc02067bc:	0a06bb03          	ld	s6,160(a3)
ffffffffc02067c0:	ff070413          	addi	s0,a4,-16 # ffffffffc01ffff0 <_binary_bin_sfs_img_size+0xffffffffc018acf0>
ffffffffc02067c4:	9456                	add	s0,s0,s5
ffffffffc02067c6:	1761                	addi	a4,a4,-8
ffffffffc02067c8:	01b42023          	sw	s11,0(s0)
ffffffffc02067cc:	12000613          	li	a2,288
ffffffffc02067d0:	4581                	li	a1,0
ffffffffc02067d2:	855a                	mv	a0,s6
ffffffffc02067d4:	9aba                	add	s5,s5,a4
ffffffffc02067d6:	3e1040ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc02067da:	77ea                	ld	a5,184(sp)
ffffffffc02067dc:	008b3823          	sd	s0,16(s6)
ffffffffc02067e0:	10fb3423          	sd	a5,264(s6)
ffffffffc02067e4:	10002773          	csrr	a4,sstatus
ffffffffc02067e8:	66a2                	ld	a3,8(sp)
ffffffffc02067ea:	edf77713          	andi	a4,a4,-289
ffffffffc02067ee:	02076713          	ori	a4,a4,32
ffffffffc02067f2:	fff48413          	addi	s0,s1,-1
ffffffffc02067f6:	099c                	addi	a5,sp,208
ffffffffc02067f8:	040e                	slli	s0,s0,0x3
ffffffffc02067fa:	97b6                	add	a5,a5,a3
ffffffffc02067fc:	10eb3023          	sd	a4,256(s6)
ffffffffc0206800:	1198                	addi	a4,sp,224
ffffffffc0206802:	049b3823          	sd	s1,80(s6)
ffffffffc0206806:	055b3c23          	sd	s5,88(s6)
ffffffffc020680a:	943a                	add	s0,s0,a4
ffffffffc020680c:	41478a33          	sub	s4,a5,s4
ffffffffc0206810:	6008                	ld	a0,0(s0)
ffffffffc0206812:	1461                	addi	s0,s0,-8
ffffffffc0206814:	82bfb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206818:	fe8a1ce3          	bne	s4,s0,ffffffffc0206810 <do_execve+0x376>
ffffffffc020681c:	0009b403          	ld	s0,0(s3)
ffffffffc0206820:	4641                	li	a2,16
ffffffffc0206822:	4581                	li	a1,0
ffffffffc0206824:	0b440413          	addi	s0,s0,180
ffffffffc0206828:	8522                	mv	a0,s0
ffffffffc020682a:	38d040ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc020682e:	463d                	li	a2,15
ffffffffc0206830:	08ac                	addi	a1,sp,88
ffffffffc0206832:	8522                	mv	a0,s0
ffffffffc0206834:	3d5040ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc0206838:	34813083          	ld	ra,840(sp)
ffffffffc020683c:	34013403          	ld	s0,832(sp)
ffffffffc0206840:	33813483          	ld	s1,824(sp)
ffffffffc0206844:	32813983          	ld	s3,808(sp)
ffffffffc0206848:	32013a03          	ld	s4,800(sp)
ffffffffc020684c:	31813a83          	ld	s5,792(sp)
ffffffffc0206850:	31013b03          	ld	s6,784(sp)
ffffffffc0206854:	30813b83          	ld	s7,776(sp)
ffffffffc0206858:	30013c03          	ld	s8,768(sp)
ffffffffc020685c:	2f813c83          	ld	s9,760(sp)
ffffffffc0206860:	2f013d03          	ld	s10,752(sp)
ffffffffc0206864:	2e813d83          	ld	s11,744(sp)
ffffffffc0206868:	854a                	mv	a0,s2
ffffffffc020686a:	33013903          	ld	s2,816(sp)
ffffffffc020686e:	35010113          	addi	sp,sp,848
ffffffffc0206872:	8082                	ret
ffffffffc0206874:	0009b703          	ld	a4,0(s3)
ffffffffc0206878:	14873503          	ld	a0,328(a4)
ffffffffc020687c:	a1ffe0ef          	jal	ra,ffffffffc020529a <files_closeall>
ffffffffc0206880:	4581                	li	a1,0
ffffffffc0206882:	854a                	mv	a0,s2
ffffffffc0206884:	ca3fe0ef          	jal	ra,ffffffffc0205526 <sysfile_open>
ffffffffc0206888:	8aaa                	mv	s5,a0
ffffffffc020688a:	d40555e3          	bgez	a0,ffffffffc02065d4 <do_execve+0x13a>
ffffffffc020688e:	a029                	j	ffffffffc0206898 <do_execve+0x3fe>
ffffffffc0206890:	8552                	mv	a0,s4
ffffffffc0206892:	cc4fd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0206896:	5af1                	li	s5,-4
ffffffffc0206898:	67a2                	ld	a5,8(sp)
ffffffffc020689a:	fff48413          	addi	s0,s1,-1
ffffffffc020689e:	0984                	addi	s1,sp,208
ffffffffc02068a0:	94be                	add	s1,s1,a5
ffffffffc02068a2:	77a2                	ld	a5,40(sp)
ffffffffc02068a4:	040e                	slli	s0,s0,0x3
ffffffffc02068a6:	02079713          	slli	a4,a5,0x20
ffffffffc02068aa:	01d75793          	srli	a5,a4,0x1d
ffffffffc02068ae:	1198                	addi	a4,sp,224
ffffffffc02068b0:	943a                	add	s0,s0,a4
ffffffffc02068b2:	8c9d                	sub	s1,s1,a5
ffffffffc02068b4:	6008                	ld	a0,0(s0)
ffffffffc02068b6:	1461                	addi	s0,s0,-8
ffffffffc02068b8:	f86fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02068bc:	fe849ce3          	bne	s1,s0,ffffffffc02068b4 <do_execve+0x41a>
ffffffffc02068c0:	8556                	mv	a0,s5
ffffffffc02068c2:	f54ff0ef          	jal	ra,ffffffffc0206016 <do_exit>
ffffffffc02068c6:	5971                	li	s2,-4
ffffffffc02068c8:	c41d                	beqz	s0,ffffffffc02068f6 <do_execve+0x45c>
ffffffffc02068ca:	fff40493          	addi	s1,s0,-1
ffffffffc02068ce:	00341793          	slli	a5,s0,0x3
ffffffffc02068d2:	0998                	addi	a4,sp,208
ffffffffc02068d4:	347d                	addiw	s0,s0,-1
ffffffffc02068d6:	97ba                	add	a5,a5,a4
ffffffffc02068d8:	02041713          	slli	a4,s0,0x20
ffffffffc02068dc:	01d75413          	srli	s0,a4,0x1d
ffffffffc02068e0:	048e                	slli	s1,s1,0x3
ffffffffc02068e2:	1198                	addi	a4,sp,224
ffffffffc02068e4:	94ba                	add	s1,s1,a4
ffffffffc02068e6:	40878433          	sub	s0,a5,s0
ffffffffc02068ea:	6088                	ld	a0,0(s1)
ffffffffc02068ec:	14e1                	addi	s1,s1,-8
ffffffffc02068ee:	f50fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02068f2:	fe849ce3          	bne	s1,s0,ffffffffc02068ea <do_execve+0x450>
ffffffffc02068f6:	f40b01e3          	beqz	s6,ffffffffc0206838 <do_execve+0x39e>
ffffffffc02068fa:	038b0513          	addi	a0,s6,56
ffffffffc02068fe:	c63fd0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0206902:	040b2823          	sw	zero,80(s6)
ffffffffc0206906:	bf0d                	j	ffffffffc0206838 <do_execve+0x39e>
ffffffffc0206908:	854a                	mv	a0,s2
ffffffffc020690a:	f34fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020690e:	5975                	li	s2,-3
ffffffffc0206910:	bf65                	j	ffffffffc02068c8 <do_execve+0x42e>
ffffffffc0206912:	0009b783          	ld	a5,0(s3)
ffffffffc0206916:	00007617          	auipc	a2,0x7
ffffffffc020691a:	c6260613          	addi	a2,a2,-926 # ffffffffc020d578 <CSWTCH.79+0x2d0>
ffffffffc020691e:	45c1                	li	a1,16
ffffffffc0206920:	43d4                	lw	a3,4(a5)
ffffffffc0206922:	08a8                	addi	a0,sp,88
ffffffffc0206924:	1a3040ef          	jal	ra,ffffffffc020b2c6 <snprintf>
ffffffffc0206928:	b109                	j	ffffffffc020652a <do_execve+0x90>
ffffffffc020692a:	018a3503          	ld	a0,24(s4)
ffffffffc020692e:	5ae1                	li	s5,-8
ffffffffc0206930:	9aaff0ef          	jal	ra,ffffffffc0205ada <put_pgdir.isra.0>
ffffffffc0206934:	8552                	mv	a0,s4
ffffffffc0206936:	c20fd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc020693a:	bfb9                	j	ffffffffc0206898 <do_execve+0x3fe>
ffffffffc020693c:	855a                	mv	a0,s6
ffffffffc020693e:	db4fd0ef          	jal	ra,ffffffffc0203ef2 <exit_mmap>
ffffffffc0206942:	018b3503          	ld	a0,24(s6)
ffffffffc0206946:	994ff0ef          	jal	ra,ffffffffc0205ada <put_pgdir.isra.0>
ffffffffc020694a:	855a                	mv	a0,s6
ffffffffc020694c:	c0afd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0206950:	b9b5                	j	ffffffffc02065cc <do_execve+0x132>
ffffffffc0206952:	664a                	ld	a2,144(sp)
ffffffffc0206954:	67aa                	ld	a5,136(sp)
ffffffffc0206956:	1cf66d63          	bltu	a2,a5,ffffffffc0206b30 <do_execve+0x696>
ffffffffc020695a:	57b6                	lw	a5,108(sp)
ffffffffc020695c:	0017f693          	andi	a3,a5,1
ffffffffc0206960:	c291                	beqz	a3,ffffffffc0206964 <do_execve+0x4ca>
ffffffffc0206962:	4691                	li	a3,4
ffffffffc0206964:	0027f713          	andi	a4,a5,2
ffffffffc0206968:	8b91                	andi	a5,a5,4
ffffffffc020696a:	cb01                	beqz	a4,ffffffffc020697a <do_execve+0x4e0>
ffffffffc020696c:	0026e693          	ori	a3,a3,2
ffffffffc0206970:	4b45                	li	s6,17
ffffffffc0206972:	e791                	bnez	a5,ffffffffc020697e <do_execve+0x4e4>
ffffffffc0206974:	004b6b13          	ori	s6,s6,4
ffffffffc0206978:	a809                	j	ffffffffc020698a <do_execve+0x4f0>
ffffffffc020697a:	4b45                	li	s6,17
ffffffffc020697c:	c781                	beqz	a5,ffffffffc0206984 <do_execve+0x4ea>
ffffffffc020697e:	0016e693          	ori	a3,a3,1
ffffffffc0206982:	4b4d                	li	s6,19
ffffffffc0206984:	0026f793          	andi	a5,a3,2
ffffffffc0206988:	f7f5                	bnez	a5,ffffffffc0206974 <do_execve+0x4da>
ffffffffc020698a:	0046f793          	andi	a5,a3,4
ffffffffc020698e:	c399                	beqz	a5,ffffffffc0206994 <do_execve+0x4fa>
ffffffffc0206990:	008b6b13          	ori	s6,s6,8
ffffffffc0206994:	75e6                	ld	a1,120(sp)
ffffffffc0206996:	4701                	li	a4,0
ffffffffc0206998:	8552                	mv	a0,s4
ffffffffc020699a:	c0efd0ef          	jal	ra,ffffffffc0203da8 <mm_map>
ffffffffc020699e:	ed41                	bnez	a0,ffffffffc0206a36 <do_execve+0x59c>
ffffffffc02069a0:	7be6                	ld	s7,120(sp)
ffffffffc02069a2:	64aa                	ld	s1,136(sp)
ffffffffc02069a4:	77fd                	lui	a5,0xfffff
ffffffffc02069a6:	7446                	ld	s0,112(sp)
ffffffffc02069a8:	94de                	add	s1,s1,s7
ffffffffc02069aa:	00fbf933          	and	s2,s7,a5
ffffffffc02069ae:	169bff63          	bgeu	s7,s1,ffffffffc0206b2c <do_execve+0x692>
ffffffffc02069b2:	ec52                	sd	s4,24(sp)
ffffffffc02069b4:	a889                	j	ffffffffc0206a06 <do_execve+0x56c>
ffffffffc02069b6:	6785                	lui	a5,0x1
ffffffffc02069b8:	412b85b3          	sub	a1,s7,s2
ffffffffc02069bc:	993e                	add	s2,s2,a5
ffffffffc02069be:	40b78a33          	sub	s4,a5,a1
ffffffffc02069c2:	0124f563          	bgeu	s1,s2,ffffffffc02069cc <do_execve+0x532>
ffffffffc02069c6:	412487b3          	sub	a5,s1,s2
ffffffffc02069ca:	9a3e                	add	s4,s4,a5
ffffffffc02069cc:	000d3783          	ld	a5,0(s10)
ffffffffc02069d0:	6742                	ld	a4,16(sp)
ffffffffc02069d2:	000cb683          	ld	a3,0(s9)
ffffffffc02069d6:	40fd87b3          	sub	a5,s11,a5
ffffffffc02069da:	8799                	srai	a5,a5,0x6
ffffffffc02069dc:	97ba                	add	a5,a5,a4
ffffffffc02069de:	6702                	ld	a4,0(sp)
ffffffffc02069e0:	00e7f533          	and	a0,a5,a4
ffffffffc02069e4:	07b2                	slli	a5,a5,0xc
ffffffffc02069e6:	14d57863          	bgeu	a0,a3,ffffffffc0206b36 <do_execve+0x69c>
ffffffffc02069ea:	000c3503          	ld	a0,0(s8)
ffffffffc02069ee:	86a2                	mv	a3,s0
ffffffffc02069f0:	8652                	mv	a2,s4
ffffffffc02069f2:	97aa                	add	a5,a5,a0
ffffffffc02069f4:	95be                	add	a1,a1,a5
ffffffffc02069f6:	8556                	mv	a0,s5
ffffffffc02069f8:	884ff0ef          	jal	ra,ffffffffc0205a7c <load_icode_read>
ffffffffc02069fc:	ed05                	bnez	a0,ffffffffc0206a34 <do_execve+0x59a>
ffffffffc02069fe:	9bd2                	add	s7,s7,s4
ffffffffc0206a00:	9452                	add	s0,s0,s4
ffffffffc0206a02:	029bfd63          	bgeu	s7,s1,ffffffffc0206a3c <do_execve+0x5a2>
ffffffffc0206a06:	67e2                	ld	a5,24(sp)
ffffffffc0206a08:	865a                	mv	a2,s6
ffffffffc0206a0a:	85ca                	mv	a1,s2
ffffffffc0206a0c:	6f88                	ld	a0,24(a5)
ffffffffc0206a0e:	914fd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc0206a12:	8daa                	mv	s11,a0
ffffffffc0206a14:	f14d                	bnez	a0,ffffffffc02069b6 <do_execve+0x51c>
ffffffffc0206a16:	6a62                	ld	s4,24(sp)
ffffffffc0206a18:	74e2                	ld	s1,56(sp)
ffffffffc0206a1a:	5971                	li	s2,-4
ffffffffc0206a1c:	8552                	mv	a0,s4
ffffffffc0206a1e:	cd4fd0ef          	jal	ra,ffffffffc0203ef2 <exit_mmap>
ffffffffc0206a22:	018a3503          	ld	a0,24(s4)
ffffffffc0206a26:	8aca                	mv	s5,s2
ffffffffc0206a28:	8b2ff0ef          	jal	ra,ffffffffc0205ada <put_pgdir.isra.0>
ffffffffc0206a2c:	8552                	mv	a0,s4
ffffffffc0206a2e:	b28fd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0206a32:	b59d                	j	ffffffffc0206898 <do_execve+0x3fe>
ffffffffc0206a34:	6a62                	ld	s4,24(sp)
ffffffffc0206a36:	74e2                	ld	s1,56(sp)
ffffffffc0206a38:	892a                	mv	s2,a0
ffffffffc0206a3a:	b7cd                	j	ffffffffc0206a1c <do_execve+0x582>
ffffffffc0206a3c:	7466                	ld	s0,120(sp)
ffffffffc0206a3e:	6a62                	ld	s4,24(sp)
ffffffffc0206a40:	ec6e                	sd	s11,24(sp)
ffffffffc0206a42:	67ca                	ld	a5,144(sp)
ffffffffc0206a44:	943e                	add	s0,s0,a5
ffffffffc0206a46:	072bf363          	bgeu	s7,s2,ffffffffc0206aac <do_execve+0x612>
ffffffffc0206a4a:	c57406e3          	beq	s0,s7,ffffffffc0206696 <do_execve+0x1fc>
ffffffffc0206a4e:	66e2                	ld	a3,24(sp)
ffffffffc0206a50:	000d3783          	ld	a5,0(s10)
ffffffffc0206a54:	6602                	ld	a2,0(sp)
ffffffffc0206a56:	6705                	lui	a4,0x1
ffffffffc0206a58:	40f687b3          	sub	a5,a3,a5
ffffffffc0206a5c:	66c2                	ld	a3,16(sp)
ffffffffc0206a5e:	8799                	srai	a5,a5,0x6
ffffffffc0206a60:	00eb8533          	add	a0,s7,a4
ffffffffc0206a64:	97b6                	add	a5,a5,a3
ffffffffc0206a66:	00c79693          	slli	a3,a5,0xc
ffffffffc0206a6a:	000cb703          	ld	a4,0(s9)
ffffffffc0206a6e:	41250533          	sub	a0,a0,s2
ffffffffc0206a72:	8ff1                	and	a5,a5,a2
ffffffffc0206a74:	03247063          	bgeu	s0,s2,ffffffffc0206a94 <do_execve+0x5fa>
ffffffffc0206a78:	0ce7f063          	bgeu	a5,a4,ffffffffc0206b38 <do_execve+0x69e>
ffffffffc0206a7c:	000c3783          	ld	a5,0(s8)
ffffffffc0206a80:	41740633          	sub	a2,s0,s7
ffffffffc0206a84:	4581                	li	a1,0
ffffffffc0206a86:	96be                	add	a3,a3,a5
ffffffffc0206a88:	9536                	add	a0,a0,a3
ffffffffc0206a8a:	12d040ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0206a8e:	b121                	j	ffffffffc0206696 <do_execve+0x1fc>
ffffffffc0206a90:	5975                	li	s2,-3
ffffffffc0206a92:	b35d                	j	ffffffffc0206838 <do_execve+0x39e>
ffffffffc0206a94:	0ae7f263          	bgeu	a5,a4,ffffffffc0206b38 <do_execve+0x69e>
ffffffffc0206a98:	000c3783          	ld	a5,0(s8)
ffffffffc0206a9c:	41790633          	sub	a2,s2,s7
ffffffffc0206aa0:	4581                	li	a1,0
ffffffffc0206aa2:	96be                	add	a3,a3,a5
ffffffffc0206aa4:	9536                	add	a0,a0,a3
ffffffffc0206aa6:	111040ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0206aaa:	8bca                	mv	s7,s2
ffffffffc0206aac:	be8bf5e3          	bgeu	s7,s0,ffffffffc0206696 <do_execve+0x1fc>
ffffffffc0206ab0:	64c2                	ld	s1,16(sp)
ffffffffc0206ab2:	a099                	j	ffffffffc0206af8 <do_execve+0x65e>
ffffffffc0206ab4:	6785                	lui	a5,0x1
ffffffffc0206ab6:	412b8533          	sub	a0,s7,s2
ffffffffc0206aba:	993e                	add	s2,s2,a5
ffffffffc0206abc:	40a78633          	sub	a2,a5,a0
ffffffffc0206ac0:	01247563          	bgeu	s0,s2,ffffffffc0206aca <do_execve+0x630>
ffffffffc0206ac4:	412407b3          	sub	a5,s0,s2
ffffffffc0206ac8:	963e                	add	a2,a2,a5
ffffffffc0206aca:	000d3783          	ld	a5,0(s10)
ffffffffc0206ace:	6682                	ld	a3,0(sp)
ffffffffc0206ad0:	000cb703          	ld	a4,0(s9)
ffffffffc0206ad4:	40fd87b3          	sub	a5,s11,a5
ffffffffc0206ad8:	8799                	srai	a5,a5,0x6
ffffffffc0206ada:	97a6                	add	a5,a5,s1
ffffffffc0206adc:	8efd                	and	a3,a3,a5
ffffffffc0206ade:	07b2                	slli	a5,a5,0xc
ffffffffc0206ae0:	06e6f863          	bgeu	a3,a4,ffffffffc0206b50 <do_execve+0x6b6>
ffffffffc0206ae4:	000c3703          	ld	a4,0(s8)
ffffffffc0206ae8:	9bb2                	add	s7,s7,a2
ffffffffc0206aea:	4581                	li	a1,0
ffffffffc0206aec:	97ba                	add	a5,a5,a4
ffffffffc0206aee:	953e                	add	a0,a0,a5
ffffffffc0206af0:	0c7040ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0206af4:	028bfa63          	bgeu	s7,s0,ffffffffc0206b28 <do_execve+0x68e>
ffffffffc0206af8:	018a3503          	ld	a0,24(s4)
ffffffffc0206afc:	865a                	mv	a2,s6
ffffffffc0206afe:	85ca                	mv	a1,s2
ffffffffc0206b00:	822fd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc0206b04:	8daa                	mv	s11,a0
ffffffffc0206b06:	f55d                	bnez	a0,ffffffffc0206ab4 <do_execve+0x61a>
ffffffffc0206b08:	74e2                	ld	s1,56(sp)
ffffffffc0206b0a:	bf01                	j	ffffffffc0206a1a <do_execve+0x580>
ffffffffc0206b0c:	5975                	li	s2,-3
ffffffffc0206b0e:	de0b16e3          	bnez	s6,ffffffffc02068fa <do_execve+0x460>
ffffffffc0206b12:	b31d                	j	ffffffffc0206838 <do_execve+0x39e>
ffffffffc0206b14:	f60b0ee3          	beqz	s6,ffffffffc0206a90 <do_execve+0x5f6>
ffffffffc0206b18:	038b0513          	addi	a0,s6,56
ffffffffc0206b1c:	a45fd0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0206b20:	5975                	li	s2,-3
ffffffffc0206b22:	040b2823          	sw	zero,80(s6)
ffffffffc0206b26:	bb09                	j	ffffffffc0206838 <do_execve+0x39e>
ffffffffc0206b28:	ec6e                	sd	s11,24(sp)
ffffffffc0206b2a:	b6b5                	j	ffffffffc0206696 <do_execve+0x1fc>
ffffffffc0206b2c:	845e                	mv	s0,s7
ffffffffc0206b2e:	bf11                	j	ffffffffc0206a42 <do_execve+0x5a8>
ffffffffc0206b30:	74e2                	ld	s1,56(sp)
ffffffffc0206b32:	5961                	li	s2,-8
ffffffffc0206b34:	b5e5                	j	ffffffffc0206a1c <do_execve+0x582>
ffffffffc0206b36:	86be                	mv	a3,a5
ffffffffc0206b38:	00006617          	auipc	a2,0x6
ffffffffc0206b3c:	88060613          	addi	a2,a2,-1920 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc0206b40:	07100593          	li	a1,113
ffffffffc0206b44:	00006517          	auipc	a0,0x6
ffffffffc0206b48:	89c50513          	addi	a0,a0,-1892 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0206b4c:	953f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206b50:	86be                	mv	a3,a5
ffffffffc0206b52:	00006617          	auipc	a2,0x6
ffffffffc0206b56:	86660613          	addi	a2,a2,-1946 # ffffffffc020c3b8 <default_pmm_manager+0x38>
ffffffffc0206b5a:	07100593          	li	a1,113
ffffffffc0206b5e:	00006517          	auipc	a0,0x6
ffffffffc0206b62:	88250513          	addi	a0,a0,-1918 # ffffffffc020c3e0 <default_pmm_manager+0x60>
ffffffffc0206b66:	939f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206b6a:	00007697          	auipc	a3,0x7
ffffffffc0206b6e:	a6668693          	addi	a3,a3,-1434 # ffffffffc020d5d0 <CSWTCH.79+0x328>
ffffffffc0206b72:	00005617          	auipc	a2,0x5
ffffffffc0206b76:	d2660613          	addi	a2,a2,-730 # ffffffffc020b898 <commands+0x210>
ffffffffc0206b7a:	33c00593          	li	a1,828
ffffffffc0206b7e:	00007517          	auipc	a0,0x7
ffffffffc0206b82:	81a50513          	addi	a0,a0,-2022 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206b86:	919f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206b8a:	00007697          	auipc	a3,0x7
ffffffffc0206b8e:	9fe68693          	addi	a3,a3,-1538 # ffffffffc020d588 <CSWTCH.79+0x2e0>
ffffffffc0206b92:	00005617          	auipc	a2,0x5
ffffffffc0206b96:	d0660613          	addi	a2,a2,-762 # ffffffffc020b898 <commands+0x210>
ffffffffc0206b9a:	33b00593          	li	a1,827
ffffffffc0206b9e:	00006517          	auipc	a0,0x6
ffffffffc0206ba2:	7fa50513          	addi	a0,a0,2042 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206ba6:	8f9f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206baa:	00007697          	auipc	a3,0x7
ffffffffc0206bae:	ab668693          	addi	a3,a3,-1354 # ffffffffc020d660 <CSWTCH.79+0x3b8>
ffffffffc0206bb2:	00005617          	auipc	a2,0x5
ffffffffc0206bb6:	ce660613          	addi	a2,a2,-794 # ffffffffc020b898 <commands+0x210>
ffffffffc0206bba:	33e00593          	li	a1,830
ffffffffc0206bbe:	00006517          	auipc	a0,0x6
ffffffffc0206bc2:	7da50513          	addi	a0,a0,2010 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206bc6:	8d9f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206bca:	00007697          	auipc	a3,0x7
ffffffffc0206bce:	a4e68693          	addi	a3,a3,-1458 # ffffffffc020d618 <CSWTCH.79+0x370>
ffffffffc0206bd2:	00005617          	auipc	a2,0x5
ffffffffc0206bd6:	cc660613          	addi	a2,a2,-826 # ffffffffc020b898 <commands+0x210>
ffffffffc0206bda:	33d00593          	li	a1,829
ffffffffc0206bde:	00006517          	auipc	a0,0x6
ffffffffc0206be2:	7ba50513          	addi	a0,a0,1978 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206be6:	8b9f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206bea:	00006617          	auipc	a2,0x6
ffffffffc0206bee:	87660613          	addi	a2,a2,-1930 # ffffffffc020c460 <default_pmm_manager+0xe0>
ffffffffc0206bf2:	34200593          	li	a1,834
ffffffffc0206bf6:	00006517          	auipc	a0,0x6
ffffffffc0206bfa:	7a250513          	addi	a0,a0,1954 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206bfe:	8a1f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206c02 <user_main>:
ffffffffc0206c02:	7179                	addi	sp,sp,-48
ffffffffc0206c04:	e84a                	sd	s2,16(sp)
ffffffffc0206c06:	00090917          	auipc	s2,0x90
ffffffffc0206c0a:	cba90913          	addi	s2,s2,-838 # ffffffffc02968c0 <current>
ffffffffc0206c0e:	00093783          	ld	a5,0(s2)
ffffffffc0206c12:	00007617          	auipc	a2,0x7
ffffffffc0206c16:	a9660613          	addi	a2,a2,-1386 # ffffffffc020d6a8 <CSWTCH.79+0x400>
ffffffffc0206c1a:	00007517          	auipc	a0,0x7
ffffffffc0206c1e:	a9650513          	addi	a0,a0,-1386 # ffffffffc020d6b0 <CSWTCH.79+0x408>
ffffffffc0206c22:	43cc                	lw	a1,4(a5)
ffffffffc0206c24:	f406                	sd	ra,40(sp)
ffffffffc0206c26:	f022                	sd	s0,32(sp)
ffffffffc0206c28:	ec26                	sd	s1,24(sp)
ffffffffc0206c2a:	e032                	sd	a2,0(sp)
ffffffffc0206c2c:	e402                	sd	zero,8(sp)
ffffffffc0206c2e:	d78f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206c32:	6782                	ld	a5,0(sp)
ffffffffc0206c34:	cfb9                	beqz	a5,ffffffffc0206c92 <user_main+0x90>
ffffffffc0206c36:	003c                	addi	a5,sp,8
ffffffffc0206c38:	4401                	li	s0,0
ffffffffc0206c3a:	6398                	ld	a4,0(a5)
ffffffffc0206c3c:	0405                	addi	s0,s0,1
ffffffffc0206c3e:	07a1                	addi	a5,a5,8
ffffffffc0206c40:	ff6d                	bnez	a4,ffffffffc0206c3a <user_main+0x38>
ffffffffc0206c42:	00093783          	ld	a5,0(s2)
ffffffffc0206c46:	12000613          	li	a2,288
ffffffffc0206c4a:	6b84                	ld	s1,16(a5)
ffffffffc0206c4c:	73cc                	ld	a1,160(a5)
ffffffffc0206c4e:	6789                	lui	a5,0x2
ffffffffc0206c50:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0206c54:	94be                	add	s1,s1,a5
ffffffffc0206c56:	8526                	mv	a0,s1
ffffffffc0206c58:	7b0040ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc0206c5c:	00093783          	ld	a5,0(s2)
ffffffffc0206c60:	860a                	mv	a2,sp
ffffffffc0206c62:	0004059b          	sext.w	a1,s0
ffffffffc0206c66:	f3c4                	sd	s1,160(a5)
ffffffffc0206c68:	00007517          	auipc	a0,0x7
ffffffffc0206c6c:	a4050513          	addi	a0,a0,-1472 # ffffffffc020d6a8 <CSWTCH.79+0x400>
ffffffffc0206c70:	82bff0ef          	jal	ra,ffffffffc020649a <do_execve>
ffffffffc0206c74:	8126                	mv	sp,s1
ffffffffc0206c76:	ddafa06f          	j	ffffffffc0201250 <__trapret>
ffffffffc0206c7a:	00007617          	auipc	a2,0x7
ffffffffc0206c7e:	a5e60613          	addi	a2,a2,-1442 # ffffffffc020d6d8 <CSWTCH.79+0x430>
ffffffffc0206c82:	47f00593          	li	a1,1151
ffffffffc0206c86:	00006517          	auipc	a0,0x6
ffffffffc0206c8a:	71250513          	addi	a0,a0,1810 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206c8e:	811f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206c92:	4401                	li	s0,0
ffffffffc0206c94:	b77d                	j	ffffffffc0206c42 <user_main+0x40>

ffffffffc0206c96 <do_yield>:
ffffffffc0206c96:	00090797          	auipc	a5,0x90
ffffffffc0206c9a:	c2a7b783          	ld	a5,-982(a5) # ffffffffc02968c0 <current>
ffffffffc0206c9e:	4705                	li	a4,1
ffffffffc0206ca0:	ef98                	sd	a4,24(a5)
ffffffffc0206ca2:	4501                	li	a0,0
ffffffffc0206ca4:	8082                	ret

ffffffffc0206ca6 <do_wait>:
ffffffffc0206ca6:	1101                	addi	sp,sp,-32
ffffffffc0206ca8:	e822                	sd	s0,16(sp)
ffffffffc0206caa:	e426                	sd	s1,8(sp)
ffffffffc0206cac:	ec06                	sd	ra,24(sp)
ffffffffc0206cae:	842e                	mv	s0,a1
ffffffffc0206cb0:	84aa                	mv	s1,a0
ffffffffc0206cb2:	c999                	beqz	a1,ffffffffc0206cc8 <do_wait+0x22>
ffffffffc0206cb4:	00090797          	auipc	a5,0x90
ffffffffc0206cb8:	c0c7b783          	ld	a5,-1012(a5) # ffffffffc02968c0 <current>
ffffffffc0206cbc:	7788                	ld	a0,40(a5)
ffffffffc0206cbe:	4685                	li	a3,1
ffffffffc0206cc0:	4611                	li	a2,4
ffffffffc0206cc2:	dd0fd0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc0206cc6:	c909                	beqz	a0,ffffffffc0206cd8 <do_wait+0x32>
ffffffffc0206cc8:	85a2                	mv	a1,s0
ffffffffc0206cca:	6442                	ld	s0,16(sp)
ffffffffc0206ccc:	60e2                	ld	ra,24(sp)
ffffffffc0206cce:	8526                	mv	a0,s1
ffffffffc0206cd0:	64a2                	ld	s1,8(sp)
ffffffffc0206cd2:	6105                	addi	sp,sp,32
ffffffffc0206cd4:	ca4ff06f          	j	ffffffffc0206178 <do_wait.part.0>
ffffffffc0206cd8:	60e2                	ld	ra,24(sp)
ffffffffc0206cda:	6442                	ld	s0,16(sp)
ffffffffc0206cdc:	64a2                	ld	s1,8(sp)
ffffffffc0206cde:	5575                	li	a0,-3
ffffffffc0206ce0:	6105                	addi	sp,sp,32
ffffffffc0206ce2:	8082                	ret

ffffffffc0206ce4 <do_kill>:
ffffffffc0206ce4:	1141                	addi	sp,sp,-16
ffffffffc0206ce6:	6789                	lui	a5,0x2
ffffffffc0206ce8:	e406                	sd	ra,8(sp)
ffffffffc0206cea:	e022                	sd	s0,0(sp)
ffffffffc0206cec:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206cf0:	17f9                	addi	a5,a5,-2
ffffffffc0206cf2:	02e7e963          	bltu	a5,a4,ffffffffc0206d24 <do_kill+0x40>
ffffffffc0206cf6:	842a                	mv	s0,a0
ffffffffc0206cf8:	45a9                	li	a1,10
ffffffffc0206cfa:	2501                	sext.w	a0,a0
ffffffffc0206cfc:	186040ef          	jal	ra,ffffffffc020ae82 <hash32>
ffffffffc0206d00:	02051793          	slli	a5,a0,0x20
ffffffffc0206d04:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0206d08:	0008b797          	auipc	a5,0x8b
ffffffffc0206d0c:	ab878793          	addi	a5,a5,-1352 # ffffffffc02917c0 <hash_list>
ffffffffc0206d10:	953e                	add	a0,a0,a5
ffffffffc0206d12:	87aa                	mv	a5,a0
ffffffffc0206d14:	a029                	j	ffffffffc0206d1e <do_kill+0x3a>
ffffffffc0206d16:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0206d1a:	00870b63          	beq	a4,s0,ffffffffc0206d30 <do_kill+0x4c>
ffffffffc0206d1e:	679c                	ld	a5,8(a5)
ffffffffc0206d20:	fef51be3          	bne	a0,a5,ffffffffc0206d16 <do_kill+0x32>
ffffffffc0206d24:	5475                	li	s0,-3
ffffffffc0206d26:	60a2                	ld	ra,8(sp)
ffffffffc0206d28:	8522                	mv	a0,s0
ffffffffc0206d2a:	6402                	ld	s0,0(sp)
ffffffffc0206d2c:	0141                	addi	sp,sp,16
ffffffffc0206d2e:	8082                	ret
ffffffffc0206d30:	fd87a703          	lw	a4,-40(a5)
ffffffffc0206d34:	00177693          	andi	a3,a4,1
ffffffffc0206d38:	e295                	bnez	a3,ffffffffc0206d5c <do_kill+0x78>
ffffffffc0206d3a:	4bd4                	lw	a3,20(a5)
ffffffffc0206d3c:	00176713          	ori	a4,a4,1
ffffffffc0206d40:	fce7ac23          	sw	a4,-40(a5)
ffffffffc0206d44:	4401                	li	s0,0
ffffffffc0206d46:	fe06d0e3          	bgez	a3,ffffffffc0206d26 <do_kill+0x42>
ffffffffc0206d4a:	f2878513          	addi	a0,a5,-216
ffffffffc0206d4e:	45a000ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc0206d52:	60a2                	ld	ra,8(sp)
ffffffffc0206d54:	8522                	mv	a0,s0
ffffffffc0206d56:	6402                	ld	s0,0(sp)
ffffffffc0206d58:	0141                	addi	sp,sp,16
ffffffffc0206d5a:	8082                	ret
ffffffffc0206d5c:	545d                	li	s0,-9
ffffffffc0206d5e:	b7e1                	j	ffffffffc0206d26 <do_kill+0x42>

ffffffffc0206d60 <proc_init>:
ffffffffc0206d60:	1101                	addi	sp,sp,-32
ffffffffc0206d62:	e426                	sd	s1,8(sp)
ffffffffc0206d64:	0008f797          	auipc	a5,0x8f
ffffffffc0206d68:	a5c78793          	addi	a5,a5,-1444 # ffffffffc02957c0 <proc_list>
ffffffffc0206d6c:	ec06                	sd	ra,24(sp)
ffffffffc0206d6e:	e822                	sd	s0,16(sp)
ffffffffc0206d70:	e04a                	sd	s2,0(sp)
ffffffffc0206d72:	0008b497          	auipc	s1,0x8b
ffffffffc0206d76:	a4e48493          	addi	s1,s1,-1458 # ffffffffc02917c0 <hash_list>
ffffffffc0206d7a:	e79c                	sd	a5,8(a5)
ffffffffc0206d7c:	e39c                	sd	a5,0(a5)
ffffffffc0206d7e:	0008f717          	auipc	a4,0x8f
ffffffffc0206d82:	a4270713          	addi	a4,a4,-1470 # ffffffffc02957c0 <proc_list>
ffffffffc0206d86:	87a6                	mv	a5,s1
ffffffffc0206d88:	e79c                	sd	a5,8(a5)
ffffffffc0206d8a:	e39c                	sd	a5,0(a5)
ffffffffc0206d8c:	07c1                	addi	a5,a5,16
ffffffffc0206d8e:	fef71de3          	bne	a4,a5,ffffffffc0206d88 <proc_init+0x28>
ffffffffc0206d92:	c43fe0ef          	jal	ra,ffffffffc02059d4 <alloc_proc>
ffffffffc0206d96:	00090917          	auipc	s2,0x90
ffffffffc0206d9a:	b3290913          	addi	s2,s2,-1230 # ffffffffc02968c8 <idleproc>
ffffffffc0206d9e:	00a93023          	sd	a0,0(s2)
ffffffffc0206da2:	842a                	mv	s0,a0
ffffffffc0206da4:	12050863          	beqz	a0,ffffffffc0206ed4 <proc_init+0x174>
ffffffffc0206da8:	4789                	li	a5,2
ffffffffc0206daa:	e11c                	sd	a5,0(a0)
ffffffffc0206dac:	0000a797          	auipc	a5,0xa
ffffffffc0206db0:	25478793          	addi	a5,a5,596 # ffffffffc0211000 <bootstack>
ffffffffc0206db4:	e91c                	sd	a5,16(a0)
ffffffffc0206db6:	4785                	li	a5,1
ffffffffc0206db8:	ed1c                	sd	a5,24(a0)
ffffffffc0206dba:	c14fe0ef          	jal	ra,ffffffffc02051ce <files_create>
ffffffffc0206dbe:	14a43423          	sd	a0,328(s0)
ffffffffc0206dc2:	0e050d63          	beqz	a0,ffffffffc0206ebc <proc_init+0x15c>
ffffffffc0206dc6:	00093403          	ld	s0,0(s2)
ffffffffc0206dca:	4641                	li	a2,16
ffffffffc0206dcc:	4581                	li	a1,0
ffffffffc0206dce:	14843703          	ld	a4,328(s0)
ffffffffc0206dd2:	0b440413          	addi	s0,s0,180
ffffffffc0206dd6:	8522                	mv	a0,s0
ffffffffc0206dd8:	4b1c                	lw	a5,16(a4)
ffffffffc0206dda:	2785                	addiw	a5,a5,1
ffffffffc0206ddc:	cb1c                	sw	a5,16(a4)
ffffffffc0206dde:	5d8040ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0206de2:	463d                	li	a2,15
ffffffffc0206de4:	00007597          	auipc	a1,0x7
ffffffffc0206de8:	95458593          	addi	a1,a1,-1708 # ffffffffc020d738 <CSWTCH.79+0x490>
ffffffffc0206dec:	8522                	mv	a0,s0
ffffffffc0206dee:	61a040ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc0206df2:	00090717          	auipc	a4,0x90
ffffffffc0206df6:	ae670713          	addi	a4,a4,-1306 # ffffffffc02968d8 <nr_process>
ffffffffc0206dfa:	431c                	lw	a5,0(a4)
ffffffffc0206dfc:	00093683          	ld	a3,0(s2)
ffffffffc0206e00:	4601                	li	a2,0
ffffffffc0206e02:	2785                	addiw	a5,a5,1
ffffffffc0206e04:	4581                	li	a1,0
ffffffffc0206e06:	fffff517          	auipc	a0,0xfffff
ffffffffc0206e0a:	54450513          	addi	a0,a0,1348 # ffffffffc020634a <init_main>
ffffffffc0206e0e:	c31c                	sw	a5,0(a4)
ffffffffc0206e10:	00090797          	auipc	a5,0x90
ffffffffc0206e14:	aad7b823          	sd	a3,-1360(a5) # ffffffffc02968c0 <current>
ffffffffc0206e18:	9aeff0ef          	jal	ra,ffffffffc0205fc6 <kernel_thread>
ffffffffc0206e1c:	842a                	mv	s0,a0
ffffffffc0206e1e:	08a05363          	blez	a0,ffffffffc0206ea4 <proc_init+0x144>
ffffffffc0206e22:	6789                	lui	a5,0x2
ffffffffc0206e24:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206e28:	17f9                	addi	a5,a5,-2
ffffffffc0206e2a:	2501                	sext.w	a0,a0
ffffffffc0206e2c:	02e7e363          	bltu	a5,a4,ffffffffc0206e52 <proc_init+0xf2>
ffffffffc0206e30:	45a9                	li	a1,10
ffffffffc0206e32:	050040ef          	jal	ra,ffffffffc020ae82 <hash32>
ffffffffc0206e36:	02051793          	slli	a5,a0,0x20
ffffffffc0206e3a:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0206e3e:	96a6                	add	a3,a3,s1
ffffffffc0206e40:	87b6                	mv	a5,a3
ffffffffc0206e42:	a029                	j	ffffffffc0206e4c <proc_init+0xec>
ffffffffc0206e44:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_bin_swap_img_size-0x5dd4>
ffffffffc0206e48:	04870b63          	beq	a4,s0,ffffffffc0206e9e <proc_init+0x13e>
ffffffffc0206e4c:	679c                	ld	a5,8(a5)
ffffffffc0206e4e:	fef69be3          	bne	a3,a5,ffffffffc0206e44 <proc_init+0xe4>
ffffffffc0206e52:	4781                	li	a5,0
ffffffffc0206e54:	0b478493          	addi	s1,a5,180
ffffffffc0206e58:	4641                	li	a2,16
ffffffffc0206e5a:	4581                	li	a1,0
ffffffffc0206e5c:	00090417          	auipc	s0,0x90
ffffffffc0206e60:	a7440413          	addi	s0,s0,-1420 # ffffffffc02968d0 <initproc>
ffffffffc0206e64:	8526                	mv	a0,s1
ffffffffc0206e66:	e01c                	sd	a5,0(s0)
ffffffffc0206e68:	54e040ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0206e6c:	463d                	li	a2,15
ffffffffc0206e6e:	00007597          	auipc	a1,0x7
ffffffffc0206e72:	8f258593          	addi	a1,a1,-1806 # ffffffffc020d760 <CSWTCH.79+0x4b8>
ffffffffc0206e76:	8526                	mv	a0,s1
ffffffffc0206e78:	590040ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc0206e7c:	00093783          	ld	a5,0(s2)
ffffffffc0206e80:	c7d1                	beqz	a5,ffffffffc0206f0c <proc_init+0x1ac>
ffffffffc0206e82:	43dc                	lw	a5,4(a5)
ffffffffc0206e84:	e7c1                	bnez	a5,ffffffffc0206f0c <proc_init+0x1ac>
ffffffffc0206e86:	601c                	ld	a5,0(s0)
ffffffffc0206e88:	c3b5                	beqz	a5,ffffffffc0206eec <proc_init+0x18c>
ffffffffc0206e8a:	43d8                	lw	a4,4(a5)
ffffffffc0206e8c:	4785                	li	a5,1
ffffffffc0206e8e:	04f71f63          	bne	a4,a5,ffffffffc0206eec <proc_init+0x18c>
ffffffffc0206e92:	60e2                	ld	ra,24(sp)
ffffffffc0206e94:	6442                	ld	s0,16(sp)
ffffffffc0206e96:	64a2                	ld	s1,8(sp)
ffffffffc0206e98:	6902                	ld	s2,0(sp)
ffffffffc0206e9a:	6105                	addi	sp,sp,32
ffffffffc0206e9c:	8082                	ret
ffffffffc0206e9e:	f2878793          	addi	a5,a5,-216
ffffffffc0206ea2:	bf4d                	j	ffffffffc0206e54 <proc_init+0xf4>
ffffffffc0206ea4:	00007617          	auipc	a2,0x7
ffffffffc0206ea8:	89c60613          	addi	a2,a2,-1892 # ffffffffc020d740 <CSWTCH.79+0x498>
ffffffffc0206eac:	4cb00593          	li	a1,1227
ffffffffc0206eb0:	00006517          	auipc	a0,0x6
ffffffffc0206eb4:	4e850513          	addi	a0,a0,1256 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206eb8:	de6f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206ebc:	00007617          	auipc	a2,0x7
ffffffffc0206ec0:	85460613          	addi	a2,a2,-1964 # ffffffffc020d710 <CSWTCH.79+0x468>
ffffffffc0206ec4:	4bf00593          	li	a1,1215
ffffffffc0206ec8:	00006517          	auipc	a0,0x6
ffffffffc0206ecc:	4d050513          	addi	a0,a0,1232 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206ed0:	dcef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206ed4:	00007617          	auipc	a2,0x7
ffffffffc0206ed8:	82460613          	addi	a2,a2,-2012 # ffffffffc020d6f8 <CSWTCH.79+0x450>
ffffffffc0206edc:	4b500593          	li	a1,1205
ffffffffc0206ee0:	00006517          	auipc	a0,0x6
ffffffffc0206ee4:	4b850513          	addi	a0,a0,1208 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206ee8:	db6f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206eec:	00007697          	auipc	a3,0x7
ffffffffc0206ef0:	8a468693          	addi	a3,a3,-1884 # ffffffffc020d790 <CSWTCH.79+0x4e8>
ffffffffc0206ef4:	00005617          	auipc	a2,0x5
ffffffffc0206ef8:	9a460613          	addi	a2,a2,-1628 # ffffffffc020b898 <commands+0x210>
ffffffffc0206efc:	4d200593          	li	a1,1234
ffffffffc0206f00:	00006517          	auipc	a0,0x6
ffffffffc0206f04:	49850513          	addi	a0,a0,1176 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206f08:	d96f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206f0c:	00007697          	auipc	a3,0x7
ffffffffc0206f10:	85c68693          	addi	a3,a3,-1956 # ffffffffc020d768 <CSWTCH.79+0x4c0>
ffffffffc0206f14:	00005617          	auipc	a2,0x5
ffffffffc0206f18:	98460613          	addi	a2,a2,-1660 # ffffffffc020b898 <commands+0x210>
ffffffffc0206f1c:	4d100593          	li	a1,1233
ffffffffc0206f20:	00006517          	auipc	a0,0x6
ffffffffc0206f24:	47850513          	addi	a0,a0,1144 # ffffffffc020d398 <CSWTCH.79+0xf0>
ffffffffc0206f28:	d76f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206f2c <cpu_idle>:
ffffffffc0206f2c:	1141                	addi	sp,sp,-16
ffffffffc0206f2e:	e022                	sd	s0,0(sp)
ffffffffc0206f30:	e406                	sd	ra,8(sp)
ffffffffc0206f32:	00090417          	auipc	s0,0x90
ffffffffc0206f36:	98e40413          	addi	s0,s0,-1650 # ffffffffc02968c0 <current>
ffffffffc0206f3a:	6018                	ld	a4,0(s0)
ffffffffc0206f3c:	6f1c                	ld	a5,24(a4)
ffffffffc0206f3e:	dffd                	beqz	a5,ffffffffc0206f3c <cpu_idle+0x10>
ffffffffc0206f40:	31a000ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc0206f44:	bfdd                	j	ffffffffc0206f3a <cpu_idle+0xe>

ffffffffc0206f46 <lab6_set_priority>:
ffffffffc0206f46:	1141                	addi	sp,sp,-16
ffffffffc0206f48:	e022                	sd	s0,0(sp)
ffffffffc0206f4a:	85aa                	mv	a1,a0
ffffffffc0206f4c:	842a                	mv	s0,a0
ffffffffc0206f4e:	00007517          	auipc	a0,0x7
ffffffffc0206f52:	86a50513          	addi	a0,a0,-1942 # ffffffffc020d7b8 <CSWTCH.79+0x510>
ffffffffc0206f56:	e406                	sd	ra,8(sp)
ffffffffc0206f58:	a4ef90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206f5c:	00090797          	auipc	a5,0x90
ffffffffc0206f60:	9647b783          	ld	a5,-1692(a5) # ffffffffc02968c0 <current>
ffffffffc0206f64:	e801                	bnez	s0,ffffffffc0206f74 <lab6_set_priority+0x2e>
ffffffffc0206f66:	60a2                	ld	ra,8(sp)
ffffffffc0206f68:	6402                	ld	s0,0(sp)
ffffffffc0206f6a:	4705                	li	a4,1
ffffffffc0206f6c:	14e7a223          	sw	a4,324(a5)
ffffffffc0206f70:	0141                	addi	sp,sp,16
ffffffffc0206f72:	8082                	ret
ffffffffc0206f74:	60a2                	ld	ra,8(sp)
ffffffffc0206f76:	1487a223          	sw	s0,324(a5)
ffffffffc0206f7a:	6402                	ld	s0,0(sp)
ffffffffc0206f7c:	0141                	addi	sp,sp,16
ffffffffc0206f7e:	8082                	ret

ffffffffc0206f80 <do_sleep>:
ffffffffc0206f80:	c539                	beqz	a0,ffffffffc0206fce <do_sleep+0x4e>
ffffffffc0206f82:	7179                	addi	sp,sp,-48
ffffffffc0206f84:	f022                	sd	s0,32(sp)
ffffffffc0206f86:	f406                	sd	ra,40(sp)
ffffffffc0206f88:	842a                	mv	s0,a0
ffffffffc0206f8a:	100027f3          	csrr	a5,sstatus
ffffffffc0206f8e:	8b89                	andi	a5,a5,2
ffffffffc0206f90:	e3a9                	bnez	a5,ffffffffc0206fd2 <do_sleep+0x52>
ffffffffc0206f92:	00090797          	auipc	a5,0x90
ffffffffc0206f96:	92e7b783          	ld	a5,-1746(a5) # ffffffffc02968c0 <current>
ffffffffc0206f9a:	0818                	addi	a4,sp,16
ffffffffc0206f9c:	c02a                	sw	a0,0(sp)
ffffffffc0206f9e:	ec3a                	sd	a4,24(sp)
ffffffffc0206fa0:	e83a                	sd	a4,16(sp)
ffffffffc0206fa2:	e43e                	sd	a5,8(sp)
ffffffffc0206fa4:	4705                	li	a4,1
ffffffffc0206fa6:	c398                	sw	a4,0(a5)
ffffffffc0206fa8:	80000737          	lui	a4,0x80000
ffffffffc0206fac:	840a                	mv	s0,sp
ffffffffc0206fae:	0709                	addi	a4,a4,2
ffffffffc0206fb0:	0ee7a623          	sw	a4,236(a5)
ffffffffc0206fb4:	8522                	mv	a0,s0
ffffffffc0206fb6:	364000ef          	jal	ra,ffffffffc020731a <add_timer>
ffffffffc0206fba:	2a0000ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc0206fbe:	8522                	mv	a0,s0
ffffffffc0206fc0:	422000ef          	jal	ra,ffffffffc02073e2 <del_timer>
ffffffffc0206fc4:	70a2                	ld	ra,40(sp)
ffffffffc0206fc6:	7402                	ld	s0,32(sp)
ffffffffc0206fc8:	4501                	li	a0,0
ffffffffc0206fca:	6145                	addi	sp,sp,48
ffffffffc0206fcc:	8082                	ret
ffffffffc0206fce:	4501                	li	a0,0
ffffffffc0206fd0:	8082                	ret
ffffffffc0206fd2:	ca1f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206fd6:	00090797          	auipc	a5,0x90
ffffffffc0206fda:	8ea7b783          	ld	a5,-1814(a5) # ffffffffc02968c0 <current>
ffffffffc0206fde:	0818                	addi	a4,sp,16
ffffffffc0206fe0:	c022                	sw	s0,0(sp)
ffffffffc0206fe2:	e43e                	sd	a5,8(sp)
ffffffffc0206fe4:	ec3a                	sd	a4,24(sp)
ffffffffc0206fe6:	e83a                	sd	a4,16(sp)
ffffffffc0206fe8:	4705                	li	a4,1
ffffffffc0206fea:	c398                	sw	a4,0(a5)
ffffffffc0206fec:	80000737          	lui	a4,0x80000
ffffffffc0206ff0:	0709                	addi	a4,a4,2
ffffffffc0206ff2:	840a                	mv	s0,sp
ffffffffc0206ff4:	8522                	mv	a0,s0
ffffffffc0206ff6:	0ee7a623          	sw	a4,236(a5)
ffffffffc0206ffa:	320000ef          	jal	ra,ffffffffc020731a <add_timer>
ffffffffc0206ffe:	c6ff90ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0207002:	bf65                	j	ffffffffc0206fba <do_sleep+0x3a>

ffffffffc0207004 <switch_to>:
ffffffffc0207004:	00153023          	sd	ra,0(a0)
ffffffffc0207008:	00253423          	sd	sp,8(a0)
ffffffffc020700c:	e900                	sd	s0,16(a0)
ffffffffc020700e:	ed04                	sd	s1,24(a0)
ffffffffc0207010:	03253023          	sd	s2,32(a0)
ffffffffc0207014:	03353423          	sd	s3,40(a0)
ffffffffc0207018:	03453823          	sd	s4,48(a0)
ffffffffc020701c:	03553c23          	sd	s5,56(a0)
ffffffffc0207020:	05653023          	sd	s6,64(a0)
ffffffffc0207024:	05753423          	sd	s7,72(a0)
ffffffffc0207028:	05853823          	sd	s8,80(a0)
ffffffffc020702c:	05953c23          	sd	s9,88(a0)
ffffffffc0207030:	07a53023          	sd	s10,96(a0)
ffffffffc0207034:	07b53423          	sd	s11,104(a0)
ffffffffc0207038:	0005b083          	ld	ra,0(a1)
ffffffffc020703c:	0085b103          	ld	sp,8(a1)
ffffffffc0207040:	6980                	ld	s0,16(a1)
ffffffffc0207042:	6d84                	ld	s1,24(a1)
ffffffffc0207044:	0205b903          	ld	s2,32(a1)
ffffffffc0207048:	0285b983          	ld	s3,40(a1)
ffffffffc020704c:	0305ba03          	ld	s4,48(a1)
ffffffffc0207050:	0385ba83          	ld	s5,56(a1)
ffffffffc0207054:	0405bb03          	ld	s6,64(a1)
ffffffffc0207058:	0485bb83          	ld	s7,72(a1)
ffffffffc020705c:	0505bc03          	ld	s8,80(a1)
ffffffffc0207060:	0585bc83          	ld	s9,88(a1)
ffffffffc0207064:	0605bd03          	ld	s10,96(a1)
ffffffffc0207068:	0685bd83          	ld	s11,104(a1)
ffffffffc020706c:	8082                	ret

ffffffffc020706e <RR_init>:
ffffffffc020706e:	e508                	sd	a0,8(a0)
ffffffffc0207070:	e108                	sd	a0,0(a0)
ffffffffc0207072:	00052823          	sw	zero,16(a0)
ffffffffc0207076:	8082                	ret

ffffffffc0207078 <RR_pick_next>:
ffffffffc0207078:	651c                	ld	a5,8(a0)
ffffffffc020707a:	00f50563          	beq	a0,a5,ffffffffc0207084 <RR_pick_next+0xc>
ffffffffc020707e:	ef078513          	addi	a0,a5,-272
ffffffffc0207082:	8082                	ret
ffffffffc0207084:	4501                	li	a0,0
ffffffffc0207086:	8082                	ret

ffffffffc0207088 <RR_proc_tick>:
ffffffffc0207088:	1205a783          	lw	a5,288(a1)
ffffffffc020708c:	00f05563          	blez	a5,ffffffffc0207096 <RR_proc_tick+0xe>
ffffffffc0207090:	37fd                	addiw	a5,a5,-1
ffffffffc0207092:	12f5a023          	sw	a5,288(a1)
ffffffffc0207096:	e399                	bnez	a5,ffffffffc020709c <RR_proc_tick+0x14>
ffffffffc0207098:	4785                	li	a5,1
ffffffffc020709a:	ed9c                	sd	a5,24(a1)
ffffffffc020709c:	8082                	ret

ffffffffc020709e <RR_dequeue>:
ffffffffc020709e:	1185b703          	ld	a4,280(a1)
ffffffffc02070a2:	11058793          	addi	a5,a1,272
ffffffffc02070a6:	02e78363          	beq	a5,a4,ffffffffc02070cc <RR_dequeue+0x2e>
ffffffffc02070aa:	1085b683          	ld	a3,264(a1)
ffffffffc02070ae:	00a69f63          	bne	a3,a0,ffffffffc02070cc <RR_dequeue+0x2e>
ffffffffc02070b2:	1105b503          	ld	a0,272(a1)
ffffffffc02070b6:	4a90                	lw	a2,16(a3)
ffffffffc02070b8:	e518                	sd	a4,8(a0)
ffffffffc02070ba:	e308                	sd	a0,0(a4)
ffffffffc02070bc:	10f5bc23          	sd	a5,280(a1)
ffffffffc02070c0:	10f5b823          	sd	a5,272(a1)
ffffffffc02070c4:	fff6079b          	addiw	a5,a2,-1
ffffffffc02070c8:	ca9c                	sw	a5,16(a3)
ffffffffc02070ca:	8082                	ret
ffffffffc02070cc:	1141                	addi	sp,sp,-16
ffffffffc02070ce:	00006697          	auipc	a3,0x6
ffffffffc02070d2:	70268693          	addi	a3,a3,1794 # ffffffffc020d7d0 <CSWTCH.79+0x528>
ffffffffc02070d6:	00004617          	auipc	a2,0x4
ffffffffc02070da:	7c260613          	addi	a2,a2,1986 # ffffffffc020b898 <commands+0x210>
ffffffffc02070de:	03c00593          	li	a1,60
ffffffffc02070e2:	00006517          	auipc	a0,0x6
ffffffffc02070e6:	72650513          	addi	a0,a0,1830 # ffffffffc020d808 <CSWTCH.79+0x560>
ffffffffc02070ea:	e406                	sd	ra,8(sp)
ffffffffc02070ec:	bb2f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02070f0 <RR_enqueue>:
ffffffffc02070f0:	1185b703          	ld	a4,280(a1)
ffffffffc02070f4:	11058793          	addi	a5,a1,272
ffffffffc02070f8:	02e79d63          	bne	a5,a4,ffffffffc0207132 <RR_enqueue+0x42>
ffffffffc02070fc:	6118                	ld	a4,0(a0)
ffffffffc02070fe:	1205a683          	lw	a3,288(a1)
ffffffffc0207102:	e11c                	sd	a5,0(a0)
ffffffffc0207104:	e71c                	sd	a5,8(a4)
ffffffffc0207106:	10a5bc23          	sd	a0,280(a1)
ffffffffc020710a:	10e5b823          	sd	a4,272(a1)
ffffffffc020710e:	495c                	lw	a5,20(a0)
ffffffffc0207110:	ea89                	bnez	a3,ffffffffc0207122 <RR_enqueue+0x32>
ffffffffc0207112:	12f5a023          	sw	a5,288(a1)
ffffffffc0207116:	491c                	lw	a5,16(a0)
ffffffffc0207118:	10a5b423          	sd	a0,264(a1)
ffffffffc020711c:	2785                	addiw	a5,a5,1
ffffffffc020711e:	c91c                	sw	a5,16(a0)
ffffffffc0207120:	8082                	ret
ffffffffc0207122:	fed7c8e3          	blt	a5,a3,ffffffffc0207112 <RR_enqueue+0x22>
ffffffffc0207126:	491c                	lw	a5,16(a0)
ffffffffc0207128:	10a5b423          	sd	a0,264(a1)
ffffffffc020712c:	2785                	addiw	a5,a5,1
ffffffffc020712e:	c91c                	sw	a5,16(a0)
ffffffffc0207130:	8082                	ret
ffffffffc0207132:	1141                	addi	sp,sp,-16
ffffffffc0207134:	00006697          	auipc	a3,0x6
ffffffffc0207138:	6f468693          	addi	a3,a3,1780 # ffffffffc020d828 <CSWTCH.79+0x580>
ffffffffc020713c:	00004617          	auipc	a2,0x4
ffffffffc0207140:	75c60613          	addi	a2,a2,1884 # ffffffffc020b898 <commands+0x210>
ffffffffc0207144:	02800593          	li	a1,40
ffffffffc0207148:	00006517          	auipc	a0,0x6
ffffffffc020714c:	6c050513          	addi	a0,a0,1728 # ffffffffc020d808 <CSWTCH.79+0x560>
ffffffffc0207150:	e406                	sd	ra,8(sp)
ffffffffc0207152:	b4cf90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207156 <sched_init>:
ffffffffc0207156:	1141                	addi	sp,sp,-16
ffffffffc0207158:	0008a717          	auipc	a4,0x8a
ffffffffc020715c:	ec870713          	addi	a4,a4,-312 # ffffffffc0291020 <default_sched_class>
ffffffffc0207160:	e022                	sd	s0,0(sp)
ffffffffc0207162:	e406                	sd	ra,8(sp)
ffffffffc0207164:	0008e797          	auipc	a5,0x8e
ffffffffc0207168:	68c78793          	addi	a5,a5,1676 # ffffffffc02957f0 <timer_list>
ffffffffc020716c:	6714                	ld	a3,8(a4)
ffffffffc020716e:	0008e517          	auipc	a0,0x8e
ffffffffc0207172:	66250513          	addi	a0,a0,1634 # ffffffffc02957d0 <__rq>
ffffffffc0207176:	e79c                	sd	a5,8(a5)
ffffffffc0207178:	e39c                	sd	a5,0(a5)
ffffffffc020717a:	4795                	li	a5,5
ffffffffc020717c:	c95c                	sw	a5,20(a0)
ffffffffc020717e:	0008f417          	auipc	s0,0x8f
ffffffffc0207182:	76a40413          	addi	s0,s0,1898 # ffffffffc02968e8 <sched_class>
ffffffffc0207186:	0008f797          	auipc	a5,0x8f
ffffffffc020718a:	74a7bd23          	sd	a0,1882(a5) # ffffffffc02968e0 <rq>
ffffffffc020718e:	e018                	sd	a4,0(s0)
ffffffffc0207190:	9682                	jalr	a3
ffffffffc0207192:	601c                	ld	a5,0(s0)
ffffffffc0207194:	6402                	ld	s0,0(sp)
ffffffffc0207196:	60a2                	ld	ra,8(sp)
ffffffffc0207198:	638c                	ld	a1,0(a5)
ffffffffc020719a:	00006517          	auipc	a0,0x6
ffffffffc020719e:	6be50513          	addi	a0,a0,1726 # ffffffffc020d858 <CSWTCH.79+0x5b0>
ffffffffc02071a2:	0141                	addi	sp,sp,16
ffffffffc02071a4:	802f906f          	j	ffffffffc02001a6 <cprintf>

ffffffffc02071a8 <wakeup_proc>:
ffffffffc02071a8:	4118                	lw	a4,0(a0)
ffffffffc02071aa:	1101                	addi	sp,sp,-32
ffffffffc02071ac:	ec06                	sd	ra,24(sp)
ffffffffc02071ae:	e822                	sd	s0,16(sp)
ffffffffc02071b0:	e426                	sd	s1,8(sp)
ffffffffc02071b2:	478d                	li	a5,3
ffffffffc02071b4:	08f70363          	beq	a4,a5,ffffffffc020723a <wakeup_proc+0x92>
ffffffffc02071b8:	842a                	mv	s0,a0
ffffffffc02071ba:	100027f3          	csrr	a5,sstatus
ffffffffc02071be:	8b89                	andi	a5,a5,2
ffffffffc02071c0:	4481                	li	s1,0
ffffffffc02071c2:	e7bd                	bnez	a5,ffffffffc0207230 <wakeup_proc+0x88>
ffffffffc02071c4:	4789                	li	a5,2
ffffffffc02071c6:	04f70863          	beq	a4,a5,ffffffffc0207216 <wakeup_proc+0x6e>
ffffffffc02071ca:	c01c                	sw	a5,0(s0)
ffffffffc02071cc:	0e042623          	sw	zero,236(s0)
ffffffffc02071d0:	0008f797          	auipc	a5,0x8f
ffffffffc02071d4:	6f07b783          	ld	a5,1776(a5) # ffffffffc02968c0 <current>
ffffffffc02071d8:	02878363          	beq	a5,s0,ffffffffc02071fe <wakeup_proc+0x56>
ffffffffc02071dc:	0008f797          	auipc	a5,0x8f
ffffffffc02071e0:	6ec7b783          	ld	a5,1772(a5) # ffffffffc02968c8 <idleproc>
ffffffffc02071e4:	00f40d63          	beq	s0,a5,ffffffffc02071fe <wakeup_proc+0x56>
ffffffffc02071e8:	0008f797          	auipc	a5,0x8f
ffffffffc02071ec:	7007b783          	ld	a5,1792(a5) # ffffffffc02968e8 <sched_class>
ffffffffc02071f0:	6b9c                	ld	a5,16(a5)
ffffffffc02071f2:	85a2                	mv	a1,s0
ffffffffc02071f4:	0008f517          	auipc	a0,0x8f
ffffffffc02071f8:	6ec53503          	ld	a0,1772(a0) # ffffffffc02968e0 <rq>
ffffffffc02071fc:	9782                	jalr	a5
ffffffffc02071fe:	e491                	bnez	s1,ffffffffc020720a <wakeup_proc+0x62>
ffffffffc0207200:	60e2                	ld	ra,24(sp)
ffffffffc0207202:	6442                	ld	s0,16(sp)
ffffffffc0207204:	64a2                	ld	s1,8(sp)
ffffffffc0207206:	6105                	addi	sp,sp,32
ffffffffc0207208:	8082                	ret
ffffffffc020720a:	6442                	ld	s0,16(sp)
ffffffffc020720c:	60e2                	ld	ra,24(sp)
ffffffffc020720e:	64a2                	ld	s1,8(sp)
ffffffffc0207210:	6105                	addi	sp,sp,32
ffffffffc0207212:	a5bf906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207216:	00006617          	auipc	a2,0x6
ffffffffc020721a:	69260613          	addi	a2,a2,1682 # ffffffffc020d8a8 <CSWTCH.79+0x600>
ffffffffc020721e:	05200593          	li	a1,82
ffffffffc0207222:	00006517          	auipc	a0,0x6
ffffffffc0207226:	66e50513          	addi	a0,a0,1646 # ffffffffc020d890 <CSWTCH.79+0x5e8>
ffffffffc020722a:	adcf90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc020722e:	bfc1                	j	ffffffffc02071fe <wakeup_proc+0x56>
ffffffffc0207230:	a43f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207234:	4018                	lw	a4,0(s0)
ffffffffc0207236:	4485                	li	s1,1
ffffffffc0207238:	b771                	j	ffffffffc02071c4 <wakeup_proc+0x1c>
ffffffffc020723a:	00006697          	auipc	a3,0x6
ffffffffc020723e:	63668693          	addi	a3,a3,1590 # ffffffffc020d870 <CSWTCH.79+0x5c8>
ffffffffc0207242:	00004617          	auipc	a2,0x4
ffffffffc0207246:	65660613          	addi	a2,a2,1622 # ffffffffc020b898 <commands+0x210>
ffffffffc020724a:	04300593          	li	a1,67
ffffffffc020724e:	00006517          	auipc	a0,0x6
ffffffffc0207252:	64250513          	addi	a0,a0,1602 # ffffffffc020d890 <CSWTCH.79+0x5e8>
ffffffffc0207256:	a48f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020725a <schedule>:
ffffffffc020725a:	7179                	addi	sp,sp,-48
ffffffffc020725c:	f406                	sd	ra,40(sp)
ffffffffc020725e:	f022                	sd	s0,32(sp)
ffffffffc0207260:	ec26                	sd	s1,24(sp)
ffffffffc0207262:	e84a                	sd	s2,16(sp)
ffffffffc0207264:	e44e                	sd	s3,8(sp)
ffffffffc0207266:	e052                	sd	s4,0(sp)
ffffffffc0207268:	100027f3          	csrr	a5,sstatus
ffffffffc020726c:	8b89                	andi	a5,a5,2
ffffffffc020726e:	4a01                	li	s4,0
ffffffffc0207270:	e3cd                	bnez	a5,ffffffffc0207312 <schedule+0xb8>
ffffffffc0207272:	0008f497          	auipc	s1,0x8f
ffffffffc0207276:	64e48493          	addi	s1,s1,1614 # ffffffffc02968c0 <current>
ffffffffc020727a:	608c                	ld	a1,0(s1)
ffffffffc020727c:	0008f997          	auipc	s3,0x8f
ffffffffc0207280:	66c98993          	addi	s3,s3,1644 # ffffffffc02968e8 <sched_class>
ffffffffc0207284:	0008f917          	auipc	s2,0x8f
ffffffffc0207288:	65c90913          	addi	s2,s2,1628 # ffffffffc02968e0 <rq>
ffffffffc020728c:	4194                	lw	a3,0(a1)
ffffffffc020728e:	0005bc23          	sd	zero,24(a1)
ffffffffc0207292:	4709                	li	a4,2
ffffffffc0207294:	0009b783          	ld	a5,0(s3)
ffffffffc0207298:	00093503          	ld	a0,0(s2)
ffffffffc020729c:	04e68e63          	beq	a3,a4,ffffffffc02072f8 <schedule+0x9e>
ffffffffc02072a0:	739c                	ld	a5,32(a5)
ffffffffc02072a2:	9782                	jalr	a5
ffffffffc02072a4:	842a                	mv	s0,a0
ffffffffc02072a6:	c521                	beqz	a0,ffffffffc02072ee <schedule+0x94>
ffffffffc02072a8:	0009b783          	ld	a5,0(s3)
ffffffffc02072ac:	00093503          	ld	a0,0(s2)
ffffffffc02072b0:	85a2                	mv	a1,s0
ffffffffc02072b2:	6f9c                	ld	a5,24(a5)
ffffffffc02072b4:	9782                	jalr	a5
ffffffffc02072b6:	441c                	lw	a5,8(s0)
ffffffffc02072b8:	6098                	ld	a4,0(s1)
ffffffffc02072ba:	2785                	addiw	a5,a5,1
ffffffffc02072bc:	c41c                	sw	a5,8(s0)
ffffffffc02072be:	00870563          	beq	a4,s0,ffffffffc02072c8 <schedule+0x6e>
ffffffffc02072c2:	8522                	mv	a0,s0
ffffffffc02072c4:	88dfe0ef          	jal	ra,ffffffffc0205b50 <proc_run>
ffffffffc02072c8:	000a1a63          	bnez	s4,ffffffffc02072dc <schedule+0x82>
ffffffffc02072cc:	70a2                	ld	ra,40(sp)
ffffffffc02072ce:	7402                	ld	s0,32(sp)
ffffffffc02072d0:	64e2                	ld	s1,24(sp)
ffffffffc02072d2:	6942                	ld	s2,16(sp)
ffffffffc02072d4:	69a2                	ld	s3,8(sp)
ffffffffc02072d6:	6a02                	ld	s4,0(sp)
ffffffffc02072d8:	6145                	addi	sp,sp,48
ffffffffc02072da:	8082                	ret
ffffffffc02072dc:	7402                	ld	s0,32(sp)
ffffffffc02072de:	70a2                	ld	ra,40(sp)
ffffffffc02072e0:	64e2                	ld	s1,24(sp)
ffffffffc02072e2:	6942                	ld	s2,16(sp)
ffffffffc02072e4:	69a2                	ld	s3,8(sp)
ffffffffc02072e6:	6a02                	ld	s4,0(sp)
ffffffffc02072e8:	6145                	addi	sp,sp,48
ffffffffc02072ea:	983f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02072ee:	0008f417          	auipc	s0,0x8f
ffffffffc02072f2:	5da43403          	ld	s0,1498(s0) # ffffffffc02968c8 <idleproc>
ffffffffc02072f6:	b7c1                	j	ffffffffc02072b6 <schedule+0x5c>
ffffffffc02072f8:	0008f717          	auipc	a4,0x8f
ffffffffc02072fc:	5d073703          	ld	a4,1488(a4) # ffffffffc02968c8 <idleproc>
ffffffffc0207300:	fae580e3          	beq	a1,a4,ffffffffc02072a0 <schedule+0x46>
ffffffffc0207304:	6b9c                	ld	a5,16(a5)
ffffffffc0207306:	9782                	jalr	a5
ffffffffc0207308:	0009b783          	ld	a5,0(s3)
ffffffffc020730c:	00093503          	ld	a0,0(s2)
ffffffffc0207310:	bf41                	j	ffffffffc02072a0 <schedule+0x46>
ffffffffc0207312:	961f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207316:	4a05                	li	s4,1
ffffffffc0207318:	bfa9                	j	ffffffffc0207272 <schedule+0x18>

ffffffffc020731a <add_timer>:
ffffffffc020731a:	1141                	addi	sp,sp,-16
ffffffffc020731c:	e022                	sd	s0,0(sp)
ffffffffc020731e:	e406                	sd	ra,8(sp)
ffffffffc0207320:	842a                	mv	s0,a0
ffffffffc0207322:	100027f3          	csrr	a5,sstatus
ffffffffc0207326:	8b89                	andi	a5,a5,2
ffffffffc0207328:	4501                	li	a0,0
ffffffffc020732a:	eba5                	bnez	a5,ffffffffc020739a <add_timer+0x80>
ffffffffc020732c:	401c                	lw	a5,0(s0)
ffffffffc020732e:	cbb5                	beqz	a5,ffffffffc02073a2 <add_timer+0x88>
ffffffffc0207330:	6418                	ld	a4,8(s0)
ffffffffc0207332:	cb25                	beqz	a4,ffffffffc02073a2 <add_timer+0x88>
ffffffffc0207334:	6c18                	ld	a4,24(s0)
ffffffffc0207336:	01040593          	addi	a1,s0,16
ffffffffc020733a:	08e59463          	bne	a1,a4,ffffffffc02073c2 <add_timer+0xa8>
ffffffffc020733e:	0008e617          	auipc	a2,0x8e
ffffffffc0207342:	4b260613          	addi	a2,a2,1202 # ffffffffc02957f0 <timer_list>
ffffffffc0207346:	6618                	ld	a4,8(a2)
ffffffffc0207348:	00c71863          	bne	a4,a2,ffffffffc0207358 <add_timer+0x3e>
ffffffffc020734c:	a80d                	j	ffffffffc020737e <add_timer+0x64>
ffffffffc020734e:	6718                	ld	a4,8(a4)
ffffffffc0207350:	9f95                	subw	a5,a5,a3
ffffffffc0207352:	c01c                	sw	a5,0(s0)
ffffffffc0207354:	02c70563          	beq	a4,a2,ffffffffc020737e <add_timer+0x64>
ffffffffc0207358:	ff072683          	lw	a3,-16(a4)
ffffffffc020735c:	fed7f9e3          	bgeu	a5,a3,ffffffffc020734e <add_timer+0x34>
ffffffffc0207360:	40f687bb          	subw	a5,a3,a5
ffffffffc0207364:	fef72823          	sw	a5,-16(a4)
ffffffffc0207368:	631c                	ld	a5,0(a4)
ffffffffc020736a:	e30c                	sd	a1,0(a4)
ffffffffc020736c:	e78c                	sd	a1,8(a5)
ffffffffc020736e:	ec18                	sd	a4,24(s0)
ffffffffc0207370:	e81c                	sd	a5,16(s0)
ffffffffc0207372:	c105                	beqz	a0,ffffffffc0207392 <add_timer+0x78>
ffffffffc0207374:	6402                	ld	s0,0(sp)
ffffffffc0207376:	60a2                	ld	ra,8(sp)
ffffffffc0207378:	0141                	addi	sp,sp,16
ffffffffc020737a:	8f3f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020737e:	0008e717          	auipc	a4,0x8e
ffffffffc0207382:	47270713          	addi	a4,a4,1138 # ffffffffc02957f0 <timer_list>
ffffffffc0207386:	631c                	ld	a5,0(a4)
ffffffffc0207388:	e30c                	sd	a1,0(a4)
ffffffffc020738a:	e78c                	sd	a1,8(a5)
ffffffffc020738c:	ec18                	sd	a4,24(s0)
ffffffffc020738e:	e81c                	sd	a5,16(s0)
ffffffffc0207390:	f175                	bnez	a0,ffffffffc0207374 <add_timer+0x5a>
ffffffffc0207392:	60a2                	ld	ra,8(sp)
ffffffffc0207394:	6402                	ld	s0,0(sp)
ffffffffc0207396:	0141                	addi	sp,sp,16
ffffffffc0207398:	8082                	ret
ffffffffc020739a:	8d9f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020739e:	4505                	li	a0,1
ffffffffc02073a0:	b771                	j	ffffffffc020732c <add_timer+0x12>
ffffffffc02073a2:	00006697          	auipc	a3,0x6
ffffffffc02073a6:	52668693          	addi	a3,a3,1318 # ffffffffc020d8c8 <CSWTCH.79+0x620>
ffffffffc02073aa:	00004617          	auipc	a2,0x4
ffffffffc02073ae:	4ee60613          	addi	a2,a2,1262 # ffffffffc020b898 <commands+0x210>
ffffffffc02073b2:	07a00593          	li	a1,122
ffffffffc02073b6:	00006517          	auipc	a0,0x6
ffffffffc02073ba:	4da50513          	addi	a0,a0,1242 # ffffffffc020d890 <CSWTCH.79+0x5e8>
ffffffffc02073be:	8e0f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02073c2:	00006697          	auipc	a3,0x6
ffffffffc02073c6:	53668693          	addi	a3,a3,1334 # ffffffffc020d8f8 <CSWTCH.79+0x650>
ffffffffc02073ca:	00004617          	auipc	a2,0x4
ffffffffc02073ce:	4ce60613          	addi	a2,a2,1230 # ffffffffc020b898 <commands+0x210>
ffffffffc02073d2:	07b00593          	li	a1,123
ffffffffc02073d6:	00006517          	auipc	a0,0x6
ffffffffc02073da:	4ba50513          	addi	a0,a0,1210 # ffffffffc020d890 <CSWTCH.79+0x5e8>
ffffffffc02073de:	8c0f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02073e2 <del_timer>:
ffffffffc02073e2:	1101                	addi	sp,sp,-32
ffffffffc02073e4:	e822                	sd	s0,16(sp)
ffffffffc02073e6:	ec06                	sd	ra,24(sp)
ffffffffc02073e8:	e426                	sd	s1,8(sp)
ffffffffc02073ea:	842a                	mv	s0,a0
ffffffffc02073ec:	100027f3          	csrr	a5,sstatus
ffffffffc02073f0:	8b89                	andi	a5,a5,2
ffffffffc02073f2:	01050493          	addi	s1,a0,16
ffffffffc02073f6:	eb9d                	bnez	a5,ffffffffc020742c <del_timer+0x4a>
ffffffffc02073f8:	6d1c                	ld	a5,24(a0)
ffffffffc02073fa:	02978463          	beq	a5,s1,ffffffffc0207422 <del_timer+0x40>
ffffffffc02073fe:	4114                	lw	a3,0(a0)
ffffffffc0207400:	6918                	ld	a4,16(a0)
ffffffffc0207402:	ce81                	beqz	a3,ffffffffc020741a <del_timer+0x38>
ffffffffc0207404:	0008e617          	auipc	a2,0x8e
ffffffffc0207408:	3ec60613          	addi	a2,a2,1004 # ffffffffc02957f0 <timer_list>
ffffffffc020740c:	00c78763          	beq	a5,a2,ffffffffc020741a <del_timer+0x38>
ffffffffc0207410:	ff07a603          	lw	a2,-16(a5)
ffffffffc0207414:	9eb1                	addw	a3,a3,a2
ffffffffc0207416:	fed7a823          	sw	a3,-16(a5)
ffffffffc020741a:	e71c                	sd	a5,8(a4)
ffffffffc020741c:	e398                	sd	a4,0(a5)
ffffffffc020741e:	ec04                	sd	s1,24(s0)
ffffffffc0207420:	e804                	sd	s1,16(s0)
ffffffffc0207422:	60e2                	ld	ra,24(sp)
ffffffffc0207424:	6442                	ld	s0,16(sp)
ffffffffc0207426:	64a2                	ld	s1,8(sp)
ffffffffc0207428:	6105                	addi	sp,sp,32
ffffffffc020742a:	8082                	ret
ffffffffc020742c:	847f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207430:	6c1c                	ld	a5,24(s0)
ffffffffc0207432:	02978463          	beq	a5,s1,ffffffffc020745a <del_timer+0x78>
ffffffffc0207436:	4014                	lw	a3,0(s0)
ffffffffc0207438:	6818                	ld	a4,16(s0)
ffffffffc020743a:	ce81                	beqz	a3,ffffffffc0207452 <del_timer+0x70>
ffffffffc020743c:	0008e617          	auipc	a2,0x8e
ffffffffc0207440:	3b460613          	addi	a2,a2,948 # ffffffffc02957f0 <timer_list>
ffffffffc0207444:	00c78763          	beq	a5,a2,ffffffffc0207452 <del_timer+0x70>
ffffffffc0207448:	ff07a603          	lw	a2,-16(a5)
ffffffffc020744c:	9eb1                	addw	a3,a3,a2
ffffffffc020744e:	fed7a823          	sw	a3,-16(a5)
ffffffffc0207452:	e71c                	sd	a5,8(a4)
ffffffffc0207454:	e398                	sd	a4,0(a5)
ffffffffc0207456:	ec04                	sd	s1,24(s0)
ffffffffc0207458:	e804                	sd	s1,16(s0)
ffffffffc020745a:	6442                	ld	s0,16(sp)
ffffffffc020745c:	60e2                	ld	ra,24(sp)
ffffffffc020745e:	64a2                	ld	s1,8(sp)
ffffffffc0207460:	6105                	addi	sp,sp,32
ffffffffc0207462:	80bf906f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc0207466 <run_timer_list>:
ffffffffc0207466:	7139                	addi	sp,sp,-64
ffffffffc0207468:	fc06                	sd	ra,56(sp)
ffffffffc020746a:	f822                	sd	s0,48(sp)
ffffffffc020746c:	f426                	sd	s1,40(sp)
ffffffffc020746e:	f04a                	sd	s2,32(sp)
ffffffffc0207470:	ec4e                	sd	s3,24(sp)
ffffffffc0207472:	e852                	sd	s4,16(sp)
ffffffffc0207474:	e456                	sd	s5,8(sp)
ffffffffc0207476:	e05a                	sd	s6,0(sp)
ffffffffc0207478:	100027f3          	csrr	a5,sstatus
ffffffffc020747c:	8b89                	andi	a5,a5,2
ffffffffc020747e:	4b01                	li	s6,0
ffffffffc0207480:	efe9                	bnez	a5,ffffffffc020755a <run_timer_list+0xf4>
ffffffffc0207482:	0008e997          	auipc	s3,0x8e
ffffffffc0207486:	36e98993          	addi	s3,s3,878 # ffffffffc02957f0 <timer_list>
ffffffffc020748a:	0089b403          	ld	s0,8(s3)
ffffffffc020748e:	07340a63          	beq	s0,s3,ffffffffc0207502 <run_timer_list+0x9c>
ffffffffc0207492:	ff042783          	lw	a5,-16(s0)
ffffffffc0207496:	ff040913          	addi	s2,s0,-16
ffffffffc020749a:	0e078763          	beqz	a5,ffffffffc0207588 <run_timer_list+0x122>
ffffffffc020749e:	fff7871b          	addiw	a4,a5,-1
ffffffffc02074a2:	fee42823          	sw	a4,-16(s0)
ffffffffc02074a6:	ef31                	bnez	a4,ffffffffc0207502 <run_timer_list+0x9c>
ffffffffc02074a8:	00006a97          	auipc	s5,0x6
ffffffffc02074ac:	4b8a8a93          	addi	s5,s5,1208 # ffffffffc020d960 <CSWTCH.79+0x6b8>
ffffffffc02074b0:	00006a17          	auipc	s4,0x6
ffffffffc02074b4:	3e0a0a13          	addi	s4,s4,992 # ffffffffc020d890 <CSWTCH.79+0x5e8>
ffffffffc02074b8:	a005                	j	ffffffffc02074d8 <run_timer_list+0x72>
ffffffffc02074ba:	0a07d763          	bgez	a5,ffffffffc0207568 <run_timer_list+0x102>
ffffffffc02074be:	8526                	mv	a0,s1
ffffffffc02074c0:	ce9ff0ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc02074c4:	854a                	mv	a0,s2
ffffffffc02074c6:	f1dff0ef          	jal	ra,ffffffffc02073e2 <del_timer>
ffffffffc02074ca:	03340c63          	beq	s0,s3,ffffffffc0207502 <run_timer_list+0x9c>
ffffffffc02074ce:	ff042783          	lw	a5,-16(s0)
ffffffffc02074d2:	ff040913          	addi	s2,s0,-16
ffffffffc02074d6:	e795                	bnez	a5,ffffffffc0207502 <run_timer_list+0x9c>
ffffffffc02074d8:	00893483          	ld	s1,8(s2)
ffffffffc02074dc:	6400                	ld	s0,8(s0)
ffffffffc02074de:	0ec4a783          	lw	a5,236(s1)
ffffffffc02074e2:	ffe1                	bnez	a5,ffffffffc02074ba <run_timer_list+0x54>
ffffffffc02074e4:	40d4                	lw	a3,4(s1)
ffffffffc02074e6:	8656                	mv	a2,s5
ffffffffc02074e8:	0ba00593          	li	a1,186
ffffffffc02074ec:	8552                	mv	a0,s4
ffffffffc02074ee:	818f90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc02074f2:	8526                	mv	a0,s1
ffffffffc02074f4:	cb5ff0ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc02074f8:	854a                	mv	a0,s2
ffffffffc02074fa:	ee9ff0ef          	jal	ra,ffffffffc02073e2 <del_timer>
ffffffffc02074fe:	fd3418e3          	bne	s0,s3,ffffffffc02074ce <run_timer_list+0x68>
ffffffffc0207502:	0008f597          	auipc	a1,0x8f
ffffffffc0207506:	3be5b583          	ld	a1,958(a1) # ffffffffc02968c0 <current>
ffffffffc020750a:	c18d                	beqz	a1,ffffffffc020752c <run_timer_list+0xc6>
ffffffffc020750c:	0008f797          	auipc	a5,0x8f
ffffffffc0207510:	3bc7b783          	ld	a5,956(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0207514:	04f58763          	beq	a1,a5,ffffffffc0207562 <run_timer_list+0xfc>
ffffffffc0207518:	0008f797          	auipc	a5,0x8f
ffffffffc020751c:	3d07b783          	ld	a5,976(a5) # ffffffffc02968e8 <sched_class>
ffffffffc0207520:	779c                	ld	a5,40(a5)
ffffffffc0207522:	0008f517          	auipc	a0,0x8f
ffffffffc0207526:	3be53503          	ld	a0,958(a0) # ffffffffc02968e0 <rq>
ffffffffc020752a:	9782                	jalr	a5
ffffffffc020752c:	000b1c63          	bnez	s6,ffffffffc0207544 <run_timer_list+0xde>
ffffffffc0207530:	70e2                	ld	ra,56(sp)
ffffffffc0207532:	7442                	ld	s0,48(sp)
ffffffffc0207534:	74a2                	ld	s1,40(sp)
ffffffffc0207536:	7902                	ld	s2,32(sp)
ffffffffc0207538:	69e2                	ld	s3,24(sp)
ffffffffc020753a:	6a42                	ld	s4,16(sp)
ffffffffc020753c:	6aa2                	ld	s5,8(sp)
ffffffffc020753e:	6b02                	ld	s6,0(sp)
ffffffffc0207540:	6121                	addi	sp,sp,64
ffffffffc0207542:	8082                	ret
ffffffffc0207544:	7442                	ld	s0,48(sp)
ffffffffc0207546:	70e2                	ld	ra,56(sp)
ffffffffc0207548:	74a2                	ld	s1,40(sp)
ffffffffc020754a:	7902                	ld	s2,32(sp)
ffffffffc020754c:	69e2                	ld	s3,24(sp)
ffffffffc020754e:	6a42                	ld	s4,16(sp)
ffffffffc0207550:	6aa2                	ld	s5,8(sp)
ffffffffc0207552:	6b02                	ld	s6,0(sp)
ffffffffc0207554:	6121                	addi	sp,sp,64
ffffffffc0207556:	f16f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020755a:	f18f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020755e:	4b05                	li	s6,1
ffffffffc0207560:	b70d                	j	ffffffffc0207482 <run_timer_list+0x1c>
ffffffffc0207562:	4785                	li	a5,1
ffffffffc0207564:	ed9c                	sd	a5,24(a1)
ffffffffc0207566:	b7d9                	j	ffffffffc020752c <run_timer_list+0xc6>
ffffffffc0207568:	00006697          	auipc	a3,0x6
ffffffffc020756c:	3d068693          	addi	a3,a3,976 # ffffffffc020d938 <CSWTCH.79+0x690>
ffffffffc0207570:	00004617          	auipc	a2,0x4
ffffffffc0207574:	32860613          	addi	a2,a2,808 # ffffffffc020b898 <commands+0x210>
ffffffffc0207578:	0b600593          	li	a1,182
ffffffffc020757c:	00006517          	auipc	a0,0x6
ffffffffc0207580:	31450513          	addi	a0,a0,788 # ffffffffc020d890 <CSWTCH.79+0x5e8>
ffffffffc0207584:	f1bf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207588:	00006697          	auipc	a3,0x6
ffffffffc020758c:	39868693          	addi	a3,a3,920 # ffffffffc020d920 <CSWTCH.79+0x678>
ffffffffc0207590:	00004617          	auipc	a2,0x4
ffffffffc0207594:	30860613          	addi	a2,a2,776 # ffffffffc020b898 <commands+0x210>
ffffffffc0207598:	0ae00593          	li	a1,174
ffffffffc020759c:	00006517          	auipc	a0,0x6
ffffffffc02075a0:	2f450513          	addi	a0,a0,756 # ffffffffc020d890 <CSWTCH.79+0x5e8>
ffffffffc02075a4:	efbf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02075a8 <sys_getpid>:
ffffffffc02075a8:	0008f797          	auipc	a5,0x8f
ffffffffc02075ac:	3187b783          	ld	a5,792(a5) # ffffffffc02968c0 <current>
ffffffffc02075b0:	43c8                	lw	a0,4(a5)
ffffffffc02075b2:	8082                	ret

ffffffffc02075b4 <sys_pgdir>:
ffffffffc02075b4:	4501                	li	a0,0
ffffffffc02075b6:	8082                	ret

ffffffffc02075b8 <sys_gettime>:
ffffffffc02075b8:	0008f797          	auipc	a5,0x8f
ffffffffc02075bc:	2b87b783          	ld	a5,696(a5) # ffffffffc0296870 <ticks>
ffffffffc02075c0:	0027951b          	slliw	a0,a5,0x2
ffffffffc02075c4:	9d3d                	addw	a0,a0,a5
ffffffffc02075c6:	0015151b          	slliw	a0,a0,0x1
ffffffffc02075ca:	8082                	ret

ffffffffc02075cc <sys_lab6_set_priority>:
ffffffffc02075cc:	4108                	lw	a0,0(a0)
ffffffffc02075ce:	1141                	addi	sp,sp,-16
ffffffffc02075d0:	e406                	sd	ra,8(sp)
ffffffffc02075d2:	975ff0ef          	jal	ra,ffffffffc0206f46 <lab6_set_priority>
ffffffffc02075d6:	60a2                	ld	ra,8(sp)
ffffffffc02075d8:	4501                	li	a0,0
ffffffffc02075da:	0141                	addi	sp,sp,16
ffffffffc02075dc:	8082                	ret

ffffffffc02075de <sys_dup>:
ffffffffc02075de:	450c                	lw	a1,8(a0)
ffffffffc02075e0:	4108                	lw	a0,0(a0)
ffffffffc02075e2:	be6fe06f          	j	ffffffffc02059c8 <sysfile_dup>

ffffffffc02075e6 <sys_getdirentry>:
ffffffffc02075e6:	650c                	ld	a1,8(a0)
ffffffffc02075e8:	4108                	lw	a0,0(a0)
ffffffffc02075ea:	aeefe06f          	j	ffffffffc02058d8 <sysfile_getdirentry>

ffffffffc02075ee <sys_getcwd>:
ffffffffc02075ee:	650c                	ld	a1,8(a0)
ffffffffc02075f0:	6108                	ld	a0,0(a0)
ffffffffc02075f2:	a42fe06f          	j	ffffffffc0205834 <sysfile_getcwd>

ffffffffc02075f6 <sys_fsync>:
ffffffffc02075f6:	4108                	lw	a0,0(a0)
ffffffffc02075f8:	a38fe06f          	j	ffffffffc0205830 <sysfile_fsync>

ffffffffc02075fc <sys_fstat>:
ffffffffc02075fc:	650c                	ld	a1,8(a0)
ffffffffc02075fe:	4108                	lw	a0,0(a0)
ffffffffc0207600:	990fe06f          	j	ffffffffc0205790 <sysfile_fstat>

ffffffffc0207604 <sys_seek>:
ffffffffc0207604:	4910                	lw	a2,16(a0)
ffffffffc0207606:	650c                	ld	a1,8(a0)
ffffffffc0207608:	4108                	lw	a0,0(a0)
ffffffffc020760a:	982fe06f          	j	ffffffffc020578c <sysfile_seek>

ffffffffc020760e <sys_write>:
ffffffffc020760e:	6910                	ld	a2,16(a0)
ffffffffc0207610:	650c                	ld	a1,8(a0)
ffffffffc0207612:	4108                	lw	a0,0(a0)
ffffffffc0207614:	85efe06f          	j	ffffffffc0205672 <sysfile_write>

ffffffffc0207618 <sys_read>:
ffffffffc0207618:	6910                	ld	a2,16(a0)
ffffffffc020761a:	650c                	ld	a1,8(a0)
ffffffffc020761c:	4108                	lw	a0,0(a0)
ffffffffc020761e:	f41fd06f          	j	ffffffffc020555e <sysfile_read>

ffffffffc0207622 <sys_close>:
ffffffffc0207622:	4108                	lw	a0,0(a0)
ffffffffc0207624:	f37fd06f          	j	ffffffffc020555a <sysfile_close>

ffffffffc0207628 <sys_open>:
ffffffffc0207628:	450c                	lw	a1,8(a0)
ffffffffc020762a:	6108                	ld	a0,0(a0)
ffffffffc020762c:	efbfd06f          	j	ffffffffc0205526 <sysfile_open>

ffffffffc0207630 <sys_putc>:
ffffffffc0207630:	4108                	lw	a0,0(a0)
ffffffffc0207632:	1141                	addi	sp,sp,-16
ffffffffc0207634:	e406                	sd	ra,8(sp)
ffffffffc0207636:	badf80ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc020763a:	60a2                	ld	ra,8(sp)
ffffffffc020763c:	4501                	li	a0,0
ffffffffc020763e:	0141                	addi	sp,sp,16
ffffffffc0207640:	8082                	ret

ffffffffc0207642 <sys_kill>:
ffffffffc0207642:	4108                	lw	a0,0(a0)
ffffffffc0207644:	ea0ff06f          	j	ffffffffc0206ce4 <do_kill>

ffffffffc0207648 <sys_sleep>:
ffffffffc0207648:	4108                	lw	a0,0(a0)
ffffffffc020764a:	937ff06f          	j	ffffffffc0206f80 <do_sleep>

ffffffffc020764e <sys_yield>:
ffffffffc020764e:	e48ff06f          	j	ffffffffc0206c96 <do_yield>

ffffffffc0207652 <sys_exec>:
ffffffffc0207652:	6910                	ld	a2,16(a0)
ffffffffc0207654:	450c                	lw	a1,8(a0)
ffffffffc0207656:	6108                	ld	a0,0(a0)
ffffffffc0207658:	e43fe06f          	j	ffffffffc020649a <do_execve>

ffffffffc020765c <sys_wait>:
ffffffffc020765c:	650c                	ld	a1,8(a0)
ffffffffc020765e:	4108                	lw	a0,0(a0)
ffffffffc0207660:	e46ff06f          	j	ffffffffc0206ca6 <do_wait>

ffffffffc0207664 <sys_fork>:
ffffffffc0207664:	0008f797          	auipc	a5,0x8f
ffffffffc0207668:	25c7b783          	ld	a5,604(a5) # ffffffffc02968c0 <current>
ffffffffc020766c:	73d0                	ld	a2,160(a5)
ffffffffc020766e:	4501                	li	a0,0
ffffffffc0207670:	6a0c                	ld	a1,16(a2)
ffffffffc0207672:	d3cfe06f          	j	ffffffffc0205bae <do_fork>

ffffffffc0207676 <sys_exit>:
ffffffffc0207676:	4108                	lw	a0,0(a0)
ffffffffc0207678:	99ffe06f          	j	ffffffffc0206016 <do_exit>

ffffffffc020767c <syscall>:
ffffffffc020767c:	715d                	addi	sp,sp,-80
ffffffffc020767e:	fc26                	sd	s1,56(sp)
ffffffffc0207680:	0008f497          	auipc	s1,0x8f
ffffffffc0207684:	24048493          	addi	s1,s1,576 # ffffffffc02968c0 <current>
ffffffffc0207688:	6098                	ld	a4,0(s1)
ffffffffc020768a:	e0a2                	sd	s0,64(sp)
ffffffffc020768c:	f84a                	sd	s2,48(sp)
ffffffffc020768e:	7340                	ld	s0,160(a4)
ffffffffc0207690:	e486                	sd	ra,72(sp)
ffffffffc0207692:	0ff00793          	li	a5,255
ffffffffc0207696:	05042903          	lw	s2,80(s0)
ffffffffc020769a:	0327ee63          	bltu	a5,s2,ffffffffc02076d6 <syscall+0x5a>
ffffffffc020769e:	00391713          	slli	a4,s2,0x3
ffffffffc02076a2:	00006797          	auipc	a5,0x6
ffffffffc02076a6:	32678793          	addi	a5,a5,806 # ffffffffc020d9c8 <syscalls>
ffffffffc02076aa:	97ba                	add	a5,a5,a4
ffffffffc02076ac:	639c                	ld	a5,0(a5)
ffffffffc02076ae:	c785                	beqz	a5,ffffffffc02076d6 <syscall+0x5a>
ffffffffc02076b0:	6c28                	ld	a0,88(s0)
ffffffffc02076b2:	702c                	ld	a1,96(s0)
ffffffffc02076b4:	7430                	ld	a2,104(s0)
ffffffffc02076b6:	7834                	ld	a3,112(s0)
ffffffffc02076b8:	7c38                	ld	a4,120(s0)
ffffffffc02076ba:	e42a                	sd	a0,8(sp)
ffffffffc02076bc:	e82e                	sd	a1,16(sp)
ffffffffc02076be:	ec32                	sd	a2,24(sp)
ffffffffc02076c0:	f036                	sd	a3,32(sp)
ffffffffc02076c2:	f43a                	sd	a4,40(sp)
ffffffffc02076c4:	0028                	addi	a0,sp,8
ffffffffc02076c6:	9782                	jalr	a5
ffffffffc02076c8:	60a6                	ld	ra,72(sp)
ffffffffc02076ca:	e828                	sd	a0,80(s0)
ffffffffc02076cc:	6406                	ld	s0,64(sp)
ffffffffc02076ce:	74e2                	ld	s1,56(sp)
ffffffffc02076d0:	7942                	ld	s2,48(sp)
ffffffffc02076d2:	6161                	addi	sp,sp,80
ffffffffc02076d4:	8082                	ret
ffffffffc02076d6:	8522                	mv	a0,s0
ffffffffc02076d8:	8b3f90ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc02076dc:	609c                	ld	a5,0(s1)
ffffffffc02076de:	86ca                	mv	a3,s2
ffffffffc02076e0:	00006617          	auipc	a2,0x6
ffffffffc02076e4:	2a060613          	addi	a2,a2,672 # ffffffffc020d980 <CSWTCH.79+0x6d8>
ffffffffc02076e8:	43d8                	lw	a4,4(a5)
ffffffffc02076ea:	0d800593          	li	a1,216
ffffffffc02076ee:	0b478793          	addi	a5,a5,180
ffffffffc02076f2:	00006517          	auipc	a0,0x6
ffffffffc02076f6:	2be50513          	addi	a0,a0,702 # ffffffffc020d9b0 <CSWTCH.79+0x708>
ffffffffc02076fa:	da5f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02076fe <__alloc_inode>:
ffffffffc02076fe:	1141                	addi	sp,sp,-16
ffffffffc0207700:	e022                	sd	s0,0(sp)
ffffffffc0207702:	842a                	mv	s0,a0
ffffffffc0207704:	07800513          	li	a0,120
ffffffffc0207708:	e406                	sd	ra,8(sp)
ffffffffc020770a:	885fa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020770e:	c111                	beqz	a0,ffffffffc0207712 <__alloc_inode+0x14>
ffffffffc0207710:	cd20                	sw	s0,88(a0)
ffffffffc0207712:	60a2                	ld	ra,8(sp)
ffffffffc0207714:	6402                	ld	s0,0(sp)
ffffffffc0207716:	0141                	addi	sp,sp,16
ffffffffc0207718:	8082                	ret

ffffffffc020771a <inode_init>:
ffffffffc020771a:	4785                	li	a5,1
ffffffffc020771c:	06052023          	sw	zero,96(a0)
ffffffffc0207720:	f92c                	sd	a1,112(a0)
ffffffffc0207722:	f530                	sd	a2,104(a0)
ffffffffc0207724:	cd7c                	sw	a5,92(a0)
ffffffffc0207726:	8082                	ret

ffffffffc0207728 <inode_kill>:
ffffffffc0207728:	4d78                	lw	a4,92(a0)
ffffffffc020772a:	1141                	addi	sp,sp,-16
ffffffffc020772c:	e406                	sd	ra,8(sp)
ffffffffc020772e:	e719                	bnez	a4,ffffffffc020773c <inode_kill+0x14>
ffffffffc0207730:	513c                	lw	a5,96(a0)
ffffffffc0207732:	e78d                	bnez	a5,ffffffffc020775c <inode_kill+0x34>
ffffffffc0207734:	60a2                	ld	ra,8(sp)
ffffffffc0207736:	0141                	addi	sp,sp,16
ffffffffc0207738:	907fa06f          	j	ffffffffc020203e <kfree>
ffffffffc020773c:	00007697          	auipc	a3,0x7
ffffffffc0207740:	a8c68693          	addi	a3,a3,-1396 # ffffffffc020e1c8 <syscalls+0x800>
ffffffffc0207744:	00004617          	auipc	a2,0x4
ffffffffc0207748:	15460613          	addi	a2,a2,340 # ffffffffc020b898 <commands+0x210>
ffffffffc020774c:	02900593          	li	a1,41
ffffffffc0207750:	00007517          	auipc	a0,0x7
ffffffffc0207754:	a9850513          	addi	a0,a0,-1384 # ffffffffc020e1e8 <syscalls+0x820>
ffffffffc0207758:	d47f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020775c:	00007697          	auipc	a3,0x7
ffffffffc0207760:	aa468693          	addi	a3,a3,-1372 # ffffffffc020e200 <syscalls+0x838>
ffffffffc0207764:	00004617          	auipc	a2,0x4
ffffffffc0207768:	13460613          	addi	a2,a2,308 # ffffffffc020b898 <commands+0x210>
ffffffffc020776c:	02a00593          	li	a1,42
ffffffffc0207770:	00007517          	auipc	a0,0x7
ffffffffc0207774:	a7850513          	addi	a0,a0,-1416 # ffffffffc020e1e8 <syscalls+0x820>
ffffffffc0207778:	d27f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020777c <inode_ref_inc>:
ffffffffc020777c:	4d7c                	lw	a5,92(a0)
ffffffffc020777e:	2785                	addiw	a5,a5,1
ffffffffc0207780:	cd7c                	sw	a5,92(a0)
ffffffffc0207782:	0007851b          	sext.w	a0,a5
ffffffffc0207786:	8082                	ret

ffffffffc0207788 <inode_open_inc>:
ffffffffc0207788:	513c                	lw	a5,96(a0)
ffffffffc020778a:	2785                	addiw	a5,a5,1
ffffffffc020778c:	d13c                	sw	a5,96(a0)
ffffffffc020778e:	0007851b          	sext.w	a0,a5
ffffffffc0207792:	8082                	ret

ffffffffc0207794 <inode_check>:
ffffffffc0207794:	1141                	addi	sp,sp,-16
ffffffffc0207796:	e406                	sd	ra,8(sp)
ffffffffc0207798:	c90d                	beqz	a0,ffffffffc02077ca <inode_check+0x36>
ffffffffc020779a:	793c                	ld	a5,112(a0)
ffffffffc020779c:	c79d                	beqz	a5,ffffffffc02077ca <inode_check+0x36>
ffffffffc020779e:	6398                	ld	a4,0(a5)
ffffffffc02077a0:	4625d7b7          	lui	a5,0x4625d
ffffffffc02077a4:	0786                	slli	a5,a5,0x1
ffffffffc02077a6:	47678793          	addi	a5,a5,1142 # 4625d476 <_binary_bin_sfs_img_size+0x461e8176>
ffffffffc02077aa:	08f71063          	bne	a4,a5,ffffffffc020782a <inode_check+0x96>
ffffffffc02077ae:	4d78                	lw	a4,92(a0)
ffffffffc02077b0:	513c                	lw	a5,96(a0)
ffffffffc02077b2:	04f74c63          	blt	a4,a5,ffffffffc020780a <inode_check+0x76>
ffffffffc02077b6:	0407ca63          	bltz	a5,ffffffffc020780a <inode_check+0x76>
ffffffffc02077ba:	66c1                	lui	a3,0x10
ffffffffc02077bc:	02d75763          	bge	a4,a3,ffffffffc02077ea <inode_check+0x56>
ffffffffc02077c0:	02d7d563          	bge	a5,a3,ffffffffc02077ea <inode_check+0x56>
ffffffffc02077c4:	60a2                	ld	ra,8(sp)
ffffffffc02077c6:	0141                	addi	sp,sp,16
ffffffffc02077c8:	8082                	ret
ffffffffc02077ca:	00007697          	auipc	a3,0x7
ffffffffc02077ce:	a5668693          	addi	a3,a3,-1450 # ffffffffc020e220 <syscalls+0x858>
ffffffffc02077d2:	00004617          	auipc	a2,0x4
ffffffffc02077d6:	0c660613          	addi	a2,a2,198 # ffffffffc020b898 <commands+0x210>
ffffffffc02077da:	06e00593          	li	a1,110
ffffffffc02077de:	00007517          	auipc	a0,0x7
ffffffffc02077e2:	a0a50513          	addi	a0,a0,-1526 # ffffffffc020e1e8 <syscalls+0x820>
ffffffffc02077e6:	cb9f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02077ea:	00007697          	auipc	a3,0x7
ffffffffc02077ee:	ab668693          	addi	a3,a3,-1354 # ffffffffc020e2a0 <syscalls+0x8d8>
ffffffffc02077f2:	00004617          	auipc	a2,0x4
ffffffffc02077f6:	0a660613          	addi	a2,a2,166 # ffffffffc020b898 <commands+0x210>
ffffffffc02077fa:	07200593          	li	a1,114
ffffffffc02077fe:	00007517          	auipc	a0,0x7
ffffffffc0207802:	9ea50513          	addi	a0,a0,-1558 # ffffffffc020e1e8 <syscalls+0x820>
ffffffffc0207806:	c99f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020780a:	00007697          	auipc	a3,0x7
ffffffffc020780e:	a6668693          	addi	a3,a3,-1434 # ffffffffc020e270 <syscalls+0x8a8>
ffffffffc0207812:	00004617          	auipc	a2,0x4
ffffffffc0207816:	08660613          	addi	a2,a2,134 # ffffffffc020b898 <commands+0x210>
ffffffffc020781a:	07100593          	li	a1,113
ffffffffc020781e:	00007517          	auipc	a0,0x7
ffffffffc0207822:	9ca50513          	addi	a0,a0,-1590 # ffffffffc020e1e8 <syscalls+0x820>
ffffffffc0207826:	c79f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020782a:	00007697          	auipc	a3,0x7
ffffffffc020782e:	a1e68693          	addi	a3,a3,-1506 # ffffffffc020e248 <syscalls+0x880>
ffffffffc0207832:	00004617          	auipc	a2,0x4
ffffffffc0207836:	06660613          	addi	a2,a2,102 # ffffffffc020b898 <commands+0x210>
ffffffffc020783a:	06f00593          	li	a1,111
ffffffffc020783e:	00007517          	auipc	a0,0x7
ffffffffc0207842:	9aa50513          	addi	a0,a0,-1622 # ffffffffc020e1e8 <syscalls+0x820>
ffffffffc0207846:	c59f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020784a <inode_ref_dec>:
ffffffffc020784a:	4d7c                	lw	a5,92(a0)
ffffffffc020784c:	1101                	addi	sp,sp,-32
ffffffffc020784e:	ec06                	sd	ra,24(sp)
ffffffffc0207850:	e822                	sd	s0,16(sp)
ffffffffc0207852:	e426                	sd	s1,8(sp)
ffffffffc0207854:	e04a                	sd	s2,0(sp)
ffffffffc0207856:	06f05e63          	blez	a5,ffffffffc02078d2 <inode_ref_dec+0x88>
ffffffffc020785a:	fff7849b          	addiw	s1,a5,-1
ffffffffc020785e:	cd64                	sw	s1,92(a0)
ffffffffc0207860:	842a                	mv	s0,a0
ffffffffc0207862:	e09d                	bnez	s1,ffffffffc0207888 <inode_ref_dec+0x3e>
ffffffffc0207864:	793c                	ld	a5,112(a0)
ffffffffc0207866:	c7b1                	beqz	a5,ffffffffc02078b2 <inode_ref_dec+0x68>
ffffffffc0207868:	0487b903          	ld	s2,72(a5)
ffffffffc020786c:	04090363          	beqz	s2,ffffffffc02078b2 <inode_ref_dec+0x68>
ffffffffc0207870:	00007597          	auipc	a1,0x7
ffffffffc0207874:	ae058593          	addi	a1,a1,-1312 # ffffffffc020e350 <syscalls+0x988>
ffffffffc0207878:	f1dff0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc020787c:	8522                	mv	a0,s0
ffffffffc020787e:	9902                	jalr	s2
ffffffffc0207880:	c501                	beqz	a0,ffffffffc0207888 <inode_ref_dec+0x3e>
ffffffffc0207882:	57c5                	li	a5,-15
ffffffffc0207884:	00f51963          	bne	a0,a5,ffffffffc0207896 <inode_ref_dec+0x4c>
ffffffffc0207888:	60e2                	ld	ra,24(sp)
ffffffffc020788a:	6442                	ld	s0,16(sp)
ffffffffc020788c:	6902                	ld	s2,0(sp)
ffffffffc020788e:	8526                	mv	a0,s1
ffffffffc0207890:	64a2                	ld	s1,8(sp)
ffffffffc0207892:	6105                	addi	sp,sp,32
ffffffffc0207894:	8082                	ret
ffffffffc0207896:	85aa                	mv	a1,a0
ffffffffc0207898:	00007517          	auipc	a0,0x7
ffffffffc020789c:	ac050513          	addi	a0,a0,-1344 # ffffffffc020e358 <syscalls+0x990>
ffffffffc02078a0:	907f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02078a4:	60e2                	ld	ra,24(sp)
ffffffffc02078a6:	6442                	ld	s0,16(sp)
ffffffffc02078a8:	6902                	ld	s2,0(sp)
ffffffffc02078aa:	8526                	mv	a0,s1
ffffffffc02078ac:	64a2                	ld	s1,8(sp)
ffffffffc02078ae:	6105                	addi	sp,sp,32
ffffffffc02078b0:	8082                	ret
ffffffffc02078b2:	00007697          	auipc	a3,0x7
ffffffffc02078b6:	a4e68693          	addi	a3,a3,-1458 # ffffffffc020e300 <syscalls+0x938>
ffffffffc02078ba:	00004617          	auipc	a2,0x4
ffffffffc02078be:	fde60613          	addi	a2,a2,-34 # ffffffffc020b898 <commands+0x210>
ffffffffc02078c2:	04400593          	li	a1,68
ffffffffc02078c6:	00007517          	auipc	a0,0x7
ffffffffc02078ca:	92250513          	addi	a0,a0,-1758 # ffffffffc020e1e8 <syscalls+0x820>
ffffffffc02078ce:	bd1f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02078d2:	00007697          	auipc	a3,0x7
ffffffffc02078d6:	a0e68693          	addi	a3,a3,-1522 # ffffffffc020e2e0 <syscalls+0x918>
ffffffffc02078da:	00004617          	auipc	a2,0x4
ffffffffc02078de:	fbe60613          	addi	a2,a2,-66 # ffffffffc020b898 <commands+0x210>
ffffffffc02078e2:	03f00593          	li	a1,63
ffffffffc02078e6:	00007517          	auipc	a0,0x7
ffffffffc02078ea:	90250513          	addi	a0,a0,-1790 # ffffffffc020e1e8 <syscalls+0x820>
ffffffffc02078ee:	bb1f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02078f2 <inode_open_dec>:
ffffffffc02078f2:	513c                	lw	a5,96(a0)
ffffffffc02078f4:	1101                	addi	sp,sp,-32
ffffffffc02078f6:	ec06                	sd	ra,24(sp)
ffffffffc02078f8:	e822                	sd	s0,16(sp)
ffffffffc02078fa:	e426                	sd	s1,8(sp)
ffffffffc02078fc:	e04a                	sd	s2,0(sp)
ffffffffc02078fe:	06f05b63          	blez	a5,ffffffffc0207974 <inode_open_dec+0x82>
ffffffffc0207902:	fff7849b          	addiw	s1,a5,-1
ffffffffc0207906:	d124                	sw	s1,96(a0)
ffffffffc0207908:	842a                	mv	s0,a0
ffffffffc020790a:	e085                	bnez	s1,ffffffffc020792a <inode_open_dec+0x38>
ffffffffc020790c:	793c                	ld	a5,112(a0)
ffffffffc020790e:	c3b9                	beqz	a5,ffffffffc0207954 <inode_open_dec+0x62>
ffffffffc0207910:	0107b903          	ld	s2,16(a5)
ffffffffc0207914:	04090063          	beqz	s2,ffffffffc0207954 <inode_open_dec+0x62>
ffffffffc0207918:	00007597          	auipc	a1,0x7
ffffffffc020791c:	ad058593          	addi	a1,a1,-1328 # ffffffffc020e3e8 <syscalls+0xa20>
ffffffffc0207920:	e75ff0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0207924:	8522                	mv	a0,s0
ffffffffc0207926:	9902                	jalr	s2
ffffffffc0207928:	e901                	bnez	a0,ffffffffc0207938 <inode_open_dec+0x46>
ffffffffc020792a:	60e2                	ld	ra,24(sp)
ffffffffc020792c:	6442                	ld	s0,16(sp)
ffffffffc020792e:	6902                	ld	s2,0(sp)
ffffffffc0207930:	8526                	mv	a0,s1
ffffffffc0207932:	64a2                	ld	s1,8(sp)
ffffffffc0207934:	6105                	addi	sp,sp,32
ffffffffc0207936:	8082                	ret
ffffffffc0207938:	85aa                	mv	a1,a0
ffffffffc020793a:	00007517          	auipc	a0,0x7
ffffffffc020793e:	ab650513          	addi	a0,a0,-1354 # ffffffffc020e3f0 <syscalls+0xa28>
ffffffffc0207942:	865f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207946:	60e2                	ld	ra,24(sp)
ffffffffc0207948:	6442                	ld	s0,16(sp)
ffffffffc020794a:	6902                	ld	s2,0(sp)
ffffffffc020794c:	8526                	mv	a0,s1
ffffffffc020794e:	64a2                	ld	s1,8(sp)
ffffffffc0207950:	6105                	addi	sp,sp,32
ffffffffc0207952:	8082                	ret
ffffffffc0207954:	00007697          	auipc	a3,0x7
ffffffffc0207958:	a4468693          	addi	a3,a3,-1468 # ffffffffc020e398 <syscalls+0x9d0>
ffffffffc020795c:	00004617          	auipc	a2,0x4
ffffffffc0207960:	f3c60613          	addi	a2,a2,-196 # ffffffffc020b898 <commands+0x210>
ffffffffc0207964:	06100593          	li	a1,97
ffffffffc0207968:	00007517          	auipc	a0,0x7
ffffffffc020796c:	88050513          	addi	a0,a0,-1920 # ffffffffc020e1e8 <syscalls+0x820>
ffffffffc0207970:	b2ff80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207974:	00007697          	auipc	a3,0x7
ffffffffc0207978:	a0468693          	addi	a3,a3,-1532 # ffffffffc020e378 <syscalls+0x9b0>
ffffffffc020797c:	00004617          	auipc	a2,0x4
ffffffffc0207980:	f1c60613          	addi	a2,a2,-228 # ffffffffc020b898 <commands+0x210>
ffffffffc0207984:	05c00593          	li	a1,92
ffffffffc0207988:	00007517          	auipc	a0,0x7
ffffffffc020798c:	86050513          	addi	a0,a0,-1952 # ffffffffc020e1e8 <syscalls+0x820>
ffffffffc0207990:	b0ff80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207994 <__alloc_fs>:
ffffffffc0207994:	1141                	addi	sp,sp,-16
ffffffffc0207996:	e022                	sd	s0,0(sp)
ffffffffc0207998:	842a                	mv	s0,a0
ffffffffc020799a:	0d800513          	li	a0,216
ffffffffc020799e:	e406                	sd	ra,8(sp)
ffffffffc02079a0:	deefa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02079a4:	c119                	beqz	a0,ffffffffc02079aa <__alloc_fs+0x16>
ffffffffc02079a6:	0a852823          	sw	s0,176(a0)
ffffffffc02079aa:	60a2                	ld	ra,8(sp)
ffffffffc02079ac:	6402                	ld	s0,0(sp)
ffffffffc02079ae:	0141                	addi	sp,sp,16
ffffffffc02079b0:	8082                	ret

ffffffffc02079b2 <vfs_init>:
ffffffffc02079b2:	1141                	addi	sp,sp,-16
ffffffffc02079b4:	4585                	li	a1,1
ffffffffc02079b6:	0008e517          	auipc	a0,0x8e
ffffffffc02079ba:	e4a50513          	addi	a0,a0,-438 # ffffffffc0295800 <bootfs_sem>
ffffffffc02079be:	e406                	sd	ra,8(sp)
ffffffffc02079c0:	b9bfc0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc02079c4:	60a2                	ld	ra,8(sp)
ffffffffc02079c6:	0141                	addi	sp,sp,16
ffffffffc02079c8:	a40d                	j	ffffffffc0207bea <vfs_devlist_init>

ffffffffc02079ca <vfs_set_bootfs>:
ffffffffc02079ca:	7179                	addi	sp,sp,-48
ffffffffc02079cc:	f022                	sd	s0,32(sp)
ffffffffc02079ce:	f406                	sd	ra,40(sp)
ffffffffc02079d0:	ec26                	sd	s1,24(sp)
ffffffffc02079d2:	e402                	sd	zero,8(sp)
ffffffffc02079d4:	842a                	mv	s0,a0
ffffffffc02079d6:	c915                	beqz	a0,ffffffffc0207a0a <vfs_set_bootfs+0x40>
ffffffffc02079d8:	03a00593          	li	a1,58
ffffffffc02079dc:	1c5030ef          	jal	ra,ffffffffc020b3a0 <strchr>
ffffffffc02079e0:	c135                	beqz	a0,ffffffffc0207a44 <vfs_set_bootfs+0x7a>
ffffffffc02079e2:	00154783          	lbu	a5,1(a0)
ffffffffc02079e6:	efb9                	bnez	a5,ffffffffc0207a44 <vfs_set_bootfs+0x7a>
ffffffffc02079e8:	8522                	mv	a0,s0
ffffffffc02079ea:	11f000ef          	jal	ra,ffffffffc0208308 <vfs_chdir>
ffffffffc02079ee:	842a                	mv	s0,a0
ffffffffc02079f0:	c519                	beqz	a0,ffffffffc02079fe <vfs_set_bootfs+0x34>
ffffffffc02079f2:	70a2                	ld	ra,40(sp)
ffffffffc02079f4:	8522                	mv	a0,s0
ffffffffc02079f6:	7402                	ld	s0,32(sp)
ffffffffc02079f8:	64e2                	ld	s1,24(sp)
ffffffffc02079fa:	6145                	addi	sp,sp,48
ffffffffc02079fc:	8082                	ret
ffffffffc02079fe:	0028                	addi	a0,sp,8
ffffffffc0207a00:	013000ef          	jal	ra,ffffffffc0208212 <vfs_get_curdir>
ffffffffc0207a04:	842a                	mv	s0,a0
ffffffffc0207a06:	f575                	bnez	a0,ffffffffc02079f2 <vfs_set_bootfs+0x28>
ffffffffc0207a08:	6422                	ld	s0,8(sp)
ffffffffc0207a0a:	0008e517          	auipc	a0,0x8e
ffffffffc0207a0e:	df650513          	addi	a0,a0,-522 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207a12:	b53fc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207a16:	0008f797          	auipc	a5,0x8f
ffffffffc0207a1a:	eda78793          	addi	a5,a5,-294 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207a1e:	6384                	ld	s1,0(a5)
ffffffffc0207a20:	0008e517          	auipc	a0,0x8e
ffffffffc0207a24:	de050513          	addi	a0,a0,-544 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207a28:	e380                	sd	s0,0(a5)
ffffffffc0207a2a:	4401                	li	s0,0
ffffffffc0207a2c:	b35fc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207a30:	d0e9                	beqz	s1,ffffffffc02079f2 <vfs_set_bootfs+0x28>
ffffffffc0207a32:	8526                	mv	a0,s1
ffffffffc0207a34:	e17ff0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc0207a38:	70a2                	ld	ra,40(sp)
ffffffffc0207a3a:	8522                	mv	a0,s0
ffffffffc0207a3c:	7402                	ld	s0,32(sp)
ffffffffc0207a3e:	64e2                	ld	s1,24(sp)
ffffffffc0207a40:	6145                	addi	sp,sp,48
ffffffffc0207a42:	8082                	ret
ffffffffc0207a44:	5475                	li	s0,-3
ffffffffc0207a46:	b775                	j	ffffffffc02079f2 <vfs_set_bootfs+0x28>

ffffffffc0207a48 <vfs_get_bootfs>:
ffffffffc0207a48:	1101                	addi	sp,sp,-32
ffffffffc0207a4a:	e426                	sd	s1,8(sp)
ffffffffc0207a4c:	0008f497          	auipc	s1,0x8f
ffffffffc0207a50:	ea448493          	addi	s1,s1,-348 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207a54:	609c                	ld	a5,0(s1)
ffffffffc0207a56:	ec06                	sd	ra,24(sp)
ffffffffc0207a58:	e822                	sd	s0,16(sp)
ffffffffc0207a5a:	c3a1                	beqz	a5,ffffffffc0207a9a <vfs_get_bootfs+0x52>
ffffffffc0207a5c:	842a                	mv	s0,a0
ffffffffc0207a5e:	0008e517          	auipc	a0,0x8e
ffffffffc0207a62:	da250513          	addi	a0,a0,-606 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207a66:	afffc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207a6a:	6084                	ld	s1,0(s1)
ffffffffc0207a6c:	c08d                	beqz	s1,ffffffffc0207a8e <vfs_get_bootfs+0x46>
ffffffffc0207a6e:	8526                	mv	a0,s1
ffffffffc0207a70:	d0dff0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc0207a74:	0008e517          	auipc	a0,0x8e
ffffffffc0207a78:	d8c50513          	addi	a0,a0,-628 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207a7c:	ae5fc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207a80:	4501                	li	a0,0
ffffffffc0207a82:	e004                	sd	s1,0(s0)
ffffffffc0207a84:	60e2                	ld	ra,24(sp)
ffffffffc0207a86:	6442                	ld	s0,16(sp)
ffffffffc0207a88:	64a2                	ld	s1,8(sp)
ffffffffc0207a8a:	6105                	addi	sp,sp,32
ffffffffc0207a8c:	8082                	ret
ffffffffc0207a8e:	0008e517          	auipc	a0,0x8e
ffffffffc0207a92:	d7250513          	addi	a0,a0,-654 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207a96:	acbfc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207a9a:	5541                	li	a0,-16
ffffffffc0207a9c:	b7e5                	j	ffffffffc0207a84 <vfs_get_bootfs+0x3c>

ffffffffc0207a9e <vfs_do_add>:
ffffffffc0207a9e:	7139                	addi	sp,sp,-64
ffffffffc0207aa0:	fc06                	sd	ra,56(sp)
ffffffffc0207aa2:	f822                	sd	s0,48(sp)
ffffffffc0207aa4:	f426                	sd	s1,40(sp)
ffffffffc0207aa6:	f04a                	sd	s2,32(sp)
ffffffffc0207aa8:	ec4e                	sd	s3,24(sp)
ffffffffc0207aaa:	e852                	sd	s4,16(sp)
ffffffffc0207aac:	e456                	sd	s5,8(sp)
ffffffffc0207aae:	e05a                	sd	s6,0(sp)
ffffffffc0207ab0:	0e050b63          	beqz	a0,ffffffffc0207ba6 <vfs_do_add+0x108>
ffffffffc0207ab4:	842a                	mv	s0,a0
ffffffffc0207ab6:	8a2e                	mv	s4,a1
ffffffffc0207ab8:	8b32                	mv	s6,a2
ffffffffc0207aba:	8ab6                	mv	s5,a3
ffffffffc0207abc:	c5cd                	beqz	a1,ffffffffc0207b66 <vfs_do_add+0xc8>
ffffffffc0207abe:	4db8                	lw	a4,88(a1)
ffffffffc0207ac0:	6785                	lui	a5,0x1
ffffffffc0207ac2:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207ac6:	0af71163          	bne	a4,a5,ffffffffc0207b68 <vfs_do_add+0xca>
ffffffffc0207aca:	8522                	mv	a0,s0
ffffffffc0207acc:	049030ef          	jal	ra,ffffffffc020b314 <strlen>
ffffffffc0207ad0:	47fd                	li	a5,31
ffffffffc0207ad2:	0ca7e663          	bltu	a5,a0,ffffffffc0207b9e <vfs_do_add+0x100>
ffffffffc0207ad6:	8522                	mv	a0,s0
ffffffffc0207ad8:	f1cf80ef          	jal	ra,ffffffffc02001f4 <strdup>
ffffffffc0207adc:	84aa                	mv	s1,a0
ffffffffc0207ade:	c171                	beqz	a0,ffffffffc0207ba2 <vfs_do_add+0x104>
ffffffffc0207ae0:	03000513          	li	a0,48
ffffffffc0207ae4:	caafa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0207ae8:	89aa                	mv	s3,a0
ffffffffc0207aea:	c92d                	beqz	a0,ffffffffc0207b5c <vfs_do_add+0xbe>
ffffffffc0207aec:	0008e517          	auipc	a0,0x8e
ffffffffc0207af0:	d3c50513          	addi	a0,a0,-708 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207af4:	0008e917          	auipc	s2,0x8e
ffffffffc0207af8:	d2490913          	addi	s2,s2,-732 # ffffffffc0295818 <vdev_list>
ffffffffc0207afc:	a69fc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207b00:	844a                	mv	s0,s2
ffffffffc0207b02:	a039                	j	ffffffffc0207b10 <vfs_do_add+0x72>
ffffffffc0207b04:	fe043503          	ld	a0,-32(s0)
ffffffffc0207b08:	85a6                	mv	a1,s1
ffffffffc0207b0a:	053030ef          	jal	ra,ffffffffc020b35c <strcmp>
ffffffffc0207b0e:	cd2d                	beqz	a0,ffffffffc0207b88 <vfs_do_add+0xea>
ffffffffc0207b10:	6400                	ld	s0,8(s0)
ffffffffc0207b12:	ff2419e3          	bne	s0,s2,ffffffffc0207b04 <vfs_do_add+0x66>
ffffffffc0207b16:	6418                	ld	a4,8(s0)
ffffffffc0207b18:	02098793          	addi	a5,s3,32
ffffffffc0207b1c:	0099b023          	sd	s1,0(s3)
ffffffffc0207b20:	0149b423          	sd	s4,8(s3)
ffffffffc0207b24:	0159bc23          	sd	s5,24(s3)
ffffffffc0207b28:	0169b823          	sd	s6,16(s3)
ffffffffc0207b2c:	e31c                	sd	a5,0(a4)
ffffffffc0207b2e:	0289b023          	sd	s0,32(s3)
ffffffffc0207b32:	02e9b423          	sd	a4,40(s3)
ffffffffc0207b36:	0008e517          	auipc	a0,0x8e
ffffffffc0207b3a:	cf250513          	addi	a0,a0,-782 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207b3e:	e41c                	sd	a5,8(s0)
ffffffffc0207b40:	4401                	li	s0,0
ffffffffc0207b42:	a1ffc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207b46:	70e2                	ld	ra,56(sp)
ffffffffc0207b48:	8522                	mv	a0,s0
ffffffffc0207b4a:	7442                	ld	s0,48(sp)
ffffffffc0207b4c:	74a2                	ld	s1,40(sp)
ffffffffc0207b4e:	7902                	ld	s2,32(sp)
ffffffffc0207b50:	69e2                	ld	s3,24(sp)
ffffffffc0207b52:	6a42                	ld	s4,16(sp)
ffffffffc0207b54:	6aa2                	ld	s5,8(sp)
ffffffffc0207b56:	6b02                	ld	s6,0(sp)
ffffffffc0207b58:	6121                	addi	sp,sp,64
ffffffffc0207b5a:	8082                	ret
ffffffffc0207b5c:	5471                	li	s0,-4
ffffffffc0207b5e:	8526                	mv	a0,s1
ffffffffc0207b60:	cdefa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0207b64:	b7cd                	j	ffffffffc0207b46 <vfs_do_add+0xa8>
ffffffffc0207b66:	d2b5                	beqz	a3,ffffffffc0207aca <vfs_do_add+0x2c>
ffffffffc0207b68:	00007697          	auipc	a3,0x7
ffffffffc0207b6c:	8d068693          	addi	a3,a3,-1840 # ffffffffc020e438 <syscalls+0xa70>
ffffffffc0207b70:	00004617          	auipc	a2,0x4
ffffffffc0207b74:	d2860613          	addi	a2,a2,-728 # ffffffffc020b898 <commands+0x210>
ffffffffc0207b78:	08f00593          	li	a1,143
ffffffffc0207b7c:	00007517          	auipc	a0,0x7
ffffffffc0207b80:	8a450513          	addi	a0,a0,-1884 # ffffffffc020e420 <syscalls+0xa58>
ffffffffc0207b84:	91bf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207b88:	0008e517          	auipc	a0,0x8e
ffffffffc0207b8c:	ca050513          	addi	a0,a0,-864 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207b90:	9d1fc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207b94:	854e                	mv	a0,s3
ffffffffc0207b96:	ca8fa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0207b9a:	5425                	li	s0,-23
ffffffffc0207b9c:	b7c9                	j	ffffffffc0207b5e <vfs_do_add+0xc0>
ffffffffc0207b9e:	5451                	li	s0,-12
ffffffffc0207ba0:	b75d                	j	ffffffffc0207b46 <vfs_do_add+0xa8>
ffffffffc0207ba2:	5471                	li	s0,-4
ffffffffc0207ba4:	b74d                	j	ffffffffc0207b46 <vfs_do_add+0xa8>
ffffffffc0207ba6:	00007697          	auipc	a3,0x7
ffffffffc0207baa:	86a68693          	addi	a3,a3,-1942 # ffffffffc020e410 <syscalls+0xa48>
ffffffffc0207bae:	00004617          	auipc	a2,0x4
ffffffffc0207bb2:	cea60613          	addi	a2,a2,-790 # ffffffffc020b898 <commands+0x210>
ffffffffc0207bb6:	08e00593          	li	a1,142
ffffffffc0207bba:	00007517          	auipc	a0,0x7
ffffffffc0207bbe:	86650513          	addi	a0,a0,-1946 # ffffffffc020e420 <syscalls+0xa58>
ffffffffc0207bc2:	8ddf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207bc6 <find_mount.part.0>:
ffffffffc0207bc6:	1141                	addi	sp,sp,-16
ffffffffc0207bc8:	00007697          	auipc	a3,0x7
ffffffffc0207bcc:	84868693          	addi	a3,a3,-1976 # ffffffffc020e410 <syscalls+0xa48>
ffffffffc0207bd0:	00004617          	auipc	a2,0x4
ffffffffc0207bd4:	cc860613          	addi	a2,a2,-824 # ffffffffc020b898 <commands+0x210>
ffffffffc0207bd8:	0cd00593          	li	a1,205
ffffffffc0207bdc:	00007517          	auipc	a0,0x7
ffffffffc0207be0:	84450513          	addi	a0,a0,-1980 # ffffffffc020e420 <syscalls+0xa58>
ffffffffc0207be4:	e406                	sd	ra,8(sp)
ffffffffc0207be6:	8b9f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207bea <vfs_devlist_init>:
ffffffffc0207bea:	0008e797          	auipc	a5,0x8e
ffffffffc0207bee:	c2e78793          	addi	a5,a5,-978 # ffffffffc0295818 <vdev_list>
ffffffffc0207bf2:	4585                	li	a1,1
ffffffffc0207bf4:	0008e517          	auipc	a0,0x8e
ffffffffc0207bf8:	c3450513          	addi	a0,a0,-972 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207bfc:	e79c                	sd	a5,8(a5)
ffffffffc0207bfe:	e39c                	sd	a5,0(a5)
ffffffffc0207c00:	95bfc06f          	j	ffffffffc020455a <sem_init>

ffffffffc0207c04 <vfs_cleanup>:
ffffffffc0207c04:	1101                	addi	sp,sp,-32
ffffffffc0207c06:	e426                	sd	s1,8(sp)
ffffffffc0207c08:	0008e497          	auipc	s1,0x8e
ffffffffc0207c0c:	c1048493          	addi	s1,s1,-1008 # ffffffffc0295818 <vdev_list>
ffffffffc0207c10:	649c                	ld	a5,8(s1)
ffffffffc0207c12:	ec06                	sd	ra,24(sp)
ffffffffc0207c14:	e822                	sd	s0,16(sp)
ffffffffc0207c16:	02978e63          	beq	a5,s1,ffffffffc0207c52 <vfs_cleanup+0x4e>
ffffffffc0207c1a:	0008e517          	auipc	a0,0x8e
ffffffffc0207c1e:	c0e50513          	addi	a0,a0,-1010 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207c22:	943fc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207c26:	6480                	ld	s0,8(s1)
ffffffffc0207c28:	00940b63          	beq	s0,s1,ffffffffc0207c3e <vfs_cleanup+0x3a>
ffffffffc0207c2c:	ff043783          	ld	a5,-16(s0)
ffffffffc0207c30:	853e                	mv	a0,a5
ffffffffc0207c32:	c399                	beqz	a5,ffffffffc0207c38 <vfs_cleanup+0x34>
ffffffffc0207c34:	6bfc                	ld	a5,208(a5)
ffffffffc0207c36:	9782                	jalr	a5
ffffffffc0207c38:	6400                	ld	s0,8(s0)
ffffffffc0207c3a:	fe9419e3          	bne	s0,s1,ffffffffc0207c2c <vfs_cleanup+0x28>
ffffffffc0207c3e:	6442                	ld	s0,16(sp)
ffffffffc0207c40:	60e2                	ld	ra,24(sp)
ffffffffc0207c42:	64a2                	ld	s1,8(sp)
ffffffffc0207c44:	0008e517          	auipc	a0,0x8e
ffffffffc0207c48:	be450513          	addi	a0,a0,-1052 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207c4c:	6105                	addi	sp,sp,32
ffffffffc0207c4e:	913fc06f          	j	ffffffffc0204560 <up>
ffffffffc0207c52:	60e2                	ld	ra,24(sp)
ffffffffc0207c54:	6442                	ld	s0,16(sp)
ffffffffc0207c56:	64a2                	ld	s1,8(sp)
ffffffffc0207c58:	6105                	addi	sp,sp,32
ffffffffc0207c5a:	8082                	ret

ffffffffc0207c5c <vfs_get_root>:
ffffffffc0207c5c:	7179                	addi	sp,sp,-48
ffffffffc0207c5e:	f406                	sd	ra,40(sp)
ffffffffc0207c60:	f022                	sd	s0,32(sp)
ffffffffc0207c62:	ec26                	sd	s1,24(sp)
ffffffffc0207c64:	e84a                	sd	s2,16(sp)
ffffffffc0207c66:	e44e                	sd	s3,8(sp)
ffffffffc0207c68:	e052                	sd	s4,0(sp)
ffffffffc0207c6a:	c541                	beqz	a0,ffffffffc0207cf2 <vfs_get_root+0x96>
ffffffffc0207c6c:	0008e917          	auipc	s2,0x8e
ffffffffc0207c70:	bac90913          	addi	s2,s2,-1108 # ffffffffc0295818 <vdev_list>
ffffffffc0207c74:	00893783          	ld	a5,8(s2)
ffffffffc0207c78:	07278b63          	beq	a5,s2,ffffffffc0207cee <vfs_get_root+0x92>
ffffffffc0207c7c:	89aa                	mv	s3,a0
ffffffffc0207c7e:	0008e517          	auipc	a0,0x8e
ffffffffc0207c82:	baa50513          	addi	a0,a0,-1110 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207c86:	8a2e                	mv	s4,a1
ffffffffc0207c88:	844a                	mv	s0,s2
ffffffffc0207c8a:	8dbfc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207c8e:	a801                	j	ffffffffc0207c9e <vfs_get_root+0x42>
ffffffffc0207c90:	fe043583          	ld	a1,-32(s0)
ffffffffc0207c94:	854e                	mv	a0,s3
ffffffffc0207c96:	6c6030ef          	jal	ra,ffffffffc020b35c <strcmp>
ffffffffc0207c9a:	84aa                	mv	s1,a0
ffffffffc0207c9c:	c505                	beqz	a0,ffffffffc0207cc4 <vfs_get_root+0x68>
ffffffffc0207c9e:	6400                	ld	s0,8(s0)
ffffffffc0207ca0:	ff2418e3          	bne	s0,s2,ffffffffc0207c90 <vfs_get_root+0x34>
ffffffffc0207ca4:	54cd                	li	s1,-13
ffffffffc0207ca6:	0008e517          	auipc	a0,0x8e
ffffffffc0207caa:	b8250513          	addi	a0,a0,-1150 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207cae:	8b3fc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207cb2:	70a2                	ld	ra,40(sp)
ffffffffc0207cb4:	7402                	ld	s0,32(sp)
ffffffffc0207cb6:	6942                	ld	s2,16(sp)
ffffffffc0207cb8:	69a2                	ld	s3,8(sp)
ffffffffc0207cba:	6a02                	ld	s4,0(sp)
ffffffffc0207cbc:	8526                	mv	a0,s1
ffffffffc0207cbe:	64e2                	ld	s1,24(sp)
ffffffffc0207cc0:	6145                	addi	sp,sp,48
ffffffffc0207cc2:	8082                	ret
ffffffffc0207cc4:	ff043503          	ld	a0,-16(s0)
ffffffffc0207cc8:	c519                	beqz	a0,ffffffffc0207cd6 <vfs_get_root+0x7a>
ffffffffc0207cca:	617c                	ld	a5,192(a0)
ffffffffc0207ccc:	9782                	jalr	a5
ffffffffc0207cce:	c519                	beqz	a0,ffffffffc0207cdc <vfs_get_root+0x80>
ffffffffc0207cd0:	00aa3023          	sd	a0,0(s4)
ffffffffc0207cd4:	bfc9                	j	ffffffffc0207ca6 <vfs_get_root+0x4a>
ffffffffc0207cd6:	ff843783          	ld	a5,-8(s0)
ffffffffc0207cda:	c399                	beqz	a5,ffffffffc0207ce0 <vfs_get_root+0x84>
ffffffffc0207cdc:	54c9                	li	s1,-14
ffffffffc0207cde:	b7e1                	j	ffffffffc0207ca6 <vfs_get_root+0x4a>
ffffffffc0207ce0:	fe843503          	ld	a0,-24(s0)
ffffffffc0207ce4:	a99ff0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc0207ce8:	fe843503          	ld	a0,-24(s0)
ffffffffc0207cec:	b7cd                	j	ffffffffc0207cce <vfs_get_root+0x72>
ffffffffc0207cee:	54cd                	li	s1,-13
ffffffffc0207cf0:	b7c9                	j	ffffffffc0207cb2 <vfs_get_root+0x56>
ffffffffc0207cf2:	00006697          	auipc	a3,0x6
ffffffffc0207cf6:	71e68693          	addi	a3,a3,1822 # ffffffffc020e410 <syscalls+0xa48>
ffffffffc0207cfa:	00004617          	auipc	a2,0x4
ffffffffc0207cfe:	b9e60613          	addi	a2,a2,-1122 # ffffffffc020b898 <commands+0x210>
ffffffffc0207d02:	04500593          	li	a1,69
ffffffffc0207d06:	00006517          	auipc	a0,0x6
ffffffffc0207d0a:	71a50513          	addi	a0,a0,1818 # ffffffffc020e420 <syscalls+0xa58>
ffffffffc0207d0e:	f90f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207d12 <vfs_get_devname>:
ffffffffc0207d12:	0008e697          	auipc	a3,0x8e
ffffffffc0207d16:	b0668693          	addi	a3,a3,-1274 # ffffffffc0295818 <vdev_list>
ffffffffc0207d1a:	87b6                	mv	a5,a3
ffffffffc0207d1c:	e511                	bnez	a0,ffffffffc0207d28 <vfs_get_devname+0x16>
ffffffffc0207d1e:	a829                	j	ffffffffc0207d38 <vfs_get_devname+0x26>
ffffffffc0207d20:	ff07b703          	ld	a4,-16(a5)
ffffffffc0207d24:	00a70763          	beq	a4,a0,ffffffffc0207d32 <vfs_get_devname+0x20>
ffffffffc0207d28:	679c                	ld	a5,8(a5)
ffffffffc0207d2a:	fed79be3          	bne	a5,a3,ffffffffc0207d20 <vfs_get_devname+0xe>
ffffffffc0207d2e:	4501                	li	a0,0
ffffffffc0207d30:	8082                	ret
ffffffffc0207d32:	fe07b503          	ld	a0,-32(a5)
ffffffffc0207d36:	8082                	ret
ffffffffc0207d38:	1141                	addi	sp,sp,-16
ffffffffc0207d3a:	00006697          	auipc	a3,0x6
ffffffffc0207d3e:	75e68693          	addi	a3,a3,1886 # ffffffffc020e498 <syscalls+0xad0>
ffffffffc0207d42:	00004617          	auipc	a2,0x4
ffffffffc0207d46:	b5660613          	addi	a2,a2,-1194 # ffffffffc020b898 <commands+0x210>
ffffffffc0207d4a:	06a00593          	li	a1,106
ffffffffc0207d4e:	00006517          	auipc	a0,0x6
ffffffffc0207d52:	6d250513          	addi	a0,a0,1746 # ffffffffc020e420 <syscalls+0xa58>
ffffffffc0207d56:	e406                	sd	ra,8(sp)
ffffffffc0207d58:	f46f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207d5c <vfs_add_dev>:
ffffffffc0207d5c:	86b2                	mv	a3,a2
ffffffffc0207d5e:	4601                	li	a2,0
ffffffffc0207d60:	d3fff06f          	j	ffffffffc0207a9e <vfs_do_add>

ffffffffc0207d64 <vfs_mount>:
ffffffffc0207d64:	7179                	addi	sp,sp,-48
ffffffffc0207d66:	e84a                	sd	s2,16(sp)
ffffffffc0207d68:	892a                	mv	s2,a0
ffffffffc0207d6a:	0008e517          	auipc	a0,0x8e
ffffffffc0207d6e:	abe50513          	addi	a0,a0,-1346 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207d72:	e44e                	sd	s3,8(sp)
ffffffffc0207d74:	f406                	sd	ra,40(sp)
ffffffffc0207d76:	f022                	sd	s0,32(sp)
ffffffffc0207d78:	ec26                	sd	s1,24(sp)
ffffffffc0207d7a:	89ae                	mv	s3,a1
ffffffffc0207d7c:	fe8fc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207d80:	08090a63          	beqz	s2,ffffffffc0207e14 <vfs_mount+0xb0>
ffffffffc0207d84:	0008e497          	auipc	s1,0x8e
ffffffffc0207d88:	a9448493          	addi	s1,s1,-1388 # ffffffffc0295818 <vdev_list>
ffffffffc0207d8c:	6480                	ld	s0,8(s1)
ffffffffc0207d8e:	00941663          	bne	s0,s1,ffffffffc0207d9a <vfs_mount+0x36>
ffffffffc0207d92:	a8ad                	j	ffffffffc0207e0c <vfs_mount+0xa8>
ffffffffc0207d94:	6400                	ld	s0,8(s0)
ffffffffc0207d96:	06940b63          	beq	s0,s1,ffffffffc0207e0c <vfs_mount+0xa8>
ffffffffc0207d9a:	ff843783          	ld	a5,-8(s0)
ffffffffc0207d9e:	dbfd                	beqz	a5,ffffffffc0207d94 <vfs_mount+0x30>
ffffffffc0207da0:	fe043503          	ld	a0,-32(s0)
ffffffffc0207da4:	85ca                	mv	a1,s2
ffffffffc0207da6:	5b6030ef          	jal	ra,ffffffffc020b35c <strcmp>
ffffffffc0207daa:	f56d                	bnez	a0,ffffffffc0207d94 <vfs_mount+0x30>
ffffffffc0207dac:	ff043783          	ld	a5,-16(s0)
ffffffffc0207db0:	e3a5                	bnez	a5,ffffffffc0207e10 <vfs_mount+0xac>
ffffffffc0207db2:	fe043783          	ld	a5,-32(s0)
ffffffffc0207db6:	c3c9                	beqz	a5,ffffffffc0207e38 <vfs_mount+0xd4>
ffffffffc0207db8:	ff843783          	ld	a5,-8(s0)
ffffffffc0207dbc:	cfb5                	beqz	a5,ffffffffc0207e38 <vfs_mount+0xd4>
ffffffffc0207dbe:	fe843503          	ld	a0,-24(s0)
ffffffffc0207dc2:	c939                	beqz	a0,ffffffffc0207e18 <vfs_mount+0xb4>
ffffffffc0207dc4:	4d38                	lw	a4,88(a0)
ffffffffc0207dc6:	6785                	lui	a5,0x1
ffffffffc0207dc8:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207dcc:	04f71663          	bne	a4,a5,ffffffffc0207e18 <vfs_mount+0xb4>
ffffffffc0207dd0:	ff040593          	addi	a1,s0,-16
ffffffffc0207dd4:	9982                	jalr	s3
ffffffffc0207dd6:	84aa                	mv	s1,a0
ffffffffc0207dd8:	ed01                	bnez	a0,ffffffffc0207df0 <vfs_mount+0x8c>
ffffffffc0207dda:	ff043783          	ld	a5,-16(s0)
ffffffffc0207dde:	cfad                	beqz	a5,ffffffffc0207e58 <vfs_mount+0xf4>
ffffffffc0207de0:	fe043583          	ld	a1,-32(s0)
ffffffffc0207de4:	00006517          	auipc	a0,0x6
ffffffffc0207de8:	74450513          	addi	a0,a0,1860 # ffffffffc020e528 <syscalls+0xb60>
ffffffffc0207dec:	bbaf80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207df0:	0008e517          	auipc	a0,0x8e
ffffffffc0207df4:	a3850513          	addi	a0,a0,-1480 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207df8:	f68fc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207dfc:	70a2                	ld	ra,40(sp)
ffffffffc0207dfe:	7402                	ld	s0,32(sp)
ffffffffc0207e00:	6942                	ld	s2,16(sp)
ffffffffc0207e02:	69a2                	ld	s3,8(sp)
ffffffffc0207e04:	8526                	mv	a0,s1
ffffffffc0207e06:	64e2                	ld	s1,24(sp)
ffffffffc0207e08:	6145                	addi	sp,sp,48
ffffffffc0207e0a:	8082                	ret
ffffffffc0207e0c:	54cd                	li	s1,-13
ffffffffc0207e0e:	b7cd                	j	ffffffffc0207df0 <vfs_mount+0x8c>
ffffffffc0207e10:	54c5                	li	s1,-15
ffffffffc0207e12:	bff9                	j	ffffffffc0207df0 <vfs_mount+0x8c>
ffffffffc0207e14:	db3ff0ef          	jal	ra,ffffffffc0207bc6 <find_mount.part.0>
ffffffffc0207e18:	00006697          	auipc	a3,0x6
ffffffffc0207e1c:	6c068693          	addi	a3,a3,1728 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc0207e20:	00004617          	auipc	a2,0x4
ffffffffc0207e24:	a7860613          	addi	a2,a2,-1416 # ffffffffc020b898 <commands+0x210>
ffffffffc0207e28:	0ed00593          	li	a1,237
ffffffffc0207e2c:	00006517          	auipc	a0,0x6
ffffffffc0207e30:	5f450513          	addi	a0,a0,1524 # ffffffffc020e420 <syscalls+0xa58>
ffffffffc0207e34:	e6af80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e38:	00006697          	auipc	a3,0x6
ffffffffc0207e3c:	67068693          	addi	a3,a3,1648 # ffffffffc020e4a8 <syscalls+0xae0>
ffffffffc0207e40:	00004617          	auipc	a2,0x4
ffffffffc0207e44:	a5860613          	addi	a2,a2,-1448 # ffffffffc020b898 <commands+0x210>
ffffffffc0207e48:	0eb00593          	li	a1,235
ffffffffc0207e4c:	00006517          	auipc	a0,0x6
ffffffffc0207e50:	5d450513          	addi	a0,a0,1492 # ffffffffc020e420 <syscalls+0xa58>
ffffffffc0207e54:	e4af80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e58:	00006697          	auipc	a3,0x6
ffffffffc0207e5c:	6b868693          	addi	a3,a3,1720 # ffffffffc020e510 <syscalls+0xb48>
ffffffffc0207e60:	00004617          	auipc	a2,0x4
ffffffffc0207e64:	a3860613          	addi	a2,a2,-1480 # ffffffffc020b898 <commands+0x210>
ffffffffc0207e68:	0ef00593          	li	a1,239
ffffffffc0207e6c:	00006517          	auipc	a0,0x6
ffffffffc0207e70:	5b450513          	addi	a0,a0,1460 # ffffffffc020e420 <syscalls+0xa58>
ffffffffc0207e74:	e2af80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207e78 <vfs_open>:
ffffffffc0207e78:	711d                	addi	sp,sp,-96
ffffffffc0207e7a:	e4a6                	sd	s1,72(sp)
ffffffffc0207e7c:	e0ca                	sd	s2,64(sp)
ffffffffc0207e7e:	fc4e                	sd	s3,56(sp)
ffffffffc0207e80:	ec86                	sd	ra,88(sp)
ffffffffc0207e82:	e8a2                	sd	s0,80(sp)
ffffffffc0207e84:	f852                	sd	s4,48(sp)
ffffffffc0207e86:	f456                	sd	s5,40(sp)
ffffffffc0207e88:	0035f793          	andi	a5,a1,3
ffffffffc0207e8c:	84ae                	mv	s1,a1
ffffffffc0207e8e:	892a                	mv	s2,a0
ffffffffc0207e90:	89b2                	mv	s3,a2
ffffffffc0207e92:	0e078663          	beqz	a5,ffffffffc0207f7e <vfs_open+0x106>
ffffffffc0207e96:	470d                	li	a4,3
ffffffffc0207e98:	0105fa93          	andi	s5,a1,16
ffffffffc0207e9c:	0ce78f63          	beq	a5,a4,ffffffffc0207f7a <vfs_open+0x102>
ffffffffc0207ea0:	002c                	addi	a1,sp,8
ffffffffc0207ea2:	854a                	mv	a0,s2
ffffffffc0207ea4:	2ae000ef          	jal	ra,ffffffffc0208152 <vfs_lookup>
ffffffffc0207ea8:	842a                	mv	s0,a0
ffffffffc0207eaa:	0044fa13          	andi	s4,s1,4
ffffffffc0207eae:	e159                	bnez	a0,ffffffffc0207f34 <vfs_open+0xbc>
ffffffffc0207eb0:	00c4f793          	andi	a5,s1,12
ffffffffc0207eb4:	4731                	li	a4,12
ffffffffc0207eb6:	0ee78263          	beq	a5,a4,ffffffffc0207f9a <vfs_open+0x122>
ffffffffc0207eba:	6422                	ld	s0,8(sp)
ffffffffc0207ebc:	12040163          	beqz	s0,ffffffffc0207fde <vfs_open+0x166>
ffffffffc0207ec0:	783c                	ld	a5,112(s0)
ffffffffc0207ec2:	cff1                	beqz	a5,ffffffffc0207f9e <vfs_open+0x126>
ffffffffc0207ec4:	679c                	ld	a5,8(a5)
ffffffffc0207ec6:	cfe1                	beqz	a5,ffffffffc0207f9e <vfs_open+0x126>
ffffffffc0207ec8:	8522                	mv	a0,s0
ffffffffc0207eca:	00006597          	auipc	a1,0x6
ffffffffc0207ece:	73e58593          	addi	a1,a1,1854 # ffffffffc020e608 <syscalls+0xc40>
ffffffffc0207ed2:	8c3ff0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0207ed6:	783c                	ld	a5,112(s0)
ffffffffc0207ed8:	6522                	ld	a0,8(sp)
ffffffffc0207eda:	85a6                	mv	a1,s1
ffffffffc0207edc:	679c                	ld	a5,8(a5)
ffffffffc0207ede:	9782                	jalr	a5
ffffffffc0207ee0:	842a                	mv	s0,a0
ffffffffc0207ee2:	6522                	ld	a0,8(sp)
ffffffffc0207ee4:	e845                	bnez	s0,ffffffffc0207f94 <vfs_open+0x11c>
ffffffffc0207ee6:	015a6a33          	or	s4,s4,s5
ffffffffc0207eea:	89fff0ef          	jal	ra,ffffffffc0207788 <inode_open_inc>
ffffffffc0207eee:	020a0663          	beqz	s4,ffffffffc0207f1a <vfs_open+0xa2>
ffffffffc0207ef2:	64a2                	ld	s1,8(sp)
ffffffffc0207ef4:	c4e9                	beqz	s1,ffffffffc0207fbe <vfs_open+0x146>
ffffffffc0207ef6:	78bc                	ld	a5,112(s1)
ffffffffc0207ef8:	c3f9                	beqz	a5,ffffffffc0207fbe <vfs_open+0x146>
ffffffffc0207efa:	73bc                	ld	a5,96(a5)
ffffffffc0207efc:	c3e9                	beqz	a5,ffffffffc0207fbe <vfs_open+0x146>
ffffffffc0207efe:	00006597          	auipc	a1,0x6
ffffffffc0207f02:	76a58593          	addi	a1,a1,1898 # ffffffffc020e668 <syscalls+0xca0>
ffffffffc0207f06:	8526                	mv	a0,s1
ffffffffc0207f08:	88dff0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0207f0c:	78bc                	ld	a5,112(s1)
ffffffffc0207f0e:	6522                	ld	a0,8(sp)
ffffffffc0207f10:	4581                	li	a1,0
ffffffffc0207f12:	73bc                	ld	a5,96(a5)
ffffffffc0207f14:	9782                	jalr	a5
ffffffffc0207f16:	87aa                	mv	a5,a0
ffffffffc0207f18:	e92d                	bnez	a0,ffffffffc0207f8a <vfs_open+0x112>
ffffffffc0207f1a:	67a2                	ld	a5,8(sp)
ffffffffc0207f1c:	00f9b023          	sd	a5,0(s3)
ffffffffc0207f20:	60e6                	ld	ra,88(sp)
ffffffffc0207f22:	8522                	mv	a0,s0
ffffffffc0207f24:	6446                	ld	s0,80(sp)
ffffffffc0207f26:	64a6                	ld	s1,72(sp)
ffffffffc0207f28:	6906                	ld	s2,64(sp)
ffffffffc0207f2a:	79e2                	ld	s3,56(sp)
ffffffffc0207f2c:	7a42                	ld	s4,48(sp)
ffffffffc0207f2e:	7aa2                	ld	s5,40(sp)
ffffffffc0207f30:	6125                	addi	sp,sp,96
ffffffffc0207f32:	8082                	ret
ffffffffc0207f34:	57c1                	li	a5,-16
ffffffffc0207f36:	fef515e3          	bne	a0,a5,ffffffffc0207f20 <vfs_open+0xa8>
ffffffffc0207f3a:	fe0a03e3          	beqz	s4,ffffffffc0207f20 <vfs_open+0xa8>
ffffffffc0207f3e:	0810                	addi	a2,sp,16
ffffffffc0207f40:	082c                	addi	a1,sp,24
ffffffffc0207f42:	854a                	mv	a0,s2
ffffffffc0207f44:	2a4000ef          	jal	ra,ffffffffc02081e8 <vfs_lookup_parent>
ffffffffc0207f48:	842a                	mv	s0,a0
ffffffffc0207f4a:	f979                	bnez	a0,ffffffffc0207f20 <vfs_open+0xa8>
ffffffffc0207f4c:	6462                	ld	s0,24(sp)
ffffffffc0207f4e:	c845                	beqz	s0,ffffffffc0207ffe <vfs_open+0x186>
ffffffffc0207f50:	783c                	ld	a5,112(s0)
ffffffffc0207f52:	c7d5                	beqz	a5,ffffffffc0207ffe <vfs_open+0x186>
ffffffffc0207f54:	77bc                	ld	a5,104(a5)
ffffffffc0207f56:	c7c5                	beqz	a5,ffffffffc0207ffe <vfs_open+0x186>
ffffffffc0207f58:	8522                	mv	a0,s0
ffffffffc0207f5a:	00006597          	auipc	a1,0x6
ffffffffc0207f5e:	64658593          	addi	a1,a1,1606 # ffffffffc020e5a0 <syscalls+0xbd8>
ffffffffc0207f62:	833ff0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0207f66:	783c                	ld	a5,112(s0)
ffffffffc0207f68:	65c2                	ld	a1,16(sp)
ffffffffc0207f6a:	6562                	ld	a0,24(sp)
ffffffffc0207f6c:	77bc                	ld	a5,104(a5)
ffffffffc0207f6e:	4034d613          	srai	a2,s1,0x3
ffffffffc0207f72:	0034                	addi	a3,sp,8
ffffffffc0207f74:	8a05                	andi	a2,a2,1
ffffffffc0207f76:	9782                	jalr	a5
ffffffffc0207f78:	b789                	j	ffffffffc0207eba <vfs_open+0x42>
ffffffffc0207f7a:	5475                	li	s0,-3
ffffffffc0207f7c:	b755                	j	ffffffffc0207f20 <vfs_open+0xa8>
ffffffffc0207f7e:	0105fa93          	andi	s5,a1,16
ffffffffc0207f82:	5475                	li	s0,-3
ffffffffc0207f84:	f80a9ee3          	bnez	s5,ffffffffc0207f20 <vfs_open+0xa8>
ffffffffc0207f88:	bf21                	j	ffffffffc0207ea0 <vfs_open+0x28>
ffffffffc0207f8a:	6522                	ld	a0,8(sp)
ffffffffc0207f8c:	843e                	mv	s0,a5
ffffffffc0207f8e:	965ff0ef          	jal	ra,ffffffffc02078f2 <inode_open_dec>
ffffffffc0207f92:	6522                	ld	a0,8(sp)
ffffffffc0207f94:	8b7ff0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc0207f98:	b761                	j	ffffffffc0207f20 <vfs_open+0xa8>
ffffffffc0207f9a:	5425                	li	s0,-23
ffffffffc0207f9c:	b751                	j	ffffffffc0207f20 <vfs_open+0xa8>
ffffffffc0207f9e:	00006697          	auipc	a3,0x6
ffffffffc0207fa2:	61a68693          	addi	a3,a3,1562 # ffffffffc020e5b8 <syscalls+0xbf0>
ffffffffc0207fa6:	00004617          	auipc	a2,0x4
ffffffffc0207faa:	8f260613          	addi	a2,a2,-1806 # ffffffffc020b898 <commands+0x210>
ffffffffc0207fae:	03300593          	li	a1,51
ffffffffc0207fb2:	00006517          	auipc	a0,0x6
ffffffffc0207fb6:	5d650513          	addi	a0,a0,1494 # ffffffffc020e588 <syscalls+0xbc0>
ffffffffc0207fba:	ce4f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207fbe:	00006697          	auipc	a3,0x6
ffffffffc0207fc2:	65268693          	addi	a3,a3,1618 # ffffffffc020e610 <syscalls+0xc48>
ffffffffc0207fc6:	00004617          	auipc	a2,0x4
ffffffffc0207fca:	8d260613          	addi	a2,a2,-1838 # ffffffffc020b898 <commands+0x210>
ffffffffc0207fce:	03a00593          	li	a1,58
ffffffffc0207fd2:	00006517          	auipc	a0,0x6
ffffffffc0207fd6:	5b650513          	addi	a0,a0,1462 # ffffffffc020e588 <syscalls+0xbc0>
ffffffffc0207fda:	cc4f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207fde:	00006697          	auipc	a3,0x6
ffffffffc0207fe2:	5ca68693          	addi	a3,a3,1482 # ffffffffc020e5a8 <syscalls+0xbe0>
ffffffffc0207fe6:	00004617          	auipc	a2,0x4
ffffffffc0207fea:	8b260613          	addi	a2,a2,-1870 # ffffffffc020b898 <commands+0x210>
ffffffffc0207fee:	03100593          	li	a1,49
ffffffffc0207ff2:	00006517          	auipc	a0,0x6
ffffffffc0207ff6:	59650513          	addi	a0,a0,1430 # ffffffffc020e588 <syscalls+0xbc0>
ffffffffc0207ffa:	ca4f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207ffe:	00006697          	auipc	a3,0x6
ffffffffc0208002:	53a68693          	addi	a3,a3,1338 # ffffffffc020e538 <syscalls+0xb70>
ffffffffc0208006:	00004617          	auipc	a2,0x4
ffffffffc020800a:	89260613          	addi	a2,a2,-1902 # ffffffffc020b898 <commands+0x210>
ffffffffc020800e:	02c00593          	li	a1,44
ffffffffc0208012:	00006517          	auipc	a0,0x6
ffffffffc0208016:	57650513          	addi	a0,a0,1398 # ffffffffc020e588 <syscalls+0xbc0>
ffffffffc020801a:	c84f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020801e <vfs_close>:
ffffffffc020801e:	1141                	addi	sp,sp,-16
ffffffffc0208020:	e406                	sd	ra,8(sp)
ffffffffc0208022:	e022                	sd	s0,0(sp)
ffffffffc0208024:	842a                	mv	s0,a0
ffffffffc0208026:	8cdff0ef          	jal	ra,ffffffffc02078f2 <inode_open_dec>
ffffffffc020802a:	8522                	mv	a0,s0
ffffffffc020802c:	81fff0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc0208030:	60a2                	ld	ra,8(sp)
ffffffffc0208032:	6402                	ld	s0,0(sp)
ffffffffc0208034:	4501                	li	a0,0
ffffffffc0208036:	0141                	addi	sp,sp,16
ffffffffc0208038:	8082                	ret

ffffffffc020803a <get_device>:
ffffffffc020803a:	7179                	addi	sp,sp,-48
ffffffffc020803c:	ec26                	sd	s1,24(sp)
ffffffffc020803e:	e84a                	sd	s2,16(sp)
ffffffffc0208040:	f406                	sd	ra,40(sp)
ffffffffc0208042:	f022                	sd	s0,32(sp)
ffffffffc0208044:	00054303          	lbu	t1,0(a0)
ffffffffc0208048:	892e                	mv	s2,a1
ffffffffc020804a:	84b2                	mv	s1,a2
ffffffffc020804c:	02030463          	beqz	t1,ffffffffc0208074 <get_device+0x3a>
ffffffffc0208050:	00150413          	addi	s0,a0,1
ffffffffc0208054:	86a2                	mv	a3,s0
ffffffffc0208056:	879a                	mv	a5,t1
ffffffffc0208058:	4701                	li	a4,0
ffffffffc020805a:	03a00813          	li	a6,58
ffffffffc020805e:	02f00893          	li	a7,47
ffffffffc0208062:	03078263          	beq	a5,a6,ffffffffc0208086 <get_device+0x4c>
ffffffffc0208066:	05178963          	beq	a5,a7,ffffffffc02080b8 <get_device+0x7e>
ffffffffc020806a:	0006c783          	lbu	a5,0(a3)
ffffffffc020806e:	2705                	addiw	a4,a4,1
ffffffffc0208070:	0685                	addi	a3,a3,1
ffffffffc0208072:	fbe5                	bnez	a5,ffffffffc0208062 <get_device+0x28>
ffffffffc0208074:	7402                	ld	s0,32(sp)
ffffffffc0208076:	00a93023          	sd	a0,0(s2)
ffffffffc020807a:	70a2                	ld	ra,40(sp)
ffffffffc020807c:	6942                	ld	s2,16(sp)
ffffffffc020807e:	8526                	mv	a0,s1
ffffffffc0208080:	64e2                	ld	s1,24(sp)
ffffffffc0208082:	6145                	addi	sp,sp,48
ffffffffc0208084:	a279                	j	ffffffffc0208212 <vfs_get_curdir>
ffffffffc0208086:	cb15                	beqz	a4,ffffffffc02080ba <get_device+0x80>
ffffffffc0208088:	00e507b3          	add	a5,a0,a4
ffffffffc020808c:	0705                	addi	a4,a4,1
ffffffffc020808e:	00078023          	sb	zero,0(a5)
ffffffffc0208092:	972a                	add	a4,a4,a0
ffffffffc0208094:	02f00613          	li	a2,47
ffffffffc0208098:	00074783          	lbu	a5,0(a4)
ffffffffc020809c:	86ba                	mv	a3,a4
ffffffffc020809e:	0705                	addi	a4,a4,1
ffffffffc02080a0:	fec78ce3          	beq	a5,a2,ffffffffc0208098 <get_device+0x5e>
ffffffffc02080a4:	7402                	ld	s0,32(sp)
ffffffffc02080a6:	70a2                	ld	ra,40(sp)
ffffffffc02080a8:	00d93023          	sd	a3,0(s2)
ffffffffc02080ac:	85a6                	mv	a1,s1
ffffffffc02080ae:	6942                	ld	s2,16(sp)
ffffffffc02080b0:	64e2                	ld	s1,24(sp)
ffffffffc02080b2:	6145                	addi	sp,sp,48
ffffffffc02080b4:	ba9ff06f          	j	ffffffffc0207c5c <vfs_get_root>
ffffffffc02080b8:	ff55                	bnez	a4,ffffffffc0208074 <get_device+0x3a>
ffffffffc02080ba:	02f00793          	li	a5,47
ffffffffc02080be:	04f30563          	beq	t1,a5,ffffffffc0208108 <get_device+0xce>
ffffffffc02080c2:	03a00793          	li	a5,58
ffffffffc02080c6:	06f31663          	bne	t1,a5,ffffffffc0208132 <get_device+0xf8>
ffffffffc02080ca:	0028                	addi	a0,sp,8
ffffffffc02080cc:	146000ef          	jal	ra,ffffffffc0208212 <vfs_get_curdir>
ffffffffc02080d0:	e515                	bnez	a0,ffffffffc02080fc <get_device+0xc2>
ffffffffc02080d2:	67a2                	ld	a5,8(sp)
ffffffffc02080d4:	77a8                	ld	a0,104(a5)
ffffffffc02080d6:	cd15                	beqz	a0,ffffffffc0208112 <get_device+0xd8>
ffffffffc02080d8:	617c                	ld	a5,192(a0)
ffffffffc02080da:	9782                	jalr	a5
ffffffffc02080dc:	87aa                	mv	a5,a0
ffffffffc02080de:	6522                	ld	a0,8(sp)
ffffffffc02080e0:	e09c                	sd	a5,0(s1)
ffffffffc02080e2:	f68ff0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc02080e6:	02f00713          	li	a4,47
ffffffffc02080ea:	a011                	j	ffffffffc02080ee <get_device+0xb4>
ffffffffc02080ec:	0405                	addi	s0,s0,1
ffffffffc02080ee:	00044783          	lbu	a5,0(s0)
ffffffffc02080f2:	fee78de3          	beq	a5,a4,ffffffffc02080ec <get_device+0xb2>
ffffffffc02080f6:	00893023          	sd	s0,0(s2)
ffffffffc02080fa:	4501                	li	a0,0
ffffffffc02080fc:	70a2                	ld	ra,40(sp)
ffffffffc02080fe:	7402                	ld	s0,32(sp)
ffffffffc0208100:	64e2                	ld	s1,24(sp)
ffffffffc0208102:	6942                	ld	s2,16(sp)
ffffffffc0208104:	6145                	addi	sp,sp,48
ffffffffc0208106:	8082                	ret
ffffffffc0208108:	8526                	mv	a0,s1
ffffffffc020810a:	93fff0ef          	jal	ra,ffffffffc0207a48 <vfs_get_bootfs>
ffffffffc020810e:	dd61                	beqz	a0,ffffffffc02080e6 <get_device+0xac>
ffffffffc0208110:	b7f5                	j	ffffffffc02080fc <get_device+0xc2>
ffffffffc0208112:	00006697          	auipc	a3,0x6
ffffffffc0208116:	58e68693          	addi	a3,a3,1422 # ffffffffc020e6a0 <syscalls+0xcd8>
ffffffffc020811a:	00003617          	auipc	a2,0x3
ffffffffc020811e:	77e60613          	addi	a2,a2,1918 # ffffffffc020b898 <commands+0x210>
ffffffffc0208122:	03900593          	li	a1,57
ffffffffc0208126:	00006517          	auipc	a0,0x6
ffffffffc020812a:	56250513          	addi	a0,a0,1378 # ffffffffc020e688 <syscalls+0xcc0>
ffffffffc020812e:	b70f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208132:	00006697          	auipc	a3,0x6
ffffffffc0208136:	54668693          	addi	a3,a3,1350 # ffffffffc020e678 <syscalls+0xcb0>
ffffffffc020813a:	00003617          	auipc	a2,0x3
ffffffffc020813e:	75e60613          	addi	a2,a2,1886 # ffffffffc020b898 <commands+0x210>
ffffffffc0208142:	03300593          	li	a1,51
ffffffffc0208146:	00006517          	auipc	a0,0x6
ffffffffc020814a:	54250513          	addi	a0,a0,1346 # ffffffffc020e688 <syscalls+0xcc0>
ffffffffc020814e:	b50f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208152 <vfs_lookup>:
ffffffffc0208152:	7139                	addi	sp,sp,-64
ffffffffc0208154:	f426                	sd	s1,40(sp)
ffffffffc0208156:	0830                	addi	a2,sp,24
ffffffffc0208158:	84ae                	mv	s1,a1
ffffffffc020815a:	002c                	addi	a1,sp,8
ffffffffc020815c:	f822                	sd	s0,48(sp)
ffffffffc020815e:	fc06                	sd	ra,56(sp)
ffffffffc0208160:	f04a                	sd	s2,32(sp)
ffffffffc0208162:	e42a                	sd	a0,8(sp)
ffffffffc0208164:	ed7ff0ef          	jal	ra,ffffffffc020803a <get_device>
ffffffffc0208168:	842a                	mv	s0,a0
ffffffffc020816a:	ed1d                	bnez	a0,ffffffffc02081a8 <vfs_lookup+0x56>
ffffffffc020816c:	67a2                	ld	a5,8(sp)
ffffffffc020816e:	6962                	ld	s2,24(sp)
ffffffffc0208170:	0007c783          	lbu	a5,0(a5)
ffffffffc0208174:	c3a9                	beqz	a5,ffffffffc02081b6 <vfs_lookup+0x64>
ffffffffc0208176:	04090963          	beqz	s2,ffffffffc02081c8 <vfs_lookup+0x76>
ffffffffc020817a:	07093783          	ld	a5,112(s2)
ffffffffc020817e:	c7a9                	beqz	a5,ffffffffc02081c8 <vfs_lookup+0x76>
ffffffffc0208180:	7bbc                	ld	a5,112(a5)
ffffffffc0208182:	c3b9                	beqz	a5,ffffffffc02081c8 <vfs_lookup+0x76>
ffffffffc0208184:	854a                	mv	a0,s2
ffffffffc0208186:	00006597          	auipc	a1,0x6
ffffffffc020818a:	58258593          	addi	a1,a1,1410 # ffffffffc020e708 <syscalls+0xd40>
ffffffffc020818e:	e06ff0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0208192:	07093783          	ld	a5,112(s2)
ffffffffc0208196:	65a2                	ld	a1,8(sp)
ffffffffc0208198:	6562                	ld	a0,24(sp)
ffffffffc020819a:	7bbc                	ld	a5,112(a5)
ffffffffc020819c:	8626                	mv	a2,s1
ffffffffc020819e:	9782                	jalr	a5
ffffffffc02081a0:	842a                	mv	s0,a0
ffffffffc02081a2:	6562                	ld	a0,24(sp)
ffffffffc02081a4:	ea6ff0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc02081a8:	70e2                	ld	ra,56(sp)
ffffffffc02081aa:	8522                	mv	a0,s0
ffffffffc02081ac:	7442                	ld	s0,48(sp)
ffffffffc02081ae:	74a2                	ld	s1,40(sp)
ffffffffc02081b0:	7902                	ld	s2,32(sp)
ffffffffc02081b2:	6121                	addi	sp,sp,64
ffffffffc02081b4:	8082                	ret
ffffffffc02081b6:	70e2                	ld	ra,56(sp)
ffffffffc02081b8:	8522                	mv	a0,s0
ffffffffc02081ba:	7442                	ld	s0,48(sp)
ffffffffc02081bc:	0124b023          	sd	s2,0(s1)
ffffffffc02081c0:	74a2                	ld	s1,40(sp)
ffffffffc02081c2:	7902                	ld	s2,32(sp)
ffffffffc02081c4:	6121                	addi	sp,sp,64
ffffffffc02081c6:	8082                	ret
ffffffffc02081c8:	00006697          	auipc	a3,0x6
ffffffffc02081cc:	4f068693          	addi	a3,a3,1264 # ffffffffc020e6b8 <syscalls+0xcf0>
ffffffffc02081d0:	00003617          	auipc	a2,0x3
ffffffffc02081d4:	6c860613          	addi	a2,a2,1736 # ffffffffc020b898 <commands+0x210>
ffffffffc02081d8:	04f00593          	li	a1,79
ffffffffc02081dc:	00006517          	auipc	a0,0x6
ffffffffc02081e0:	4ac50513          	addi	a0,a0,1196 # ffffffffc020e688 <syscalls+0xcc0>
ffffffffc02081e4:	abaf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02081e8 <vfs_lookup_parent>:
ffffffffc02081e8:	7139                	addi	sp,sp,-64
ffffffffc02081ea:	f822                	sd	s0,48(sp)
ffffffffc02081ec:	f426                	sd	s1,40(sp)
ffffffffc02081ee:	842e                	mv	s0,a1
ffffffffc02081f0:	84b2                	mv	s1,a2
ffffffffc02081f2:	002c                	addi	a1,sp,8
ffffffffc02081f4:	0830                	addi	a2,sp,24
ffffffffc02081f6:	fc06                	sd	ra,56(sp)
ffffffffc02081f8:	e42a                	sd	a0,8(sp)
ffffffffc02081fa:	e41ff0ef          	jal	ra,ffffffffc020803a <get_device>
ffffffffc02081fe:	e509                	bnez	a0,ffffffffc0208208 <vfs_lookup_parent+0x20>
ffffffffc0208200:	67a2                	ld	a5,8(sp)
ffffffffc0208202:	e09c                	sd	a5,0(s1)
ffffffffc0208204:	67e2                	ld	a5,24(sp)
ffffffffc0208206:	e01c                	sd	a5,0(s0)
ffffffffc0208208:	70e2                	ld	ra,56(sp)
ffffffffc020820a:	7442                	ld	s0,48(sp)
ffffffffc020820c:	74a2                	ld	s1,40(sp)
ffffffffc020820e:	6121                	addi	sp,sp,64
ffffffffc0208210:	8082                	ret

ffffffffc0208212 <vfs_get_curdir>:
ffffffffc0208212:	0008e797          	auipc	a5,0x8e
ffffffffc0208216:	6ae7b783          	ld	a5,1710(a5) # ffffffffc02968c0 <current>
ffffffffc020821a:	1487b783          	ld	a5,328(a5)
ffffffffc020821e:	1101                	addi	sp,sp,-32
ffffffffc0208220:	e426                	sd	s1,8(sp)
ffffffffc0208222:	6384                	ld	s1,0(a5)
ffffffffc0208224:	ec06                	sd	ra,24(sp)
ffffffffc0208226:	e822                	sd	s0,16(sp)
ffffffffc0208228:	cc81                	beqz	s1,ffffffffc0208240 <vfs_get_curdir+0x2e>
ffffffffc020822a:	842a                	mv	s0,a0
ffffffffc020822c:	8526                	mv	a0,s1
ffffffffc020822e:	d4eff0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc0208232:	4501                	li	a0,0
ffffffffc0208234:	e004                	sd	s1,0(s0)
ffffffffc0208236:	60e2                	ld	ra,24(sp)
ffffffffc0208238:	6442                	ld	s0,16(sp)
ffffffffc020823a:	64a2                	ld	s1,8(sp)
ffffffffc020823c:	6105                	addi	sp,sp,32
ffffffffc020823e:	8082                	ret
ffffffffc0208240:	5541                	li	a0,-16
ffffffffc0208242:	bfd5                	j	ffffffffc0208236 <vfs_get_curdir+0x24>

ffffffffc0208244 <vfs_set_curdir>:
ffffffffc0208244:	7139                	addi	sp,sp,-64
ffffffffc0208246:	f04a                	sd	s2,32(sp)
ffffffffc0208248:	0008e917          	auipc	s2,0x8e
ffffffffc020824c:	67890913          	addi	s2,s2,1656 # ffffffffc02968c0 <current>
ffffffffc0208250:	00093783          	ld	a5,0(s2)
ffffffffc0208254:	f822                	sd	s0,48(sp)
ffffffffc0208256:	842a                	mv	s0,a0
ffffffffc0208258:	1487b503          	ld	a0,328(a5)
ffffffffc020825c:	ec4e                	sd	s3,24(sp)
ffffffffc020825e:	fc06                	sd	ra,56(sp)
ffffffffc0208260:	f426                	sd	s1,40(sp)
ffffffffc0208262:	f61fc0ef          	jal	ra,ffffffffc02051c2 <lock_files>
ffffffffc0208266:	00093783          	ld	a5,0(s2)
ffffffffc020826a:	1487b503          	ld	a0,328(a5)
ffffffffc020826e:	00053983          	ld	s3,0(a0)
ffffffffc0208272:	07340963          	beq	s0,s3,ffffffffc02082e4 <vfs_set_curdir+0xa0>
ffffffffc0208276:	cc39                	beqz	s0,ffffffffc02082d4 <vfs_set_curdir+0x90>
ffffffffc0208278:	783c                	ld	a5,112(s0)
ffffffffc020827a:	c7bd                	beqz	a5,ffffffffc02082e8 <vfs_set_curdir+0xa4>
ffffffffc020827c:	6bbc                	ld	a5,80(a5)
ffffffffc020827e:	c7ad                	beqz	a5,ffffffffc02082e8 <vfs_set_curdir+0xa4>
ffffffffc0208280:	00006597          	auipc	a1,0x6
ffffffffc0208284:	4f858593          	addi	a1,a1,1272 # ffffffffc020e778 <syscalls+0xdb0>
ffffffffc0208288:	8522                	mv	a0,s0
ffffffffc020828a:	d0aff0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc020828e:	783c                	ld	a5,112(s0)
ffffffffc0208290:	006c                	addi	a1,sp,12
ffffffffc0208292:	8522                	mv	a0,s0
ffffffffc0208294:	6bbc                	ld	a5,80(a5)
ffffffffc0208296:	9782                	jalr	a5
ffffffffc0208298:	84aa                	mv	s1,a0
ffffffffc020829a:	e901                	bnez	a0,ffffffffc02082aa <vfs_set_curdir+0x66>
ffffffffc020829c:	47b2                	lw	a5,12(sp)
ffffffffc020829e:	669d                	lui	a3,0x7
ffffffffc02082a0:	6709                	lui	a4,0x2
ffffffffc02082a2:	8ff5                	and	a5,a5,a3
ffffffffc02082a4:	54b9                	li	s1,-18
ffffffffc02082a6:	02e78063          	beq	a5,a4,ffffffffc02082c6 <vfs_set_curdir+0x82>
ffffffffc02082aa:	00093783          	ld	a5,0(s2)
ffffffffc02082ae:	1487b503          	ld	a0,328(a5)
ffffffffc02082b2:	f17fc0ef          	jal	ra,ffffffffc02051c8 <unlock_files>
ffffffffc02082b6:	70e2                	ld	ra,56(sp)
ffffffffc02082b8:	7442                	ld	s0,48(sp)
ffffffffc02082ba:	7902                	ld	s2,32(sp)
ffffffffc02082bc:	69e2                	ld	s3,24(sp)
ffffffffc02082be:	8526                	mv	a0,s1
ffffffffc02082c0:	74a2                	ld	s1,40(sp)
ffffffffc02082c2:	6121                	addi	sp,sp,64
ffffffffc02082c4:	8082                	ret
ffffffffc02082c6:	8522                	mv	a0,s0
ffffffffc02082c8:	cb4ff0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc02082cc:	00093783          	ld	a5,0(s2)
ffffffffc02082d0:	1487b503          	ld	a0,328(a5)
ffffffffc02082d4:	e100                	sd	s0,0(a0)
ffffffffc02082d6:	4481                	li	s1,0
ffffffffc02082d8:	fc098de3          	beqz	s3,ffffffffc02082b2 <vfs_set_curdir+0x6e>
ffffffffc02082dc:	854e                	mv	a0,s3
ffffffffc02082de:	d6cff0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc02082e2:	b7e1                	j	ffffffffc02082aa <vfs_set_curdir+0x66>
ffffffffc02082e4:	4481                	li	s1,0
ffffffffc02082e6:	b7f1                	j	ffffffffc02082b2 <vfs_set_curdir+0x6e>
ffffffffc02082e8:	00006697          	auipc	a3,0x6
ffffffffc02082ec:	42868693          	addi	a3,a3,1064 # ffffffffc020e710 <syscalls+0xd48>
ffffffffc02082f0:	00003617          	auipc	a2,0x3
ffffffffc02082f4:	5a860613          	addi	a2,a2,1448 # ffffffffc020b898 <commands+0x210>
ffffffffc02082f8:	04300593          	li	a1,67
ffffffffc02082fc:	00006517          	auipc	a0,0x6
ffffffffc0208300:	46450513          	addi	a0,a0,1124 # ffffffffc020e760 <syscalls+0xd98>
ffffffffc0208304:	99af80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208308 <vfs_chdir>:
ffffffffc0208308:	1101                	addi	sp,sp,-32
ffffffffc020830a:	002c                	addi	a1,sp,8
ffffffffc020830c:	e822                	sd	s0,16(sp)
ffffffffc020830e:	ec06                	sd	ra,24(sp)
ffffffffc0208310:	e43ff0ef          	jal	ra,ffffffffc0208152 <vfs_lookup>
ffffffffc0208314:	842a                	mv	s0,a0
ffffffffc0208316:	c511                	beqz	a0,ffffffffc0208322 <vfs_chdir+0x1a>
ffffffffc0208318:	60e2                	ld	ra,24(sp)
ffffffffc020831a:	8522                	mv	a0,s0
ffffffffc020831c:	6442                	ld	s0,16(sp)
ffffffffc020831e:	6105                	addi	sp,sp,32
ffffffffc0208320:	8082                	ret
ffffffffc0208322:	6522                	ld	a0,8(sp)
ffffffffc0208324:	f21ff0ef          	jal	ra,ffffffffc0208244 <vfs_set_curdir>
ffffffffc0208328:	842a                	mv	s0,a0
ffffffffc020832a:	6522                	ld	a0,8(sp)
ffffffffc020832c:	d1eff0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc0208330:	60e2                	ld	ra,24(sp)
ffffffffc0208332:	8522                	mv	a0,s0
ffffffffc0208334:	6442                	ld	s0,16(sp)
ffffffffc0208336:	6105                	addi	sp,sp,32
ffffffffc0208338:	8082                	ret

ffffffffc020833a <vfs_getcwd>:
ffffffffc020833a:	0008e797          	auipc	a5,0x8e
ffffffffc020833e:	5867b783          	ld	a5,1414(a5) # ffffffffc02968c0 <current>
ffffffffc0208342:	1487b783          	ld	a5,328(a5)
ffffffffc0208346:	7179                	addi	sp,sp,-48
ffffffffc0208348:	ec26                	sd	s1,24(sp)
ffffffffc020834a:	6384                	ld	s1,0(a5)
ffffffffc020834c:	f406                	sd	ra,40(sp)
ffffffffc020834e:	f022                	sd	s0,32(sp)
ffffffffc0208350:	e84a                	sd	s2,16(sp)
ffffffffc0208352:	ccbd                	beqz	s1,ffffffffc02083d0 <vfs_getcwd+0x96>
ffffffffc0208354:	892a                	mv	s2,a0
ffffffffc0208356:	8526                	mv	a0,s1
ffffffffc0208358:	c24ff0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc020835c:	74a8                	ld	a0,104(s1)
ffffffffc020835e:	c93d                	beqz	a0,ffffffffc02083d4 <vfs_getcwd+0x9a>
ffffffffc0208360:	9b3ff0ef          	jal	ra,ffffffffc0207d12 <vfs_get_devname>
ffffffffc0208364:	842a                	mv	s0,a0
ffffffffc0208366:	7af020ef          	jal	ra,ffffffffc020b314 <strlen>
ffffffffc020836a:	862a                	mv	a2,a0
ffffffffc020836c:	85a2                	mv	a1,s0
ffffffffc020836e:	4701                	li	a4,0
ffffffffc0208370:	4685                	li	a3,1
ffffffffc0208372:	854a                	mv	a0,s2
ffffffffc0208374:	878fd0ef          	jal	ra,ffffffffc02053ec <iobuf_move>
ffffffffc0208378:	842a                	mv	s0,a0
ffffffffc020837a:	c919                	beqz	a0,ffffffffc0208390 <vfs_getcwd+0x56>
ffffffffc020837c:	8526                	mv	a0,s1
ffffffffc020837e:	cccff0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc0208382:	70a2                	ld	ra,40(sp)
ffffffffc0208384:	8522                	mv	a0,s0
ffffffffc0208386:	7402                	ld	s0,32(sp)
ffffffffc0208388:	64e2                	ld	s1,24(sp)
ffffffffc020838a:	6942                	ld	s2,16(sp)
ffffffffc020838c:	6145                	addi	sp,sp,48
ffffffffc020838e:	8082                	ret
ffffffffc0208390:	03a00793          	li	a5,58
ffffffffc0208394:	4701                	li	a4,0
ffffffffc0208396:	4685                	li	a3,1
ffffffffc0208398:	4605                	li	a2,1
ffffffffc020839a:	00f10593          	addi	a1,sp,15
ffffffffc020839e:	854a                	mv	a0,s2
ffffffffc02083a0:	00f107a3          	sb	a5,15(sp)
ffffffffc02083a4:	848fd0ef          	jal	ra,ffffffffc02053ec <iobuf_move>
ffffffffc02083a8:	842a                	mv	s0,a0
ffffffffc02083aa:	f969                	bnez	a0,ffffffffc020837c <vfs_getcwd+0x42>
ffffffffc02083ac:	78bc                	ld	a5,112(s1)
ffffffffc02083ae:	c3b9                	beqz	a5,ffffffffc02083f4 <vfs_getcwd+0xba>
ffffffffc02083b0:	7f9c                	ld	a5,56(a5)
ffffffffc02083b2:	c3a9                	beqz	a5,ffffffffc02083f4 <vfs_getcwd+0xba>
ffffffffc02083b4:	00006597          	auipc	a1,0x6
ffffffffc02083b8:	42458593          	addi	a1,a1,1060 # ffffffffc020e7d8 <syscalls+0xe10>
ffffffffc02083bc:	8526                	mv	a0,s1
ffffffffc02083be:	bd6ff0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc02083c2:	78bc                	ld	a5,112(s1)
ffffffffc02083c4:	85ca                	mv	a1,s2
ffffffffc02083c6:	8526                	mv	a0,s1
ffffffffc02083c8:	7f9c                	ld	a5,56(a5)
ffffffffc02083ca:	9782                	jalr	a5
ffffffffc02083cc:	842a                	mv	s0,a0
ffffffffc02083ce:	b77d                	j	ffffffffc020837c <vfs_getcwd+0x42>
ffffffffc02083d0:	5441                	li	s0,-16
ffffffffc02083d2:	bf45                	j	ffffffffc0208382 <vfs_getcwd+0x48>
ffffffffc02083d4:	00006697          	auipc	a3,0x6
ffffffffc02083d8:	2cc68693          	addi	a3,a3,716 # ffffffffc020e6a0 <syscalls+0xcd8>
ffffffffc02083dc:	00003617          	auipc	a2,0x3
ffffffffc02083e0:	4bc60613          	addi	a2,a2,1212 # ffffffffc020b898 <commands+0x210>
ffffffffc02083e4:	06e00593          	li	a1,110
ffffffffc02083e8:	00006517          	auipc	a0,0x6
ffffffffc02083ec:	37850513          	addi	a0,a0,888 # ffffffffc020e760 <syscalls+0xd98>
ffffffffc02083f0:	8aef80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02083f4:	00006697          	auipc	a3,0x6
ffffffffc02083f8:	38c68693          	addi	a3,a3,908 # ffffffffc020e780 <syscalls+0xdb8>
ffffffffc02083fc:	00003617          	auipc	a2,0x3
ffffffffc0208400:	49c60613          	addi	a2,a2,1180 # ffffffffc020b898 <commands+0x210>
ffffffffc0208404:	07800593          	li	a1,120
ffffffffc0208408:	00006517          	auipc	a0,0x6
ffffffffc020840c:	35850513          	addi	a0,a0,856 # ffffffffc020e760 <syscalls+0xd98>
ffffffffc0208410:	88ef80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208414 <dev_lookup>:
ffffffffc0208414:	0005c783          	lbu	a5,0(a1)
ffffffffc0208418:	e385                	bnez	a5,ffffffffc0208438 <dev_lookup+0x24>
ffffffffc020841a:	1101                	addi	sp,sp,-32
ffffffffc020841c:	e822                	sd	s0,16(sp)
ffffffffc020841e:	e426                	sd	s1,8(sp)
ffffffffc0208420:	ec06                	sd	ra,24(sp)
ffffffffc0208422:	84aa                	mv	s1,a0
ffffffffc0208424:	8432                	mv	s0,a2
ffffffffc0208426:	b56ff0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc020842a:	60e2                	ld	ra,24(sp)
ffffffffc020842c:	e004                	sd	s1,0(s0)
ffffffffc020842e:	6442                	ld	s0,16(sp)
ffffffffc0208430:	64a2                	ld	s1,8(sp)
ffffffffc0208432:	4501                	li	a0,0
ffffffffc0208434:	6105                	addi	sp,sp,32
ffffffffc0208436:	8082                	ret
ffffffffc0208438:	5541                	li	a0,-16
ffffffffc020843a:	8082                	ret

ffffffffc020843c <dev_fstat>:
ffffffffc020843c:	1101                	addi	sp,sp,-32
ffffffffc020843e:	e426                	sd	s1,8(sp)
ffffffffc0208440:	84ae                	mv	s1,a1
ffffffffc0208442:	e822                	sd	s0,16(sp)
ffffffffc0208444:	02000613          	li	a2,32
ffffffffc0208448:	842a                	mv	s0,a0
ffffffffc020844a:	4581                	li	a1,0
ffffffffc020844c:	8526                	mv	a0,s1
ffffffffc020844e:	ec06                	sd	ra,24(sp)
ffffffffc0208450:	767020ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0208454:	c429                	beqz	s0,ffffffffc020849e <dev_fstat+0x62>
ffffffffc0208456:	783c                	ld	a5,112(s0)
ffffffffc0208458:	c3b9                	beqz	a5,ffffffffc020849e <dev_fstat+0x62>
ffffffffc020845a:	6bbc                	ld	a5,80(a5)
ffffffffc020845c:	c3a9                	beqz	a5,ffffffffc020849e <dev_fstat+0x62>
ffffffffc020845e:	00006597          	auipc	a1,0x6
ffffffffc0208462:	31a58593          	addi	a1,a1,794 # ffffffffc020e778 <syscalls+0xdb0>
ffffffffc0208466:	8522                	mv	a0,s0
ffffffffc0208468:	b2cff0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc020846c:	783c                	ld	a5,112(s0)
ffffffffc020846e:	85a6                	mv	a1,s1
ffffffffc0208470:	8522                	mv	a0,s0
ffffffffc0208472:	6bbc                	ld	a5,80(a5)
ffffffffc0208474:	9782                	jalr	a5
ffffffffc0208476:	ed19                	bnez	a0,ffffffffc0208494 <dev_fstat+0x58>
ffffffffc0208478:	4c38                	lw	a4,88(s0)
ffffffffc020847a:	6785                	lui	a5,0x1
ffffffffc020847c:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208480:	02f71f63          	bne	a4,a5,ffffffffc02084be <dev_fstat+0x82>
ffffffffc0208484:	6018                	ld	a4,0(s0)
ffffffffc0208486:	641c                	ld	a5,8(s0)
ffffffffc0208488:	4685                	li	a3,1
ffffffffc020848a:	e494                	sd	a3,8(s1)
ffffffffc020848c:	02e787b3          	mul	a5,a5,a4
ffffffffc0208490:	e898                	sd	a4,16(s1)
ffffffffc0208492:	ec9c                	sd	a5,24(s1)
ffffffffc0208494:	60e2                	ld	ra,24(sp)
ffffffffc0208496:	6442                	ld	s0,16(sp)
ffffffffc0208498:	64a2                	ld	s1,8(sp)
ffffffffc020849a:	6105                	addi	sp,sp,32
ffffffffc020849c:	8082                	ret
ffffffffc020849e:	00006697          	auipc	a3,0x6
ffffffffc02084a2:	27268693          	addi	a3,a3,626 # ffffffffc020e710 <syscalls+0xd48>
ffffffffc02084a6:	00003617          	auipc	a2,0x3
ffffffffc02084aa:	3f260613          	addi	a2,a2,1010 # ffffffffc020b898 <commands+0x210>
ffffffffc02084ae:	04200593          	li	a1,66
ffffffffc02084b2:	00006517          	auipc	a0,0x6
ffffffffc02084b6:	33650513          	addi	a0,a0,822 # ffffffffc020e7e8 <syscalls+0xe20>
ffffffffc02084ba:	fe5f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02084be:	00006697          	auipc	a3,0x6
ffffffffc02084c2:	01a68693          	addi	a3,a3,26 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc02084c6:	00003617          	auipc	a2,0x3
ffffffffc02084ca:	3d260613          	addi	a2,a2,978 # ffffffffc020b898 <commands+0x210>
ffffffffc02084ce:	04500593          	li	a1,69
ffffffffc02084d2:	00006517          	auipc	a0,0x6
ffffffffc02084d6:	31650513          	addi	a0,a0,790 # ffffffffc020e7e8 <syscalls+0xe20>
ffffffffc02084da:	fc5f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02084de <dev_ioctl>:
ffffffffc02084de:	c909                	beqz	a0,ffffffffc02084f0 <dev_ioctl+0x12>
ffffffffc02084e0:	4d34                	lw	a3,88(a0)
ffffffffc02084e2:	6705                	lui	a4,0x1
ffffffffc02084e4:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02084e8:	00e69463          	bne	a3,a4,ffffffffc02084f0 <dev_ioctl+0x12>
ffffffffc02084ec:	751c                	ld	a5,40(a0)
ffffffffc02084ee:	8782                	jr	a5
ffffffffc02084f0:	1141                	addi	sp,sp,-16
ffffffffc02084f2:	00006697          	auipc	a3,0x6
ffffffffc02084f6:	fe668693          	addi	a3,a3,-26 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc02084fa:	00003617          	auipc	a2,0x3
ffffffffc02084fe:	39e60613          	addi	a2,a2,926 # ffffffffc020b898 <commands+0x210>
ffffffffc0208502:	03500593          	li	a1,53
ffffffffc0208506:	00006517          	auipc	a0,0x6
ffffffffc020850a:	2e250513          	addi	a0,a0,738 # ffffffffc020e7e8 <syscalls+0xe20>
ffffffffc020850e:	e406                	sd	ra,8(sp)
ffffffffc0208510:	f8ff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208514 <dev_tryseek>:
ffffffffc0208514:	c51d                	beqz	a0,ffffffffc0208542 <dev_tryseek+0x2e>
ffffffffc0208516:	4d38                	lw	a4,88(a0)
ffffffffc0208518:	6785                	lui	a5,0x1
ffffffffc020851a:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020851e:	02f71263          	bne	a4,a5,ffffffffc0208542 <dev_tryseek+0x2e>
ffffffffc0208522:	611c                	ld	a5,0(a0)
ffffffffc0208524:	cf89                	beqz	a5,ffffffffc020853e <dev_tryseek+0x2a>
ffffffffc0208526:	6518                	ld	a4,8(a0)
ffffffffc0208528:	02e5f6b3          	remu	a3,a1,a4
ffffffffc020852c:	ea89                	bnez	a3,ffffffffc020853e <dev_tryseek+0x2a>
ffffffffc020852e:	0005c863          	bltz	a1,ffffffffc020853e <dev_tryseek+0x2a>
ffffffffc0208532:	02e787b3          	mul	a5,a5,a4
ffffffffc0208536:	00f5f463          	bgeu	a1,a5,ffffffffc020853e <dev_tryseek+0x2a>
ffffffffc020853a:	4501                	li	a0,0
ffffffffc020853c:	8082                	ret
ffffffffc020853e:	5575                	li	a0,-3
ffffffffc0208540:	8082                	ret
ffffffffc0208542:	1141                	addi	sp,sp,-16
ffffffffc0208544:	00006697          	auipc	a3,0x6
ffffffffc0208548:	f9468693          	addi	a3,a3,-108 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc020854c:	00003617          	auipc	a2,0x3
ffffffffc0208550:	34c60613          	addi	a2,a2,844 # ffffffffc020b898 <commands+0x210>
ffffffffc0208554:	05f00593          	li	a1,95
ffffffffc0208558:	00006517          	auipc	a0,0x6
ffffffffc020855c:	29050513          	addi	a0,a0,656 # ffffffffc020e7e8 <syscalls+0xe20>
ffffffffc0208560:	e406                	sd	ra,8(sp)
ffffffffc0208562:	f3df70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208566 <dev_gettype>:
ffffffffc0208566:	c10d                	beqz	a0,ffffffffc0208588 <dev_gettype+0x22>
ffffffffc0208568:	4d38                	lw	a4,88(a0)
ffffffffc020856a:	6785                	lui	a5,0x1
ffffffffc020856c:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208570:	00f71c63          	bne	a4,a5,ffffffffc0208588 <dev_gettype+0x22>
ffffffffc0208574:	6118                	ld	a4,0(a0)
ffffffffc0208576:	6795                	lui	a5,0x5
ffffffffc0208578:	c701                	beqz	a4,ffffffffc0208580 <dev_gettype+0x1a>
ffffffffc020857a:	c19c                	sw	a5,0(a1)
ffffffffc020857c:	4501                	li	a0,0
ffffffffc020857e:	8082                	ret
ffffffffc0208580:	6791                	lui	a5,0x4
ffffffffc0208582:	c19c                	sw	a5,0(a1)
ffffffffc0208584:	4501                	li	a0,0
ffffffffc0208586:	8082                	ret
ffffffffc0208588:	1141                	addi	sp,sp,-16
ffffffffc020858a:	00006697          	auipc	a3,0x6
ffffffffc020858e:	f4e68693          	addi	a3,a3,-178 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc0208592:	00003617          	auipc	a2,0x3
ffffffffc0208596:	30660613          	addi	a2,a2,774 # ffffffffc020b898 <commands+0x210>
ffffffffc020859a:	05300593          	li	a1,83
ffffffffc020859e:	00006517          	auipc	a0,0x6
ffffffffc02085a2:	24a50513          	addi	a0,a0,586 # ffffffffc020e7e8 <syscalls+0xe20>
ffffffffc02085a6:	e406                	sd	ra,8(sp)
ffffffffc02085a8:	ef7f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02085ac <dev_write>:
ffffffffc02085ac:	c911                	beqz	a0,ffffffffc02085c0 <dev_write+0x14>
ffffffffc02085ae:	4d34                	lw	a3,88(a0)
ffffffffc02085b0:	6705                	lui	a4,0x1
ffffffffc02085b2:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02085b6:	00e69563          	bne	a3,a4,ffffffffc02085c0 <dev_write+0x14>
ffffffffc02085ba:	711c                	ld	a5,32(a0)
ffffffffc02085bc:	4605                	li	a2,1
ffffffffc02085be:	8782                	jr	a5
ffffffffc02085c0:	1141                	addi	sp,sp,-16
ffffffffc02085c2:	00006697          	auipc	a3,0x6
ffffffffc02085c6:	f1668693          	addi	a3,a3,-234 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc02085ca:	00003617          	auipc	a2,0x3
ffffffffc02085ce:	2ce60613          	addi	a2,a2,718 # ffffffffc020b898 <commands+0x210>
ffffffffc02085d2:	02c00593          	li	a1,44
ffffffffc02085d6:	00006517          	auipc	a0,0x6
ffffffffc02085da:	21250513          	addi	a0,a0,530 # ffffffffc020e7e8 <syscalls+0xe20>
ffffffffc02085de:	e406                	sd	ra,8(sp)
ffffffffc02085e0:	ebff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02085e4 <dev_read>:
ffffffffc02085e4:	c911                	beqz	a0,ffffffffc02085f8 <dev_read+0x14>
ffffffffc02085e6:	4d34                	lw	a3,88(a0)
ffffffffc02085e8:	6705                	lui	a4,0x1
ffffffffc02085ea:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02085ee:	00e69563          	bne	a3,a4,ffffffffc02085f8 <dev_read+0x14>
ffffffffc02085f2:	711c                	ld	a5,32(a0)
ffffffffc02085f4:	4601                	li	a2,0
ffffffffc02085f6:	8782                	jr	a5
ffffffffc02085f8:	1141                	addi	sp,sp,-16
ffffffffc02085fa:	00006697          	auipc	a3,0x6
ffffffffc02085fe:	ede68693          	addi	a3,a3,-290 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc0208602:	00003617          	auipc	a2,0x3
ffffffffc0208606:	29660613          	addi	a2,a2,662 # ffffffffc020b898 <commands+0x210>
ffffffffc020860a:	02300593          	li	a1,35
ffffffffc020860e:	00006517          	auipc	a0,0x6
ffffffffc0208612:	1da50513          	addi	a0,a0,474 # ffffffffc020e7e8 <syscalls+0xe20>
ffffffffc0208616:	e406                	sd	ra,8(sp)
ffffffffc0208618:	e87f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020861c <dev_close>:
ffffffffc020861c:	c909                	beqz	a0,ffffffffc020862e <dev_close+0x12>
ffffffffc020861e:	4d34                	lw	a3,88(a0)
ffffffffc0208620:	6705                	lui	a4,0x1
ffffffffc0208622:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208626:	00e69463          	bne	a3,a4,ffffffffc020862e <dev_close+0x12>
ffffffffc020862a:	6d1c                	ld	a5,24(a0)
ffffffffc020862c:	8782                	jr	a5
ffffffffc020862e:	1141                	addi	sp,sp,-16
ffffffffc0208630:	00006697          	auipc	a3,0x6
ffffffffc0208634:	ea868693          	addi	a3,a3,-344 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc0208638:	00003617          	auipc	a2,0x3
ffffffffc020863c:	26060613          	addi	a2,a2,608 # ffffffffc020b898 <commands+0x210>
ffffffffc0208640:	45e9                	li	a1,26
ffffffffc0208642:	00006517          	auipc	a0,0x6
ffffffffc0208646:	1a650513          	addi	a0,a0,422 # ffffffffc020e7e8 <syscalls+0xe20>
ffffffffc020864a:	e406                	sd	ra,8(sp)
ffffffffc020864c:	e53f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208650 <dev_open>:
ffffffffc0208650:	03c5f713          	andi	a4,a1,60
ffffffffc0208654:	eb11                	bnez	a4,ffffffffc0208668 <dev_open+0x18>
ffffffffc0208656:	c919                	beqz	a0,ffffffffc020866c <dev_open+0x1c>
ffffffffc0208658:	4d34                	lw	a3,88(a0)
ffffffffc020865a:	6705                	lui	a4,0x1
ffffffffc020865c:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208660:	00e69663          	bne	a3,a4,ffffffffc020866c <dev_open+0x1c>
ffffffffc0208664:	691c                	ld	a5,16(a0)
ffffffffc0208666:	8782                	jr	a5
ffffffffc0208668:	5575                	li	a0,-3
ffffffffc020866a:	8082                	ret
ffffffffc020866c:	1141                	addi	sp,sp,-16
ffffffffc020866e:	00006697          	auipc	a3,0x6
ffffffffc0208672:	e6a68693          	addi	a3,a3,-406 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc0208676:	00003617          	auipc	a2,0x3
ffffffffc020867a:	22260613          	addi	a2,a2,546 # ffffffffc020b898 <commands+0x210>
ffffffffc020867e:	45c5                	li	a1,17
ffffffffc0208680:	00006517          	auipc	a0,0x6
ffffffffc0208684:	16850513          	addi	a0,a0,360 # ffffffffc020e7e8 <syscalls+0xe20>
ffffffffc0208688:	e406                	sd	ra,8(sp)
ffffffffc020868a:	e15f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020868e <dev_init>:
ffffffffc020868e:	1141                	addi	sp,sp,-16
ffffffffc0208690:	e406                	sd	ra,8(sp)
ffffffffc0208692:	542000ef          	jal	ra,ffffffffc0208bd4 <dev_init_stdin>
ffffffffc0208696:	65a000ef          	jal	ra,ffffffffc0208cf0 <dev_init_stdout>
ffffffffc020869a:	60a2                	ld	ra,8(sp)
ffffffffc020869c:	0141                	addi	sp,sp,16
ffffffffc020869e:	a439                	j	ffffffffc02088ac <dev_init_disk0>

ffffffffc02086a0 <dev_create_inode>:
ffffffffc02086a0:	6505                	lui	a0,0x1
ffffffffc02086a2:	1141                	addi	sp,sp,-16
ffffffffc02086a4:	23450513          	addi	a0,a0,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02086a8:	e022                	sd	s0,0(sp)
ffffffffc02086aa:	e406                	sd	ra,8(sp)
ffffffffc02086ac:	852ff0ef          	jal	ra,ffffffffc02076fe <__alloc_inode>
ffffffffc02086b0:	842a                	mv	s0,a0
ffffffffc02086b2:	c901                	beqz	a0,ffffffffc02086c2 <dev_create_inode+0x22>
ffffffffc02086b4:	4601                	li	a2,0
ffffffffc02086b6:	00006597          	auipc	a1,0x6
ffffffffc02086ba:	14a58593          	addi	a1,a1,330 # ffffffffc020e800 <dev_node_ops>
ffffffffc02086be:	85cff0ef          	jal	ra,ffffffffc020771a <inode_init>
ffffffffc02086c2:	60a2                	ld	ra,8(sp)
ffffffffc02086c4:	8522                	mv	a0,s0
ffffffffc02086c6:	6402                	ld	s0,0(sp)
ffffffffc02086c8:	0141                	addi	sp,sp,16
ffffffffc02086ca:	8082                	ret

ffffffffc02086cc <disk0_open>:
ffffffffc02086cc:	4501                	li	a0,0
ffffffffc02086ce:	8082                	ret

ffffffffc02086d0 <disk0_close>:
ffffffffc02086d0:	4501                	li	a0,0
ffffffffc02086d2:	8082                	ret

ffffffffc02086d4 <disk0_ioctl>:
ffffffffc02086d4:	5531                	li	a0,-20
ffffffffc02086d6:	8082                	ret

ffffffffc02086d8 <disk0_io>:
ffffffffc02086d8:	659c                	ld	a5,8(a1)
ffffffffc02086da:	7159                	addi	sp,sp,-112
ffffffffc02086dc:	eca6                	sd	s1,88(sp)
ffffffffc02086de:	f45e                	sd	s7,40(sp)
ffffffffc02086e0:	6d84                	ld	s1,24(a1)
ffffffffc02086e2:	6b85                	lui	s7,0x1
ffffffffc02086e4:	1bfd                	addi	s7,s7,-1
ffffffffc02086e6:	e4ce                	sd	s3,72(sp)
ffffffffc02086e8:	43f7d993          	srai	s3,a5,0x3f
ffffffffc02086ec:	0179f9b3          	and	s3,s3,s7
ffffffffc02086f0:	99be                	add	s3,s3,a5
ffffffffc02086f2:	8fc5                	or	a5,a5,s1
ffffffffc02086f4:	f486                	sd	ra,104(sp)
ffffffffc02086f6:	f0a2                	sd	s0,96(sp)
ffffffffc02086f8:	e8ca                	sd	s2,80(sp)
ffffffffc02086fa:	e0d2                	sd	s4,64(sp)
ffffffffc02086fc:	fc56                	sd	s5,56(sp)
ffffffffc02086fe:	f85a                	sd	s6,48(sp)
ffffffffc0208700:	f062                	sd	s8,32(sp)
ffffffffc0208702:	ec66                	sd	s9,24(sp)
ffffffffc0208704:	e86a                	sd	s10,16(sp)
ffffffffc0208706:	0177f7b3          	and	a5,a5,s7
ffffffffc020870a:	10079d63          	bnez	a5,ffffffffc0208824 <disk0_io+0x14c>
ffffffffc020870e:	40c9d993          	srai	s3,s3,0xc
ffffffffc0208712:	00c4d713          	srli	a4,s1,0xc
ffffffffc0208716:	2981                	sext.w	s3,s3
ffffffffc0208718:	2701                	sext.w	a4,a4
ffffffffc020871a:	00e987bb          	addw	a5,s3,a4
ffffffffc020871e:	6114                	ld	a3,0(a0)
ffffffffc0208720:	1782                	slli	a5,a5,0x20
ffffffffc0208722:	9381                	srli	a5,a5,0x20
ffffffffc0208724:	10f6e063          	bltu	a3,a5,ffffffffc0208824 <disk0_io+0x14c>
ffffffffc0208728:	4501                	li	a0,0
ffffffffc020872a:	ef19                	bnez	a4,ffffffffc0208748 <disk0_io+0x70>
ffffffffc020872c:	70a6                	ld	ra,104(sp)
ffffffffc020872e:	7406                	ld	s0,96(sp)
ffffffffc0208730:	64e6                	ld	s1,88(sp)
ffffffffc0208732:	6946                	ld	s2,80(sp)
ffffffffc0208734:	69a6                	ld	s3,72(sp)
ffffffffc0208736:	6a06                	ld	s4,64(sp)
ffffffffc0208738:	7ae2                	ld	s5,56(sp)
ffffffffc020873a:	7b42                	ld	s6,48(sp)
ffffffffc020873c:	7ba2                	ld	s7,40(sp)
ffffffffc020873e:	7c02                	ld	s8,32(sp)
ffffffffc0208740:	6ce2                	ld	s9,24(sp)
ffffffffc0208742:	6d42                	ld	s10,16(sp)
ffffffffc0208744:	6165                	addi	sp,sp,112
ffffffffc0208746:	8082                	ret
ffffffffc0208748:	0008d517          	auipc	a0,0x8d
ffffffffc020874c:	0f850513          	addi	a0,a0,248 # ffffffffc0295840 <disk0_sem>
ffffffffc0208750:	8b2e                	mv	s6,a1
ffffffffc0208752:	8c32                	mv	s8,a2
ffffffffc0208754:	0008ea97          	auipc	s5,0x8e
ffffffffc0208758:	1a4a8a93          	addi	s5,s5,420 # ffffffffc02968f8 <disk0_buffer>
ffffffffc020875c:	e09fb0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0208760:	6c91                	lui	s9,0x4
ffffffffc0208762:	e4b9                	bnez	s1,ffffffffc02087b0 <disk0_io+0xd8>
ffffffffc0208764:	a845                	j	ffffffffc0208814 <disk0_io+0x13c>
ffffffffc0208766:	00c4d413          	srli	s0,s1,0xc
ffffffffc020876a:	0034169b          	slliw	a3,s0,0x3
ffffffffc020876e:	00068d1b          	sext.w	s10,a3
ffffffffc0208772:	1682                	slli	a3,a3,0x20
ffffffffc0208774:	2401                	sext.w	s0,s0
ffffffffc0208776:	9281                	srli	a3,a3,0x20
ffffffffc0208778:	8926                	mv	s2,s1
ffffffffc020877a:	00399a1b          	slliw	s4,s3,0x3
ffffffffc020877e:	862e                	mv	a2,a1
ffffffffc0208780:	4509                	li	a0,2
ffffffffc0208782:	85d2                	mv	a1,s4
ffffffffc0208784:	bbcf80ef          	jal	ra,ffffffffc0200b40 <ide_read_secs>
ffffffffc0208788:	e165                	bnez	a0,ffffffffc0208868 <disk0_io+0x190>
ffffffffc020878a:	000ab583          	ld	a1,0(s5)
ffffffffc020878e:	0038                	addi	a4,sp,8
ffffffffc0208790:	4685                	li	a3,1
ffffffffc0208792:	864a                	mv	a2,s2
ffffffffc0208794:	855a                	mv	a0,s6
ffffffffc0208796:	c57fc0ef          	jal	ra,ffffffffc02053ec <iobuf_move>
ffffffffc020879a:	67a2                	ld	a5,8(sp)
ffffffffc020879c:	09279663          	bne	a5,s2,ffffffffc0208828 <disk0_io+0x150>
ffffffffc02087a0:	017977b3          	and	a5,s2,s7
ffffffffc02087a4:	e3d1                	bnez	a5,ffffffffc0208828 <disk0_io+0x150>
ffffffffc02087a6:	412484b3          	sub	s1,s1,s2
ffffffffc02087aa:	013409bb          	addw	s3,s0,s3
ffffffffc02087ae:	c0bd                	beqz	s1,ffffffffc0208814 <disk0_io+0x13c>
ffffffffc02087b0:	000ab583          	ld	a1,0(s5)
ffffffffc02087b4:	000c1b63          	bnez	s8,ffffffffc02087ca <disk0_io+0xf2>
ffffffffc02087b8:	fb94e7e3          	bltu	s1,s9,ffffffffc0208766 <disk0_io+0x8e>
ffffffffc02087bc:	02000693          	li	a3,32
ffffffffc02087c0:	02000d13          	li	s10,32
ffffffffc02087c4:	4411                	li	s0,4
ffffffffc02087c6:	6911                	lui	s2,0x4
ffffffffc02087c8:	bf4d                	j	ffffffffc020877a <disk0_io+0xa2>
ffffffffc02087ca:	0038                	addi	a4,sp,8
ffffffffc02087cc:	4681                	li	a3,0
ffffffffc02087ce:	6611                	lui	a2,0x4
ffffffffc02087d0:	855a                	mv	a0,s6
ffffffffc02087d2:	c1bfc0ef          	jal	ra,ffffffffc02053ec <iobuf_move>
ffffffffc02087d6:	6422                	ld	s0,8(sp)
ffffffffc02087d8:	c825                	beqz	s0,ffffffffc0208848 <disk0_io+0x170>
ffffffffc02087da:	0684e763          	bltu	s1,s0,ffffffffc0208848 <disk0_io+0x170>
ffffffffc02087de:	017477b3          	and	a5,s0,s7
ffffffffc02087e2:	e3bd                	bnez	a5,ffffffffc0208848 <disk0_io+0x170>
ffffffffc02087e4:	8031                	srli	s0,s0,0xc
ffffffffc02087e6:	0034179b          	slliw	a5,s0,0x3
ffffffffc02087ea:	000ab603          	ld	a2,0(s5)
ffffffffc02087ee:	0039991b          	slliw	s2,s3,0x3
ffffffffc02087f2:	02079693          	slli	a3,a5,0x20
ffffffffc02087f6:	9281                	srli	a3,a3,0x20
ffffffffc02087f8:	85ca                	mv	a1,s2
ffffffffc02087fa:	4509                	li	a0,2
ffffffffc02087fc:	2401                	sext.w	s0,s0
ffffffffc02087fe:	00078a1b          	sext.w	s4,a5
ffffffffc0208802:	bd4f80ef          	jal	ra,ffffffffc0200bd6 <ide_write_secs>
ffffffffc0208806:	e151                	bnez	a0,ffffffffc020888a <disk0_io+0x1b2>
ffffffffc0208808:	6922                	ld	s2,8(sp)
ffffffffc020880a:	013409bb          	addw	s3,s0,s3
ffffffffc020880e:	412484b3          	sub	s1,s1,s2
ffffffffc0208812:	fcd9                	bnez	s1,ffffffffc02087b0 <disk0_io+0xd8>
ffffffffc0208814:	0008d517          	auipc	a0,0x8d
ffffffffc0208818:	02c50513          	addi	a0,a0,44 # ffffffffc0295840 <disk0_sem>
ffffffffc020881c:	d45fb0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0208820:	4501                	li	a0,0
ffffffffc0208822:	b729                	j	ffffffffc020872c <disk0_io+0x54>
ffffffffc0208824:	5575                	li	a0,-3
ffffffffc0208826:	b719                	j	ffffffffc020872c <disk0_io+0x54>
ffffffffc0208828:	00006697          	auipc	a3,0x6
ffffffffc020882c:	15068693          	addi	a3,a3,336 # ffffffffc020e978 <dev_node_ops+0x178>
ffffffffc0208830:	00003617          	auipc	a2,0x3
ffffffffc0208834:	06860613          	addi	a2,a2,104 # ffffffffc020b898 <commands+0x210>
ffffffffc0208838:	06200593          	li	a1,98
ffffffffc020883c:	00006517          	auipc	a0,0x6
ffffffffc0208840:	08450513          	addi	a0,a0,132 # ffffffffc020e8c0 <dev_node_ops+0xc0>
ffffffffc0208844:	c5bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208848:	00006697          	auipc	a3,0x6
ffffffffc020884c:	03868693          	addi	a3,a3,56 # ffffffffc020e880 <dev_node_ops+0x80>
ffffffffc0208850:	00003617          	auipc	a2,0x3
ffffffffc0208854:	04860613          	addi	a2,a2,72 # ffffffffc020b898 <commands+0x210>
ffffffffc0208858:	05700593          	li	a1,87
ffffffffc020885c:	00006517          	auipc	a0,0x6
ffffffffc0208860:	06450513          	addi	a0,a0,100 # ffffffffc020e8c0 <dev_node_ops+0xc0>
ffffffffc0208864:	c3bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208868:	88aa                	mv	a7,a0
ffffffffc020886a:	886a                	mv	a6,s10
ffffffffc020886c:	87a2                	mv	a5,s0
ffffffffc020886e:	8752                	mv	a4,s4
ffffffffc0208870:	86ce                	mv	a3,s3
ffffffffc0208872:	00006617          	auipc	a2,0x6
ffffffffc0208876:	0be60613          	addi	a2,a2,190 # ffffffffc020e930 <dev_node_ops+0x130>
ffffffffc020887a:	02d00593          	li	a1,45
ffffffffc020887e:	00006517          	auipc	a0,0x6
ffffffffc0208882:	04250513          	addi	a0,a0,66 # ffffffffc020e8c0 <dev_node_ops+0xc0>
ffffffffc0208886:	c19f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020888a:	88aa                	mv	a7,a0
ffffffffc020888c:	8852                	mv	a6,s4
ffffffffc020888e:	87a2                	mv	a5,s0
ffffffffc0208890:	874a                	mv	a4,s2
ffffffffc0208892:	86ce                	mv	a3,s3
ffffffffc0208894:	00006617          	auipc	a2,0x6
ffffffffc0208898:	04c60613          	addi	a2,a2,76 # ffffffffc020e8e0 <dev_node_ops+0xe0>
ffffffffc020889c:	03700593          	li	a1,55
ffffffffc02088a0:	00006517          	auipc	a0,0x6
ffffffffc02088a4:	02050513          	addi	a0,a0,32 # ffffffffc020e8c0 <dev_node_ops+0xc0>
ffffffffc02088a8:	bf7f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02088ac <dev_init_disk0>:
ffffffffc02088ac:	1101                	addi	sp,sp,-32
ffffffffc02088ae:	ec06                	sd	ra,24(sp)
ffffffffc02088b0:	e822                	sd	s0,16(sp)
ffffffffc02088b2:	e426                	sd	s1,8(sp)
ffffffffc02088b4:	dedff0ef          	jal	ra,ffffffffc02086a0 <dev_create_inode>
ffffffffc02088b8:	c541                	beqz	a0,ffffffffc0208940 <dev_init_disk0+0x94>
ffffffffc02088ba:	4d38                	lw	a4,88(a0)
ffffffffc02088bc:	6485                	lui	s1,0x1
ffffffffc02088be:	23448793          	addi	a5,s1,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02088c2:	842a                	mv	s0,a0
ffffffffc02088c4:	0cf71f63          	bne	a4,a5,ffffffffc02089a2 <dev_init_disk0+0xf6>
ffffffffc02088c8:	4509                	li	a0,2
ffffffffc02088ca:	a2af80ef          	jal	ra,ffffffffc0200af4 <ide_device_valid>
ffffffffc02088ce:	cd55                	beqz	a0,ffffffffc020898a <dev_init_disk0+0xde>
ffffffffc02088d0:	4509                	li	a0,2
ffffffffc02088d2:	a46f80ef          	jal	ra,ffffffffc0200b18 <ide_device_size>
ffffffffc02088d6:	00355793          	srli	a5,a0,0x3
ffffffffc02088da:	e01c                	sd	a5,0(s0)
ffffffffc02088dc:	00000797          	auipc	a5,0x0
ffffffffc02088e0:	df078793          	addi	a5,a5,-528 # ffffffffc02086cc <disk0_open>
ffffffffc02088e4:	e81c                	sd	a5,16(s0)
ffffffffc02088e6:	00000797          	auipc	a5,0x0
ffffffffc02088ea:	dea78793          	addi	a5,a5,-534 # ffffffffc02086d0 <disk0_close>
ffffffffc02088ee:	ec1c                	sd	a5,24(s0)
ffffffffc02088f0:	00000797          	auipc	a5,0x0
ffffffffc02088f4:	de878793          	addi	a5,a5,-536 # ffffffffc02086d8 <disk0_io>
ffffffffc02088f8:	f01c                	sd	a5,32(s0)
ffffffffc02088fa:	00000797          	auipc	a5,0x0
ffffffffc02088fe:	dda78793          	addi	a5,a5,-550 # ffffffffc02086d4 <disk0_ioctl>
ffffffffc0208902:	f41c                	sd	a5,40(s0)
ffffffffc0208904:	4585                	li	a1,1
ffffffffc0208906:	0008d517          	auipc	a0,0x8d
ffffffffc020890a:	f3a50513          	addi	a0,a0,-198 # ffffffffc0295840 <disk0_sem>
ffffffffc020890e:	e404                	sd	s1,8(s0)
ffffffffc0208910:	c4bfb0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc0208914:	6511                	lui	a0,0x4
ffffffffc0208916:	e78f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020891a:	0008e797          	auipc	a5,0x8e
ffffffffc020891e:	fca7bf23          	sd	a0,-34(a5) # ffffffffc02968f8 <disk0_buffer>
ffffffffc0208922:	c921                	beqz	a0,ffffffffc0208972 <dev_init_disk0+0xc6>
ffffffffc0208924:	4605                	li	a2,1
ffffffffc0208926:	85a2                	mv	a1,s0
ffffffffc0208928:	00006517          	auipc	a0,0x6
ffffffffc020892c:	0e050513          	addi	a0,a0,224 # ffffffffc020ea08 <dev_node_ops+0x208>
ffffffffc0208930:	c2cff0ef          	jal	ra,ffffffffc0207d5c <vfs_add_dev>
ffffffffc0208934:	e115                	bnez	a0,ffffffffc0208958 <dev_init_disk0+0xac>
ffffffffc0208936:	60e2                	ld	ra,24(sp)
ffffffffc0208938:	6442                	ld	s0,16(sp)
ffffffffc020893a:	64a2                	ld	s1,8(sp)
ffffffffc020893c:	6105                	addi	sp,sp,32
ffffffffc020893e:	8082                	ret
ffffffffc0208940:	00006617          	auipc	a2,0x6
ffffffffc0208944:	06860613          	addi	a2,a2,104 # ffffffffc020e9a8 <dev_node_ops+0x1a8>
ffffffffc0208948:	08700593          	li	a1,135
ffffffffc020894c:	00006517          	auipc	a0,0x6
ffffffffc0208950:	f7450513          	addi	a0,a0,-140 # ffffffffc020e8c0 <dev_node_ops+0xc0>
ffffffffc0208954:	b4bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208958:	86aa                	mv	a3,a0
ffffffffc020895a:	00006617          	auipc	a2,0x6
ffffffffc020895e:	0b660613          	addi	a2,a2,182 # ffffffffc020ea10 <dev_node_ops+0x210>
ffffffffc0208962:	08d00593          	li	a1,141
ffffffffc0208966:	00006517          	auipc	a0,0x6
ffffffffc020896a:	f5a50513          	addi	a0,a0,-166 # ffffffffc020e8c0 <dev_node_ops+0xc0>
ffffffffc020896e:	b31f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208972:	00006617          	auipc	a2,0x6
ffffffffc0208976:	07660613          	addi	a2,a2,118 # ffffffffc020e9e8 <dev_node_ops+0x1e8>
ffffffffc020897a:	07f00593          	li	a1,127
ffffffffc020897e:	00006517          	auipc	a0,0x6
ffffffffc0208982:	f4250513          	addi	a0,a0,-190 # ffffffffc020e8c0 <dev_node_ops+0xc0>
ffffffffc0208986:	b19f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020898a:	00006617          	auipc	a2,0x6
ffffffffc020898e:	03e60613          	addi	a2,a2,62 # ffffffffc020e9c8 <dev_node_ops+0x1c8>
ffffffffc0208992:	07300593          	li	a1,115
ffffffffc0208996:	00006517          	auipc	a0,0x6
ffffffffc020899a:	f2a50513          	addi	a0,a0,-214 # ffffffffc020e8c0 <dev_node_ops+0xc0>
ffffffffc020899e:	b01f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02089a2:	00006697          	auipc	a3,0x6
ffffffffc02089a6:	b3668693          	addi	a3,a3,-1226 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc02089aa:	00003617          	auipc	a2,0x3
ffffffffc02089ae:	eee60613          	addi	a2,a2,-274 # ffffffffc020b898 <commands+0x210>
ffffffffc02089b2:	08900593          	li	a1,137
ffffffffc02089b6:	00006517          	auipc	a0,0x6
ffffffffc02089ba:	f0a50513          	addi	a0,a0,-246 # ffffffffc020e8c0 <dev_node_ops+0xc0>
ffffffffc02089be:	ae1f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02089c2 <stdin_open>:
ffffffffc02089c2:	4501                	li	a0,0
ffffffffc02089c4:	e191                	bnez	a1,ffffffffc02089c8 <stdin_open+0x6>
ffffffffc02089c6:	8082                	ret
ffffffffc02089c8:	5575                	li	a0,-3
ffffffffc02089ca:	8082                	ret

ffffffffc02089cc <stdin_close>:
ffffffffc02089cc:	4501                	li	a0,0
ffffffffc02089ce:	8082                	ret

ffffffffc02089d0 <stdin_ioctl>:
ffffffffc02089d0:	5575                	li	a0,-3
ffffffffc02089d2:	8082                	ret

ffffffffc02089d4 <stdin_io>:
ffffffffc02089d4:	7135                	addi	sp,sp,-160
ffffffffc02089d6:	ed06                	sd	ra,152(sp)
ffffffffc02089d8:	e922                	sd	s0,144(sp)
ffffffffc02089da:	e526                	sd	s1,136(sp)
ffffffffc02089dc:	e14a                	sd	s2,128(sp)
ffffffffc02089de:	fcce                	sd	s3,120(sp)
ffffffffc02089e0:	f8d2                	sd	s4,112(sp)
ffffffffc02089e2:	f4d6                	sd	s5,104(sp)
ffffffffc02089e4:	f0da                	sd	s6,96(sp)
ffffffffc02089e6:	ecde                	sd	s7,88(sp)
ffffffffc02089e8:	e8e2                	sd	s8,80(sp)
ffffffffc02089ea:	e4e6                	sd	s9,72(sp)
ffffffffc02089ec:	e0ea                	sd	s10,64(sp)
ffffffffc02089ee:	fc6e                	sd	s11,56(sp)
ffffffffc02089f0:	14061163          	bnez	a2,ffffffffc0208b32 <stdin_io+0x15e>
ffffffffc02089f4:	0005bd83          	ld	s11,0(a1)
ffffffffc02089f8:	0185bd03          	ld	s10,24(a1)
ffffffffc02089fc:	8b2e                	mv	s6,a1
ffffffffc02089fe:	100027f3          	csrr	a5,sstatus
ffffffffc0208a02:	8b89                	andi	a5,a5,2
ffffffffc0208a04:	10079e63          	bnez	a5,ffffffffc0208b20 <stdin_io+0x14c>
ffffffffc0208a08:	4401                	li	s0,0
ffffffffc0208a0a:	100d0963          	beqz	s10,ffffffffc0208b1c <stdin_io+0x148>
ffffffffc0208a0e:	0008e997          	auipc	s3,0x8e
ffffffffc0208a12:	ef298993          	addi	s3,s3,-270 # ffffffffc0296900 <p_rpos>
ffffffffc0208a16:	0009b783          	ld	a5,0(s3)
ffffffffc0208a1a:	800004b7          	lui	s1,0x80000
ffffffffc0208a1e:	6c85                	lui	s9,0x1
ffffffffc0208a20:	4a81                	li	s5,0
ffffffffc0208a22:	0008ea17          	auipc	s4,0x8e
ffffffffc0208a26:	ee6a0a13          	addi	s4,s4,-282 # ffffffffc0296908 <p_wpos>
ffffffffc0208a2a:	0491                	addi	s1,s1,4
ffffffffc0208a2c:	0008d917          	auipc	s2,0x8d
ffffffffc0208a30:	e2c90913          	addi	s2,s2,-468 # ffffffffc0295858 <__wait_queue>
ffffffffc0208a34:	1cfd                	addi	s9,s9,-1
ffffffffc0208a36:	000a3703          	ld	a4,0(s4)
ffffffffc0208a3a:	000a8c1b          	sext.w	s8,s5
ffffffffc0208a3e:	8be2                	mv	s7,s8
ffffffffc0208a40:	02e7d763          	bge	a5,a4,ffffffffc0208a6e <stdin_io+0x9a>
ffffffffc0208a44:	a859                	j	ffffffffc0208ada <stdin_io+0x106>
ffffffffc0208a46:	815fe0ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc0208a4a:	100027f3          	csrr	a5,sstatus
ffffffffc0208a4e:	8b89                	andi	a5,a5,2
ffffffffc0208a50:	4401                	li	s0,0
ffffffffc0208a52:	ef8d                	bnez	a5,ffffffffc0208a8c <stdin_io+0xb8>
ffffffffc0208a54:	0028                	addi	a0,sp,8
ffffffffc0208a56:	ba1fb0ef          	jal	ra,ffffffffc02045f6 <wait_in_queue>
ffffffffc0208a5a:	e121                	bnez	a0,ffffffffc0208a9a <stdin_io+0xc6>
ffffffffc0208a5c:	47c2                	lw	a5,16(sp)
ffffffffc0208a5e:	04979563          	bne	a5,s1,ffffffffc0208aa8 <stdin_io+0xd4>
ffffffffc0208a62:	0009b783          	ld	a5,0(s3)
ffffffffc0208a66:	000a3703          	ld	a4,0(s4)
ffffffffc0208a6a:	06e7c863          	blt	a5,a4,ffffffffc0208ada <stdin_io+0x106>
ffffffffc0208a6e:	8626                	mv	a2,s1
ffffffffc0208a70:	002c                	addi	a1,sp,8
ffffffffc0208a72:	854a                	mv	a0,s2
ffffffffc0208a74:	cadfb0ef          	jal	ra,ffffffffc0204720 <wait_current_set>
ffffffffc0208a78:	d479                	beqz	s0,ffffffffc0208a46 <stdin_io+0x72>
ffffffffc0208a7a:	9f2f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208a7e:	fdcfe0ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc0208a82:	100027f3          	csrr	a5,sstatus
ffffffffc0208a86:	8b89                	andi	a5,a5,2
ffffffffc0208a88:	4401                	li	s0,0
ffffffffc0208a8a:	d7e9                	beqz	a5,ffffffffc0208a54 <stdin_io+0x80>
ffffffffc0208a8c:	9e6f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208a90:	0028                	addi	a0,sp,8
ffffffffc0208a92:	4405                	li	s0,1
ffffffffc0208a94:	b63fb0ef          	jal	ra,ffffffffc02045f6 <wait_in_queue>
ffffffffc0208a98:	d171                	beqz	a0,ffffffffc0208a5c <stdin_io+0x88>
ffffffffc0208a9a:	002c                	addi	a1,sp,8
ffffffffc0208a9c:	854a                	mv	a0,s2
ffffffffc0208a9e:	afffb0ef          	jal	ra,ffffffffc020459c <wait_queue_del>
ffffffffc0208aa2:	47c2                	lw	a5,16(sp)
ffffffffc0208aa4:	fa978fe3          	beq	a5,s1,ffffffffc0208a62 <stdin_io+0x8e>
ffffffffc0208aa8:	e435                	bnez	s0,ffffffffc0208b14 <stdin_io+0x140>
ffffffffc0208aaa:	060b8963          	beqz	s7,ffffffffc0208b1c <stdin_io+0x148>
ffffffffc0208aae:	018b3783          	ld	a5,24(s6)
ffffffffc0208ab2:	41578ab3          	sub	s5,a5,s5
ffffffffc0208ab6:	015b3c23          	sd	s5,24(s6)
ffffffffc0208aba:	60ea                	ld	ra,152(sp)
ffffffffc0208abc:	644a                	ld	s0,144(sp)
ffffffffc0208abe:	64aa                	ld	s1,136(sp)
ffffffffc0208ac0:	690a                	ld	s2,128(sp)
ffffffffc0208ac2:	79e6                	ld	s3,120(sp)
ffffffffc0208ac4:	7a46                	ld	s4,112(sp)
ffffffffc0208ac6:	7aa6                	ld	s5,104(sp)
ffffffffc0208ac8:	7b06                	ld	s6,96(sp)
ffffffffc0208aca:	6c46                	ld	s8,80(sp)
ffffffffc0208acc:	6ca6                	ld	s9,72(sp)
ffffffffc0208ace:	6d06                	ld	s10,64(sp)
ffffffffc0208ad0:	7de2                	ld	s11,56(sp)
ffffffffc0208ad2:	855e                	mv	a0,s7
ffffffffc0208ad4:	6be6                	ld	s7,88(sp)
ffffffffc0208ad6:	610d                	addi	sp,sp,160
ffffffffc0208ad8:	8082                	ret
ffffffffc0208ada:	43f7d713          	srai	a4,a5,0x3f
ffffffffc0208ade:	03475693          	srli	a3,a4,0x34
ffffffffc0208ae2:	00d78733          	add	a4,a5,a3
ffffffffc0208ae6:	01977733          	and	a4,a4,s9
ffffffffc0208aea:	8f15                	sub	a4,a4,a3
ffffffffc0208aec:	0008d697          	auipc	a3,0x8d
ffffffffc0208af0:	d7c68693          	addi	a3,a3,-644 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208af4:	9736                	add	a4,a4,a3
ffffffffc0208af6:	00074683          	lbu	a3,0(a4)
ffffffffc0208afa:	0785                	addi	a5,a5,1
ffffffffc0208afc:	015d8733          	add	a4,s11,s5
ffffffffc0208b00:	00d70023          	sb	a3,0(a4)
ffffffffc0208b04:	00f9b023          	sd	a5,0(s3)
ffffffffc0208b08:	0a85                	addi	s5,s5,1
ffffffffc0208b0a:	001c0b9b          	addiw	s7,s8,1
ffffffffc0208b0e:	f3aae4e3          	bltu	s5,s10,ffffffffc0208a36 <stdin_io+0x62>
ffffffffc0208b12:	dc51                	beqz	s0,ffffffffc0208aae <stdin_io+0xda>
ffffffffc0208b14:	958f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208b18:	f80b9be3          	bnez	s7,ffffffffc0208aae <stdin_io+0xda>
ffffffffc0208b1c:	4b81                	li	s7,0
ffffffffc0208b1e:	bf71                	j	ffffffffc0208aba <stdin_io+0xe6>
ffffffffc0208b20:	952f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208b24:	4405                	li	s0,1
ffffffffc0208b26:	ee0d14e3          	bnez	s10,ffffffffc0208a0e <stdin_io+0x3a>
ffffffffc0208b2a:	942f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208b2e:	4b81                	li	s7,0
ffffffffc0208b30:	b769                	j	ffffffffc0208aba <stdin_io+0xe6>
ffffffffc0208b32:	5bf5                	li	s7,-3
ffffffffc0208b34:	b759                	j	ffffffffc0208aba <stdin_io+0xe6>

ffffffffc0208b36 <dev_stdin_write>:
ffffffffc0208b36:	e111                	bnez	a0,ffffffffc0208b3a <dev_stdin_write+0x4>
ffffffffc0208b38:	8082                	ret
ffffffffc0208b3a:	1101                	addi	sp,sp,-32
ffffffffc0208b3c:	e822                	sd	s0,16(sp)
ffffffffc0208b3e:	ec06                	sd	ra,24(sp)
ffffffffc0208b40:	e426                	sd	s1,8(sp)
ffffffffc0208b42:	842a                	mv	s0,a0
ffffffffc0208b44:	100027f3          	csrr	a5,sstatus
ffffffffc0208b48:	8b89                	andi	a5,a5,2
ffffffffc0208b4a:	4481                	li	s1,0
ffffffffc0208b4c:	e3c1                	bnez	a5,ffffffffc0208bcc <dev_stdin_write+0x96>
ffffffffc0208b4e:	0008e597          	auipc	a1,0x8e
ffffffffc0208b52:	dba58593          	addi	a1,a1,-582 # ffffffffc0296908 <p_wpos>
ffffffffc0208b56:	6198                	ld	a4,0(a1)
ffffffffc0208b58:	6605                	lui	a2,0x1
ffffffffc0208b5a:	fff60513          	addi	a0,a2,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0208b5e:	43f75693          	srai	a3,a4,0x3f
ffffffffc0208b62:	92d1                	srli	a3,a3,0x34
ffffffffc0208b64:	00d707b3          	add	a5,a4,a3
ffffffffc0208b68:	8fe9                	and	a5,a5,a0
ffffffffc0208b6a:	8f95                	sub	a5,a5,a3
ffffffffc0208b6c:	0008d697          	auipc	a3,0x8d
ffffffffc0208b70:	cfc68693          	addi	a3,a3,-772 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208b74:	97b6                	add	a5,a5,a3
ffffffffc0208b76:	00878023          	sb	s0,0(a5)
ffffffffc0208b7a:	0008e797          	auipc	a5,0x8e
ffffffffc0208b7e:	d867b783          	ld	a5,-634(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208b82:	40f707b3          	sub	a5,a4,a5
ffffffffc0208b86:	00c7d463          	bge	a5,a2,ffffffffc0208b8e <dev_stdin_write+0x58>
ffffffffc0208b8a:	0705                	addi	a4,a4,1
ffffffffc0208b8c:	e198                	sd	a4,0(a1)
ffffffffc0208b8e:	0008d517          	auipc	a0,0x8d
ffffffffc0208b92:	cca50513          	addi	a0,a0,-822 # ffffffffc0295858 <__wait_queue>
ffffffffc0208b96:	a55fb0ef          	jal	ra,ffffffffc02045ea <wait_queue_empty>
ffffffffc0208b9a:	cd09                	beqz	a0,ffffffffc0208bb4 <dev_stdin_write+0x7e>
ffffffffc0208b9c:	e491                	bnez	s1,ffffffffc0208ba8 <dev_stdin_write+0x72>
ffffffffc0208b9e:	60e2                	ld	ra,24(sp)
ffffffffc0208ba0:	6442                	ld	s0,16(sp)
ffffffffc0208ba2:	64a2                	ld	s1,8(sp)
ffffffffc0208ba4:	6105                	addi	sp,sp,32
ffffffffc0208ba6:	8082                	ret
ffffffffc0208ba8:	6442                	ld	s0,16(sp)
ffffffffc0208baa:	60e2                	ld	ra,24(sp)
ffffffffc0208bac:	64a2                	ld	s1,8(sp)
ffffffffc0208bae:	6105                	addi	sp,sp,32
ffffffffc0208bb0:	8bcf806f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0208bb4:	800005b7          	lui	a1,0x80000
ffffffffc0208bb8:	4605                	li	a2,1
ffffffffc0208bba:	0591                	addi	a1,a1,4
ffffffffc0208bbc:	0008d517          	auipc	a0,0x8d
ffffffffc0208bc0:	c9c50513          	addi	a0,a0,-868 # ffffffffc0295858 <__wait_queue>
ffffffffc0208bc4:	a8ffb0ef          	jal	ra,ffffffffc0204652 <wakeup_queue>
ffffffffc0208bc8:	d8f9                	beqz	s1,ffffffffc0208b9e <dev_stdin_write+0x68>
ffffffffc0208bca:	bff9                	j	ffffffffc0208ba8 <dev_stdin_write+0x72>
ffffffffc0208bcc:	8a6f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208bd0:	4485                	li	s1,1
ffffffffc0208bd2:	bfb5                	j	ffffffffc0208b4e <dev_stdin_write+0x18>

ffffffffc0208bd4 <dev_init_stdin>:
ffffffffc0208bd4:	1141                	addi	sp,sp,-16
ffffffffc0208bd6:	e406                	sd	ra,8(sp)
ffffffffc0208bd8:	e022                	sd	s0,0(sp)
ffffffffc0208bda:	ac7ff0ef          	jal	ra,ffffffffc02086a0 <dev_create_inode>
ffffffffc0208bde:	c93d                	beqz	a0,ffffffffc0208c54 <dev_init_stdin+0x80>
ffffffffc0208be0:	4d38                	lw	a4,88(a0)
ffffffffc0208be2:	6785                	lui	a5,0x1
ffffffffc0208be4:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208be8:	842a                	mv	s0,a0
ffffffffc0208bea:	08f71e63          	bne	a4,a5,ffffffffc0208c86 <dev_init_stdin+0xb2>
ffffffffc0208bee:	4785                	li	a5,1
ffffffffc0208bf0:	e41c                	sd	a5,8(s0)
ffffffffc0208bf2:	00000797          	auipc	a5,0x0
ffffffffc0208bf6:	dd078793          	addi	a5,a5,-560 # ffffffffc02089c2 <stdin_open>
ffffffffc0208bfa:	e81c                	sd	a5,16(s0)
ffffffffc0208bfc:	00000797          	auipc	a5,0x0
ffffffffc0208c00:	dd078793          	addi	a5,a5,-560 # ffffffffc02089cc <stdin_close>
ffffffffc0208c04:	ec1c                	sd	a5,24(s0)
ffffffffc0208c06:	00000797          	auipc	a5,0x0
ffffffffc0208c0a:	dce78793          	addi	a5,a5,-562 # ffffffffc02089d4 <stdin_io>
ffffffffc0208c0e:	f01c                	sd	a5,32(s0)
ffffffffc0208c10:	00000797          	auipc	a5,0x0
ffffffffc0208c14:	dc078793          	addi	a5,a5,-576 # ffffffffc02089d0 <stdin_ioctl>
ffffffffc0208c18:	f41c                	sd	a5,40(s0)
ffffffffc0208c1a:	0008d517          	auipc	a0,0x8d
ffffffffc0208c1e:	c3e50513          	addi	a0,a0,-962 # ffffffffc0295858 <__wait_queue>
ffffffffc0208c22:	00043023          	sd	zero,0(s0)
ffffffffc0208c26:	0008e797          	auipc	a5,0x8e
ffffffffc0208c2a:	ce07b123          	sd	zero,-798(a5) # ffffffffc0296908 <p_wpos>
ffffffffc0208c2e:	0008e797          	auipc	a5,0x8e
ffffffffc0208c32:	cc07b923          	sd	zero,-814(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208c36:	961fb0ef          	jal	ra,ffffffffc0204596 <wait_queue_init>
ffffffffc0208c3a:	4601                	li	a2,0
ffffffffc0208c3c:	85a2                	mv	a1,s0
ffffffffc0208c3e:	00006517          	auipc	a0,0x6
ffffffffc0208c42:	e3250513          	addi	a0,a0,-462 # ffffffffc020ea70 <dev_node_ops+0x270>
ffffffffc0208c46:	916ff0ef          	jal	ra,ffffffffc0207d5c <vfs_add_dev>
ffffffffc0208c4a:	e10d                	bnez	a0,ffffffffc0208c6c <dev_init_stdin+0x98>
ffffffffc0208c4c:	60a2                	ld	ra,8(sp)
ffffffffc0208c4e:	6402                	ld	s0,0(sp)
ffffffffc0208c50:	0141                	addi	sp,sp,16
ffffffffc0208c52:	8082                	ret
ffffffffc0208c54:	00006617          	auipc	a2,0x6
ffffffffc0208c58:	ddc60613          	addi	a2,a2,-548 # ffffffffc020ea30 <dev_node_ops+0x230>
ffffffffc0208c5c:	07500593          	li	a1,117
ffffffffc0208c60:	00006517          	auipc	a0,0x6
ffffffffc0208c64:	df050513          	addi	a0,a0,-528 # ffffffffc020ea50 <dev_node_ops+0x250>
ffffffffc0208c68:	837f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c6c:	86aa                	mv	a3,a0
ffffffffc0208c6e:	00006617          	auipc	a2,0x6
ffffffffc0208c72:	e0a60613          	addi	a2,a2,-502 # ffffffffc020ea78 <dev_node_ops+0x278>
ffffffffc0208c76:	07b00593          	li	a1,123
ffffffffc0208c7a:	00006517          	auipc	a0,0x6
ffffffffc0208c7e:	dd650513          	addi	a0,a0,-554 # ffffffffc020ea50 <dev_node_ops+0x250>
ffffffffc0208c82:	81df70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c86:	00006697          	auipc	a3,0x6
ffffffffc0208c8a:	85268693          	addi	a3,a3,-1966 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc0208c8e:	00003617          	auipc	a2,0x3
ffffffffc0208c92:	c0a60613          	addi	a2,a2,-1014 # ffffffffc020b898 <commands+0x210>
ffffffffc0208c96:	07700593          	li	a1,119
ffffffffc0208c9a:	00006517          	auipc	a0,0x6
ffffffffc0208c9e:	db650513          	addi	a0,a0,-586 # ffffffffc020ea50 <dev_node_ops+0x250>
ffffffffc0208ca2:	ffcf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208ca6 <stdout_open>:
ffffffffc0208ca6:	4785                	li	a5,1
ffffffffc0208ca8:	4501                	li	a0,0
ffffffffc0208caa:	00f59363          	bne	a1,a5,ffffffffc0208cb0 <stdout_open+0xa>
ffffffffc0208cae:	8082                	ret
ffffffffc0208cb0:	5575                	li	a0,-3
ffffffffc0208cb2:	8082                	ret

ffffffffc0208cb4 <stdout_close>:
ffffffffc0208cb4:	4501                	li	a0,0
ffffffffc0208cb6:	8082                	ret

ffffffffc0208cb8 <stdout_ioctl>:
ffffffffc0208cb8:	5575                	li	a0,-3
ffffffffc0208cba:	8082                	ret

ffffffffc0208cbc <stdout_io>:
ffffffffc0208cbc:	ca05                	beqz	a2,ffffffffc0208cec <stdout_io+0x30>
ffffffffc0208cbe:	6d9c                	ld	a5,24(a1)
ffffffffc0208cc0:	1101                	addi	sp,sp,-32
ffffffffc0208cc2:	e822                	sd	s0,16(sp)
ffffffffc0208cc4:	e426                	sd	s1,8(sp)
ffffffffc0208cc6:	ec06                	sd	ra,24(sp)
ffffffffc0208cc8:	6180                	ld	s0,0(a1)
ffffffffc0208cca:	84ae                	mv	s1,a1
ffffffffc0208ccc:	cb91                	beqz	a5,ffffffffc0208ce0 <stdout_io+0x24>
ffffffffc0208cce:	00044503          	lbu	a0,0(s0)
ffffffffc0208cd2:	0405                	addi	s0,s0,1
ffffffffc0208cd4:	d0ef70ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0208cd8:	6c9c                	ld	a5,24(s1)
ffffffffc0208cda:	17fd                	addi	a5,a5,-1
ffffffffc0208cdc:	ec9c                	sd	a5,24(s1)
ffffffffc0208cde:	fbe5                	bnez	a5,ffffffffc0208cce <stdout_io+0x12>
ffffffffc0208ce0:	60e2                	ld	ra,24(sp)
ffffffffc0208ce2:	6442                	ld	s0,16(sp)
ffffffffc0208ce4:	64a2                	ld	s1,8(sp)
ffffffffc0208ce6:	4501                	li	a0,0
ffffffffc0208ce8:	6105                	addi	sp,sp,32
ffffffffc0208cea:	8082                	ret
ffffffffc0208cec:	5575                	li	a0,-3
ffffffffc0208cee:	8082                	ret

ffffffffc0208cf0 <dev_init_stdout>:
ffffffffc0208cf0:	1141                	addi	sp,sp,-16
ffffffffc0208cf2:	e406                	sd	ra,8(sp)
ffffffffc0208cf4:	9adff0ef          	jal	ra,ffffffffc02086a0 <dev_create_inode>
ffffffffc0208cf8:	c939                	beqz	a0,ffffffffc0208d4e <dev_init_stdout+0x5e>
ffffffffc0208cfa:	4d38                	lw	a4,88(a0)
ffffffffc0208cfc:	6785                	lui	a5,0x1
ffffffffc0208cfe:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208d02:	85aa                	mv	a1,a0
ffffffffc0208d04:	06f71e63          	bne	a4,a5,ffffffffc0208d80 <dev_init_stdout+0x90>
ffffffffc0208d08:	4785                	li	a5,1
ffffffffc0208d0a:	e51c                	sd	a5,8(a0)
ffffffffc0208d0c:	00000797          	auipc	a5,0x0
ffffffffc0208d10:	f9a78793          	addi	a5,a5,-102 # ffffffffc0208ca6 <stdout_open>
ffffffffc0208d14:	e91c                	sd	a5,16(a0)
ffffffffc0208d16:	00000797          	auipc	a5,0x0
ffffffffc0208d1a:	f9e78793          	addi	a5,a5,-98 # ffffffffc0208cb4 <stdout_close>
ffffffffc0208d1e:	ed1c                	sd	a5,24(a0)
ffffffffc0208d20:	00000797          	auipc	a5,0x0
ffffffffc0208d24:	f9c78793          	addi	a5,a5,-100 # ffffffffc0208cbc <stdout_io>
ffffffffc0208d28:	f11c                	sd	a5,32(a0)
ffffffffc0208d2a:	00000797          	auipc	a5,0x0
ffffffffc0208d2e:	f8e78793          	addi	a5,a5,-114 # ffffffffc0208cb8 <stdout_ioctl>
ffffffffc0208d32:	00053023          	sd	zero,0(a0)
ffffffffc0208d36:	f51c                	sd	a5,40(a0)
ffffffffc0208d38:	4601                	li	a2,0
ffffffffc0208d3a:	00006517          	auipc	a0,0x6
ffffffffc0208d3e:	d9e50513          	addi	a0,a0,-610 # ffffffffc020ead8 <dev_node_ops+0x2d8>
ffffffffc0208d42:	81aff0ef          	jal	ra,ffffffffc0207d5c <vfs_add_dev>
ffffffffc0208d46:	e105                	bnez	a0,ffffffffc0208d66 <dev_init_stdout+0x76>
ffffffffc0208d48:	60a2                	ld	ra,8(sp)
ffffffffc0208d4a:	0141                	addi	sp,sp,16
ffffffffc0208d4c:	8082                	ret
ffffffffc0208d4e:	00006617          	auipc	a2,0x6
ffffffffc0208d52:	d4a60613          	addi	a2,a2,-694 # ffffffffc020ea98 <dev_node_ops+0x298>
ffffffffc0208d56:	03700593          	li	a1,55
ffffffffc0208d5a:	00006517          	auipc	a0,0x6
ffffffffc0208d5e:	d5e50513          	addi	a0,a0,-674 # ffffffffc020eab8 <dev_node_ops+0x2b8>
ffffffffc0208d62:	f3cf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d66:	86aa                	mv	a3,a0
ffffffffc0208d68:	00006617          	auipc	a2,0x6
ffffffffc0208d6c:	d7860613          	addi	a2,a2,-648 # ffffffffc020eae0 <dev_node_ops+0x2e0>
ffffffffc0208d70:	03d00593          	li	a1,61
ffffffffc0208d74:	00006517          	auipc	a0,0x6
ffffffffc0208d78:	d4450513          	addi	a0,a0,-700 # ffffffffc020eab8 <dev_node_ops+0x2b8>
ffffffffc0208d7c:	f22f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d80:	00005697          	auipc	a3,0x5
ffffffffc0208d84:	75868693          	addi	a3,a3,1880 # ffffffffc020e4d8 <syscalls+0xb10>
ffffffffc0208d88:	00003617          	auipc	a2,0x3
ffffffffc0208d8c:	b1060613          	addi	a2,a2,-1264 # ffffffffc020b898 <commands+0x210>
ffffffffc0208d90:	03900593          	li	a1,57
ffffffffc0208d94:	00006517          	auipc	a0,0x6
ffffffffc0208d98:	d2450513          	addi	a0,a0,-732 # ffffffffc020eab8 <dev_node_ops+0x2b8>
ffffffffc0208d9c:	f02f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208da0 <bitmap_translate.part.0>:
ffffffffc0208da0:	1141                	addi	sp,sp,-16
ffffffffc0208da2:	00006697          	auipc	a3,0x6
ffffffffc0208da6:	d5e68693          	addi	a3,a3,-674 # ffffffffc020eb00 <dev_node_ops+0x300>
ffffffffc0208daa:	00003617          	auipc	a2,0x3
ffffffffc0208dae:	aee60613          	addi	a2,a2,-1298 # ffffffffc020b898 <commands+0x210>
ffffffffc0208db2:	04c00593          	li	a1,76
ffffffffc0208db6:	00006517          	auipc	a0,0x6
ffffffffc0208dba:	d6250513          	addi	a0,a0,-670 # ffffffffc020eb18 <dev_node_ops+0x318>
ffffffffc0208dbe:	e406                	sd	ra,8(sp)
ffffffffc0208dc0:	edef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208dc4 <bitmap_create>:
ffffffffc0208dc4:	7139                	addi	sp,sp,-64
ffffffffc0208dc6:	fc06                	sd	ra,56(sp)
ffffffffc0208dc8:	f822                	sd	s0,48(sp)
ffffffffc0208dca:	f426                	sd	s1,40(sp)
ffffffffc0208dcc:	f04a                	sd	s2,32(sp)
ffffffffc0208dce:	ec4e                	sd	s3,24(sp)
ffffffffc0208dd0:	e852                	sd	s4,16(sp)
ffffffffc0208dd2:	e456                	sd	s5,8(sp)
ffffffffc0208dd4:	c14d                	beqz	a0,ffffffffc0208e76 <bitmap_create+0xb2>
ffffffffc0208dd6:	842a                	mv	s0,a0
ffffffffc0208dd8:	4541                	li	a0,16
ffffffffc0208dda:	9b4f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208dde:	84aa                	mv	s1,a0
ffffffffc0208de0:	cd25                	beqz	a0,ffffffffc0208e58 <bitmap_create+0x94>
ffffffffc0208de2:	02041a13          	slli	s4,s0,0x20
ffffffffc0208de6:	020a5a13          	srli	s4,s4,0x20
ffffffffc0208dea:	01fa0793          	addi	a5,s4,31
ffffffffc0208dee:	0057d993          	srli	s3,a5,0x5
ffffffffc0208df2:	00299a93          	slli	s5,s3,0x2
ffffffffc0208df6:	8556                	mv	a0,s5
ffffffffc0208df8:	894e                	mv	s2,s3
ffffffffc0208dfa:	994f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208dfe:	c53d                	beqz	a0,ffffffffc0208e6c <bitmap_create+0xa8>
ffffffffc0208e00:	0134a223          	sw	s3,4(s1) # ffffffff80000004 <_binary_bin_sfs_img_size+0xffffffff7ff8ad04>
ffffffffc0208e04:	c080                	sw	s0,0(s1)
ffffffffc0208e06:	8656                	mv	a2,s5
ffffffffc0208e08:	0ff00593          	li	a1,255
ffffffffc0208e0c:	5aa020ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc0208e10:	e488                	sd	a0,8(s1)
ffffffffc0208e12:	0996                	slli	s3,s3,0x5
ffffffffc0208e14:	053a0263          	beq	s4,s3,ffffffffc0208e58 <bitmap_create+0x94>
ffffffffc0208e18:	fff9079b          	addiw	a5,s2,-1
ffffffffc0208e1c:	0057969b          	slliw	a3,a5,0x5
ffffffffc0208e20:	0054561b          	srliw	a2,s0,0x5
ffffffffc0208e24:	40d4073b          	subw	a4,s0,a3
ffffffffc0208e28:	0054541b          	srliw	s0,s0,0x5
ffffffffc0208e2c:	08f61463          	bne	a2,a5,ffffffffc0208eb4 <bitmap_create+0xf0>
ffffffffc0208e30:	fff7069b          	addiw	a3,a4,-1
ffffffffc0208e34:	47f9                	li	a5,30
ffffffffc0208e36:	04d7ef63          	bltu	a5,a3,ffffffffc0208e94 <bitmap_create+0xd0>
ffffffffc0208e3a:	1402                	slli	s0,s0,0x20
ffffffffc0208e3c:	8079                	srli	s0,s0,0x1e
ffffffffc0208e3e:	9522                	add	a0,a0,s0
ffffffffc0208e40:	411c                	lw	a5,0(a0)
ffffffffc0208e42:	4585                	li	a1,1
ffffffffc0208e44:	02000613          	li	a2,32
ffffffffc0208e48:	00e596bb          	sllw	a3,a1,a4
ffffffffc0208e4c:	8fb5                	xor	a5,a5,a3
ffffffffc0208e4e:	2705                	addiw	a4,a4,1
ffffffffc0208e50:	2781                	sext.w	a5,a5
ffffffffc0208e52:	fec71be3          	bne	a4,a2,ffffffffc0208e48 <bitmap_create+0x84>
ffffffffc0208e56:	c11c                	sw	a5,0(a0)
ffffffffc0208e58:	70e2                	ld	ra,56(sp)
ffffffffc0208e5a:	7442                	ld	s0,48(sp)
ffffffffc0208e5c:	7902                	ld	s2,32(sp)
ffffffffc0208e5e:	69e2                	ld	s3,24(sp)
ffffffffc0208e60:	6a42                	ld	s4,16(sp)
ffffffffc0208e62:	6aa2                	ld	s5,8(sp)
ffffffffc0208e64:	8526                	mv	a0,s1
ffffffffc0208e66:	74a2                	ld	s1,40(sp)
ffffffffc0208e68:	6121                	addi	sp,sp,64
ffffffffc0208e6a:	8082                	ret
ffffffffc0208e6c:	8526                	mv	a0,s1
ffffffffc0208e6e:	9d0f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208e72:	4481                	li	s1,0
ffffffffc0208e74:	b7d5                	j	ffffffffc0208e58 <bitmap_create+0x94>
ffffffffc0208e76:	00006697          	auipc	a3,0x6
ffffffffc0208e7a:	cba68693          	addi	a3,a3,-838 # ffffffffc020eb30 <dev_node_ops+0x330>
ffffffffc0208e7e:	00003617          	auipc	a2,0x3
ffffffffc0208e82:	a1a60613          	addi	a2,a2,-1510 # ffffffffc020b898 <commands+0x210>
ffffffffc0208e86:	45d5                	li	a1,21
ffffffffc0208e88:	00006517          	auipc	a0,0x6
ffffffffc0208e8c:	c9050513          	addi	a0,a0,-880 # ffffffffc020eb18 <dev_node_ops+0x318>
ffffffffc0208e90:	e0ef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208e94:	00006697          	auipc	a3,0x6
ffffffffc0208e98:	cdc68693          	addi	a3,a3,-804 # ffffffffc020eb70 <dev_node_ops+0x370>
ffffffffc0208e9c:	00003617          	auipc	a2,0x3
ffffffffc0208ea0:	9fc60613          	addi	a2,a2,-1540 # ffffffffc020b898 <commands+0x210>
ffffffffc0208ea4:	02b00593          	li	a1,43
ffffffffc0208ea8:	00006517          	auipc	a0,0x6
ffffffffc0208eac:	c7050513          	addi	a0,a0,-912 # ffffffffc020eb18 <dev_node_ops+0x318>
ffffffffc0208eb0:	deef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208eb4:	00006697          	auipc	a3,0x6
ffffffffc0208eb8:	ca468693          	addi	a3,a3,-860 # ffffffffc020eb58 <dev_node_ops+0x358>
ffffffffc0208ebc:	00003617          	auipc	a2,0x3
ffffffffc0208ec0:	9dc60613          	addi	a2,a2,-1572 # ffffffffc020b898 <commands+0x210>
ffffffffc0208ec4:	02a00593          	li	a1,42
ffffffffc0208ec8:	00006517          	auipc	a0,0x6
ffffffffc0208ecc:	c5050513          	addi	a0,a0,-944 # ffffffffc020eb18 <dev_node_ops+0x318>
ffffffffc0208ed0:	dcef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208ed4 <bitmap_alloc>:
ffffffffc0208ed4:	4150                	lw	a2,4(a0)
ffffffffc0208ed6:	651c                	ld	a5,8(a0)
ffffffffc0208ed8:	c231                	beqz	a2,ffffffffc0208f1c <bitmap_alloc+0x48>
ffffffffc0208eda:	4701                	li	a4,0
ffffffffc0208edc:	a029                	j	ffffffffc0208ee6 <bitmap_alloc+0x12>
ffffffffc0208ede:	2705                	addiw	a4,a4,1
ffffffffc0208ee0:	0791                	addi	a5,a5,4
ffffffffc0208ee2:	02e60d63          	beq	a2,a4,ffffffffc0208f1c <bitmap_alloc+0x48>
ffffffffc0208ee6:	4394                	lw	a3,0(a5)
ffffffffc0208ee8:	dafd                	beqz	a3,ffffffffc0208ede <bitmap_alloc+0xa>
ffffffffc0208eea:	4501                	li	a0,0
ffffffffc0208eec:	4885                	li	a7,1
ffffffffc0208eee:	8e36                	mv	t3,a3
ffffffffc0208ef0:	02000313          	li	t1,32
ffffffffc0208ef4:	a021                	j	ffffffffc0208efc <bitmap_alloc+0x28>
ffffffffc0208ef6:	2505                	addiw	a0,a0,1
ffffffffc0208ef8:	02650463          	beq	a0,t1,ffffffffc0208f20 <bitmap_alloc+0x4c>
ffffffffc0208efc:	00a8983b          	sllw	a6,a7,a0
ffffffffc0208f00:	0106f633          	and	a2,a3,a6
ffffffffc0208f04:	2601                	sext.w	a2,a2
ffffffffc0208f06:	da65                	beqz	a2,ffffffffc0208ef6 <bitmap_alloc+0x22>
ffffffffc0208f08:	010e4833          	xor	a6,t3,a6
ffffffffc0208f0c:	0057171b          	slliw	a4,a4,0x5
ffffffffc0208f10:	9f29                	addw	a4,a4,a0
ffffffffc0208f12:	0107a023          	sw	a6,0(a5)
ffffffffc0208f16:	c198                	sw	a4,0(a1)
ffffffffc0208f18:	4501                	li	a0,0
ffffffffc0208f1a:	8082                	ret
ffffffffc0208f1c:	5571                	li	a0,-4
ffffffffc0208f1e:	8082                	ret
ffffffffc0208f20:	1141                	addi	sp,sp,-16
ffffffffc0208f22:	00004697          	auipc	a3,0x4
ffffffffc0208f26:	9f668693          	addi	a3,a3,-1546 # ffffffffc020c918 <default_pmm_manager+0x598>
ffffffffc0208f2a:	00003617          	auipc	a2,0x3
ffffffffc0208f2e:	96e60613          	addi	a2,a2,-1682 # ffffffffc020b898 <commands+0x210>
ffffffffc0208f32:	04300593          	li	a1,67
ffffffffc0208f36:	00006517          	auipc	a0,0x6
ffffffffc0208f3a:	be250513          	addi	a0,a0,-1054 # ffffffffc020eb18 <dev_node_ops+0x318>
ffffffffc0208f3e:	e406                	sd	ra,8(sp)
ffffffffc0208f40:	d5ef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208f44 <bitmap_test>:
ffffffffc0208f44:	411c                	lw	a5,0(a0)
ffffffffc0208f46:	00f5ff63          	bgeu	a1,a5,ffffffffc0208f64 <bitmap_test+0x20>
ffffffffc0208f4a:	651c                	ld	a5,8(a0)
ffffffffc0208f4c:	0055d71b          	srliw	a4,a1,0x5
ffffffffc0208f50:	070a                	slli	a4,a4,0x2
ffffffffc0208f52:	97ba                	add	a5,a5,a4
ffffffffc0208f54:	4388                	lw	a0,0(a5)
ffffffffc0208f56:	4785                	li	a5,1
ffffffffc0208f58:	00b795bb          	sllw	a1,a5,a1
ffffffffc0208f5c:	8d6d                	and	a0,a0,a1
ffffffffc0208f5e:	1502                	slli	a0,a0,0x20
ffffffffc0208f60:	9101                	srli	a0,a0,0x20
ffffffffc0208f62:	8082                	ret
ffffffffc0208f64:	1141                	addi	sp,sp,-16
ffffffffc0208f66:	e406                	sd	ra,8(sp)
ffffffffc0208f68:	e39ff0ef          	jal	ra,ffffffffc0208da0 <bitmap_translate.part.0>

ffffffffc0208f6c <bitmap_free>:
ffffffffc0208f6c:	411c                	lw	a5,0(a0)
ffffffffc0208f6e:	1141                	addi	sp,sp,-16
ffffffffc0208f70:	e406                	sd	ra,8(sp)
ffffffffc0208f72:	02f5f463          	bgeu	a1,a5,ffffffffc0208f9a <bitmap_free+0x2e>
ffffffffc0208f76:	651c                	ld	a5,8(a0)
ffffffffc0208f78:	0055d71b          	srliw	a4,a1,0x5
ffffffffc0208f7c:	070a                	slli	a4,a4,0x2
ffffffffc0208f7e:	97ba                	add	a5,a5,a4
ffffffffc0208f80:	4398                	lw	a4,0(a5)
ffffffffc0208f82:	4685                	li	a3,1
ffffffffc0208f84:	00b695bb          	sllw	a1,a3,a1
ffffffffc0208f88:	00b776b3          	and	a3,a4,a1
ffffffffc0208f8c:	2681                	sext.w	a3,a3
ffffffffc0208f8e:	ea81                	bnez	a3,ffffffffc0208f9e <bitmap_free+0x32>
ffffffffc0208f90:	60a2                	ld	ra,8(sp)
ffffffffc0208f92:	8f4d                	or	a4,a4,a1
ffffffffc0208f94:	c398                	sw	a4,0(a5)
ffffffffc0208f96:	0141                	addi	sp,sp,16
ffffffffc0208f98:	8082                	ret
ffffffffc0208f9a:	e07ff0ef          	jal	ra,ffffffffc0208da0 <bitmap_translate.part.0>
ffffffffc0208f9e:	00006697          	auipc	a3,0x6
ffffffffc0208fa2:	bfa68693          	addi	a3,a3,-1030 # ffffffffc020eb98 <dev_node_ops+0x398>
ffffffffc0208fa6:	00003617          	auipc	a2,0x3
ffffffffc0208faa:	8f260613          	addi	a2,a2,-1806 # ffffffffc020b898 <commands+0x210>
ffffffffc0208fae:	05f00593          	li	a1,95
ffffffffc0208fb2:	00006517          	auipc	a0,0x6
ffffffffc0208fb6:	b6650513          	addi	a0,a0,-1178 # ffffffffc020eb18 <dev_node_ops+0x318>
ffffffffc0208fba:	ce4f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208fbe <bitmap_destroy>:
ffffffffc0208fbe:	1141                	addi	sp,sp,-16
ffffffffc0208fc0:	e022                	sd	s0,0(sp)
ffffffffc0208fc2:	842a                	mv	s0,a0
ffffffffc0208fc4:	6508                	ld	a0,8(a0)
ffffffffc0208fc6:	e406                	sd	ra,8(sp)
ffffffffc0208fc8:	876f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208fcc:	8522                	mv	a0,s0
ffffffffc0208fce:	6402                	ld	s0,0(sp)
ffffffffc0208fd0:	60a2                	ld	ra,8(sp)
ffffffffc0208fd2:	0141                	addi	sp,sp,16
ffffffffc0208fd4:	86af906f          	j	ffffffffc020203e <kfree>

ffffffffc0208fd8 <bitmap_getdata>:
ffffffffc0208fd8:	c589                	beqz	a1,ffffffffc0208fe2 <bitmap_getdata+0xa>
ffffffffc0208fda:	00456783          	lwu	a5,4(a0)
ffffffffc0208fde:	078a                	slli	a5,a5,0x2
ffffffffc0208fe0:	e19c                	sd	a5,0(a1)
ffffffffc0208fe2:	6508                	ld	a0,8(a0)
ffffffffc0208fe4:	8082                	ret

ffffffffc0208fe6 <sfs_init>:
ffffffffc0208fe6:	1141                	addi	sp,sp,-16
ffffffffc0208fe8:	00006517          	auipc	a0,0x6
ffffffffc0208fec:	a2050513          	addi	a0,a0,-1504 # ffffffffc020ea08 <dev_node_ops+0x208>
ffffffffc0208ff0:	e406                	sd	ra,8(sp)
ffffffffc0208ff2:	554000ef          	jal	ra,ffffffffc0209546 <sfs_mount>
ffffffffc0208ff6:	e501                	bnez	a0,ffffffffc0208ffe <sfs_init+0x18>
ffffffffc0208ff8:	60a2                	ld	ra,8(sp)
ffffffffc0208ffa:	0141                	addi	sp,sp,16
ffffffffc0208ffc:	8082                	ret
ffffffffc0208ffe:	86aa                	mv	a3,a0
ffffffffc0209000:	00006617          	auipc	a2,0x6
ffffffffc0209004:	ba860613          	addi	a2,a2,-1112 # ffffffffc020eba8 <dev_node_ops+0x3a8>
ffffffffc0209008:	45c1                	li	a1,16
ffffffffc020900a:	00006517          	auipc	a0,0x6
ffffffffc020900e:	bbe50513          	addi	a0,a0,-1090 # ffffffffc020ebc8 <dev_node_ops+0x3c8>
ffffffffc0209012:	c8cf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209016 <sfs_unmount>:
ffffffffc0209016:	1141                	addi	sp,sp,-16
ffffffffc0209018:	e406                	sd	ra,8(sp)
ffffffffc020901a:	e022                	sd	s0,0(sp)
ffffffffc020901c:	cd1d                	beqz	a0,ffffffffc020905a <sfs_unmount+0x44>
ffffffffc020901e:	0b052783          	lw	a5,176(a0)
ffffffffc0209022:	842a                	mv	s0,a0
ffffffffc0209024:	eb9d                	bnez	a5,ffffffffc020905a <sfs_unmount+0x44>
ffffffffc0209026:	7158                	ld	a4,160(a0)
ffffffffc0209028:	09850793          	addi	a5,a0,152
ffffffffc020902c:	02f71563          	bne	a4,a5,ffffffffc0209056 <sfs_unmount+0x40>
ffffffffc0209030:	613c                	ld	a5,64(a0)
ffffffffc0209032:	e7a1                	bnez	a5,ffffffffc020907a <sfs_unmount+0x64>
ffffffffc0209034:	7d08                	ld	a0,56(a0)
ffffffffc0209036:	f89ff0ef          	jal	ra,ffffffffc0208fbe <bitmap_destroy>
ffffffffc020903a:	6428                	ld	a0,72(s0)
ffffffffc020903c:	802f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209040:	7448                	ld	a0,168(s0)
ffffffffc0209042:	ffdf80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209046:	8522                	mv	a0,s0
ffffffffc0209048:	ff7f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020904c:	4501                	li	a0,0
ffffffffc020904e:	60a2                	ld	ra,8(sp)
ffffffffc0209050:	6402                	ld	s0,0(sp)
ffffffffc0209052:	0141                	addi	sp,sp,16
ffffffffc0209054:	8082                	ret
ffffffffc0209056:	5545                	li	a0,-15
ffffffffc0209058:	bfdd                	j	ffffffffc020904e <sfs_unmount+0x38>
ffffffffc020905a:	00006697          	auipc	a3,0x6
ffffffffc020905e:	b8668693          	addi	a3,a3,-1146 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc0209062:	00003617          	auipc	a2,0x3
ffffffffc0209066:	83660613          	addi	a2,a2,-1994 # ffffffffc020b898 <commands+0x210>
ffffffffc020906a:	04100593          	li	a1,65
ffffffffc020906e:	00006517          	auipc	a0,0x6
ffffffffc0209072:	ba250513          	addi	a0,a0,-1118 # ffffffffc020ec10 <dev_node_ops+0x410>
ffffffffc0209076:	c28f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020907a:	00006697          	auipc	a3,0x6
ffffffffc020907e:	bae68693          	addi	a3,a3,-1106 # ffffffffc020ec28 <dev_node_ops+0x428>
ffffffffc0209082:	00003617          	auipc	a2,0x3
ffffffffc0209086:	81660613          	addi	a2,a2,-2026 # ffffffffc020b898 <commands+0x210>
ffffffffc020908a:	04500593          	li	a1,69
ffffffffc020908e:	00006517          	auipc	a0,0x6
ffffffffc0209092:	b8250513          	addi	a0,a0,-1150 # ffffffffc020ec10 <dev_node_ops+0x410>
ffffffffc0209096:	c08f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020909a <sfs_cleanup>:
ffffffffc020909a:	1101                	addi	sp,sp,-32
ffffffffc020909c:	ec06                	sd	ra,24(sp)
ffffffffc020909e:	e822                	sd	s0,16(sp)
ffffffffc02090a0:	e426                	sd	s1,8(sp)
ffffffffc02090a2:	e04a                	sd	s2,0(sp)
ffffffffc02090a4:	c525                	beqz	a0,ffffffffc020910c <sfs_cleanup+0x72>
ffffffffc02090a6:	0b052783          	lw	a5,176(a0)
ffffffffc02090aa:	84aa                	mv	s1,a0
ffffffffc02090ac:	e3a5                	bnez	a5,ffffffffc020910c <sfs_cleanup+0x72>
ffffffffc02090ae:	4158                	lw	a4,4(a0)
ffffffffc02090b0:	4514                	lw	a3,8(a0)
ffffffffc02090b2:	00c50913          	addi	s2,a0,12
ffffffffc02090b6:	85ca                	mv	a1,s2
ffffffffc02090b8:	40d7063b          	subw	a2,a4,a3
ffffffffc02090bc:	00006517          	auipc	a0,0x6
ffffffffc02090c0:	b8450513          	addi	a0,a0,-1148 # ffffffffc020ec40 <dev_node_ops+0x440>
ffffffffc02090c4:	8e2f70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02090c8:	02000413          	li	s0,32
ffffffffc02090cc:	a019                	j	ffffffffc02090d2 <sfs_cleanup+0x38>
ffffffffc02090ce:	347d                	addiw	s0,s0,-1
ffffffffc02090d0:	c819                	beqz	s0,ffffffffc02090e6 <sfs_cleanup+0x4c>
ffffffffc02090d2:	7cdc                	ld	a5,184(s1)
ffffffffc02090d4:	8526                	mv	a0,s1
ffffffffc02090d6:	9782                	jalr	a5
ffffffffc02090d8:	f97d                	bnez	a0,ffffffffc02090ce <sfs_cleanup+0x34>
ffffffffc02090da:	60e2                	ld	ra,24(sp)
ffffffffc02090dc:	6442                	ld	s0,16(sp)
ffffffffc02090de:	64a2                	ld	s1,8(sp)
ffffffffc02090e0:	6902                	ld	s2,0(sp)
ffffffffc02090e2:	6105                	addi	sp,sp,32
ffffffffc02090e4:	8082                	ret
ffffffffc02090e6:	6442                	ld	s0,16(sp)
ffffffffc02090e8:	60e2                	ld	ra,24(sp)
ffffffffc02090ea:	64a2                	ld	s1,8(sp)
ffffffffc02090ec:	86ca                	mv	a3,s2
ffffffffc02090ee:	6902                	ld	s2,0(sp)
ffffffffc02090f0:	872a                	mv	a4,a0
ffffffffc02090f2:	00006617          	auipc	a2,0x6
ffffffffc02090f6:	b6e60613          	addi	a2,a2,-1170 # ffffffffc020ec60 <dev_node_ops+0x460>
ffffffffc02090fa:	05f00593          	li	a1,95
ffffffffc02090fe:	00006517          	auipc	a0,0x6
ffffffffc0209102:	b1250513          	addi	a0,a0,-1262 # ffffffffc020ec10 <dev_node_ops+0x410>
ffffffffc0209106:	6105                	addi	sp,sp,32
ffffffffc0209108:	bfef706f          	j	ffffffffc0200506 <__warn>
ffffffffc020910c:	00006697          	auipc	a3,0x6
ffffffffc0209110:	ad468693          	addi	a3,a3,-1324 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc0209114:	00002617          	auipc	a2,0x2
ffffffffc0209118:	78460613          	addi	a2,a2,1924 # ffffffffc020b898 <commands+0x210>
ffffffffc020911c:	05400593          	li	a1,84
ffffffffc0209120:	00006517          	auipc	a0,0x6
ffffffffc0209124:	af050513          	addi	a0,a0,-1296 # ffffffffc020ec10 <dev_node_ops+0x410>
ffffffffc0209128:	b76f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020912c <sfs_sync>:
ffffffffc020912c:	7179                	addi	sp,sp,-48
ffffffffc020912e:	f406                	sd	ra,40(sp)
ffffffffc0209130:	f022                	sd	s0,32(sp)
ffffffffc0209132:	ec26                	sd	s1,24(sp)
ffffffffc0209134:	e84a                	sd	s2,16(sp)
ffffffffc0209136:	e44e                	sd	s3,8(sp)
ffffffffc0209138:	e052                	sd	s4,0(sp)
ffffffffc020913a:	cd4d                	beqz	a0,ffffffffc02091f4 <sfs_sync+0xc8>
ffffffffc020913c:	0b052783          	lw	a5,176(a0)
ffffffffc0209140:	8a2a                	mv	s4,a0
ffffffffc0209142:	ebcd                	bnez	a5,ffffffffc02091f4 <sfs_sync+0xc8>
ffffffffc0209144:	51f010ef          	jal	ra,ffffffffc020ae62 <lock_sfs_fs>
ffffffffc0209148:	0a0a3403          	ld	s0,160(s4)
ffffffffc020914c:	098a0913          	addi	s2,s4,152
ffffffffc0209150:	02890763          	beq	s2,s0,ffffffffc020917e <sfs_sync+0x52>
ffffffffc0209154:	00004997          	auipc	s3,0x4
ffffffffc0209158:	0cc98993          	addi	s3,s3,204 # ffffffffc020d220 <default_pmm_manager+0xea0>
ffffffffc020915c:	7c1c                	ld	a5,56(s0)
ffffffffc020915e:	fc840493          	addi	s1,s0,-56
ffffffffc0209162:	cbb5                	beqz	a5,ffffffffc02091d6 <sfs_sync+0xaa>
ffffffffc0209164:	7b9c                	ld	a5,48(a5)
ffffffffc0209166:	cba5                	beqz	a5,ffffffffc02091d6 <sfs_sync+0xaa>
ffffffffc0209168:	85ce                	mv	a1,s3
ffffffffc020916a:	8526                	mv	a0,s1
ffffffffc020916c:	e28fe0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0209170:	7c1c                	ld	a5,56(s0)
ffffffffc0209172:	8526                	mv	a0,s1
ffffffffc0209174:	7b9c                	ld	a5,48(a5)
ffffffffc0209176:	9782                	jalr	a5
ffffffffc0209178:	6400                	ld	s0,8(s0)
ffffffffc020917a:	fe8911e3          	bne	s2,s0,ffffffffc020915c <sfs_sync+0x30>
ffffffffc020917e:	8552                	mv	a0,s4
ffffffffc0209180:	4f3010ef          	jal	ra,ffffffffc020ae72 <unlock_sfs_fs>
ffffffffc0209184:	040a3783          	ld	a5,64(s4)
ffffffffc0209188:	4501                	li	a0,0
ffffffffc020918a:	eb89                	bnez	a5,ffffffffc020919c <sfs_sync+0x70>
ffffffffc020918c:	70a2                	ld	ra,40(sp)
ffffffffc020918e:	7402                	ld	s0,32(sp)
ffffffffc0209190:	64e2                	ld	s1,24(sp)
ffffffffc0209192:	6942                	ld	s2,16(sp)
ffffffffc0209194:	69a2                	ld	s3,8(sp)
ffffffffc0209196:	6a02                	ld	s4,0(sp)
ffffffffc0209198:	6145                	addi	sp,sp,48
ffffffffc020919a:	8082                	ret
ffffffffc020919c:	040a3023          	sd	zero,64(s4)
ffffffffc02091a0:	8552                	mv	a0,s4
ffffffffc02091a2:	3a5010ef          	jal	ra,ffffffffc020ad46 <sfs_sync_super>
ffffffffc02091a6:	cd01                	beqz	a0,ffffffffc02091be <sfs_sync+0x92>
ffffffffc02091a8:	70a2                	ld	ra,40(sp)
ffffffffc02091aa:	7402                	ld	s0,32(sp)
ffffffffc02091ac:	4785                	li	a5,1
ffffffffc02091ae:	04fa3023          	sd	a5,64(s4)
ffffffffc02091b2:	64e2                	ld	s1,24(sp)
ffffffffc02091b4:	6942                	ld	s2,16(sp)
ffffffffc02091b6:	69a2                	ld	s3,8(sp)
ffffffffc02091b8:	6a02                	ld	s4,0(sp)
ffffffffc02091ba:	6145                	addi	sp,sp,48
ffffffffc02091bc:	8082                	ret
ffffffffc02091be:	8552                	mv	a0,s4
ffffffffc02091c0:	3cd010ef          	jal	ra,ffffffffc020ad8c <sfs_sync_freemap>
ffffffffc02091c4:	f175                	bnez	a0,ffffffffc02091a8 <sfs_sync+0x7c>
ffffffffc02091c6:	70a2                	ld	ra,40(sp)
ffffffffc02091c8:	7402                	ld	s0,32(sp)
ffffffffc02091ca:	64e2                	ld	s1,24(sp)
ffffffffc02091cc:	6942                	ld	s2,16(sp)
ffffffffc02091ce:	69a2                	ld	s3,8(sp)
ffffffffc02091d0:	6a02                	ld	s4,0(sp)
ffffffffc02091d2:	6145                	addi	sp,sp,48
ffffffffc02091d4:	8082                	ret
ffffffffc02091d6:	00004697          	auipc	a3,0x4
ffffffffc02091da:	ffa68693          	addi	a3,a3,-6 # ffffffffc020d1d0 <default_pmm_manager+0xe50>
ffffffffc02091de:	00002617          	auipc	a2,0x2
ffffffffc02091e2:	6ba60613          	addi	a2,a2,1722 # ffffffffc020b898 <commands+0x210>
ffffffffc02091e6:	45ed                	li	a1,27
ffffffffc02091e8:	00006517          	auipc	a0,0x6
ffffffffc02091ec:	a2850513          	addi	a0,a0,-1496 # ffffffffc020ec10 <dev_node_ops+0x410>
ffffffffc02091f0:	aaef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02091f4:	00006697          	auipc	a3,0x6
ffffffffc02091f8:	9ec68693          	addi	a3,a3,-1556 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc02091fc:	00002617          	auipc	a2,0x2
ffffffffc0209200:	69c60613          	addi	a2,a2,1692 # ffffffffc020b898 <commands+0x210>
ffffffffc0209204:	45d5                	li	a1,21
ffffffffc0209206:	00006517          	auipc	a0,0x6
ffffffffc020920a:	a0a50513          	addi	a0,a0,-1526 # ffffffffc020ec10 <dev_node_ops+0x410>
ffffffffc020920e:	a90f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209212 <sfs_get_root>:
ffffffffc0209212:	1101                	addi	sp,sp,-32
ffffffffc0209214:	ec06                	sd	ra,24(sp)
ffffffffc0209216:	cd09                	beqz	a0,ffffffffc0209230 <sfs_get_root+0x1e>
ffffffffc0209218:	0b052783          	lw	a5,176(a0)
ffffffffc020921c:	eb91                	bnez	a5,ffffffffc0209230 <sfs_get_root+0x1e>
ffffffffc020921e:	4605                	li	a2,1
ffffffffc0209220:	002c                	addi	a1,sp,8
ffffffffc0209222:	356010ef          	jal	ra,ffffffffc020a578 <sfs_load_inode>
ffffffffc0209226:	e50d                	bnez	a0,ffffffffc0209250 <sfs_get_root+0x3e>
ffffffffc0209228:	60e2                	ld	ra,24(sp)
ffffffffc020922a:	6522                	ld	a0,8(sp)
ffffffffc020922c:	6105                	addi	sp,sp,32
ffffffffc020922e:	8082                	ret
ffffffffc0209230:	00006697          	auipc	a3,0x6
ffffffffc0209234:	9b068693          	addi	a3,a3,-1616 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc0209238:	00002617          	auipc	a2,0x2
ffffffffc020923c:	66060613          	addi	a2,a2,1632 # ffffffffc020b898 <commands+0x210>
ffffffffc0209240:	03600593          	li	a1,54
ffffffffc0209244:	00006517          	auipc	a0,0x6
ffffffffc0209248:	9cc50513          	addi	a0,a0,-1588 # ffffffffc020ec10 <dev_node_ops+0x410>
ffffffffc020924c:	a52f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209250:	86aa                	mv	a3,a0
ffffffffc0209252:	00006617          	auipc	a2,0x6
ffffffffc0209256:	a2e60613          	addi	a2,a2,-1490 # ffffffffc020ec80 <dev_node_ops+0x480>
ffffffffc020925a:	03700593          	li	a1,55
ffffffffc020925e:	00006517          	auipc	a0,0x6
ffffffffc0209262:	9b250513          	addi	a0,a0,-1614 # ffffffffc020ec10 <dev_node_ops+0x410>
ffffffffc0209266:	a38f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020926a <sfs_do_mount>:
ffffffffc020926a:	6518                	ld	a4,8(a0)
ffffffffc020926c:	7171                	addi	sp,sp,-176
ffffffffc020926e:	f506                	sd	ra,168(sp)
ffffffffc0209270:	f122                	sd	s0,160(sp)
ffffffffc0209272:	ed26                	sd	s1,152(sp)
ffffffffc0209274:	e94a                	sd	s2,144(sp)
ffffffffc0209276:	e54e                	sd	s3,136(sp)
ffffffffc0209278:	e152                	sd	s4,128(sp)
ffffffffc020927a:	fcd6                	sd	s5,120(sp)
ffffffffc020927c:	f8da                	sd	s6,112(sp)
ffffffffc020927e:	f4de                	sd	s7,104(sp)
ffffffffc0209280:	f0e2                	sd	s8,96(sp)
ffffffffc0209282:	ece6                	sd	s9,88(sp)
ffffffffc0209284:	e8ea                	sd	s10,80(sp)
ffffffffc0209286:	e4ee                	sd	s11,72(sp)
ffffffffc0209288:	6785                	lui	a5,0x1
ffffffffc020928a:	24f71663          	bne	a4,a5,ffffffffc02094d6 <sfs_do_mount+0x26c>
ffffffffc020928e:	892a                	mv	s2,a0
ffffffffc0209290:	4501                	li	a0,0
ffffffffc0209292:	8aae                	mv	s5,a1
ffffffffc0209294:	f00fe0ef          	jal	ra,ffffffffc0207994 <__alloc_fs>
ffffffffc0209298:	842a                	mv	s0,a0
ffffffffc020929a:	24050463          	beqz	a0,ffffffffc02094e2 <sfs_do_mount+0x278>
ffffffffc020929e:	0b052b03          	lw	s6,176(a0)
ffffffffc02092a2:	260b1263          	bnez	s6,ffffffffc0209506 <sfs_do_mount+0x29c>
ffffffffc02092a6:	03253823          	sd	s2,48(a0)
ffffffffc02092aa:	6505                	lui	a0,0x1
ffffffffc02092ac:	ce3f80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02092b0:	e428                	sd	a0,72(s0)
ffffffffc02092b2:	84aa                	mv	s1,a0
ffffffffc02092b4:	16050363          	beqz	a0,ffffffffc020941a <sfs_do_mount+0x1b0>
ffffffffc02092b8:	85aa                	mv	a1,a0
ffffffffc02092ba:	4681                	li	a3,0
ffffffffc02092bc:	6605                	lui	a2,0x1
ffffffffc02092be:	1008                	addi	a0,sp,32
ffffffffc02092c0:	922fc0ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc02092c4:	02093783          	ld	a5,32(s2)
ffffffffc02092c8:	85aa                	mv	a1,a0
ffffffffc02092ca:	4601                	li	a2,0
ffffffffc02092cc:	854a                	mv	a0,s2
ffffffffc02092ce:	9782                	jalr	a5
ffffffffc02092d0:	8a2a                	mv	s4,a0
ffffffffc02092d2:	10051e63          	bnez	a0,ffffffffc02093ee <sfs_do_mount+0x184>
ffffffffc02092d6:	408c                	lw	a1,0(s1)
ffffffffc02092d8:	2f8dc637          	lui	a2,0x2f8dc
ffffffffc02092dc:	e2a60613          	addi	a2,a2,-470 # 2f8dbe2a <_binary_bin_sfs_img_size+0x2f866b2a>
ffffffffc02092e0:	14c59863          	bne	a1,a2,ffffffffc0209430 <sfs_do_mount+0x1c6>
ffffffffc02092e4:	40dc                	lw	a5,4(s1)
ffffffffc02092e6:	00093603          	ld	a2,0(s2)
ffffffffc02092ea:	02079713          	slli	a4,a5,0x20
ffffffffc02092ee:	9301                	srli	a4,a4,0x20
ffffffffc02092f0:	12e66763          	bltu	a2,a4,ffffffffc020941e <sfs_do_mount+0x1b4>
ffffffffc02092f4:	020485a3          	sb	zero,43(s1)
ffffffffc02092f8:	0084af03          	lw	t5,8(s1)
ffffffffc02092fc:	00c4ae83          	lw	t4,12(s1)
ffffffffc0209300:	0104ae03          	lw	t3,16(s1)
ffffffffc0209304:	0144a303          	lw	t1,20(s1)
ffffffffc0209308:	0184a883          	lw	a7,24(s1)
ffffffffc020930c:	01c4a803          	lw	a6,28(s1)
ffffffffc0209310:	5090                	lw	a2,32(s1)
ffffffffc0209312:	50d4                	lw	a3,36(s1)
ffffffffc0209314:	5498                	lw	a4,40(s1)
ffffffffc0209316:	6511                	lui	a0,0x4
ffffffffc0209318:	c00c                	sw	a1,0(s0)
ffffffffc020931a:	c05c                	sw	a5,4(s0)
ffffffffc020931c:	01e42423          	sw	t5,8(s0)
ffffffffc0209320:	01d42623          	sw	t4,12(s0)
ffffffffc0209324:	01c42823          	sw	t3,16(s0)
ffffffffc0209328:	00642a23          	sw	t1,20(s0)
ffffffffc020932c:	01142c23          	sw	a7,24(s0)
ffffffffc0209330:	01042e23          	sw	a6,28(s0)
ffffffffc0209334:	d010                	sw	a2,32(s0)
ffffffffc0209336:	d054                	sw	a3,36(s0)
ffffffffc0209338:	d418                	sw	a4,40(s0)
ffffffffc020933a:	c55f80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020933e:	f448                	sd	a0,168(s0)
ffffffffc0209340:	8c2a                	mv	s8,a0
ffffffffc0209342:	18050c63          	beqz	a0,ffffffffc02094da <sfs_do_mount+0x270>
ffffffffc0209346:	6711                	lui	a4,0x4
ffffffffc0209348:	87aa                	mv	a5,a0
ffffffffc020934a:	972a                	add	a4,a4,a0
ffffffffc020934c:	e79c                	sd	a5,8(a5)
ffffffffc020934e:	e39c                	sd	a5,0(a5)
ffffffffc0209350:	07c1                	addi	a5,a5,16
ffffffffc0209352:	fee79de3          	bne	a5,a4,ffffffffc020934c <sfs_do_mount+0xe2>
ffffffffc0209356:	0044eb83          	lwu	s7,4(s1)
ffffffffc020935a:	67a1                	lui	a5,0x8
ffffffffc020935c:	fff78993          	addi	s3,a5,-1 # 7fff <_binary_bin_swap_img_size+0x2ff>
ffffffffc0209360:	9bce                	add	s7,s7,s3
ffffffffc0209362:	77e1                	lui	a5,0xffff8
ffffffffc0209364:	00fbfbb3          	and	s7,s7,a5
ffffffffc0209368:	2b81                	sext.w	s7,s7
ffffffffc020936a:	855e                	mv	a0,s7
ffffffffc020936c:	a59ff0ef          	jal	ra,ffffffffc0208dc4 <bitmap_create>
ffffffffc0209370:	fc08                	sd	a0,56(s0)
ffffffffc0209372:	8d2a                	mv	s10,a0
ffffffffc0209374:	14050f63          	beqz	a0,ffffffffc02094d2 <sfs_do_mount+0x268>
ffffffffc0209378:	0044e783          	lwu	a5,4(s1)
ffffffffc020937c:	082c                	addi	a1,sp,24
ffffffffc020937e:	97ce                	add	a5,a5,s3
ffffffffc0209380:	00f7d713          	srli	a4,a5,0xf
ffffffffc0209384:	e43a                	sd	a4,8(sp)
ffffffffc0209386:	40f7d993          	srai	s3,a5,0xf
ffffffffc020938a:	c4fff0ef          	jal	ra,ffffffffc0208fd8 <bitmap_getdata>
ffffffffc020938e:	14050c63          	beqz	a0,ffffffffc02094e6 <sfs_do_mount+0x27c>
ffffffffc0209392:	00c9979b          	slliw	a5,s3,0xc
ffffffffc0209396:	66e2                	ld	a3,24(sp)
ffffffffc0209398:	1782                	slli	a5,a5,0x20
ffffffffc020939a:	9381                	srli	a5,a5,0x20
ffffffffc020939c:	14d79563          	bne	a5,a3,ffffffffc02094e6 <sfs_do_mount+0x27c>
ffffffffc02093a0:	6722                	ld	a4,8(sp)
ffffffffc02093a2:	6d89                	lui	s11,0x2
ffffffffc02093a4:	89aa                	mv	s3,a0
ffffffffc02093a6:	00c71c93          	slli	s9,a4,0xc
ffffffffc02093aa:	9caa                	add	s9,s9,a0
ffffffffc02093ac:	40ad8dbb          	subw	s11,s11,a0
ffffffffc02093b0:	e711                	bnez	a4,ffffffffc02093bc <sfs_do_mount+0x152>
ffffffffc02093b2:	a079                	j	ffffffffc0209440 <sfs_do_mount+0x1d6>
ffffffffc02093b4:	6785                	lui	a5,0x1
ffffffffc02093b6:	99be                	add	s3,s3,a5
ffffffffc02093b8:	093c8463          	beq	s9,s3,ffffffffc0209440 <sfs_do_mount+0x1d6>
ffffffffc02093bc:	013d86bb          	addw	a3,s11,s3
ffffffffc02093c0:	1682                	slli	a3,a3,0x20
ffffffffc02093c2:	6605                	lui	a2,0x1
ffffffffc02093c4:	85ce                	mv	a1,s3
ffffffffc02093c6:	9281                	srli	a3,a3,0x20
ffffffffc02093c8:	1008                	addi	a0,sp,32
ffffffffc02093ca:	818fc0ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc02093ce:	02093783          	ld	a5,32(s2)
ffffffffc02093d2:	85aa                	mv	a1,a0
ffffffffc02093d4:	4601                	li	a2,0
ffffffffc02093d6:	854a                	mv	a0,s2
ffffffffc02093d8:	9782                	jalr	a5
ffffffffc02093da:	dd69                	beqz	a0,ffffffffc02093b4 <sfs_do_mount+0x14a>
ffffffffc02093dc:	e42a                	sd	a0,8(sp)
ffffffffc02093de:	856a                	mv	a0,s10
ffffffffc02093e0:	bdfff0ef          	jal	ra,ffffffffc0208fbe <bitmap_destroy>
ffffffffc02093e4:	67a2                	ld	a5,8(sp)
ffffffffc02093e6:	8a3e                	mv	s4,a5
ffffffffc02093e8:	8562                	mv	a0,s8
ffffffffc02093ea:	c55f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02093ee:	8526                	mv	a0,s1
ffffffffc02093f0:	c4ff80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02093f4:	8522                	mv	a0,s0
ffffffffc02093f6:	c49f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02093fa:	70aa                	ld	ra,168(sp)
ffffffffc02093fc:	740a                	ld	s0,160(sp)
ffffffffc02093fe:	64ea                	ld	s1,152(sp)
ffffffffc0209400:	694a                	ld	s2,144(sp)
ffffffffc0209402:	69aa                	ld	s3,136(sp)
ffffffffc0209404:	7ae6                	ld	s5,120(sp)
ffffffffc0209406:	7b46                	ld	s6,112(sp)
ffffffffc0209408:	7ba6                	ld	s7,104(sp)
ffffffffc020940a:	7c06                	ld	s8,96(sp)
ffffffffc020940c:	6ce6                	ld	s9,88(sp)
ffffffffc020940e:	6d46                	ld	s10,80(sp)
ffffffffc0209410:	6da6                	ld	s11,72(sp)
ffffffffc0209412:	8552                	mv	a0,s4
ffffffffc0209414:	6a0a                	ld	s4,128(sp)
ffffffffc0209416:	614d                	addi	sp,sp,176
ffffffffc0209418:	8082                	ret
ffffffffc020941a:	5a71                	li	s4,-4
ffffffffc020941c:	bfe1                	j	ffffffffc02093f4 <sfs_do_mount+0x18a>
ffffffffc020941e:	85be                	mv	a1,a5
ffffffffc0209420:	00006517          	auipc	a0,0x6
ffffffffc0209424:	8b850513          	addi	a0,a0,-1864 # ffffffffc020ecd8 <dev_node_ops+0x4d8>
ffffffffc0209428:	d7ff60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020942c:	5a75                	li	s4,-3
ffffffffc020942e:	b7c1                	j	ffffffffc02093ee <sfs_do_mount+0x184>
ffffffffc0209430:	00006517          	auipc	a0,0x6
ffffffffc0209434:	87050513          	addi	a0,a0,-1936 # ffffffffc020eca0 <dev_node_ops+0x4a0>
ffffffffc0209438:	d6ff60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020943c:	5a75                	li	s4,-3
ffffffffc020943e:	bf45                	j	ffffffffc02093ee <sfs_do_mount+0x184>
ffffffffc0209440:	00442903          	lw	s2,4(s0)
ffffffffc0209444:	4481                	li	s1,0
ffffffffc0209446:	080b8c63          	beqz	s7,ffffffffc02094de <sfs_do_mount+0x274>
ffffffffc020944a:	85a6                	mv	a1,s1
ffffffffc020944c:	856a                	mv	a0,s10
ffffffffc020944e:	af7ff0ef          	jal	ra,ffffffffc0208f44 <bitmap_test>
ffffffffc0209452:	c111                	beqz	a0,ffffffffc0209456 <sfs_do_mount+0x1ec>
ffffffffc0209454:	2b05                	addiw	s6,s6,1
ffffffffc0209456:	2485                	addiw	s1,s1,1
ffffffffc0209458:	fe9b99e3          	bne	s7,s1,ffffffffc020944a <sfs_do_mount+0x1e0>
ffffffffc020945c:	441c                	lw	a5,8(s0)
ffffffffc020945e:	0d679463          	bne	a5,s6,ffffffffc0209526 <sfs_do_mount+0x2bc>
ffffffffc0209462:	4585                	li	a1,1
ffffffffc0209464:	05040513          	addi	a0,s0,80
ffffffffc0209468:	04043023          	sd	zero,64(s0)
ffffffffc020946c:	8eefb0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc0209470:	4585                	li	a1,1
ffffffffc0209472:	06840513          	addi	a0,s0,104
ffffffffc0209476:	8e4fb0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc020947a:	4585                	li	a1,1
ffffffffc020947c:	08040513          	addi	a0,s0,128
ffffffffc0209480:	8dafb0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc0209484:	09840793          	addi	a5,s0,152
ffffffffc0209488:	f05c                	sd	a5,160(s0)
ffffffffc020948a:	ec5c                	sd	a5,152(s0)
ffffffffc020948c:	874a                	mv	a4,s2
ffffffffc020948e:	86da                	mv	a3,s6
ffffffffc0209490:	4169063b          	subw	a2,s2,s6
ffffffffc0209494:	00c40593          	addi	a1,s0,12
ffffffffc0209498:	00006517          	auipc	a0,0x6
ffffffffc020949c:	8d050513          	addi	a0,a0,-1840 # ffffffffc020ed68 <dev_node_ops+0x568>
ffffffffc02094a0:	d07f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02094a4:	00000797          	auipc	a5,0x0
ffffffffc02094a8:	c8878793          	addi	a5,a5,-888 # ffffffffc020912c <sfs_sync>
ffffffffc02094ac:	fc5c                	sd	a5,184(s0)
ffffffffc02094ae:	00000797          	auipc	a5,0x0
ffffffffc02094b2:	d6478793          	addi	a5,a5,-668 # ffffffffc0209212 <sfs_get_root>
ffffffffc02094b6:	e07c                	sd	a5,192(s0)
ffffffffc02094b8:	00000797          	auipc	a5,0x0
ffffffffc02094bc:	b5e78793          	addi	a5,a5,-1186 # ffffffffc0209016 <sfs_unmount>
ffffffffc02094c0:	e47c                	sd	a5,200(s0)
ffffffffc02094c2:	00000797          	auipc	a5,0x0
ffffffffc02094c6:	bd878793          	addi	a5,a5,-1064 # ffffffffc020909a <sfs_cleanup>
ffffffffc02094ca:	e87c                	sd	a5,208(s0)
ffffffffc02094cc:	008ab023          	sd	s0,0(s5)
ffffffffc02094d0:	b72d                	j	ffffffffc02093fa <sfs_do_mount+0x190>
ffffffffc02094d2:	5a71                	li	s4,-4
ffffffffc02094d4:	bf11                	j	ffffffffc02093e8 <sfs_do_mount+0x17e>
ffffffffc02094d6:	5a49                	li	s4,-14
ffffffffc02094d8:	b70d                	j	ffffffffc02093fa <sfs_do_mount+0x190>
ffffffffc02094da:	5a71                	li	s4,-4
ffffffffc02094dc:	bf09                	j	ffffffffc02093ee <sfs_do_mount+0x184>
ffffffffc02094de:	4b01                	li	s6,0
ffffffffc02094e0:	bfb5                	j	ffffffffc020945c <sfs_do_mount+0x1f2>
ffffffffc02094e2:	5a71                	li	s4,-4
ffffffffc02094e4:	bf19                	j	ffffffffc02093fa <sfs_do_mount+0x190>
ffffffffc02094e6:	00006697          	auipc	a3,0x6
ffffffffc02094ea:	82268693          	addi	a3,a3,-2014 # ffffffffc020ed08 <dev_node_ops+0x508>
ffffffffc02094ee:	00002617          	auipc	a2,0x2
ffffffffc02094f2:	3aa60613          	addi	a2,a2,938 # ffffffffc020b898 <commands+0x210>
ffffffffc02094f6:	08300593          	li	a1,131
ffffffffc02094fa:	00005517          	auipc	a0,0x5
ffffffffc02094fe:	71650513          	addi	a0,a0,1814 # ffffffffc020ec10 <dev_node_ops+0x410>
ffffffffc0209502:	f9df60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209506:	00005697          	auipc	a3,0x5
ffffffffc020950a:	6da68693          	addi	a3,a3,1754 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc020950e:	00002617          	auipc	a2,0x2
ffffffffc0209512:	38a60613          	addi	a2,a2,906 # ffffffffc020b898 <commands+0x210>
ffffffffc0209516:	0a300593          	li	a1,163
ffffffffc020951a:	00005517          	auipc	a0,0x5
ffffffffc020951e:	6f650513          	addi	a0,a0,1782 # ffffffffc020ec10 <dev_node_ops+0x410>
ffffffffc0209522:	f7df60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209526:	00006697          	auipc	a3,0x6
ffffffffc020952a:	81268693          	addi	a3,a3,-2030 # ffffffffc020ed38 <dev_node_ops+0x538>
ffffffffc020952e:	00002617          	auipc	a2,0x2
ffffffffc0209532:	36a60613          	addi	a2,a2,874 # ffffffffc020b898 <commands+0x210>
ffffffffc0209536:	0e000593          	li	a1,224
ffffffffc020953a:	00005517          	auipc	a0,0x5
ffffffffc020953e:	6d650513          	addi	a0,a0,1750 # ffffffffc020ec10 <dev_node_ops+0x410>
ffffffffc0209542:	f5df60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209546 <sfs_mount>:
ffffffffc0209546:	00000597          	auipc	a1,0x0
ffffffffc020954a:	d2458593          	addi	a1,a1,-732 # ffffffffc020926a <sfs_do_mount>
ffffffffc020954e:	817fe06f          	j	ffffffffc0207d64 <vfs_mount>

ffffffffc0209552 <sfs_opendir>:
ffffffffc0209552:	0235f593          	andi	a1,a1,35
ffffffffc0209556:	4501                	li	a0,0
ffffffffc0209558:	e191                	bnez	a1,ffffffffc020955c <sfs_opendir+0xa>
ffffffffc020955a:	8082                	ret
ffffffffc020955c:	553d                	li	a0,-17
ffffffffc020955e:	8082                	ret

ffffffffc0209560 <sfs_openfile>:
ffffffffc0209560:	4501                	li	a0,0
ffffffffc0209562:	8082                	ret

ffffffffc0209564 <sfs_gettype>:
ffffffffc0209564:	1141                	addi	sp,sp,-16
ffffffffc0209566:	e406                	sd	ra,8(sp)
ffffffffc0209568:	c939                	beqz	a0,ffffffffc02095be <sfs_gettype+0x5a>
ffffffffc020956a:	4d34                	lw	a3,88(a0)
ffffffffc020956c:	6785                	lui	a5,0x1
ffffffffc020956e:	23578713          	addi	a4,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209572:	04e69663          	bne	a3,a4,ffffffffc02095be <sfs_gettype+0x5a>
ffffffffc0209576:	6114                	ld	a3,0(a0)
ffffffffc0209578:	4709                	li	a4,2
ffffffffc020957a:	0046d683          	lhu	a3,4(a3)
ffffffffc020957e:	02e68a63          	beq	a3,a4,ffffffffc02095b2 <sfs_gettype+0x4e>
ffffffffc0209582:	470d                	li	a4,3
ffffffffc0209584:	02e68163          	beq	a3,a4,ffffffffc02095a6 <sfs_gettype+0x42>
ffffffffc0209588:	4705                	li	a4,1
ffffffffc020958a:	00e68f63          	beq	a3,a4,ffffffffc02095a8 <sfs_gettype+0x44>
ffffffffc020958e:	00006617          	auipc	a2,0x6
ffffffffc0209592:	84a60613          	addi	a2,a2,-1974 # ffffffffc020edd8 <dev_node_ops+0x5d8>
ffffffffc0209596:	38b00593          	li	a1,907
ffffffffc020959a:	00006517          	auipc	a0,0x6
ffffffffc020959e:	82650513          	addi	a0,a0,-2010 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc02095a2:	efdf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02095a6:	678d                	lui	a5,0x3
ffffffffc02095a8:	60a2                	ld	ra,8(sp)
ffffffffc02095aa:	c19c                	sw	a5,0(a1)
ffffffffc02095ac:	4501                	li	a0,0
ffffffffc02095ae:	0141                	addi	sp,sp,16
ffffffffc02095b0:	8082                	ret
ffffffffc02095b2:	60a2                	ld	ra,8(sp)
ffffffffc02095b4:	6789                	lui	a5,0x2
ffffffffc02095b6:	c19c                	sw	a5,0(a1)
ffffffffc02095b8:	4501                	li	a0,0
ffffffffc02095ba:	0141                	addi	sp,sp,16
ffffffffc02095bc:	8082                	ret
ffffffffc02095be:	00005697          	auipc	a3,0x5
ffffffffc02095c2:	7ca68693          	addi	a3,a3,1994 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc02095c6:	00002617          	auipc	a2,0x2
ffffffffc02095ca:	2d260613          	addi	a2,a2,722 # ffffffffc020b898 <commands+0x210>
ffffffffc02095ce:	37f00593          	li	a1,895
ffffffffc02095d2:	00005517          	auipc	a0,0x5
ffffffffc02095d6:	7ee50513          	addi	a0,a0,2030 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc02095da:	ec5f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02095de <sfs_fsync>:
ffffffffc02095de:	7179                	addi	sp,sp,-48
ffffffffc02095e0:	ec26                	sd	s1,24(sp)
ffffffffc02095e2:	7524                	ld	s1,104(a0)
ffffffffc02095e4:	f406                	sd	ra,40(sp)
ffffffffc02095e6:	f022                	sd	s0,32(sp)
ffffffffc02095e8:	e84a                	sd	s2,16(sp)
ffffffffc02095ea:	e44e                	sd	s3,8(sp)
ffffffffc02095ec:	c4bd                	beqz	s1,ffffffffc020965a <sfs_fsync+0x7c>
ffffffffc02095ee:	0b04a783          	lw	a5,176(s1)
ffffffffc02095f2:	e7a5                	bnez	a5,ffffffffc020965a <sfs_fsync+0x7c>
ffffffffc02095f4:	4d38                	lw	a4,88(a0)
ffffffffc02095f6:	6785                	lui	a5,0x1
ffffffffc02095f8:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02095fc:	842a                	mv	s0,a0
ffffffffc02095fe:	06f71e63          	bne	a4,a5,ffffffffc020967a <sfs_fsync+0x9c>
ffffffffc0209602:	691c                	ld	a5,16(a0)
ffffffffc0209604:	4901                	li	s2,0
ffffffffc0209606:	eb89                	bnez	a5,ffffffffc0209618 <sfs_fsync+0x3a>
ffffffffc0209608:	70a2                	ld	ra,40(sp)
ffffffffc020960a:	7402                	ld	s0,32(sp)
ffffffffc020960c:	64e2                	ld	s1,24(sp)
ffffffffc020960e:	69a2                	ld	s3,8(sp)
ffffffffc0209610:	854a                	mv	a0,s2
ffffffffc0209612:	6942                	ld	s2,16(sp)
ffffffffc0209614:	6145                	addi	sp,sp,48
ffffffffc0209616:	8082                	ret
ffffffffc0209618:	02050993          	addi	s3,a0,32
ffffffffc020961c:	854e                	mv	a0,s3
ffffffffc020961e:	f47fa0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0209622:	681c                	ld	a5,16(s0)
ffffffffc0209624:	ef81                	bnez	a5,ffffffffc020963c <sfs_fsync+0x5e>
ffffffffc0209626:	854e                	mv	a0,s3
ffffffffc0209628:	f39fa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020962c:	70a2                	ld	ra,40(sp)
ffffffffc020962e:	7402                	ld	s0,32(sp)
ffffffffc0209630:	64e2                	ld	s1,24(sp)
ffffffffc0209632:	69a2                	ld	s3,8(sp)
ffffffffc0209634:	854a                	mv	a0,s2
ffffffffc0209636:	6942                	ld	s2,16(sp)
ffffffffc0209638:	6145                	addi	sp,sp,48
ffffffffc020963a:	8082                	ret
ffffffffc020963c:	4414                	lw	a3,8(s0)
ffffffffc020963e:	600c                	ld	a1,0(s0)
ffffffffc0209640:	00043823          	sd	zero,16(s0)
ffffffffc0209644:	4701                	li	a4,0
ffffffffc0209646:	04000613          	li	a2,64
ffffffffc020964a:	8526                	mv	a0,s1
ffffffffc020964c:	666010ef          	jal	ra,ffffffffc020acb2 <sfs_wbuf>
ffffffffc0209650:	892a                	mv	s2,a0
ffffffffc0209652:	d971                	beqz	a0,ffffffffc0209626 <sfs_fsync+0x48>
ffffffffc0209654:	4785                	li	a5,1
ffffffffc0209656:	e81c                	sd	a5,16(s0)
ffffffffc0209658:	b7f9                	j	ffffffffc0209626 <sfs_fsync+0x48>
ffffffffc020965a:	00005697          	auipc	a3,0x5
ffffffffc020965e:	58668693          	addi	a3,a3,1414 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc0209662:	00002617          	auipc	a2,0x2
ffffffffc0209666:	23660613          	addi	a2,a2,566 # ffffffffc020b898 <commands+0x210>
ffffffffc020966a:	2c300593          	li	a1,707
ffffffffc020966e:	00005517          	auipc	a0,0x5
ffffffffc0209672:	75250513          	addi	a0,a0,1874 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209676:	e29f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020967a:	00005697          	auipc	a3,0x5
ffffffffc020967e:	70e68693          	addi	a3,a3,1806 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc0209682:	00002617          	auipc	a2,0x2
ffffffffc0209686:	21660613          	addi	a2,a2,534 # ffffffffc020b898 <commands+0x210>
ffffffffc020968a:	2c400593          	li	a1,708
ffffffffc020968e:	00005517          	auipc	a0,0x5
ffffffffc0209692:	73250513          	addi	a0,a0,1842 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209696:	e09f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020969a <sfs_fstat>:
ffffffffc020969a:	1101                	addi	sp,sp,-32
ffffffffc020969c:	e426                	sd	s1,8(sp)
ffffffffc020969e:	84ae                	mv	s1,a1
ffffffffc02096a0:	e822                	sd	s0,16(sp)
ffffffffc02096a2:	02000613          	li	a2,32
ffffffffc02096a6:	842a                	mv	s0,a0
ffffffffc02096a8:	4581                	li	a1,0
ffffffffc02096aa:	8526                	mv	a0,s1
ffffffffc02096ac:	ec06                	sd	ra,24(sp)
ffffffffc02096ae:	509010ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc02096b2:	c439                	beqz	s0,ffffffffc0209700 <sfs_fstat+0x66>
ffffffffc02096b4:	783c                	ld	a5,112(s0)
ffffffffc02096b6:	c7a9                	beqz	a5,ffffffffc0209700 <sfs_fstat+0x66>
ffffffffc02096b8:	6bbc                	ld	a5,80(a5)
ffffffffc02096ba:	c3b9                	beqz	a5,ffffffffc0209700 <sfs_fstat+0x66>
ffffffffc02096bc:	00005597          	auipc	a1,0x5
ffffffffc02096c0:	0bc58593          	addi	a1,a1,188 # ffffffffc020e778 <syscalls+0xdb0>
ffffffffc02096c4:	8522                	mv	a0,s0
ffffffffc02096c6:	8cefe0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc02096ca:	783c                	ld	a5,112(s0)
ffffffffc02096cc:	85a6                	mv	a1,s1
ffffffffc02096ce:	8522                	mv	a0,s0
ffffffffc02096d0:	6bbc                	ld	a5,80(a5)
ffffffffc02096d2:	9782                	jalr	a5
ffffffffc02096d4:	e10d                	bnez	a0,ffffffffc02096f6 <sfs_fstat+0x5c>
ffffffffc02096d6:	4c38                	lw	a4,88(s0)
ffffffffc02096d8:	6785                	lui	a5,0x1
ffffffffc02096da:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02096de:	04f71163          	bne	a4,a5,ffffffffc0209720 <sfs_fstat+0x86>
ffffffffc02096e2:	601c                	ld	a5,0(s0)
ffffffffc02096e4:	0067d683          	lhu	a3,6(a5)
ffffffffc02096e8:	0087e703          	lwu	a4,8(a5)
ffffffffc02096ec:	0007e783          	lwu	a5,0(a5)
ffffffffc02096f0:	e494                	sd	a3,8(s1)
ffffffffc02096f2:	e898                	sd	a4,16(s1)
ffffffffc02096f4:	ec9c                	sd	a5,24(s1)
ffffffffc02096f6:	60e2                	ld	ra,24(sp)
ffffffffc02096f8:	6442                	ld	s0,16(sp)
ffffffffc02096fa:	64a2                	ld	s1,8(sp)
ffffffffc02096fc:	6105                	addi	sp,sp,32
ffffffffc02096fe:	8082                	ret
ffffffffc0209700:	00005697          	auipc	a3,0x5
ffffffffc0209704:	01068693          	addi	a3,a3,16 # ffffffffc020e710 <syscalls+0xd48>
ffffffffc0209708:	00002617          	auipc	a2,0x2
ffffffffc020970c:	19060613          	addi	a2,a2,400 # ffffffffc020b898 <commands+0x210>
ffffffffc0209710:	2b400593          	li	a1,692
ffffffffc0209714:	00005517          	auipc	a0,0x5
ffffffffc0209718:	6ac50513          	addi	a0,a0,1708 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020971c:	d83f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209720:	00005697          	auipc	a3,0x5
ffffffffc0209724:	66868693          	addi	a3,a3,1640 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc0209728:	00002617          	auipc	a2,0x2
ffffffffc020972c:	17060613          	addi	a2,a2,368 # ffffffffc020b898 <commands+0x210>
ffffffffc0209730:	2b700593          	li	a1,695
ffffffffc0209734:	00005517          	auipc	a0,0x5
ffffffffc0209738:	68c50513          	addi	a0,a0,1676 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020973c:	d63f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209740 <sfs_tryseek>:
ffffffffc0209740:	080007b7          	lui	a5,0x8000
ffffffffc0209744:	04f5fd63          	bgeu	a1,a5,ffffffffc020979e <sfs_tryseek+0x5e>
ffffffffc0209748:	1101                	addi	sp,sp,-32
ffffffffc020974a:	e822                	sd	s0,16(sp)
ffffffffc020974c:	ec06                	sd	ra,24(sp)
ffffffffc020974e:	e426                	sd	s1,8(sp)
ffffffffc0209750:	842a                	mv	s0,a0
ffffffffc0209752:	c921                	beqz	a0,ffffffffc02097a2 <sfs_tryseek+0x62>
ffffffffc0209754:	4d38                	lw	a4,88(a0)
ffffffffc0209756:	6785                	lui	a5,0x1
ffffffffc0209758:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020975c:	04f71363          	bne	a4,a5,ffffffffc02097a2 <sfs_tryseek+0x62>
ffffffffc0209760:	611c                	ld	a5,0(a0)
ffffffffc0209762:	84ae                	mv	s1,a1
ffffffffc0209764:	0007e783          	lwu	a5,0(a5)
ffffffffc0209768:	02b7d563          	bge	a5,a1,ffffffffc0209792 <sfs_tryseek+0x52>
ffffffffc020976c:	793c                	ld	a5,112(a0)
ffffffffc020976e:	cbb1                	beqz	a5,ffffffffc02097c2 <sfs_tryseek+0x82>
ffffffffc0209770:	73bc                	ld	a5,96(a5)
ffffffffc0209772:	cba1                	beqz	a5,ffffffffc02097c2 <sfs_tryseek+0x82>
ffffffffc0209774:	00005597          	auipc	a1,0x5
ffffffffc0209778:	ef458593          	addi	a1,a1,-268 # ffffffffc020e668 <syscalls+0xca0>
ffffffffc020977c:	818fe0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0209780:	783c                	ld	a5,112(s0)
ffffffffc0209782:	8522                	mv	a0,s0
ffffffffc0209784:	6442                	ld	s0,16(sp)
ffffffffc0209786:	60e2                	ld	ra,24(sp)
ffffffffc0209788:	73bc                	ld	a5,96(a5)
ffffffffc020978a:	85a6                	mv	a1,s1
ffffffffc020978c:	64a2                	ld	s1,8(sp)
ffffffffc020978e:	6105                	addi	sp,sp,32
ffffffffc0209790:	8782                	jr	a5
ffffffffc0209792:	60e2                	ld	ra,24(sp)
ffffffffc0209794:	6442                	ld	s0,16(sp)
ffffffffc0209796:	64a2                	ld	s1,8(sp)
ffffffffc0209798:	4501                	li	a0,0
ffffffffc020979a:	6105                	addi	sp,sp,32
ffffffffc020979c:	8082                	ret
ffffffffc020979e:	5575                	li	a0,-3
ffffffffc02097a0:	8082                	ret
ffffffffc02097a2:	00005697          	auipc	a3,0x5
ffffffffc02097a6:	5e668693          	addi	a3,a3,1510 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc02097aa:	00002617          	auipc	a2,0x2
ffffffffc02097ae:	0ee60613          	addi	a2,a2,238 # ffffffffc020b898 <commands+0x210>
ffffffffc02097b2:	39600593          	li	a1,918
ffffffffc02097b6:	00005517          	auipc	a0,0x5
ffffffffc02097ba:	60a50513          	addi	a0,a0,1546 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc02097be:	ce1f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097c2:	00005697          	auipc	a3,0x5
ffffffffc02097c6:	e4e68693          	addi	a3,a3,-434 # ffffffffc020e610 <syscalls+0xc48>
ffffffffc02097ca:	00002617          	auipc	a2,0x2
ffffffffc02097ce:	0ce60613          	addi	a2,a2,206 # ffffffffc020b898 <commands+0x210>
ffffffffc02097d2:	39800593          	li	a1,920
ffffffffc02097d6:	00005517          	auipc	a0,0x5
ffffffffc02097da:	5ea50513          	addi	a0,a0,1514 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc02097de:	cc1f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02097e2 <sfs_close>:
ffffffffc02097e2:	1141                	addi	sp,sp,-16
ffffffffc02097e4:	e406                	sd	ra,8(sp)
ffffffffc02097e6:	e022                	sd	s0,0(sp)
ffffffffc02097e8:	c11d                	beqz	a0,ffffffffc020980e <sfs_close+0x2c>
ffffffffc02097ea:	793c                	ld	a5,112(a0)
ffffffffc02097ec:	842a                	mv	s0,a0
ffffffffc02097ee:	c385                	beqz	a5,ffffffffc020980e <sfs_close+0x2c>
ffffffffc02097f0:	7b9c                	ld	a5,48(a5)
ffffffffc02097f2:	cf91                	beqz	a5,ffffffffc020980e <sfs_close+0x2c>
ffffffffc02097f4:	00004597          	auipc	a1,0x4
ffffffffc02097f8:	a2c58593          	addi	a1,a1,-1492 # ffffffffc020d220 <default_pmm_manager+0xea0>
ffffffffc02097fc:	f99fd0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0209800:	783c                	ld	a5,112(s0)
ffffffffc0209802:	8522                	mv	a0,s0
ffffffffc0209804:	6402                	ld	s0,0(sp)
ffffffffc0209806:	60a2                	ld	ra,8(sp)
ffffffffc0209808:	7b9c                	ld	a5,48(a5)
ffffffffc020980a:	0141                	addi	sp,sp,16
ffffffffc020980c:	8782                	jr	a5
ffffffffc020980e:	00004697          	auipc	a3,0x4
ffffffffc0209812:	9c268693          	addi	a3,a3,-1598 # ffffffffc020d1d0 <default_pmm_manager+0xe50>
ffffffffc0209816:	00002617          	auipc	a2,0x2
ffffffffc020981a:	08260613          	addi	a2,a2,130 # ffffffffc020b898 <commands+0x210>
ffffffffc020981e:	21c00593          	li	a1,540
ffffffffc0209822:	00005517          	auipc	a0,0x5
ffffffffc0209826:	59e50513          	addi	a0,a0,1438 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020982a:	c75f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020982e <sfs_io.part.0>:
ffffffffc020982e:	1141                	addi	sp,sp,-16
ffffffffc0209830:	00005697          	auipc	a3,0x5
ffffffffc0209834:	55868693          	addi	a3,a3,1368 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc0209838:	00002617          	auipc	a2,0x2
ffffffffc020983c:	06060613          	addi	a2,a2,96 # ffffffffc020b898 <commands+0x210>
ffffffffc0209840:	29300593          	li	a1,659
ffffffffc0209844:	00005517          	auipc	a0,0x5
ffffffffc0209848:	57c50513          	addi	a0,a0,1404 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020984c:	e406                	sd	ra,8(sp)
ffffffffc020984e:	c51f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209852 <sfs_block_free>:
ffffffffc0209852:	1101                	addi	sp,sp,-32
ffffffffc0209854:	e426                	sd	s1,8(sp)
ffffffffc0209856:	ec06                	sd	ra,24(sp)
ffffffffc0209858:	e822                	sd	s0,16(sp)
ffffffffc020985a:	4154                	lw	a3,4(a0)
ffffffffc020985c:	84ae                	mv	s1,a1
ffffffffc020985e:	c595                	beqz	a1,ffffffffc020988a <sfs_block_free+0x38>
ffffffffc0209860:	02d5f563          	bgeu	a1,a3,ffffffffc020988a <sfs_block_free+0x38>
ffffffffc0209864:	842a                	mv	s0,a0
ffffffffc0209866:	7d08                	ld	a0,56(a0)
ffffffffc0209868:	edcff0ef          	jal	ra,ffffffffc0208f44 <bitmap_test>
ffffffffc020986c:	ed05                	bnez	a0,ffffffffc02098a4 <sfs_block_free+0x52>
ffffffffc020986e:	7c08                	ld	a0,56(s0)
ffffffffc0209870:	85a6                	mv	a1,s1
ffffffffc0209872:	efaff0ef          	jal	ra,ffffffffc0208f6c <bitmap_free>
ffffffffc0209876:	441c                	lw	a5,8(s0)
ffffffffc0209878:	4705                	li	a4,1
ffffffffc020987a:	60e2                	ld	ra,24(sp)
ffffffffc020987c:	2785                	addiw	a5,a5,1
ffffffffc020987e:	e038                	sd	a4,64(s0)
ffffffffc0209880:	c41c                	sw	a5,8(s0)
ffffffffc0209882:	6442                	ld	s0,16(sp)
ffffffffc0209884:	64a2                	ld	s1,8(sp)
ffffffffc0209886:	6105                	addi	sp,sp,32
ffffffffc0209888:	8082                	ret
ffffffffc020988a:	8726                	mv	a4,s1
ffffffffc020988c:	00005617          	auipc	a2,0x5
ffffffffc0209890:	56460613          	addi	a2,a2,1380 # ffffffffc020edf0 <dev_node_ops+0x5f0>
ffffffffc0209894:	05300593          	li	a1,83
ffffffffc0209898:	00005517          	auipc	a0,0x5
ffffffffc020989c:	52850513          	addi	a0,a0,1320 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc02098a0:	bfff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02098a4:	00005697          	auipc	a3,0x5
ffffffffc02098a8:	58468693          	addi	a3,a3,1412 # ffffffffc020ee28 <dev_node_ops+0x628>
ffffffffc02098ac:	00002617          	auipc	a2,0x2
ffffffffc02098b0:	fec60613          	addi	a2,a2,-20 # ffffffffc020b898 <commands+0x210>
ffffffffc02098b4:	06a00593          	li	a1,106
ffffffffc02098b8:	00005517          	auipc	a0,0x5
ffffffffc02098bc:	50850513          	addi	a0,a0,1288 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc02098c0:	bdff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02098c4 <sfs_reclaim>:
ffffffffc02098c4:	1101                	addi	sp,sp,-32
ffffffffc02098c6:	e426                	sd	s1,8(sp)
ffffffffc02098c8:	7524                	ld	s1,104(a0)
ffffffffc02098ca:	ec06                	sd	ra,24(sp)
ffffffffc02098cc:	e822                	sd	s0,16(sp)
ffffffffc02098ce:	e04a                	sd	s2,0(sp)
ffffffffc02098d0:	0e048a63          	beqz	s1,ffffffffc02099c4 <sfs_reclaim+0x100>
ffffffffc02098d4:	0b04a783          	lw	a5,176(s1)
ffffffffc02098d8:	0e079663          	bnez	a5,ffffffffc02099c4 <sfs_reclaim+0x100>
ffffffffc02098dc:	4d38                	lw	a4,88(a0)
ffffffffc02098de:	6785                	lui	a5,0x1
ffffffffc02098e0:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02098e4:	842a                	mv	s0,a0
ffffffffc02098e6:	10f71f63          	bne	a4,a5,ffffffffc0209a04 <sfs_reclaim+0x140>
ffffffffc02098ea:	8526                	mv	a0,s1
ffffffffc02098ec:	576010ef          	jal	ra,ffffffffc020ae62 <lock_sfs_fs>
ffffffffc02098f0:	4c1c                	lw	a5,24(s0)
ffffffffc02098f2:	0ef05963          	blez	a5,ffffffffc02099e4 <sfs_reclaim+0x120>
ffffffffc02098f6:	fff7871b          	addiw	a4,a5,-1
ffffffffc02098fa:	cc18                	sw	a4,24(s0)
ffffffffc02098fc:	eb59                	bnez	a4,ffffffffc0209992 <sfs_reclaim+0xce>
ffffffffc02098fe:	05c42903          	lw	s2,92(s0)
ffffffffc0209902:	08091863          	bnez	s2,ffffffffc0209992 <sfs_reclaim+0xce>
ffffffffc0209906:	601c                	ld	a5,0(s0)
ffffffffc0209908:	0067d783          	lhu	a5,6(a5)
ffffffffc020990c:	e785                	bnez	a5,ffffffffc0209934 <sfs_reclaim+0x70>
ffffffffc020990e:	783c                	ld	a5,112(s0)
ffffffffc0209910:	10078a63          	beqz	a5,ffffffffc0209a24 <sfs_reclaim+0x160>
ffffffffc0209914:	73bc                	ld	a5,96(a5)
ffffffffc0209916:	10078763          	beqz	a5,ffffffffc0209a24 <sfs_reclaim+0x160>
ffffffffc020991a:	00005597          	auipc	a1,0x5
ffffffffc020991e:	d4e58593          	addi	a1,a1,-690 # ffffffffc020e668 <syscalls+0xca0>
ffffffffc0209922:	8522                	mv	a0,s0
ffffffffc0209924:	e71fd0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0209928:	783c                	ld	a5,112(s0)
ffffffffc020992a:	4581                	li	a1,0
ffffffffc020992c:	8522                	mv	a0,s0
ffffffffc020992e:	73bc                	ld	a5,96(a5)
ffffffffc0209930:	9782                	jalr	a5
ffffffffc0209932:	e559                	bnez	a0,ffffffffc02099c0 <sfs_reclaim+0xfc>
ffffffffc0209934:	681c                	ld	a5,16(s0)
ffffffffc0209936:	c39d                	beqz	a5,ffffffffc020995c <sfs_reclaim+0x98>
ffffffffc0209938:	783c                	ld	a5,112(s0)
ffffffffc020993a:	10078563          	beqz	a5,ffffffffc0209a44 <sfs_reclaim+0x180>
ffffffffc020993e:	7b9c                	ld	a5,48(a5)
ffffffffc0209940:	10078263          	beqz	a5,ffffffffc0209a44 <sfs_reclaim+0x180>
ffffffffc0209944:	8522                	mv	a0,s0
ffffffffc0209946:	00004597          	auipc	a1,0x4
ffffffffc020994a:	8da58593          	addi	a1,a1,-1830 # ffffffffc020d220 <default_pmm_manager+0xea0>
ffffffffc020994e:	e47fd0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0209952:	783c                	ld	a5,112(s0)
ffffffffc0209954:	8522                	mv	a0,s0
ffffffffc0209956:	7b9c                	ld	a5,48(a5)
ffffffffc0209958:	9782                	jalr	a5
ffffffffc020995a:	e13d                	bnez	a0,ffffffffc02099c0 <sfs_reclaim+0xfc>
ffffffffc020995c:	7c18                	ld	a4,56(s0)
ffffffffc020995e:	603c                	ld	a5,64(s0)
ffffffffc0209960:	8526                	mv	a0,s1
ffffffffc0209962:	e71c                	sd	a5,8(a4)
ffffffffc0209964:	e398                	sd	a4,0(a5)
ffffffffc0209966:	6438                	ld	a4,72(s0)
ffffffffc0209968:	683c                	ld	a5,80(s0)
ffffffffc020996a:	e71c                	sd	a5,8(a4)
ffffffffc020996c:	e398                	sd	a4,0(a5)
ffffffffc020996e:	504010ef          	jal	ra,ffffffffc020ae72 <unlock_sfs_fs>
ffffffffc0209972:	6008                	ld	a0,0(s0)
ffffffffc0209974:	00655783          	lhu	a5,6(a0)
ffffffffc0209978:	cb85                	beqz	a5,ffffffffc02099a8 <sfs_reclaim+0xe4>
ffffffffc020997a:	ec4f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020997e:	8522                	mv	a0,s0
ffffffffc0209980:	da9fd0ef          	jal	ra,ffffffffc0207728 <inode_kill>
ffffffffc0209984:	60e2                	ld	ra,24(sp)
ffffffffc0209986:	6442                	ld	s0,16(sp)
ffffffffc0209988:	64a2                	ld	s1,8(sp)
ffffffffc020998a:	854a                	mv	a0,s2
ffffffffc020998c:	6902                	ld	s2,0(sp)
ffffffffc020998e:	6105                	addi	sp,sp,32
ffffffffc0209990:	8082                	ret
ffffffffc0209992:	5945                	li	s2,-15
ffffffffc0209994:	8526                	mv	a0,s1
ffffffffc0209996:	4dc010ef          	jal	ra,ffffffffc020ae72 <unlock_sfs_fs>
ffffffffc020999a:	60e2                	ld	ra,24(sp)
ffffffffc020999c:	6442                	ld	s0,16(sp)
ffffffffc020999e:	64a2                	ld	s1,8(sp)
ffffffffc02099a0:	854a                	mv	a0,s2
ffffffffc02099a2:	6902                	ld	s2,0(sp)
ffffffffc02099a4:	6105                	addi	sp,sp,32
ffffffffc02099a6:	8082                	ret
ffffffffc02099a8:	440c                	lw	a1,8(s0)
ffffffffc02099aa:	8526                	mv	a0,s1
ffffffffc02099ac:	ea7ff0ef          	jal	ra,ffffffffc0209852 <sfs_block_free>
ffffffffc02099b0:	6008                	ld	a0,0(s0)
ffffffffc02099b2:	5d4c                	lw	a1,60(a0)
ffffffffc02099b4:	d1f9                	beqz	a1,ffffffffc020997a <sfs_reclaim+0xb6>
ffffffffc02099b6:	8526                	mv	a0,s1
ffffffffc02099b8:	e9bff0ef          	jal	ra,ffffffffc0209852 <sfs_block_free>
ffffffffc02099bc:	6008                	ld	a0,0(s0)
ffffffffc02099be:	bf75                	j	ffffffffc020997a <sfs_reclaim+0xb6>
ffffffffc02099c0:	892a                	mv	s2,a0
ffffffffc02099c2:	bfc9                	j	ffffffffc0209994 <sfs_reclaim+0xd0>
ffffffffc02099c4:	00005697          	auipc	a3,0x5
ffffffffc02099c8:	21c68693          	addi	a3,a3,540 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc02099cc:	00002617          	auipc	a2,0x2
ffffffffc02099d0:	ecc60613          	addi	a2,a2,-308 # ffffffffc020b898 <commands+0x210>
ffffffffc02099d4:	35400593          	li	a1,852
ffffffffc02099d8:	00005517          	auipc	a0,0x5
ffffffffc02099dc:	3e850513          	addi	a0,a0,1000 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc02099e0:	abff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02099e4:	00005697          	auipc	a3,0x5
ffffffffc02099e8:	46468693          	addi	a3,a3,1124 # ffffffffc020ee48 <dev_node_ops+0x648>
ffffffffc02099ec:	00002617          	auipc	a2,0x2
ffffffffc02099f0:	eac60613          	addi	a2,a2,-340 # ffffffffc020b898 <commands+0x210>
ffffffffc02099f4:	35a00593          	li	a1,858
ffffffffc02099f8:	00005517          	auipc	a0,0x5
ffffffffc02099fc:	3c850513          	addi	a0,a0,968 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209a00:	a9ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a04:	00005697          	auipc	a3,0x5
ffffffffc0209a08:	38468693          	addi	a3,a3,900 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc0209a0c:	00002617          	auipc	a2,0x2
ffffffffc0209a10:	e8c60613          	addi	a2,a2,-372 # ffffffffc020b898 <commands+0x210>
ffffffffc0209a14:	35500593          	li	a1,853
ffffffffc0209a18:	00005517          	auipc	a0,0x5
ffffffffc0209a1c:	3a850513          	addi	a0,a0,936 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209a20:	a7ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a24:	00005697          	auipc	a3,0x5
ffffffffc0209a28:	bec68693          	addi	a3,a3,-1044 # ffffffffc020e610 <syscalls+0xc48>
ffffffffc0209a2c:	00002617          	auipc	a2,0x2
ffffffffc0209a30:	e6c60613          	addi	a2,a2,-404 # ffffffffc020b898 <commands+0x210>
ffffffffc0209a34:	35f00593          	li	a1,863
ffffffffc0209a38:	00005517          	auipc	a0,0x5
ffffffffc0209a3c:	38850513          	addi	a0,a0,904 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209a40:	a5ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a44:	00003697          	auipc	a3,0x3
ffffffffc0209a48:	78c68693          	addi	a3,a3,1932 # ffffffffc020d1d0 <default_pmm_manager+0xe50>
ffffffffc0209a4c:	00002617          	auipc	a2,0x2
ffffffffc0209a50:	e4c60613          	addi	a2,a2,-436 # ffffffffc020b898 <commands+0x210>
ffffffffc0209a54:	36400593          	li	a1,868
ffffffffc0209a58:	00005517          	auipc	a0,0x5
ffffffffc0209a5c:	36850513          	addi	a0,a0,872 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209a60:	a3ff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209a64 <sfs_block_alloc>:
ffffffffc0209a64:	1101                	addi	sp,sp,-32
ffffffffc0209a66:	e822                	sd	s0,16(sp)
ffffffffc0209a68:	842a                	mv	s0,a0
ffffffffc0209a6a:	7d08                	ld	a0,56(a0)
ffffffffc0209a6c:	e426                	sd	s1,8(sp)
ffffffffc0209a6e:	ec06                	sd	ra,24(sp)
ffffffffc0209a70:	84ae                	mv	s1,a1
ffffffffc0209a72:	c62ff0ef          	jal	ra,ffffffffc0208ed4 <bitmap_alloc>
ffffffffc0209a76:	e90d                	bnez	a0,ffffffffc0209aa8 <sfs_block_alloc+0x44>
ffffffffc0209a78:	441c                	lw	a5,8(s0)
ffffffffc0209a7a:	cbad                	beqz	a5,ffffffffc0209aec <sfs_block_alloc+0x88>
ffffffffc0209a7c:	37fd                	addiw	a5,a5,-1
ffffffffc0209a7e:	c41c                	sw	a5,8(s0)
ffffffffc0209a80:	408c                	lw	a1,0(s1)
ffffffffc0209a82:	4785                	li	a5,1
ffffffffc0209a84:	e03c                	sd	a5,64(s0)
ffffffffc0209a86:	4054                	lw	a3,4(s0)
ffffffffc0209a88:	c58d                	beqz	a1,ffffffffc0209ab2 <sfs_block_alloc+0x4e>
ffffffffc0209a8a:	02d5f463          	bgeu	a1,a3,ffffffffc0209ab2 <sfs_block_alloc+0x4e>
ffffffffc0209a8e:	7c08                	ld	a0,56(s0)
ffffffffc0209a90:	cb4ff0ef          	jal	ra,ffffffffc0208f44 <bitmap_test>
ffffffffc0209a94:	ed05                	bnez	a0,ffffffffc0209acc <sfs_block_alloc+0x68>
ffffffffc0209a96:	8522                	mv	a0,s0
ffffffffc0209a98:	6442                	ld	s0,16(sp)
ffffffffc0209a9a:	408c                	lw	a1,0(s1)
ffffffffc0209a9c:	60e2                	ld	ra,24(sp)
ffffffffc0209a9e:	64a2                	ld	s1,8(sp)
ffffffffc0209aa0:	4605                	li	a2,1
ffffffffc0209aa2:	6105                	addi	sp,sp,32
ffffffffc0209aa4:	35e0106f          	j	ffffffffc020ae02 <sfs_clear_block>
ffffffffc0209aa8:	60e2                	ld	ra,24(sp)
ffffffffc0209aaa:	6442                	ld	s0,16(sp)
ffffffffc0209aac:	64a2                	ld	s1,8(sp)
ffffffffc0209aae:	6105                	addi	sp,sp,32
ffffffffc0209ab0:	8082                	ret
ffffffffc0209ab2:	872e                	mv	a4,a1
ffffffffc0209ab4:	00005617          	auipc	a2,0x5
ffffffffc0209ab8:	33c60613          	addi	a2,a2,828 # ffffffffc020edf0 <dev_node_ops+0x5f0>
ffffffffc0209abc:	05300593          	li	a1,83
ffffffffc0209ac0:	00005517          	auipc	a0,0x5
ffffffffc0209ac4:	30050513          	addi	a0,a0,768 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209ac8:	9d7f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209acc:	00005697          	auipc	a3,0x5
ffffffffc0209ad0:	3b468693          	addi	a3,a3,948 # ffffffffc020ee80 <dev_node_ops+0x680>
ffffffffc0209ad4:	00002617          	auipc	a2,0x2
ffffffffc0209ad8:	dc460613          	addi	a2,a2,-572 # ffffffffc020b898 <commands+0x210>
ffffffffc0209adc:	06100593          	li	a1,97
ffffffffc0209ae0:	00005517          	auipc	a0,0x5
ffffffffc0209ae4:	2e050513          	addi	a0,a0,736 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209ae8:	9b7f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209aec:	00005697          	auipc	a3,0x5
ffffffffc0209af0:	37468693          	addi	a3,a3,884 # ffffffffc020ee60 <dev_node_ops+0x660>
ffffffffc0209af4:	00002617          	auipc	a2,0x2
ffffffffc0209af8:	da460613          	addi	a2,a2,-604 # ffffffffc020b898 <commands+0x210>
ffffffffc0209afc:	05f00593          	li	a1,95
ffffffffc0209b00:	00005517          	auipc	a0,0x5
ffffffffc0209b04:	2c050513          	addi	a0,a0,704 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209b08:	997f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209b0c <sfs_bmap_load_nolock>:
ffffffffc0209b0c:	7159                	addi	sp,sp,-112
ffffffffc0209b0e:	f85a                	sd	s6,48(sp)
ffffffffc0209b10:	0005bb03          	ld	s6,0(a1)
ffffffffc0209b14:	f45e                	sd	s7,40(sp)
ffffffffc0209b16:	f486                	sd	ra,104(sp)
ffffffffc0209b18:	008b2b83          	lw	s7,8(s6)
ffffffffc0209b1c:	f0a2                	sd	s0,96(sp)
ffffffffc0209b1e:	eca6                	sd	s1,88(sp)
ffffffffc0209b20:	e8ca                	sd	s2,80(sp)
ffffffffc0209b22:	e4ce                	sd	s3,72(sp)
ffffffffc0209b24:	e0d2                	sd	s4,64(sp)
ffffffffc0209b26:	fc56                	sd	s5,56(sp)
ffffffffc0209b28:	f062                	sd	s8,32(sp)
ffffffffc0209b2a:	ec66                	sd	s9,24(sp)
ffffffffc0209b2c:	18cbe363          	bltu	s7,a2,ffffffffc0209cb2 <sfs_bmap_load_nolock+0x1a6>
ffffffffc0209b30:	47ad                	li	a5,11
ffffffffc0209b32:	8aae                	mv	s5,a1
ffffffffc0209b34:	8432                	mv	s0,a2
ffffffffc0209b36:	84aa                	mv	s1,a0
ffffffffc0209b38:	89b6                	mv	s3,a3
ffffffffc0209b3a:	04c7f563          	bgeu	a5,a2,ffffffffc0209b84 <sfs_bmap_load_nolock+0x78>
ffffffffc0209b3e:	ff46071b          	addiw	a4,a2,-12
ffffffffc0209b42:	0007069b          	sext.w	a3,a4
ffffffffc0209b46:	3ff00793          	li	a5,1023
ffffffffc0209b4a:	1ad7e163          	bltu	a5,a3,ffffffffc0209cec <sfs_bmap_load_nolock+0x1e0>
ffffffffc0209b4e:	03cb2a03          	lw	s4,60(s6)
ffffffffc0209b52:	02071793          	slli	a5,a4,0x20
ffffffffc0209b56:	c602                	sw	zero,12(sp)
ffffffffc0209b58:	c452                	sw	s4,8(sp)
ffffffffc0209b5a:	01e7dc13          	srli	s8,a5,0x1e
ffffffffc0209b5e:	0e0a1e63          	bnez	s4,ffffffffc0209c5a <sfs_bmap_load_nolock+0x14e>
ffffffffc0209b62:	0acb8663          	beq	s7,a2,ffffffffc0209c0e <sfs_bmap_load_nolock+0x102>
ffffffffc0209b66:	4a01                	li	s4,0
ffffffffc0209b68:	40d4                	lw	a3,4(s1)
ffffffffc0209b6a:	8752                	mv	a4,s4
ffffffffc0209b6c:	00005617          	auipc	a2,0x5
ffffffffc0209b70:	28460613          	addi	a2,a2,644 # ffffffffc020edf0 <dev_node_ops+0x5f0>
ffffffffc0209b74:	05300593          	li	a1,83
ffffffffc0209b78:	00005517          	auipc	a0,0x5
ffffffffc0209b7c:	24850513          	addi	a0,a0,584 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209b80:	91ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b84:	02061793          	slli	a5,a2,0x20
ffffffffc0209b88:	01e7da13          	srli	s4,a5,0x1e
ffffffffc0209b8c:	9a5a                	add	s4,s4,s6
ffffffffc0209b8e:	00ca2583          	lw	a1,12(s4)
ffffffffc0209b92:	c22e                	sw	a1,4(sp)
ffffffffc0209b94:	ed99                	bnez	a1,ffffffffc0209bb2 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209b96:	fccb98e3          	bne	s7,a2,ffffffffc0209b66 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209b9a:	004c                	addi	a1,sp,4
ffffffffc0209b9c:	ec9ff0ef          	jal	ra,ffffffffc0209a64 <sfs_block_alloc>
ffffffffc0209ba0:	892a                	mv	s2,a0
ffffffffc0209ba2:	e921                	bnez	a0,ffffffffc0209bf2 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209ba4:	4592                	lw	a1,4(sp)
ffffffffc0209ba6:	4705                	li	a4,1
ffffffffc0209ba8:	00ba2623          	sw	a1,12(s4)
ffffffffc0209bac:	00eab823          	sd	a4,16(s5)
ffffffffc0209bb0:	d9dd                	beqz	a1,ffffffffc0209b66 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209bb2:	40d4                	lw	a3,4(s1)
ffffffffc0209bb4:	10d5ff63          	bgeu	a1,a3,ffffffffc0209cd2 <sfs_bmap_load_nolock+0x1c6>
ffffffffc0209bb8:	7c88                	ld	a0,56(s1)
ffffffffc0209bba:	b8aff0ef          	jal	ra,ffffffffc0208f44 <bitmap_test>
ffffffffc0209bbe:	18051363          	bnez	a0,ffffffffc0209d44 <sfs_bmap_load_nolock+0x238>
ffffffffc0209bc2:	4a12                	lw	s4,4(sp)
ffffffffc0209bc4:	fa0a02e3          	beqz	s4,ffffffffc0209b68 <sfs_bmap_load_nolock+0x5c>
ffffffffc0209bc8:	40dc                	lw	a5,4(s1)
ffffffffc0209bca:	f8fa7fe3          	bgeu	s4,a5,ffffffffc0209b68 <sfs_bmap_load_nolock+0x5c>
ffffffffc0209bce:	7c88                	ld	a0,56(s1)
ffffffffc0209bd0:	85d2                	mv	a1,s4
ffffffffc0209bd2:	b72ff0ef          	jal	ra,ffffffffc0208f44 <bitmap_test>
ffffffffc0209bd6:	12051763          	bnez	a0,ffffffffc0209d04 <sfs_bmap_load_nolock+0x1f8>
ffffffffc0209bda:	008b9763          	bne	s7,s0,ffffffffc0209be8 <sfs_bmap_load_nolock+0xdc>
ffffffffc0209bde:	008b2783          	lw	a5,8(s6)
ffffffffc0209be2:	2785                	addiw	a5,a5,1
ffffffffc0209be4:	00fb2423          	sw	a5,8(s6)
ffffffffc0209be8:	4901                	li	s2,0
ffffffffc0209bea:	00098463          	beqz	s3,ffffffffc0209bf2 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209bee:	0149a023          	sw	s4,0(s3)
ffffffffc0209bf2:	70a6                	ld	ra,104(sp)
ffffffffc0209bf4:	7406                	ld	s0,96(sp)
ffffffffc0209bf6:	64e6                	ld	s1,88(sp)
ffffffffc0209bf8:	69a6                	ld	s3,72(sp)
ffffffffc0209bfa:	6a06                	ld	s4,64(sp)
ffffffffc0209bfc:	7ae2                	ld	s5,56(sp)
ffffffffc0209bfe:	7b42                	ld	s6,48(sp)
ffffffffc0209c00:	7ba2                	ld	s7,40(sp)
ffffffffc0209c02:	7c02                	ld	s8,32(sp)
ffffffffc0209c04:	6ce2                	ld	s9,24(sp)
ffffffffc0209c06:	854a                	mv	a0,s2
ffffffffc0209c08:	6946                	ld	s2,80(sp)
ffffffffc0209c0a:	6165                	addi	sp,sp,112
ffffffffc0209c0c:	8082                	ret
ffffffffc0209c0e:	002c                	addi	a1,sp,8
ffffffffc0209c10:	e55ff0ef          	jal	ra,ffffffffc0209a64 <sfs_block_alloc>
ffffffffc0209c14:	892a                	mv	s2,a0
ffffffffc0209c16:	00c10c93          	addi	s9,sp,12
ffffffffc0209c1a:	fd61                	bnez	a0,ffffffffc0209bf2 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209c1c:	85e6                	mv	a1,s9
ffffffffc0209c1e:	8526                	mv	a0,s1
ffffffffc0209c20:	e45ff0ef          	jal	ra,ffffffffc0209a64 <sfs_block_alloc>
ffffffffc0209c24:	892a                	mv	s2,a0
ffffffffc0209c26:	e925                	bnez	a0,ffffffffc0209c96 <sfs_bmap_load_nolock+0x18a>
ffffffffc0209c28:	46a2                	lw	a3,8(sp)
ffffffffc0209c2a:	85e6                	mv	a1,s9
ffffffffc0209c2c:	8762                	mv	a4,s8
ffffffffc0209c2e:	4611                	li	a2,4
ffffffffc0209c30:	8526                	mv	a0,s1
ffffffffc0209c32:	080010ef          	jal	ra,ffffffffc020acb2 <sfs_wbuf>
ffffffffc0209c36:	45b2                	lw	a1,12(sp)
ffffffffc0209c38:	892a                	mv	s2,a0
ffffffffc0209c3a:	e939                	bnez	a0,ffffffffc0209c90 <sfs_bmap_load_nolock+0x184>
ffffffffc0209c3c:	03cb2683          	lw	a3,60(s6)
ffffffffc0209c40:	4722                	lw	a4,8(sp)
ffffffffc0209c42:	c22e                	sw	a1,4(sp)
ffffffffc0209c44:	f6d706e3          	beq	a4,a3,ffffffffc0209bb0 <sfs_bmap_load_nolock+0xa4>
ffffffffc0209c48:	eef1                	bnez	a3,ffffffffc0209d24 <sfs_bmap_load_nolock+0x218>
ffffffffc0209c4a:	02eb2e23          	sw	a4,60(s6)
ffffffffc0209c4e:	4705                	li	a4,1
ffffffffc0209c50:	00eab823          	sd	a4,16(s5)
ffffffffc0209c54:	f00589e3          	beqz	a1,ffffffffc0209b66 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209c58:	bfa9                	j	ffffffffc0209bb2 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209c5a:	00c10c93          	addi	s9,sp,12
ffffffffc0209c5e:	8762                	mv	a4,s8
ffffffffc0209c60:	86d2                	mv	a3,s4
ffffffffc0209c62:	4611                	li	a2,4
ffffffffc0209c64:	85e6                	mv	a1,s9
ffffffffc0209c66:	7cd000ef          	jal	ra,ffffffffc020ac32 <sfs_rbuf>
ffffffffc0209c6a:	892a                	mv	s2,a0
ffffffffc0209c6c:	f159                	bnez	a0,ffffffffc0209bf2 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209c6e:	45b2                	lw	a1,12(sp)
ffffffffc0209c70:	e995                	bnez	a1,ffffffffc0209ca4 <sfs_bmap_load_nolock+0x198>
ffffffffc0209c72:	fa8b85e3          	beq	s7,s0,ffffffffc0209c1c <sfs_bmap_load_nolock+0x110>
ffffffffc0209c76:	03cb2703          	lw	a4,60(s6)
ffffffffc0209c7a:	47a2                	lw	a5,8(sp)
ffffffffc0209c7c:	c202                	sw	zero,4(sp)
ffffffffc0209c7e:	eee784e3          	beq	a5,a4,ffffffffc0209b66 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209c82:	e34d                	bnez	a4,ffffffffc0209d24 <sfs_bmap_load_nolock+0x218>
ffffffffc0209c84:	02fb2e23          	sw	a5,60(s6)
ffffffffc0209c88:	4785                	li	a5,1
ffffffffc0209c8a:	00fab823          	sd	a5,16(s5)
ffffffffc0209c8e:	bde1                	j	ffffffffc0209b66 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209c90:	8526                	mv	a0,s1
ffffffffc0209c92:	bc1ff0ef          	jal	ra,ffffffffc0209852 <sfs_block_free>
ffffffffc0209c96:	45a2                	lw	a1,8(sp)
ffffffffc0209c98:	f4ba0de3          	beq	s4,a1,ffffffffc0209bf2 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209c9c:	8526                	mv	a0,s1
ffffffffc0209c9e:	bb5ff0ef          	jal	ra,ffffffffc0209852 <sfs_block_free>
ffffffffc0209ca2:	bf81                	j	ffffffffc0209bf2 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209ca4:	03cb2683          	lw	a3,60(s6)
ffffffffc0209ca8:	4722                	lw	a4,8(sp)
ffffffffc0209caa:	c22e                	sw	a1,4(sp)
ffffffffc0209cac:	f8e69ee3          	bne	a3,a4,ffffffffc0209c48 <sfs_bmap_load_nolock+0x13c>
ffffffffc0209cb0:	b709                	j	ffffffffc0209bb2 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209cb2:	00005697          	auipc	a3,0x5
ffffffffc0209cb6:	1f668693          	addi	a3,a3,502 # ffffffffc020eea8 <dev_node_ops+0x6a8>
ffffffffc0209cba:	00002617          	auipc	a2,0x2
ffffffffc0209cbe:	bde60613          	addi	a2,a2,-1058 # ffffffffc020b898 <commands+0x210>
ffffffffc0209cc2:	16400593          	li	a1,356
ffffffffc0209cc6:	00005517          	auipc	a0,0x5
ffffffffc0209cca:	0fa50513          	addi	a0,a0,250 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209cce:	fd0f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209cd2:	872e                	mv	a4,a1
ffffffffc0209cd4:	00005617          	auipc	a2,0x5
ffffffffc0209cd8:	11c60613          	addi	a2,a2,284 # ffffffffc020edf0 <dev_node_ops+0x5f0>
ffffffffc0209cdc:	05300593          	li	a1,83
ffffffffc0209ce0:	00005517          	auipc	a0,0x5
ffffffffc0209ce4:	0e050513          	addi	a0,a0,224 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209ce8:	fb6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209cec:	00005617          	auipc	a2,0x5
ffffffffc0209cf0:	1ec60613          	addi	a2,a2,492 # ffffffffc020eed8 <dev_node_ops+0x6d8>
ffffffffc0209cf4:	11e00593          	li	a1,286
ffffffffc0209cf8:	00005517          	auipc	a0,0x5
ffffffffc0209cfc:	0c850513          	addi	a0,a0,200 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209d00:	f9ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d04:	00005697          	auipc	a3,0x5
ffffffffc0209d08:	12468693          	addi	a3,a3,292 # ffffffffc020ee28 <dev_node_ops+0x628>
ffffffffc0209d0c:	00002617          	auipc	a2,0x2
ffffffffc0209d10:	b8c60613          	addi	a2,a2,-1140 # ffffffffc020b898 <commands+0x210>
ffffffffc0209d14:	16b00593          	li	a1,363
ffffffffc0209d18:	00005517          	auipc	a0,0x5
ffffffffc0209d1c:	0a850513          	addi	a0,a0,168 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209d20:	f7ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d24:	00005697          	auipc	a3,0x5
ffffffffc0209d28:	19c68693          	addi	a3,a3,412 # ffffffffc020eec0 <dev_node_ops+0x6c0>
ffffffffc0209d2c:	00002617          	auipc	a2,0x2
ffffffffc0209d30:	b6c60613          	addi	a2,a2,-1172 # ffffffffc020b898 <commands+0x210>
ffffffffc0209d34:	11800593          	li	a1,280
ffffffffc0209d38:	00005517          	auipc	a0,0x5
ffffffffc0209d3c:	08850513          	addi	a0,a0,136 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209d40:	f5ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d44:	00005697          	auipc	a3,0x5
ffffffffc0209d48:	1c468693          	addi	a3,a3,452 # ffffffffc020ef08 <dev_node_ops+0x708>
ffffffffc0209d4c:	00002617          	auipc	a2,0x2
ffffffffc0209d50:	b4c60613          	addi	a2,a2,-1204 # ffffffffc020b898 <commands+0x210>
ffffffffc0209d54:	12100593          	li	a1,289
ffffffffc0209d58:	00005517          	auipc	a0,0x5
ffffffffc0209d5c:	06850513          	addi	a0,a0,104 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209d60:	f3ef60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209d64 <sfs_io_nolock>:
ffffffffc0209d64:	7175                	addi	sp,sp,-144
ffffffffc0209d66:	f8ca                	sd	s2,112(sp)
ffffffffc0209d68:	892e                	mv	s2,a1
ffffffffc0209d6a:	618c                	ld	a1,0(a1)
ffffffffc0209d6c:	e506                	sd	ra,136(sp)
ffffffffc0209d6e:	e122                	sd	s0,128(sp)
ffffffffc0209d70:	0045d883          	lhu	a7,4(a1)
ffffffffc0209d74:	fca6                	sd	s1,120(sp)
ffffffffc0209d76:	f4ce                	sd	s3,104(sp)
ffffffffc0209d78:	f0d2                	sd	s4,96(sp)
ffffffffc0209d7a:	ecd6                	sd	s5,88(sp)
ffffffffc0209d7c:	e8da                	sd	s6,80(sp)
ffffffffc0209d7e:	e4de                	sd	s7,72(sp)
ffffffffc0209d80:	e0e2                	sd	s8,64(sp)
ffffffffc0209d82:	fc66                	sd	s9,56(sp)
ffffffffc0209d84:	f86a                	sd	s10,48(sp)
ffffffffc0209d86:	f46e                	sd	s11,40(sp)
ffffffffc0209d88:	4809                	li	a6,2
ffffffffc0209d8a:	17088f63          	beq	a7,a6,ffffffffc0209f08 <sfs_io_nolock+0x1a4>
ffffffffc0209d8e:	00073983          	ld	s3,0(a4) # 4000 <_binary_bin_swap_img_size-0x3d00>
ffffffffc0209d92:	8aba                	mv	s5,a4
ffffffffc0209d94:	000ab023          	sd	zero,0(s5)
ffffffffc0209d98:	08000737          	lui	a4,0x8000
ffffffffc0209d9c:	84b6                	mv	s1,a3
ffffffffc0209d9e:	99b6                	add	s3,s3,a3
ffffffffc0209da0:	14e6ff63          	bgeu	a3,a4,ffffffffc0209efe <sfs_io_nolock+0x19a>
ffffffffc0209da4:	14d9cd63          	blt	s3,a3,ffffffffc0209efe <sfs_io_nolock+0x19a>
ffffffffc0209da8:	0d368c63          	beq	a3,s3,ffffffffc0209e80 <sfs_io_nolock+0x11c>
ffffffffc0209dac:	842a                	mv	s0,a0
ffffffffc0209dae:	8db2                	mv	s11,a2
ffffffffc0209db0:	01377463          	bgeu	a4,s3,ffffffffc0209db8 <sfs_io_nolock+0x54>
ffffffffc0209db4:	080009b7          	lui	s3,0x8000
ffffffffc0209db8:	c7e5                	beqz	a5,ffffffffc0209ea0 <sfs_io_nolock+0x13c>
ffffffffc0209dba:	00001797          	auipc	a5,0x1
ffffffffc0209dbe:	ef878793          	addi	a5,a5,-264 # ffffffffc020acb2 <sfs_wbuf>
ffffffffc0209dc2:	00001b97          	auipc	s7,0x1
ffffffffc0209dc6:	e10b8b93          	addi	s7,s7,-496 # ffffffffc020abd2 <sfs_wblock>
ffffffffc0209dca:	e43e                	sd	a5,8(sp)
ffffffffc0209dcc:	6705                	lui	a4,0x1
ffffffffc0209dce:	40c4dd13          	srai	s10,s1,0xc
ffffffffc0209dd2:	40c9db13          	srai	s6,s3,0xc
ffffffffc0209dd6:	fff70c13          	addi	s8,a4,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0209dda:	41ab0a3b          	subw	s4,s6,s10
ffffffffc0209dde:	0184fc33          	and	s8,s1,s8
ffffffffc0209de2:	8b52                	mv	s6,s4
ffffffffc0209de4:	2d01                	sext.w	s10,s10
ffffffffc0209de6:	87e2                	mv	a5,s8
ffffffffc0209de8:	020c0c63          	beqz	s8,ffffffffc0209e20 <sfs_io_nolock+0xbc>
ffffffffc0209dec:	40998cb3          	sub	s9,s3,s1
ffffffffc0209df0:	0c0a1863          	bnez	s4,ffffffffc0209ec0 <sfs_io_nolock+0x15c>
ffffffffc0209df4:	0874                	addi	a3,sp,28
ffffffffc0209df6:	866a                	mv	a2,s10
ffffffffc0209df8:	85ca                	mv	a1,s2
ffffffffc0209dfa:	8522                	mv	a0,s0
ffffffffc0209dfc:	d11ff0ef          	jal	ra,ffffffffc0209b0c <sfs_bmap_load_nolock>
ffffffffc0209e00:	e149                	bnez	a0,ffffffffc0209e82 <sfs_io_nolock+0x11e>
ffffffffc0209e02:	46f2                	lw	a3,28(sp)
ffffffffc0209e04:	67a2                	ld	a5,8(sp)
ffffffffc0209e06:	8762                	mv	a4,s8
ffffffffc0209e08:	8666                	mv	a2,s9
ffffffffc0209e0a:	85ee                	mv	a1,s11
ffffffffc0209e0c:	8522                	mv	a0,s0
ffffffffc0209e0e:	9782                	jalr	a5
ffffffffc0209e10:	e92d                	bnez	a0,ffffffffc0209e82 <sfs_io_nolock+0x11e>
ffffffffc0209e12:	040a0763          	beqz	s4,ffffffffc0209e60 <sfs_io_nolock+0xfc>
ffffffffc0209e16:	9de6                	add	s11,s11,s9
ffffffffc0209e18:	2d05                	addiw	s10,s10,1
ffffffffc0209e1a:	fffb0a1b          	addiw	s4,s6,-1
ffffffffc0209e1e:	87e6                	mv	a5,s9
ffffffffc0209e20:	0e0a0163          	beqz	s4,ffffffffc0209f02 <sfs_io_nolock+0x19e>
ffffffffc0209e24:	6b05                	lui	s6,0x1
ffffffffc0209e26:	97da                	add	a5,a5,s6
ffffffffc0209e28:	01aa0a3b          	addw	s4,s4,s10
ffffffffc0209e2c:	41b78c33          	sub	s8,a5,s11
ffffffffc0209e30:	0874                	addi	a3,sp,28
ffffffffc0209e32:	866a                	mv	a2,s10
ffffffffc0209e34:	85ca                	mv	a1,s2
ffffffffc0209e36:	8522                	mv	a0,s0
ffffffffc0209e38:	cd5ff0ef          	jal	ra,ffffffffc0209b0c <sfs_bmap_load_nolock>
ffffffffc0209e3c:	e139                	bnez	a0,ffffffffc0209e82 <sfs_io_nolock+0x11e>
ffffffffc0209e3e:	4672                	lw	a2,28(sp)
ffffffffc0209e40:	4685                	li	a3,1
ffffffffc0209e42:	85ee                	mv	a1,s11
ffffffffc0209e44:	8522                	mv	a0,s0
ffffffffc0209e46:	9b82                	jalr	s7
ffffffffc0209e48:	ed0d                	bnez	a0,ffffffffc0209e82 <sfs_io_nolock+0x11e>
ffffffffc0209e4a:	2d05                	addiw	s10,s10,1
ffffffffc0209e4c:	018d8cb3          	add	s9,s11,s8
ffffffffc0209e50:	9dda                	add	s11,s11,s6
ffffffffc0209e52:	fd4d1fe3          	bne	s10,s4,ffffffffc0209e30 <sfs_io_nolock+0xcc>
ffffffffc0209e56:	19d2                	slli	s3,s3,0x34
ffffffffc0209e58:	0349db13          	srli	s6,s3,0x34
ffffffffc0209e5c:	08099063          	bnez	s3,ffffffffc0209edc <sfs_io_nolock+0x178>
ffffffffc0209e60:	00093683          	ld	a3,0(s2)
ffffffffc0209e64:	01948733          	add	a4,s1,s9
ffffffffc0209e68:	019ab023          	sd	s9,0(s5)
ffffffffc0209e6c:	0006e603          	lwu	a2,0(a3)
ffffffffc0209e70:	00e67863          	bgeu	a2,a4,ffffffffc0209e80 <sfs_io_nolock+0x11c>
ffffffffc0209e74:	019484bb          	addw	s1,s1,s9
ffffffffc0209e78:	c284                	sw	s1,0(a3)
ffffffffc0209e7a:	4785                	li	a5,1
ffffffffc0209e7c:	00f93823          	sd	a5,16(s2)
ffffffffc0209e80:	4501                	li	a0,0
ffffffffc0209e82:	60aa                	ld	ra,136(sp)
ffffffffc0209e84:	640a                	ld	s0,128(sp)
ffffffffc0209e86:	74e6                	ld	s1,120(sp)
ffffffffc0209e88:	7946                	ld	s2,112(sp)
ffffffffc0209e8a:	79a6                	ld	s3,104(sp)
ffffffffc0209e8c:	7a06                	ld	s4,96(sp)
ffffffffc0209e8e:	6ae6                	ld	s5,88(sp)
ffffffffc0209e90:	6b46                	ld	s6,80(sp)
ffffffffc0209e92:	6ba6                	ld	s7,72(sp)
ffffffffc0209e94:	6c06                	ld	s8,64(sp)
ffffffffc0209e96:	7ce2                	ld	s9,56(sp)
ffffffffc0209e98:	7d42                	ld	s10,48(sp)
ffffffffc0209e9a:	7da2                	ld	s11,40(sp)
ffffffffc0209e9c:	6149                	addi	sp,sp,144
ffffffffc0209e9e:	8082                	ret
ffffffffc0209ea0:	0005e783          	lwu	a5,0(a1)
ffffffffc0209ea4:	fcf4dee3          	bge	s1,a5,ffffffffc0209e80 <sfs_io_nolock+0x11c>
ffffffffc0209ea8:	0137cf63          	blt	a5,s3,ffffffffc0209ec6 <sfs_io_nolock+0x162>
ffffffffc0209eac:	00001797          	auipc	a5,0x1
ffffffffc0209eb0:	d8678793          	addi	a5,a5,-634 # ffffffffc020ac32 <sfs_rbuf>
ffffffffc0209eb4:	00001b97          	auipc	s7,0x1
ffffffffc0209eb8:	cbeb8b93          	addi	s7,s7,-834 # ffffffffc020ab72 <sfs_rblock>
ffffffffc0209ebc:	e43e                	sd	a5,8(sp)
ffffffffc0209ebe:	b739                	j	ffffffffc0209dcc <sfs_io_nolock+0x68>
ffffffffc0209ec0:	41870cb3          	sub	s9,a4,s8
ffffffffc0209ec4:	bf05                	j	ffffffffc0209df4 <sfs_io_nolock+0x90>
ffffffffc0209ec6:	89be                	mv	s3,a5
ffffffffc0209ec8:	00001797          	auipc	a5,0x1
ffffffffc0209ecc:	d6a78793          	addi	a5,a5,-662 # ffffffffc020ac32 <sfs_rbuf>
ffffffffc0209ed0:	00001b97          	auipc	s7,0x1
ffffffffc0209ed4:	ca2b8b93          	addi	s7,s7,-862 # ffffffffc020ab72 <sfs_rblock>
ffffffffc0209ed8:	e43e                	sd	a5,8(sp)
ffffffffc0209eda:	bdcd                	j	ffffffffc0209dcc <sfs_io_nolock+0x68>
ffffffffc0209edc:	0874                	addi	a3,sp,28
ffffffffc0209ede:	8652                	mv	a2,s4
ffffffffc0209ee0:	85ca                	mv	a1,s2
ffffffffc0209ee2:	8522                	mv	a0,s0
ffffffffc0209ee4:	c29ff0ef          	jal	ra,ffffffffc0209b0c <sfs_bmap_load_nolock>
ffffffffc0209ee8:	fd49                	bnez	a0,ffffffffc0209e82 <sfs_io_nolock+0x11e>
ffffffffc0209eea:	46f2                	lw	a3,28(sp)
ffffffffc0209eec:	67a2                	ld	a5,8(sp)
ffffffffc0209eee:	4701                	li	a4,0
ffffffffc0209ef0:	865a                	mv	a2,s6
ffffffffc0209ef2:	85ee                	mv	a1,s11
ffffffffc0209ef4:	8522                	mv	a0,s0
ffffffffc0209ef6:	9782                	jalr	a5
ffffffffc0209ef8:	f549                	bnez	a0,ffffffffc0209e82 <sfs_io_nolock+0x11e>
ffffffffc0209efa:	9cda                	add	s9,s9,s6
ffffffffc0209efc:	b795                	j	ffffffffc0209e60 <sfs_io_nolock+0xfc>
ffffffffc0209efe:	5575                	li	a0,-3
ffffffffc0209f00:	b749                	j	ffffffffc0209e82 <sfs_io_nolock+0x11e>
ffffffffc0209f02:	8a6a                	mv	s4,s10
ffffffffc0209f04:	8cbe                	mv	s9,a5
ffffffffc0209f06:	bf81                	j	ffffffffc0209e56 <sfs_io_nolock+0xf2>
ffffffffc0209f08:	00005697          	auipc	a3,0x5
ffffffffc0209f0c:	02868693          	addi	a3,a3,40 # ffffffffc020ef30 <dev_node_ops+0x730>
ffffffffc0209f10:	00002617          	auipc	a2,0x2
ffffffffc0209f14:	98860613          	addi	a2,a2,-1656 # ffffffffc020b898 <commands+0x210>
ffffffffc0209f18:	22b00593          	li	a1,555
ffffffffc0209f1c:	00005517          	auipc	a0,0x5
ffffffffc0209f20:	ea450513          	addi	a0,a0,-348 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209f24:	d7af60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209f28 <sfs_read>:
ffffffffc0209f28:	7139                	addi	sp,sp,-64
ffffffffc0209f2a:	f04a                	sd	s2,32(sp)
ffffffffc0209f2c:	06853903          	ld	s2,104(a0)
ffffffffc0209f30:	fc06                	sd	ra,56(sp)
ffffffffc0209f32:	f822                	sd	s0,48(sp)
ffffffffc0209f34:	f426                	sd	s1,40(sp)
ffffffffc0209f36:	ec4e                	sd	s3,24(sp)
ffffffffc0209f38:	04090f63          	beqz	s2,ffffffffc0209f96 <sfs_read+0x6e>
ffffffffc0209f3c:	0b092783          	lw	a5,176(s2)
ffffffffc0209f40:	ebb9                	bnez	a5,ffffffffc0209f96 <sfs_read+0x6e>
ffffffffc0209f42:	4d38                	lw	a4,88(a0)
ffffffffc0209f44:	6785                	lui	a5,0x1
ffffffffc0209f46:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209f4a:	842a                	mv	s0,a0
ffffffffc0209f4c:	06f71563          	bne	a4,a5,ffffffffc0209fb6 <sfs_read+0x8e>
ffffffffc0209f50:	02050993          	addi	s3,a0,32
ffffffffc0209f54:	854e                	mv	a0,s3
ffffffffc0209f56:	84ae                	mv	s1,a1
ffffffffc0209f58:	e0cfa0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0209f5c:	0184b803          	ld	a6,24(s1)
ffffffffc0209f60:	6494                	ld	a3,8(s1)
ffffffffc0209f62:	6090                	ld	a2,0(s1)
ffffffffc0209f64:	85a2                	mv	a1,s0
ffffffffc0209f66:	4781                	li	a5,0
ffffffffc0209f68:	0038                	addi	a4,sp,8
ffffffffc0209f6a:	854a                	mv	a0,s2
ffffffffc0209f6c:	e442                	sd	a6,8(sp)
ffffffffc0209f6e:	df7ff0ef          	jal	ra,ffffffffc0209d64 <sfs_io_nolock>
ffffffffc0209f72:	65a2                	ld	a1,8(sp)
ffffffffc0209f74:	842a                	mv	s0,a0
ffffffffc0209f76:	ed81                	bnez	a1,ffffffffc0209f8e <sfs_read+0x66>
ffffffffc0209f78:	854e                	mv	a0,s3
ffffffffc0209f7a:	de6fa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0209f7e:	70e2                	ld	ra,56(sp)
ffffffffc0209f80:	8522                	mv	a0,s0
ffffffffc0209f82:	7442                	ld	s0,48(sp)
ffffffffc0209f84:	74a2                	ld	s1,40(sp)
ffffffffc0209f86:	7902                	ld	s2,32(sp)
ffffffffc0209f88:	69e2                	ld	s3,24(sp)
ffffffffc0209f8a:	6121                	addi	sp,sp,64
ffffffffc0209f8c:	8082                	ret
ffffffffc0209f8e:	8526                	mv	a0,s1
ffffffffc0209f90:	cc8fb0ef          	jal	ra,ffffffffc0205458 <iobuf_skip>
ffffffffc0209f94:	b7d5                	j	ffffffffc0209f78 <sfs_read+0x50>
ffffffffc0209f96:	00005697          	auipc	a3,0x5
ffffffffc0209f9a:	c4a68693          	addi	a3,a3,-950 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc0209f9e:	00002617          	auipc	a2,0x2
ffffffffc0209fa2:	8fa60613          	addi	a2,a2,-1798 # ffffffffc020b898 <commands+0x210>
ffffffffc0209fa6:	29200593          	li	a1,658
ffffffffc0209faa:	00005517          	auipc	a0,0x5
ffffffffc0209fae:	e1650513          	addi	a0,a0,-490 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc0209fb2:	cecf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209fb6:	879ff0ef          	jal	ra,ffffffffc020982e <sfs_io.part.0>

ffffffffc0209fba <sfs_write>:
ffffffffc0209fba:	7139                	addi	sp,sp,-64
ffffffffc0209fbc:	f04a                	sd	s2,32(sp)
ffffffffc0209fbe:	06853903          	ld	s2,104(a0)
ffffffffc0209fc2:	fc06                	sd	ra,56(sp)
ffffffffc0209fc4:	f822                	sd	s0,48(sp)
ffffffffc0209fc6:	f426                	sd	s1,40(sp)
ffffffffc0209fc8:	ec4e                	sd	s3,24(sp)
ffffffffc0209fca:	04090f63          	beqz	s2,ffffffffc020a028 <sfs_write+0x6e>
ffffffffc0209fce:	0b092783          	lw	a5,176(s2)
ffffffffc0209fd2:	ebb9                	bnez	a5,ffffffffc020a028 <sfs_write+0x6e>
ffffffffc0209fd4:	4d38                	lw	a4,88(a0)
ffffffffc0209fd6:	6785                	lui	a5,0x1
ffffffffc0209fd8:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209fdc:	842a                	mv	s0,a0
ffffffffc0209fde:	06f71563          	bne	a4,a5,ffffffffc020a048 <sfs_write+0x8e>
ffffffffc0209fe2:	02050993          	addi	s3,a0,32
ffffffffc0209fe6:	854e                	mv	a0,s3
ffffffffc0209fe8:	84ae                	mv	s1,a1
ffffffffc0209fea:	d7afa0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0209fee:	0184b803          	ld	a6,24(s1)
ffffffffc0209ff2:	6494                	ld	a3,8(s1)
ffffffffc0209ff4:	6090                	ld	a2,0(s1)
ffffffffc0209ff6:	85a2                	mv	a1,s0
ffffffffc0209ff8:	4785                	li	a5,1
ffffffffc0209ffa:	0038                	addi	a4,sp,8
ffffffffc0209ffc:	854a                	mv	a0,s2
ffffffffc0209ffe:	e442                	sd	a6,8(sp)
ffffffffc020a000:	d65ff0ef          	jal	ra,ffffffffc0209d64 <sfs_io_nolock>
ffffffffc020a004:	65a2                	ld	a1,8(sp)
ffffffffc020a006:	842a                	mv	s0,a0
ffffffffc020a008:	ed81                	bnez	a1,ffffffffc020a020 <sfs_write+0x66>
ffffffffc020a00a:	854e                	mv	a0,s3
ffffffffc020a00c:	d54fa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a010:	70e2                	ld	ra,56(sp)
ffffffffc020a012:	8522                	mv	a0,s0
ffffffffc020a014:	7442                	ld	s0,48(sp)
ffffffffc020a016:	74a2                	ld	s1,40(sp)
ffffffffc020a018:	7902                	ld	s2,32(sp)
ffffffffc020a01a:	69e2                	ld	s3,24(sp)
ffffffffc020a01c:	6121                	addi	sp,sp,64
ffffffffc020a01e:	8082                	ret
ffffffffc020a020:	8526                	mv	a0,s1
ffffffffc020a022:	c36fb0ef          	jal	ra,ffffffffc0205458 <iobuf_skip>
ffffffffc020a026:	b7d5                	j	ffffffffc020a00a <sfs_write+0x50>
ffffffffc020a028:	00005697          	auipc	a3,0x5
ffffffffc020a02c:	bb868693          	addi	a3,a3,-1096 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc020a030:	00002617          	auipc	a2,0x2
ffffffffc020a034:	86860613          	addi	a2,a2,-1944 # ffffffffc020b898 <commands+0x210>
ffffffffc020a038:	29200593          	li	a1,658
ffffffffc020a03c:	00005517          	auipc	a0,0x5
ffffffffc020a040:	d8450513          	addi	a0,a0,-636 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a044:	c5af60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a048:	fe6ff0ef          	jal	ra,ffffffffc020982e <sfs_io.part.0>

ffffffffc020a04c <sfs_dirent_read_nolock>:
ffffffffc020a04c:	6198                	ld	a4,0(a1)
ffffffffc020a04e:	7179                	addi	sp,sp,-48
ffffffffc020a050:	f406                	sd	ra,40(sp)
ffffffffc020a052:	00475883          	lhu	a7,4(a4)
ffffffffc020a056:	f022                	sd	s0,32(sp)
ffffffffc020a058:	ec26                	sd	s1,24(sp)
ffffffffc020a05a:	4809                	li	a6,2
ffffffffc020a05c:	05089b63          	bne	a7,a6,ffffffffc020a0b2 <sfs_dirent_read_nolock+0x66>
ffffffffc020a060:	4718                	lw	a4,8(a4)
ffffffffc020a062:	87b2                	mv	a5,a2
ffffffffc020a064:	2601                	sext.w	a2,a2
ffffffffc020a066:	04e7f663          	bgeu	a5,a4,ffffffffc020a0b2 <sfs_dirent_read_nolock+0x66>
ffffffffc020a06a:	84b6                	mv	s1,a3
ffffffffc020a06c:	0074                	addi	a3,sp,12
ffffffffc020a06e:	842a                	mv	s0,a0
ffffffffc020a070:	a9dff0ef          	jal	ra,ffffffffc0209b0c <sfs_bmap_load_nolock>
ffffffffc020a074:	c511                	beqz	a0,ffffffffc020a080 <sfs_dirent_read_nolock+0x34>
ffffffffc020a076:	70a2                	ld	ra,40(sp)
ffffffffc020a078:	7402                	ld	s0,32(sp)
ffffffffc020a07a:	64e2                	ld	s1,24(sp)
ffffffffc020a07c:	6145                	addi	sp,sp,48
ffffffffc020a07e:	8082                	ret
ffffffffc020a080:	45b2                	lw	a1,12(sp)
ffffffffc020a082:	4054                	lw	a3,4(s0)
ffffffffc020a084:	c5b9                	beqz	a1,ffffffffc020a0d2 <sfs_dirent_read_nolock+0x86>
ffffffffc020a086:	04d5f663          	bgeu	a1,a3,ffffffffc020a0d2 <sfs_dirent_read_nolock+0x86>
ffffffffc020a08a:	7c08                	ld	a0,56(s0)
ffffffffc020a08c:	eb9fe0ef          	jal	ra,ffffffffc0208f44 <bitmap_test>
ffffffffc020a090:	ed31                	bnez	a0,ffffffffc020a0ec <sfs_dirent_read_nolock+0xa0>
ffffffffc020a092:	46b2                	lw	a3,12(sp)
ffffffffc020a094:	4701                	li	a4,0
ffffffffc020a096:	10400613          	li	a2,260
ffffffffc020a09a:	85a6                	mv	a1,s1
ffffffffc020a09c:	8522                	mv	a0,s0
ffffffffc020a09e:	395000ef          	jal	ra,ffffffffc020ac32 <sfs_rbuf>
ffffffffc020a0a2:	f971                	bnez	a0,ffffffffc020a076 <sfs_dirent_read_nolock+0x2a>
ffffffffc020a0a4:	100481a3          	sb	zero,259(s1)
ffffffffc020a0a8:	70a2                	ld	ra,40(sp)
ffffffffc020a0aa:	7402                	ld	s0,32(sp)
ffffffffc020a0ac:	64e2                	ld	s1,24(sp)
ffffffffc020a0ae:	6145                	addi	sp,sp,48
ffffffffc020a0b0:	8082                	ret
ffffffffc020a0b2:	00005697          	auipc	a3,0x5
ffffffffc020a0b6:	e9e68693          	addi	a3,a3,-354 # ffffffffc020ef50 <dev_node_ops+0x750>
ffffffffc020a0ba:	00001617          	auipc	a2,0x1
ffffffffc020a0be:	7de60613          	addi	a2,a2,2014 # ffffffffc020b898 <commands+0x210>
ffffffffc020a0c2:	18e00593          	li	a1,398
ffffffffc020a0c6:	00005517          	auipc	a0,0x5
ffffffffc020a0ca:	cfa50513          	addi	a0,a0,-774 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a0ce:	bd0f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a0d2:	872e                	mv	a4,a1
ffffffffc020a0d4:	00005617          	auipc	a2,0x5
ffffffffc020a0d8:	d1c60613          	addi	a2,a2,-740 # ffffffffc020edf0 <dev_node_ops+0x5f0>
ffffffffc020a0dc:	05300593          	li	a1,83
ffffffffc020a0e0:	00005517          	auipc	a0,0x5
ffffffffc020a0e4:	ce050513          	addi	a0,a0,-800 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a0e8:	bb6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a0ec:	00005697          	auipc	a3,0x5
ffffffffc020a0f0:	d3c68693          	addi	a3,a3,-708 # ffffffffc020ee28 <dev_node_ops+0x628>
ffffffffc020a0f4:	00001617          	auipc	a2,0x1
ffffffffc020a0f8:	7a460613          	addi	a2,a2,1956 # ffffffffc020b898 <commands+0x210>
ffffffffc020a0fc:	19500593          	li	a1,405
ffffffffc020a100:	00005517          	auipc	a0,0x5
ffffffffc020a104:	cc050513          	addi	a0,a0,-832 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a108:	b96f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a10c <sfs_getdirentry>:
ffffffffc020a10c:	715d                	addi	sp,sp,-80
ffffffffc020a10e:	ec56                	sd	s5,24(sp)
ffffffffc020a110:	8aaa                	mv	s5,a0
ffffffffc020a112:	10400513          	li	a0,260
ffffffffc020a116:	e85a                	sd	s6,16(sp)
ffffffffc020a118:	e486                	sd	ra,72(sp)
ffffffffc020a11a:	e0a2                	sd	s0,64(sp)
ffffffffc020a11c:	fc26                	sd	s1,56(sp)
ffffffffc020a11e:	f84a                	sd	s2,48(sp)
ffffffffc020a120:	f44e                	sd	s3,40(sp)
ffffffffc020a122:	f052                	sd	s4,32(sp)
ffffffffc020a124:	e45e                	sd	s7,8(sp)
ffffffffc020a126:	e062                	sd	s8,0(sp)
ffffffffc020a128:	8b2e                	mv	s6,a1
ffffffffc020a12a:	e65f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a12e:	cd61                	beqz	a0,ffffffffc020a206 <sfs_getdirentry+0xfa>
ffffffffc020a130:	068abb83          	ld	s7,104(s5)
ffffffffc020a134:	0c0b8b63          	beqz	s7,ffffffffc020a20a <sfs_getdirentry+0xfe>
ffffffffc020a138:	0b0ba783          	lw	a5,176(s7)
ffffffffc020a13c:	e7f9                	bnez	a5,ffffffffc020a20a <sfs_getdirentry+0xfe>
ffffffffc020a13e:	058aa703          	lw	a4,88(s5)
ffffffffc020a142:	6785                	lui	a5,0x1
ffffffffc020a144:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a148:	0ef71163          	bne	a4,a5,ffffffffc020a22a <sfs_getdirentry+0x11e>
ffffffffc020a14c:	008b3983          	ld	s3,8(s6) # 1008 <_binary_bin_swap_img_size-0x6cf8>
ffffffffc020a150:	892a                	mv	s2,a0
ffffffffc020a152:	0a09c163          	bltz	s3,ffffffffc020a1f4 <sfs_getdirentry+0xe8>
ffffffffc020a156:	0ff9f793          	zext.b	a5,s3
ffffffffc020a15a:	efc9                	bnez	a5,ffffffffc020a1f4 <sfs_getdirentry+0xe8>
ffffffffc020a15c:	000ab783          	ld	a5,0(s5)
ffffffffc020a160:	0089d993          	srli	s3,s3,0x8
ffffffffc020a164:	2981                	sext.w	s3,s3
ffffffffc020a166:	479c                	lw	a5,8(a5)
ffffffffc020a168:	0937eb63          	bltu	a5,s3,ffffffffc020a1fe <sfs_getdirentry+0xf2>
ffffffffc020a16c:	020a8c13          	addi	s8,s5,32
ffffffffc020a170:	8562                	mv	a0,s8
ffffffffc020a172:	bf2fa0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020a176:	000ab783          	ld	a5,0(s5)
ffffffffc020a17a:	0087aa03          	lw	s4,8(a5)
ffffffffc020a17e:	07405663          	blez	s4,ffffffffc020a1ea <sfs_getdirentry+0xde>
ffffffffc020a182:	4481                	li	s1,0
ffffffffc020a184:	a811                	j	ffffffffc020a198 <sfs_getdirentry+0x8c>
ffffffffc020a186:	00092783          	lw	a5,0(s2)
ffffffffc020a18a:	c781                	beqz	a5,ffffffffc020a192 <sfs_getdirentry+0x86>
ffffffffc020a18c:	02098263          	beqz	s3,ffffffffc020a1b0 <sfs_getdirentry+0xa4>
ffffffffc020a190:	39fd                	addiw	s3,s3,-1
ffffffffc020a192:	2485                	addiw	s1,s1,1
ffffffffc020a194:	049a0b63          	beq	s4,s1,ffffffffc020a1ea <sfs_getdirentry+0xde>
ffffffffc020a198:	86ca                	mv	a3,s2
ffffffffc020a19a:	8626                	mv	a2,s1
ffffffffc020a19c:	85d6                	mv	a1,s5
ffffffffc020a19e:	855e                	mv	a0,s7
ffffffffc020a1a0:	eadff0ef          	jal	ra,ffffffffc020a04c <sfs_dirent_read_nolock>
ffffffffc020a1a4:	842a                	mv	s0,a0
ffffffffc020a1a6:	d165                	beqz	a0,ffffffffc020a186 <sfs_getdirentry+0x7a>
ffffffffc020a1a8:	8562                	mv	a0,s8
ffffffffc020a1aa:	bb6fa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a1ae:	a831                	j	ffffffffc020a1ca <sfs_getdirentry+0xbe>
ffffffffc020a1b0:	8562                	mv	a0,s8
ffffffffc020a1b2:	baefa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a1b6:	4701                	li	a4,0
ffffffffc020a1b8:	4685                	li	a3,1
ffffffffc020a1ba:	10000613          	li	a2,256
ffffffffc020a1be:	00490593          	addi	a1,s2,4
ffffffffc020a1c2:	855a                	mv	a0,s6
ffffffffc020a1c4:	a28fb0ef          	jal	ra,ffffffffc02053ec <iobuf_move>
ffffffffc020a1c8:	842a                	mv	s0,a0
ffffffffc020a1ca:	854a                	mv	a0,s2
ffffffffc020a1cc:	e73f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a1d0:	60a6                	ld	ra,72(sp)
ffffffffc020a1d2:	8522                	mv	a0,s0
ffffffffc020a1d4:	6406                	ld	s0,64(sp)
ffffffffc020a1d6:	74e2                	ld	s1,56(sp)
ffffffffc020a1d8:	7942                	ld	s2,48(sp)
ffffffffc020a1da:	79a2                	ld	s3,40(sp)
ffffffffc020a1dc:	7a02                	ld	s4,32(sp)
ffffffffc020a1de:	6ae2                	ld	s5,24(sp)
ffffffffc020a1e0:	6b42                	ld	s6,16(sp)
ffffffffc020a1e2:	6ba2                	ld	s7,8(sp)
ffffffffc020a1e4:	6c02                	ld	s8,0(sp)
ffffffffc020a1e6:	6161                	addi	sp,sp,80
ffffffffc020a1e8:	8082                	ret
ffffffffc020a1ea:	8562                	mv	a0,s8
ffffffffc020a1ec:	5441                	li	s0,-16
ffffffffc020a1ee:	b72fa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a1f2:	bfe1                	j	ffffffffc020a1ca <sfs_getdirentry+0xbe>
ffffffffc020a1f4:	854a                	mv	a0,s2
ffffffffc020a1f6:	e49f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a1fa:	5475                	li	s0,-3
ffffffffc020a1fc:	bfd1                	j	ffffffffc020a1d0 <sfs_getdirentry+0xc4>
ffffffffc020a1fe:	e41f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a202:	5441                	li	s0,-16
ffffffffc020a204:	b7f1                	j	ffffffffc020a1d0 <sfs_getdirentry+0xc4>
ffffffffc020a206:	5471                	li	s0,-4
ffffffffc020a208:	b7e1                	j	ffffffffc020a1d0 <sfs_getdirentry+0xc4>
ffffffffc020a20a:	00005697          	auipc	a3,0x5
ffffffffc020a20e:	9d668693          	addi	a3,a3,-1578 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc020a212:	00001617          	auipc	a2,0x1
ffffffffc020a216:	68660613          	addi	a2,a2,1670 # ffffffffc020b898 <commands+0x210>
ffffffffc020a21a:	33600593          	li	a1,822
ffffffffc020a21e:	00005517          	auipc	a0,0x5
ffffffffc020a222:	ba250513          	addi	a0,a0,-1118 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a226:	a78f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a22a:	00005697          	auipc	a3,0x5
ffffffffc020a22e:	b5e68693          	addi	a3,a3,-1186 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc020a232:	00001617          	auipc	a2,0x1
ffffffffc020a236:	66660613          	addi	a2,a2,1638 # ffffffffc020b898 <commands+0x210>
ffffffffc020a23a:	33700593          	li	a1,823
ffffffffc020a23e:	00005517          	auipc	a0,0x5
ffffffffc020a242:	b8250513          	addi	a0,a0,-1150 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a246:	a58f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a24a <sfs_dirent_search_nolock.constprop.0>:
ffffffffc020a24a:	715d                	addi	sp,sp,-80
ffffffffc020a24c:	f052                	sd	s4,32(sp)
ffffffffc020a24e:	8a2a                	mv	s4,a0
ffffffffc020a250:	8532                	mv	a0,a2
ffffffffc020a252:	f44e                	sd	s3,40(sp)
ffffffffc020a254:	e85a                	sd	s6,16(sp)
ffffffffc020a256:	e45e                	sd	s7,8(sp)
ffffffffc020a258:	e486                	sd	ra,72(sp)
ffffffffc020a25a:	e0a2                	sd	s0,64(sp)
ffffffffc020a25c:	fc26                	sd	s1,56(sp)
ffffffffc020a25e:	f84a                	sd	s2,48(sp)
ffffffffc020a260:	ec56                	sd	s5,24(sp)
ffffffffc020a262:	e062                	sd	s8,0(sp)
ffffffffc020a264:	8b32                	mv	s6,a2
ffffffffc020a266:	89ae                	mv	s3,a1
ffffffffc020a268:	8bb6                	mv	s7,a3
ffffffffc020a26a:	0aa010ef          	jal	ra,ffffffffc020b314 <strlen>
ffffffffc020a26e:	0ff00793          	li	a5,255
ffffffffc020a272:	06a7ef63          	bltu	a5,a0,ffffffffc020a2f0 <sfs_dirent_search_nolock.constprop.0+0xa6>
ffffffffc020a276:	10400513          	li	a0,260
ffffffffc020a27a:	d15f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a27e:	892a                	mv	s2,a0
ffffffffc020a280:	c535                	beqz	a0,ffffffffc020a2ec <sfs_dirent_search_nolock.constprop.0+0xa2>
ffffffffc020a282:	0009b783          	ld	a5,0(s3) # 8000000 <_binary_bin_sfs_img_size+0x7f8ad00>
ffffffffc020a286:	0087aa83          	lw	s5,8(a5)
ffffffffc020a28a:	05505a63          	blez	s5,ffffffffc020a2de <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a28e:	4481                	li	s1,0
ffffffffc020a290:	00450c13          	addi	s8,a0,4
ffffffffc020a294:	a829                	j	ffffffffc020a2ae <sfs_dirent_search_nolock.constprop.0+0x64>
ffffffffc020a296:	00092783          	lw	a5,0(s2)
ffffffffc020a29a:	c799                	beqz	a5,ffffffffc020a2a8 <sfs_dirent_search_nolock.constprop.0+0x5e>
ffffffffc020a29c:	85e2                	mv	a1,s8
ffffffffc020a29e:	855a                	mv	a0,s6
ffffffffc020a2a0:	0bc010ef          	jal	ra,ffffffffc020b35c <strcmp>
ffffffffc020a2a4:	842a                	mv	s0,a0
ffffffffc020a2a6:	cd15                	beqz	a0,ffffffffc020a2e2 <sfs_dirent_search_nolock.constprop.0+0x98>
ffffffffc020a2a8:	2485                	addiw	s1,s1,1
ffffffffc020a2aa:	029a8a63          	beq	s5,s1,ffffffffc020a2de <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a2ae:	86ca                	mv	a3,s2
ffffffffc020a2b0:	8626                	mv	a2,s1
ffffffffc020a2b2:	85ce                	mv	a1,s3
ffffffffc020a2b4:	8552                	mv	a0,s4
ffffffffc020a2b6:	d97ff0ef          	jal	ra,ffffffffc020a04c <sfs_dirent_read_nolock>
ffffffffc020a2ba:	842a                	mv	s0,a0
ffffffffc020a2bc:	dd69                	beqz	a0,ffffffffc020a296 <sfs_dirent_search_nolock.constprop.0+0x4c>
ffffffffc020a2be:	854a                	mv	a0,s2
ffffffffc020a2c0:	d7ff70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a2c4:	60a6                	ld	ra,72(sp)
ffffffffc020a2c6:	8522                	mv	a0,s0
ffffffffc020a2c8:	6406                	ld	s0,64(sp)
ffffffffc020a2ca:	74e2                	ld	s1,56(sp)
ffffffffc020a2cc:	7942                	ld	s2,48(sp)
ffffffffc020a2ce:	79a2                	ld	s3,40(sp)
ffffffffc020a2d0:	7a02                	ld	s4,32(sp)
ffffffffc020a2d2:	6ae2                	ld	s5,24(sp)
ffffffffc020a2d4:	6b42                	ld	s6,16(sp)
ffffffffc020a2d6:	6ba2                	ld	s7,8(sp)
ffffffffc020a2d8:	6c02                	ld	s8,0(sp)
ffffffffc020a2da:	6161                	addi	sp,sp,80
ffffffffc020a2dc:	8082                	ret
ffffffffc020a2de:	5441                	li	s0,-16
ffffffffc020a2e0:	bff9                	j	ffffffffc020a2be <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a2e2:	00092783          	lw	a5,0(s2)
ffffffffc020a2e6:	00fba023          	sw	a5,0(s7)
ffffffffc020a2ea:	bfd1                	j	ffffffffc020a2be <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a2ec:	5471                	li	s0,-4
ffffffffc020a2ee:	bfd9                	j	ffffffffc020a2c4 <sfs_dirent_search_nolock.constprop.0+0x7a>
ffffffffc020a2f0:	00005697          	auipc	a3,0x5
ffffffffc020a2f4:	cb068693          	addi	a3,a3,-848 # ffffffffc020efa0 <dev_node_ops+0x7a0>
ffffffffc020a2f8:	00001617          	auipc	a2,0x1
ffffffffc020a2fc:	5a060613          	addi	a2,a2,1440 # ffffffffc020b898 <commands+0x210>
ffffffffc020a300:	1ba00593          	li	a1,442
ffffffffc020a304:	00005517          	auipc	a0,0x5
ffffffffc020a308:	abc50513          	addi	a0,a0,-1348 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a30c:	992f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a310 <sfs_truncfile>:
ffffffffc020a310:	7175                	addi	sp,sp,-144
ffffffffc020a312:	e506                	sd	ra,136(sp)
ffffffffc020a314:	e122                	sd	s0,128(sp)
ffffffffc020a316:	fca6                	sd	s1,120(sp)
ffffffffc020a318:	f8ca                	sd	s2,112(sp)
ffffffffc020a31a:	f4ce                	sd	s3,104(sp)
ffffffffc020a31c:	f0d2                	sd	s4,96(sp)
ffffffffc020a31e:	ecd6                	sd	s5,88(sp)
ffffffffc020a320:	e8da                	sd	s6,80(sp)
ffffffffc020a322:	e4de                	sd	s7,72(sp)
ffffffffc020a324:	e0e2                	sd	s8,64(sp)
ffffffffc020a326:	fc66                	sd	s9,56(sp)
ffffffffc020a328:	f86a                	sd	s10,48(sp)
ffffffffc020a32a:	f46e                	sd	s11,40(sp)
ffffffffc020a32c:	080007b7          	lui	a5,0x8000
ffffffffc020a330:	16b7e463          	bltu	a5,a1,ffffffffc020a498 <sfs_truncfile+0x188>
ffffffffc020a334:	06853c83          	ld	s9,104(a0)
ffffffffc020a338:	89aa                	mv	s3,a0
ffffffffc020a33a:	160c8163          	beqz	s9,ffffffffc020a49c <sfs_truncfile+0x18c>
ffffffffc020a33e:	0b0ca783          	lw	a5,176(s9) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc020a342:	14079d63          	bnez	a5,ffffffffc020a49c <sfs_truncfile+0x18c>
ffffffffc020a346:	4d38                	lw	a4,88(a0)
ffffffffc020a348:	6405                	lui	s0,0x1
ffffffffc020a34a:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a34e:	16f71763          	bne	a4,a5,ffffffffc020a4bc <sfs_truncfile+0x1ac>
ffffffffc020a352:	00053a83          	ld	s5,0(a0)
ffffffffc020a356:	147d                	addi	s0,s0,-1
ffffffffc020a358:	942e                	add	s0,s0,a1
ffffffffc020a35a:	000ae783          	lwu	a5,0(s5)
ffffffffc020a35e:	8031                	srli	s0,s0,0xc
ffffffffc020a360:	8a2e                	mv	s4,a1
ffffffffc020a362:	2401                	sext.w	s0,s0
ffffffffc020a364:	02b79763          	bne	a5,a1,ffffffffc020a392 <sfs_truncfile+0x82>
ffffffffc020a368:	008aa783          	lw	a5,8(s5)
ffffffffc020a36c:	4901                	li	s2,0
ffffffffc020a36e:	18879763          	bne	a5,s0,ffffffffc020a4fc <sfs_truncfile+0x1ec>
ffffffffc020a372:	60aa                	ld	ra,136(sp)
ffffffffc020a374:	640a                	ld	s0,128(sp)
ffffffffc020a376:	74e6                	ld	s1,120(sp)
ffffffffc020a378:	79a6                	ld	s3,104(sp)
ffffffffc020a37a:	7a06                	ld	s4,96(sp)
ffffffffc020a37c:	6ae6                	ld	s5,88(sp)
ffffffffc020a37e:	6b46                	ld	s6,80(sp)
ffffffffc020a380:	6ba6                	ld	s7,72(sp)
ffffffffc020a382:	6c06                	ld	s8,64(sp)
ffffffffc020a384:	7ce2                	ld	s9,56(sp)
ffffffffc020a386:	7d42                	ld	s10,48(sp)
ffffffffc020a388:	7da2                	ld	s11,40(sp)
ffffffffc020a38a:	854a                	mv	a0,s2
ffffffffc020a38c:	7946                	ld	s2,112(sp)
ffffffffc020a38e:	6149                	addi	sp,sp,144
ffffffffc020a390:	8082                	ret
ffffffffc020a392:	02050b13          	addi	s6,a0,32
ffffffffc020a396:	855a                	mv	a0,s6
ffffffffc020a398:	9ccfa0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020a39c:	008aa483          	lw	s1,8(s5)
ffffffffc020a3a0:	0a84e663          	bltu	s1,s0,ffffffffc020a44c <sfs_truncfile+0x13c>
ffffffffc020a3a4:	0c947163          	bgeu	s0,s1,ffffffffc020a466 <sfs_truncfile+0x156>
ffffffffc020a3a8:	4dad                	li	s11,11
ffffffffc020a3aa:	4b85                	li	s7,1
ffffffffc020a3ac:	a09d                	j	ffffffffc020a412 <sfs_truncfile+0x102>
ffffffffc020a3ae:	ff37091b          	addiw	s2,a4,-13
ffffffffc020a3b2:	0009079b          	sext.w	a5,s2
ffffffffc020a3b6:	3ff00713          	li	a4,1023
ffffffffc020a3ba:	04f76563          	bltu	a4,a5,ffffffffc020a404 <sfs_truncfile+0xf4>
ffffffffc020a3be:	03cd2c03          	lw	s8,60(s10)
ffffffffc020a3c2:	040c0163          	beqz	s8,ffffffffc020a404 <sfs_truncfile+0xf4>
ffffffffc020a3c6:	004ca783          	lw	a5,4(s9)
ffffffffc020a3ca:	18fc7963          	bgeu	s8,a5,ffffffffc020a55c <sfs_truncfile+0x24c>
ffffffffc020a3ce:	038cb503          	ld	a0,56(s9)
ffffffffc020a3d2:	85e2                	mv	a1,s8
ffffffffc020a3d4:	b71fe0ef          	jal	ra,ffffffffc0208f44 <bitmap_test>
ffffffffc020a3d8:	16051263          	bnez	a0,ffffffffc020a53c <sfs_truncfile+0x22c>
ffffffffc020a3dc:	02091793          	slli	a5,s2,0x20
ffffffffc020a3e0:	01e7d713          	srli	a4,a5,0x1e
ffffffffc020a3e4:	86e2                	mv	a3,s8
ffffffffc020a3e6:	4611                	li	a2,4
ffffffffc020a3e8:	082c                	addi	a1,sp,24
ffffffffc020a3ea:	8566                	mv	a0,s9
ffffffffc020a3ec:	e43a                	sd	a4,8(sp)
ffffffffc020a3ee:	ce02                	sw	zero,28(sp)
ffffffffc020a3f0:	043000ef          	jal	ra,ffffffffc020ac32 <sfs_rbuf>
ffffffffc020a3f4:	892a                	mv	s2,a0
ffffffffc020a3f6:	e141                	bnez	a0,ffffffffc020a476 <sfs_truncfile+0x166>
ffffffffc020a3f8:	47e2                	lw	a5,24(sp)
ffffffffc020a3fa:	6722                	ld	a4,8(sp)
ffffffffc020a3fc:	e3c9                	bnez	a5,ffffffffc020a47e <sfs_truncfile+0x16e>
ffffffffc020a3fe:	008d2603          	lw	a2,8(s10)
ffffffffc020a402:	367d                	addiw	a2,a2,-1
ffffffffc020a404:	00cd2423          	sw	a2,8(s10)
ffffffffc020a408:	0179b823          	sd	s7,16(s3)
ffffffffc020a40c:	34fd                	addiw	s1,s1,-1
ffffffffc020a40e:	04940a63          	beq	s0,s1,ffffffffc020a462 <sfs_truncfile+0x152>
ffffffffc020a412:	0009bd03          	ld	s10,0(s3)
ffffffffc020a416:	008d2703          	lw	a4,8(s10)
ffffffffc020a41a:	c369                	beqz	a4,ffffffffc020a4dc <sfs_truncfile+0x1cc>
ffffffffc020a41c:	fff7079b          	addiw	a5,a4,-1
ffffffffc020a420:	0007861b          	sext.w	a2,a5
ffffffffc020a424:	f8cde5e3          	bltu	s11,a2,ffffffffc020a3ae <sfs_truncfile+0x9e>
ffffffffc020a428:	02079713          	slli	a4,a5,0x20
ffffffffc020a42c:	01e75793          	srli	a5,a4,0x1e
ffffffffc020a430:	00fd0933          	add	s2,s10,a5
ffffffffc020a434:	00c92583          	lw	a1,12(s2)
ffffffffc020a438:	d5f1                	beqz	a1,ffffffffc020a404 <sfs_truncfile+0xf4>
ffffffffc020a43a:	8566                	mv	a0,s9
ffffffffc020a43c:	c16ff0ef          	jal	ra,ffffffffc0209852 <sfs_block_free>
ffffffffc020a440:	00092623          	sw	zero,12(s2)
ffffffffc020a444:	008d2603          	lw	a2,8(s10)
ffffffffc020a448:	367d                	addiw	a2,a2,-1
ffffffffc020a44a:	bf6d                	j	ffffffffc020a404 <sfs_truncfile+0xf4>
ffffffffc020a44c:	4681                	li	a3,0
ffffffffc020a44e:	8626                	mv	a2,s1
ffffffffc020a450:	85ce                	mv	a1,s3
ffffffffc020a452:	8566                	mv	a0,s9
ffffffffc020a454:	eb8ff0ef          	jal	ra,ffffffffc0209b0c <sfs_bmap_load_nolock>
ffffffffc020a458:	892a                	mv	s2,a0
ffffffffc020a45a:	ed11                	bnez	a0,ffffffffc020a476 <sfs_truncfile+0x166>
ffffffffc020a45c:	2485                	addiw	s1,s1,1
ffffffffc020a45e:	fe9417e3          	bne	s0,s1,ffffffffc020a44c <sfs_truncfile+0x13c>
ffffffffc020a462:	008aa483          	lw	s1,8(s5)
ffffffffc020a466:	0a941b63          	bne	s0,s1,ffffffffc020a51c <sfs_truncfile+0x20c>
ffffffffc020a46a:	014aa023          	sw	s4,0(s5)
ffffffffc020a46e:	4785                	li	a5,1
ffffffffc020a470:	00f9b823          	sd	a5,16(s3)
ffffffffc020a474:	4901                	li	s2,0
ffffffffc020a476:	855a                	mv	a0,s6
ffffffffc020a478:	8e8fa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a47c:	bddd                	j	ffffffffc020a372 <sfs_truncfile+0x62>
ffffffffc020a47e:	86e2                	mv	a3,s8
ffffffffc020a480:	4611                	li	a2,4
ffffffffc020a482:	086c                	addi	a1,sp,28
ffffffffc020a484:	8566                	mv	a0,s9
ffffffffc020a486:	02d000ef          	jal	ra,ffffffffc020acb2 <sfs_wbuf>
ffffffffc020a48a:	892a                	mv	s2,a0
ffffffffc020a48c:	f56d                	bnez	a0,ffffffffc020a476 <sfs_truncfile+0x166>
ffffffffc020a48e:	45e2                	lw	a1,24(sp)
ffffffffc020a490:	8566                	mv	a0,s9
ffffffffc020a492:	bc0ff0ef          	jal	ra,ffffffffc0209852 <sfs_block_free>
ffffffffc020a496:	b7a5                	j	ffffffffc020a3fe <sfs_truncfile+0xee>
ffffffffc020a498:	5975                	li	s2,-3
ffffffffc020a49a:	bde1                	j	ffffffffc020a372 <sfs_truncfile+0x62>
ffffffffc020a49c:	00004697          	auipc	a3,0x4
ffffffffc020a4a0:	74468693          	addi	a3,a3,1860 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc020a4a4:	00001617          	auipc	a2,0x1
ffffffffc020a4a8:	3f460613          	addi	a2,a2,1012 # ffffffffc020b898 <commands+0x210>
ffffffffc020a4ac:	3a500593          	li	a1,933
ffffffffc020a4b0:	00005517          	auipc	a0,0x5
ffffffffc020a4b4:	91050513          	addi	a0,a0,-1776 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a4b8:	fe7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a4bc:	00005697          	auipc	a3,0x5
ffffffffc020a4c0:	8cc68693          	addi	a3,a3,-1844 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc020a4c4:	00001617          	auipc	a2,0x1
ffffffffc020a4c8:	3d460613          	addi	a2,a2,980 # ffffffffc020b898 <commands+0x210>
ffffffffc020a4cc:	3a600593          	li	a1,934
ffffffffc020a4d0:	00005517          	auipc	a0,0x5
ffffffffc020a4d4:	8f050513          	addi	a0,a0,-1808 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a4d8:	fc7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a4dc:	00005697          	auipc	a3,0x5
ffffffffc020a4e0:	b0468693          	addi	a3,a3,-1276 # ffffffffc020efe0 <dev_node_ops+0x7e0>
ffffffffc020a4e4:	00001617          	auipc	a2,0x1
ffffffffc020a4e8:	3b460613          	addi	a2,a2,948 # ffffffffc020b898 <commands+0x210>
ffffffffc020a4ec:	17b00593          	li	a1,379
ffffffffc020a4f0:	00005517          	auipc	a0,0x5
ffffffffc020a4f4:	8d050513          	addi	a0,a0,-1840 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a4f8:	fa7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a4fc:	00005697          	auipc	a3,0x5
ffffffffc020a500:	acc68693          	addi	a3,a3,-1332 # ffffffffc020efc8 <dev_node_ops+0x7c8>
ffffffffc020a504:	00001617          	auipc	a2,0x1
ffffffffc020a508:	39460613          	addi	a2,a2,916 # ffffffffc020b898 <commands+0x210>
ffffffffc020a50c:	3ad00593          	li	a1,941
ffffffffc020a510:	00005517          	auipc	a0,0x5
ffffffffc020a514:	8b050513          	addi	a0,a0,-1872 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a518:	f87f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a51c:	00005697          	auipc	a3,0x5
ffffffffc020a520:	b1468693          	addi	a3,a3,-1260 # ffffffffc020f030 <dev_node_ops+0x830>
ffffffffc020a524:	00001617          	auipc	a2,0x1
ffffffffc020a528:	37460613          	addi	a2,a2,884 # ffffffffc020b898 <commands+0x210>
ffffffffc020a52c:	3c600593          	li	a1,966
ffffffffc020a530:	00005517          	auipc	a0,0x5
ffffffffc020a534:	89050513          	addi	a0,a0,-1904 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a538:	f67f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a53c:	00005697          	auipc	a3,0x5
ffffffffc020a540:	abc68693          	addi	a3,a3,-1348 # ffffffffc020eff8 <dev_node_ops+0x7f8>
ffffffffc020a544:	00001617          	auipc	a2,0x1
ffffffffc020a548:	35460613          	addi	a2,a2,852 # ffffffffc020b898 <commands+0x210>
ffffffffc020a54c:	12b00593          	li	a1,299
ffffffffc020a550:	00005517          	auipc	a0,0x5
ffffffffc020a554:	87050513          	addi	a0,a0,-1936 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a558:	f47f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a55c:	8762                	mv	a4,s8
ffffffffc020a55e:	86be                	mv	a3,a5
ffffffffc020a560:	00005617          	auipc	a2,0x5
ffffffffc020a564:	89060613          	addi	a2,a2,-1904 # ffffffffc020edf0 <dev_node_ops+0x5f0>
ffffffffc020a568:	05300593          	li	a1,83
ffffffffc020a56c:	00005517          	auipc	a0,0x5
ffffffffc020a570:	85450513          	addi	a0,a0,-1964 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a574:	f2bf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a578 <sfs_load_inode>:
ffffffffc020a578:	7139                	addi	sp,sp,-64
ffffffffc020a57a:	fc06                	sd	ra,56(sp)
ffffffffc020a57c:	f822                	sd	s0,48(sp)
ffffffffc020a57e:	f426                	sd	s1,40(sp)
ffffffffc020a580:	f04a                	sd	s2,32(sp)
ffffffffc020a582:	84b2                	mv	s1,a2
ffffffffc020a584:	892a                	mv	s2,a0
ffffffffc020a586:	ec4e                	sd	s3,24(sp)
ffffffffc020a588:	e852                	sd	s4,16(sp)
ffffffffc020a58a:	89ae                	mv	s3,a1
ffffffffc020a58c:	e456                	sd	s5,8(sp)
ffffffffc020a58e:	0d5000ef          	jal	ra,ffffffffc020ae62 <lock_sfs_fs>
ffffffffc020a592:	45a9                	li	a1,10
ffffffffc020a594:	8526                	mv	a0,s1
ffffffffc020a596:	0a893403          	ld	s0,168(s2)
ffffffffc020a59a:	0e9000ef          	jal	ra,ffffffffc020ae82 <hash32>
ffffffffc020a59e:	02051793          	slli	a5,a0,0x20
ffffffffc020a5a2:	01c7d713          	srli	a4,a5,0x1c
ffffffffc020a5a6:	9722                	add	a4,a4,s0
ffffffffc020a5a8:	843a                	mv	s0,a4
ffffffffc020a5aa:	a029                	j	ffffffffc020a5b4 <sfs_load_inode+0x3c>
ffffffffc020a5ac:	fc042783          	lw	a5,-64(s0)
ffffffffc020a5b0:	10978863          	beq	a5,s1,ffffffffc020a6c0 <sfs_load_inode+0x148>
ffffffffc020a5b4:	6400                	ld	s0,8(s0)
ffffffffc020a5b6:	fe871be3          	bne	a4,s0,ffffffffc020a5ac <sfs_load_inode+0x34>
ffffffffc020a5ba:	04000513          	li	a0,64
ffffffffc020a5be:	9d1f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a5c2:	8aaa                	mv	s5,a0
ffffffffc020a5c4:	16050563          	beqz	a0,ffffffffc020a72e <sfs_load_inode+0x1b6>
ffffffffc020a5c8:	00492683          	lw	a3,4(s2)
ffffffffc020a5cc:	18048363          	beqz	s1,ffffffffc020a752 <sfs_load_inode+0x1da>
ffffffffc020a5d0:	18d4f163          	bgeu	s1,a3,ffffffffc020a752 <sfs_load_inode+0x1da>
ffffffffc020a5d4:	03893503          	ld	a0,56(s2)
ffffffffc020a5d8:	85a6                	mv	a1,s1
ffffffffc020a5da:	96bfe0ef          	jal	ra,ffffffffc0208f44 <bitmap_test>
ffffffffc020a5de:	18051763          	bnez	a0,ffffffffc020a76c <sfs_load_inode+0x1f4>
ffffffffc020a5e2:	4701                	li	a4,0
ffffffffc020a5e4:	86a6                	mv	a3,s1
ffffffffc020a5e6:	04000613          	li	a2,64
ffffffffc020a5ea:	85d6                	mv	a1,s5
ffffffffc020a5ec:	854a                	mv	a0,s2
ffffffffc020a5ee:	644000ef          	jal	ra,ffffffffc020ac32 <sfs_rbuf>
ffffffffc020a5f2:	842a                	mv	s0,a0
ffffffffc020a5f4:	0e051563          	bnez	a0,ffffffffc020a6de <sfs_load_inode+0x166>
ffffffffc020a5f8:	006ad783          	lhu	a5,6(s5)
ffffffffc020a5fc:	12078b63          	beqz	a5,ffffffffc020a732 <sfs_load_inode+0x1ba>
ffffffffc020a600:	6405                	lui	s0,0x1
ffffffffc020a602:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a606:	8f8fd0ef          	jal	ra,ffffffffc02076fe <__alloc_inode>
ffffffffc020a60a:	8a2a                	mv	s4,a0
ffffffffc020a60c:	c961                	beqz	a0,ffffffffc020a6dc <sfs_load_inode+0x164>
ffffffffc020a60e:	004ad683          	lhu	a3,4(s5)
ffffffffc020a612:	4785                	li	a5,1
ffffffffc020a614:	0cf69c63          	bne	a3,a5,ffffffffc020a6ec <sfs_load_inode+0x174>
ffffffffc020a618:	864a                	mv	a2,s2
ffffffffc020a61a:	00005597          	auipc	a1,0x5
ffffffffc020a61e:	b2658593          	addi	a1,a1,-1242 # ffffffffc020f140 <sfs_node_fileops>
ffffffffc020a622:	8f8fd0ef          	jal	ra,ffffffffc020771a <inode_init>
ffffffffc020a626:	058a2783          	lw	a5,88(s4)
ffffffffc020a62a:	23540413          	addi	s0,s0,565
ffffffffc020a62e:	0e879063          	bne	a5,s0,ffffffffc020a70e <sfs_load_inode+0x196>
ffffffffc020a632:	4785                	li	a5,1
ffffffffc020a634:	00fa2c23          	sw	a5,24(s4)
ffffffffc020a638:	015a3023          	sd	s5,0(s4)
ffffffffc020a63c:	009a2423          	sw	s1,8(s4)
ffffffffc020a640:	000a3823          	sd	zero,16(s4)
ffffffffc020a644:	4585                	li	a1,1
ffffffffc020a646:	020a0513          	addi	a0,s4,32
ffffffffc020a64a:	f11f90ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc020a64e:	058a2703          	lw	a4,88(s4)
ffffffffc020a652:	6785                	lui	a5,0x1
ffffffffc020a654:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a658:	14f71663          	bne	a4,a5,ffffffffc020a7a4 <sfs_load_inode+0x22c>
ffffffffc020a65c:	0a093703          	ld	a4,160(s2)
ffffffffc020a660:	038a0793          	addi	a5,s4,56
ffffffffc020a664:	008a2503          	lw	a0,8(s4)
ffffffffc020a668:	e31c                	sd	a5,0(a4)
ffffffffc020a66a:	0af93023          	sd	a5,160(s2)
ffffffffc020a66e:	09890793          	addi	a5,s2,152
ffffffffc020a672:	0a893403          	ld	s0,168(s2)
ffffffffc020a676:	45a9                	li	a1,10
ffffffffc020a678:	04ea3023          	sd	a4,64(s4)
ffffffffc020a67c:	02fa3c23          	sd	a5,56(s4)
ffffffffc020a680:	003000ef          	jal	ra,ffffffffc020ae82 <hash32>
ffffffffc020a684:	02051713          	slli	a4,a0,0x20
ffffffffc020a688:	01c75793          	srli	a5,a4,0x1c
ffffffffc020a68c:	97a2                	add	a5,a5,s0
ffffffffc020a68e:	6798                	ld	a4,8(a5)
ffffffffc020a690:	048a0693          	addi	a3,s4,72
ffffffffc020a694:	e314                	sd	a3,0(a4)
ffffffffc020a696:	e794                	sd	a3,8(a5)
ffffffffc020a698:	04ea3823          	sd	a4,80(s4)
ffffffffc020a69c:	04fa3423          	sd	a5,72(s4)
ffffffffc020a6a0:	854a                	mv	a0,s2
ffffffffc020a6a2:	7d0000ef          	jal	ra,ffffffffc020ae72 <unlock_sfs_fs>
ffffffffc020a6a6:	4401                	li	s0,0
ffffffffc020a6a8:	0149b023          	sd	s4,0(s3)
ffffffffc020a6ac:	70e2                	ld	ra,56(sp)
ffffffffc020a6ae:	8522                	mv	a0,s0
ffffffffc020a6b0:	7442                	ld	s0,48(sp)
ffffffffc020a6b2:	74a2                	ld	s1,40(sp)
ffffffffc020a6b4:	7902                	ld	s2,32(sp)
ffffffffc020a6b6:	69e2                	ld	s3,24(sp)
ffffffffc020a6b8:	6a42                	ld	s4,16(sp)
ffffffffc020a6ba:	6aa2                	ld	s5,8(sp)
ffffffffc020a6bc:	6121                	addi	sp,sp,64
ffffffffc020a6be:	8082                	ret
ffffffffc020a6c0:	fb840a13          	addi	s4,s0,-72
ffffffffc020a6c4:	8552                	mv	a0,s4
ffffffffc020a6c6:	8b6fd0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc020a6ca:	4785                	li	a5,1
ffffffffc020a6cc:	fcf51ae3          	bne	a0,a5,ffffffffc020a6a0 <sfs_load_inode+0x128>
ffffffffc020a6d0:	fd042783          	lw	a5,-48(s0)
ffffffffc020a6d4:	2785                	addiw	a5,a5,1
ffffffffc020a6d6:	fcf42823          	sw	a5,-48(s0)
ffffffffc020a6da:	b7d9                	j	ffffffffc020a6a0 <sfs_load_inode+0x128>
ffffffffc020a6dc:	5471                	li	s0,-4
ffffffffc020a6de:	8556                	mv	a0,s5
ffffffffc020a6e0:	95ff70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a6e4:	854a                	mv	a0,s2
ffffffffc020a6e6:	78c000ef          	jal	ra,ffffffffc020ae72 <unlock_sfs_fs>
ffffffffc020a6ea:	b7c9                	j	ffffffffc020a6ac <sfs_load_inode+0x134>
ffffffffc020a6ec:	4789                	li	a5,2
ffffffffc020a6ee:	08f69f63          	bne	a3,a5,ffffffffc020a78c <sfs_load_inode+0x214>
ffffffffc020a6f2:	864a                	mv	a2,s2
ffffffffc020a6f4:	00005597          	auipc	a1,0x5
ffffffffc020a6f8:	9cc58593          	addi	a1,a1,-1588 # ffffffffc020f0c0 <sfs_node_dirops>
ffffffffc020a6fc:	81efd0ef          	jal	ra,ffffffffc020771a <inode_init>
ffffffffc020a700:	058a2703          	lw	a4,88(s4)
ffffffffc020a704:	6785                	lui	a5,0x1
ffffffffc020a706:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a70a:	f2f704e3          	beq	a4,a5,ffffffffc020a632 <sfs_load_inode+0xba>
ffffffffc020a70e:	00004697          	auipc	a3,0x4
ffffffffc020a712:	67a68693          	addi	a3,a3,1658 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc020a716:	00001617          	auipc	a2,0x1
ffffffffc020a71a:	18260613          	addi	a2,a2,386 # ffffffffc020b898 <commands+0x210>
ffffffffc020a71e:	07700593          	li	a1,119
ffffffffc020a722:	00004517          	auipc	a0,0x4
ffffffffc020a726:	69e50513          	addi	a0,a0,1694 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a72a:	d75f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a72e:	5471                	li	s0,-4
ffffffffc020a730:	bf55                	j	ffffffffc020a6e4 <sfs_load_inode+0x16c>
ffffffffc020a732:	00005697          	auipc	a3,0x5
ffffffffc020a736:	91668693          	addi	a3,a3,-1770 # ffffffffc020f048 <dev_node_ops+0x848>
ffffffffc020a73a:	00001617          	auipc	a2,0x1
ffffffffc020a73e:	15e60613          	addi	a2,a2,350 # ffffffffc020b898 <commands+0x210>
ffffffffc020a742:	0ad00593          	li	a1,173
ffffffffc020a746:	00004517          	auipc	a0,0x4
ffffffffc020a74a:	67a50513          	addi	a0,a0,1658 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a74e:	d51f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a752:	8726                	mv	a4,s1
ffffffffc020a754:	00004617          	auipc	a2,0x4
ffffffffc020a758:	69c60613          	addi	a2,a2,1692 # ffffffffc020edf0 <dev_node_ops+0x5f0>
ffffffffc020a75c:	05300593          	li	a1,83
ffffffffc020a760:	00004517          	auipc	a0,0x4
ffffffffc020a764:	66050513          	addi	a0,a0,1632 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a768:	d37f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a76c:	00004697          	auipc	a3,0x4
ffffffffc020a770:	6bc68693          	addi	a3,a3,1724 # ffffffffc020ee28 <dev_node_ops+0x628>
ffffffffc020a774:	00001617          	auipc	a2,0x1
ffffffffc020a778:	12460613          	addi	a2,a2,292 # ffffffffc020b898 <commands+0x210>
ffffffffc020a77c:	0a800593          	li	a1,168
ffffffffc020a780:	00004517          	auipc	a0,0x4
ffffffffc020a784:	64050513          	addi	a0,a0,1600 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a788:	d17f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a78c:	00004617          	auipc	a2,0x4
ffffffffc020a790:	64c60613          	addi	a2,a2,1612 # ffffffffc020edd8 <dev_node_ops+0x5d8>
ffffffffc020a794:	02e00593          	li	a1,46
ffffffffc020a798:	00004517          	auipc	a0,0x4
ffffffffc020a79c:	62850513          	addi	a0,a0,1576 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a7a0:	cfff50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a7a4:	00004697          	auipc	a3,0x4
ffffffffc020a7a8:	5e468693          	addi	a3,a3,1508 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc020a7ac:	00001617          	auipc	a2,0x1
ffffffffc020a7b0:	0ec60613          	addi	a2,a2,236 # ffffffffc020b898 <commands+0x210>
ffffffffc020a7b4:	0b100593          	li	a1,177
ffffffffc020a7b8:	00004517          	auipc	a0,0x4
ffffffffc020a7bc:	60850513          	addi	a0,a0,1544 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a7c0:	cdff50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a7c4 <sfs_lookup>:
ffffffffc020a7c4:	7139                	addi	sp,sp,-64
ffffffffc020a7c6:	ec4e                	sd	s3,24(sp)
ffffffffc020a7c8:	06853983          	ld	s3,104(a0)
ffffffffc020a7cc:	fc06                	sd	ra,56(sp)
ffffffffc020a7ce:	f822                	sd	s0,48(sp)
ffffffffc020a7d0:	f426                	sd	s1,40(sp)
ffffffffc020a7d2:	f04a                	sd	s2,32(sp)
ffffffffc020a7d4:	e852                	sd	s4,16(sp)
ffffffffc020a7d6:	0a098c63          	beqz	s3,ffffffffc020a88e <sfs_lookup+0xca>
ffffffffc020a7da:	0b09a783          	lw	a5,176(s3)
ffffffffc020a7de:	ebc5                	bnez	a5,ffffffffc020a88e <sfs_lookup+0xca>
ffffffffc020a7e0:	0005c783          	lbu	a5,0(a1)
ffffffffc020a7e4:	84ae                	mv	s1,a1
ffffffffc020a7e6:	c7c1                	beqz	a5,ffffffffc020a86e <sfs_lookup+0xaa>
ffffffffc020a7e8:	02f00713          	li	a4,47
ffffffffc020a7ec:	08e78163          	beq	a5,a4,ffffffffc020a86e <sfs_lookup+0xaa>
ffffffffc020a7f0:	842a                	mv	s0,a0
ffffffffc020a7f2:	8a32                	mv	s4,a2
ffffffffc020a7f4:	f89fc0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc020a7f8:	4c38                	lw	a4,88(s0)
ffffffffc020a7fa:	6785                	lui	a5,0x1
ffffffffc020a7fc:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a800:	0af71763          	bne	a4,a5,ffffffffc020a8ae <sfs_lookup+0xea>
ffffffffc020a804:	6018                	ld	a4,0(s0)
ffffffffc020a806:	4789                	li	a5,2
ffffffffc020a808:	00475703          	lhu	a4,4(a4)
ffffffffc020a80c:	04f71c63          	bne	a4,a5,ffffffffc020a864 <sfs_lookup+0xa0>
ffffffffc020a810:	02040913          	addi	s2,s0,32
ffffffffc020a814:	854a                	mv	a0,s2
ffffffffc020a816:	d4ff90ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020a81a:	8626                	mv	a2,s1
ffffffffc020a81c:	0054                	addi	a3,sp,4
ffffffffc020a81e:	85a2                	mv	a1,s0
ffffffffc020a820:	854e                	mv	a0,s3
ffffffffc020a822:	a29ff0ef          	jal	ra,ffffffffc020a24a <sfs_dirent_search_nolock.constprop.0>
ffffffffc020a826:	84aa                	mv	s1,a0
ffffffffc020a828:	854a                	mv	a0,s2
ffffffffc020a82a:	d37f90ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a82e:	cc89                	beqz	s1,ffffffffc020a848 <sfs_lookup+0x84>
ffffffffc020a830:	8522                	mv	a0,s0
ffffffffc020a832:	818fd0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020a836:	70e2                	ld	ra,56(sp)
ffffffffc020a838:	7442                	ld	s0,48(sp)
ffffffffc020a83a:	7902                	ld	s2,32(sp)
ffffffffc020a83c:	69e2                	ld	s3,24(sp)
ffffffffc020a83e:	6a42                	ld	s4,16(sp)
ffffffffc020a840:	8526                	mv	a0,s1
ffffffffc020a842:	74a2                	ld	s1,40(sp)
ffffffffc020a844:	6121                	addi	sp,sp,64
ffffffffc020a846:	8082                	ret
ffffffffc020a848:	4612                	lw	a2,4(sp)
ffffffffc020a84a:	002c                	addi	a1,sp,8
ffffffffc020a84c:	854e                	mv	a0,s3
ffffffffc020a84e:	d2bff0ef          	jal	ra,ffffffffc020a578 <sfs_load_inode>
ffffffffc020a852:	84aa                	mv	s1,a0
ffffffffc020a854:	8522                	mv	a0,s0
ffffffffc020a856:	ff5fc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020a85a:	fcf1                	bnez	s1,ffffffffc020a836 <sfs_lookup+0x72>
ffffffffc020a85c:	67a2                	ld	a5,8(sp)
ffffffffc020a85e:	00fa3023          	sd	a5,0(s4)
ffffffffc020a862:	bfd1                	j	ffffffffc020a836 <sfs_lookup+0x72>
ffffffffc020a864:	8522                	mv	a0,s0
ffffffffc020a866:	fe5fc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020a86a:	54b9                	li	s1,-18
ffffffffc020a86c:	b7e9                	j	ffffffffc020a836 <sfs_lookup+0x72>
ffffffffc020a86e:	00004697          	auipc	a3,0x4
ffffffffc020a872:	7f268693          	addi	a3,a3,2034 # ffffffffc020f060 <dev_node_ops+0x860>
ffffffffc020a876:	00001617          	auipc	a2,0x1
ffffffffc020a87a:	02260613          	addi	a2,a2,34 # ffffffffc020b898 <commands+0x210>
ffffffffc020a87e:	3d700593          	li	a1,983
ffffffffc020a882:	00004517          	auipc	a0,0x4
ffffffffc020a886:	53e50513          	addi	a0,a0,1342 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a88a:	c15f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a88e:	00004697          	auipc	a3,0x4
ffffffffc020a892:	35268693          	addi	a3,a3,850 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc020a896:	00001617          	auipc	a2,0x1
ffffffffc020a89a:	00260613          	addi	a2,a2,2 # ffffffffc020b898 <commands+0x210>
ffffffffc020a89e:	3d600593          	li	a1,982
ffffffffc020a8a2:	00004517          	auipc	a0,0x4
ffffffffc020a8a6:	51e50513          	addi	a0,a0,1310 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a8aa:	bf5f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a8ae:	00004697          	auipc	a3,0x4
ffffffffc020a8b2:	4da68693          	addi	a3,a3,1242 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc020a8b6:	00001617          	auipc	a2,0x1
ffffffffc020a8ba:	fe260613          	addi	a2,a2,-30 # ffffffffc020b898 <commands+0x210>
ffffffffc020a8be:	3d900593          	li	a1,985
ffffffffc020a8c2:	00004517          	auipc	a0,0x4
ffffffffc020a8c6:	4fe50513          	addi	a0,a0,1278 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020a8ca:	bd5f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a8ce <sfs_namefile>:
ffffffffc020a8ce:	6d98                	ld	a4,24(a1)
ffffffffc020a8d0:	7175                	addi	sp,sp,-144
ffffffffc020a8d2:	e506                	sd	ra,136(sp)
ffffffffc020a8d4:	e122                	sd	s0,128(sp)
ffffffffc020a8d6:	fca6                	sd	s1,120(sp)
ffffffffc020a8d8:	f8ca                	sd	s2,112(sp)
ffffffffc020a8da:	f4ce                	sd	s3,104(sp)
ffffffffc020a8dc:	f0d2                	sd	s4,96(sp)
ffffffffc020a8de:	ecd6                	sd	s5,88(sp)
ffffffffc020a8e0:	e8da                	sd	s6,80(sp)
ffffffffc020a8e2:	e4de                	sd	s7,72(sp)
ffffffffc020a8e4:	e0e2                	sd	s8,64(sp)
ffffffffc020a8e6:	fc66                	sd	s9,56(sp)
ffffffffc020a8e8:	f86a                	sd	s10,48(sp)
ffffffffc020a8ea:	f46e                	sd	s11,40(sp)
ffffffffc020a8ec:	e42e                	sd	a1,8(sp)
ffffffffc020a8ee:	4789                	li	a5,2
ffffffffc020a8f0:	1ae7f363          	bgeu	a5,a4,ffffffffc020aa96 <sfs_namefile+0x1c8>
ffffffffc020a8f4:	89aa                	mv	s3,a0
ffffffffc020a8f6:	10400513          	li	a0,260
ffffffffc020a8fa:	e94f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a8fe:	842a                	mv	s0,a0
ffffffffc020a900:	18050b63          	beqz	a0,ffffffffc020aa96 <sfs_namefile+0x1c8>
ffffffffc020a904:	0689b483          	ld	s1,104(s3)
ffffffffc020a908:	1e048963          	beqz	s1,ffffffffc020aafa <sfs_namefile+0x22c>
ffffffffc020a90c:	0b04a783          	lw	a5,176(s1)
ffffffffc020a910:	1e079563          	bnez	a5,ffffffffc020aafa <sfs_namefile+0x22c>
ffffffffc020a914:	0589ac83          	lw	s9,88(s3)
ffffffffc020a918:	6785                	lui	a5,0x1
ffffffffc020a91a:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a91e:	1afc9e63          	bne	s9,a5,ffffffffc020aada <sfs_namefile+0x20c>
ffffffffc020a922:	6722                	ld	a4,8(sp)
ffffffffc020a924:	854e                	mv	a0,s3
ffffffffc020a926:	8ace                	mv	s5,s3
ffffffffc020a928:	6f1c                	ld	a5,24(a4)
ffffffffc020a92a:	00073b03          	ld	s6,0(a4)
ffffffffc020a92e:	02098a13          	addi	s4,s3,32
ffffffffc020a932:	ffe78b93          	addi	s7,a5,-2
ffffffffc020a936:	9b3e                	add	s6,s6,a5
ffffffffc020a938:	00004d17          	auipc	s10,0x4
ffffffffc020a93c:	748d0d13          	addi	s10,s10,1864 # ffffffffc020f080 <dev_node_ops+0x880>
ffffffffc020a940:	e3dfc0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc020a944:	00440c13          	addi	s8,s0,4
ffffffffc020a948:	e066                	sd	s9,0(sp)
ffffffffc020a94a:	8552                	mv	a0,s4
ffffffffc020a94c:	c19f90ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020a950:	0854                	addi	a3,sp,20
ffffffffc020a952:	866a                	mv	a2,s10
ffffffffc020a954:	85d6                	mv	a1,s5
ffffffffc020a956:	8526                	mv	a0,s1
ffffffffc020a958:	8f3ff0ef          	jal	ra,ffffffffc020a24a <sfs_dirent_search_nolock.constprop.0>
ffffffffc020a95c:	8daa                	mv	s11,a0
ffffffffc020a95e:	8552                	mv	a0,s4
ffffffffc020a960:	c01f90ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a964:	020d8863          	beqz	s11,ffffffffc020a994 <sfs_namefile+0xc6>
ffffffffc020a968:	854e                	mv	a0,s3
ffffffffc020a96a:	ee1fc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020a96e:	8522                	mv	a0,s0
ffffffffc020a970:	ecef70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a974:	60aa                	ld	ra,136(sp)
ffffffffc020a976:	640a                	ld	s0,128(sp)
ffffffffc020a978:	74e6                	ld	s1,120(sp)
ffffffffc020a97a:	7946                	ld	s2,112(sp)
ffffffffc020a97c:	79a6                	ld	s3,104(sp)
ffffffffc020a97e:	7a06                	ld	s4,96(sp)
ffffffffc020a980:	6ae6                	ld	s5,88(sp)
ffffffffc020a982:	6b46                	ld	s6,80(sp)
ffffffffc020a984:	6ba6                	ld	s7,72(sp)
ffffffffc020a986:	6c06                	ld	s8,64(sp)
ffffffffc020a988:	7ce2                	ld	s9,56(sp)
ffffffffc020a98a:	7d42                	ld	s10,48(sp)
ffffffffc020a98c:	856e                	mv	a0,s11
ffffffffc020a98e:	7da2                	ld	s11,40(sp)
ffffffffc020a990:	6149                	addi	sp,sp,144
ffffffffc020a992:	8082                	ret
ffffffffc020a994:	4652                	lw	a2,20(sp)
ffffffffc020a996:	082c                	addi	a1,sp,24
ffffffffc020a998:	8526                	mv	a0,s1
ffffffffc020a99a:	bdfff0ef          	jal	ra,ffffffffc020a578 <sfs_load_inode>
ffffffffc020a99e:	8daa                	mv	s11,a0
ffffffffc020a9a0:	f561                	bnez	a0,ffffffffc020a968 <sfs_namefile+0x9a>
ffffffffc020a9a2:	854e                	mv	a0,s3
ffffffffc020a9a4:	008aa903          	lw	s2,8(s5)
ffffffffc020a9a8:	ea3fc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020a9ac:	6ce2                	ld	s9,24(sp)
ffffffffc020a9ae:	0b3c8463          	beq	s9,s3,ffffffffc020aa56 <sfs_namefile+0x188>
ffffffffc020a9b2:	100c8463          	beqz	s9,ffffffffc020aaba <sfs_namefile+0x1ec>
ffffffffc020a9b6:	058ca703          	lw	a4,88(s9)
ffffffffc020a9ba:	6782                	ld	a5,0(sp)
ffffffffc020a9bc:	0ef71f63          	bne	a4,a5,ffffffffc020aaba <sfs_namefile+0x1ec>
ffffffffc020a9c0:	008ca703          	lw	a4,8(s9)
ffffffffc020a9c4:	8ae6                	mv	s5,s9
ffffffffc020a9c6:	0d270a63          	beq	a4,s2,ffffffffc020aa9a <sfs_namefile+0x1cc>
ffffffffc020a9ca:	000cb703          	ld	a4,0(s9)
ffffffffc020a9ce:	4789                	li	a5,2
ffffffffc020a9d0:	00475703          	lhu	a4,4(a4)
ffffffffc020a9d4:	0cf71363          	bne	a4,a5,ffffffffc020aa9a <sfs_namefile+0x1cc>
ffffffffc020a9d8:	020c8a13          	addi	s4,s9,32
ffffffffc020a9dc:	8552                	mv	a0,s4
ffffffffc020a9de:	b87f90ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020a9e2:	000cb703          	ld	a4,0(s9)
ffffffffc020a9e6:	00872983          	lw	s3,8(a4)
ffffffffc020a9ea:	01304963          	bgtz	s3,ffffffffc020a9fc <sfs_namefile+0x12e>
ffffffffc020a9ee:	a899                	j	ffffffffc020aa44 <sfs_namefile+0x176>
ffffffffc020a9f0:	4018                	lw	a4,0(s0)
ffffffffc020a9f2:	01270e63          	beq	a4,s2,ffffffffc020aa0e <sfs_namefile+0x140>
ffffffffc020a9f6:	2d85                	addiw	s11,s11,1
ffffffffc020a9f8:	05b98663          	beq	s3,s11,ffffffffc020aa44 <sfs_namefile+0x176>
ffffffffc020a9fc:	86a2                	mv	a3,s0
ffffffffc020a9fe:	866e                	mv	a2,s11
ffffffffc020aa00:	85e6                	mv	a1,s9
ffffffffc020aa02:	8526                	mv	a0,s1
ffffffffc020aa04:	e48ff0ef          	jal	ra,ffffffffc020a04c <sfs_dirent_read_nolock>
ffffffffc020aa08:	872a                	mv	a4,a0
ffffffffc020aa0a:	d17d                	beqz	a0,ffffffffc020a9f0 <sfs_namefile+0x122>
ffffffffc020aa0c:	a82d                	j	ffffffffc020aa46 <sfs_namefile+0x178>
ffffffffc020aa0e:	8552                	mv	a0,s4
ffffffffc020aa10:	b51f90ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020aa14:	8562                	mv	a0,s8
ffffffffc020aa16:	0ff000ef          	jal	ra,ffffffffc020b314 <strlen>
ffffffffc020aa1a:	00150793          	addi	a5,a0,1
ffffffffc020aa1e:	862a                	mv	a2,a0
ffffffffc020aa20:	06fbe863          	bltu	s7,a5,ffffffffc020aa90 <sfs_namefile+0x1c2>
ffffffffc020aa24:	fff64913          	not	s2,a2
ffffffffc020aa28:	995a                	add	s2,s2,s6
ffffffffc020aa2a:	85e2                	mv	a1,s8
ffffffffc020aa2c:	854a                	mv	a0,s2
ffffffffc020aa2e:	40fb8bb3          	sub	s7,s7,a5
ffffffffc020aa32:	1d7000ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc020aa36:	02f00793          	li	a5,47
ffffffffc020aa3a:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc020aa3e:	89e6                	mv	s3,s9
ffffffffc020aa40:	8b4a                	mv	s6,s2
ffffffffc020aa42:	b721                	j	ffffffffc020a94a <sfs_namefile+0x7c>
ffffffffc020aa44:	5741                	li	a4,-16
ffffffffc020aa46:	8552                	mv	a0,s4
ffffffffc020aa48:	e03a                	sd	a4,0(sp)
ffffffffc020aa4a:	b17f90ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020aa4e:	6702                	ld	a4,0(sp)
ffffffffc020aa50:	89e6                	mv	s3,s9
ffffffffc020aa52:	8dba                	mv	s11,a4
ffffffffc020aa54:	bf11                	j	ffffffffc020a968 <sfs_namefile+0x9a>
ffffffffc020aa56:	854e                	mv	a0,s3
ffffffffc020aa58:	df3fc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020aa5c:	64a2                	ld	s1,8(sp)
ffffffffc020aa5e:	85da                	mv	a1,s6
ffffffffc020aa60:	6c98                	ld	a4,24(s1)
ffffffffc020aa62:	6088                	ld	a0,0(s1)
ffffffffc020aa64:	1779                	addi	a4,a4,-2
ffffffffc020aa66:	41770bb3          	sub	s7,a4,s7
ffffffffc020aa6a:	865e                	mv	a2,s7
ffffffffc020aa6c:	0505                	addi	a0,a0,1
ffffffffc020aa6e:	15b000ef          	jal	ra,ffffffffc020b3c8 <memmove>
ffffffffc020aa72:	02f00713          	li	a4,47
ffffffffc020aa76:	fee50fa3          	sb	a4,-1(a0)
ffffffffc020aa7a:	955e                	add	a0,a0,s7
ffffffffc020aa7c:	00050023          	sb	zero,0(a0)
ffffffffc020aa80:	85de                	mv	a1,s7
ffffffffc020aa82:	8526                	mv	a0,s1
ffffffffc020aa84:	9d5fa0ef          	jal	ra,ffffffffc0205458 <iobuf_skip>
ffffffffc020aa88:	8522                	mv	a0,s0
ffffffffc020aa8a:	db4f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020aa8e:	b5dd                	j	ffffffffc020a974 <sfs_namefile+0xa6>
ffffffffc020aa90:	89e6                	mv	s3,s9
ffffffffc020aa92:	5df1                	li	s11,-4
ffffffffc020aa94:	bdd1                	j	ffffffffc020a968 <sfs_namefile+0x9a>
ffffffffc020aa96:	5df1                	li	s11,-4
ffffffffc020aa98:	bdf1                	j	ffffffffc020a974 <sfs_namefile+0xa6>
ffffffffc020aa9a:	00004697          	auipc	a3,0x4
ffffffffc020aa9e:	5ee68693          	addi	a3,a3,1518 # ffffffffc020f088 <dev_node_ops+0x888>
ffffffffc020aaa2:	00001617          	auipc	a2,0x1
ffffffffc020aaa6:	df660613          	addi	a2,a2,-522 # ffffffffc020b898 <commands+0x210>
ffffffffc020aaaa:	2f500593          	li	a1,757
ffffffffc020aaae:	00004517          	auipc	a0,0x4
ffffffffc020aab2:	31250513          	addi	a0,a0,786 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020aab6:	9e9f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aaba:	00004697          	auipc	a3,0x4
ffffffffc020aabe:	2ce68693          	addi	a3,a3,718 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc020aac2:	00001617          	auipc	a2,0x1
ffffffffc020aac6:	dd660613          	addi	a2,a2,-554 # ffffffffc020b898 <commands+0x210>
ffffffffc020aaca:	2f400593          	li	a1,756
ffffffffc020aace:	00004517          	auipc	a0,0x4
ffffffffc020aad2:	2f250513          	addi	a0,a0,754 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020aad6:	9c9f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aada:	00004697          	auipc	a3,0x4
ffffffffc020aade:	2ae68693          	addi	a3,a3,686 # ffffffffc020ed88 <dev_node_ops+0x588>
ffffffffc020aae2:	00001617          	auipc	a2,0x1
ffffffffc020aae6:	db660613          	addi	a2,a2,-586 # ffffffffc020b898 <commands+0x210>
ffffffffc020aaea:	2e100593          	li	a1,737
ffffffffc020aaee:	00004517          	auipc	a0,0x4
ffffffffc020aaf2:	2d250513          	addi	a0,a0,722 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020aaf6:	9a9f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aafa:	00004697          	auipc	a3,0x4
ffffffffc020aafe:	0e668693          	addi	a3,a3,230 # ffffffffc020ebe0 <dev_node_ops+0x3e0>
ffffffffc020ab02:	00001617          	auipc	a2,0x1
ffffffffc020ab06:	d9660613          	addi	a2,a2,-618 # ffffffffc020b898 <commands+0x210>
ffffffffc020ab0a:	2e000593          	li	a1,736
ffffffffc020ab0e:	00004517          	auipc	a0,0x4
ffffffffc020ab12:	2b250513          	addi	a0,a0,690 # ffffffffc020edc0 <dev_node_ops+0x5c0>
ffffffffc020ab16:	989f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ab1a <sfs_rwblock_nolock>:
ffffffffc020ab1a:	7139                	addi	sp,sp,-64
ffffffffc020ab1c:	f822                	sd	s0,48(sp)
ffffffffc020ab1e:	f426                	sd	s1,40(sp)
ffffffffc020ab20:	fc06                	sd	ra,56(sp)
ffffffffc020ab22:	842a                	mv	s0,a0
ffffffffc020ab24:	84b6                	mv	s1,a3
ffffffffc020ab26:	e211                	bnez	a2,ffffffffc020ab2a <sfs_rwblock_nolock+0x10>
ffffffffc020ab28:	e715                	bnez	a4,ffffffffc020ab54 <sfs_rwblock_nolock+0x3a>
ffffffffc020ab2a:	405c                	lw	a5,4(s0)
ffffffffc020ab2c:	02f67463          	bgeu	a2,a5,ffffffffc020ab54 <sfs_rwblock_nolock+0x3a>
ffffffffc020ab30:	00c6169b          	slliw	a3,a2,0xc
ffffffffc020ab34:	1682                	slli	a3,a3,0x20
ffffffffc020ab36:	6605                	lui	a2,0x1
ffffffffc020ab38:	9281                	srli	a3,a3,0x20
ffffffffc020ab3a:	850a                	mv	a0,sp
ffffffffc020ab3c:	8a7fa0ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc020ab40:	85aa                	mv	a1,a0
ffffffffc020ab42:	7808                	ld	a0,48(s0)
ffffffffc020ab44:	8626                	mv	a2,s1
ffffffffc020ab46:	7118                	ld	a4,32(a0)
ffffffffc020ab48:	9702                	jalr	a4
ffffffffc020ab4a:	70e2                	ld	ra,56(sp)
ffffffffc020ab4c:	7442                	ld	s0,48(sp)
ffffffffc020ab4e:	74a2                	ld	s1,40(sp)
ffffffffc020ab50:	6121                	addi	sp,sp,64
ffffffffc020ab52:	8082                	ret
ffffffffc020ab54:	00004697          	auipc	a3,0x4
ffffffffc020ab58:	66c68693          	addi	a3,a3,1644 # ffffffffc020f1c0 <sfs_node_fileops+0x80>
ffffffffc020ab5c:	00001617          	auipc	a2,0x1
ffffffffc020ab60:	d3c60613          	addi	a2,a2,-708 # ffffffffc020b898 <commands+0x210>
ffffffffc020ab64:	45d5                	li	a1,21
ffffffffc020ab66:	00004517          	auipc	a0,0x4
ffffffffc020ab6a:	69250513          	addi	a0,a0,1682 # ffffffffc020f1f8 <sfs_node_fileops+0xb8>
ffffffffc020ab6e:	931f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ab72 <sfs_rblock>:
ffffffffc020ab72:	7139                	addi	sp,sp,-64
ffffffffc020ab74:	ec4e                	sd	s3,24(sp)
ffffffffc020ab76:	89b6                	mv	s3,a3
ffffffffc020ab78:	f822                	sd	s0,48(sp)
ffffffffc020ab7a:	f04a                	sd	s2,32(sp)
ffffffffc020ab7c:	e852                	sd	s4,16(sp)
ffffffffc020ab7e:	fc06                	sd	ra,56(sp)
ffffffffc020ab80:	f426                	sd	s1,40(sp)
ffffffffc020ab82:	e456                	sd	s5,8(sp)
ffffffffc020ab84:	8a2a                	mv	s4,a0
ffffffffc020ab86:	892e                	mv	s2,a1
ffffffffc020ab88:	8432                	mv	s0,a2
ffffffffc020ab8a:	2e0000ef          	jal	ra,ffffffffc020ae6a <lock_sfs_io>
ffffffffc020ab8e:	04098063          	beqz	s3,ffffffffc020abce <sfs_rblock+0x5c>
ffffffffc020ab92:	013409bb          	addw	s3,s0,s3
ffffffffc020ab96:	6a85                	lui	s5,0x1
ffffffffc020ab98:	a021                	j	ffffffffc020aba0 <sfs_rblock+0x2e>
ffffffffc020ab9a:	9956                	add	s2,s2,s5
ffffffffc020ab9c:	02898963          	beq	s3,s0,ffffffffc020abce <sfs_rblock+0x5c>
ffffffffc020aba0:	8622                	mv	a2,s0
ffffffffc020aba2:	85ca                	mv	a1,s2
ffffffffc020aba4:	4705                	li	a4,1
ffffffffc020aba6:	4681                	li	a3,0
ffffffffc020aba8:	8552                	mv	a0,s4
ffffffffc020abaa:	f71ff0ef          	jal	ra,ffffffffc020ab1a <sfs_rwblock_nolock>
ffffffffc020abae:	84aa                	mv	s1,a0
ffffffffc020abb0:	2405                	addiw	s0,s0,1
ffffffffc020abb2:	d565                	beqz	a0,ffffffffc020ab9a <sfs_rblock+0x28>
ffffffffc020abb4:	8552                	mv	a0,s4
ffffffffc020abb6:	2c4000ef          	jal	ra,ffffffffc020ae7a <unlock_sfs_io>
ffffffffc020abba:	70e2                	ld	ra,56(sp)
ffffffffc020abbc:	7442                	ld	s0,48(sp)
ffffffffc020abbe:	7902                	ld	s2,32(sp)
ffffffffc020abc0:	69e2                	ld	s3,24(sp)
ffffffffc020abc2:	6a42                	ld	s4,16(sp)
ffffffffc020abc4:	6aa2                	ld	s5,8(sp)
ffffffffc020abc6:	8526                	mv	a0,s1
ffffffffc020abc8:	74a2                	ld	s1,40(sp)
ffffffffc020abca:	6121                	addi	sp,sp,64
ffffffffc020abcc:	8082                	ret
ffffffffc020abce:	4481                	li	s1,0
ffffffffc020abd0:	b7d5                	j	ffffffffc020abb4 <sfs_rblock+0x42>

ffffffffc020abd2 <sfs_wblock>:
ffffffffc020abd2:	7139                	addi	sp,sp,-64
ffffffffc020abd4:	ec4e                	sd	s3,24(sp)
ffffffffc020abd6:	89b6                	mv	s3,a3
ffffffffc020abd8:	f822                	sd	s0,48(sp)
ffffffffc020abda:	f04a                	sd	s2,32(sp)
ffffffffc020abdc:	e852                	sd	s4,16(sp)
ffffffffc020abde:	fc06                	sd	ra,56(sp)
ffffffffc020abe0:	f426                	sd	s1,40(sp)
ffffffffc020abe2:	e456                	sd	s5,8(sp)
ffffffffc020abe4:	8a2a                	mv	s4,a0
ffffffffc020abe6:	892e                	mv	s2,a1
ffffffffc020abe8:	8432                	mv	s0,a2
ffffffffc020abea:	280000ef          	jal	ra,ffffffffc020ae6a <lock_sfs_io>
ffffffffc020abee:	04098063          	beqz	s3,ffffffffc020ac2e <sfs_wblock+0x5c>
ffffffffc020abf2:	013409bb          	addw	s3,s0,s3
ffffffffc020abf6:	6a85                	lui	s5,0x1
ffffffffc020abf8:	a021                	j	ffffffffc020ac00 <sfs_wblock+0x2e>
ffffffffc020abfa:	9956                	add	s2,s2,s5
ffffffffc020abfc:	02898963          	beq	s3,s0,ffffffffc020ac2e <sfs_wblock+0x5c>
ffffffffc020ac00:	8622                	mv	a2,s0
ffffffffc020ac02:	85ca                	mv	a1,s2
ffffffffc020ac04:	4705                	li	a4,1
ffffffffc020ac06:	4685                	li	a3,1
ffffffffc020ac08:	8552                	mv	a0,s4
ffffffffc020ac0a:	f11ff0ef          	jal	ra,ffffffffc020ab1a <sfs_rwblock_nolock>
ffffffffc020ac0e:	84aa                	mv	s1,a0
ffffffffc020ac10:	2405                	addiw	s0,s0,1
ffffffffc020ac12:	d565                	beqz	a0,ffffffffc020abfa <sfs_wblock+0x28>
ffffffffc020ac14:	8552                	mv	a0,s4
ffffffffc020ac16:	264000ef          	jal	ra,ffffffffc020ae7a <unlock_sfs_io>
ffffffffc020ac1a:	70e2                	ld	ra,56(sp)
ffffffffc020ac1c:	7442                	ld	s0,48(sp)
ffffffffc020ac1e:	7902                	ld	s2,32(sp)
ffffffffc020ac20:	69e2                	ld	s3,24(sp)
ffffffffc020ac22:	6a42                	ld	s4,16(sp)
ffffffffc020ac24:	6aa2                	ld	s5,8(sp)
ffffffffc020ac26:	8526                	mv	a0,s1
ffffffffc020ac28:	74a2                	ld	s1,40(sp)
ffffffffc020ac2a:	6121                	addi	sp,sp,64
ffffffffc020ac2c:	8082                	ret
ffffffffc020ac2e:	4481                	li	s1,0
ffffffffc020ac30:	b7d5                	j	ffffffffc020ac14 <sfs_wblock+0x42>

ffffffffc020ac32 <sfs_rbuf>:
ffffffffc020ac32:	7179                	addi	sp,sp,-48
ffffffffc020ac34:	f406                	sd	ra,40(sp)
ffffffffc020ac36:	f022                	sd	s0,32(sp)
ffffffffc020ac38:	ec26                	sd	s1,24(sp)
ffffffffc020ac3a:	e84a                	sd	s2,16(sp)
ffffffffc020ac3c:	e44e                	sd	s3,8(sp)
ffffffffc020ac3e:	e052                	sd	s4,0(sp)
ffffffffc020ac40:	6785                	lui	a5,0x1
ffffffffc020ac42:	04f77863          	bgeu	a4,a5,ffffffffc020ac92 <sfs_rbuf+0x60>
ffffffffc020ac46:	84ba                	mv	s1,a4
ffffffffc020ac48:	9732                	add	a4,a4,a2
ffffffffc020ac4a:	89b2                	mv	s3,a2
ffffffffc020ac4c:	04e7e363          	bltu	a5,a4,ffffffffc020ac92 <sfs_rbuf+0x60>
ffffffffc020ac50:	8936                	mv	s2,a3
ffffffffc020ac52:	842a                	mv	s0,a0
ffffffffc020ac54:	8a2e                	mv	s4,a1
ffffffffc020ac56:	214000ef          	jal	ra,ffffffffc020ae6a <lock_sfs_io>
ffffffffc020ac5a:	642c                	ld	a1,72(s0)
ffffffffc020ac5c:	864a                	mv	a2,s2
ffffffffc020ac5e:	4705                	li	a4,1
ffffffffc020ac60:	4681                	li	a3,0
ffffffffc020ac62:	8522                	mv	a0,s0
ffffffffc020ac64:	eb7ff0ef          	jal	ra,ffffffffc020ab1a <sfs_rwblock_nolock>
ffffffffc020ac68:	892a                	mv	s2,a0
ffffffffc020ac6a:	cd09                	beqz	a0,ffffffffc020ac84 <sfs_rbuf+0x52>
ffffffffc020ac6c:	8522                	mv	a0,s0
ffffffffc020ac6e:	20c000ef          	jal	ra,ffffffffc020ae7a <unlock_sfs_io>
ffffffffc020ac72:	70a2                	ld	ra,40(sp)
ffffffffc020ac74:	7402                	ld	s0,32(sp)
ffffffffc020ac76:	64e2                	ld	s1,24(sp)
ffffffffc020ac78:	69a2                	ld	s3,8(sp)
ffffffffc020ac7a:	6a02                	ld	s4,0(sp)
ffffffffc020ac7c:	854a                	mv	a0,s2
ffffffffc020ac7e:	6942                	ld	s2,16(sp)
ffffffffc020ac80:	6145                	addi	sp,sp,48
ffffffffc020ac82:	8082                	ret
ffffffffc020ac84:	642c                	ld	a1,72(s0)
ffffffffc020ac86:	864e                	mv	a2,s3
ffffffffc020ac88:	8552                	mv	a0,s4
ffffffffc020ac8a:	95a6                	add	a1,a1,s1
ffffffffc020ac8c:	77c000ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc020ac90:	bff1                	j	ffffffffc020ac6c <sfs_rbuf+0x3a>
ffffffffc020ac92:	00004697          	auipc	a3,0x4
ffffffffc020ac96:	57e68693          	addi	a3,a3,1406 # ffffffffc020f210 <sfs_node_fileops+0xd0>
ffffffffc020ac9a:	00001617          	auipc	a2,0x1
ffffffffc020ac9e:	bfe60613          	addi	a2,a2,-1026 # ffffffffc020b898 <commands+0x210>
ffffffffc020aca2:	05500593          	li	a1,85
ffffffffc020aca6:	00004517          	auipc	a0,0x4
ffffffffc020acaa:	55250513          	addi	a0,a0,1362 # ffffffffc020f1f8 <sfs_node_fileops+0xb8>
ffffffffc020acae:	ff0f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020acb2 <sfs_wbuf>:
ffffffffc020acb2:	7139                	addi	sp,sp,-64
ffffffffc020acb4:	fc06                	sd	ra,56(sp)
ffffffffc020acb6:	f822                	sd	s0,48(sp)
ffffffffc020acb8:	f426                	sd	s1,40(sp)
ffffffffc020acba:	f04a                	sd	s2,32(sp)
ffffffffc020acbc:	ec4e                	sd	s3,24(sp)
ffffffffc020acbe:	e852                	sd	s4,16(sp)
ffffffffc020acc0:	e456                	sd	s5,8(sp)
ffffffffc020acc2:	6785                	lui	a5,0x1
ffffffffc020acc4:	06f77163          	bgeu	a4,a5,ffffffffc020ad26 <sfs_wbuf+0x74>
ffffffffc020acc8:	893a                	mv	s2,a4
ffffffffc020acca:	9732                	add	a4,a4,a2
ffffffffc020accc:	8a32                	mv	s4,a2
ffffffffc020acce:	04e7ec63          	bltu	a5,a4,ffffffffc020ad26 <sfs_wbuf+0x74>
ffffffffc020acd2:	842a                	mv	s0,a0
ffffffffc020acd4:	89b6                	mv	s3,a3
ffffffffc020acd6:	8aae                	mv	s5,a1
ffffffffc020acd8:	192000ef          	jal	ra,ffffffffc020ae6a <lock_sfs_io>
ffffffffc020acdc:	642c                	ld	a1,72(s0)
ffffffffc020acde:	4705                	li	a4,1
ffffffffc020ace0:	4681                	li	a3,0
ffffffffc020ace2:	864e                	mv	a2,s3
ffffffffc020ace4:	8522                	mv	a0,s0
ffffffffc020ace6:	e35ff0ef          	jal	ra,ffffffffc020ab1a <sfs_rwblock_nolock>
ffffffffc020acea:	84aa                	mv	s1,a0
ffffffffc020acec:	cd11                	beqz	a0,ffffffffc020ad08 <sfs_wbuf+0x56>
ffffffffc020acee:	8522                	mv	a0,s0
ffffffffc020acf0:	18a000ef          	jal	ra,ffffffffc020ae7a <unlock_sfs_io>
ffffffffc020acf4:	70e2                	ld	ra,56(sp)
ffffffffc020acf6:	7442                	ld	s0,48(sp)
ffffffffc020acf8:	7902                	ld	s2,32(sp)
ffffffffc020acfa:	69e2                	ld	s3,24(sp)
ffffffffc020acfc:	6a42                	ld	s4,16(sp)
ffffffffc020acfe:	6aa2                	ld	s5,8(sp)
ffffffffc020ad00:	8526                	mv	a0,s1
ffffffffc020ad02:	74a2                	ld	s1,40(sp)
ffffffffc020ad04:	6121                	addi	sp,sp,64
ffffffffc020ad06:	8082                	ret
ffffffffc020ad08:	6428                	ld	a0,72(s0)
ffffffffc020ad0a:	8652                	mv	a2,s4
ffffffffc020ad0c:	85d6                	mv	a1,s5
ffffffffc020ad0e:	954a                	add	a0,a0,s2
ffffffffc020ad10:	6f8000ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc020ad14:	642c                	ld	a1,72(s0)
ffffffffc020ad16:	4705                	li	a4,1
ffffffffc020ad18:	4685                	li	a3,1
ffffffffc020ad1a:	864e                	mv	a2,s3
ffffffffc020ad1c:	8522                	mv	a0,s0
ffffffffc020ad1e:	dfdff0ef          	jal	ra,ffffffffc020ab1a <sfs_rwblock_nolock>
ffffffffc020ad22:	84aa                	mv	s1,a0
ffffffffc020ad24:	b7e9                	j	ffffffffc020acee <sfs_wbuf+0x3c>
ffffffffc020ad26:	00004697          	auipc	a3,0x4
ffffffffc020ad2a:	4ea68693          	addi	a3,a3,1258 # ffffffffc020f210 <sfs_node_fileops+0xd0>
ffffffffc020ad2e:	00001617          	auipc	a2,0x1
ffffffffc020ad32:	b6a60613          	addi	a2,a2,-1174 # ffffffffc020b898 <commands+0x210>
ffffffffc020ad36:	06b00593          	li	a1,107
ffffffffc020ad3a:	00004517          	auipc	a0,0x4
ffffffffc020ad3e:	4be50513          	addi	a0,a0,1214 # ffffffffc020f1f8 <sfs_node_fileops+0xb8>
ffffffffc020ad42:	f5cf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ad46 <sfs_sync_super>:
ffffffffc020ad46:	1101                	addi	sp,sp,-32
ffffffffc020ad48:	ec06                	sd	ra,24(sp)
ffffffffc020ad4a:	e822                	sd	s0,16(sp)
ffffffffc020ad4c:	e426                	sd	s1,8(sp)
ffffffffc020ad4e:	842a                	mv	s0,a0
ffffffffc020ad50:	11a000ef          	jal	ra,ffffffffc020ae6a <lock_sfs_io>
ffffffffc020ad54:	6428                	ld	a0,72(s0)
ffffffffc020ad56:	6605                	lui	a2,0x1
ffffffffc020ad58:	4581                	li	a1,0
ffffffffc020ad5a:	65c000ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc020ad5e:	6428                	ld	a0,72(s0)
ffffffffc020ad60:	85a2                	mv	a1,s0
ffffffffc020ad62:	02c00613          	li	a2,44
ffffffffc020ad66:	6a2000ef          	jal	ra,ffffffffc020b408 <memcpy>
ffffffffc020ad6a:	642c                	ld	a1,72(s0)
ffffffffc020ad6c:	4701                	li	a4,0
ffffffffc020ad6e:	4685                	li	a3,1
ffffffffc020ad70:	4601                	li	a2,0
ffffffffc020ad72:	8522                	mv	a0,s0
ffffffffc020ad74:	da7ff0ef          	jal	ra,ffffffffc020ab1a <sfs_rwblock_nolock>
ffffffffc020ad78:	84aa                	mv	s1,a0
ffffffffc020ad7a:	8522                	mv	a0,s0
ffffffffc020ad7c:	0fe000ef          	jal	ra,ffffffffc020ae7a <unlock_sfs_io>
ffffffffc020ad80:	60e2                	ld	ra,24(sp)
ffffffffc020ad82:	6442                	ld	s0,16(sp)
ffffffffc020ad84:	8526                	mv	a0,s1
ffffffffc020ad86:	64a2                	ld	s1,8(sp)
ffffffffc020ad88:	6105                	addi	sp,sp,32
ffffffffc020ad8a:	8082                	ret

ffffffffc020ad8c <sfs_sync_freemap>:
ffffffffc020ad8c:	7139                	addi	sp,sp,-64
ffffffffc020ad8e:	ec4e                	sd	s3,24(sp)
ffffffffc020ad90:	e852                	sd	s4,16(sp)
ffffffffc020ad92:	00456983          	lwu	s3,4(a0)
ffffffffc020ad96:	8a2a                	mv	s4,a0
ffffffffc020ad98:	7d08                	ld	a0,56(a0)
ffffffffc020ad9a:	67a1                	lui	a5,0x8
ffffffffc020ad9c:	17fd                	addi	a5,a5,-1
ffffffffc020ad9e:	4581                	li	a1,0
ffffffffc020ada0:	f822                	sd	s0,48(sp)
ffffffffc020ada2:	fc06                	sd	ra,56(sp)
ffffffffc020ada4:	f426                	sd	s1,40(sp)
ffffffffc020ada6:	f04a                	sd	s2,32(sp)
ffffffffc020ada8:	e456                	sd	s5,8(sp)
ffffffffc020adaa:	99be                	add	s3,s3,a5
ffffffffc020adac:	a2cfe0ef          	jal	ra,ffffffffc0208fd8 <bitmap_getdata>
ffffffffc020adb0:	00f9d993          	srli	s3,s3,0xf
ffffffffc020adb4:	842a                	mv	s0,a0
ffffffffc020adb6:	8552                	mv	a0,s4
ffffffffc020adb8:	0b2000ef          	jal	ra,ffffffffc020ae6a <lock_sfs_io>
ffffffffc020adbc:	04098163          	beqz	s3,ffffffffc020adfe <sfs_sync_freemap+0x72>
ffffffffc020adc0:	09b2                	slli	s3,s3,0xc
ffffffffc020adc2:	99a2                	add	s3,s3,s0
ffffffffc020adc4:	4909                	li	s2,2
ffffffffc020adc6:	6a85                	lui	s5,0x1
ffffffffc020adc8:	a021                	j	ffffffffc020add0 <sfs_sync_freemap+0x44>
ffffffffc020adca:	2905                	addiw	s2,s2,1
ffffffffc020adcc:	02898963          	beq	s3,s0,ffffffffc020adfe <sfs_sync_freemap+0x72>
ffffffffc020add0:	85a2                	mv	a1,s0
ffffffffc020add2:	864a                	mv	a2,s2
ffffffffc020add4:	4705                	li	a4,1
ffffffffc020add6:	4685                	li	a3,1
ffffffffc020add8:	8552                	mv	a0,s4
ffffffffc020adda:	d41ff0ef          	jal	ra,ffffffffc020ab1a <sfs_rwblock_nolock>
ffffffffc020adde:	84aa                	mv	s1,a0
ffffffffc020ade0:	9456                	add	s0,s0,s5
ffffffffc020ade2:	d565                	beqz	a0,ffffffffc020adca <sfs_sync_freemap+0x3e>
ffffffffc020ade4:	8552                	mv	a0,s4
ffffffffc020ade6:	094000ef          	jal	ra,ffffffffc020ae7a <unlock_sfs_io>
ffffffffc020adea:	70e2                	ld	ra,56(sp)
ffffffffc020adec:	7442                	ld	s0,48(sp)
ffffffffc020adee:	7902                	ld	s2,32(sp)
ffffffffc020adf0:	69e2                	ld	s3,24(sp)
ffffffffc020adf2:	6a42                	ld	s4,16(sp)
ffffffffc020adf4:	6aa2                	ld	s5,8(sp)
ffffffffc020adf6:	8526                	mv	a0,s1
ffffffffc020adf8:	74a2                	ld	s1,40(sp)
ffffffffc020adfa:	6121                	addi	sp,sp,64
ffffffffc020adfc:	8082                	ret
ffffffffc020adfe:	4481                	li	s1,0
ffffffffc020ae00:	b7d5                	j	ffffffffc020ade4 <sfs_sync_freemap+0x58>

ffffffffc020ae02 <sfs_clear_block>:
ffffffffc020ae02:	7179                	addi	sp,sp,-48
ffffffffc020ae04:	f022                	sd	s0,32(sp)
ffffffffc020ae06:	e84a                	sd	s2,16(sp)
ffffffffc020ae08:	e44e                	sd	s3,8(sp)
ffffffffc020ae0a:	f406                	sd	ra,40(sp)
ffffffffc020ae0c:	89b2                	mv	s3,a2
ffffffffc020ae0e:	ec26                	sd	s1,24(sp)
ffffffffc020ae10:	892a                	mv	s2,a0
ffffffffc020ae12:	842e                	mv	s0,a1
ffffffffc020ae14:	056000ef          	jal	ra,ffffffffc020ae6a <lock_sfs_io>
ffffffffc020ae18:	04893503          	ld	a0,72(s2)
ffffffffc020ae1c:	6605                	lui	a2,0x1
ffffffffc020ae1e:	4581                	li	a1,0
ffffffffc020ae20:	596000ef          	jal	ra,ffffffffc020b3b6 <memset>
ffffffffc020ae24:	02098d63          	beqz	s3,ffffffffc020ae5e <sfs_clear_block+0x5c>
ffffffffc020ae28:	013409bb          	addw	s3,s0,s3
ffffffffc020ae2c:	a019                	j	ffffffffc020ae32 <sfs_clear_block+0x30>
ffffffffc020ae2e:	02898863          	beq	s3,s0,ffffffffc020ae5e <sfs_clear_block+0x5c>
ffffffffc020ae32:	04893583          	ld	a1,72(s2)
ffffffffc020ae36:	8622                	mv	a2,s0
ffffffffc020ae38:	4705                	li	a4,1
ffffffffc020ae3a:	4685                	li	a3,1
ffffffffc020ae3c:	854a                	mv	a0,s2
ffffffffc020ae3e:	cddff0ef          	jal	ra,ffffffffc020ab1a <sfs_rwblock_nolock>
ffffffffc020ae42:	84aa                	mv	s1,a0
ffffffffc020ae44:	2405                	addiw	s0,s0,1
ffffffffc020ae46:	d565                	beqz	a0,ffffffffc020ae2e <sfs_clear_block+0x2c>
ffffffffc020ae48:	854a                	mv	a0,s2
ffffffffc020ae4a:	030000ef          	jal	ra,ffffffffc020ae7a <unlock_sfs_io>
ffffffffc020ae4e:	70a2                	ld	ra,40(sp)
ffffffffc020ae50:	7402                	ld	s0,32(sp)
ffffffffc020ae52:	6942                	ld	s2,16(sp)
ffffffffc020ae54:	69a2                	ld	s3,8(sp)
ffffffffc020ae56:	8526                	mv	a0,s1
ffffffffc020ae58:	64e2                	ld	s1,24(sp)
ffffffffc020ae5a:	6145                	addi	sp,sp,48
ffffffffc020ae5c:	8082                	ret
ffffffffc020ae5e:	4481                	li	s1,0
ffffffffc020ae60:	b7e5                	j	ffffffffc020ae48 <sfs_clear_block+0x46>

ffffffffc020ae62 <lock_sfs_fs>:
ffffffffc020ae62:	05050513          	addi	a0,a0,80
ffffffffc020ae66:	efef906f          	j	ffffffffc0204564 <down>

ffffffffc020ae6a <lock_sfs_io>:
ffffffffc020ae6a:	06850513          	addi	a0,a0,104
ffffffffc020ae6e:	ef6f906f          	j	ffffffffc0204564 <down>

ffffffffc020ae72 <unlock_sfs_fs>:
ffffffffc020ae72:	05050513          	addi	a0,a0,80
ffffffffc020ae76:	eeaf906f          	j	ffffffffc0204560 <up>

ffffffffc020ae7a <unlock_sfs_io>:
ffffffffc020ae7a:	06850513          	addi	a0,a0,104
ffffffffc020ae7e:	ee2f906f          	j	ffffffffc0204560 <up>

ffffffffc020ae82 <hash32>:
ffffffffc020ae82:	9e3707b7          	lui	a5,0x9e370
ffffffffc020ae86:	2785                	addiw	a5,a5,1
ffffffffc020ae88:	02a7853b          	mulw	a0,a5,a0
ffffffffc020ae8c:	02000793          	li	a5,32
ffffffffc020ae90:	9f8d                	subw	a5,a5,a1
ffffffffc020ae92:	00f5553b          	srlw	a0,a0,a5
ffffffffc020ae96:	8082                	ret

ffffffffc020ae98 <printnum>:
ffffffffc020ae98:	02071893          	slli	a7,a4,0x20
ffffffffc020ae9c:	7139                	addi	sp,sp,-64
ffffffffc020ae9e:	0208d893          	srli	a7,a7,0x20
ffffffffc020aea2:	e456                	sd	s5,8(sp)
ffffffffc020aea4:	0316fab3          	remu	s5,a3,a7
ffffffffc020aea8:	f822                	sd	s0,48(sp)
ffffffffc020aeaa:	f426                	sd	s1,40(sp)
ffffffffc020aeac:	f04a                	sd	s2,32(sp)
ffffffffc020aeae:	ec4e                	sd	s3,24(sp)
ffffffffc020aeb0:	fc06                	sd	ra,56(sp)
ffffffffc020aeb2:	e852                	sd	s4,16(sp)
ffffffffc020aeb4:	84aa                	mv	s1,a0
ffffffffc020aeb6:	89ae                	mv	s3,a1
ffffffffc020aeb8:	8932                	mv	s2,a2
ffffffffc020aeba:	fff7841b          	addiw	s0,a5,-1
ffffffffc020aebe:	2a81                	sext.w	s5,s5
ffffffffc020aec0:	0516f163          	bgeu	a3,a7,ffffffffc020af02 <printnum+0x6a>
ffffffffc020aec4:	8a42                	mv	s4,a6
ffffffffc020aec6:	00805863          	blez	s0,ffffffffc020aed6 <printnum+0x3e>
ffffffffc020aeca:	347d                	addiw	s0,s0,-1
ffffffffc020aecc:	864e                	mv	a2,s3
ffffffffc020aece:	85ca                	mv	a1,s2
ffffffffc020aed0:	8552                	mv	a0,s4
ffffffffc020aed2:	9482                	jalr	s1
ffffffffc020aed4:	f87d                	bnez	s0,ffffffffc020aeca <printnum+0x32>
ffffffffc020aed6:	1a82                	slli	s5,s5,0x20
ffffffffc020aed8:	00004797          	auipc	a5,0x4
ffffffffc020aedc:	38078793          	addi	a5,a5,896 # ffffffffc020f258 <sfs_node_fileops+0x118>
ffffffffc020aee0:	020ada93          	srli	s5,s5,0x20
ffffffffc020aee4:	9abe                	add	s5,s5,a5
ffffffffc020aee6:	7442                	ld	s0,48(sp)
ffffffffc020aee8:	000ac503          	lbu	a0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020aeec:	70e2                	ld	ra,56(sp)
ffffffffc020aeee:	6a42                	ld	s4,16(sp)
ffffffffc020aef0:	6aa2                	ld	s5,8(sp)
ffffffffc020aef2:	864e                	mv	a2,s3
ffffffffc020aef4:	85ca                	mv	a1,s2
ffffffffc020aef6:	69e2                	ld	s3,24(sp)
ffffffffc020aef8:	7902                	ld	s2,32(sp)
ffffffffc020aefa:	87a6                	mv	a5,s1
ffffffffc020aefc:	74a2                	ld	s1,40(sp)
ffffffffc020aefe:	6121                	addi	sp,sp,64
ffffffffc020af00:	8782                	jr	a5
ffffffffc020af02:	0316d6b3          	divu	a3,a3,a7
ffffffffc020af06:	87a2                	mv	a5,s0
ffffffffc020af08:	f91ff0ef          	jal	ra,ffffffffc020ae98 <printnum>
ffffffffc020af0c:	b7e9                	j	ffffffffc020aed6 <printnum+0x3e>

ffffffffc020af0e <sprintputch>:
ffffffffc020af0e:	499c                	lw	a5,16(a1)
ffffffffc020af10:	6198                	ld	a4,0(a1)
ffffffffc020af12:	6594                	ld	a3,8(a1)
ffffffffc020af14:	2785                	addiw	a5,a5,1
ffffffffc020af16:	c99c                	sw	a5,16(a1)
ffffffffc020af18:	00d77763          	bgeu	a4,a3,ffffffffc020af26 <sprintputch+0x18>
ffffffffc020af1c:	00170793          	addi	a5,a4,1
ffffffffc020af20:	e19c                	sd	a5,0(a1)
ffffffffc020af22:	00a70023          	sb	a0,0(a4)
ffffffffc020af26:	8082                	ret

ffffffffc020af28 <vprintfmt>:
ffffffffc020af28:	7119                	addi	sp,sp,-128
ffffffffc020af2a:	f4a6                	sd	s1,104(sp)
ffffffffc020af2c:	f0ca                	sd	s2,96(sp)
ffffffffc020af2e:	ecce                	sd	s3,88(sp)
ffffffffc020af30:	e8d2                	sd	s4,80(sp)
ffffffffc020af32:	e4d6                	sd	s5,72(sp)
ffffffffc020af34:	e0da                	sd	s6,64(sp)
ffffffffc020af36:	fc5e                	sd	s7,56(sp)
ffffffffc020af38:	ec6e                	sd	s11,24(sp)
ffffffffc020af3a:	fc86                	sd	ra,120(sp)
ffffffffc020af3c:	f8a2                	sd	s0,112(sp)
ffffffffc020af3e:	f862                	sd	s8,48(sp)
ffffffffc020af40:	f466                	sd	s9,40(sp)
ffffffffc020af42:	f06a                	sd	s10,32(sp)
ffffffffc020af44:	89aa                	mv	s3,a0
ffffffffc020af46:	892e                	mv	s2,a1
ffffffffc020af48:	84b2                	mv	s1,a2
ffffffffc020af4a:	8db6                	mv	s11,a3
ffffffffc020af4c:	8aba                	mv	s5,a4
ffffffffc020af4e:	02500a13          	li	s4,37
ffffffffc020af52:	5bfd                	li	s7,-1
ffffffffc020af54:	00004b17          	auipc	s6,0x4
ffffffffc020af58:	330b0b13          	addi	s6,s6,816 # ffffffffc020f284 <sfs_node_fileops+0x144>
ffffffffc020af5c:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020af60:	001d8413          	addi	s0,s11,1
ffffffffc020af64:	01450b63          	beq	a0,s4,ffffffffc020af7a <vprintfmt+0x52>
ffffffffc020af68:	c129                	beqz	a0,ffffffffc020afaa <vprintfmt+0x82>
ffffffffc020af6a:	864a                	mv	a2,s2
ffffffffc020af6c:	85a6                	mv	a1,s1
ffffffffc020af6e:	0405                	addi	s0,s0,1
ffffffffc020af70:	9982                	jalr	s3
ffffffffc020af72:	fff44503          	lbu	a0,-1(s0)
ffffffffc020af76:	ff4519e3          	bne	a0,s4,ffffffffc020af68 <vprintfmt+0x40>
ffffffffc020af7a:	00044583          	lbu	a1,0(s0)
ffffffffc020af7e:	02000813          	li	a6,32
ffffffffc020af82:	4d01                	li	s10,0
ffffffffc020af84:	4301                	li	t1,0
ffffffffc020af86:	5cfd                	li	s9,-1
ffffffffc020af88:	5c7d                	li	s8,-1
ffffffffc020af8a:	05500513          	li	a0,85
ffffffffc020af8e:	48a5                	li	a7,9
ffffffffc020af90:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020af94:	0ff67613          	zext.b	a2,a2
ffffffffc020af98:	00140d93          	addi	s11,s0,1
ffffffffc020af9c:	04c56263          	bltu	a0,a2,ffffffffc020afe0 <vprintfmt+0xb8>
ffffffffc020afa0:	060a                	slli	a2,a2,0x2
ffffffffc020afa2:	965a                	add	a2,a2,s6
ffffffffc020afa4:	4214                	lw	a3,0(a2)
ffffffffc020afa6:	96da                	add	a3,a3,s6
ffffffffc020afa8:	8682                	jr	a3
ffffffffc020afaa:	70e6                	ld	ra,120(sp)
ffffffffc020afac:	7446                	ld	s0,112(sp)
ffffffffc020afae:	74a6                	ld	s1,104(sp)
ffffffffc020afb0:	7906                	ld	s2,96(sp)
ffffffffc020afb2:	69e6                	ld	s3,88(sp)
ffffffffc020afb4:	6a46                	ld	s4,80(sp)
ffffffffc020afb6:	6aa6                	ld	s5,72(sp)
ffffffffc020afb8:	6b06                	ld	s6,64(sp)
ffffffffc020afba:	7be2                	ld	s7,56(sp)
ffffffffc020afbc:	7c42                	ld	s8,48(sp)
ffffffffc020afbe:	7ca2                	ld	s9,40(sp)
ffffffffc020afc0:	7d02                	ld	s10,32(sp)
ffffffffc020afc2:	6de2                	ld	s11,24(sp)
ffffffffc020afc4:	6109                	addi	sp,sp,128
ffffffffc020afc6:	8082                	ret
ffffffffc020afc8:	882e                	mv	a6,a1
ffffffffc020afca:	00144583          	lbu	a1,1(s0)
ffffffffc020afce:	846e                	mv	s0,s11
ffffffffc020afd0:	00140d93          	addi	s11,s0,1
ffffffffc020afd4:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020afd8:	0ff67613          	zext.b	a2,a2
ffffffffc020afdc:	fcc572e3          	bgeu	a0,a2,ffffffffc020afa0 <vprintfmt+0x78>
ffffffffc020afe0:	864a                	mv	a2,s2
ffffffffc020afe2:	85a6                	mv	a1,s1
ffffffffc020afe4:	02500513          	li	a0,37
ffffffffc020afe8:	9982                	jalr	s3
ffffffffc020afea:	fff44783          	lbu	a5,-1(s0)
ffffffffc020afee:	8da2                	mv	s11,s0
ffffffffc020aff0:	f74786e3          	beq	a5,s4,ffffffffc020af5c <vprintfmt+0x34>
ffffffffc020aff4:	ffedc783          	lbu	a5,-2(s11)
ffffffffc020aff8:	1dfd                	addi	s11,s11,-1
ffffffffc020affa:	ff479de3          	bne	a5,s4,ffffffffc020aff4 <vprintfmt+0xcc>
ffffffffc020affe:	bfb9                	j	ffffffffc020af5c <vprintfmt+0x34>
ffffffffc020b000:	fd058c9b          	addiw	s9,a1,-48
ffffffffc020b004:	00144583          	lbu	a1,1(s0)
ffffffffc020b008:	846e                	mv	s0,s11
ffffffffc020b00a:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b00e:	0005861b          	sext.w	a2,a1
ffffffffc020b012:	02d8e463          	bltu	a7,a3,ffffffffc020b03a <vprintfmt+0x112>
ffffffffc020b016:	00144583          	lbu	a1,1(s0)
ffffffffc020b01a:	002c969b          	slliw	a3,s9,0x2
ffffffffc020b01e:	0196873b          	addw	a4,a3,s9
ffffffffc020b022:	0017171b          	slliw	a4,a4,0x1
ffffffffc020b026:	9f31                	addw	a4,a4,a2
ffffffffc020b028:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b02c:	0405                	addi	s0,s0,1
ffffffffc020b02e:	fd070c9b          	addiw	s9,a4,-48
ffffffffc020b032:	0005861b          	sext.w	a2,a1
ffffffffc020b036:	fed8f0e3          	bgeu	a7,a3,ffffffffc020b016 <vprintfmt+0xee>
ffffffffc020b03a:	f40c5be3          	bgez	s8,ffffffffc020af90 <vprintfmt+0x68>
ffffffffc020b03e:	8c66                	mv	s8,s9
ffffffffc020b040:	5cfd                	li	s9,-1
ffffffffc020b042:	b7b9                	j	ffffffffc020af90 <vprintfmt+0x68>
ffffffffc020b044:	fffc4693          	not	a3,s8
ffffffffc020b048:	96fd                	srai	a3,a3,0x3f
ffffffffc020b04a:	00dc77b3          	and	a5,s8,a3
ffffffffc020b04e:	00144583          	lbu	a1,1(s0)
ffffffffc020b052:	00078c1b          	sext.w	s8,a5
ffffffffc020b056:	846e                	mv	s0,s11
ffffffffc020b058:	bf25                	j	ffffffffc020af90 <vprintfmt+0x68>
ffffffffc020b05a:	000aac83          	lw	s9,0(s5)
ffffffffc020b05e:	00144583          	lbu	a1,1(s0)
ffffffffc020b062:	0aa1                	addi	s5,s5,8
ffffffffc020b064:	846e                	mv	s0,s11
ffffffffc020b066:	bfd1                	j	ffffffffc020b03a <vprintfmt+0x112>
ffffffffc020b068:	4705                	li	a4,1
ffffffffc020b06a:	008a8613          	addi	a2,s5,8
ffffffffc020b06e:	00674463          	blt	a4,t1,ffffffffc020b076 <vprintfmt+0x14e>
ffffffffc020b072:	1c030c63          	beqz	t1,ffffffffc020b24a <vprintfmt+0x322>
ffffffffc020b076:	000ab683          	ld	a3,0(s5)
ffffffffc020b07a:	4741                	li	a4,16
ffffffffc020b07c:	8ab2                	mv	s5,a2
ffffffffc020b07e:	2801                	sext.w	a6,a6
ffffffffc020b080:	87e2                	mv	a5,s8
ffffffffc020b082:	8626                	mv	a2,s1
ffffffffc020b084:	85ca                	mv	a1,s2
ffffffffc020b086:	854e                	mv	a0,s3
ffffffffc020b088:	e11ff0ef          	jal	ra,ffffffffc020ae98 <printnum>
ffffffffc020b08c:	bdc1                	j	ffffffffc020af5c <vprintfmt+0x34>
ffffffffc020b08e:	000aa503          	lw	a0,0(s5)
ffffffffc020b092:	864a                	mv	a2,s2
ffffffffc020b094:	85a6                	mv	a1,s1
ffffffffc020b096:	0aa1                	addi	s5,s5,8
ffffffffc020b098:	9982                	jalr	s3
ffffffffc020b09a:	b5c9                	j	ffffffffc020af5c <vprintfmt+0x34>
ffffffffc020b09c:	4705                	li	a4,1
ffffffffc020b09e:	008a8613          	addi	a2,s5,8
ffffffffc020b0a2:	00674463          	blt	a4,t1,ffffffffc020b0aa <vprintfmt+0x182>
ffffffffc020b0a6:	18030d63          	beqz	t1,ffffffffc020b240 <vprintfmt+0x318>
ffffffffc020b0aa:	000ab683          	ld	a3,0(s5)
ffffffffc020b0ae:	4729                	li	a4,10
ffffffffc020b0b0:	8ab2                	mv	s5,a2
ffffffffc020b0b2:	b7f1                	j	ffffffffc020b07e <vprintfmt+0x156>
ffffffffc020b0b4:	00144583          	lbu	a1,1(s0)
ffffffffc020b0b8:	4d05                	li	s10,1
ffffffffc020b0ba:	846e                	mv	s0,s11
ffffffffc020b0bc:	bdd1                	j	ffffffffc020af90 <vprintfmt+0x68>
ffffffffc020b0be:	864a                	mv	a2,s2
ffffffffc020b0c0:	85a6                	mv	a1,s1
ffffffffc020b0c2:	02500513          	li	a0,37
ffffffffc020b0c6:	9982                	jalr	s3
ffffffffc020b0c8:	bd51                	j	ffffffffc020af5c <vprintfmt+0x34>
ffffffffc020b0ca:	00144583          	lbu	a1,1(s0)
ffffffffc020b0ce:	2305                	addiw	t1,t1,1
ffffffffc020b0d0:	846e                	mv	s0,s11
ffffffffc020b0d2:	bd7d                	j	ffffffffc020af90 <vprintfmt+0x68>
ffffffffc020b0d4:	4705                	li	a4,1
ffffffffc020b0d6:	008a8613          	addi	a2,s5,8
ffffffffc020b0da:	00674463          	blt	a4,t1,ffffffffc020b0e2 <vprintfmt+0x1ba>
ffffffffc020b0de:	14030c63          	beqz	t1,ffffffffc020b236 <vprintfmt+0x30e>
ffffffffc020b0e2:	000ab683          	ld	a3,0(s5)
ffffffffc020b0e6:	4721                	li	a4,8
ffffffffc020b0e8:	8ab2                	mv	s5,a2
ffffffffc020b0ea:	bf51                	j	ffffffffc020b07e <vprintfmt+0x156>
ffffffffc020b0ec:	03000513          	li	a0,48
ffffffffc020b0f0:	864a                	mv	a2,s2
ffffffffc020b0f2:	85a6                	mv	a1,s1
ffffffffc020b0f4:	e042                	sd	a6,0(sp)
ffffffffc020b0f6:	9982                	jalr	s3
ffffffffc020b0f8:	864a                	mv	a2,s2
ffffffffc020b0fa:	85a6                	mv	a1,s1
ffffffffc020b0fc:	07800513          	li	a0,120
ffffffffc020b100:	9982                	jalr	s3
ffffffffc020b102:	0aa1                	addi	s5,s5,8
ffffffffc020b104:	6802                	ld	a6,0(sp)
ffffffffc020b106:	4741                	li	a4,16
ffffffffc020b108:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020b10c:	bf8d                	j	ffffffffc020b07e <vprintfmt+0x156>
ffffffffc020b10e:	000ab403          	ld	s0,0(s5)
ffffffffc020b112:	008a8793          	addi	a5,s5,8
ffffffffc020b116:	e03e                	sd	a5,0(sp)
ffffffffc020b118:	14040c63          	beqz	s0,ffffffffc020b270 <vprintfmt+0x348>
ffffffffc020b11c:	11805063          	blez	s8,ffffffffc020b21c <vprintfmt+0x2f4>
ffffffffc020b120:	02d00693          	li	a3,45
ffffffffc020b124:	0cd81963          	bne	a6,a3,ffffffffc020b1f6 <vprintfmt+0x2ce>
ffffffffc020b128:	00044683          	lbu	a3,0(s0)
ffffffffc020b12c:	0006851b          	sext.w	a0,a3
ffffffffc020b130:	ce8d                	beqz	a3,ffffffffc020b16a <vprintfmt+0x242>
ffffffffc020b132:	00140a93          	addi	s5,s0,1
ffffffffc020b136:	05e00413          	li	s0,94
ffffffffc020b13a:	000cc563          	bltz	s9,ffffffffc020b144 <vprintfmt+0x21c>
ffffffffc020b13e:	3cfd                	addiw	s9,s9,-1
ffffffffc020b140:	037c8363          	beq	s9,s7,ffffffffc020b166 <vprintfmt+0x23e>
ffffffffc020b144:	864a                	mv	a2,s2
ffffffffc020b146:	85a6                	mv	a1,s1
ffffffffc020b148:	100d0663          	beqz	s10,ffffffffc020b254 <vprintfmt+0x32c>
ffffffffc020b14c:	3681                	addiw	a3,a3,-32
ffffffffc020b14e:	10d47363          	bgeu	s0,a3,ffffffffc020b254 <vprintfmt+0x32c>
ffffffffc020b152:	03f00513          	li	a0,63
ffffffffc020b156:	9982                	jalr	s3
ffffffffc020b158:	000ac683          	lbu	a3,0(s5)
ffffffffc020b15c:	3c7d                	addiw	s8,s8,-1
ffffffffc020b15e:	0a85                	addi	s5,s5,1
ffffffffc020b160:	0006851b          	sext.w	a0,a3
ffffffffc020b164:	faf9                	bnez	a3,ffffffffc020b13a <vprintfmt+0x212>
ffffffffc020b166:	01805a63          	blez	s8,ffffffffc020b17a <vprintfmt+0x252>
ffffffffc020b16a:	3c7d                	addiw	s8,s8,-1
ffffffffc020b16c:	864a                	mv	a2,s2
ffffffffc020b16e:	85a6                	mv	a1,s1
ffffffffc020b170:	02000513          	li	a0,32
ffffffffc020b174:	9982                	jalr	s3
ffffffffc020b176:	fe0c1ae3          	bnez	s8,ffffffffc020b16a <vprintfmt+0x242>
ffffffffc020b17a:	6a82                	ld	s5,0(sp)
ffffffffc020b17c:	b3c5                	j	ffffffffc020af5c <vprintfmt+0x34>
ffffffffc020b17e:	4705                	li	a4,1
ffffffffc020b180:	008a8d13          	addi	s10,s5,8
ffffffffc020b184:	00674463          	blt	a4,t1,ffffffffc020b18c <vprintfmt+0x264>
ffffffffc020b188:	0a030463          	beqz	t1,ffffffffc020b230 <vprintfmt+0x308>
ffffffffc020b18c:	000ab403          	ld	s0,0(s5)
ffffffffc020b190:	0c044463          	bltz	s0,ffffffffc020b258 <vprintfmt+0x330>
ffffffffc020b194:	86a2                	mv	a3,s0
ffffffffc020b196:	8aea                	mv	s5,s10
ffffffffc020b198:	4729                	li	a4,10
ffffffffc020b19a:	b5d5                	j	ffffffffc020b07e <vprintfmt+0x156>
ffffffffc020b19c:	000aa783          	lw	a5,0(s5)
ffffffffc020b1a0:	46e1                	li	a3,24
ffffffffc020b1a2:	0aa1                	addi	s5,s5,8
ffffffffc020b1a4:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020b1a8:	8fb9                	xor	a5,a5,a4
ffffffffc020b1aa:	40e7873b          	subw	a4,a5,a4
ffffffffc020b1ae:	02e6c663          	blt	a3,a4,ffffffffc020b1da <vprintfmt+0x2b2>
ffffffffc020b1b2:	00371793          	slli	a5,a4,0x3
ffffffffc020b1b6:	00004697          	auipc	a3,0x4
ffffffffc020b1ba:	40268693          	addi	a3,a3,1026 # ffffffffc020f5b8 <error_string>
ffffffffc020b1be:	97b6                	add	a5,a5,a3
ffffffffc020b1c0:	639c                	ld	a5,0(a5)
ffffffffc020b1c2:	cf81                	beqz	a5,ffffffffc020b1da <vprintfmt+0x2b2>
ffffffffc020b1c4:	873e                	mv	a4,a5
ffffffffc020b1c6:	00000697          	auipc	a3,0x0
ffffffffc020b1ca:	28268693          	addi	a3,a3,642 # ffffffffc020b448 <etext+0x28>
ffffffffc020b1ce:	8626                	mv	a2,s1
ffffffffc020b1d0:	85ca                	mv	a1,s2
ffffffffc020b1d2:	854e                	mv	a0,s3
ffffffffc020b1d4:	0d4000ef          	jal	ra,ffffffffc020b2a8 <printfmt>
ffffffffc020b1d8:	b351                	j	ffffffffc020af5c <vprintfmt+0x34>
ffffffffc020b1da:	00004697          	auipc	a3,0x4
ffffffffc020b1de:	09e68693          	addi	a3,a3,158 # ffffffffc020f278 <sfs_node_fileops+0x138>
ffffffffc020b1e2:	8626                	mv	a2,s1
ffffffffc020b1e4:	85ca                	mv	a1,s2
ffffffffc020b1e6:	854e                	mv	a0,s3
ffffffffc020b1e8:	0c0000ef          	jal	ra,ffffffffc020b2a8 <printfmt>
ffffffffc020b1ec:	bb85                	j	ffffffffc020af5c <vprintfmt+0x34>
ffffffffc020b1ee:	00004417          	auipc	s0,0x4
ffffffffc020b1f2:	08240413          	addi	s0,s0,130 # ffffffffc020f270 <sfs_node_fileops+0x130>
ffffffffc020b1f6:	85e6                	mv	a1,s9
ffffffffc020b1f8:	8522                	mv	a0,s0
ffffffffc020b1fa:	e442                	sd	a6,8(sp)
ffffffffc020b1fc:	132000ef          	jal	ra,ffffffffc020b32e <strnlen>
ffffffffc020b200:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020b204:	01805c63          	blez	s8,ffffffffc020b21c <vprintfmt+0x2f4>
ffffffffc020b208:	6822                	ld	a6,8(sp)
ffffffffc020b20a:	00080a9b          	sext.w	s5,a6
ffffffffc020b20e:	3c7d                	addiw	s8,s8,-1
ffffffffc020b210:	864a                	mv	a2,s2
ffffffffc020b212:	85a6                	mv	a1,s1
ffffffffc020b214:	8556                	mv	a0,s5
ffffffffc020b216:	9982                	jalr	s3
ffffffffc020b218:	fe0c1be3          	bnez	s8,ffffffffc020b20e <vprintfmt+0x2e6>
ffffffffc020b21c:	00044683          	lbu	a3,0(s0)
ffffffffc020b220:	00140a93          	addi	s5,s0,1
ffffffffc020b224:	0006851b          	sext.w	a0,a3
ffffffffc020b228:	daa9                	beqz	a3,ffffffffc020b17a <vprintfmt+0x252>
ffffffffc020b22a:	05e00413          	li	s0,94
ffffffffc020b22e:	b731                	j	ffffffffc020b13a <vprintfmt+0x212>
ffffffffc020b230:	000aa403          	lw	s0,0(s5)
ffffffffc020b234:	bfb1                	j	ffffffffc020b190 <vprintfmt+0x268>
ffffffffc020b236:	000ae683          	lwu	a3,0(s5)
ffffffffc020b23a:	4721                	li	a4,8
ffffffffc020b23c:	8ab2                	mv	s5,a2
ffffffffc020b23e:	b581                	j	ffffffffc020b07e <vprintfmt+0x156>
ffffffffc020b240:	000ae683          	lwu	a3,0(s5)
ffffffffc020b244:	4729                	li	a4,10
ffffffffc020b246:	8ab2                	mv	s5,a2
ffffffffc020b248:	bd1d                	j	ffffffffc020b07e <vprintfmt+0x156>
ffffffffc020b24a:	000ae683          	lwu	a3,0(s5)
ffffffffc020b24e:	4741                	li	a4,16
ffffffffc020b250:	8ab2                	mv	s5,a2
ffffffffc020b252:	b535                	j	ffffffffc020b07e <vprintfmt+0x156>
ffffffffc020b254:	9982                	jalr	s3
ffffffffc020b256:	b709                	j	ffffffffc020b158 <vprintfmt+0x230>
ffffffffc020b258:	864a                	mv	a2,s2
ffffffffc020b25a:	85a6                	mv	a1,s1
ffffffffc020b25c:	02d00513          	li	a0,45
ffffffffc020b260:	e042                	sd	a6,0(sp)
ffffffffc020b262:	9982                	jalr	s3
ffffffffc020b264:	6802                	ld	a6,0(sp)
ffffffffc020b266:	8aea                	mv	s5,s10
ffffffffc020b268:	408006b3          	neg	a3,s0
ffffffffc020b26c:	4729                	li	a4,10
ffffffffc020b26e:	bd01                	j	ffffffffc020b07e <vprintfmt+0x156>
ffffffffc020b270:	03805163          	blez	s8,ffffffffc020b292 <vprintfmt+0x36a>
ffffffffc020b274:	02d00693          	li	a3,45
ffffffffc020b278:	f6d81be3          	bne	a6,a3,ffffffffc020b1ee <vprintfmt+0x2c6>
ffffffffc020b27c:	00004417          	auipc	s0,0x4
ffffffffc020b280:	ff440413          	addi	s0,s0,-12 # ffffffffc020f270 <sfs_node_fileops+0x130>
ffffffffc020b284:	02800693          	li	a3,40
ffffffffc020b288:	02800513          	li	a0,40
ffffffffc020b28c:	00140a93          	addi	s5,s0,1
ffffffffc020b290:	b55d                	j	ffffffffc020b136 <vprintfmt+0x20e>
ffffffffc020b292:	00004a97          	auipc	s5,0x4
ffffffffc020b296:	fdfa8a93          	addi	s5,s5,-33 # ffffffffc020f271 <sfs_node_fileops+0x131>
ffffffffc020b29a:	02800513          	li	a0,40
ffffffffc020b29e:	02800693          	li	a3,40
ffffffffc020b2a2:	05e00413          	li	s0,94
ffffffffc020b2a6:	bd51                	j	ffffffffc020b13a <vprintfmt+0x212>

ffffffffc020b2a8 <printfmt>:
ffffffffc020b2a8:	7139                	addi	sp,sp,-64
ffffffffc020b2aa:	02010313          	addi	t1,sp,32
ffffffffc020b2ae:	f03a                	sd	a4,32(sp)
ffffffffc020b2b0:	871a                	mv	a4,t1
ffffffffc020b2b2:	ec06                	sd	ra,24(sp)
ffffffffc020b2b4:	f43e                	sd	a5,40(sp)
ffffffffc020b2b6:	f842                	sd	a6,48(sp)
ffffffffc020b2b8:	fc46                	sd	a7,56(sp)
ffffffffc020b2ba:	e41a                	sd	t1,8(sp)
ffffffffc020b2bc:	c6dff0ef          	jal	ra,ffffffffc020af28 <vprintfmt>
ffffffffc020b2c0:	60e2                	ld	ra,24(sp)
ffffffffc020b2c2:	6121                	addi	sp,sp,64
ffffffffc020b2c4:	8082                	ret

ffffffffc020b2c6 <snprintf>:
ffffffffc020b2c6:	711d                	addi	sp,sp,-96
ffffffffc020b2c8:	15fd                	addi	a1,a1,-1
ffffffffc020b2ca:	03810313          	addi	t1,sp,56
ffffffffc020b2ce:	95aa                	add	a1,a1,a0
ffffffffc020b2d0:	f406                	sd	ra,40(sp)
ffffffffc020b2d2:	fc36                	sd	a3,56(sp)
ffffffffc020b2d4:	e0ba                	sd	a4,64(sp)
ffffffffc020b2d6:	e4be                	sd	a5,72(sp)
ffffffffc020b2d8:	e8c2                	sd	a6,80(sp)
ffffffffc020b2da:	ecc6                	sd	a7,88(sp)
ffffffffc020b2dc:	e01a                	sd	t1,0(sp)
ffffffffc020b2de:	e42a                	sd	a0,8(sp)
ffffffffc020b2e0:	e82e                	sd	a1,16(sp)
ffffffffc020b2e2:	cc02                	sw	zero,24(sp)
ffffffffc020b2e4:	c515                	beqz	a0,ffffffffc020b310 <snprintf+0x4a>
ffffffffc020b2e6:	02a5e563          	bltu	a1,a0,ffffffffc020b310 <snprintf+0x4a>
ffffffffc020b2ea:	75dd                	lui	a1,0xffff7
ffffffffc020b2ec:	86b2                	mv	a3,a2
ffffffffc020b2ee:	00000517          	auipc	a0,0x0
ffffffffc020b2f2:	c2050513          	addi	a0,a0,-992 # ffffffffc020af0e <sprintputch>
ffffffffc020b2f6:	871a                	mv	a4,t1
ffffffffc020b2f8:	0030                	addi	a2,sp,8
ffffffffc020b2fa:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020b2fe:	c2bff0ef          	jal	ra,ffffffffc020af28 <vprintfmt>
ffffffffc020b302:	67a2                	ld	a5,8(sp)
ffffffffc020b304:	00078023          	sb	zero,0(a5)
ffffffffc020b308:	4562                	lw	a0,24(sp)
ffffffffc020b30a:	70a2                	ld	ra,40(sp)
ffffffffc020b30c:	6125                	addi	sp,sp,96
ffffffffc020b30e:	8082                	ret
ffffffffc020b310:	5575                	li	a0,-3
ffffffffc020b312:	bfe5                	j	ffffffffc020b30a <snprintf+0x44>

ffffffffc020b314 <strlen>:
ffffffffc020b314:	00054783          	lbu	a5,0(a0)
ffffffffc020b318:	872a                	mv	a4,a0
ffffffffc020b31a:	4501                	li	a0,0
ffffffffc020b31c:	cb81                	beqz	a5,ffffffffc020b32c <strlen+0x18>
ffffffffc020b31e:	0505                	addi	a0,a0,1
ffffffffc020b320:	00a707b3          	add	a5,a4,a0
ffffffffc020b324:	0007c783          	lbu	a5,0(a5)
ffffffffc020b328:	fbfd                	bnez	a5,ffffffffc020b31e <strlen+0xa>
ffffffffc020b32a:	8082                	ret
ffffffffc020b32c:	8082                	ret

ffffffffc020b32e <strnlen>:
ffffffffc020b32e:	4781                	li	a5,0
ffffffffc020b330:	e589                	bnez	a1,ffffffffc020b33a <strnlen+0xc>
ffffffffc020b332:	a811                	j	ffffffffc020b346 <strnlen+0x18>
ffffffffc020b334:	0785                	addi	a5,a5,1
ffffffffc020b336:	00f58863          	beq	a1,a5,ffffffffc020b346 <strnlen+0x18>
ffffffffc020b33a:	00f50733          	add	a4,a0,a5
ffffffffc020b33e:	00074703          	lbu	a4,0(a4)
ffffffffc020b342:	fb6d                	bnez	a4,ffffffffc020b334 <strnlen+0x6>
ffffffffc020b344:	85be                	mv	a1,a5
ffffffffc020b346:	852e                	mv	a0,a1
ffffffffc020b348:	8082                	ret

ffffffffc020b34a <strcpy>:
ffffffffc020b34a:	87aa                	mv	a5,a0
ffffffffc020b34c:	0005c703          	lbu	a4,0(a1)
ffffffffc020b350:	0785                	addi	a5,a5,1
ffffffffc020b352:	0585                	addi	a1,a1,1
ffffffffc020b354:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b358:	fb75                	bnez	a4,ffffffffc020b34c <strcpy+0x2>
ffffffffc020b35a:	8082                	ret

ffffffffc020b35c <strcmp>:
ffffffffc020b35c:	00054783          	lbu	a5,0(a0)
ffffffffc020b360:	0005c703          	lbu	a4,0(a1)
ffffffffc020b364:	cb89                	beqz	a5,ffffffffc020b376 <strcmp+0x1a>
ffffffffc020b366:	0505                	addi	a0,a0,1
ffffffffc020b368:	0585                	addi	a1,a1,1
ffffffffc020b36a:	fee789e3          	beq	a5,a4,ffffffffc020b35c <strcmp>
ffffffffc020b36e:	0007851b          	sext.w	a0,a5
ffffffffc020b372:	9d19                	subw	a0,a0,a4
ffffffffc020b374:	8082                	ret
ffffffffc020b376:	4501                	li	a0,0
ffffffffc020b378:	bfed                	j	ffffffffc020b372 <strcmp+0x16>

ffffffffc020b37a <strncmp>:
ffffffffc020b37a:	c20d                	beqz	a2,ffffffffc020b39c <strncmp+0x22>
ffffffffc020b37c:	962e                	add	a2,a2,a1
ffffffffc020b37e:	a031                	j	ffffffffc020b38a <strncmp+0x10>
ffffffffc020b380:	0505                	addi	a0,a0,1
ffffffffc020b382:	00e79a63          	bne	a5,a4,ffffffffc020b396 <strncmp+0x1c>
ffffffffc020b386:	00b60b63          	beq	a2,a1,ffffffffc020b39c <strncmp+0x22>
ffffffffc020b38a:	00054783          	lbu	a5,0(a0)
ffffffffc020b38e:	0585                	addi	a1,a1,1
ffffffffc020b390:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020b394:	f7f5                	bnez	a5,ffffffffc020b380 <strncmp+0x6>
ffffffffc020b396:	40e7853b          	subw	a0,a5,a4
ffffffffc020b39a:	8082                	ret
ffffffffc020b39c:	4501                	li	a0,0
ffffffffc020b39e:	8082                	ret

ffffffffc020b3a0 <strchr>:
ffffffffc020b3a0:	00054783          	lbu	a5,0(a0)
ffffffffc020b3a4:	c799                	beqz	a5,ffffffffc020b3b2 <strchr+0x12>
ffffffffc020b3a6:	00f58763          	beq	a1,a5,ffffffffc020b3b4 <strchr+0x14>
ffffffffc020b3aa:	00154783          	lbu	a5,1(a0)
ffffffffc020b3ae:	0505                	addi	a0,a0,1
ffffffffc020b3b0:	fbfd                	bnez	a5,ffffffffc020b3a6 <strchr+0x6>
ffffffffc020b3b2:	4501                	li	a0,0
ffffffffc020b3b4:	8082                	ret

ffffffffc020b3b6 <memset>:
ffffffffc020b3b6:	ca01                	beqz	a2,ffffffffc020b3c6 <memset+0x10>
ffffffffc020b3b8:	962a                	add	a2,a2,a0
ffffffffc020b3ba:	87aa                	mv	a5,a0
ffffffffc020b3bc:	0785                	addi	a5,a5,1
ffffffffc020b3be:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020b3c2:	fec79de3          	bne	a5,a2,ffffffffc020b3bc <memset+0x6>
ffffffffc020b3c6:	8082                	ret

ffffffffc020b3c8 <memmove>:
ffffffffc020b3c8:	02a5f263          	bgeu	a1,a0,ffffffffc020b3ec <memmove+0x24>
ffffffffc020b3cc:	00c587b3          	add	a5,a1,a2
ffffffffc020b3d0:	00f57e63          	bgeu	a0,a5,ffffffffc020b3ec <memmove+0x24>
ffffffffc020b3d4:	00c50733          	add	a4,a0,a2
ffffffffc020b3d8:	c615                	beqz	a2,ffffffffc020b404 <memmove+0x3c>
ffffffffc020b3da:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020b3de:	17fd                	addi	a5,a5,-1
ffffffffc020b3e0:	177d                	addi	a4,a4,-1
ffffffffc020b3e2:	00d70023          	sb	a3,0(a4)
ffffffffc020b3e6:	fef59ae3          	bne	a1,a5,ffffffffc020b3da <memmove+0x12>
ffffffffc020b3ea:	8082                	ret
ffffffffc020b3ec:	00c586b3          	add	a3,a1,a2
ffffffffc020b3f0:	87aa                	mv	a5,a0
ffffffffc020b3f2:	ca11                	beqz	a2,ffffffffc020b406 <memmove+0x3e>
ffffffffc020b3f4:	0005c703          	lbu	a4,0(a1)
ffffffffc020b3f8:	0585                	addi	a1,a1,1
ffffffffc020b3fa:	0785                	addi	a5,a5,1
ffffffffc020b3fc:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b400:	fed59ae3          	bne	a1,a3,ffffffffc020b3f4 <memmove+0x2c>
ffffffffc020b404:	8082                	ret
ffffffffc020b406:	8082                	ret

ffffffffc020b408 <memcpy>:
ffffffffc020b408:	ca19                	beqz	a2,ffffffffc020b41e <memcpy+0x16>
ffffffffc020b40a:	962e                	add	a2,a2,a1
ffffffffc020b40c:	87aa                	mv	a5,a0
ffffffffc020b40e:	0005c703          	lbu	a4,0(a1)
ffffffffc020b412:	0585                	addi	a1,a1,1
ffffffffc020b414:	0785                	addi	a5,a5,1
ffffffffc020b416:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b41a:	fec59ae3          	bne	a1,a2,ffffffffc020b40e <memcpy+0x6>
ffffffffc020b41e:	8082                	ret
