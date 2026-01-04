
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
ffffffffc0200062:	5640b0ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0200066:	52c000ef          	jal	ra,ffffffffc0200592 <cons_init>
ffffffffc020006a:	0000b597          	auipc	a1,0xb
ffffffffc020006e:	5c658593          	addi	a1,a1,1478 # ffffffffc020b630 <etext>
ffffffffc0200072:	0000b517          	auipc	a0,0xb
ffffffffc0200076:	5de50513          	addi	a0,a0,1502 # ffffffffc020b650 <etext+0x20>
ffffffffc020007a:	12c000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020007e:	1ae000ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc0200082:	62a000ef          	jal	ra,ffffffffc02006ac <dtb_init>
ffffffffc0200086:	24f020ef          	jal	ra,ffffffffc0202ad4 <pmm_init>
ffffffffc020008a:	3ef000ef          	jal	ra,ffffffffc0200c78 <pic_init>
ffffffffc020008e:	515000ef          	jal	ra,ffffffffc0200da2 <idt_init>
ffffffffc0200092:	6db030ef          	jal	ra,ffffffffc0203f6c <vmm_init>
ffffffffc0200096:	0c0070ef          	jal	ra,ffffffffc0207156 <sched_init>
ffffffffc020009a:	4c7060ef          	jal	ra,ffffffffc0206d60 <proc_init>
ffffffffc020009e:	1bf000ef          	jal	ra,ffffffffc0200a5c <ide_init>
ffffffffc02000a2:	10c050ef          	jal	ra,ffffffffc02051ae <fs_init>
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
ffffffffc02000cc:	59050513          	addi	a0,a0,1424 # ffffffffc020b658 <etext+0x28>
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
ffffffffc020019a:	79f0a0ef          	jal	ra,ffffffffc020b138 <vprintfmt>
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
ffffffffc02001d6:	7630a0ef          	jal	ra,ffffffffc020b138 <vprintfmt>
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
ffffffffc0200200:	3240b0ef          	jal	ra,ffffffffc020b524 <strlen>
ffffffffc0200204:	842a                	mv	s0,a0
ffffffffc0200206:	0505                	addi	a0,a0,1
ffffffffc0200208:	58b010ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc020020c:	84aa                	mv	s1,a0
ffffffffc020020e:	c901                	beqz	a0,ffffffffc020021e <strdup+0x2a>
ffffffffc0200210:	8622                	mv	a2,s0
ffffffffc0200212:	85ca                	mv	a1,s2
ffffffffc0200214:	9426                	add	s0,s0,s1
ffffffffc0200216:	4020b0ef          	jal	ra,ffffffffc020b618 <memcpy>
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
ffffffffc0200232:	43250513          	addi	a0,a0,1074 # ffffffffc020b660 <etext+0x30>
ffffffffc0200236:	e406                	sd	ra,8(sp)
ffffffffc0200238:	f6fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020023c:	00000597          	auipc	a1,0x0
ffffffffc0200240:	e0e58593          	addi	a1,a1,-498 # ffffffffc020004a <kern_init>
ffffffffc0200244:	0000b517          	auipc	a0,0xb
ffffffffc0200248:	43c50513          	addi	a0,a0,1084 # ffffffffc020b680 <etext+0x50>
ffffffffc020024c:	f5bff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200250:	0000b597          	auipc	a1,0xb
ffffffffc0200254:	3e058593          	addi	a1,a1,992 # ffffffffc020b630 <etext>
ffffffffc0200258:	0000b517          	auipc	a0,0xb
ffffffffc020025c:	44850513          	addi	a0,a0,1096 # ffffffffc020b6a0 <etext+0x70>
ffffffffc0200260:	f47ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200264:	00091597          	auipc	a1,0x91
ffffffffc0200268:	dfc58593          	addi	a1,a1,-516 # ffffffffc0291060 <buf>
ffffffffc020026c:	0000b517          	auipc	a0,0xb
ffffffffc0200270:	45450513          	addi	a0,a0,1108 # ffffffffc020b6c0 <etext+0x90>
ffffffffc0200274:	f33ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200278:	00096597          	auipc	a1,0x96
ffffffffc020027c:	69858593          	addi	a1,a1,1688 # ffffffffc0296910 <end>
ffffffffc0200280:	0000b517          	auipc	a0,0xb
ffffffffc0200284:	46050513          	addi	a0,a0,1120 # ffffffffc020b6e0 <etext+0xb0>
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
ffffffffc02002b2:	45250513          	addi	a0,a0,1106 # ffffffffc020b700 <etext+0xd0>
ffffffffc02002b6:	0141                	addi	sp,sp,16
ffffffffc02002b8:	b5fd                	j	ffffffffc02001a6 <cprintf>

ffffffffc02002ba <print_stackframe>:
ffffffffc02002ba:	1141                	addi	sp,sp,-16
ffffffffc02002bc:	0000b617          	auipc	a2,0xb
ffffffffc02002c0:	47460613          	addi	a2,a2,1140 # ffffffffc020b730 <etext+0x100>
ffffffffc02002c4:	04e00593          	li	a1,78
ffffffffc02002c8:	0000b517          	auipc	a0,0xb
ffffffffc02002cc:	48050513          	addi	a0,a0,1152 # ffffffffc020b748 <etext+0x118>
ffffffffc02002d0:	e406                	sd	ra,8(sp)
ffffffffc02002d2:	1cc000ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02002d6 <mon_help>:
ffffffffc02002d6:	1141                	addi	sp,sp,-16
ffffffffc02002d8:	0000b617          	auipc	a2,0xb
ffffffffc02002dc:	48860613          	addi	a2,a2,1160 # ffffffffc020b760 <etext+0x130>
ffffffffc02002e0:	0000b597          	auipc	a1,0xb
ffffffffc02002e4:	4a058593          	addi	a1,a1,1184 # ffffffffc020b780 <etext+0x150>
ffffffffc02002e8:	0000b517          	auipc	a0,0xb
ffffffffc02002ec:	4a050513          	addi	a0,a0,1184 # ffffffffc020b788 <etext+0x158>
ffffffffc02002f0:	e406                	sd	ra,8(sp)
ffffffffc02002f2:	eb5ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02002f6:	0000b617          	auipc	a2,0xb
ffffffffc02002fa:	4a260613          	addi	a2,a2,1186 # ffffffffc020b798 <etext+0x168>
ffffffffc02002fe:	0000b597          	auipc	a1,0xb
ffffffffc0200302:	4c258593          	addi	a1,a1,1218 # ffffffffc020b7c0 <etext+0x190>
ffffffffc0200306:	0000b517          	auipc	a0,0xb
ffffffffc020030a:	48250513          	addi	a0,a0,1154 # ffffffffc020b788 <etext+0x158>
ffffffffc020030e:	e99ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200312:	0000b617          	auipc	a2,0xb
ffffffffc0200316:	4be60613          	addi	a2,a2,1214 # ffffffffc020b7d0 <etext+0x1a0>
ffffffffc020031a:	0000b597          	auipc	a1,0xb
ffffffffc020031e:	4d658593          	addi	a1,a1,1238 # ffffffffc020b7f0 <etext+0x1c0>
ffffffffc0200322:	0000b517          	auipc	a0,0xb
ffffffffc0200326:	46650513          	addi	a0,a0,1126 # ffffffffc020b788 <etext+0x158>
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
ffffffffc0200360:	4a450513          	addi	a0,a0,1188 # ffffffffc020b800 <etext+0x1d0>
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
ffffffffc0200382:	4aa50513          	addi	a0,a0,1194 # ffffffffc020b828 <etext+0x1f8>
ffffffffc0200386:	e21ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020038a:	000b8563          	beqz	s7,ffffffffc0200394 <kmonitor+0x3e>
ffffffffc020038e:	855e                	mv	a0,s7
ffffffffc0200390:	3fb000ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0200394:	0000bc17          	auipc	s8,0xb
ffffffffc0200398:	504c0c13          	addi	s8,s8,1284 # ffffffffc020b898 <commands>
ffffffffc020039c:	0000b917          	auipc	s2,0xb
ffffffffc02003a0:	4b490913          	addi	s2,s2,1204 # ffffffffc020b850 <etext+0x220>
ffffffffc02003a4:	0000b497          	auipc	s1,0xb
ffffffffc02003a8:	4b448493          	addi	s1,s1,1204 # ffffffffc020b858 <etext+0x228>
ffffffffc02003ac:	49bd                	li	s3,15
ffffffffc02003ae:	0000bb17          	auipc	s6,0xb
ffffffffc02003b2:	4b2b0b13          	addi	s6,s6,1202 # ffffffffc020b860 <etext+0x230>
ffffffffc02003b6:	0000ba17          	auipc	s4,0xb
ffffffffc02003ba:	3caa0a13          	addi	s4,s4,970 # ffffffffc020b780 <etext+0x150>
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
ffffffffc02003dc:	4c0d0d13          	addi	s10,s10,1216 # ffffffffc020b898 <commands>
ffffffffc02003e0:	8552                	mv	a0,s4
ffffffffc02003e2:	4401                	li	s0,0
ffffffffc02003e4:	0d61                	addi	s10,s10,24
ffffffffc02003e6:	1860b0ef          	jal	ra,ffffffffc020b56c <strcmp>
ffffffffc02003ea:	c919                	beqz	a0,ffffffffc0200400 <kmonitor+0xaa>
ffffffffc02003ec:	2405                	addiw	s0,s0,1
ffffffffc02003ee:	0b540063          	beq	s0,s5,ffffffffc020048e <kmonitor+0x138>
ffffffffc02003f2:	000d3503          	ld	a0,0(s10)
ffffffffc02003f6:	6582                	ld	a1,0(sp)
ffffffffc02003f8:	0d61                	addi	s10,s10,24
ffffffffc02003fa:	1720b0ef          	jal	ra,ffffffffc020b56c <strcmp>
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
ffffffffc0200438:	1780b0ef          	jal	ra,ffffffffc020b5b0 <strchr>
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
ffffffffc0200476:	13a0b0ef          	jal	ra,ffffffffc020b5b0 <strchr>
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
ffffffffc0200494:	3f050513          	addi	a0,a0,1008 # ffffffffc020b880 <etext+0x250>
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
ffffffffc02004d0:	41450513          	addi	a0,a0,1044 # ffffffffc020b8e0 <commands+0x48>
ffffffffc02004d4:	e43e                	sd	a5,8(sp)
ffffffffc02004d6:	cd1ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004da:	65a2                	ld	a1,8(sp)
ffffffffc02004dc:	8522                	mv	a0,s0
ffffffffc02004de:	ca3ff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc02004e2:	0000c517          	auipc	a0,0xc
ffffffffc02004e6:	6be50513          	addi	a0,a0,1726 # ffffffffc020cba0 <default_pmm_manager+0x610>
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
ffffffffc020051a:	3ea50513          	addi	a0,a0,1002 # ffffffffc020b900 <commands+0x68>
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
ffffffffc020053a:	66a50513          	addi	a0,a0,1642 # ffffffffc020cba0 <default_pmm_manager+0x610>
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
ffffffffc020056c:	3b850513          	addi	a0,a0,952 # ffffffffc020b920 <commands+0x88>
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
ffffffffc02006b2:	29250513          	addi	a0,a0,658 # ffffffffc020b940 <commands+0xa8>
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
ffffffffc02006e0:	27450513          	addi	a0,a0,628 # ffffffffc020b950 <commands+0xb8>
ffffffffc02006e4:	ac3ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006e8:	00014417          	auipc	s0,0x14
ffffffffc02006ec:	92040413          	addi	s0,s0,-1760 # ffffffffc0214008 <boot_dtb>
ffffffffc02006f0:	600c                	ld	a1,0(s0)
ffffffffc02006f2:	0000b517          	auipc	a0,0xb
ffffffffc02006f6:	26e50513          	addi	a0,a0,622 # ffffffffc020b960 <commands+0xc8>
ffffffffc02006fa:	aadff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006fe:	00043a03          	ld	s4,0(s0)
ffffffffc0200702:	0000b517          	auipc	a0,0xb
ffffffffc0200706:	27650513          	addi	a0,a0,630 # ffffffffc020b978 <commands+0xe0>
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
ffffffffc02007c0:	20c90913          	addi	s2,s2,524 # ffffffffc020b9c8 <commands+0x130>
ffffffffc02007c4:	49bd                	li	s3,15
ffffffffc02007c6:	4d91                	li	s11,4
ffffffffc02007c8:	4d05                	li	s10,1
ffffffffc02007ca:	0000b497          	auipc	s1,0xb
ffffffffc02007ce:	1f648493          	addi	s1,s1,502 # ffffffffc020b9c0 <commands+0x128>
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
ffffffffc0200822:	22250513          	addi	a0,a0,546 # ffffffffc020ba40 <commands+0x1a8>
ffffffffc0200826:	981ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020082a:	0000b517          	auipc	a0,0xb
ffffffffc020082e:	24e50513          	addi	a0,a0,590 # ffffffffc020ba78 <commands+0x1e0>
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
ffffffffc020086e:	12e50513          	addi	a0,a0,302 # ffffffffc020b998 <commands+0x100>
ffffffffc0200872:	6109                	addi	sp,sp,128
ffffffffc0200874:	ba0d                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200876:	8556                	mv	a0,s5
ffffffffc0200878:	4ad0a0ef          	jal	ra,ffffffffc020b524 <strlen>
ffffffffc020087c:	8a2a                	mv	s4,a0
ffffffffc020087e:	4619                	li	a2,6
ffffffffc0200880:	85a6                	mv	a1,s1
ffffffffc0200882:	8556                	mv	a0,s5
ffffffffc0200884:	2a01                	sext.w	s4,s4
ffffffffc0200886:	5050a0ef          	jal	ra,ffffffffc020b58a <strncmp>
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
ffffffffc020091c:	4510a0ef          	jal	ra,ffffffffc020b56c <strcmp>
ffffffffc0200920:	66a2                	ld	a3,8(sp)
ffffffffc0200922:	f94d                	bnez	a0,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200924:	fb59f8e3          	bgeu	s3,s5,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200928:	00ca3783          	ld	a5,12(s4)
ffffffffc020092c:	014a3703          	ld	a4,20(s4)
ffffffffc0200930:	0000b517          	auipc	a0,0xb
ffffffffc0200934:	0a050513          	addi	a0,a0,160 # ffffffffc020b9d0 <commands+0x138>
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
ffffffffc0200a02:	ff250513          	addi	a0,a0,-14 # ffffffffc020b9f0 <commands+0x158>
ffffffffc0200a06:	fa0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a0a:	014b5613          	srli	a2,s6,0x14
ffffffffc0200a0e:	85da                	mv	a1,s6
ffffffffc0200a10:	0000b517          	auipc	a0,0xb
ffffffffc0200a14:	ff850513          	addi	a0,a0,-8 # ffffffffc020ba08 <commands+0x170>
ffffffffc0200a18:	f8eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a1c:	008b05b3          	add	a1,s6,s0
ffffffffc0200a20:	15fd                	addi	a1,a1,-1
ffffffffc0200a22:	0000b517          	auipc	a0,0xb
ffffffffc0200a26:	00650513          	addi	a0,a0,6 # ffffffffc020ba28 <commands+0x190>
ffffffffc0200a2a:	f7cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a2e:	0000b517          	auipc	a0,0xb
ffffffffc0200a32:	04a50513          	addi	a0,a0,74 # ffffffffc020ba78 <commands+0x1e0>
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
ffffffffc0200abc:	fd868693          	addi	a3,a3,-40 # ffffffffc020ba90 <commands+0x1f8>
ffffffffc0200ac0:	0000b617          	auipc	a2,0xb
ffffffffc0200ac4:	fe860613          	addi	a2,a2,-24 # ffffffffc020baa8 <commands+0x210>
ffffffffc0200ac8:	45c5                	li	a1,17
ffffffffc0200aca:	0000b517          	auipc	a0,0xb
ffffffffc0200ace:	ff650513          	addi	a0,a0,-10 # ffffffffc020bac0 <commands+0x228>
ffffffffc0200ad2:	9cdff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200ad6:	0000b697          	auipc	a3,0xb
ffffffffc0200ada:	00268693          	addi	a3,a3,2 # ffffffffc020bad8 <commands+0x240>
ffffffffc0200ade:	0000b617          	auipc	a2,0xb
ffffffffc0200ae2:	fca60613          	addi	a2,a2,-54 # ffffffffc020baa8 <commands+0x210>
ffffffffc0200ae6:	45d1                	li	a1,20
ffffffffc0200ae8:	0000b517          	auipc	a0,0xb
ffffffffc0200aec:	fd850513          	addi	a0,a0,-40 # ffffffffc020bac0 <commands+0x228>
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
ffffffffc0200b9a:	f5a68693          	addi	a3,a3,-166 # ffffffffc020baf0 <commands+0x258>
ffffffffc0200b9e:	0000b617          	auipc	a2,0xb
ffffffffc0200ba2:	f0a60613          	addi	a2,a2,-246 # ffffffffc020baa8 <commands+0x210>
ffffffffc0200ba6:	02200593          	li	a1,34
ffffffffc0200baa:	0000b517          	auipc	a0,0xb
ffffffffc0200bae:	f1650513          	addi	a0,a0,-234 # ffffffffc020bac0 <commands+0x228>
ffffffffc0200bb2:	8edff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200bb6:	0000b697          	auipc	a3,0xb
ffffffffc0200bba:	f6268693          	addi	a3,a3,-158 # ffffffffc020bb18 <commands+0x280>
ffffffffc0200bbe:	0000b617          	auipc	a2,0xb
ffffffffc0200bc2:	eea60613          	addi	a2,a2,-278 # ffffffffc020baa8 <commands+0x210>
ffffffffc0200bc6:	02300593          	li	a1,35
ffffffffc0200bca:	0000b517          	auipc	a0,0xb
ffffffffc0200bce:	ef650513          	addi	a0,a0,-266 # ffffffffc020bac0 <commands+0x228>
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
ffffffffc0200c30:	ec468693          	addi	a3,a3,-316 # ffffffffc020baf0 <commands+0x258>
ffffffffc0200c34:	0000b617          	auipc	a2,0xb
ffffffffc0200c38:	e7460613          	addi	a2,a2,-396 # ffffffffc020baa8 <commands+0x210>
ffffffffc0200c3c:	02900593          	li	a1,41
ffffffffc0200c40:	0000b517          	auipc	a0,0xb
ffffffffc0200c44:	e8050513          	addi	a0,a0,-384 # ffffffffc020bac0 <commands+0x228>
ffffffffc0200c48:	857ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200c4c:	0000b697          	auipc	a3,0xb
ffffffffc0200c50:	ecc68693          	addi	a3,a3,-308 # ffffffffc020bb18 <commands+0x280>
ffffffffc0200c54:	0000b617          	auipc	a2,0xb
ffffffffc0200c58:	e5460613          	addi	a2,a2,-428 # ffffffffc020baa8 <commands+0x210>
ffffffffc0200c5c:	02a00593          	li	a1,42
ffffffffc0200c60:	0000b517          	auipc	a0,0xb
ffffffffc0200c64:	e6050513          	addi	a0,a0,-416 # ffffffffc020bac0 <commands+0x228>
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
ffffffffc0200c98:	1810a0ef          	jal	ra,ffffffffc020b618 <memcpy>
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
ffffffffc0200cc2:	1570a0ef          	jal	ra,ffffffffc020b618 <memcpy>
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
ffffffffc0200ce4:	0e30a0ef          	jal	ra,ffffffffc020b5c6 <memset>
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
ffffffffc0200d16:	e5e50513          	addi	a0,a0,-418 # ffffffffc020bb70 <commands+0x2d8>
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
ffffffffc0200d38:	e9458593          	addi	a1,a1,-364 # ffffffffc020bbc8 <commands+0x330>
ffffffffc0200d3c:	01f0a0ef          	jal	ra,ffffffffc020b55a <strcpy>
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
ffffffffc0200d80:	ddc50513          	addi	a0,a0,-548 # ffffffffc020bb58 <commands+0x2c0>
ffffffffc0200d84:	6105                	addi	sp,sp,32
ffffffffc0200d86:	c20ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0200d8a:	0000b617          	auipc	a2,0xb
ffffffffc0200d8e:	e0e60613          	addi	a2,a2,-498 # ffffffffc020bb98 <commands+0x300>
ffffffffc0200d92:	03200593          	li	a1,50
ffffffffc0200d96:	0000b517          	auipc	a0,0xb
ffffffffc0200d9a:	e1a50513          	addi	a0,a0,-486 # ffffffffc020bbb0 <commands+0x318>
ffffffffc0200d9e:	f00ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200da2 <idt_init>:
ffffffffc0200da2:	14005073          	csrwi	sscratch,0
ffffffffc0200da6:	00000797          	auipc	a5,0x0
ffffffffc0200daa:	43e78793          	addi	a5,a5,1086 # ffffffffc02011e4 <__alltraps>
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
ffffffffc0200dc8:	e1450513          	addi	a0,a0,-492 # ffffffffc020bbd8 <commands+0x340>
ffffffffc0200dcc:	e406                	sd	ra,8(sp)
ffffffffc0200dce:	bd8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dd2:	640c                	ld	a1,8(s0)
ffffffffc0200dd4:	0000b517          	auipc	a0,0xb
ffffffffc0200dd8:	e1c50513          	addi	a0,a0,-484 # ffffffffc020bbf0 <commands+0x358>
ffffffffc0200ddc:	bcaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200de0:	680c                	ld	a1,16(s0)
ffffffffc0200de2:	0000b517          	auipc	a0,0xb
ffffffffc0200de6:	e2650513          	addi	a0,a0,-474 # ffffffffc020bc08 <commands+0x370>
ffffffffc0200dea:	bbcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dee:	6c0c                	ld	a1,24(s0)
ffffffffc0200df0:	0000b517          	auipc	a0,0xb
ffffffffc0200df4:	e3050513          	addi	a0,a0,-464 # ffffffffc020bc20 <commands+0x388>
ffffffffc0200df8:	baeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dfc:	700c                	ld	a1,32(s0)
ffffffffc0200dfe:	0000b517          	auipc	a0,0xb
ffffffffc0200e02:	e3a50513          	addi	a0,a0,-454 # ffffffffc020bc38 <commands+0x3a0>
ffffffffc0200e06:	ba0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e0a:	740c                	ld	a1,40(s0)
ffffffffc0200e0c:	0000b517          	auipc	a0,0xb
ffffffffc0200e10:	e4450513          	addi	a0,a0,-444 # ffffffffc020bc50 <commands+0x3b8>
ffffffffc0200e14:	b92ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e18:	780c                	ld	a1,48(s0)
ffffffffc0200e1a:	0000b517          	auipc	a0,0xb
ffffffffc0200e1e:	e4e50513          	addi	a0,a0,-434 # ffffffffc020bc68 <commands+0x3d0>
ffffffffc0200e22:	b84ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e26:	7c0c                	ld	a1,56(s0)
ffffffffc0200e28:	0000b517          	auipc	a0,0xb
ffffffffc0200e2c:	e5850513          	addi	a0,a0,-424 # ffffffffc020bc80 <commands+0x3e8>
ffffffffc0200e30:	b76ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e34:	602c                	ld	a1,64(s0)
ffffffffc0200e36:	0000b517          	auipc	a0,0xb
ffffffffc0200e3a:	e6250513          	addi	a0,a0,-414 # ffffffffc020bc98 <commands+0x400>
ffffffffc0200e3e:	b68ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e42:	642c                	ld	a1,72(s0)
ffffffffc0200e44:	0000b517          	auipc	a0,0xb
ffffffffc0200e48:	e6c50513          	addi	a0,a0,-404 # ffffffffc020bcb0 <commands+0x418>
ffffffffc0200e4c:	b5aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e50:	682c                	ld	a1,80(s0)
ffffffffc0200e52:	0000b517          	auipc	a0,0xb
ffffffffc0200e56:	e7650513          	addi	a0,a0,-394 # ffffffffc020bcc8 <commands+0x430>
ffffffffc0200e5a:	b4cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e5e:	6c2c                	ld	a1,88(s0)
ffffffffc0200e60:	0000b517          	auipc	a0,0xb
ffffffffc0200e64:	e8050513          	addi	a0,a0,-384 # ffffffffc020bce0 <commands+0x448>
ffffffffc0200e68:	b3eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e6c:	702c                	ld	a1,96(s0)
ffffffffc0200e6e:	0000b517          	auipc	a0,0xb
ffffffffc0200e72:	e8a50513          	addi	a0,a0,-374 # ffffffffc020bcf8 <commands+0x460>
ffffffffc0200e76:	b30ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e7a:	742c                	ld	a1,104(s0)
ffffffffc0200e7c:	0000b517          	auipc	a0,0xb
ffffffffc0200e80:	e9450513          	addi	a0,a0,-364 # ffffffffc020bd10 <commands+0x478>
ffffffffc0200e84:	b22ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e88:	782c                	ld	a1,112(s0)
ffffffffc0200e8a:	0000b517          	auipc	a0,0xb
ffffffffc0200e8e:	e9e50513          	addi	a0,a0,-354 # ffffffffc020bd28 <commands+0x490>
ffffffffc0200e92:	b14ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e96:	7c2c                	ld	a1,120(s0)
ffffffffc0200e98:	0000b517          	auipc	a0,0xb
ffffffffc0200e9c:	ea850513          	addi	a0,a0,-344 # ffffffffc020bd40 <commands+0x4a8>
ffffffffc0200ea0:	b06ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ea4:	604c                	ld	a1,128(s0)
ffffffffc0200ea6:	0000b517          	auipc	a0,0xb
ffffffffc0200eaa:	eb250513          	addi	a0,a0,-334 # ffffffffc020bd58 <commands+0x4c0>
ffffffffc0200eae:	af8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eb2:	644c                	ld	a1,136(s0)
ffffffffc0200eb4:	0000b517          	auipc	a0,0xb
ffffffffc0200eb8:	ebc50513          	addi	a0,a0,-324 # ffffffffc020bd70 <commands+0x4d8>
ffffffffc0200ebc:	aeaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ec0:	684c                	ld	a1,144(s0)
ffffffffc0200ec2:	0000b517          	auipc	a0,0xb
ffffffffc0200ec6:	ec650513          	addi	a0,a0,-314 # ffffffffc020bd88 <commands+0x4f0>
ffffffffc0200eca:	adcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ece:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed0:	0000b517          	auipc	a0,0xb
ffffffffc0200ed4:	ed050513          	addi	a0,a0,-304 # ffffffffc020bda0 <commands+0x508>
ffffffffc0200ed8:	aceff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200edc:	704c                	ld	a1,160(s0)
ffffffffc0200ede:	0000b517          	auipc	a0,0xb
ffffffffc0200ee2:	eda50513          	addi	a0,a0,-294 # ffffffffc020bdb8 <commands+0x520>
ffffffffc0200ee6:	ac0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eea:	744c                	ld	a1,168(s0)
ffffffffc0200eec:	0000b517          	auipc	a0,0xb
ffffffffc0200ef0:	ee450513          	addi	a0,a0,-284 # ffffffffc020bdd0 <commands+0x538>
ffffffffc0200ef4:	ab2ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ef8:	784c                	ld	a1,176(s0)
ffffffffc0200efa:	0000b517          	auipc	a0,0xb
ffffffffc0200efe:	eee50513          	addi	a0,a0,-274 # ffffffffc020bde8 <commands+0x550>
ffffffffc0200f02:	aa4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f06:	7c4c                	ld	a1,184(s0)
ffffffffc0200f08:	0000b517          	auipc	a0,0xb
ffffffffc0200f0c:	ef850513          	addi	a0,a0,-264 # ffffffffc020be00 <commands+0x568>
ffffffffc0200f10:	a96ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f14:	606c                	ld	a1,192(s0)
ffffffffc0200f16:	0000b517          	auipc	a0,0xb
ffffffffc0200f1a:	f0250513          	addi	a0,a0,-254 # ffffffffc020be18 <commands+0x580>
ffffffffc0200f1e:	a88ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f22:	646c                	ld	a1,200(s0)
ffffffffc0200f24:	0000b517          	auipc	a0,0xb
ffffffffc0200f28:	f0c50513          	addi	a0,a0,-244 # ffffffffc020be30 <commands+0x598>
ffffffffc0200f2c:	a7aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f30:	686c                	ld	a1,208(s0)
ffffffffc0200f32:	0000b517          	auipc	a0,0xb
ffffffffc0200f36:	f1650513          	addi	a0,a0,-234 # ffffffffc020be48 <commands+0x5b0>
ffffffffc0200f3a:	a6cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f3e:	6c6c                	ld	a1,216(s0)
ffffffffc0200f40:	0000b517          	auipc	a0,0xb
ffffffffc0200f44:	f2050513          	addi	a0,a0,-224 # ffffffffc020be60 <commands+0x5c8>
ffffffffc0200f48:	a5eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f4c:	706c                	ld	a1,224(s0)
ffffffffc0200f4e:	0000b517          	auipc	a0,0xb
ffffffffc0200f52:	f2a50513          	addi	a0,a0,-214 # ffffffffc020be78 <commands+0x5e0>
ffffffffc0200f56:	a50ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f5a:	746c                	ld	a1,232(s0)
ffffffffc0200f5c:	0000b517          	auipc	a0,0xb
ffffffffc0200f60:	f3450513          	addi	a0,a0,-204 # ffffffffc020be90 <commands+0x5f8>
ffffffffc0200f64:	a42ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f68:	786c                	ld	a1,240(s0)
ffffffffc0200f6a:	0000b517          	auipc	a0,0xb
ffffffffc0200f6e:	f3e50513          	addi	a0,a0,-194 # ffffffffc020bea8 <commands+0x610>
ffffffffc0200f72:	a34ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f76:	7c6c                	ld	a1,248(s0)
ffffffffc0200f78:	6402                	ld	s0,0(sp)
ffffffffc0200f7a:	60a2                	ld	ra,8(sp)
ffffffffc0200f7c:	0000b517          	auipc	a0,0xb
ffffffffc0200f80:	f4450513          	addi	a0,a0,-188 # ffffffffc020bec0 <commands+0x628>
ffffffffc0200f84:	0141                	addi	sp,sp,16
ffffffffc0200f86:	a20ff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200f8a <print_trapframe>:
ffffffffc0200f8a:	1141                	addi	sp,sp,-16
ffffffffc0200f8c:	e022                	sd	s0,0(sp)
ffffffffc0200f8e:	85aa                	mv	a1,a0
ffffffffc0200f90:	842a                	mv	s0,a0
ffffffffc0200f92:	0000b517          	auipc	a0,0xb
ffffffffc0200f96:	f4650513          	addi	a0,a0,-186 # ffffffffc020bed8 <commands+0x640>
ffffffffc0200f9a:	e406                	sd	ra,8(sp)
ffffffffc0200f9c:	a0aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fa0:	8522                	mv	a0,s0
ffffffffc0200fa2:	e1bff0ef          	jal	ra,ffffffffc0200dbc <print_regs>
ffffffffc0200fa6:	10043583          	ld	a1,256(s0)
ffffffffc0200faa:	0000b517          	auipc	a0,0xb
ffffffffc0200fae:	f4650513          	addi	a0,a0,-186 # ffffffffc020bef0 <commands+0x658>
ffffffffc0200fb2:	9f4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fb6:	10843583          	ld	a1,264(s0)
ffffffffc0200fba:	0000b517          	auipc	a0,0xb
ffffffffc0200fbe:	f4e50513          	addi	a0,a0,-178 # ffffffffc020bf08 <commands+0x670>
ffffffffc0200fc2:	9e4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fc6:	11043583          	ld	a1,272(s0)
ffffffffc0200fca:	0000b517          	auipc	a0,0xb
ffffffffc0200fce:	f5650513          	addi	a0,a0,-170 # ffffffffc020bf20 <commands+0x688>
ffffffffc0200fd2:	9d4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fd6:	11843583          	ld	a1,280(s0)
ffffffffc0200fda:	6402                	ld	s0,0(sp)
ffffffffc0200fdc:	60a2                	ld	ra,8(sp)
ffffffffc0200fde:	0000b517          	auipc	a0,0xb
ffffffffc0200fe2:	f5250513          	addi	a0,a0,-174 # ffffffffc020bf30 <commands+0x698>
ffffffffc0200fe6:	0141                	addi	sp,sp,16
ffffffffc0200fe8:	9beff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200fec <interrupt_handler>:
ffffffffc0200fec:	11853783          	ld	a5,280(a0)
ffffffffc0200ff0:	472d                	li	a4,11
ffffffffc0200ff2:	0786                	slli	a5,a5,0x1
ffffffffc0200ff4:	8385                	srli	a5,a5,0x1
ffffffffc0200ff6:	06f76e63          	bltu	a4,a5,ffffffffc0201072 <interrupt_handler+0x86>
ffffffffc0200ffa:	0000b717          	auipc	a4,0xb
ffffffffc0200ffe:	fee70713          	addi	a4,a4,-18 # ffffffffc020bfe8 <commands+0x750>
ffffffffc0201002:	078a                	slli	a5,a5,0x2
ffffffffc0201004:	97ba                	add	a5,a5,a4
ffffffffc0201006:	439c                	lw	a5,0(a5)
ffffffffc0201008:	97ba                	add	a5,a5,a4
ffffffffc020100a:	8782                	jr	a5
ffffffffc020100c:	0000b517          	auipc	a0,0xb
ffffffffc0201010:	f9c50513          	addi	a0,a0,-100 # ffffffffc020bfa8 <commands+0x710>
ffffffffc0201014:	992ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201018:	0000b517          	auipc	a0,0xb
ffffffffc020101c:	f7050513          	addi	a0,a0,-144 # ffffffffc020bf88 <commands+0x6f0>
ffffffffc0201020:	986ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201024:	0000b517          	auipc	a0,0xb
ffffffffc0201028:	f2450513          	addi	a0,a0,-220 # ffffffffc020bf48 <commands+0x6b0>
ffffffffc020102c:	97aff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201030:	0000b517          	auipc	a0,0xb
ffffffffc0201034:	f3850513          	addi	a0,a0,-200 # ffffffffc020bf68 <commands+0x6d0>
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
ffffffffc020105c:	0ff57513          	zext.b	a0,a0
ffffffffc0201060:	0141                	addi	sp,sp,16
ffffffffc0201062:	2d50706f          	j	ffffffffc0208b36 <dev_stdin_write>
ffffffffc0201066:	0000b517          	auipc	a0,0xb
ffffffffc020106a:	f6250513          	addi	a0,a0,-158 # ffffffffc020bfc8 <commands+0x730>
ffffffffc020106e:	938ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201072:	bf21                	j	ffffffffc0200f8a <print_trapframe>

ffffffffc0201074 <exception_handler>:
ffffffffc0201074:	11853783          	ld	a5,280(a0)
ffffffffc0201078:	1141                	addi	sp,sp,-16
ffffffffc020107a:	e022                	sd	s0,0(sp)
ffffffffc020107c:	e406                	sd	ra,8(sp)
ffffffffc020107e:	473d                	li	a4,15
ffffffffc0201080:	842a                	mv	s0,a0
ffffffffc0201082:	0af76b63          	bltu	a4,a5,ffffffffc0201138 <exception_handler+0xc4>
ffffffffc0201086:	0000b717          	auipc	a4,0xb
ffffffffc020108a:	12270713          	addi	a4,a4,290 # ffffffffc020c1a8 <commands+0x910>
ffffffffc020108e:	078a                	slli	a5,a5,0x2
ffffffffc0201090:	97ba                	add	a5,a5,a4
ffffffffc0201092:	439c                	lw	a5,0(a5)
ffffffffc0201094:	97ba                	add	a5,a5,a4
ffffffffc0201096:	8782                	jr	a5
ffffffffc0201098:	0000b517          	auipc	a0,0xb
ffffffffc020109c:	06850513          	addi	a0,a0,104 # ffffffffc020c100 <commands+0x868>
ffffffffc02010a0:	906ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02010a4:	10843783          	ld	a5,264(s0)
ffffffffc02010a8:	60a2                	ld	ra,8(sp)
ffffffffc02010aa:	0791                	addi	a5,a5,4
ffffffffc02010ac:	10f43423          	sd	a5,264(s0)
ffffffffc02010b0:	6402                	ld	s0,0(sp)
ffffffffc02010b2:	0141                	addi	sp,sp,16
ffffffffc02010b4:	5c80606f          	j	ffffffffc020767c <syscall>
ffffffffc02010b8:	0000b517          	auipc	a0,0xb
ffffffffc02010bc:	06850513          	addi	a0,a0,104 # ffffffffc020c120 <commands+0x888>
ffffffffc02010c0:	6402                	ld	s0,0(sp)
ffffffffc02010c2:	60a2                	ld	ra,8(sp)
ffffffffc02010c4:	0141                	addi	sp,sp,16
ffffffffc02010c6:	8e0ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010ca:	0000b517          	auipc	a0,0xb
ffffffffc02010ce:	07650513          	addi	a0,a0,118 # ffffffffc020c140 <commands+0x8a8>
ffffffffc02010d2:	b7fd                	j	ffffffffc02010c0 <exception_handler+0x4c>
ffffffffc02010d4:	0000b517          	auipc	a0,0xb
ffffffffc02010d8:	08c50513          	addi	a0,a0,140 # ffffffffc020c160 <commands+0x8c8>
ffffffffc02010dc:	b7d5                	j	ffffffffc02010c0 <exception_handler+0x4c>
ffffffffc02010de:	0000b517          	auipc	a0,0xb
ffffffffc02010e2:	09a50513          	addi	a0,a0,154 # ffffffffc020c178 <commands+0x8e0>
ffffffffc02010e6:	bfe9                	j	ffffffffc02010c0 <exception_handler+0x4c>
ffffffffc02010e8:	0000b517          	auipc	a0,0xb
ffffffffc02010ec:	0a850513          	addi	a0,a0,168 # ffffffffc020c190 <commands+0x8f8>
ffffffffc02010f0:	bfc1                	j	ffffffffc02010c0 <exception_handler+0x4c>
ffffffffc02010f2:	0000b517          	auipc	a0,0xb
ffffffffc02010f6:	f2650513          	addi	a0,a0,-218 # ffffffffc020c018 <commands+0x780>
ffffffffc02010fa:	b7d9                	j	ffffffffc02010c0 <exception_handler+0x4c>
ffffffffc02010fc:	0000b517          	auipc	a0,0xb
ffffffffc0201100:	f3c50513          	addi	a0,a0,-196 # ffffffffc020c038 <commands+0x7a0>
ffffffffc0201104:	bf75                	j	ffffffffc02010c0 <exception_handler+0x4c>
ffffffffc0201106:	0000b517          	auipc	a0,0xb
ffffffffc020110a:	f5250513          	addi	a0,a0,-174 # ffffffffc020c058 <commands+0x7c0>
ffffffffc020110e:	bf4d                	j	ffffffffc02010c0 <exception_handler+0x4c>
ffffffffc0201110:	0000b517          	auipc	a0,0xb
ffffffffc0201114:	f6050513          	addi	a0,a0,-160 # ffffffffc020c070 <commands+0x7d8>
ffffffffc0201118:	b765                	j	ffffffffc02010c0 <exception_handler+0x4c>
ffffffffc020111a:	0000b517          	auipc	a0,0xb
ffffffffc020111e:	f6650513          	addi	a0,a0,-154 # ffffffffc020c080 <commands+0x7e8>
ffffffffc0201122:	bf79                	j	ffffffffc02010c0 <exception_handler+0x4c>
ffffffffc0201124:	0000b517          	auipc	a0,0xb
ffffffffc0201128:	f7c50513          	addi	a0,a0,-132 # ffffffffc020c0a0 <commands+0x808>
ffffffffc020112c:	bf51                	j	ffffffffc02010c0 <exception_handler+0x4c>
ffffffffc020112e:	0000b517          	auipc	a0,0xb
ffffffffc0201132:	fba50513          	addi	a0,a0,-70 # ffffffffc020c0e8 <commands+0x850>
ffffffffc0201136:	b769                	j	ffffffffc02010c0 <exception_handler+0x4c>
ffffffffc0201138:	8522                	mv	a0,s0
ffffffffc020113a:	6402                	ld	s0,0(sp)
ffffffffc020113c:	60a2                	ld	ra,8(sp)
ffffffffc020113e:	0141                	addi	sp,sp,16
ffffffffc0201140:	b5a9                	j	ffffffffc0200f8a <print_trapframe>
ffffffffc0201142:	0000b617          	auipc	a2,0xb
ffffffffc0201146:	f7660613          	addi	a2,a2,-138 # ffffffffc020c0b8 <commands+0x820>
ffffffffc020114a:	0b300593          	li	a1,179
ffffffffc020114e:	0000b517          	auipc	a0,0xb
ffffffffc0201152:	f8250513          	addi	a0,a0,-126 # ffffffffc020c0d0 <commands+0x838>
ffffffffc0201156:	b48ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020115a <trap>:
ffffffffc020115a:	1101                	addi	sp,sp,-32
ffffffffc020115c:	e822                	sd	s0,16(sp)
ffffffffc020115e:	00095417          	auipc	s0,0x95
ffffffffc0201162:	76240413          	addi	s0,s0,1890 # ffffffffc02968c0 <current>
ffffffffc0201166:	6018                	ld	a4,0(s0)
ffffffffc0201168:	ec06                	sd	ra,24(sp)
ffffffffc020116a:	e426                	sd	s1,8(sp)
ffffffffc020116c:	e04a                	sd	s2,0(sp)
ffffffffc020116e:	11853683          	ld	a3,280(a0)
ffffffffc0201172:	cf1d                	beqz	a4,ffffffffc02011b0 <trap+0x56>
ffffffffc0201174:	10053483          	ld	s1,256(a0)
ffffffffc0201178:	0a073903          	ld	s2,160(a4)
ffffffffc020117c:	f348                	sd	a0,160(a4)
ffffffffc020117e:	1004f493          	andi	s1,s1,256
ffffffffc0201182:	0206c463          	bltz	a3,ffffffffc02011aa <trap+0x50>
ffffffffc0201186:	eefff0ef          	jal	ra,ffffffffc0201074 <exception_handler>
ffffffffc020118a:	601c                	ld	a5,0(s0)
ffffffffc020118c:	0b27b023          	sd	s2,160(a5) # 400a0 <_binary_bin_swap_img_size+0x383a0>
ffffffffc0201190:	e499                	bnez	s1,ffffffffc020119e <trap+0x44>
ffffffffc0201192:	0b07a703          	lw	a4,176(a5)
ffffffffc0201196:	8b05                	andi	a4,a4,1
ffffffffc0201198:	e329                	bnez	a4,ffffffffc02011da <trap+0x80>
ffffffffc020119a:	6f9c                	ld	a5,24(a5)
ffffffffc020119c:	eb85                	bnez	a5,ffffffffc02011cc <trap+0x72>
ffffffffc020119e:	60e2                	ld	ra,24(sp)
ffffffffc02011a0:	6442                	ld	s0,16(sp)
ffffffffc02011a2:	64a2                	ld	s1,8(sp)
ffffffffc02011a4:	6902                	ld	s2,0(sp)
ffffffffc02011a6:	6105                	addi	sp,sp,32
ffffffffc02011a8:	8082                	ret
ffffffffc02011aa:	e43ff0ef          	jal	ra,ffffffffc0200fec <interrupt_handler>
ffffffffc02011ae:	bff1                	j	ffffffffc020118a <trap+0x30>
ffffffffc02011b0:	0006c863          	bltz	a3,ffffffffc02011c0 <trap+0x66>
ffffffffc02011b4:	6442                	ld	s0,16(sp)
ffffffffc02011b6:	60e2                	ld	ra,24(sp)
ffffffffc02011b8:	64a2                	ld	s1,8(sp)
ffffffffc02011ba:	6902                	ld	s2,0(sp)
ffffffffc02011bc:	6105                	addi	sp,sp,32
ffffffffc02011be:	bd5d                	j	ffffffffc0201074 <exception_handler>
ffffffffc02011c0:	6442                	ld	s0,16(sp)
ffffffffc02011c2:	60e2                	ld	ra,24(sp)
ffffffffc02011c4:	64a2                	ld	s1,8(sp)
ffffffffc02011c6:	6902                	ld	s2,0(sp)
ffffffffc02011c8:	6105                	addi	sp,sp,32
ffffffffc02011ca:	b50d                	j	ffffffffc0200fec <interrupt_handler>
ffffffffc02011cc:	6442                	ld	s0,16(sp)
ffffffffc02011ce:	60e2                	ld	ra,24(sp)
ffffffffc02011d0:	64a2                	ld	s1,8(sp)
ffffffffc02011d2:	6902                	ld	s2,0(sp)
ffffffffc02011d4:	6105                	addi	sp,sp,32
ffffffffc02011d6:	0840606f          	j	ffffffffc020725a <schedule>
ffffffffc02011da:	555d                	li	a0,-9
ffffffffc02011dc:	63f040ef          	jal	ra,ffffffffc020601a <do_exit>
ffffffffc02011e0:	601c                	ld	a5,0(s0)
ffffffffc02011e2:	bf65                	j	ffffffffc020119a <trap+0x40>

ffffffffc02011e4 <__alltraps>:
ffffffffc02011e4:	14011173          	csrrw	sp,sscratch,sp
ffffffffc02011e8:	00011463          	bnez	sp,ffffffffc02011f0 <__alltraps+0xc>
ffffffffc02011ec:	14002173          	csrr	sp,sscratch
ffffffffc02011f0:	712d                	addi	sp,sp,-288
ffffffffc02011f2:	e002                	sd	zero,0(sp)
ffffffffc02011f4:	e406                	sd	ra,8(sp)
ffffffffc02011f6:	ec0e                	sd	gp,24(sp)
ffffffffc02011f8:	f012                	sd	tp,32(sp)
ffffffffc02011fa:	f416                	sd	t0,40(sp)
ffffffffc02011fc:	f81a                	sd	t1,48(sp)
ffffffffc02011fe:	fc1e                	sd	t2,56(sp)
ffffffffc0201200:	e0a2                	sd	s0,64(sp)
ffffffffc0201202:	e4a6                	sd	s1,72(sp)
ffffffffc0201204:	e8aa                	sd	a0,80(sp)
ffffffffc0201206:	ecae                	sd	a1,88(sp)
ffffffffc0201208:	f0b2                	sd	a2,96(sp)
ffffffffc020120a:	f4b6                	sd	a3,104(sp)
ffffffffc020120c:	f8ba                	sd	a4,112(sp)
ffffffffc020120e:	fcbe                	sd	a5,120(sp)
ffffffffc0201210:	e142                	sd	a6,128(sp)
ffffffffc0201212:	e546                	sd	a7,136(sp)
ffffffffc0201214:	e94a                	sd	s2,144(sp)
ffffffffc0201216:	ed4e                	sd	s3,152(sp)
ffffffffc0201218:	f152                	sd	s4,160(sp)
ffffffffc020121a:	f556                	sd	s5,168(sp)
ffffffffc020121c:	f95a                	sd	s6,176(sp)
ffffffffc020121e:	fd5e                	sd	s7,184(sp)
ffffffffc0201220:	e1e2                	sd	s8,192(sp)
ffffffffc0201222:	e5e6                	sd	s9,200(sp)
ffffffffc0201224:	e9ea                	sd	s10,208(sp)
ffffffffc0201226:	edee                	sd	s11,216(sp)
ffffffffc0201228:	f1f2                	sd	t3,224(sp)
ffffffffc020122a:	f5f6                	sd	t4,232(sp)
ffffffffc020122c:	f9fa                	sd	t5,240(sp)
ffffffffc020122e:	fdfe                	sd	t6,248(sp)
ffffffffc0201230:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0201234:	100024f3          	csrr	s1,sstatus
ffffffffc0201238:	14102973          	csrr	s2,sepc
ffffffffc020123c:	143029f3          	csrr	s3,stval
ffffffffc0201240:	14202a73          	csrr	s4,scause
ffffffffc0201244:	e822                	sd	s0,16(sp)
ffffffffc0201246:	e226                	sd	s1,256(sp)
ffffffffc0201248:	e64a                	sd	s2,264(sp)
ffffffffc020124a:	ea4e                	sd	s3,272(sp)
ffffffffc020124c:	ee52                	sd	s4,280(sp)
ffffffffc020124e:	850a                	mv	a0,sp
ffffffffc0201250:	f0bff0ef          	jal	ra,ffffffffc020115a <trap>

ffffffffc0201254 <__trapret>:
ffffffffc0201254:	6492                	ld	s1,256(sp)
ffffffffc0201256:	6932                	ld	s2,264(sp)
ffffffffc0201258:	1004f413          	andi	s0,s1,256
ffffffffc020125c:	e401                	bnez	s0,ffffffffc0201264 <__trapret+0x10>
ffffffffc020125e:	1200                	addi	s0,sp,288
ffffffffc0201260:	14041073          	csrw	sscratch,s0
ffffffffc0201264:	10049073          	csrw	sstatus,s1
ffffffffc0201268:	14191073          	csrw	sepc,s2
ffffffffc020126c:	60a2                	ld	ra,8(sp)
ffffffffc020126e:	61e2                	ld	gp,24(sp)
ffffffffc0201270:	7202                	ld	tp,32(sp)
ffffffffc0201272:	72a2                	ld	t0,40(sp)
ffffffffc0201274:	7342                	ld	t1,48(sp)
ffffffffc0201276:	73e2                	ld	t2,56(sp)
ffffffffc0201278:	6406                	ld	s0,64(sp)
ffffffffc020127a:	64a6                	ld	s1,72(sp)
ffffffffc020127c:	6546                	ld	a0,80(sp)
ffffffffc020127e:	65e6                	ld	a1,88(sp)
ffffffffc0201280:	7606                	ld	a2,96(sp)
ffffffffc0201282:	76a6                	ld	a3,104(sp)
ffffffffc0201284:	7746                	ld	a4,112(sp)
ffffffffc0201286:	77e6                	ld	a5,120(sp)
ffffffffc0201288:	680a                	ld	a6,128(sp)
ffffffffc020128a:	68aa                	ld	a7,136(sp)
ffffffffc020128c:	694a                	ld	s2,144(sp)
ffffffffc020128e:	69ea                	ld	s3,152(sp)
ffffffffc0201290:	7a0a                	ld	s4,160(sp)
ffffffffc0201292:	7aaa                	ld	s5,168(sp)
ffffffffc0201294:	7b4a                	ld	s6,176(sp)
ffffffffc0201296:	7bea                	ld	s7,184(sp)
ffffffffc0201298:	6c0e                	ld	s8,192(sp)
ffffffffc020129a:	6cae                	ld	s9,200(sp)
ffffffffc020129c:	6d4e                	ld	s10,208(sp)
ffffffffc020129e:	6dee                	ld	s11,216(sp)
ffffffffc02012a0:	7e0e                	ld	t3,224(sp)
ffffffffc02012a2:	7eae                	ld	t4,232(sp)
ffffffffc02012a4:	7f4e                	ld	t5,240(sp)
ffffffffc02012a6:	7fee                	ld	t6,248(sp)
ffffffffc02012a8:	6142                	ld	sp,16(sp)
ffffffffc02012aa:	10200073          	sret

ffffffffc02012ae <forkrets>:
ffffffffc02012ae:	812a                	mv	sp,a0
ffffffffc02012b0:	b755                	j	ffffffffc0201254 <__trapret>

ffffffffc02012b2 <default_init>:
ffffffffc02012b2:	00090797          	auipc	a5,0x90
ffffffffc02012b6:	4f678793          	addi	a5,a5,1270 # ffffffffc02917a8 <free_area>
ffffffffc02012ba:	e79c                	sd	a5,8(a5)
ffffffffc02012bc:	e39c                	sd	a5,0(a5)
ffffffffc02012be:	0007a823          	sw	zero,16(a5)
ffffffffc02012c2:	8082                	ret

ffffffffc02012c4 <default_nr_free_pages>:
ffffffffc02012c4:	00090517          	auipc	a0,0x90
ffffffffc02012c8:	4f456503          	lwu	a0,1268(a0) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02012cc:	8082                	ret

ffffffffc02012ce <default_check>:
ffffffffc02012ce:	715d                	addi	sp,sp,-80
ffffffffc02012d0:	e0a2                	sd	s0,64(sp)
ffffffffc02012d2:	00090417          	auipc	s0,0x90
ffffffffc02012d6:	4d640413          	addi	s0,s0,1238 # ffffffffc02917a8 <free_area>
ffffffffc02012da:	641c                	ld	a5,8(s0)
ffffffffc02012dc:	e486                	sd	ra,72(sp)
ffffffffc02012de:	fc26                	sd	s1,56(sp)
ffffffffc02012e0:	f84a                	sd	s2,48(sp)
ffffffffc02012e2:	f44e                	sd	s3,40(sp)
ffffffffc02012e4:	f052                	sd	s4,32(sp)
ffffffffc02012e6:	ec56                	sd	s5,24(sp)
ffffffffc02012e8:	e85a                	sd	s6,16(sp)
ffffffffc02012ea:	e45e                	sd	s7,8(sp)
ffffffffc02012ec:	e062                	sd	s8,0(sp)
ffffffffc02012ee:	2a878d63          	beq	a5,s0,ffffffffc02015a8 <default_check+0x2da>
ffffffffc02012f2:	4481                	li	s1,0
ffffffffc02012f4:	4901                	li	s2,0
ffffffffc02012f6:	ff07b703          	ld	a4,-16(a5)
ffffffffc02012fa:	8b09                	andi	a4,a4,2
ffffffffc02012fc:	2a070a63          	beqz	a4,ffffffffc02015b0 <default_check+0x2e2>
ffffffffc0201300:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201304:	679c                	ld	a5,8(a5)
ffffffffc0201306:	2905                	addiw	s2,s2,1
ffffffffc0201308:	9cb9                	addw	s1,s1,a4
ffffffffc020130a:	fe8796e3          	bne	a5,s0,ffffffffc02012f6 <default_check+0x28>
ffffffffc020130e:	89a6                	mv	s3,s1
ffffffffc0201310:	6df000ef          	jal	ra,ffffffffc02021ee <nr_free_pages>
ffffffffc0201314:	6f351e63          	bne	a0,s3,ffffffffc0201a10 <default_check+0x742>
ffffffffc0201318:	4505                	li	a0,1
ffffffffc020131a:	657000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc020131e:	8aaa                	mv	s5,a0
ffffffffc0201320:	42050863          	beqz	a0,ffffffffc0201750 <default_check+0x482>
ffffffffc0201324:	4505                	li	a0,1
ffffffffc0201326:	64b000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc020132a:	89aa                	mv	s3,a0
ffffffffc020132c:	70050263          	beqz	a0,ffffffffc0201a30 <default_check+0x762>
ffffffffc0201330:	4505                	li	a0,1
ffffffffc0201332:	63f000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0201336:	8a2a                	mv	s4,a0
ffffffffc0201338:	48050c63          	beqz	a0,ffffffffc02017d0 <default_check+0x502>
ffffffffc020133c:	293a8a63          	beq	s5,s3,ffffffffc02015d0 <default_check+0x302>
ffffffffc0201340:	28aa8863          	beq	s5,a0,ffffffffc02015d0 <default_check+0x302>
ffffffffc0201344:	28a98663          	beq	s3,a0,ffffffffc02015d0 <default_check+0x302>
ffffffffc0201348:	000aa783          	lw	a5,0(s5)
ffffffffc020134c:	2a079263          	bnez	a5,ffffffffc02015f0 <default_check+0x322>
ffffffffc0201350:	0009a783          	lw	a5,0(s3)
ffffffffc0201354:	28079e63          	bnez	a5,ffffffffc02015f0 <default_check+0x322>
ffffffffc0201358:	411c                	lw	a5,0(a0)
ffffffffc020135a:	28079b63          	bnez	a5,ffffffffc02015f0 <default_check+0x322>
ffffffffc020135e:	00095797          	auipc	a5,0x95
ffffffffc0201362:	54a7b783          	ld	a5,1354(a5) # ffffffffc02968a8 <pages>
ffffffffc0201366:	40fa8733          	sub	a4,s5,a5
ffffffffc020136a:	0000e617          	auipc	a2,0xe
ffffffffc020136e:	52663603          	ld	a2,1318(a2) # ffffffffc020f890 <nbase>
ffffffffc0201372:	8719                	srai	a4,a4,0x6
ffffffffc0201374:	9732                	add	a4,a4,a2
ffffffffc0201376:	00095697          	auipc	a3,0x95
ffffffffc020137a:	52a6b683          	ld	a3,1322(a3) # ffffffffc02968a0 <npage>
ffffffffc020137e:	06b2                	slli	a3,a3,0xc
ffffffffc0201380:	0732                	slli	a4,a4,0xc
ffffffffc0201382:	28d77763          	bgeu	a4,a3,ffffffffc0201610 <default_check+0x342>
ffffffffc0201386:	40f98733          	sub	a4,s3,a5
ffffffffc020138a:	8719                	srai	a4,a4,0x6
ffffffffc020138c:	9732                	add	a4,a4,a2
ffffffffc020138e:	0732                	slli	a4,a4,0xc
ffffffffc0201390:	4cd77063          	bgeu	a4,a3,ffffffffc0201850 <default_check+0x582>
ffffffffc0201394:	40f507b3          	sub	a5,a0,a5
ffffffffc0201398:	8799                	srai	a5,a5,0x6
ffffffffc020139a:	97b2                	add	a5,a5,a2
ffffffffc020139c:	07b2                	slli	a5,a5,0xc
ffffffffc020139e:	30d7f963          	bgeu	a5,a3,ffffffffc02016b0 <default_check+0x3e2>
ffffffffc02013a2:	4505                	li	a0,1
ffffffffc02013a4:	00043c03          	ld	s8,0(s0)
ffffffffc02013a8:	00843b83          	ld	s7,8(s0)
ffffffffc02013ac:	01042b03          	lw	s6,16(s0)
ffffffffc02013b0:	e400                	sd	s0,8(s0)
ffffffffc02013b2:	e000                	sd	s0,0(s0)
ffffffffc02013b4:	00090797          	auipc	a5,0x90
ffffffffc02013b8:	4007a223          	sw	zero,1028(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02013bc:	5b5000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc02013c0:	2c051863          	bnez	a0,ffffffffc0201690 <default_check+0x3c2>
ffffffffc02013c4:	4585                	li	a1,1
ffffffffc02013c6:	8556                	mv	a0,s5
ffffffffc02013c8:	5e7000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc02013cc:	4585                	li	a1,1
ffffffffc02013ce:	854e                	mv	a0,s3
ffffffffc02013d0:	5df000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc02013d4:	4585                	li	a1,1
ffffffffc02013d6:	8552                	mv	a0,s4
ffffffffc02013d8:	5d7000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc02013dc:	4818                	lw	a4,16(s0)
ffffffffc02013de:	478d                	li	a5,3
ffffffffc02013e0:	28f71863          	bne	a4,a5,ffffffffc0201670 <default_check+0x3a2>
ffffffffc02013e4:	4505                	li	a0,1
ffffffffc02013e6:	58b000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc02013ea:	89aa                	mv	s3,a0
ffffffffc02013ec:	26050263          	beqz	a0,ffffffffc0201650 <default_check+0x382>
ffffffffc02013f0:	4505                	li	a0,1
ffffffffc02013f2:	57f000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc02013f6:	8aaa                	mv	s5,a0
ffffffffc02013f8:	3a050c63          	beqz	a0,ffffffffc02017b0 <default_check+0x4e2>
ffffffffc02013fc:	4505                	li	a0,1
ffffffffc02013fe:	573000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0201402:	8a2a                	mv	s4,a0
ffffffffc0201404:	38050663          	beqz	a0,ffffffffc0201790 <default_check+0x4c2>
ffffffffc0201408:	4505                	li	a0,1
ffffffffc020140a:	567000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc020140e:	36051163          	bnez	a0,ffffffffc0201770 <default_check+0x4a2>
ffffffffc0201412:	4585                	li	a1,1
ffffffffc0201414:	854e                	mv	a0,s3
ffffffffc0201416:	599000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc020141a:	641c                	ld	a5,8(s0)
ffffffffc020141c:	20878a63          	beq	a5,s0,ffffffffc0201630 <default_check+0x362>
ffffffffc0201420:	4505                	li	a0,1
ffffffffc0201422:	54f000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0201426:	30a99563          	bne	s3,a0,ffffffffc0201730 <default_check+0x462>
ffffffffc020142a:	4505                	li	a0,1
ffffffffc020142c:	545000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0201430:	2e051063          	bnez	a0,ffffffffc0201710 <default_check+0x442>
ffffffffc0201434:	481c                	lw	a5,16(s0)
ffffffffc0201436:	2a079d63          	bnez	a5,ffffffffc02016f0 <default_check+0x422>
ffffffffc020143a:	854e                	mv	a0,s3
ffffffffc020143c:	4585                	li	a1,1
ffffffffc020143e:	01843023          	sd	s8,0(s0)
ffffffffc0201442:	01743423          	sd	s7,8(s0)
ffffffffc0201446:	01642823          	sw	s6,16(s0)
ffffffffc020144a:	565000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc020144e:	4585                	li	a1,1
ffffffffc0201450:	8556                	mv	a0,s5
ffffffffc0201452:	55d000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc0201456:	4585                	li	a1,1
ffffffffc0201458:	8552                	mv	a0,s4
ffffffffc020145a:	555000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc020145e:	4515                	li	a0,5
ffffffffc0201460:	511000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0201464:	89aa                	mv	s3,a0
ffffffffc0201466:	26050563          	beqz	a0,ffffffffc02016d0 <default_check+0x402>
ffffffffc020146a:	651c                	ld	a5,8(a0)
ffffffffc020146c:	8385                	srli	a5,a5,0x1
ffffffffc020146e:	8b85                	andi	a5,a5,1
ffffffffc0201470:	54079063          	bnez	a5,ffffffffc02019b0 <default_check+0x6e2>
ffffffffc0201474:	4505                	li	a0,1
ffffffffc0201476:	00043b03          	ld	s6,0(s0)
ffffffffc020147a:	00843a83          	ld	s5,8(s0)
ffffffffc020147e:	e000                	sd	s0,0(s0)
ffffffffc0201480:	e400                	sd	s0,8(s0)
ffffffffc0201482:	4ef000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0201486:	50051563          	bnez	a0,ffffffffc0201990 <default_check+0x6c2>
ffffffffc020148a:	08098a13          	addi	s4,s3,128
ffffffffc020148e:	8552                	mv	a0,s4
ffffffffc0201490:	458d                	li	a1,3
ffffffffc0201492:	01042b83          	lw	s7,16(s0)
ffffffffc0201496:	00090797          	auipc	a5,0x90
ffffffffc020149a:	3207a123          	sw	zero,802(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc020149e:	511000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc02014a2:	4511                	li	a0,4
ffffffffc02014a4:	4cd000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc02014a8:	4c051463          	bnez	a0,ffffffffc0201970 <default_check+0x6a2>
ffffffffc02014ac:	0889b783          	ld	a5,136(s3)
ffffffffc02014b0:	8385                	srli	a5,a5,0x1
ffffffffc02014b2:	8b85                	andi	a5,a5,1
ffffffffc02014b4:	48078e63          	beqz	a5,ffffffffc0201950 <default_check+0x682>
ffffffffc02014b8:	0909a703          	lw	a4,144(s3)
ffffffffc02014bc:	478d                	li	a5,3
ffffffffc02014be:	48f71963          	bne	a4,a5,ffffffffc0201950 <default_check+0x682>
ffffffffc02014c2:	450d                	li	a0,3
ffffffffc02014c4:	4ad000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc02014c8:	8c2a                	mv	s8,a0
ffffffffc02014ca:	46050363          	beqz	a0,ffffffffc0201930 <default_check+0x662>
ffffffffc02014ce:	4505                	li	a0,1
ffffffffc02014d0:	4a1000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc02014d4:	42051e63          	bnez	a0,ffffffffc0201910 <default_check+0x642>
ffffffffc02014d8:	418a1c63          	bne	s4,s8,ffffffffc02018f0 <default_check+0x622>
ffffffffc02014dc:	4585                	li	a1,1
ffffffffc02014de:	854e                	mv	a0,s3
ffffffffc02014e0:	4cf000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc02014e4:	458d                	li	a1,3
ffffffffc02014e6:	8552                	mv	a0,s4
ffffffffc02014e8:	4c7000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc02014ec:	0089b783          	ld	a5,8(s3)
ffffffffc02014f0:	04098c13          	addi	s8,s3,64
ffffffffc02014f4:	8385                	srli	a5,a5,0x1
ffffffffc02014f6:	8b85                	andi	a5,a5,1
ffffffffc02014f8:	3c078c63          	beqz	a5,ffffffffc02018d0 <default_check+0x602>
ffffffffc02014fc:	0109a703          	lw	a4,16(s3)
ffffffffc0201500:	4785                	li	a5,1
ffffffffc0201502:	3cf71763          	bne	a4,a5,ffffffffc02018d0 <default_check+0x602>
ffffffffc0201506:	008a3783          	ld	a5,8(s4)
ffffffffc020150a:	8385                	srli	a5,a5,0x1
ffffffffc020150c:	8b85                	andi	a5,a5,1
ffffffffc020150e:	3a078163          	beqz	a5,ffffffffc02018b0 <default_check+0x5e2>
ffffffffc0201512:	010a2703          	lw	a4,16(s4)
ffffffffc0201516:	478d                	li	a5,3
ffffffffc0201518:	38f71c63          	bne	a4,a5,ffffffffc02018b0 <default_check+0x5e2>
ffffffffc020151c:	4505                	li	a0,1
ffffffffc020151e:	453000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0201522:	36a99763          	bne	s3,a0,ffffffffc0201890 <default_check+0x5c2>
ffffffffc0201526:	4585                	li	a1,1
ffffffffc0201528:	487000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc020152c:	4509                	li	a0,2
ffffffffc020152e:	443000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0201532:	32aa1f63          	bne	s4,a0,ffffffffc0201870 <default_check+0x5a2>
ffffffffc0201536:	4589                	li	a1,2
ffffffffc0201538:	477000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc020153c:	4585                	li	a1,1
ffffffffc020153e:	8562                	mv	a0,s8
ffffffffc0201540:	46f000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc0201544:	4515                	li	a0,5
ffffffffc0201546:	42b000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc020154a:	89aa                	mv	s3,a0
ffffffffc020154c:	48050263          	beqz	a0,ffffffffc02019d0 <default_check+0x702>
ffffffffc0201550:	4505                	li	a0,1
ffffffffc0201552:	41f000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0201556:	2c051d63          	bnez	a0,ffffffffc0201830 <default_check+0x562>
ffffffffc020155a:	481c                	lw	a5,16(s0)
ffffffffc020155c:	2a079a63          	bnez	a5,ffffffffc0201810 <default_check+0x542>
ffffffffc0201560:	4595                	li	a1,5
ffffffffc0201562:	854e                	mv	a0,s3
ffffffffc0201564:	01742823          	sw	s7,16(s0)
ffffffffc0201568:	01643023          	sd	s6,0(s0)
ffffffffc020156c:	01543423          	sd	s5,8(s0)
ffffffffc0201570:	43f000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc0201574:	641c                	ld	a5,8(s0)
ffffffffc0201576:	00878963          	beq	a5,s0,ffffffffc0201588 <default_check+0x2ba>
ffffffffc020157a:	ff87a703          	lw	a4,-8(a5)
ffffffffc020157e:	679c                	ld	a5,8(a5)
ffffffffc0201580:	397d                	addiw	s2,s2,-1
ffffffffc0201582:	9c99                	subw	s1,s1,a4
ffffffffc0201584:	fe879be3          	bne	a5,s0,ffffffffc020157a <default_check+0x2ac>
ffffffffc0201588:	26091463          	bnez	s2,ffffffffc02017f0 <default_check+0x522>
ffffffffc020158c:	46049263          	bnez	s1,ffffffffc02019f0 <default_check+0x722>
ffffffffc0201590:	60a6                	ld	ra,72(sp)
ffffffffc0201592:	6406                	ld	s0,64(sp)
ffffffffc0201594:	74e2                	ld	s1,56(sp)
ffffffffc0201596:	7942                	ld	s2,48(sp)
ffffffffc0201598:	79a2                	ld	s3,40(sp)
ffffffffc020159a:	7a02                	ld	s4,32(sp)
ffffffffc020159c:	6ae2                	ld	s5,24(sp)
ffffffffc020159e:	6b42                	ld	s6,16(sp)
ffffffffc02015a0:	6ba2                	ld	s7,8(sp)
ffffffffc02015a2:	6c02                	ld	s8,0(sp)
ffffffffc02015a4:	6161                	addi	sp,sp,80
ffffffffc02015a6:	8082                	ret
ffffffffc02015a8:	4981                	li	s3,0
ffffffffc02015aa:	4481                	li	s1,0
ffffffffc02015ac:	4901                	li	s2,0
ffffffffc02015ae:	b38d                	j	ffffffffc0201310 <default_check+0x42>
ffffffffc02015b0:	0000b697          	auipc	a3,0xb
ffffffffc02015b4:	c3868693          	addi	a3,a3,-968 # ffffffffc020c1e8 <commands+0x950>
ffffffffc02015b8:	0000a617          	auipc	a2,0xa
ffffffffc02015bc:	4f060613          	addi	a2,a2,1264 # ffffffffc020baa8 <commands+0x210>
ffffffffc02015c0:	0ef00593          	li	a1,239
ffffffffc02015c4:	0000b517          	auipc	a0,0xb
ffffffffc02015c8:	c3450513          	addi	a0,a0,-972 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02015cc:	ed3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015d0:	0000b697          	auipc	a3,0xb
ffffffffc02015d4:	cc068693          	addi	a3,a3,-832 # ffffffffc020c290 <commands+0x9f8>
ffffffffc02015d8:	0000a617          	auipc	a2,0xa
ffffffffc02015dc:	4d060613          	addi	a2,a2,1232 # ffffffffc020baa8 <commands+0x210>
ffffffffc02015e0:	0bc00593          	li	a1,188
ffffffffc02015e4:	0000b517          	auipc	a0,0xb
ffffffffc02015e8:	c1450513          	addi	a0,a0,-1004 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02015ec:	eb3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015f0:	0000b697          	auipc	a3,0xb
ffffffffc02015f4:	cc868693          	addi	a3,a3,-824 # ffffffffc020c2b8 <commands+0xa20>
ffffffffc02015f8:	0000a617          	auipc	a2,0xa
ffffffffc02015fc:	4b060613          	addi	a2,a2,1200 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201600:	0bd00593          	li	a1,189
ffffffffc0201604:	0000b517          	auipc	a0,0xb
ffffffffc0201608:	bf450513          	addi	a0,a0,-1036 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020160c:	e93fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201610:	0000b697          	auipc	a3,0xb
ffffffffc0201614:	ce868693          	addi	a3,a3,-792 # ffffffffc020c2f8 <commands+0xa60>
ffffffffc0201618:	0000a617          	auipc	a2,0xa
ffffffffc020161c:	49060613          	addi	a2,a2,1168 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201620:	0bf00593          	li	a1,191
ffffffffc0201624:	0000b517          	auipc	a0,0xb
ffffffffc0201628:	bd450513          	addi	a0,a0,-1068 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020162c:	e73fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201630:	0000b697          	auipc	a3,0xb
ffffffffc0201634:	d5068693          	addi	a3,a3,-688 # ffffffffc020c380 <commands+0xae8>
ffffffffc0201638:	0000a617          	auipc	a2,0xa
ffffffffc020163c:	47060613          	addi	a2,a2,1136 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201640:	0d800593          	li	a1,216
ffffffffc0201644:	0000b517          	auipc	a0,0xb
ffffffffc0201648:	bb450513          	addi	a0,a0,-1100 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020164c:	e53fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201650:	0000b697          	auipc	a3,0xb
ffffffffc0201654:	be068693          	addi	a3,a3,-1056 # ffffffffc020c230 <commands+0x998>
ffffffffc0201658:	0000a617          	auipc	a2,0xa
ffffffffc020165c:	45060613          	addi	a2,a2,1104 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201660:	0d100593          	li	a1,209
ffffffffc0201664:	0000b517          	auipc	a0,0xb
ffffffffc0201668:	b9450513          	addi	a0,a0,-1132 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020166c:	e33fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201670:	0000b697          	auipc	a3,0xb
ffffffffc0201674:	d0068693          	addi	a3,a3,-768 # ffffffffc020c370 <commands+0xad8>
ffffffffc0201678:	0000a617          	auipc	a2,0xa
ffffffffc020167c:	43060613          	addi	a2,a2,1072 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201680:	0cf00593          	li	a1,207
ffffffffc0201684:	0000b517          	auipc	a0,0xb
ffffffffc0201688:	b7450513          	addi	a0,a0,-1164 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020168c:	e13fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201690:	0000b697          	auipc	a3,0xb
ffffffffc0201694:	cc868693          	addi	a3,a3,-824 # ffffffffc020c358 <commands+0xac0>
ffffffffc0201698:	0000a617          	auipc	a2,0xa
ffffffffc020169c:	41060613          	addi	a2,a2,1040 # ffffffffc020baa8 <commands+0x210>
ffffffffc02016a0:	0ca00593          	li	a1,202
ffffffffc02016a4:	0000b517          	auipc	a0,0xb
ffffffffc02016a8:	b5450513          	addi	a0,a0,-1196 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02016ac:	df3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016b0:	0000b697          	auipc	a3,0xb
ffffffffc02016b4:	c8868693          	addi	a3,a3,-888 # ffffffffc020c338 <commands+0xaa0>
ffffffffc02016b8:	0000a617          	auipc	a2,0xa
ffffffffc02016bc:	3f060613          	addi	a2,a2,1008 # ffffffffc020baa8 <commands+0x210>
ffffffffc02016c0:	0c100593          	li	a1,193
ffffffffc02016c4:	0000b517          	auipc	a0,0xb
ffffffffc02016c8:	b3450513          	addi	a0,a0,-1228 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02016cc:	dd3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016d0:	0000b697          	auipc	a3,0xb
ffffffffc02016d4:	cf868693          	addi	a3,a3,-776 # ffffffffc020c3c8 <commands+0xb30>
ffffffffc02016d8:	0000a617          	auipc	a2,0xa
ffffffffc02016dc:	3d060613          	addi	a2,a2,976 # ffffffffc020baa8 <commands+0x210>
ffffffffc02016e0:	0f700593          	li	a1,247
ffffffffc02016e4:	0000b517          	auipc	a0,0xb
ffffffffc02016e8:	b1450513          	addi	a0,a0,-1260 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02016ec:	db3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016f0:	0000b697          	auipc	a3,0xb
ffffffffc02016f4:	cc868693          	addi	a3,a3,-824 # ffffffffc020c3b8 <commands+0xb20>
ffffffffc02016f8:	0000a617          	auipc	a2,0xa
ffffffffc02016fc:	3b060613          	addi	a2,a2,944 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201700:	0de00593          	li	a1,222
ffffffffc0201704:	0000b517          	auipc	a0,0xb
ffffffffc0201708:	af450513          	addi	a0,a0,-1292 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020170c:	d93fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201710:	0000b697          	auipc	a3,0xb
ffffffffc0201714:	c4868693          	addi	a3,a3,-952 # ffffffffc020c358 <commands+0xac0>
ffffffffc0201718:	0000a617          	auipc	a2,0xa
ffffffffc020171c:	39060613          	addi	a2,a2,912 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201720:	0dc00593          	li	a1,220
ffffffffc0201724:	0000b517          	auipc	a0,0xb
ffffffffc0201728:	ad450513          	addi	a0,a0,-1324 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020172c:	d73fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201730:	0000b697          	auipc	a3,0xb
ffffffffc0201734:	c6868693          	addi	a3,a3,-920 # ffffffffc020c398 <commands+0xb00>
ffffffffc0201738:	0000a617          	auipc	a2,0xa
ffffffffc020173c:	37060613          	addi	a2,a2,880 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201740:	0db00593          	li	a1,219
ffffffffc0201744:	0000b517          	auipc	a0,0xb
ffffffffc0201748:	ab450513          	addi	a0,a0,-1356 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020174c:	d53fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201750:	0000b697          	auipc	a3,0xb
ffffffffc0201754:	ae068693          	addi	a3,a3,-1312 # ffffffffc020c230 <commands+0x998>
ffffffffc0201758:	0000a617          	auipc	a2,0xa
ffffffffc020175c:	35060613          	addi	a2,a2,848 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201760:	0b800593          	li	a1,184
ffffffffc0201764:	0000b517          	auipc	a0,0xb
ffffffffc0201768:	a9450513          	addi	a0,a0,-1388 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020176c:	d33fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201770:	0000b697          	auipc	a3,0xb
ffffffffc0201774:	be868693          	addi	a3,a3,-1048 # ffffffffc020c358 <commands+0xac0>
ffffffffc0201778:	0000a617          	auipc	a2,0xa
ffffffffc020177c:	33060613          	addi	a2,a2,816 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201780:	0d500593          	li	a1,213
ffffffffc0201784:	0000b517          	auipc	a0,0xb
ffffffffc0201788:	a7450513          	addi	a0,a0,-1420 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020178c:	d13fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201790:	0000b697          	auipc	a3,0xb
ffffffffc0201794:	ae068693          	addi	a3,a3,-1312 # ffffffffc020c270 <commands+0x9d8>
ffffffffc0201798:	0000a617          	auipc	a2,0xa
ffffffffc020179c:	31060613          	addi	a2,a2,784 # ffffffffc020baa8 <commands+0x210>
ffffffffc02017a0:	0d300593          	li	a1,211
ffffffffc02017a4:	0000b517          	auipc	a0,0xb
ffffffffc02017a8:	a5450513          	addi	a0,a0,-1452 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02017ac:	cf3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017b0:	0000b697          	auipc	a3,0xb
ffffffffc02017b4:	aa068693          	addi	a3,a3,-1376 # ffffffffc020c250 <commands+0x9b8>
ffffffffc02017b8:	0000a617          	auipc	a2,0xa
ffffffffc02017bc:	2f060613          	addi	a2,a2,752 # ffffffffc020baa8 <commands+0x210>
ffffffffc02017c0:	0d200593          	li	a1,210
ffffffffc02017c4:	0000b517          	auipc	a0,0xb
ffffffffc02017c8:	a3450513          	addi	a0,a0,-1484 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02017cc:	cd3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017d0:	0000b697          	auipc	a3,0xb
ffffffffc02017d4:	aa068693          	addi	a3,a3,-1376 # ffffffffc020c270 <commands+0x9d8>
ffffffffc02017d8:	0000a617          	auipc	a2,0xa
ffffffffc02017dc:	2d060613          	addi	a2,a2,720 # ffffffffc020baa8 <commands+0x210>
ffffffffc02017e0:	0ba00593          	li	a1,186
ffffffffc02017e4:	0000b517          	auipc	a0,0xb
ffffffffc02017e8:	a1450513          	addi	a0,a0,-1516 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02017ec:	cb3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017f0:	0000b697          	auipc	a3,0xb
ffffffffc02017f4:	d2868693          	addi	a3,a3,-728 # ffffffffc020c518 <commands+0xc80>
ffffffffc02017f8:	0000a617          	auipc	a2,0xa
ffffffffc02017fc:	2b060613          	addi	a2,a2,688 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201800:	12400593          	li	a1,292
ffffffffc0201804:	0000b517          	auipc	a0,0xb
ffffffffc0201808:	9f450513          	addi	a0,a0,-1548 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020180c:	c93fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201810:	0000b697          	auipc	a3,0xb
ffffffffc0201814:	ba868693          	addi	a3,a3,-1112 # ffffffffc020c3b8 <commands+0xb20>
ffffffffc0201818:	0000a617          	auipc	a2,0xa
ffffffffc020181c:	29060613          	addi	a2,a2,656 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201820:	11900593          	li	a1,281
ffffffffc0201824:	0000b517          	auipc	a0,0xb
ffffffffc0201828:	9d450513          	addi	a0,a0,-1580 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020182c:	c73fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201830:	0000b697          	auipc	a3,0xb
ffffffffc0201834:	b2868693          	addi	a3,a3,-1240 # ffffffffc020c358 <commands+0xac0>
ffffffffc0201838:	0000a617          	auipc	a2,0xa
ffffffffc020183c:	27060613          	addi	a2,a2,624 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201840:	11700593          	li	a1,279
ffffffffc0201844:	0000b517          	auipc	a0,0xb
ffffffffc0201848:	9b450513          	addi	a0,a0,-1612 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020184c:	c53fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201850:	0000b697          	auipc	a3,0xb
ffffffffc0201854:	ac868693          	addi	a3,a3,-1336 # ffffffffc020c318 <commands+0xa80>
ffffffffc0201858:	0000a617          	auipc	a2,0xa
ffffffffc020185c:	25060613          	addi	a2,a2,592 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201860:	0c000593          	li	a1,192
ffffffffc0201864:	0000b517          	auipc	a0,0xb
ffffffffc0201868:	99450513          	addi	a0,a0,-1644 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020186c:	c33fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201870:	0000b697          	auipc	a3,0xb
ffffffffc0201874:	c6868693          	addi	a3,a3,-920 # ffffffffc020c4d8 <commands+0xc40>
ffffffffc0201878:	0000a617          	auipc	a2,0xa
ffffffffc020187c:	23060613          	addi	a2,a2,560 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201880:	11100593          	li	a1,273
ffffffffc0201884:	0000b517          	auipc	a0,0xb
ffffffffc0201888:	97450513          	addi	a0,a0,-1676 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020188c:	c13fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201890:	0000b697          	auipc	a3,0xb
ffffffffc0201894:	c2868693          	addi	a3,a3,-984 # ffffffffc020c4b8 <commands+0xc20>
ffffffffc0201898:	0000a617          	auipc	a2,0xa
ffffffffc020189c:	21060613          	addi	a2,a2,528 # ffffffffc020baa8 <commands+0x210>
ffffffffc02018a0:	10f00593          	li	a1,271
ffffffffc02018a4:	0000b517          	auipc	a0,0xb
ffffffffc02018a8:	95450513          	addi	a0,a0,-1708 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02018ac:	bf3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018b0:	0000b697          	auipc	a3,0xb
ffffffffc02018b4:	be068693          	addi	a3,a3,-1056 # ffffffffc020c490 <commands+0xbf8>
ffffffffc02018b8:	0000a617          	auipc	a2,0xa
ffffffffc02018bc:	1f060613          	addi	a2,a2,496 # ffffffffc020baa8 <commands+0x210>
ffffffffc02018c0:	10d00593          	li	a1,269
ffffffffc02018c4:	0000b517          	auipc	a0,0xb
ffffffffc02018c8:	93450513          	addi	a0,a0,-1740 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02018cc:	bd3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018d0:	0000b697          	auipc	a3,0xb
ffffffffc02018d4:	b9868693          	addi	a3,a3,-1128 # ffffffffc020c468 <commands+0xbd0>
ffffffffc02018d8:	0000a617          	auipc	a2,0xa
ffffffffc02018dc:	1d060613          	addi	a2,a2,464 # ffffffffc020baa8 <commands+0x210>
ffffffffc02018e0:	10c00593          	li	a1,268
ffffffffc02018e4:	0000b517          	auipc	a0,0xb
ffffffffc02018e8:	91450513          	addi	a0,a0,-1772 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02018ec:	bb3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018f0:	0000b697          	auipc	a3,0xb
ffffffffc02018f4:	b6868693          	addi	a3,a3,-1176 # ffffffffc020c458 <commands+0xbc0>
ffffffffc02018f8:	0000a617          	auipc	a2,0xa
ffffffffc02018fc:	1b060613          	addi	a2,a2,432 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201900:	10700593          	li	a1,263
ffffffffc0201904:	0000b517          	auipc	a0,0xb
ffffffffc0201908:	8f450513          	addi	a0,a0,-1804 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020190c:	b93fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201910:	0000b697          	auipc	a3,0xb
ffffffffc0201914:	a4868693          	addi	a3,a3,-1464 # ffffffffc020c358 <commands+0xac0>
ffffffffc0201918:	0000a617          	auipc	a2,0xa
ffffffffc020191c:	19060613          	addi	a2,a2,400 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201920:	10600593          	li	a1,262
ffffffffc0201924:	0000b517          	auipc	a0,0xb
ffffffffc0201928:	8d450513          	addi	a0,a0,-1836 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020192c:	b73fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201930:	0000b697          	auipc	a3,0xb
ffffffffc0201934:	b0868693          	addi	a3,a3,-1272 # ffffffffc020c438 <commands+0xba0>
ffffffffc0201938:	0000a617          	auipc	a2,0xa
ffffffffc020193c:	17060613          	addi	a2,a2,368 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201940:	10500593          	li	a1,261
ffffffffc0201944:	0000b517          	auipc	a0,0xb
ffffffffc0201948:	8b450513          	addi	a0,a0,-1868 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020194c:	b53fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201950:	0000b697          	auipc	a3,0xb
ffffffffc0201954:	ab868693          	addi	a3,a3,-1352 # ffffffffc020c408 <commands+0xb70>
ffffffffc0201958:	0000a617          	auipc	a2,0xa
ffffffffc020195c:	15060613          	addi	a2,a2,336 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201960:	10400593          	li	a1,260
ffffffffc0201964:	0000b517          	auipc	a0,0xb
ffffffffc0201968:	89450513          	addi	a0,a0,-1900 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020196c:	b33fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201970:	0000b697          	auipc	a3,0xb
ffffffffc0201974:	a8068693          	addi	a3,a3,-1408 # ffffffffc020c3f0 <commands+0xb58>
ffffffffc0201978:	0000a617          	auipc	a2,0xa
ffffffffc020197c:	13060613          	addi	a2,a2,304 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201980:	10300593          	li	a1,259
ffffffffc0201984:	0000b517          	auipc	a0,0xb
ffffffffc0201988:	87450513          	addi	a0,a0,-1932 # ffffffffc020c1f8 <commands+0x960>
ffffffffc020198c:	b13fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201990:	0000b697          	auipc	a3,0xb
ffffffffc0201994:	9c868693          	addi	a3,a3,-1592 # ffffffffc020c358 <commands+0xac0>
ffffffffc0201998:	0000a617          	auipc	a2,0xa
ffffffffc020199c:	11060613          	addi	a2,a2,272 # ffffffffc020baa8 <commands+0x210>
ffffffffc02019a0:	0fd00593          	li	a1,253
ffffffffc02019a4:	0000b517          	auipc	a0,0xb
ffffffffc02019a8:	85450513          	addi	a0,a0,-1964 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02019ac:	af3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019b0:	0000b697          	auipc	a3,0xb
ffffffffc02019b4:	a2868693          	addi	a3,a3,-1496 # ffffffffc020c3d8 <commands+0xb40>
ffffffffc02019b8:	0000a617          	auipc	a2,0xa
ffffffffc02019bc:	0f060613          	addi	a2,a2,240 # ffffffffc020baa8 <commands+0x210>
ffffffffc02019c0:	0f800593          	li	a1,248
ffffffffc02019c4:	0000b517          	auipc	a0,0xb
ffffffffc02019c8:	83450513          	addi	a0,a0,-1996 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02019cc:	ad3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019d0:	0000b697          	auipc	a3,0xb
ffffffffc02019d4:	b2868693          	addi	a3,a3,-1240 # ffffffffc020c4f8 <commands+0xc60>
ffffffffc02019d8:	0000a617          	auipc	a2,0xa
ffffffffc02019dc:	0d060613          	addi	a2,a2,208 # ffffffffc020baa8 <commands+0x210>
ffffffffc02019e0:	11600593          	li	a1,278
ffffffffc02019e4:	0000b517          	auipc	a0,0xb
ffffffffc02019e8:	81450513          	addi	a0,a0,-2028 # ffffffffc020c1f8 <commands+0x960>
ffffffffc02019ec:	ab3fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019f0:	0000b697          	auipc	a3,0xb
ffffffffc02019f4:	b3868693          	addi	a3,a3,-1224 # ffffffffc020c528 <commands+0xc90>
ffffffffc02019f8:	0000a617          	auipc	a2,0xa
ffffffffc02019fc:	0b060613          	addi	a2,a2,176 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201a00:	12500593          	li	a1,293
ffffffffc0201a04:	0000a517          	auipc	a0,0xa
ffffffffc0201a08:	7f450513          	addi	a0,a0,2036 # ffffffffc020c1f8 <commands+0x960>
ffffffffc0201a0c:	a93fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a10:	0000b697          	auipc	a3,0xb
ffffffffc0201a14:	80068693          	addi	a3,a3,-2048 # ffffffffc020c210 <commands+0x978>
ffffffffc0201a18:	0000a617          	auipc	a2,0xa
ffffffffc0201a1c:	09060613          	addi	a2,a2,144 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201a20:	0f200593          	li	a1,242
ffffffffc0201a24:	0000a517          	auipc	a0,0xa
ffffffffc0201a28:	7d450513          	addi	a0,a0,2004 # ffffffffc020c1f8 <commands+0x960>
ffffffffc0201a2c:	a73fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a30:	0000b697          	auipc	a3,0xb
ffffffffc0201a34:	82068693          	addi	a3,a3,-2016 # ffffffffc020c250 <commands+0x9b8>
ffffffffc0201a38:	0000a617          	auipc	a2,0xa
ffffffffc0201a3c:	07060613          	addi	a2,a2,112 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201a40:	0b900593          	li	a1,185
ffffffffc0201a44:	0000a517          	auipc	a0,0xa
ffffffffc0201a48:	7b450513          	addi	a0,a0,1972 # ffffffffc020c1f8 <commands+0x960>
ffffffffc0201a4c:	a53fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201a50 <default_free_pages>:
ffffffffc0201a50:	1141                	addi	sp,sp,-16
ffffffffc0201a52:	e406                	sd	ra,8(sp)
ffffffffc0201a54:	14058463          	beqz	a1,ffffffffc0201b9c <default_free_pages+0x14c>
ffffffffc0201a58:	00659693          	slli	a3,a1,0x6
ffffffffc0201a5c:	96aa                	add	a3,a3,a0
ffffffffc0201a5e:	87aa                	mv	a5,a0
ffffffffc0201a60:	02d50263          	beq	a0,a3,ffffffffc0201a84 <default_free_pages+0x34>
ffffffffc0201a64:	6798                	ld	a4,8(a5)
ffffffffc0201a66:	8b05                	andi	a4,a4,1
ffffffffc0201a68:	10071a63          	bnez	a4,ffffffffc0201b7c <default_free_pages+0x12c>
ffffffffc0201a6c:	6798                	ld	a4,8(a5)
ffffffffc0201a6e:	8b09                	andi	a4,a4,2
ffffffffc0201a70:	10071663          	bnez	a4,ffffffffc0201b7c <default_free_pages+0x12c>
ffffffffc0201a74:	0007b423          	sd	zero,8(a5)
ffffffffc0201a78:	0007a023          	sw	zero,0(a5)
ffffffffc0201a7c:	04078793          	addi	a5,a5,64
ffffffffc0201a80:	fed792e3          	bne	a5,a3,ffffffffc0201a64 <default_free_pages+0x14>
ffffffffc0201a84:	2581                	sext.w	a1,a1
ffffffffc0201a86:	c90c                	sw	a1,16(a0)
ffffffffc0201a88:	00850893          	addi	a7,a0,8
ffffffffc0201a8c:	4789                	li	a5,2
ffffffffc0201a8e:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0201a92:	00090697          	auipc	a3,0x90
ffffffffc0201a96:	d1668693          	addi	a3,a3,-746 # ffffffffc02917a8 <free_area>
ffffffffc0201a9a:	4a98                	lw	a4,16(a3)
ffffffffc0201a9c:	669c                	ld	a5,8(a3)
ffffffffc0201a9e:	01850613          	addi	a2,a0,24
ffffffffc0201aa2:	9db9                	addw	a1,a1,a4
ffffffffc0201aa4:	ca8c                	sw	a1,16(a3)
ffffffffc0201aa6:	0ad78463          	beq	a5,a3,ffffffffc0201b4e <default_free_pages+0xfe>
ffffffffc0201aaa:	fe878713          	addi	a4,a5,-24
ffffffffc0201aae:	0006b803          	ld	a6,0(a3)
ffffffffc0201ab2:	4581                	li	a1,0
ffffffffc0201ab4:	00e56a63          	bltu	a0,a4,ffffffffc0201ac8 <default_free_pages+0x78>
ffffffffc0201ab8:	6798                	ld	a4,8(a5)
ffffffffc0201aba:	04d70c63          	beq	a4,a3,ffffffffc0201b12 <default_free_pages+0xc2>
ffffffffc0201abe:	87ba                	mv	a5,a4
ffffffffc0201ac0:	fe878713          	addi	a4,a5,-24
ffffffffc0201ac4:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ab8 <default_free_pages+0x68>
ffffffffc0201ac8:	c199                	beqz	a1,ffffffffc0201ace <default_free_pages+0x7e>
ffffffffc0201aca:	0106b023          	sd	a6,0(a3)
ffffffffc0201ace:	6398                	ld	a4,0(a5)
ffffffffc0201ad0:	e390                	sd	a2,0(a5)
ffffffffc0201ad2:	e710                	sd	a2,8(a4)
ffffffffc0201ad4:	f11c                	sd	a5,32(a0)
ffffffffc0201ad6:	ed18                	sd	a4,24(a0)
ffffffffc0201ad8:	00d70d63          	beq	a4,a3,ffffffffc0201af2 <default_free_pages+0xa2>
ffffffffc0201adc:	ff872583          	lw	a1,-8(a4)
ffffffffc0201ae0:	fe870613          	addi	a2,a4,-24
ffffffffc0201ae4:	02059813          	slli	a6,a1,0x20
ffffffffc0201ae8:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201aec:	97b2                	add	a5,a5,a2
ffffffffc0201aee:	02f50c63          	beq	a0,a5,ffffffffc0201b26 <default_free_pages+0xd6>
ffffffffc0201af2:	711c                	ld	a5,32(a0)
ffffffffc0201af4:	00d78c63          	beq	a5,a3,ffffffffc0201b0c <default_free_pages+0xbc>
ffffffffc0201af8:	4910                	lw	a2,16(a0)
ffffffffc0201afa:	fe878693          	addi	a3,a5,-24
ffffffffc0201afe:	02061593          	slli	a1,a2,0x20
ffffffffc0201b02:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201b06:	972a                	add	a4,a4,a0
ffffffffc0201b08:	04e68a63          	beq	a3,a4,ffffffffc0201b5c <default_free_pages+0x10c>
ffffffffc0201b0c:	60a2                	ld	ra,8(sp)
ffffffffc0201b0e:	0141                	addi	sp,sp,16
ffffffffc0201b10:	8082                	ret
ffffffffc0201b12:	e790                	sd	a2,8(a5)
ffffffffc0201b14:	f114                	sd	a3,32(a0)
ffffffffc0201b16:	6798                	ld	a4,8(a5)
ffffffffc0201b18:	ed1c                	sd	a5,24(a0)
ffffffffc0201b1a:	02d70763          	beq	a4,a3,ffffffffc0201b48 <default_free_pages+0xf8>
ffffffffc0201b1e:	8832                	mv	a6,a2
ffffffffc0201b20:	4585                	li	a1,1
ffffffffc0201b22:	87ba                	mv	a5,a4
ffffffffc0201b24:	bf71                	j	ffffffffc0201ac0 <default_free_pages+0x70>
ffffffffc0201b26:	491c                	lw	a5,16(a0)
ffffffffc0201b28:	9dbd                	addw	a1,a1,a5
ffffffffc0201b2a:	feb72c23          	sw	a1,-8(a4)
ffffffffc0201b2e:	57f5                	li	a5,-3
ffffffffc0201b30:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0201b34:	01853803          	ld	a6,24(a0)
ffffffffc0201b38:	710c                	ld	a1,32(a0)
ffffffffc0201b3a:	8532                	mv	a0,a2
ffffffffc0201b3c:	00b83423          	sd	a1,8(a6)
ffffffffc0201b40:	671c                	ld	a5,8(a4)
ffffffffc0201b42:	0105b023          	sd	a6,0(a1)
ffffffffc0201b46:	b77d                	j	ffffffffc0201af4 <default_free_pages+0xa4>
ffffffffc0201b48:	e290                	sd	a2,0(a3)
ffffffffc0201b4a:	873e                	mv	a4,a5
ffffffffc0201b4c:	bf41                	j	ffffffffc0201adc <default_free_pages+0x8c>
ffffffffc0201b4e:	60a2                	ld	ra,8(sp)
ffffffffc0201b50:	e390                	sd	a2,0(a5)
ffffffffc0201b52:	e790                	sd	a2,8(a5)
ffffffffc0201b54:	f11c                	sd	a5,32(a0)
ffffffffc0201b56:	ed1c                	sd	a5,24(a0)
ffffffffc0201b58:	0141                	addi	sp,sp,16
ffffffffc0201b5a:	8082                	ret
ffffffffc0201b5c:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201b60:	ff078693          	addi	a3,a5,-16
ffffffffc0201b64:	9e39                	addw	a2,a2,a4
ffffffffc0201b66:	c910                	sw	a2,16(a0)
ffffffffc0201b68:	5775                	li	a4,-3
ffffffffc0201b6a:	60e6b02f          	amoand.d	zero,a4,(a3)
ffffffffc0201b6e:	6398                	ld	a4,0(a5)
ffffffffc0201b70:	679c                	ld	a5,8(a5)
ffffffffc0201b72:	60a2                	ld	ra,8(sp)
ffffffffc0201b74:	e71c                	sd	a5,8(a4)
ffffffffc0201b76:	e398                	sd	a4,0(a5)
ffffffffc0201b78:	0141                	addi	sp,sp,16
ffffffffc0201b7a:	8082                	ret
ffffffffc0201b7c:	0000b697          	auipc	a3,0xb
ffffffffc0201b80:	9c468693          	addi	a3,a3,-1596 # ffffffffc020c540 <commands+0xca8>
ffffffffc0201b84:	0000a617          	auipc	a2,0xa
ffffffffc0201b88:	f2460613          	addi	a2,a2,-220 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201b8c:	08200593          	li	a1,130
ffffffffc0201b90:	0000a517          	auipc	a0,0xa
ffffffffc0201b94:	66850513          	addi	a0,a0,1640 # ffffffffc020c1f8 <commands+0x960>
ffffffffc0201b98:	907fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201b9c:	0000b697          	auipc	a3,0xb
ffffffffc0201ba0:	99c68693          	addi	a3,a3,-1636 # ffffffffc020c538 <commands+0xca0>
ffffffffc0201ba4:	0000a617          	auipc	a2,0xa
ffffffffc0201ba8:	f0460613          	addi	a2,a2,-252 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201bac:	07f00593          	li	a1,127
ffffffffc0201bb0:	0000a517          	auipc	a0,0xa
ffffffffc0201bb4:	64850513          	addi	a0,a0,1608 # ffffffffc020c1f8 <commands+0x960>
ffffffffc0201bb8:	8e7fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201bbc <default_alloc_pages>:
ffffffffc0201bbc:	c941                	beqz	a0,ffffffffc0201c4c <default_alloc_pages+0x90>
ffffffffc0201bbe:	00090597          	auipc	a1,0x90
ffffffffc0201bc2:	bea58593          	addi	a1,a1,-1046 # ffffffffc02917a8 <free_area>
ffffffffc0201bc6:	0105a803          	lw	a6,16(a1)
ffffffffc0201bca:	872a                	mv	a4,a0
ffffffffc0201bcc:	02081793          	slli	a5,a6,0x20
ffffffffc0201bd0:	9381                	srli	a5,a5,0x20
ffffffffc0201bd2:	00a7ee63          	bltu	a5,a0,ffffffffc0201bee <default_alloc_pages+0x32>
ffffffffc0201bd6:	87ae                	mv	a5,a1
ffffffffc0201bd8:	a801                	j	ffffffffc0201be8 <default_alloc_pages+0x2c>
ffffffffc0201bda:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201bde:	02069613          	slli	a2,a3,0x20
ffffffffc0201be2:	9201                	srli	a2,a2,0x20
ffffffffc0201be4:	00e67763          	bgeu	a2,a4,ffffffffc0201bf2 <default_alloc_pages+0x36>
ffffffffc0201be8:	679c                	ld	a5,8(a5)
ffffffffc0201bea:	feb798e3          	bne	a5,a1,ffffffffc0201bda <default_alloc_pages+0x1e>
ffffffffc0201bee:	4501                	li	a0,0
ffffffffc0201bf0:	8082                	ret
ffffffffc0201bf2:	0007b883          	ld	a7,0(a5)
ffffffffc0201bf6:	0087b303          	ld	t1,8(a5)
ffffffffc0201bfa:	fe878513          	addi	a0,a5,-24
ffffffffc0201bfe:	00070e1b          	sext.w	t3,a4
ffffffffc0201c02:	0068b423          	sd	t1,8(a7) # 10000008 <_binary_bin_sfs_img_size+0xff8ad08>
ffffffffc0201c06:	01133023          	sd	a7,0(t1)
ffffffffc0201c0a:	02c77863          	bgeu	a4,a2,ffffffffc0201c3a <default_alloc_pages+0x7e>
ffffffffc0201c0e:	071a                	slli	a4,a4,0x6
ffffffffc0201c10:	972a                	add	a4,a4,a0
ffffffffc0201c12:	41c686bb          	subw	a3,a3,t3
ffffffffc0201c16:	cb14                	sw	a3,16(a4)
ffffffffc0201c18:	00870613          	addi	a2,a4,8
ffffffffc0201c1c:	4689                	li	a3,2
ffffffffc0201c1e:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0201c22:	0088b683          	ld	a3,8(a7)
ffffffffc0201c26:	01870613          	addi	a2,a4,24
ffffffffc0201c2a:	0105a803          	lw	a6,16(a1)
ffffffffc0201c2e:	e290                	sd	a2,0(a3)
ffffffffc0201c30:	00c8b423          	sd	a2,8(a7)
ffffffffc0201c34:	f314                	sd	a3,32(a4)
ffffffffc0201c36:	01173c23          	sd	a7,24(a4)
ffffffffc0201c3a:	41c8083b          	subw	a6,a6,t3
ffffffffc0201c3e:	0105a823          	sw	a6,16(a1)
ffffffffc0201c42:	5775                	li	a4,-3
ffffffffc0201c44:	17c1                	addi	a5,a5,-16
ffffffffc0201c46:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0201c4a:	8082                	ret
ffffffffc0201c4c:	1141                	addi	sp,sp,-16
ffffffffc0201c4e:	0000b697          	auipc	a3,0xb
ffffffffc0201c52:	8ea68693          	addi	a3,a3,-1814 # ffffffffc020c538 <commands+0xca0>
ffffffffc0201c56:	0000a617          	auipc	a2,0xa
ffffffffc0201c5a:	e5260613          	addi	a2,a2,-430 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201c5e:	06100593          	li	a1,97
ffffffffc0201c62:	0000a517          	auipc	a0,0xa
ffffffffc0201c66:	59650513          	addi	a0,a0,1430 # ffffffffc020c1f8 <commands+0x960>
ffffffffc0201c6a:	e406                	sd	ra,8(sp)
ffffffffc0201c6c:	833fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201c70 <default_init_memmap>:
ffffffffc0201c70:	1141                	addi	sp,sp,-16
ffffffffc0201c72:	e406                	sd	ra,8(sp)
ffffffffc0201c74:	c5f1                	beqz	a1,ffffffffc0201d40 <default_init_memmap+0xd0>
ffffffffc0201c76:	00659693          	slli	a3,a1,0x6
ffffffffc0201c7a:	96aa                	add	a3,a3,a0
ffffffffc0201c7c:	87aa                	mv	a5,a0
ffffffffc0201c7e:	00d50f63          	beq	a0,a3,ffffffffc0201c9c <default_init_memmap+0x2c>
ffffffffc0201c82:	6798                	ld	a4,8(a5)
ffffffffc0201c84:	8b05                	andi	a4,a4,1
ffffffffc0201c86:	cf49                	beqz	a4,ffffffffc0201d20 <default_init_memmap+0xb0>
ffffffffc0201c88:	0007a823          	sw	zero,16(a5)
ffffffffc0201c8c:	0007b423          	sd	zero,8(a5)
ffffffffc0201c90:	0007a023          	sw	zero,0(a5)
ffffffffc0201c94:	04078793          	addi	a5,a5,64
ffffffffc0201c98:	fed795e3          	bne	a5,a3,ffffffffc0201c82 <default_init_memmap+0x12>
ffffffffc0201c9c:	2581                	sext.w	a1,a1
ffffffffc0201c9e:	c90c                	sw	a1,16(a0)
ffffffffc0201ca0:	4789                	li	a5,2
ffffffffc0201ca2:	00850713          	addi	a4,a0,8
ffffffffc0201ca6:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0201caa:	00090697          	auipc	a3,0x90
ffffffffc0201cae:	afe68693          	addi	a3,a3,-1282 # ffffffffc02917a8 <free_area>
ffffffffc0201cb2:	4a98                	lw	a4,16(a3)
ffffffffc0201cb4:	669c                	ld	a5,8(a3)
ffffffffc0201cb6:	01850613          	addi	a2,a0,24
ffffffffc0201cba:	9db9                	addw	a1,a1,a4
ffffffffc0201cbc:	ca8c                	sw	a1,16(a3)
ffffffffc0201cbe:	04d78a63          	beq	a5,a3,ffffffffc0201d12 <default_init_memmap+0xa2>
ffffffffc0201cc2:	fe878713          	addi	a4,a5,-24
ffffffffc0201cc6:	0006b803          	ld	a6,0(a3)
ffffffffc0201cca:	4581                	li	a1,0
ffffffffc0201ccc:	00e56a63          	bltu	a0,a4,ffffffffc0201ce0 <default_init_memmap+0x70>
ffffffffc0201cd0:	6798                	ld	a4,8(a5)
ffffffffc0201cd2:	02d70263          	beq	a4,a3,ffffffffc0201cf6 <default_init_memmap+0x86>
ffffffffc0201cd6:	87ba                	mv	a5,a4
ffffffffc0201cd8:	fe878713          	addi	a4,a5,-24
ffffffffc0201cdc:	fee57ae3          	bgeu	a0,a4,ffffffffc0201cd0 <default_init_memmap+0x60>
ffffffffc0201ce0:	c199                	beqz	a1,ffffffffc0201ce6 <default_init_memmap+0x76>
ffffffffc0201ce2:	0106b023          	sd	a6,0(a3)
ffffffffc0201ce6:	6398                	ld	a4,0(a5)
ffffffffc0201ce8:	60a2                	ld	ra,8(sp)
ffffffffc0201cea:	e390                	sd	a2,0(a5)
ffffffffc0201cec:	e710                	sd	a2,8(a4)
ffffffffc0201cee:	f11c                	sd	a5,32(a0)
ffffffffc0201cf0:	ed18                	sd	a4,24(a0)
ffffffffc0201cf2:	0141                	addi	sp,sp,16
ffffffffc0201cf4:	8082                	ret
ffffffffc0201cf6:	e790                	sd	a2,8(a5)
ffffffffc0201cf8:	f114                	sd	a3,32(a0)
ffffffffc0201cfa:	6798                	ld	a4,8(a5)
ffffffffc0201cfc:	ed1c                	sd	a5,24(a0)
ffffffffc0201cfe:	00d70663          	beq	a4,a3,ffffffffc0201d0a <default_init_memmap+0x9a>
ffffffffc0201d02:	8832                	mv	a6,a2
ffffffffc0201d04:	4585                	li	a1,1
ffffffffc0201d06:	87ba                	mv	a5,a4
ffffffffc0201d08:	bfc1                	j	ffffffffc0201cd8 <default_init_memmap+0x68>
ffffffffc0201d0a:	60a2                	ld	ra,8(sp)
ffffffffc0201d0c:	e290                	sd	a2,0(a3)
ffffffffc0201d0e:	0141                	addi	sp,sp,16
ffffffffc0201d10:	8082                	ret
ffffffffc0201d12:	60a2                	ld	ra,8(sp)
ffffffffc0201d14:	e390                	sd	a2,0(a5)
ffffffffc0201d16:	e790                	sd	a2,8(a5)
ffffffffc0201d18:	f11c                	sd	a5,32(a0)
ffffffffc0201d1a:	ed1c                	sd	a5,24(a0)
ffffffffc0201d1c:	0141                	addi	sp,sp,16
ffffffffc0201d1e:	8082                	ret
ffffffffc0201d20:	0000b697          	auipc	a3,0xb
ffffffffc0201d24:	84868693          	addi	a3,a3,-1976 # ffffffffc020c568 <commands+0xcd0>
ffffffffc0201d28:	0000a617          	auipc	a2,0xa
ffffffffc0201d2c:	d8060613          	addi	a2,a2,-640 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201d30:	04800593          	li	a1,72
ffffffffc0201d34:	0000a517          	auipc	a0,0xa
ffffffffc0201d38:	4c450513          	addi	a0,a0,1220 # ffffffffc020c1f8 <commands+0x960>
ffffffffc0201d3c:	f62fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201d40:	0000a697          	auipc	a3,0xa
ffffffffc0201d44:	7f868693          	addi	a3,a3,2040 # ffffffffc020c538 <commands+0xca0>
ffffffffc0201d48:	0000a617          	auipc	a2,0xa
ffffffffc0201d4c:	d6060613          	addi	a2,a2,-672 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201d50:	04500593          	li	a1,69
ffffffffc0201d54:	0000a517          	auipc	a0,0xa
ffffffffc0201d58:	4a450513          	addi	a0,a0,1188 # ffffffffc020c1f8 <commands+0x960>
ffffffffc0201d5c:	f42fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201d60 <slob_free>:
ffffffffc0201d60:	c94d                	beqz	a0,ffffffffc0201e12 <slob_free+0xb2>
ffffffffc0201d62:	1141                	addi	sp,sp,-16
ffffffffc0201d64:	e022                	sd	s0,0(sp)
ffffffffc0201d66:	e406                	sd	ra,8(sp)
ffffffffc0201d68:	842a                	mv	s0,a0
ffffffffc0201d6a:	e9c1                	bnez	a1,ffffffffc0201dfa <slob_free+0x9a>
ffffffffc0201d6c:	100027f3          	csrr	a5,sstatus
ffffffffc0201d70:	8b89                	andi	a5,a5,2
ffffffffc0201d72:	4501                	li	a0,0
ffffffffc0201d74:	ebd9                	bnez	a5,ffffffffc0201e0a <slob_free+0xaa>
ffffffffc0201d76:	0008f617          	auipc	a2,0x8f
ffffffffc0201d7a:	2da60613          	addi	a2,a2,730 # ffffffffc0291050 <slobfree>
ffffffffc0201d7e:	621c                	ld	a5,0(a2)
ffffffffc0201d80:	873e                	mv	a4,a5
ffffffffc0201d82:	679c                	ld	a5,8(a5)
ffffffffc0201d84:	02877a63          	bgeu	a4,s0,ffffffffc0201db8 <slob_free+0x58>
ffffffffc0201d88:	00f46463          	bltu	s0,a5,ffffffffc0201d90 <slob_free+0x30>
ffffffffc0201d8c:	fef76ae3          	bltu	a4,a5,ffffffffc0201d80 <slob_free+0x20>
ffffffffc0201d90:	400c                	lw	a1,0(s0)
ffffffffc0201d92:	00459693          	slli	a3,a1,0x4
ffffffffc0201d96:	96a2                	add	a3,a3,s0
ffffffffc0201d98:	02d78a63          	beq	a5,a3,ffffffffc0201dcc <slob_free+0x6c>
ffffffffc0201d9c:	4314                	lw	a3,0(a4)
ffffffffc0201d9e:	e41c                	sd	a5,8(s0)
ffffffffc0201da0:	00469793          	slli	a5,a3,0x4
ffffffffc0201da4:	97ba                	add	a5,a5,a4
ffffffffc0201da6:	02f40e63          	beq	s0,a5,ffffffffc0201de2 <slob_free+0x82>
ffffffffc0201daa:	e700                	sd	s0,8(a4)
ffffffffc0201dac:	e218                	sd	a4,0(a2)
ffffffffc0201dae:	e129                	bnez	a0,ffffffffc0201df0 <slob_free+0x90>
ffffffffc0201db0:	60a2                	ld	ra,8(sp)
ffffffffc0201db2:	6402                	ld	s0,0(sp)
ffffffffc0201db4:	0141                	addi	sp,sp,16
ffffffffc0201db6:	8082                	ret
ffffffffc0201db8:	fcf764e3          	bltu	a4,a5,ffffffffc0201d80 <slob_free+0x20>
ffffffffc0201dbc:	fcf472e3          	bgeu	s0,a5,ffffffffc0201d80 <slob_free+0x20>
ffffffffc0201dc0:	400c                	lw	a1,0(s0)
ffffffffc0201dc2:	00459693          	slli	a3,a1,0x4
ffffffffc0201dc6:	96a2                	add	a3,a3,s0
ffffffffc0201dc8:	fcd79ae3          	bne	a5,a3,ffffffffc0201d9c <slob_free+0x3c>
ffffffffc0201dcc:	4394                	lw	a3,0(a5)
ffffffffc0201dce:	679c                	ld	a5,8(a5)
ffffffffc0201dd0:	9db5                	addw	a1,a1,a3
ffffffffc0201dd2:	c00c                	sw	a1,0(s0)
ffffffffc0201dd4:	4314                	lw	a3,0(a4)
ffffffffc0201dd6:	e41c                	sd	a5,8(s0)
ffffffffc0201dd8:	00469793          	slli	a5,a3,0x4
ffffffffc0201ddc:	97ba                	add	a5,a5,a4
ffffffffc0201dde:	fcf416e3          	bne	s0,a5,ffffffffc0201daa <slob_free+0x4a>
ffffffffc0201de2:	401c                	lw	a5,0(s0)
ffffffffc0201de4:	640c                	ld	a1,8(s0)
ffffffffc0201de6:	e218                	sd	a4,0(a2)
ffffffffc0201de8:	9ebd                	addw	a3,a3,a5
ffffffffc0201dea:	c314                	sw	a3,0(a4)
ffffffffc0201dec:	e70c                	sd	a1,8(a4)
ffffffffc0201dee:	d169                	beqz	a0,ffffffffc0201db0 <slob_free+0x50>
ffffffffc0201df0:	6402                	ld	s0,0(sp)
ffffffffc0201df2:	60a2                	ld	ra,8(sp)
ffffffffc0201df4:	0141                	addi	sp,sp,16
ffffffffc0201df6:	e77fe06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0201dfa:	25bd                	addiw	a1,a1,15
ffffffffc0201dfc:	8191                	srli	a1,a1,0x4
ffffffffc0201dfe:	c10c                	sw	a1,0(a0)
ffffffffc0201e00:	100027f3          	csrr	a5,sstatus
ffffffffc0201e04:	8b89                	andi	a5,a5,2
ffffffffc0201e06:	4501                	li	a0,0
ffffffffc0201e08:	d7bd                	beqz	a5,ffffffffc0201d76 <slob_free+0x16>
ffffffffc0201e0a:	e69fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201e0e:	4505                	li	a0,1
ffffffffc0201e10:	b79d                	j	ffffffffc0201d76 <slob_free+0x16>
ffffffffc0201e12:	8082                	ret

ffffffffc0201e14 <__slob_get_free_pages.constprop.0>:
ffffffffc0201e14:	4785                	li	a5,1
ffffffffc0201e16:	1141                	addi	sp,sp,-16
ffffffffc0201e18:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201e1c:	e406                	sd	ra,8(sp)
ffffffffc0201e1e:	352000ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0201e22:	c91d                	beqz	a0,ffffffffc0201e58 <__slob_get_free_pages.constprop.0+0x44>
ffffffffc0201e24:	00095697          	auipc	a3,0x95
ffffffffc0201e28:	a846b683          	ld	a3,-1404(a3) # ffffffffc02968a8 <pages>
ffffffffc0201e2c:	8d15                	sub	a0,a0,a3
ffffffffc0201e2e:	8519                	srai	a0,a0,0x6
ffffffffc0201e30:	0000e697          	auipc	a3,0xe
ffffffffc0201e34:	a606b683          	ld	a3,-1440(a3) # ffffffffc020f890 <nbase>
ffffffffc0201e38:	9536                	add	a0,a0,a3
ffffffffc0201e3a:	00c51793          	slli	a5,a0,0xc
ffffffffc0201e3e:	83b1                	srli	a5,a5,0xc
ffffffffc0201e40:	00095717          	auipc	a4,0x95
ffffffffc0201e44:	a6073703          	ld	a4,-1440(a4) # ffffffffc02968a0 <npage>
ffffffffc0201e48:	0532                	slli	a0,a0,0xc
ffffffffc0201e4a:	00e7fa63          	bgeu	a5,a4,ffffffffc0201e5e <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201e4e:	00095697          	auipc	a3,0x95
ffffffffc0201e52:	a6a6b683          	ld	a3,-1430(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0201e56:	9536                	add	a0,a0,a3
ffffffffc0201e58:	60a2                	ld	ra,8(sp)
ffffffffc0201e5a:	0141                	addi	sp,sp,16
ffffffffc0201e5c:	8082                	ret
ffffffffc0201e5e:	86aa                	mv	a3,a0
ffffffffc0201e60:	0000a617          	auipc	a2,0xa
ffffffffc0201e64:	76860613          	addi	a2,a2,1896 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc0201e68:	07100593          	li	a1,113
ffffffffc0201e6c:	0000a517          	auipc	a0,0xa
ffffffffc0201e70:	78450513          	addi	a0,a0,1924 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0201e74:	e2afe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201e78 <slob_alloc.constprop.0>:
ffffffffc0201e78:	1101                	addi	sp,sp,-32
ffffffffc0201e7a:	ec06                	sd	ra,24(sp)
ffffffffc0201e7c:	e822                	sd	s0,16(sp)
ffffffffc0201e7e:	e426                	sd	s1,8(sp)
ffffffffc0201e80:	e04a                	sd	s2,0(sp)
ffffffffc0201e82:	01050713          	addi	a4,a0,16
ffffffffc0201e86:	6785                	lui	a5,0x1
ffffffffc0201e88:	0cf77363          	bgeu	a4,a5,ffffffffc0201f4e <slob_alloc.constprop.0+0xd6>
ffffffffc0201e8c:	00f50493          	addi	s1,a0,15
ffffffffc0201e90:	8091                	srli	s1,s1,0x4
ffffffffc0201e92:	2481                	sext.w	s1,s1
ffffffffc0201e94:	10002673          	csrr	a2,sstatus
ffffffffc0201e98:	8a09                	andi	a2,a2,2
ffffffffc0201e9a:	e25d                	bnez	a2,ffffffffc0201f40 <slob_alloc.constprop.0+0xc8>
ffffffffc0201e9c:	0008f917          	auipc	s2,0x8f
ffffffffc0201ea0:	1b490913          	addi	s2,s2,436 # ffffffffc0291050 <slobfree>
ffffffffc0201ea4:	00093683          	ld	a3,0(s2)
ffffffffc0201ea8:	669c                	ld	a5,8(a3)
ffffffffc0201eaa:	4398                	lw	a4,0(a5)
ffffffffc0201eac:	08975e63          	bge	a4,s1,ffffffffc0201f48 <slob_alloc.constprop.0+0xd0>
ffffffffc0201eb0:	00f68b63          	beq	a3,a5,ffffffffc0201ec6 <slob_alloc.constprop.0+0x4e>
ffffffffc0201eb4:	6780                	ld	s0,8(a5)
ffffffffc0201eb6:	4018                	lw	a4,0(s0)
ffffffffc0201eb8:	02975a63          	bge	a4,s1,ffffffffc0201eec <slob_alloc.constprop.0+0x74>
ffffffffc0201ebc:	00093683          	ld	a3,0(s2)
ffffffffc0201ec0:	87a2                	mv	a5,s0
ffffffffc0201ec2:	fef699e3          	bne	a3,a5,ffffffffc0201eb4 <slob_alloc.constprop.0+0x3c>
ffffffffc0201ec6:	ee31                	bnez	a2,ffffffffc0201f22 <slob_alloc.constprop.0+0xaa>
ffffffffc0201ec8:	4501                	li	a0,0
ffffffffc0201eca:	f4bff0ef          	jal	ra,ffffffffc0201e14 <__slob_get_free_pages.constprop.0>
ffffffffc0201ece:	842a                	mv	s0,a0
ffffffffc0201ed0:	cd05                	beqz	a0,ffffffffc0201f08 <slob_alloc.constprop.0+0x90>
ffffffffc0201ed2:	6585                	lui	a1,0x1
ffffffffc0201ed4:	e8dff0ef          	jal	ra,ffffffffc0201d60 <slob_free>
ffffffffc0201ed8:	10002673          	csrr	a2,sstatus
ffffffffc0201edc:	8a09                	andi	a2,a2,2
ffffffffc0201ede:	ee05                	bnez	a2,ffffffffc0201f16 <slob_alloc.constprop.0+0x9e>
ffffffffc0201ee0:	00093783          	ld	a5,0(s2)
ffffffffc0201ee4:	6780                	ld	s0,8(a5)
ffffffffc0201ee6:	4018                	lw	a4,0(s0)
ffffffffc0201ee8:	fc974ae3          	blt	a4,s1,ffffffffc0201ebc <slob_alloc.constprop.0+0x44>
ffffffffc0201eec:	04e48763          	beq	s1,a4,ffffffffc0201f3a <slob_alloc.constprop.0+0xc2>
ffffffffc0201ef0:	00449693          	slli	a3,s1,0x4
ffffffffc0201ef4:	96a2                	add	a3,a3,s0
ffffffffc0201ef6:	e794                	sd	a3,8(a5)
ffffffffc0201ef8:	640c                	ld	a1,8(s0)
ffffffffc0201efa:	9f05                	subw	a4,a4,s1
ffffffffc0201efc:	c298                	sw	a4,0(a3)
ffffffffc0201efe:	e68c                	sd	a1,8(a3)
ffffffffc0201f00:	c004                	sw	s1,0(s0)
ffffffffc0201f02:	00f93023          	sd	a5,0(s2)
ffffffffc0201f06:	e20d                	bnez	a2,ffffffffc0201f28 <slob_alloc.constprop.0+0xb0>
ffffffffc0201f08:	60e2                	ld	ra,24(sp)
ffffffffc0201f0a:	8522                	mv	a0,s0
ffffffffc0201f0c:	6442                	ld	s0,16(sp)
ffffffffc0201f0e:	64a2                	ld	s1,8(sp)
ffffffffc0201f10:	6902                	ld	s2,0(sp)
ffffffffc0201f12:	6105                	addi	sp,sp,32
ffffffffc0201f14:	8082                	ret
ffffffffc0201f16:	d5dfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f1a:	00093783          	ld	a5,0(s2)
ffffffffc0201f1e:	4605                	li	a2,1
ffffffffc0201f20:	b7d1                	j	ffffffffc0201ee4 <slob_alloc.constprop.0+0x6c>
ffffffffc0201f22:	d4bfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f26:	b74d                	j	ffffffffc0201ec8 <slob_alloc.constprop.0+0x50>
ffffffffc0201f28:	d45fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f2c:	60e2                	ld	ra,24(sp)
ffffffffc0201f2e:	8522                	mv	a0,s0
ffffffffc0201f30:	6442                	ld	s0,16(sp)
ffffffffc0201f32:	64a2                	ld	s1,8(sp)
ffffffffc0201f34:	6902                	ld	s2,0(sp)
ffffffffc0201f36:	6105                	addi	sp,sp,32
ffffffffc0201f38:	8082                	ret
ffffffffc0201f3a:	6418                	ld	a4,8(s0)
ffffffffc0201f3c:	e798                	sd	a4,8(a5)
ffffffffc0201f3e:	b7d1                	j	ffffffffc0201f02 <slob_alloc.constprop.0+0x8a>
ffffffffc0201f40:	d33fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f44:	4605                	li	a2,1
ffffffffc0201f46:	bf99                	j	ffffffffc0201e9c <slob_alloc.constprop.0+0x24>
ffffffffc0201f48:	843e                	mv	s0,a5
ffffffffc0201f4a:	87b6                	mv	a5,a3
ffffffffc0201f4c:	b745                	j	ffffffffc0201eec <slob_alloc.constprop.0+0x74>
ffffffffc0201f4e:	0000a697          	auipc	a3,0xa
ffffffffc0201f52:	6b268693          	addi	a3,a3,1714 # ffffffffc020c600 <default_pmm_manager+0x70>
ffffffffc0201f56:	0000a617          	auipc	a2,0xa
ffffffffc0201f5a:	b5260613          	addi	a2,a2,-1198 # ffffffffc020baa8 <commands+0x210>
ffffffffc0201f5e:	06300593          	li	a1,99
ffffffffc0201f62:	0000a517          	auipc	a0,0xa
ffffffffc0201f66:	6be50513          	addi	a0,a0,1726 # ffffffffc020c620 <default_pmm_manager+0x90>
ffffffffc0201f6a:	d34fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201f6e <kmalloc_init>:
ffffffffc0201f6e:	1141                	addi	sp,sp,-16
ffffffffc0201f70:	0000a517          	auipc	a0,0xa
ffffffffc0201f74:	6c850513          	addi	a0,a0,1736 # ffffffffc020c638 <default_pmm_manager+0xa8>
ffffffffc0201f78:	e406                	sd	ra,8(sp)
ffffffffc0201f7a:	a2cfe0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201f7e:	60a2                	ld	ra,8(sp)
ffffffffc0201f80:	0000a517          	auipc	a0,0xa
ffffffffc0201f84:	6d050513          	addi	a0,a0,1744 # ffffffffc020c650 <default_pmm_manager+0xc0>
ffffffffc0201f88:	0141                	addi	sp,sp,16
ffffffffc0201f8a:	a1cfe06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0201f8e <kallocated>:
ffffffffc0201f8e:	4501                	li	a0,0
ffffffffc0201f90:	8082                	ret

ffffffffc0201f92 <kmalloc>:
ffffffffc0201f92:	1101                	addi	sp,sp,-32
ffffffffc0201f94:	e04a                	sd	s2,0(sp)
ffffffffc0201f96:	6905                	lui	s2,0x1
ffffffffc0201f98:	e822                	sd	s0,16(sp)
ffffffffc0201f9a:	ec06                	sd	ra,24(sp)
ffffffffc0201f9c:	e426                	sd	s1,8(sp)
ffffffffc0201f9e:	fef90793          	addi	a5,s2,-17 # fef <_binary_bin_swap_img_size-0x6d11>
ffffffffc0201fa2:	842a                	mv	s0,a0
ffffffffc0201fa4:	04a7f963          	bgeu	a5,a0,ffffffffc0201ff6 <kmalloc+0x64>
ffffffffc0201fa8:	4561                	li	a0,24
ffffffffc0201faa:	ecfff0ef          	jal	ra,ffffffffc0201e78 <slob_alloc.constprop.0>
ffffffffc0201fae:	84aa                	mv	s1,a0
ffffffffc0201fb0:	c929                	beqz	a0,ffffffffc0202002 <kmalloc+0x70>
ffffffffc0201fb2:	0004079b          	sext.w	a5,s0
ffffffffc0201fb6:	4501                	li	a0,0
ffffffffc0201fb8:	00f95763          	bge	s2,a5,ffffffffc0201fc6 <kmalloc+0x34>
ffffffffc0201fbc:	6705                	lui	a4,0x1
ffffffffc0201fbe:	8785                	srai	a5,a5,0x1
ffffffffc0201fc0:	2505                	addiw	a0,a0,1
ffffffffc0201fc2:	fef74ee3          	blt	a4,a5,ffffffffc0201fbe <kmalloc+0x2c>
ffffffffc0201fc6:	c088                	sw	a0,0(s1)
ffffffffc0201fc8:	e4dff0ef          	jal	ra,ffffffffc0201e14 <__slob_get_free_pages.constprop.0>
ffffffffc0201fcc:	e488                	sd	a0,8(s1)
ffffffffc0201fce:	842a                	mv	s0,a0
ffffffffc0201fd0:	c525                	beqz	a0,ffffffffc0202038 <kmalloc+0xa6>
ffffffffc0201fd2:	100027f3          	csrr	a5,sstatus
ffffffffc0201fd6:	8b89                	andi	a5,a5,2
ffffffffc0201fd8:	ef8d                	bnez	a5,ffffffffc0202012 <kmalloc+0x80>
ffffffffc0201fda:	00095797          	auipc	a5,0x95
ffffffffc0201fde:	8ae78793          	addi	a5,a5,-1874 # ffffffffc0296888 <bigblocks>
ffffffffc0201fe2:	6398                	ld	a4,0(a5)
ffffffffc0201fe4:	e384                	sd	s1,0(a5)
ffffffffc0201fe6:	e898                	sd	a4,16(s1)
ffffffffc0201fe8:	60e2                	ld	ra,24(sp)
ffffffffc0201fea:	8522                	mv	a0,s0
ffffffffc0201fec:	6442                	ld	s0,16(sp)
ffffffffc0201fee:	64a2                	ld	s1,8(sp)
ffffffffc0201ff0:	6902                	ld	s2,0(sp)
ffffffffc0201ff2:	6105                	addi	sp,sp,32
ffffffffc0201ff4:	8082                	ret
ffffffffc0201ff6:	0541                	addi	a0,a0,16
ffffffffc0201ff8:	e81ff0ef          	jal	ra,ffffffffc0201e78 <slob_alloc.constprop.0>
ffffffffc0201ffc:	01050413          	addi	s0,a0,16
ffffffffc0202000:	f565                	bnez	a0,ffffffffc0201fe8 <kmalloc+0x56>
ffffffffc0202002:	4401                	li	s0,0
ffffffffc0202004:	60e2                	ld	ra,24(sp)
ffffffffc0202006:	8522                	mv	a0,s0
ffffffffc0202008:	6442                	ld	s0,16(sp)
ffffffffc020200a:	64a2                	ld	s1,8(sp)
ffffffffc020200c:	6902                	ld	s2,0(sp)
ffffffffc020200e:	6105                	addi	sp,sp,32
ffffffffc0202010:	8082                	ret
ffffffffc0202012:	c61fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202016:	00095797          	auipc	a5,0x95
ffffffffc020201a:	87278793          	addi	a5,a5,-1934 # ffffffffc0296888 <bigblocks>
ffffffffc020201e:	6398                	ld	a4,0(a5)
ffffffffc0202020:	e384                	sd	s1,0(a5)
ffffffffc0202022:	e898                	sd	a4,16(s1)
ffffffffc0202024:	c49fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202028:	6480                	ld	s0,8(s1)
ffffffffc020202a:	60e2                	ld	ra,24(sp)
ffffffffc020202c:	64a2                	ld	s1,8(sp)
ffffffffc020202e:	8522                	mv	a0,s0
ffffffffc0202030:	6442                	ld	s0,16(sp)
ffffffffc0202032:	6902                	ld	s2,0(sp)
ffffffffc0202034:	6105                	addi	sp,sp,32
ffffffffc0202036:	8082                	ret
ffffffffc0202038:	45e1                	li	a1,24
ffffffffc020203a:	8526                	mv	a0,s1
ffffffffc020203c:	d25ff0ef          	jal	ra,ffffffffc0201d60 <slob_free>
ffffffffc0202040:	b765                	j	ffffffffc0201fe8 <kmalloc+0x56>

ffffffffc0202042 <kfree>:
ffffffffc0202042:	c169                	beqz	a0,ffffffffc0202104 <kfree+0xc2>
ffffffffc0202044:	1101                	addi	sp,sp,-32
ffffffffc0202046:	e822                	sd	s0,16(sp)
ffffffffc0202048:	ec06                	sd	ra,24(sp)
ffffffffc020204a:	e426                	sd	s1,8(sp)
ffffffffc020204c:	03451793          	slli	a5,a0,0x34
ffffffffc0202050:	842a                	mv	s0,a0
ffffffffc0202052:	e3d9                	bnez	a5,ffffffffc02020d8 <kfree+0x96>
ffffffffc0202054:	100027f3          	csrr	a5,sstatus
ffffffffc0202058:	8b89                	andi	a5,a5,2
ffffffffc020205a:	e7d9                	bnez	a5,ffffffffc02020e8 <kfree+0xa6>
ffffffffc020205c:	00095797          	auipc	a5,0x95
ffffffffc0202060:	82c7b783          	ld	a5,-2004(a5) # ffffffffc0296888 <bigblocks>
ffffffffc0202064:	4601                	li	a2,0
ffffffffc0202066:	cbad                	beqz	a5,ffffffffc02020d8 <kfree+0x96>
ffffffffc0202068:	00095697          	auipc	a3,0x95
ffffffffc020206c:	82068693          	addi	a3,a3,-2016 # ffffffffc0296888 <bigblocks>
ffffffffc0202070:	a021                	j	ffffffffc0202078 <kfree+0x36>
ffffffffc0202072:	01048693          	addi	a3,s1,16
ffffffffc0202076:	c3a5                	beqz	a5,ffffffffc02020d6 <kfree+0x94>
ffffffffc0202078:	6798                	ld	a4,8(a5)
ffffffffc020207a:	84be                	mv	s1,a5
ffffffffc020207c:	6b9c                	ld	a5,16(a5)
ffffffffc020207e:	fe871ae3          	bne	a4,s0,ffffffffc0202072 <kfree+0x30>
ffffffffc0202082:	e29c                	sd	a5,0(a3)
ffffffffc0202084:	ee2d                	bnez	a2,ffffffffc02020fe <kfree+0xbc>
ffffffffc0202086:	c02007b7          	lui	a5,0xc0200
ffffffffc020208a:	4098                	lw	a4,0(s1)
ffffffffc020208c:	08f46963          	bltu	s0,a5,ffffffffc020211e <kfree+0xdc>
ffffffffc0202090:	00095697          	auipc	a3,0x95
ffffffffc0202094:	8286b683          	ld	a3,-2008(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202098:	8c15                	sub	s0,s0,a3
ffffffffc020209a:	8031                	srli	s0,s0,0xc
ffffffffc020209c:	00095797          	auipc	a5,0x95
ffffffffc02020a0:	8047b783          	ld	a5,-2044(a5) # ffffffffc02968a0 <npage>
ffffffffc02020a4:	06f47163          	bgeu	s0,a5,ffffffffc0202106 <kfree+0xc4>
ffffffffc02020a8:	0000d517          	auipc	a0,0xd
ffffffffc02020ac:	7e853503          	ld	a0,2024(a0) # ffffffffc020f890 <nbase>
ffffffffc02020b0:	8c09                	sub	s0,s0,a0
ffffffffc02020b2:	041a                	slli	s0,s0,0x6
ffffffffc02020b4:	00094517          	auipc	a0,0x94
ffffffffc02020b8:	7f453503          	ld	a0,2036(a0) # ffffffffc02968a8 <pages>
ffffffffc02020bc:	4585                	li	a1,1
ffffffffc02020be:	9522                	add	a0,a0,s0
ffffffffc02020c0:	00e595bb          	sllw	a1,a1,a4
ffffffffc02020c4:	0ea000ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc02020c8:	6442                	ld	s0,16(sp)
ffffffffc02020ca:	60e2                	ld	ra,24(sp)
ffffffffc02020cc:	8526                	mv	a0,s1
ffffffffc02020ce:	64a2                	ld	s1,8(sp)
ffffffffc02020d0:	45e1                	li	a1,24
ffffffffc02020d2:	6105                	addi	sp,sp,32
ffffffffc02020d4:	b171                	j	ffffffffc0201d60 <slob_free>
ffffffffc02020d6:	e20d                	bnez	a2,ffffffffc02020f8 <kfree+0xb6>
ffffffffc02020d8:	ff040513          	addi	a0,s0,-16
ffffffffc02020dc:	6442                	ld	s0,16(sp)
ffffffffc02020de:	60e2                	ld	ra,24(sp)
ffffffffc02020e0:	64a2                	ld	s1,8(sp)
ffffffffc02020e2:	4581                	li	a1,0
ffffffffc02020e4:	6105                	addi	sp,sp,32
ffffffffc02020e6:	b9ad                	j	ffffffffc0201d60 <slob_free>
ffffffffc02020e8:	b8bfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02020ec:	00094797          	auipc	a5,0x94
ffffffffc02020f0:	79c7b783          	ld	a5,1948(a5) # ffffffffc0296888 <bigblocks>
ffffffffc02020f4:	4605                	li	a2,1
ffffffffc02020f6:	fbad                	bnez	a5,ffffffffc0202068 <kfree+0x26>
ffffffffc02020f8:	b75fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020fc:	bff1                	j	ffffffffc02020d8 <kfree+0x96>
ffffffffc02020fe:	b6ffe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202102:	b751                	j	ffffffffc0202086 <kfree+0x44>
ffffffffc0202104:	8082                	ret
ffffffffc0202106:	0000a617          	auipc	a2,0xa
ffffffffc020210a:	59260613          	addi	a2,a2,1426 # ffffffffc020c698 <default_pmm_manager+0x108>
ffffffffc020210e:	06900593          	li	a1,105
ffffffffc0202112:	0000a517          	auipc	a0,0xa
ffffffffc0202116:	4de50513          	addi	a0,a0,1246 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc020211a:	b84fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020211e:	86a2                	mv	a3,s0
ffffffffc0202120:	0000a617          	auipc	a2,0xa
ffffffffc0202124:	55060613          	addi	a2,a2,1360 # ffffffffc020c670 <default_pmm_manager+0xe0>
ffffffffc0202128:	07700593          	li	a1,119
ffffffffc020212c:	0000a517          	auipc	a0,0xa
ffffffffc0202130:	4c450513          	addi	a0,a0,1220 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0202134:	b6afe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202138 <pa2page.part.0>:
ffffffffc0202138:	1141                	addi	sp,sp,-16
ffffffffc020213a:	0000a617          	auipc	a2,0xa
ffffffffc020213e:	55e60613          	addi	a2,a2,1374 # ffffffffc020c698 <default_pmm_manager+0x108>
ffffffffc0202142:	06900593          	li	a1,105
ffffffffc0202146:	0000a517          	auipc	a0,0xa
ffffffffc020214a:	4aa50513          	addi	a0,a0,1194 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc020214e:	e406                	sd	ra,8(sp)
ffffffffc0202150:	b4efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202154 <pte2page.part.0>:
ffffffffc0202154:	1141                	addi	sp,sp,-16
ffffffffc0202156:	0000a617          	auipc	a2,0xa
ffffffffc020215a:	56260613          	addi	a2,a2,1378 # ffffffffc020c6b8 <default_pmm_manager+0x128>
ffffffffc020215e:	07f00593          	li	a1,127
ffffffffc0202162:	0000a517          	auipc	a0,0xa
ffffffffc0202166:	48e50513          	addi	a0,a0,1166 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc020216a:	e406                	sd	ra,8(sp)
ffffffffc020216c:	b32fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202170 <alloc_pages>:
ffffffffc0202170:	100027f3          	csrr	a5,sstatus
ffffffffc0202174:	8b89                	andi	a5,a5,2
ffffffffc0202176:	e799                	bnez	a5,ffffffffc0202184 <alloc_pages+0x14>
ffffffffc0202178:	00094797          	auipc	a5,0x94
ffffffffc020217c:	7387b783          	ld	a5,1848(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202180:	6f9c                	ld	a5,24(a5)
ffffffffc0202182:	8782                	jr	a5
ffffffffc0202184:	1141                	addi	sp,sp,-16
ffffffffc0202186:	e406                	sd	ra,8(sp)
ffffffffc0202188:	e022                	sd	s0,0(sp)
ffffffffc020218a:	842a                	mv	s0,a0
ffffffffc020218c:	ae7fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202190:	00094797          	auipc	a5,0x94
ffffffffc0202194:	7207b783          	ld	a5,1824(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202198:	6f9c                	ld	a5,24(a5)
ffffffffc020219a:	8522                	mv	a0,s0
ffffffffc020219c:	9782                	jalr	a5
ffffffffc020219e:	842a                	mv	s0,a0
ffffffffc02021a0:	acdfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02021a4:	60a2                	ld	ra,8(sp)
ffffffffc02021a6:	8522                	mv	a0,s0
ffffffffc02021a8:	6402                	ld	s0,0(sp)
ffffffffc02021aa:	0141                	addi	sp,sp,16
ffffffffc02021ac:	8082                	ret

ffffffffc02021ae <free_pages>:
ffffffffc02021ae:	100027f3          	csrr	a5,sstatus
ffffffffc02021b2:	8b89                	andi	a5,a5,2
ffffffffc02021b4:	e799                	bnez	a5,ffffffffc02021c2 <free_pages+0x14>
ffffffffc02021b6:	00094797          	auipc	a5,0x94
ffffffffc02021ba:	6fa7b783          	ld	a5,1786(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021be:	739c                	ld	a5,32(a5)
ffffffffc02021c0:	8782                	jr	a5
ffffffffc02021c2:	1101                	addi	sp,sp,-32
ffffffffc02021c4:	ec06                	sd	ra,24(sp)
ffffffffc02021c6:	e822                	sd	s0,16(sp)
ffffffffc02021c8:	e426                	sd	s1,8(sp)
ffffffffc02021ca:	842a                	mv	s0,a0
ffffffffc02021cc:	84ae                	mv	s1,a1
ffffffffc02021ce:	aa5fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02021d2:	00094797          	auipc	a5,0x94
ffffffffc02021d6:	6de7b783          	ld	a5,1758(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021da:	739c                	ld	a5,32(a5)
ffffffffc02021dc:	85a6                	mv	a1,s1
ffffffffc02021de:	8522                	mv	a0,s0
ffffffffc02021e0:	9782                	jalr	a5
ffffffffc02021e2:	6442                	ld	s0,16(sp)
ffffffffc02021e4:	60e2                	ld	ra,24(sp)
ffffffffc02021e6:	64a2                	ld	s1,8(sp)
ffffffffc02021e8:	6105                	addi	sp,sp,32
ffffffffc02021ea:	a83fe06f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02021ee <nr_free_pages>:
ffffffffc02021ee:	100027f3          	csrr	a5,sstatus
ffffffffc02021f2:	8b89                	andi	a5,a5,2
ffffffffc02021f4:	e799                	bnez	a5,ffffffffc0202202 <nr_free_pages+0x14>
ffffffffc02021f6:	00094797          	auipc	a5,0x94
ffffffffc02021fa:	6ba7b783          	ld	a5,1722(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021fe:	779c                	ld	a5,40(a5)
ffffffffc0202200:	8782                	jr	a5
ffffffffc0202202:	1141                	addi	sp,sp,-16
ffffffffc0202204:	e406                	sd	ra,8(sp)
ffffffffc0202206:	e022                	sd	s0,0(sp)
ffffffffc0202208:	a6bfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020220c:	00094797          	auipc	a5,0x94
ffffffffc0202210:	6a47b783          	ld	a5,1700(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202214:	779c                	ld	a5,40(a5)
ffffffffc0202216:	9782                	jalr	a5
ffffffffc0202218:	842a                	mv	s0,a0
ffffffffc020221a:	a53fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020221e:	60a2                	ld	ra,8(sp)
ffffffffc0202220:	8522                	mv	a0,s0
ffffffffc0202222:	6402                	ld	s0,0(sp)
ffffffffc0202224:	0141                	addi	sp,sp,16
ffffffffc0202226:	8082                	ret

ffffffffc0202228 <get_pte>:
ffffffffc0202228:	01e5d793          	srli	a5,a1,0x1e
ffffffffc020222c:	1ff7f793          	andi	a5,a5,511
ffffffffc0202230:	7139                	addi	sp,sp,-64
ffffffffc0202232:	078e                	slli	a5,a5,0x3
ffffffffc0202234:	f426                	sd	s1,40(sp)
ffffffffc0202236:	00f504b3          	add	s1,a0,a5
ffffffffc020223a:	6094                	ld	a3,0(s1)
ffffffffc020223c:	f04a                	sd	s2,32(sp)
ffffffffc020223e:	ec4e                	sd	s3,24(sp)
ffffffffc0202240:	e852                	sd	s4,16(sp)
ffffffffc0202242:	fc06                	sd	ra,56(sp)
ffffffffc0202244:	f822                	sd	s0,48(sp)
ffffffffc0202246:	e456                	sd	s5,8(sp)
ffffffffc0202248:	e05a                	sd	s6,0(sp)
ffffffffc020224a:	0016f793          	andi	a5,a3,1
ffffffffc020224e:	892e                	mv	s2,a1
ffffffffc0202250:	8a32                	mv	s4,a2
ffffffffc0202252:	00094997          	auipc	s3,0x94
ffffffffc0202256:	64e98993          	addi	s3,s3,1614 # ffffffffc02968a0 <npage>
ffffffffc020225a:	efbd                	bnez	a5,ffffffffc02022d8 <get_pte+0xb0>
ffffffffc020225c:	14060c63          	beqz	a2,ffffffffc02023b4 <get_pte+0x18c>
ffffffffc0202260:	100027f3          	csrr	a5,sstatus
ffffffffc0202264:	8b89                	andi	a5,a5,2
ffffffffc0202266:	14079963          	bnez	a5,ffffffffc02023b8 <get_pte+0x190>
ffffffffc020226a:	00094797          	auipc	a5,0x94
ffffffffc020226e:	6467b783          	ld	a5,1606(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202272:	6f9c                	ld	a5,24(a5)
ffffffffc0202274:	4505                	li	a0,1
ffffffffc0202276:	9782                	jalr	a5
ffffffffc0202278:	842a                	mv	s0,a0
ffffffffc020227a:	12040d63          	beqz	s0,ffffffffc02023b4 <get_pte+0x18c>
ffffffffc020227e:	00094b17          	auipc	s6,0x94
ffffffffc0202282:	62ab0b13          	addi	s6,s6,1578 # ffffffffc02968a8 <pages>
ffffffffc0202286:	000b3503          	ld	a0,0(s6)
ffffffffc020228a:	00080ab7          	lui	s5,0x80
ffffffffc020228e:	00094997          	auipc	s3,0x94
ffffffffc0202292:	61298993          	addi	s3,s3,1554 # ffffffffc02968a0 <npage>
ffffffffc0202296:	40a40533          	sub	a0,s0,a0
ffffffffc020229a:	8519                	srai	a0,a0,0x6
ffffffffc020229c:	9556                	add	a0,a0,s5
ffffffffc020229e:	0009b703          	ld	a4,0(s3)
ffffffffc02022a2:	00c51793          	slli	a5,a0,0xc
ffffffffc02022a6:	4685                	li	a3,1
ffffffffc02022a8:	c014                	sw	a3,0(s0)
ffffffffc02022aa:	83b1                	srli	a5,a5,0xc
ffffffffc02022ac:	0532                	slli	a0,a0,0xc
ffffffffc02022ae:	16e7f763          	bgeu	a5,a4,ffffffffc020241c <get_pte+0x1f4>
ffffffffc02022b2:	00094797          	auipc	a5,0x94
ffffffffc02022b6:	6067b783          	ld	a5,1542(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022ba:	6605                	lui	a2,0x1
ffffffffc02022bc:	4581                	li	a1,0
ffffffffc02022be:	953e                	add	a0,a0,a5
ffffffffc02022c0:	306090ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc02022c4:	000b3683          	ld	a3,0(s6)
ffffffffc02022c8:	40d406b3          	sub	a3,s0,a3
ffffffffc02022cc:	8699                	srai	a3,a3,0x6
ffffffffc02022ce:	96d6                	add	a3,a3,s5
ffffffffc02022d0:	06aa                	slli	a3,a3,0xa
ffffffffc02022d2:	0116e693          	ori	a3,a3,17
ffffffffc02022d6:	e094                	sd	a3,0(s1)
ffffffffc02022d8:	77fd                	lui	a5,0xfffff
ffffffffc02022da:	068a                	slli	a3,a3,0x2
ffffffffc02022dc:	0009b703          	ld	a4,0(s3)
ffffffffc02022e0:	8efd                	and	a3,a3,a5
ffffffffc02022e2:	00c6d793          	srli	a5,a3,0xc
ffffffffc02022e6:	10e7ff63          	bgeu	a5,a4,ffffffffc0202404 <get_pte+0x1dc>
ffffffffc02022ea:	00094a97          	auipc	s5,0x94
ffffffffc02022ee:	5cea8a93          	addi	s5,s5,1486 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022f2:	000ab403          	ld	s0,0(s5)
ffffffffc02022f6:	01595793          	srli	a5,s2,0x15
ffffffffc02022fa:	1ff7f793          	andi	a5,a5,511
ffffffffc02022fe:	96a2                	add	a3,a3,s0
ffffffffc0202300:	00379413          	slli	s0,a5,0x3
ffffffffc0202304:	9436                	add	s0,s0,a3
ffffffffc0202306:	6014                	ld	a3,0(s0)
ffffffffc0202308:	0016f793          	andi	a5,a3,1
ffffffffc020230c:	ebad                	bnez	a5,ffffffffc020237e <get_pte+0x156>
ffffffffc020230e:	0a0a0363          	beqz	s4,ffffffffc02023b4 <get_pte+0x18c>
ffffffffc0202312:	100027f3          	csrr	a5,sstatus
ffffffffc0202316:	8b89                	andi	a5,a5,2
ffffffffc0202318:	efcd                	bnez	a5,ffffffffc02023d2 <get_pte+0x1aa>
ffffffffc020231a:	00094797          	auipc	a5,0x94
ffffffffc020231e:	5967b783          	ld	a5,1430(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202322:	6f9c                	ld	a5,24(a5)
ffffffffc0202324:	4505                	li	a0,1
ffffffffc0202326:	9782                	jalr	a5
ffffffffc0202328:	84aa                	mv	s1,a0
ffffffffc020232a:	c4c9                	beqz	s1,ffffffffc02023b4 <get_pte+0x18c>
ffffffffc020232c:	00094b17          	auipc	s6,0x94
ffffffffc0202330:	57cb0b13          	addi	s6,s6,1404 # ffffffffc02968a8 <pages>
ffffffffc0202334:	000b3503          	ld	a0,0(s6)
ffffffffc0202338:	00080a37          	lui	s4,0x80
ffffffffc020233c:	0009b703          	ld	a4,0(s3)
ffffffffc0202340:	40a48533          	sub	a0,s1,a0
ffffffffc0202344:	8519                	srai	a0,a0,0x6
ffffffffc0202346:	9552                	add	a0,a0,s4
ffffffffc0202348:	00c51793          	slli	a5,a0,0xc
ffffffffc020234c:	4685                	li	a3,1
ffffffffc020234e:	c094                	sw	a3,0(s1)
ffffffffc0202350:	83b1                	srli	a5,a5,0xc
ffffffffc0202352:	0532                	slli	a0,a0,0xc
ffffffffc0202354:	0ee7f163          	bgeu	a5,a4,ffffffffc0202436 <get_pte+0x20e>
ffffffffc0202358:	000ab783          	ld	a5,0(s5)
ffffffffc020235c:	6605                	lui	a2,0x1
ffffffffc020235e:	4581                	li	a1,0
ffffffffc0202360:	953e                	add	a0,a0,a5
ffffffffc0202362:	264090ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0202366:	000b3683          	ld	a3,0(s6)
ffffffffc020236a:	40d486b3          	sub	a3,s1,a3
ffffffffc020236e:	8699                	srai	a3,a3,0x6
ffffffffc0202370:	96d2                	add	a3,a3,s4
ffffffffc0202372:	06aa                	slli	a3,a3,0xa
ffffffffc0202374:	0116e693          	ori	a3,a3,17
ffffffffc0202378:	e014                	sd	a3,0(s0)
ffffffffc020237a:	0009b703          	ld	a4,0(s3)
ffffffffc020237e:	068a                	slli	a3,a3,0x2
ffffffffc0202380:	757d                	lui	a0,0xfffff
ffffffffc0202382:	8ee9                	and	a3,a3,a0
ffffffffc0202384:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202388:	06e7f263          	bgeu	a5,a4,ffffffffc02023ec <get_pte+0x1c4>
ffffffffc020238c:	000ab503          	ld	a0,0(s5)
ffffffffc0202390:	00c95913          	srli	s2,s2,0xc
ffffffffc0202394:	1ff97913          	andi	s2,s2,511
ffffffffc0202398:	96aa                	add	a3,a3,a0
ffffffffc020239a:	00391513          	slli	a0,s2,0x3
ffffffffc020239e:	9536                	add	a0,a0,a3
ffffffffc02023a0:	70e2                	ld	ra,56(sp)
ffffffffc02023a2:	7442                	ld	s0,48(sp)
ffffffffc02023a4:	74a2                	ld	s1,40(sp)
ffffffffc02023a6:	7902                	ld	s2,32(sp)
ffffffffc02023a8:	69e2                	ld	s3,24(sp)
ffffffffc02023aa:	6a42                	ld	s4,16(sp)
ffffffffc02023ac:	6aa2                	ld	s5,8(sp)
ffffffffc02023ae:	6b02                	ld	s6,0(sp)
ffffffffc02023b0:	6121                	addi	sp,sp,64
ffffffffc02023b2:	8082                	ret
ffffffffc02023b4:	4501                	li	a0,0
ffffffffc02023b6:	b7ed                	j	ffffffffc02023a0 <get_pte+0x178>
ffffffffc02023b8:	8bbfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023bc:	00094797          	auipc	a5,0x94
ffffffffc02023c0:	4f47b783          	ld	a5,1268(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023c4:	6f9c                	ld	a5,24(a5)
ffffffffc02023c6:	4505                	li	a0,1
ffffffffc02023c8:	9782                	jalr	a5
ffffffffc02023ca:	842a                	mv	s0,a0
ffffffffc02023cc:	8a1fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023d0:	b56d                	j	ffffffffc020227a <get_pte+0x52>
ffffffffc02023d2:	8a1fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023d6:	00094797          	auipc	a5,0x94
ffffffffc02023da:	4da7b783          	ld	a5,1242(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023de:	6f9c                	ld	a5,24(a5)
ffffffffc02023e0:	4505                	li	a0,1
ffffffffc02023e2:	9782                	jalr	a5
ffffffffc02023e4:	84aa                	mv	s1,a0
ffffffffc02023e6:	887fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023ea:	b781                	j	ffffffffc020232a <get_pte+0x102>
ffffffffc02023ec:	0000a617          	auipc	a2,0xa
ffffffffc02023f0:	1dc60613          	addi	a2,a2,476 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc02023f4:	13200593          	li	a1,306
ffffffffc02023f8:	0000a517          	auipc	a0,0xa
ffffffffc02023fc:	2e850513          	addi	a0,a0,744 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0202400:	89efe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202404:	0000a617          	auipc	a2,0xa
ffffffffc0202408:	1c460613          	addi	a2,a2,452 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc020240c:	12500593          	li	a1,293
ffffffffc0202410:	0000a517          	auipc	a0,0xa
ffffffffc0202414:	2d050513          	addi	a0,a0,720 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0202418:	886fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020241c:	86aa                	mv	a3,a0
ffffffffc020241e:	0000a617          	auipc	a2,0xa
ffffffffc0202422:	1aa60613          	addi	a2,a2,426 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc0202426:	12100593          	li	a1,289
ffffffffc020242a:	0000a517          	auipc	a0,0xa
ffffffffc020242e:	2b650513          	addi	a0,a0,694 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0202432:	86cfe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202436:	86aa                	mv	a3,a0
ffffffffc0202438:	0000a617          	auipc	a2,0xa
ffffffffc020243c:	19060613          	addi	a2,a2,400 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc0202440:	12f00593          	li	a1,303
ffffffffc0202444:	0000a517          	auipc	a0,0xa
ffffffffc0202448:	29c50513          	addi	a0,a0,668 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc020244c:	852fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202450 <boot_map_segment>:
ffffffffc0202450:	6785                	lui	a5,0x1
ffffffffc0202452:	7139                	addi	sp,sp,-64
ffffffffc0202454:	00d5c833          	xor	a6,a1,a3
ffffffffc0202458:	17fd                	addi	a5,a5,-1
ffffffffc020245a:	fc06                	sd	ra,56(sp)
ffffffffc020245c:	f822                	sd	s0,48(sp)
ffffffffc020245e:	f426                	sd	s1,40(sp)
ffffffffc0202460:	f04a                	sd	s2,32(sp)
ffffffffc0202462:	ec4e                	sd	s3,24(sp)
ffffffffc0202464:	e852                	sd	s4,16(sp)
ffffffffc0202466:	e456                	sd	s5,8(sp)
ffffffffc0202468:	00f87833          	and	a6,a6,a5
ffffffffc020246c:	08081563          	bnez	a6,ffffffffc02024f6 <boot_map_segment+0xa6>
ffffffffc0202470:	00f5f4b3          	and	s1,a1,a5
ffffffffc0202474:	963e                	add	a2,a2,a5
ffffffffc0202476:	94b2                	add	s1,s1,a2
ffffffffc0202478:	797d                	lui	s2,0xfffff
ffffffffc020247a:	80b1                	srli	s1,s1,0xc
ffffffffc020247c:	0125f5b3          	and	a1,a1,s2
ffffffffc0202480:	0126f6b3          	and	a3,a3,s2
ffffffffc0202484:	c0a1                	beqz	s1,ffffffffc02024c4 <boot_map_segment+0x74>
ffffffffc0202486:	00176713          	ori	a4,a4,1
ffffffffc020248a:	04b2                	slli	s1,s1,0xc
ffffffffc020248c:	02071993          	slli	s3,a4,0x20
ffffffffc0202490:	8a2a                	mv	s4,a0
ffffffffc0202492:	842e                	mv	s0,a1
ffffffffc0202494:	94ae                	add	s1,s1,a1
ffffffffc0202496:	40b68933          	sub	s2,a3,a1
ffffffffc020249a:	0209d993          	srli	s3,s3,0x20
ffffffffc020249e:	6a85                	lui	s5,0x1
ffffffffc02024a0:	4605                	li	a2,1
ffffffffc02024a2:	85a2                	mv	a1,s0
ffffffffc02024a4:	8552                	mv	a0,s4
ffffffffc02024a6:	d83ff0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc02024aa:	008907b3          	add	a5,s2,s0
ffffffffc02024ae:	c505                	beqz	a0,ffffffffc02024d6 <boot_map_segment+0x86>
ffffffffc02024b0:	83b1                	srli	a5,a5,0xc
ffffffffc02024b2:	07aa                	slli	a5,a5,0xa
ffffffffc02024b4:	0137e7b3          	or	a5,a5,s3
ffffffffc02024b8:	0017e793          	ori	a5,a5,1
ffffffffc02024bc:	e11c                	sd	a5,0(a0)
ffffffffc02024be:	9456                	add	s0,s0,s5
ffffffffc02024c0:	fe8490e3          	bne	s1,s0,ffffffffc02024a0 <boot_map_segment+0x50>
ffffffffc02024c4:	70e2                	ld	ra,56(sp)
ffffffffc02024c6:	7442                	ld	s0,48(sp)
ffffffffc02024c8:	74a2                	ld	s1,40(sp)
ffffffffc02024ca:	7902                	ld	s2,32(sp)
ffffffffc02024cc:	69e2                	ld	s3,24(sp)
ffffffffc02024ce:	6a42                	ld	s4,16(sp)
ffffffffc02024d0:	6aa2                	ld	s5,8(sp)
ffffffffc02024d2:	6121                	addi	sp,sp,64
ffffffffc02024d4:	8082                	ret
ffffffffc02024d6:	0000a697          	auipc	a3,0xa
ffffffffc02024da:	23268693          	addi	a3,a3,562 # ffffffffc020c708 <default_pmm_manager+0x178>
ffffffffc02024de:	00009617          	auipc	a2,0x9
ffffffffc02024e2:	5ca60613          	addi	a2,a2,1482 # ffffffffc020baa8 <commands+0x210>
ffffffffc02024e6:	09c00593          	li	a1,156
ffffffffc02024ea:	0000a517          	auipc	a0,0xa
ffffffffc02024ee:	1f650513          	addi	a0,a0,502 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02024f2:	fadfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024f6:	0000a697          	auipc	a3,0xa
ffffffffc02024fa:	1fa68693          	addi	a3,a3,506 # ffffffffc020c6f0 <default_pmm_manager+0x160>
ffffffffc02024fe:	00009617          	auipc	a2,0x9
ffffffffc0202502:	5aa60613          	addi	a2,a2,1450 # ffffffffc020baa8 <commands+0x210>
ffffffffc0202506:	09500593          	li	a1,149
ffffffffc020250a:	0000a517          	auipc	a0,0xa
ffffffffc020250e:	1d650513          	addi	a0,a0,470 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0202512:	f8dfd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202516 <get_page>:
ffffffffc0202516:	1141                	addi	sp,sp,-16
ffffffffc0202518:	e022                	sd	s0,0(sp)
ffffffffc020251a:	8432                	mv	s0,a2
ffffffffc020251c:	4601                	li	a2,0
ffffffffc020251e:	e406                	sd	ra,8(sp)
ffffffffc0202520:	d09ff0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc0202524:	c011                	beqz	s0,ffffffffc0202528 <get_page+0x12>
ffffffffc0202526:	e008                	sd	a0,0(s0)
ffffffffc0202528:	c511                	beqz	a0,ffffffffc0202534 <get_page+0x1e>
ffffffffc020252a:	611c                	ld	a5,0(a0)
ffffffffc020252c:	4501                	li	a0,0
ffffffffc020252e:	0017f713          	andi	a4,a5,1
ffffffffc0202532:	e709                	bnez	a4,ffffffffc020253c <get_page+0x26>
ffffffffc0202534:	60a2                	ld	ra,8(sp)
ffffffffc0202536:	6402                	ld	s0,0(sp)
ffffffffc0202538:	0141                	addi	sp,sp,16
ffffffffc020253a:	8082                	ret
ffffffffc020253c:	078a                	slli	a5,a5,0x2
ffffffffc020253e:	83b1                	srli	a5,a5,0xc
ffffffffc0202540:	00094717          	auipc	a4,0x94
ffffffffc0202544:	36073703          	ld	a4,864(a4) # ffffffffc02968a0 <npage>
ffffffffc0202548:	00e7ff63          	bgeu	a5,a4,ffffffffc0202566 <get_page+0x50>
ffffffffc020254c:	60a2                	ld	ra,8(sp)
ffffffffc020254e:	6402                	ld	s0,0(sp)
ffffffffc0202550:	fff80537          	lui	a0,0xfff80
ffffffffc0202554:	97aa                	add	a5,a5,a0
ffffffffc0202556:	079a                	slli	a5,a5,0x6
ffffffffc0202558:	00094517          	auipc	a0,0x94
ffffffffc020255c:	35053503          	ld	a0,848(a0) # ffffffffc02968a8 <pages>
ffffffffc0202560:	953e                	add	a0,a0,a5
ffffffffc0202562:	0141                	addi	sp,sp,16
ffffffffc0202564:	8082                	ret
ffffffffc0202566:	bd3ff0ef          	jal	ra,ffffffffc0202138 <pa2page.part.0>

ffffffffc020256a <unmap_range>:
ffffffffc020256a:	7159                	addi	sp,sp,-112
ffffffffc020256c:	00c5e7b3          	or	a5,a1,a2
ffffffffc0202570:	f486                	sd	ra,104(sp)
ffffffffc0202572:	f0a2                	sd	s0,96(sp)
ffffffffc0202574:	eca6                	sd	s1,88(sp)
ffffffffc0202576:	e8ca                	sd	s2,80(sp)
ffffffffc0202578:	e4ce                	sd	s3,72(sp)
ffffffffc020257a:	e0d2                	sd	s4,64(sp)
ffffffffc020257c:	fc56                	sd	s5,56(sp)
ffffffffc020257e:	f85a                	sd	s6,48(sp)
ffffffffc0202580:	f45e                	sd	s7,40(sp)
ffffffffc0202582:	f062                	sd	s8,32(sp)
ffffffffc0202584:	ec66                	sd	s9,24(sp)
ffffffffc0202586:	e86a                	sd	s10,16(sp)
ffffffffc0202588:	17d2                	slli	a5,a5,0x34
ffffffffc020258a:	e3ed                	bnez	a5,ffffffffc020266c <unmap_range+0x102>
ffffffffc020258c:	002007b7          	lui	a5,0x200
ffffffffc0202590:	842e                	mv	s0,a1
ffffffffc0202592:	0ef5ed63          	bltu	a1,a5,ffffffffc020268c <unmap_range+0x122>
ffffffffc0202596:	8932                	mv	s2,a2
ffffffffc0202598:	0ec5fa63          	bgeu	a1,a2,ffffffffc020268c <unmap_range+0x122>
ffffffffc020259c:	4785                	li	a5,1
ffffffffc020259e:	07fe                	slli	a5,a5,0x1f
ffffffffc02025a0:	0ec7e663          	bltu	a5,a2,ffffffffc020268c <unmap_range+0x122>
ffffffffc02025a4:	89aa                	mv	s3,a0
ffffffffc02025a6:	6a05                	lui	s4,0x1
ffffffffc02025a8:	00094c97          	auipc	s9,0x94
ffffffffc02025ac:	2f8c8c93          	addi	s9,s9,760 # ffffffffc02968a0 <npage>
ffffffffc02025b0:	00094c17          	auipc	s8,0x94
ffffffffc02025b4:	2f8c0c13          	addi	s8,s8,760 # ffffffffc02968a8 <pages>
ffffffffc02025b8:	fff80bb7          	lui	s7,0xfff80
ffffffffc02025bc:	00094d17          	auipc	s10,0x94
ffffffffc02025c0:	2f4d0d13          	addi	s10,s10,756 # ffffffffc02968b0 <pmm_manager>
ffffffffc02025c4:	00200b37          	lui	s6,0x200
ffffffffc02025c8:	ffe00ab7          	lui	s5,0xffe00
ffffffffc02025cc:	4601                	li	a2,0
ffffffffc02025ce:	85a2                	mv	a1,s0
ffffffffc02025d0:	854e                	mv	a0,s3
ffffffffc02025d2:	c57ff0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc02025d6:	84aa                	mv	s1,a0
ffffffffc02025d8:	cd29                	beqz	a0,ffffffffc0202632 <unmap_range+0xc8>
ffffffffc02025da:	611c                	ld	a5,0(a0)
ffffffffc02025dc:	e395                	bnez	a5,ffffffffc0202600 <unmap_range+0x96>
ffffffffc02025de:	9452                	add	s0,s0,s4
ffffffffc02025e0:	ff2466e3          	bltu	s0,s2,ffffffffc02025cc <unmap_range+0x62>
ffffffffc02025e4:	70a6                	ld	ra,104(sp)
ffffffffc02025e6:	7406                	ld	s0,96(sp)
ffffffffc02025e8:	64e6                	ld	s1,88(sp)
ffffffffc02025ea:	6946                	ld	s2,80(sp)
ffffffffc02025ec:	69a6                	ld	s3,72(sp)
ffffffffc02025ee:	6a06                	ld	s4,64(sp)
ffffffffc02025f0:	7ae2                	ld	s5,56(sp)
ffffffffc02025f2:	7b42                	ld	s6,48(sp)
ffffffffc02025f4:	7ba2                	ld	s7,40(sp)
ffffffffc02025f6:	7c02                	ld	s8,32(sp)
ffffffffc02025f8:	6ce2                	ld	s9,24(sp)
ffffffffc02025fa:	6d42                	ld	s10,16(sp)
ffffffffc02025fc:	6165                	addi	sp,sp,112
ffffffffc02025fe:	8082                	ret
ffffffffc0202600:	0017f713          	andi	a4,a5,1
ffffffffc0202604:	df69                	beqz	a4,ffffffffc02025de <unmap_range+0x74>
ffffffffc0202606:	000cb703          	ld	a4,0(s9)
ffffffffc020260a:	078a                	slli	a5,a5,0x2
ffffffffc020260c:	83b1                	srli	a5,a5,0xc
ffffffffc020260e:	08e7ff63          	bgeu	a5,a4,ffffffffc02026ac <unmap_range+0x142>
ffffffffc0202612:	000c3503          	ld	a0,0(s8)
ffffffffc0202616:	97de                	add	a5,a5,s7
ffffffffc0202618:	079a                	slli	a5,a5,0x6
ffffffffc020261a:	953e                	add	a0,a0,a5
ffffffffc020261c:	411c                	lw	a5,0(a0)
ffffffffc020261e:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202622:	c118                	sw	a4,0(a0)
ffffffffc0202624:	cf11                	beqz	a4,ffffffffc0202640 <unmap_range+0xd6>
ffffffffc0202626:	0004b023          	sd	zero,0(s1)
ffffffffc020262a:	12040073          	sfence.vma	s0
ffffffffc020262e:	9452                	add	s0,s0,s4
ffffffffc0202630:	bf45                	j	ffffffffc02025e0 <unmap_range+0x76>
ffffffffc0202632:	945a                	add	s0,s0,s6
ffffffffc0202634:	01547433          	and	s0,s0,s5
ffffffffc0202638:	d455                	beqz	s0,ffffffffc02025e4 <unmap_range+0x7a>
ffffffffc020263a:	f92469e3          	bltu	s0,s2,ffffffffc02025cc <unmap_range+0x62>
ffffffffc020263e:	b75d                	j	ffffffffc02025e4 <unmap_range+0x7a>
ffffffffc0202640:	100027f3          	csrr	a5,sstatus
ffffffffc0202644:	8b89                	andi	a5,a5,2
ffffffffc0202646:	e799                	bnez	a5,ffffffffc0202654 <unmap_range+0xea>
ffffffffc0202648:	000d3783          	ld	a5,0(s10)
ffffffffc020264c:	4585                	li	a1,1
ffffffffc020264e:	739c                	ld	a5,32(a5)
ffffffffc0202650:	9782                	jalr	a5
ffffffffc0202652:	bfd1                	j	ffffffffc0202626 <unmap_range+0xbc>
ffffffffc0202654:	e42a                	sd	a0,8(sp)
ffffffffc0202656:	e1cfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020265a:	000d3783          	ld	a5,0(s10)
ffffffffc020265e:	6522                	ld	a0,8(sp)
ffffffffc0202660:	4585                	li	a1,1
ffffffffc0202662:	739c                	ld	a5,32(a5)
ffffffffc0202664:	9782                	jalr	a5
ffffffffc0202666:	e06fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020266a:	bf75                	j	ffffffffc0202626 <unmap_range+0xbc>
ffffffffc020266c:	0000a697          	auipc	a3,0xa
ffffffffc0202670:	0ac68693          	addi	a3,a3,172 # ffffffffc020c718 <default_pmm_manager+0x188>
ffffffffc0202674:	00009617          	auipc	a2,0x9
ffffffffc0202678:	43460613          	addi	a2,a2,1076 # ffffffffc020baa8 <commands+0x210>
ffffffffc020267c:	15a00593          	li	a1,346
ffffffffc0202680:	0000a517          	auipc	a0,0xa
ffffffffc0202684:	06050513          	addi	a0,a0,96 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0202688:	e17fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020268c:	0000a697          	auipc	a3,0xa
ffffffffc0202690:	0bc68693          	addi	a3,a3,188 # ffffffffc020c748 <default_pmm_manager+0x1b8>
ffffffffc0202694:	00009617          	auipc	a2,0x9
ffffffffc0202698:	41460613          	addi	a2,a2,1044 # ffffffffc020baa8 <commands+0x210>
ffffffffc020269c:	15b00593          	li	a1,347
ffffffffc02026a0:	0000a517          	auipc	a0,0xa
ffffffffc02026a4:	04050513          	addi	a0,a0,64 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02026a8:	df7fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02026ac:	a8dff0ef          	jal	ra,ffffffffc0202138 <pa2page.part.0>

ffffffffc02026b0 <exit_range>:
ffffffffc02026b0:	7119                	addi	sp,sp,-128
ffffffffc02026b2:	00c5e7b3          	or	a5,a1,a2
ffffffffc02026b6:	fc86                	sd	ra,120(sp)
ffffffffc02026b8:	f8a2                	sd	s0,112(sp)
ffffffffc02026ba:	f4a6                	sd	s1,104(sp)
ffffffffc02026bc:	f0ca                	sd	s2,96(sp)
ffffffffc02026be:	ecce                	sd	s3,88(sp)
ffffffffc02026c0:	e8d2                	sd	s4,80(sp)
ffffffffc02026c2:	e4d6                	sd	s5,72(sp)
ffffffffc02026c4:	e0da                	sd	s6,64(sp)
ffffffffc02026c6:	fc5e                	sd	s7,56(sp)
ffffffffc02026c8:	f862                	sd	s8,48(sp)
ffffffffc02026ca:	f466                	sd	s9,40(sp)
ffffffffc02026cc:	f06a                	sd	s10,32(sp)
ffffffffc02026ce:	ec6e                	sd	s11,24(sp)
ffffffffc02026d0:	17d2                	slli	a5,a5,0x34
ffffffffc02026d2:	20079a63          	bnez	a5,ffffffffc02028e6 <exit_range+0x236>
ffffffffc02026d6:	002007b7          	lui	a5,0x200
ffffffffc02026da:	24f5e463          	bltu	a1,a5,ffffffffc0202922 <exit_range+0x272>
ffffffffc02026de:	8ab2                	mv	s5,a2
ffffffffc02026e0:	24c5f163          	bgeu	a1,a2,ffffffffc0202922 <exit_range+0x272>
ffffffffc02026e4:	4785                	li	a5,1
ffffffffc02026e6:	07fe                	slli	a5,a5,0x1f
ffffffffc02026e8:	22c7ed63          	bltu	a5,a2,ffffffffc0202922 <exit_range+0x272>
ffffffffc02026ec:	c00009b7          	lui	s3,0xc0000
ffffffffc02026f0:	0135f9b3          	and	s3,a1,s3
ffffffffc02026f4:	ffe00937          	lui	s2,0xffe00
ffffffffc02026f8:	400007b7          	lui	a5,0x40000
ffffffffc02026fc:	5cfd                	li	s9,-1
ffffffffc02026fe:	8c2a                	mv	s8,a0
ffffffffc0202700:	0125f933          	and	s2,a1,s2
ffffffffc0202704:	99be                	add	s3,s3,a5
ffffffffc0202706:	00094d17          	auipc	s10,0x94
ffffffffc020270a:	19ad0d13          	addi	s10,s10,410 # ffffffffc02968a0 <npage>
ffffffffc020270e:	00ccdc93          	srli	s9,s9,0xc
ffffffffc0202712:	00094717          	auipc	a4,0x94
ffffffffc0202716:	19670713          	addi	a4,a4,406 # ffffffffc02968a8 <pages>
ffffffffc020271a:	00094d97          	auipc	s11,0x94
ffffffffc020271e:	196d8d93          	addi	s11,s11,406 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202722:	c0000437          	lui	s0,0xc0000
ffffffffc0202726:	944e                	add	s0,s0,s3
ffffffffc0202728:	8079                	srli	s0,s0,0x1e
ffffffffc020272a:	1ff47413          	andi	s0,s0,511
ffffffffc020272e:	040e                	slli	s0,s0,0x3
ffffffffc0202730:	9462                	add	s0,s0,s8
ffffffffc0202732:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202736:	001a7793          	andi	a5,s4,1
ffffffffc020273a:	eb99                	bnez	a5,ffffffffc0202750 <exit_range+0xa0>
ffffffffc020273c:	12098463          	beqz	s3,ffffffffc0202864 <exit_range+0x1b4>
ffffffffc0202740:	400007b7          	lui	a5,0x40000
ffffffffc0202744:	97ce                	add	a5,a5,s3
ffffffffc0202746:	894e                	mv	s2,s3
ffffffffc0202748:	1159fe63          	bgeu	s3,s5,ffffffffc0202864 <exit_range+0x1b4>
ffffffffc020274c:	89be                	mv	s3,a5
ffffffffc020274e:	bfd1                	j	ffffffffc0202722 <exit_range+0x72>
ffffffffc0202750:	000d3783          	ld	a5,0(s10)
ffffffffc0202754:	0a0a                	slli	s4,s4,0x2
ffffffffc0202756:	00ca5a13          	srli	s4,s4,0xc
ffffffffc020275a:	1cfa7263          	bgeu	s4,a5,ffffffffc020291e <exit_range+0x26e>
ffffffffc020275e:	fff80637          	lui	a2,0xfff80
ffffffffc0202762:	9652                	add	a2,a2,s4
ffffffffc0202764:	000806b7          	lui	a3,0x80
ffffffffc0202768:	96b2                	add	a3,a3,a2
ffffffffc020276a:	0196f5b3          	and	a1,a3,s9
ffffffffc020276e:	061a                	slli	a2,a2,0x6
ffffffffc0202770:	06b2                	slli	a3,a3,0xc
ffffffffc0202772:	18f5fa63          	bgeu	a1,a5,ffffffffc0202906 <exit_range+0x256>
ffffffffc0202776:	00094817          	auipc	a6,0x94
ffffffffc020277a:	14280813          	addi	a6,a6,322 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020277e:	00083b03          	ld	s6,0(a6)
ffffffffc0202782:	4b85                	li	s7,1
ffffffffc0202784:	fff80e37          	lui	t3,0xfff80
ffffffffc0202788:	9b36                	add	s6,s6,a3
ffffffffc020278a:	00080337          	lui	t1,0x80
ffffffffc020278e:	6885                	lui	a7,0x1
ffffffffc0202790:	a819                	j	ffffffffc02027a6 <exit_range+0xf6>
ffffffffc0202792:	4b81                	li	s7,0
ffffffffc0202794:	002007b7          	lui	a5,0x200
ffffffffc0202798:	993e                	add	s2,s2,a5
ffffffffc020279a:	08090c63          	beqz	s2,ffffffffc0202832 <exit_range+0x182>
ffffffffc020279e:	09397a63          	bgeu	s2,s3,ffffffffc0202832 <exit_range+0x182>
ffffffffc02027a2:	0f597063          	bgeu	s2,s5,ffffffffc0202882 <exit_range+0x1d2>
ffffffffc02027a6:	01595493          	srli	s1,s2,0x15
ffffffffc02027aa:	1ff4f493          	andi	s1,s1,511
ffffffffc02027ae:	048e                	slli	s1,s1,0x3
ffffffffc02027b0:	94da                	add	s1,s1,s6
ffffffffc02027b2:	609c                	ld	a5,0(s1)
ffffffffc02027b4:	0017f693          	andi	a3,a5,1
ffffffffc02027b8:	dee9                	beqz	a3,ffffffffc0202792 <exit_range+0xe2>
ffffffffc02027ba:	000d3583          	ld	a1,0(s10)
ffffffffc02027be:	078a                	slli	a5,a5,0x2
ffffffffc02027c0:	83b1                	srli	a5,a5,0xc
ffffffffc02027c2:	14b7fe63          	bgeu	a5,a1,ffffffffc020291e <exit_range+0x26e>
ffffffffc02027c6:	97f2                	add	a5,a5,t3
ffffffffc02027c8:	006786b3          	add	a3,a5,t1
ffffffffc02027cc:	0196feb3          	and	t4,a3,s9
ffffffffc02027d0:	00679513          	slli	a0,a5,0x6
ffffffffc02027d4:	06b2                	slli	a3,a3,0xc
ffffffffc02027d6:	12bef863          	bgeu	t4,a1,ffffffffc0202906 <exit_range+0x256>
ffffffffc02027da:	00083783          	ld	a5,0(a6)
ffffffffc02027de:	96be                	add	a3,a3,a5
ffffffffc02027e0:	011685b3          	add	a1,a3,a7
ffffffffc02027e4:	629c                	ld	a5,0(a3)
ffffffffc02027e6:	8b85                	andi	a5,a5,1
ffffffffc02027e8:	f7d5                	bnez	a5,ffffffffc0202794 <exit_range+0xe4>
ffffffffc02027ea:	06a1                	addi	a3,a3,8
ffffffffc02027ec:	fed59ce3          	bne	a1,a3,ffffffffc02027e4 <exit_range+0x134>
ffffffffc02027f0:	631c                	ld	a5,0(a4)
ffffffffc02027f2:	953e                	add	a0,a0,a5
ffffffffc02027f4:	100027f3          	csrr	a5,sstatus
ffffffffc02027f8:	8b89                	andi	a5,a5,2
ffffffffc02027fa:	e7d9                	bnez	a5,ffffffffc0202888 <exit_range+0x1d8>
ffffffffc02027fc:	000db783          	ld	a5,0(s11)
ffffffffc0202800:	4585                	li	a1,1
ffffffffc0202802:	e032                	sd	a2,0(sp)
ffffffffc0202804:	739c                	ld	a5,32(a5)
ffffffffc0202806:	9782                	jalr	a5
ffffffffc0202808:	6602                	ld	a2,0(sp)
ffffffffc020280a:	00094817          	auipc	a6,0x94
ffffffffc020280e:	0ae80813          	addi	a6,a6,174 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202812:	fff80e37          	lui	t3,0xfff80
ffffffffc0202816:	00080337          	lui	t1,0x80
ffffffffc020281a:	6885                	lui	a7,0x1
ffffffffc020281c:	00094717          	auipc	a4,0x94
ffffffffc0202820:	08c70713          	addi	a4,a4,140 # ffffffffc02968a8 <pages>
ffffffffc0202824:	0004b023          	sd	zero,0(s1)
ffffffffc0202828:	002007b7          	lui	a5,0x200
ffffffffc020282c:	993e                	add	s2,s2,a5
ffffffffc020282e:	f60918e3          	bnez	s2,ffffffffc020279e <exit_range+0xee>
ffffffffc0202832:	f00b85e3          	beqz	s7,ffffffffc020273c <exit_range+0x8c>
ffffffffc0202836:	000d3783          	ld	a5,0(s10)
ffffffffc020283a:	0efa7263          	bgeu	s4,a5,ffffffffc020291e <exit_range+0x26e>
ffffffffc020283e:	6308                	ld	a0,0(a4)
ffffffffc0202840:	9532                	add	a0,a0,a2
ffffffffc0202842:	100027f3          	csrr	a5,sstatus
ffffffffc0202846:	8b89                	andi	a5,a5,2
ffffffffc0202848:	efad                	bnez	a5,ffffffffc02028c2 <exit_range+0x212>
ffffffffc020284a:	000db783          	ld	a5,0(s11)
ffffffffc020284e:	4585                	li	a1,1
ffffffffc0202850:	739c                	ld	a5,32(a5)
ffffffffc0202852:	9782                	jalr	a5
ffffffffc0202854:	00094717          	auipc	a4,0x94
ffffffffc0202858:	05470713          	addi	a4,a4,84 # ffffffffc02968a8 <pages>
ffffffffc020285c:	00043023          	sd	zero,0(s0)
ffffffffc0202860:	ee0990e3          	bnez	s3,ffffffffc0202740 <exit_range+0x90>
ffffffffc0202864:	70e6                	ld	ra,120(sp)
ffffffffc0202866:	7446                	ld	s0,112(sp)
ffffffffc0202868:	74a6                	ld	s1,104(sp)
ffffffffc020286a:	7906                	ld	s2,96(sp)
ffffffffc020286c:	69e6                	ld	s3,88(sp)
ffffffffc020286e:	6a46                	ld	s4,80(sp)
ffffffffc0202870:	6aa6                	ld	s5,72(sp)
ffffffffc0202872:	6b06                	ld	s6,64(sp)
ffffffffc0202874:	7be2                	ld	s7,56(sp)
ffffffffc0202876:	7c42                	ld	s8,48(sp)
ffffffffc0202878:	7ca2                	ld	s9,40(sp)
ffffffffc020287a:	7d02                	ld	s10,32(sp)
ffffffffc020287c:	6de2                	ld	s11,24(sp)
ffffffffc020287e:	6109                	addi	sp,sp,128
ffffffffc0202880:	8082                	ret
ffffffffc0202882:	ea0b8fe3          	beqz	s7,ffffffffc0202740 <exit_range+0x90>
ffffffffc0202886:	bf45                	j	ffffffffc0202836 <exit_range+0x186>
ffffffffc0202888:	e032                	sd	a2,0(sp)
ffffffffc020288a:	e42a                	sd	a0,8(sp)
ffffffffc020288c:	be6fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202890:	000db783          	ld	a5,0(s11)
ffffffffc0202894:	6522                	ld	a0,8(sp)
ffffffffc0202896:	4585                	li	a1,1
ffffffffc0202898:	739c                	ld	a5,32(a5)
ffffffffc020289a:	9782                	jalr	a5
ffffffffc020289c:	bd0fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02028a0:	6602                	ld	a2,0(sp)
ffffffffc02028a2:	00094717          	auipc	a4,0x94
ffffffffc02028a6:	00670713          	addi	a4,a4,6 # ffffffffc02968a8 <pages>
ffffffffc02028aa:	6885                	lui	a7,0x1
ffffffffc02028ac:	00080337          	lui	t1,0x80
ffffffffc02028b0:	fff80e37          	lui	t3,0xfff80
ffffffffc02028b4:	00094817          	auipc	a6,0x94
ffffffffc02028b8:	00480813          	addi	a6,a6,4 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02028bc:	0004b023          	sd	zero,0(s1)
ffffffffc02028c0:	b7a5                	j	ffffffffc0202828 <exit_range+0x178>
ffffffffc02028c2:	e02a                	sd	a0,0(sp)
ffffffffc02028c4:	baefe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02028c8:	000db783          	ld	a5,0(s11)
ffffffffc02028cc:	6502                	ld	a0,0(sp)
ffffffffc02028ce:	4585                	li	a1,1
ffffffffc02028d0:	739c                	ld	a5,32(a5)
ffffffffc02028d2:	9782                	jalr	a5
ffffffffc02028d4:	b98fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02028d8:	00094717          	auipc	a4,0x94
ffffffffc02028dc:	fd070713          	addi	a4,a4,-48 # ffffffffc02968a8 <pages>
ffffffffc02028e0:	00043023          	sd	zero,0(s0)
ffffffffc02028e4:	bfb5                	j	ffffffffc0202860 <exit_range+0x1b0>
ffffffffc02028e6:	0000a697          	auipc	a3,0xa
ffffffffc02028ea:	e3268693          	addi	a3,a3,-462 # ffffffffc020c718 <default_pmm_manager+0x188>
ffffffffc02028ee:	00009617          	auipc	a2,0x9
ffffffffc02028f2:	1ba60613          	addi	a2,a2,442 # ffffffffc020baa8 <commands+0x210>
ffffffffc02028f6:	16f00593          	li	a1,367
ffffffffc02028fa:	0000a517          	auipc	a0,0xa
ffffffffc02028fe:	de650513          	addi	a0,a0,-538 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0202902:	b9dfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202906:	0000a617          	auipc	a2,0xa
ffffffffc020290a:	cc260613          	addi	a2,a2,-830 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc020290e:	07100593          	li	a1,113
ffffffffc0202912:	0000a517          	auipc	a0,0xa
ffffffffc0202916:	cde50513          	addi	a0,a0,-802 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc020291a:	b85fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020291e:	81bff0ef          	jal	ra,ffffffffc0202138 <pa2page.part.0>
ffffffffc0202922:	0000a697          	auipc	a3,0xa
ffffffffc0202926:	e2668693          	addi	a3,a3,-474 # ffffffffc020c748 <default_pmm_manager+0x1b8>
ffffffffc020292a:	00009617          	auipc	a2,0x9
ffffffffc020292e:	17e60613          	addi	a2,a2,382 # ffffffffc020baa8 <commands+0x210>
ffffffffc0202932:	17000593          	li	a1,368
ffffffffc0202936:	0000a517          	auipc	a0,0xa
ffffffffc020293a:	daa50513          	addi	a0,a0,-598 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc020293e:	b61fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202942 <page_remove>:
ffffffffc0202942:	7179                	addi	sp,sp,-48
ffffffffc0202944:	4601                	li	a2,0
ffffffffc0202946:	ec26                	sd	s1,24(sp)
ffffffffc0202948:	f406                	sd	ra,40(sp)
ffffffffc020294a:	f022                	sd	s0,32(sp)
ffffffffc020294c:	84ae                	mv	s1,a1
ffffffffc020294e:	8dbff0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc0202952:	c511                	beqz	a0,ffffffffc020295e <page_remove+0x1c>
ffffffffc0202954:	611c                	ld	a5,0(a0)
ffffffffc0202956:	842a                	mv	s0,a0
ffffffffc0202958:	0017f713          	andi	a4,a5,1
ffffffffc020295c:	e711                	bnez	a4,ffffffffc0202968 <page_remove+0x26>
ffffffffc020295e:	70a2                	ld	ra,40(sp)
ffffffffc0202960:	7402                	ld	s0,32(sp)
ffffffffc0202962:	64e2                	ld	s1,24(sp)
ffffffffc0202964:	6145                	addi	sp,sp,48
ffffffffc0202966:	8082                	ret
ffffffffc0202968:	078a                	slli	a5,a5,0x2
ffffffffc020296a:	83b1                	srli	a5,a5,0xc
ffffffffc020296c:	00094717          	auipc	a4,0x94
ffffffffc0202970:	f3473703          	ld	a4,-204(a4) # ffffffffc02968a0 <npage>
ffffffffc0202974:	06e7f363          	bgeu	a5,a4,ffffffffc02029da <page_remove+0x98>
ffffffffc0202978:	fff80537          	lui	a0,0xfff80
ffffffffc020297c:	97aa                	add	a5,a5,a0
ffffffffc020297e:	079a                	slli	a5,a5,0x6
ffffffffc0202980:	00094517          	auipc	a0,0x94
ffffffffc0202984:	f2853503          	ld	a0,-216(a0) # ffffffffc02968a8 <pages>
ffffffffc0202988:	953e                	add	a0,a0,a5
ffffffffc020298a:	411c                	lw	a5,0(a0)
ffffffffc020298c:	fff7871b          	addiw	a4,a5,-1
ffffffffc0202990:	c118                	sw	a4,0(a0)
ffffffffc0202992:	cb11                	beqz	a4,ffffffffc02029a6 <page_remove+0x64>
ffffffffc0202994:	00043023          	sd	zero,0(s0)
ffffffffc0202998:	12048073          	sfence.vma	s1
ffffffffc020299c:	70a2                	ld	ra,40(sp)
ffffffffc020299e:	7402                	ld	s0,32(sp)
ffffffffc02029a0:	64e2                	ld	s1,24(sp)
ffffffffc02029a2:	6145                	addi	sp,sp,48
ffffffffc02029a4:	8082                	ret
ffffffffc02029a6:	100027f3          	csrr	a5,sstatus
ffffffffc02029aa:	8b89                	andi	a5,a5,2
ffffffffc02029ac:	eb89                	bnez	a5,ffffffffc02029be <page_remove+0x7c>
ffffffffc02029ae:	00094797          	auipc	a5,0x94
ffffffffc02029b2:	f027b783          	ld	a5,-254(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02029b6:	739c                	ld	a5,32(a5)
ffffffffc02029b8:	4585                	li	a1,1
ffffffffc02029ba:	9782                	jalr	a5
ffffffffc02029bc:	bfe1                	j	ffffffffc0202994 <page_remove+0x52>
ffffffffc02029be:	e42a                	sd	a0,8(sp)
ffffffffc02029c0:	ab2fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02029c4:	00094797          	auipc	a5,0x94
ffffffffc02029c8:	eec7b783          	ld	a5,-276(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02029cc:	739c                	ld	a5,32(a5)
ffffffffc02029ce:	6522                	ld	a0,8(sp)
ffffffffc02029d0:	4585                	li	a1,1
ffffffffc02029d2:	9782                	jalr	a5
ffffffffc02029d4:	a98fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02029d8:	bf75                	j	ffffffffc0202994 <page_remove+0x52>
ffffffffc02029da:	f5eff0ef          	jal	ra,ffffffffc0202138 <pa2page.part.0>

ffffffffc02029de <page_insert>:
ffffffffc02029de:	7139                	addi	sp,sp,-64
ffffffffc02029e0:	e852                	sd	s4,16(sp)
ffffffffc02029e2:	8a32                	mv	s4,a2
ffffffffc02029e4:	f822                	sd	s0,48(sp)
ffffffffc02029e6:	4605                	li	a2,1
ffffffffc02029e8:	842e                	mv	s0,a1
ffffffffc02029ea:	85d2                	mv	a1,s4
ffffffffc02029ec:	f426                	sd	s1,40(sp)
ffffffffc02029ee:	fc06                	sd	ra,56(sp)
ffffffffc02029f0:	f04a                	sd	s2,32(sp)
ffffffffc02029f2:	ec4e                	sd	s3,24(sp)
ffffffffc02029f4:	e456                	sd	s5,8(sp)
ffffffffc02029f6:	84b6                	mv	s1,a3
ffffffffc02029f8:	831ff0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc02029fc:	c961                	beqz	a0,ffffffffc0202acc <page_insert+0xee>
ffffffffc02029fe:	4014                	lw	a3,0(s0)
ffffffffc0202a00:	611c                	ld	a5,0(a0)
ffffffffc0202a02:	89aa                	mv	s3,a0
ffffffffc0202a04:	0016871b          	addiw	a4,a3,1
ffffffffc0202a08:	c018                	sw	a4,0(s0)
ffffffffc0202a0a:	0017f713          	andi	a4,a5,1
ffffffffc0202a0e:	ef05                	bnez	a4,ffffffffc0202a46 <page_insert+0x68>
ffffffffc0202a10:	00094717          	auipc	a4,0x94
ffffffffc0202a14:	e9873703          	ld	a4,-360(a4) # ffffffffc02968a8 <pages>
ffffffffc0202a18:	8c19                	sub	s0,s0,a4
ffffffffc0202a1a:	000807b7          	lui	a5,0x80
ffffffffc0202a1e:	8419                	srai	s0,s0,0x6
ffffffffc0202a20:	943e                	add	s0,s0,a5
ffffffffc0202a22:	042a                	slli	s0,s0,0xa
ffffffffc0202a24:	8cc1                	or	s1,s1,s0
ffffffffc0202a26:	0014e493          	ori	s1,s1,1
ffffffffc0202a2a:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202a2e:	120a0073          	sfence.vma	s4
ffffffffc0202a32:	4501                	li	a0,0
ffffffffc0202a34:	70e2                	ld	ra,56(sp)
ffffffffc0202a36:	7442                	ld	s0,48(sp)
ffffffffc0202a38:	74a2                	ld	s1,40(sp)
ffffffffc0202a3a:	7902                	ld	s2,32(sp)
ffffffffc0202a3c:	69e2                	ld	s3,24(sp)
ffffffffc0202a3e:	6a42                	ld	s4,16(sp)
ffffffffc0202a40:	6aa2                	ld	s5,8(sp)
ffffffffc0202a42:	6121                	addi	sp,sp,64
ffffffffc0202a44:	8082                	ret
ffffffffc0202a46:	078a                	slli	a5,a5,0x2
ffffffffc0202a48:	83b1                	srli	a5,a5,0xc
ffffffffc0202a4a:	00094717          	auipc	a4,0x94
ffffffffc0202a4e:	e5673703          	ld	a4,-426(a4) # ffffffffc02968a0 <npage>
ffffffffc0202a52:	06e7ff63          	bgeu	a5,a4,ffffffffc0202ad0 <page_insert+0xf2>
ffffffffc0202a56:	00094a97          	auipc	s5,0x94
ffffffffc0202a5a:	e52a8a93          	addi	s5,s5,-430 # ffffffffc02968a8 <pages>
ffffffffc0202a5e:	000ab703          	ld	a4,0(s5)
ffffffffc0202a62:	fff80937          	lui	s2,0xfff80
ffffffffc0202a66:	993e                	add	s2,s2,a5
ffffffffc0202a68:	091a                	slli	s2,s2,0x6
ffffffffc0202a6a:	993a                	add	s2,s2,a4
ffffffffc0202a6c:	01240c63          	beq	s0,s2,ffffffffc0202a84 <page_insert+0xa6>
ffffffffc0202a70:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202a74:	fff7869b          	addiw	a3,a5,-1
ffffffffc0202a78:	00d92023          	sw	a3,0(s2)
ffffffffc0202a7c:	c691                	beqz	a3,ffffffffc0202a88 <page_insert+0xaa>
ffffffffc0202a7e:	120a0073          	sfence.vma	s4
ffffffffc0202a82:	bf59                	j	ffffffffc0202a18 <page_insert+0x3a>
ffffffffc0202a84:	c014                	sw	a3,0(s0)
ffffffffc0202a86:	bf49                	j	ffffffffc0202a18 <page_insert+0x3a>
ffffffffc0202a88:	100027f3          	csrr	a5,sstatus
ffffffffc0202a8c:	8b89                	andi	a5,a5,2
ffffffffc0202a8e:	ef91                	bnez	a5,ffffffffc0202aaa <page_insert+0xcc>
ffffffffc0202a90:	00094797          	auipc	a5,0x94
ffffffffc0202a94:	e207b783          	ld	a5,-480(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202a98:	739c                	ld	a5,32(a5)
ffffffffc0202a9a:	4585                	li	a1,1
ffffffffc0202a9c:	854a                	mv	a0,s2
ffffffffc0202a9e:	9782                	jalr	a5
ffffffffc0202aa0:	000ab703          	ld	a4,0(s5)
ffffffffc0202aa4:	120a0073          	sfence.vma	s4
ffffffffc0202aa8:	bf85                	j	ffffffffc0202a18 <page_insert+0x3a>
ffffffffc0202aaa:	9c8fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202aae:	00094797          	auipc	a5,0x94
ffffffffc0202ab2:	e027b783          	ld	a5,-510(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202ab6:	739c                	ld	a5,32(a5)
ffffffffc0202ab8:	4585                	li	a1,1
ffffffffc0202aba:	854a                	mv	a0,s2
ffffffffc0202abc:	9782                	jalr	a5
ffffffffc0202abe:	9aefe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202ac2:	000ab703          	ld	a4,0(s5)
ffffffffc0202ac6:	120a0073          	sfence.vma	s4
ffffffffc0202aca:	b7b9                	j	ffffffffc0202a18 <page_insert+0x3a>
ffffffffc0202acc:	5571                	li	a0,-4
ffffffffc0202ace:	b79d                	j	ffffffffc0202a34 <page_insert+0x56>
ffffffffc0202ad0:	e68ff0ef          	jal	ra,ffffffffc0202138 <pa2page.part.0>

ffffffffc0202ad4 <pmm_init>:
ffffffffc0202ad4:	0000a797          	auipc	a5,0xa
ffffffffc0202ad8:	abc78793          	addi	a5,a5,-1348 # ffffffffc020c590 <default_pmm_manager>
ffffffffc0202adc:	638c                	ld	a1,0(a5)
ffffffffc0202ade:	7159                	addi	sp,sp,-112
ffffffffc0202ae0:	f85a                	sd	s6,48(sp)
ffffffffc0202ae2:	0000a517          	auipc	a0,0xa
ffffffffc0202ae6:	c7e50513          	addi	a0,a0,-898 # ffffffffc020c760 <default_pmm_manager+0x1d0>
ffffffffc0202aea:	00094b17          	auipc	s6,0x94
ffffffffc0202aee:	dc6b0b13          	addi	s6,s6,-570 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202af2:	f486                	sd	ra,104(sp)
ffffffffc0202af4:	e8ca                	sd	s2,80(sp)
ffffffffc0202af6:	e4ce                	sd	s3,72(sp)
ffffffffc0202af8:	f0a2                	sd	s0,96(sp)
ffffffffc0202afa:	eca6                	sd	s1,88(sp)
ffffffffc0202afc:	e0d2                	sd	s4,64(sp)
ffffffffc0202afe:	fc56                	sd	s5,56(sp)
ffffffffc0202b00:	f45e                	sd	s7,40(sp)
ffffffffc0202b02:	f062                	sd	s8,32(sp)
ffffffffc0202b04:	ec66                	sd	s9,24(sp)
ffffffffc0202b06:	00fb3023          	sd	a5,0(s6)
ffffffffc0202b0a:	e9cfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b0e:	000b3783          	ld	a5,0(s6)
ffffffffc0202b12:	00094997          	auipc	s3,0x94
ffffffffc0202b16:	da698993          	addi	s3,s3,-602 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202b1a:	679c                	ld	a5,8(a5)
ffffffffc0202b1c:	9782                	jalr	a5
ffffffffc0202b1e:	57f5                	li	a5,-3
ffffffffc0202b20:	07fa                	slli	a5,a5,0x1e
ffffffffc0202b22:	00f9b023          	sd	a5,0(s3)
ffffffffc0202b26:	f23fd0ef          	jal	ra,ffffffffc0200a48 <get_memory_base>
ffffffffc0202b2a:	892a                	mv	s2,a0
ffffffffc0202b2c:	f27fd0ef          	jal	ra,ffffffffc0200a52 <get_memory_size>
ffffffffc0202b30:	280502e3          	beqz	a0,ffffffffc02035b4 <pmm_init+0xae0>
ffffffffc0202b34:	84aa                	mv	s1,a0
ffffffffc0202b36:	0000a517          	auipc	a0,0xa
ffffffffc0202b3a:	c6250513          	addi	a0,a0,-926 # ffffffffc020c798 <default_pmm_manager+0x208>
ffffffffc0202b3e:	e68fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b42:	00990433          	add	s0,s2,s1
ffffffffc0202b46:	fff40693          	addi	a3,s0,-1
ffffffffc0202b4a:	864a                	mv	a2,s2
ffffffffc0202b4c:	85a6                	mv	a1,s1
ffffffffc0202b4e:	0000a517          	auipc	a0,0xa
ffffffffc0202b52:	c6250513          	addi	a0,a0,-926 # ffffffffc020c7b0 <default_pmm_manager+0x220>
ffffffffc0202b56:	e50fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b5a:	c8000737          	lui	a4,0xc8000
ffffffffc0202b5e:	87a2                	mv	a5,s0
ffffffffc0202b60:	5e876e63          	bltu	a4,s0,ffffffffc020315c <pmm_init+0x688>
ffffffffc0202b64:	757d                	lui	a0,0xfffff
ffffffffc0202b66:	00095617          	auipc	a2,0x95
ffffffffc0202b6a:	da960613          	addi	a2,a2,-599 # ffffffffc029790f <end+0xfff>
ffffffffc0202b6e:	8e69                	and	a2,a2,a0
ffffffffc0202b70:	00094497          	auipc	s1,0x94
ffffffffc0202b74:	d3048493          	addi	s1,s1,-720 # ffffffffc02968a0 <npage>
ffffffffc0202b78:	00c7d513          	srli	a0,a5,0xc
ffffffffc0202b7c:	00094b97          	auipc	s7,0x94
ffffffffc0202b80:	d2cb8b93          	addi	s7,s7,-724 # ffffffffc02968a8 <pages>
ffffffffc0202b84:	e088                	sd	a0,0(s1)
ffffffffc0202b86:	00cbb023          	sd	a2,0(s7)
ffffffffc0202b8a:	000807b7          	lui	a5,0x80
ffffffffc0202b8e:	86b2                	mv	a3,a2
ffffffffc0202b90:	02f50863          	beq	a0,a5,ffffffffc0202bc0 <pmm_init+0xec>
ffffffffc0202b94:	4781                	li	a5,0
ffffffffc0202b96:	4585                	li	a1,1
ffffffffc0202b98:	fff806b7          	lui	a3,0xfff80
ffffffffc0202b9c:	00679513          	slli	a0,a5,0x6
ffffffffc0202ba0:	9532                	add	a0,a0,a2
ffffffffc0202ba2:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd686f8>
ffffffffc0202ba6:	40b7302f          	amoor.d	zero,a1,(a4)
ffffffffc0202baa:	6088                	ld	a0,0(s1)
ffffffffc0202bac:	0785                	addi	a5,a5,1
ffffffffc0202bae:	000bb603          	ld	a2,0(s7)
ffffffffc0202bb2:	00d50733          	add	a4,a0,a3
ffffffffc0202bb6:	fee7e3e3          	bltu	a5,a4,ffffffffc0202b9c <pmm_init+0xc8>
ffffffffc0202bba:	071a                	slli	a4,a4,0x6
ffffffffc0202bbc:	00e606b3          	add	a3,a2,a4
ffffffffc0202bc0:	c02007b7          	lui	a5,0xc0200
ffffffffc0202bc4:	3af6eae3          	bltu	a3,a5,ffffffffc0203778 <pmm_init+0xca4>
ffffffffc0202bc8:	0009b583          	ld	a1,0(s3)
ffffffffc0202bcc:	77fd                	lui	a5,0xfffff
ffffffffc0202bce:	8c7d                	and	s0,s0,a5
ffffffffc0202bd0:	8e8d                	sub	a3,a3,a1
ffffffffc0202bd2:	5e86e363          	bltu	a3,s0,ffffffffc02031b8 <pmm_init+0x6e4>
ffffffffc0202bd6:	0000a517          	auipc	a0,0xa
ffffffffc0202bda:	c0250513          	addi	a0,a0,-1022 # ffffffffc020c7d8 <default_pmm_manager+0x248>
ffffffffc0202bde:	dc8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202be2:	000b3783          	ld	a5,0(s6)
ffffffffc0202be6:	7b9c                	ld	a5,48(a5)
ffffffffc0202be8:	9782                	jalr	a5
ffffffffc0202bea:	0000a517          	auipc	a0,0xa
ffffffffc0202bee:	c0650513          	addi	a0,a0,-1018 # ffffffffc020c7f0 <default_pmm_manager+0x260>
ffffffffc0202bf2:	db4fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bf6:	100027f3          	csrr	a5,sstatus
ffffffffc0202bfa:	8b89                	andi	a5,a5,2
ffffffffc0202bfc:	5a079363          	bnez	a5,ffffffffc02031a2 <pmm_init+0x6ce>
ffffffffc0202c00:	000b3783          	ld	a5,0(s6)
ffffffffc0202c04:	4505                	li	a0,1
ffffffffc0202c06:	6f9c                	ld	a5,24(a5)
ffffffffc0202c08:	9782                	jalr	a5
ffffffffc0202c0a:	842a                	mv	s0,a0
ffffffffc0202c0c:	180408e3          	beqz	s0,ffffffffc020359c <pmm_init+0xac8>
ffffffffc0202c10:	000bb683          	ld	a3,0(s7)
ffffffffc0202c14:	5a7d                	li	s4,-1
ffffffffc0202c16:	6098                	ld	a4,0(s1)
ffffffffc0202c18:	40d406b3          	sub	a3,s0,a3
ffffffffc0202c1c:	8699                	srai	a3,a3,0x6
ffffffffc0202c1e:	00080437          	lui	s0,0x80
ffffffffc0202c22:	96a2                	add	a3,a3,s0
ffffffffc0202c24:	00ca5793          	srli	a5,s4,0xc
ffffffffc0202c28:	8ff5                	and	a5,a5,a3
ffffffffc0202c2a:	06b2                	slli	a3,a3,0xc
ffffffffc0202c2c:	30e7fde3          	bgeu	a5,a4,ffffffffc0203746 <pmm_init+0xc72>
ffffffffc0202c30:	0009b403          	ld	s0,0(s3)
ffffffffc0202c34:	6605                	lui	a2,0x1
ffffffffc0202c36:	4581                	li	a1,0
ffffffffc0202c38:	9436                	add	s0,s0,a3
ffffffffc0202c3a:	8522                	mv	a0,s0
ffffffffc0202c3c:	18b080ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0202c40:	0009b683          	ld	a3,0(s3)
ffffffffc0202c44:	77fd                	lui	a5,0xfffff
ffffffffc0202c46:	0000a917          	auipc	s2,0xa
ffffffffc0202c4a:	9e990913          	addi	s2,s2,-1559 # ffffffffc020c62f <default_pmm_manager+0x9f>
ffffffffc0202c4e:	00f97933          	and	s2,s2,a5
ffffffffc0202c52:	c0200ab7          	lui	s5,0xc0200
ffffffffc0202c56:	3fe00637          	lui	a2,0x3fe00
ffffffffc0202c5a:	964a                	add	a2,a2,s2
ffffffffc0202c5c:	4729                	li	a4,10
ffffffffc0202c5e:	40da86b3          	sub	a3,s5,a3
ffffffffc0202c62:	c02005b7          	lui	a1,0xc0200
ffffffffc0202c66:	8522                	mv	a0,s0
ffffffffc0202c68:	fe8ff0ef          	jal	ra,ffffffffc0202450 <boot_map_segment>
ffffffffc0202c6c:	c8000637          	lui	a2,0xc8000
ffffffffc0202c70:	41260633          	sub	a2,a2,s2
ffffffffc0202c74:	3f596ce3          	bltu	s2,s5,ffffffffc020386c <pmm_init+0xd98>
ffffffffc0202c78:	0009b683          	ld	a3,0(s3)
ffffffffc0202c7c:	85ca                	mv	a1,s2
ffffffffc0202c7e:	4719                	li	a4,6
ffffffffc0202c80:	40d906b3          	sub	a3,s2,a3
ffffffffc0202c84:	8522                	mv	a0,s0
ffffffffc0202c86:	00094917          	auipc	s2,0x94
ffffffffc0202c8a:	c1290913          	addi	s2,s2,-1006 # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0202c8e:	fc2ff0ef          	jal	ra,ffffffffc0202450 <boot_map_segment>
ffffffffc0202c92:	00893023          	sd	s0,0(s2)
ffffffffc0202c96:	2d5464e3          	bltu	s0,s5,ffffffffc020375e <pmm_init+0xc8a>
ffffffffc0202c9a:	0009b783          	ld	a5,0(s3)
ffffffffc0202c9e:	1a7e                	slli	s4,s4,0x3f
ffffffffc0202ca0:	8c1d                	sub	s0,s0,a5
ffffffffc0202ca2:	00c45793          	srli	a5,s0,0xc
ffffffffc0202ca6:	00094717          	auipc	a4,0x94
ffffffffc0202caa:	be873523          	sd	s0,-1046(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0202cae:	0147ea33          	or	s4,a5,s4
ffffffffc0202cb2:	180a1073          	csrw	satp,s4
ffffffffc0202cb6:	12000073          	sfence.vma
ffffffffc0202cba:	0000a517          	auipc	a0,0xa
ffffffffc0202cbe:	b7650513          	addi	a0,a0,-1162 # ffffffffc020c830 <default_pmm_manager+0x2a0>
ffffffffc0202cc2:	ce4fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202cc6:	0000e717          	auipc	a4,0xe
ffffffffc0202cca:	33a70713          	addi	a4,a4,826 # ffffffffc0211000 <bootstack>
ffffffffc0202cce:	0000e797          	auipc	a5,0xe
ffffffffc0202cd2:	33278793          	addi	a5,a5,818 # ffffffffc0211000 <bootstack>
ffffffffc0202cd6:	5cf70d63          	beq	a4,a5,ffffffffc02032b0 <pmm_init+0x7dc>
ffffffffc0202cda:	100027f3          	csrr	a5,sstatus
ffffffffc0202cde:	8b89                	andi	a5,a5,2
ffffffffc0202ce0:	4a079763          	bnez	a5,ffffffffc020318e <pmm_init+0x6ba>
ffffffffc0202ce4:	000b3783          	ld	a5,0(s6)
ffffffffc0202ce8:	779c                	ld	a5,40(a5)
ffffffffc0202cea:	9782                	jalr	a5
ffffffffc0202cec:	842a                	mv	s0,a0
ffffffffc0202cee:	6098                	ld	a4,0(s1)
ffffffffc0202cf0:	c80007b7          	lui	a5,0xc8000
ffffffffc0202cf4:	83b1                	srli	a5,a5,0xc
ffffffffc0202cf6:	08e7e3e3          	bltu	a5,a4,ffffffffc020357c <pmm_init+0xaa8>
ffffffffc0202cfa:	00093503          	ld	a0,0(s2)
ffffffffc0202cfe:	04050fe3          	beqz	a0,ffffffffc020355c <pmm_init+0xa88>
ffffffffc0202d02:	03451793          	slli	a5,a0,0x34
ffffffffc0202d06:	04079be3          	bnez	a5,ffffffffc020355c <pmm_init+0xa88>
ffffffffc0202d0a:	4601                	li	a2,0
ffffffffc0202d0c:	4581                	li	a1,0
ffffffffc0202d0e:	809ff0ef          	jal	ra,ffffffffc0202516 <get_page>
ffffffffc0202d12:	2e0511e3          	bnez	a0,ffffffffc02037f4 <pmm_init+0xd20>
ffffffffc0202d16:	100027f3          	csrr	a5,sstatus
ffffffffc0202d1a:	8b89                	andi	a5,a5,2
ffffffffc0202d1c:	44079e63          	bnez	a5,ffffffffc0203178 <pmm_init+0x6a4>
ffffffffc0202d20:	000b3783          	ld	a5,0(s6)
ffffffffc0202d24:	4505                	li	a0,1
ffffffffc0202d26:	6f9c                	ld	a5,24(a5)
ffffffffc0202d28:	9782                	jalr	a5
ffffffffc0202d2a:	8a2a                	mv	s4,a0
ffffffffc0202d2c:	00093503          	ld	a0,0(s2)
ffffffffc0202d30:	4681                	li	a3,0
ffffffffc0202d32:	4601                	li	a2,0
ffffffffc0202d34:	85d2                	mv	a1,s4
ffffffffc0202d36:	ca9ff0ef          	jal	ra,ffffffffc02029de <page_insert>
ffffffffc0202d3a:	26051be3          	bnez	a0,ffffffffc02037b0 <pmm_init+0xcdc>
ffffffffc0202d3e:	00093503          	ld	a0,0(s2)
ffffffffc0202d42:	4601                	li	a2,0
ffffffffc0202d44:	4581                	li	a1,0
ffffffffc0202d46:	ce2ff0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc0202d4a:	280505e3          	beqz	a0,ffffffffc02037d4 <pmm_init+0xd00>
ffffffffc0202d4e:	611c                	ld	a5,0(a0)
ffffffffc0202d50:	0017f713          	andi	a4,a5,1
ffffffffc0202d54:	26070ee3          	beqz	a4,ffffffffc02037d0 <pmm_init+0xcfc>
ffffffffc0202d58:	6098                	ld	a4,0(s1)
ffffffffc0202d5a:	078a                	slli	a5,a5,0x2
ffffffffc0202d5c:	83b1                	srli	a5,a5,0xc
ffffffffc0202d5e:	62e7f363          	bgeu	a5,a4,ffffffffc0203384 <pmm_init+0x8b0>
ffffffffc0202d62:	000bb683          	ld	a3,0(s7)
ffffffffc0202d66:	fff80637          	lui	a2,0xfff80
ffffffffc0202d6a:	97b2                	add	a5,a5,a2
ffffffffc0202d6c:	079a                	slli	a5,a5,0x6
ffffffffc0202d6e:	97b6                	add	a5,a5,a3
ffffffffc0202d70:	2afa12e3          	bne	s4,a5,ffffffffc0203814 <pmm_init+0xd40>
ffffffffc0202d74:	000a2683          	lw	a3,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202d78:	4785                	li	a5,1
ffffffffc0202d7a:	2cf699e3          	bne	a3,a5,ffffffffc020384c <pmm_init+0xd78>
ffffffffc0202d7e:	00093503          	ld	a0,0(s2)
ffffffffc0202d82:	77fd                	lui	a5,0xfffff
ffffffffc0202d84:	6114                	ld	a3,0(a0)
ffffffffc0202d86:	068a                	slli	a3,a3,0x2
ffffffffc0202d88:	8efd                	and	a3,a3,a5
ffffffffc0202d8a:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202d8e:	2ae673e3          	bgeu	a2,a4,ffffffffc0203834 <pmm_init+0xd60>
ffffffffc0202d92:	0009bc03          	ld	s8,0(s3)
ffffffffc0202d96:	96e2                	add	a3,a3,s8
ffffffffc0202d98:	0006ba83          	ld	s5,0(a3) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202d9c:	0a8a                	slli	s5,s5,0x2
ffffffffc0202d9e:	00fafab3          	and	s5,s5,a5
ffffffffc0202da2:	00cad793          	srli	a5,s5,0xc
ffffffffc0202da6:	06e7f3e3          	bgeu	a5,a4,ffffffffc020360c <pmm_init+0xb38>
ffffffffc0202daa:	4601                	li	a2,0
ffffffffc0202dac:	6585                	lui	a1,0x1
ffffffffc0202dae:	9ae2                	add	s5,s5,s8
ffffffffc0202db0:	c78ff0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc0202db4:	0aa1                	addi	s5,s5,8
ffffffffc0202db6:	03551be3          	bne	a0,s5,ffffffffc02035ec <pmm_init+0xb18>
ffffffffc0202dba:	100027f3          	csrr	a5,sstatus
ffffffffc0202dbe:	8b89                	andi	a5,a5,2
ffffffffc0202dc0:	3a079163          	bnez	a5,ffffffffc0203162 <pmm_init+0x68e>
ffffffffc0202dc4:	000b3783          	ld	a5,0(s6)
ffffffffc0202dc8:	4505                	li	a0,1
ffffffffc0202dca:	6f9c                	ld	a5,24(a5)
ffffffffc0202dcc:	9782                	jalr	a5
ffffffffc0202dce:	8c2a                	mv	s8,a0
ffffffffc0202dd0:	00093503          	ld	a0,0(s2)
ffffffffc0202dd4:	46d1                	li	a3,20
ffffffffc0202dd6:	6605                	lui	a2,0x1
ffffffffc0202dd8:	85e2                	mv	a1,s8
ffffffffc0202dda:	c05ff0ef          	jal	ra,ffffffffc02029de <page_insert>
ffffffffc0202dde:	1a0519e3          	bnez	a0,ffffffffc0203790 <pmm_init+0xcbc>
ffffffffc0202de2:	00093503          	ld	a0,0(s2)
ffffffffc0202de6:	4601                	li	a2,0
ffffffffc0202de8:	6585                	lui	a1,0x1
ffffffffc0202dea:	c3eff0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc0202dee:	10050ce3          	beqz	a0,ffffffffc0203706 <pmm_init+0xc32>
ffffffffc0202df2:	611c                	ld	a5,0(a0)
ffffffffc0202df4:	0107f713          	andi	a4,a5,16
ffffffffc0202df8:	0e0707e3          	beqz	a4,ffffffffc02036e6 <pmm_init+0xc12>
ffffffffc0202dfc:	8b91                	andi	a5,a5,4
ffffffffc0202dfe:	0c0784e3          	beqz	a5,ffffffffc02036c6 <pmm_init+0xbf2>
ffffffffc0202e02:	00093503          	ld	a0,0(s2)
ffffffffc0202e06:	611c                	ld	a5,0(a0)
ffffffffc0202e08:	8bc1                	andi	a5,a5,16
ffffffffc0202e0a:	08078ee3          	beqz	a5,ffffffffc02036a6 <pmm_init+0xbd2>
ffffffffc0202e0e:	000c2703          	lw	a4,0(s8)
ffffffffc0202e12:	4785                	li	a5,1
ffffffffc0202e14:	06f719e3          	bne	a4,a5,ffffffffc0203686 <pmm_init+0xbb2>
ffffffffc0202e18:	4681                	li	a3,0
ffffffffc0202e1a:	6605                	lui	a2,0x1
ffffffffc0202e1c:	85d2                	mv	a1,s4
ffffffffc0202e1e:	bc1ff0ef          	jal	ra,ffffffffc02029de <page_insert>
ffffffffc0202e22:	040512e3          	bnez	a0,ffffffffc0203666 <pmm_init+0xb92>
ffffffffc0202e26:	000a2703          	lw	a4,0(s4)
ffffffffc0202e2a:	4789                	li	a5,2
ffffffffc0202e2c:	00f71de3          	bne	a4,a5,ffffffffc0203646 <pmm_init+0xb72>
ffffffffc0202e30:	000c2783          	lw	a5,0(s8)
ffffffffc0202e34:	7e079963          	bnez	a5,ffffffffc0203626 <pmm_init+0xb52>
ffffffffc0202e38:	00093503          	ld	a0,0(s2)
ffffffffc0202e3c:	4601                	li	a2,0
ffffffffc0202e3e:	6585                	lui	a1,0x1
ffffffffc0202e40:	be8ff0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc0202e44:	54050263          	beqz	a0,ffffffffc0203388 <pmm_init+0x8b4>
ffffffffc0202e48:	6118                	ld	a4,0(a0)
ffffffffc0202e4a:	00177793          	andi	a5,a4,1
ffffffffc0202e4e:	180781e3          	beqz	a5,ffffffffc02037d0 <pmm_init+0xcfc>
ffffffffc0202e52:	6094                	ld	a3,0(s1)
ffffffffc0202e54:	00271793          	slli	a5,a4,0x2
ffffffffc0202e58:	83b1                	srli	a5,a5,0xc
ffffffffc0202e5a:	52d7f563          	bgeu	a5,a3,ffffffffc0203384 <pmm_init+0x8b0>
ffffffffc0202e5e:	000bb683          	ld	a3,0(s7)
ffffffffc0202e62:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202e66:	97d6                	add	a5,a5,s5
ffffffffc0202e68:	079a                	slli	a5,a5,0x6
ffffffffc0202e6a:	97b6                	add	a5,a5,a3
ffffffffc0202e6c:	58fa1e63          	bne	s4,a5,ffffffffc0203408 <pmm_init+0x934>
ffffffffc0202e70:	8b41                	andi	a4,a4,16
ffffffffc0202e72:	56071b63          	bnez	a4,ffffffffc02033e8 <pmm_init+0x914>
ffffffffc0202e76:	00093503          	ld	a0,0(s2)
ffffffffc0202e7a:	4581                	li	a1,0
ffffffffc0202e7c:	ac7ff0ef          	jal	ra,ffffffffc0202942 <page_remove>
ffffffffc0202e80:	000a2c83          	lw	s9,0(s4)
ffffffffc0202e84:	4785                	li	a5,1
ffffffffc0202e86:	5cfc9163          	bne	s9,a5,ffffffffc0203448 <pmm_init+0x974>
ffffffffc0202e8a:	000c2783          	lw	a5,0(s8)
ffffffffc0202e8e:	58079d63          	bnez	a5,ffffffffc0203428 <pmm_init+0x954>
ffffffffc0202e92:	00093503          	ld	a0,0(s2)
ffffffffc0202e96:	6585                	lui	a1,0x1
ffffffffc0202e98:	aabff0ef          	jal	ra,ffffffffc0202942 <page_remove>
ffffffffc0202e9c:	000a2783          	lw	a5,0(s4)
ffffffffc0202ea0:	200793e3          	bnez	a5,ffffffffc02038a6 <pmm_init+0xdd2>
ffffffffc0202ea4:	000c2783          	lw	a5,0(s8)
ffffffffc0202ea8:	1c079fe3          	bnez	a5,ffffffffc0203886 <pmm_init+0xdb2>
ffffffffc0202eac:	00093a03          	ld	s4,0(s2)
ffffffffc0202eb0:	608c                	ld	a1,0(s1)
ffffffffc0202eb2:	000a3683          	ld	a3,0(s4)
ffffffffc0202eb6:	068a                	slli	a3,a3,0x2
ffffffffc0202eb8:	82b1                	srli	a3,a3,0xc
ffffffffc0202eba:	4cb6f563          	bgeu	a3,a1,ffffffffc0203384 <pmm_init+0x8b0>
ffffffffc0202ebe:	000bb503          	ld	a0,0(s7)
ffffffffc0202ec2:	96d6                	add	a3,a3,s5
ffffffffc0202ec4:	069a                	slli	a3,a3,0x6
ffffffffc0202ec6:	00d507b3          	add	a5,a0,a3
ffffffffc0202eca:	439c                	lw	a5,0(a5)
ffffffffc0202ecc:	4f979e63          	bne	a5,s9,ffffffffc02033c8 <pmm_init+0x8f4>
ffffffffc0202ed0:	8699                	srai	a3,a3,0x6
ffffffffc0202ed2:	00080637          	lui	a2,0x80
ffffffffc0202ed6:	96b2                	add	a3,a3,a2
ffffffffc0202ed8:	00c69713          	slli	a4,a3,0xc
ffffffffc0202edc:	8331                	srli	a4,a4,0xc
ffffffffc0202ede:	06b2                	slli	a3,a3,0xc
ffffffffc0202ee0:	06b773e3          	bgeu	a4,a1,ffffffffc0203746 <pmm_init+0xc72>
ffffffffc0202ee4:	0009b703          	ld	a4,0(s3)
ffffffffc0202ee8:	96ba                	add	a3,a3,a4
ffffffffc0202eea:	629c                	ld	a5,0(a3)
ffffffffc0202eec:	078a                	slli	a5,a5,0x2
ffffffffc0202eee:	83b1                	srli	a5,a5,0xc
ffffffffc0202ef0:	48b7fa63          	bgeu	a5,a1,ffffffffc0203384 <pmm_init+0x8b0>
ffffffffc0202ef4:	8f91                	sub	a5,a5,a2
ffffffffc0202ef6:	079a                	slli	a5,a5,0x6
ffffffffc0202ef8:	953e                	add	a0,a0,a5
ffffffffc0202efa:	100027f3          	csrr	a5,sstatus
ffffffffc0202efe:	8b89                	andi	a5,a5,2
ffffffffc0202f00:	32079463          	bnez	a5,ffffffffc0203228 <pmm_init+0x754>
ffffffffc0202f04:	000b3783          	ld	a5,0(s6)
ffffffffc0202f08:	4585                	li	a1,1
ffffffffc0202f0a:	739c                	ld	a5,32(a5)
ffffffffc0202f0c:	9782                	jalr	a5
ffffffffc0202f0e:	000a3783          	ld	a5,0(s4)
ffffffffc0202f12:	6098                	ld	a4,0(s1)
ffffffffc0202f14:	078a                	slli	a5,a5,0x2
ffffffffc0202f16:	83b1                	srli	a5,a5,0xc
ffffffffc0202f18:	46e7f663          	bgeu	a5,a4,ffffffffc0203384 <pmm_init+0x8b0>
ffffffffc0202f1c:	000bb503          	ld	a0,0(s7)
ffffffffc0202f20:	fff80737          	lui	a4,0xfff80
ffffffffc0202f24:	97ba                	add	a5,a5,a4
ffffffffc0202f26:	079a                	slli	a5,a5,0x6
ffffffffc0202f28:	953e                	add	a0,a0,a5
ffffffffc0202f2a:	100027f3          	csrr	a5,sstatus
ffffffffc0202f2e:	8b89                	andi	a5,a5,2
ffffffffc0202f30:	2e079063          	bnez	a5,ffffffffc0203210 <pmm_init+0x73c>
ffffffffc0202f34:	000b3783          	ld	a5,0(s6)
ffffffffc0202f38:	4585                	li	a1,1
ffffffffc0202f3a:	739c                	ld	a5,32(a5)
ffffffffc0202f3c:	9782                	jalr	a5
ffffffffc0202f3e:	00093783          	ld	a5,0(s2)
ffffffffc0202f42:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0202f46:	12000073          	sfence.vma
ffffffffc0202f4a:	100027f3          	csrr	a5,sstatus
ffffffffc0202f4e:	8b89                	andi	a5,a5,2
ffffffffc0202f50:	2a079663          	bnez	a5,ffffffffc02031fc <pmm_init+0x728>
ffffffffc0202f54:	000b3783          	ld	a5,0(s6)
ffffffffc0202f58:	779c                	ld	a5,40(a5)
ffffffffc0202f5a:	9782                	jalr	a5
ffffffffc0202f5c:	8a2a                	mv	s4,a0
ffffffffc0202f5e:	7d441463          	bne	s0,s4,ffffffffc0203726 <pmm_init+0xc52>
ffffffffc0202f62:	0000a517          	auipc	a0,0xa
ffffffffc0202f66:	c2650513          	addi	a0,a0,-986 # ffffffffc020cb88 <default_pmm_manager+0x5f8>
ffffffffc0202f6a:	a3cfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202f6e:	100027f3          	csrr	a5,sstatus
ffffffffc0202f72:	8b89                	andi	a5,a5,2
ffffffffc0202f74:	26079a63          	bnez	a5,ffffffffc02031e8 <pmm_init+0x714>
ffffffffc0202f78:	000b3783          	ld	a5,0(s6)
ffffffffc0202f7c:	779c                	ld	a5,40(a5)
ffffffffc0202f7e:	9782                	jalr	a5
ffffffffc0202f80:	8c2a                	mv	s8,a0
ffffffffc0202f82:	6098                	ld	a4,0(s1)
ffffffffc0202f84:	c0200437          	lui	s0,0xc0200
ffffffffc0202f88:	7afd                	lui	s5,0xfffff
ffffffffc0202f8a:	00c71793          	slli	a5,a4,0xc
ffffffffc0202f8e:	6a05                	lui	s4,0x1
ffffffffc0202f90:	02f47c63          	bgeu	s0,a5,ffffffffc0202fc8 <pmm_init+0x4f4>
ffffffffc0202f94:	00c45793          	srli	a5,s0,0xc
ffffffffc0202f98:	00093503          	ld	a0,0(s2)
ffffffffc0202f9c:	3ae7f763          	bgeu	a5,a4,ffffffffc020334a <pmm_init+0x876>
ffffffffc0202fa0:	0009b583          	ld	a1,0(s3)
ffffffffc0202fa4:	4601                	li	a2,0
ffffffffc0202fa6:	95a2                	add	a1,a1,s0
ffffffffc0202fa8:	a80ff0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc0202fac:	36050f63          	beqz	a0,ffffffffc020332a <pmm_init+0x856>
ffffffffc0202fb0:	611c                	ld	a5,0(a0)
ffffffffc0202fb2:	078a                	slli	a5,a5,0x2
ffffffffc0202fb4:	0157f7b3          	and	a5,a5,s5
ffffffffc0202fb8:	3a879663          	bne	a5,s0,ffffffffc0203364 <pmm_init+0x890>
ffffffffc0202fbc:	6098                	ld	a4,0(s1)
ffffffffc0202fbe:	9452                	add	s0,s0,s4
ffffffffc0202fc0:	00c71793          	slli	a5,a4,0xc
ffffffffc0202fc4:	fcf468e3          	bltu	s0,a5,ffffffffc0202f94 <pmm_init+0x4c0>
ffffffffc0202fc8:	00093783          	ld	a5,0(s2)
ffffffffc0202fcc:	639c                	ld	a5,0(a5)
ffffffffc0202fce:	48079d63          	bnez	a5,ffffffffc0203468 <pmm_init+0x994>
ffffffffc0202fd2:	100027f3          	csrr	a5,sstatus
ffffffffc0202fd6:	8b89                	andi	a5,a5,2
ffffffffc0202fd8:	26079463          	bnez	a5,ffffffffc0203240 <pmm_init+0x76c>
ffffffffc0202fdc:	000b3783          	ld	a5,0(s6)
ffffffffc0202fe0:	4505                	li	a0,1
ffffffffc0202fe2:	6f9c                	ld	a5,24(a5)
ffffffffc0202fe4:	9782                	jalr	a5
ffffffffc0202fe6:	8a2a                	mv	s4,a0
ffffffffc0202fe8:	00093503          	ld	a0,0(s2)
ffffffffc0202fec:	4699                	li	a3,6
ffffffffc0202fee:	10000613          	li	a2,256
ffffffffc0202ff2:	85d2                	mv	a1,s4
ffffffffc0202ff4:	9ebff0ef          	jal	ra,ffffffffc02029de <page_insert>
ffffffffc0202ff8:	4a051863          	bnez	a0,ffffffffc02034a8 <pmm_init+0x9d4>
ffffffffc0202ffc:	000a2703          	lw	a4,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0203000:	4785                	li	a5,1
ffffffffc0203002:	48f71363          	bne	a4,a5,ffffffffc0203488 <pmm_init+0x9b4>
ffffffffc0203006:	00093503          	ld	a0,0(s2)
ffffffffc020300a:	6405                	lui	s0,0x1
ffffffffc020300c:	4699                	li	a3,6
ffffffffc020300e:	10040613          	addi	a2,s0,256 # 1100 <_binary_bin_swap_img_size-0x6c00>
ffffffffc0203012:	85d2                	mv	a1,s4
ffffffffc0203014:	9cbff0ef          	jal	ra,ffffffffc02029de <page_insert>
ffffffffc0203018:	38051863          	bnez	a0,ffffffffc02033a8 <pmm_init+0x8d4>
ffffffffc020301c:	000a2703          	lw	a4,0(s4)
ffffffffc0203020:	4789                	li	a5,2
ffffffffc0203022:	4ef71363          	bne	a4,a5,ffffffffc0203508 <pmm_init+0xa34>
ffffffffc0203026:	0000a597          	auipc	a1,0xa
ffffffffc020302a:	caa58593          	addi	a1,a1,-854 # ffffffffc020ccd0 <default_pmm_manager+0x740>
ffffffffc020302e:	10000513          	li	a0,256
ffffffffc0203032:	528080ef          	jal	ra,ffffffffc020b55a <strcpy>
ffffffffc0203036:	10040593          	addi	a1,s0,256
ffffffffc020303a:	10000513          	li	a0,256
ffffffffc020303e:	52e080ef          	jal	ra,ffffffffc020b56c <strcmp>
ffffffffc0203042:	4a051363          	bnez	a0,ffffffffc02034e8 <pmm_init+0xa14>
ffffffffc0203046:	000bb683          	ld	a3,0(s7)
ffffffffc020304a:	00080737          	lui	a4,0x80
ffffffffc020304e:	547d                	li	s0,-1
ffffffffc0203050:	40da06b3          	sub	a3,s4,a3
ffffffffc0203054:	8699                	srai	a3,a3,0x6
ffffffffc0203056:	609c                	ld	a5,0(s1)
ffffffffc0203058:	96ba                	add	a3,a3,a4
ffffffffc020305a:	8031                	srli	s0,s0,0xc
ffffffffc020305c:	0086f733          	and	a4,a3,s0
ffffffffc0203060:	06b2                	slli	a3,a3,0xc
ffffffffc0203062:	6ef77263          	bgeu	a4,a5,ffffffffc0203746 <pmm_init+0xc72>
ffffffffc0203066:	0009b783          	ld	a5,0(s3)
ffffffffc020306a:	10000513          	li	a0,256
ffffffffc020306e:	96be                	add	a3,a3,a5
ffffffffc0203070:	10068023          	sb	zero,256(a3)
ffffffffc0203074:	4b0080ef          	jal	ra,ffffffffc020b524 <strlen>
ffffffffc0203078:	44051863          	bnez	a0,ffffffffc02034c8 <pmm_init+0x9f4>
ffffffffc020307c:	00093a83          	ld	s5,0(s2)
ffffffffc0203080:	609c                	ld	a5,0(s1)
ffffffffc0203082:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0203086:	068a                	slli	a3,a3,0x2
ffffffffc0203088:	82b1                	srli	a3,a3,0xc
ffffffffc020308a:	2ef6fd63          	bgeu	a3,a5,ffffffffc0203384 <pmm_init+0x8b0>
ffffffffc020308e:	8c75                	and	s0,s0,a3
ffffffffc0203090:	06b2                	slli	a3,a3,0xc
ffffffffc0203092:	6af47a63          	bgeu	s0,a5,ffffffffc0203746 <pmm_init+0xc72>
ffffffffc0203096:	0009b403          	ld	s0,0(s3)
ffffffffc020309a:	9436                	add	s0,s0,a3
ffffffffc020309c:	100027f3          	csrr	a5,sstatus
ffffffffc02030a0:	8b89                	andi	a5,a5,2
ffffffffc02030a2:	1e079c63          	bnez	a5,ffffffffc020329a <pmm_init+0x7c6>
ffffffffc02030a6:	000b3783          	ld	a5,0(s6)
ffffffffc02030aa:	4585                	li	a1,1
ffffffffc02030ac:	8552                	mv	a0,s4
ffffffffc02030ae:	739c                	ld	a5,32(a5)
ffffffffc02030b0:	9782                	jalr	a5
ffffffffc02030b2:	601c                	ld	a5,0(s0)
ffffffffc02030b4:	6098                	ld	a4,0(s1)
ffffffffc02030b6:	078a                	slli	a5,a5,0x2
ffffffffc02030b8:	83b1                	srli	a5,a5,0xc
ffffffffc02030ba:	2ce7f563          	bgeu	a5,a4,ffffffffc0203384 <pmm_init+0x8b0>
ffffffffc02030be:	000bb503          	ld	a0,0(s7)
ffffffffc02030c2:	fff80737          	lui	a4,0xfff80
ffffffffc02030c6:	97ba                	add	a5,a5,a4
ffffffffc02030c8:	079a                	slli	a5,a5,0x6
ffffffffc02030ca:	953e                	add	a0,a0,a5
ffffffffc02030cc:	100027f3          	csrr	a5,sstatus
ffffffffc02030d0:	8b89                	andi	a5,a5,2
ffffffffc02030d2:	1a079863          	bnez	a5,ffffffffc0203282 <pmm_init+0x7ae>
ffffffffc02030d6:	000b3783          	ld	a5,0(s6)
ffffffffc02030da:	4585                	li	a1,1
ffffffffc02030dc:	739c                	ld	a5,32(a5)
ffffffffc02030de:	9782                	jalr	a5
ffffffffc02030e0:	000ab783          	ld	a5,0(s5)
ffffffffc02030e4:	6098                	ld	a4,0(s1)
ffffffffc02030e6:	078a                	slli	a5,a5,0x2
ffffffffc02030e8:	83b1                	srli	a5,a5,0xc
ffffffffc02030ea:	28e7fd63          	bgeu	a5,a4,ffffffffc0203384 <pmm_init+0x8b0>
ffffffffc02030ee:	000bb503          	ld	a0,0(s7)
ffffffffc02030f2:	fff80737          	lui	a4,0xfff80
ffffffffc02030f6:	97ba                	add	a5,a5,a4
ffffffffc02030f8:	079a                	slli	a5,a5,0x6
ffffffffc02030fa:	953e                	add	a0,a0,a5
ffffffffc02030fc:	100027f3          	csrr	a5,sstatus
ffffffffc0203100:	8b89                	andi	a5,a5,2
ffffffffc0203102:	16079463          	bnez	a5,ffffffffc020326a <pmm_init+0x796>
ffffffffc0203106:	000b3783          	ld	a5,0(s6)
ffffffffc020310a:	4585                	li	a1,1
ffffffffc020310c:	739c                	ld	a5,32(a5)
ffffffffc020310e:	9782                	jalr	a5
ffffffffc0203110:	00093783          	ld	a5,0(s2)
ffffffffc0203114:	0007b023          	sd	zero,0(a5)
ffffffffc0203118:	12000073          	sfence.vma
ffffffffc020311c:	100027f3          	csrr	a5,sstatus
ffffffffc0203120:	8b89                	andi	a5,a5,2
ffffffffc0203122:	12079a63          	bnez	a5,ffffffffc0203256 <pmm_init+0x782>
ffffffffc0203126:	000b3783          	ld	a5,0(s6)
ffffffffc020312a:	779c                	ld	a5,40(a5)
ffffffffc020312c:	9782                	jalr	a5
ffffffffc020312e:	842a                	mv	s0,a0
ffffffffc0203130:	488c1e63          	bne	s8,s0,ffffffffc02035cc <pmm_init+0xaf8>
ffffffffc0203134:	0000a517          	auipc	a0,0xa
ffffffffc0203138:	c1450513          	addi	a0,a0,-1004 # ffffffffc020cd48 <default_pmm_manager+0x7b8>
ffffffffc020313c:	86afd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203140:	7406                	ld	s0,96(sp)
ffffffffc0203142:	70a6                	ld	ra,104(sp)
ffffffffc0203144:	64e6                	ld	s1,88(sp)
ffffffffc0203146:	6946                	ld	s2,80(sp)
ffffffffc0203148:	69a6                	ld	s3,72(sp)
ffffffffc020314a:	6a06                	ld	s4,64(sp)
ffffffffc020314c:	7ae2                	ld	s5,56(sp)
ffffffffc020314e:	7b42                	ld	s6,48(sp)
ffffffffc0203150:	7ba2                	ld	s7,40(sp)
ffffffffc0203152:	7c02                	ld	s8,32(sp)
ffffffffc0203154:	6ce2                	ld	s9,24(sp)
ffffffffc0203156:	6165                	addi	sp,sp,112
ffffffffc0203158:	e17fe06f          	j	ffffffffc0201f6e <kmalloc_init>
ffffffffc020315c:	c80007b7          	lui	a5,0xc8000
ffffffffc0203160:	b411                	j	ffffffffc0202b64 <pmm_init+0x90>
ffffffffc0203162:	b11fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203166:	000b3783          	ld	a5,0(s6)
ffffffffc020316a:	4505                	li	a0,1
ffffffffc020316c:	6f9c                	ld	a5,24(a5)
ffffffffc020316e:	9782                	jalr	a5
ffffffffc0203170:	8c2a                	mv	s8,a0
ffffffffc0203172:	afbfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203176:	b9a9                	j	ffffffffc0202dd0 <pmm_init+0x2fc>
ffffffffc0203178:	afbfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020317c:	000b3783          	ld	a5,0(s6)
ffffffffc0203180:	4505                	li	a0,1
ffffffffc0203182:	6f9c                	ld	a5,24(a5)
ffffffffc0203184:	9782                	jalr	a5
ffffffffc0203186:	8a2a                	mv	s4,a0
ffffffffc0203188:	ae5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020318c:	b645                	j	ffffffffc0202d2c <pmm_init+0x258>
ffffffffc020318e:	ae5fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203192:	000b3783          	ld	a5,0(s6)
ffffffffc0203196:	779c                	ld	a5,40(a5)
ffffffffc0203198:	9782                	jalr	a5
ffffffffc020319a:	842a                	mv	s0,a0
ffffffffc020319c:	ad1fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031a0:	b6b9                	j	ffffffffc0202cee <pmm_init+0x21a>
ffffffffc02031a2:	ad1fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031a6:	000b3783          	ld	a5,0(s6)
ffffffffc02031aa:	4505                	li	a0,1
ffffffffc02031ac:	6f9c                	ld	a5,24(a5)
ffffffffc02031ae:	9782                	jalr	a5
ffffffffc02031b0:	842a                	mv	s0,a0
ffffffffc02031b2:	abbfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031b6:	bc99                	j	ffffffffc0202c0c <pmm_init+0x138>
ffffffffc02031b8:	6705                	lui	a4,0x1
ffffffffc02031ba:	177d                	addi	a4,a4,-1
ffffffffc02031bc:	96ba                	add	a3,a3,a4
ffffffffc02031be:	8ff5                	and	a5,a5,a3
ffffffffc02031c0:	00c7d713          	srli	a4,a5,0xc
ffffffffc02031c4:	1ca77063          	bgeu	a4,a0,ffffffffc0203384 <pmm_init+0x8b0>
ffffffffc02031c8:	000b3683          	ld	a3,0(s6)
ffffffffc02031cc:	fff80537          	lui	a0,0xfff80
ffffffffc02031d0:	972a                	add	a4,a4,a0
ffffffffc02031d2:	6a94                	ld	a3,16(a3)
ffffffffc02031d4:	8c1d                	sub	s0,s0,a5
ffffffffc02031d6:	00671513          	slli	a0,a4,0x6
ffffffffc02031da:	00c45593          	srli	a1,s0,0xc
ffffffffc02031de:	9532                	add	a0,a0,a2
ffffffffc02031e0:	9682                	jalr	a3
ffffffffc02031e2:	0009b583          	ld	a1,0(s3)
ffffffffc02031e6:	bac5                	j	ffffffffc0202bd6 <pmm_init+0x102>
ffffffffc02031e8:	a8bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031ec:	000b3783          	ld	a5,0(s6)
ffffffffc02031f0:	779c                	ld	a5,40(a5)
ffffffffc02031f2:	9782                	jalr	a5
ffffffffc02031f4:	8c2a                	mv	s8,a0
ffffffffc02031f6:	a77fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031fa:	b361                	j	ffffffffc0202f82 <pmm_init+0x4ae>
ffffffffc02031fc:	a77fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203200:	000b3783          	ld	a5,0(s6)
ffffffffc0203204:	779c                	ld	a5,40(a5)
ffffffffc0203206:	9782                	jalr	a5
ffffffffc0203208:	8a2a                	mv	s4,a0
ffffffffc020320a:	a63fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020320e:	bb81                	j	ffffffffc0202f5e <pmm_init+0x48a>
ffffffffc0203210:	e42a                	sd	a0,8(sp)
ffffffffc0203212:	a61fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203216:	000b3783          	ld	a5,0(s6)
ffffffffc020321a:	6522                	ld	a0,8(sp)
ffffffffc020321c:	4585                	li	a1,1
ffffffffc020321e:	739c                	ld	a5,32(a5)
ffffffffc0203220:	9782                	jalr	a5
ffffffffc0203222:	a4bfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203226:	bb21                	j	ffffffffc0202f3e <pmm_init+0x46a>
ffffffffc0203228:	e42a                	sd	a0,8(sp)
ffffffffc020322a:	a49fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020322e:	000b3783          	ld	a5,0(s6)
ffffffffc0203232:	6522                	ld	a0,8(sp)
ffffffffc0203234:	4585                	li	a1,1
ffffffffc0203236:	739c                	ld	a5,32(a5)
ffffffffc0203238:	9782                	jalr	a5
ffffffffc020323a:	a33fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020323e:	b9c1                	j	ffffffffc0202f0e <pmm_init+0x43a>
ffffffffc0203240:	a33fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203244:	000b3783          	ld	a5,0(s6)
ffffffffc0203248:	4505                	li	a0,1
ffffffffc020324a:	6f9c                	ld	a5,24(a5)
ffffffffc020324c:	9782                	jalr	a5
ffffffffc020324e:	8a2a                	mv	s4,a0
ffffffffc0203250:	a1dfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203254:	bb51                	j	ffffffffc0202fe8 <pmm_init+0x514>
ffffffffc0203256:	a1dfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020325a:	000b3783          	ld	a5,0(s6)
ffffffffc020325e:	779c                	ld	a5,40(a5)
ffffffffc0203260:	9782                	jalr	a5
ffffffffc0203262:	842a                	mv	s0,a0
ffffffffc0203264:	a09fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203268:	b5e1                	j	ffffffffc0203130 <pmm_init+0x65c>
ffffffffc020326a:	e42a                	sd	a0,8(sp)
ffffffffc020326c:	a07fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203270:	000b3783          	ld	a5,0(s6)
ffffffffc0203274:	6522                	ld	a0,8(sp)
ffffffffc0203276:	4585                	li	a1,1
ffffffffc0203278:	739c                	ld	a5,32(a5)
ffffffffc020327a:	9782                	jalr	a5
ffffffffc020327c:	9f1fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203280:	bd41                	j	ffffffffc0203110 <pmm_init+0x63c>
ffffffffc0203282:	e42a                	sd	a0,8(sp)
ffffffffc0203284:	9effd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203288:	000b3783          	ld	a5,0(s6)
ffffffffc020328c:	6522                	ld	a0,8(sp)
ffffffffc020328e:	4585                	li	a1,1
ffffffffc0203290:	739c                	ld	a5,32(a5)
ffffffffc0203292:	9782                	jalr	a5
ffffffffc0203294:	9d9fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203298:	b5a1                	j	ffffffffc02030e0 <pmm_init+0x60c>
ffffffffc020329a:	9d9fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020329e:	000b3783          	ld	a5,0(s6)
ffffffffc02032a2:	4585                	li	a1,1
ffffffffc02032a4:	8552                	mv	a0,s4
ffffffffc02032a6:	739c                	ld	a5,32(a5)
ffffffffc02032a8:	9782                	jalr	a5
ffffffffc02032aa:	9c3fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032ae:	b511                	j	ffffffffc02030b2 <pmm_init+0x5de>
ffffffffc02032b0:	00010417          	auipc	s0,0x10
ffffffffc02032b4:	d5040413          	addi	s0,s0,-688 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc02032b8:	00010797          	auipc	a5,0x10
ffffffffc02032bc:	d4878793          	addi	a5,a5,-696 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc02032c0:	a0f41de3          	bne	s0,a5,ffffffffc0202cda <pmm_init+0x206>
ffffffffc02032c4:	4581                	li	a1,0
ffffffffc02032c6:	6605                	lui	a2,0x1
ffffffffc02032c8:	8522                	mv	a0,s0
ffffffffc02032ca:	2fc080ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc02032ce:	0000d597          	auipc	a1,0xd
ffffffffc02032d2:	d3258593          	addi	a1,a1,-718 # ffffffffc0210000 <bootstackguard>
ffffffffc02032d6:	0000e797          	auipc	a5,0xe
ffffffffc02032da:	d20784a3          	sb	zero,-727(a5) # ffffffffc0210fff <bootstackguard+0xfff>
ffffffffc02032de:	0000d797          	auipc	a5,0xd
ffffffffc02032e2:	d2078123          	sb	zero,-734(a5) # ffffffffc0210000 <bootstackguard>
ffffffffc02032e6:	00093503          	ld	a0,0(s2)
ffffffffc02032ea:	2555ec63          	bltu	a1,s5,ffffffffc0203542 <pmm_init+0xa6e>
ffffffffc02032ee:	0009b683          	ld	a3,0(s3)
ffffffffc02032f2:	4701                	li	a4,0
ffffffffc02032f4:	6605                	lui	a2,0x1
ffffffffc02032f6:	40d586b3          	sub	a3,a1,a3
ffffffffc02032fa:	956ff0ef          	jal	ra,ffffffffc0202450 <boot_map_segment>
ffffffffc02032fe:	00093503          	ld	a0,0(s2)
ffffffffc0203302:	23546363          	bltu	s0,s5,ffffffffc0203528 <pmm_init+0xa54>
ffffffffc0203306:	0009b683          	ld	a3,0(s3)
ffffffffc020330a:	4701                	li	a4,0
ffffffffc020330c:	6605                	lui	a2,0x1
ffffffffc020330e:	40d406b3          	sub	a3,s0,a3
ffffffffc0203312:	85a2                	mv	a1,s0
ffffffffc0203314:	93cff0ef          	jal	ra,ffffffffc0202450 <boot_map_segment>
ffffffffc0203318:	12000073          	sfence.vma
ffffffffc020331c:	00009517          	auipc	a0,0x9
ffffffffc0203320:	53c50513          	addi	a0,a0,1340 # ffffffffc020c858 <default_pmm_manager+0x2c8>
ffffffffc0203324:	e83fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203328:	ba4d                	j	ffffffffc0202cda <pmm_init+0x206>
ffffffffc020332a:	0000a697          	auipc	a3,0xa
ffffffffc020332e:	87e68693          	addi	a3,a3,-1922 # ffffffffc020cba8 <default_pmm_manager+0x618>
ffffffffc0203332:	00008617          	auipc	a2,0x8
ffffffffc0203336:	77660613          	addi	a2,a2,1910 # ffffffffc020baa8 <commands+0x210>
ffffffffc020333a:	28a00593          	li	a1,650
ffffffffc020333e:	00009517          	auipc	a0,0x9
ffffffffc0203342:	3a250513          	addi	a0,a0,930 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203346:	958fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020334a:	86a2                	mv	a3,s0
ffffffffc020334c:	00009617          	auipc	a2,0x9
ffffffffc0203350:	27c60613          	addi	a2,a2,636 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc0203354:	28a00593          	li	a1,650
ffffffffc0203358:	00009517          	auipc	a0,0x9
ffffffffc020335c:	38850513          	addi	a0,a0,904 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203360:	93efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203364:	0000a697          	auipc	a3,0xa
ffffffffc0203368:	88468693          	addi	a3,a3,-1916 # ffffffffc020cbe8 <default_pmm_manager+0x658>
ffffffffc020336c:	00008617          	auipc	a2,0x8
ffffffffc0203370:	73c60613          	addi	a2,a2,1852 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203374:	28b00593          	li	a1,651
ffffffffc0203378:	00009517          	auipc	a0,0x9
ffffffffc020337c:	36850513          	addi	a0,a0,872 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203380:	91efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203384:	db5fe0ef          	jal	ra,ffffffffc0202138 <pa2page.part.0>
ffffffffc0203388:	00009697          	auipc	a3,0x9
ffffffffc020338c:	68868693          	addi	a3,a3,1672 # ffffffffc020ca10 <default_pmm_manager+0x480>
ffffffffc0203390:	00008617          	auipc	a2,0x8
ffffffffc0203394:	71860613          	addi	a2,a2,1816 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203398:	26700593          	li	a1,615
ffffffffc020339c:	00009517          	auipc	a0,0x9
ffffffffc02033a0:	34450513          	addi	a0,a0,836 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02033a4:	8fafd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033a8:	0000a697          	auipc	a3,0xa
ffffffffc02033ac:	8c868693          	addi	a3,a3,-1848 # ffffffffc020cc70 <default_pmm_manager+0x6e0>
ffffffffc02033b0:	00008617          	auipc	a2,0x8
ffffffffc02033b4:	6f860613          	addi	a2,a2,1784 # ffffffffc020baa8 <commands+0x210>
ffffffffc02033b8:	29400593          	li	a1,660
ffffffffc02033bc:	00009517          	auipc	a0,0x9
ffffffffc02033c0:	32450513          	addi	a0,a0,804 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02033c4:	8dafd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033c8:	00009697          	auipc	a3,0x9
ffffffffc02033cc:	76868693          	addi	a3,a3,1896 # ffffffffc020cb30 <default_pmm_manager+0x5a0>
ffffffffc02033d0:	00008617          	auipc	a2,0x8
ffffffffc02033d4:	6d860613          	addi	a2,a2,1752 # ffffffffc020baa8 <commands+0x210>
ffffffffc02033d8:	27300593          	li	a1,627
ffffffffc02033dc:	00009517          	auipc	a0,0x9
ffffffffc02033e0:	30450513          	addi	a0,a0,772 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02033e4:	8bafd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033e8:	00009697          	auipc	a3,0x9
ffffffffc02033ec:	71868693          	addi	a3,a3,1816 # ffffffffc020cb00 <default_pmm_manager+0x570>
ffffffffc02033f0:	00008617          	auipc	a2,0x8
ffffffffc02033f4:	6b860613          	addi	a2,a2,1720 # ffffffffc020baa8 <commands+0x210>
ffffffffc02033f8:	26900593          	li	a1,617
ffffffffc02033fc:	00009517          	auipc	a0,0x9
ffffffffc0203400:	2e450513          	addi	a0,a0,740 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203404:	89afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203408:	00009697          	auipc	a3,0x9
ffffffffc020340c:	56868693          	addi	a3,a3,1384 # ffffffffc020c970 <default_pmm_manager+0x3e0>
ffffffffc0203410:	00008617          	auipc	a2,0x8
ffffffffc0203414:	69860613          	addi	a2,a2,1688 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203418:	26800593          	li	a1,616
ffffffffc020341c:	00009517          	auipc	a0,0x9
ffffffffc0203420:	2c450513          	addi	a0,a0,708 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203424:	87afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203428:	00009697          	auipc	a3,0x9
ffffffffc020342c:	6c068693          	addi	a3,a3,1728 # ffffffffc020cae8 <default_pmm_manager+0x558>
ffffffffc0203430:	00008617          	auipc	a2,0x8
ffffffffc0203434:	67860613          	addi	a2,a2,1656 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203438:	26d00593          	li	a1,621
ffffffffc020343c:	00009517          	auipc	a0,0x9
ffffffffc0203440:	2a450513          	addi	a0,a0,676 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203444:	85afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203448:	00009697          	auipc	a3,0x9
ffffffffc020344c:	54068693          	addi	a3,a3,1344 # ffffffffc020c988 <default_pmm_manager+0x3f8>
ffffffffc0203450:	00008617          	auipc	a2,0x8
ffffffffc0203454:	65860613          	addi	a2,a2,1624 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203458:	26c00593          	li	a1,620
ffffffffc020345c:	00009517          	auipc	a0,0x9
ffffffffc0203460:	28450513          	addi	a0,a0,644 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203464:	83afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203468:	00009697          	auipc	a3,0x9
ffffffffc020346c:	79868693          	addi	a3,a3,1944 # ffffffffc020cc00 <default_pmm_manager+0x670>
ffffffffc0203470:	00008617          	auipc	a2,0x8
ffffffffc0203474:	63860613          	addi	a2,a2,1592 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203478:	28e00593          	li	a1,654
ffffffffc020347c:	00009517          	auipc	a0,0x9
ffffffffc0203480:	26450513          	addi	a0,a0,612 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203484:	81afd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203488:	00009697          	auipc	a3,0x9
ffffffffc020348c:	7d068693          	addi	a3,a3,2000 # ffffffffc020cc58 <default_pmm_manager+0x6c8>
ffffffffc0203490:	00008617          	auipc	a2,0x8
ffffffffc0203494:	61860613          	addi	a2,a2,1560 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203498:	29300593          	li	a1,659
ffffffffc020349c:	00009517          	auipc	a0,0x9
ffffffffc02034a0:	24450513          	addi	a0,a0,580 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02034a4:	ffbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034a8:	00009697          	auipc	a3,0x9
ffffffffc02034ac:	77068693          	addi	a3,a3,1904 # ffffffffc020cc18 <default_pmm_manager+0x688>
ffffffffc02034b0:	00008617          	auipc	a2,0x8
ffffffffc02034b4:	5f860613          	addi	a2,a2,1528 # ffffffffc020baa8 <commands+0x210>
ffffffffc02034b8:	29200593          	li	a1,658
ffffffffc02034bc:	00009517          	auipc	a0,0x9
ffffffffc02034c0:	22450513          	addi	a0,a0,548 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02034c4:	fdbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034c8:	0000a697          	auipc	a3,0xa
ffffffffc02034cc:	85868693          	addi	a3,a3,-1960 # ffffffffc020cd20 <default_pmm_manager+0x790>
ffffffffc02034d0:	00008617          	auipc	a2,0x8
ffffffffc02034d4:	5d860613          	addi	a2,a2,1496 # ffffffffc020baa8 <commands+0x210>
ffffffffc02034d8:	29c00593          	li	a1,668
ffffffffc02034dc:	00009517          	auipc	a0,0x9
ffffffffc02034e0:	20450513          	addi	a0,a0,516 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02034e4:	fbbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034e8:	0000a697          	auipc	a3,0xa
ffffffffc02034ec:	80068693          	addi	a3,a3,-2048 # ffffffffc020cce8 <default_pmm_manager+0x758>
ffffffffc02034f0:	00008617          	auipc	a2,0x8
ffffffffc02034f4:	5b860613          	addi	a2,a2,1464 # ffffffffc020baa8 <commands+0x210>
ffffffffc02034f8:	29900593          	li	a1,665
ffffffffc02034fc:	00009517          	auipc	a0,0x9
ffffffffc0203500:	1e450513          	addi	a0,a0,484 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203504:	f9bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203508:	00009697          	auipc	a3,0x9
ffffffffc020350c:	7b068693          	addi	a3,a3,1968 # ffffffffc020ccb8 <default_pmm_manager+0x728>
ffffffffc0203510:	00008617          	auipc	a2,0x8
ffffffffc0203514:	59860613          	addi	a2,a2,1432 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203518:	29500593          	li	a1,661
ffffffffc020351c:	00009517          	auipc	a0,0x9
ffffffffc0203520:	1c450513          	addi	a0,a0,452 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203524:	f7bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203528:	86a2                	mv	a3,s0
ffffffffc020352a:	00009617          	auipc	a2,0x9
ffffffffc020352e:	14660613          	addi	a2,a2,326 # ffffffffc020c670 <default_pmm_manager+0xe0>
ffffffffc0203532:	0dc00593          	li	a1,220
ffffffffc0203536:	00009517          	auipc	a0,0x9
ffffffffc020353a:	1aa50513          	addi	a0,a0,426 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc020353e:	f61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203542:	86ae                	mv	a3,a1
ffffffffc0203544:	00009617          	auipc	a2,0x9
ffffffffc0203548:	12c60613          	addi	a2,a2,300 # ffffffffc020c670 <default_pmm_manager+0xe0>
ffffffffc020354c:	0db00593          	li	a1,219
ffffffffc0203550:	00009517          	auipc	a0,0x9
ffffffffc0203554:	19050513          	addi	a0,a0,400 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203558:	f47fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020355c:	00009697          	auipc	a3,0x9
ffffffffc0203560:	34468693          	addi	a3,a3,836 # ffffffffc020c8a0 <default_pmm_manager+0x310>
ffffffffc0203564:	00008617          	auipc	a2,0x8
ffffffffc0203568:	54460613          	addi	a2,a2,1348 # ffffffffc020baa8 <commands+0x210>
ffffffffc020356c:	24c00593          	li	a1,588
ffffffffc0203570:	00009517          	auipc	a0,0x9
ffffffffc0203574:	17050513          	addi	a0,a0,368 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203578:	f27fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020357c:	00009697          	auipc	a3,0x9
ffffffffc0203580:	30468693          	addi	a3,a3,772 # ffffffffc020c880 <default_pmm_manager+0x2f0>
ffffffffc0203584:	00008617          	auipc	a2,0x8
ffffffffc0203588:	52460613          	addi	a2,a2,1316 # ffffffffc020baa8 <commands+0x210>
ffffffffc020358c:	24b00593          	li	a1,587
ffffffffc0203590:	00009517          	auipc	a0,0x9
ffffffffc0203594:	15050513          	addi	a0,a0,336 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203598:	f07fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020359c:	00009617          	auipc	a2,0x9
ffffffffc02035a0:	27460613          	addi	a2,a2,628 # ffffffffc020c810 <default_pmm_manager+0x280>
ffffffffc02035a4:	0aa00593          	li	a1,170
ffffffffc02035a8:	00009517          	auipc	a0,0x9
ffffffffc02035ac:	13850513          	addi	a0,a0,312 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02035b0:	eeffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035b4:	00009617          	auipc	a2,0x9
ffffffffc02035b8:	1c460613          	addi	a2,a2,452 # ffffffffc020c778 <default_pmm_manager+0x1e8>
ffffffffc02035bc:	06500593          	li	a1,101
ffffffffc02035c0:	00009517          	auipc	a0,0x9
ffffffffc02035c4:	12050513          	addi	a0,a0,288 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02035c8:	ed7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035cc:	00009697          	auipc	a3,0x9
ffffffffc02035d0:	59468693          	addi	a3,a3,1428 # ffffffffc020cb60 <default_pmm_manager+0x5d0>
ffffffffc02035d4:	00008617          	auipc	a2,0x8
ffffffffc02035d8:	4d460613          	addi	a2,a2,1236 # ffffffffc020baa8 <commands+0x210>
ffffffffc02035dc:	2a500593          	li	a1,677
ffffffffc02035e0:	00009517          	auipc	a0,0x9
ffffffffc02035e4:	10050513          	addi	a0,a0,256 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02035e8:	eb7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035ec:	00009697          	auipc	a3,0x9
ffffffffc02035f0:	3b468693          	addi	a3,a3,948 # ffffffffc020c9a0 <default_pmm_manager+0x410>
ffffffffc02035f4:	00008617          	auipc	a2,0x8
ffffffffc02035f8:	4b460613          	addi	a2,a2,1204 # ffffffffc020baa8 <commands+0x210>
ffffffffc02035fc:	25a00593          	li	a1,602
ffffffffc0203600:	00009517          	auipc	a0,0x9
ffffffffc0203604:	0e050513          	addi	a0,a0,224 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203608:	e97fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020360c:	86d6                	mv	a3,s5
ffffffffc020360e:	00009617          	auipc	a2,0x9
ffffffffc0203612:	fba60613          	addi	a2,a2,-70 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc0203616:	25900593          	li	a1,601
ffffffffc020361a:	00009517          	auipc	a0,0x9
ffffffffc020361e:	0c650513          	addi	a0,a0,198 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203622:	e7dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203626:	00009697          	auipc	a3,0x9
ffffffffc020362a:	4c268693          	addi	a3,a3,1218 # ffffffffc020cae8 <default_pmm_manager+0x558>
ffffffffc020362e:	00008617          	auipc	a2,0x8
ffffffffc0203632:	47a60613          	addi	a2,a2,1146 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203636:	26600593          	li	a1,614
ffffffffc020363a:	00009517          	auipc	a0,0x9
ffffffffc020363e:	0a650513          	addi	a0,a0,166 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203642:	e5dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203646:	00009697          	auipc	a3,0x9
ffffffffc020364a:	48a68693          	addi	a3,a3,1162 # ffffffffc020cad0 <default_pmm_manager+0x540>
ffffffffc020364e:	00008617          	auipc	a2,0x8
ffffffffc0203652:	45a60613          	addi	a2,a2,1114 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203656:	26500593          	li	a1,613
ffffffffc020365a:	00009517          	auipc	a0,0x9
ffffffffc020365e:	08650513          	addi	a0,a0,134 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203662:	e3dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203666:	00009697          	auipc	a3,0x9
ffffffffc020366a:	43a68693          	addi	a3,a3,1082 # ffffffffc020caa0 <default_pmm_manager+0x510>
ffffffffc020366e:	00008617          	auipc	a2,0x8
ffffffffc0203672:	43a60613          	addi	a2,a2,1082 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203676:	26400593          	li	a1,612
ffffffffc020367a:	00009517          	auipc	a0,0x9
ffffffffc020367e:	06650513          	addi	a0,a0,102 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203682:	e1dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203686:	00009697          	auipc	a3,0x9
ffffffffc020368a:	40268693          	addi	a3,a3,1026 # ffffffffc020ca88 <default_pmm_manager+0x4f8>
ffffffffc020368e:	00008617          	auipc	a2,0x8
ffffffffc0203692:	41a60613          	addi	a2,a2,1050 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203696:	26200593          	li	a1,610
ffffffffc020369a:	00009517          	auipc	a0,0x9
ffffffffc020369e:	04650513          	addi	a0,a0,70 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02036a2:	dfdfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036a6:	00009697          	auipc	a3,0x9
ffffffffc02036aa:	3c268693          	addi	a3,a3,962 # ffffffffc020ca68 <default_pmm_manager+0x4d8>
ffffffffc02036ae:	00008617          	auipc	a2,0x8
ffffffffc02036b2:	3fa60613          	addi	a2,a2,1018 # ffffffffc020baa8 <commands+0x210>
ffffffffc02036b6:	26100593          	li	a1,609
ffffffffc02036ba:	00009517          	auipc	a0,0x9
ffffffffc02036be:	02650513          	addi	a0,a0,38 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02036c2:	dddfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036c6:	00009697          	auipc	a3,0x9
ffffffffc02036ca:	39268693          	addi	a3,a3,914 # ffffffffc020ca58 <default_pmm_manager+0x4c8>
ffffffffc02036ce:	00008617          	auipc	a2,0x8
ffffffffc02036d2:	3da60613          	addi	a2,a2,986 # ffffffffc020baa8 <commands+0x210>
ffffffffc02036d6:	26000593          	li	a1,608
ffffffffc02036da:	00009517          	auipc	a0,0x9
ffffffffc02036de:	00650513          	addi	a0,a0,6 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02036e2:	dbdfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036e6:	00009697          	auipc	a3,0x9
ffffffffc02036ea:	36268693          	addi	a3,a3,866 # ffffffffc020ca48 <default_pmm_manager+0x4b8>
ffffffffc02036ee:	00008617          	auipc	a2,0x8
ffffffffc02036f2:	3ba60613          	addi	a2,a2,954 # ffffffffc020baa8 <commands+0x210>
ffffffffc02036f6:	25f00593          	li	a1,607
ffffffffc02036fa:	00009517          	auipc	a0,0x9
ffffffffc02036fe:	fe650513          	addi	a0,a0,-26 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203702:	d9dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203706:	00009697          	auipc	a3,0x9
ffffffffc020370a:	30a68693          	addi	a3,a3,778 # ffffffffc020ca10 <default_pmm_manager+0x480>
ffffffffc020370e:	00008617          	auipc	a2,0x8
ffffffffc0203712:	39a60613          	addi	a2,a2,922 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203716:	25e00593          	li	a1,606
ffffffffc020371a:	00009517          	auipc	a0,0x9
ffffffffc020371e:	fc650513          	addi	a0,a0,-58 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203722:	d7dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203726:	00009697          	auipc	a3,0x9
ffffffffc020372a:	43a68693          	addi	a3,a3,1082 # ffffffffc020cb60 <default_pmm_manager+0x5d0>
ffffffffc020372e:	00008617          	auipc	a2,0x8
ffffffffc0203732:	37a60613          	addi	a2,a2,890 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203736:	27b00593          	li	a1,635
ffffffffc020373a:	00009517          	auipc	a0,0x9
ffffffffc020373e:	fa650513          	addi	a0,a0,-90 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203742:	d5dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203746:	00009617          	auipc	a2,0x9
ffffffffc020374a:	e8260613          	addi	a2,a2,-382 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc020374e:	07100593          	li	a1,113
ffffffffc0203752:	00009517          	auipc	a0,0x9
ffffffffc0203756:	e9e50513          	addi	a0,a0,-354 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc020375a:	d45fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020375e:	86a2                	mv	a3,s0
ffffffffc0203760:	00009617          	auipc	a2,0x9
ffffffffc0203764:	f1060613          	addi	a2,a2,-240 # ffffffffc020c670 <default_pmm_manager+0xe0>
ffffffffc0203768:	0ca00593          	li	a1,202
ffffffffc020376c:	00009517          	auipc	a0,0x9
ffffffffc0203770:	f7450513          	addi	a0,a0,-140 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203774:	d2bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203778:	00009617          	auipc	a2,0x9
ffffffffc020377c:	ef860613          	addi	a2,a2,-264 # ffffffffc020c670 <default_pmm_manager+0xe0>
ffffffffc0203780:	08100593          	li	a1,129
ffffffffc0203784:	00009517          	auipc	a0,0x9
ffffffffc0203788:	f5c50513          	addi	a0,a0,-164 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc020378c:	d13fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203790:	00009697          	auipc	a3,0x9
ffffffffc0203794:	24068693          	addi	a3,a3,576 # ffffffffc020c9d0 <default_pmm_manager+0x440>
ffffffffc0203798:	00008617          	auipc	a2,0x8
ffffffffc020379c:	31060613          	addi	a2,a2,784 # ffffffffc020baa8 <commands+0x210>
ffffffffc02037a0:	25d00593          	li	a1,605
ffffffffc02037a4:	00009517          	auipc	a0,0x9
ffffffffc02037a8:	f3c50513          	addi	a0,a0,-196 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02037ac:	cf3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037b0:	00009697          	auipc	a3,0x9
ffffffffc02037b4:	16068693          	addi	a3,a3,352 # ffffffffc020c910 <default_pmm_manager+0x380>
ffffffffc02037b8:	00008617          	auipc	a2,0x8
ffffffffc02037bc:	2f060613          	addi	a2,a2,752 # ffffffffc020baa8 <commands+0x210>
ffffffffc02037c0:	25100593          	li	a1,593
ffffffffc02037c4:	00009517          	auipc	a0,0x9
ffffffffc02037c8:	f1c50513          	addi	a0,a0,-228 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02037cc:	cd3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037d0:	985fe0ef          	jal	ra,ffffffffc0202154 <pte2page.part.0>
ffffffffc02037d4:	00009697          	auipc	a3,0x9
ffffffffc02037d8:	16c68693          	addi	a3,a3,364 # ffffffffc020c940 <default_pmm_manager+0x3b0>
ffffffffc02037dc:	00008617          	auipc	a2,0x8
ffffffffc02037e0:	2cc60613          	addi	a2,a2,716 # ffffffffc020baa8 <commands+0x210>
ffffffffc02037e4:	25400593          	li	a1,596
ffffffffc02037e8:	00009517          	auipc	a0,0x9
ffffffffc02037ec:	ef850513          	addi	a0,a0,-264 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02037f0:	caffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037f4:	00009697          	auipc	a3,0x9
ffffffffc02037f8:	0ec68693          	addi	a3,a3,236 # ffffffffc020c8e0 <default_pmm_manager+0x350>
ffffffffc02037fc:	00008617          	auipc	a2,0x8
ffffffffc0203800:	2ac60613          	addi	a2,a2,684 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203804:	24d00593          	li	a1,589
ffffffffc0203808:	00009517          	auipc	a0,0x9
ffffffffc020380c:	ed850513          	addi	a0,a0,-296 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203810:	c8ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203814:	00009697          	auipc	a3,0x9
ffffffffc0203818:	15c68693          	addi	a3,a3,348 # ffffffffc020c970 <default_pmm_manager+0x3e0>
ffffffffc020381c:	00008617          	auipc	a2,0x8
ffffffffc0203820:	28c60613          	addi	a2,a2,652 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203824:	25500593          	li	a1,597
ffffffffc0203828:	00009517          	auipc	a0,0x9
ffffffffc020382c:	eb850513          	addi	a0,a0,-328 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203830:	c6ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203834:	00009617          	auipc	a2,0x9
ffffffffc0203838:	d9460613          	addi	a2,a2,-620 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc020383c:	25800593          	li	a1,600
ffffffffc0203840:	00009517          	auipc	a0,0x9
ffffffffc0203844:	ea050513          	addi	a0,a0,-352 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203848:	c57fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020384c:	00009697          	auipc	a3,0x9
ffffffffc0203850:	13c68693          	addi	a3,a3,316 # ffffffffc020c988 <default_pmm_manager+0x3f8>
ffffffffc0203854:	00008617          	auipc	a2,0x8
ffffffffc0203858:	25460613          	addi	a2,a2,596 # ffffffffc020baa8 <commands+0x210>
ffffffffc020385c:	25600593          	li	a1,598
ffffffffc0203860:	00009517          	auipc	a0,0x9
ffffffffc0203864:	e8050513          	addi	a0,a0,-384 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203868:	c37fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020386c:	86ca                	mv	a3,s2
ffffffffc020386e:	00009617          	auipc	a2,0x9
ffffffffc0203872:	e0260613          	addi	a2,a2,-510 # ffffffffc020c670 <default_pmm_manager+0xe0>
ffffffffc0203876:	0c600593          	li	a1,198
ffffffffc020387a:	00009517          	auipc	a0,0x9
ffffffffc020387e:	e6650513          	addi	a0,a0,-410 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203882:	c1dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203886:	00009697          	auipc	a3,0x9
ffffffffc020388a:	26268693          	addi	a3,a3,610 # ffffffffc020cae8 <default_pmm_manager+0x558>
ffffffffc020388e:	00008617          	auipc	a2,0x8
ffffffffc0203892:	21a60613          	addi	a2,a2,538 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203896:	27100593          	li	a1,625
ffffffffc020389a:	00009517          	auipc	a0,0x9
ffffffffc020389e:	e4650513          	addi	a0,a0,-442 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02038a2:	bfdfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038a6:	00009697          	auipc	a3,0x9
ffffffffc02038aa:	27268693          	addi	a3,a3,626 # ffffffffc020cb18 <default_pmm_manager+0x588>
ffffffffc02038ae:	00008617          	auipc	a2,0x8
ffffffffc02038b2:	1fa60613          	addi	a2,a2,506 # ffffffffc020baa8 <commands+0x210>
ffffffffc02038b6:	27000593          	li	a1,624
ffffffffc02038ba:	00009517          	auipc	a0,0x9
ffffffffc02038be:	e2650513          	addi	a0,a0,-474 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc02038c2:	bddfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02038c6 <copy_range>:
ffffffffc02038c6:	7159                	addi	sp,sp,-112
ffffffffc02038c8:	00d667b3          	or	a5,a2,a3
ffffffffc02038cc:	f486                	sd	ra,104(sp)
ffffffffc02038ce:	f0a2                	sd	s0,96(sp)
ffffffffc02038d0:	eca6                	sd	s1,88(sp)
ffffffffc02038d2:	e8ca                	sd	s2,80(sp)
ffffffffc02038d4:	e4ce                	sd	s3,72(sp)
ffffffffc02038d6:	e0d2                	sd	s4,64(sp)
ffffffffc02038d8:	fc56                	sd	s5,56(sp)
ffffffffc02038da:	f85a                	sd	s6,48(sp)
ffffffffc02038dc:	f45e                	sd	s7,40(sp)
ffffffffc02038de:	f062                	sd	s8,32(sp)
ffffffffc02038e0:	ec66                	sd	s9,24(sp)
ffffffffc02038e2:	e86a                	sd	s10,16(sp)
ffffffffc02038e4:	e46e                	sd	s11,8(sp)
ffffffffc02038e6:	17d2                	slli	a5,a5,0x34
ffffffffc02038e8:	20079f63          	bnez	a5,ffffffffc0203b06 <copy_range+0x240>
ffffffffc02038ec:	002007b7          	lui	a5,0x200
ffffffffc02038f0:	8432                	mv	s0,a2
ffffffffc02038f2:	1af66263          	bltu	a2,a5,ffffffffc0203a96 <copy_range+0x1d0>
ffffffffc02038f6:	8936                	mv	s2,a3
ffffffffc02038f8:	18d67f63          	bgeu	a2,a3,ffffffffc0203a96 <copy_range+0x1d0>
ffffffffc02038fc:	4785                	li	a5,1
ffffffffc02038fe:	07fe                	slli	a5,a5,0x1f
ffffffffc0203900:	18d7eb63          	bltu	a5,a3,ffffffffc0203a96 <copy_range+0x1d0>
ffffffffc0203904:	5b7d                	li	s6,-1
ffffffffc0203906:	8aaa                	mv	s5,a0
ffffffffc0203908:	89ae                	mv	s3,a1
ffffffffc020390a:	6a05                	lui	s4,0x1
ffffffffc020390c:	00093c17          	auipc	s8,0x93
ffffffffc0203910:	f94c0c13          	addi	s8,s8,-108 # ffffffffc02968a0 <npage>
ffffffffc0203914:	00093b97          	auipc	s7,0x93
ffffffffc0203918:	f94b8b93          	addi	s7,s7,-108 # ffffffffc02968a8 <pages>
ffffffffc020391c:	00cb5b13          	srli	s6,s6,0xc
ffffffffc0203920:	00093c97          	auipc	s9,0x93
ffffffffc0203924:	f90c8c93          	addi	s9,s9,-112 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203928:	4601                	li	a2,0
ffffffffc020392a:	85a2                	mv	a1,s0
ffffffffc020392c:	854e                	mv	a0,s3
ffffffffc020392e:	8fbfe0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc0203932:	84aa                	mv	s1,a0
ffffffffc0203934:	0e050c63          	beqz	a0,ffffffffc0203a2c <copy_range+0x166>
ffffffffc0203938:	611c                	ld	a5,0(a0)
ffffffffc020393a:	8b85                	andi	a5,a5,1
ffffffffc020393c:	e785                	bnez	a5,ffffffffc0203964 <copy_range+0x9e>
ffffffffc020393e:	9452                	add	s0,s0,s4
ffffffffc0203940:	ff2464e3          	bltu	s0,s2,ffffffffc0203928 <copy_range+0x62>
ffffffffc0203944:	4501                	li	a0,0
ffffffffc0203946:	70a6                	ld	ra,104(sp)
ffffffffc0203948:	7406                	ld	s0,96(sp)
ffffffffc020394a:	64e6                	ld	s1,88(sp)
ffffffffc020394c:	6946                	ld	s2,80(sp)
ffffffffc020394e:	69a6                	ld	s3,72(sp)
ffffffffc0203950:	6a06                	ld	s4,64(sp)
ffffffffc0203952:	7ae2                	ld	s5,56(sp)
ffffffffc0203954:	7b42                	ld	s6,48(sp)
ffffffffc0203956:	7ba2                	ld	s7,40(sp)
ffffffffc0203958:	7c02                	ld	s8,32(sp)
ffffffffc020395a:	6ce2                	ld	s9,24(sp)
ffffffffc020395c:	6d42                	ld	s10,16(sp)
ffffffffc020395e:	6da2                	ld	s11,8(sp)
ffffffffc0203960:	6165                	addi	sp,sp,112
ffffffffc0203962:	8082                	ret
ffffffffc0203964:	4605                	li	a2,1
ffffffffc0203966:	85a2                	mv	a1,s0
ffffffffc0203968:	8556                	mv	a0,s5
ffffffffc020396a:	8bffe0ef          	jal	ra,ffffffffc0202228 <get_pte>
ffffffffc020396e:	c56d                	beqz	a0,ffffffffc0203a58 <copy_range+0x192>
ffffffffc0203970:	609c                	ld	a5,0(s1)
ffffffffc0203972:	0017f713          	andi	a4,a5,1
ffffffffc0203976:	01f7f493          	andi	s1,a5,31
ffffffffc020397a:	16070a63          	beqz	a4,ffffffffc0203aee <copy_range+0x228>
ffffffffc020397e:	000c3683          	ld	a3,0(s8)
ffffffffc0203982:	078a                	slli	a5,a5,0x2
ffffffffc0203984:	00c7d713          	srli	a4,a5,0xc
ffffffffc0203988:	14d77763          	bgeu	a4,a3,ffffffffc0203ad6 <copy_range+0x210>
ffffffffc020398c:	000bb783          	ld	a5,0(s7)
ffffffffc0203990:	fff806b7          	lui	a3,0xfff80
ffffffffc0203994:	9736                	add	a4,a4,a3
ffffffffc0203996:	071a                	slli	a4,a4,0x6
ffffffffc0203998:	00e78db3          	add	s11,a5,a4
ffffffffc020399c:	10002773          	csrr	a4,sstatus
ffffffffc02039a0:	8b09                	andi	a4,a4,2
ffffffffc02039a2:	e345                	bnez	a4,ffffffffc0203a42 <copy_range+0x17c>
ffffffffc02039a4:	000cb703          	ld	a4,0(s9)
ffffffffc02039a8:	4505                	li	a0,1
ffffffffc02039aa:	6f18                	ld	a4,24(a4)
ffffffffc02039ac:	9702                	jalr	a4
ffffffffc02039ae:	8d2a                	mv	s10,a0
ffffffffc02039b0:	0c0d8363          	beqz	s11,ffffffffc0203a76 <copy_range+0x1b0>
ffffffffc02039b4:	100d0163          	beqz	s10,ffffffffc0203ab6 <copy_range+0x1f0>
ffffffffc02039b8:	000bb703          	ld	a4,0(s7)
ffffffffc02039bc:	000805b7          	lui	a1,0x80
ffffffffc02039c0:	000c3603          	ld	a2,0(s8)
ffffffffc02039c4:	40ed86b3          	sub	a3,s11,a4
ffffffffc02039c8:	8699                	srai	a3,a3,0x6
ffffffffc02039ca:	96ae                	add	a3,a3,a1
ffffffffc02039cc:	0166f7b3          	and	a5,a3,s6
ffffffffc02039d0:	06b2                	slli	a3,a3,0xc
ffffffffc02039d2:	08c7f663          	bgeu	a5,a2,ffffffffc0203a5e <copy_range+0x198>
ffffffffc02039d6:	40ed07b3          	sub	a5,s10,a4
ffffffffc02039da:	00093717          	auipc	a4,0x93
ffffffffc02039de:	ede70713          	addi	a4,a4,-290 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02039e2:	6308                	ld	a0,0(a4)
ffffffffc02039e4:	8799                	srai	a5,a5,0x6
ffffffffc02039e6:	97ae                	add	a5,a5,a1
ffffffffc02039e8:	0167f733          	and	a4,a5,s6
ffffffffc02039ec:	00a685b3          	add	a1,a3,a0
ffffffffc02039f0:	07b2                	slli	a5,a5,0xc
ffffffffc02039f2:	06c77563          	bgeu	a4,a2,ffffffffc0203a5c <copy_range+0x196>
ffffffffc02039f6:	6605                	lui	a2,0x1
ffffffffc02039f8:	953e                	add	a0,a0,a5
ffffffffc02039fa:	41f070ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc02039fe:	86a6                	mv	a3,s1
ffffffffc0203a00:	8622                	mv	a2,s0
ffffffffc0203a02:	85ea                	mv	a1,s10
ffffffffc0203a04:	8556                	mv	a0,s5
ffffffffc0203a06:	fd9fe0ef          	jal	ra,ffffffffc02029de <page_insert>
ffffffffc0203a0a:	d915                	beqz	a0,ffffffffc020393e <copy_range+0x78>
ffffffffc0203a0c:	00009697          	auipc	a3,0x9
ffffffffc0203a10:	37c68693          	addi	a3,a3,892 # ffffffffc020cd88 <default_pmm_manager+0x7f8>
ffffffffc0203a14:	00008617          	auipc	a2,0x8
ffffffffc0203a18:	09460613          	addi	a2,a2,148 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203a1c:	1e900593          	li	a1,489
ffffffffc0203a20:	00009517          	auipc	a0,0x9
ffffffffc0203a24:	cc050513          	addi	a0,a0,-832 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203a28:	a77fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a2c:	00200637          	lui	a2,0x200
ffffffffc0203a30:	9432                	add	s0,s0,a2
ffffffffc0203a32:	ffe00637          	lui	a2,0xffe00
ffffffffc0203a36:	8c71                	and	s0,s0,a2
ffffffffc0203a38:	f00406e3          	beqz	s0,ffffffffc0203944 <copy_range+0x7e>
ffffffffc0203a3c:	ef2466e3          	bltu	s0,s2,ffffffffc0203928 <copy_range+0x62>
ffffffffc0203a40:	b711                	j	ffffffffc0203944 <copy_range+0x7e>
ffffffffc0203a42:	a30fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203a46:	000cb703          	ld	a4,0(s9)
ffffffffc0203a4a:	4505                	li	a0,1
ffffffffc0203a4c:	6f18                	ld	a4,24(a4)
ffffffffc0203a4e:	9702                	jalr	a4
ffffffffc0203a50:	8d2a                	mv	s10,a0
ffffffffc0203a52:	a1afd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203a56:	bfa9                	j	ffffffffc02039b0 <copy_range+0xea>
ffffffffc0203a58:	5571                	li	a0,-4
ffffffffc0203a5a:	b5f5                	j	ffffffffc0203946 <copy_range+0x80>
ffffffffc0203a5c:	86be                	mv	a3,a5
ffffffffc0203a5e:	00009617          	auipc	a2,0x9
ffffffffc0203a62:	b6a60613          	addi	a2,a2,-1174 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc0203a66:	07100593          	li	a1,113
ffffffffc0203a6a:	00009517          	auipc	a0,0x9
ffffffffc0203a6e:	b8650513          	addi	a0,a0,-1146 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0203a72:	a2dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a76:	00009697          	auipc	a3,0x9
ffffffffc0203a7a:	2f268693          	addi	a3,a3,754 # ffffffffc020cd68 <default_pmm_manager+0x7d8>
ffffffffc0203a7e:	00008617          	auipc	a2,0x8
ffffffffc0203a82:	02a60613          	addi	a2,a2,42 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203a86:	1ce00593          	li	a1,462
ffffffffc0203a8a:	00009517          	auipc	a0,0x9
ffffffffc0203a8e:	c5650513          	addi	a0,a0,-938 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203a92:	a0dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a96:	00009697          	auipc	a3,0x9
ffffffffc0203a9a:	cb268693          	addi	a3,a3,-846 # ffffffffc020c748 <default_pmm_manager+0x1b8>
ffffffffc0203a9e:	00008617          	auipc	a2,0x8
ffffffffc0203aa2:	00a60613          	addi	a2,a2,10 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203aa6:	1b600593          	li	a1,438
ffffffffc0203aaa:	00009517          	auipc	a0,0x9
ffffffffc0203aae:	c3650513          	addi	a0,a0,-970 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203ab2:	9edfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ab6:	00009697          	auipc	a3,0x9
ffffffffc0203aba:	2c268693          	addi	a3,a3,706 # ffffffffc020cd78 <default_pmm_manager+0x7e8>
ffffffffc0203abe:	00008617          	auipc	a2,0x8
ffffffffc0203ac2:	fea60613          	addi	a2,a2,-22 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203ac6:	1cf00593          	li	a1,463
ffffffffc0203aca:	00009517          	auipc	a0,0x9
ffffffffc0203ace:	c1650513          	addi	a0,a0,-1002 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203ad2:	9cdfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ad6:	00009617          	auipc	a2,0x9
ffffffffc0203ada:	bc260613          	addi	a2,a2,-1086 # ffffffffc020c698 <default_pmm_manager+0x108>
ffffffffc0203ade:	06900593          	li	a1,105
ffffffffc0203ae2:	00009517          	auipc	a0,0x9
ffffffffc0203ae6:	b0e50513          	addi	a0,a0,-1266 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0203aea:	9b5fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203aee:	00009617          	auipc	a2,0x9
ffffffffc0203af2:	bca60613          	addi	a2,a2,-1078 # ffffffffc020c6b8 <default_pmm_manager+0x128>
ffffffffc0203af6:	07f00593          	li	a1,127
ffffffffc0203afa:	00009517          	auipc	a0,0x9
ffffffffc0203afe:	af650513          	addi	a0,a0,-1290 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0203b02:	99dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b06:	00009697          	auipc	a3,0x9
ffffffffc0203b0a:	c1268693          	addi	a3,a3,-1006 # ffffffffc020c718 <default_pmm_manager+0x188>
ffffffffc0203b0e:	00008617          	auipc	a2,0x8
ffffffffc0203b12:	f9a60613          	addi	a2,a2,-102 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203b16:	1b500593          	li	a1,437
ffffffffc0203b1a:	00009517          	auipc	a0,0x9
ffffffffc0203b1e:	bc650513          	addi	a0,a0,-1082 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203b22:	97dfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203b26 <pgdir_alloc_page>:
ffffffffc0203b26:	7179                	addi	sp,sp,-48
ffffffffc0203b28:	ec26                	sd	s1,24(sp)
ffffffffc0203b2a:	e84a                	sd	s2,16(sp)
ffffffffc0203b2c:	e052                	sd	s4,0(sp)
ffffffffc0203b2e:	f406                	sd	ra,40(sp)
ffffffffc0203b30:	f022                	sd	s0,32(sp)
ffffffffc0203b32:	e44e                	sd	s3,8(sp)
ffffffffc0203b34:	8a2a                	mv	s4,a0
ffffffffc0203b36:	84ae                	mv	s1,a1
ffffffffc0203b38:	8932                	mv	s2,a2
ffffffffc0203b3a:	100027f3          	csrr	a5,sstatus
ffffffffc0203b3e:	8b89                	andi	a5,a5,2
ffffffffc0203b40:	00093997          	auipc	s3,0x93
ffffffffc0203b44:	d7098993          	addi	s3,s3,-656 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203b48:	ef8d                	bnez	a5,ffffffffc0203b82 <pgdir_alloc_page+0x5c>
ffffffffc0203b4a:	0009b783          	ld	a5,0(s3)
ffffffffc0203b4e:	4505                	li	a0,1
ffffffffc0203b50:	6f9c                	ld	a5,24(a5)
ffffffffc0203b52:	9782                	jalr	a5
ffffffffc0203b54:	842a                	mv	s0,a0
ffffffffc0203b56:	cc09                	beqz	s0,ffffffffc0203b70 <pgdir_alloc_page+0x4a>
ffffffffc0203b58:	86ca                	mv	a3,s2
ffffffffc0203b5a:	8626                	mv	a2,s1
ffffffffc0203b5c:	85a2                	mv	a1,s0
ffffffffc0203b5e:	8552                	mv	a0,s4
ffffffffc0203b60:	e7ffe0ef          	jal	ra,ffffffffc02029de <page_insert>
ffffffffc0203b64:	e915                	bnez	a0,ffffffffc0203b98 <pgdir_alloc_page+0x72>
ffffffffc0203b66:	4018                	lw	a4,0(s0)
ffffffffc0203b68:	fc04                	sd	s1,56(s0)
ffffffffc0203b6a:	4785                	li	a5,1
ffffffffc0203b6c:	04f71e63          	bne	a4,a5,ffffffffc0203bc8 <pgdir_alloc_page+0xa2>
ffffffffc0203b70:	70a2                	ld	ra,40(sp)
ffffffffc0203b72:	8522                	mv	a0,s0
ffffffffc0203b74:	7402                	ld	s0,32(sp)
ffffffffc0203b76:	64e2                	ld	s1,24(sp)
ffffffffc0203b78:	6942                	ld	s2,16(sp)
ffffffffc0203b7a:	69a2                	ld	s3,8(sp)
ffffffffc0203b7c:	6a02                	ld	s4,0(sp)
ffffffffc0203b7e:	6145                	addi	sp,sp,48
ffffffffc0203b80:	8082                	ret
ffffffffc0203b82:	8f0fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203b86:	0009b783          	ld	a5,0(s3)
ffffffffc0203b8a:	4505                	li	a0,1
ffffffffc0203b8c:	6f9c                	ld	a5,24(a5)
ffffffffc0203b8e:	9782                	jalr	a5
ffffffffc0203b90:	842a                	mv	s0,a0
ffffffffc0203b92:	8dafd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203b96:	b7c1                	j	ffffffffc0203b56 <pgdir_alloc_page+0x30>
ffffffffc0203b98:	100027f3          	csrr	a5,sstatus
ffffffffc0203b9c:	8b89                	andi	a5,a5,2
ffffffffc0203b9e:	eb89                	bnez	a5,ffffffffc0203bb0 <pgdir_alloc_page+0x8a>
ffffffffc0203ba0:	0009b783          	ld	a5,0(s3)
ffffffffc0203ba4:	8522                	mv	a0,s0
ffffffffc0203ba6:	4585                	li	a1,1
ffffffffc0203ba8:	739c                	ld	a5,32(a5)
ffffffffc0203baa:	4401                	li	s0,0
ffffffffc0203bac:	9782                	jalr	a5
ffffffffc0203bae:	b7c9                	j	ffffffffc0203b70 <pgdir_alloc_page+0x4a>
ffffffffc0203bb0:	8c2fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203bb4:	0009b783          	ld	a5,0(s3)
ffffffffc0203bb8:	8522                	mv	a0,s0
ffffffffc0203bba:	4585                	li	a1,1
ffffffffc0203bbc:	739c                	ld	a5,32(a5)
ffffffffc0203bbe:	4401                	li	s0,0
ffffffffc0203bc0:	9782                	jalr	a5
ffffffffc0203bc2:	8aafd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203bc6:	b76d                	j	ffffffffc0203b70 <pgdir_alloc_page+0x4a>
ffffffffc0203bc8:	00009697          	auipc	a3,0x9
ffffffffc0203bcc:	1d068693          	addi	a3,a3,464 # ffffffffc020cd98 <default_pmm_manager+0x808>
ffffffffc0203bd0:	00008617          	auipc	a2,0x8
ffffffffc0203bd4:	ed860613          	addi	a2,a2,-296 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203bd8:	23200593          	li	a1,562
ffffffffc0203bdc:	00009517          	auipc	a0,0x9
ffffffffc0203be0:	b0450513          	addi	a0,a0,-1276 # ffffffffc020c6e0 <default_pmm_manager+0x150>
ffffffffc0203be4:	8bbfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203be8 <check_vma_overlap.part.0>:
ffffffffc0203be8:	1141                	addi	sp,sp,-16
ffffffffc0203bea:	00009697          	auipc	a3,0x9
ffffffffc0203bee:	1c668693          	addi	a3,a3,454 # ffffffffc020cdb0 <default_pmm_manager+0x820>
ffffffffc0203bf2:	00008617          	auipc	a2,0x8
ffffffffc0203bf6:	eb660613          	addi	a2,a2,-330 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203bfa:	07400593          	li	a1,116
ffffffffc0203bfe:	00009517          	auipc	a0,0x9
ffffffffc0203c02:	1d250513          	addi	a0,a0,466 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0203c06:	e406                	sd	ra,8(sp)
ffffffffc0203c08:	897fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203c0c <mm_create>:
ffffffffc0203c0c:	1141                	addi	sp,sp,-16
ffffffffc0203c0e:	05800513          	li	a0,88
ffffffffc0203c12:	e022                	sd	s0,0(sp)
ffffffffc0203c14:	e406                	sd	ra,8(sp)
ffffffffc0203c16:	b7cfe0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc0203c1a:	842a                	mv	s0,a0
ffffffffc0203c1c:	c115                	beqz	a0,ffffffffc0203c40 <mm_create+0x34>
ffffffffc0203c1e:	e408                	sd	a0,8(s0)
ffffffffc0203c20:	e008                	sd	a0,0(s0)
ffffffffc0203c22:	00053823          	sd	zero,16(a0)
ffffffffc0203c26:	00053c23          	sd	zero,24(a0)
ffffffffc0203c2a:	02052023          	sw	zero,32(a0)
ffffffffc0203c2e:	02053423          	sd	zero,40(a0)
ffffffffc0203c32:	02052823          	sw	zero,48(a0)
ffffffffc0203c36:	4585                	li	a1,1
ffffffffc0203c38:	03850513          	addi	a0,a0,56
ffffffffc0203c3c:	123000ef          	jal	ra,ffffffffc020455e <sem_init>
ffffffffc0203c40:	60a2                	ld	ra,8(sp)
ffffffffc0203c42:	8522                	mv	a0,s0
ffffffffc0203c44:	6402                	ld	s0,0(sp)
ffffffffc0203c46:	0141                	addi	sp,sp,16
ffffffffc0203c48:	8082                	ret

ffffffffc0203c4a <find_vma>:
ffffffffc0203c4a:	86aa                	mv	a3,a0
ffffffffc0203c4c:	c505                	beqz	a0,ffffffffc0203c74 <find_vma+0x2a>
ffffffffc0203c4e:	6908                	ld	a0,16(a0)
ffffffffc0203c50:	c501                	beqz	a0,ffffffffc0203c58 <find_vma+0xe>
ffffffffc0203c52:	651c                	ld	a5,8(a0)
ffffffffc0203c54:	02f5f263          	bgeu	a1,a5,ffffffffc0203c78 <find_vma+0x2e>
ffffffffc0203c58:	669c                	ld	a5,8(a3)
ffffffffc0203c5a:	00f68d63          	beq	a3,a5,ffffffffc0203c74 <find_vma+0x2a>
ffffffffc0203c5e:	fe87b703          	ld	a4,-24(a5) # 1fffe8 <_binary_bin_sfs_img_size+0x18ace8>
ffffffffc0203c62:	00e5e663          	bltu	a1,a4,ffffffffc0203c6e <find_vma+0x24>
ffffffffc0203c66:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203c6a:	00e5ec63          	bltu	a1,a4,ffffffffc0203c82 <find_vma+0x38>
ffffffffc0203c6e:	679c                	ld	a5,8(a5)
ffffffffc0203c70:	fef697e3          	bne	a3,a5,ffffffffc0203c5e <find_vma+0x14>
ffffffffc0203c74:	4501                	li	a0,0
ffffffffc0203c76:	8082                	ret
ffffffffc0203c78:	691c                	ld	a5,16(a0)
ffffffffc0203c7a:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0203c58 <find_vma+0xe>
ffffffffc0203c7e:	ea88                	sd	a0,16(a3)
ffffffffc0203c80:	8082                	ret
ffffffffc0203c82:	fe078513          	addi	a0,a5,-32
ffffffffc0203c86:	ea88                	sd	a0,16(a3)
ffffffffc0203c88:	8082                	ret

ffffffffc0203c8a <insert_vma_struct>:
ffffffffc0203c8a:	6590                	ld	a2,8(a1)
ffffffffc0203c8c:	0105b803          	ld	a6,16(a1) # 80010 <_binary_bin_sfs_img_size+0xad10>
ffffffffc0203c90:	1141                	addi	sp,sp,-16
ffffffffc0203c92:	e406                	sd	ra,8(sp)
ffffffffc0203c94:	87aa                	mv	a5,a0
ffffffffc0203c96:	01066763          	bltu	a2,a6,ffffffffc0203ca4 <insert_vma_struct+0x1a>
ffffffffc0203c9a:	a085                	j	ffffffffc0203cfa <insert_vma_struct+0x70>
ffffffffc0203c9c:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203ca0:	04e66863          	bltu	a2,a4,ffffffffc0203cf0 <insert_vma_struct+0x66>
ffffffffc0203ca4:	86be                	mv	a3,a5
ffffffffc0203ca6:	679c                	ld	a5,8(a5)
ffffffffc0203ca8:	fef51ae3          	bne	a0,a5,ffffffffc0203c9c <insert_vma_struct+0x12>
ffffffffc0203cac:	02a68463          	beq	a3,a0,ffffffffc0203cd4 <insert_vma_struct+0x4a>
ffffffffc0203cb0:	ff06b703          	ld	a4,-16(a3)
ffffffffc0203cb4:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203cb8:	08e8f163          	bgeu	a7,a4,ffffffffc0203d3a <insert_vma_struct+0xb0>
ffffffffc0203cbc:	04e66f63          	bltu	a2,a4,ffffffffc0203d1a <insert_vma_struct+0x90>
ffffffffc0203cc0:	00f50a63          	beq	a0,a5,ffffffffc0203cd4 <insert_vma_struct+0x4a>
ffffffffc0203cc4:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203cc8:	05076963          	bltu	a4,a6,ffffffffc0203d1a <insert_vma_struct+0x90>
ffffffffc0203ccc:	ff07b603          	ld	a2,-16(a5)
ffffffffc0203cd0:	02c77363          	bgeu	a4,a2,ffffffffc0203cf6 <insert_vma_struct+0x6c>
ffffffffc0203cd4:	5118                	lw	a4,32(a0)
ffffffffc0203cd6:	e188                	sd	a0,0(a1)
ffffffffc0203cd8:	02058613          	addi	a2,a1,32
ffffffffc0203cdc:	e390                	sd	a2,0(a5)
ffffffffc0203cde:	e690                	sd	a2,8(a3)
ffffffffc0203ce0:	60a2                	ld	ra,8(sp)
ffffffffc0203ce2:	f59c                	sd	a5,40(a1)
ffffffffc0203ce4:	f194                	sd	a3,32(a1)
ffffffffc0203ce6:	0017079b          	addiw	a5,a4,1
ffffffffc0203cea:	d11c                	sw	a5,32(a0)
ffffffffc0203cec:	0141                	addi	sp,sp,16
ffffffffc0203cee:	8082                	ret
ffffffffc0203cf0:	fca690e3          	bne	a3,a0,ffffffffc0203cb0 <insert_vma_struct+0x26>
ffffffffc0203cf4:	bfd1                	j	ffffffffc0203cc8 <insert_vma_struct+0x3e>
ffffffffc0203cf6:	ef3ff0ef          	jal	ra,ffffffffc0203be8 <check_vma_overlap.part.0>
ffffffffc0203cfa:	00009697          	auipc	a3,0x9
ffffffffc0203cfe:	0e668693          	addi	a3,a3,230 # ffffffffc020cde0 <default_pmm_manager+0x850>
ffffffffc0203d02:	00008617          	auipc	a2,0x8
ffffffffc0203d06:	da660613          	addi	a2,a2,-602 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203d0a:	07a00593          	li	a1,122
ffffffffc0203d0e:	00009517          	auipc	a0,0x9
ffffffffc0203d12:	0c250513          	addi	a0,a0,194 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0203d16:	f88fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d1a:	00009697          	auipc	a3,0x9
ffffffffc0203d1e:	10668693          	addi	a3,a3,262 # ffffffffc020ce20 <default_pmm_manager+0x890>
ffffffffc0203d22:	00008617          	auipc	a2,0x8
ffffffffc0203d26:	d8660613          	addi	a2,a2,-634 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203d2a:	07300593          	li	a1,115
ffffffffc0203d2e:	00009517          	auipc	a0,0x9
ffffffffc0203d32:	0a250513          	addi	a0,a0,162 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0203d36:	f68fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d3a:	00009697          	auipc	a3,0x9
ffffffffc0203d3e:	0c668693          	addi	a3,a3,198 # ffffffffc020ce00 <default_pmm_manager+0x870>
ffffffffc0203d42:	00008617          	auipc	a2,0x8
ffffffffc0203d46:	d6660613          	addi	a2,a2,-666 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203d4a:	07200593          	li	a1,114
ffffffffc0203d4e:	00009517          	auipc	a0,0x9
ffffffffc0203d52:	08250513          	addi	a0,a0,130 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0203d56:	f48fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203d5a <mm_destroy>:
ffffffffc0203d5a:	591c                	lw	a5,48(a0)
ffffffffc0203d5c:	1141                	addi	sp,sp,-16
ffffffffc0203d5e:	e406                	sd	ra,8(sp)
ffffffffc0203d60:	e022                	sd	s0,0(sp)
ffffffffc0203d62:	e78d                	bnez	a5,ffffffffc0203d8c <mm_destroy+0x32>
ffffffffc0203d64:	842a                	mv	s0,a0
ffffffffc0203d66:	6508                	ld	a0,8(a0)
ffffffffc0203d68:	00a40c63          	beq	s0,a0,ffffffffc0203d80 <mm_destroy+0x26>
ffffffffc0203d6c:	6118                	ld	a4,0(a0)
ffffffffc0203d6e:	651c                	ld	a5,8(a0)
ffffffffc0203d70:	1501                	addi	a0,a0,-32
ffffffffc0203d72:	e71c                	sd	a5,8(a4)
ffffffffc0203d74:	e398                	sd	a4,0(a5)
ffffffffc0203d76:	accfe0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0203d7a:	6408                	ld	a0,8(s0)
ffffffffc0203d7c:	fea418e3          	bne	s0,a0,ffffffffc0203d6c <mm_destroy+0x12>
ffffffffc0203d80:	8522                	mv	a0,s0
ffffffffc0203d82:	6402                	ld	s0,0(sp)
ffffffffc0203d84:	60a2                	ld	ra,8(sp)
ffffffffc0203d86:	0141                	addi	sp,sp,16
ffffffffc0203d88:	abafe06f          	j	ffffffffc0202042 <kfree>
ffffffffc0203d8c:	00009697          	auipc	a3,0x9
ffffffffc0203d90:	0b468693          	addi	a3,a3,180 # ffffffffc020ce40 <default_pmm_manager+0x8b0>
ffffffffc0203d94:	00008617          	auipc	a2,0x8
ffffffffc0203d98:	d1460613          	addi	a2,a2,-748 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203d9c:	09e00593          	li	a1,158
ffffffffc0203da0:	00009517          	auipc	a0,0x9
ffffffffc0203da4:	03050513          	addi	a0,a0,48 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0203da8:	ef6fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203dac <mm_map>:
ffffffffc0203dac:	7139                	addi	sp,sp,-64
ffffffffc0203dae:	f822                	sd	s0,48(sp)
ffffffffc0203db0:	6405                	lui	s0,0x1
ffffffffc0203db2:	147d                	addi	s0,s0,-1
ffffffffc0203db4:	77fd                	lui	a5,0xfffff
ffffffffc0203db6:	9622                	add	a2,a2,s0
ffffffffc0203db8:	962e                	add	a2,a2,a1
ffffffffc0203dba:	f426                	sd	s1,40(sp)
ffffffffc0203dbc:	fc06                	sd	ra,56(sp)
ffffffffc0203dbe:	00f5f4b3          	and	s1,a1,a5
ffffffffc0203dc2:	f04a                	sd	s2,32(sp)
ffffffffc0203dc4:	ec4e                	sd	s3,24(sp)
ffffffffc0203dc6:	e852                	sd	s4,16(sp)
ffffffffc0203dc8:	e456                	sd	s5,8(sp)
ffffffffc0203dca:	002005b7          	lui	a1,0x200
ffffffffc0203dce:	00f67433          	and	s0,a2,a5
ffffffffc0203dd2:	06b4e363          	bltu	s1,a1,ffffffffc0203e38 <mm_map+0x8c>
ffffffffc0203dd6:	0684f163          	bgeu	s1,s0,ffffffffc0203e38 <mm_map+0x8c>
ffffffffc0203dda:	4785                	li	a5,1
ffffffffc0203ddc:	07fe                	slli	a5,a5,0x1f
ffffffffc0203dde:	0487ed63          	bltu	a5,s0,ffffffffc0203e38 <mm_map+0x8c>
ffffffffc0203de2:	89aa                	mv	s3,a0
ffffffffc0203de4:	cd21                	beqz	a0,ffffffffc0203e3c <mm_map+0x90>
ffffffffc0203de6:	85a6                	mv	a1,s1
ffffffffc0203de8:	8ab6                	mv	s5,a3
ffffffffc0203dea:	8a3a                	mv	s4,a4
ffffffffc0203dec:	e5fff0ef          	jal	ra,ffffffffc0203c4a <find_vma>
ffffffffc0203df0:	c501                	beqz	a0,ffffffffc0203df8 <mm_map+0x4c>
ffffffffc0203df2:	651c                	ld	a5,8(a0)
ffffffffc0203df4:	0487e263          	bltu	a5,s0,ffffffffc0203e38 <mm_map+0x8c>
ffffffffc0203df8:	03000513          	li	a0,48
ffffffffc0203dfc:	996fe0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc0203e00:	892a                	mv	s2,a0
ffffffffc0203e02:	5571                	li	a0,-4
ffffffffc0203e04:	02090163          	beqz	s2,ffffffffc0203e26 <mm_map+0x7a>
ffffffffc0203e08:	854e                	mv	a0,s3
ffffffffc0203e0a:	00993423          	sd	s1,8(s2)
ffffffffc0203e0e:	00893823          	sd	s0,16(s2)
ffffffffc0203e12:	01592c23          	sw	s5,24(s2)
ffffffffc0203e16:	85ca                	mv	a1,s2
ffffffffc0203e18:	e73ff0ef          	jal	ra,ffffffffc0203c8a <insert_vma_struct>
ffffffffc0203e1c:	4501                	li	a0,0
ffffffffc0203e1e:	000a0463          	beqz	s4,ffffffffc0203e26 <mm_map+0x7a>
ffffffffc0203e22:	012a3023          	sd	s2,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0203e26:	70e2                	ld	ra,56(sp)
ffffffffc0203e28:	7442                	ld	s0,48(sp)
ffffffffc0203e2a:	74a2                	ld	s1,40(sp)
ffffffffc0203e2c:	7902                	ld	s2,32(sp)
ffffffffc0203e2e:	69e2                	ld	s3,24(sp)
ffffffffc0203e30:	6a42                	ld	s4,16(sp)
ffffffffc0203e32:	6aa2                	ld	s5,8(sp)
ffffffffc0203e34:	6121                	addi	sp,sp,64
ffffffffc0203e36:	8082                	ret
ffffffffc0203e38:	5575                	li	a0,-3
ffffffffc0203e3a:	b7f5                	j	ffffffffc0203e26 <mm_map+0x7a>
ffffffffc0203e3c:	00009697          	auipc	a3,0x9
ffffffffc0203e40:	01c68693          	addi	a3,a3,28 # ffffffffc020ce58 <default_pmm_manager+0x8c8>
ffffffffc0203e44:	00008617          	auipc	a2,0x8
ffffffffc0203e48:	c6460613          	addi	a2,a2,-924 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203e4c:	0b300593          	li	a1,179
ffffffffc0203e50:	00009517          	auipc	a0,0x9
ffffffffc0203e54:	f8050513          	addi	a0,a0,-128 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0203e58:	e46fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203e5c <dup_mmap>:
ffffffffc0203e5c:	7139                	addi	sp,sp,-64
ffffffffc0203e5e:	fc06                	sd	ra,56(sp)
ffffffffc0203e60:	f822                	sd	s0,48(sp)
ffffffffc0203e62:	f426                	sd	s1,40(sp)
ffffffffc0203e64:	f04a                	sd	s2,32(sp)
ffffffffc0203e66:	ec4e                	sd	s3,24(sp)
ffffffffc0203e68:	e852                	sd	s4,16(sp)
ffffffffc0203e6a:	e456                	sd	s5,8(sp)
ffffffffc0203e6c:	c52d                	beqz	a0,ffffffffc0203ed6 <dup_mmap+0x7a>
ffffffffc0203e6e:	892a                	mv	s2,a0
ffffffffc0203e70:	84ae                	mv	s1,a1
ffffffffc0203e72:	842e                	mv	s0,a1
ffffffffc0203e74:	e595                	bnez	a1,ffffffffc0203ea0 <dup_mmap+0x44>
ffffffffc0203e76:	a085                	j	ffffffffc0203ed6 <dup_mmap+0x7a>
ffffffffc0203e78:	854a                	mv	a0,s2
ffffffffc0203e7a:	0155b423          	sd	s5,8(a1) # 200008 <_binary_bin_sfs_img_size+0x18ad08>
ffffffffc0203e7e:	0145b823          	sd	s4,16(a1)
ffffffffc0203e82:	0135ac23          	sw	s3,24(a1)
ffffffffc0203e86:	e05ff0ef          	jal	ra,ffffffffc0203c8a <insert_vma_struct>
ffffffffc0203e8a:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_bin_swap_img_size-0x6d10>
ffffffffc0203e8e:	fe843603          	ld	a2,-24(s0)
ffffffffc0203e92:	6c8c                	ld	a1,24(s1)
ffffffffc0203e94:	01893503          	ld	a0,24(s2)
ffffffffc0203e98:	4701                	li	a4,0
ffffffffc0203e9a:	a2dff0ef          	jal	ra,ffffffffc02038c6 <copy_range>
ffffffffc0203e9e:	e105                	bnez	a0,ffffffffc0203ebe <dup_mmap+0x62>
ffffffffc0203ea0:	6000                	ld	s0,0(s0)
ffffffffc0203ea2:	02848863          	beq	s1,s0,ffffffffc0203ed2 <dup_mmap+0x76>
ffffffffc0203ea6:	03000513          	li	a0,48
ffffffffc0203eaa:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203eae:	ff043a03          	ld	s4,-16(s0)
ffffffffc0203eb2:	ff842983          	lw	s3,-8(s0)
ffffffffc0203eb6:	8dcfe0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc0203eba:	85aa                	mv	a1,a0
ffffffffc0203ebc:	fd55                	bnez	a0,ffffffffc0203e78 <dup_mmap+0x1c>
ffffffffc0203ebe:	5571                	li	a0,-4
ffffffffc0203ec0:	70e2                	ld	ra,56(sp)
ffffffffc0203ec2:	7442                	ld	s0,48(sp)
ffffffffc0203ec4:	74a2                	ld	s1,40(sp)
ffffffffc0203ec6:	7902                	ld	s2,32(sp)
ffffffffc0203ec8:	69e2                	ld	s3,24(sp)
ffffffffc0203eca:	6a42                	ld	s4,16(sp)
ffffffffc0203ecc:	6aa2                	ld	s5,8(sp)
ffffffffc0203ece:	6121                	addi	sp,sp,64
ffffffffc0203ed0:	8082                	ret
ffffffffc0203ed2:	4501                	li	a0,0
ffffffffc0203ed4:	b7f5                	j	ffffffffc0203ec0 <dup_mmap+0x64>
ffffffffc0203ed6:	00009697          	auipc	a3,0x9
ffffffffc0203eda:	f9268693          	addi	a3,a3,-110 # ffffffffc020ce68 <default_pmm_manager+0x8d8>
ffffffffc0203ede:	00008617          	auipc	a2,0x8
ffffffffc0203ee2:	bca60613          	addi	a2,a2,-1078 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203ee6:	0cf00593          	li	a1,207
ffffffffc0203eea:	00009517          	auipc	a0,0x9
ffffffffc0203eee:	ee650513          	addi	a0,a0,-282 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0203ef2:	dacfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203ef6 <exit_mmap>:
ffffffffc0203ef6:	1101                	addi	sp,sp,-32
ffffffffc0203ef8:	ec06                	sd	ra,24(sp)
ffffffffc0203efa:	e822                	sd	s0,16(sp)
ffffffffc0203efc:	e426                	sd	s1,8(sp)
ffffffffc0203efe:	e04a                	sd	s2,0(sp)
ffffffffc0203f00:	c531                	beqz	a0,ffffffffc0203f4c <exit_mmap+0x56>
ffffffffc0203f02:	591c                	lw	a5,48(a0)
ffffffffc0203f04:	84aa                	mv	s1,a0
ffffffffc0203f06:	e3b9                	bnez	a5,ffffffffc0203f4c <exit_mmap+0x56>
ffffffffc0203f08:	6500                	ld	s0,8(a0)
ffffffffc0203f0a:	01853903          	ld	s2,24(a0)
ffffffffc0203f0e:	02850663          	beq	a0,s0,ffffffffc0203f3a <exit_mmap+0x44>
ffffffffc0203f12:	ff043603          	ld	a2,-16(s0)
ffffffffc0203f16:	fe843583          	ld	a1,-24(s0)
ffffffffc0203f1a:	854a                	mv	a0,s2
ffffffffc0203f1c:	e4efe0ef          	jal	ra,ffffffffc020256a <unmap_range>
ffffffffc0203f20:	6400                	ld	s0,8(s0)
ffffffffc0203f22:	fe8498e3          	bne	s1,s0,ffffffffc0203f12 <exit_mmap+0x1c>
ffffffffc0203f26:	6400                	ld	s0,8(s0)
ffffffffc0203f28:	00848c63          	beq	s1,s0,ffffffffc0203f40 <exit_mmap+0x4a>
ffffffffc0203f2c:	ff043603          	ld	a2,-16(s0)
ffffffffc0203f30:	fe843583          	ld	a1,-24(s0)
ffffffffc0203f34:	854a                	mv	a0,s2
ffffffffc0203f36:	f7afe0ef          	jal	ra,ffffffffc02026b0 <exit_range>
ffffffffc0203f3a:	6400                	ld	s0,8(s0)
ffffffffc0203f3c:	fe8498e3          	bne	s1,s0,ffffffffc0203f2c <exit_mmap+0x36>
ffffffffc0203f40:	60e2                	ld	ra,24(sp)
ffffffffc0203f42:	6442                	ld	s0,16(sp)
ffffffffc0203f44:	64a2                	ld	s1,8(sp)
ffffffffc0203f46:	6902                	ld	s2,0(sp)
ffffffffc0203f48:	6105                	addi	sp,sp,32
ffffffffc0203f4a:	8082                	ret
ffffffffc0203f4c:	00009697          	auipc	a3,0x9
ffffffffc0203f50:	f3c68693          	addi	a3,a3,-196 # ffffffffc020ce88 <default_pmm_manager+0x8f8>
ffffffffc0203f54:	00008617          	auipc	a2,0x8
ffffffffc0203f58:	b5460613          	addi	a2,a2,-1196 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203f5c:	0e800593          	li	a1,232
ffffffffc0203f60:	00009517          	auipc	a0,0x9
ffffffffc0203f64:	e7050513          	addi	a0,a0,-400 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0203f68:	d36fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203f6c <vmm_init>:
ffffffffc0203f6c:	7139                	addi	sp,sp,-64
ffffffffc0203f6e:	05800513          	li	a0,88
ffffffffc0203f72:	fc06                	sd	ra,56(sp)
ffffffffc0203f74:	f822                	sd	s0,48(sp)
ffffffffc0203f76:	f426                	sd	s1,40(sp)
ffffffffc0203f78:	f04a                	sd	s2,32(sp)
ffffffffc0203f7a:	ec4e                	sd	s3,24(sp)
ffffffffc0203f7c:	e852                	sd	s4,16(sp)
ffffffffc0203f7e:	e456                	sd	s5,8(sp)
ffffffffc0203f80:	812fe0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc0203f84:	2e050963          	beqz	a0,ffffffffc0204276 <vmm_init+0x30a>
ffffffffc0203f88:	e508                	sd	a0,8(a0)
ffffffffc0203f8a:	e108                	sd	a0,0(a0)
ffffffffc0203f8c:	00053823          	sd	zero,16(a0)
ffffffffc0203f90:	00053c23          	sd	zero,24(a0)
ffffffffc0203f94:	02052023          	sw	zero,32(a0)
ffffffffc0203f98:	02053423          	sd	zero,40(a0)
ffffffffc0203f9c:	02052823          	sw	zero,48(a0)
ffffffffc0203fa0:	84aa                	mv	s1,a0
ffffffffc0203fa2:	4585                	li	a1,1
ffffffffc0203fa4:	03850513          	addi	a0,a0,56
ffffffffc0203fa8:	5b6000ef          	jal	ra,ffffffffc020455e <sem_init>
ffffffffc0203fac:	03200413          	li	s0,50
ffffffffc0203fb0:	a811                	j	ffffffffc0203fc4 <vmm_init+0x58>
ffffffffc0203fb2:	e500                	sd	s0,8(a0)
ffffffffc0203fb4:	e91c                	sd	a5,16(a0)
ffffffffc0203fb6:	00052c23          	sw	zero,24(a0)
ffffffffc0203fba:	146d                	addi	s0,s0,-5
ffffffffc0203fbc:	8526                	mv	a0,s1
ffffffffc0203fbe:	ccdff0ef          	jal	ra,ffffffffc0203c8a <insert_vma_struct>
ffffffffc0203fc2:	c80d                	beqz	s0,ffffffffc0203ff4 <vmm_init+0x88>
ffffffffc0203fc4:	03000513          	li	a0,48
ffffffffc0203fc8:	fcbfd0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc0203fcc:	85aa                	mv	a1,a0
ffffffffc0203fce:	00240793          	addi	a5,s0,2
ffffffffc0203fd2:	f165                	bnez	a0,ffffffffc0203fb2 <vmm_init+0x46>
ffffffffc0203fd4:	00009697          	auipc	a3,0x9
ffffffffc0203fd8:	04c68693          	addi	a3,a3,76 # ffffffffc020d020 <default_pmm_manager+0xa90>
ffffffffc0203fdc:	00008617          	auipc	a2,0x8
ffffffffc0203fe0:	acc60613          	addi	a2,a2,-1332 # ffffffffc020baa8 <commands+0x210>
ffffffffc0203fe4:	12c00593          	li	a1,300
ffffffffc0203fe8:	00009517          	auipc	a0,0x9
ffffffffc0203fec:	de850513          	addi	a0,a0,-536 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0203ff0:	caefc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ff4:	03700413          	li	s0,55
ffffffffc0203ff8:	1f900913          	li	s2,505
ffffffffc0203ffc:	a819                	j	ffffffffc0204012 <vmm_init+0xa6>
ffffffffc0203ffe:	e500                	sd	s0,8(a0)
ffffffffc0204000:	e91c                	sd	a5,16(a0)
ffffffffc0204002:	00052c23          	sw	zero,24(a0)
ffffffffc0204006:	0415                	addi	s0,s0,5
ffffffffc0204008:	8526                	mv	a0,s1
ffffffffc020400a:	c81ff0ef          	jal	ra,ffffffffc0203c8a <insert_vma_struct>
ffffffffc020400e:	03240a63          	beq	s0,s2,ffffffffc0204042 <vmm_init+0xd6>
ffffffffc0204012:	03000513          	li	a0,48
ffffffffc0204016:	f7dfd0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc020401a:	85aa                	mv	a1,a0
ffffffffc020401c:	00240793          	addi	a5,s0,2
ffffffffc0204020:	fd79                	bnez	a0,ffffffffc0203ffe <vmm_init+0x92>
ffffffffc0204022:	00009697          	auipc	a3,0x9
ffffffffc0204026:	ffe68693          	addi	a3,a3,-2 # ffffffffc020d020 <default_pmm_manager+0xa90>
ffffffffc020402a:	00008617          	auipc	a2,0x8
ffffffffc020402e:	a7e60613          	addi	a2,a2,-1410 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204032:	13300593          	li	a1,307
ffffffffc0204036:	00009517          	auipc	a0,0x9
ffffffffc020403a:	d9a50513          	addi	a0,a0,-614 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc020403e:	c60fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204042:	649c                	ld	a5,8(s1)
ffffffffc0204044:	471d                	li	a4,7
ffffffffc0204046:	1fb00593          	li	a1,507
ffffffffc020404a:	16f48663          	beq	s1,a5,ffffffffc02041b6 <vmm_init+0x24a>
ffffffffc020404e:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd686d8>
ffffffffc0204052:	ffe70693          	addi	a3,a4,-2
ffffffffc0204056:	10d61063          	bne	a2,a3,ffffffffc0204156 <vmm_init+0x1ea>
ffffffffc020405a:	ff07b683          	ld	a3,-16(a5)
ffffffffc020405e:	0ed71c63          	bne	a4,a3,ffffffffc0204156 <vmm_init+0x1ea>
ffffffffc0204062:	0715                	addi	a4,a4,5
ffffffffc0204064:	679c                	ld	a5,8(a5)
ffffffffc0204066:	feb712e3          	bne	a4,a1,ffffffffc020404a <vmm_init+0xde>
ffffffffc020406a:	4a1d                	li	s4,7
ffffffffc020406c:	4415                	li	s0,5
ffffffffc020406e:	1f900a93          	li	s5,505
ffffffffc0204072:	85a2                	mv	a1,s0
ffffffffc0204074:	8526                	mv	a0,s1
ffffffffc0204076:	bd5ff0ef          	jal	ra,ffffffffc0203c4a <find_vma>
ffffffffc020407a:	892a                	mv	s2,a0
ffffffffc020407c:	16050d63          	beqz	a0,ffffffffc02041f6 <vmm_init+0x28a>
ffffffffc0204080:	00140593          	addi	a1,s0,1
ffffffffc0204084:	8526                	mv	a0,s1
ffffffffc0204086:	bc5ff0ef          	jal	ra,ffffffffc0203c4a <find_vma>
ffffffffc020408a:	89aa                	mv	s3,a0
ffffffffc020408c:	14050563          	beqz	a0,ffffffffc02041d6 <vmm_init+0x26a>
ffffffffc0204090:	85d2                	mv	a1,s4
ffffffffc0204092:	8526                	mv	a0,s1
ffffffffc0204094:	bb7ff0ef          	jal	ra,ffffffffc0203c4a <find_vma>
ffffffffc0204098:	16051f63          	bnez	a0,ffffffffc0204216 <vmm_init+0x2aa>
ffffffffc020409c:	00340593          	addi	a1,s0,3
ffffffffc02040a0:	8526                	mv	a0,s1
ffffffffc02040a2:	ba9ff0ef          	jal	ra,ffffffffc0203c4a <find_vma>
ffffffffc02040a6:	1a051863          	bnez	a0,ffffffffc0204256 <vmm_init+0x2ea>
ffffffffc02040aa:	00440593          	addi	a1,s0,4
ffffffffc02040ae:	8526                	mv	a0,s1
ffffffffc02040b0:	b9bff0ef          	jal	ra,ffffffffc0203c4a <find_vma>
ffffffffc02040b4:	18051163          	bnez	a0,ffffffffc0204236 <vmm_init+0x2ca>
ffffffffc02040b8:	00893783          	ld	a5,8(s2)
ffffffffc02040bc:	0a879d63          	bne	a5,s0,ffffffffc0204176 <vmm_init+0x20a>
ffffffffc02040c0:	01093783          	ld	a5,16(s2)
ffffffffc02040c4:	0b479963          	bne	a5,s4,ffffffffc0204176 <vmm_init+0x20a>
ffffffffc02040c8:	0089b783          	ld	a5,8(s3)
ffffffffc02040cc:	0c879563          	bne	a5,s0,ffffffffc0204196 <vmm_init+0x22a>
ffffffffc02040d0:	0109b783          	ld	a5,16(s3)
ffffffffc02040d4:	0d479163          	bne	a5,s4,ffffffffc0204196 <vmm_init+0x22a>
ffffffffc02040d8:	0415                	addi	s0,s0,5
ffffffffc02040da:	0a15                	addi	s4,s4,5
ffffffffc02040dc:	f9541be3          	bne	s0,s5,ffffffffc0204072 <vmm_init+0x106>
ffffffffc02040e0:	4411                	li	s0,4
ffffffffc02040e2:	597d                	li	s2,-1
ffffffffc02040e4:	85a2                	mv	a1,s0
ffffffffc02040e6:	8526                	mv	a0,s1
ffffffffc02040e8:	b63ff0ef          	jal	ra,ffffffffc0203c4a <find_vma>
ffffffffc02040ec:	0004059b          	sext.w	a1,s0
ffffffffc02040f0:	c90d                	beqz	a0,ffffffffc0204122 <vmm_init+0x1b6>
ffffffffc02040f2:	6914                	ld	a3,16(a0)
ffffffffc02040f4:	6510                	ld	a2,8(a0)
ffffffffc02040f6:	00009517          	auipc	a0,0x9
ffffffffc02040fa:	eb250513          	addi	a0,a0,-334 # ffffffffc020cfa8 <default_pmm_manager+0xa18>
ffffffffc02040fe:	8a8fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0204102:	00009697          	auipc	a3,0x9
ffffffffc0204106:	ece68693          	addi	a3,a3,-306 # ffffffffc020cfd0 <default_pmm_manager+0xa40>
ffffffffc020410a:	00008617          	auipc	a2,0x8
ffffffffc020410e:	99e60613          	addi	a2,a2,-1634 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204112:	15900593          	li	a1,345
ffffffffc0204116:	00009517          	auipc	a0,0x9
ffffffffc020411a:	cba50513          	addi	a0,a0,-838 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc020411e:	b80fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204122:	147d                	addi	s0,s0,-1
ffffffffc0204124:	fd2410e3          	bne	s0,s2,ffffffffc02040e4 <vmm_init+0x178>
ffffffffc0204128:	8526                	mv	a0,s1
ffffffffc020412a:	c31ff0ef          	jal	ra,ffffffffc0203d5a <mm_destroy>
ffffffffc020412e:	00009517          	auipc	a0,0x9
ffffffffc0204132:	eba50513          	addi	a0,a0,-326 # ffffffffc020cfe8 <default_pmm_manager+0xa58>
ffffffffc0204136:	870fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020413a:	7442                	ld	s0,48(sp)
ffffffffc020413c:	70e2                	ld	ra,56(sp)
ffffffffc020413e:	74a2                	ld	s1,40(sp)
ffffffffc0204140:	7902                	ld	s2,32(sp)
ffffffffc0204142:	69e2                	ld	s3,24(sp)
ffffffffc0204144:	6a42                	ld	s4,16(sp)
ffffffffc0204146:	6aa2                	ld	s5,8(sp)
ffffffffc0204148:	00009517          	auipc	a0,0x9
ffffffffc020414c:	ec050513          	addi	a0,a0,-320 # ffffffffc020d008 <default_pmm_manager+0xa78>
ffffffffc0204150:	6121                	addi	sp,sp,64
ffffffffc0204152:	854fc06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0204156:	00009697          	auipc	a3,0x9
ffffffffc020415a:	d6a68693          	addi	a3,a3,-662 # ffffffffc020cec0 <default_pmm_manager+0x930>
ffffffffc020415e:	00008617          	auipc	a2,0x8
ffffffffc0204162:	94a60613          	addi	a2,a2,-1718 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204166:	13d00593          	li	a1,317
ffffffffc020416a:	00009517          	auipc	a0,0x9
ffffffffc020416e:	c6650513          	addi	a0,a0,-922 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0204172:	b2cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204176:	00009697          	auipc	a3,0x9
ffffffffc020417a:	dd268693          	addi	a3,a3,-558 # ffffffffc020cf48 <default_pmm_manager+0x9b8>
ffffffffc020417e:	00008617          	auipc	a2,0x8
ffffffffc0204182:	92a60613          	addi	a2,a2,-1750 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204186:	14e00593          	li	a1,334
ffffffffc020418a:	00009517          	auipc	a0,0x9
ffffffffc020418e:	c4650513          	addi	a0,a0,-954 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0204192:	b0cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204196:	00009697          	auipc	a3,0x9
ffffffffc020419a:	de268693          	addi	a3,a3,-542 # ffffffffc020cf78 <default_pmm_manager+0x9e8>
ffffffffc020419e:	00008617          	auipc	a2,0x8
ffffffffc02041a2:	90a60613          	addi	a2,a2,-1782 # ffffffffc020baa8 <commands+0x210>
ffffffffc02041a6:	14f00593          	li	a1,335
ffffffffc02041aa:	00009517          	auipc	a0,0x9
ffffffffc02041ae:	c2650513          	addi	a0,a0,-986 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc02041b2:	aecfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041b6:	00009697          	auipc	a3,0x9
ffffffffc02041ba:	cf268693          	addi	a3,a3,-782 # ffffffffc020cea8 <default_pmm_manager+0x918>
ffffffffc02041be:	00008617          	auipc	a2,0x8
ffffffffc02041c2:	8ea60613          	addi	a2,a2,-1814 # ffffffffc020baa8 <commands+0x210>
ffffffffc02041c6:	13b00593          	li	a1,315
ffffffffc02041ca:	00009517          	auipc	a0,0x9
ffffffffc02041ce:	c0650513          	addi	a0,a0,-1018 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc02041d2:	accfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041d6:	00009697          	auipc	a3,0x9
ffffffffc02041da:	d3268693          	addi	a3,a3,-718 # ffffffffc020cf08 <default_pmm_manager+0x978>
ffffffffc02041de:	00008617          	auipc	a2,0x8
ffffffffc02041e2:	8ca60613          	addi	a2,a2,-1846 # ffffffffc020baa8 <commands+0x210>
ffffffffc02041e6:	14600593          	li	a1,326
ffffffffc02041ea:	00009517          	auipc	a0,0x9
ffffffffc02041ee:	be650513          	addi	a0,a0,-1050 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc02041f2:	aacfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041f6:	00009697          	auipc	a3,0x9
ffffffffc02041fa:	d0268693          	addi	a3,a3,-766 # ffffffffc020cef8 <default_pmm_manager+0x968>
ffffffffc02041fe:	00008617          	auipc	a2,0x8
ffffffffc0204202:	8aa60613          	addi	a2,a2,-1878 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204206:	14400593          	li	a1,324
ffffffffc020420a:	00009517          	auipc	a0,0x9
ffffffffc020420e:	bc650513          	addi	a0,a0,-1082 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0204212:	a8cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204216:	00009697          	auipc	a3,0x9
ffffffffc020421a:	d0268693          	addi	a3,a3,-766 # ffffffffc020cf18 <default_pmm_manager+0x988>
ffffffffc020421e:	00008617          	auipc	a2,0x8
ffffffffc0204222:	88a60613          	addi	a2,a2,-1910 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204226:	14800593          	li	a1,328
ffffffffc020422a:	00009517          	auipc	a0,0x9
ffffffffc020422e:	ba650513          	addi	a0,a0,-1114 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0204232:	a6cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204236:	00009697          	auipc	a3,0x9
ffffffffc020423a:	d0268693          	addi	a3,a3,-766 # ffffffffc020cf38 <default_pmm_manager+0x9a8>
ffffffffc020423e:	00008617          	auipc	a2,0x8
ffffffffc0204242:	86a60613          	addi	a2,a2,-1942 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204246:	14c00593          	li	a1,332
ffffffffc020424a:	00009517          	auipc	a0,0x9
ffffffffc020424e:	b8650513          	addi	a0,a0,-1146 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0204252:	a4cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204256:	00009697          	auipc	a3,0x9
ffffffffc020425a:	cd268693          	addi	a3,a3,-814 # ffffffffc020cf28 <default_pmm_manager+0x998>
ffffffffc020425e:	00008617          	auipc	a2,0x8
ffffffffc0204262:	84a60613          	addi	a2,a2,-1974 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204266:	14a00593          	li	a1,330
ffffffffc020426a:	00009517          	auipc	a0,0x9
ffffffffc020426e:	b6650513          	addi	a0,a0,-1178 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0204272:	a2cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204276:	00009697          	auipc	a3,0x9
ffffffffc020427a:	be268693          	addi	a3,a3,-1054 # ffffffffc020ce58 <default_pmm_manager+0x8c8>
ffffffffc020427e:	00008617          	auipc	a2,0x8
ffffffffc0204282:	82a60613          	addi	a2,a2,-2006 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204286:	12400593          	li	a1,292
ffffffffc020428a:	00009517          	auipc	a0,0x9
ffffffffc020428e:	b4650513          	addi	a0,a0,-1210 # ffffffffc020cdd0 <default_pmm_manager+0x840>
ffffffffc0204292:	a0cfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204296 <user_mem_check>:
ffffffffc0204296:	7179                	addi	sp,sp,-48
ffffffffc0204298:	f022                	sd	s0,32(sp)
ffffffffc020429a:	f406                	sd	ra,40(sp)
ffffffffc020429c:	ec26                	sd	s1,24(sp)
ffffffffc020429e:	e84a                	sd	s2,16(sp)
ffffffffc02042a0:	e44e                	sd	s3,8(sp)
ffffffffc02042a2:	e052                	sd	s4,0(sp)
ffffffffc02042a4:	842e                	mv	s0,a1
ffffffffc02042a6:	c135                	beqz	a0,ffffffffc020430a <user_mem_check+0x74>
ffffffffc02042a8:	002007b7          	lui	a5,0x200
ffffffffc02042ac:	04f5e663          	bltu	a1,a5,ffffffffc02042f8 <user_mem_check+0x62>
ffffffffc02042b0:	00c584b3          	add	s1,a1,a2
ffffffffc02042b4:	0495f263          	bgeu	a1,s1,ffffffffc02042f8 <user_mem_check+0x62>
ffffffffc02042b8:	4785                	li	a5,1
ffffffffc02042ba:	07fe                	slli	a5,a5,0x1f
ffffffffc02042bc:	0297ee63          	bltu	a5,s1,ffffffffc02042f8 <user_mem_check+0x62>
ffffffffc02042c0:	892a                	mv	s2,a0
ffffffffc02042c2:	89b6                	mv	s3,a3
ffffffffc02042c4:	6a05                	lui	s4,0x1
ffffffffc02042c6:	a821                	j	ffffffffc02042de <user_mem_check+0x48>
ffffffffc02042c8:	0027f693          	andi	a3,a5,2
ffffffffc02042cc:	9752                	add	a4,a4,s4
ffffffffc02042ce:	8ba1                	andi	a5,a5,8
ffffffffc02042d0:	c685                	beqz	a3,ffffffffc02042f8 <user_mem_check+0x62>
ffffffffc02042d2:	c399                	beqz	a5,ffffffffc02042d8 <user_mem_check+0x42>
ffffffffc02042d4:	02e46263          	bltu	s0,a4,ffffffffc02042f8 <user_mem_check+0x62>
ffffffffc02042d8:	6900                	ld	s0,16(a0)
ffffffffc02042da:	04947663          	bgeu	s0,s1,ffffffffc0204326 <user_mem_check+0x90>
ffffffffc02042de:	85a2                	mv	a1,s0
ffffffffc02042e0:	854a                	mv	a0,s2
ffffffffc02042e2:	969ff0ef          	jal	ra,ffffffffc0203c4a <find_vma>
ffffffffc02042e6:	c909                	beqz	a0,ffffffffc02042f8 <user_mem_check+0x62>
ffffffffc02042e8:	6518                	ld	a4,8(a0)
ffffffffc02042ea:	00e46763          	bltu	s0,a4,ffffffffc02042f8 <user_mem_check+0x62>
ffffffffc02042ee:	4d1c                	lw	a5,24(a0)
ffffffffc02042f0:	fc099ce3          	bnez	s3,ffffffffc02042c8 <user_mem_check+0x32>
ffffffffc02042f4:	8b85                	andi	a5,a5,1
ffffffffc02042f6:	f3ed                	bnez	a5,ffffffffc02042d8 <user_mem_check+0x42>
ffffffffc02042f8:	4501                	li	a0,0
ffffffffc02042fa:	70a2                	ld	ra,40(sp)
ffffffffc02042fc:	7402                	ld	s0,32(sp)
ffffffffc02042fe:	64e2                	ld	s1,24(sp)
ffffffffc0204300:	6942                	ld	s2,16(sp)
ffffffffc0204302:	69a2                	ld	s3,8(sp)
ffffffffc0204304:	6a02                	ld	s4,0(sp)
ffffffffc0204306:	6145                	addi	sp,sp,48
ffffffffc0204308:	8082                	ret
ffffffffc020430a:	c02007b7          	lui	a5,0xc0200
ffffffffc020430e:	4501                	li	a0,0
ffffffffc0204310:	fef5e5e3          	bltu	a1,a5,ffffffffc02042fa <user_mem_check+0x64>
ffffffffc0204314:	962e                	add	a2,a2,a1
ffffffffc0204316:	fec5f2e3          	bgeu	a1,a2,ffffffffc02042fa <user_mem_check+0x64>
ffffffffc020431a:	c8000537          	lui	a0,0xc8000
ffffffffc020431e:	0505                	addi	a0,a0,1
ffffffffc0204320:	00a63533          	sltu	a0,a2,a0
ffffffffc0204324:	bfd9                	j	ffffffffc02042fa <user_mem_check+0x64>
ffffffffc0204326:	4505                	li	a0,1
ffffffffc0204328:	bfc9                	j	ffffffffc02042fa <user_mem_check+0x64>

ffffffffc020432a <copy_from_user>:
ffffffffc020432a:	1101                	addi	sp,sp,-32
ffffffffc020432c:	e822                	sd	s0,16(sp)
ffffffffc020432e:	e426                	sd	s1,8(sp)
ffffffffc0204330:	8432                	mv	s0,a2
ffffffffc0204332:	84b6                	mv	s1,a3
ffffffffc0204334:	e04a                	sd	s2,0(sp)
ffffffffc0204336:	86ba                	mv	a3,a4
ffffffffc0204338:	892e                	mv	s2,a1
ffffffffc020433a:	8626                	mv	a2,s1
ffffffffc020433c:	85a2                	mv	a1,s0
ffffffffc020433e:	ec06                	sd	ra,24(sp)
ffffffffc0204340:	f57ff0ef          	jal	ra,ffffffffc0204296 <user_mem_check>
ffffffffc0204344:	c519                	beqz	a0,ffffffffc0204352 <copy_from_user+0x28>
ffffffffc0204346:	8626                	mv	a2,s1
ffffffffc0204348:	85a2                	mv	a1,s0
ffffffffc020434a:	854a                	mv	a0,s2
ffffffffc020434c:	2cc070ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc0204350:	4505                	li	a0,1
ffffffffc0204352:	60e2                	ld	ra,24(sp)
ffffffffc0204354:	6442                	ld	s0,16(sp)
ffffffffc0204356:	64a2                	ld	s1,8(sp)
ffffffffc0204358:	6902                	ld	s2,0(sp)
ffffffffc020435a:	6105                	addi	sp,sp,32
ffffffffc020435c:	8082                	ret

ffffffffc020435e <copy_to_user>:
ffffffffc020435e:	1101                	addi	sp,sp,-32
ffffffffc0204360:	e822                	sd	s0,16(sp)
ffffffffc0204362:	8436                	mv	s0,a3
ffffffffc0204364:	e04a                	sd	s2,0(sp)
ffffffffc0204366:	4685                	li	a3,1
ffffffffc0204368:	8932                	mv	s2,a2
ffffffffc020436a:	8622                	mv	a2,s0
ffffffffc020436c:	e426                	sd	s1,8(sp)
ffffffffc020436e:	ec06                	sd	ra,24(sp)
ffffffffc0204370:	84ae                	mv	s1,a1
ffffffffc0204372:	f25ff0ef          	jal	ra,ffffffffc0204296 <user_mem_check>
ffffffffc0204376:	c519                	beqz	a0,ffffffffc0204384 <copy_to_user+0x26>
ffffffffc0204378:	8622                	mv	a2,s0
ffffffffc020437a:	85ca                	mv	a1,s2
ffffffffc020437c:	8526                	mv	a0,s1
ffffffffc020437e:	29a070ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc0204382:	4505                	li	a0,1
ffffffffc0204384:	60e2                	ld	ra,24(sp)
ffffffffc0204386:	6442                	ld	s0,16(sp)
ffffffffc0204388:	64a2                	ld	s1,8(sp)
ffffffffc020438a:	6902                	ld	s2,0(sp)
ffffffffc020438c:	6105                	addi	sp,sp,32
ffffffffc020438e:	8082                	ret

ffffffffc0204390 <copy_string>:
ffffffffc0204390:	7139                	addi	sp,sp,-64
ffffffffc0204392:	ec4e                	sd	s3,24(sp)
ffffffffc0204394:	6985                	lui	s3,0x1
ffffffffc0204396:	99b2                	add	s3,s3,a2
ffffffffc0204398:	77fd                	lui	a5,0xfffff
ffffffffc020439a:	00f9f9b3          	and	s3,s3,a5
ffffffffc020439e:	f426                	sd	s1,40(sp)
ffffffffc02043a0:	f04a                	sd	s2,32(sp)
ffffffffc02043a2:	e852                	sd	s4,16(sp)
ffffffffc02043a4:	e456                	sd	s5,8(sp)
ffffffffc02043a6:	fc06                	sd	ra,56(sp)
ffffffffc02043a8:	f822                	sd	s0,48(sp)
ffffffffc02043aa:	84b2                	mv	s1,a2
ffffffffc02043ac:	8aaa                	mv	s5,a0
ffffffffc02043ae:	8a2e                	mv	s4,a1
ffffffffc02043b0:	8936                	mv	s2,a3
ffffffffc02043b2:	40c989b3          	sub	s3,s3,a2
ffffffffc02043b6:	a015                	j	ffffffffc02043da <copy_string+0x4a>
ffffffffc02043b8:	186070ef          	jal	ra,ffffffffc020b53e <strnlen>
ffffffffc02043bc:	87aa                	mv	a5,a0
ffffffffc02043be:	85a6                	mv	a1,s1
ffffffffc02043c0:	8552                	mv	a0,s4
ffffffffc02043c2:	8622                	mv	a2,s0
ffffffffc02043c4:	0487e363          	bltu	a5,s0,ffffffffc020440a <copy_string+0x7a>
ffffffffc02043c8:	0329f763          	bgeu	s3,s2,ffffffffc02043f6 <copy_string+0x66>
ffffffffc02043cc:	24c070ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc02043d0:	9a22                	add	s4,s4,s0
ffffffffc02043d2:	94a2                	add	s1,s1,s0
ffffffffc02043d4:	40890933          	sub	s2,s2,s0
ffffffffc02043d8:	6985                	lui	s3,0x1
ffffffffc02043da:	4681                	li	a3,0
ffffffffc02043dc:	85a6                	mv	a1,s1
ffffffffc02043de:	8556                	mv	a0,s5
ffffffffc02043e0:	844a                	mv	s0,s2
ffffffffc02043e2:	0129f363          	bgeu	s3,s2,ffffffffc02043e8 <copy_string+0x58>
ffffffffc02043e6:	844e                	mv	s0,s3
ffffffffc02043e8:	8622                	mv	a2,s0
ffffffffc02043ea:	eadff0ef          	jal	ra,ffffffffc0204296 <user_mem_check>
ffffffffc02043ee:	87aa                	mv	a5,a0
ffffffffc02043f0:	85a2                	mv	a1,s0
ffffffffc02043f2:	8526                	mv	a0,s1
ffffffffc02043f4:	f3f1                	bnez	a5,ffffffffc02043b8 <copy_string+0x28>
ffffffffc02043f6:	4501                	li	a0,0
ffffffffc02043f8:	70e2                	ld	ra,56(sp)
ffffffffc02043fa:	7442                	ld	s0,48(sp)
ffffffffc02043fc:	74a2                	ld	s1,40(sp)
ffffffffc02043fe:	7902                	ld	s2,32(sp)
ffffffffc0204400:	69e2                	ld	s3,24(sp)
ffffffffc0204402:	6a42                	ld	s4,16(sp)
ffffffffc0204404:	6aa2                	ld	s5,8(sp)
ffffffffc0204406:	6121                	addi	sp,sp,64
ffffffffc0204408:	8082                	ret
ffffffffc020440a:	00178613          	addi	a2,a5,1 # fffffffffffff001 <end+0x3fd686f1>
ffffffffc020440e:	20a070ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc0204412:	4505                	li	a0,1
ffffffffc0204414:	b7d5                	j	ffffffffc02043f8 <copy_string+0x68>

ffffffffc0204416 <__down.constprop.0>:
ffffffffc0204416:	715d                	addi	sp,sp,-80
ffffffffc0204418:	e0a2                	sd	s0,64(sp)
ffffffffc020441a:	e486                	sd	ra,72(sp)
ffffffffc020441c:	fc26                	sd	s1,56(sp)
ffffffffc020441e:	842a                	mv	s0,a0
ffffffffc0204420:	100027f3          	csrr	a5,sstatus
ffffffffc0204424:	8b89                	andi	a5,a5,2
ffffffffc0204426:	ebb1                	bnez	a5,ffffffffc020447a <__down.constprop.0+0x64>
ffffffffc0204428:	411c                	lw	a5,0(a0)
ffffffffc020442a:	00f05a63          	blez	a5,ffffffffc020443e <__down.constprop.0+0x28>
ffffffffc020442e:	37fd                	addiw	a5,a5,-1
ffffffffc0204430:	c11c                	sw	a5,0(a0)
ffffffffc0204432:	4501                	li	a0,0
ffffffffc0204434:	60a6                	ld	ra,72(sp)
ffffffffc0204436:	6406                	ld	s0,64(sp)
ffffffffc0204438:	74e2                	ld	s1,56(sp)
ffffffffc020443a:	6161                	addi	sp,sp,80
ffffffffc020443c:	8082                	ret
ffffffffc020443e:	00850413          	addi	s0,a0,8 # ffffffffc8000008 <end+0x7d696f8>
ffffffffc0204442:	0024                	addi	s1,sp,8
ffffffffc0204444:	10000613          	li	a2,256
ffffffffc0204448:	85a6                	mv	a1,s1
ffffffffc020444a:	8522                	mv	a0,s0
ffffffffc020444c:	2d8000ef          	jal	ra,ffffffffc0204724 <wait_current_set>
ffffffffc0204450:	60b020ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc0204454:	100027f3          	csrr	a5,sstatus
ffffffffc0204458:	8b89                	andi	a5,a5,2
ffffffffc020445a:	efb9                	bnez	a5,ffffffffc02044b8 <__down.constprop.0+0xa2>
ffffffffc020445c:	8526                	mv	a0,s1
ffffffffc020445e:	19c000ef          	jal	ra,ffffffffc02045fa <wait_in_queue>
ffffffffc0204462:	e531                	bnez	a0,ffffffffc02044ae <__down.constprop.0+0x98>
ffffffffc0204464:	4542                	lw	a0,16(sp)
ffffffffc0204466:	10000793          	li	a5,256
ffffffffc020446a:	fcf515e3          	bne	a0,a5,ffffffffc0204434 <__down.constprop.0+0x1e>
ffffffffc020446e:	60a6                	ld	ra,72(sp)
ffffffffc0204470:	6406                	ld	s0,64(sp)
ffffffffc0204472:	74e2                	ld	s1,56(sp)
ffffffffc0204474:	4501                	li	a0,0
ffffffffc0204476:	6161                	addi	sp,sp,80
ffffffffc0204478:	8082                	ret
ffffffffc020447a:	ff8fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020447e:	401c                	lw	a5,0(s0)
ffffffffc0204480:	00f05c63          	blez	a5,ffffffffc0204498 <__down.constprop.0+0x82>
ffffffffc0204484:	37fd                	addiw	a5,a5,-1
ffffffffc0204486:	c01c                	sw	a5,0(s0)
ffffffffc0204488:	fe4fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020448c:	60a6                	ld	ra,72(sp)
ffffffffc020448e:	6406                	ld	s0,64(sp)
ffffffffc0204490:	74e2                	ld	s1,56(sp)
ffffffffc0204492:	4501                	li	a0,0
ffffffffc0204494:	6161                	addi	sp,sp,80
ffffffffc0204496:	8082                	ret
ffffffffc0204498:	0421                	addi	s0,s0,8
ffffffffc020449a:	0024                	addi	s1,sp,8
ffffffffc020449c:	10000613          	li	a2,256
ffffffffc02044a0:	85a6                	mv	a1,s1
ffffffffc02044a2:	8522                	mv	a0,s0
ffffffffc02044a4:	280000ef          	jal	ra,ffffffffc0204724 <wait_current_set>
ffffffffc02044a8:	fc4fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02044ac:	b755                	j	ffffffffc0204450 <__down.constprop.0+0x3a>
ffffffffc02044ae:	85a6                	mv	a1,s1
ffffffffc02044b0:	8522                	mv	a0,s0
ffffffffc02044b2:	0ee000ef          	jal	ra,ffffffffc02045a0 <wait_queue_del>
ffffffffc02044b6:	b77d                	j	ffffffffc0204464 <__down.constprop.0+0x4e>
ffffffffc02044b8:	fbafc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02044bc:	8526                	mv	a0,s1
ffffffffc02044be:	13c000ef          	jal	ra,ffffffffc02045fa <wait_in_queue>
ffffffffc02044c2:	e501                	bnez	a0,ffffffffc02044ca <__down.constprop.0+0xb4>
ffffffffc02044c4:	fa8fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02044c8:	bf71                	j	ffffffffc0204464 <__down.constprop.0+0x4e>
ffffffffc02044ca:	85a6                	mv	a1,s1
ffffffffc02044cc:	8522                	mv	a0,s0
ffffffffc02044ce:	0d2000ef          	jal	ra,ffffffffc02045a0 <wait_queue_del>
ffffffffc02044d2:	bfcd                	j	ffffffffc02044c4 <__down.constprop.0+0xae>

ffffffffc02044d4 <__up.constprop.0>:
ffffffffc02044d4:	1101                	addi	sp,sp,-32
ffffffffc02044d6:	e822                	sd	s0,16(sp)
ffffffffc02044d8:	ec06                	sd	ra,24(sp)
ffffffffc02044da:	e426                	sd	s1,8(sp)
ffffffffc02044dc:	e04a                	sd	s2,0(sp)
ffffffffc02044de:	842a                	mv	s0,a0
ffffffffc02044e0:	100027f3          	csrr	a5,sstatus
ffffffffc02044e4:	8b89                	andi	a5,a5,2
ffffffffc02044e6:	4901                	li	s2,0
ffffffffc02044e8:	eba1                	bnez	a5,ffffffffc0204538 <__up.constprop.0+0x64>
ffffffffc02044ea:	00840493          	addi	s1,s0,8
ffffffffc02044ee:	8526                	mv	a0,s1
ffffffffc02044f0:	0ee000ef          	jal	ra,ffffffffc02045de <wait_queue_first>
ffffffffc02044f4:	85aa                	mv	a1,a0
ffffffffc02044f6:	cd0d                	beqz	a0,ffffffffc0204530 <__up.constprop.0+0x5c>
ffffffffc02044f8:	6118                	ld	a4,0(a0)
ffffffffc02044fa:	10000793          	li	a5,256
ffffffffc02044fe:	0ec72703          	lw	a4,236(a4)
ffffffffc0204502:	02f71f63          	bne	a4,a5,ffffffffc0204540 <__up.constprop.0+0x6c>
ffffffffc0204506:	4685                	li	a3,1
ffffffffc0204508:	10000613          	li	a2,256
ffffffffc020450c:	8526                	mv	a0,s1
ffffffffc020450e:	0fa000ef          	jal	ra,ffffffffc0204608 <wakeup_wait>
ffffffffc0204512:	00091863          	bnez	s2,ffffffffc0204522 <__up.constprop.0+0x4e>
ffffffffc0204516:	60e2                	ld	ra,24(sp)
ffffffffc0204518:	6442                	ld	s0,16(sp)
ffffffffc020451a:	64a2                	ld	s1,8(sp)
ffffffffc020451c:	6902                	ld	s2,0(sp)
ffffffffc020451e:	6105                	addi	sp,sp,32
ffffffffc0204520:	8082                	ret
ffffffffc0204522:	6442                	ld	s0,16(sp)
ffffffffc0204524:	60e2                	ld	ra,24(sp)
ffffffffc0204526:	64a2                	ld	s1,8(sp)
ffffffffc0204528:	6902                	ld	s2,0(sp)
ffffffffc020452a:	6105                	addi	sp,sp,32
ffffffffc020452c:	f40fc06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0204530:	401c                	lw	a5,0(s0)
ffffffffc0204532:	2785                	addiw	a5,a5,1
ffffffffc0204534:	c01c                	sw	a5,0(s0)
ffffffffc0204536:	bff1                	j	ffffffffc0204512 <__up.constprop.0+0x3e>
ffffffffc0204538:	f3afc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020453c:	4905                	li	s2,1
ffffffffc020453e:	b775                	j	ffffffffc02044ea <__up.constprop.0+0x16>
ffffffffc0204540:	00009697          	auipc	a3,0x9
ffffffffc0204544:	af068693          	addi	a3,a3,-1296 # ffffffffc020d030 <default_pmm_manager+0xaa0>
ffffffffc0204548:	00007617          	auipc	a2,0x7
ffffffffc020454c:	56060613          	addi	a2,a2,1376 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204550:	45e5                	li	a1,25
ffffffffc0204552:	00009517          	auipc	a0,0x9
ffffffffc0204556:	b0650513          	addi	a0,a0,-1274 # ffffffffc020d058 <default_pmm_manager+0xac8>
ffffffffc020455a:	f45fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020455e <sem_init>:
ffffffffc020455e:	c10c                	sw	a1,0(a0)
ffffffffc0204560:	0521                	addi	a0,a0,8
ffffffffc0204562:	a825                	j	ffffffffc020459a <wait_queue_init>

ffffffffc0204564 <up>:
ffffffffc0204564:	f71ff06f          	j	ffffffffc02044d4 <__up.constprop.0>

ffffffffc0204568 <down>:
ffffffffc0204568:	1141                	addi	sp,sp,-16
ffffffffc020456a:	e406                	sd	ra,8(sp)
ffffffffc020456c:	eabff0ef          	jal	ra,ffffffffc0204416 <__down.constprop.0>
ffffffffc0204570:	2501                	sext.w	a0,a0
ffffffffc0204572:	e501                	bnez	a0,ffffffffc020457a <down+0x12>
ffffffffc0204574:	60a2                	ld	ra,8(sp)
ffffffffc0204576:	0141                	addi	sp,sp,16
ffffffffc0204578:	8082                	ret
ffffffffc020457a:	00009697          	auipc	a3,0x9
ffffffffc020457e:	aee68693          	addi	a3,a3,-1298 # ffffffffc020d068 <default_pmm_manager+0xad8>
ffffffffc0204582:	00007617          	auipc	a2,0x7
ffffffffc0204586:	52660613          	addi	a2,a2,1318 # ffffffffc020baa8 <commands+0x210>
ffffffffc020458a:	04000593          	li	a1,64
ffffffffc020458e:	00009517          	auipc	a0,0x9
ffffffffc0204592:	aca50513          	addi	a0,a0,-1334 # ffffffffc020d058 <default_pmm_manager+0xac8>
ffffffffc0204596:	f09fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020459a <wait_queue_init>:
ffffffffc020459a:	e508                	sd	a0,8(a0)
ffffffffc020459c:	e108                	sd	a0,0(a0)
ffffffffc020459e:	8082                	ret

ffffffffc02045a0 <wait_queue_del>:
ffffffffc02045a0:	7198                	ld	a4,32(a1)
ffffffffc02045a2:	01858793          	addi	a5,a1,24
ffffffffc02045a6:	00e78b63          	beq	a5,a4,ffffffffc02045bc <wait_queue_del+0x1c>
ffffffffc02045aa:	6994                	ld	a3,16(a1)
ffffffffc02045ac:	00a69863          	bne	a3,a0,ffffffffc02045bc <wait_queue_del+0x1c>
ffffffffc02045b0:	6d94                	ld	a3,24(a1)
ffffffffc02045b2:	e698                	sd	a4,8(a3)
ffffffffc02045b4:	e314                	sd	a3,0(a4)
ffffffffc02045b6:	f19c                	sd	a5,32(a1)
ffffffffc02045b8:	ed9c                	sd	a5,24(a1)
ffffffffc02045ba:	8082                	ret
ffffffffc02045bc:	1141                	addi	sp,sp,-16
ffffffffc02045be:	00009697          	auipc	a3,0x9
ffffffffc02045c2:	b0a68693          	addi	a3,a3,-1270 # ffffffffc020d0c8 <default_pmm_manager+0xb38>
ffffffffc02045c6:	00007617          	auipc	a2,0x7
ffffffffc02045ca:	4e260613          	addi	a2,a2,1250 # ffffffffc020baa8 <commands+0x210>
ffffffffc02045ce:	45f1                	li	a1,28
ffffffffc02045d0:	00009517          	auipc	a0,0x9
ffffffffc02045d4:	ae050513          	addi	a0,a0,-1312 # ffffffffc020d0b0 <default_pmm_manager+0xb20>
ffffffffc02045d8:	e406                	sd	ra,8(sp)
ffffffffc02045da:	ec5fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02045de <wait_queue_first>:
ffffffffc02045de:	651c                	ld	a5,8(a0)
ffffffffc02045e0:	00f50563          	beq	a0,a5,ffffffffc02045ea <wait_queue_first+0xc>
ffffffffc02045e4:	fe878513          	addi	a0,a5,-24
ffffffffc02045e8:	8082                	ret
ffffffffc02045ea:	4501                	li	a0,0
ffffffffc02045ec:	8082                	ret

ffffffffc02045ee <wait_queue_empty>:
ffffffffc02045ee:	651c                	ld	a5,8(a0)
ffffffffc02045f0:	40a78533          	sub	a0,a5,a0
ffffffffc02045f4:	00153513          	seqz	a0,a0
ffffffffc02045f8:	8082                	ret

ffffffffc02045fa <wait_in_queue>:
ffffffffc02045fa:	711c                	ld	a5,32(a0)
ffffffffc02045fc:	0561                	addi	a0,a0,24
ffffffffc02045fe:	40a78533          	sub	a0,a5,a0
ffffffffc0204602:	00a03533          	snez	a0,a0
ffffffffc0204606:	8082                	ret

ffffffffc0204608 <wakeup_wait>:
ffffffffc0204608:	e689                	bnez	a3,ffffffffc0204612 <wakeup_wait+0xa>
ffffffffc020460a:	6188                	ld	a0,0(a1)
ffffffffc020460c:	c590                	sw	a2,8(a1)
ffffffffc020460e:	39b0206f          	j	ffffffffc02071a8 <wakeup_proc>
ffffffffc0204612:	7198                	ld	a4,32(a1)
ffffffffc0204614:	01858793          	addi	a5,a1,24
ffffffffc0204618:	00e78e63          	beq	a5,a4,ffffffffc0204634 <wakeup_wait+0x2c>
ffffffffc020461c:	6994                	ld	a3,16(a1)
ffffffffc020461e:	00d51b63          	bne	a0,a3,ffffffffc0204634 <wakeup_wait+0x2c>
ffffffffc0204622:	6d94                	ld	a3,24(a1)
ffffffffc0204624:	6188                	ld	a0,0(a1)
ffffffffc0204626:	e698                	sd	a4,8(a3)
ffffffffc0204628:	e314                	sd	a3,0(a4)
ffffffffc020462a:	f19c                	sd	a5,32(a1)
ffffffffc020462c:	ed9c                	sd	a5,24(a1)
ffffffffc020462e:	c590                	sw	a2,8(a1)
ffffffffc0204630:	3790206f          	j	ffffffffc02071a8 <wakeup_proc>
ffffffffc0204634:	1141                	addi	sp,sp,-16
ffffffffc0204636:	00009697          	auipc	a3,0x9
ffffffffc020463a:	a9268693          	addi	a3,a3,-1390 # ffffffffc020d0c8 <default_pmm_manager+0xb38>
ffffffffc020463e:	00007617          	auipc	a2,0x7
ffffffffc0204642:	46a60613          	addi	a2,a2,1130 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204646:	45f1                	li	a1,28
ffffffffc0204648:	00009517          	auipc	a0,0x9
ffffffffc020464c:	a6850513          	addi	a0,a0,-1432 # ffffffffc020d0b0 <default_pmm_manager+0xb20>
ffffffffc0204650:	e406                	sd	ra,8(sp)
ffffffffc0204652:	e4dfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204656 <wakeup_queue>:
ffffffffc0204656:	651c                	ld	a5,8(a0)
ffffffffc0204658:	0ca78563          	beq	a5,a0,ffffffffc0204722 <wakeup_queue+0xcc>
ffffffffc020465c:	1101                	addi	sp,sp,-32
ffffffffc020465e:	e822                	sd	s0,16(sp)
ffffffffc0204660:	e426                	sd	s1,8(sp)
ffffffffc0204662:	e04a                	sd	s2,0(sp)
ffffffffc0204664:	ec06                	sd	ra,24(sp)
ffffffffc0204666:	84aa                	mv	s1,a0
ffffffffc0204668:	892e                	mv	s2,a1
ffffffffc020466a:	fe878413          	addi	s0,a5,-24
ffffffffc020466e:	e23d                	bnez	a2,ffffffffc02046d4 <wakeup_queue+0x7e>
ffffffffc0204670:	6008                	ld	a0,0(s0)
ffffffffc0204672:	01242423          	sw	s2,8(s0)
ffffffffc0204676:	333020ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc020467a:	701c                	ld	a5,32(s0)
ffffffffc020467c:	01840713          	addi	a4,s0,24
ffffffffc0204680:	02e78463          	beq	a5,a4,ffffffffc02046a8 <wakeup_queue+0x52>
ffffffffc0204684:	6818                	ld	a4,16(s0)
ffffffffc0204686:	02e49163          	bne	s1,a4,ffffffffc02046a8 <wakeup_queue+0x52>
ffffffffc020468a:	02f48f63          	beq	s1,a5,ffffffffc02046c8 <wakeup_queue+0x72>
ffffffffc020468e:	fe87b503          	ld	a0,-24(a5)
ffffffffc0204692:	ff27a823          	sw	s2,-16(a5)
ffffffffc0204696:	fe878413          	addi	s0,a5,-24
ffffffffc020469a:	30f020ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc020469e:	701c                	ld	a5,32(s0)
ffffffffc02046a0:	01840713          	addi	a4,s0,24
ffffffffc02046a4:	fee790e3          	bne	a5,a4,ffffffffc0204684 <wakeup_queue+0x2e>
ffffffffc02046a8:	00009697          	auipc	a3,0x9
ffffffffc02046ac:	a2068693          	addi	a3,a3,-1504 # ffffffffc020d0c8 <default_pmm_manager+0xb38>
ffffffffc02046b0:	00007617          	auipc	a2,0x7
ffffffffc02046b4:	3f860613          	addi	a2,a2,1016 # ffffffffc020baa8 <commands+0x210>
ffffffffc02046b8:	02200593          	li	a1,34
ffffffffc02046bc:	00009517          	auipc	a0,0x9
ffffffffc02046c0:	9f450513          	addi	a0,a0,-1548 # ffffffffc020d0b0 <default_pmm_manager+0xb20>
ffffffffc02046c4:	ddbfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02046c8:	60e2                	ld	ra,24(sp)
ffffffffc02046ca:	6442                	ld	s0,16(sp)
ffffffffc02046cc:	64a2                	ld	s1,8(sp)
ffffffffc02046ce:	6902                	ld	s2,0(sp)
ffffffffc02046d0:	6105                	addi	sp,sp,32
ffffffffc02046d2:	8082                	ret
ffffffffc02046d4:	6798                	ld	a4,8(a5)
ffffffffc02046d6:	02f70763          	beq	a4,a5,ffffffffc0204704 <wakeup_queue+0xae>
ffffffffc02046da:	6814                	ld	a3,16(s0)
ffffffffc02046dc:	02d49463          	bne	s1,a3,ffffffffc0204704 <wakeup_queue+0xae>
ffffffffc02046e0:	6c14                	ld	a3,24(s0)
ffffffffc02046e2:	6008                	ld	a0,0(s0)
ffffffffc02046e4:	e698                	sd	a4,8(a3)
ffffffffc02046e6:	e314                	sd	a3,0(a4)
ffffffffc02046e8:	f01c                	sd	a5,32(s0)
ffffffffc02046ea:	ec1c                	sd	a5,24(s0)
ffffffffc02046ec:	01242423          	sw	s2,8(s0)
ffffffffc02046f0:	2b9020ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc02046f4:	6480                	ld	s0,8(s1)
ffffffffc02046f6:	fc8489e3          	beq	s1,s0,ffffffffc02046c8 <wakeup_queue+0x72>
ffffffffc02046fa:	6418                	ld	a4,8(s0)
ffffffffc02046fc:	87a2                	mv	a5,s0
ffffffffc02046fe:	1421                	addi	s0,s0,-24
ffffffffc0204700:	fce79de3          	bne	a5,a4,ffffffffc02046da <wakeup_queue+0x84>
ffffffffc0204704:	00009697          	auipc	a3,0x9
ffffffffc0204708:	9c468693          	addi	a3,a3,-1596 # ffffffffc020d0c8 <default_pmm_manager+0xb38>
ffffffffc020470c:	00007617          	auipc	a2,0x7
ffffffffc0204710:	39c60613          	addi	a2,a2,924 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204714:	45f1                	li	a1,28
ffffffffc0204716:	00009517          	auipc	a0,0x9
ffffffffc020471a:	99a50513          	addi	a0,a0,-1638 # ffffffffc020d0b0 <default_pmm_manager+0xb20>
ffffffffc020471e:	d81fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204722:	8082                	ret

ffffffffc0204724 <wait_current_set>:
ffffffffc0204724:	00092797          	auipc	a5,0x92
ffffffffc0204728:	19c7b783          	ld	a5,412(a5) # ffffffffc02968c0 <current>
ffffffffc020472c:	c39d                	beqz	a5,ffffffffc0204752 <wait_current_set+0x2e>
ffffffffc020472e:	01858713          	addi	a4,a1,24
ffffffffc0204732:	800006b7          	lui	a3,0x80000
ffffffffc0204736:	ed98                	sd	a4,24(a1)
ffffffffc0204738:	e19c                	sd	a5,0(a1)
ffffffffc020473a:	c594                	sw	a3,8(a1)
ffffffffc020473c:	4685                	li	a3,1
ffffffffc020473e:	c394                	sw	a3,0(a5)
ffffffffc0204740:	0ec7a623          	sw	a2,236(a5)
ffffffffc0204744:	611c                	ld	a5,0(a0)
ffffffffc0204746:	e988                	sd	a0,16(a1)
ffffffffc0204748:	e118                	sd	a4,0(a0)
ffffffffc020474a:	e798                	sd	a4,8(a5)
ffffffffc020474c:	f188                	sd	a0,32(a1)
ffffffffc020474e:	ed9c                	sd	a5,24(a1)
ffffffffc0204750:	8082                	ret
ffffffffc0204752:	1141                	addi	sp,sp,-16
ffffffffc0204754:	00009697          	auipc	a3,0x9
ffffffffc0204758:	9b468693          	addi	a3,a3,-1612 # ffffffffc020d108 <default_pmm_manager+0xb78>
ffffffffc020475c:	00007617          	auipc	a2,0x7
ffffffffc0204760:	34c60613          	addi	a2,a2,844 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204764:	07400593          	li	a1,116
ffffffffc0204768:	00009517          	auipc	a0,0x9
ffffffffc020476c:	94850513          	addi	a0,a0,-1720 # ffffffffc020d0b0 <default_pmm_manager+0xb20>
ffffffffc0204770:	e406                	sd	ra,8(sp)
ffffffffc0204772:	d2dfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204776 <get_fd_array.part.0>:
ffffffffc0204776:	1141                	addi	sp,sp,-16
ffffffffc0204778:	00009697          	auipc	a3,0x9
ffffffffc020477c:	9a068693          	addi	a3,a3,-1632 # ffffffffc020d118 <default_pmm_manager+0xb88>
ffffffffc0204780:	00007617          	auipc	a2,0x7
ffffffffc0204784:	32860613          	addi	a2,a2,808 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204788:	45d1                	li	a1,20
ffffffffc020478a:	00009517          	auipc	a0,0x9
ffffffffc020478e:	9be50513          	addi	a0,a0,-1602 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0204792:	e406                	sd	ra,8(sp)
ffffffffc0204794:	d0bfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204798 <fd_array_alloc>:
ffffffffc0204798:	00092797          	auipc	a5,0x92
ffffffffc020479c:	1287b783          	ld	a5,296(a5) # ffffffffc02968c0 <current>
ffffffffc02047a0:	1487b783          	ld	a5,328(a5)
ffffffffc02047a4:	1141                	addi	sp,sp,-16
ffffffffc02047a6:	e406                	sd	ra,8(sp)
ffffffffc02047a8:	c3a5                	beqz	a5,ffffffffc0204808 <fd_array_alloc+0x70>
ffffffffc02047aa:	4b98                	lw	a4,16(a5)
ffffffffc02047ac:	04e05e63          	blez	a4,ffffffffc0204808 <fd_array_alloc+0x70>
ffffffffc02047b0:	775d                	lui	a4,0xffff7
ffffffffc02047b2:	ad970713          	addi	a4,a4,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc02047b6:	679c                	ld	a5,8(a5)
ffffffffc02047b8:	02e50863          	beq	a0,a4,ffffffffc02047e8 <fd_array_alloc+0x50>
ffffffffc02047bc:	04700713          	li	a4,71
ffffffffc02047c0:	04a76263          	bltu	a4,a0,ffffffffc0204804 <fd_array_alloc+0x6c>
ffffffffc02047c4:	00351713          	slli	a4,a0,0x3
ffffffffc02047c8:	40a70533          	sub	a0,a4,a0
ffffffffc02047cc:	050e                	slli	a0,a0,0x3
ffffffffc02047ce:	97aa                	add	a5,a5,a0
ffffffffc02047d0:	4398                	lw	a4,0(a5)
ffffffffc02047d2:	e71d                	bnez	a4,ffffffffc0204800 <fd_array_alloc+0x68>
ffffffffc02047d4:	5b88                	lw	a0,48(a5)
ffffffffc02047d6:	e91d                	bnez	a0,ffffffffc020480c <fd_array_alloc+0x74>
ffffffffc02047d8:	4705                	li	a4,1
ffffffffc02047da:	c398                	sw	a4,0(a5)
ffffffffc02047dc:	0207b423          	sd	zero,40(a5)
ffffffffc02047e0:	e19c                	sd	a5,0(a1)
ffffffffc02047e2:	60a2                	ld	ra,8(sp)
ffffffffc02047e4:	0141                	addi	sp,sp,16
ffffffffc02047e6:	8082                	ret
ffffffffc02047e8:	6685                	lui	a3,0x1
ffffffffc02047ea:	fc068693          	addi	a3,a3,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02047ee:	96be                	add	a3,a3,a5
ffffffffc02047f0:	4398                	lw	a4,0(a5)
ffffffffc02047f2:	d36d                	beqz	a4,ffffffffc02047d4 <fd_array_alloc+0x3c>
ffffffffc02047f4:	03878793          	addi	a5,a5,56
ffffffffc02047f8:	fef69ce3          	bne	a3,a5,ffffffffc02047f0 <fd_array_alloc+0x58>
ffffffffc02047fc:	5529                	li	a0,-22
ffffffffc02047fe:	b7d5                	j	ffffffffc02047e2 <fd_array_alloc+0x4a>
ffffffffc0204800:	5545                	li	a0,-15
ffffffffc0204802:	b7c5                	j	ffffffffc02047e2 <fd_array_alloc+0x4a>
ffffffffc0204804:	5575                	li	a0,-3
ffffffffc0204806:	bff1                	j	ffffffffc02047e2 <fd_array_alloc+0x4a>
ffffffffc0204808:	f6fff0ef          	jal	ra,ffffffffc0204776 <get_fd_array.part.0>
ffffffffc020480c:	00009697          	auipc	a3,0x9
ffffffffc0204810:	94c68693          	addi	a3,a3,-1716 # ffffffffc020d158 <default_pmm_manager+0xbc8>
ffffffffc0204814:	00007617          	auipc	a2,0x7
ffffffffc0204818:	29460613          	addi	a2,a2,660 # ffffffffc020baa8 <commands+0x210>
ffffffffc020481c:	03b00593          	li	a1,59
ffffffffc0204820:	00009517          	auipc	a0,0x9
ffffffffc0204824:	92850513          	addi	a0,a0,-1752 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0204828:	c77fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020482c <fd_array_free>:
ffffffffc020482c:	411c                	lw	a5,0(a0)
ffffffffc020482e:	1141                	addi	sp,sp,-16
ffffffffc0204830:	e022                	sd	s0,0(sp)
ffffffffc0204832:	e406                	sd	ra,8(sp)
ffffffffc0204834:	4705                	li	a4,1
ffffffffc0204836:	842a                	mv	s0,a0
ffffffffc0204838:	04e78063          	beq	a5,a4,ffffffffc0204878 <fd_array_free+0x4c>
ffffffffc020483c:	470d                	li	a4,3
ffffffffc020483e:	04e79563          	bne	a5,a4,ffffffffc0204888 <fd_array_free+0x5c>
ffffffffc0204842:	591c                	lw	a5,48(a0)
ffffffffc0204844:	c38d                	beqz	a5,ffffffffc0204866 <fd_array_free+0x3a>
ffffffffc0204846:	00009697          	auipc	a3,0x9
ffffffffc020484a:	91268693          	addi	a3,a3,-1774 # ffffffffc020d158 <default_pmm_manager+0xbc8>
ffffffffc020484e:	00007617          	auipc	a2,0x7
ffffffffc0204852:	25a60613          	addi	a2,a2,602 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204856:	04500593          	li	a1,69
ffffffffc020485a:	00009517          	auipc	a0,0x9
ffffffffc020485e:	8ee50513          	addi	a0,a0,-1810 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0204862:	c3dfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204866:	7408                	ld	a0,40(s0)
ffffffffc0204868:	7b6030ef          	jal	ra,ffffffffc020801e <vfs_close>
ffffffffc020486c:	60a2                	ld	ra,8(sp)
ffffffffc020486e:	00042023          	sw	zero,0(s0)
ffffffffc0204872:	6402                	ld	s0,0(sp)
ffffffffc0204874:	0141                	addi	sp,sp,16
ffffffffc0204876:	8082                	ret
ffffffffc0204878:	591c                	lw	a5,48(a0)
ffffffffc020487a:	f7f1                	bnez	a5,ffffffffc0204846 <fd_array_free+0x1a>
ffffffffc020487c:	60a2                	ld	ra,8(sp)
ffffffffc020487e:	00042023          	sw	zero,0(s0)
ffffffffc0204882:	6402                	ld	s0,0(sp)
ffffffffc0204884:	0141                	addi	sp,sp,16
ffffffffc0204886:	8082                	ret
ffffffffc0204888:	00009697          	auipc	a3,0x9
ffffffffc020488c:	90868693          	addi	a3,a3,-1784 # ffffffffc020d190 <default_pmm_manager+0xc00>
ffffffffc0204890:	00007617          	auipc	a2,0x7
ffffffffc0204894:	21860613          	addi	a2,a2,536 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204898:	04400593          	li	a1,68
ffffffffc020489c:	00009517          	auipc	a0,0x9
ffffffffc02048a0:	8ac50513          	addi	a0,a0,-1876 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc02048a4:	bfbfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02048a8 <fd_array_release>:
ffffffffc02048a8:	4118                	lw	a4,0(a0)
ffffffffc02048aa:	1141                	addi	sp,sp,-16
ffffffffc02048ac:	e406                	sd	ra,8(sp)
ffffffffc02048ae:	4685                	li	a3,1
ffffffffc02048b0:	3779                	addiw	a4,a4,-2
ffffffffc02048b2:	04e6e063          	bltu	a3,a4,ffffffffc02048f2 <fd_array_release+0x4a>
ffffffffc02048b6:	5918                	lw	a4,48(a0)
ffffffffc02048b8:	00e05d63          	blez	a4,ffffffffc02048d2 <fd_array_release+0x2a>
ffffffffc02048bc:	fff7069b          	addiw	a3,a4,-1
ffffffffc02048c0:	d914                	sw	a3,48(a0)
ffffffffc02048c2:	c681                	beqz	a3,ffffffffc02048ca <fd_array_release+0x22>
ffffffffc02048c4:	60a2                	ld	ra,8(sp)
ffffffffc02048c6:	0141                	addi	sp,sp,16
ffffffffc02048c8:	8082                	ret
ffffffffc02048ca:	60a2                	ld	ra,8(sp)
ffffffffc02048cc:	0141                	addi	sp,sp,16
ffffffffc02048ce:	f5fff06f          	j	ffffffffc020482c <fd_array_free>
ffffffffc02048d2:	00009697          	auipc	a3,0x9
ffffffffc02048d6:	92e68693          	addi	a3,a3,-1746 # ffffffffc020d200 <default_pmm_manager+0xc70>
ffffffffc02048da:	00007617          	auipc	a2,0x7
ffffffffc02048de:	1ce60613          	addi	a2,a2,462 # ffffffffc020baa8 <commands+0x210>
ffffffffc02048e2:	05600593          	li	a1,86
ffffffffc02048e6:	00009517          	auipc	a0,0x9
ffffffffc02048ea:	86250513          	addi	a0,a0,-1950 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc02048ee:	bb1fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02048f2:	00009697          	auipc	a3,0x9
ffffffffc02048f6:	8d668693          	addi	a3,a3,-1834 # ffffffffc020d1c8 <default_pmm_manager+0xc38>
ffffffffc02048fa:	00007617          	auipc	a2,0x7
ffffffffc02048fe:	1ae60613          	addi	a2,a2,430 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204902:	05500593          	li	a1,85
ffffffffc0204906:	00009517          	auipc	a0,0x9
ffffffffc020490a:	84250513          	addi	a0,a0,-1982 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc020490e:	b91fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204912 <fd_array_open.part.0>:
ffffffffc0204912:	1141                	addi	sp,sp,-16
ffffffffc0204914:	00009697          	auipc	a3,0x9
ffffffffc0204918:	90468693          	addi	a3,a3,-1788 # ffffffffc020d218 <default_pmm_manager+0xc88>
ffffffffc020491c:	00007617          	auipc	a2,0x7
ffffffffc0204920:	18c60613          	addi	a2,a2,396 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204924:	05f00593          	li	a1,95
ffffffffc0204928:	00009517          	auipc	a0,0x9
ffffffffc020492c:	82050513          	addi	a0,a0,-2016 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0204930:	e406                	sd	ra,8(sp)
ffffffffc0204932:	b6dfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204936 <fd_array_init>:
ffffffffc0204936:	4781                	li	a5,0
ffffffffc0204938:	04800713          	li	a4,72
ffffffffc020493c:	cd1c                	sw	a5,24(a0)
ffffffffc020493e:	02052823          	sw	zero,48(a0)
ffffffffc0204942:	00052023          	sw	zero,0(a0)
ffffffffc0204946:	2785                	addiw	a5,a5,1
ffffffffc0204948:	03850513          	addi	a0,a0,56
ffffffffc020494c:	fee798e3          	bne	a5,a4,ffffffffc020493c <fd_array_init+0x6>
ffffffffc0204950:	8082                	ret

ffffffffc0204952 <fd_array_close>:
ffffffffc0204952:	4118                	lw	a4,0(a0)
ffffffffc0204954:	1141                	addi	sp,sp,-16
ffffffffc0204956:	e406                	sd	ra,8(sp)
ffffffffc0204958:	e022                	sd	s0,0(sp)
ffffffffc020495a:	4789                	li	a5,2
ffffffffc020495c:	04f71a63          	bne	a4,a5,ffffffffc02049b0 <fd_array_close+0x5e>
ffffffffc0204960:	591c                	lw	a5,48(a0)
ffffffffc0204962:	842a                	mv	s0,a0
ffffffffc0204964:	02f05663          	blez	a5,ffffffffc0204990 <fd_array_close+0x3e>
ffffffffc0204968:	37fd                	addiw	a5,a5,-1
ffffffffc020496a:	470d                	li	a4,3
ffffffffc020496c:	c118                	sw	a4,0(a0)
ffffffffc020496e:	d91c                	sw	a5,48(a0)
ffffffffc0204970:	0007871b          	sext.w	a4,a5
ffffffffc0204974:	c709                	beqz	a4,ffffffffc020497e <fd_array_close+0x2c>
ffffffffc0204976:	60a2                	ld	ra,8(sp)
ffffffffc0204978:	6402                	ld	s0,0(sp)
ffffffffc020497a:	0141                	addi	sp,sp,16
ffffffffc020497c:	8082                	ret
ffffffffc020497e:	7508                	ld	a0,40(a0)
ffffffffc0204980:	69e030ef          	jal	ra,ffffffffc020801e <vfs_close>
ffffffffc0204984:	60a2                	ld	ra,8(sp)
ffffffffc0204986:	00042023          	sw	zero,0(s0)
ffffffffc020498a:	6402                	ld	s0,0(sp)
ffffffffc020498c:	0141                	addi	sp,sp,16
ffffffffc020498e:	8082                	ret
ffffffffc0204990:	00009697          	auipc	a3,0x9
ffffffffc0204994:	87068693          	addi	a3,a3,-1936 # ffffffffc020d200 <default_pmm_manager+0xc70>
ffffffffc0204998:	00007617          	auipc	a2,0x7
ffffffffc020499c:	11060613          	addi	a2,a2,272 # ffffffffc020baa8 <commands+0x210>
ffffffffc02049a0:	06800593          	li	a1,104
ffffffffc02049a4:	00008517          	auipc	a0,0x8
ffffffffc02049a8:	7a450513          	addi	a0,a0,1956 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc02049ac:	af3fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02049b0:	00008697          	auipc	a3,0x8
ffffffffc02049b4:	7c068693          	addi	a3,a3,1984 # ffffffffc020d170 <default_pmm_manager+0xbe0>
ffffffffc02049b8:	00007617          	auipc	a2,0x7
ffffffffc02049bc:	0f060613          	addi	a2,a2,240 # ffffffffc020baa8 <commands+0x210>
ffffffffc02049c0:	06700593          	li	a1,103
ffffffffc02049c4:	00008517          	auipc	a0,0x8
ffffffffc02049c8:	78450513          	addi	a0,a0,1924 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc02049cc:	ad3fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02049d0 <fd_array_dup>:
ffffffffc02049d0:	7179                	addi	sp,sp,-48
ffffffffc02049d2:	e84a                	sd	s2,16(sp)
ffffffffc02049d4:	00052903          	lw	s2,0(a0)
ffffffffc02049d8:	f406                	sd	ra,40(sp)
ffffffffc02049da:	f022                	sd	s0,32(sp)
ffffffffc02049dc:	ec26                	sd	s1,24(sp)
ffffffffc02049de:	e44e                	sd	s3,8(sp)
ffffffffc02049e0:	4785                	li	a5,1
ffffffffc02049e2:	04f91663          	bne	s2,a5,ffffffffc0204a2e <fd_array_dup+0x5e>
ffffffffc02049e6:	0005a983          	lw	s3,0(a1)
ffffffffc02049ea:	4789                	li	a5,2
ffffffffc02049ec:	04f99163          	bne	s3,a5,ffffffffc0204a2e <fd_array_dup+0x5e>
ffffffffc02049f0:	7584                	ld	s1,40(a1)
ffffffffc02049f2:	699c                	ld	a5,16(a1)
ffffffffc02049f4:	7194                	ld	a3,32(a1)
ffffffffc02049f6:	6598                	ld	a4,8(a1)
ffffffffc02049f8:	842a                	mv	s0,a0
ffffffffc02049fa:	e91c                	sd	a5,16(a0)
ffffffffc02049fc:	f114                	sd	a3,32(a0)
ffffffffc02049fe:	e518                	sd	a4,8(a0)
ffffffffc0204a00:	8526                	mv	a0,s1
ffffffffc0204a02:	57b020ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc0204a06:	8526                	mv	a0,s1
ffffffffc0204a08:	581020ef          	jal	ra,ffffffffc0207788 <inode_open_inc>
ffffffffc0204a0c:	401c                	lw	a5,0(s0)
ffffffffc0204a0e:	f404                	sd	s1,40(s0)
ffffffffc0204a10:	03279f63          	bne	a5,s2,ffffffffc0204a4e <fd_array_dup+0x7e>
ffffffffc0204a14:	cc8d                	beqz	s1,ffffffffc0204a4e <fd_array_dup+0x7e>
ffffffffc0204a16:	581c                	lw	a5,48(s0)
ffffffffc0204a18:	01342023          	sw	s3,0(s0)
ffffffffc0204a1c:	70a2                	ld	ra,40(sp)
ffffffffc0204a1e:	2785                	addiw	a5,a5,1
ffffffffc0204a20:	d81c                	sw	a5,48(s0)
ffffffffc0204a22:	7402                	ld	s0,32(sp)
ffffffffc0204a24:	64e2                	ld	s1,24(sp)
ffffffffc0204a26:	6942                	ld	s2,16(sp)
ffffffffc0204a28:	69a2                	ld	s3,8(sp)
ffffffffc0204a2a:	6145                	addi	sp,sp,48
ffffffffc0204a2c:	8082                	ret
ffffffffc0204a2e:	00009697          	auipc	a3,0x9
ffffffffc0204a32:	81a68693          	addi	a3,a3,-2022 # ffffffffc020d248 <default_pmm_manager+0xcb8>
ffffffffc0204a36:	00007617          	auipc	a2,0x7
ffffffffc0204a3a:	07260613          	addi	a2,a2,114 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204a3e:	07300593          	li	a1,115
ffffffffc0204a42:	00008517          	auipc	a0,0x8
ffffffffc0204a46:	70650513          	addi	a0,a0,1798 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0204a4a:	a55fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204a4e:	ec5ff0ef          	jal	ra,ffffffffc0204912 <fd_array_open.part.0>

ffffffffc0204a52 <file_testfd>:
ffffffffc0204a52:	04700793          	li	a5,71
ffffffffc0204a56:	04a7e263          	bltu	a5,a0,ffffffffc0204a9a <file_testfd+0x48>
ffffffffc0204a5a:	00092797          	auipc	a5,0x92
ffffffffc0204a5e:	e667b783          	ld	a5,-410(a5) # ffffffffc02968c0 <current>
ffffffffc0204a62:	1487b783          	ld	a5,328(a5)
ffffffffc0204a66:	cf85                	beqz	a5,ffffffffc0204a9e <file_testfd+0x4c>
ffffffffc0204a68:	4b98                	lw	a4,16(a5)
ffffffffc0204a6a:	02e05a63          	blez	a4,ffffffffc0204a9e <file_testfd+0x4c>
ffffffffc0204a6e:	6798                	ld	a4,8(a5)
ffffffffc0204a70:	00351793          	slli	a5,a0,0x3
ffffffffc0204a74:	8f89                	sub	a5,a5,a0
ffffffffc0204a76:	078e                	slli	a5,a5,0x3
ffffffffc0204a78:	97ba                	add	a5,a5,a4
ffffffffc0204a7a:	4394                	lw	a3,0(a5)
ffffffffc0204a7c:	4709                	li	a4,2
ffffffffc0204a7e:	00e69e63          	bne	a3,a4,ffffffffc0204a9a <file_testfd+0x48>
ffffffffc0204a82:	4f98                	lw	a4,24(a5)
ffffffffc0204a84:	00a71b63          	bne	a4,a0,ffffffffc0204a9a <file_testfd+0x48>
ffffffffc0204a88:	c199                	beqz	a1,ffffffffc0204a8e <file_testfd+0x3c>
ffffffffc0204a8a:	6788                	ld	a0,8(a5)
ffffffffc0204a8c:	c901                	beqz	a0,ffffffffc0204a9c <file_testfd+0x4a>
ffffffffc0204a8e:	4505                	li	a0,1
ffffffffc0204a90:	c611                	beqz	a2,ffffffffc0204a9c <file_testfd+0x4a>
ffffffffc0204a92:	6b88                	ld	a0,16(a5)
ffffffffc0204a94:	00a03533          	snez	a0,a0
ffffffffc0204a98:	8082                	ret
ffffffffc0204a9a:	4501                	li	a0,0
ffffffffc0204a9c:	8082                	ret
ffffffffc0204a9e:	1141                	addi	sp,sp,-16
ffffffffc0204aa0:	e406                	sd	ra,8(sp)
ffffffffc0204aa2:	cd5ff0ef          	jal	ra,ffffffffc0204776 <get_fd_array.part.0>

ffffffffc0204aa6 <file_open>:
ffffffffc0204aa6:	711d                	addi	sp,sp,-96
ffffffffc0204aa8:	ec86                	sd	ra,88(sp)
ffffffffc0204aaa:	e8a2                	sd	s0,80(sp)
ffffffffc0204aac:	e4a6                	sd	s1,72(sp)
ffffffffc0204aae:	e0ca                	sd	s2,64(sp)
ffffffffc0204ab0:	fc4e                	sd	s3,56(sp)
ffffffffc0204ab2:	f852                	sd	s4,48(sp)
ffffffffc0204ab4:	0035f793          	andi	a5,a1,3
ffffffffc0204ab8:	470d                	li	a4,3
ffffffffc0204aba:	0ce78163          	beq	a5,a4,ffffffffc0204b7c <file_open+0xd6>
ffffffffc0204abe:	078e                	slli	a5,a5,0x3
ffffffffc0204ac0:	00009717          	auipc	a4,0x9
ffffffffc0204ac4:	9f870713          	addi	a4,a4,-1544 # ffffffffc020d4b8 <CSWTCH.79>
ffffffffc0204ac8:	892a                	mv	s2,a0
ffffffffc0204aca:	00009697          	auipc	a3,0x9
ffffffffc0204ace:	9d668693          	addi	a3,a3,-1578 # ffffffffc020d4a0 <CSWTCH.78>
ffffffffc0204ad2:	755d                	lui	a0,0xffff7
ffffffffc0204ad4:	96be                	add	a3,a3,a5
ffffffffc0204ad6:	84ae                	mv	s1,a1
ffffffffc0204ad8:	97ba                	add	a5,a5,a4
ffffffffc0204ada:	858a                	mv	a1,sp
ffffffffc0204adc:	ad950513          	addi	a0,a0,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204ae0:	0006ba03          	ld	s4,0(a3)
ffffffffc0204ae4:	0007b983          	ld	s3,0(a5)
ffffffffc0204ae8:	cb1ff0ef          	jal	ra,ffffffffc0204798 <fd_array_alloc>
ffffffffc0204aec:	842a                	mv	s0,a0
ffffffffc0204aee:	c911                	beqz	a0,ffffffffc0204b02 <file_open+0x5c>
ffffffffc0204af0:	60e6                	ld	ra,88(sp)
ffffffffc0204af2:	8522                	mv	a0,s0
ffffffffc0204af4:	6446                	ld	s0,80(sp)
ffffffffc0204af6:	64a6                	ld	s1,72(sp)
ffffffffc0204af8:	6906                	ld	s2,64(sp)
ffffffffc0204afa:	79e2                	ld	s3,56(sp)
ffffffffc0204afc:	7a42                	ld	s4,48(sp)
ffffffffc0204afe:	6125                	addi	sp,sp,96
ffffffffc0204b00:	8082                	ret
ffffffffc0204b02:	0030                	addi	a2,sp,8
ffffffffc0204b04:	85a6                	mv	a1,s1
ffffffffc0204b06:	854a                	mv	a0,s2
ffffffffc0204b08:	370030ef          	jal	ra,ffffffffc0207e78 <vfs_open>
ffffffffc0204b0c:	842a                	mv	s0,a0
ffffffffc0204b0e:	e13d                	bnez	a0,ffffffffc0204b74 <file_open+0xce>
ffffffffc0204b10:	6782                	ld	a5,0(sp)
ffffffffc0204b12:	0204f493          	andi	s1,s1,32
ffffffffc0204b16:	6422                	ld	s0,8(sp)
ffffffffc0204b18:	0207b023          	sd	zero,32(a5)
ffffffffc0204b1c:	c885                	beqz	s1,ffffffffc0204b4c <file_open+0xa6>
ffffffffc0204b1e:	c03d                	beqz	s0,ffffffffc0204b84 <file_open+0xde>
ffffffffc0204b20:	783c                	ld	a5,112(s0)
ffffffffc0204b22:	c3ad                	beqz	a5,ffffffffc0204b84 <file_open+0xde>
ffffffffc0204b24:	779c                	ld	a5,40(a5)
ffffffffc0204b26:	cfb9                	beqz	a5,ffffffffc0204b84 <file_open+0xde>
ffffffffc0204b28:	8522                	mv	a0,s0
ffffffffc0204b2a:	00008597          	auipc	a1,0x8
ffffffffc0204b2e:	7a658593          	addi	a1,a1,1958 # ffffffffc020d2d0 <default_pmm_manager+0xd40>
ffffffffc0204b32:	463020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204b36:	783c                	ld	a5,112(s0)
ffffffffc0204b38:	6522                	ld	a0,8(sp)
ffffffffc0204b3a:	080c                	addi	a1,sp,16
ffffffffc0204b3c:	779c                	ld	a5,40(a5)
ffffffffc0204b3e:	9782                	jalr	a5
ffffffffc0204b40:	842a                	mv	s0,a0
ffffffffc0204b42:	e515                	bnez	a0,ffffffffc0204b6e <file_open+0xc8>
ffffffffc0204b44:	6782                	ld	a5,0(sp)
ffffffffc0204b46:	7722                	ld	a4,40(sp)
ffffffffc0204b48:	6422                	ld	s0,8(sp)
ffffffffc0204b4a:	f398                	sd	a4,32(a5)
ffffffffc0204b4c:	4394                	lw	a3,0(a5)
ffffffffc0204b4e:	f780                	sd	s0,40(a5)
ffffffffc0204b50:	0147b423          	sd	s4,8(a5)
ffffffffc0204b54:	0137b823          	sd	s3,16(a5)
ffffffffc0204b58:	4705                	li	a4,1
ffffffffc0204b5a:	02e69363          	bne	a3,a4,ffffffffc0204b80 <file_open+0xda>
ffffffffc0204b5e:	c00d                	beqz	s0,ffffffffc0204b80 <file_open+0xda>
ffffffffc0204b60:	5b98                	lw	a4,48(a5)
ffffffffc0204b62:	4689                	li	a3,2
ffffffffc0204b64:	4f80                	lw	s0,24(a5)
ffffffffc0204b66:	2705                	addiw	a4,a4,1
ffffffffc0204b68:	c394                	sw	a3,0(a5)
ffffffffc0204b6a:	db98                	sw	a4,48(a5)
ffffffffc0204b6c:	b751                	j	ffffffffc0204af0 <file_open+0x4a>
ffffffffc0204b6e:	6522                	ld	a0,8(sp)
ffffffffc0204b70:	4ae030ef          	jal	ra,ffffffffc020801e <vfs_close>
ffffffffc0204b74:	6502                	ld	a0,0(sp)
ffffffffc0204b76:	cb7ff0ef          	jal	ra,ffffffffc020482c <fd_array_free>
ffffffffc0204b7a:	bf9d                	j	ffffffffc0204af0 <file_open+0x4a>
ffffffffc0204b7c:	5475                	li	s0,-3
ffffffffc0204b7e:	bf8d                	j	ffffffffc0204af0 <file_open+0x4a>
ffffffffc0204b80:	d93ff0ef          	jal	ra,ffffffffc0204912 <fd_array_open.part.0>
ffffffffc0204b84:	00008697          	auipc	a3,0x8
ffffffffc0204b88:	6fc68693          	addi	a3,a3,1788 # ffffffffc020d280 <default_pmm_manager+0xcf0>
ffffffffc0204b8c:	00007617          	auipc	a2,0x7
ffffffffc0204b90:	f1c60613          	addi	a2,a2,-228 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204b94:	0b500593          	li	a1,181
ffffffffc0204b98:	00008517          	auipc	a0,0x8
ffffffffc0204b9c:	5b050513          	addi	a0,a0,1456 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0204ba0:	8fffb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204ba4 <file_close>:
ffffffffc0204ba4:	04700713          	li	a4,71
ffffffffc0204ba8:	04a76563          	bltu	a4,a0,ffffffffc0204bf2 <file_close+0x4e>
ffffffffc0204bac:	00092717          	auipc	a4,0x92
ffffffffc0204bb0:	d1473703          	ld	a4,-748(a4) # ffffffffc02968c0 <current>
ffffffffc0204bb4:	14873703          	ld	a4,328(a4)
ffffffffc0204bb8:	1141                	addi	sp,sp,-16
ffffffffc0204bba:	e406                	sd	ra,8(sp)
ffffffffc0204bbc:	cf0d                	beqz	a4,ffffffffc0204bf6 <file_close+0x52>
ffffffffc0204bbe:	4b14                	lw	a3,16(a4)
ffffffffc0204bc0:	02d05b63          	blez	a3,ffffffffc0204bf6 <file_close+0x52>
ffffffffc0204bc4:	6718                	ld	a4,8(a4)
ffffffffc0204bc6:	87aa                	mv	a5,a0
ffffffffc0204bc8:	050e                	slli	a0,a0,0x3
ffffffffc0204bca:	8d1d                	sub	a0,a0,a5
ffffffffc0204bcc:	050e                	slli	a0,a0,0x3
ffffffffc0204bce:	953a                	add	a0,a0,a4
ffffffffc0204bd0:	4114                	lw	a3,0(a0)
ffffffffc0204bd2:	4709                	li	a4,2
ffffffffc0204bd4:	00e69b63          	bne	a3,a4,ffffffffc0204bea <file_close+0x46>
ffffffffc0204bd8:	4d18                	lw	a4,24(a0)
ffffffffc0204bda:	00f71863          	bne	a4,a5,ffffffffc0204bea <file_close+0x46>
ffffffffc0204bde:	d75ff0ef          	jal	ra,ffffffffc0204952 <fd_array_close>
ffffffffc0204be2:	60a2                	ld	ra,8(sp)
ffffffffc0204be4:	4501                	li	a0,0
ffffffffc0204be6:	0141                	addi	sp,sp,16
ffffffffc0204be8:	8082                	ret
ffffffffc0204bea:	60a2                	ld	ra,8(sp)
ffffffffc0204bec:	5575                	li	a0,-3
ffffffffc0204bee:	0141                	addi	sp,sp,16
ffffffffc0204bf0:	8082                	ret
ffffffffc0204bf2:	5575                	li	a0,-3
ffffffffc0204bf4:	8082                	ret
ffffffffc0204bf6:	b81ff0ef          	jal	ra,ffffffffc0204776 <get_fd_array.part.0>

ffffffffc0204bfa <file_read>:
ffffffffc0204bfa:	715d                	addi	sp,sp,-80
ffffffffc0204bfc:	e486                	sd	ra,72(sp)
ffffffffc0204bfe:	e0a2                	sd	s0,64(sp)
ffffffffc0204c00:	fc26                	sd	s1,56(sp)
ffffffffc0204c02:	f84a                	sd	s2,48(sp)
ffffffffc0204c04:	f44e                	sd	s3,40(sp)
ffffffffc0204c06:	f052                	sd	s4,32(sp)
ffffffffc0204c08:	0006b023          	sd	zero,0(a3)
ffffffffc0204c0c:	04700793          	li	a5,71
ffffffffc0204c10:	0aa7e463          	bltu	a5,a0,ffffffffc0204cb8 <file_read+0xbe>
ffffffffc0204c14:	00092797          	auipc	a5,0x92
ffffffffc0204c18:	cac7b783          	ld	a5,-852(a5) # ffffffffc02968c0 <current>
ffffffffc0204c1c:	1487b783          	ld	a5,328(a5)
ffffffffc0204c20:	cfd1                	beqz	a5,ffffffffc0204cbc <file_read+0xc2>
ffffffffc0204c22:	4b98                	lw	a4,16(a5)
ffffffffc0204c24:	08e05c63          	blez	a4,ffffffffc0204cbc <file_read+0xc2>
ffffffffc0204c28:	6780                	ld	s0,8(a5)
ffffffffc0204c2a:	00351793          	slli	a5,a0,0x3
ffffffffc0204c2e:	8f89                	sub	a5,a5,a0
ffffffffc0204c30:	078e                	slli	a5,a5,0x3
ffffffffc0204c32:	943e                	add	s0,s0,a5
ffffffffc0204c34:	00042983          	lw	s3,0(s0)
ffffffffc0204c38:	4789                	li	a5,2
ffffffffc0204c3a:	06f99f63          	bne	s3,a5,ffffffffc0204cb8 <file_read+0xbe>
ffffffffc0204c3e:	4c1c                	lw	a5,24(s0)
ffffffffc0204c40:	06a79c63          	bne	a5,a0,ffffffffc0204cb8 <file_read+0xbe>
ffffffffc0204c44:	641c                	ld	a5,8(s0)
ffffffffc0204c46:	cbad                	beqz	a5,ffffffffc0204cb8 <file_read+0xbe>
ffffffffc0204c48:	581c                	lw	a5,48(s0)
ffffffffc0204c4a:	8a36                	mv	s4,a3
ffffffffc0204c4c:	7014                	ld	a3,32(s0)
ffffffffc0204c4e:	2785                	addiw	a5,a5,1
ffffffffc0204c50:	850a                	mv	a0,sp
ffffffffc0204c52:	d81c                	sw	a5,48(s0)
ffffffffc0204c54:	792000ef          	jal	ra,ffffffffc02053e6 <iobuf_init>
ffffffffc0204c58:	02843903          	ld	s2,40(s0)
ffffffffc0204c5c:	84aa                	mv	s1,a0
ffffffffc0204c5e:	06090163          	beqz	s2,ffffffffc0204cc0 <file_read+0xc6>
ffffffffc0204c62:	07093783          	ld	a5,112(s2)
ffffffffc0204c66:	cfa9                	beqz	a5,ffffffffc0204cc0 <file_read+0xc6>
ffffffffc0204c68:	6f9c                	ld	a5,24(a5)
ffffffffc0204c6a:	cbb9                	beqz	a5,ffffffffc0204cc0 <file_read+0xc6>
ffffffffc0204c6c:	00008597          	auipc	a1,0x8
ffffffffc0204c70:	6bc58593          	addi	a1,a1,1724 # ffffffffc020d328 <default_pmm_manager+0xd98>
ffffffffc0204c74:	854a                	mv	a0,s2
ffffffffc0204c76:	31f020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204c7a:	07093783          	ld	a5,112(s2)
ffffffffc0204c7e:	7408                	ld	a0,40(s0)
ffffffffc0204c80:	85a6                	mv	a1,s1
ffffffffc0204c82:	6f9c                	ld	a5,24(a5)
ffffffffc0204c84:	9782                	jalr	a5
ffffffffc0204c86:	689c                	ld	a5,16(s1)
ffffffffc0204c88:	6c94                	ld	a3,24(s1)
ffffffffc0204c8a:	4018                	lw	a4,0(s0)
ffffffffc0204c8c:	84aa                	mv	s1,a0
ffffffffc0204c8e:	8f95                	sub	a5,a5,a3
ffffffffc0204c90:	03370063          	beq	a4,s3,ffffffffc0204cb0 <file_read+0xb6>
ffffffffc0204c94:	00fa3023          	sd	a5,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0204c98:	8522                	mv	a0,s0
ffffffffc0204c9a:	c0fff0ef          	jal	ra,ffffffffc02048a8 <fd_array_release>
ffffffffc0204c9e:	60a6                	ld	ra,72(sp)
ffffffffc0204ca0:	6406                	ld	s0,64(sp)
ffffffffc0204ca2:	7942                	ld	s2,48(sp)
ffffffffc0204ca4:	79a2                	ld	s3,40(sp)
ffffffffc0204ca6:	7a02                	ld	s4,32(sp)
ffffffffc0204ca8:	8526                	mv	a0,s1
ffffffffc0204caa:	74e2                	ld	s1,56(sp)
ffffffffc0204cac:	6161                	addi	sp,sp,80
ffffffffc0204cae:	8082                	ret
ffffffffc0204cb0:	7018                	ld	a4,32(s0)
ffffffffc0204cb2:	973e                	add	a4,a4,a5
ffffffffc0204cb4:	f018                	sd	a4,32(s0)
ffffffffc0204cb6:	bff9                	j	ffffffffc0204c94 <file_read+0x9a>
ffffffffc0204cb8:	54f5                	li	s1,-3
ffffffffc0204cba:	b7d5                	j	ffffffffc0204c9e <file_read+0xa4>
ffffffffc0204cbc:	abbff0ef          	jal	ra,ffffffffc0204776 <get_fd_array.part.0>
ffffffffc0204cc0:	00008697          	auipc	a3,0x8
ffffffffc0204cc4:	61868693          	addi	a3,a3,1560 # ffffffffc020d2d8 <default_pmm_manager+0xd48>
ffffffffc0204cc8:	00007617          	auipc	a2,0x7
ffffffffc0204ccc:	de060613          	addi	a2,a2,-544 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204cd0:	0de00593          	li	a1,222
ffffffffc0204cd4:	00008517          	auipc	a0,0x8
ffffffffc0204cd8:	47450513          	addi	a0,a0,1140 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0204cdc:	fc2fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204ce0 <file_write>:
ffffffffc0204ce0:	715d                	addi	sp,sp,-80
ffffffffc0204ce2:	e486                	sd	ra,72(sp)
ffffffffc0204ce4:	e0a2                	sd	s0,64(sp)
ffffffffc0204ce6:	fc26                	sd	s1,56(sp)
ffffffffc0204ce8:	f84a                	sd	s2,48(sp)
ffffffffc0204cea:	f44e                	sd	s3,40(sp)
ffffffffc0204cec:	f052                	sd	s4,32(sp)
ffffffffc0204cee:	0006b023          	sd	zero,0(a3)
ffffffffc0204cf2:	04700793          	li	a5,71
ffffffffc0204cf6:	0aa7e463          	bltu	a5,a0,ffffffffc0204d9e <file_write+0xbe>
ffffffffc0204cfa:	00092797          	auipc	a5,0x92
ffffffffc0204cfe:	bc67b783          	ld	a5,-1082(a5) # ffffffffc02968c0 <current>
ffffffffc0204d02:	1487b783          	ld	a5,328(a5)
ffffffffc0204d06:	cfd1                	beqz	a5,ffffffffc0204da2 <file_write+0xc2>
ffffffffc0204d08:	4b98                	lw	a4,16(a5)
ffffffffc0204d0a:	08e05c63          	blez	a4,ffffffffc0204da2 <file_write+0xc2>
ffffffffc0204d0e:	6780                	ld	s0,8(a5)
ffffffffc0204d10:	00351793          	slli	a5,a0,0x3
ffffffffc0204d14:	8f89                	sub	a5,a5,a0
ffffffffc0204d16:	078e                	slli	a5,a5,0x3
ffffffffc0204d18:	943e                	add	s0,s0,a5
ffffffffc0204d1a:	00042983          	lw	s3,0(s0)
ffffffffc0204d1e:	4789                	li	a5,2
ffffffffc0204d20:	06f99f63          	bne	s3,a5,ffffffffc0204d9e <file_write+0xbe>
ffffffffc0204d24:	4c1c                	lw	a5,24(s0)
ffffffffc0204d26:	06a79c63          	bne	a5,a0,ffffffffc0204d9e <file_write+0xbe>
ffffffffc0204d2a:	681c                	ld	a5,16(s0)
ffffffffc0204d2c:	cbad                	beqz	a5,ffffffffc0204d9e <file_write+0xbe>
ffffffffc0204d2e:	581c                	lw	a5,48(s0)
ffffffffc0204d30:	8a36                	mv	s4,a3
ffffffffc0204d32:	7014                	ld	a3,32(s0)
ffffffffc0204d34:	2785                	addiw	a5,a5,1
ffffffffc0204d36:	850a                	mv	a0,sp
ffffffffc0204d38:	d81c                	sw	a5,48(s0)
ffffffffc0204d3a:	6ac000ef          	jal	ra,ffffffffc02053e6 <iobuf_init>
ffffffffc0204d3e:	02843903          	ld	s2,40(s0)
ffffffffc0204d42:	84aa                	mv	s1,a0
ffffffffc0204d44:	06090163          	beqz	s2,ffffffffc0204da6 <file_write+0xc6>
ffffffffc0204d48:	07093783          	ld	a5,112(s2)
ffffffffc0204d4c:	cfa9                	beqz	a5,ffffffffc0204da6 <file_write+0xc6>
ffffffffc0204d4e:	739c                	ld	a5,32(a5)
ffffffffc0204d50:	cbb9                	beqz	a5,ffffffffc0204da6 <file_write+0xc6>
ffffffffc0204d52:	00008597          	auipc	a1,0x8
ffffffffc0204d56:	62e58593          	addi	a1,a1,1582 # ffffffffc020d380 <default_pmm_manager+0xdf0>
ffffffffc0204d5a:	854a                	mv	a0,s2
ffffffffc0204d5c:	239020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204d60:	07093783          	ld	a5,112(s2)
ffffffffc0204d64:	7408                	ld	a0,40(s0)
ffffffffc0204d66:	85a6                	mv	a1,s1
ffffffffc0204d68:	739c                	ld	a5,32(a5)
ffffffffc0204d6a:	9782                	jalr	a5
ffffffffc0204d6c:	689c                	ld	a5,16(s1)
ffffffffc0204d6e:	6c94                	ld	a3,24(s1)
ffffffffc0204d70:	4018                	lw	a4,0(s0)
ffffffffc0204d72:	84aa                	mv	s1,a0
ffffffffc0204d74:	8f95                	sub	a5,a5,a3
ffffffffc0204d76:	03370063          	beq	a4,s3,ffffffffc0204d96 <file_write+0xb6>
ffffffffc0204d7a:	00fa3023          	sd	a5,0(s4)
ffffffffc0204d7e:	8522                	mv	a0,s0
ffffffffc0204d80:	b29ff0ef          	jal	ra,ffffffffc02048a8 <fd_array_release>
ffffffffc0204d84:	60a6                	ld	ra,72(sp)
ffffffffc0204d86:	6406                	ld	s0,64(sp)
ffffffffc0204d88:	7942                	ld	s2,48(sp)
ffffffffc0204d8a:	79a2                	ld	s3,40(sp)
ffffffffc0204d8c:	7a02                	ld	s4,32(sp)
ffffffffc0204d8e:	8526                	mv	a0,s1
ffffffffc0204d90:	74e2                	ld	s1,56(sp)
ffffffffc0204d92:	6161                	addi	sp,sp,80
ffffffffc0204d94:	8082                	ret
ffffffffc0204d96:	7018                	ld	a4,32(s0)
ffffffffc0204d98:	973e                	add	a4,a4,a5
ffffffffc0204d9a:	f018                	sd	a4,32(s0)
ffffffffc0204d9c:	bff9                	j	ffffffffc0204d7a <file_write+0x9a>
ffffffffc0204d9e:	54f5                	li	s1,-3
ffffffffc0204da0:	b7d5                	j	ffffffffc0204d84 <file_write+0xa4>
ffffffffc0204da2:	9d5ff0ef          	jal	ra,ffffffffc0204776 <get_fd_array.part.0>
ffffffffc0204da6:	00008697          	auipc	a3,0x8
ffffffffc0204daa:	58a68693          	addi	a3,a3,1418 # ffffffffc020d330 <default_pmm_manager+0xda0>
ffffffffc0204dae:	00007617          	auipc	a2,0x7
ffffffffc0204db2:	cfa60613          	addi	a2,a2,-774 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204db6:	0f800593          	li	a1,248
ffffffffc0204dba:	00008517          	auipc	a0,0x8
ffffffffc0204dbe:	38e50513          	addi	a0,a0,910 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0204dc2:	edcfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204dc6 <file_seek>:
ffffffffc0204dc6:	7139                	addi	sp,sp,-64
ffffffffc0204dc8:	fc06                	sd	ra,56(sp)
ffffffffc0204dca:	f822                	sd	s0,48(sp)
ffffffffc0204dcc:	f426                	sd	s1,40(sp)
ffffffffc0204dce:	f04a                	sd	s2,32(sp)
ffffffffc0204dd0:	04700793          	li	a5,71
ffffffffc0204dd4:	08a7e863          	bltu	a5,a0,ffffffffc0204e64 <file_seek+0x9e>
ffffffffc0204dd8:	00092797          	auipc	a5,0x92
ffffffffc0204ddc:	ae87b783          	ld	a5,-1304(a5) # ffffffffc02968c0 <current>
ffffffffc0204de0:	1487b783          	ld	a5,328(a5)
ffffffffc0204de4:	cfdd                	beqz	a5,ffffffffc0204ea2 <file_seek+0xdc>
ffffffffc0204de6:	4b98                	lw	a4,16(a5)
ffffffffc0204de8:	0ae05d63          	blez	a4,ffffffffc0204ea2 <file_seek+0xdc>
ffffffffc0204dec:	6780                	ld	s0,8(a5)
ffffffffc0204dee:	00351793          	slli	a5,a0,0x3
ffffffffc0204df2:	8f89                	sub	a5,a5,a0
ffffffffc0204df4:	078e                	slli	a5,a5,0x3
ffffffffc0204df6:	943e                	add	s0,s0,a5
ffffffffc0204df8:	4018                	lw	a4,0(s0)
ffffffffc0204dfa:	4789                	li	a5,2
ffffffffc0204dfc:	06f71463          	bne	a4,a5,ffffffffc0204e64 <file_seek+0x9e>
ffffffffc0204e00:	4c1c                	lw	a5,24(s0)
ffffffffc0204e02:	06a79163          	bne	a5,a0,ffffffffc0204e64 <file_seek+0x9e>
ffffffffc0204e06:	581c                	lw	a5,48(s0)
ffffffffc0204e08:	4685                	li	a3,1
ffffffffc0204e0a:	892e                	mv	s2,a1
ffffffffc0204e0c:	2785                	addiw	a5,a5,1
ffffffffc0204e0e:	d81c                	sw	a5,48(s0)
ffffffffc0204e10:	02d60063          	beq	a2,a3,ffffffffc0204e30 <file_seek+0x6a>
ffffffffc0204e14:	06e60063          	beq	a2,a4,ffffffffc0204e74 <file_seek+0xae>
ffffffffc0204e18:	54f5                	li	s1,-3
ffffffffc0204e1a:	ce11                	beqz	a2,ffffffffc0204e36 <file_seek+0x70>
ffffffffc0204e1c:	8522                	mv	a0,s0
ffffffffc0204e1e:	a8bff0ef          	jal	ra,ffffffffc02048a8 <fd_array_release>
ffffffffc0204e22:	70e2                	ld	ra,56(sp)
ffffffffc0204e24:	7442                	ld	s0,48(sp)
ffffffffc0204e26:	7902                	ld	s2,32(sp)
ffffffffc0204e28:	8526                	mv	a0,s1
ffffffffc0204e2a:	74a2                	ld	s1,40(sp)
ffffffffc0204e2c:	6121                	addi	sp,sp,64
ffffffffc0204e2e:	8082                	ret
ffffffffc0204e30:	701c                	ld	a5,32(s0)
ffffffffc0204e32:	00f58933          	add	s2,a1,a5
ffffffffc0204e36:	7404                	ld	s1,40(s0)
ffffffffc0204e38:	c4bd                	beqz	s1,ffffffffc0204ea6 <file_seek+0xe0>
ffffffffc0204e3a:	78bc                	ld	a5,112(s1)
ffffffffc0204e3c:	c7ad                	beqz	a5,ffffffffc0204ea6 <file_seek+0xe0>
ffffffffc0204e3e:	6fbc                	ld	a5,88(a5)
ffffffffc0204e40:	c3bd                	beqz	a5,ffffffffc0204ea6 <file_seek+0xe0>
ffffffffc0204e42:	8526                	mv	a0,s1
ffffffffc0204e44:	00008597          	auipc	a1,0x8
ffffffffc0204e48:	59458593          	addi	a1,a1,1428 # ffffffffc020d3d8 <default_pmm_manager+0xe48>
ffffffffc0204e4c:	149020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204e50:	78bc                	ld	a5,112(s1)
ffffffffc0204e52:	7408                	ld	a0,40(s0)
ffffffffc0204e54:	85ca                	mv	a1,s2
ffffffffc0204e56:	6fbc                	ld	a5,88(a5)
ffffffffc0204e58:	9782                	jalr	a5
ffffffffc0204e5a:	84aa                	mv	s1,a0
ffffffffc0204e5c:	f161                	bnez	a0,ffffffffc0204e1c <file_seek+0x56>
ffffffffc0204e5e:	03243023          	sd	s2,32(s0)
ffffffffc0204e62:	bf6d                	j	ffffffffc0204e1c <file_seek+0x56>
ffffffffc0204e64:	70e2                	ld	ra,56(sp)
ffffffffc0204e66:	7442                	ld	s0,48(sp)
ffffffffc0204e68:	54f5                	li	s1,-3
ffffffffc0204e6a:	7902                	ld	s2,32(sp)
ffffffffc0204e6c:	8526                	mv	a0,s1
ffffffffc0204e6e:	74a2                	ld	s1,40(sp)
ffffffffc0204e70:	6121                	addi	sp,sp,64
ffffffffc0204e72:	8082                	ret
ffffffffc0204e74:	7404                	ld	s1,40(s0)
ffffffffc0204e76:	c8a1                	beqz	s1,ffffffffc0204ec6 <file_seek+0x100>
ffffffffc0204e78:	78bc                	ld	a5,112(s1)
ffffffffc0204e7a:	c7b1                	beqz	a5,ffffffffc0204ec6 <file_seek+0x100>
ffffffffc0204e7c:	779c                	ld	a5,40(a5)
ffffffffc0204e7e:	c7a1                	beqz	a5,ffffffffc0204ec6 <file_seek+0x100>
ffffffffc0204e80:	8526                	mv	a0,s1
ffffffffc0204e82:	00008597          	auipc	a1,0x8
ffffffffc0204e86:	44e58593          	addi	a1,a1,1102 # ffffffffc020d2d0 <default_pmm_manager+0xd40>
ffffffffc0204e8a:	10b020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204e8e:	78bc                	ld	a5,112(s1)
ffffffffc0204e90:	7408                	ld	a0,40(s0)
ffffffffc0204e92:	858a                	mv	a1,sp
ffffffffc0204e94:	779c                	ld	a5,40(a5)
ffffffffc0204e96:	9782                	jalr	a5
ffffffffc0204e98:	84aa                	mv	s1,a0
ffffffffc0204e9a:	f149                	bnez	a0,ffffffffc0204e1c <file_seek+0x56>
ffffffffc0204e9c:	67e2                	ld	a5,24(sp)
ffffffffc0204e9e:	993e                	add	s2,s2,a5
ffffffffc0204ea0:	bf59                	j	ffffffffc0204e36 <file_seek+0x70>
ffffffffc0204ea2:	8d5ff0ef          	jal	ra,ffffffffc0204776 <get_fd_array.part.0>
ffffffffc0204ea6:	00008697          	auipc	a3,0x8
ffffffffc0204eaa:	4e268693          	addi	a3,a3,1250 # ffffffffc020d388 <default_pmm_manager+0xdf8>
ffffffffc0204eae:	00007617          	auipc	a2,0x7
ffffffffc0204eb2:	bfa60613          	addi	a2,a2,-1030 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204eb6:	11a00593          	li	a1,282
ffffffffc0204eba:	00008517          	auipc	a0,0x8
ffffffffc0204ebe:	28e50513          	addi	a0,a0,654 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0204ec2:	ddcfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204ec6:	00008697          	auipc	a3,0x8
ffffffffc0204eca:	3ba68693          	addi	a3,a3,954 # ffffffffc020d280 <default_pmm_manager+0xcf0>
ffffffffc0204ece:	00007617          	auipc	a2,0x7
ffffffffc0204ed2:	bda60613          	addi	a2,a2,-1062 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204ed6:	11200593          	li	a1,274
ffffffffc0204eda:	00008517          	auipc	a0,0x8
ffffffffc0204ede:	26e50513          	addi	a0,a0,622 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0204ee2:	dbcfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204ee6 <file_fstat>:
ffffffffc0204ee6:	1101                	addi	sp,sp,-32
ffffffffc0204ee8:	ec06                	sd	ra,24(sp)
ffffffffc0204eea:	e822                	sd	s0,16(sp)
ffffffffc0204eec:	e426                	sd	s1,8(sp)
ffffffffc0204eee:	e04a                	sd	s2,0(sp)
ffffffffc0204ef0:	04700793          	li	a5,71
ffffffffc0204ef4:	06a7ef63          	bltu	a5,a0,ffffffffc0204f72 <file_fstat+0x8c>
ffffffffc0204ef8:	00092797          	auipc	a5,0x92
ffffffffc0204efc:	9c87b783          	ld	a5,-1592(a5) # ffffffffc02968c0 <current>
ffffffffc0204f00:	1487b783          	ld	a5,328(a5)
ffffffffc0204f04:	cfd9                	beqz	a5,ffffffffc0204fa2 <file_fstat+0xbc>
ffffffffc0204f06:	4b98                	lw	a4,16(a5)
ffffffffc0204f08:	08e05d63          	blez	a4,ffffffffc0204fa2 <file_fstat+0xbc>
ffffffffc0204f0c:	6780                	ld	s0,8(a5)
ffffffffc0204f0e:	00351793          	slli	a5,a0,0x3
ffffffffc0204f12:	8f89                	sub	a5,a5,a0
ffffffffc0204f14:	078e                	slli	a5,a5,0x3
ffffffffc0204f16:	943e                	add	s0,s0,a5
ffffffffc0204f18:	4018                	lw	a4,0(s0)
ffffffffc0204f1a:	4789                	li	a5,2
ffffffffc0204f1c:	04f71b63          	bne	a4,a5,ffffffffc0204f72 <file_fstat+0x8c>
ffffffffc0204f20:	4c1c                	lw	a5,24(s0)
ffffffffc0204f22:	04a79863          	bne	a5,a0,ffffffffc0204f72 <file_fstat+0x8c>
ffffffffc0204f26:	581c                	lw	a5,48(s0)
ffffffffc0204f28:	02843903          	ld	s2,40(s0)
ffffffffc0204f2c:	2785                	addiw	a5,a5,1
ffffffffc0204f2e:	d81c                	sw	a5,48(s0)
ffffffffc0204f30:	04090963          	beqz	s2,ffffffffc0204f82 <file_fstat+0x9c>
ffffffffc0204f34:	07093783          	ld	a5,112(s2)
ffffffffc0204f38:	c7a9                	beqz	a5,ffffffffc0204f82 <file_fstat+0x9c>
ffffffffc0204f3a:	779c                	ld	a5,40(a5)
ffffffffc0204f3c:	c3b9                	beqz	a5,ffffffffc0204f82 <file_fstat+0x9c>
ffffffffc0204f3e:	84ae                	mv	s1,a1
ffffffffc0204f40:	854a                	mv	a0,s2
ffffffffc0204f42:	00008597          	auipc	a1,0x8
ffffffffc0204f46:	38e58593          	addi	a1,a1,910 # ffffffffc020d2d0 <default_pmm_manager+0xd40>
ffffffffc0204f4a:	04b020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0204f4e:	07093783          	ld	a5,112(s2)
ffffffffc0204f52:	7408                	ld	a0,40(s0)
ffffffffc0204f54:	85a6                	mv	a1,s1
ffffffffc0204f56:	779c                	ld	a5,40(a5)
ffffffffc0204f58:	9782                	jalr	a5
ffffffffc0204f5a:	87aa                	mv	a5,a0
ffffffffc0204f5c:	8522                	mv	a0,s0
ffffffffc0204f5e:	843e                	mv	s0,a5
ffffffffc0204f60:	949ff0ef          	jal	ra,ffffffffc02048a8 <fd_array_release>
ffffffffc0204f64:	60e2                	ld	ra,24(sp)
ffffffffc0204f66:	8522                	mv	a0,s0
ffffffffc0204f68:	6442                	ld	s0,16(sp)
ffffffffc0204f6a:	64a2                	ld	s1,8(sp)
ffffffffc0204f6c:	6902                	ld	s2,0(sp)
ffffffffc0204f6e:	6105                	addi	sp,sp,32
ffffffffc0204f70:	8082                	ret
ffffffffc0204f72:	5475                	li	s0,-3
ffffffffc0204f74:	60e2                	ld	ra,24(sp)
ffffffffc0204f76:	8522                	mv	a0,s0
ffffffffc0204f78:	6442                	ld	s0,16(sp)
ffffffffc0204f7a:	64a2                	ld	s1,8(sp)
ffffffffc0204f7c:	6902                	ld	s2,0(sp)
ffffffffc0204f7e:	6105                	addi	sp,sp,32
ffffffffc0204f80:	8082                	ret
ffffffffc0204f82:	00008697          	auipc	a3,0x8
ffffffffc0204f86:	2fe68693          	addi	a3,a3,766 # ffffffffc020d280 <default_pmm_manager+0xcf0>
ffffffffc0204f8a:	00007617          	auipc	a2,0x7
ffffffffc0204f8e:	b1e60613          	addi	a2,a2,-1250 # ffffffffc020baa8 <commands+0x210>
ffffffffc0204f92:	12c00593          	li	a1,300
ffffffffc0204f96:	00008517          	auipc	a0,0x8
ffffffffc0204f9a:	1b250513          	addi	a0,a0,434 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0204f9e:	d00fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204fa2:	fd4ff0ef          	jal	ra,ffffffffc0204776 <get_fd_array.part.0>

ffffffffc0204fa6 <file_fsync>:
ffffffffc0204fa6:	1101                	addi	sp,sp,-32
ffffffffc0204fa8:	ec06                	sd	ra,24(sp)
ffffffffc0204faa:	e822                	sd	s0,16(sp)
ffffffffc0204fac:	e426                	sd	s1,8(sp)
ffffffffc0204fae:	04700793          	li	a5,71
ffffffffc0204fb2:	06a7e863          	bltu	a5,a0,ffffffffc0205022 <file_fsync+0x7c>
ffffffffc0204fb6:	00092797          	auipc	a5,0x92
ffffffffc0204fba:	90a7b783          	ld	a5,-1782(a5) # ffffffffc02968c0 <current>
ffffffffc0204fbe:	1487b783          	ld	a5,328(a5)
ffffffffc0204fc2:	c7d9                	beqz	a5,ffffffffc0205050 <file_fsync+0xaa>
ffffffffc0204fc4:	4b98                	lw	a4,16(a5)
ffffffffc0204fc6:	08e05563          	blez	a4,ffffffffc0205050 <file_fsync+0xaa>
ffffffffc0204fca:	6780                	ld	s0,8(a5)
ffffffffc0204fcc:	00351793          	slli	a5,a0,0x3
ffffffffc0204fd0:	8f89                	sub	a5,a5,a0
ffffffffc0204fd2:	078e                	slli	a5,a5,0x3
ffffffffc0204fd4:	943e                	add	s0,s0,a5
ffffffffc0204fd6:	4018                	lw	a4,0(s0)
ffffffffc0204fd8:	4789                	li	a5,2
ffffffffc0204fda:	04f71463          	bne	a4,a5,ffffffffc0205022 <file_fsync+0x7c>
ffffffffc0204fde:	4c1c                	lw	a5,24(s0)
ffffffffc0204fe0:	04a79163          	bne	a5,a0,ffffffffc0205022 <file_fsync+0x7c>
ffffffffc0204fe4:	581c                	lw	a5,48(s0)
ffffffffc0204fe6:	7404                	ld	s1,40(s0)
ffffffffc0204fe8:	2785                	addiw	a5,a5,1
ffffffffc0204fea:	d81c                	sw	a5,48(s0)
ffffffffc0204fec:	c0b1                	beqz	s1,ffffffffc0205030 <file_fsync+0x8a>
ffffffffc0204fee:	78bc                	ld	a5,112(s1)
ffffffffc0204ff0:	c3a1                	beqz	a5,ffffffffc0205030 <file_fsync+0x8a>
ffffffffc0204ff2:	7b9c                	ld	a5,48(a5)
ffffffffc0204ff4:	cf95                	beqz	a5,ffffffffc0205030 <file_fsync+0x8a>
ffffffffc0204ff6:	00008597          	auipc	a1,0x8
ffffffffc0204ffa:	43a58593          	addi	a1,a1,1082 # ffffffffc020d430 <default_pmm_manager+0xea0>
ffffffffc0204ffe:	8526                	mv	a0,s1
ffffffffc0205000:	794020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0205004:	78bc                	ld	a5,112(s1)
ffffffffc0205006:	7408                	ld	a0,40(s0)
ffffffffc0205008:	7b9c                	ld	a5,48(a5)
ffffffffc020500a:	9782                	jalr	a5
ffffffffc020500c:	87aa                	mv	a5,a0
ffffffffc020500e:	8522                	mv	a0,s0
ffffffffc0205010:	843e                	mv	s0,a5
ffffffffc0205012:	897ff0ef          	jal	ra,ffffffffc02048a8 <fd_array_release>
ffffffffc0205016:	60e2                	ld	ra,24(sp)
ffffffffc0205018:	8522                	mv	a0,s0
ffffffffc020501a:	6442                	ld	s0,16(sp)
ffffffffc020501c:	64a2                	ld	s1,8(sp)
ffffffffc020501e:	6105                	addi	sp,sp,32
ffffffffc0205020:	8082                	ret
ffffffffc0205022:	5475                	li	s0,-3
ffffffffc0205024:	60e2                	ld	ra,24(sp)
ffffffffc0205026:	8522                	mv	a0,s0
ffffffffc0205028:	6442                	ld	s0,16(sp)
ffffffffc020502a:	64a2                	ld	s1,8(sp)
ffffffffc020502c:	6105                	addi	sp,sp,32
ffffffffc020502e:	8082                	ret
ffffffffc0205030:	00008697          	auipc	a3,0x8
ffffffffc0205034:	3b068693          	addi	a3,a3,944 # ffffffffc020d3e0 <default_pmm_manager+0xe50>
ffffffffc0205038:	00007617          	auipc	a2,0x7
ffffffffc020503c:	a7060613          	addi	a2,a2,-1424 # ffffffffc020baa8 <commands+0x210>
ffffffffc0205040:	13a00593          	li	a1,314
ffffffffc0205044:	00008517          	auipc	a0,0x8
ffffffffc0205048:	10450513          	addi	a0,a0,260 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc020504c:	c52fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205050:	f26ff0ef          	jal	ra,ffffffffc0204776 <get_fd_array.part.0>

ffffffffc0205054 <file_getdirentry>:
ffffffffc0205054:	715d                	addi	sp,sp,-80
ffffffffc0205056:	e486                	sd	ra,72(sp)
ffffffffc0205058:	e0a2                	sd	s0,64(sp)
ffffffffc020505a:	fc26                	sd	s1,56(sp)
ffffffffc020505c:	f84a                	sd	s2,48(sp)
ffffffffc020505e:	f44e                	sd	s3,40(sp)
ffffffffc0205060:	04700793          	li	a5,71
ffffffffc0205064:	0aa7e063          	bltu	a5,a0,ffffffffc0205104 <file_getdirentry+0xb0>
ffffffffc0205068:	00092797          	auipc	a5,0x92
ffffffffc020506c:	8587b783          	ld	a5,-1960(a5) # ffffffffc02968c0 <current>
ffffffffc0205070:	1487b783          	ld	a5,328(a5)
ffffffffc0205074:	c3e9                	beqz	a5,ffffffffc0205136 <file_getdirentry+0xe2>
ffffffffc0205076:	4b98                	lw	a4,16(a5)
ffffffffc0205078:	0ae05f63          	blez	a4,ffffffffc0205136 <file_getdirentry+0xe2>
ffffffffc020507c:	6780                	ld	s0,8(a5)
ffffffffc020507e:	00351793          	slli	a5,a0,0x3
ffffffffc0205082:	8f89                	sub	a5,a5,a0
ffffffffc0205084:	078e                	slli	a5,a5,0x3
ffffffffc0205086:	943e                	add	s0,s0,a5
ffffffffc0205088:	4018                	lw	a4,0(s0)
ffffffffc020508a:	4789                	li	a5,2
ffffffffc020508c:	06f71c63          	bne	a4,a5,ffffffffc0205104 <file_getdirentry+0xb0>
ffffffffc0205090:	4c1c                	lw	a5,24(s0)
ffffffffc0205092:	06a79963          	bne	a5,a0,ffffffffc0205104 <file_getdirentry+0xb0>
ffffffffc0205096:	581c                	lw	a5,48(s0)
ffffffffc0205098:	6194                	ld	a3,0(a1)
ffffffffc020509a:	84ae                	mv	s1,a1
ffffffffc020509c:	2785                	addiw	a5,a5,1
ffffffffc020509e:	10000613          	li	a2,256
ffffffffc02050a2:	d81c                	sw	a5,48(s0)
ffffffffc02050a4:	05a1                	addi	a1,a1,8
ffffffffc02050a6:	850a                	mv	a0,sp
ffffffffc02050a8:	33e000ef          	jal	ra,ffffffffc02053e6 <iobuf_init>
ffffffffc02050ac:	02843983          	ld	s3,40(s0)
ffffffffc02050b0:	892a                	mv	s2,a0
ffffffffc02050b2:	06098263          	beqz	s3,ffffffffc0205116 <file_getdirentry+0xc2>
ffffffffc02050b6:	0709b783          	ld	a5,112(s3) # 1070 <_binary_bin_swap_img_size-0x6c90>
ffffffffc02050ba:	cfb1                	beqz	a5,ffffffffc0205116 <file_getdirentry+0xc2>
ffffffffc02050bc:	63bc                	ld	a5,64(a5)
ffffffffc02050be:	cfa1                	beqz	a5,ffffffffc0205116 <file_getdirentry+0xc2>
ffffffffc02050c0:	854e                	mv	a0,s3
ffffffffc02050c2:	00008597          	auipc	a1,0x8
ffffffffc02050c6:	3ce58593          	addi	a1,a1,974 # ffffffffc020d490 <default_pmm_manager+0xf00>
ffffffffc02050ca:	6ca020ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc02050ce:	0709b783          	ld	a5,112(s3)
ffffffffc02050d2:	7408                	ld	a0,40(s0)
ffffffffc02050d4:	85ca                	mv	a1,s2
ffffffffc02050d6:	63bc                	ld	a5,64(a5)
ffffffffc02050d8:	9782                	jalr	a5
ffffffffc02050da:	89aa                	mv	s3,a0
ffffffffc02050dc:	e909                	bnez	a0,ffffffffc02050ee <file_getdirentry+0x9a>
ffffffffc02050de:	609c                	ld	a5,0(s1)
ffffffffc02050e0:	01093683          	ld	a3,16(s2)
ffffffffc02050e4:	01893703          	ld	a4,24(s2)
ffffffffc02050e8:	97b6                	add	a5,a5,a3
ffffffffc02050ea:	8f99                	sub	a5,a5,a4
ffffffffc02050ec:	e09c                	sd	a5,0(s1)
ffffffffc02050ee:	8522                	mv	a0,s0
ffffffffc02050f0:	fb8ff0ef          	jal	ra,ffffffffc02048a8 <fd_array_release>
ffffffffc02050f4:	60a6                	ld	ra,72(sp)
ffffffffc02050f6:	6406                	ld	s0,64(sp)
ffffffffc02050f8:	74e2                	ld	s1,56(sp)
ffffffffc02050fa:	7942                	ld	s2,48(sp)
ffffffffc02050fc:	854e                	mv	a0,s3
ffffffffc02050fe:	79a2                	ld	s3,40(sp)
ffffffffc0205100:	6161                	addi	sp,sp,80
ffffffffc0205102:	8082                	ret
ffffffffc0205104:	60a6                	ld	ra,72(sp)
ffffffffc0205106:	6406                	ld	s0,64(sp)
ffffffffc0205108:	59f5                	li	s3,-3
ffffffffc020510a:	74e2                	ld	s1,56(sp)
ffffffffc020510c:	7942                	ld	s2,48(sp)
ffffffffc020510e:	854e                	mv	a0,s3
ffffffffc0205110:	79a2                	ld	s3,40(sp)
ffffffffc0205112:	6161                	addi	sp,sp,80
ffffffffc0205114:	8082                	ret
ffffffffc0205116:	00008697          	auipc	a3,0x8
ffffffffc020511a:	32268693          	addi	a3,a3,802 # ffffffffc020d438 <default_pmm_manager+0xea8>
ffffffffc020511e:	00007617          	auipc	a2,0x7
ffffffffc0205122:	98a60613          	addi	a2,a2,-1654 # ffffffffc020baa8 <commands+0x210>
ffffffffc0205126:	14a00593          	li	a1,330
ffffffffc020512a:	00008517          	auipc	a0,0x8
ffffffffc020512e:	01e50513          	addi	a0,a0,30 # ffffffffc020d148 <default_pmm_manager+0xbb8>
ffffffffc0205132:	b6cfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205136:	e40ff0ef          	jal	ra,ffffffffc0204776 <get_fd_array.part.0>

ffffffffc020513a <file_dup>:
ffffffffc020513a:	04700713          	li	a4,71
ffffffffc020513e:	06a76463          	bltu	a4,a0,ffffffffc02051a6 <file_dup+0x6c>
ffffffffc0205142:	00091717          	auipc	a4,0x91
ffffffffc0205146:	77e73703          	ld	a4,1918(a4) # ffffffffc02968c0 <current>
ffffffffc020514a:	14873703          	ld	a4,328(a4)
ffffffffc020514e:	1101                	addi	sp,sp,-32
ffffffffc0205150:	ec06                	sd	ra,24(sp)
ffffffffc0205152:	e822                	sd	s0,16(sp)
ffffffffc0205154:	cb39                	beqz	a4,ffffffffc02051aa <file_dup+0x70>
ffffffffc0205156:	4b14                	lw	a3,16(a4)
ffffffffc0205158:	04d05963          	blez	a3,ffffffffc02051aa <file_dup+0x70>
ffffffffc020515c:	6700                	ld	s0,8(a4)
ffffffffc020515e:	00351713          	slli	a4,a0,0x3
ffffffffc0205162:	8f09                	sub	a4,a4,a0
ffffffffc0205164:	070e                	slli	a4,a4,0x3
ffffffffc0205166:	943a                	add	s0,s0,a4
ffffffffc0205168:	4014                	lw	a3,0(s0)
ffffffffc020516a:	4709                	li	a4,2
ffffffffc020516c:	02e69863          	bne	a3,a4,ffffffffc020519c <file_dup+0x62>
ffffffffc0205170:	4c18                	lw	a4,24(s0)
ffffffffc0205172:	02a71563          	bne	a4,a0,ffffffffc020519c <file_dup+0x62>
ffffffffc0205176:	852e                	mv	a0,a1
ffffffffc0205178:	002c                	addi	a1,sp,8
ffffffffc020517a:	e1eff0ef          	jal	ra,ffffffffc0204798 <fd_array_alloc>
ffffffffc020517e:	c509                	beqz	a0,ffffffffc0205188 <file_dup+0x4e>
ffffffffc0205180:	60e2                	ld	ra,24(sp)
ffffffffc0205182:	6442                	ld	s0,16(sp)
ffffffffc0205184:	6105                	addi	sp,sp,32
ffffffffc0205186:	8082                	ret
ffffffffc0205188:	6522                	ld	a0,8(sp)
ffffffffc020518a:	85a2                	mv	a1,s0
ffffffffc020518c:	845ff0ef          	jal	ra,ffffffffc02049d0 <fd_array_dup>
ffffffffc0205190:	67a2                	ld	a5,8(sp)
ffffffffc0205192:	60e2                	ld	ra,24(sp)
ffffffffc0205194:	6442                	ld	s0,16(sp)
ffffffffc0205196:	4f88                	lw	a0,24(a5)
ffffffffc0205198:	6105                	addi	sp,sp,32
ffffffffc020519a:	8082                	ret
ffffffffc020519c:	60e2                	ld	ra,24(sp)
ffffffffc020519e:	6442                	ld	s0,16(sp)
ffffffffc02051a0:	5575                	li	a0,-3
ffffffffc02051a2:	6105                	addi	sp,sp,32
ffffffffc02051a4:	8082                	ret
ffffffffc02051a6:	5575                	li	a0,-3
ffffffffc02051a8:	8082                	ret
ffffffffc02051aa:	dccff0ef          	jal	ra,ffffffffc0204776 <get_fd_array.part.0>

ffffffffc02051ae <fs_init>:
ffffffffc02051ae:	1141                	addi	sp,sp,-16
ffffffffc02051b0:	e406                	sd	ra,8(sp)
ffffffffc02051b2:	001020ef          	jal	ra,ffffffffc02079b2 <vfs_init>
ffffffffc02051b6:	4d8030ef          	jal	ra,ffffffffc020868e <dev_init>
ffffffffc02051ba:	60a2                	ld	ra,8(sp)
ffffffffc02051bc:	0141                	addi	sp,sp,16
ffffffffc02051be:	6290306f          	j	ffffffffc0208fe6 <sfs_init>

ffffffffc02051c2 <fs_cleanup>:
ffffffffc02051c2:	2430206f          	j	ffffffffc0207c04 <vfs_cleanup>

ffffffffc02051c6 <lock_files>:
ffffffffc02051c6:	0561                	addi	a0,a0,24
ffffffffc02051c8:	ba0ff06f          	j	ffffffffc0204568 <down>

ffffffffc02051cc <unlock_files>:
ffffffffc02051cc:	0561                	addi	a0,a0,24
ffffffffc02051ce:	b96ff06f          	j	ffffffffc0204564 <up>

ffffffffc02051d2 <files_create>:
ffffffffc02051d2:	1141                	addi	sp,sp,-16
ffffffffc02051d4:	6505                	lui	a0,0x1
ffffffffc02051d6:	e022                	sd	s0,0(sp)
ffffffffc02051d8:	e406                	sd	ra,8(sp)
ffffffffc02051da:	db9fc0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc02051de:	842a                	mv	s0,a0
ffffffffc02051e0:	cd19                	beqz	a0,ffffffffc02051fe <files_create+0x2c>
ffffffffc02051e2:	03050793          	addi	a5,a0,48 # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc02051e6:	00043023          	sd	zero,0(s0)
ffffffffc02051ea:	0561                	addi	a0,a0,24
ffffffffc02051ec:	e41c                	sd	a5,8(s0)
ffffffffc02051ee:	00042823          	sw	zero,16(s0)
ffffffffc02051f2:	4585                	li	a1,1
ffffffffc02051f4:	b6aff0ef          	jal	ra,ffffffffc020455e <sem_init>
ffffffffc02051f8:	6408                	ld	a0,8(s0)
ffffffffc02051fa:	f3cff0ef          	jal	ra,ffffffffc0204936 <fd_array_init>
ffffffffc02051fe:	60a2                	ld	ra,8(sp)
ffffffffc0205200:	8522                	mv	a0,s0
ffffffffc0205202:	6402                	ld	s0,0(sp)
ffffffffc0205204:	0141                	addi	sp,sp,16
ffffffffc0205206:	8082                	ret

ffffffffc0205208 <files_destroy>:
ffffffffc0205208:	7179                	addi	sp,sp,-48
ffffffffc020520a:	f406                	sd	ra,40(sp)
ffffffffc020520c:	f022                	sd	s0,32(sp)
ffffffffc020520e:	ec26                	sd	s1,24(sp)
ffffffffc0205210:	e84a                	sd	s2,16(sp)
ffffffffc0205212:	e44e                	sd	s3,8(sp)
ffffffffc0205214:	c52d                	beqz	a0,ffffffffc020527e <files_destroy+0x76>
ffffffffc0205216:	491c                	lw	a5,16(a0)
ffffffffc0205218:	89aa                	mv	s3,a0
ffffffffc020521a:	e3b5                	bnez	a5,ffffffffc020527e <files_destroy+0x76>
ffffffffc020521c:	6108                	ld	a0,0(a0)
ffffffffc020521e:	c119                	beqz	a0,ffffffffc0205224 <files_destroy+0x1c>
ffffffffc0205220:	62a020ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc0205224:	0089b403          	ld	s0,8(s3)
ffffffffc0205228:	6485                	lui	s1,0x1
ffffffffc020522a:	fc048493          	addi	s1,s1,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc020522e:	94a2                	add	s1,s1,s0
ffffffffc0205230:	4909                	li	s2,2
ffffffffc0205232:	401c                	lw	a5,0(s0)
ffffffffc0205234:	03278063          	beq	a5,s2,ffffffffc0205254 <files_destroy+0x4c>
ffffffffc0205238:	e39d                	bnez	a5,ffffffffc020525e <files_destroy+0x56>
ffffffffc020523a:	03840413          	addi	s0,s0,56
ffffffffc020523e:	fe849ae3          	bne	s1,s0,ffffffffc0205232 <files_destroy+0x2a>
ffffffffc0205242:	7402                	ld	s0,32(sp)
ffffffffc0205244:	70a2                	ld	ra,40(sp)
ffffffffc0205246:	64e2                	ld	s1,24(sp)
ffffffffc0205248:	6942                	ld	s2,16(sp)
ffffffffc020524a:	854e                	mv	a0,s3
ffffffffc020524c:	69a2                	ld	s3,8(sp)
ffffffffc020524e:	6145                	addi	sp,sp,48
ffffffffc0205250:	df3fc06f          	j	ffffffffc0202042 <kfree>
ffffffffc0205254:	8522                	mv	a0,s0
ffffffffc0205256:	efcff0ef          	jal	ra,ffffffffc0204952 <fd_array_close>
ffffffffc020525a:	401c                	lw	a5,0(s0)
ffffffffc020525c:	bff1                	j	ffffffffc0205238 <files_destroy+0x30>
ffffffffc020525e:	00008697          	auipc	a3,0x8
ffffffffc0205262:	2b268693          	addi	a3,a3,690 # ffffffffc020d510 <CSWTCH.79+0x58>
ffffffffc0205266:	00007617          	auipc	a2,0x7
ffffffffc020526a:	84260613          	addi	a2,a2,-1982 # ffffffffc020baa8 <commands+0x210>
ffffffffc020526e:	03d00593          	li	a1,61
ffffffffc0205272:	00008517          	auipc	a0,0x8
ffffffffc0205276:	28e50513          	addi	a0,a0,654 # ffffffffc020d500 <CSWTCH.79+0x48>
ffffffffc020527a:	a24fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020527e:	00008697          	auipc	a3,0x8
ffffffffc0205282:	25268693          	addi	a3,a3,594 # ffffffffc020d4d0 <CSWTCH.79+0x18>
ffffffffc0205286:	00007617          	auipc	a2,0x7
ffffffffc020528a:	82260613          	addi	a2,a2,-2014 # ffffffffc020baa8 <commands+0x210>
ffffffffc020528e:	03300593          	li	a1,51
ffffffffc0205292:	00008517          	auipc	a0,0x8
ffffffffc0205296:	26e50513          	addi	a0,a0,622 # ffffffffc020d500 <CSWTCH.79+0x48>
ffffffffc020529a:	a04fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020529e <files_closeall>:
ffffffffc020529e:	1101                	addi	sp,sp,-32
ffffffffc02052a0:	ec06                	sd	ra,24(sp)
ffffffffc02052a2:	e822                	sd	s0,16(sp)
ffffffffc02052a4:	e426                	sd	s1,8(sp)
ffffffffc02052a6:	e04a                	sd	s2,0(sp)
ffffffffc02052a8:	c129                	beqz	a0,ffffffffc02052ea <files_closeall+0x4c>
ffffffffc02052aa:	491c                	lw	a5,16(a0)
ffffffffc02052ac:	02f05f63          	blez	a5,ffffffffc02052ea <files_closeall+0x4c>
ffffffffc02052b0:	6504                	ld	s1,8(a0)
ffffffffc02052b2:	6785                	lui	a5,0x1
ffffffffc02052b4:	fc078793          	addi	a5,a5,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02052b8:	07048413          	addi	s0,s1,112
ffffffffc02052bc:	4909                	li	s2,2
ffffffffc02052be:	94be                	add	s1,s1,a5
ffffffffc02052c0:	a029                	j	ffffffffc02052ca <files_closeall+0x2c>
ffffffffc02052c2:	03840413          	addi	s0,s0,56
ffffffffc02052c6:	00848c63          	beq	s1,s0,ffffffffc02052de <files_closeall+0x40>
ffffffffc02052ca:	401c                	lw	a5,0(s0)
ffffffffc02052cc:	ff279be3          	bne	a5,s2,ffffffffc02052c2 <files_closeall+0x24>
ffffffffc02052d0:	8522                	mv	a0,s0
ffffffffc02052d2:	03840413          	addi	s0,s0,56
ffffffffc02052d6:	e7cff0ef          	jal	ra,ffffffffc0204952 <fd_array_close>
ffffffffc02052da:	fe8498e3          	bne	s1,s0,ffffffffc02052ca <files_closeall+0x2c>
ffffffffc02052de:	60e2                	ld	ra,24(sp)
ffffffffc02052e0:	6442                	ld	s0,16(sp)
ffffffffc02052e2:	64a2                	ld	s1,8(sp)
ffffffffc02052e4:	6902                	ld	s2,0(sp)
ffffffffc02052e6:	6105                	addi	sp,sp,32
ffffffffc02052e8:	8082                	ret
ffffffffc02052ea:	00008697          	auipc	a3,0x8
ffffffffc02052ee:	e2e68693          	addi	a3,a3,-466 # ffffffffc020d118 <default_pmm_manager+0xb88>
ffffffffc02052f2:	00006617          	auipc	a2,0x6
ffffffffc02052f6:	7b660613          	addi	a2,a2,1974 # ffffffffc020baa8 <commands+0x210>
ffffffffc02052fa:	04500593          	li	a1,69
ffffffffc02052fe:	00008517          	auipc	a0,0x8
ffffffffc0205302:	20250513          	addi	a0,a0,514 # ffffffffc020d500 <CSWTCH.79+0x48>
ffffffffc0205306:	998fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020530a <dup_files>:
ffffffffc020530a:	7179                	addi	sp,sp,-48
ffffffffc020530c:	f406                	sd	ra,40(sp)
ffffffffc020530e:	f022                	sd	s0,32(sp)
ffffffffc0205310:	ec26                	sd	s1,24(sp)
ffffffffc0205312:	e84a                	sd	s2,16(sp)
ffffffffc0205314:	e44e                	sd	s3,8(sp)
ffffffffc0205316:	e052                	sd	s4,0(sp)
ffffffffc0205318:	c52d                	beqz	a0,ffffffffc0205382 <dup_files+0x78>
ffffffffc020531a:	842e                	mv	s0,a1
ffffffffc020531c:	c1bd                	beqz	a1,ffffffffc0205382 <dup_files+0x78>
ffffffffc020531e:	491c                	lw	a5,16(a0)
ffffffffc0205320:	84aa                	mv	s1,a0
ffffffffc0205322:	e3c1                	bnez	a5,ffffffffc02053a2 <dup_files+0x98>
ffffffffc0205324:	499c                	lw	a5,16(a1)
ffffffffc0205326:	06f05e63          	blez	a5,ffffffffc02053a2 <dup_files+0x98>
ffffffffc020532a:	6188                	ld	a0,0(a1)
ffffffffc020532c:	e088                	sd	a0,0(s1)
ffffffffc020532e:	c119                	beqz	a0,ffffffffc0205334 <dup_files+0x2a>
ffffffffc0205330:	44c020ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc0205334:	6400                	ld	s0,8(s0)
ffffffffc0205336:	6905                	lui	s2,0x1
ffffffffc0205338:	fc090913          	addi	s2,s2,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc020533c:	6484                	ld	s1,8(s1)
ffffffffc020533e:	9922                	add	s2,s2,s0
ffffffffc0205340:	4989                	li	s3,2
ffffffffc0205342:	4a05                	li	s4,1
ffffffffc0205344:	a039                	j	ffffffffc0205352 <dup_files+0x48>
ffffffffc0205346:	03840413          	addi	s0,s0,56
ffffffffc020534a:	03848493          	addi	s1,s1,56
ffffffffc020534e:	02890163          	beq	s2,s0,ffffffffc0205370 <dup_files+0x66>
ffffffffc0205352:	401c                	lw	a5,0(s0)
ffffffffc0205354:	ff3799e3          	bne	a5,s3,ffffffffc0205346 <dup_files+0x3c>
ffffffffc0205358:	0144a023          	sw	s4,0(s1)
ffffffffc020535c:	85a2                	mv	a1,s0
ffffffffc020535e:	8526                	mv	a0,s1
ffffffffc0205360:	03840413          	addi	s0,s0,56
ffffffffc0205364:	e6cff0ef          	jal	ra,ffffffffc02049d0 <fd_array_dup>
ffffffffc0205368:	03848493          	addi	s1,s1,56
ffffffffc020536c:	fe8913e3          	bne	s2,s0,ffffffffc0205352 <dup_files+0x48>
ffffffffc0205370:	70a2                	ld	ra,40(sp)
ffffffffc0205372:	7402                	ld	s0,32(sp)
ffffffffc0205374:	64e2                	ld	s1,24(sp)
ffffffffc0205376:	6942                	ld	s2,16(sp)
ffffffffc0205378:	69a2                	ld	s3,8(sp)
ffffffffc020537a:	6a02                	ld	s4,0(sp)
ffffffffc020537c:	4501                	li	a0,0
ffffffffc020537e:	6145                	addi	sp,sp,48
ffffffffc0205380:	8082                	ret
ffffffffc0205382:	00008697          	auipc	a3,0x8
ffffffffc0205386:	ae668693          	addi	a3,a3,-1306 # ffffffffc020ce68 <default_pmm_manager+0x8d8>
ffffffffc020538a:	00006617          	auipc	a2,0x6
ffffffffc020538e:	71e60613          	addi	a2,a2,1822 # ffffffffc020baa8 <commands+0x210>
ffffffffc0205392:	05300593          	li	a1,83
ffffffffc0205396:	00008517          	auipc	a0,0x8
ffffffffc020539a:	16a50513          	addi	a0,a0,362 # ffffffffc020d500 <CSWTCH.79+0x48>
ffffffffc020539e:	900fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02053a2:	00008697          	auipc	a3,0x8
ffffffffc02053a6:	18668693          	addi	a3,a3,390 # ffffffffc020d528 <CSWTCH.79+0x70>
ffffffffc02053aa:	00006617          	auipc	a2,0x6
ffffffffc02053ae:	6fe60613          	addi	a2,a2,1790 # ffffffffc020baa8 <commands+0x210>
ffffffffc02053b2:	05400593          	li	a1,84
ffffffffc02053b6:	00008517          	auipc	a0,0x8
ffffffffc02053ba:	14a50513          	addi	a0,a0,330 # ffffffffc020d500 <CSWTCH.79+0x48>
ffffffffc02053be:	8e0fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02053c2 <iobuf_skip.part.0>:
ffffffffc02053c2:	1141                	addi	sp,sp,-16
ffffffffc02053c4:	00008697          	auipc	a3,0x8
ffffffffc02053c8:	19468693          	addi	a3,a3,404 # ffffffffc020d558 <CSWTCH.79+0xa0>
ffffffffc02053cc:	00006617          	auipc	a2,0x6
ffffffffc02053d0:	6dc60613          	addi	a2,a2,1756 # ffffffffc020baa8 <commands+0x210>
ffffffffc02053d4:	04a00593          	li	a1,74
ffffffffc02053d8:	00008517          	auipc	a0,0x8
ffffffffc02053dc:	19850513          	addi	a0,a0,408 # ffffffffc020d570 <CSWTCH.79+0xb8>
ffffffffc02053e0:	e406                	sd	ra,8(sp)
ffffffffc02053e2:	8bcfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02053e6 <iobuf_init>:
ffffffffc02053e6:	e10c                	sd	a1,0(a0)
ffffffffc02053e8:	e514                	sd	a3,8(a0)
ffffffffc02053ea:	ed10                	sd	a2,24(a0)
ffffffffc02053ec:	e910                	sd	a2,16(a0)
ffffffffc02053ee:	8082                	ret

ffffffffc02053f0 <iobuf_move>:
ffffffffc02053f0:	7179                	addi	sp,sp,-48
ffffffffc02053f2:	ec26                	sd	s1,24(sp)
ffffffffc02053f4:	6d04                	ld	s1,24(a0)
ffffffffc02053f6:	f022                	sd	s0,32(sp)
ffffffffc02053f8:	e84a                	sd	s2,16(sp)
ffffffffc02053fa:	e44e                	sd	s3,8(sp)
ffffffffc02053fc:	f406                	sd	ra,40(sp)
ffffffffc02053fe:	842a                	mv	s0,a0
ffffffffc0205400:	8932                	mv	s2,a2
ffffffffc0205402:	852e                	mv	a0,a1
ffffffffc0205404:	89ba                	mv	s3,a4
ffffffffc0205406:	00967363          	bgeu	a2,s1,ffffffffc020540c <iobuf_move+0x1c>
ffffffffc020540a:	84b2                	mv	s1,a2
ffffffffc020540c:	c495                	beqz	s1,ffffffffc0205438 <iobuf_move+0x48>
ffffffffc020540e:	600c                	ld	a1,0(s0)
ffffffffc0205410:	c681                	beqz	a3,ffffffffc0205418 <iobuf_move+0x28>
ffffffffc0205412:	87ae                	mv	a5,a1
ffffffffc0205414:	85aa                	mv	a1,a0
ffffffffc0205416:	853e                	mv	a0,a5
ffffffffc0205418:	8626                	mv	a2,s1
ffffffffc020541a:	1be060ef          	jal	ra,ffffffffc020b5d8 <memmove>
ffffffffc020541e:	6c1c                	ld	a5,24(s0)
ffffffffc0205420:	0297ea63          	bltu	a5,s1,ffffffffc0205454 <iobuf_move+0x64>
ffffffffc0205424:	6014                	ld	a3,0(s0)
ffffffffc0205426:	6418                	ld	a4,8(s0)
ffffffffc0205428:	8f85                	sub	a5,a5,s1
ffffffffc020542a:	96a6                	add	a3,a3,s1
ffffffffc020542c:	9726                	add	a4,a4,s1
ffffffffc020542e:	e014                	sd	a3,0(s0)
ffffffffc0205430:	e418                	sd	a4,8(s0)
ffffffffc0205432:	ec1c                	sd	a5,24(s0)
ffffffffc0205434:	40990933          	sub	s2,s2,s1
ffffffffc0205438:	00098463          	beqz	s3,ffffffffc0205440 <iobuf_move+0x50>
ffffffffc020543c:	0099b023          	sd	s1,0(s3)
ffffffffc0205440:	4501                	li	a0,0
ffffffffc0205442:	00091b63          	bnez	s2,ffffffffc0205458 <iobuf_move+0x68>
ffffffffc0205446:	70a2                	ld	ra,40(sp)
ffffffffc0205448:	7402                	ld	s0,32(sp)
ffffffffc020544a:	64e2                	ld	s1,24(sp)
ffffffffc020544c:	6942                	ld	s2,16(sp)
ffffffffc020544e:	69a2                	ld	s3,8(sp)
ffffffffc0205450:	6145                	addi	sp,sp,48
ffffffffc0205452:	8082                	ret
ffffffffc0205454:	f6fff0ef          	jal	ra,ffffffffc02053c2 <iobuf_skip.part.0>
ffffffffc0205458:	5571                	li	a0,-4
ffffffffc020545a:	b7f5                	j	ffffffffc0205446 <iobuf_move+0x56>

ffffffffc020545c <iobuf_skip>:
ffffffffc020545c:	6d1c                	ld	a5,24(a0)
ffffffffc020545e:	00b7eb63          	bltu	a5,a1,ffffffffc0205474 <iobuf_skip+0x18>
ffffffffc0205462:	6114                	ld	a3,0(a0)
ffffffffc0205464:	6518                	ld	a4,8(a0)
ffffffffc0205466:	8f8d                	sub	a5,a5,a1
ffffffffc0205468:	96ae                	add	a3,a3,a1
ffffffffc020546a:	95ba                	add	a1,a1,a4
ffffffffc020546c:	e114                	sd	a3,0(a0)
ffffffffc020546e:	e50c                	sd	a1,8(a0)
ffffffffc0205470:	ed1c                	sd	a5,24(a0)
ffffffffc0205472:	8082                	ret
ffffffffc0205474:	1141                	addi	sp,sp,-16
ffffffffc0205476:	e406                	sd	ra,8(sp)
ffffffffc0205478:	f4bff0ef          	jal	ra,ffffffffc02053c2 <iobuf_skip.part.0>

ffffffffc020547c <copy_path>:
ffffffffc020547c:	7139                	addi	sp,sp,-64
ffffffffc020547e:	f04a                	sd	s2,32(sp)
ffffffffc0205480:	00091917          	auipc	s2,0x91
ffffffffc0205484:	44090913          	addi	s2,s2,1088 # ffffffffc02968c0 <current>
ffffffffc0205488:	00093703          	ld	a4,0(s2)
ffffffffc020548c:	ec4e                	sd	s3,24(sp)
ffffffffc020548e:	89aa                	mv	s3,a0
ffffffffc0205490:	6505                	lui	a0,0x1
ffffffffc0205492:	f426                	sd	s1,40(sp)
ffffffffc0205494:	e852                	sd	s4,16(sp)
ffffffffc0205496:	fc06                	sd	ra,56(sp)
ffffffffc0205498:	f822                	sd	s0,48(sp)
ffffffffc020549a:	e456                	sd	s5,8(sp)
ffffffffc020549c:	02873a03          	ld	s4,40(a4)
ffffffffc02054a0:	84ae                	mv	s1,a1
ffffffffc02054a2:	af1fc0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc02054a6:	c141                	beqz	a0,ffffffffc0205526 <copy_path+0xaa>
ffffffffc02054a8:	842a                	mv	s0,a0
ffffffffc02054aa:	040a0563          	beqz	s4,ffffffffc02054f4 <copy_path+0x78>
ffffffffc02054ae:	038a0a93          	addi	s5,s4,56
ffffffffc02054b2:	8556                	mv	a0,s5
ffffffffc02054b4:	8b4ff0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc02054b8:	00093783          	ld	a5,0(s2)
ffffffffc02054bc:	cba1                	beqz	a5,ffffffffc020550c <copy_path+0x90>
ffffffffc02054be:	43dc                	lw	a5,4(a5)
ffffffffc02054c0:	6685                	lui	a3,0x1
ffffffffc02054c2:	8626                	mv	a2,s1
ffffffffc02054c4:	04fa2823          	sw	a5,80(s4)
ffffffffc02054c8:	85a2                	mv	a1,s0
ffffffffc02054ca:	8552                	mv	a0,s4
ffffffffc02054cc:	ec5fe0ef          	jal	ra,ffffffffc0204390 <copy_string>
ffffffffc02054d0:	c529                	beqz	a0,ffffffffc020551a <copy_path+0x9e>
ffffffffc02054d2:	8556                	mv	a0,s5
ffffffffc02054d4:	890ff0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc02054d8:	040a2823          	sw	zero,80(s4)
ffffffffc02054dc:	0089b023          	sd	s0,0(s3)
ffffffffc02054e0:	4501                	li	a0,0
ffffffffc02054e2:	70e2                	ld	ra,56(sp)
ffffffffc02054e4:	7442                	ld	s0,48(sp)
ffffffffc02054e6:	74a2                	ld	s1,40(sp)
ffffffffc02054e8:	7902                	ld	s2,32(sp)
ffffffffc02054ea:	69e2                	ld	s3,24(sp)
ffffffffc02054ec:	6a42                	ld	s4,16(sp)
ffffffffc02054ee:	6aa2                	ld	s5,8(sp)
ffffffffc02054f0:	6121                	addi	sp,sp,64
ffffffffc02054f2:	8082                	ret
ffffffffc02054f4:	85aa                	mv	a1,a0
ffffffffc02054f6:	6685                	lui	a3,0x1
ffffffffc02054f8:	8626                	mv	a2,s1
ffffffffc02054fa:	4501                	li	a0,0
ffffffffc02054fc:	e95fe0ef          	jal	ra,ffffffffc0204390 <copy_string>
ffffffffc0205500:	fd71                	bnez	a0,ffffffffc02054dc <copy_path+0x60>
ffffffffc0205502:	8522                	mv	a0,s0
ffffffffc0205504:	b3ffc0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0205508:	5575                	li	a0,-3
ffffffffc020550a:	bfe1                	j	ffffffffc02054e2 <copy_path+0x66>
ffffffffc020550c:	6685                	lui	a3,0x1
ffffffffc020550e:	8626                	mv	a2,s1
ffffffffc0205510:	85a2                	mv	a1,s0
ffffffffc0205512:	8552                	mv	a0,s4
ffffffffc0205514:	e7dfe0ef          	jal	ra,ffffffffc0204390 <copy_string>
ffffffffc0205518:	fd4d                	bnez	a0,ffffffffc02054d2 <copy_path+0x56>
ffffffffc020551a:	8556                	mv	a0,s5
ffffffffc020551c:	848ff0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc0205520:	040a2823          	sw	zero,80(s4)
ffffffffc0205524:	bff9                	j	ffffffffc0205502 <copy_path+0x86>
ffffffffc0205526:	5571                	li	a0,-4
ffffffffc0205528:	bf6d                	j	ffffffffc02054e2 <copy_path+0x66>

ffffffffc020552a <sysfile_open>:
ffffffffc020552a:	7179                	addi	sp,sp,-48
ffffffffc020552c:	872a                	mv	a4,a0
ffffffffc020552e:	ec26                	sd	s1,24(sp)
ffffffffc0205530:	0028                	addi	a0,sp,8
ffffffffc0205532:	84ae                	mv	s1,a1
ffffffffc0205534:	85ba                	mv	a1,a4
ffffffffc0205536:	f022                	sd	s0,32(sp)
ffffffffc0205538:	f406                	sd	ra,40(sp)
ffffffffc020553a:	f43ff0ef          	jal	ra,ffffffffc020547c <copy_path>
ffffffffc020553e:	842a                	mv	s0,a0
ffffffffc0205540:	e909                	bnez	a0,ffffffffc0205552 <sysfile_open+0x28>
ffffffffc0205542:	6522                	ld	a0,8(sp)
ffffffffc0205544:	85a6                	mv	a1,s1
ffffffffc0205546:	d60ff0ef          	jal	ra,ffffffffc0204aa6 <file_open>
ffffffffc020554a:	842a                	mv	s0,a0
ffffffffc020554c:	6522                	ld	a0,8(sp)
ffffffffc020554e:	af5fc0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0205552:	70a2                	ld	ra,40(sp)
ffffffffc0205554:	8522                	mv	a0,s0
ffffffffc0205556:	7402                	ld	s0,32(sp)
ffffffffc0205558:	64e2                	ld	s1,24(sp)
ffffffffc020555a:	6145                	addi	sp,sp,48
ffffffffc020555c:	8082                	ret

ffffffffc020555e <sysfile_close>:
ffffffffc020555e:	e46ff06f          	j	ffffffffc0204ba4 <file_close>

ffffffffc0205562 <sysfile_read>:
ffffffffc0205562:	7159                	addi	sp,sp,-112
ffffffffc0205564:	f0a2                	sd	s0,96(sp)
ffffffffc0205566:	f486                	sd	ra,104(sp)
ffffffffc0205568:	eca6                	sd	s1,88(sp)
ffffffffc020556a:	e8ca                	sd	s2,80(sp)
ffffffffc020556c:	e4ce                	sd	s3,72(sp)
ffffffffc020556e:	e0d2                	sd	s4,64(sp)
ffffffffc0205570:	fc56                	sd	s5,56(sp)
ffffffffc0205572:	f85a                	sd	s6,48(sp)
ffffffffc0205574:	f45e                	sd	s7,40(sp)
ffffffffc0205576:	f062                	sd	s8,32(sp)
ffffffffc0205578:	ec66                	sd	s9,24(sp)
ffffffffc020557a:	4401                	li	s0,0
ffffffffc020557c:	ee19                	bnez	a2,ffffffffc020559a <sysfile_read+0x38>
ffffffffc020557e:	70a6                	ld	ra,104(sp)
ffffffffc0205580:	8522                	mv	a0,s0
ffffffffc0205582:	7406                	ld	s0,96(sp)
ffffffffc0205584:	64e6                	ld	s1,88(sp)
ffffffffc0205586:	6946                	ld	s2,80(sp)
ffffffffc0205588:	69a6                	ld	s3,72(sp)
ffffffffc020558a:	6a06                	ld	s4,64(sp)
ffffffffc020558c:	7ae2                	ld	s5,56(sp)
ffffffffc020558e:	7b42                	ld	s6,48(sp)
ffffffffc0205590:	7ba2                	ld	s7,40(sp)
ffffffffc0205592:	7c02                	ld	s8,32(sp)
ffffffffc0205594:	6ce2                	ld	s9,24(sp)
ffffffffc0205596:	6165                	addi	sp,sp,112
ffffffffc0205598:	8082                	ret
ffffffffc020559a:	00091c97          	auipc	s9,0x91
ffffffffc020559e:	326c8c93          	addi	s9,s9,806 # ffffffffc02968c0 <current>
ffffffffc02055a2:	000cb783          	ld	a5,0(s9)
ffffffffc02055a6:	84b2                	mv	s1,a2
ffffffffc02055a8:	8b2e                	mv	s6,a1
ffffffffc02055aa:	4601                	li	a2,0
ffffffffc02055ac:	4585                	li	a1,1
ffffffffc02055ae:	0287b903          	ld	s2,40(a5)
ffffffffc02055b2:	8aaa                	mv	s5,a0
ffffffffc02055b4:	c9eff0ef          	jal	ra,ffffffffc0204a52 <file_testfd>
ffffffffc02055b8:	c959                	beqz	a0,ffffffffc020564e <sysfile_read+0xec>
ffffffffc02055ba:	6505                	lui	a0,0x1
ffffffffc02055bc:	9d7fc0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc02055c0:	89aa                	mv	s3,a0
ffffffffc02055c2:	c941                	beqz	a0,ffffffffc0205652 <sysfile_read+0xf0>
ffffffffc02055c4:	4b81                	li	s7,0
ffffffffc02055c6:	6a05                	lui	s4,0x1
ffffffffc02055c8:	03890c13          	addi	s8,s2,56
ffffffffc02055cc:	0744ec63          	bltu	s1,s4,ffffffffc0205644 <sysfile_read+0xe2>
ffffffffc02055d0:	e452                	sd	s4,8(sp)
ffffffffc02055d2:	6605                	lui	a2,0x1
ffffffffc02055d4:	0034                	addi	a3,sp,8
ffffffffc02055d6:	85ce                	mv	a1,s3
ffffffffc02055d8:	8556                	mv	a0,s5
ffffffffc02055da:	e20ff0ef          	jal	ra,ffffffffc0204bfa <file_read>
ffffffffc02055de:	66a2                	ld	a3,8(sp)
ffffffffc02055e0:	842a                	mv	s0,a0
ffffffffc02055e2:	ca9d                	beqz	a3,ffffffffc0205618 <sysfile_read+0xb6>
ffffffffc02055e4:	00090c63          	beqz	s2,ffffffffc02055fc <sysfile_read+0x9a>
ffffffffc02055e8:	8562                	mv	a0,s8
ffffffffc02055ea:	f7ffe0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc02055ee:	000cb783          	ld	a5,0(s9)
ffffffffc02055f2:	cfa1                	beqz	a5,ffffffffc020564a <sysfile_read+0xe8>
ffffffffc02055f4:	43dc                	lw	a5,4(a5)
ffffffffc02055f6:	66a2                	ld	a3,8(sp)
ffffffffc02055f8:	04f92823          	sw	a5,80(s2)
ffffffffc02055fc:	864e                	mv	a2,s3
ffffffffc02055fe:	85da                	mv	a1,s6
ffffffffc0205600:	854a                	mv	a0,s2
ffffffffc0205602:	d5dfe0ef          	jal	ra,ffffffffc020435e <copy_to_user>
ffffffffc0205606:	c50d                	beqz	a0,ffffffffc0205630 <sysfile_read+0xce>
ffffffffc0205608:	67a2                	ld	a5,8(sp)
ffffffffc020560a:	04f4e663          	bltu	s1,a5,ffffffffc0205656 <sysfile_read+0xf4>
ffffffffc020560e:	9b3e                	add	s6,s6,a5
ffffffffc0205610:	8c9d                	sub	s1,s1,a5
ffffffffc0205612:	9bbe                	add	s7,s7,a5
ffffffffc0205614:	02091263          	bnez	s2,ffffffffc0205638 <sysfile_read+0xd6>
ffffffffc0205618:	e401                	bnez	s0,ffffffffc0205620 <sysfile_read+0xbe>
ffffffffc020561a:	67a2                	ld	a5,8(sp)
ffffffffc020561c:	c391                	beqz	a5,ffffffffc0205620 <sysfile_read+0xbe>
ffffffffc020561e:	f4dd                	bnez	s1,ffffffffc02055cc <sysfile_read+0x6a>
ffffffffc0205620:	854e                	mv	a0,s3
ffffffffc0205622:	a21fc0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0205626:	f40b8ce3          	beqz	s7,ffffffffc020557e <sysfile_read+0x1c>
ffffffffc020562a:	000b841b          	sext.w	s0,s7
ffffffffc020562e:	bf81                	j	ffffffffc020557e <sysfile_read+0x1c>
ffffffffc0205630:	e011                	bnez	s0,ffffffffc0205634 <sysfile_read+0xd2>
ffffffffc0205632:	5475                	li	s0,-3
ffffffffc0205634:	fe0906e3          	beqz	s2,ffffffffc0205620 <sysfile_read+0xbe>
ffffffffc0205638:	8562                	mv	a0,s8
ffffffffc020563a:	f2bfe0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020563e:	04092823          	sw	zero,80(s2)
ffffffffc0205642:	bfd9                	j	ffffffffc0205618 <sysfile_read+0xb6>
ffffffffc0205644:	e426                	sd	s1,8(sp)
ffffffffc0205646:	8626                	mv	a2,s1
ffffffffc0205648:	b771                	j	ffffffffc02055d4 <sysfile_read+0x72>
ffffffffc020564a:	66a2                	ld	a3,8(sp)
ffffffffc020564c:	bf45                	j	ffffffffc02055fc <sysfile_read+0x9a>
ffffffffc020564e:	5475                	li	s0,-3
ffffffffc0205650:	b73d                	j	ffffffffc020557e <sysfile_read+0x1c>
ffffffffc0205652:	5471                	li	s0,-4
ffffffffc0205654:	b72d                	j	ffffffffc020557e <sysfile_read+0x1c>
ffffffffc0205656:	00008697          	auipc	a3,0x8
ffffffffc020565a:	f2a68693          	addi	a3,a3,-214 # ffffffffc020d580 <CSWTCH.79+0xc8>
ffffffffc020565e:	00006617          	auipc	a2,0x6
ffffffffc0205662:	44a60613          	addi	a2,a2,1098 # ffffffffc020baa8 <commands+0x210>
ffffffffc0205666:	05500593          	li	a1,85
ffffffffc020566a:	00008517          	auipc	a0,0x8
ffffffffc020566e:	f2650513          	addi	a0,a0,-218 # ffffffffc020d590 <CSWTCH.79+0xd8>
ffffffffc0205672:	e2dfa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205676 <sysfile_write>:
ffffffffc0205676:	7159                	addi	sp,sp,-112
ffffffffc0205678:	e8ca                	sd	s2,80(sp)
ffffffffc020567a:	f486                	sd	ra,104(sp)
ffffffffc020567c:	f0a2                	sd	s0,96(sp)
ffffffffc020567e:	eca6                	sd	s1,88(sp)
ffffffffc0205680:	e4ce                	sd	s3,72(sp)
ffffffffc0205682:	e0d2                	sd	s4,64(sp)
ffffffffc0205684:	fc56                	sd	s5,56(sp)
ffffffffc0205686:	f85a                	sd	s6,48(sp)
ffffffffc0205688:	f45e                	sd	s7,40(sp)
ffffffffc020568a:	f062                	sd	s8,32(sp)
ffffffffc020568c:	ec66                	sd	s9,24(sp)
ffffffffc020568e:	4901                	li	s2,0
ffffffffc0205690:	ee19                	bnez	a2,ffffffffc02056ae <sysfile_write+0x38>
ffffffffc0205692:	70a6                	ld	ra,104(sp)
ffffffffc0205694:	7406                	ld	s0,96(sp)
ffffffffc0205696:	64e6                	ld	s1,88(sp)
ffffffffc0205698:	69a6                	ld	s3,72(sp)
ffffffffc020569a:	6a06                	ld	s4,64(sp)
ffffffffc020569c:	7ae2                	ld	s5,56(sp)
ffffffffc020569e:	7b42                	ld	s6,48(sp)
ffffffffc02056a0:	7ba2                	ld	s7,40(sp)
ffffffffc02056a2:	7c02                	ld	s8,32(sp)
ffffffffc02056a4:	6ce2                	ld	s9,24(sp)
ffffffffc02056a6:	854a                	mv	a0,s2
ffffffffc02056a8:	6946                	ld	s2,80(sp)
ffffffffc02056aa:	6165                	addi	sp,sp,112
ffffffffc02056ac:	8082                	ret
ffffffffc02056ae:	00091c17          	auipc	s8,0x91
ffffffffc02056b2:	212c0c13          	addi	s8,s8,530 # ffffffffc02968c0 <current>
ffffffffc02056b6:	000c3783          	ld	a5,0(s8)
ffffffffc02056ba:	8432                	mv	s0,a2
ffffffffc02056bc:	89ae                	mv	s3,a1
ffffffffc02056be:	4605                	li	a2,1
ffffffffc02056c0:	4581                	li	a1,0
ffffffffc02056c2:	7784                	ld	s1,40(a5)
ffffffffc02056c4:	8baa                	mv	s7,a0
ffffffffc02056c6:	b8cff0ef          	jal	ra,ffffffffc0204a52 <file_testfd>
ffffffffc02056ca:	cd59                	beqz	a0,ffffffffc0205768 <sysfile_write+0xf2>
ffffffffc02056cc:	6505                	lui	a0,0x1
ffffffffc02056ce:	8c5fc0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc02056d2:	8a2a                	mv	s4,a0
ffffffffc02056d4:	cd41                	beqz	a0,ffffffffc020576c <sysfile_write+0xf6>
ffffffffc02056d6:	4c81                	li	s9,0
ffffffffc02056d8:	6a85                	lui	s5,0x1
ffffffffc02056da:	03848b13          	addi	s6,s1,56
ffffffffc02056de:	05546a63          	bltu	s0,s5,ffffffffc0205732 <sysfile_write+0xbc>
ffffffffc02056e2:	e456                	sd	s5,8(sp)
ffffffffc02056e4:	c8a9                	beqz	s1,ffffffffc0205736 <sysfile_write+0xc0>
ffffffffc02056e6:	855a                	mv	a0,s6
ffffffffc02056e8:	e81fe0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc02056ec:	000c3783          	ld	a5,0(s8)
ffffffffc02056f0:	c399                	beqz	a5,ffffffffc02056f6 <sysfile_write+0x80>
ffffffffc02056f2:	43dc                	lw	a5,4(a5)
ffffffffc02056f4:	c8bc                	sw	a5,80(s1)
ffffffffc02056f6:	66a2                	ld	a3,8(sp)
ffffffffc02056f8:	4701                	li	a4,0
ffffffffc02056fa:	864e                	mv	a2,s3
ffffffffc02056fc:	85d2                	mv	a1,s4
ffffffffc02056fe:	8526                	mv	a0,s1
ffffffffc0205700:	c2bfe0ef          	jal	ra,ffffffffc020432a <copy_from_user>
ffffffffc0205704:	c139                	beqz	a0,ffffffffc020574a <sysfile_write+0xd4>
ffffffffc0205706:	855a                	mv	a0,s6
ffffffffc0205708:	e5dfe0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020570c:	0404a823          	sw	zero,80(s1)
ffffffffc0205710:	6622                	ld	a2,8(sp)
ffffffffc0205712:	0034                	addi	a3,sp,8
ffffffffc0205714:	85d2                	mv	a1,s4
ffffffffc0205716:	855e                	mv	a0,s7
ffffffffc0205718:	dc8ff0ef          	jal	ra,ffffffffc0204ce0 <file_write>
ffffffffc020571c:	67a2                	ld	a5,8(sp)
ffffffffc020571e:	892a                	mv	s2,a0
ffffffffc0205720:	ef85                	bnez	a5,ffffffffc0205758 <sysfile_write+0xe2>
ffffffffc0205722:	8552                	mv	a0,s4
ffffffffc0205724:	91ffc0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0205728:	f60c85e3          	beqz	s9,ffffffffc0205692 <sysfile_write+0x1c>
ffffffffc020572c:	000c891b          	sext.w	s2,s9
ffffffffc0205730:	b78d                	j	ffffffffc0205692 <sysfile_write+0x1c>
ffffffffc0205732:	e422                	sd	s0,8(sp)
ffffffffc0205734:	f8cd                	bnez	s1,ffffffffc02056e6 <sysfile_write+0x70>
ffffffffc0205736:	66a2                	ld	a3,8(sp)
ffffffffc0205738:	4701                	li	a4,0
ffffffffc020573a:	864e                	mv	a2,s3
ffffffffc020573c:	85d2                	mv	a1,s4
ffffffffc020573e:	4501                	li	a0,0
ffffffffc0205740:	bebfe0ef          	jal	ra,ffffffffc020432a <copy_from_user>
ffffffffc0205744:	f571                	bnez	a0,ffffffffc0205710 <sysfile_write+0x9a>
ffffffffc0205746:	5975                	li	s2,-3
ffffffffc0205748:	bfe9                	j	ffffffffc0205722 <sysfile_write+0xac>
ffffffffc020574a:	855a                	mv	a0,s6
ffffffffc020574c:	e19fe0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc0205750:	5975                	li	s2,-3
ffffffffc0205752:	0404a823          	sw	zero,80(s1)
ffffffffc0205756:	b7f1                	j	ffffffffc0205722 <sysfile_write+0xac>
ffffffffc0205758:	00f46c63          	bltu	s0,a5,ffffffffc0205770 <sysfile_write+0xfa>
ffffffffc020575c:	99be                	add	s3,s3,a5
ffffffffc020575e:	8c1d                	sub	s0,s0,a5
ffffffffc0205760:	9cbe                	add	s9,s9,a5
ffffffffc0205762:	f161                	bnez	a0,ffffffffc0205722 <sysfile_write+0xac>
ffffffffc0205764:	fc2d                	bnez	s0,ffffffffc02056de <sysfile_write+0x68>
ffffffffc0205766:	bf75                	j	ffffffffc0205722 <sysfile_write+0xac>
ffffffffc0205768:	5975                	li	s2,-3
ffffffffc020576a:	b725                	j	ffffffffc0205692 <sysfile_write+0x1c>
ffffffffc020576c:	5971                	li	s2,-4
ffffffffc020576e:	b715                	j	ffffffffc0205692 <sysfile_write+0x1c>
ffffffffc0205770:	00008697          	auipc	a3,0x8
ffffffffc0205774:	e1068693          	addi	a3,a3,-496 # ffffffffc020d580 <CSWTCH.79+0xc8>
ffffffffc0205778:	00006617          	auipc	a2,0x6
ffffffffc020577c:	33060613          	addi	a2,a2,816 # ffffffffc020baa8 <commands+0x210>
ffffffffc0205780:	08a00593          	li	a1,138
ffffffffc0205784:	00008517          	auipc	a0,0x8
ffffffffc0205788:	e0c50513          	addi	a0,a0,-500 # ffffffffc020d590 <CSWTCH.79+0xd8>
ffffffffc020578c:	d13fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205790 <sysfile_seek>:
ffffffffc0205790:	e36ff06f          	j	ffffffffc0204dc6 <file_seek>

ffffffffc0205794 <sysfile_fstat>:
ffffffffc0205794:	715d                	addi	sp,sp,-80
ffffffffc0205796:	f44e                	sd	s3,40(sp)
ffffffffc0205798:	00091997          	auipc	s3,0x91
ffffffffc020579c:	12898993          	addi	s3,s3,296 # ffffffffc02968c0 <current>
ffffffffc02057a0:	0009b703          	ld	a4,0(s3)
ffffffffc02057a4:	fc26                	sd	s1,56(sp)
ffffffffc02057a6:	84ae                	mv	s1,a1
ffffffffc02057a8:	858a                	mv	a1,sp
ffffffffc02057aa:	e0a2                	sd	s0,64(sp)
ffffffffc02057ac:	f84a                	sd	s2,48(sp)
ffffffffc02057ae:	e486                	sd	ra,72(sp)
ffffffffc02057b0:	02873903          	ld	s2,40(a4)
ffffffffc02057b4:	f052                	sd	s4,32(sp)
ffffffffc02057b6:	f30ff0ef          	jal	ra,ffffffffc0204ee6 <file_fstat>
ffffffffc02057ba:	842a                	mv	s0,a0
ffffffffc02057bc:	e91d                	bnez	a0,ffffffffc02057f2 <sysfile_fstat+0x5e>
ffffffffc02057be:	04090363          	beqz	s2,ffffffffc0205804 <sysfile_fstat+0x70>
ffffffffc02057c2:	03890a13          	addi	s4,s2,56
ffffffffc02057c6:	8552                	mv	a0,s4
ffffffffc02057c8:	da1fe0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc02057cc:	0009b783          	ld	a5,0(s3)
ffffffffc02057d0:	c3b9                	beqz	a5,ffffffffc0205816 <sysfile_fstat+0x82>
ffffffffc02057d2:	43dc                	lw	a5,4(a5)
ffffffffc02057d4:	02000693          	li	a3,32
ffffffffc02057d8:	860a                	mv	a2,sp
ffffffffc02057da:	04f92823          	sw	a5,80(s2)
ffffffffc02057de:	85a6                	mv	a1,s1
ffffffffc02057e0:	854a                	mv	a0,s2
ffffffffc02057e2:	b7dfe0ef          	jal	ra,ffffffffc020435e <copy_to_user>
ffffffffc02057e6:	c121                	beqz	a0,ffffffffc0205826 <sysfile_fstat+0x92>
ffffffffc02057e8:	8552                	mv	a0,s4
ffffffffc02057ea:	d7bfe0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc02057ee:	04092823          	sw	zero,80(s2)
ffffffffc02057f2:	60a6                	ld	ra,72(sp)
ffffffffc02057f4:	8522                	mv	a0,s0
ffffffffc02057f6:	6406                	ld	s0,64(sp)
ffffffffc02057f8:	74e2                	ld	s1,56(sp)
ffffffffc02057fa:	7942                	ld	s2,48(sp)
ffffffffc02057fc:	79a2                	ld	s3,40(sp)
ffffffffc02057fe:	7a02                	ld	s4,32(sp)
ffffffffc0205800:	6161                	addi	sp,sp,80
ffffffffc0205802:	8082                	ret
ffffffffc0205804:	02000693          	li	a3,32
ffffffffc0205808:	860a                	mv	a2,sp
ffffffffc020580a:	85a6                	mv	a1,s1
ffffffffc020580c:	b53fe0ef          	jal	ra,ffffffffc020435e <copy_to_user>
ffffffffc0205810:	f16d                	bnez	a0,ffffffffc02057f2 <sysfile_fstat+0x5e>
ffffffffc0205812:	5475                	li	s0,-3
ffffffffc0205814:	bff9                	j	ffffffffc02057f2 <sysfile_fstat+0x5e>
ffffffffc0205816:	02000693          	li	a3,32
ffffffffc020581a:	860a                	mv	a2,sp
ffffffffc020581c:	85a6                	mv	a1,s1
ffffffffc020581e:	854a                	mv	a0,s2
ffffffffc0205820:	b3ffe0ef          	jal	ra,ffffffffc020435e <copy_to_user>
ffffffffc0205824:	f171                	bnez	a0,ffffffffc02057e8 <sysfile_fstat+0x54>
ffffffffc0205826:	8552                	mv	a0,s4
ffffffffc0205828:	d3dfe0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020582c:	5475                	li	s0,-3
ffffffffc020582e:	04092823          	sw	zero,80(s2)
ffffffffc0205832:	b7c1                	j	ffffffffc02057f2 <sysfile_fstat+0x5e>

ffffffffc0205834 <sysfile_fsync>:
ffffffffc0205834:	f72ff06f          	j	ffffffffc0204fa6 <file_fsync>

ffffffffc0205838 <sysfile_getcwd>:
ffffffffc0205838:	715d                	addi	sp,sp,-80
ffffffffc020583a:	f44e                	sd	s3,40(sp)
ffffffffc020583c:	00091997          	auipc	s3,0x91
ffffffffc0205840:	08498993          	addi	s3,s3,132 # ffffffffc02968c0 <current>
ffffffffc0205844:	0009b783          	ld	a5,0(s3)
ffffffffc0205848:	f84a                	sd	s2,48(sp)
ffffffffc020584a:	e486                	sd	ra,72(sp)
ffffffffc020584c:	e0a2                	sd	s0,64(sp)
ffffffffc020584e:	fc26                	sd	s1,56(sp)
ffffffffc0205850:	f052                	sd	s4,32(sp)
ffffffffc0205852:	0287b903          	ld	s2,40(a5)
ffffffffc0205856:	cda9                	beqz	a1,ffffffffc02058b0 <sysfile_getcwd+0x78>
ffffffffc0205858:	842e                	mv	s0,a1
ffffffffc020585a:	84aa                	mv	s1,a0
ffffffffc020585c:	04090363          	beqz	s2,ffffffffc02058a2 <sysfile_getcwd+0x6a>
ffffffffc0205860:	03890a13          	addi	s4,s2,56
ffffffffc0205864:	8552                	mv	a0,s4
ffffffffc0205866:	d03fe0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc020586a:	0009b783          	ld	a5,0(s3)
ffffffffc020586e:	c781                	beqz	a5,ffffffffc0205876 <sysfile_getcwd+0x3e>
ffffffffc0205870:	43dc                	lw	a5,4(a5)
ffffffffc0205872:	04f92823          	sw	a5,80(s2)
ffffffffc0205876:	4685                	li	a3,1
ffffffffc0205878:	8622                	mv	a2,s0
ffffffffc020587a:	85a6                	mv	a1,s1
ffffffffc020587c:	854a                	mv	a0,s2
ffffffffc020587e:	a19fe0ef          	jal	ra,ffffffffc0204296 <user_mem_check>
ffffffffc0205882:	e90d                	bnez	a0,ffffffffc02058b4 <sysfile_getcwd+0x7c>
ffffffffc0205884:	5475                	li	s0,-3
ffffffffc0205886:	8552                	mv	a0,s4
ffffffffc0205888:	cddfe0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020588c:	04092823          	sw	zero,80(s2)
ffffffffc0205890:	60a6                	ld	ra,72(sp)
ffffffffc0205892:	8522                	mv	a0,s0
ffffffffc0205894:	6406                	ld	s0,64(sp)
ffffffffc0205896:	74e2                	ld	s1,56(sp)
ffffffffc0205898:	7942                	ld	s2,48(sp)
ffffffffc020589a:	79a2                	ld	s3,40(sp)
ffffffffc020589c:	7a02                	ld	s4,32(sp)
ffffffffc020589e:	6161                	addi	sp,sp,80
ffffffffc02058a0:	8082                	ret
ffffffffc02058a2:	862e                	mv	a2,a1
ffffffffc02058a4:	4685                	li	a3,1
ffffffffc02058a6:	85aa                	mv	a1,a0
ffffffffc02058a8:	4501                	li	a0,0
ffffffffc02058aa:	9edfe0ef          	jal	ra,ffffffffc0204296 <user_mem_check>
ffffffffc02058ae:	ed09                	bnez	a0,ffffffffc02058c8 <sysfile_getcwd+0x90>
ffffffffc02058b0:	5475                	li	s0,-3
ffffffffc02058b2:	bff9                	j	ffffffffc0205890 <sysfile_getcwd+0x58>
ffffffffc02058b4:	8622                	mv	a2,s0
ffffffffc02058b6:	4681                	li	a3,0
ffffffffc02058b8:	85a6                	mv	a1,s1
ffffffffc02058ba:	850a                	mv	a0,sp
ffffffffc02058bc:	b2bff0ef          	jal	ra,ffffffffc02053e6 <iobuf_init>
ffffffffc02058c0:	27b020ef          	jal	ra,ffffffffc020833a <vfs_getcwd>
ffffffffc02058c4:	842a                	mv	s0,a0
ffffffffc02058c6:	b7c1                	j	ffffffffc0205886 <sysfile_getcwd+0x4e>
ffffffffc02058c8:	8622                	mv	a2,s0
ffffffffc02058ca:	4681                	li	a3,0
ffffffffc02058cc:	85a6                	mv	a1,s1
ffffffffc02058ce:	850a                	mv	a0,sp
ffffffffc02058d0:	b17ff0ef          	jal	ra,ffffffffc02053e6 <iobuf_init>
ffffffffc02058d4:	267020ef          	jal	ra,ffffffffc020833a <vfs_getcwd>
ffffffffc02058d8:	842a                	mv	s0,a0
ffffffffc02058da:	bf5d                	j	ffffffffc0205890 <sysfile_getcwd+0x58>

ffffffffc02058dc <sysfile_getdirentry>:
ffffffffc02058dc:	7139                	addi	sp,sp,-64
ffffffffc02058de:	e852                	sd	s4,16(sp)
ffffffffc02058e0:	00091a17          	auipc	s4,0x91
ffffffffc02058e4:	fe0a0a13          	addi	s4,s4,-32 # ffffffffc02968c0 <current>
ffffffffc02058e8:	000a3703          	ld	a4,0(s4)
ffffffffc02058ec:	ec4e                	sd	s3,24(sp)
ffffffffc02058ee:	89aa                	mv	s3,a0
ffffffffc02058f0:	10800513          	li	a0,264
ffffffffc02058f4:	f426                	sd	s1,40(sp)
ffffffffc02058f6:	f04a                	sd	s2,32(sp)
ffffffffc02058f8:	fc06                	sd	ra,56(sp)
ffffffffc02058fa:	f822                	sd	s0,48(sp)
ffffffffc02058fc:	e456                	sd	s5,8(sp)
ffffffffc02058fe:	7704                	ld	s1,40(a4)
ffffffffc0205900:	892e                	mv	s2,a1
ffffffffc0205902:	e90fc0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc0205906:	c169                	beqz	a0,ffffffffc02059c8 <sysfile_getdirentry+0xec>
ffffffffc0205908:	842a                	mv	s0,a0
ffffffffc020590a:	c8c1                	beqz	s1,ffffffffc020599a <sysfile_getdirentry+0xbe>
ffffffffc020590c:	03848a93          	addi	s5,s1,56
ffffffffc0205910:	8556                	mv	a0,s5
ffffffffc0205912:	c57fe0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc0205916:	000a3783          	ld	a5,0(s4)
ffffffffc020591a:	c399                	beqz	a5,ffffffffc0205920 <sysfile_getdirentry+0x44>
ffffffffc020591c:	43dc                	lw	a5,4(a5)
ffffffffc020591e:	c8bc                	sw	a5,80(s1)
ffffffffc0205920:	4705                	li	a4,1
ffffffffc0205922:	46a1                	li	a3,8
ffffffffc0205924:	864a                	mv	a2,s2
ffffffffc0205926:	85a2                	mv	a1,s0
ffffffffc0205928:	8526                	mv	a0,s1
ffffffffc020592a:	a01fe0ef          	jal	ra,ffffffffc020432a <copy_from_user>
ffffffffc020592e:	e505                	bnez	a0,ffffffffc0205956 <sysfile_getdirentry+0x7a>
ffffffffc0205930:	8556                	mv	a0,s5
ffffffffc0205932:	c33fe0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc0205936:	59f5                	li	s3,-3
ffffffffc0205938:	0404a823          	sw	zero,80(s1)
ffffffffc020593c:	8522                	mv	a0,s0
ffffffffc020593e:	f04fc0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0205942:	70e2                	ld	ra,56(sp)
ffffffffc0205944:	7442                	ld	s0,48(sp)
ffffffffc0205946:	74a2                	ld	s1,40(sp)
ffffffffc0205948:	7902                	ld	s2,32(sp)
ffffffffc020594a:	6a42                	ld	s4,16(sp)
ffffffffc020594c:	6aa2                	ld	s5,8(sp)
ffffffffc020594e:	854e                	mv	a0,s3
ffffffffc0205950:	69e2                	ld	s3,24(sp)
ffffffffc0205952:	6121                	addi	sp,sp,64
ffffffffc0205954:	8082                	ret
ffffffffc0205956:	8556                	mv	a0,s5
ffffffffc0205958:	c0dfe0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020595c:	854e                	mv	a0,s3
ffffffffc020595e:	85a2                	mv	a1,s0
ffffffffc0205960:	0404a823          	sw	zero,80(s1)
ffffffffc0205964:	ef0ff0ef          	jal	ra,ffffffffc0205054 <file_getdirentry>
ffffffffc0205968:	89aa                	mv	s3,a0
ffffffffc020596a:	f969                	bnez	a0,ffffffffc020593c <sysfile_getdirentry+0x60>
ffffffffc020596c:	8556                	mv	a0,s5
ffffffffc020596e:	bfbfe0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc0205972:	000a3783          	ld	a5,0(s4)
ffffffffc0205976:	c399                	beqz	a5,ffffffffc020597c <sysfile_getdirentry+0xa0>
ffffffffc0205978:	43dc                	lw	a5,4(a5)
ffffffffc020597a:	c8bc                	sw	a5,80(s1)
ffffffffc020597c:	10800693          	li	a3,264
ffffffffc0205980:	8622                	mv	a2,s0
ffffffffc0205982:	85ca                	mv	a1,s2
ffffffffc0205984:	8526                	mv	a0,s1
ffffffffc0205986:	9d9fe0ef          	jal	ra,ffffffffc020435e <copy_to_user>
ffffffffc020598a:	e111                	bnez	a0,ffffffffc020598e <sysfile_getdirentry+0xb2>
ffffffffc020598c:	59f5                	li	s3,-3
ffffffffc020598e:	8556                	mv	a0,s5
ffffffffc0205990:	bd5fe0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc0205994:	0404a823          	sw	zero,80(s1)
ffffffffc0205998:	b755                	j	ffffffffc020593c <sysfile_getdirentry+0x60>
ffffffffc020599a:	85aa                	mv	a1,a0
ffffffffc020599c:	4705                	li	a4,1
ffffffffc020599e:	46a1                	li	a3,8
ffffffffc02059a0:	864a                	mv	a2,s2
ffffffffc02059a2:	4501                	li	a0,0
ffffffffc02059a4:	987fe0ef          	jal	ra,ffffffffc020432a <copy_from_user>
ffffffffc02059a8:	cd11                	beqz	a0,ffffffffc02059c4 <sysfile_getdirentry+0xe8>
ffffffffc02059aa:	854e                	mv	a0,s3
ffffffffc02059ac:	85a2                	mv	a1,s0
ffffffffc02059ae:	ea6ff0ef          	jal	ra,ffffffffc0205054 <file_getdirentry>
ffffffffc02059b2:	89aa                	mv	s3,a0
ffffffffc02059b4:	f541                	bnez	a0,ffffffffc020593c <sysfile_getdirentry+0x60>
ffffffffc02059b6:	10800693          	li	a3,264
ffffffffc02059ba:	8622                	mv	a2,s0
ffffffffc02059bc:	85ca                	mv	a1,s2
ffffffffc02059be:	9a1fe0ef          	jal	ra,ffffffffc020435e <copy_to_user>
ffffffffc02059c2:	fd2d                	bnez	a0,ffffffffc020593c <sysfile_getdirentry+0x60>
ffffffffc02059c4:	59f5                	li	s3,-3
ffffffffc02059c6:	bf9d                	j	ffffffffc020593c <sysfile_getdirentry+0x60>
ffffffffc02059c8:	59f1                	li	s3,-4
ffffffffc02059ca:	bfa5                	j	ffffffffc0205942 <sysfile_getdirentry+0x66>

ffffffffc02059cc <sysfile_dup>:
ffffffffc02059cc:	f6eff06f          	j	ffffffffc020513a <file_dup>

ffffffffc02059d0 <kernel_thread_entry>:
ffffffffc02059d0:	8526                	mv	a0,s1
ffffffffc02059d2:	9402                	jalr	s0
ffffffffc02059d4:	646000ef          	jal	ra,ffffffffc020601a <do_exit>

ffffffffc02059d8 <alloc_proc>:
ffffffffc02059d8:	1141                	addi	sp,sp,-16
ffffffffc02059da:	15000513          	li	a0,336
ffffffffc02059de:	e022                	sd	s0,0(sp)
ffffffffc02059e0:	e406                	sd	ra,8(sp)
ffffffffc02059e2:	db0fc0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc02059e6:	842a                	mv	s0,a0
ffffffffc02059e8:	c141                	beqz	a0,ffffffffc0205a68 <alloc_proc+0x90>
ffffffffc02059ea:	57fd                	li	a5,-1
ffffffffc02059ec:	1782                	slli	a5,a5,0x20
ffffffffc02059ee:	e11c                	sd	a5,0(a0)
ffffffffc02059f0:	07000613          	li	a2,112
ffffffffc02059f4:	4581                	li	a1,0
ffffffffc02059f6:	00052423          	sw	zero,8(a0)
ffffffffc02059fa:	00053823          	sd	zero,16(a0)
ffffffffc02059fe:	00053c23          	sd	zero,24(a0)
ffffffffc0205a02:	02053023          	sd	zero,32(a0)
ffffffffc0205a06:	02053423          	sd	zero,40(a0)
ffffffffc0205a0a:	03050513          	addi	a0,a0,48
ffffffffc0205a0e:	3b9050ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0205a12:	00091797          	auipc	a5,0x91
ffffffffc0205a16:	e7e7b783          	ld	a5,-386(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0205a1a:	f45c                	sd	a5,168(s0)
ffffffffc0205a1c:	0a043023          	sd	zero,160(s0)
ffffffffc0205a20:	0a042823          	sw	zero,176(s0)
ffffffffc0205a24:	463d                	li	a2,15
ffffffffc0205a26:	4581                	li	a1,0
ffffffffc0205a28:	0b440513          	addi	a0,s0,180
ffffffffc0205a2c:	39b050ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0205a30:	11040793          	addi	a5,s0,272
ffffffffc0205a34:	0e042623          	sw	zero,236(s0)
ffffffffc0205a38:	0e043c23          	sd	zero,248(s0)
ffffffffc0205a3c:	10043023          	sd	zero,256(s0)
ffffffffc0205a40:	0e043823          	sd	zero,240(s0)
ffffffffc0205a44:	10043423          	sd	zero,264(s0)
ffffffffc0205a48:	10f43c23          	sd	a5,280(s0)
ffffffffc0205a4c:	10f43823          	sd	a5,272(s0)
ffffffffc0205a50:	12042023          	sw	zero,288(s0)
ffffffffc0205a54:	12043423          	sd	zero,296(s0)
ffffffffc0205a58:	12043823          	sd	zero,304(s0)
ffffffffc0205a5c:	12043c23          	sd	zero,312(s0)
ffffffffc0205a60:	14043023          	sd	zero,320(s0)
ffffffffc0205a64:	14043423          	sd	zero,328(s0)
ffffffffc0205a68:	60a2                	ld	ra,8(sp)
ffffffffc0205a6a:	8522                	mv	a0,s0
ffffffffc0205a6c:	6402                	ld	s0,0(sp)
ffffffffc0205a6e:	0141                	addi	sp,sp,16
ffffffffc0205a70:	8082                	ret

ffffffffc0205a72 <forkret>:
ffffffffc0205a72:	00091797          	auipc	a5,0x91
ffffffffc0205a76:	e4e7b783          	ld	a5,-434(a5) # ffffffffc02968c0 <current>
ffffffffc0205a7a:	73c8                	ld	a0,160(a5)
ffffffffc0205a7c:	833fb06f          	j	ffffffffc02012ae <forkrets>

ffffffffc0205a80 <load_icode_read>:
ffffffffc0205a80:	7139                	addi	sp,sp,-64
ffffffffc0205a82:	f822                	sd	s0,48(sp)
ffffffffc0205a84:	f426                	sd	s1,40(sp)
ffffffffc0205a86:	8432                	mv	s0,a2
ffffffffc0205a88:	84ae                	mv	s1,a1
ffffffffc0205a8a:	4601                	li	a2,0
ffffffffc0205a8c:	85b6                	mv	a1,a3
ffffffffc0205a8e:	f04a                	sd	s2,32(sp)
ffffffffc0205a90:	ec4e                	sd	s3,24(sp)
ffffffffc0205a92:	fc06                	sd	ra,56(sp)
ffffffffc0205a94:	892a                	mv	s2,a0
ffffffffc0205a96:	cfbff0ef          	jal	ra,ffffffffc0205790 <sysfile_seek>
ffffffffc0205a9a:	89aa                	mv	s3,a0
ffffffffc0205a9c:	e105                	bnez	a0,ffffffffc0205abc <load_icode_read+0x3c>
ffffffffc0205a9e:	e419                	bnez	s0,ffffffffc0205aac <load_icode_read+0x2c>
ffffffffc0205aa0:	a831                	j	ffffffffc0205abc <load_icode_read+0x3c>
ffffffffc0205aa2:	67a2                	ld	a5,8(sp)
ffffffffc0205aa4:	8c1d                	sub	s0,s0,a5
ffffffffc0205aa6:	c39d                	beqz	a5,ffffffffc0205acc <load_icode_read+0x4c>
ffffffffc0205aa8:	94be                	add	s1,s1,a5
ffffffffc0205aaa:	c809                	beqz	s0,ffffffffc0205abc <load_icode_read+0x3c>
ffffffffc0205aac:	8622                	mv	a2,s0
ffffffffc0205aae:	85a6                	mv	a1,s1
ffffffffc0205ab0:	0034                	addi	a3,sp,8
ffffffffc0205ab2:	854a                	mv	a0,s2
ffffffffc0205ab4:	946ff0ef          	jal	ra,ffffffffc0204bfa <file_read>
ffffffffc0205ab8:	d56d                	beqz	a0,ffffffffc0205aa2 <load_icode_read+0x22>
ffffffffc0205aba:	89aa                	mv	s3,a0
ffffffffc0205abc:	70e2                	ld	ra,56(sp)
ffffffffc0205abe:	7442                	ld	s0,48(sp)
ffffffffc0205ac0:	74a2                	ld	s1,40(sp)
ffffffffc0205ac2:	7902                	ld	s2,32(sp)
ffffffffc0205ac4:	854e                	mv	a0,s3
ffffffffc0205ac6:	69e2                	ld	s3,24(sp)
ffffffffc0205ac8:	6121                	addi	sp,sp,64
ffffffffc0205aca:	8082                	ret
ffffffffc0205acc:	70e2                	ld	ra,56(sp)
ffffffffc0205ace:	7442                	ld	s0,48(sp)
ffffffffc0205ad0:	59fd                	li	s3,-1
ffffffffc0205ad2:	74a2                	ld	s1,40(sp)
ffffffffc0205ad4:	7902                	ld	s2,32(sp)
ffffffffc0205ad6:	854e                	mv	a0,s3
ffffffffc0205ad8:	69e2                	ld	s3,24(sp)
ffffffffc0205ada:	6121                	addi	sp,sp,64
ffffffffc0205adc:	8082                	ret

ffffffffc0205ade <put_pgdir.isra.0>:
ffffffffc0205ade:	1141                	addi	sp,sp,-16
ffffffffc0205ae0:	e406                	sd	ra,8(sp)
ffffffffc0205ae2:	c02007b7          	lui	a5,0xc0200
ffffffffc0205ae6:	02f56e63          	bltu	a0,a5,ffffffffc0205b22 <put_pgdir.isra.0+0x44>
ffffffffc0205aea:	00091697          	auipc	a3,0x91
ffffffffc0205aee:	dce6b683          	ld	a3,-562(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205af2:	8d15                	sub	a0,a0,a3
ffffffffc0205af4:	8131                	srli	a0,a0,0xc
ffffffffc0205af6:	00091797          	auipc	a5,0x91
ffffffffc0205afa:	daa7b783          	ld	a5,-598(a5) # ffffffffc02968a0 <npage>
ffffffffc0205afe:	02f57f63          	bgeu	a0,a5,ffffffffc0205b3c <put_pgdir.isra.0+0x5e>
ffffffffc0205b02:	0000a697          	auipc	a3,0xa
ffffffffc0205b06:	d8e6b683          	ld	a3,-626(a3) # ffffffffc020f890 <nbase>
ffffffffc0205b0a:	60a2                	ld	ra,8(sp)
ffffffffc0205b0c:	8d15                	sub	a0,a0,a3
ffffffffc0205b0e:	00091797          	auipc	a5,0x91
ffffffffc0205b12:	d9a7b783          	ld	a5,-614(a5) # ffffffffc02968a8 <pages>
ffffffffc0205b16:	051a                	slli	a0,a0,0x6
ffffffffc0205b18:	4585                	li	a1,1
ffffffffc0205b1a:	953e                	add	a0,a0,a5
ffffffffc0205b1c:	0141                	addi	sp,sp,16
ffffffffc0205b1e:	e90fc06f          	j	ffffffffc02021ae <free_pages>
ffffffffc0205b22:	86aa                	mv	a3,a0
ffffffffc0205b24:	00007617          	auipc	a2,0x7
ffffffffc0205b28:	b4c60613          	addi	a2,a2,-1204 # ffffffffc020c670 <default_pmm_manager+0xe0>
ffffffffc0205b2c:	07700593          	li	a1,119
ffffffffc0205b30:	00007517          	auipc	a0,0x7
ffffffffc0205b34:	ac050513          	addi	a0,a0,-1344 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0205b38:	967fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205b3c:	00007617          	auipc	a2,0x7
ffffffffc0205b40:	b5c60613          	addi	a2,a2,-1188 # ffffffffc020c698 <default_pmm_manager+0x108>
ffffffffc0205b44:	06900593          	li	a1,105
ffffffffc0205b48:	00007517          	auipc	a0,0x7
ffffffffc0205b4c:	aa850513          	addi	a0,a0,-1368 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0205b50:	94ffa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205b54 <proc_run>:
ffffffffc0205b54:	1101                	addi	sp,sp,-32
ffffffffc0205b56:	e822                	sd	s0,16(sp)
ffffffffc0205b58:	ec06                	sd	ra,24(sp)
ffffffffc0205b5a:	e426                	sd	s1,8(sp)
ffffffffc0205b5c:	842a                	mv	s0,a0
ffffffffc0205b5e:	100027f3          	csrr	a5,sstatus
ffffffffc0205b62:	8b89                	andi	a5,a5,2
ffffffffc0205b64:	4481                	li	s1,0
ffffffffc0205b66:	e3b1                	bnez	a5,ffffffffc0205baa <proc_run+0x56>
ffffffffc0205b68:	745c                	ld	a5,168(s0)
ffffffffc0205b6a:	577d                	li	a4,-1
ffffffffc0205b6c:	00091697          	auipc	a3,0x91
ffffffffc0205b70:	d5468693          	addi	a3,a3,-684 # ffffffffc02968c0 <current>
ffffffffc0205b74:	177e                	slli	a4,a4,0x3f
ffffffffc0205b76:	83b1                	srli	a5,a5,0xc
ffffffffc0205b78:	6288                	ld	a0,0(a3)
ffffffffc0205b7a:	8fd9                	or	a5,a5,a4
ffffffffc0205b7c:	e280                	sd	s0,0(a3)
ffffffffc0205b7e:	18079073          	csrw	satp,a5
ffffffffc0205b82:	12000073          	sfence.vma
ffffffffc0205b86:	03040593          	addi	a1,s0,48
ffffffffc0205b8a:	03050513          	addi	a0,a0,48
ffffffffc0205b8e:	476010ef          	jal	ra,ffffffffc0207004 <switch_to>
ffffffffc0205b92:	e491                	bnez	s1,ffffffffc0205b9e <proc_run+0x4a>
ffffffffc0205b94:	60e2                	ld	ra,24(sp)
ffffffffc0205b96:	6442                	ld	s0,16(sp)
ffffffffc0205b98:	64a2                	ld	s1,8(sp)
ffffffffc0205b9a:	6105                	addi	sp,sp,32
ffffffffc0205b9c:	8082                	ret
ffffffffc0205b9e:	6442                	ld	s0,16(sp)
ffffffffc0205ba0:	60e2                	ld	ra,24(sp)
ffffffffc0205ba2:	64a2                	ld	s1,8(sp)
ffffffffc0205ba4:	6105                	addi	sp,sp,32
ffffffffc0205ba6:	8c6fb06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0205baa:	8c8fb0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205bae:	4485                	li	s1,1
ffffffffc0205bb0:	bf65                	j	ffffffffc0205b68 <proc_run+0x14>

ffffffffc0205bb2 <do_fork>:
ffffffffc0205bb2:	7119                	addi	sp,sp,-128
ffffffffc0205bb4:	ecce                	sd	s3,88(sp)
ffffffffc0205bb6:	00091997          	auipc	s3,0x91
ffffffffc0205bba:	d2298993          	addi	s3,s3,-734 # ffffffffc02968d8 <nr_process>
ffffffffc0205bbe:	0009a703          	lw	a4,0(s3)
ffffffffc0205bc2:	fc86                	sd	ra,120(sp)
ffffffffc0205bc4:	f8a2                	sd	s0,112(sp)
ffffffffc0205bc6:	f4a6                	sd	s1,104(sp)
ffffffffc0205bc8:	f0ca                	sd	s2,96(sp)
ffffffffc0205bca:	e8d2                	sd	s4,80(sp)
ffffffffc0205bcc:	e4d6                	sd	s5,72(sp)
ffffffffc0205bce:	e0da                	sd	s6,64(sp)
ffffffffc0205bd0:	fc5e                	sd	s7,56(sp)
ffffffffc0205bd2:	f862                	sd	s8,48(sp)
ffffffffc0205bd4:	f466                	sd	s9,40(sp)
ffffffffc0205bd6:	f06a                	sd	s10,32(sp)
ffffffffc0205bd8:	ec6e                	sd	s11,24(sp)
ffffffffc0205bda:	6785                	lui	a5,0x1
ffffffffc0205bdc:	32f75c63          	bge	a4,a5,ffffffffc0205f14 <do_fork+0x362>
ffffffffc0205be0:	84aa                	mv	s1,a0
ffffffffc0205be2:	892e                	mv	s2,a1
ffffffffc0205be4:	8432                	mv	s0,a2
ffffffffc0205be6:	df3ff0ef          	jal	ra,ffffffffc02059d8 <alloc_proc>
ffffffffc0205bea:	8aaa                	mv	s5,a0
ffffffffc0205bec:	34050763          	beqz	a0,ffffffffc0205f3a <do_fork+0x388>
ffffffffc0205bf0:	00091b97          	auipc	s7,0x91
ffffffffc0205bf4:	cd0b8b93          	addi	s7,s7,-816 # ffffffffc02968c0 <current>
ffffffffc0205bf8:	000bb783          	ld	a5,0(s7)
ffffffffc0205bfc:	4509                	li	a0,2
ffffffffc0205bfe:	02fab023          	sd	a5,32(s5) # 1020 <_binary_bin_swap_img_size-0x6ce0>
ffffffffc0205c02:	d6efc0ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0205c06:	30050163          	beqz	a0,ffffffffc0205f08 <do_fork+0x356>
ffffffffc0205c0a:	00091c17          	auipc	s8,0x91
ffffffffc0205c0e:	c9ec0c13          	addi	s8,s8,-866 # ffffffffc02968a8 <pages>
ffffffffc0205c12:	000c3683          	ld	a3,0(s8)
ffffffffc0205c16:	00091c97          	auipc	s9,0x91
ffffffffc0205c1a:	c8ac8c93          	addi	s9,s9,-886 # ffffffffc02968a0 <npage>
ffffffffc0205c1e:	0000aa17          	auipc	s4,0xa
ffffffffc0205c22:	c72a3a03          	ld	s4,-910(s4) # ffffffffc020f890 <nbase>
ffffffffc0205c26:	40d506b3          	sub	a3,a0,a3
ffffffffc0205c2a:	8699                	srai	a3,a3,0x6
ffffffffc0205c2c:	5b7d                	li	s6,-1
ffffffffc0205c2e:	000cb783          	ld	a5,0(s9)
ffffffffc0205c32:	96d2                	add	a3,a3,s4
ffffffffc0205c34:	00cb5b13          	srli	s6,s6,0xc
ffffffffc0205c38:	0166f733          	and	a4,a3,s6
ffffffffc0205c3c:	06b2                	slli	a3,a3,0xc
ffffffffc0205c3e:	30f77563          	bgeu	a4,a5,ffffffffc0205f48 <do_fork+0x396>
ffffffffc0205c42:	000bb703          	ld	a4,0(s7)
ffffffffc0205c46:	00091d97          	auipc	s11,0x91
ffffffffc0205c4a:	c72d8d93          	addi	s11,s11,-910 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205c4e:	000db783          	ld	a5,0(s11)
ffffffffc0205c52:	02873d03          	ld	s10,40(a4)
ffffffffc0205c56:	96be                	add	a3,a3,a5
ffffffffc0205c58:	00dab823          	sd	a3,16(s5)
ffffffffc0205c5c:	020d0a63          	beqz	s10,ffffffffc0205c90 <do_fork+0xde>
ffffffffc0205c60:	1004f793          	andi	a5,s1,256
ffffffffc0205c64:	1c078463          	beqz	a5,ffffffffc0205e2c <do_fork+0x27a>
ffffffffc0205c68:	030d2683          	lw	a3,48(s10)
ffffffffc0205c6c:	018d3783          	ld	a5,24(s10)
ffffffffc0205c70:	c0200637          	lui	a2,0xc0200
ffffffffc0205c74:	2685                	addiw	a3,a3,1
ffffffffc0205c76:	02dd2823          	sw	a3,48(s10)
ffffffffc0205c7a:	03aab423          	sd	s10,40(s5)
ffffffffc0205c7e:	2ec7e163          	bltu	a5,a2,ffffffffc0205f60 <do_fork+0x3ae>
ffffffffc0205c82:	000db703          	ld	a4,0(s11)
ffffffffc0205c86:	010ab683          	ld	a3,16(s5)
ffffffffc0205c8a:	8f99                	sub	a5,a5,a4
ffffffffc0205c8c:	0afab423          	sd	a5,168(s5)
ffffffffc0205c90:	6789                	lui	a5,0x2
ffffffffc0205c92:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0205c96:	96be                	add	a3,a3,a5
ffffffffc0205c98:	0adab023          	sd	a3,160(s5)
ffffffffc0205c9c:	87b6                	mv	a5,a3
ffffffffc0205c9e:	12040813          	addi	a6,s0,288
ffffffffc0205ca2:	6008                	ld	a0,0(s0)
ffffffffc0205ca4:	640c                	ld	a1,8(s0)
ffffffffc0205ca6:	6810                	ld	a2,16(s0)
ffffffffc0205ca8:	6c18                	ld	a4,24(s0)
ffffffffc0205caa:	e388                	sd	a0,0(a5)
ffffffffc0205cac:	e78c                	sd	a1,8(a5)
ffffffffc0205cae:	eb90                	sd	a2,16(a5)
ffffffffc0205cb0:	ef98                	sd	a4,24(a5)
ffffffffc0205cb2:	02040413          	addi	s0,s0,32
ffffffffc0205cb6:	02078793          	addi	a5,a5,32
ffffffffc0205cba:	ff0414e3          	bne	s0,a6,ffffffffc0205ca2 <do_fork+0xf0>
ffffffffc0205cbe:	0406b823          	sd	zero,80(a3)
ffffffffc0205cc2:	00091363          	bnez	s2,ffffffffc0205cc8 <do_fork+0x116>
ffffffffc0205cc6:	8936                	mv	s2,a3
ffffffffc0205cc8:	0008b817          	auipc	a6,0x8b
ffffffffc0205ccc:	39080813          	addi	a6,a6,912 # ffffffffc0291058 <last_pid.1>
ffffffffc0205cd0:	00082783          	lw	a5,0(a6)
ffffffffc0205cd4:	0126b823          	sd	s2,16(a3)
ffffffffc0205cd8:	00000717          	auipc	a4,0x0
ffffffffc0205cdc:	d9a70713          	addi	a4,a4,-614 # ffffffffc0205a72 <forkret>
ffffffffc0205ce0:	0017851b          	addiw	a0,a5,1
ffffffffc0205ce4:	02eab823          	sd	a4,48(s5)
ffffffffc0205ce8:	02dabc23          	sd	a3,56(s5)
ffffffffc0205cec:	00a82023          	sw	a0,0(a6)
ffffffffc0205cf0:	6789                	lui	a5,0x2
ffffffffc0205cf2:	1af55e63          	bge	a0,a5,ffffffffc0205eae <do_fork+0x2fc>
ffffffffc0205cf6:	0008b317          	auipc	t1,0x8b
ffffffffc0205cfa:	36630313          	addi	t1,t1,870 # ffffffffc029105c <next_safe.0>
ffffffffc0205cfe:	00032783          	lw	a5,0(t1)
ffffffffc0205d02:	00090417          	auipc	s0,0x90
ffffffffc0205d06:	abe40413          	addi	s0,s0,-1346 # ffffffffc02957c0 <proc_list>
ffffffffc0205d0a:	06f54063          	blt	a0,a5,ffffffffc0205d6a <do_fork+0x1b8>
ffffffffc0205d0e:	00090417          	auipc	s0,0x90
ffffffffc0205d12:	ab240413          	addi	s0,s0,-1358 # ffffffffc02957c0 <proc_list>
ffffffffc0205d16:	00843e03          	ld	t3,8(s0)
ffffffffc0205d1a:	6789                	lui	a5,0x2
ffffffffc0205d1c:	00f32023          	sw	a5,0(t1)
ffffffffc0205d20:	86aa                	mv	a3,a0
ffffffffc0205d22:	4581                	li	a1,0
ffffffffc0205d24:	6e89                	lui	t4,0x2
ffffffffc0205d26:	208e0563          	beq	t3,s0,ffffffffc0205f30 <do_fork+0x37e>
ffffffffc0205d2a:	88ae                	mv	a7,a1
ffffffffc0205d2c:	87f2                	mv	a5,t3
ffffffffc0205d2e:	6609                	lui	a2,0x2
ffffffffc0205d30:	a811                	j	ffffffffc0205d44 <do_fork+0x192>
ffffffffc0205d32:	00e6d663          	bge	a3,a4,ffffffffc0205d3e <do_fork+0x18c>
ffffffffc0205d36:	00c75463          	bge	a4,a2,ffffffffc0205d3e <do_fork+0x18c>
ffffffffc0205d3a:	863a                	mv	a2,a4
ffffffffc0205d3c:	4885                	li	a7,1
ffffffffc0205d3e:	679c                	ld	a5,8(a5)
ffffffffc0205d40:	00878d63          	beq	a5,s0,ffffffffc0205d5a <do_fork+0x1a8>
ffffffffc0205d44:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_bin_swap_img_size-0x5dc4>
ffffffffc0205d48:	fed715e3          	bne	a4,a3,ffffffffc0205d32 <do_fork+0x180>
ffffffffc0205d4c:	2685                	addiw	a3,a3,1
ffffffffc0205d4e:	1ac6d863          	bge	a3,a2,ffffffffc0205efe <do_fork+0x34c>
ffffffffc0205d52:	679c                	ld	a5,8(a5)
ffffffffc0205d54:	4585                	li	a1,1
ffffffffc0205d56:	fe8797e3          	bne	a5,s0,ffffffffc0205d44 <do_fork+0x192>
ffffffffc0205d5a:	c581                	beqz	a1,ffffffffc0205d62 <do_fork+0x1b0>
ffffffffc0205d5c:	00d82023          	sw	a3,0(a6)
ffffffffc0205d60:	8536                	mv	a0,a3
ffffffffc0205d62:	00088463          	beqz	a7,ffffffffc0205d6a <do_fork+0x1b8>
ffffffffc0205d66:	00c32023          	sw	a2,0(t1)
ffffffffc0205d6a:	00aaa223          	sw	a0,4(s5)
ffffffffc0205d6e:	45a9                	li	a1,10
ffffffffc0205d70:	2501                	sext.w	a0,a0
ffffffffc0205d72:	320050ef          	jal	ra,ffffffffc020b092 <hash32>
ffffffffc0205d76:	02051793          	slli	a5,a0,0x20
ffffffffc0205d7a:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0205d7e:	0008c797          	auipc	a5,0x8c
ffffffffc0205d82:	a4278793          	addi	a5,a5,-1470 # ffffffffc02917c0 <hash_list>
ffffffffc0205d86:	953e                	add	a0,a0,a5
ffffffffc0205d88:	650c                	ld	a1,8(a0)
ffffffffc0205d8a:	020ab683          	ld	a3,32(s5)
ffffffffc0205d8e:	0d8a8793          	addi	a5,s5,216
ffffffffc0205d92:	e19c                	sd	a5,0(a1)
ffffffffc0205d94:	6410                	ld	a2,8(s0)
ffffffffc0205d96:	e51c                	sd	a5,8(a0)
ffffffffc0205d98:	7af8                	ld	a4,240(a3)
ffffffffc0205d9a:	0c8a8793          	addi	a5,s5,200
ffffffffc0205d9e:	0ebab023          	sd	a1,224(s5)
ffffffffc0205da2:	0caabc23          	sd	a0,216(s5)
ffffffffc0205da6:	e21c                	sd	a5,0(a2)
ffffffffc0205da8:	e41c                	sd	a5,8(s0)
ffffffffc0205daa:	0ccab823          	sd	a2,208(s5)
ffffffffc0205dae:	0c8ab423          	sd	s0,200(s5)
ffffffffc0205db2:	0e0abc23          	sd	zero,248(s5)
ffffffffc0205db6:	10eab023          	sd	a4,256(s5)
ffffffffc0205dba:	c319                	beqz	a4,ffffffffc0205dc0 <do_fork+0x20e>
ffffffffc0205dbc:	0f573c23          	sd	s5,248(a4)
ffffffffc0205dc0:	0009a783          	lw	a5,0(s3)
ffffffffc0205dc4:	0f56b823          	sd	s5,240(a3)
ffffffffc0205dc8:	8556                	mv	a0,s5
ffffffffc0205dca:	2785                	addiw	a5,a5,1
ffffffffc0205dcc:	00f9a023          	sw	a5,0(s3)
ffffffffc0205dd0:	3d8010ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc0205dd4:	000bb783          	ld	a5,0(s7)
ffffffffc0205dd8:	004aa403          	lw	s0,4(s5)
ffffffffc0205ddc:	1487b903          	ld	s2,328(a5)
ffffffffc0205de0:	18090d63          	beqz	s2,ffffffffc0205f7a <do_fork+0x3c8>
ffffffffc0205de4:	80ad                	srli	s1,s1,0xb
ffffffffc0205de6:	8885                	andi	s1,s1,1
ffffffffc0205de8:	e899                	bnez	s1,ffffffffc0205dfe <do_fork+0x24c>
ffffffffc0205dea:	be8ff0ef          	jal	ra,ffffffffc02051d2 <files_create>
ffffffffc0205dee:	84aa                	mv	s1,a0
ffffffffc0205df0:	cd61                	beqz	a0,ffffffffc0205ec8 <do_fork+0x316>
ffffffffc0205df2:	85ca                	mv	a1,s2
ffffffffc0205df4:	d16ff0ef          	jal	ra,ffffffffc020530a <dup_files>
ffffffffc0205df8:	8926                	mv	s2,s1
ffffffffc0205dfa:	10051963          	bnez	a0,ffffffffc0205f0c <do_fork+0x35a>
ffffffffc0205dfe:	01092783          	lw	a5,16(s2)
ffffffffc0205e02:	2785                	addiw	a5,a5,1
ffffffffc0205e04:	00f92823          	sw	a5,16(s2)
ffffffffc0205e08:	152ab423          	sd	s2,328(s5)
ffffffffc0205e0c:	70e6                	ld	ra,120(sp)
ffffffffc0205e0e:	8522                	mv	a0,s0
ffffffffc0205e10:	7446                	ld	s0,112(sp)
ffffffffc0205e12:	74a6                	ld	s1,104(sp)
ffffffffc0205e14:	7906                	ld	s2,96(sp)
ffffffffc0205e16:	69e6                	ld	s3,88(sp)
ffffffffc0205e18:	6a46                	ld	s4,80(sp)
ffffffffc0205e1a:	6aa6                	ld	s5,72(sp)
ffffffffc0205e1c:	6b06                	ld	s6,64(sp)
ffffffffc0205e1e:	7be2                	ld	s7,56(sp)
ffffffffc0205e20:	7c42                	ld	s8,48(sp)
ffffffffc0205e22:	7ca2                	ld	s9,40(sp)
ffffffffc0205e24:	7d02                	ld	s10,32(sp)
ffffffffc0205e26:	6de2                	ld	s11,24(sp)
ffffffffc0205e28:	6109                	addi	sp,sp,128
ffffffffc0205e2a:	8082                	ret
ffffffffc0205e2c:	de1fd0ef          	jal	ra,ffffffffc0203c0c <mm_create>
ffffffffc0205e30:	e02a                	sd	a0,0(sp)
ffffffffc0205e32:	10050963          	beqz	a0,ffffffffc0205f44 <do_fork+0x392>
ffffffffc0205e36:	4505                	li	a0,1
ffffffffc0205e38:	b38fc0ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc0205e3c:	c151                	beqz	a0,ffffffffc0205ec0 <do_fork+0x30e>
ffffffffc0205e3e:	000c3683          	ld	a3,0(s8)
ffffffffc0205e42:	000cb783          	ld	a5,0(s9)
ffffffffc0205e46:	40d506b3          	sub	a3,a0,a3
ffffffffc0205e4a:	8699                	srai	a3,a3,0x6
ffffffffc0205e4c:	96d2                	add	a3,a3,s4
ffffffffc0205e4e:	0166fb33          	and	s6,a3,s6
ffffffffc0205e52:	06b2                	slli	a3,a3,0xc
ffffffffc0205e54:	0efb7a63          	bgeu	s6,a5,ffffffffc0205f48 <do_fork+0x396>
ffffffffc0205e58:	000dbb03          	ld	s6,0(s11)
ffffffffc0205e5c:	6605                	lui	a2,0x1
ffffffffc0205e5e:	00091597          	auipc	a1,0x91
ffffffffc0205e62:	a3a5b583          	ld	a1,-1478(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0205e66:	9b36                	add	s6,s6,a3
ffffffffc0205e68:	855a                	mv	a0,s6
ffffffffc0205e6a:	7ae050ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc0205e6e:	6702                	ld	a4,0(sp)
ffffffffc0205e70:	038d0793          	addi	a5,s10,56
ffffffffc0205e74:	853e                	mv	a0,a5
ffffffffc0205e76:	01673c23          	sd	s6,24(a4)
ffffffffc0205e7a:	e43e                	sd	a5,8(sp)
ffffffffc0205e7c:	eecfe0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc0205e80:	000bb683          	ld	a3,0(s7)
ffffffffc0205e84:	67a2                	ld	a5,8(sp)
ffffffffc0205e86:	c681                	beqz	a3,ffffffffc0205e8e <do_fork+0x2dc>
ffffffffc0205e88:	42d4                	lw	a3,4(a3)
ffffffffc0205e8a:	04dd2823          	sw	a3,80(s10)
ffffffffc0205e8e:	6502                	ld	a0,0(sp)
ffffffffc0205e90:	85ea                	mv	a1,s10
ffffffffc0205e92:	e43e                	sd	a5,8(sp)
ffffffffc0205e94:	fc9fd0ef          	jal	ra,ffffffffc0203e5c <dup_mmap>
ffffffffc0205e98:	67a2                	ld	a5,8(sp)
ffffffffc0205e9a:	8b2a                	mv	s6,a0
ffffffffc0205e9c:	853e                	mv	a0,a5
ffffffffc0205e9e:	ec6fe0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc0205ea2:	040d2823          	sw	zero,80(s10)
ffffffffc0205ea6:	060b1963          	bnez	s6,ffffffffc0205f18 <do_fork+0x366>
ffffffffc0205eaa:	6d02                	ld	s10,0(sp)
ffffffffc0205eac:	bb75                	j	ffffffffc0205c68 <do_fork+0xb6>
ffffffffc0205eae:	4785                	li	a5,1
ffffffffc0205eb0:	00f82023          	sw	a5,0(a6)
ffffffffc0205eb4:	4505                	li	a0,1
ffffffffc0205eb6:	0008b317          	auipc	t1,0x8b
ffffffffc0205eba:	1a630313          	addi	t1,t1,422 # ffffffffc029105c <next_safe.0>
ffffffffc0205ebe:	bd81                	j	ffffffffc0205d0e <do_fork+0x15c>
ffffffffc0205ec0:	6502                	ld	a0,0(sp)
ffffffffc0205ec2:	5471                	li	s0,-4
ffffffffc0205ec4:	e97fd0ef          	jal	ra,ffffffffc0203d5a <mm_destroy>
ffffffffc0205ec8:	010ab683          	ld	a3,16(s5)
ffffffffc0205ecc:	c02007b7          	lui	a5,0xc0200
ffffffffc0205ed0:	0ef6e163          	bltu	a3,a5,ffffffffc0205fb2 <do_fork+0x400>
ffffffffc0205ed4:	000db703          	ld	a4,0(s11)
ffffffffc0205ed8:	000cb783          	ld	a5,0(s9)
ffffffffc0205edc:	8e99                	sub	a3,a3,a4
ffffffffc0205ede:	82b1                	srli	a3,a3,0xc
ffffffffc0205ee0:	0af6fd63          	bgeu	a3,a5,ffffffffc0205f9a <do_fork+0x3e8>
ffffffffc0205ee4:	000c3503          	ld	a0,0(s8)
ffffffffc0205ee8:	414686b3          	sub	a3,a3,s4
ffffffffc0205eec:	069a                	slli	a3,a3,0x6
ffffffffc0205eee:	4589                	li	a1,2
ffffffffc0205ef0:	9536                	add	a0,a0,a3
ffffffffc0205ef2:	abcfc0ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc0205ef6:	8556                	mv	a0,s5
ffffffffc0205ef8:	94afc0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0205efc:	bf01                	j	ffffffffc0205e0c <do_fork+0x25a>
ffffffffc0205efe:	01d6c363          	blt	a3,t4,ffffffffc0205f04 <do_fork+0x352>
ffffffffc0205f02:	4685                	li	a3,1
ffffffffc0205f04:	4585                	li	a1,1
ffffffffc0205f06:	b505                	j	ffffffffc0205d26 <do_fork+0x174>
ffffffffc0205f08:	5471                	li	s0,-4
ffffffffc0205f0a:	b7f5                	j	ffffffffc0205ef6 <do_fork+0x344>
ffffffffc0205f0c:	8526                	mv	a0,s1
ffffffffc0205f0e:	afaff0ef          	jal	ra,ffffffffc0205208 <files_destroy>
ffffffffc0205f12:	bf5d                	j	ffffffffc0205ec8 <do_fork+0x316>
ffffffffc0205f14:	546d                	li	s0,-5
ffffffffc0205f16:	bddd                	j	ffffffffc0205e0c <do_fork+0x25a>
ffffffffc0205f18:	6482                	ld	s1,0(sp)
ffffffffc0205f1a:	5471                	li	s0,-4
ffffffffc0205f1c:	8526                	mv	a0,s1
ffffffffc0205f1e:	fd9fd0ef          	jal	ra,ffffffffc0203ef6 <exit_mmap>
ffffffffc0205f22:	6c88                	ld	a0,24(s1)
ffffffffc0205f24:	bbbff0ef          	jal	ra,ffffffffc0205ade <put_pgdir.isra.0>
ffffffffc0205f28:	8526                	mv	a0,s1
ffffffffc0205f2a:	e31fd0ef          	jal	ra,ffffffffc0203d5a <mm_destroy>
ffffffffc0205f2e:	bf69                	j	ffffffffc0205ec8 <do_fork+0x316>
ffffffffc0205f30:	c599                	beqz	a1,ffffffffc0205f3e <do_fork+0x38c>
ffffffffc0205f32:	00d82023          	sw	a3,0(a6)
ffffffffc0205f36:	8536                	mv	a0,a3
ffffffffc0205f38:	bd0d                	j	ffffffffc0205d6a <do_fork+0x1b8>
ffffffffc0205f3a:	5471                	li	s0,-4
ffffffffc0205f3c:	bdc1                	j	ffffffffc0205e0c <do_fork+0x25a>
ffffffffc0205f3e:	00082503          	lw	a0,0(a6)
ffffffffc0205f42:	b525                	j	ffffffffc0205d6a <do_fork+0x1b8>
ffffffffc0205f44:	5471                	li	s0,-4
ffffffffc0205f46:	b749                	j	ffffffffc0205ec8 <do_fork+0x316>
ffffffffc0205f48:	00006617          	auipc	a2,0x6
ffffffffc0205f4c:	68060613          	addi	a2,a2,1664 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc0205f50:	07100593          	li	a1,113
ffffffffc0205f54:	00006517          	auipc	a0,0x6
ffffffffc0205f58:	69c50513          	addi	a0,a0,1692 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0205f5c:	d42fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f60:	86be                	mv	a3,a5
ffffffffc0205f62:	00006617          	auipc	a2,0x6
ffffffffc0205f66:	70e60613          	addi	a2,a2,1806 # ffffffffc020c670 <default_pmm_manager+0xe0>
ffffffffc0205f6a:	1b100593          	li	a1,433
ffffffffc0205f6e:	00007517          	auipc	a0,0x7
ffffffffc0205f72:	63a50513          	addi	a0,a0,1594 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0205f76:	d28fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f7a:	00007697          	auipc	a3,0x7
ffffffffc0205f7e:	64668693          	addi	a3,a3,1606 # ffffffffc020d5c0 <CSWTCH.79+0x108>
ffffffffc0205f82:	00006617          	auipc	a2,0x6
ffffffffc0205f86:	b2660613          	addi	a2,a2,-1242 # ffffffffc020baa8 <commands+0x210>
ffffffffc0205f8a:	1d100593          	li	a1,465
ffffffffc0205f8e:	00007517          	auipc	a0,0x7
ffffffffc0205f92:	61a50513          	addi	a0,a0,1562 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0205f96:	d08fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f9a:	00006617          	auipc	a2,0x6
ffffffffc0205f9e:	6fe60613          	addi	a2,a2,1790 # ffffffffc020c698 <default_pmm_manager+0x108>
ffffffffc0205fa2:	06900593          	li	a1,105
ffffffffc0205fa6:	00006517          	auipc	a0,0x6
ffffffffc0205faa:	64a50513          	addi	a0,a0,1610 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0205fae:	cf0fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205fb2:	00006617          	auipc	a2,0x6
ffffffffc0205fb6:	6be60613          	addi	a2,a2,1726 # ffffffffc020c670 <default_pmm_manager+0xe0>
ffffffffc0205fba:	07700593          	li	a1,119
ffffffffc0205fbe:	00006517          	auipc	a0,0x6
ffffffffc0205fc2:	63250513          	addi	a0,a0,1586 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0205fc6:	cd8fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205fca <kernel_thread>:
ffffffffc0205fca:	7129                	addi	sp,sp,-320
ffffffffc0205fcc:	fa22                	sd	s0,304(sp)
ffffffffc0205fce:	f626                	sd	s1,296(sp)
ffffffffc0205fd0:	f24a                	sd	s2,288(sp)
ffffffffc0205fd2:	84ae                	mv	s1,a1
ffffffffc0205fd4:	892a                	mv	s2,a0
ffffffffc0205fd6:	8432                	mv	s0,a2
ffffffffc0205fd8:	4581                	li	a1,0
ffffffffc0205fda:	12000613          	li	a2,288
ffffffffc0205fde:	850a                	mv	a0,sp
ffffffffc0205fe0:	fe06                	sd	ra,312(sp)
ffffffffc0205fe2:	5e4050ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0205fe6:	e0ca                	sd	s2,64(sp)
ffffffffc0205fe8:	e4a6                	sd	s1,72(sp)
ffffffffc0205fea:	100027f3          	csrr	a5,sstatus
ffffffffc0205fee:	edd7f793          	andi	a5,a5,-291
ffffffffc0205ff2:	1207e793          	ori	a5,a5,288
ffffffffc0205ff6:	e23e                	sd	a5,256(sp)
ffffffffc0205ff8:	860a                	mv	a2,sp
ffffffffc0205ffa:	10046513          	ori	a0,s0,256
ffffffffc0205ffe:	00000797          	auipc	a5,0x0
ffffffffc0206002:	9d278793          	addi	a5,a5,-1582 # ffffffffc02059d0 <kernel_thread_entry>
ffffffffc0206006:	4581                	li	a1,0
ffffffffc0206008:	e63e                	sd	a5,264(sp)
ffffffffc020600a:	ba9ff0ef          	jal	ra,ffffffffc0205bb2 <do_fork>
ffffffffc020600e:	70f2                	ld	ra,312(sp)
ffffffffc0206010:	7452                	ld	s0,304(sp)
ffffffffc0206012:	74b2                	ld	s1,296(sp)
ffffffffc0206014:	7912                	ld	s2,288(sp)
ffffffffc0206016:	6131                	addi	sp,sp,320
ffffffffc0206018:	8082                	ret

ffffffffc020601a <do_exit>:
ffffffffc020601a:	7179                	addi	sp,sp,-48
ffffffffc020601c:	f022                	sd	s0,32(sp)
ffffffffc020601e:	00091417          	auipc	s0,0x91
ffffffffc0206022:	8a240413          	addi	s0,s0,-1886 # ffffffffc02968c0 <current>
ffffffffc0206026:	601c                	ld	a5,0(s0)
ffffffffc0206028:	f406                	sd	ra,40(sp)
ffffffffc020602a:	ec26                	sd	s1,24(sp)
ffffffffc020602c:	e84a                	sd	s2,16(sp)
ffffffffc020602e:	e44e                	sd	s3,8(sp)
ffffffffc0206030:	e052                	sd	s4,0(sp)
ffffffffc0206032:	00091717          	auipc	a4,0x91
ffffffffc0206036:	89673703          	ld	a4,-1898(a4) # ffffffffc02968c8 <idleproc>
ffffffffc020603a:	0ee78763          	beq	a5,a4,ffffffffc0206128 <do_exit+0x10e>
ffffffffc020603e:	00091497          	auipc	s1,0x91
ffffffffc0206042:	89248493          	addi	s1,s1,-1902 # ffffffffc02968d0 <initproc>
ffffffffc0206046:	6098                	ld	a4,0(s1)
ffffffffc0206048:	10e78763          	beq	a5,a4,ffffffffc0206156 <do_exit+0x13c>
ffffffffc020604c:	0287b983          	ld	s3,40(a5)
ffffffffc0206050:	892a                	mv	s2,a0
ffffffffc0206052:	02098e63          	beqz	s3,ffffffffc020608e <do_exit+0x74>
ffffffffc0206056:	00091797          	auipc	a5,0x91
ffffffffc020605a:	83a7b783          	ld	a5,-1990(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc020605e:	577d                	li	a4,-1
ffffffffc0206060:	177e                	slli	a4,a4,0x3f
ffffffffc0206062:	83b1                	srli	a5,a5,0xc
ffffffffc0206064:	8fd9                	or	a5,a5,a4
ffffffffc0206066:	18079073          	csrw	satp,a5
ffffffffc020606a:	0309a783          	lw	a5,48(s3)
ffffffffc020606e:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206072:	02e9a823          	sw	a4,48(s3)
ffffffffc0206076:	c769                	beqz	a4,ffffffffc0206140 <do_exit+0x126>
ffffffffc0206078:	601c                	ld	a5,0(s0)
ffffffffc020607a:	1487b503          	ld	a0,328(a5)
ffffffffc020607e:	0207b423          	sd	zero,40(a5)
ffffffffc0206082:	c511                	beqz	a0,ffffffffc020608e <do_exit+0x74>
ffffffffc0206084:	491c                	lw	a5,16(a0)
ffffffffc0206086:	fff7871b          	addiw	a4,a5,-1
ffffffffc020608a:	c918                	sw	a4,16(a0)
ffffffffc020608c:	cb59                	beqz	a4,ffffffffc0206122 <do_exit+0x108>
ffffffffc020608e:	601c                	ld	a5,0(s0)
ffffffffc0206090:	470d                	li	a4,3
ffffffffc0206092:	c398                	sw	a4,0(a5)
ffffffffc0206094:	0f27a423          	sw	s2,232(a5)
ffffffffc0206098:	100027f3          	csrr	a5,sstatus
ffffffffc020609c:	8b89                	andi	a5,a5,2
ffffffffc020609e:	4a01                	li	s4,0
ffffffffc02060a0:	e7f9                	bnez	a5,ffffffffc020616e <do_exit+0x154>
ffffffffc02060a2:	6018                	ld	a4,0(s0)
ffffffffc02060a4:	800007b7          	lui	a5,0x80000
ffffffffc02060a8:	0785                	addi	a5,a5,1
ffffffffc02060aa:	7308                	ld	a0,32(a4)
ffffffffc02060ac:	0ec52703          	lw	a4,236(a0)
ffffffffc02060b0:	0cf70363          	beq	a4,a5,ffffffffc0206176 <do_exit+0x15c>
ffffffffc02060b4:	6018                	ld	a4,0(s0)
ffffffffc02060b6:	7b7c                	ld	a5,240(a4)
ffffffffc02060b8:	c3a1                	beqz	a5,ffffffffc02060f8 <do_exit+0xde>
ffffffffc02060ba:	800009b7          	lui	s3,0x80000
ffffffffc02060be:	490d                	li	s2,3
ffffffffc02060c0:	0985                	addi	s3,s3,1
ffffffffc02060c2:	a021                	j	ffffffffc02060ca <do_exit+0xb0>
ffffffffc02060c4:	6018                	ld	a4,0(s0)
ffffffffc02060c6:	7b7c                	ld	a5,240(a4)
ffffffffc02060c8:	cb85                	beqz	a5,ffffffffc02060f8 <do_exit+0xde>
ffffffffc02060ca:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_bin_sfs_img_size+0xffffffff7ff8ae00>
ffffffffc02060ce:	6088                	ld	a0,0(s1)
ffffffffc02060d0:	fb74                	sd	a3,240(a4)
ffffffffc02060d2:	7978                	ld	a4,240(a0)
ffffffffc02060d4:	0e07bc23          	sd	zero,248(a5)
ffffffffc02060d8:	10e7b023          	sd	a4,256(a5)
ffffffffc02060dc:	c311                	beqz	a4,ffffffffc02060e0 <do_exit+0xc6>
ffffffffc02060de:	ff7c                	sd	a5,248(a4)
ffffffffc02060e0:	4398                	lw	a4,0(a5)
ffffffffc02060e2:	f388                	sd	a0,32(a5)
ffffffffc02060e4:	f97c                	sd	a5,240(a0)
ffffffffc02060e6:	fd271fe3          	bne	a4,s2,ffffffffc02060c4 <do_exit+0xaa>
ffffffffc02060ea:	0ec52783          	lw	a5,236(a0)
ffffffffc02060ee:	fd379be3          	bne	a5,s3,ffffffffc02060c4 <do_exit+0xaa>
ffffffffc02060f2:	0b6010ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc02060f6:	b7f9                	j	ffffffffc02060c4 <do_exit+0xaa>
ffffffffc02060f8:	020a1263          	bnez	s4,ffffffffc020611c <do_exit+0x102>
ffffffffc02060fc:	15e010ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc0206100:	601c                	ld	a5,0(s0)
ffffffffc0206102:	00007617          	auipc	a2,0x7
ffffffffc0206106:	4f660613          	addi	a2,a2,1270 # ffffffffc020d5f8 <CSWTCH.79+0x140>
ffffffffc020610a:	29600593          	li	a1,662
ffffffffc020610e:	43d4                	lw	a3,4(a5)
ffffffffc0206110:	00007517          	auipc	a0,0x7
ffffffffc0206114:	49850513          	addi	a0,a0,1176 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206118:	b86fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020611c:	b51fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0206120:	bff1                	j	ffffffffc02060fc <do_exit+0xe2>
ffffffffc0206122:	8e6ff0ef          	jal	ra,ffffffffc0205208 <files_destroy>
ffffffffc0206126:	b7a5                	j	ffffffffc020608e <do_exit+0x74>
ffffffffc0206128:	00007617          	auipc	a2,0x7
ffffffffc020612c:	4b060613          	addi	a2,a2,1200 # ffffffffc020d5d8 <CSWTCH.79+0x120>
ffffffffc0206130:	26100593          	li	a1,609
ffffffffc0206134:	00007517          	auipc	a0,0x7
ffffffffc0206138:	47450513          	addi	a0,a0,1140 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc020613c:	b62fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206140:	854e                	mv	a0,s3
ffffffffc0206142:	db5fd0ef          	jal	ra,ffffffffc0203ef6 <exit_mmap>
ffffffffc0206146:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc020614a:	995ff0ef          	jal	ra,ffffffffc0205ade <put_pgdir.isra.0>
ffffffffc020614e:	854e                	mv	a0,s3
ffffffffc0206150:	c0bfd0ef          	jal	ra,ffffffffc0203d5a <mm_destroy>
ffffffffc0206154:	b715                	j	ffffffffc0206078 <do_exit+0x5e>
ffffffffc0206156:	00007617          	auipc	a2,0x7
ffffffffc020615a:	49260613          	addi	a2,a2,1170 # ffffffffc020d5e8 <CSWTCH.79+0x130>
ffffffffc020615e:	26500593          	li	a1,613
ffffffffc0206162:	00007517          	auipc	a0,0x7
ffffffffc0206166:	44650513          	addi	a0,a0,1094 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc020616a:	b34fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020616e:	b05fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206172:	4a05                	li	s4,1
ffffffffc0206174:	b73d                	j	ffffffffc02060a2 <do_exit+0x88>
ffffffffc0206176:	032010ef          	jal	ra,ffffffffc02071a8 <wakeup_proc>
ffffffffc020617a:	bf2d                	j	ffffffffc02060b4 <do_exit+0x9a>

ffffffffc020617c <do_wait.part.0>:
ffffffffc020617c:	715d                	addi	sp,sp,-80
ffffffffc020617e:	f84a                	sd	s2,48(sp)
ffffffffc0206180:	f44e                	sd	s3,40(sp)
ffffffffc0206182:	80000937          	lui	s2,0x80000
ffffffffc0206186:	6989                	lui	s3,0x2
ffffffffc0206188:	fc26                	sd	s1,56(sp)
ffffffffc020618a:	f052                	sd	s4,32(sp)
ffffffffc020618c:	ec56                	sd	s5,24(sp)
ffffffffc020618e:	e85a                	sd	s6,16(sp)
ffffffffc0206190:	e45e                	sd	s7,8(sp)
ffffffffc0206192:	e486                	sd	ra,72(sp)
ffffffffc0206194:	e0a2                	sd	s0,64(sp)
ffffffffc0206196:	84aa                	mv	s1,a0
ffffffffc0206198:	8a2e                	mv	s4,a1
ffffffffc020619a:	00090b97          	auipc	s7,0x90
ffffffffc020619e:	726b8b93          	addi	s7,s7,1830 # ffffffffc02968c0 <current>
ffffffffc02061a2:	00050b1b          	sext.w	s6,a0
ffffffffc02061a6:	fff50a9b          	addiw	s5,a0,-1
ffffffffc02061aa:	19f9                	addi	s3,s3,-2
ffffffffc02061ac:	0905                	addi	s2,s2,1
ffffffffc02061ae:	ccbd                	beqz	s1,ffffffffc020622c <do_wait.part.0+0xb0>
ffffffffc02061b0:	0359e863          	bltu	s3,s5,ffffffffc02061e0 <do_wait.part.0+0x64>
ffffffffc02061b4:	45a9                	li	a1,10
ffffffffc02061b6:	855a                	mv	a0,s6
ffffffffc02061b8:	6db040ef          	jal	ra,ffffffffc020b092 <hash32>
ffffffffc02061bc:	02051793          	slli	a5,a0,0x20
ffffffffc02061c0:	01c7d513          	srli	a0,a5,0x1c
ffffffffc02061c4:	0008b797          	auipc	a5,0x8b
ffffffffc02061c8:	5fc78793          	addi	a5,a5,1532 # ffffffffc02917c0 <hash_list>
ffffffffc02061cc:	953e                	add	a0,a0,a5
ffffffffc02061ce:	842a                	mv	s0,a0
ffffffffc02061d0:	a029                	j	ffffffffc02061da <do_wait.part.0+0x5e>
ffffffffc02061d2:	f2c42783          	lw	a5,-212(s0)
ffffffffc02061d6:	02978163          	beq	a5,s1,ffffffffc02061f8 <do_wait.part.0+0x7c>
ffffffffc02061da:	6400                	ld	s0,8(s0)
ffffffffc02061dc:	fe851be3          	bne	a0,s0,ffffffffc02061d2 <do_wait.part.0+0x56>
ffffffffc02061e0:	5579                	li	a0,-2
ffffffffc02061e2:	60a6                	ld	ra,72(sp)
ffffffffc02061e4:	6406                	ld	s0,64(sp)
ffffffffc02061e6:	74e2                	ld	s1,56(sp)
ffffffffc02061e8:	7942                	ld	s2,48(sp)
ffffffffc02061ea:	79a2                	ld	s3,40(sp)
ffffffffc02061ec:	7a02                	ld	s4,32(sp)
ffffffffc02061ee:	6ae2                	ld	s5,24(sp)
ffffffffc02061f0:	6b42                	ld	s6,16(sp)
ffffffffc02061f2:	6ba2                	ld	s7,8(sp)
ffffffffc02061f4:	6161                	addi	sp,sp,80
ffffffffc02061f6:	8082                	ret
ffffffffc02061f8:	000bb683          	ld	a3,0(s7)
ffffffffc02061fc:	f4843783          	ld	a5,-184(s0)
ffffffffc0206200:	fed790e3          	bne	a5,a3,ffffffffc02061e0 <do_wait.part.0+0x64>
ffffffffc0206204:	f2842703          	lw	a4,-216(s0)
ffffffffc0206208:	478d                	li	a5,3
ffffffffc020620a:	0ef70b63          	beq	a4,a5,ffffffffc0206300 <do_wait.part.0+0x184>
ffffffffc020620e:	4785                	li	a5,1
ffffffffc0206210:	c29c                	sw	a5,0(a3)
ffffffffc0206212:	0f26a623          	sw	s2,236(a3)
ffffffffc0206216:	044010ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc020621a:	000bb783          	ld	a5,0(s7)
ffffffffc020621e:	0b07a783          	lw	a5,176(a5)
ffffffffc0206222:	8b85                	andi	a5,a5,1
ffffffffc0206224:	d7c9                	beqz	a5,ffffffffc02061ae <do_wait.part.0+0x32>
ffffffffc0206226:	555d                	li	a0,-9
ffffffffc0206228:	df3ff0ef          	jal	ra,ffffffffc020601a <do_exit>
ffffffffc020622c:	000bb683          	ld	a3,0(s7)
ffffffffc0206230:	7ae0                	ld	s0,240(a3)
ffffffffc0206232:	d45d                	beqz	s0,ffffffffc02061e0 <do_wait.part.0+0x64>
ffffffffc0206234:	470d                	li	a4,3
ffffffffc0206236:	a021                	j	ffffffffc020623e <do_wait.part.0+0xc2>
ffffffffc0206238:	10043403          	ld	s0,256(s0)
ffffffffc020623c:	d869                	beqz	s0,ffffffffc020620e <do_wait.part.0+0x92>
ffffffffc020623e:	401c                	lw	a5,0(s0)
ffffffffc0206240:	fee79ce3          	bne	a5,a4,ffffffffc0206238 <do_wait.part.0+0xbc>
ffffffffc0206244:	00090797          	auipc	a5,0x90
ffffffffc0206248:	6847b783          	ld	a5,1668(a5) # ffffffffc02968c8 <idleproc>
ffffffffc020624c:	0c878963          	beq	a5,s0,ffffffffc020631e <do_wait.part.0+0x1a2>
ffffffffc0206250:	00090797          	auipc	a5,0x90
ffffffffc0206254:	6807b783          	ld	a5,1664(a5) # ffffffffc02968d0 <initproc>
ffffffffc0206258:	0cf40363          	beq	s0,a5,ffffffffc020631e <do_wait.part.0+0x1a2>
ffffffffc020625c:	000a0663          	beqz	s4,ffffffffc0206268 <do_wait.part.0+0xec>
ffffffffc0206260:	0e842783          	lw	a5,232(s0)
ffffffffc0206264:	00fa2023          	sw	a5,0(s4)
ffffffffc0206268:	100027f3          	csrr	a5,sstatus
ffffffffc020626c:	8b89                	andi	a5,a5,2
ffffffffc020626e:	4581                	li	a1,0
ffffffffc0206270:	e7c1                	bnez	a5,ffffffffc02062f8 <do_wait.part.0+0x17c>
ffffffffc0206272:	6c70                	ld	a2,216(s0)
ffffffffc0206274:	7074                	ld	a3,224(s0)
ffffffffc0206276:	10043703          	ld	a4,256(s0)
ffffffffc020627a:	7c7c                	ld	a5,248(s0)
ffffffffc020627c:	e614                	sd	a3,8(a2)
ffffffffc020627e:	e290                	sd	a2,0(a3)
ffffffffc0206280:	6470                	ld	a2,200(s0)
ffffffffc0206282:	6874                	ld	a3,208(s0)
ffffffffc0206284:	e614                	sd	a3,8(a2)
ffffffffc0206286:	e290                	sd	a2,0(a3)
ffffffffc0206288:	c319                	beqz	a4,ffffffffc020628e <do_wait.part.0+0x112>
ffffffffc020628a:	ff7c                	sd	a5,248(a4)
ffffffffc020628c:	7c7c                	ld	a5,248(s0)
ffffffffc020628e:	c3b5                	beqz	a5,ffffffffc02062f2 <do_wait.part.0+0x176>
ffffffffc0206290:	10e7b023          	sd	a4,256(a5)
ffffffffc0206294:	00090717          	auipc	a4,0x90
ffffffffc0206298:	64470713          	addi	a4,a4,1604 # ffffffffc02968d8 <nr_process>
ffffffffc020629c:	431c                	lw	a5,0(a4)
ffffffffc020629e:	37fd                	addiw	a5,a5,-1
ffffffffc02062a0:	c31c                	sw	a5,0(a4)
ffffffffc02062a2:	e5a9                	bnez	a1,ffffffffc02062ec <do_wait.part.0+0x170>
ffffffffc02062a4:	6814                	ld	a3,16(s0)
ffffffffc02062a6:	c02007b7          	lui	a5,0xc0200
ffffffffc02062aa:	04f6ee63          	bltu	a3,a5,ffffffffc0206306 <do_wait.part.0+0x18a>
ffffffffc02062ae:	00090797          	auipc	a5,0x90
ffffffffc02062b2:	60a7b783          	ld	a5,1546(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc02062b6:	8e9d                	sub	a3,a3,a5
ffffffffc02062b8:	82b1                	srli	a3,a3,0xc
ffffffffc02062ba:	00090797          	auipc	a5,0x90
ffffffffc02062be:	5e67b783          	ld	a5,1510(a5) # ffffffffc02968a0 <npage>
ffffffffc02062c2:	06f6fa63          	bgeu	a3,a5,ffffffffc0206336 <do_wait.part.0+0x1ba>
ffffffffc02062c6:	00009517          	auipc	a0,0x9
ffffffffc02062ca:	5ca53503          	ld	a0,1482(a0) # ffffffffc020f890 <nbase>
ffffffffc02062ce:	8e89                	sub	a3,a3,a0
ffffffffc02062d0:	069a                	slli	a3,a3,0x6
ffffffffc02062d2:	00090517          	auipc	a0,0x90
ffffffffc02062d6:	5d653503          	ld	a0,1494(a0) # ffffffffc02968a8 <pages>
ffffffffc02062da:	9536                	add	a0,a0,a3
ffffffffc02062dc:	4589                	li	a1,2
ffffffffc02062de:	ed1fb0ef          	jal	ra,ffffffffc02021ae <free_pages>
ffffffffc02062e2:	8522                	mv	a0,s0
ffffffffc02062e4:	d5ffb0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc02062e8:	4501                	li	a0,0
ffffffffc02062ea:	bde5                	j	ffffffffc02061e2 <do_wait.part.0+0x66>
ffffffffc02062ec:	981fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02062f0:	bf55                	j	ffffffffc02062a4 <do_wait.part.0+0x128>
ffffffffc02062f2:	701c                	ld	a5,32(s0)
ffffffffc02062f4:	fbf8                	sd	a4,240(a5)
ffffffffc02062f6:	bf79                	j	ffffffffc0206294 <do_wait.part.0+0x118>
ffffffffc02062f8:	97bfa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02062fc:	4585                	li	a1,1
ffffffffc02062fe:	bf95                	j	ffffffffc0206272 <do_wait.part.0+0xf6>
ffffffffc0206300:	f2840413          	addi	s0,s0,-216
ffffffffc0206304:	b781                	j	ffffffffc0206244 <do_wait.part.0+0xc8>
ffffffffc0206306:	00006617          	auipc	a2,0x6
ffffffffc020630a:	36a60613          	addi	a2,a2,874 # ffffffffc020c670 <default_pmm_manager+0xe0>
ffffffffc020630e:	07700593          	li	a1,119
ffffffffc0206312:	00006517          	auipc	a0,0x6
ffffffffc0206316:	2de50513          	addi	a0,a0,734 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc020631a:	984fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020631e:	00007617          	auipc	a2,0x7
ffffffffc0206322:	2fa60613          	addi	a2,a2,762 # ffffffffc020d618 <CSWTCH.79+0x160>
ffffffffc0206326:	43600593          	li	a1,1078
ffffffffc020632a:	00007517          	auipc	a0,0x7
ffffffffc020632e:	27e50513          	addi	a0,a0,638 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206332:	96cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206336:	00006617          	auipc	a2,0x6
ffffffffc020633a:	36260613          	addi	a2,a2,866 # ffffffffc020c698 <default_pmm_manager+0x108>
ffffffffc020633e:	06900593          	li	a1,105
ffffffffc0206342:	00006517          	auipc	a0,0x6
ffffffffc0206346:	2ae50513          	addi	a0,a0,686 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc020634a:	954fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020634e <init_main>:
ffffffffc020634e:	1141                	addi	sp,sp,-16
ffffffffc0206350:	00007517          	auipc	a0,0x7
ffffffffc0206354:	2e850513          	addi	a0,a0,744 # ffffffffc020d638 <CSWTCH.79+0x180>
ffffffffc0206358:	e406                	sd	ra,8(sp)
ffffffffc020635a:	670010ef          	jal	ra,ffffffffc02079ca <vfs_set_bootfs>
ffffffffc020635e:	e179                	bnez	a0,ffffffffc0206424 <init_main+0xd6>
ffffffffc0206360:	e8ffb0ef          	jal	ra,ffffffffc02021ee <nr_free_pages>
ffffffffc0206364:	c2bfb0ef          	jal	ra,ffffffffc0201f8e <kallocated>
ffffffffc0206368:	4601                	li	a2,0
ffffffffc020636a:	4581                	li	a1,0
ffffffffc020636c:	00001517          	auipc	a0,0x1
ffffffffc0206370:	89650513          	addi	a0,a0,-1898 # ffffffffc0206c02 <user_main>
ffffffffc0206374:	c57ff0ef          	jal	ra,ffffffffc0205fca <kernel_thread>
ffffffffc0206378:	00a04563          	bgtz	a0,ffffffffc0206382 <init_main+0x34>
ffffffffc020637c:	a841                	j	ffffffffc020640c <init_main+0xbe>
ffffffffc020637e:	6dd000ef          	jal	ra,ffffffffc020725a <schedule>
ffffffffc0206382:	4581                	li	a1,0
ffffffffc0206384:	4501                	li	a0,0
ffffffffc0206386:	df7ff0ef          	jal	ra,ffffffffc020617c <do_wait.part.0>
ffffffffc020638a:	d975                	beqz	a0,ffffffffc020637e <init_main+0x30>
ffffffffc020638c:	e37fe0ef          	jal	ra,ffffffffc02051c2 <fs_cleanup>
ffffffffc0206390:	00007517          	auipc	a0,0x7
ffffffffc0206394:	2f050513          	addi	a0,a0,752 # ffffffffc020d680 <CSWTCH.79+0x1c8>
ffffffffc0206398:	e0ff90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020639c:	00090797          	auipc	a5,0x90
ffffffffc02063a0:	5347b783          	ld	a5,1332(a5) # ffffffffc02968d0 <initproc>
ffffffffc02063a4:	7bf8                	ld	a4,240(a5)
ffffffffc02063a6:	e339                	bnez	a4,ffffffffc02063ec <init_main+0x9e>
ffffffffc02063a8:	7ff8                	ld	a4,248(a5)
ffffffffc02063aa:	e329                	bnez	a4,ffffffffc02063ec <init_main+0x9e>
ffffffffc02063ac:	1007b703          	ld	a4,256(a5)
ffffffffc02063b0:	ef15                	bnez	a4,ffffffffc02063ec <init_main+0x9e>
ffffffffc02063b2:	00090697          	auipc	a3,0x90
ffffffffc02063b6:	5266a683          	lw	a3,1318(a3) # ffffffffc02968d8 <nr_process>
ffffffffc02063ba:	4709                	li	a4,2
ffffffffc02063bc:	0ce69163          	bne	a3,a4,ffffffffc020647e <init_main+0x130>
ffffffffc02063c0:	0008f717          	auipc	a4,0x8f
ffffffffc02063c4:	40070713          	addi	a4,a4,1024 # ffffffffc02957c0 <proc_list>
ffffffffc02063c8:	6714                	ld	a3,8(a4)
ffffffffc02063ca:	0c878793          	addi	a5,a5,200
ffffffffc02063ce:	08d79863          	bne	a5,a3,ffffffffc020645e <init_main+0x110>
ffffffffc02063d2:	6318                	ld	a4,0(a4)
ffffffffc02063d4:	06e79563          	bne	a5,a4,ffffffffc020643e <init_main+0xf0>
ffffffffc02063d8:	00007517          	auipc	a0,0x7
ffffffffc02063dc:	39050513          	addi	a0,a0,912 # ffffffffc020d768 <CSWTCH.79+0x2b0>
ffffffffc02063e0:	dc7f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02063e4:	60a2                	ld	ra,8(sp)
ffffffffc02063e6:	4501                	li	a0,0
ffffffffc02063e8:	0141                	addi	sp,sp,16
ffffffffc02063ea:	8082                	ret
ffffffffc02063ec:	00007697          	auipc	a3,0x7
ffffffffc02063f0:	2bc68693          	addi	a3,a3,700 # ffffffffc020d6a8 <CSWTCH.79+0x1f0>
ffffffffc02063f4:	00005617          	auipc	a2,0x5
ffffffffc02063f8:	6b460613          	addi	a2,a2,1716 # ffffffffc020baa8 <commands+0x210>
ffffffffc02063fc:	4ac00593          	li	a1,1196
ffffffffc0206400:	00007517          	auipc	a0,0x7
ffffffffc0206404:	1a850513          	addi	a0,a0,424 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206408:	896fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020640c:	00007617          	auipc	a2,0x7
ffffffffc0206410:	25460613          	addi	a2,a2,596 # ffffffffc020d660 <CSWTCH.79+0x1a8>
ffffffffc0206414:	49f00593          	li	a1,1183
ffffffffc0206418:	00007517          	auipc	a0,0x7
ffffffffc020641c:	19050513          	addi	a0,a0,400 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206420:	87efa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206424:	86aa                	mv	a3,a0
ffffffffc0206426:	00007617          	auipc	a2,0x7
ffffffffc020642a:	21a60613          	addi	a2,a2,538 # ffffffffc020d640 <CSWTCH.79+0x188>
ffffffffc020642e:	49700593          	li	a1,1175
ffffffffc0206432:	00007517          	auipc	a0,0x7
ffffffffc0206436:	17650513          	addi	a0,a0,374 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc020643a:	864fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020643e:	00007697          	auipc	a3,0x7
ffffffffc0206442:	2fa68693          	addi	a3,a3,762 # ffffffffc020d738 <CSWTCH.79+0x280>
ffffffffc0206446:	00005617          	auipc	a2,0x5
ffffffffc020644a:	66260613          	addi	a2,a2,1634 # ffffffffc020baa8 <commands+0x210>
ffffffffc020644e:	4af00593          	li	a1,1199
ffffffffc0206452:	00007517          	auipc	a0,0x7
ffffffffc0206456:	15650513          	addi	a0,a0,342 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc020645a:	844fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020645e:	00007697          	auipc	a3,0x7
ffffffffc0206462:	2aa68693          	addi	a3,a3,682 # ffffffffc020d708 <CSWTCH.79+0x250>
ffffffffc0206466:	00005617          	auipc	a2,0x5
ffffffffc020646a:	64260613          	addi	a2,a2,1602 # ffffffffc020baa8 <commands+0x210>
ffffffffc020646e:	4ae00593          	li	a1,1198
ffffffffc0206472:	00007517          	auipc	a0,0x7
ffffffffc0206476:	13650513          	addi	a0,a0,310 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc020647a:	824fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020647e:	00007697          	auipc	a3,0x7
ffffffffc0206482:	27a68693          	addi	a3,a3,634 # ffffffffc020d6f8 <CSWTCH.79+0x240>
ffffffffc0206486:	00005617          	auipc	a2,0x5
ffffffffc020648a:	62260613          	addi	a2,a2,1570 # ffffffffc020baa8 <commands+0x210>
ffffffffc020648e:	4ad00593          	li	a1,1197
ffffffffc0206492:	00007517          	auipc	a0,0x7
ffffffffc0206496:	11650513          	addi	a0,a0,278 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc020649a:	804fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020649e <do_execve>:
ffffffffc020649e:	cb010113          	addi	sp,sp,-848
ffffffffc02064a2:	33313423          	sd	s3,808(sp)
ffffffffc02064a6:	00090997          	auipc	s3,0x90
ffffffffc02064aa:	41a98993          	addi	s3,s3,1050 # ffffffffc02968c0 <current>
ffffffffc02064ae:	0009b683          	ld	a3,0(s3)
ffffffffc02064b2:	fff5871b          	addiw	a4,a1,-1
ffffffffc02064b6:	31613823          	sd	s6,784(sp)
ffffffffc02064ba:	34113423          	sd	ra,840(sp)
ffffffffc02064be:	34813023          	sd	s0,832(sp)
ffffffffc02064c2:	32913c23          	sd	s1,824(sp)
ffffffffc02064c6:	33213823          	sd	s2,816(sp)
ffffffffc02064ca:	33413023          	sd	s4,800(sp)
ffffffffc02064ce:	31513c23          	sd	s5,792(sp)
ffffffffc02064d2:	31713423          	sd	s7,776(sp)
ffffffffc02064d6:	31813023          	sd	s8,768(sp)
ffffffffc02064da:	2f913c23          	sd	s9,760(sp)
ffffffffc02064de:	2fa13823          	sd	s10,752(sp)
ffffffffc02064e2:	2fb13423          	sd	s11,744(sp)
ffffffffc02064e6:	d43a                	sw	a4,40(sp)
ffffffffc02064e8:	47fd                	li	a5,31
ffffffffc02064ea:	0286bb03          	ld	s6,40(a3)
ffffffffc02064ee:	5ae7e363          	bltu	a5,a4,ffffffffc0206a94 <do_execve+0x5f6>
ffffffffc02064f2:	84ae                	mv	s1,a1
ffffffffc02064f4:	842a                	mv	s0,a0
ffffffffc02064f6:	8bb2                	mv	s7,a2
ffffffffc02064f8:	4581                	li	a1,0
ffffffffc02064fa:	4641                	li	a2,16
ffffffffc02064fc:	08a8                	addi	a0,sp,88
ffffffffc02064fe:	0c8050ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0206502:	000b0c63          	beqz	s6,ffffffffc020651a <do_execve+0x7c>
ffffffffc0206506:	038b0513          	addi	a0,s6,56
ffffffffc020650a:	85efe0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc020650e:	0009b783          	ld	a5,0(s3)
ffffffffc0206512:	c781                	beqz	a5,ffffffffc020651a <do_execve+0x7c>
ffffffffc0206514:	43dc                	lw	a5,4(a5)
ffffffffc0206516:	04fb2823          	sw	a5,80(s6)
ffffffffc020651a:	40040063          	beqz	s0,ffffffffc020691a <do_execve+0x47c>
ffffffffc020651e:	46c1                	li	a3,16
ffffffffc0206520:	8622                	mv	a2,s0
ffffffffc0206522:	08ac                	addi	a1,sp,88
ffffffffc0206524:	855a                	mv	a0,s6
ffffffffc0206526:	e6bfd0ef          	jal	ra,ffffffffc0204390 <copy_string>
ffffffffc020652a:	5e050763          	beqz	a0,ffffffffc0206b18 <do_execve+0x67a>
ffffffffc020652e:	00349793          	slli	a5,s1,0x3
ffffffffc0206532:	4681                	li	a3,0
ffffffffc0206534:	863e                	mv	a2,a5
ffffffffc0206536:	85de                	mv	a1,s7
ffffffffc0206538:	855a                	mv	a0,s6
ffffffffc020653a:	e43e                	sd	a5,8(sp)
ffffffffc020653c:	d5bfd0ef          	jal	ra,ffffffffc0204296 <user_mem_check>
ffffffffc0206540:	8a5e                	mv	s4,s7
ffffffffc0206542:	5c050763          	beqz	a0,ffffffffc0206b10 <do_execve+0x672>
ffffffffc0206546:	0e010a93          	addi	s5,sp,224
ffffffffc020654a:	4401                	li	s0,0
ffffffffc020654c:	a011                	j	ffffffffc0206550 <do_execve+0xb2>
ffffffffc020654e:	846e                	mv	s0,s11
ffffffffc0206550:	6505                	lui	a0,0x1
ffffffffc0206552:	a41fb0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc0206556:	892a                	mv	s2,a0
ffffffffc0206558:	36050b63          	beqz	a0,ffffffffc02068ce <do_execve+0x430>
ffffffffc020655c:	000a3603          	ld	a2,0(s4)
ffffffffc0206560:	85aa                	mv	a1,a0
ffffffffc0206562:	6685                	lui	a3,0x1
ffffffffc0206564:	855a                	mv	a0,s6
ffffffffc0206566:	e2bfd0ef          	jal	ra,ffffffffc0204390 <copy_string>
ffffffffc020656a:	3a050363          	beqz	a0,ffffffffc0206910 <do_execve+0x472>
ffffffffc020656e:	012ab023          	sd	s2,0(s5)
ffffffffc0206572:	00140d9b          	addiw	s11,s0,1
ffffffffc0206576:	0aa1                	addi	s5,s5,8
ffffffffc0206578:	0a21                	addi	s4,s4,8
ffffffffc020657a:	fdb49ae3          	bne	s1,s11,ffffffffc020654e <do_execve+0xb0>
ffffffffc020657e:	000bb903          	ld	s2,0(s7)
ffffffffc0206582:	2e0b0d63          	beqz	s6,ffffffffc020687c <do_execve+0x3de>
ffffffffc0206586:	038b0513          	addi	a0,s6,56
ffffffffc020658a:	fdbfd0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020658e:	0009b703          	ld	a4,0(s3)
ffffffffc0206592:	040b2823          	sw	zero,80(s6)
ffffffffc0206596:	14873503          	ld	a0,328(a4)
ffffffffc020659a:	d05fe0ef          	jal	ra,ffffffffc020529e <files_closeall>
ffffffffc020659e:	4581                	li	a1,0
ffffffffc02065a0:	854a                	mv	a0,s2
ffffffffc02065a2:	f89fe0ef          	jal	ra,ffffffffc020552a <sysfile_open>
ffffffffc02065a6:	8aaa                	mv	s5,a0
ffffffffc02065a8:	2e054c63          	bltz	a0,ffffffffc02068a0 <do_execve+0x402>
ffffffffc02065ac:	00090717          	auipc	a4,0x90
ffffffffc02065b0:	2e473703          	ld	a4,740(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc02065b4:	56fd                	li	a3,-1
ffffffffc02065b6:	16fe                	slli	a3,a3,0x3f
ffffffffc02065b8:	8331                	srli	a4,a4,0xc
ffffffffc02065ba:	8f55                	or	a4,a4,a3
ffffffffc02065bc:	18071073          	csrw	satp,a4
ffffffffc02065c0:	030b2703          	lw	a4,48(s6)
ffffffffc02065c4:	fff7069b          	addiw	a3,a4,-1
ffffffffc02065c8:	02db2823          	sw	a3,48(s6)
ffffffffc02065cc:	36068c63          	beqz	a3,ffffffffc0206944 <do_execve+0x4a6>
ffffffffc02065d0:	0009b703          	ld	a4,0(s3)
ffffffffc02065d4:	02073423          	sd	zero,40(a4)
ffffffffc02065d8:	e34fd0ef          	jal	ra,ffffffffc0203c0c <mm_create>
ffffffffc02065dc:	8a2a                	mv	s4,a0
ffffffffc02065de:	2c050063          	beqz	a0,ffffffffc020689e <do_execve+0x400>
ffffffffc02065e2:	4505                	li	a0,1
ffffffffc02065e4:	b8dfb0ef          	jal	ra,ffffffffc0202170 <alloc_pages>
ffffffffc02065e8:	2a050863          	beqz	a0,ffffffffc0206898 <do_execve+0x3fa>
ffffffffc02065ec:	00090d17          	auipc	s10,0x90
ffffffffc02065f0:	2bcd0d13          	addi	s10,s10,700 # ffffffffc02968a8 <pages>
ffffffffc02065f4:	000d3683          	ld	a3,0(s10)
ffffffffc02065f8:	00090c97          	auipc	s9,0x90
ffffffffc02065fc:	2a8c8c93          	addi	s9,s9,680 # ffffffffc02968a0 <npage>
ffffffffc0206600:	00009797          	auipc	a5,0x9
ffffffffc0206604:	2907b783          	ld	a5,656(a5) # ffffffffc020f890 <nbase>
ffffffffc0206608:	40d506b3          	sub	a3,a0,a3
ffffffffc020660c:	567d                	li	a2,-1
ffffffffc020660e:	8699                	srai	a3,a3,0x6
ffffffffc0206610:	000cb703          	ld	a4,0(s9)
ffffffffc0206614:	96be                	add	a3,a3,a5
ffffffffc0206616:	e83e                	sd	a5,16(sp)
ffffffffc0206618:	00c65793          	srli	a5,a2,0xc
ffffffffc020661c:	00f6f633          	and	a2,a3,a5
ffffffffc0206620:	e03e                	sd	a5,0(sp)
ffffffffc0206622:	06b2                	slli	a3,a3,0xc
ffffffffc0206624:	50e67a63          	bgeu	a2,a4,ffffffffc0206b38 <do_execve+0x69a>
ffffffffc0206628:	00090c17          	auipc	s8,0x90
ffffffffc020662c:	290c0c13          	addi	s8,s8,656 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206630:	000c3903          	ld	s2,0(s8)
ffffffffc0206634:	6605                	lui	a2,0x1
ffffffffc0206636:	00090597          	auipc	a1,0x90
ffffffffc020663a:	2625b583          	ld	a1,610(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc020663e:	9936                	add	s2,s2,a3
ffffffffc0206640:	854a                	mv	a0,s2
ffffffffc0206642:	7d7040ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc0206646:	4681                	li	a3,0
ffffffffc0206648:	012a3c23          	sd	s2,24(s4)
ffffffffc020664c:	04000613          	li	a2,64
ffffffffc0206650:	110c                	addi	a1,sp,160
ffffffffc0206652:	8556                	mv	a0,s5
ffffffffc0206654:	c2cff0ef          	jal	ra,ffffffffc0205a80 <load_icode_read>
ffffffffc0206658:	892a                	mv	s2,a0
ffffffffc020665a:	3c051863          	bnez	a0,ffffffffc0206a2a <do_execve+0x58c>
ffffffffc020665e:	568a                	lw	a3,160(sp)
ffffffffc0206660:	464c4737          	lui	a4,0x464c4
ffffffffc0206664:	57f70713          	addi	a4,a4,1407 # 464c457f <_binary_bin_sfs_img_size+0x4644f27f>
ffffffffc0206668:	2ce69563          	bne	a3,a4,ffffffffc0206932 <do_execve+0x494>
ffffffffc020666c:	0d815703          	lhu	a4,216(sp)
ffffffffc0206670:	c729                	beqz	a4,ffffffffc02066ba <do_execve+0x21c>
ffffffffc0206672:	4881                	li	a7,0
ffffffffc0206674:	e0ee                	sd	s11,64(sp)
ffffffffc0206676:	f002                	sd	zero,32(sp)
ffffffffc0206678:	8dc6                	mv	s11,a7
ffffffffc020667a:	e4a2                	sd	s0,72(sp)
ffffffffc020667c:	f82a                	sd	a0,48(sp)
ffffffffc020667e:	fc26                	sd	s1,56(sp)
ffffffffc0206680:	668e                	ld	a3,192(sp)
ffffffffc0206682:	7782                	ld	a5,32(sp)
ffffffffc0206684:	03800613          	li	a2,56
ffffffffc0206688:	10ac                	addi	a1,sp,104
ffffffffc020668a:	96be                	add	a3,a3,a5
ffffffffc020668c:	8556                	mv	a0,s5
ffffffffc020668e:	bf2ff0ef          	jal	ra,ffffffffc0205a80 <load_icode_read>
ffffffffc0206692:	3a051663          	bnez	a0,ffffffffc0206a3e <do_execve+0x5a0>
ffffffffc0206696:	57a6                	lw	a5,104(sp)
ffffffffc0206698:	4705                	li	a4,1
ffffffffc020669a:	2ce78063          	beq	a5,a4,ffffffffc020695a <do_execve+0x4bc>
ffffffffc020669e:	7742                	ld	a4,48(sp)
ffffffffc02066a0:	7682                	ld	a3,32(sp)
ffffffffc02066a2:	0d815783          	lhu	a5,216(sp)
ffffffffc02066a6:	2705                	addiw	a4,a4,1
ffffffffc02066a8:	03868693          	addi	a3,a3,56 # 1038 <_binary_bin_swap_img_size-0x6cc8>
ffffffffc02066ac:	f83a                	sd	a4,48(sp)
ffffffffc02066ae:	f036                	sd	a3,32(sp)
ffffffffc02066b0:	fcf748e3          	blt	a4,a5,ffffffffc0206680 <do_execve+0x1e2>
ffffffffc02066b4:	6d86                	ld	s11,64(sp)
ffffffffc02066b6:	6426                	ld	s0,72(sp)
ffffffffc02066b8:	74e2                	ld	s1,56(sp)
ffffffffc02066ba:	4701                	li	a4,0
ffffffffc02066bc:	46ad                	li	a3,11
ffffffffc02066be:	00100637          	lui	a2,0x100
ffffffffc02066c2:	7ff005b7          	lui	a1,0x7ff00
ffffffffc02066c6:	8552                	mv	a0,s4
ffffffffc02066c8:	ee4fd0ef          	jal	ra,ffffffffc0203dac <mm_map>
ffffffffc02066cc:	892a                	mv	s2,a0
ffffffffc02066ce:	34051b63          	bnez	a0,ffffffffc0206a24 <do_execve+0x586>
ffffffffc02066d2:	018a3503          	ld	a0,24(s4)
ffffffffc02066d6:	467d                	li	a2,31
ffffffffc02066d8:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc02066dc:	c4afd0ef          	jal	ra,ffffffffc0203b26 <pgdir_alloc_page>
ffffffffc02066e0:	4a050563          	beqz	a0,ffffffffc0206b8a <do_execve+0x6ec>
ffffffffc02066e4:	018a3503          	ld	a0,24(s4)
ffffffffc02066e8:	467d                	li	a2,31
ffffffffc02066ea:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc02066ee:	c38fd0ef          	jal	ra,ffffffffc0203b26 <pgdir_alloc_page>
ffffffffc02066f2:	46050c63          	beqz	a0,ffffffffc0206b6a <do_execve+0x6cc>
ffffffffc02066f6:	018a3503          	ld	a0,24(s4)
ffffffffc02066fa:	467d                	li	a2,31
ffffffffc02066fc:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc0206700:	c26fd0ef          	jal	ra,ffffffffc0203b26 <pgdir_alloc_page>
ffffffffc0206704:	4c050363          	beqz	a0,ffffffffc0206bca <do_execve+0x72c>
ffffffffc0206708:	018a3503          	ld	a0,24(s4)
ffffffffc020670c:	467d                	li	a2,31
ffffffffc020670e:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc0206712:	c14fd0ef          	jal	ra,ffffffffc0203b26 <pgdir_alloc_page>
ffffffffc0206716:	48050a63          	beqz	a0,ffffffffc0206baa <do_execve+0x70c>
ffffffffc020671a:	030a2703          	lw	a4,48(s4)
ffffffffc020671e:	0009b603          	ld	a2,0(s3)
ffffffffc0206722:	018a3683          	ld	a3,24(s4)
ffffffffc0206726:	2705                	addiw	a4,a4,1
ffffffffc0206728:	02ea2823          	sw	a4,48(s4)
ffffffffc020672c:	03463423          	sd	s4,40(a2) # 100028 <_binary_bin_sfs_img_size+0x8ad28>
ffffffffc0206730:	c0200737          	lui	a4,0xc0200
ffffffffc0206734:	4ae6eb63          	bltu	a3,a4,ffffffffc0206bea <do_execve+0x74c>
ffffffffc0206738:	000c3703          	ld	a4,0(s8)
ffffffffc020673c:	8e99                	sub	a3,a3,a4
ffffffffc020673e:	00c6d713          	srli	a4,a3,0xc
ffffffffc0206742:	f654                	sd	a3,168(a2)
ffffffffc0206744:	56fd                	li	a3,-1
ffffffffc0206746:	16fe                	slli	a3,a3,0x3f
ffffffffc0206748:	8f55                	or	a4,a4,a3
ffffffffc020674a:	18071073          	csrw	satp,a4
ffffffffc020674e:	4a05                	li	s4,1
ffffffffc0206750:	1e010b93          	addi	s7,sp,480
ffffffffc0206754:	0e010b13          	addi	s6,sp,224
ffffffffc0206758:	4a81                	li	s5,0
ffffffffc020675a:	0a7e                	slli	s4,s4,0x1f
ffffffffc020675c:	000b3c03          	ld	s8,0(s6)
ffffffffc0206760:	0ba1                	addi	s7,s7,8
ffffffffc0206762:	0b21                	addi	s6,s6,8
ffffffffc0206764:	8562                	mv	a0,s8
ffffffffc0206766:	5bf040ef          	jal	ra,ffffffffc020b524 <strlen>
ffffffffc020676a:	0015079b          	addiw	a5,a0,1
ffffffffc020676e:	40fa0a33          	sub	s4,s4,a5
ffffffffc0206772:	85e2                	mv	a1,s8
ffffffffc0206774:	8552                	mv	a0,s4
ffffffffc0206776:	5e5040ef          	jal	ra,ffffffffc020b55a <strcpy>
ffffffffc020677a:	87d6                	mv	a5,s5
ffffffffc020677c:	ff4bbc23          	sd	s4,-8(s7)
ffffffffc0206780:	2a85                	addiw	s5,s5,1
ffffffffc0206782:	fc87cde3          	blt	a5,s0,ffffffffc020675c <do_execve+0x2be>
ffffffffc0206786:	02816703          	lwu	a4,40(sp)
ffffffffc020678a:	67a2                	ld	a5,8(sp)
ffffffffc020678c:	ff8a7693          	andi	a3,s4,-8
ffffffffc0206790:	00371a13          	slli	s4,a4,0x3
ffffffffc0206794:	ff868a93          	addi	s5,a3,-8
ffffffffc0206798:	41468533          	sub	a0,a3,s4
ffffffffc020679c:	fe06bc23          	sd	zero,-8(a3)
ffffffffc02067a0:	1541                	addi	a0,a0,-16
ffffffffc02067a2:	40d786b3          	sub	a3,a5,a3
ffffffffc02067a6:	8656                	mv	a2,s5
ffffffffc02067a8:	1661                	addi	a2,a2,-8
ffffffffc02067aa:	00d607b3          	add	a5,a2,a3
ffffffffc02067ae:	138c                	addi	a1,sp,480
ffffffffc02067b0:	97ae                	add	a5,a5,a1
ffffffffc02067b2:	679c                	ld	a5,8(a5)
ffffffffc02067b4:	e21c                	sd	a5,0(a2)
ffffffffc02067b6:	fea619e3          	bne	a2,a0,ffffffffc02067a8 <do_execve+0x30a>
ffffffffc02067ba:	0009b683          	ld	a3,0(s3)
ffffffffc02067be:	40e00733          	neg	a4,a4
ffffffffc02067c2:	070e                	slli	a4,a4,0x3
ffffffffc02067c4:	0a06bb03          	ld	s6,160(a3)
ffffffffc02067c8:	ff070413          	addi	s0,a4,-16 # ffffffffc01ffff0 <_binary_bin_sfs_img_size+0xffffffffc018acf0>
ffffffffc02067cc:	9456                	add	s0,s0,s5
ffffffffc02067ce:	1761                	addi	a4,a4,-8
ffffffffc02067d0:	01b42023          	sw	s11,0(s0)
ffffffffc02067d4:	12000613          	li	a2,288
ffffffffc02067d8:	4581                	li	a1,0
ffffffffc02067da:	855a                	mv	a0,s6
ffffffffc02067dc:	9aba                	add	s5,s5,a4
ffffffffc02067de:	5e9040ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc02067e2:	77ea                	ld	a5,184(sp)
ffffffffc02067e4:	008b3823          	sd	s0,16(s6)
ffffffffc02067e8:	10fb3423          	sd	a5,264(s6)
ffffffffc02067ec:	10002773          	csrr	a4,sstatus
ffffffffc02067f0:	66a2                	ld	a3,8(sp)
ffffffffc02067f2:	edf77713          	andi	a4,a4,-289
ffffffffc02067f6:	02076713          	ori	a4,a4,32
ffffffffc02067fa:	fff48413          	addi	s0,s1,-1
ffffffffc02067fe:	099c                	addi	a5,sp,208
ffffffffc0206800:	040e                	slli	s0,s0,0x3
ffffffffc0206802:	97b6                	add	a5,a5,a3
ffffffffc0206804:	10eb3023          	sd	a4,256(s6)
ffffffffc0206808:	1198                	addi	a4,sp,224
ffffffffc020680a:	049b3823          	sd	s1,80(s6)
ffffffffc020680e:	055b3c23          	sd	s5,88(s6)
ffffffffc0206812:	943a                	add	s0,s0,a4
ffffffffc0206814:	41478a33          	sub	s4,a5,s4
ffffffffc0206818:	6008                	ld	a0,0(s0)
ffffffffc020681a:	1461                	addi	s0,s0,-8
ffffffffc020681c:	827fb0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0206820:	fe8a1ce3          	bne	s4,s0,ffffffffc0206818 <do_execve+0x37a>
ffffffffc0206824:	0009b403          	ld	s0,0(s3)
ffffffffc0206828:	4641                	li	a2,16
ffffffffc020682a:	4581                	li	a1,0
ffffffffc020682c:	0b440413          	addi	s0,s0,180
ffffffffc0206830:	8522                	mv	a0,s0
ffffffffc0206832:	595040ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0206836:	463d                	li	a2,15
ffffffffc0206838:	08ac                	addi	a1,sp,88
ffffffffc020683a:	8522                	mv	a0,s0
ffffffffc020683c:	5dd040ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc0206840:	34813083          	ld	ra,840(sp)
ffffffffc0206844:	34013403          	ld	s0,832(sp)
ffffffffc0206848:	33813483          	ld	s1,824(sp)
ffffffffc020684c:	32813983          	ld	s3,808(sp)
ffffffffc0206850:	32013a03          	ld	s4,800(sp)
ffffffffc0206854:	31813a83          	ld	s5,792(sp)
ffffffffc0206858:	31013b03          	ld	s6,784(sp)
ffffffffc020685c:	30813b83          	ld	s7,776(sp)
ffffffffc0206860:	30013c03          	ld	s8,768(sp)
ffffffffc0206864:	2f813c83          	ld	s9,760(sp)
ffffffffc0206868:	2f013d03          	ld	s10,752(sp)
ffffffffc020686c:	2e813d83          	ld	s11,744(sp)
ffffffffc0206870:	854a                	mv	a0,s2
ffffffffc0206872:	33013903          	ld	s2,816(sp)
ffffffffc0206876:	35010113          	addi	sp,sp,848
ffffffffc020687a:	8082                	ret
ffffffffc020687c:	0009b703          	ld	a4,0(s3)
ffffffffc0206880:	14873503          	ld	a0,328(a4)
ffffffffc0206884:	a1bfe0ef          	jal	ra,ffffffffc020529e <files_closeall>
ffffffffc0206888:	4581                	li	a1,0
ffffffffc020688a:	854a                	mv	a0,s2
ffffffffc020688c:	c9ffe0ef          	jal	ra,ffffffffc020552a <sysfile_open>
ffffffffc0206890:	8aaa                	mv	s5,a0
ffffffffc0206892:	d40553e3          	bgez	a0,ffffffffc02065d8 <do_execve+0x13a>
ffffffffc0206896:	a029                	j	ffffffffc02068a0 <do_execve+0x402>
ffffffffc0206898:	8552                	mv	a0,s4
ffffffffc020689a:	cc0fd0ef          	jal	ra,ffffffffc0203d5a <mm_destroy>
ffffffffc020689e:	5af1                	li	s5,-4
ffffffffc02068a0:	67a2                	ld	a5,8(sp)
ffffffffc02068a2:	fff48413          	addi	s0,s1,-1
ffffffffc02068a6:	0984                	addi	s1,sp,208
ffffffffc02068a8:	94be                	add	s1,s1,a5
ffffffffc02068aa:	77a2                	ld	a5,40(sp)
ffffffffc02068ac:	040e                	slli	s0,s0,0x3
ffffffffc02068ae:	02079713          	slli	a4,a5,0x20
ffffffffc02068b2:	01d75793          	srli	a5,a4,0x1d
ffffffffc02068b6:	1198                	addi	a4,sp,224
ffffffffc02068b8:	943a                	add	s0,s0,a4
ffffffffc02068ba:	8c9d                	sub	s1,s1,a5
ffffffffc02068bc:	6008                	ld	a0,0(s0)
ffffffffc02068be:	1461                	addi	s0,s0,-8
ffffffffc02068c0:	f82fb0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc02068c4:	fe849ce3          	bne	s1,s0,ffffffffc02068bc <do_execve+0x41e>
ffffffffc02068c8:	8556                	mv	a0,s5
ffffffffc02068ca:	f50ff0ef          	jal	ra,ffffffffc020601a <do_exit>
ffffffffc02068ce:	5971                	li	s2,-4
ffffffffc02068d0:	c41d                	beqz	s0,ffffffffc02068fe <do_execve+0x460>
ffffffffc02068d2:	fff40493          	addi	s1,s0,-1
ffffffffc02068d6:	00341793          	slli	a5,s0,0x3
ffffffffc02068da:	0998                	addi	a4,sp,208
ffffffffc02068dc:	347d                	addiw	s0,s0,-1
ffffffffc02068de:	97ba                	add	a5,a5,a4
ffffffffc02068e0:	02041713          	slli	a4,s0,0x20
ffffffffc02068e4:	01d75413          	srli	s0,a4,0x1d
ffffffffc02068e8:	048e                	slli	s1,s1,0x3
ffffffffc02068ea:	1198                	addi	a4,sp,224
ffffffffc02068ec:	94ba                	add	s1,s1,a4
ffffffffc02068ee:	40878433          	sub	s0,a5,s0
ffffffffc02068f2:	6088                	ld	a0,0(s1)
ffffffffc02068f4:	14e1                	addi	s1,s1,-8
ffffffffc02068f6:	f4cfb0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc02068fa:	fe849ce3          	bne	s1,s0,ffffffffc02068f2 <do_execve+0x454>
ffffffffc02068fe:	f40b01e3          	beqz	s6,ffffffffc0206840 <do_execve+0x3a2>
ffffffffc0206902:	038b0513          	addi	a0,s6,56
ffffffffc0206906:	c5ffd0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020690a:	040b2823          	sw	zero,80(s6)
ffffffffc020690e:	bf0d                	j	ffffffffc0206840 <do_execve+0x3a2>
ffffffffc0206910:	854a                	mv	a0,s2
ffffffffc0206912:	f30fb0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0206916:	5975                	li	s2,-3
ffffffffc0206918:	bf65                	j	ffffffffc02068d0 <do_execve+0x432>
ffffffffc020691a:	0009b783          	ld	a5,0(s3)
ffffffffc020691e:	00007617          	auipc	a2,0x7
ffffffffc0206922:	e6a60613          	addi	a2,a2,-406 # ffffffffc020d788 <CSWTCH.79+0x2d0>
ffffffffc0206926:	45c1                	li	a1,16
ffffffffc0206928:	43d4                	lw	a3,4(a5)
ffffffffc020692a:	08a8                	addi	a0,sp,88
ffffffffc020692c:	3ab040ef          	jal	ra,ffffffffc020b4d6 <snprintf>
ffffffffc0206930:	befd                	j	ffffffffc020652e <do_execve+0x90>
ffffffffc0206932:	018a3503          	ld	a0,24(s4)
ffffffffc0206936:	5ae1                	li	s5,-8
ffffffffc0206938:	9a6ff0ef          	jal	ra,ffffffffc0205ade <put_pgdir.isra.0>
ffffffffc020693c:	8552                	mv	a0,s4
ffffffffc020693e:	c1cfd0ef          	jal	ra,ffffffffc0203d5a <mm_destroy>
ffffffffc0206942:	bfb9                	j	ffffffffc02068a0 <do_execve+0x402>
ffffffffc0206944:	855a                	mv	a0,s6
ffffffffc0206946:	db0fd0ef          	jal	ra,ffffffffc0203ef6 <exit_mmap>
ffffffffc020694a:	018b3503          	ld	a0,24(s6)
ffffffffc020694e:	990ff0ef          	jal	ra,ffffffffc0205ade <put_pgdir.isra.0>
ffffffffc0206952:	855a                	mv	a0,s6
ffffffffc0206954:	c06fd0ef          	jal	ra,ffffffffc0203d5a <mm_destroy>
ffffffffc0206958:	b9a5                	j	ffffffffc02065d0 <do_execve+0x132>
ffffffffc020695a:	664a                	ld	a2,144(sp)
ffffffffc020695c:	67aa                	ld	a5,136(sp)
ffffffffc020695e:	1cf66963          	bltu	a2,a5,ffffffffc0206b30 <do_execve+0x692>
ffffffffc0206962:	57b6                	lw	a5,108(sp)
ffffffffc0206964:	0017f693          	andi	a3,a5,1
ffffffffc0206968:	c291                	beqz	a3,ffffffffc020696c <do_execve+0x4ce>
ffffffffc020696a:	4691                	li	a3,4
ffffffffc020696c:	0027f713          	andi	a4,a5,2
ffffffffc0206970:	8b91                	andi	a5,a5,4
ffffffffc0206972:	cb01                	beqz	a4,ffffffffc0206982 <do_execve+0x4e4>
ffffffffc0206974:	0026e693          	ori	a3,a3,2
ffffffffc0206978:	4b45                	li	s6,17
ffffffffc020697a:	e791                	bnez	a5,ffffffffc0206986 <do_execve+0x4e8>
ffffffffc020697c:	004b6b13          	ori	s6,s6,4
ffffffffc0206980:	a809                	j	ffffffffc0206992 <do_execve+0x4f4>
ffffffffc0206982:	4b45                	li	s6,17
ffffffffc0206984:	c781                	beqz	a5,ffffffffc020698c <do_execve+0x4ee>
ffffffffc0206986:	0016e693          	ori	a3,a3,1
ffffffffc020698a:	4b4d                	li	s6,19
ffffffffc020698c:	0026f793          	andi	a5,a3,2
ffffffffc0206990:	f7f5                	bnez	a5,ffffffffc020697c <do_execve+0x4de>
ffffffffc0206992:	0046f793          	andi	a5,a3,4
ffffffffc0206996:	c399                	beqz	a5,ffffffffc020699c <do_execve+0x4fe>
ffffffffc0206998:	008b6b13          	ori	s6,s6,8
ffffffffc020699c:	75e6                	ld	a1,120(sp)
ffffffffc020699e:	4701                	li	a4,0
ffffffffc02069a0:	8552                	mv	a0,s4
ffffffffc02069a2:	c0afd0ef          	jal	ra,ffffffffc0203dac <mm_map>
ffffffffc02069a6:	ed41                	bnez	a0,ffffffffc0206a3e <do_execve+0x5a0>
ffffffffc02069a8:	7be6                	ld	s7,120(sp)
ffffffffc02069aa:	64aa                	ld	s1,136(sp)
ffffffffc02069ac:	77fd                	lui	a5,0xfffff
ffffffffc02069ae:	7446                	ld	s0,112(sp)
ffffffffc02069b0:	94de                	add	s1,s1,s7
ffffffffc02069b2:	00fbf933          	and	s2,s7,a5
ffffffffc02069b6:	169bfb63          	bgeu	s7,s1,ffffffffc0206b2c <do_execve+0x68e>
ffffffffc02069ba:	ec52                	sd	s4,24(sp)
ffffffffc02069bc:	a889                	j	ffffffffc0206a0e <do_execve+0x570>
ffffffffc02069be:	6785                	lui	a5,0x1
ffffffffc02069c0:	412b85b3          	sub	a1,s7,s2
ffffffffc02069c4:	993e                	add	s2,s2,a5
ffffffffc02069c6:	40b78a33          	sub	s4,a5,a1
ffffffffc02069ca:	0124f563          	bgeu	s1,s2,ffffffffc02069d4 <do_execve+0x536>
ffffffffc02069ce:	412487b3          	sub	a5,s1,s2
ffffffffc02069d2:	9a3e                	add	s4,s4,a5
ffffffffc02069d4:	000d3783          	ld	a5,0(s10)
ffffffffc02069d8:	6742                	ld	a4,16(sp)
ffffffffc02069da:	000cb683          	ld	a3,0(s9)
ffffffffc02069de:	40fd87b3          	sub	a5,s11,a5
ffffffffc02069e2:	8799                	srai	a5,a5,0x6
ffffffffc02069e4:	97ba                	add	a5,a5,a4
ffffffffc02069e6:	6702                	ld	a4,0(sp)
ffffffffc02069e8:	00e7f533          	and	a0,a5,a4
ffffffffc02069ec:	07b2                	slli	a5,a5,0xc
ffffffffc02069ee:	14d57463          	bgeu	a0,a3,ffffffffc0206b36 <do_execve+0x698>
ffffffffc02069f2:	000c3503          	ld	a0,0(s8)
ffffffffc02069f6:	86a2                	mv	a3,s0
ffffffffc02069f8:	8652                	mv	a2,s4
ffffffffc02069fa:	97aa                	add	a5,a5,a0
ffffffffc02069fc:	95be                	add	a1,a1,a5
ffffffffc02069fe:	8556                	mv	a0,s5
ffffffffc0206a00:	880ff0ef          	jal	ra,ffffffffc0205a80 <load_icode_read>
ffffffffc0206a04:	ed05                	bnez	a0,ffffffffc0206a3c <do_execve+0x59e>
ffffffffc0206a06:	9bd2                	add	s7,s7,s4
ffffffffc0206a08:	9452                	add	s0,s0,s4
ffffffffc0206a0a:	029bfd63          	bgeu	s7,s1,ffffffffc0206a44 <do_execve+0x5a6>
ffffffffc0206a0e:	67e2                	ld	a5,24(sp)
ffffffffc0206a10:	865a                	mv	a2,s6
ffffffffc0206a12:	85ca                	mv	a1,s2
ffffffffc0206a14:	6f88                	ld	a0,24(a5)
ffffffffc0206a16:	910fd0ef          	jal	ra,ffffffffc0203b26 <pgdir_alloc_page>
ffffffffc0206a1a:	8daa                	mv	s11,a0
ffffffffc0206a1c:	f14d                	bnez	a0,ffffffffc02069be <do_execve+0x520>
ffffffffc0206a1e:	6a62                	ld	s4,24(sp)
ffffffffc0206a20:	74e2                	ld	s1,56(sp)
ffffffffc0206a22:	5971                	li	s2,-4
ffffffffc0206a24:	8552                	mv	a0,s4
ffffffffc0206a26:	cd0fd0ef          	jal	ra,ffffffffc0203ef6 <exit_mmap>
ffffffffc0206a2a:	018a3503          	ld	a0,24(s4)
ffffffffc0206a2e:	8aca                	mv	s5,s2
ffffffffc0206a30:	8aeff0ef          	jal	ra,ffffffffc0205ade <put_pgdir.isra.0>
ffffffffc0206a34:	8552                	mv	a0,s4
ffffffffc0206a36:	b24fd0ef          	jal	ra,ffffffffc0203d5a <mm_destroy>
ffffffffc0206a3a:	b59d                	j	ffffffffc02068a0 <do_execve+0x402>
ffffffffc0206a3c:	6a62                	ld	s4,24(sp)
ffffffffc0206a3e:	74e2                	ld	s1,56(sp)
ffffffffc0206a40:	892a                	mv	s2,a0
ffffffffc0206a42:	b7cd                	j	ffffffffc0206a24 <do_execve+0x586>
ffffffffc0206a44:	6a62                	ld	s4,24(sp)
ffffffffc0206a46:	7466                	ld	s0,120(sp)
ffffffffc0206a48:	67ca                	ld	a5,144(sp)
ffffffffc0206a4a:	943e                	add	s0,s0,a5
ffffffffc0206a4c:	072bf263          	bgeu	s7,s2,ffffffffc0206ab0 <do_execve+0x612>
ffffffffc0206a50:	c57407e3          	beq	s0,s7,ffffffffc020669e <do_execve+0x200>
ffffffffc0206a54:	000d3783          	ld	a5,0(s10)
ffffffffc0206a58:	66c2                	ld	a3,16(sp)
ffffffffc0206a5a:	6602                	ld	a2,0(sp)
ffffffffc0206a5c:	40fd87b3          	sub	a5,s11,a5
ffffffffc0206a60:	6705                	lui	a4,0x1
ffffffffc0206a62:	8799                	srai	a5,a5,0x6
ffffffffc0206a64:	00eb8533          	add	a0,s7,a4
ffffffffc0206a68:	97b6                	add	a5,a5,a3
ffffffffc0206a6a:	00c79693          	slli	a3,a5,0xc
ffffffffc0206a6e:	000cb703          	ld	a4,0(s9)
ffffffffc0206a72:	41250533          	sub	a0,a0,s2
ffffffffc0206a76:	8ff1                	and	a5,a5,a2
ffffffffc0206a78:	03247063          	bgeu	s0,s2,ffffffffc0206a98 <do_execve+0x5fa>
ffffffffc0206a7c:	0ae7fe63          	bgeu	a5,a4,ffffffffc0206b38 <do_execve+0x69a>
ffffffffc0206a80:	000c3783          	ld	a5,0(s8)
ffffffffc0206a84:	41740633          	sub	a2,s0,s7
ffffffffc0206a88:	4581                	li	a1,0
ffffffffc0206a8a:	96be                	add	a3,a3,a5
ffffffffc0206a8c:	9536                	add	a0,a0,a3
ffffffffc0206a8e:	339040ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0206a92:	b131                	j	ffffffffc020669e <do_execve+0x200>
ffffffffc0206a94:	5975                	li	s2,-3
ffffffffc0206a96:	b36d                	j	ffffffffc0206840 <do_execve+0x3a2>
ffffffffc0206a98:	0ae7f063          	bgeu	a5,a4,ffffffffc0206b38 <do_execve+0x69a>
ffffffffc0206a9c:	000c3783          	ld	a5,0(s8)
ffffffffc0206aa0:	41790633          	sub	a2,s2,s7
ffffffffc0206aa4:	4581                	li	a1,0
ffffffffc0206aa6:	96be                	add	a3,a3,a5
ffffffffc0206aa8:	9536                	add	a0,a0,a3
ffffffffc0206aaa:	31d040ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0206aae:	8bca                	mv	s7,s2
ffffffffc0206ab0:	be8bf7e3          	bgeu	s7,s0,ffffffffc020669e <do_execve+0x200>
ffffffffc0206ab4:	64c2                	ld	s1,16(sp)
ffffffffc0206ab6:	a099                	j	ffffffffc0206afc <do_execve+0x65e>
ffffffffc0206ab8:	6785                	lui	a5,0x1
ffffffffc0206aba:	412b8533          	sub	a0,s7,s2
ffffffffc0206abe:	993e                	add	s2,s2,a5
ffffffffc0206ac0:	40a78633          	sub	a2,a5,a0
ffffffffc0206ac4:	01247563          	bgeu	s0,s2,ffffffffc0206ace <do_execve+0x630>
ffffffffc0206ac8:	412407b3          	sub	a5,s0,s2
ffffffffc0206acc:	963e                	add	a2,a2,a5
ffffffffc0206ace:	000d3783          	ld	a5,0(s10)
ffffffffc0206ad2:	6682                	ld	a3,0(sp)
ffffffffc0206ad4:	000cb703          	ld	a4,0(s9)
ffffffffc0206ad8:	40fd87b3          	sub	a5,s11,a5
ffffffffc0206adc:	8799                	srai	a5,a5,0x6
ffffffffc0206ade:	97a6                	add	a5,a5,s1
ffffffffc0206ae0:	8efd                	and	a3,a3,a5
ffffffffc0206ae2:	07b2                	slli	a5,a5,0xc
ffffffffc0206ae4:	06e6f663          	bgeu	a3,a4,ffffffffc0206b50 <do_execve+0x6b2>
ffffffffc0206ae8:	000c3703          	ld	a4,0(s8)
ffffffffc0206aec:	9bb2                	add	s7,s7,a2
ffffffffc0206aee:	4581                	li	a1,0
ffffffffc0206af0:	97ba                	add	a5,a5,a4
ffffffffc0206af2:	953e                	add	a0,a0,a5
ffffffffc0206af4:	2d3040ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0206af8:	ba8bf3e3          	bgeu	s7,s0,ffffffffc020669e <do_execve+0x200>
ffffffffc0206afc:	018a3503          	ld	a0,24(s4)
ffffffffc0206b00:	865a                	mv	a2,s6
ffffffffc0206b02:	85ca                	mv	a1,s2
ffffffffc0206b04:	822fd0ef          	jal	ra,ffffffffc0203b26 <pgdir_alloc_page>
ffffffffc0206b08:	8daa                	mv	s11,a0
ffffffffc0206b0a:	f55d                	bnez	a0,ffffffffc0206ab8 <do_execve+0x61a>
ffffffffc0206b0c:	74e2                	ld	s1,56(sp)
ffffffffc0206b0e:	bf11                	j	ffffffffc0206a22 <do_execve+0x584>
ffffffffc0206b10:	5975                	li	s2,-3
ffffffffc0206b12:	de0b18e3          	bnez	s6,ffffffffc0206902 <do_execve+0x464>
ffffffffc0206b16:	b32d                	j	ffffffffc0206840 <do_execve+0x3a2>
ffffffffc0206b18:	f60b0ee3          	beqz	s6,ffffffffc0206a94 <do_execve+0x5f6>
ffffffffc0206b1c:	038b0513          	addi	a0,s6,56
ffffffffc0206b20:	a45fd0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc0206b24:	5975                	li	s2,-3
ffffffffc0206b26:	040b2823          	sw	zero,80(s6)
ffffffffc0206b2a:	bb19                	j	ffffffffc0206840 <do_execve+0x3a2>
ffffffffc0206b2c:	845e                	mv	s0,s7
ffffffffc0206b2e:	bf29                	j	ffffffffc0206a48 <do_execve+0x5aa>
ffffffffc0206b30:	74e2                	ld	s1,56(sp)
ffffffffc0206b32:	5961                	li	s2,-8
ffffffffc0206b34:	bdc5                	j	ffffffffc0206a24 <do_execve+0x586>
ffffffffc0206b36:	86be                	mv	a3,a5
ffffffffc0206b38:	00006617          	auipc	a2,0x6
ffffffffc0206b3c:	a9060613          	addi	a2,a2,-1392 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc0206b40:	07100593          	li	a1,113
ffffffffc0206b44:	00006517          	auipc	a0,0x6
ffffffffc0206b48:	aac50513          	addi	a0,a0,-1364 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0206b4c:	953f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206b50:	86be                	mv	a3,a5
ffffffffc0206b52:	00006617          	auipc	a2,0x6
ffffffffc0206b56:	a7660613          	addi	a2,a2,-1418 # ffffffffc020c5c8 <default_pmm_manager+0x38>
ffffffffc0206b5a:	07100593          	li	a1,113
ffffffffc0206b5e:	00006517          	auipc	a0,0x6
ffffffffc0206b62:	a9250513          	addi	a0,a0,-1390 # ffffffffc020c5f0 <default_pmm_manager+0x60>
ffffffffc0206b66:	939f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206b6a:	00007697          	auipc	a3,0x7
ffffffffc0206b6e:	c7668693          	addi	a3,a3,-906 # ffffffffc020d7e0 <CSWTCH.79+0x328>
ffffffffc0206b72:	00005617          	auipc	a2,0x5
ffffffffc0206b76:	f3660613          	addi	a2,a2,-202 # ffffffffc020baa8 <commands+0x210>
ffffffffc0206b7a:	34500593          	li	a1,837
ffffffffc0206b7e:	00007517          	auipc	a0,0x7
ffffffffc0206b82:	a2a50513          	addi	a0,a0,-1494 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206b86:	919f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206b8a:	00007697          	auipc	a3,0x7
ffffffffc0206b8e:	c0e68693          	addi	a3,a3,-1010 # ffffffffc020d798 <CSWTCH.79+0x2e0>
ffffffffc0206b92:	00005617          	auipc	a2,0x5
ffffffffc0206b96:	f1660613          	addi	a2,a2,-234 # ffffffffc020baa8 <commands+0x210>
ffffffffc0206b9a:	34400593          	li	a1,836
ffffffffc0206b9e:	00007517          	auipc	a0,0x7
ffffffffc0206ba2:	a0a50513          	addi	a0,a0,-1526 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206ba6:	8f9f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206baa:	00007697          	auipc	a3,0x7
ffffffffc0206bae:	cc668693          	addi	a3,a3,-826 # ffffffffc020d870 <CSWTCH.79+0x3b8>
ffffffffc0206bb2:	00005617          	auipc	a2,0x5
ffffffffc0206bb6:	ef660613          	addi	a2,a2,-266 # ffffffffc020baa8 <commands+0x210>
ffffffffc0206bba:	34700593          	li	a1,839
ffffffffc0206bbe:	00007517          	auipc	a0,0x7
ffffffffc0206bc2:	9ea50513          	addi	a0,a0,-1558 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206bc6:	8d9f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206bca:	00007697          	auipc	a3,0x7
ffffffffc0206bce:	c5e68693          	addi	a3,a3,-930 # ffffffffc020d828 <CSWTCH.79+0x370>
ffffffffc0206bd2:	00005617          	auipc	a2,0x5
ffffffffc0206bd6:	ed660613          	addi	a2,a2,-298 # ffffffffc020baa8 <commands+0x210>
ffffffffc0206bda:	34600593          	li	a1,838
ffffffffc0206bde:	00007517          	auipc	a0,0x7
ffffffffc0206be2:	9ca50513          	addi	a0,a0,-1590 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206be6:	8b9f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206bea:	00006617          	auipc	a2,0x6
ffffffffc0206bee:	a8660613          	addi	a2,a2,-1402 # ffffffffc020c670 <default_pmm_manager+0xe0>
ffffffffc0206bf2:	34c00593          	li	a1,844
ffffffffc0206bf6:	00007517          	auipc	a0,0x7
ffffffffc0206bfa:	9b250513          	addi	a0,a0,-1614 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206bfe:	8a1f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206c02 <user_main>:
ffffffffc0206c02:	7179                	addi	sp,sp,-48
ffffffffc0206c04:	e84a                	sd	s2,16(sp)
ffffffffc0206c06:	00090917          	auipc	s2,0x90
ffffffffc0206c0a:	cba90913          	addi	s2,s2,-838 # ffffffffc02968c0 <current>
ffffffffc0206c0e:	00093783          	ld	a5,0(s2)
ffffffffc0206c12:	00007617          	auipc	a2,0x7
ffffffffc0206c16:	ca660613          	addi	a2,a2,-858 # ffffffffc020d8b8 <CSWTCH.79+0x400>
ffffffffc0206c1a:	00007517          	auipc	a0,0x7
ffffffffc0206c1e:	ca650513          	addi	a0,a0,-858 # ffffffffc020d8c0 <CSWTCH.79+0x408>
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
ffffffffc0206c58:	1c1040ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc0206c5c:	00093783          	ld	a5,0(s2)
ffffffffc0206c60:	860a                	mv	a2,sp
ffffffffc0206c62:	0004059b          	sext.w	a1,s0
ffffffffc0206c66:	f3c4                	sd	s1,160(a5)
ffffffffc0206c68:	00007517          	auipc	a0,0x7
ffffffffc0206c6c:	c5050513          	addi	a0,a0,-944 # ffffffffc020d8b8 <CSWTCH.79+0x400>
ffffffffc0206c70:	82fff0ef          	jal	ra,ffffffffc020649e <do_execve>
ffffffffc0206c74:	8126                	mv	sp,s1
ffffffffc0206c76:	ddefa06f          	j	ffffffffc0201254 <__trapret>
ffffffffc0206c7a:	00007617          	auipc	a2,0x7
ffffffffc0206c7e:	c6e60613          	addi	a2,a2,-914 # ffffffffc020d8e8 <CSWTCH.79+0x430>
ffffffffc0206c82:	48d00593          	li	a1,1165
ffffffffc0206c86:	00007517          	auipc	a0,0x7
ffffffffc0206c8a:	92250513          	addi	a0,a0,-1758 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
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
ffffffffc0206cc2:	dd4fd0ef          	jal	ra,ffffffffc0204296 <user_mem_check>
ffffffffc0206cc6:	c909                	beqz	a0,ffffffffc0206cd8 <do_wait+0x32>
ffffffffc0206cc8:	85a2                	mv	a1,s0
ffffffffc0206cca:	6442                	ld	s0,16(sp)
ffffffffc0206ccc:	60e2                	ld	ra,24(sp)
ffffffffc0206cce:	8526                	mv	a0,s1
ffffffffc0206cd0:	64a2                	ld	s1,8(sp)
ffffffffc0206cd2:	6105                	addi	sp,sp,32
ffffffffc0206cd4:	ca8ff06f          	j	ffffffffc020617c <do_wait.part.0>
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
ffffffffc0206cfc:	396040ef          	jal	ra,ffffffffc020b092 <hash32>
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
ffffffffc0206d92:	c47fe0ef          	jal	ra,ffffffffc02059d8 <alloc_proc>
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
ffffffffc0206dba:	c18fe0ef          	jal	ra,ffffffffc02051d2 <files_create>
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
ffffffffc0206dde:	7e8040ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0206de2:	463d                	li	a2,15
ffffffffc0206de4:	00007597          	auipc	a1,0x7
ffffffffc0206de8:	b6458593          	addi	a1,a1,-1180 # ffffffffc020d948 <CSWTCH.79+0x490>
ffffffffc0206dec:	8522                	mv	a0,s0
ffffffffc0206dee:	02b040ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc0206df2:	00090717          	auipc	a4,0x90
ffffffffc0206df6:	ae670713          	addi	a4,a4,-1306 # ffffffffc02968d8 <nr_process>
ffffffffc0206dfa:	431c                	lw	a5,0(a4)
ffffffffc0206dfc:	00093683          	ld	a3,0(s2)
ffffffffc0206e00:	4601                	li	a2,0
ffffffffc0206e02:	2785                	addiw	a5,a5,1
ffffffffc0206e04:	4581                	li	a1,0
ffffffffc0206e06:	fffff517          	auipc	a0,0xfffff
ffffffffc0206e0a:	54850513          	addi	a0,a0,1352 # ffffffffc020634e <init_main>
ffffffffc0206e0e:	c31c                	sw	a5,0(a4)
ffffffffc0206e10:	00090797          	auipc	a5,0x90
ffffffffc0206e14:	aad7b823          	sd	a3,-1360(a5) # ffffffffc02968c0 <current>
ffffffffc0206e18:	9b2ff0ef          	jal	ra,ffffffffc0205fca <kernel_thread>
ffffffffc0206e1c:	842a                	mv	s0,a0
ffffffffc0206e1e:	08a05363          	blez	a0,ffffffffc0206ea4 <proc_init+0x144>
ffffffffc0206e22:	6789                	lui	a5,0x2
ffffffffc0206e24:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206e28:	17f9                	addi	a5,a5,-2
ffffffffc0206e2a:	2501                	sext.w	a0,a0
ffffffffc0206e2c:	02e7e363          	bltu	a5,a4,ffffffffc0206e52 <proc_init+0xf2>
ffffffffc0206e30:	45a9                	li	a1,10
ffffffffc0206e32:	260040ef          	jal	ra,ffffffffc020b092 <hash32>
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
ffffffffc0206e68:	75e040ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0206e6c:	463d                	li	a2,15
ffffffffc0206e6e:	00007597          	auipc	a1,0x7
ffffffffc0206e72:	b0258593          	addi	a1,a1,-1278 # ffffffffc020d970 <CSWTCH.79+0x4b8>
ffffffffc0206e76:	8526                	mv	a0,s1
ffffffffc0206e78:	7a0040ef          	jal	ra,ffffffffc020b618 <memcpy>
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
ffffffffc0206ea8:	aac60613          	addi	a2,a2,-1364 # ffffffffc020d950 <CSWTCH.79+0x498>
ffffffffc0206eac:	4d900593          	li	a1,1241
ffffffffc0206eb0:	00006517          	auipc	a0,0x6
ffffffffc0206eb4:	6f850513          	addi	a0,a0,1784 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206eb8:	de6f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206ebc:	00007617          	auipc	a2,0x7
ffffffffc0206ec0:	a6460613          	addi	a2,a2,-1436 # ffffffffc020d920 <CSWTCH.79+0x468>
ffffffffc0206ec4:	4cd00593          	li	a1,1229
ffffffffc0206ec8:	00006517          	auipc	a0,0x6
ffffffffc0206ecc:	6e050513          	addi	a0,a0,1760 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206ed0:	dcef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206ed4:	00007617          	auipc	a2,0x7
ffffffffc0206ed8:	a3460613          	addi	a2,a2,-1484 # ffffffffc020d908 <CSWTCH.79+0x450>
ffffffffc0206edc:	4c300593          	li	a1,1219
ffffffffc0206ee0:	00006517          	auipc	a0,0x6
ffffffffc0206ee4:	6c850513          	addi	a0,a0,1736 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206ee8:	db6f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206eec:	00007697          	auipc	a3,0x7
ffffffffc0206ef0:	ab468693          	addi	a3,a3,-1356 # ffffffffc020d9a0 <CSWTCH.79+0x4e8>
ffffffffc0206ef4:	00005617          	auipc	a2,0x5
ffffffffc0206ef8:	bb460613          	addi	a2,a2,-1100 # ffffffffc020baa8 <commands+0x210>
ffffffffc0206efc:	4e000593          	li	a1,1248
ffffffffc0206f00:	00006517          	auipc	a0,0x6
ffffffffc0206f04:	6a850513          	addi	a0,a0,1704 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
ffffffffc0206f08:	d96f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206f0c:	00007697          	auipc	a3,0x7
ffffffffc0206f10:	a6c68693          	addi	a3,a3,-1428 # ffffffffc020d978 <CSWTCH.79+0x4c0>
ffffffffc0206f14:	00005617          	auipc	a2,0x5
ffffffffc0206f18:	b9460613          	addi	a2,a2,-1132 # ffffffffc020baa8 <commands+0x210>
ffffffffc0206f1c:	4df00593          	li	a1,1247
ffffffffc0206f20:	00006517          	auipc	a0,0x6
ffffffffc0206f24:	68850513          	addi	a0,a0,1672 # ffffffffc020d5a8 <CSWTCH.79+0xf0>
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
ffffffffc0206f52:	a7a50513          	addi	a0,a0,-1414 # ffffffffc020d9c8 <CSWTCH.79+0x510>
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
ffffffffc02070ce:	00007697          	auipc	a3,0x7
ffffffffc02070d2:	91268693          	addi	a3,a3,-1774 # ffffffffc020d9e0 <CSWTCH.79+0x528>
ffffffffc02070d6:	00005617          	auipc	a2,0x5
ffffffffc02070da:	9d260613          	addi	a2,a2,-1582 # ffffffffc020baa8 <commands+0x210>
ffffffffc02070de:	03c00593          	li	a1,60
ffffffffc02070e2:	00007517          	auipc	a0,0x7
ffffffffc02070e6:	93650513          	addi	a0,a0,-1738 # ffffffffc020da18 <CSWTCH.79+0x560>
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
ffffffffc0207134:	00007697          	auipc	a3,0x7
ffffffffc0207138:	90468693          	addi	a3,a3,-1788 # ffffffffc020da38 <CSWTCH.79+0x580>
ffffffffc020713c:	00005617          	auipc	a2,0x5
ffffffffc0207140:	96c60613          	addi	a2,a2,-1684 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207144:	02800593          	li	a1,40
ffffffffc0207148:	00007517          	auipc	a0,0x7
ffffffffc020714c:	8d050513          	addi	a0,a0,-1840 # ffffffffc020da18 <CSWTCH.79+0x560>
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
ffffffffc020719a:	00007517          	auipc	a0,0x7
ffffffffc020719e:	8ce50513          	addi	a0,a0,-1842 # ffffffffc020da68 <CSWTCH.79+0x5b0>
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
ffffffffc0207216:	00007617          	auipc	a2,0x7
ffffffffc020721a:	8a260613          	addi	a2,a2,-1886 # ffffffffc020dab8 <CSWTCH.79+0x600>
ffffffffc020721e:	05200593          	li	a1,82
ffffffffc0207222:	00007517          	auipc	a0,0x7
ffffffffc0207226:	87e50513          	addi	a0,a0,-1922 # ffffffffc020daa0 <CSWTCH.79+0x5e8>
ffffffffc020722a:	adcf90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc020722e:	bfc1                	j	ffffffffc02071fe <wakeup_proc+0x56>
ffffffffc0207230:	a43f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207234:	4018                	lw	a4,0(s0)
ffffffffc0207236:	4485                	li	s1,1
ffffffffc0207238:	b771                	j	ffffffffc02071c4 <wakeup_proc+0x1c>
ffffffffc020723a:	00007697          	auipc	a3,0x7
ffffffffc020723e:	84668693          	addi	a3,a3,-1978 # ffffffffc020da80 <CSWTCH.79+0x5c8>
ffffffffc0207242:	00005617          	auipc	a2,0x5
ffffffffc0207246:	86660613          	addi	a2,a2,-1946 # ffffffffc020baa8 <commands+0x210>
ffffffffc020724a:	04300593          	li	a1,67
ffffffffc020724e:	00007517          	auipc	a0,0x7
ffffffffc0207252:	85250513          	addi	a0,a0,-1966 # ffffffffc020daa0 <CSWTCH.79+0x5e8>
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
ffffffffc02072c4:	891fe0ef          	jal	ra,ffffffffc0205b54 <proc_run>
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
ffffffffc02073a6:	73668693          	addi	a3,a3,1846 # ffffffffc020dad8 <CSWTCH.79+0x620>
ffffffffc02073aa:	00004617          	auipc	a2,0x4
ffffffffc02073ae:	6fe60613          	addi	a2,a2,1790 # ffffffffc020baa8 <commands+0x210>
ffffffffc02073b2:	07a00593          	li	a1,122
ffffffffc02073b6:	00006517          	auipc	a0,0x6
ffffffffc02073ba:	6ea50513          	addi	a0,a0,1770 # ffffffffc020daa0 <CSWTCH.79+0x5e8>
ffffffffc02073be:	8e0f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02073c2:	00006697          	auipc	a3,0x6
ffffffffc02073c6:	74668693          	addi	a3,a3,1862 # ffffffffc020db08 <CSWTCH.79+0x650>
ffffffffc02073ca:	00004617          	auipc	a2,0x4
ffffffffc02073ce:	6de60613          	addi	a2,a2,1758 # ffffffffc020baa8 <commands+0x210>
ffffffffc02073d2:	07b00593          	li	a1,123
ffffffffc02073d6:	00006517          	auipc	a0,0x6
ffffffffc02073da:	6ca50513          	addi	a0,a0,1738 # ffffffffc020daa0 <CSWTCH.79+0x5e8>
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
ffffffffc02074ac:	6c8a8a93          	addi	s5,s5,1736 # ffffffffc020db70 <CSWTCH.79+0x6b8>
ffffffffc02074b0:	00006a17          	auipc	s4,0x6
ffffffffc02074b4:	5f0a0a13          	addi	s4,s4,1520 # ffffffffc020daa0 <CSWTCH.79+0x5e8>
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
ffffffffc020756c:	5e068693          	addi	a3,a3,1504 # ffffffffc020db48 <CSWTCH.79+0x690>
ffffffffc0207570:	00004617          	auipc	a2,0x4
ffffffffc0207574:	53860613          	addi	a2,a2,1336 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207578:	0b600593          	li	a1,182
ffffffffc020757c:	00006517          	auipc	a0,0x6
ffffffffc0207580:	52450513          	addi	a0,a0,1316 # ffffffffc020daa0 <CSWTCH.79+0x5e8>
ffffffffc0207584:	f1bf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207588:	00006697          	auipc	a3,0x6
ffffffffc020758c:	5a868693          	addi	a3,a3,1448 # ffffffffc020db30 <CSWTCH.79+0x678>
ffffffffc0207590:	00004617          	auipc	a2,0x4
ffffffffc0207594:	51860613          	addi	a2,a2,1304 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207598:	0ae00593          	li	a1,174
ffffffffc020759c:	00006517          	auipc	a0,0x6
ffffffffc02075a0:	50450513          	addi	a0,a0,1284 # ffffffffc020daa0 <CSWTCH.79+0x5e8>
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
ffffffffc02075e2:	beafe06f          	j	ffffffffc02059cc <sysfile_dup>

ffffffffc02075e6 <sys_getdirentry>:
ffffffffc02075e6:	650c                	ld	a1,8(a0)
ffffffffc02075e8:	4108                	lw	a0,0(a0)
ffffffffc02075ea:	af2fe06f          	j	ffffffffc02058dc <sysfile_getdirentry>

ffffffffc02075ee <sys_getcwd>:
ffffffffc02075ee:	650c                	ld	a1,8(a0)
ffffffffc02075f0:	6108                	ld	a0,0(a0)
ffffffffc02075f2:	a46fe06f          	j	ffffffffc0205838 <sysfile_getcwd>

ffffffffc02075f6 <sys_fsync>:
ffffffffc02075f6:	4108                	lw	a0,0(a0)
ffffffffc02075f8:	a3cfe06f          	j	ffffffffc0205834 <sysfile_fsync>

ffffffffc02075fc <sys_fstat>:
ffffffffc02075fc:	650c                	ld	a1,8(a0)
ffffffffc02075fe:	4108                	lw	a0,0(a0)
ffffffffc0207600:	994fe06f          	j	ffffffffc0205794 <sysfile_fstat>

ffffffffc0207604 <sys_seek>:
ffffffffc0207604:	4910                	lw	a2,16(a0)
ffffffffc0207606:	650c                	ld	a1,8(a0)
ffffffffc0207608:	4108                	lw	a0,0(a0)
ffffffffc020760a:	986fe06f          	j	ffffffffc0205790 <sysfile_seek>

ffffffffc020760e <sys_write>:
ffffffffc020760e:	6910                	ld	a2,16(a0)
ffffffffc0207610:	650c                	ld	a1,8(a0)
ffffffffc0207612:	4108                	lw	a0,0(a0)
ffffffffc0207614:	862fe06f          	j	ffffffffc0205676 <sysfile_write>

ffffffffc0207618 <sys_read>:
ffffffffc0207618:	6910                	ld	a2,16(a0)
ffffffffc020761a:	650c                	ld	a1,8(a0)
ffffffffc020761c:	4108                	lw	a0,0(a0)
ffffffffc020761e:	f45fd06f          	j	ffffffffc0205562 <sysfile_read>

ffffffffc0207622 <sys_close>:
ffffffffc0207622:	4108                	lw	a0,0(a0)
ffffffffc0207624:	f3bfd06f          	j	ffffffffc020555e <sysfile_close>

ffffffffc0207628 <sys_open>:
ffffffffc0207628:	450c                	lw	a1,8(a0)
ffffffffc020762a:	6108                	ld	a0,0(a0)
ffffffffc020762c:	efffd06f          	j	ffffffffc020552a <sysfile_open>

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
ffffffffc0207658:	e47fe06f          	j	ffffffffc020649e <do_execve>

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
ffffffffc0207672:	d40fe06f          	j	ffffffffc0205bb2 <do_fork>

ffffffffc0207676 <sys_exit>:
ffffffffc0207676:	4108                	lw	a0,0(a0)
ffffffffc0207678:	9a3fe06f          	j	ffffffffc020601a <do_exit>

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
ffffffffc02076a6:	53678793          	addi	a5,a5,1334 # ffffffffc020dbd8 <syscalls>
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
ffffffffc02076e4:	4b060613          	addi	a2,a2,1200 # ffffffffc020db90 <CSWTCH.79+0x6d8>
ffffffffc02076e8:	43d8                	lw	a4,4(a5)
ffffffffc02076ea:	0d800593          	li	a1,216
ffffffffc02076ee:	0b478793          	addi	a5,a5,180
ffffffffc02076f2:	00006517          	auipc	a0,0x6
ffffffffc02076f6:	4ce50513          	addi	a0,a0,1230 # ffffffffc020dbc0 <CSWTCH.79+0x708>
ffffffffc02076fa:	da5f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02076fe <__alloc_inode>:
ffffffffc02076fe:	1141                	addi	sp,sp,-16
ffffffffc0207700:	e022                	sd	s0,0(sp)
ffffffffc0207702:	842a                	mv	s0,a0
ffffffffc0207704:	07800513          	li	a0,120
ffffffffc0207708:	e406                	sd	ra,8(sp)
ffffffffc020770a:	889fa0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
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
ffffffffc0207738:	90bfa06f          	j	ffffffffc0202042 <kfree>
ffffffffc020773c:	00007697          	auipc	a3,0x7
ffffffffc0207740:	c9c68693          	addi	a3,a3,-868 # ffffffffc020e3d8 <syscalls+0x800>
ffffffffc0207744:	00004617          	auipc	a2,0x4
ffffffffc0207748:	36460613          	addi	a2,a2,868 # ffffffffc020baa8 <commands+0x210>
ffffffffc020774c:	02900593          	li	a1,41
ffffffffc0207750:	00007517          	auipc	a0,0x7
ffffffffc0207754:	ca850513          	addi	a0,a0,-856 # ffffffffc020e3f8 <syscalls+0x820>
ffffffffc0207758:	d47f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020775c:	00007697          	auipc	a3,0x7
ffffffffc0207760:	cb468693          	addi	a3,a3,-844 # ffffffffc020e410 <syscalls+0x838>
ffffffffc0207764:	00004617          	auipc	a2,0x4
ffffffffc0207768:	34460613          	addi	a2,a2,836 # ffffffffc020baa8 <commands+0x210>
ffffffffc020776c:	02a00593          	li	a1,42
ffffffffc0207770:	00007517          	auipc	a0,0x7
ffffffffc0207774:	c8850513          	addi	a0,a0,-888 # ffffffffc020e3f8 <syscalls+0x820>
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
ffffffffc02077ce:	c6668693          	addi	a3,a3,-922 # ffffffffc020e430 <syscalls+0x858>
ffffffffc02077d2:	00004617          	auipc	a2,0x4
ffffffffc02077d6:	2d660613          	addi	a2,a2,726 # ffffffffc020baa8 <commands+0x210>
ffffffffc02077da:	06e00593          	li	a1,110
ffffffffc02077de:	00007517          	auipc	a0,0x7
ffffffffc02077e2:	c1a50513          	addi	a0,a0,-998 # ffffffffc020e3f8 <syscalls+0x820>
ffffffffc02077e6:	cb9f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02077ea:	00007697          	auipc	a3,0x7
ffffffffc02077ee:	cc668693          	addi	a3,a3,-826 # ffffffffc020e4b0 <syscalls+0x8d8>
ffffffffc02077f2:	00004617          	auipc	a2,0x4
ffffffffc02077f6:	2b660613          	addi	a2,a2,694 # ffffffffc020baa8 <commands+0x210>
ffffffffc02077fa:	07200593          	li	a1,114
ffffffffc02077fe:	00007517          	auipc	a0,0x7
ffffffffc0207802:	bfa50513          	addi	a0,a0,-1030 # ffffffffc020e3f8 <syscalls+0x820>
ffffffffc0207806:	c99f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020780a:	00007697          	auipc	a3,0x7
ffffffffc020780e:	c7668693          	addi	a3,a3,-906 # ffffffffc020e480 <syscalls+0x8a8>
ffffffffc0207812:	00004617          	auipc	a2,0x4
ffffffffc0207816:	29660613          	addi	a2,a2,662 # ffffffffc020baa8 <commands+0x210>
ffffffffc020781a:	07100593          	li	a1,113
ffffffffc020781e:	00007517          	auipc	a0,0x7
ffffffffc0207822:	bda50513          	addi	a0,a0,-1062 # ffffffffc020e3f8 <syscalls+0x820>
ffffffffc0207826:	c79f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020782a:	00007697          	auipc	a3,0x7
ffffffffc020782e:	c2e68693          	addi	a3,a3,-978 # ffffffffc020e458 <syscalls+0x880>
ffffffffc0207832:	00004617          	auipc	a2,0x4
ffffffffc0207836:	27660613          	addi	a2,a2,630 # ffffffffc020baa8 <commands+0x210>
ffffffffc020783a:	06f00593          	li	a1,111
ffffffffc020783e:	00007517          	auipc	a0,0x7
ffffffffc0207842:	bba50513          	addi	a0,a0,-1094 # ffffffffc020e3f8 <syscalls+0x820>
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
ffffffffc0207874:	cf058593          	addi	a1,a1,-784 # ffffffffc020e560 <syscalls+0x988>
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
ffffffffc020789c:	cd050513          	addi	a0,a0,-816 # ffffffffc020e568 <syscalls+0x990>
ffffffffc02078a0:	907f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02078a4:	60e2                	ld	ra,24(sp)
ffffffffc02078a6:	6442                	ld	s0,16(sp)
ffffffffc02078a8:	6902                	ld	s2,0(sp)
ffffffffc02078aa:	8526                	mv	a0,s1
ffffffffc02078ac:	64a2                	ld	s1,8(sp)
ffffffffc02078ae:	6105                	addi	sp,sp,32
ffffffffc02078b0:	8082                	ret
ffffffffc02078b2:	00007697          	auipc	a3,0x7
ffffffffc02078b6:	c5e68693          	addi	a3,a3,-930 # ffffffffc020e510 <syscalls+0x938>
ffffffffc02078ba:	00004617          	auipc	a2,0x4
ffffffffc02078be:	1ee60613          	addi	a2,a2,494 # ffffffffc020baa8 <commands+0x210>
ffffffffc02078c2:	04400593          	li	a1,68
ffffffffc02078c6:	00007517          	auipc	a0,0x7
ffffffffc02078ca:	b3250513          	addi	a0,a0,-1230 # ffffffffc020e3f8 <syscalls+0x820>
ffffffffc02078ce:	bd1f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02078d2:	00007697          	auipc	a3,0x7
ffffffffc02078d6:	c1e68693          	addi	a3,a3,-994 # ffffffffc020e4f0 <syscalls+0x918>
ffffffffc02078da:	00004617          	auipc	a2,0x4
ffffffffc02078de:	1ce60613          	addi	a2,a2,462 # ffffffffc020baa8 <commands+0x210>
ffffffffc02078e2:	03f00593          	li	a1,63
ffffffffc02078e6:	00007517          	auipc	a0,0x7
ffffffffc02078ea:	b1250513          	addi	a0,a0,-1262 # ffffffffc020e3f8 <syscalls+0x820>
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
ffffffffc020791c:	ce058593          	addi	a1,a1,-800 # ffffffffc020e5f8 <syscalls+0xa20>
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
ffffffffc020793e:	cc650513          	addi	a0,a0,-826 # ffffffffc020e600 <syscalls+0xa28>
ffffffffc0207942:	865f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207946:	60e2                	ld	ra,24(sp)
ffffffffc0207948:	6442                	ld	s0,16(sp)
ffffffffc020794a:	6902                	ld	s2,0(sp)
ffffffffc020794c:	8526                	mv	a0,s1
ffffffffc020794e:	64a2                	ld	s1,8(sp)
ffffffffc0207950:	6105                	addi	sp,sp,32
ffffffffc0207952:	8082                	ret
ffffffffc0207954:	00007697          	auipc	a3,0x7
ffffffffc0207958:	c5468693          	addi	a3,a3,-940 # ffffffffc020e5a8 <syscalls+0x9d0>
ffffffffc020795c:	00004617          	auipc	a2,0x4
ffffffffc0207960:	14c60613          	addi	a2,a2,332 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207964:	06100593          	li	a1,97
ffffffffc0207968:	00007517          	auipc	a0,0x7
ffffffffc020796c:	a9050513          	addi	a0,a0,-1392 # ffffffffc020e3f8 <syscalls+0x820>
ffffffffc0207970:	b2ff80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207974:	00007697          	auipc	a3,0x7
ffffffffc0207978:	c1468693          	addi	a3,a3,-1004 # ffffffffc020e588 <syscalls+0x9b0>
ffffffffc020797c:	00004617          	auipc	a2,0x4
ffffffffc0207980:	12c60613          	addi	a2,a2,300 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207984:	05c00593          	li	a1,92
ffffffffc0207988:	00007517          	auipc	a0,0x7
ffffffffc020798c:	a7050513          	addi	a0,a0,-1424 # ffffffffc020e3f8 <syscalls+0x820>
ffffffffc0207990:	b0ff80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207994 <__alloc_fs>:
ffffffffc0207994:	1141                	addi	sp,sp,-16
ffffffffc0207996:	e022                	sd	s0,0(sp)
ffffffffc0207998:	842a                	mv	s0,a0
ffffffffc020799a:	0d800513          	li	a0,216
ffffffffc020799e:	e406                	sd	ra,8(sp)
ffffffffc02079a0:	df2fa0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
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
ffffffffc02079c0:	b9ffc0ef          	jal	ra,ffffffffc020455e <sem_init>
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
ffffffffc02079dc:	3d5030ef          	jal	ra,ffffffffc020b5b0 <strchr>
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
ffffffffc0207a12:	b57fc0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc0207a16:	0008f797          	auipc	a5,0x8f
ffffffffc0207a1a:	eda78793          	addi	a5,a5,-294 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207a1e:	6384                	ld	s1,0(a5)
ffffffffc0207a20:	0008e517          	auipc	a0,0x8e
ffffffffc0207a24:	de050513          	addi	a0,a0,-544 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207a28:	e380                	sd	s0,0(a5)
ffffffffc0207a2a:	4401                	li	s0,0
ffffffffc0207a2c:	b39fc0ef          	jal	ra,ffffffffc0204564 <up>
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
ffffffffc0207a66:	b03fc0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc0207a6a:	6084                	ld	s1,0(s1)
ffffffffc0207a6c:	c08d                	beqz	s1,ffffffffc0207a8e <vfs_get_bootfs+0x46>
ffffffffc0207a6e:	8526                	mv	a0,s1
ffffffffc0207a70:	d0dff0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc0207a74:	0008e517          	auipc	a0,0x8e
ffffffffc0207a78:	d8c50513          	addi	a0,a0,-628 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207a7c:	ae9fc0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc0207a80:	4501                	li	a0,0
ffffffffc0207a82:	e004                	sd	s1,0(s0)
ffffffffc0207a84:	60e2                	ld	ra,24(sp)
ffffffffc0207a86:	6442                	ld	s0,16(sp)
ffffffffc0207a88:	64a2                	ld	s1,8(sp)
ffffffffc0207a8a:	6105                	addi	sp,sp,32
ffffffffc0207a8c:	8082                	ret
ffffffffc0207a8e:	0008e517          	auipc	a0,0x8e
ffffffffc0207a92:	d7250513          	addi	a0,a0,-654 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207a96:	acffc0ef          	jal	ra,ffffffffc0204564 <up>
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
ffffffffc0207acc:	259030ef          	jal	ra,ffffffffc020b524 <strlen>
ffffffffc0207ad0:	47fd                	li	a5,31
ffffffffc0207ad2:	0ca7e663          	bltu	a5,a0,ffffffffc0207b9e <vfs_do_add+0x100>
ffffffffc0207ad6:	8522                	mv	a0,s0
ffffffffc0207ad8:	f1cf80ef          	jal	ra,ffffffffc02001f4 <strdup>
ffffffffc0207adc:	84aa                	mv	s1,a0
ffffffffc0207ade:	c171                	beqz	a0,ffffffffc0207ba2 <vfs_do_add+0x104>
ffffffffc0207ae0:	03000513          	li	a0,48
ffffffffc0207ae4:	caefa0ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc0207ae8:	89aa                	mv	s3,a0
ffffffffc0207aea:	c92d                	beqz	a0,ffffffffc0207b5c <vfs_do_add+0xbe>
ffffffffc0207aec:	0008e517          	auipc	a0,0x8e
ffffffffc0207af0:	d3c50513          	addi	a0,a0,-708 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207af4:	0008e917          	auipc	s2,0x8e
ffffffffc0207af8:	d2490913          	addi	s2,s2,-732 # ffffffffc0295818 <vdev_list>
ffffffffc0207afc:	a6dfc0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc0207b00:	844a                	mv	s0,s2
ffffffffc0207b02:	a039                	j	ffffffffc0207b10 <vfs_do_add+0x72>
ffffffffc0207b04:	fe043503          	ld	a0,-32(s0)
ffffffffc0207b08:	85a6                	mv	a1,s1
ffffffffc0207b0a:	263030ef          	jal	ra,ffffffffc020b56c <strcmp>
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
ffffffffc0207b42:	a23fc0ef          	jal	ra,ffffffffc0204564 <up>
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
ffffffffc0207b60:	ce2fa0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0207b64:	b7cd                	j	ffffffffc0207b46 <vfs_do_add+0xa8>
ffffffffc0207b66:	d2b5                	beqz	a3,ffffffffc0207aca <vfs_do_add+0x2c>
ffffffffc0207b68:	00007697          	auipc	a3,0x7
ffffffffc0207b6c:	ae068693          	addi	a3,a3,-1312 # ffffffffc020e648 <syscalls+0xa70>
ffffffffc0207b70:	00004617          	auipc	a2,0x4
ffffffffc0207b74:	f3860613          	addi	a2,a2,-200 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207b78:	08f00593          	li	a1,143
ffffffffc0207b7c:	00007517          	auipc	a0,0x7
ffffffffc0207b80:	ab450513          	addi	a0,a0,-1356 # ffffffffc020e630 <syscalls+0xa58>
ffffffffc0207b84:	91bf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207b88:	0008e517          	auipc	a0,0x8e
ffffffffc0207b8c:	ca050513          	addi	a0,a0,-864 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207b90:	9d5fc0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc0207b94:	854e                	mv	a0,s3
ffffffffc0207b96:	cacfa0ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0207b9a:	5425                	li	s0,-23
ffffffffc0207b9c:	b7c9                	j	ffffffffc0207b5e <vfs_do_add+0xc0>
ffffffffc0207b9e:	5451                	li	s0,-12
ffffffffc0207ba0:	b75d                	j	ffffffffc0207b46 <vfs_do_add+0xa8>
ffffffffc0207ba2:	5471                	li	s0,-4
ffffffffc0207ba4:	b74d                	j	ffffffffc0207b46 <vfs_do_add+0xa8>
ffffffffc0207ba6:	00007697          	auipc	a3,0x7
ffffffffc0207baa:	a7a68693          	addi	a3,a3,-1414 # ffffffffc020e620 <syscalls+0xa48>
ffffffffc0207bae:	00004617          	auipc	a2,0x4
ffffffffc0207bb2:	efa60613          	addi	a2,a2,-262 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207bb6:	08e00593          	li	a1,142
ffffffffc0207bba:	00007517          	auipc	a0,0x7
ffffffffc0207bbe:	a7650513          	addi	a0,a0,-1418 # ffffffffc020e630 <syscalls+0xa58>
ffffffffc0207bc2:	8ddf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207bc6 <find_mount.part.0>:
ffffffffc0207bc6:	1141                	addi	sp,sp,-16
ffffffffc0207bc8:	00007697          	auipc	a3,0x7
ffffffffc0207bcc:	a5868693          	addi	a3,a3,-1448 # ffffffffc020e620 <syscalls+0xa48>
ffffffffc0207bd0:	00004617          	auipc	a2,0x4
ffffffffc0207bd4:	ed860613          	addi	a2,a2,-296 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207bd8:	0cd00593          	li	a1,205
ffffffffc0207bdc:	00007517          	auipc	a0,0x7
ffffffffc0207be0:	a5450513          	addi	a0,a0,-1452 # ffffffffc020e630 <syscalls+0xa58>
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
ffffffffc0207c00:	95ffc06f          	j	ffffffffc020455e <sem_init>

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
ffffffffc0207c22:	947fc0ef          	jal	ra,ffffffffc0204568 <down>
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
ffffffffc0207c4e:	917fc06f          	j	ffffffffc0204564 <up>
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
ffffffffc0207c8a:	8dffc0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc0207c8e:	a801                	j	ffffffffc0207c9e <vfs_get_root+0x42>
ffffffffc0207c90:	fe043583          	ld	a1,-32(s0)
ffffffffc0207c94:	854e                	mv	a0,s3
ffffffffc0207c96:	0d7030ef          	jal	ra,ffffffffc020b56c <strcmp>
ffffffffc0207c9a:	84aa                	mv	s1,a0
ffffffffc0207c9c:	c505                	beqz	a0,ffffffffc0207cc4 <vfs_get_root+0x68>
ffffffffc0207c9e:	6400                	ld	s0,8(s0)
ffffffffc0207ca0:	ff2418e3          	bne	s0,s2,ffffffffc0207c90 <vfs_get_root+0x34>
ffffffffc0207ca4:	54cd                	li	s1,-13
ffffffffc0207ca6:	0008e517          	auipc	a0,0x8e
ffffffffc0207caa:	b8250513          	addi	a0,a0,-1150 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207cae:	8b7fc0ef          	jal	ra,ffffffffc0204564 <up>
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
ffffffffc0207cf2:	00007697          	auipc	a3,0x7
ffffffffc0207cf6:	92e68693          	addi	a3,a3,-1746 # ffffffffc020e620 <syscalls+0xa48>
ffffffffc0207cfa:	00004617          	auipc	a2,0x4
ffffffffc0207cfe:	dae60613          	addi	a2,a2,-594 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207d02:	04500593          	li	a1,69
ffffffffc0207d06:	00007517          	auipc	a0,0x7
ffffffffc0207d0a:	92a50513          	addi	a0,a0,-1750 # ffffffffc020e630 <syscalls+0xa58>
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
ffffffffc0207d3a:	00007697          	auipc	a3,0x7
ffffffffc0207d3e:	96e68693          	addi	a3,a3,-1682 # ffffffffc020e6a8 <syscalls+0xad0>
ffffffffc0207d42:	00004617          	auipc	a2,0x4
ffffffffc0207d46:	d6660613          	addi	a2,a2,-666 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207d4a:	06a00593          	li	a1,106
ffffffffc0207d4e:	00007517          	auipc	a0,0x7
ffffffffc0207d52:	8e250513          	addi	a0,a0,-1822 # ffffffffc020e630 <syscalls+0xa58>
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
ffffffffc0207d7c:	fecfc0ef          	jal	ra,ffffffffc0204568 <down>
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
ffffffffc0207da6:	7c6030ef          	jal	ra,ffffffffc020b56c <strcmp>
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
ffffffffc0207de4:	00007517          	auipc	a0,0x7
ffffffffc0207de8:	95450513          	addi	a0,a0,-1708 # ffffffffc020e738 <syscalls+0xb60>
ffffffffc0207dec:	bbaf80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207df0:	0008e517          	auipc	a0,0x8e
ffffffffc0207df4:	a3850513          	addi	a0,a0,-1480 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207df8:	f6cfc0ef          	jal	ra,ffffffffc0204564 <up>
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
ffffffffc0207e18:	00007697          	auipc	a3,0x7
ffffffffc0207e1c:	8d068693          	addi	a3,a3,-1840 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc0207e20:	00004617          	auipc	a2,0x4
ffffffffc0207e24:	c8860613          	addi	a2,a2,-888 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207e28:	0ed00593          	li	a1,237
ffffffffc0207e2c:	00007517          	auipc	a0,0x7
ffffffffc0207e30:	80450513          	addi	a0,a0,-2044 # ffffffffc020e630 <syscalls+0xa58>
ffffffffc0207e34:	e6af80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e38:	00007697          	auipc	a3,0x7
ffffffffc0207e3c:	88068693          	addi	a3,a3,-1920 # ffffffffc020e6b8 <syscalls+0xae0>
ffffffffc0207e40:	00004617          	auipc	a2,0x4
ffffffffc0207e44:	c6860613          	addi	a2,a2,-920 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207e48:	0eb00593          	li	a1,235
ffffffffc0207e4c:	00006517          	auipc	a0,0x6
ffffffffc0207e50:	7e450513          	addi	a0,a0,2020 # ffffffffc020e630 <syscalls+0xa58>
ffffffffc0207e54:	e4af80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e58:	00007697          	auipc	a3,0x7
ffffffffc0207e5c:	8c868693          	addi	a3,a3,-1848 # ffffffffc020e720 <syscalls+0xb48>
ffffffffc0207e60:	00004617          	auipc	a2,0x4
ffffffffc0207e64:	c4860613          	addi	a2,a2,-952 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207e68:	0ef00593          	li	a1,239
ffffffffc0207e6c:	00006517          	auipc	a0,0x6
ffffffffc0207e70:	7c450513          	addi	a0,a0,1988 # ffffffffc020e630 <syscalls+0xa58>
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
ffffffffc0207eca:	00007597          	auipc	a1,0x7
ffffffffc0207ece:	94e58593          	addi	a1,a1,-1714 # ffffffffc020e818 <syscalls+0xc40>
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
ffffffffc0207efe:	00007597          	auipc	a1,0x7
ffffffffc0207f02:	97a58593          	addi	a1,a1,-1670 # ffffffffc020e878 <syscalls+0xca0>
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
ffffffffc0207f5a:	00007597          	auipc	a1,0x7
ffffffffc0207f5e:	85658593          	addi	a1,a1,-1962 # ffffffffc020e7b0 <syscalls+0xbd8>
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
ffffffffc0207f9e:	00007697          	auipc	a3,0x7
ffffffffc0207fa2:	82a68693          	addi	a3,a3,-2006 # ffffffffc020e7c8 <syscalls+0xbf0>
ffffffffc0207fa6:	00004617          	auipc	a2,0x4
ffffffffc0207faa:	b0260613          	addi	a2,a2,-1278 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207fae:	03300593          	li	a1,51
ffffffffc0207fb2:	00006517          	auipc	a0,0x6
ffffffffc0207fb6:	7e650513          	addi	a0,a0,2022 # ffffffffc020e798 <syscalls+0xbc0>
ffffffffc0207fba:	ce4f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207fbe:	00007697          	auipc	a3,0x7
ffffffffc0207fc2:	86268693          	addi	a3,a3,-1950 # ffffffffc020e820 <syscalls+0xc48>
ffffffffc0207fc6:	00004617          	auipc	a2,0x4
ffffffffc0207fca:	ae260613          	addi	a2,a2,-1310 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207fce:	03a00593          	li	a1,58
ffffffffc0207fd2:	00006517          	auipc	a0,0x6
ffffffffc0207fd6:	7c650513          	addi	a0,a0,1990 # ffffffffc020e798 <syscalls+0xbc0>
ffffffffc0207fda:	cc4f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207fde:	00006697          	auipc	a3,0x6
ffffffffc0207fe2:	7da68693          	addi	a3,a3,2010 # ffffffffc020e7b8 <syscalls+0xbe0>
ffffffffc0207fe6:	00004617          	auipc	a2,0x4
ffffffffc0207fea:	ac260613          	addi	a2,a2,-1342 # ffffffffc020baa8 <commands+0x210>
ffffffffc0207fee:	03100593          	li	a1,49
ffffffffc0207ff2:	00006517          	auipc	a0,0x6
ffffffffc0207ff6:	7a650513          	addi	a0,a0,1958 # ffffffffc020e798 <syscalls+0xbc0>
ffffffffc0207ffa:	ca4f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207ffe:	00006697          	auipc	a3,0x6
ffffffffc0208002:	74a68693          	addi	a3,a3,1866 # ffffffffc020e748 <syscalls+0xb70>
ffffffffc0208006:	00004617          	auipc	a2,0x4
ffffffffc020800a:	aa260613          	addi	a2,a2,-1374 # ffffffffc020baa8 <commands+0x210>
ffffffffc020800e:	02c00593          	li	a1,44
ffffffffc0208012:	00006517          	auipc	a0,0x6
ffffffffc0208016:	78650513          	addi	a0,a0,1926 # ffffffffc020e798 <syscalls+0xbc0>
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
ffffffffc0208116:	79e68693          	addi	a3,a3,1950 # ffffffffc020e8b0 <syscalls+0xcd8>
ffffffffc020811a:	00004617          	auipc	a2,0x4
ffffffffc020811e:	98e60613          	addi	a2,a2,-1650 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208122:	03900593          	li	a1,57
ffffffffc0208126:	00006517          	auipc	a0,0x6
ffffffffc020812a:	77250513          	addi	a0,a0,1906 # ffffffffc020e898 <syscalls+0xcc0>
ffffffffc020812e:	b70f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208132:	00006697          	auipc	a3,0x6
ffffffffc0208136:	75668693          	addi	a3,a3,1878 # ffffffffc020e888 <syscalls+0xcb0>
ffffffffc020813a:	00004617          	auipc	a2,0x4
ffffffffc020813e:	96e60613          	addi	a2,a2,-1682 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208142:	03300593          	li	a1,51
ffffffffc0208146:	00006517          	auipc	a0,0x6
ffffffffc020814a:	75250513          	addi	a0,a0,1874 # ffffffffc020e898 <syscalls+0xcc0>
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
ffffffffc020818a:	79258593          	addi	a1,a1,1938 # ffffffffc020e918 <syscalls+0xd40>
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
ffffffffc02081cc:	70068693          	addi	a3,a3,1792 # ffffffffc020e8c8 <syscalls+0xcf0>
ffffffffc02081d0:	00004617          	auipc	a2,0x4
ffffffffc02081d4:	8d860613          	addi	a2,a2,-1832 # ffffffffc020baa8 <commands+0x210>
ffffffffc02081d8:	04f00593          	li	a1,79
ffffffffc02081dc:	00006517          	auipc	a0,0x6
ffffffffc02081e0:	6bc50513          	addi	a0,a0,1724 # ffffffffc020e898 <syscalls+0xcc0>
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
ffffffffc0208262:	f65fc0ef          	jal	ra,ffffffffc02051c6 <lock_files>
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
ffffffffc0208284:	70858593          	addi	a1,a1,1800 # ffffffffc020e988 <syscalls+0xdb0>
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
ffffffffc02082b2:	f1bfc0ef          	jal	ra,ffffffffc02051cc <unlock_files>
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
ffffffffc02082ec:	63868693          	addi	a3,a3,1592 # ffffffffc020e920 <syscalls+0xd48>
ffffffffc02082f0:	00003617          	auipc	a2,0x3
ffffffffc02082f4:	7b860613          	addi	a2,a2,1976 # ffffffffc020baa8 <commands+0x210>
ffffffffc02082f8:	04300593          	li	a1,67
ffffffffc02082fc:	00006517          	auipc	a0,0x6
ffffffffc0208300:	67450513          	addi	a0,a0,1652 # ffffffffc020e970 <syscalls+0xd98>
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
ffffffffc0208366:	1be030ef          	jal	ra,ffffffffc020b524 <strlen>
ffffffffc020836a:	862a                	mv	a2,a0
ffffffffc020836c:	85a2                	mv	a1,s0
ffffffffc020836e:	4701                	li	a4,0
ffffffffc0208370:	4685                	li	a3,1
ffffffffc0208372:	854a                	mv	a0,s2
ffffffffc0208374:	87cfd0ef          	jal	ra,ffffffffc02053f0 <iobuf_move>
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
ffffffffc02083a4:	84cfd0ef          	jal	ra,ffffffffc02053f0 <iobuf_move>
ffffffffc02083a8:	842a                	mv	s0,a0
ffffffffc02083aa:	f969                	bnez	a0,ffffffffc020837c <vfs_getcwd+0x42>
ffffffffc02083ac:	78bc                	ld	a5,112(s1)
ffffffffc02083ae:	c3b9                	beqz	a5,ffffffffc02083f4 <vfs_getcwd+0xba>
ffffffffc02083b0:	7f9c                	ld	a5,56(a5)
ffffffffc02083b2:	c3a9                	beqz	a5,ffffffffc02083f4 <vfs_getcwd+0xba>
ffffffffc02083b4:	00006597          	auipc	a1,0x6
ffffffffc02083b8:	63458593          	addi	a1,a1,1588 # ffffffffc020e9e8 <syscalls+0xe10>
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
ffffffffc02083d8:	4dc68693          	addi	a3,a3,1244 # ffffffffc020e8b0 <syscalls+0xcd8>
ffffffffc02083dc:	00003617          	auipc	a2,0x3
ffffffffc02083e0:	6cc60613          	addi	a2,a2,1740 # ffffffffc020baa8 <commands+0x210>
ffffffffc02083e4:	06e00593          	li	a1,110
ffffffffc02083e8:	00006517          	auipc	a0,0x6
ffffffffc02083ec:	58850513          	addi	a0,a0,1416 # ffffffffc020e970 <syscalls+0xd98>
ffffffffc02083f0:	8aef80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02083f4:	00006697          	auipc	a3,0x6
ffffffffc02083f8:	59c68693          	addi	a3,a3,1436 # ffffffffc020e990 <syscalls+0xdb8>
ffffffffc02083fc:	00003617          	auipc	a2,0x3
ffffffffc0208400:	6ac60613          	addi	a2,a2,1708 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208404:	07800593          	li	a1,120
ffffffffc0208408:	00006517          	auipc	a0,0x6
ffffffffc020840c:	56850513          	addi	a0,a0,1384 # ffffffffc020e970 <syscalls+0xd98>
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
ffffffffc0208450:	176030ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc0208454:	c429                	beqz	s0,ffffffffc020849e <dev_fstat+0x62>
ffffffffc0208456:	783c                	ld	a5,112(s0)
ffffffffc0208458:	c3b9                	beqz	a5,ffffffffc020849e <dev_fstat+0x62>
ffffffffc020845a:	6bbc                	ld	a5,80(a5)
ffffffffc020845c:	c3a9                	beqz	a5,ffffffffc020849e <dev_fstat+0x62>
ffffffffc020845e:	00006597          	auipc	a1,0x6
ffffffffc0208462:	52a58593          	addi	a1,a1,1322 # ffffffffc020e988 <syscalls+0xdb0>
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
ffffffffc02084a2:	48268693          	addi	a3,a3,1154 # ffffffffc020e920 <syscalls+0xd48>
ffffffffc02084a6:	00003617          	auipc	a2,0x3
ffffffffc02084aa:	60260613          	addi	a2,a2,1538 # ffffffffc020baa8 <commands+0x210>
ffffffffc02084ae:	04200593          	li	a1,66
ffffffffc02084b2:	00006517          	auipc	a0,0x6
ffffffffc02084b6:	54650513          	addi	a0,a0,1350 # ffffffffc020e9f8 <syscalls+0xe20>
ffffffffc02084ba:	fe5f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02084be:	00006697          	auipc	a3,0x6
ffffffffc02084c2:	22a68693          	addi	a3,a3,554 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc02084c6:	00003617          	auipc	a2,0x3
ffffffffc02084ca:	5e260613          	addi	a2,a2,1506 # ffffffffc020baa8 <commands+0x210>
ffffffffc02084ce:	04500593          	li	a1,69
ffffffffc02084d2:	00006517          	auipc	a0,0x6
ffffffffc02084d6:	52650513          	addi	a0,a0,1318 # ffffffffc020e9f8 <syscalls+0xe20>
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
ffffffffc02084f6:	1f668693          	addi	a3,a3,502 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc02084fa:	00003617          	auipc	a2,0x3
ffffffffc02084fe:	5ae60613          	addi	a2,a2,1454 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208502:	03500593          	li	a1,53
ffffffffc0208506:	00006517          	auipc	a0,0x6
ffffffffc020850a:	4f250513          	addi	a0,a0,1266 # ffffffffc020e9f8 <syscalls+0xe20>
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
ffffffffc0208548:	1a468693          	addi	a3,a3,420 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc020854c:	00003617          	auipc	a2,0x3
ffffffffc0208550:	55c60613          	addi	a2,a2,1372 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208554:	05f00593          	li	a1,95
ffffffffc0208558:	00006517          	auipc	a0,0x6
ffffffffc020855c:	4a050513          	addi	a0,a0,1184 # ffffffffc020e9f8 <syscalls+0xe20>
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
ffffffffc020858e:	15e68693          	addi	a3,a3,350 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc0208592:	00003617          	auipc	a2,0x3
ffffffffc0208596:	51660613          	addi	a2,a2,1302 # ffffffffc020baa8 <commands+0x210>
ffffffffc020859a:	05300593          	li	a1,83
ffffffffc020859e:	00006517          	auipc	a0,0x6
ffffffffc02085a2:	45a50513          	addi	a0,a0,1114 # ffffffffc020e9f8 <syscalls+0xe20>
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
ffffffffc02085c6:	12668693          	addi	a3,a3,294 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc02085ca:	00003617          	auipc	a2,0x3
ffffffffc02085ce:	4de60613          	addi	a2,a2,1246 # ffffffffc020baa8 <commands+0x210>
ffffffffc02085d2:	02c00593          	li	a1,44
ffffffffc02085d6:	00006517          	auipc	a0,0x6
ffffffffc02085da:	42250513          	addi	a0,a0,1058 # ffffffffc020e9f8 <syscalls+0xe20>
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
ffffffffc02085fe:	0ee68693          	addi	a3,a3,238 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc0208602:	00003617          	auipc	a2,0x3
ffffffffc0208606:	4a660613          	addi	a2,a2,1190 # ffffffffc020baa8 <commands+0x210>
ffffffffc020860a:	02300593          	li	a1,35
ffffffffc020860e:	00006517          	auipc	a0,0x6
ffffffffc0208612:	3ea50513          	addi	a0,a0,1002 # ffffffffc020e9f8 <syscalls+0xe20>
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
ffffffffc0208634:	0b868693          	addi	a3,a3,184 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc0208638:	00003617          	auipc	a2,0x3
ffffffffc020863c:	47060613          	addi	a2,a2,1136 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208640:	45e9                	li	a1,26
ffffffffc0208642:	00006517          	auipc	a0,0x6
ffffffffc0208646:	3b650513          	addi	a0,a0,950 # ffffffffc020e9f8 <syscalls+0xe20>
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
ffffffffc0208672:	07a68693          	addi	a3,a3,122 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc0208676:	00003617          	auipc	a2,0x3
ffffffffc020867a:	43260613          	addi	a2,a2,1074 # ffffffffc020baa8 <commands+0x210>
ffffffffc020867e:	45c5                	li	a1,17
ffffffffc0208680:	00006517          	auipc	a0,0x6
ffffffffc0208684:	37850513          	addi	a0,a0,888 # ffffffffc020e9f8 <syscalls+0xe20>
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
ffffffffc02086ba:	35a58593          	addi	a1,a1,858 # ffffffffc020ea10 <dev_node_ops>
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
ffffffffc020875c:	e0dfb0ef          	jal	ra,ffffffffc0204568 <down>
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
ffffffffc0208796:	c5bfc0ef          	jal	ra,ffffffffc02053f0 <iobuf_move>
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
ffffffffc02087d2:	c1ffc0ef          	jal	ra,ffffffffc02053f0 <iobuf_move>
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
ffffffffc020881c:	d49fb0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc0208820:	4501                	li	a0,0
ffffffffc0208822:	b729                	j	ffffffffc020872c <disk0_io+0x54>
ffffffffc0208824:	5575                	li	a0,-3
ffffffffc0208826:	b719                	j	ffffffffc020872c <disk0_io+0x54>
ffffffffc0208828:	00006697          	auipc	a3,0x6
ffffffffc020882c:	36068693          	addi	a3,a3,864 # ffffffffc020eb88 <dev_node_ops+0x178>
ffffffffc0208830:	00003617          	auipc	a2,0x3
ffffffffc0208834:	27860613          	addi	a2,a2,632 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208838:	06200593          	li	a1,98
ffffffffc020883c:	00006517          	auipc	a0,0x6
ffffffffc0208840:	29450513          	addi	a0,a0,660 # ffffffffc020ead0 <dev_node_ops+0xc0>
ffffffffc0208844:	c5bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208848:	00006697          	auipc	a3,0x6
ffffffffc020884c:	24868693          	addi	a3,a3,584 # ffffffffc020ea90 <dev_node_ops+0x80>
ffffffffc0208850:	00003617          	auipc	a2,0x3
ffffffffc0208854:	25860613          	addi	a2,a2,600 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208858:	05700593          	li	a1,87
ffffffffc020885c:	00006517          	auipc	a0,0x6
ffffffffc0208860:	27450513          	addi	a0,a0,628 # ffffffffc020ead0 <dev_node_ops+0xc0>
ffffffffc0208864:	c3bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208868:	88aa                	mv	a7,a0
ffffffffc020886a:	886a                	mv	a6,s10
ffffffffc020886c:	87a2                	mv	a5,s0
ffffffffc020886e:	8752                	mv	a4,s4
ffffffffc0208870:	86ce                	mv	a3,s3
ffffffffc0208872:	00006617          	auipc	a2,0x6
ffffffffc0208876:	2ce60613          	addi	a2,a2,718 # ffffffffc020eb40 <dev_node_ops+0x130>
ffffffffc020887a:	02d00593          	li	a1,45
ffffffffc020887e:	00006517          	auipc	a0,0x6
ffffffffc0208882:	25250513          	addi	a0,a0,594 # ffffffffc020ead0 <dev_node_ops+0xc0>
ffffffffc0208886:	c19f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020888a:	88aa                	mv	a7,a0
ffffffffc020888c:	8852                	mv	a6,s4
ffffffffc020888e:	87a2                	mv	a5,s0
ffffffffc0208890:	874a                	mv	a4,s2
ffffffffc0208892:	86ce                	mv	a3,s3
ffffffffc0208894:	00006617          	auipc	a2,0x6
ffffffffc0208898:	25c60613          	addi	a2,a2,604 # ffffffffc020eaf0 <dev_node_ops+0xe0>
ffffffffc020889c:	03700593          	li	a1,55
ffffffffc02088a0:	00006517          	auipc	a0,0x6
ffffffffc02088a4:	23050513          	addi	a0,a0,560 # ffffffffc020ead0 <dev_node_ops+0xc0>
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
ffffffffc0208910:	c4ffb0ef          	jal	ra,ffffffffc020455e <sem_init>
ffffffffc0208914:	6511                	lui	a0,0x4
ffffffffc0208916:	e7cf90ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc020891a:	0008e797          	auipc	a5,0x8e
ffffffffc020891e:	fca7bf23          	sd	a0,-34(a5) # ffffffffc02968f8 <disk0_buffer>
ffffffffc0208922:	c921                	beqz	a0,ffffffffc0208972 <dev_init_disk0+0xc6>
ffffffffc0208924:	4605                	li	a2,1
ffffffffc0208926:	85a2                	mv	a1,s0
ffffffffc0208928:	00006517          	auipc	a0,0x6
ffffffffc020892c:	2f050513          	addi	a0,a0,752 # ffffffffc020ec18 <dev_node_ops+0x208>
ffffffffc0208930:	c2cff0ef          	jal	ra,ffffffffc0207d5c <vfs_add_dev>
ffffffffc0208934:	e115                	bnez	a0,ffffffffc0208958 <dev_init_disk0+0xac>
ffffffffc0208936:	60e2                	ld	ra,24(sp)
ffffffffc0208938:	6442                	ld	s0,16(sp)
ffffffffc020893a:	64a2                	ld	s1,8(sp)
ffffffffc020893c:	6105                	addi	sp,sp,32
ffffffffc020893e:	8082                	ret
ffffffffc0208940:	00006617          	auipc	a2,0x6
ffffffffc0208944:	27860613          	addi	a2,a2,632 # ffffffffc020ebb8 <dev_node_ops+0x1a8>
ffffffffc0208948:	08700593          	li	a1,135
ffffffffc020894c:	00006517          	auipc	a0,0x6
ffffffffc0208950:	18450513          	addi	a0,a0,388 # ffffffffc020ead0 <dev_node_ops+0xc0>
ffffffffc0208954:	b4bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208958:	86aa                	mv	a3,a0
ffffffffc020895a:	00006617          	auipc	a2,0x6
ffffffffc020895e:	2c660613          	addi	a2,a2,710 # ffffffffc020ec20 <dev_node_ops+0x210>
ffffffffc0208962:	08d00593          	li	a1,141
ffffffffc0208966:	00006517          	auipc	a0,0x6
ffffffffc020896a:	16a50513          	addi	a0,a0,362 # ffffffffc020ead0 <dev_node_ops+0xc0>
ffffffffc020896e:	b31f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208972:	00006617          	auipc	a2,0x6
ffffffffc0208976:	28660613          	addi	a2,a2,646 # ffffffffc020ebf8 <dev_node_ops+0x1e8>
ffffffffc020897a:	07f00593          	li	a1,127
ffffffffc020897e:	00006517          	auipc	a0,0x6
ffffffffc0208982:	15250513          	addi	a0,a0,338 # ffffffffc020ead0 <dev_node_ops+0xc0>
ffffffffc0208986:	b19f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020898a:	00006617          	auipc	a2,0x6
ffffffffc020898e:	24e60613          	addi	a2,a2,590 # ffffffffc020ebd8 <dev_node_ops+0x1c8>
ffffffffc0208992:	07300593          	li	a1,115
ffffffffc0208996:	00006517          	auipc	a0,0x6
ffffffffc020899a:	13a50513          	addi	a0,a0,314 # ffffffffc020ead0 <dev_node_ops+0xc0>
ffffffffc020899e:	b01f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02089a2:	00006697          	auipc	a3,0x6
ffffffffc02089a6:	d4668693          	addi	a3,a3,-698 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc02089aa:	00003617          	auipc	a2,0x3
ffffffffc02089ae:	0fe60613          	addi	a2,a2,254 # ffffffffc020baa8 <commands+0x210>
ffffffffc02089b2:	08900593          	li	a1,137
ffffffffc02089b6:	00006517          	auipc	a0,0x6
ffffffffc02089ba:	11a50513          	addi	a0,a0,282 # ffffffffc020ead0 <dev_node_ops+0xc0>
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
ffffffffc0208a56:	ba5fb0ef          	jal	ra,ffffffffc02045fa <wait_in_queue>
ffffffffc0208a5a:	e121                	bnez	a0,ffffffffc0208a9a <stdin_io+0xc6>
ffffffffc0208a5c:	47c2                	lw	a5,16(sp)
ffffffffc0208a5e:	04979563          	bne	a5,s1,ffffffffc0208aa8 <stdin_io+0xd4>
ffffffffc0208a62:	0009b783          	ld	a5,0(s3)
ffffffffc0208a66:	000a3703          	ld	a4,0(s4)
ffffffffc0208a6a:	06e7c863          	blt	a5,a4,ffffffffc0208ada <stdin_io+0x106>
ffffffffc0208a6e:	8626                	mv	a2,s1
ffffffffc0208a70:	002c                	addi	a1,sp,8
ffffffffc0208a72:	854a                	mv	a0,s2
ffffffffc0208a74:	cb1fb0ef          	jal	ra,ffffffffc0204724 <wait_current_set>
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
ffffffffc0208a94:	b67fb0ef          	jal	ra,ffffffffc02045fa <wait_in_queue>
ffffffffc0208a98:	d171                	beqz	a0,ffffffffc0208a5c <stdin_io+0x88>
ffffffffc0208a9a:	002c                	addi	a1,sp,8
ffffffffc0208a9c:	854a                	mv	a0,s2
ffffffffc0208a9e:	b03fb0ef          	jal	ra,ffffffffc02045a0 <wait_queue_del>
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
ffffffffc0208b96:	a59fb0ef          	jal	ra,ffffffffc02045ee <wait_queue_empty>
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
ffffffffc0208bc4:	a93fb0ef          	jal	ra,ffffffffc0204656 <wakeup_queue>
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
ffffffffc0208c36:	965fb0ef          	jal	ra,ffffffffc020459a <wait_queue_init>
ffffffffc0208c3a:	4601                	li	a2,0
ffffffffc0208c3c:	85a2                	mv	a1,s0
ffffffffc0208c3e:	00006517          	auipc	a0,0x6
ffffffffc0208c42:	04250513          	addi	a0,a0,66 # ffffffffc020ec80 <dev_node_ops+0x270>
ffffffffc0208c46:	916ff0ef          	jal	ra,ffffffffc0207d5c <vfs_add_dev>
ffffffffc0208c4a:	e10d                	bnez	a0,ffffffffc0208c6c <dev_init_stdin+0x98>
ffffffffc0208c4c:	60a2                	ld	ra,8(sp)
ffffffffc0208c4e:	6402                	ld	s0,0(sp)
ffffffffc0208c50:	0141                	addi	sp,sp,16
ffffffffc0208c52:	8082                	ret
ffffffffc0208c54:	00006617          	auipc	a2,0x6
ffffffffc0208c58:	fec60613          	addi	a2,a2,-20 # ffffffffc020ec40 <dev_node_ops+0x230>
ffffffffc0208c5c:	07500593          	li	a1,117
ffffffffc0208c60:	00006517          	auipc	a0,0x6
ffffffffc0208c64:	00050513          	mv	a0,a0
ffffffffc0208c68:	837f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c6c:	86aa                	mv	a3,a0
ffffffffc0208c6e:	00006617          	auipc	a2,0x6
ffffffffc0208c72:	01a60613          	addi	a2,a2,26 # ffffffffc020ec88 <dev_node_ops+0x278>
ffffffffc0208c76:	07b00593          	li	a1,123
ffffffffc0208c7a:	00006517          	auipc	a0,0x6
ffffffffc0208c7e:	fe650513          	addi	a0,a0,-26 # ffffffffc020ec60 <dev_node_ops+0x250>
ffffffffc0208c82:	81df70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208c86:	00006697          	auipc	a3,0x6
ffffffffc0208c8a:	a6268693          	addi	a3,a3,-1438 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc0208c8e:	00003617          	auipc	a2,0x3
ffffffffc0208c92:	e1a60613          	addi	a2,a2,-486 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208c96:	07700593          	li	a1,119
ffffffffc0208c9a:	00006517          	auipc	a0,0x6
ffffffffc0208c9e:	fc650513          	addi	a0,a0,-58 # ffffffffc020ec60 <dev_node_ops+0x250>
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
ffffffffc0208d3e:	fae50513          	addi	a0,a0,-82 # ffffffffc020ece8 <dev_node_ops+0x2d8>
ffffffffc0208d42:	81aff0ef          	jal	ra,ffffffffc0207d5c <vfs_add_dev>
ffffffffc0208d46:	e105                	bnez	a0,ffffffffc0208d66 <dev_init_stdout+0x76>
ffffffffc0208d48:	60a2                	ld	ra,8(sp)
ffffffffc0208d4a:	0141                	addi	sp,sp,16
ffffffffc0208d4c:	8082                	ret
ffffffffc0208d4e:	00006617          	auipc	a2,0x6
ffffffffc0208d52:	f5a60613          	addi	a2,a2,-166 # ffffffffc020eca8 <dev_node_ops+0x298>
ffffffffc0208d56:	03700593          	li	a1,55
ffffffffc0208d5a:	00006517          	auipc	a0,0x6
ffffffffc0208d5e:	f6e50513          	addi	a0,a0,-146 # ffffffffc020ecc8 <dev_node_ops+0x2b8>
ffffffffc0208d62:	f3cf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d66:	86aa                	mv	a3,a0
ffffffffc0208d68:	00006617          	auipc	a2,0x6
ffffffffc0208d6c:	f8860613          	addi	a2,a2,-120 # ffffffffc020ecf0 <dev_node_ops+0x2e0>
ffffffffc0208d70:	03d00593          	li	a1,61
ffffffffc0208d74:	00006517          	auipc	a0,0x6
ffffffffc0208d78:	f5450513          	addi	a0,a0,-172 # ffffffffc020ecc8 <dev_node_ops+0x2b8>
ffffffffc0208d7c:	f22f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d80:	00006697          	auipc	a3,0x6
ffffffffc0208d84:	96868693          	addi	a3,a3,-1688 # ffffffffc020e6e8 <syscalls+0xb10>
ffffffffc0208d88:	00003617          	auipc	a2,0x3
ffffffffc0208d8c:	d2060613          	addi	a2,a2,-736 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208d90:	03900593          	li	a1,57
ffffffffc0208d94:	00006517          	auipc	a0,0x6
ffffffffc0208d98:	f3450513          	addi	a0,a0,-204 # ffffffffc020ecc8 <dev_node_ops+0x2b8>
ffffffffc0208d9c:	f02f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208da0 <bitmap_translate.part.0>:
ffffffffc0208da0:	1141                	addi	sp,sp,-16
ffffffffc0208da2:	00006697          	auipc	a3,0x6
ffffffffc0208da6:	f6e68693          	addi	a3,a3,-146 # ffffffffc020ed10 <dev_node_ops+0x300>
ffffffffc0208daa:	00003617          	auipc	a2,0x3
ffffffffc0208dae:	cfe60613          	addi	a2,a2,-770 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208db2:	04c00593          	li	a1,76
ffffffffc0208db6:	00006517          	auipc	a0,0x6
ffffffffc0208dba:	f7250513          	addi	a0,a0,-142 # ffffffffc020ed28 <dev_node_ops+0x318>
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
ffffffffc0208dda:	9b8f90ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc0208dde:	84aa                	mv	s1,a0
ffffffffc0208de0:	cd25                	beqz	a0,ffffffffc0208e58 <bitmap_create+0x94>
ffffffffc0208de2:	02041a13          	slli	s4,s0,0x20
ffffffffc0208de6:	020a5a13          	srli	s4,s4,0x20
ffffffffc0208dea:	01fa0793          	addi	a5,s4,31
ffffffffc0208dee:	0057d993          	srli	s3,a5,0x5
ffffffffc0208df2:	00299a93          	slli	s5,s3,0x2
ffffffffc0208df6:	8556                	mv	a0,s5
ffffffffc0208df8:	894e                	mv	s2,s3
ffffffffc0208dfa:	998f90ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc0208dfe:	c53d                	beqz	a0,ffffffffc0208e6c <bitmap_create+0xa8>
ffffffffc0208e00:	0134a223          	sw	s3,4(s1) # ffffffff80000004 <_binary_bin_sfs_img_size+0xffffffff7ff8ad04>
ffffffffc0208e04:	c080                	sw	s0,0(s1)
ffffffffc0208e06:	8656                	mv	a2,s5
ffffffffc0208e08:	0ff00593          	li	a1,255
ffffffffc0208e0c:	7ba020ef          	jal	ra,ffffffffc020b5c6 <memset>
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
ffffffffc0208e6e:	9d4f90ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0208e72:	4481                	li	s1,0
ffffffffc0208e74:	b7d5                	j	ffffffffc0208e58 <bitmap_create+0x94>
ffffffffc0208e76:	00006697          	auipc	a3,0x6
ffffffffc0208e7a:	eca68693          	addi	a3,a3,-310 # ffffffffc020ed40 <dev_node_ops+0x330>
ffffffffc0208e7e:	00003617          	auipc	a2,0x3
ffffffffc0208e82:	c2a60613          	addi	a2,a2,-982 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208e86:	45d5                	li	a1,21
ffffffffc0208e88:	00006517          	auipc	a0,0x6
ffffffffc0208e8c:	ea050513          	addi	a0,a0,-352 # ffffffffc020ed28 <dev_node_ops+0x318>
ffffffffc0208e90:	e0ef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208e94:	00006697          	auipc	a3,0x6
ffffffffc0208e98:	eec68693          	addi	a3,a3,-276 # ffffffffc020ed80 <dev_node_ops+0x370>
ffffffffc0208e9c:	00003617          	auipc	a2,0x3
ffffffffc0208ea0:	c0c60613          	addi	a2,a2,-1012 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208ea4:	02b00593          	li	a1,43
ffffffffc0208ea8:	00006517          	auipc	a0,0x6
ffffffffc0208eac:	e8050513          	addi	a0,a0,-384 # ffffffffc020ed28 <dev_node_ops+0x318>
ffffffffc0208eb0:	deef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208eb4:	00006697          	auipc	a3,0x6
ffffffffc0208eb8:	eb468693          	addi	a3,a3,-332 # ffffffffc020ed68 <dev_node_ops+0x358>
ffffffffc0208ebc:	00003617          	auipc	a2,0x3
ffffffffc0208ec0:	bec60613          	addi	a2,a2,-1044 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208ec4:	02a00593          	li	a1,42
ffffffffc0208ec8:	00006517          	auipc	a0,0x6
ffffffffc0208ecc:	e6050513          	addi	a0,a0,-416 # ffffffffc020ed28 <dev_node_ops+0x318>
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
ffffffffc0208f26:	c0668693          	addi	a3,a3,-1018 # ffffffffc020cb28 <default_pmm_manager+0x598>
ffffffffc0208f2a:	00003617          	auipc	a2,0x3
ffffffffc0208f2e:	b7e60613          	addi	a2,a2,-1154 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208f32:	04300593          	li	a1,67
ffffffffc0208f36:	00006517          	auipc	a0,0x6
ffffffffc0208f3a:	df250513          	addi	a0,a0,-526 # ffffffffc020ed28 <dev_node_ops+0x318>
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
ffffffffc0208fa2:	e0a68693          	addi	a3,a3,-502 # ffffffffc020eda8 <dev_node_ops+0x398>
ffffffffc0208fa6:	00003617          	auipc	a2,0x3
ffffffffc0208faa:	b0260613          	addi	a2,a2,-1278 # ffffffffc020baa8 <commands+0x210>
ffffffffc0208fae:	05f00593          	li	a1,95
ffffffffc0208fb2:	00006517          	auipc	a0,0x6
ffffffffc0208fb6:	d7650513          	addi	a0,a0,-650 # ffffffffc020ed28 <dev_node_ops+0x318>
ffffffffc0208fba:	ce4f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208fbe <bitmap_destroy>:
ffffffffc0208fbe:	1141                	addi	sp,sp,-16
ffffffffc0208fc0:	e022                	sd	s0,0(sp)
ffffffffc0208fc2:	842a                	mv	s0,a0
ffffffffc0208fc4:	6508                	ld	a0,8(a0)
ffffffffc0208fc6:	e406                	sd	ra,8(sp)
ffffffffc0208fc8:	87af90ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0208fcc:	8522                	mv	a0,s0
ffffffffc0208fce:	6402                	ld	s0,0(sp)
ffffffffc0208fd0:	60a2                	ld	ra,8(sp)
ffffffffc0208fd2:	0141                	addi	sp,sp,16
ffffffffc0208fd4:	86ef906f          	j	ffffffffc0202042 <kfree>

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
ffffffffc0208fec:	c3050513          	addi	a0,a0,-976 # ffffffffc020ec18 <dev_node_ops+0x208>
ffffffffc0208ff0:	e406                	sd	ra,8(sp)
ffffffffc0208ff2:	554000ef          	jal	ra,ffffffffc0209546 <sfs_mount>
ffffffffc0208ff6:	e501                	bnez	a0,ffffffffc0208ffe <sfs_init+0x18>
ffffffffc0208ff8:	60a2                	ld	ra,8(sp)
ffffffffc0208ffa:	0141                	addi	sp,sp,16
ffffffffc0208ffc:	8082                	ret
ffffffffc0208ffe:	86aa                	mv	a3,a0
ffffffffc0209000:	00006617          	auipc	a2,0x6
ffffffffc0209004:	db860613          	addi	a2,a2,-584 # ffffffffc020edb8 <dev_node_ops+0x3a8>
ffffffffc0209008:	45c1                	li	a1,16
ffffffffc020900a:	00006517          	auipc	a0,0x6
ffffffffc020900e:	dce50513          	addi	a0,a0,-562 # ffffffffc020edd8 <dev_node_ops+0x3c8>
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
ffffffffc020903c:	806f90ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0209040:	7448                	ld	a0,168(s0)
ffffffffc0209042:	800f90ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc0209046:	8522                	mv	a0,s0
ffffffffc0209048:	ffbf80ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc020904c:	4501                	li	a0,0
ffffffffc020904e:	60a2                	ld	ra,8(sp)
ffffffffc0209050:	6402                	ld	s0,0(sp)
ffffffffc0209052:	0141                	addi	sp,sp,16
ffffffffc0209054:	8082                	ret
ffffffffc0209056:	5545                	li	a0,-15
ffffffffc0209058:	bfdd                	j	ffffffffc020904e <sfs_unmount+0x38>
ffffffffc020905a:	00006697          	auipc	a3,0x6
ffffffffc020905e:	d9668693          	addi	a3,a3,-618 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc0209062:	00003617          	auipc	a2,0x3
ffffffffc0209066:	a4660613          	addi	a2,a2,-1466 # ffffffffc020baa8 <commands+0x210>
ffffffffc020906a:	04100593          	li	a1,65
ffffffffc020906e:	00006517          	auipc	a0,0x6
ffffffffc0209072:	db250513          	addi	a0,a0,-590 # ffffffffc020ee20 <dev_node_ops+0x410>
ffffffffc0209076:	c28f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020907a:	00006697          	auipc	a3,0x6
ffffffffc020907e:	dbe68693          	addi	a3,a3,-578 # ffffffffc020ee38 <dev_node_ops+0x428>
ffffffffc0209082:	00003617          	auipc	a2,0x3
ffffffffc0209086:	a2660613          	addi	a2,a2,-1498 # ffffffffc020baa8 <commands+0x210>
ffffffffc020908a:	04500593          	li	a1,69
ffffffffc020908e:	00006517          	auipc	a0,0x6
ffffffffc0209092:	d9250513          	addi	a0,a0,-622 # ffffffffc020ee20 <dev_node_ops+0x410>
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
ffffffffc02090c0:	d9450513          	addi	a0,a0,-620 # ffffffffc020ee50 <dev_node_ops+0x440>
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
ffffffffc02090f6:	d7e60613          	addi	a2,a2,-642 # ffffffffc020ee70 <dev_node_ops+0x460>
ffffffffc02090fa:	05f00593          	li	a1,95
ffffffffc02090fe:	00006517          	auipc	a0,0x6
ffffffffc0209102:	d2250513          	addi	a0,a0,-734 # ffffffffc020ee20 <dev_node_ops+0x410>
ffffffffc0209106:	6105                	addi	sp,sp,32
ffffffffc0209108:	bfef706f          	j	ffffffffc0200506 <__warn>
ffffffffc020910c:	00006697          	auipc	a3,0x6
ffffffffc0209110:	ce468693          	addi	a3,a3,-796 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc0209114:	00003617          	auipc	a2,0x3
ffffffffc0209118:	99460613          	addi	a2,a2,-1644 # ffffffffc020baa8 <commands+0x210>
ffffffffc020911c:	05400593          	li	a1,84
ffffffffc0209120:	00006517          	auipc	a0,0x6
ffffffffc0209124:	d0050513          	addi	a0,a0,-768 # ffffffffc020ee20 <dev_node_ops+0x410>
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
ffffffffc0209144:	72f010ef          	jal	ra,ffffffffc020b072 <lock_sfs_fs>
ffffffffc0209148:	0a0a3403          	ld	s0,160(s4)
ffffffffc020914c:	098a0913          	addi	s2,s4,152
ffffffffc0209150:	02890763          	beq	s2,s0,ffffffffc020917e <sfs_sync+0x52>
ffffffffc0209154:	00004997          	auipc	s3,0x4
ffffffffc0209158:	2dc98993          	addi	s3,s3,732 # ffffffffc020d430 <default_pmm_manager+0xea0>
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
ffffffffc0209180:	703010ef          	jal	ra,ffffffffc020b082 <unlock_sfs_fs>
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
ffffffffc02091a2:	5b5010ef          	jal	ra,ffffffffc020af56 <sfs_sync_super>
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
ffffffffc02091c0:	5dd010ef          	jal	ra,ffffffffc020af9c <sfs_sync_freemap>
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
ffffffffc02091da:	20a68693          	addi	a3,a3,522 # ffffffffc020d3e0 <default_pmm_manager+0xe50>
ffffffffc02091de:	00003617          	auipc	a2,0x3
ffffffffc02091e2:	8ca60613          	addi	a2,a2,-1846 # ffffffffc020baa8 <commands+0x210>
ffffffffc02091e6:	45ed                	li	a1,27
ffffffffc02091e8:	00006517          	auipc	a0,0x6
ffffffffc02091ec:	c3850513          	addi	a0,a0,-968 # ffffffffc020ee20 <dev_node_ops+0x410>
ffffffffc02091f0:	aaef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02091f4:	00006697          	auipc	a3,0x6
ffffffffc02091f8:	bfc68693          	addi	a3,a3,-1028 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc02091fc:	00003617          	auipc	a2,0x3
ffffffffc0209200:	8ac60613          	addi	a2,a2,-1876 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209204:	45d5                	li	a1,21
ffffffffc0209206:	00006517          	auipc	a0,0x6
ffffffffc020920a:	c1a50513          	addi	a0,a0,-998 # ffffffffc020ee20 <dev_node_ops+0x410>
ffffffffc020920e:	a90f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209212 <sfs_get_root>:
ffffffffc0209212:	1101                	addi	sp,sp,-32
ffffffffc0209214:	ec06                	sd	ra,24(sp)
ffffffffc0209216:	cd09                	beqz	a0,ffffffffc0209230 <sfs_get_root+0x1e>
ffffffffc0209218:	0b052783          	lw	a5,176(a0)
ffffffffc020921c:	eb91                	bnez	a5,ffffffffc0209230 <sfs_get_root+0x1e>
ffffffffc020921e:	4605                	li	a2,1
ffffffffc0209220:	002c                	addi	a1,sp,8
ffffffffc0209222:	378010ef          	jal	ra,ffffffffc020a59a <sfs_load_inode>
ffffffffc0209226:	e50d                	bnez	a0,ffffffffc0209250 <sfs_get_root+0x3e>
ffffffffc0209228:	60e2                	ld	ra,24(sp)
ffffffffc020922a:	6522                	ld	a0,8(sp)
ffffffffc020922c:	6105                	addi	sp,sp,32
ffffffffc020922e:	8082                	ret
ffffffffc0209230:	00006697          	auipc	a3,0x6
ffffffffc0209234:	bc068693          	addi	a3,a3,-1088 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc0209238:	00003617          	auipc	a2,0x3
ffffffffc020923c:	87060613          	addi	a2,a2,-1936 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209240:	03600593          	li	a1,54
ffffffffc0209244:	00006517          	auipc	a0,0x6
ffffffffc0209248:	bdc50513          	addi	a0,a0,-1060 # ffffffffc020ee20 <dev_node_ops+0x410>
ffffffffc020924c:	a52f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209250:	86aa                	mv	a3,a0
ffffffffc0209252:	00006617          	auipc	a2,0x6
ffffffffc0209256:	c3e60613          	addi	a2,a2,-962 # ffffffffc020ee90 <dev_node_ops+0x480>
ffffffffc020925a:	03700593          	li	a1,55
ffffffffc020925e:	00006517          	auipc	a0,0x6
ffffffffc0209262:	bc250513          	addi	a0,a0,-1086 # ffffffffc020ee20 <dev_node_ops+0x410>
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
ffffffffc02092ac:	ce7f80ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc02092b0:	e428                	sd	a0,72(s0)
ffffffffc02092b2:	84aa                	mv	s1,a0
ffffffffc02092b4:	16050363          	beqz	a0,ffffffffc020941a <sfs_do_mount+0x1b0>
ffffffffc02092b8:	85aa                	mv	a1,a0
ffffffffc02092ba:	4681                	li	a3,0
ffffffffc02092bc:	6605                	lui	a2,0x1
ffffffffc02092be:	1008                	addi	a0,sp,32
ffffffffc02092c0:	926fc0ef          	jal	ra,ffffffffc02053e6 <iobuf_init>
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
ffffffffc020933a:	c59f80ef          	jal	ra,ffffffffc0201f92 <kmalloc>
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
ffffffffc02093ca:	81cfc0ef          	jal	ra,ffffffffc02053e6 <iobuf_init>
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
ffffffffc02093ea:	c59f80ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc02093ee:	8526                	mv	a0,s1
ffffffffc02093f0:	c53f80ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc02093f4:	8522                	mv	a0,s0
ffffffffc02093f6:	c4df80ef          	jal	ra,ffffffffc0202042 <kfree>
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
ffffffffc0209424:	ac850513          	addi	a0,a0,-1336 # ffffffffc020eee8 <dev_node_ops+0x4d8>
ffffffffc0209428:	d7ff60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020942c:	5a75                	li	s4,-3
ffffffffc020942e:	b7c1                	j	ffffffffc02093ee <sfs_do_mount+0x184>
ffffffffc0209430:	00006517          	auipc	a0,0x6
ffffffffc0209434:	a8050513          	addi	a0,a0,-1408 # ffffffffc020eeb0 <dev_node_ops+0x4a0>
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
ffffffffc020946c:	8f2fb0ef          	jal	ra,ffffffffc020455e <sem_init>
ffffffffc0209470:	4585                	li	a1,1
ffffffffc0209472:	06840513          	addi	a0,s0,104
ffffffffc0209476:	8e8fb0ef          	jal	ra,ffffffffc020455e <sem_init>
ffffffffc020947a:	4585                	li	a1,1
ffffffffc020947c:	08040513          	addi	a0,s0,128
ffffffffc0209480:	8defb0ef          	jal	ra,ffffffffc020455e <sem_init>
ffffffffc0209484:	09840793          	addi	a5,s0,152
ffffffffc0209488:	f05c                	sd	a5,160(s0)
ffffffffc020948a:	ec5c                	sd	a5,152(s0)
ffffffffc020948c:	874a                	mv	a4,s2
ffffffffc020948e:	86da                	mv	a3,s6
ffffffffc0209490:	4169063b          	subw	a2,s2,s6
ffffffffc0209494:	00c40593          	addi	a1,s0,12
ffffffffc0209498:	00006517          	auipc	a0,0x6
ffffffffc020949c:	ae050513          	addi	a0,a0,-1312 # ffffffffc020ef78 <dev_node_ops+0x568>
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
ffffffffc02094ea:	a3268693          	addi	a3,a3,-1486 # ffffffffc020ef18 <dev_node_ops+0x508>
ffffffffc02094ee:	00002617          	auipc	a2,0x2
ffffffffc02094f2:	5ba60613          	addi	a2,a2,1466 # ffffffffc020baa8 <commands+0x210>
ffffffffc02094f6:	08300593          	li	a1,131
ffffffffc02094fa:	00006517          	auipc	a0,0x6
ffffffffc02094fe:	92650513          	addi	a0,a0,-1754 # ffffffffc020ee20 <dev_node_ops+0x410>
ffffffffc0209502:	f9df60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209506:	00006697          	auipc	a3,0x6
ffffffffc020950a:	8ea68693          	addi	a3,a3,-1814 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc020950e:	00002617          	auipc	a2,0x2
ffffffffc0209512:	59a60613          	addi	a2,a2,1434 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209516:	0a300593          	li	a1,163
ffffffffc020951a:	00006517          	auipc	a0,0x6
ffffffffc020951e:	90650513          	addi	a0,a0,-1786 # ffffffffc020ee20 <dev_node_ops+0x410>
ffffffffc0209522:	f7df60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209526:	00006697          	auipc	a3,0x6
ffffffffc020952a:	a2268693          	addi	a3,a3,-1502 # ffffffffc020ef48 <dev_node_ops+0x538>
ffffffffc020952e:	00002617          	auipc	a2,0x2
ffffffffc0209532:	57a60613          	addi	a2,a2,1402 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209536:	0e000593          	li	a1,224
ffffffffc020953a:	00006517          	auipc	a0,0x6
ffffffffc020953e:	8e650513          	addi	a0,a0,-1818 # ffffffffc020ee20 <dev_node_ops+0x410>
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
ffffffffc0209592:	a5a60613          	addi	a2,a2,-1446 # ffffffffc020efe8 <dev_node_ops+0x5d8>
ffffffffc0209596:	3bb00593          	li	a1,955
ffffffffc020959a:	00006517          	auipc	a0,0x6
ffffffffc020959e:	a3650513          	addi	a0,a0,-1482 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc02095be:	00006697          	auipc	a3,0x6
ffffffffc02095c2:	9da68693          	addi	a3,a3,-1574 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc02095c6:	00002617          	auipc	a2,0x2
ffffffffc02095ca:	4e260613          	addi	a2,a2,1250 # ffffffffc020baa8 <commands+0x210>
ffffffffc02095ce:	3af00593          	li	a1,943
ffffffffc02095d2:	00006517          	auipc	a0,0x6
ffffffffc02095d6:	9fe50513          	addi	a0,a0,-1538 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc020961e:	f4bfa0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc0209622:	681c                	ld	a5,16(s0)
ffffffffc0209624:	ef81                	bnez	a5,ffffffffc020963c <sfs_fsync+0x5e>
ffffffffc0209626:	854e                	mv	a0,s3
ffffffffc0209628:	f3dfa0ef          	jal	ra,ffffffffc0204564 <up>
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
ffffffffc020964c:	077010ef          	jal	ra,ffffffffc020aec2 <sfs_wbuf>
ffffffffc0209650:	892a                	mv	s2,a0
ffffffffc0209652:	d971                	beqz	a0,ffffffffc0209626 <sfs_fsync+0x48>
ffffffffc0209654:	4785                	li	a5,1
ffffffffc0209656:	e81c                	sd	a5,16(s0)
ffffffffc0209658:	b7f9                	j	ffffffffc0209626 <sfs_fsync+0x48>
ffffffffc020965a:	00005697          	auipc	a3,0x5
ffffffffc020965e:	79668693          	addi	a3,a3,1942 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc0209662:	00002617          	auipc	a2,0x2
ffffffffc0209666:	44660613          	addi	a2,a2,1094 # ffffffffc020baa8 <commands+0x210>
ffffffffc020966a:	2f300593          	li	a1,755
ffffffffc020966e:	00006517          	auipc	a0,0x6
ffffffffc0209672:	96250513          	addi	a0,a0,-1694 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc0209676:	e29f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020967a:	00006697          	auipc	a3,0x6
ffffffffc020967e:	91e68693          	addi	a3,a3,-1762 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc0209682:	00002617          	auipc	a2,0x2
ffffffffc0209686:	42660613          	addi	a2,a2,1062 # ffffffffc020baa8 <commands+0x210>
ffffffffc020968a:	2f400593          	li	a1,756
ffffffffc020968e:	00006517          	auipc	a0,0x6
ffffffffc0209692:	94250513          	addi	a0,a0,-1726 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc02096ae:	719010ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc02096b2:	c439                	beqz	s0,ffffffffc0209700 <sfs_fstat+0x66>
ffffffffc02096b4:	783c                	ld	a5,112(s0)
ffffffffc02096b6:	c7a9                	beqz	a5,ffffffffc0209700 <sfs_fstat+0x66>
ffffffffc02096b8:	6bbc                	ld	a5,80(a5)
ffffffffc02096ba:	c3b9                	beqz	a5,ffffffffc0209700 <sfs_fstat+0x66>
ffffffffc02096bc:	00005597          	auipc	a1,0x5
ffffffffc02096c0:	2cc58593          	addi	a1,a1,716 # ffffffffc020e988 <syscalls+0xdb0>
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
ffffffffc0209704:	22068693          	addi	a3,a3,544 # ffffffffc020e920 <syscalls+0xd48>
ffffffffc0209708:	00002617          	auipc	a2,0x2
ffffffffc020970c:	3a060613          	addi	a2,a2,928 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209710:	2e400593          	li	a1,740
ffffffffc0209714:	00006517          	auipc	a0,0x6
ffffffffc0209718:	8bc50513          	addi	a0,a0,-1860 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020971c:	d83f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209720:	00006697          	auipc	a3,0x6
ffffffffc0209724:	87868693          	addi	a3,a3,-1928 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc0209728:	00002617          	auipc	a2,0x2
ffffffffc020972c:	38060613          	addi	a2,a2,896 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209730:	2e700593          	li	a1,743
ffffffffc0209734:	00006517          	auipc	a0,0x6
ffffffffc0209738:	89c50513          	addi	a0,a0,-1892 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc0209778:	10458593          	addi	a1,a1,260 # ffffffffc020e878 <syscalls+0xca0>
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
ffffffffc02097a6:	7f668693          	addi	a3,a3,2038 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc02097aa:	00002617          	auipc	a2,0x2
ffffffffc02097ae:	2fe60613          	addi	a2,a2,766 # ffffffffc020baa8 <commands+0x210>
ffffffffc02097b2:	3c600593          	li	a1,966
ffffffffc02097b6:	00006517          	auipc	a0,0x6
ffffffffc02097ba:	81a50513          	addi	a0,a0,-2022 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc02097be:	ce1f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097c2:	00005697          	auipc	a3,0x5
ffffffffc02097c6:	05e68693          	addi	a3,a3,94 # ffffffffc020e820 <syscalls+0xc48>
ffffffffc02097ca:	00002617          	auipc	a2,0x2
ffffffffc02097ce:	2de60613          	addi	a2,a2,734 # ffffffffc020baa8 <commands+0x210>
ffffffffc02097d2:	3c800593          	li	a1,968
ffffffffc02097d6:	00005517          	auipc	a0,0x5
ffffffffc02097da:	7fa50513          	addi	a0,a0,2042 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc02097f8:	c3c58593          	addi	a1,a1,-964 # ffffffffc020d430 <default_pmm_manager+0xea0>
ffffffffc02097fc:	f99fd0ef          	jal	ra,ffffffffc0207794 <inode_check>
ffffffffc0209800:	783c                	ld	a5,112(s0)
ffffffffc0209802:	8522                	mv	a0,s0
ffffffffc0209804:	6402                	ld	s0,0(sp)
ffffffffc0209806:	60a2                	ld	ra,8(sp)
ffffffffc0209808:	7b9c                	ld	a5,48(a5)
ffffffffc020980a:	0141                	addi	sp,sp,16
ffffffffc020980c:	8782                	jr	a5
ffffffffc020980e:	00004697          	auipc	a3,0x4
ffffffffc0209812:	bd268693          	addi	a3,a3,-1070 # ffffffffc020d3e0 <default_pmm_manager+0xe50>
ffffffffc0209816:	00002617          	auipc	a2,0x2
ffffffffc020981a:	29260613          	addi	a2,a2,658 # ffffffffc020baa8 <commands+0x210>
ffffffffc020981e:	24c00593          	li	a1,588
ffffffffc0209822:	00005517          	auipc	a0,0x5
ffffffffc0209826:	7ae50513          	addi	a0,a0,1966 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020982a:	c75f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020982e <sfs_io.part.0>:
ffffffffc020982e:	1141                	addi	sp,sp,-16
ffffffffc0209830:	00005697          	auipc	a3,0x5
ffffffffc0209834:	76868693          	addi	a3,a3,1896 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc0209838:	00002617          	auipc	a2,0x2
ffffffffc020983c:	27060613          	addi	a2,a2,624 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209840:	2c300593          	li	a1,707
ffffffffc0209844:	00005517          	auipc	a0,0x5
ffffffffc0209848:	78c50513          	addi	a0,a0,1932 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc0209890:	77460613          	addi	a2,a2,1908 # ffffffffc020f000 <dev_node_ops+0x5f0>
ffffffffc0209894:	05300593          	li	a1,83
ffffffffc0209898:	00005517          	auipc	a0,0x5
ffffffffc020989c:	73850513          	addi	a0,a0,1848 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc02098a0:	bfff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02098a4:	00005697          	auipc	a3,0x5
ffffffffc02098a8:	79468693          	addi	a3,a3,1940 # ffffffffc020f038 <dev_node_ops+0x628>
ffffffffc02098ac:	00002617          	auipc	a2,0x2
ffffffffc02098b0:	1fc60613          	addi	a2,a2,508 # ffffffffc020baa8 <commands+0x210>
ffffffffc02098b4:	06a00593          	li	a1,106
ffffffffc02098b8:	00005517          	auipc	a0,0x5
ffffffffc02098bc:	71850513          	addi	a0,a0,1816 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc02098ec:	786010ef          	jal	ra,ffffffffc020b072 <lock_sfs_fs>
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
ffffffffc020991e:	f5e58593          	addi	a1,a1,-162 # ffffffffc020e878 <syscalls+0xca0>
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
ffffffffc020994a:	aea58593          	addi	a1,a1,-1302 # ffffffffc020d430 <default_pmm_manager+0xea0>
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
ffffffffc020996e:	714010ef          	jal	ra,ffffffffc020b082 <unlock_sfs_fs>
ffffffffc0209972:	6008                	ld	a0,0(s0)
ffffffffc0209974:	00655783          	lhu	a5,6(a0)
ffffffffc0209978:	cb85                	beqz	a5,ffffffffc02099a8 <sfs_reclaim+0xe4>
ffffffffc020997a:	ec8f80ef          	jal	ra,ffffffffc0202042 <kfree>
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
ffffffffc0209996:	6ec010ef          	jal	ra,ffffffffc020b082 <unlock_sfs_fs>
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
ffffffffc02099c8:	42c68693          	addi	a3,a3,1068 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc02099cc:	00002617          	auipc	a2,0x2
ffffffffc02099d0:	0dc60613          	addi	a2,a2,220 # ffffffffc020baa8 <commands+0x210>
ffffffffc02099d4:	38400593          	li	a1,900
ffffffffc02099d8:	00005517          	auipc	a0,0x5
ffffffffc02099dc:	5f850513          	addi	a0,a0,1528 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc02099e0:	abff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02099e4:	00005697          	auipc	a3,0x5
ffffffffc02099e8:	67468693          	addi	a3,a3,1652 # ffffffffc020f058 <dev_node_ops+0x648>
ffffffffc02099ec:	00002617          	auipc	a2,0x2
ffffffffc02099f0:	0bc60613          	addi	a2,a2,188 # ffffffffc020baa8 <commands+0x210>
ffffffffc02099f4:	38a00593          	li	a1,906
ffffffffc02099f8:	00005517          	auipc	a0,0x5
ffffffffc02099fc:	5d850513          	addi	a0,a0,1496 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc0209a00:	a9ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a04:	00005697          	auipc	a3,0x5
ffffffffc0209a08:	59468693          	addi	a3,a3,1428 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc0209a0c:	00002617          	auipc	a2,0x2
ffffffffc0209a10:	09c60613          	addi	a2,a2,156 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209a14:	38500593          	li	a1,901
ffffffffc0209a18:	00005517          	auipc	a0,0x5
ffffffffc0209a1c:	5b850513          	addi	a0,a0,1464 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc0209a20:	a7ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a24:	00005697          	auipc	a3,0x5
ffffffffc0209a28:	dfc68693          	addi	a3,a3,-516 # ffffffffc020e820 <syscalls+0xc48>
ffffffffc0209a2c:	00002617          	auipc	a2,0x2
ffffffffc0209a30:	07c60613          	addi	a2,a2,124 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209a34:	38f00593          	li	a1,911
ffffffffc0209a38:	00005517          	auipc	a0,0x5
ffffffffc0209a3c:	59850513          	addi	a0,a0,1432 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc0209a40:	a5ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a44:	00004697          	auipc	a3,0x4
ffffffffc0209a48:	99c68693          	addi	a3,a3,-1636 # ffffffffc020d3e0 <default_pmm_manager+0xe50>
ffffffffc0209a4c:	00002617          	auipc	a2,0x2
ffffffffc0209a50:	05c60613          	addi	a2,a2,92 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209a54:	39400593          	li	a1,916
ffffffffc0209a58:	00005517          	auipc	a0,0x5
ffffffffc0209a5c:	57850513          	addi	a0,a0,1400 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc0209aa4:	56e0106f          	j	ffffffffc020b012 <sfs_clear_block>
ffffffffc0209aa8:	60e2                	ld	ra,24(sp)
ffffffffc0209aaa:	6442                	ld	s0,16(sp)
ffffffffc0209aac:	64a2                	ld	s1,8(sp)
ffffffffc0209aae:	6105                	addi	sp,sp,32
ffffffffc0209ab0:	8082                	ret
ffffffffc0209ab2:	872e                	mv	a4,a1
ffffffffc0209ab4:	00005617          	auipc	a2,0x5
ffffffffc0209ab8:	54c60613          	addi	a2,a2,1356 # ffffffffc020f000 <dev_node_ops+0x5f0>
ffffffffc0209abc:	05300593          	li	a1,83
ffffffffc0209ac0:	00005517          	auipc	a0,0x5
ffffffffc0209ac4:	51050513          	addi	a0,a0,1296 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc0209ac8:	9d7f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209acc:	00005697          	auipc	a3,0x5
ffffffffc0209ad0:	5c468693          	addi	a3,a3,1476 # ffffffffc020f090 <dev_node_ops+0x680>
ffffffffc0209ad4:	00002617          	auipc	a2,0x2
ffffffffc0209ad8:	fd460613          	addi	a2,a2,-44 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209adc:	06100593          	li	a1,97
ffffffffc0209ae0:	00005517          	auipc	a0,0x5
ffffffffc0209ae4:	4f050513          	addi	a0,a0,1264 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc0209ae8:	9b7f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209aec:	00005697          	auipc	a3,0x5
ffffffffc0209af0:	58468693          	addi	a3,a3,1412 # ffffffffc020f070 <dev_node_ops+0x660>
ffffffffc0209af4:	00002617          	auipc	a2,0x2
ffffffffc0209af8:	fb460613          	addi	a2,a2,-76 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209afc:	05f00593          	li	a1,95
ffffffffc0209b00:	00005517          	auipc	a0,0x5
ffffffffc0209b04:	4d050513          	addi	a0,a0,1232 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc0209b70:	49460613          	addi	a2,a2,1172 # ffffffffc020f000 <dev_node_ops+0x5f0>
ffffffffc0209b74:	05300593          	li	a1,83
ffffffffc0209b78:	00005517          	auipc	a0,0x5
ffffffffc0209b7c:	45850513          	addi	a0,a0,1112 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc0209c32:	290010ef          	jal	ra,ffffffffc020aec2 <sfs_wbuf>
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
ffffffffc0209c66:	1dc010ef          	jal	ra,ffffffffc020ae42 <sfs_rbuf>
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
ffffffffc0209cb6:	40668693          	addi	a3,a3,1030 # ffffffffc020f0b8 <dev_node_ops+0x6a8>
ffffffffc0209cba:	00002617          	auipc	a2,0x2
ffffffffc0209cbe:	dee60613          	addi	a2,a2,-530 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209cc2:	16400593          	li	a1,356
ffffffffc0209cc6:	00005517          	auipc	a0,0x5
ffffffffc0209cca:	30a50513          	addi	a0,a0,778 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc0209cce:	fd0f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209cd2:	872e                	mv	a4,a1
ffffffffc0209cd4:	00005617          	auipc	a2,0x5
ffffffffc0209cd8:	32c60613          	addi	a2,a2,812 # ffffffffc020f000 <dev_node_ops+0x5f0>
ffffffffc0209cdc:	05300593          	li	a1,83
ffffffffc0209ce0:	00005517          	auipc	a0,0x5
ffffffffc0209ce4:	2f050513          	addi	a0,a0,752 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc0209ce8:	fb6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209cec:	00005617          	auipc	a2,0x5
ffffffffc0209cf0:	3fc60613          	addi	a2,a2,1020 # ffffffffc020f0e8 <dev_node_ops+0x6d8>
ffffffffc0209cf4:	11e00593          	li	a1,286
ffffffffc0209cf8:	00005517          	auipc	a0,0x5
ffffffffc0209cfc:	2d850513          	addi	a0,a0,728 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc0209d00:	f9ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d04:	00005697          	auipc	a3,0x5
ffffffffc0209d08:	33468693          	addi	a3,a3,820 # ffffffffc020f038 <dev_node_ops+0x628>
ffffffffc0209d0c:	00002617          	auipc	a2,0x2
ffffffffc0209d10:	d9c60613          	addi	a2,a2,-612 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209d14:	16b00593          	li	a1,363
ffffffffc0209d18:	00005517          	auipc	a0,0x5
ffffffffc0209d1c:	2b850513          	addi	a0,a0,696 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc0209d20:	f7ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d24:	00005697          	auipc	a3,0x5
ffffffffc0209d28:	3ac68693          	addi	a3,a3,940 # ffffffffc020f0d0 <dev_node_ops+0x6c0>
ffffffffc0209d2c:	00002617          	auipc	a2,0x2
ffffffffc0209d30:	d7c60613          	addi	a2,a2,-644 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209d34:	11800593          	li	a1,280
ffffffffc0209d38:	00005517          	auipc	a0,0x5
ffffffffc0209d3c:	29850513          	addi	a0,a0,664 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc0209d40:	f5ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d44:	00005697          	auipc	a3,0x5
ffffffffc0209d48:	3d468693          	addi	a3,a3,980 # ffffffffc020f118 <dev_node_ops+0x708>
ffffffffc0209d4c:	00002617          	auipc	a2,0x2
ffffffffc0209d50:	d5c60613          	addi	a2,a2,-676 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209d54:	12100593          	li	a1,289
ffffffffc0209d58:	00005517          	auipc	a0,0x5
ffffffffc0209d5c:	27850513          	addi	a0,a0,632 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc0209dbe:	10878793          	addi	a5,a5,264 # ffffffffc020aec2 <sfs_wbuf>
ffffffffc0209dc2:	00001b97          	auipc	s7,0x1
ffffffffc0209dc6:	020b8b93          	addi	s7,s7,32 # ffffffffc020ade2 <sfs_wblock>
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
ffffffffc0209eb0:	f9678793          	addi	a5,a5,-106 # ffffffffc020ae42 <sfs_rbuf>
ffffffffc0209eb4:	00001b97          	auipc	s7,0x1
ffffffffc0209eb8:	eceb8b93          	addi	s7,s7,-306 # ffffffffc020ad82 <sfs_rblock>
ffffffffc0209ebc:	e43e                	sd	a5,8(sp)
ffffffffc0209ebe:	b739                	j	ffffffffc0209dcc <sfs_io_nolock+0x68>
ffffffffc0209ec0:	41870cb3          	sub	s9,a4,s8
ffffffffc0209ec4:	bf05                	j	ffffffffc0209df4 <sfs_io_nolock+0x90>
ffffffffc0209ec6:	89be                	mv	s3,a5
ffffffffc0209ec8:	00001797          	auipc	a5,0x1
ffffffffc0209ecc:	f7a78793          	addi	a5,a5,-134 # ffffffffc020ae42 <sfs_rbuf>
ffffffffc0209ed0:	00001b97          	auipc	s7,0x1
ffffffffc0209ed4:	eb2b8b93          	addi	s7,s7,-334 # ffffffffc020ad82 <sfs_rblock>
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
ffffffffc0209f0c:	23868693          	addi	a3,a3,568 # ffffffffc020f140 <dev_node_ops+0x730>
ffffffffc0209f10:	00002617          	auipc	a2,0x2
ffffffffc0209f14:	b9860613          	addi	a2,a2,-1128 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209f18:	25b00593          	li	a1,603
ffffffffc0209f1c:	00005517          	auipc	a0,0x5
ffffffffc0209f20:	0b450513          	addi	a0,a0,180 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc0209f58:	e10fa0ef          	jal	ra,ffffffffc0204568 <down>
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
ffffffffc0209f7a:	deafa0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc0209f7e:	70e2                	ld	ra,56(sp)
ffffffffc0209f80:	8522                	mv	a0,s0
ffffffffc0209f82:	7442                	ld	s0,48(sp)
ffffffffc0209f84:	74a2                	ld	s1,40(sp)
ffffffffc0209f86:	7902                	ld	s2,32(sp)
ffffffffc0209f88:	69e2                	ld	s3,24(sp)
ffffffffc0209f8a:	6121                	addi	sp,sp,64
ffffffffc0209f8c:	8082                	ret
ffffffffc0209f8e:	8526                	mv	a0,s1
ffffffffc0209f90:	cccfb0ef          	jal	ra,ffffffffc020545c <iobuf_skip>
ffffffffc0209f94:	b7d5                	j	ffffffffc0209f78 <sfs_read+0x50>
ffffffffc0209f96:	00005697          	auipc	a3,0x5
ffffffffc0209f9a:	e5a68693          	addi	a3,a3,-422 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc0209f9e:	00002617          	auipc	a2,0x2
ffffffffc0209fa2:	b0a60613          	addi	a2,a2,-1270 # ffffffffc020baa8 <commands+0x210>
ffffffffc0209fa6:	2c200593          	li	a1,706
ffffffffc0209faa:	00005517          	auipc	a0,0x5
ffffffffc0209fae:	02650513          	addi	a0,a0,38 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc0209fea:	d7efa0ef          	jal	ra,ffffffffc0204568 <down>
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
ffffffffc020a00c:	d58fa0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020a010:	70e2                	ld	ra,56(sp)
ffffffffc020a012:	8522                	mv	a0,s0
ffffffffc020a014:	7442                	ld	s0,48(sp)
ffffffffc020a016:	74a2                	ld	s1,40(sp)
ffffffffc020a018:	7902                	ld	s2,32(sp)
ffffffffc020a01a:	69e2                	ld	s3,24(sp)
ffffffffc020a01c:	6121                	addi	sp,sp,64
ffffffffc020a01e:	8082                	ret
ffffffffc020a020:	8526                	mv	a0,s1
ffffffffc020a022:	c3afb0ef          	jal	ra,ffffffffc020545c <iobuf_skip>
ffffffffc020a026:	b7d5                	j	ffffffffc020a00a <sfs_write+0x50>
ffffffffc020a028:	00005697          	auipc	a3,0x5
ffffffffc020a02c:	dc868693          	addi	a3,a3,-568 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc020a030:	00002617          	auipc	a2,0x2
ffffffffc020a034:	a7860613          	addi	a2,a2,-1416 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a038:	2c200593          	li	a1,706
ffffffffc020a03c:	00005517          	auipc	a0,0x5
ffffffffc020a040:	f9450513          	addi	a0,a0,-108 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc020a09e:	5a5000ef          	jal	ra,ffffffffc020ae42 <sfs_rbuf>
ffffffffc020a0a2:	f971                	bnez	a0,ffffffffc020a076 <sfs_dirent_read_nolock+0x2a>
ffffffffc020a0a4:	100481a3          	sb	zero,259(s1)
ffffffffc020a0a8:	70a2                	ld	ra,40(sp)
ffffffffc020a0aa:	7402                	ld	s0,32(sp)
ffffffffc020a0ac:	64e2                	ld	s1,24(sp)
ffffffffc020a0ae:	6145                	addi	sp,sp,48
ffffffffc020a0b0:	8082                	ret
ffffffffc020a0b2:	00005697          	auipc	a3,0x5
ffffffffc020a0b6:	0ae68693          	addi	a3,a3,174 # ffffffffc020f160 <dev_node_ops+0x750>
ffffffffc020a0ba:	00002617          	auipc	a2,0x2
ffffffffc020a0be:	9ee60613          	addi	a2,a2,-1554 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a0c2:	18e00593          	li	a1,398
ffffffffc020a0c6:	00005517          	auipc	a0,0x5
ffffffffc020a0ca:	f0a50513          	addi	a0,a0,-246 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a0ce:	bd0f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a0d2:	872e                	mv	a4,a1
ffffffffc020a0d4:	00005617          	auipc	a2,0x5
ffffffffc020a0d8:	f2c60613          	addi	a2,a2,-212 # ffffffffc020f000 <dev_node_ops+0x5f0>
ffffffffc020a0dc:	05300593          	li	a1,83
ffffffffc020a0e0:	00005517          	auipc	a0,0x5
ffffffffc020a0e4:	ef050513          	addi	a0,a0,-272 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a0e8:	bb6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a0ec:	00005697          	auipc	a3,0x5
ffffffffc020a0f0:	f4c68693          	addi	a3,a3,-180 # ffffffffc020f038 <dev_node_ops+0x628>
ffffffffc020a0f4:	00002617          	auipc	a2,0x2
ffffffffc020a0f8:	9b460613          	addi	a2,a2,-1612 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a0fc:	19500593          	li	a1,405
ffffffffc020a100:	00005517          	auipc	a0,0x5
ffffffffc020a104:	ed050513          	addi	a0,a0,-304 # ffffffffc020efd0 <dev_node_ops+0x5c0>
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
ffffffffc020a12a:	e69f70ef          	jal	ra,ffffffffc0201f92 <kmalloc>
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
ffffffffc020a172:	bf6fa0ef          	jal	ra,ffffffffc0204568 <down>
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
ffffffffc020a1aa:	bbafa0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020a1ae:	a831                	j	ffffffffc020a1ca <sfs_getdirentry+0xbe>
ffffffffc020a1b0:	8562                	mv	a0,s8
ffffffffc020a1b2:	bb2fa0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020a1b6:	4701                	li	a4,0
ffffffffc020a1b8:	4685                	li	a3,1
ffffffffc020a1ba:	10000613          	li	a2,256
ffffffffc020a1be:	00490593          	addi	a1,s2,4
ffffffffc020a1c2:	855a                	mv	a0,s6
ffffffffc020a1c4:	a2cfb0ef          	jal	ra,ffffffffc02053f0 <iobuf_move>
ffffffffc020a1c8:	842a                	mv	s0,a0
ffffffffc020a1ca:	854a                	mv	a0,s2
ffffffffc020a1cc:	e77f70ef          	jal	ra,ffffffffc0202042 <kfree>
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
ffffffffc020a1ee:	b76fa0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020a1f2:	bfe1                	j	ffffffffc020a1ca <sfs_getdirentry+0xbe>
ffffffffc020a1f4:	854a                	mv	a0,s2
ffffffffc020a1f6:	e4df70ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc020a1fa:	5475                	li	s0,-3
ffffffffc020a1fc:	bfd1                	j	ffffffffc020a1d0 <sfs_getdirentry+0xc4>
ffffffffc020a1fe:	e45f70ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc020a202:	5441                	li	s0,-16
ffffffffc020a204:	b7f1                	j	ffffffffc020a1d0 <sfs_getdirentry+0xc4>
ffffffffc020a206:	5471                	li	s0,-4
ffffffffc020a208:	b7e1                	j	ffffffffc020a1d0 <sfs_getdirentry+0xc4>
ffffffffc020a20a:	00005697          	auipc	a3,0x5
ffffffffc020a20e:	be668693          	addi	a3,a3,-1050 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc020a212:	00002617          	auipc	a2,0x2
ffffffffc020a216:	89660613          	addi	a2,a2,-1898 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a21a:	36600593          	li	a1,870
ffffffffc020a21e:	00005517          	auipc	a0,0x5
ffffffffc020a222:	db250513          	addi	a0,a0,-590 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a226:	a78f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a22a:	00005697          	auipc	a3,0x5
ffffffffc020a22e:	d6e68693          	addi	a3,a3,-658 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc020a232:	00002617          	auipc	a2,0x2
ffffffffc020a236:	87660613          	addi	a2,a2,-1930 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a23a:	36700593          	li	a1,871
ffffffffc020a23e:	00005517          	auipc	a0,0x5
ffffffffc020a242:	d9250513          	addi	a0,a0,-622 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a246:	a58f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a24a <sfs_dirent_search_nolock>:
ffffffffc020a24a:	711d                	addi	sp,sp,-96
ffffffffc020a24c:	fc4e                	sd	s3,56(sp)
ffffffffc020a24e:	89aa                	mv	s3,a0
ffffffffc020a250:	8532                	mv	a0,a2
ffffffffc020a252:	e0ca                	sd	s2,64(sp)
ffffffffc020a254:	f852                	sd	s4,48(sp)
ffffffffc020a256:	f05a                	sd	s6,32(sp)
ffffffffc020a258:	e862                	sd	s8,16(sp)
ffffffffc020a25a:	e466                	sd	s9,8(sp)
ffffffffc020a25c:	8a3e                	mv	s4,a5
ffffffffc020a25e:	ec86                	sd	ra,88(sp)
ffffffffc020a260:	e8a2                	sd	s0,80(sp)
ffffffffc020a262:	e4a6                	sd	s1,72(sp)
ffffffffc020a264:	f456                	sd	s5,40(sp)
ffffffffc020a266:	ec5e                	sd	s7,24(sp)
ffffffffc020a268:	e06a                	sd	s10,0(sp)
ffffffffc020a26a:	8b32                	mv	s6,a2
ffffffffc020a26c:	892e                	mv	s2,a1
ffffffffc020a26e:	8cb6                	mv	s9,a3
ffffffffc020a270:	8c3a                	mv	s8,a4
ffffffffc020a272:	2b2010ef          	jal	ra,ffffffffc020b524 <strlen>
ffffffffc020a276:	0ff00793          	li	a5,255
ffffffffc020a27a:	08a7ec63          	bltu	a5,a0,ffffffffc020a312 <sfs_dirent_search_nolock+0xc8>
ffffffffc020a27e:	10400513          	li	a0,260
ffffffffc020a282:	d11f70ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc020a286:	8d2a                	mv	s10,a0
ffffffffc020a288:	c159                	beqz	a0,ffffffffc020a30e <sfs_dirent_search_nolock+0xc4>
ffffffffc020a28a:	00093783          	ld	a5,0(s2)
ffffffffc020a28e:	0087aa83          	lw	s5,8(a5)
ffffffffc020a292:	000a0463          	beqz	s4,ffffffffc020a29a <sfs_dirent_search_nolock+0x50>
ffffffffc020a296:	015a2023          	sw	s5,0(s4)
ffffffffc020a29a:	07505863          	blez	s5,ffffffffc020a30a <sfs_dirent_search_nolock+0xc0>
ffffffffc020a29e:	4481                	li	s1,0
ffffffffc020a2a0:	004d0b93          	addi	s7,s10,4
ffffffffc020a2a4:	a801                	j	ffffffffc020a2b4 <sfs_dirent_search_nolock+0x6a>
ffffffffc020a2a6:	000a0463          	beqz	s4,ffffffffc020a2ae <sfs_dirent_search_nolock+0x64>
ffffffffc020a2aa:	009a2023          	sw	s1,0(s4)
ffffffffc020a2ae:	2485                	addiw	s1,s1,1
ffffffffc020a2b0:	049a8d63          	beq	s5,s1,ffffffffc020a30a <sfs_dirent_search_nolock+0xc0>
ffffffffc020a2b4:	86ea                	mv	a3,s10
ffffffffc020a2b6:	8626                	mv	a2,s1
ffffffffc020a2b8:	85ca                	mv	a1,s2
ffffffffc020a2ba:	854e                	mv	a0,s3
ffffffffc020a2bc:	d91ff0ef          	jal	ra,ffffffffc020a04c <sfs_dirent_read_nolock>
ffffffffc020a2c0:	842a                	mv	s0,a0
ffffffffc020a2c2:	e115                	bnez	a0,ffffffffc020a2e6 <sfs_dirent_search_nolock+0x9c>
ffffffffc020a2c4:	000d2783          	lw	a5,0(s10)
ffffffffc020a2c8:	dff9                	beqz	a5,ffffffffc020a2a6 <sfs_dirent_search_nolock+0x5c>
ffffffffc020a2ca:	85de                	mv	a1,s7
ffffffffc020a2cc:	855a                	mv	a0,s6
ffffffffc020a2ce:	29e010ef          	jal	ra,ffffffffc020b56c <strcmp>
ffffffffc020a2d2:	842a                	mv	s0,a0
ffffffffc020a2d4:	fd69                	bnez	a0,ffffffffc020a2ae <sfs_dirent_search_nolock+0x64>
ffffffffc020a2d6:	000c0463          	beqz	s8,ffffffffc020a2de <sfs_dirent_search_nolock+0x94>
ffffffffc020a2da:	009c2023          	sw	s1,0(s8)
ffffffffc020a2de:	000d2783          	lw	a5,0(s10)
ffffffffc020a2e2:	00fca023          	sw	a5,0(s9) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020a2e6:	856a                	mv	a0,s10
ffffffffc020a2e8:	d5bf70ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc020a2ec:	60e6                	ld	ra,88(sp)
ffffffffc020a2ee:	8522                	mv	a0,s0
ffffffffc020a2f0:	6446                	ld	s0,80(sp)
ffffffffc020a2f2:	64a6                	ld	s1,72(sp)
ffffffffc020a2f4:	6906                	ld	s2,64(sp)
ffffffffc020a2f6:	79e2                	ld	s3,56(sp)
ffffffffc020a2f8:	7a42                	ld	s4,48(sp)
ffffffffc020a2fa:	7aa2                	ld	s5,40(sp)
ffffffffc020a2fc:	7b02                	ld	s6,32(sp)
ffffffffc020a2fe:	6be2                	ld	s7,24(sp)
ffffffffc020a300:	6c42                	ld	s8,16(sp)
ffffffffc020a302:	6ca2                	ld	s9,8(sp)
ffffffffc020a304:	6d02                	ld	s10,0(sp)
ffffffffc020a306:	6125                	addi	sp,sp,96
ffffffffc020a308:	8082                	ret
ffffffffc020a30a:	5441                	li	s0,-16
ffffffffc020a30c:	bfe9                	j	ffffffffc020a2e6 <sfs_dirent_search_nolock+0x9c>
ffffffffc020a30e:	5471                	li	s0,-4
ffffffffc020a310:	bff1                	j	ffffffffc020a2ec <sfs_dirent_search_nolock+0xa2>
ffffffffc020a312:	00005697          	auipc	a3,0x5
ffffffffc020a316:	e9e68693          	addi	a3,a3,-354 # ffffffffc020f1b0 <dev_node_ops+0x7a0>
ffffffffc020a31a:	00001617          	auipc	a2,0x1
ffffffffc020a31e:	78e60613          	addi	a2,a2,1934 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a322:	1ea00593          	li	a1,490
ffffffffc020a326:	00005517          	auipc	a0,0x5
ffffffffc020a32a:	caa50513          	addi	a0,a0,-854 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a32e:	970f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a332 <sfs_truncfile>:
ffffffffc020a332:	7175                	addi	sp,sp,-144
ffffffffc020a334:	e506                	sd	ra,136(sp)
ffffffffc020a336:	e122                	sd	s0,128(sp)
ffffffffc020a338:	fca6                	sd	s1,120(sp)
ffffffffc020a33a:	f8ca                	sd	s2,112(sp)
ffffffffc020a33c:	f4ce                	sd	s3,104(sp)
ffffffffc020a33e:	f0d2                	sd	s4,96(sp)
ffffffffc020a340:	ecd6                	sd	s5,88(sp)
ffffffffc020a342:	e8da                	sd	s6,80(sp)
ffffffffc020a344:	e4de                	sd	s7,72(sp)
ffffffffc020a346:	e0e2                	sd	s8,64(sp)
ffffffffc020a348:	fc66                	sd	s9,56(sp)
ffffffffc020a34a:	f86a                	sd	s10,48(sp)
ffffffffc020a34c:	f46e                	sd	s11,40(sp)
ffffffffc020a34e:	080007b7          	lui	a5,0x8000
ffffffffc020a352:	16b7e463          	bltu	a5,a1,ffffffffc020a4ba <sfs_truncfile+0x188>
ffffffffc020a356:	06853c83          	ld	s9,104(a0)
ffffffffc020a35a:	89aa                	mv	s3,a0
ffffffffc020a35c:	160c8163          	beqz	s9,ffffffffc020a4be <sfs_truncfile+0x18c>
ffffffffc020a360:	0b0ca783          	lw	a5,176(s9)
ffffffffc020a364:	14079d63          	bnez	a5,ffffffffc020a4be <sfs_truncfile+0x18c>
ffffffffc020a368:	4d38                	lw	a4,88(a0)
ffffffffc020a36a:	6405                	lui	s0,0x1
ffffffffc020a36c:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a370:	16f71763          	bne	a4,a5,ffffffffc020a4de <sfs_truncfile+0x1ac>
ffffffffc020a374:	00053a83          	ld	s5,0(a0)
ffffffffc020a378:	147d                	addi	s0,s0,-1
ffffffffc020a37a:	942e                	add	s0,s0,a1
ffffffffc020a37c:	000ae783          	lwu	a5,0(s5)
ffffffffc020a380:	8031                	srli	s0,s0,0xc
ffffffffc020a382:	8a2e                	mv	s4,a1
ffffffffc020a384:	2401                	sext.w	s0,s0
ffffffffc020a386:	02b79763          	bne	a5,a1,ffffffffc020a3b4 <sfs_truncfile+0x82>
ffffffffc020a38a:	008aa783          	lw	a5,8(s5)
ffffffffc020a38e:	4901                	li	s2,0
ffffffffc020a390:	18879763          	bne	a5,s0,ffffffffc020a51e <sfs_truncfile+0x1ec>
ffffffffc020a394:	60aa                	ld	ra,136(sp)
ffffffffc020a396:	640a                	ld	s0,128(sp)
ffffffffc020a398:	74e6                	ld	s1,120(sp)
ffffffffc020a39a:	79a6                	ld	s3,104(sp)
ffffffffc020a39c:	7a06                	ld	s4,96(sp)
ffffffffc020a39e:	6ae6                	ld	s5,88(sp)
ffffffffc020a3a0:	6b46                	ld	s6,80(sp)
ffffffffc020a3a2:	6ba6                	ld	s7,72(sp)
ffffffffc020a3a4:	6c06                	ld	s8,64(sp)
ffffffffc020a3a6:	7ce2                	ld	s9,56(sp)
ffffffffc020a3a8:	7d42                	ld	s10,48(sp)
ffffffffc020a3aa:	7da2                	ld	s11,40(sp)
ffffffffc020a3ac:	854a                	mv	a0,s2
ffffffffc020a3ae:	7946                	ld	s2,112(sp)
ffffffffc020a3b0:	6149                	addi	sp,sp,144
ffffffffc020a3b2:	8082                	ret
ffffffffc020a3b4:	02050b13          	addi	s6,a0,32
ffffffffc020a3b8:	855a                	mv	a0,s6
ffffffffc020a3ba:	9aefa0ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc020a3be:	008aa483          	lw	s1,8(s5)
ffffffffc020a3c2:	0a84e663          	bltu	s1,s0,ffffffffc020a46e <sfs_truncfile+0x13c>
ffffffffc020a3c6:	0c947163          	bgeu	s0,s1,ffffffffc020a488 <sfs_truncfile+0x156>
ffffffffc020a3ca:	4dad                	li	s11,11
ffffffffc020a3cc:	4b85                	li	s7,1
ffffffffc020a3ce:	a09d                	j	ffffffffc020a434 <sfs_truncfile+0x102>
ffffffffc020a3d0:	ff37091b          	addiw	s2,a4,-13
ffffffffc020a3d4:	0009079b          	sext.w	a5,s2
ffffffffc020a3d8:	3ff00713          	li	a4,1023
ffffffffc020a3dc:	04f76563          	bltu	a4,a5,ffffffffc020a426 <sfs_truncfile+0xf4>
ffffffffc020a3e0:	03cd2c03          	lw	s8,60(s10)
ffffffffc020a3e4:	040c0163          	beqz	s8,ffffffffc020a426 <sfs_truncfile+0xf4>
ffffffffc020a3e8:	004ca783          	lw	a5,4(s9)
ffffffffc020a3ec:	18fc7963          	bgeu	s8,a5,ffffffffc020a57e <sfs_truncfile+0x24c>
ffffffffc020a3f0:	038cb503          	ld	a0,56(s9)
ffffffffc020a3f4:	85e2                	mv	a1,s8
ffffffffc020a3f6:	b4ffe0ef          	jal	ra,ffffffffc0208f44 <bitmap_test>
ffffffffc020a3fa:	16051263          	bnez	a0,ffffffffc020a55e <sfs_truncfile+0x22c>
ffffffffc020a3fe:	02091793          	slli	a5,s2,0x20
ffffffffc020a402:	01e7d713          	srli	a4,a5,0x1e
ffffffffc020a406:	86e2                	mv	a3,s8
ffffffffc020a408:	4611                	li	a2,4
ffffffffc020a40a:	082c                	addi	a1,sp,24
ffffffffc020a40c:	8566                	mv	a0,s9
ffffffffc020a40e:	e43a                	sd	a4,8(sp)
ffffffffc020a410:	ce02                	sw	zero,28(sp)
ffffffffc020a412:	231000ef          	jal	ra,ffffffffc020ae42 <sfs_rbuf>
ffffffffc020a416:	892a                	mv	s2,a0
ffffffffc020a418:	e141                	bnez	a0,ffffffffc020a498 <sfs_truncfile+0x166>
ffffffffc020a41a:	47e2                	lw	a5,24(sp)
ffffffffc020a41c:	6722                	ld	a4,8(sp)
ffffffffc020a41e:	e3c9                	bnez	a5,ffffffffc020a4a0 <sfs_truncfile+0x16e>
ffffffffc020a420:	008d2603          	lw	a2,8(s10)
ffffffffc020a424:	367d                	addiw	a2,a2,-1
ffffffffc020a426:	00cd2423          	sw	a2,8(s10)
ffffffffc020a42a:	0179b823          	sd	s7,16(s3) # 8000010 <_binary_bin_sfs_img_size+0x7f8ad10>
ffffffffc020a42e:	34fd                	addiw	s1,s1,-1
ffffffffc020a430:	04940a63          	beq	s0,s1,ffffffffc020a484 <sfs_truncfile+0x152>
ffffffffc020a434:	0009bd03          	ld	s10,0(s3)
ffffffffc020a438:	008d2703          	lw	a4,8(s10)
ffffffffc020a43c:	c369                	beqz	a4,ffffffffc020a4fe <sfs_truncfile+0x1cc>
ffffffffc020a43e:	fff7079b          	addiw	a5,a4,-1
ffffffffc020a442:	0007861b          	sext.w	a2,a5
ffffffffc020a446:	f8cde5e3          	bltu	s11,a2,ffffffffc020a3d0 <sfs_truncfile+0x9e>
ffffffffc020a44a:	02079713          	slli	a4,a5,0x20
ffffffffc020a44e:	01e75793          	srli	a5,a4,0x1e
ffffffffc020a452:	00fd0933          	add	s2,s10,a5
ffffffffc020a456:	00c92583          	lw	a1,12(s2)
ffffffffc020a45a:	d5f1                	beqz	a1,ffffffffc020a426 <sfs_truncfile+0xf4>
ffffffffc020a45c:	8566                	mv	a0,s9
ffffffffc020a45e:	bf4ff0ef          	jal	ra,ffffffffc0209852 <sfs_block_free>
ffffffffc020a462:	00092623          	sw	zero,12(s2)
ffffffffc020a466:	008d2603          	lw	a2,8(s10)
ffffffffc020a46a:	367d                	addiw	a2,a2,-1
ffffffffc020a46c:	bf6d                	j	ffffffffc020a426 <sfs_truncfile+0xf4>
ffffffffc020a46e:	4681                	li	a3,0
ffffffffc020a470:	8626                	mv	a2,s1
ffffffffc020a472:	85ce                	mv	a1,s3
ffffffffc020a474:	8566                	mv	a0,s9
ffffffffc020a476:	e96ff0ef          	jal	ra,ffffffffc0209b0c <sfs_bmap_load_nolock>
ffffffffc020a47a:	892a                	mv	s2,a0
ffffffffc020a47c:	ed11                	bnez	a0,ffffffffc020a498 <sfs_truncfile+0x166>
ffffffffc020a47e:	2485                	addiw	s1,s1,1
ffffffffc020a480:	fe9417e3          	bne	s0,s1,ffffffffc020a46e <sfs_truncfile+0x13c>
ffffffffc020a484:	008aa483          	lw	s1,8(s5)
ffffffffc020a488:	0a941b63          	bne	s0,s1,ffffffffc020a53e <sfs_truncfile+0x20c>
ffffffffc020a48c:	014aa023          	sw	s4,0(s5)
ffffffffc020a490:	4785                	li	a5,1
ffffffffc020a492:	00f9b823          	sd	a5,16(s3)
ffffffffc020a496:	4901                	li	s2,0
ffffffffc020a498:	855a                	mv	a0,s6
ffffffffc020a49a:	8cafa0ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020a49e:	bddd                	j	ffffffffc020a394 <sfs_truncfile+0x62>
ffffffffc020a4a0:	86e2                	mv	a3,s8
ffffffffc020a4a2:	4611                	li	a2,4
ffffffffc020a4a4:	086c                	addi	a1,sp,28
ffffffffc020a4a6:	8566                	mv	a0,s9
ffffffffc020a4a8:	21b000ef          	jal	ra,ffffffffc020aec2 <sfs_wbuf>
ffffffffc020a4ac:	892a                	mv	s2,a0
ffffffffc020a4ae:	f56d                	bnez	a0,ffffffffc020a498 <sfs_truncfile+0x166>
ffffffffc020a4b0:	45e2                	lw	a1,24(sp)
ffffffffc020a4b2:	8566                	mv	a0,s9
ffffffffc020a4b4:	b9eff0ef          	jal	ra,ffffffffc0209852 <sfs_block_free>
ffffffffc020a4b8:	b7a5                	j	ffffffffc020a420 <sfs_truncfile+0xee>
ffffffffc020a4ba:	5975                	li	s2,-3
ffffffffc020a4bc:	bde1                	j	ffffffffc020a394 <sfs_truncfile+0x62>
ffffffffc020a4be:	00005697          	auipc	a3,0x5
ffffffffc020a4c2:	93268693          	addi	a3,a3,-1742 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc020a4c6:	00001617          	auipc	a2,0x1
ffffffffc020a4ca:	5e260613          	addi	a2,a2,1506 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a4ce:	3d500593          	li	a1,981
ffffffffc020a4d2:	00005517          	auipc	a0,0x5
ffffffffc020a4d6:	afe50513          	addi	a0,a0,-1282 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a4da:	fc5f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a4de:	00005697          	auipc	a3,0x5
ffffffffc020a4e2:	aba68693          	addi	a3,a3,-1350 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc020a4e6:	00001617          	auipc	a2,0x1
ffffffffc020a4ea:	5c260613          	addi	a2,a2,1474 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a4ee:	3d600593          	li	a1,982
ffffffffc020a4f2:	00005517          	auipc	a0,0x5
ffffffffc020a4f6:	ade50513          	addi	a0,a0,-1314 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a4fa:	fa5f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a4fe:	00005697          	auipc	a3,0x5
ffffffffc020a502:	cf268693          	addi	a3,a3,-782 # ffffffffc020f1f0 <dev_node_ops+0x7e0>
ffffffffc020a506:	00001617          	auipc	a2,0x1
ffffffffc020a50a:	5a260613          	addi	a2,a2,1442 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a50e:	17b00593          	li	a1,379
ffffffffc020a512:	00005517          	auipc	a0,0x5
ffffffffc020a516:	abe50513          	addi	a0,a0,-1346 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a51a:	f85f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a51e:	00005697          	auipc	a3,0x5
ffffffffc020a522:	cba68693          	addi	a3,a3,-838 # ffffffffc020f1d8 <dev_node_ops+0x7c8>
ffffffffc020a526:	00001617          	auipc	a2,0x1
ffffffffc020a52a:	58260613          	addi	a2,a2,1410 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a52e:	3dd00593          	li	a1,989
ffffffffc020a532:	00005517          	auipc	a0,0x5
ffffffffc020a536:	a9e50513          	addi	a0,a0,-1378 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a53a:	f65f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a53e:	00005697          	auipc	a3,0x5
ffffffffc020a542:	d0268693          	addi	a3,a3,-766 # ffffffffc020f240 <dev_node_ops+0x830>
ffffffffc020a546:	00001617          	auipc	a2,0x1
ffffffffc020a54a:	56260613          	addi	a2,a2,1378 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a54e:	3f600593          	li	a1,1014
ffffffffc020a552:	00005517          	auipc	a0,0x5
ffffffffc020a556:	a7e50513          	addi	a0,a0,-1410 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a55a:	f45f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a55e:	00005697          	auipc	a3,0x5
ffffffffc020a562:	caa68693          	addi	a3,a3,-854 # ffffffffc020f208 <dev_node_ops+0x7f8>
ffffffffc020a566:	00001617          	auipc	a2,0x1
ffffffffc020a56a:	54260613          	addi	a2,a2,1346 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a56e:	12b00593          	li	a1,299
ffffffffc020a572:	00005517          	auipc	a0,0x5
ffffffffc020a576:	a5e50513          	addi	a0,a0,-1442 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a57a:	f25f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a57e:	8762                	mv	a4,s8
ffffffffc020a580:	86be                	mv	a3,a5
ffffffffc020a582:	00005617          	auipc	a2,0x5
ffffffffc020a586:	a7e60613          	addi	a2,a2,-1410 # ffffffffc020f000 <dev_node_ops+0x5f0>
ffffffffc020a58a:	05300593          	li	a1,83
ffffffffc020a58e:	00005517          	auipc	a0,0x5
ffffffffc020a592:	a4250513          	addi	a0,a0,-1470 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a596:	f09f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a59a <sfs_load_inode>:
ffffffffc020a59a:	7139                	addi	sp,sp,-64
ffffffffc020a59c:	fc06                	sd	ra,56(sp)
ffffffffc020a59e:	f822                	sd	s0,48(sp)
ffffffffc020a5a0:	f426                	sd	s1,40(sp)
ffffffffc020a5a2:	f04a                	sd	s2,32(sp)
ffffffffc020a5a4:	84b2                	mv	s1,a2
ffffffffc020a5a6:	892a                	mv	s2,a0
ffffffffc020a5a8:	ec4e                	sd	s3,24(sp)
ffffffffc020a5aa:	e852                	sd	s4,16(sp)
ffffffffc020a5ac:	89ae                	mv	s3,a1
ffffffffc020a5ae:	e456                	sd	s5,8(sp)
ffffffffc020a5b0:	2c3000ef          	jal	ra,ffffffffc020b072 <lock_sfs_fs>
ffffffffc020a5b4:	45a9                	li	a1,10
ffffffffc020a5b6:	8526                	mv	a0,s1
ffffffffc020a5b8:	0a893403          	ld	s0,168(s2)
ffffffffc020a5bc:	2d7000ef          	jal	ra,ffffffffc020b092 <hash32>
ffffffffc020a5c0:	02051793          	slli	a5,a0,0x20
ffffffffc020a5c4:	01c7d713          	srli	a4,a5,0x1c
ffffffffc020a5c8:	9722                	add	a4,a4,s0
ffffffffc020a5ca:	843a                	mv	s0,a4
ffffffffc020a5cc:	a029                	j	ffffffffc020a5d6 <sfs_load_inode+0x3c>
ffffffffc020a5ce:	fc042783          	lw	a5,-64(s0)
ffffffffc020a5d2:	10978863          	beq	a5,s1,ffffffffc020a6e2 <sfs_load_inode+0x148>
ffffffffc020a5d6:	6400                	ld	s0,8(s0)
ffffffffc020a5d8:	fe871be3          	bne	a4,s0,ffffffffc020a5ce <sfs_load_inode+0x34>
ffffffffc020a5dc:	04000513          	li	a0,64
ffffffffc020a5e0:	9b3f70ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc020a5e4:	8aaa                	mv	s5,a0
ffffffffc020a5e6:	16050563          	beqz	a0,ffffffffc020a750 <sfs_load_inode+0x1b6>
ffffffffc020a5ea:	00492683          	lw	a3,4(s2)
ffffffffc020a5ee:	18048363          	beqz	s1,ffffffffc020a774 <sfs_load_inode+0x1da>
ffffffffc020a5f2:	18d4f163          	bgeu	s1,a3,ffffffffc020a774 <sfs_load_inode+0x1da>
ffffffffc020a5f6:	03893503          	ld	a0,56(s2)
ffffffffc020a5fa:	85a6                	mv	a1,s1
ffffffffc020a5fc:	949fe0ef          	jal	ra,ffffffffc0208f44 <bitmap_test>
ffffffffc020a600:	18051763          	bnez	a0,ffffffffc020a78e <sfs_load_inode+0x1f4>
ffffffffc020a604:	4701                	li	a4,0
ffffffffc020a606:	86a6                	mv	a3,s1
ffffffffc020a608:	04000613          	li	a2,64
ffffffffc020a60c:	85d6                	mv	a1,s5
ffffffffc020a60e:	854a                	mv	a0,s2
ffffffffc020a610:	033000ef          	jal	ra,ffffffffc020ae42 <sfs_rbuf>
ffffffffc020a614:	842a                	mv	s0,a0
ffffffffc020a616:	0e051563          	bnez	a0,ffffffffc020a700 <sfs_load_inode+0x166>
ffffffffc020a61a:	006ad783          	lhu	a5,6(s5)
ffffffffc020a61e:	12078b63          	beqz	a5,ffffffffc020a754 <sfs_load_inode+0x1ba>
ffffffffc020a622:	6405                	lui	s0,0x1
ffffffffc020a624:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a628:	8d6fd0ef          	jal	ra,ffffffffc02076fe <__alloc_inode>
ffffffffc020a62c:	8a2a                	mv	s4,a0
ffffffffc020a62e:	c961                	beqz	a0,ffffffffc020a6fe <sfs_load_inode+0x164>
ffffffffc020a630:	004ad683          	lhu	a3,4(s5)
ffffffffc020a634:	4785                	li	a5,1
ffffffffc020a636:	0cf69c63          	bne	a3,a5,ffffffffc020a70e <sfs_load_inode+0x174>
ffffffffc020a63a:	864a                	mv	a2,s2
ffffffffc020a63c:	00005597          	auipc	a1,0x5
ffffffffc020a640:	d1458593          	addi	a1,a1,-748 # ffffffffc020f350 <sfs_node_fileops>
ffffffffc020a644:	8d6fd0ef          	jal	ra,ffffffffc020771a <inode_init>
ffffffffc020a648:	058a2783          	lw	a5,88(s4)
ffffffffc020a64c:	23540413          	addi	s0,s0,565
ffffffffc020a650:	0e879063          	bne	a5,s0,ffffffffc020a730 <sfs_load_inode+0x196>
ffffffffc020a654:	4785                	li	a5,1
ffffffffc020a656:	00fa2c23          	sw	a5,24(s4)
ffffffffc020a65a:	015a3023          	sd	s5,0(s4)
ffffffffc020a65e:	009a2423          	sw	s1,8(s4)
ffffffffc020a662:	000a3823          	sd	zero,16(s4)
ffffffffc020a666:	4585                	li	a1,1
ffffffffc020a668:	020a0513          	addi	a0,s4,32
ffffffffc020a66c:	ef3f90ef          	jal	ra,ffffffffc020455e <sem_init>
ffffffffc020a670:	058a2703          	lw	a4,88(s4)
ffffffffc020a674:	6785                	lui	a5,0x1
ffffffffc020a676:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a67a:	14f71663          	bne	a4,a5,ffffffffc020a7c6 <sfs_load_inode+0x22c>
ffffffffc020a67e:	0a093703          	ld	a4,160(s2)
ffffffffc020a682:	038a0793          	addi	a5,s4,56
ffffffffc020a686:	008a2503          	lw	a0,8(s4)
ffffffffc020a68a:	e31c                	sd	a5,0(a4)
ffffffffc020a68c:	0af93023          	sd	a5,160(s2)
ffffffffc020a690:	09890793          	addi	a5,s2,152
ffffffffc020a694:	0a893403          	ld	s0,168(s2)
ffffffffc020a698:	45a9                	li	a1,10
ffffffffc020a69a:	04ea3023          	sd	a4,64(s4)
ffffffffc020a69e:	02fa3c23          	sd	a5,56(s4)
ffffffffc020a6a2:	1f1000ef          	jal	ra,ffffffffc020b092 <hash32>
ffffffffc020a6a6:	02051713          	slli	a4,a0,0x20
ffffffffc020a6aa:	01c75793          	srli	a5,a4,0x1c
ffffffffc020a6ae:	97a2                	add	a5,a5,s0
ffffffffc020a6b0:	6798                	ld	a4,8(a5)
ffffffffc020a6b2:	048a0693          	addi	a3,s4,72
ffffffffc020a6b6:	e314                	sd	a3,0(a4)
ffffffffc020a6b8:	e794                	sd	a3,8(a5)
ffffffffc020a6ba:	04ea3823          	sd	a4,80(s4)
ffffffffc020a6be:	04fa3423          	sd	a5,72(s4)
ffffffffc020a6c2:	854a                	mv	a0,s2
ffffffffc020a6c4:	1bf000ef          	jal	ra,ffffffffc020b082 <unlock_sfs_fs>
ffffffffc020a6c8:	4401                	li	s0,0
ffffffffc020a6ca:	0149b023          	sd	s4,0(s3)
ffffffffc020a6ce:	70e2                	ld	ra,56(sp)
ffffffffc020a6d0:	8522                	mv	a0,s0
ffffffffc020a6d2:	7442                	ld	s0,48(sp)
ffffffffc020a6d4:	74a2                	ld	s1,40(sp)
ffffffffc020a6d6:	7902                	ld	s2,32(sp)
ffffffffc020a6d8:	69e2                	ld	s3,24(sp)
ffffffffc020a6da:	6a42                	ld	s4,16(sp)
ffffffffc020a6dc:	6aa2                	ld	s5,8(sp)
ffffffffc020a6de:	6121                	addi	sp,sp,64
ffffffffc020a6e0:	8082                	ret
ffffffffc020a6e2:	fb840a13          	addi	s4,s0,-72
ffffffffc020a6e6:	8552                	mv	a0,s4
ffffffffc020a6e8:	894fd0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc020a6ec:	4785                	li	a5,1
ffffffffc020a6ee:	fcf51ae3          	bne	a0,a5,ffffffffc020a6c2 <sfs_load_inode+0x128>
ffffffffc020a6f2:	fd042783          	lw	a5,-48(s0)
ffffffffc020a6f6:	2785                	addiw	a5,a5,1
ffffffffc020a6f8:	fcf42823          	sw	a5,-48(s0)
ffffffffc020a6fc:	b7d9                	j	ffffffffc020a6c2 <sfs_load_inode+0x128>
ffffffffc020a6fe:	5471                	li	s0,-4
ffffffffc020a700:	8556                	mv	a0,s5
ffffffffc020a702:	941f70ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc020a706:	854a                	mv	a0,s2
ffffffffc020a708:	17b000ef          	jal	ra,ffffffffc020b082 <unlock_sfs_fs>
ffffffffc020a70c:	b7c9                	j	ffffffffc020a6ce <sfs_load_inode+0x134>
ffffffffc020a70e:	4789                	li	a5,2
ffffffffc020a710:	08f69f63          	bne	a3,a5,ffffffffc020a7ae <sfs_load_inode+0x214>
ffffffffc020a714:	864a                	mv	a2,s2
ffffffffc020a716:	00005597          	auipc	a1,0x5
ffffffffc020a71a:	bba58593          	addi	a1,a1,-1094 # ffffffffc020f2d0 <sfs_node_dirops>
ffffffffc020a71e:	ffdfc0ef          	jal	ra,ffffffffc020771a <inode_init>
ffffffffc020a722:	058a2703          	lw	a4,88(s4)
ffffffffc020a726:	6785                	lui	a5,0x1
ffffffffc020a728:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a72c:	f2f704e3          	beq	a4,a5,ffffffffc020a654 <sfs_load_inode+0xba>
ffffffffc020a730:	00005697          	auipc	a3,0x5
ffffffffc020a734:	86868693          	addi	a3,a3,-1944 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc020a738:	00001617          	auipc	a2,0x1
ffffffffc020a73c:	37060613          	addi	a2,a2,880 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a740:	07700593          	li	a1,119
ffffffffc020a744:	00005517          	auipc	a0,0x5
ffffffffc020a748:	88c50513          	addi	a0,a0,-1908 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a74c:	d53f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a750:	5471                	li	s0,-4
ffffffffc020a752:	bf55                	j	ffffffffc020a706 <sfs_load_inode+0x16c>
ffffffffc020a754:	00005697          	auipc	a3,0x5
ffffffffc020a758:	b0468693          	addi	a3,a3,-1276 # ffffffffc020f258 <dev_node_ops+0x848>
ffffffffc020a75c:	00001617          	auipc	a2,0x1
ffffffffc020a760:	34c60613          	addi	a2,a2,844 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a764:	0ad00593          	li	a1,173
ffffffffc020a768:	00005517          	auipc	a0,0x5
ffffffffc020a76c:	86850513          	addi	a0,a0,-1944 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a770:	d2ff50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a774:	8726                	mv	a4,s1
ffffffffc020a776:	00005617          	auipc	a2,0x5
ffffffffc020a77a:	88a60613          	addi	a2,a2,-1910 # ffffffffc020f000 <dev_node_ops+0x5f0>
ffffffffc020a77e:	05300593          	li	a1,83
ffffffffc020a782:	00005517          	auipc	a0,0x5
ffffffffc020a786:	84e50513          	addi	a0,a0,-1970 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a78a:	d15f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a78e:	00005697          	auipc	a3,0x5
ffffffffc020a792:	8aa68693          	addi	a3,a3,-1878 # ffffffffc020f038 <dev_node_ops+0x628>
ffffffffc020a796:	00001617          	auipc	a2,0x1
ffffffffc020a79a:	31260613          	addi	a2,a2,786 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a79e:	0a800593          	li	a1,168
ffffffffc020a7a2:	00005517          	auipc	a0,0x5
ffffffffc020a7a6:	82e50513          	addi	a0,a0,-2002 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a7aa:	cf5f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a7ae:	00005617          	auipc	a2,0x5
ffffffffc020a7b2:	83a60613          	addi	a2,a2,-1990 # ffffffffc020efe8 <dev_node_ops+0x5d8>
ffffffffc020a7b6:	02e00593          	li	a1,46
ffffffffc020a7ba:	00005517          	auipc	a0,0x5
ffffffffc020a7be:	81650513          	addi	a0,a0,-2026 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a7c2:	cddf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a7c6:	00004697          	auipc	a3,0x4
ffffffffc020a7ca:	7d268693          	addi	a3,a3,2002 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc020a7ce:	00001617          	auipc	a2,0x1
ffffffffc020a7d2:	2da60613          	addi	a2,a2,730 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a7d6:	0b100593          	li	a1,177
ffffffffc020a7da:	00004517          	auipc	a0,0x4
ffffffffc020a7de:	7f650513          	addi	a0,a0,2038 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a7e2:	cbdf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a7e6 <sfs_create>:
ffffffffc020a7e6:	7159                	addi	sp,sp,-112
ffffffffc020a7e8:	e4ce                	sd	s3,72(sp)
ffffffffc020a7ea:	06853983          	ld	s3,104(a0)
ffffffffc020a7ee:	f486                	sd	ra,104(sp)
ffffffffc020a7f0:	f0a2                	sd	s0,96(sp)
ffffffffc020a7f2:	eca6                	sd	s1,88(sp)
ffffffffc020a7f4:	e8ca                	sd	s2,80(sp)
ffffffffc020a7f6:	e0d2                	sd	s4,64(sp)
ffffffffc020a7f8:	fc56                	sd	s5,56(sp)
ffffffffc020a7fa:	f85a                	sd	s6,48(sp)
ffffffffc020a7fc:	f45e                	sd	s7,40(sp)
ffffffffc020a7fe:	16098563          	beqz	s3,ffffffffc020a968 <sfs_create+0x182>
ffffffffc020a802:	0b09a783          	lw	a5,176(s3)
ffffffffc020a806:	16079163          	bnez	a5,ffffffffc020a968 <sfs_create+0x182>
ffffffffc020a80a:	4d38                	lw	a4,88(a0)
ffffffffc020a80c:	6785                	lui	a5,0x1
ffffffffc020a80e:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a812:	84aa                	mv	s1,a0
ffffffffc020a814:	16f71a63          	bne	a4,a5,ffffffffc020a988 <sfs_create+0x1a2>
ffffffffc020a818:	852e                	mv	a0,a1
ffffffffc020a81a:	892e                	mv	s2,a1
ffffffffc020a81c:	8b32                	mv	s6,a2
ffffffffc020a81e:	8a36                	mv	s4,a3
ffffffffc020a820:	505000ef          	jal	ra,ffffffffc020b524 <strlen>
ffffffffc020a824:	0ff00793          	li	a5,255
ffffffffc020a828:	12a7e163          	bltu	a5,a0,ffffffffc020a94a <sfs_create+0x164>
ffffffffc020a82c:	02048a93          	addi	s5,s1,32
ffffffffc020a830:	8556                	mv	a0,s5
ffffffffc020a832:	d37f90ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc020a836:	007c                	addi	a5,sp,12
ffffffffc020a838:	0038                	addi	a4,sp,8
ffffffffc020a83a:	0814                	addi	a3,sp,16
ffffffffc020a83c:	864a                	mv	a2,s2
ffffffffc020a83e:	85a6                	mv	a1,s1
ffffffffc020a840:	854e                	mv	a0,s3
ffffffffc020a842:	a09ff0ef          	jal	ra,ffffffffc020a24a <sfs_dirent_search_nolock>
ffffffffc020a846:	57c1                	li	a5,-16
ffffffffc020a848:	842a                	mv	s0,a0
ffffffffc020a84a:	02f50c63          	beq	a0,a5,ffffffffc020a882 <sfs_create+0x9c>
ffffffffc020a84e:	c105                	beqz	a0,ffffffffc020a86e <sfs_create+0x88>
ffffffffc020a850:	8556                	mv	a0,s5
ffffffffc020a852:	d13f90ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020a856:	70a6                	ld	ra,104(sp)
ffffffffc020a858:	8522                	mv	a0,s0
ffffffffc020a85a:	7406                	ld	s0,96(sp)
ffffffffc020a85c:	64e6                	ld	s1,88(sp)
ffffffffc020a85e:	6946                	ld	s2,80(sp)
ffffffffc020a860:	69a6                	ld	s3,72(sp)
ffffffffc020a862:	6a06                	ld	s4,64(sp)
ffffffffc020a864:	7ae2                	ld	s5,56(sp)
ffffffffc020a866:	7b42                	ld	s6,48(sp)
ffffffffc020a868:	7ba2                	ld	s7,40(sp)
ffffffffc020a86a:	6165                	addi	sp,sp,112
ffffffffc020a86c:	8082                	ret
ffffffffc020a86e:	5425                	li	s0,-23
ffffffffc020a870:	fe0b10e3          	bnez	s6,ffffffffc020a850 <sfs_create+0x6a>
ffffffffc020a874:	4642                	lw	a2,16(sp)
ffffffffc020a876:	85d2                	mv	a1,s4
ffffffffc020a878:	854e                	mv	a0,s3
ffffffffc020a87a:	d21ff0ef          	jal	ra,ffffffffc020a59a <sfs_load_inode>
ffffffffc020a87e:	842a                	mv	s0,a0
ffffffffc020a880:	bfc1                	j	ffffffffc020a850 <sfs_create+0x6a>
ffffffffc020a882:	080c                	addi	a1,sp,16
ffffffffc020a884:	854e                	mv	a0,s3
ffffffffc020a886:	9deff0ef          	jal	ra,ffffffffc0209a64 <sfs_block_alloc>
ffffffffc020a88a:	842a                	mv	s0,a0
ffffffffc020a88c:	f171                	bnez	a0,ffffffffc020a850 <sfs_create+0x6a>
ffffffffc020a88e:	04000513          	li	a0,64
ffffffffc020a892:	f00f70ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc020a896:	8b2a                	mv	s6,a0
ffffffffc020a898:	c95d                	beqz	a0,ffffffffc020a94e <sfs_create+0x168>
ffffffffc020a89a:	04000613          	li	a2,64
ffffffffc020a89e:	4581                	li	a1,0
ffffffffc020a8a0:	527000ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc020a8a4:	46c2                	lw	a3,16(sp)
ffffffffc020a8a6:	67c1                	lui	a5,0x10
ffffffffc020a8a8:	0785                	addi	a5,a5,1
ffffffffc020a8aa:	00fb2223          	sw	a5,4(s6)
ffffffffc020a8ae:	4701                	li	a4,0
ffffffffc020a8b0:	04000613          	li	a2,64
ffffffffc020a8b4:	85da                	mv	a1,s6
ffffffffc020a8b6:	854e                	mv	a0,s3
ffffffffc020a8b8:	60a000ef          	jal	ra,ffffffffc020aec2 <sfs_wbuf>
ffffffffc020a8bc:	842a                	mv	s0,a0
ffffffffc020a8be:	855a                	mv	a0,s6
ffffffffc020a8c0:	f82f70ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc020a8c4:	ec35                	bnez	s0,ffffffffc020a940 <sfs_create+0x15a>
ffffffffc020a8c6:	4642                	lw	a2,16(sp)
ffffffffc020a8c8:	082c                	addi	a1,sp,24
ffffffffc020a8ca:	854e                	mv	a0,s3
ffffffffc020a8cc:	ccfff0ef          	jal	ra,ffffffffc020a59a <sfs_load_inode>
ffffffffc020a8d0:	842a                	mv	s0,a0
ffffffffc020a8d2:	e53d                	bnez	a0,ffffffffc020a940 <sfs_create+0x15a>
ffffffffc020a8d4:	6462                	ld	s0,24(sp)
ffffffffc020a8d6:	0c040b63          	beqz	s0,ffffffffc020a9ac <sfs_create+0x1c6>
ffffffffc020a8da:	4c38                	lw	a4,88(s0)
ffffffffc020a8dc:	6785                	lui	a5,0x1
ffffffffc020a8de:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a8e2:	0cf71563          	bne	a4,a5,ffffffffc020a9ac <sfs_create+0x1c6>
ffffffffc020a8e6:	10400513          	li	a0,260
ffffffffc020a8ea:	4bb2                	lw	s7,12(sp)
ffffffffc020a8ec:	ea6f70ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc020a8f0:	8b2a                	mv	s6,a0
ffffffffc020a8f2:	c95d                	beqz	a0,ffffffffc020a9a8 <sfs_create+0x1c2>
ffffffffc020a8f4:	10400613          	li	a2,260
ffffffffc020a8f8:	4581                	li	a1,0
ffffffffc020a8fa:	4cd000ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc020a8fe:	441c                	lw	a5,8(s0)
ffffffffc020a900:	85ca                	mv	a1,s2
ffffffffc020a902:	004b0513          	addi	a0,s6,4
ffffffffc020a906:	00fb2023          	sw	a5,0(s6)
ffffffffc020a90a:	451000ef          	jal	ra,ffffffffc020b55a <strcpy>
ffffffffc020a90e:	0854                	addi	a3,sp,20
ffffffffc020a910:	865e                	mv	a2,s7
ffffffffc020a912:	85a6                	mv	a1,s1
ffffffffc020a914:	854e                	mv	a0,s3
ffffffffc020a916:	9f6ff0ef          	jal	ra,ffffffffc0209b0c <sfs_bmap_load_nolock>
ffffffffc020a91a:	842a                	mv	s0,a0
ffffffffc020a91c:	ed1d                	bnez	a0,ffffffffc020a95a <sfs_create+0x174>
ffffffffc020a91e:	46d2                	lw	a3,20(sp)
ffffffffc020a920:	4701                	li	a4,0
ffffffffc020a922:	10400613          	li	a2,260
ffffffffc020a926:	85da                	mv	a1,s6
ffffffffc020a928:	854e                	mv	a0,s3
ffffffffc020a92a:	598000ef          	jal	ra,ffffffffc020aec2 <sfs_wbuf>
ffffffffc020a92e:	842a                	mv	s0,a0
ffffffffc020a930:	855a                	mv	a0,s6
ffffffffc020a932:	f10f70ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc020a936:	e40d                	bnez	s0,ffffffffc020a960 <sfs_create+0x17a>
ffffffffc020a938:	67e2                	ld	a5,24(sp)
ffffffffc020a93a:	00fa3023          	sd	a5,0(s4)
ffffffffc020a93e:	bf09                	j	ffffffffc020a850 <sfs_create+0x6a>
ffffffffc020a940:	45c2                	lw	a1,16(sp)
ffffffffc020a942:	854e                	mv	a0,s3
ffffffffc020a944:	f0ffe0ef          	jal	ra,ffffffffc0209852 <sfs_block_free>
ffffffffc020a948:	b721                	j	ffffffffc020a850 <sfs_create+0x6a>
ffffffffc020a94a:	5451                	li	s0,-12
ffffffffc020a94c:	b729                	j	ffffffffc020a856 <sfs_create+0x70>
ffffffffc020a94e:	45c2                	lw	a1,16(sp)
ffffffffc020a950:	854e                	mv	a0,s3
ffffffffc020a952:	5471                	li	s0,-4
ffffffffc020a954:	efffe0ef          	jal	ra,ffffffffc0209852 <sfs_block_free>
ffffffffc020a958:	bde5                	j	ffffffffc020a850 <sfs_create+0x6a>
ffffffffc020a95a:	855a                	mv	a0,s6
ffffffffc020a95c:	ee6f70ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc020a960:	6562                	ld	a0,24(sp)
ffffffffc020a962:	ee9fc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020a966:	b5ed                	j	ffffffffc020a850 <sfs_create+0x6a>
ffffffffc020a968:	00004697          	auipc	a3,0x4
ffffffffc020a96c:	48868693          	addi	a3,a3,1160 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc020a970:	00001617          	auipc	a2,0x1
ffffffffc020a974:	13860613          	addi	a2,a2,312 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a978:	40400593          	li	a1,1028
ffffffffc020a97c:	00004517          	auipc	a0,0x4
ffffffffc020a980:	65450513          	addi	a0,a0,1620 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a984:	b1bf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a988:	00004697          	auipc	a3,0x4
ffffffffc020a98c:	61068693          	addi	a3,a3,1552 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc020a990:	00001617          	auipc	a2,0x1
ffffffffc020a994:	11860613          	addi	a2,a2,280 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a998:	40500593          	li	a1,1029
ffffffffc020a99c:	00004517          	auipc	a0,0x4
ffffffffc020a9a0:	63450513          	addi	a0,a0,1588 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a9a4:	afbf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a9a8:	5471                	li	s0,-4
ffffffffc020a9aa:	bf5d                	j	ffffffffc020a960 <sfs_create+0x17a>
ffffffffc020a9ac:	00004697          	auipc	a3,0x4
ffffffffc020a9b0:	5ec68693          	addi	a3,a3,1516 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc020a9b4:	00001617          	auipc	a2,0x1
ffffffffc020a9b8:	0f460613          	addi	a2,a2,244 # ffffffffc020baa8 <commands+0x210>
ffffffffc020a9bc:	42a00593          	li	a1,1066
ffffffffc020a9c0:	00004517          	auipc	a0,0x4
ffffffffc020a9c4:	61050513          	addi	a0,a0,1552 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020a9c8:	ad7f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a9cc <sfs_lookup>:
ffffffffc020a9cc:	7139                	addi	sp,sp,-64
ffffffffc020a9ce:	ec4e                	sd	s3,24(sp)
ffffffffc020a9d0:	06853983          	ld	s3,104(a0)
ffffffffc020a9d4:	fc06                	sd	ra,56(sp)
ffffffffc020a9d6:	f822                	sd	s0,48(sp)
ffffffffc020a9d8:	f426                	sd	s1,40(sp)
ffffffffc020a9da:	f04a                	sd	s2,32(sp)
ffffffffc020a9dc:	e852                	sd	s4,16(sp)
ffffffffc020a9de:	0a098e63          	beqz	s3,ffffffffc020aa9a <sfs_lookup+0xce>
ffffffffc020a9e2:	0b09a783          	lw	a5,176(s3)
ffffffffc020a9e6:	ebd5                	bnez	a5,ffffffffc020aa9a <sfs_lookup+0xce>
ffffffffc020a9e8:	0005c783          	lbu	a5,0(a1)
ffffffffc020a9ec:	84ae                	mv	s1,a1
ffffffffc020a9ee:	c7d1                	beqz	a5,ffffffffc020aa7a <sfs_lookup+0xae>
ffffffffc020a9f0:	02f00713          	li	a4,47
ffffffffc020a9f4:	08e78363          	beq	a5,a4,ffffffffc020aa7a <sfs_lookup+0xae>
ffffffffc020a9f8:	842a                	mv	s0,a0
ffffffffc020a9fa:	8a32                	mv	s4,a2
ffffffffc020a9fc:	d81fc0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc020aa00:	4c38                	lw	a4,88(s0)
ffffffffc020aa02:	6785                	lui	a5,0x1
ffffffffc020aa04:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020aa08:	0af71963          	bne	a4,a5,ffffffffc020aaba <sfs_lookup+0xee>
ffffffffc020aa0c:	6018                	ld	a4,0(s0)
ffffffffc020aa0e:	4789                	li	a5,2
ffffffffc020aa10:	00475703          	lhu	a4,4(a4)
ffffffffc020aa14:	04f71e63          	bne	a4,a5,ffffffffc020aa70 <sfs_lookup+0xa4>
ffffffffc020aa18:	02040913          	addi	s2,s0,32
ffffffffc020aa1c:	854a                	mv	a0,s2
ffffffffc020aa1e:	b4bf90ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc020aa22:	8626                	mv	a2,s1
ffffffffc020aa24:	4781                	li	a5,0
ffffffffc020aa26:	4701                	li	a4,0
ffffffffc020aa28:	0054                	addi	a3,sp,4
ffffffffc020aa2a:	85a2                	mv	a1,s0
ffffffffc020aa2c:	854e                	mv	a0,s3
ffffffffc020aa2e:	81dff0ef          	jal	ra,ffffffffc020a24a <sfs_dirent_search_nolock>
ffffffffc020aa32:	84aa                	mv	s1,a0
ffffffffc020aa34:	854a                	mv	a0,s2
ffffffffc020aa36:	b2ff90ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020aa3a:	cc89                	beqz	s1,ffffffffc020aa54 <sfs_lookup+0x88>
ffffffffc020aa3c:	8522                	mv	a0,s0
ffffffffc020aa3e:	e0dfc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020aa42:	70e2                	ld	ra,56(sp)
ffffffffc020aa44:	7442                	ld	s0,48(sp)
ffffffffc020aa46:	7902                	ld	s2,32(sp)
ffffffffc020aa48:	69e2                	ld	s3,24(sp)
ffffffffc020aa4a:	6a42                	ld	s4,16(sp)
ffffffffc020aa4c:	8526                	mv	a0,s1
ffffffffc020aa4e:	74a2                	ld	s1,40(sp)
ffffffffc020aa50:	6121                	addi	sp,sp,64
ffffffffc020aa52:	8082                	ret
ffffffffc020aa54:	4612                	lw	a2,4(sp)
ffffffffc020aa56:	002c                	addi	a1,sp,8
ffffffffc020aa58:	854e                	mv	a0,s3
ffffffffc020aa5a:	b41ff0ef          	jal	ra,ffffffffc020a59a <sfs_load_inode>
ffffffffc020aa5e:	84aa                	mv	s1,a0
ffffffffc020aa60:	8522                	mv	a0,s0
ffffffffc020aa62:	de9fc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020aa66:	fcf1                	bnez	s1,ffffffffc020aa42 <sfs_lookup+0x76>
ffffffffc020aa68:	67a2                	ld	a5,8(sp)
ffffffffc020aa6a:	00fa3023          	sd	a5,0(s4)
ffffffffc020aa6e:	bfd1                	j	ffffffffc020aa42 <sfs_lookup+0x76>
ffffffffc020aa70:	8522                	mv	a0,s0
ffffffffc020aa72:	dd9fc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020aa76:	54b9                	li	s1,-18
ffffffffc020aa78:	b7e9                	j	ffffffffc020aa42 <sfs_lookup+0x76>
ffffffffc020aa7a:	00004697          	auipc	a3,0x4
ffffffffc020aa7e:	7f668693          	addi	a3,a3,2038 # ffffffffc020f270 <dev_node_ops+0x860>
ffffffffc020aa82:	00001617          	auipc	a2,0x1
ffffffffc020aa86:	02660613          	addi	a2,a2,38 # ffffffffc020baa8 <commands+0x210>
ffffffffc020aa8a:	44800593          	li	a1,1096
ffffffffc020aa8e:	00004517          	auipc	a0,0x4
ffffffffc020aa92:	54250513          	addi	a0,a0,1346 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020aa96:	a09f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa9a:	00004697          	auipc	a3,0x4
ffffffffc020aa9e:	35668693          	addi	a3,a3,854 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc020aaa2:	00001617          	auipc	a2,0x1
ffffffffc020aaa6:	00660613          	addi	a2,a2,6 # ffffffffc020baa8 <commands+0x210>
ffffffffc020aaaa:	44700593          	li	a1,1095
ffffffffc020aaae:	00004517          	auipc	a0,0x4
ffffffffc020aab2:	52250513          	addi	a0,a0,1314 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020aab6:	9e9f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aaba:	00004697          	auipc	a3,0x4
ffffffffc020aabe:	4de68693          	addi	a3,a3,1246 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc020aac2:	00001617          	auipc	a2,0x1
ffffffffc020aac6:	fe660613          	addi	a2,a2,-26 # ffffffffc020baa8 <commands+0x210>
ffffffffc020aaca:	44a00593          	li	a1,1098
ffffffffc020aace:	00004517          	auipc	a0,0x4
ffffffffc020aad2:	50250513          	addi	a0,a0,1282 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020aad6:	9c9f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020aada <sfs_namefile>:
ffffffffc020aada:	6d98                	ld	a4,24(a1)
ffffffffc020aadc:	7175                	addi	sp,sp,-144
ffffffffc020aade:	e506                	sd	ra,136(sp)
ffffffffc020aae0:	e122                	sd	s0,128(sp)
ffffffffc020aae2:	fca6                	sd	s1,120(sp)
ffffffffc020aae4:	f8ca                	sd	s2,112(sp)
ffffffffc020aae6:	f4ce                	sd	s3,104(sp)
ffffffffc020aae8:	f0d2                	sd	s4,96(sp)
ffffffffc020aaea:	ecd6                	sd	s5,88(sp)
ffffffffc020aaec:	e8da                	sd	s6,80(sp)
ffffffffc020aaee:	e4de                	sd	s7,72(sp)
ffffffffc020aaf0:	e0e2                	sd	s8,64(sp)
ffffffffc020aaf2:	fc66                	sd	s9,56(sp)
ffffffffc020aaf4:	f86a                	sd	s10,48(sp)
ffffffffc020aaf6:	f46e                	sd	s11,40(sp)
ffffffffc020aaf8:	e42e                	sd	a1,8(sp)
ffffffffc020aafa:	4789                	li	a5,2
ffffffffc020aafc:	1ae7f563          	bgeu	a5,a4,ffffffffc020aca6 <sfs_namefile+0x1cc>
ffffffffc020ab00:	89aa                	mv	s3,a0
ffffffffc020ab02:	10400513          	li	a0,260
ffffffffc020ab06:	c8cf70ef          	jal	ra,ffffffffc0201f92 <kmalloc>
ffffffffc020ab0a:	842a                	mv	s0,a0
ffffffffc020ab0c:	18050d63          	beqz	a0,ffffffffc020aca6 <sfs_namefile+0x1cc>
ffffffffc020ab10:	0689b483          	ld	s1,104(s3)
ffffffffc020ab14:	1e048b63          	beqz	s1,ffffffffc020ad0a <sfs_namefile+0x230>
ffffffffc020ab18:	0b04a783          	lw	a5,176(s1)
ffffffffc020ab1c:	1e079763          	bnez	a5,ffffffffc020ad0a <sfs_namefile+0x230>
ffffffffc020ab20:	0589ac83          	lw	s9,88(s3)
ffffffffc020ab24:	6785                	lui	a5,0x1
ffffffffc020ab26:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020ab2a:	1cfc9063          	bne	s9,a5,ffffffffc020acea <sfs_namefile+0x210>
ffffffffc020ab2e:	6722                	ld	a4,8(sp)
ffffffffc020ab30:	854e                	mv	a0,s3
ffffffffc020ab32:	8ace                	mv	s5,s3
ffffffffc020ab34:	6f1c                	ld	a5,24(a4)
ffffffffc020ab36:	00073b03          	ld	s6,0(a4)
ffffffffc020ab3a:	02098a13          	addi	s4,s3,32
ffffffffc020ab3e:	ffe78b93          	addi	s7,a5,-2
ffffffffc020ab42:	9b3e                	add	s6,s6,a5
ffffffffc020ab44:	00004d17          	auipc	s10,0x4
ffffffffc020ab48:	74cd0d13          	addi	s10,s10,1868 # ffffffffc020f290 <dev_node_ops+0x880>
ffffffffc020ab4c:	c31fc0ef          	jal	ra,ffffffffc020777c <inode_ref_inc>
ffffffffc020ab50:	00440c13          	addi	s8,s0,4
ffffffffc020ab54:	e066                	sd	s9,0(sp)
ffffffffc020ab56:	8552                	mv	a0,s4
ffffffffc020ab58:	a11f90ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc020ab5c:	4781                	li	a5,0
ffffffffc020ab5e:	4701                	li	a4,0
ffffffffc020ab60:	0854                	addi	a3,sp,20
ffffffffc020ab62:	866a                	mv	a2,s10
ffffffffc020ab64:	85d6                	mv	a1,s5
ffffffffc020ab66:	8526                	mv	a0,s1
ffffffffc020ab68:	ee2ff0ef          	jal	ra,ffffffffc020a24a <sfs_dirent_search_nolock>
ffffffffc020ab6c:	8daa                	mv	s11,a0
ffffffffc020ab6e:	8552                	mv	a0,s4
ffffffffc020ab70:	9f5f90ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020ab74:	020d8863          	beqz	s11,ffffffffc020aba4 <sfs_namefile+0xca>
ffffffffc020ab78:	854e                	mv	a0,s3
ffffffffc020ab7a:	cd1fc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020ab7e:	8522                	mv	a0,s0
ffffffffc020ab80:	cc2f70ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc020ab84:	60aa                	ld	ra,136(sp)
ffffffffc020ab86:	640a                	ld	s0,128(sp)
ffffffffc020ab88:	74e6                	ld	s1,120(sp)
ffffffffc020ab8a:	7946                	ld	s2,112(sp)
ffffffffc020ab8c:	79a6                	ld	s3,104(sp)
ffffffffc020ab8e:	7a06                	ld	s4,96(sp)
ffffffffc020ab90:	6ae6                	ld	s5,88(sp)
ffffffffc020ab92:	6b46                	ld	s6,80(sp)
ffffffffc020ab94:	6ba6                	ld	s7,72(sp)
ffffffffc020ab96:	6c06                	ld	s8,64(sp)
ffffffffc020ab98:	7ce2                	ld	s9,56(sp)
ffffffffc020ab9a:	7d42                	ld	s10,48(sp)
ffffffffc020ab9c:	856e                	mv	a0,s11
ffffffffc020ab9e:	7da2                	ld	s11,40(sp)
ffffffffc020aba0:	6149                	addi	sp,sp,144
ffffffffc020aba2:	8082                	ret
ffffffffc020aba4:	4652                	lw	a2,20(sp)
ffffffffc020aba6:	082c                	addi	a1,sp,24
ffffffffc020aba8:	8526                	mv	a0,s1
ffffffffc020abaa:	9f1ff0ef          	jal	ra,ffffffffc020a59a <sfs_load_inode>
ffffffffc020abae:	8daa                	mv	s11,a0
ffffffffc020abb0:	f561                	bnez	a0,ffffffffc020ab78 <sfs_namefile+0x9e>
ffffffffc020abb2:	854e                	mv	a0,s3
ffffffffc020abb4:	008aa903          	lw	s2,8(s5)
ffffffffc020abb8:	c93fc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020abbc:	6ce2                	ld	s9,24(sp)
ffffffffc020abbe:	0b3c8463          	beq	s9,s3,ffffffffc020ac66 <sfs_namefile+0x18c>
ffffffffc020abc2:	100c8463          	beqz	s9,ffffffffc020acca <sfs_namefile+0x1f0>
ffffffffc020abc6:	058ca703          	lw	a4,88(s9)
ffffffffc020abca:	6782                	ld	a5,0(sp)
ffffffffc020abcc:	0ef71f63          	bne	a4,a5,ffffffffc020acca <sfs_namefile+0x1f0>
ffffffffc020abd0:	008ca703          	lw	a4,8(s9)
ffffffffc020abd4:	8ae6                	mv	s5,s9
ffffffffc020abd6:	0d270a63          	beq	a4,s2,ffffffffc020acaa <sfs_namefile+0x1d0>
ffffffffc020abda:	000cb703          	ld	a4,0(s9)
ffffffffc020abde:	4789                	li	a5,2
ffffffffc020abe0:	00475703          	lhu	a4,4(a4)
ffffffffc020abe4:	0cf71363          	bne	a4,a5,ffffffffc020acaa <sfs_namefile+0x1d0>
ffffffffc020abe8:	020c8a13          	addi	s4,s9,32
ffffffffc020abec:	8552                	mv	a0,s4
ffffffffc020abee:	97bf90ef          	jal	ra,ffffffffc0204568 <down>
ffffffffc020abf2:	000cb703          	ld	a4,0(s9)
ffffffffc020abf6:	00872983          	lw	s3,8(a4)
ffffffffc020abfa:	01304963          	bgtz	s3,ffffffffc020ac0c <sfs_namefile+0x132>
ffffffffc020abfe:	a899                	j	ffffffffc020ac54 <sfs_namefile+0x17a>
ffffffffc020ac00:	4018                	lw	a4,0(s0)
ffffffffc020ac02:	01270e63          	beq	a4,s2,ffffffffc020ac1e <sfs_namefile+0x144>
ffffffffc020ac06:	2d85                	addiw	s11,s11,1
ffffffffc020ac08:	05b98663          	beq	s3,s11,ffffffffc020ac54 <sfs_namefile+0x17a>
ffffffffc020ac0c:	86a2                	mv	a3,s0
ffffffffc020ac0e:	866e                	mv	a2,s11
ffffffffc020ac10:	85e6                	mv	a1,s9
ffffffffc020ac12:	8526                	mv	a0,s1
ffffffffc020ac14:	c38ff0ef          	jal	ra,ffffffffc020a04c <sfs_dirent_read_nolock>
ffffffffc020ac18:	872a                	mv	a4,a0
ffffffffc020ac1a:	d17d                	beqz	a0,ffffffffc020ac00 <sfs_namefile+0x126>
ffffffffc020ac1c:	a82d                	j	ffffffffc020ac56 <sfs_namefile+0x17c>
ffffffffc020ac1e:	8552                	mv	a0,s4
ffffffffc020ac20:	945f90ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020ac24:	8562                	mv	a0,s8
ffffffffc020ac26:	0ff000ef          	jal	ra,ffffffffc020b524 <strlen>
ffffffffc020ac2a:	00150793          	addi	a5,a0,1
ffffffffc020ac2e:	862a                	mv	a2,a0
ffffffffc020ac30:	06fbe863          	bltu	s7,a5,ffffffffc020aca0 <sfs_namefile+0x1c6>
ffffffffc020ac34:	fff64913          	not	s2,a2
ffffffffc020ac38:	995a                	add	s2,s2,s6
ffffffffc020ac3a:	85e2                	mv	a1,s8
ffffffffc020ac3c:	854a                	mv	a0,s2
ffffffffc020ac3e:	40fb8bb3          	sub	s7,s7,a5
ffffffffc020ac42:	1d7000ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc020ac46:	02f00793          	li	a5,47
ffffffffc020ac4a:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc020ac4e:	89e6                	mv	s3,s9
ffffffffc020ac50:	8b4a                	mv	s6,s2
ffffffffc020ac52:	b711                	j	ffffffffc020ab56 <sfs_namefile+0x7c>
ffffffffc020ac54:	5741                	li	a4,-16
ffffffffc020ac56:	8552                	mv	a0,s4
ffffffffc020ac58:	e03a                	sd	a4,0(sp)
ffffffffc020ac5a:	90bf90ef          	jal	ra,ffffffffc0204564 <up>
ffffffffc020ac5e:	6702                	ld	a4,0(sp)
ffffffffc020ac60:	89e6                	mv	s3,s9
ffffffffc020ac62:	8dba                	mv	s11,a4
ffffffffc020ac64:	bf11                	j	ffffffffc020ab78 <sfs_namefile+0x9e>
ffffffffc020ac66:	854e                	mv	a0,s3
ffffffffc020ac68:	be3fc0ef          	jal	ra,ffffffffc020784a <inode_ref_dec>
ffffffffc020ac6c:	64a2                	ld	s1,8(sp)
ffffffffc020ac6e:	85da                	mv	a1,s6
ffffffffc020ac70:	6c98                	ld	a4,24(s1)
ffffffffc020ac72:	6088                	ld	a0,0(s1)
ffffffffc020ac74:	1779                	addi	a4,a4,-2
ffffffffc020ac76:	41770bb3          	sub	s7,a4,s7
ffffffffc020ac7a:	865e                	mv	a2,s7
ffffffffc020ac7c:	0505                	addi	a0,a0,1
ffffffffc020ac7e:	15b000ef          	jal	ra,ffffffffc020b5d8 <memmove>
ffffffffc020ac82:	02f00713          	li	a4,47
ffffffffc020ac86:	fee50fa3          	sb	a4,-1(a0)
ffffffffc020ac8a:	955e                	add	a0,a0,s7
ffffffffc020ac8c:	00050023          	sb	zero,0(a0)
ffffffffc020ac90:	85de                	mv	a1,s7
ffffffffc020ac92:	8526                	mv	a0,s1
ffffffffc020ac94:	fc8fa0ef          	jal	ra,ffffffffc020545c <iobuf_skip>
ffffffffc020ac98:	8522                	mv	a0,s0
ffffffffc020ac9a:	ba8f70ef          	jal	ra,ffffffffc0202042 <kfree>
ffffffffc020ac9e:	b5dd                	j	ffffffffc020ab84 <sfs_namefile+0xaa>
ffffffffc020aca0:	89e6                	mv	s3,s9
ffffffffc020aca2:	5df1                	li	s11,-4
ffffffffc020aca4:	bdd1                	j	ffffffffc020ab78 <sfs_namefile+0x9e>
ffffffffc020aca6:	5df1                	li	s11,-4
ffffffffc020aca8:	bdf1                	j	ffffffffc020ab84 <sfs_namefile+0xaa>
ffffffffc020acaa:	00004697          	auipc	a3,0x4
ffffffffc020acae:	5ee68693          	addi	a3,a3,1518 # ffffffffc020f298 <dev_node_ops+0x888>
ffffffffc020acb2:	00001617          	auipc	a2,0x1
ffffffffc020acb6:	df660613          	addi	a2,a2,-522 # ffffffffc020baa8 <commands+0x210>
ffffffffc020acba:	32500593          	li	a1,805
ffffffffc020acbe:	00004517          	auipc	a0,0x4
ffffffffc020acc2:	31250513          	addi	a0,a0,786 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020acc6:	fd8f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020acca:	00004697          	auipc	a3,0x4
ffffffffc020acce:	2ce68693          	addi	a3,a3,718 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc020acd2:	00001617          	auipc	a2,0x1
ffffffffc020acd6:	dd660613          	addi	a2,a2,-554 # ffffffffc020baa8 <commands+0x210>
ffffffffc020acda:	32400593          	li	a1,804
ffffffffc020acde:	00004517          	auipc	a0,0x4
ffffffffc020ace2:	2f250513          	addi	a0,a0,754 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020ace6:	fb8f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020acea:	00004697          	auipc	a3,0x4
ffffffffc020acee:	2ae68693          	addi	a3,a3,686 # ffffffffc020ef98 <dev_node_ops+0x588>
ffffffffc020acf2:	00001617          	auipc	a2,0x1
ffffffffc020acf6:	db660613          	addi	a2,a2,-586 # ffffffffc020baa8 <commands+0x210>
ffffffffc020acfa:	31100593          	li	a1,785
ffffffffc020acfe:	00004517          	auipc	a0,0x4
ffffffffc020ad02:	2d250513          	addi	a0,a0,722 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020ad06:	f98f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ad0a:	00004697          	auipc	a3,0x4
ffffffffc020ad0e:	0e668693          	addi	a3,a3,230 # ffffffffc020edf0 <dev_node_ops+0x3e0>
ffffffffc020ad12:	00001617          	auipc	a2,0x1
ffffffffc020ad16:	d9660613          	addi	a2,a2,-618 # ffffffffc020baa8 <commands+0x210>
ffffffffc020ad1a:	31000593          	li	a1,784
ffffffffc020ad1e:	00004517          	auipc	a0,0x4
ffffffffc020ad22:	2b250513          	addi	a0,a0,690 # ffffffffc020efd0 <dev_node_ops+0x5c0>
ffffffffc020ad26:	f78f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ad2a <sfs_rwblock_nolock>:
ffffffffc020ad2a:	7139                	addi	sp,sp,-64
ffffffffc020ad2c:	f822                	sd	s0,48(sp)
ffffffffc020ad2e:	f426                	sd	s1,40(sp)
ffffffffc020ad30:	fc06                	sd	ra,56(sp)
ffffffffc020ad32:	842a                	mv	s0,a0
ffffffffc020ad34:	84b6                	mv	s1,a3
ffffffffc020ad36:	e211                	bnez	a2,ffffffffc020ad3a <sfs_rwblock_nolock+0x10>
ffffffffc020ad38:	e715                	bnez	a4,ffffffffc020ad64 <sfs_rwblock_nolock+0x3a>
ffffffffc020ad3a:	405c                	lw	a5,4(s0)
ffffffffc020ad3c:	02f67463          	bgeu	a2,a5,ffffffffc020ad64 <sfs_rwblock_nolock+0x3a>
ffffffffc020ad40:	00c6169b          	slliw	a3,a2,0xc
ffffffffc020ad44:	1682                	slli	a3,a3,0x20
ffffffffc020ad46:	6605                	lui	a2,0x1
ffffffffc020ad48:	9281                	srli	a3,a3,0x20
ffffffffc020ad4a:	850a                	mv	a0,sp
ffffffffc020ad4c:	e9afa0ef          	jal	ra,ffffffffc02053e6 <iobuf_init>
ffffffffc020ad50:	85aa                	mv	a1,a0
ffffffffc020ad52:	7808                	ld	a0,48(s0)
ffffffffc020ad54:	8626                	mv	a2,s1
ffffffffc020ad56:	7118                	ld	a4,32(a0)
ffffffffc020ad58:	9702                	jalr	a4
ffffffffc020ad5a:	70e2                	ld	ra,56(sp)
ffffffffc020ad5c:	7442                	ld	s0,48(sp)
ffffffffc020ad5e:	74a2                	ld	s1,40(sp)
ffffffffc020ad60:	6121                	addi	sp,sp,64
ffffffffc020ad62:	8082                	ret
ffffffffc020ad64:	00004697          	auipc	a3,0x4
ffffffffc020ad68:	66c68693          	addi	a3,a3,1644 # ffffffffc020f3d0 <sfs_node_fileops+0x80>
ffffffffc020ad6c:	00001617          	auipc	a2,0x1
ffffffffc020ad70:	d3c60613          	addi	a2,a2,-708 # ffffffffc020baa8 <commands+0x210>
ffffffffc020ad74:	45d5                	li	a1,21
ffffffffc020ad76:	00004517          	auipc	a0,0x4
ffffffffc020ad7a:	69250513          	addi	a0,a0,1682 # ffffffffc020f408 <sfs_node_fileops+0xb8>
ffffffffc020ad7e:	f20f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ad82 <sfs_rblock>:
ffffffffc020ad82:	7139                	addi	sp,sp,-64
ffffffffc020ad84:	ec4e                	sd	s3,24(sp)
ffffffffc020ad86:	89b6                	mv	s3,a3
ffffffffc020ad88:	f822                	sd	s0,48(sp)
ffffffffc020ad8a:	f04a                	sd	s2,32(sp)
ffffffffc020ad8c:	e852                	sd	s4,16(sp)
ffffffffc020ad8e:	fc06                	sd	ra,56(sp)
ffffffffc020ad90:	f426                	sd	s1,40(sp)
ffffffffc020ad92:	e456                	sd	s5,8(sp)
ffffffffc020ad94:	8a2a                	mv	s4,a0
ffffffffc020ad96:	892e                	mv	s2,a1
ffffffffc020ad98:	8432                	mv	s0,a2
ffffffffc020ad9a:	2e0000ef          	jal	ra,ffffffffc020b07a <lock_sfs_io>
ffffffffc020ad9e:	04098063          	beqz	s3,ffffffffc020adde <sfs_rblock+0x5c>
ffffffffc020ada2:	013409bb          	addw	s3,s0,s3
ffffffffc020ada6:	6a85                	lui	s5,0x1
ffffffffc020ada8:	a021                	j	ffffffffc020adb0 <sfs_rblock+0x2e>
ffffffffc020adaa:	9956                	add	s2,s2,s5
ffffffffc020adac:	02898963          	beq	s3,s0,ffffffffc020adde <sfs_rblock+0x5c>
ffffffffc020adb0:	8622                	mv	a2,s0
ffffffffc020adb2:	85ca                	mv	a1,s2
ffffffffc020adb4:	4705                	li	a4,1
ffffffffc020adb6:	4681                	li	a3,0
ffffffffc020adb8:	8552                	mv	a0,s4
ffffffffc020adba:	f71ff0ef          	jal	ra,ffffffffc020ad2a <sfs_rwblock_nolock>
ffffffffc020adbe:	84aa                	mv	s1,a0
ffffffffc020adc0:	2405                	addiw	s0,s0,1
ffffffffc020adc2:	d565                	beqz	a0,ffffffffc020adaa <sfs_rblock+0x28>
ffffffffc020adc4:	8552                	mv	a0,s4
ffffffffc020adc6:	2c4000ef          	jal	ra,ffffffffc020b08a <unlock_sfs_io>
ffffffffc020adca:	70e2                	ld	ra,56(sp)
ffffffffc020adcc:	7442                	ld	s0,48(sp)
ffffffffc020adce:	7902                	ld	s2,32(sp)
ffffffffc020add0:	69e2                	ld	s3,24(sp)
ffffffffc020add2:	6a42                	ld	s4,16(sp)
ffffffffc020add4:	6aa2                	ld	s5,8(sp)
ffffffffc020add6:	8526                	mv	a0,s1
ffffffffc020add8:	74a2                	ld	s1,40(sp)
ffffffffc020adda:	6121                	addi	sp,sp,64
ffffffffc020addc:	8082                	ret
ffffffffc020adde:	4481                	li	s1,0
ffffffffc020ade0:	b7d5                	j	ffffffffc020adc4 <sfs_rblock+0x42>

ffffffffc020ade2 <sfs_wblock>:
ffffffffc020ade2:	7139                	addi	sp,sp,-64
ffffffffc020ade4:	ec4e                	sd	s3,24(sp)
ffffffffc020ade6:	89b6                	mv	s3,a3
ffffffffc020ade8:	f822                	sd	s0,48(sp)
ffffffffc020adea:	f04a                	sd	s2,32(sp)
ffffffffc020adec:	e852                	sd	s4,16(sp)
ffffffffc020adee:	fc06                	sd	ra,56(sp)
ffffffffc020adf0:	f426                	sd	s1,40(sp)
ffffffffc020adf2:	e456                	sd	s5,8(sp)
ffffffffc020adf4:	8a2a                	mv	s4,a0
ffffffffc020adf6:	892e                	mv	s2,a1
ffffffffc020adf8:	8432                	mv	s0,a2
ffffffffc020adfa:	280000ef          	jal	ra,ffffffffc020b07a <lock_sfs_io>
ffffffffc020adfe:	04098063          	beqz	s3,ffffffffc020ae3e <sfs_wblock+0x5c>
ffffffffc020ae02:	013409bb          	addw	s3,s0,s3
ffffffffc020ae06:	6a85                	lui	s5,0x1
ffffffffc020ae08:	a021                	j	ffffffffc020ae10 <sfs_wblock+0x2e>
ffffffffc020ae0a:	9956                	add	s2,s2,s5
ffffffffc020ae0c:	02898963          	beq	s3,s0,ffffffffc020ae3e <sfs_wblock+0x5c>
ffffffffc020ae10:	8622                	mv	a2,s0
ffffffffc020ae12:	85ca                	mv	a1,s2
ffffffffc020ae14:	4705                	li	a4,1
ffffffffc020ae16:	4685                	li	a3,1
ffffffffc020ae18:	8552                	mv	a0,s4
ffffffffc020ae1a:	f11ff0ef          	jal	ra,ffffffffc020ad2a <sfs_rwblock_nolock>
ffffffffc020ae1e:	84aa                	mv	s1,a0
ffffffffc020ae20:	2405                	addiw	s0,s0,1
ffffffffc020ae22:	d565                	beqz	a0,ffffffffc020ae0a <sfs_wblock+0x28>
ffffffffc020ae24:	8552                	mv	a0,s4
ffffffffc020ae26:	264000ef          	jal	ra,ffffffffc020b08a <unlock_sfs_io>
ffffffffc020ae2a:	70e2                	ld	ra,56(sp)
ffffffffc020ae2c:	7442                	ld	s0,48(sp)
ffffffffc020ae2e:	7902                	ld	s2,32(sp)
ffffffffc020ae30:	69e2                	ld	s3,24(sp)
ffffffffc020ae32:	6a42                	ld	s4,16(sp)
ffffffffc020ae34:	6aa2                	ld	s5,8(sp)
ffffffffc020ae36:	8526                	mv	a0,s1
ffffffffc020ae38:	74a2                	ld	s1,40(sp)
ffffffffc020ae3a:	6121                	addi	sp,sp,64
ffffffffc020ae3c:	8082                	ret
ffffffffc020ae3e:	4481                	li	s1,0
ffffffffc020ae40:	b7d5                	j	ffffffffc020ae24 <sfs_wblock+0x42>

ffffffffc020ae42 <sfs_rbuf>:
ffffffffc020ae42:	7179                	addi	sp,sp,-48
ffffffffc020ae44:	f406                	sd	ra,40(sp)
ffffffffc020ae46:	f022                	sd	s0,32(sp)
ffffffffc020ae48:	ec26                	sd	s1,24(sp)
ffffffffc020ae4a:	e84a                	sd	s2,16(sp)
ffffffffc020ae4c:	e44e                	sd	s3,8(sp)
ffffffffc020ae4e:	e052                	sd	s4,0(sp)
ffffffffc020ae50:	6785                	lui	a5,0x1
ffffffffc020ae52:	04f77863          	bgeu	a4,a5,ffffffffc020aea2 <sfs_rbuf+0x60>
ffffffffc020ae56:	84ba                	mv	s1,a4
ffffffffc020ae58:	9732                	add	a4,a4,a2
ffffffffc020ae5a:	89b2                	mv	s3,a2
ffffffffc020ae5c:	04e7e363          	bltu	a5,a4,ffffffffc020aea2 <sfs_rbuf+0x60>
ffffffffc020ae60:	8936                	mv	s2,a3
ffffffffc020ae62:	842a                	mv	s0,a0
ffffffffc020ae64:	8a2e                	mv	s4,a1
ffffffffc020ae66:	214000ef          	jal	ra,ffffffffc020b07a <lock_sfs_io>
ffffffffc020ae6a:	642c                	ld	a1,72(s0)
ffffffffc020ae6c:	864a                	mv	a2,s2
ffffffffc020ae6e:	4705                	li	a4,1
ffffffffc020ae70:	4681                	li	a3,0
ffffffffc020ae72:	8522                	mv	a0,s0
ffffffffc020ae74:	eb7ff0ef          	jal	ra,ffffffffc020ad2a <sfs_rwblock_nolock>
ffffffffc020ae78:	892a                	mv	s2,a0
ffffffffc020ae7a:	cd09                	beqz	a0,ffffffffc020ae94 <sfs_rbuf+0x52>
ffffffffc020ae7c:	8522                	mv	a0,s0
ffffffffc020ae7e:	20c000ef          	jal	ra,ffffffffc020b08a <unlock_sfs_io>
ffffffffc020ae82:	70a2                	ld	ra,40(sp)
ffffffffc020ae84:	7402                	ld	s0,32(sp)
ffffffffc020ae86:	64e2                	ld	s1,24(sp)
ffffffffc020ae88:	69a2                	ld	s3,8(sp)
ffffffffc020ae8a:	6a02                	ld	s4,0(sp)
ffffffffc020ae8c:	854a                	mv	a0,s2
ffffffffc020ae8e:	6942                	ld	s2,16(sp)
ffffffffc020ae90:	6145                	addi	sp,sp,48
ffffffffc020ae92:	8082                	ret
ffffffffc020ae94:	642c                	ld	a1,72(s0)
ffffffffc020ae96:	864e                	mv	a2,s3
ffffffffc020ae98:	8552                	mv	a0,s4
ffffffffc020ae9a:	95a6                	add	a1,a1,s1
ffffffffc020ae9c:	77c000ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc020aea0:	bff1                	j	ffffffffc020ae7c <sfs_rbuf+0x3a>
ffffffffc020aea2:	00004697          	auipc	a3,0x4
ffffffffc020aea6:	57e68693          	addi	a3,a3,1406 # ffffffffc020f420 <sfs_node_fileops+0xd0>
ffffffffc020aeaa:	00001617          	auipc	a2,0x1
ffffffffc020aeae:	bfe60613          	addi	a2,a2,-1026 # ffffffffc020baa8 <commands+0x210>
ffffffffc020aeb2:	05500593          	li	a1,85
ffffffffc020aeb6:	00004517          	auipc	a0,0x4
ffffffffc020aeba:	55250513          	addi	a0,a0,1362 # ffffffffc020f408 <sfs_node_fileops+0xb8>
ffffffffc020aebe:	de0f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020aec2 <sfs_wbuf>:
ffffffffc020aec2:	7139                	addi	sp,sp,-64
ffffffffc020aec4:	fc06                	sd	ra,56(sp)
ffffffffc020aec6:	f822                	sd	s0,48(sp)
ffffffffc020aec8:	f426                	sd	s1,40(sp)
ffffffffc020aeca:	f04a                	sd	s2,32(sp)
ffffffffc020aecc:	ec4e                	sd	s3,24(sp)
ffffffffc020aece:	e852                	sd	s4,16(sp)
ffffffffc020aed0:	e456                	sd	s5,8(sp)
ffffffffc020aed2:	6785                	lui	a5,0x1
ffffffffc020aed4:	06f77163          	bgeu	a4,a5,ffffffffc020af36 <sfs_wbuf+0x74>
ffffffffc020aed8:	893a                	mv	s2,a4
ffffffffc020aeda:	9732                	add	a4,a4,a2
ffffffffc020aedc:	8a32                	mv	s4,a2
ffffffffc020aede:	04e7ec63          	bltu	a5,a4,ffffffffc020af36 <sfs_wbuf+0x74>
ffffffffc020aee2:	842a                	mv	s0,a0
ffffffffc020aee4:	89b6                	mv	s3,a3
ffffffffc020aee6:	8aae                	mv	s5,a1
ffffffffc020aee8:	192000ef          	jal	ra,ffffffffc020b07a <lock_sfs_io>
ffffffffc020aeec:	642c                	ld	a1,72(s0)
ffffffffc020aeee:	4705                	li	a4,1
ffffffffc020aef0:	4681                	li	a3,0
ffffffffc020aef2:	864e                	mv	a2,s3
ffffffffc020aef4:	8522                	mv	a0,s0
ffffffffc020aef6:	e35ff0ef          	jal	ra,ffffffffc020ad2a <sfs_rwblock_nolock>
ffffffffc020aefa:	84aa                	mv	s1,a0
ffffffffc020aefc:	cd11                	beqz	a0,ffffffffc020af18 <sfs_wbuf+0x56>
ffffffffc020aefe:	8522                	mv	a0,s0
ffffffffc020af00:	18a000ef          	jal	ra,ffffffffc020b08a <unlock_sfs_io>
ffffffffc020af04:	70e2                	ld	ra,56(sp)
ffffffffc020af06:	7442                	ld	s0,48(sp)
ffffffffc020af08:	7902                	ld	s2,32(sp)
ffffffffc020af0a:	69e2                	ld	s3,24(sp)
ffffffffc020af0c:	6a42                	ld	s4,16(sp)
ffffffffc020af0e:	6aa2                	ld	s5,8(sp)
ffffffffc020af10:	8526                	mv	a0,s1
ffffffffc020af12:	74a2                	ld	s1,40(sp)
ffffffffc020af14:	6121                	addi	sp,sp,64
ffffffffc020af16:	8082                	ret
ffffffffc020af18:	6428                	ld	a0,72(s0)
ffffffffc020af1a:	8652                	mv	a2,s4
ffffffffc020af1c:	85d6                	mv	a1,s5
ffffffffc020af1e:	954a                	add	a0,a0,s2
ffffffffc020af20:	6f8000ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc020af24:	642c                	ld	a1,72(s0)
ffffffffc020af26:	4705                	li	a4,1
ffffffffc020af28:	4685                	li	a3,1
ffffffffc020af2a:	864e                	mv	a2,s3
ffffffffc020af2c:	8522                	mv	a0,s0
ffffffffc020af2e:	dfdff0ef          	jal	ra,ffffffffc020ad2a <sfs_rwblock_nolock>
ffffffffc020af32:	84aa                	mv	s1,a0
ffffffffc020af34:	b7e9                	j	ffffffffc020aefe <sfs_wbuf+0x3c>
ffffffffc020af36:	00004697          	auipc	a3,0x4
ffffffffc020af3a:	4ea68693          	addi	a3,a3,1258 # ffffffffc020f420 <sfs_node_fileops+0xd0>
ffffffffc020af3e:	00001617          	auipc	a2,0x1
ffffffffc020af42:	b6a60613          	addi	a2,a2,-1174 # ffffffffc020baa8 <commands+0x210>
ffffffffc020af46:	06b00593          	li	a1,107
ffffffffc020af4a:	00004517          	auipc	a0,0x4
ffffffffc020af4e:	4be50513          	addi	a0,a0,1214 # ffffffffc020f408 <sfs_node_fileops+0xb8>
ffffffffc020af52:	d4cf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020af56 <sfs_sync_super>:
ffffffffc020af56:	1101                	addi	sp,sp,-32
ffffffffc020af58:	ec06                	sd	ra,24(sp)
ffffffffc020af5a:	e822                	sd	s0,16(sp)
ffffffffc020af5c:	e426                	sd	s1,8(sp)
ffffffffc020af5e:	842a                	mv	s0,a0
ffffffffc020af60:	11a000ef          	jal	ra,ffffffffc020b07a <lock_sfs_io>
ffffffffc020af64:	6428                	ld	a0,72(s0)
ffffffffc020af66:	6605                	lui	a2,0x1
ffffffffc020af68:	4581                	li	a1,0
ffffffffc020af6a:	65c000ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc020af6e:	6428                	ld	a0,72(s0)
ffffffffc020af70:	85a2                	mv	a1,s0
ffffffffc020af72:	02c00613          	li	a2,44
ffffffffc020af76:	6a2000ef          	jal	ra,ffffffffc020b618 <memcpy>
ffffffffc020af7a:	642c                	ld	a1,72(s0)
ffffffffc020af7c:	4701                	li	a4,0
ffffffffc020af7e:	4685                	li	a3,1
ffffffffc020af80:	4601                	li	a2,0
ffffffffc020af82:	8522                	mv	a0,s0
ffffffffc020af84:	da7ff0ef          	jal	ra,ffffffffc020ad2a <sfs_rwblock_nolock>
ffffffffc020af88:	84aa                	mv	s1,a0
ffffffffc020af8a:	8522                	mv	a0,s0
ffffffffc020af8c:	0fe000ef          	jal	ra,ffffffffc020b08a <unlock_sfs_io>
ffffffffc020af90:	60e2                	ld	ra,24(sp)
ffffffffc020af92:	6442                	ld	s0,16(sp)
ffffffffc020af94:	8526                	mv	a0,s1
ffffffffc020af96:	64a2                	ld	s1,8(sp)
ffffffffc020af98:	6105                	addi	sp,sp,32
ffffffffc020af9a:	8082                	ret

ffffffffc020af9c <sfs_sync_freemap>:
ffffffffc020af9c:	7139                	addi	sp,sp,-64
ffffffffc020af9e:	ec4e                	sd	s3,24(sp)
ffffffffc020afa0:	e852                	sd	s4,16(sp)
ffffffffc020afa2:	00456983          	lwu	s3,4(a0)
ffffffffc020afa6:	8a2a                	mv	s4,a0
ffffffffc020afa8:	7d08                	ld	a0,56(a0)
ffffffffc020afaa:	67a1                	lui	a5,0x8
ffffffffc020afac:	17fd                	addi	a5,a5,-1
ffffffffc020afae:	4581                	li	a1,0
ffffffffc020afb0:	f822                	sd	s0,48(sp)
ffffffffc020afb2:	fc06                	sd	ra,56(sp)
ffffffffc020afb4:	f426                	sd	s1,40(sp)
ffffffffc020afb6:	f04a                	sd	s2,32(sp)
ffffffffc020afb8:	e456                	sd	s5,8(sp)
ffffffffc020afba:	99be                	add	s3,s3,a5
ffffffffc020afbc:	81cfe0ef          	jal	ra,ffffffffc0208fd8 <bitmap_getdata>
ffffffffc020afc0:	00f9d993          	srli	s3,s3,0xf
ffffffffc020afc4:	842a                	mv	s0,a0
ffffffffc020afc6:	8552                	mv	a0,s4
ffffffffc020afc8:	0b2000ef          	jal	ra,ffffffffc020b07a <lock_sfs_io>
ffffffffc020afcc:	04098163          	beqz	s3,ffffffffc020b00e <sfs_sync_freemap+0x72>
ffffffffc020afd0:	09b2                	slli	s3,s3,0xc
ffffffffc020afd2:	99a2                	add	s3,s3,s0
ffffffffc020afd4:	4909                	li	s2,2
ffffffffc020afd6:	6a85                	lui	s5,0x1
ffffffffc020afd8:	a021                	j	ffffffffc020afe0 <sfs_sync_freemap+0x44>
ffffffffc020afda:	2905                	addiw	s2,s2,1
ffffffffc020afdc:	02898963          	beq	s3,s0,ffffffffc020b00e <sfs_sync_freemap+0x72>
ffffffffc020afe0:	85a2                	mv	a1,s0
ffffffffc020afe2:	864a                	mv	a2,s2
ffffffffc020afe4:	4705                	li	a4,1
ffffffffc020afe6:	4685                	li	a3,1
ffffffffc020afe8:	8552                	mv	a0,s4
ffffffffc020afea:	d41ff0ef          	jal	ra,ffffffffc020ad2a <sfs_rwblock_nolock>
ffffffffc020afee:	84aa                	mv	s1,a0
ffffffffc020aff0:	9456                	add	s0,s0,s5
ffffffffc020aff2:	d565                	beqz	a0,ffffffffc020afda <sfs_sync_freemap+0x3e>
ffffffffc020aff4:	8552                	mv	a0,s4
ffffffffc020aff6:	094000ef          	jal	ra,ffffffffc020b08a <unlock_sfs_io>
ffffffffc020affa:	70e2                	ld	ra,56(sp)
ffffffffc020affc:	7442                	ld	s0,48(sp)
ffffffffc020affe:	7902                	ld	s2,32(sp)
ffffffffc020b000:	69e2                	ld	s3,24(sp)
ffffffffc020b002:	6a42                	ld	s4,16(sp)
ffffffffc020b004:	6aa2                	ld	s5,8(sp)
ffffffffc020b006:	8526                	mv	a0,s1
ffffffffc020b008:	74a2                	ld	s1,40(sp)
ffffffffc020b00a:	6121                	addi	sp,sp,64
ffffffffc020b00c:	8082                	ret
ffffffffc020b00e:	4481                	li	s1,0
ffffffffc020b010:	b7d5                	j	ffffffffc020aff4 <sfs_sync_freemap+0x58>

ffffffffc020b012 <sfs_clear_block>:
ffffffffc020b012:	7179                	addi	sp,sp,-48
ffffffffc020b014:	f022                	sd	s0,32(sp)
ffffffffc020b016:	e84a                	sd	s2,16(sp)
ffffffffc020b018:	e44e                	sd	s3,8(sp)
ffffffffc020b01a:	f406                	sd	ra,40(sp)
ffffffffc020b01c:	89b2                	mv	s3,a2
ffffffffc020b01e:	ec26                	sd	s1,24(sp)
ffffffffc020b020:	892a                	mv	s2,a0
ffffffffc020b022:	842e                	mv	s0,a1
ffffffffc020b024:	056000ef          	jal	ra,ffffffffc020b07a <lock_sfs_io>
ffffffffc020b028:	04893503          	ld	a0,72(s2)
ffffffffc020b02c:	6605                	lui	a2,0x1
ffffffffc020b02e:	4581                	li	a1,0
ffffffffc020b030:	596000ef          	jal	ra,ffffffffc020b5c6 <memset>
ffffffffc020b034:	02098d63          	beqz	s3,ffffffffc020b06e <sfs_clear_block+0x5c>
ffffffffc020b038:	013409bb          	addw	s3,s0,s3
ffffffffc020b03c:	a019                	j	ffffffffc020b042 <sfs_clear_block+0x30>
ffffffffc020b03e:	02898863          	beq	s3,s0,ffffffffc020b06e <sfs_clear_block+0x5c>
ffffffffc020b042:	04893583          	ld	a1,72(s2)
ffffffffc020b046:	8622                	mv	a2,s0
ffffffffc020b048:	4705                	li	a4,1
ffffffffc020b04a:	4685                	li	a3,1
ffffffffc020b04c:	854a                	mv	a0,s2
ffffffffc020b04e:	cddff0ef          	jal	ra,ffffffffc020ad2a <sfs_rwblock_nolock>
ffffffffc020b052:	84aa                	mv	s1,a0
ffffffffc020b054:	2405                	addiw	s0,s0,1
ffffffffc020b056:	d565                	beqz	a0,ffffffffc020b03e <sfs_clear_block+0x2c>
ffffffffc020b058:	854a                	mv	a0,s2
ffffffffc020b05a:	030000ef          	jal	ra,ffffffffc020b08a <unlock_sfs_io>
ffffffffc020b05e:	70a2                	ld	ra,40(sp)
ffffffffc020b060:	7402                	ld	s0,32(sp)
ffffffffc020b062:	6942                	ld	s2,16(sp)
ffffffffc020b064:	69a2                	ld	s3,8(sp)
ffffffffc020b066:	8526                	mv	a0,s1
ffffffffc020b068:	64e2                	ld	s1,24(sp)
ffffffffc020b06a:	6145                	addi	sp,sp,48
ffffffffc020b06c:	8082                	ret
ffffffffc020b06e:	4481                	li	s1,0
ffffffffc020b070:	b7e5                	j	ffffffffc020b058 <sfs_clear_block+0x46>

ffffffffc020b072 <lock_sfs_fs>:
ffffffffc020b072:	05050513          	addi	a0,a0,80
ffffffffc020b076:	cf2f906f          	j	ffffffffc0204568 <down>

ffffffffc020b07a <lock_sfs_io>:
ffffffffc020b07a:	06850513          	addi	a0,a0,104
ffffffffc020b07e:	ceaf906f          	j	ffffffffc0204568 <down>

ffffffffc020b082 <unlock_sfs_fs>:
ffffffffc020b082:	05050513          	addi	a0,a0,80
ffffffffc020b086:	cdef906f          	j	ffffffffc0204564 <up>

ffffffffc020b08a <unlock_sfs_io>:
ffffffffc020b08a:	06850513          	addi	a0,a0,104
ffffffffc020b08e:	cd6f906f          	j	ffffffffc0204564 <up>

ffffffffc020b092 <hash32>:
ffffffffc020b092:	9e3707b7          	lui	a5,0x9e370
ffffffffc020b096:	2785                	addiw	a5,a5,1
ffffffffc020b098:	02a7853b          	mulw	a0,a5,a0
ffffffffc020b09c:	02000793          	li	a5,32
ffffffffc020b0a0:	9f8d                	subw	a5,a5,a1
ffffffffc020b0a2:	00f5553b          	srlw	a0,a0,a5
ffffffffc020b0a6:	8082                	ret

ffffffffc020b0a8 <printnum>:
ffffffffc020b0a8:	02071893          	slli	a7,a4,0x20
ffffffffc020b0ac:	7139                	addi	sp,sp,-64
ffffffffc020b0ae:	0208d893          	srli	a7,a7,0x20
ffffffffc020b0b2:	e456                	sd	s5,8(sp)
ffffffffc020b0b4:	0316fab3          	remu	s5,a3,a7
ffffffffc020b0b8:	f822                	sd	s0,48(sp)
ffffffffc020b0ba:	f426                	sd	s1,40(sp)
ffffffffc020b0bc:	f04a                	sd	s2,32(sp)
ffffffffc020b0be:	ec4e                	sd	s3,24(sp)
ffffffffc020b0c0:	fc06                	sd	ra,56(sp)
ffffffffc020b0c2:	e852                	sd	s4,16(sp)
ffffffffc020b0c4:	84aa                	mv	s1,a0
ffffffffc020b0c6:	89ae                	mv	s3,a1
ffffffffc020b0c8:	8932                	mv	s2,a2
ffffffffc020b0ca:	fff7841b          	addiw	s0,a5,-1
ffffffffc020b0ce:	2a81                	sext.w	s5,s5
ffffffffc020b0d0:	0516f163          	bgeu	a3,a7,ffffffffc020b112 <printnum+0x6a>
ffffffffc020b0d4:	8a42                	mv	s4,a6
ffffffffc020b0d6:	00805863          	blez	s0,ffffffffc020b0e6 <printnum+0x3e>
ffffffffc020b0da:	347d                	addiw	s0,s0,-1
ffffffffc020b0dc:	864e                	mv	a2,s3
ffffffffc020b0de:	85ca                	mv	a1,s2
ffffffffc020b0e0:	8552                	mv	a0,s4
ffffffffc020b0e2:	9482                	jalr	s1
ffffffffc020b0e4:	f87d                	bnez	s0,ffffffffc020b0da <printnum+0x32>
ffffffffc020b0e6:	1a82                	slli	s5,s5,0x20
ffffffffc020b0e8:	00004797          	auipc	a5,0x4
ffffffffc020b0ec:	38078793          	addi	a5,a5,896 # ffffffffc020f468 <sfs_node_fileops+0x118>
ffffffffc020b0f0:	020ada93          	srli	s5,s5,0x20
ffffffffc020b0f4:	9abe                	add	s5,s5,a5
ffffffffc020b0f6:	7442                	ld	s0,48(sp)
ffffffffc020b0f8:	000ac503          	lbu	a0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020b0fc:	70e2                	ld	ra,56(sp)
ffffffffc020b0fe:	6a42                	ld	s4,16(sp)
ffffffffc020b100:	6aa2                	ld	s5,8(sp)
ffffffffc020b102:	864e                	mv	a2,s3
ffffffffc020b104:	85ca                	mv	a1,s2
ffffffffc020b106:	69e2                	ld	s3,24(sp)
ffffffffc020b108:	7902                	ld	s2,32(sp)
ffffffffc020b10a:	87a6                	mv	a5,s1
ffffffffc020b10c:	74a2                	ld	s1,40(sp)
ffffffffc020b10e:	6121                	addi	sp,sp,64
ffffffffc020b110:	8782                	jr	a5
ffffffffc020b112:	0316d6b3          	divu	a3,a3,a7
ffffffffc020b116:	87a2                	mv	a5,s0
ffffffffc020b118:	f91ff0ef          	jal	ra,ffffffffc020b0a8 <printnum>
ffffffffc020b11c:	b7e9                	j	ffffffffc020b0e6 <printnum+0x3e>

ffffffffc020b11e <sprintputch>:
ffffffffc020b11e:	499c                	lw	a5,16(a1)
ffffffffc020b120:	6198                	ld	a4,0(a1)
ffffffffc020b122:	6594                	ld	a3,8(a1)
ffffffffc020b124:	2785                	addiw	a5,a5,1
ffffffffc020b126:	c99c                	sw	a5,16(a1)
ffffffffc020b128:	00d77763          	bgeu	a4,a3,ffffffffc020b136 <sprintputch+0x18>
ffffffffc020b12c:	00170793          	addi	a5,a4,1
ffffffffc020b130:	e19c                	sd	a5,0(a1)
ffffffffc020b132:	00a70023          	sb	a0,0(a4)
ffffffffc020b136:	8082                	ret

ffffffffc020b138 <vprintfmt>:
ffffffffc020b138:	7119                	addi	sp,sp,-128
ffffffffc020b13a:	f4a6                	sd	s1,104(sp)
ffffffffc020b13c:	f0ca                	sd	s2,96(sp)
ffffffffc020b13e:	ecce                	sd	s3,88(sp)
ffffffffc020b140:	e8d2                	sd	s4,80(sp)
ffffffffc020b142:	e4d6                	sd	s5,72(sp)
ffffffffc020b144:	e0da                	sd	s6,64(sp)
ffffffffc020b146:	fc5e                	sd	s7,56(sp)
ffffffffc020b148:	ec6e                	sd	s11,24(sp)
ffffffffc020b14a:	fc86                	sd	ra,120(sp)
ffffffffc020b14c:	f8a2                	sd	s0,112(sp)
ffffffffc020b14e:	f862                	sd	s8,48(sp)
ffffffffc020b150:	f466                	sd	s9,40(sp)
ffffffffc020b152:	f06a                	sd	s10,32(sp)
ffffffffc020b154:	89aa                	mv	s3,a0
ffffffffc020b156:	892e                	mv	s2,a1
ffffffffc020b158:	84b2                	mv	s1,a2
ffffffffc020b15a:	8db6                	mv	s11,a3
ffffffffc020b15c:	8aba                	mv	s5,a4
ffffffffc020b15e:	02500a13          	li	s4,37
ffffffffc020b162:	5bfd                	li	s7,-1
ffffffffc020b164:	00004b17          	auipc	s6,0x4
ffffffffc020b168:	330b0b13          	addi	s6,s6,816 # ffffffffc020f494 <sfs_node_fileops+0x144>
ffffffffc020b16c:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020b170:	001d8413          	addi	s0,s11,1
ffffffffc020b174:	01450b63          	beq	a0,s4,ffffffffc020b18a <vprintfmt+0x52>
ffffffffc020b178:	c129                	beqz	a0,ffffffffc020b1ba <vprintfmt+0x82>
ffffffffc020b17a:	864a                	mv	a2,s2
ffffffffc020b17c:	85a6                	mv	a1,s1
ffffffffc020b17e:	0405                	addi	s0,s0,1
ffffffffc020b180:	9982                	jalr	s3
ffffffffc020b182:	fff44503          	lbu	a0,-1(s0)
ffffffffc020b186:	ff4519e3          	bne	a0,s4,ffffffffc020b178 <vprintfmt+0x40>
ffffffffc020b18a:	00044583          	lbu	a1,0(s0)
ffffffffc020b18e:	02000813          	li	a6,32
ffffffffc020b192:	4d01                	li	s10,0
ffffffffc020b194:	4301                	li	t1,0
ffffffffc020b196:	5cfd                	li	s9,-1
ffffffffc020b198:	5c7d                	li	s8,-1
ffffffffc020b19a:	05500513          	li	a0,85
ffffffffc020b19e:	48a5                	li	a7,9
ffffffffc020b1a0:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b1a4:	0ff67613          	zext.b	a2,a2
ffffffffc020b1a8:	00140d93          	addi	s11,s0,1
ffffffffc020b1ac:	04c56263          	bltu	a0,a2,ffffffffc020b1f0 <vprintfmt+0xb8>
ffffffffc020b1b0:	060a                	slli	a2,a2,0x2
ffffffffc020b1b2:	965a                	add	a2,a2,s6
ffffffffc020b1b4:	4214                	lw	a3,0(a2)
ffffffffc020b1b6:	96da                	add	a3,a3,s6
ffffffffc020b1b8:	8682                	jr	a3
ffffffffc020b1ba:	70e6                	ld	ra,120(sp)
ffffffffc020b1bc:	7446                	ld	s0,112(sp)
ffffffffc020b1be:	74a6                	ld	s1,104(sp)
ffffffffc020b1c0:	7906                	ld	s2,96(sp)
ffffffffc020b1c2:	69e6                	ld	s3,88(sp)
ffffffffc020b1c4:	6a46                	ld	s4,80(sp)
ffffffffc020b1c6:	6aa6                	ld	s5,72(sp)
ffffffffc020b1c8:	6b06                	ld	s6,64(sp)
ffffffffc020b1ca:	7be2                	ld	s7,56(sp)
ffffffffc020b1cc:	7c42                	ld	s8,48(sp)
ffffffffc020b1ce:	7ca2                	ld	s9,40(sp)
ffffffffc020b1d0:	7d02                	ld	s10,32(sp)
ffffffffc020b1d2:	6de2                	ld	s11,24(sp)
ffffffffc020b1d4:	6109                	addi	sp,sp,128
ffffffffc020b1d6:	8082                	ret
ffffffffc020b1d8:	882e                	mv	a6,a1
ffffffffc020b1da:	00144583          	lbu	a1,1(s0)
ffffffffc020b1de:	846e                	mv	s0,s11
ffffffffc020b1e0:	00140d93          	addi	s11,s0,1
ffffffffc020b1e4:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b1e8:	0ff67613          	zext.b	a2,a2
ffffffffc020b1ec:	fcc572e3          	bgeu	a0,a2,ffffffffc020b1b0 <vprintfmt+0x78>
ffffffffc020b1f0:	864a                	mv	a2,s2
ffffffffc020b1f2:	85a6                	mv	a1,s1
ffffffffc020b1f4:	02500513          	li	a0,37
ffffffffc020b1f8:	9982                	jalr	s3
ffffffffc020b1fa:	fff44783          	lbu	a5,-1(s0)
ffffffffc020b1fe:	8da2                	mv	s11,s0
ffffffffc020b200:	f74786e3          	beq	a5,s4,ffffffffc020b16c <vprintfmt+0x34>
ffffffffc020b204:	ffedc783          	lbu	a5,-2(s11)
ffffffffc020b208:	1dfd                	addi	s11,s11,-1
ffffffffc020b20a:	ff479de3          	bne	a5,s4,ffffffffc020b204 <vprintfmt+0xcc>
ffffffffc020b20e:	bfb9                	j	ffffffffc020b16c <vprintfmt+0x34>
ffffffffc020b210:	fd058c9b          	addiw	s9,a1,-48
ffffffffc020b214:	00144583          	lbu	a1,1(s0)
ffffffffc020b218:	846e                	mv	s0,s11
ffffffffc020b21a:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b21e:	0005861b          	sext.w	a2,a1
ffffffffc020b222:	02d8e463          	bltu	a7,a3,ffffffffc020b24a <vprintfmt+0x112>
ffffffffc020b226:	00144583          	lbu	a1,1(s0)
ffffffffc020b22a:	002c969b          	slliw	a3,s9,0x2
ffffffffc020b22e:	0196873b          	addw	a4,a3,s9
ffffffffc020b232:	0017171b          	slliw	a4,a4,0x1
ffffffffc020b236:	9f31                	addw	a4,a4,a2
ffffffffc020b238:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b23c:	0405                	addi	s0,s0,1
ffffffffc020b23e:	fd070c9b          	addiw	s9,a4,-48
ffffffffc020b242:	0005861b          	sext.w	a2,a1
ffffffffc020b246:	fed8f0e3          	bgeu	a7,a3,ffffffffc020b226 <vprintfmt+0xee>
ffffffffc020b24a:	f40c5be3          	bgez	s8,ffffffffc020b1a0 <vprintfmt+0x68>
ffffffffc020b24e:	8c66                	mv	s8,s9
ffffffffc020b250:	5cfd                	li	s9,-1
ffffffffc020b252:	b7b9                	j	ffffffffc020b1a0 <vprintfmt+0x68>
ffffffffc020b254:	fffc4693          	not	a3,s8
ffffffffc020b258:	96fd                	srai	a3,a3,0x3f
ffffffffc020b25a:	00dc77b3          	and	a5,s8,a3
ffffffffc020b25e:	00144583          	lbu	a1,1(s0)
ffffffffc020b262:	00078c1b          	sext.w	s8,a5
ffffffffc020b266:	846e                	mv	s0,s11
ffffffffc020b268:	bf25                	j	ffffffffc020b1a0 <vprintfmt+0x68>
ffffffffc020b26a:	000aac83          	lw	s9,0(s5)
ffffffffc020b26e:	00144583          	lbu	a1,1(s0)
ffffffffc020b272:	0aa1                	addi	s5,s5,8
ffffffffc020b274:	846e                	mv	s0,s11
ffffffffc020b276:	bfd1                	j	ffffffffc020b24a <vprintfmt+0x112>
ffffffffc020b278:	4705                	li	a4,1
ffffffffc020b27a:	008a8613          	addi	a2,s5,8
ffffffffc020b27e:	00674463          	blt	a4,t1,ffffffffc020b286 <vprintfmt+0x14e>
ffffffffc020b282:	1c030c63          	beqz	t1,ffffffffc020b45a <vprintfmt+0x322>
ffffffffc020b286:	000ab683          	ld	a3,0(s5)
ffffffffc020b28a:	4741                	li	a4,16
ffffffffc020b28c:	8ab2                	mv	s5,a2
ffffffffc020b28e:	2801                	sext.w	a6,a6
ffffffffc020b290:	87e2                	mv	a5,s8
ffffffffc020b292:	8626                	mv	a2,s1
ffffffffc020b294:	85ca                	mv	a1,s2
ffffffffc020b296:	854e                	mv	a0,s3
ffffffffc020b298:	e11ff0ef          	jal	ra,ffffffffc020b0a8 <printnum>
ffffffffc020b29c:	bdc1                	j	ffffffffc020b16c <vprintfmt+0x34>
ffffffffc020b29e:	000aa503          	lw	a0,0(s5)
ffffffffc020b2a2:	864a                	mv	a2,s2
ffffffffc020b2a4:	85a6                	mv	a1,s1
ffffffffc020b2a6:	0aa1                	addi	s5,s5,8
ffffffffc020b2a8:	9982                	jalr	s3
ffffffffc020b2aa:	b5c9                	j	ffffffffc020b16c <vprintfmt+0x34>
ffffffffc020b2ac:	4705                	li	a4,1
ffffffffc020b2ae:	008a8613          	addi	a2,s5,8
ffffffffc020b2b2:	00674463          	blt	a4,t1,ffffffffc020b2ba <vprintfmt+0x182>
ffffffffc020b2b6:	18030d63          	beqz	t1,ffffffffc020b450 <vprintfmt+0x318>
ffffffffc020b2ba:	000ab683          	ld	a3,0(s5)
ffffffffc020b2be:	4729                	li	a4,10
ffffffffc020b2c0:	8ab2                	mv	s5,a2
ffffffffc020b2c2:	b7f1                	j	ffffffffc020b28e <vprintfmt+0x156>
ffffffffc020b2c4:	00144583          	lbu	a1,1(s0)
ffffffffc020b2c8:	4d05                	li	s10,1
ffffffffc020b2ca:	846e                	mv	s0,s11
ffffffffc020b2cc:	bdd1                	j	ffffffffc020b1a0 <vprintfmt+0x68>
ffffffffc020b2ce:	864a                	mv	a2,s2
ffffffffc020b2d0:	85a6                	mv	a1,s1
ffffffffc020b2d2:	02500513          	li	a0,37
ffffffffc020b2d6:	9982                	jalr	s3
ffffffffc020b2d8:	bd51                	j	ffffffffc020b16c <vprintfmt+0x34>
ffffffffc020b2da:	00144583          	lbu	a1,1(s0)
ffffffffc020b2de:	2305                	addiw	t1,t1,1
ffffffffc020b2e0:	846e                	mv	s0,s11
ffffffffc020b2e2:	bd7d                	j	ffffffffc020b1a0 <vprintfmt+0x68>
ffffffffc020b2e4:	4705                	li	a4,1
ffffffffc020b2e6:	008a8613          	addi	a2,s5,8
ffffffffc020b2ea:	00674463          	blt	a4,t1,ffffffffc020b2f2 <vprintfmt+0x1ba>
ffffffffc020b2ee:	14030c63          	beqz	t1,ffffffffc020b446 <vprintfmt+0x30e>
ffffffffc020b2f2:	000ab683          	ld	a3,0(s5)
ffffffffc020b2f6:	4721                	li	a4,8
ffffffffc020b2f8:	8ab2                	mv	s5,a2
ffffffffc020b2fa:	bf51                	j	ffffffffc020b28e <vprintfmt+0x156>
ffffffffc020b2fc:	03000513          	li	a0,48
ffffffffc020b300:	864a                	mv	a2,s2
ffffffffc020b302:	85a6                	mv	a1,s1
ffffffffc020b304:	e042                	sd	a6,0(sp)
ffffffffc020b306:	9982                	jalr	s3
ffffffffc020b308:	864a                	mv	a2,s2
ffffffffc020b30a:	85a6                	mv	a1,s1
ffffffffc020b30c:	07800513          	li	a0,120
ffffffffc020b310:	9982                	jalr	s3
ffffffffc020b312:	0aa1                	addi	s5,s5,8
ffffffffc020b314:	6802                	ld	a6,0(sp)
ffffffffc020b316:	4741                	li	a4,16
ffffffffc020b318:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020b31c:	bf8d                	j	ffffffffc020b28e <vprintfmt+0x156>
ffffffffc020b31e:	000ab403          	ld	s0,0(s5)
ffffffffc020b322:	008a8793          	addi	a5,s5,8
ffffffffc020b326:	e03e                	sd	a5,0(sp)
ffffffffc020b328:	14040c63          	beqz	s0,ffffffffc020b480 <vprintfmt+0x348>
ffffffffc020b32c:	11805063          	blez	s8,ffffffffc020b42c <vprintfmt+0x2f4>
ffffffffc020b330:	02d00693          	li	a3,45
ffffffffc020b334:	0cd81963          	bne	a6,a3,ffffffffc020b406 <vprintfmt+0x2ce>
ffffffffc020b338:	00044683          	lbu	a3,0(s0)
ffffffffc020b33c:	0006851b          	sext.w	a0,a3
ffffffffc020b340:	ce8d                	beqz	a3,ffffffffc020b37a <vprintfmt+0x242>
ffffffffc020b342:	00140a93          	addi	s5,s0,1
ffffffffc020b346:	05e00413          	li	s0,94
ffffffffc020b34a:	000cc563          	bltz	s9,ffffffffc020b354 <vprintfmt+0x21c>
ffffffffc020b34e:	3cfd                	addiw	s9,s9,-1
ffffffffc020b350:	037c8363          	beq	s9,s7,ffffffffc020b376 <vprintfmt+0x23e>
ffffffffc020b354:	864a                	mv	a2,s2
ffffffffc020b356:	85a6                	mv	a1,s1
ffffffffc020b358:	100d0663          	beqz	s10,ffffffffc020b464 <vprintfmt+0x32c>
ffffffffc020b35c:	3681                	addiw	a3,a3,-32
ffffffffc020b35e:	10d47363          	bgeu	s0,a3,ffffffffc020b464 <vprintfmt+0x32c>
ffffffffc020b362:	03f00513          	li	a0,63
ffffffffc020b366:	9982                	jalr	s3
ffffffffc020b368:	000ac683          	lbu	a3,0(s5)
ffffffffc020b36c:	3c7d                	addiw	s8,s8,-1
ffffffffc020b36e:	0a85                	addi	s5,s5,1
ffffffffc020b370:	0006851b          	sext.w	a0,a3
ffffffffc020b374:	faf9                	bnez	a3,ffffffffc020b34a <vprintfmt+0x212>
ffffffffc020b376:	01805a63          	blez	s8,ffffffffc020b38a <vprintfmt+0x252>
ffffffffc020b37a:	3c7d                	addiw	s8,s8,-1
ffffffffc020b37c:	864a                	mv	a2,s2
ffffffffc020b37e:	85a6                	mv	a1,s1
ffffffffc020b380:	02000513          	li	a0,32
ffffffffc020b384:	9982                	jalr	s3
ffffffffc020b386:	fe0c1ae3          	bnez	s8,ffffffffc020b37a <vprintfmt+0x242>
ffffffffc020b38a:	6a82                	ld	s5,0(sp)
ffffffffc020b38c:	b3c5                	j	ffffffffc020b16c <vprintfmt+0x34>
ffffffffc020b38e:	4705                	li	a4,1
ffffffffc020b390:	008a8d13          	addi	s10,s5,8
ffffffffc020b394:	00674463          	blt	a4,t1,ffffffffc020b39c <vprintfmt+0x264>
ffffffffc020b398:	0a030463          	beqz	t1,ffffffffc020b440 <vprintfmt+0x308>
ffffffffc020b39c:	000ab403          	ld	s0,0(s5)
ffffffffc020b3a0:	0c044463          	bltz	s0,ffffffffc020b468 <vprintfmt+0x330>
ffffffffc020b3a4:	86a2                	mv	a3,s0
ffffffffc020b3a6:	8aea                	mv	s5,s10
ffffffffc020b3a8:	4729                	li	a4,10
ffffffffc020b3aa:	b5d5                	j	ffffffffc020b28e <vprintfmt+0x156>
ffffffffc020b3ac:	000aa783          	lw	a5,0(s5)
ffffffffc020b3b0:	46e1                	li	a3,24
ffffffffc020b3b2:	0aa1                	addi	s5,s5,8
ffffffffc020b3b4:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020b3b8:	8fb9                	xor	a5,a5,a4
ffffffffc020b3ba:	40e7873b          	subw	a4,a5,a4
ffffffffc020b3be:	02e6c663          	blt	a3,a4,ffffffffc020b3ea <vprintfmt+0x2b2>
ffffffffc020b3c2:	00371793          	slli	a5,a4,0x3
ffffffffc020b3c6:	00004697          	auipc	a3,0x4
ffffffffc020b3ca:	40268693          	addi	a3,a3,1026 # ffffffffc020f7c8 <error_string>
ffffffffc020b3ce:	97b6                	add	a5,a5,a3
ffffffffc020b3d0:	639c                	ld	a5,0(a5)
ffffffffc020b3d2:	cf81                	beqz	a5,ffffffffc020b3ea <vprintfmt+0x2b2>
ffffffffc020b3d4:	873e                	mv	a4,a5
ffffffffc020b3d6:	00000697          	auipc	a3,0x0
ffffffffc020b3da:	28268693          	addi	a3,a3,642 # ffffffffc020b658 <etext+0x28>
ffffffffc020b3de:	8626                	mv	a2,s1
ffffffffc020b3e0:	85ca                	mv	a1,s2
ffffffffc020b3e2:	854e                	mv	a0,s3
ffffffffc020b3e4:	0d4000ef          	jal	ra,ffffffffc020b4b8 <printfmt>
ffffffffc020b3e8:	b351                	j	ffffffffc020b16c <vprintfmt+0x34>
ffffffffc020b3ea:	00004697          	auipc	a3,0x4
ffffffffc020b3ee:	09e68693          	addi	a3,a3,158 # ffffffffc020f488 <sfs_node_fileops+0x138>
ffffffffc020b3f2:	8626                	mv	a2,s1
ffffffffc020b3f4:	85ca                	mv	a1,s2
ffffffffc020b3f6:	854e                	mv	a0,s3
ffffffffc020b3f8:	0c0000ef          	jal	ra,ffffffffc020b4b8 <printfmt>
ffffffffc020b3fc:	bb85                	j	ffffffffc020b16c <vprintfmt+0x34>
ffffffffc020b3fe:	00004417          	auipc	s0,0x4
ffffffffc020b402:	08240413          	addi	s0,s0,130 # ffffffffc020f480 <sfs_node_fileops+0x130>
ffffffffc020b406:	85e6                	mv	a1,s9
ffffffffc020b408:	8522                	mv	a0,s0
ffffffffc020b40a:	e442                	sd	a6,8(sp)
ffffffffc020b40c:	132000ef          	jal	ra,ffffffffc020b53e <strnlen>
ffffffffc020b410:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020b414:	01805c63          	blez	s8,ffffffffc020b42c <vprintfmt+0x2f4>
ffffffffc020b418:	6822                	ld	a6,8(sp)
ffffffffc020b41a:	00080a9b          	sext.w	s5,a6
ffffffffc020b41e:	3c7d                	addiw	s8,s8,-1
ffffffffc020b420:	864a                	mv	a2,s2
ffffffffc020b422:	85a6                	mv	a1,s1
ffffffffc020b424:	8556                	mv	a0,s5
ffffffffc020b426:	9982                	jalr	s3
ffffffffc020b428:	fe0c1be3          	bnez	s8,ffffffffc020b41e <vprintfmt+0x2e6>
ffffffffc020b42c:	00044683          	lbu	a3,0(s0)
ffffffffc020b430:	00140a93          	addi	s5,s0,1
ffffffffc020b434:	0006851b          	sext.w	a0,a3
ffffffffc020b438:	daa9                	beqz	a3,ffffffffc020b38a <vprintfmt+0x252>
ffffffffc020b43a:	05e00413          	li	s0,94
ffffffffc020b43e:	b731                	j	ffffffffc020b34a <vprintfmt+0x212>
ffffffffc020b440:	000aa403          	lw	s0,0(s5)
ffffffffc020b444:	bfb1                	j	ffffffffc020b3a0 <vprintfmt+0x268>
ffffffffc020b446:	000ae683          	lwu	a3,0(s5)
ffffffffc020b44a:	4721                	li	a4,8
ffffffffc020b44c:	8ab2                	mv	s5,a2
ffffffffc020b44e:	b581                	j	ffffffffc020b28e <vprintfmt+0x156>
ffffffffc020b450:	000ae683          	lwu	a3,0(s5)
ffffffffc020b454:	4729                	li	a4,10
ffffffffc020b456:	8ab2                	mv	s5,a2
ffffffffc020b458:	bd1d                	j	ffffffffc020b28e <vprintfmt+0x156>
ffffffffc020b45a:	000ae683          	lwu	a3,0(s5)
ffffffffc020b45e:	4741                	li	a4,16
ffffffffc020b460:	8ab2                	mv	s5,a2
ffffffffc020b462:	b535                	j	ffffffffc020b28e <vprintfmt+0x156>
ffffffffc020b464:	9982                	jalr	s3
ffffffffc020b466:	b709                	j	ffffffffc020b368 <vprintfmt+0x230>
ffffffffc020b468:	864a                	mv	a2,s2
ffffffffc020b46a:	85a6                	mv	a1,s1
ffffffffc020b46c:	02d00513          	li	a0,45
ffffffffc020b470:	e042                	sd	a6,0(sp)
ffffffffc020b472:	9982                	jalr	s3
ffffffffc020b474:	6802                	ld	a6,0(sp)
ffffffffc020b476:	8aea                	mv	s5,s10
ffffffffc020b478:	408006b3          	neg	a3,s0
ffffffffc020b47c:	4729                	li	a4,10
ffffffffc020b47e:	bd01                	j	ffffffffc020b28e <vprintfmt+0x156>
ffffffffc020b480:	03805163          	blez	s8,ffffffffc020b4a2 <vprintfmt+0x36a>
ffffffffc020b484:	02d00693          	li	a3,45
ffffffffc020b488:	f6d81be3          	bne	a6,a3,ffffffffc020b3fe <vprintfmt+0x2c6>
ffffffffc020b48c:	00004417          	auipc	s0,0x4
ffffffffc020b490:	ff440413          	addi	s0,s0,-12 # ffffffffc020f480 <sfs_node_fileops+0x130>
ffffffffc020b494:	02800693          	li	a3,40
ffffffffc020b498:	02800513          	li	a0,40
ffffffffc020b49c:	00140a93          	addi	s5,s0,1
ffffffffc020b4a0:	b55d                	j	ffffffffc020b346 <vprintfmt+0x20e>
ffffffffc020b4a2:	00004a97          	auipc	s5,0x4
ffffffffc020b4a6:	fdfa8a93          	addi	s5,s5,-33 # ffffffffc020f481 <sfs_node_fileops+0x131>
ffffffffc020b4aa:	02800513          	li	a0,40
ffffffffc020b4ae:	02800693          	li	a3,40
ffffffffc020b4b2:	05e00413          	li	s0,94
ffffffffc020b4b6:	bd51                	j	ffffffffc020b34a <vprintfmt+0x212>

ffffffffc020b4b8 <printfmt>:
ffffffffc020b4b8:	7139                	addi	sp,sp,-64
ffffffffc020b4ba:	02010313          	addi	t1,sp,32
ffffffffc020b4be:	f03a                	sd	a4,32(sp)
ffffffffc020b4c0:	871a                	mv	a4,t1
ffffffffc020b4c2:	ec06                	sd	ra,24(sp)
ffffffffc020b4c4:	f43e                	sd	a5,40(sp)
ffffffffc020b4c6:	f842                	sd	a6,48(sp)
ffffffffc020b4c8:	fc46                	sd	a7,56(sp)
ffffffffc020b4ca:	e41a                	sd	t1,8(sp)
ffffffffc020b4cc:	c6dff0ef          	jal	ra,ffffffffc020b138 <vprintfmt>
ffffffffc020b4d0:	60e2                	ld	ra,24(sp)
ffffffffc020b4d2:	6121                	addi	sp,sp,64
ffffffffc020b4d4:	8082                	ret

ffffffffc020b4d6 <snprintf>:
ffffffffc020b4d6:	711d                	addi	sp,sp,-96
ffffffffc020b4d8:	15fd                	addi	a1,a1,-1
ffffffffc020b4da:	03810313          	addi	t1,sp,56
ffffffffc020b4de:	95aa                	add	a1,a1,a0
ffffffffc020b4e0:	f406                	sd	ra,40(sp)
ffffffffc020b4e2:	fc36                	sd	a3,56(sp)
ffffffffc020b4e4:	e0ba                	sd	a4,64(sp)
ffffffffc020b4e6:	e4be                	sd	a5,72(sp)
ffffffffc020b4e8:	e8c2                	sd	a6,80(sp)
ffffffffc020b4ea:	ecc6                	sd	a7,88(sp)
ffffffffc020b4ec:	e01a                	sd	t1,0(sp)
ffffffffc020b4ee:	e42a                	sd	a0,8(sp)
ffffffffc020b4f0:	e82e                	sd	a1,16(sp)
ffffffffc020b4f2:	cc02                	sw	zero,24(sp)
ffffffffc020b4f4:	c515                	beqz	a0,ffffffffc020b520 <snprintf+0x4a>
ffffffffc020b4f6:	02a5e563          	bltu	a1,a0,ffffffffc020b520 <snprintf+0x4a>
ffffffffc020b4fa:	75dd                	lui	a1,0xffff7
ffffffffc020b4fc:	86b2                	mv	a3,a2
ffffffffc020b4fe:	00000517          	auipc	a0,0x0
ffffffffc020b502:	c2050513          	addi	a0,a0,-992 # ffffffffc020b11e <sprintputch>
ffffffffc020b506:	871a                	mv	a4,t1
ffffffffc020b508:	0030                	addi	a2,sp,8
ffffffffc020b50a:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020b50e:	c2bff0ef          	jal	ra,ffffffffc020b138 <vprintfmt>
ffffffffc020b512:	67a2                	ld	a5,8(sp)
ffffffffc020b514:	00078023          	sb	zero,0(a5)
ffffffffc020b518:	4562                	lw	a0,24(sp)
ffffffffc020b51a:	70a2                	ld	ra,40(sp)
ffffffffc020b51c:	6125                	addi	sp,sp,96
ffffffffc020b51e:	8082                	ret
ffffffffc020b520:	5575                	li	a0,-3
ffffffffc020b522:	bfe5                	j	ffffffffc020b51a <snprintf+0x44>

ffffffffc020b524 <strlen>:
ffffffffc020b524:	00054783          	lbu	a5,0(a0)
ffffffffc020b528:	872a                	mv	a4,a0
ffffffffc020b52a:	4501                	li	a0,0
ffffffffc020b52c:	cb81                	beqz	a5,ffffffffc020b53c <strlen+0x18>
ffffffffc020b52e:	0505                	addi	a0,a0,1
ffffffffc020b530:	00a707b3          	add	a5,a4,a0
ffffffffc020b534:	0007c783          	lbu	a5,0(a5)
ffffffffc020b538:	fbfd                	bnez	a5,ffffffffc020b52e <strlen+0xa>
ffffffffc020b53a:	8082                	ret
ffffffffc020b53c:	8082                	ret

ffffffffc020b53e <strnlen>:
ffffffffc020b53e:	4781                	li	a5,0
ffffffffc020b540:	e589                	bnez	a1,ffffffffc020b54a <strnlen+0xc>
ffffffffc020b542:	a811                	j	ffffffffc020b556 <strnlen+0x18>
ffffffffc020b544:	0785                	addi	a5,a5,1
ffffffffc020b546:	00f58863          	beq	a1,a5,ffffffffc020b556 <strnlen+0x18>
ffffffffc020b54a:	00f50733          	add	a4,a0,a5
ffffffffc020b54e:	00074703          	lbu	a4,0(a4)
ffffffffc020b552:	fb6d                	bnez	a4,ffffffffc020b544 <strnlen+0x6>
ffffffffc020b554:	85be                	mv	a1,a5
ffffffffc020b556:	852e                	mv	a0,a1
ffffffffc020b558:	8082                	ret

ffffffffc020b55a <strcpy>:
ffffffffc020b55a:	87aa                	mv	a5,a0
ffffffffc020b55c:	0005c703          	lbu	a4,0(a1)
ffffffffc020b560:	0785                	addi	a5,a5,1
ffffffffc020b562:	0585                	addi	a1,a1,1
ffffffffc020b564:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b568:	fb75                	bnez	a4,ffffffffc020b55c <strcpy+0x2>
ffffffffc020b56a:	8082                	ret

ffffffffc020b56c <strcmp>:
ffffffffc020b56c:	00054783          	lbu	a5,0(a0)
ffffffffc020b570:	0005c703          	lbu	a4,0(a1)
ffffffffc020b574:	cb89                	beqz	a5,ffffffffc020b586 <strcmp+0x1a>
ffffffffc020b576:	0505                	addi	a0,a0,1
ffffffffc020b578:	0585                	addi	a1,a1,1
ffffffffc020b57a:	fee789e3          	beq	a5,a4,ffffffffc020b56c <strcmp>
ffffffffc020b57e:	0007851b          	sext.w	a0,a5
ffffffffc020b582:	9d19                	subw	a0,a0,a4
ffffffffc020b584:	8082                	ret
ffffffffc020b586:	4501                	li	a0,0
ffffffffc020b588:	bfed                	j	ffffffffc020b582 <strcmp+0x16>

ffffffffc020b58a <strncmp>:
ffffffffc020b58a:	c20d                	beqz	a2,ffffffffc020b5ac <strncmp+0x22>
ffffffffc020b58c:	962e                	add	a2,a2,a1
ffffffffc020b58e:	a031                	j	ffffffffc020b59a <strncmp+0x10>
ffffffffc020b590:	0505                	addi	a0,a0,1
ffffffffc020b592:	00e79a63          	bne	a5,a4,ffffffffc020b5a6 <strncmp+0x1c>
ffffffffc020b596:	00b60b63          	beq	a2,a1,ffffffffc020b5ac <strncmp+0x22>
ffffffffc020b59a:	00054783          	lbu	a5,0(a0)
ffffffffc020b59e:	0585                	addi	a1,a1,1
ffffffffc020b5a0:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020b5a4:	f7f5                	bnez	a5,ffffffffc020b590 <strncmp+0x6>
ffffffffc020b5a6:	40e7853b          	subw	a0,a5,a4
ffffffffc020b5aa:	8082                	ret
ffffffffc020b5ac:	4501                	li	a0,0
ffffffffc020b5ae:	8082                	ret

ffffffffc020b5b0 <strchr>:
ffffffffc020b5b0:	00054783          	lbu	a5,0(a0)
ffffffffc020b5b4:	c799                	beqz	a5,ffffffffc020b5c2 <strchr+0x12>
ffffffffc020b5b6:	00f58763          	beq	a1,a5,ffffffffc020b5c4 <strchr+0x14>
ffffffffc020b5ba:	00154783          	lbu	a5,1(a0)
ffffffffc020b5be:	0505                	addi	a0,a0,1
ffffffffc020b5c0:	fbfd                	bnez	a5,ffffffffc020b5b6 <strchr+0x6>
ffffffffc020b5c2:	4501                	li	a0,0
ffffffffc020b5c4:	8082                	ret

ffffffffc020b5c6 <memset>:
ffffffffc020b5c6:	ca01                	beqz	a2,ffffffffc020b5d6 <memset+0x10>
ffffffffc020b5c8:	962a                	add	a2,a2,a0
ffffffffc020b5ca:	87aa                	mv	a5,a0
ffffffffc020b5cc:	0785                	addi	a5,a5,1
ffffffffc020b5ce:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020b5d2:	fec79de3          	bne	a5,a2,ffffffffc020b5cc <memset+0x6>
ffffffffc020b5d6:	8082                	ret

ffffffffc020b5d8 <memmove>:
ffffffffc020b5d8:	02a5f263          	bgeu	a1,a0,ffffffffc020b5fc <memmove+0x24>
ffffffffc020b5dc:	00c587b3          	add	a5,a1,a2
ffffffffc020b5e0:	00f57e63          	bgeu	a0,a5,ffffffffc020b5fc <memmove+0x24>
ffffffffc020b5e4:	00c50733          	add	a4,a0,a2
ffffffffc020b5e8:	c615                	beqz	a2,ffffffffc020b614 <memmove+0x3c>
ffffffffc020b5ea:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020b5ee:	17fd                	addi	a5,a5,-1
ffffffffc020b5f0:	177d                	addi	a4,a4,-1
ffffffffc020b5f2:	00d70023          	sb	a3,0(a4)
ffffffffc020b5f6:	fef59ae3          	bne	a1,a5,ffffffffc020b5ea <memmove+0x12>
ffffffffc020b5fa:	8082                	ret
ffffffffc020b5fc:	00c586b3          	add	a3,a1,a2
ffffffffc020b600:	87aa                	mv	a5,a0
ffffffffc020b602:	ca11                	beqz	a2,ffffffffc020b616 <memmove+0x3e>
ffffffffc020b604:	0005c703          	lbu	a4,0(a1)
ffffffffc020b608:	0585                	addi	a1,a1,1
ffffffffc020b60a:	0785                	addi	a5,a5,1
ffffffffc020b60c:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b610:	fed59ae3          	bne	a1,a3,ffffffffc020b604 <memmove+0x2c>
ffffffffc020b614:	8082                	ret
ffffffffc020b616:	8082                	ret

ffffffffc020b618 <memcpy>:
ffffffffc020b618:	ca19                	beqz	a2,ffffffffc020b62e <memcpy+0x16>
ffffffffc020b61a:	962e                	add	a2,a2,a1
ffffffffc020b61c:	87aa                	mv	a5,a0
ffffffffc020b61e:	0005c703          	lbu	a4,0(a1)
ffffffffc020b622:	0585                	addi	a1,a1,1
ffffffffc020b624:	0785                	addi	a5,a5,1
ffffffffc020b626:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b62a:	fec59ae3          	bne	a1,a2,ffffffffc020b61e <memcpy+0x6>
ffffffffc020b62e:	8082                	ret
