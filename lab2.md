## 练习2：实现 Best-Fit 连续物理内存分配算法（需要编程）
### 实验要求
在完成练习一后，参考kern/mm/default_pmm.c对First Fit算法的实现，编程实现Best Fit页面分配算法，算法的时空复杂度不做要求，能通过测试即可。 请在实验报告中简要说明你的设计实现过程，阐述代码是如何对物理内存进行分配和释放，并回答如下问题：

- 你的 Best-Fit 算法是否有进一步的改进空间？

### 实现原理
Best-Fit算法的核心思想是每次分配内存时，选择最小的能够满足请求的空闲块，从而减少内存碎片。
而我们的实验是按内存地址排序的链表，并通过完整遍历来找到最佳块。简单来说就是，遍历寻找满足要求的块，在满足要求的块中选择最小的块进行分配。

### 实验过程
本次实验中，我们需要填写5个代码块，可以参考first fit算法的实现，来补充代码，代码分别是：
```c
for (; p != base + n; p ++) {
        assert(PageReserved(p));
        p->flags = 0; 
        set_page_ref(p, 0); 
        ClearPageProperty(p); 
    }
```
这段代码是将一段连续的页框（从base开始，共n个）初始化为未保留状态，并清除它们的标志和属性信息，同时将引用计数设置为0。

```c
 while ((le = list_next(le)) != &free_list) {
            struct Page* page = le2page(le, page_link);
            if (base < page) {
                list_add_before(le, &(base->page_link)); 
                break; 
            } else if (list_next(le) == &free_list) {
                list_add(le, &(base->page_link)); 
            }

        }
```
这段代码是将一个空闲内存块（base）按地址顺序插入到空闲链表中，保持链表的地址有序性。


```c
while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        if (p->property >= n) {
            if (p->property < min_size) {
                page = p;
                min_size = p->property; 
        }
    }
```
这段代码是遍历空闲链表，寻找最小的能够满足请求的空闲块（即property >= n且property最小的块），并将其赋值给page变量。


```c
    base->property = n; 
    SetPageProperty(base);
    nr_free += n;
```
这段代码是将一个页块（base）标记为包含n个连续页框的空闲块，并更新系统中空闲页框的总数。

```c
list_entry_t* le = list_prev(&(base->page_link));
    if (le != &free_list) {
        p = le2page(le, page_link);
        if (p + p->property == base) {
            p->property += base->property; 
            ClearPageProperty(base); 
            list_del(&(base->page_link)); 
            base = p; 
        }
    }
```
这段代码是检查并合并当前释放的页块（base）与其前面的空闲页块（p），如果它们是连续的，则将它们合并为一个更大的空闲块，并更新链表和属性信息。

我们还需要对pmm.c中的代码进行修改：
```c
static void init_pmm_manager(void) {
    pmm_manager = &best_fit_pmm_manager;
    cprintf("memory management: %s\n", pmm_manager->name);
    pmm_manager->init();
}
```
这段代码是初始化物理内存管理器，将当前的内存管理器设置为Best-Fit算法的实现，并调用其初始化函数。
我们在lab2文件夹中通过终端，输入指令：
```bash
make grade
```
来对代码进行编译和测试，测试通过后，说明代码实现正确。
以下是测试通过的截图：
![ex2](./images/gdb1.png)

## Challenge1：buddy system(伙伴系统)分配算法(需要编程)
### 实验要求
Buddy System算法把系统中的可用存储空间划分为存储块(Block)来进行管理, 每个存储块的大小必须是2的n次幂(Pow(2, n)), 即1, 2, 4, 8, 16, 32, 64, 128...等。每次分配内存时，系统会选择一个最小的能够满足请求的存储块，如果没有合适大小的存储块，则从更大的存储块中拆分出一个合适大小的存储块进行分配。释放内存时，如果相邻的存储块都是空闲的，则将它们合并为一个更大的存储块。

### 实现原理
Buddy System算法通过将内存划分为2的n次幂大小的块来管理内存，从而减少内存碎片。每次分配内存时，系统会选择一个最小的能够满足请求的块，如果没有合适大小的块，则从更大的块中拆分出一个合适大小的块进行分配。释放内存时，如果相邻的块都是空闲的，则将它们合并为一个更大的块。

### 具体实现

#### 数据结构设计
我们设计了如下的数据结构来实现Buddy System算法：

```c
struct buddy2 {
  unsigned size;// 管理内存的总单元数目
  unsigned longest[1];// 每个节点记录该节点所管理的内存块中最大空闲块的大小   
};

typedef struct{
    Page* base; // buddy system内存池的起始地址
    buddy2* root; // buddy system内存池的管理结构
    unsigned int nr_free; // 空闲页数
    unsigned int total_size; // 总页数
} buddy_system_t;
```

#### 初始化
初始化buddy_system结构体的各个字段，buddy2结构体的longest数组，构建二叉树，会将管理的内存块数量调整为小于等于n的最大2的幂次方

```c
static void
buddy_system_init_memmap(struct Page *base, size_t n)
{
    //cprintf("Buddy System Physical Memory Manager Memmap Init Start\n");
    assert(n > 0);
    struct Page *p = base;
    for (; p != base + n; p++)
    {
        assert(PageReserved(p));
        p->flags = p->property = 0;
        set_page_ref(p, 0);
    }

    buddy_base = base;
    buddy_total_size = n;
    //cprintf("buddy_total_size: %u\n", buddy_total_size);
    unsigned int size = alt_fixsize(n);
    //cprintf("size: %u\n", size);
    buddy_nr_free = size;
    //cprintf("buddy_nr_free: %u\n", buddy_nr_free);
    unsigned int len = size * 2 - 1;
    buddy_root = (buddy2 *)KADDR(page2pa(base)); // buddy2结构紧跟在Page数组后面
    buddy_root->size = size;
    /*
    初始化buddy2结构
    由于n可能不是2的幂次方，因此需要将管理的单元数目减少为小于等于n的最小2的幂次方
    longest数组的长度为2*size-1,前size-1个元素用于存储非叶子节点的信息，后size个元素用于存储叶子节点的信息
    */
    for (unsigned int i = 0; i < len; i++)
    {
        buddy_root->longest[i] = 1;
    }
    for (int i = size - 2; i >= 0; i--)
    {
        buddy_root->longest[i] = buddy_root->longest[LEFT_LEAF(i)] * 2;
    }

    //cprintf("w\n%u\n", buddy_root->longest[32767]);
    //cprintf("w\n%u\n", buddy_root->longest[0]);
    //cprintf("w\n%u\n", buddy_root->longest[1]);
    //cprintf("w\n%u\n", buddy_root->longest[2]);
    buddy_base->property = size;
    SetPageProperty(buddy_base);
    //cprintf("Buddy System Physical Memory Manager Memmap Init OK\n");
}
```

#### 分配内存
首先根据请求的内存大小调整为2的幂次方，并且判断是否有足够的空闲页，如果没有则返回NULL，然后进行适配搜索，深度优先遍历，当找到对应节点后，将其longest标记为0，即分离适配的块出来，并转换为内存块索引offset，之后获取到page指针，更新nr_free字段，并且沿着路径更新longest数组

```c
static struct Page *
buddy_system_alloc_pages(size_t n)
{
    //cprintf("Buddy System Physical Memory Manager Alloc Start\n");
    unsigned int index = 0;
    unsigned int node_size;
    unsigned int offset = 0;
    struct Page *page = NULL;
    assert(n > 0);
    if (n > buddy_nr_free)
    {
        return NULL;
    }
    if (!IS_POWER_OF_2(n))
    {
        n = fixsize(n);
    }

    if (buddy_root->longest[index] < n)
    {
        return NULL;
    }

    for(node_size = buddy_root->size; node_size != n; node_size /= 2)
    {
        if(buddy_root->longest[LEFT_LEAF(index)] >= n)
            index = LEFT_LEAF(index);
        else
            index = RIGHT_LEAF(index);
    }

    buddy_root->longest[index] = 0;
    offset = (index + 1) * node_size - buddy_root->size;
    cprintf("index:%u\n", index);
    cprintf("offset:%u\n", offset);

    page = buddy_base + offset;
    page->property = 0;
    ClearPageProperty(page);
    buddy_nr_free -= n;
    if( index%2==1 && buddy_root->longest[index+1]==node_size) 
        {
            struct Page* right = buddy_base + offset + node_size;
            right->property = node_size;
            SetPageProperty(right);            
        }

    while(index)
    {
        index = PARENT(index);
        node_size *= 2;
        offset = (index + 1) * node_size - buddy_root->size;
        buddy_root->longest[index] = MAX(buddy_root->longest[LEFT_LEAF(index)], buddy_root->longest[RIGHT_LEAF(index)]);
        if( index%2==1 && buddy_root->longest[index+1]==node_size) 
        {
            struct Page* right = buddy_base + offset + node_size;
            right->property = node_size;
            SetPageProperty(right);            
        }
    }
   
    //cprintf("Buddy System Physical Memory Manager Alloc OK\n");
    return page;
}
```

#### 释放内存
同样首先根据释放的页数n，调整为大于等于n的最小2的幂次方，若页面不是保留的，也不是空闲块的第一个页面，则将其置为空闲状态，之后计算释放的内存块在二叉树中的位置，更新longest数组，标记释放的内存块为可用，并尝试合并相邻的空闲块

```c
static void
buddy_system_free_pages(struct Page *base, size_t n)
{
    //cprintf("Buddy System Physical Memory Manager Free Start\n");
    unsigned int index = 0;
    unsigned int node_size = n;
    unsigned int offset = 0;
    struct Page *p = base;

    assert(n > 0);
    if (!IS_POWER_OF_2(n))
    {
        n = fixsize(n);
        node_size = n;
    }
    for (; p != base + n; p++)
    {
        assert(!PageReserved(p) && !PageProperty(p));
        p->flags = 0;
        set_page_ref(p, 0);
    }
    base->property = n;
    SetPageProperty(base);
    buddy_nr_free += n;

    offset = base - buddy_base;
    index = (offset + buddy_root->size) / n - 1;

    buddy_root->longest[index] = n;
    while (index)
    {
        index = PARENT(index);
        if(buddy_root->longest[LEFT_LEAF(index)] == buddy_root->longest[RIGHT_LEAF(index)] && buddy_root->longest[LEFT_LEAF(index)] == node_size)
            {
                buddy_root->longest[index] = buddy_root->longest[LEFT_LEAF(index)] * 2;
                offset = (index + 1) * node_size * 2 - buddy_root->size;
                struct Page* LPage = buddy_base + offset;
                struct Page* RPage = LPage + node_size;
                LPage->property = node_size * 2;
                SetPageProperty(LPage);
                ClearPageProperty(RPage);
            }
        else
            buddy_root->longest[index] = MAX(buddy_root->longest[LEFT_LEAF(index)], buddy_root->longest[RIGHT_LEAF(index)]);
        node_size *= 2;
    }
    //cprintf("Buddy System Physical Memory Manager Free OK\n");
}
```

### 测试

首先输出未分配内存状态下的空闲块信息，如下所示：
```
Buddy System Tree Structure:
Node 0: longest = 16384, 地址为: 0xffffffffc020f318
```
此时，表示整个内存块都是空闲的，大小为16384页。

接下来，分别分配10页和20页内存，并输出分配后的空闲块信息，如下所示：
```
index:1023
offset:0
Allocated 10 pages at 0xffffffffc020f318
Buddy System Tree Structure:
Node 2: longest = 8192, 地址为: 0xffffffffc025f318
Node 4: longest = 4096, 地址为: 0xffffffffc0237318
Node 8: longest = 2048, 地址为: 0xffffffffc0223318
Node 16: longest = 1024, 地址为: 0xffffffffc0219318
Node 32: longest = 512, 地址为: 0xffffffffc0214318
Node 64: longest = 256, 地址为: 0xffffffffc0211b18
Node 128: longest = 128, 地址为: 0xffffffffc0210718
Node 256: longest = 64, 地址为: 0xffffffffc020fd18
Node 512: longest = 32, 地址为: 0xffffffffc020f818
Node 1024: longest = 16, 地址为: 0xffffffffc020f598

index:512
offset:32
Allocated 20 pages at 0xffffffffc020f818
Buddy System Tree Structure:
Node 2: longest = 8192, 地址为: 0xffffffffc025f318
Node 4: longest = 4096, 地址为: 0xffffffffc0237318
Node 8: longest = 2048, 地址为: 0xffffffffc0223318
Node 16: longest = 1024, 地址为: 0xffffffffc0219318
Node 32: longest = 512, 地址为: 0xffffffffc0214318
Node 64: longest = 256, 地址为: 0xffffffffc0211b18
Node 128: longest = 128, 地址为: 0xffffffffc0210718
Node 256: longest = 64, 地址为: 0xffffffffc020fd18
Node 1024: longest = 16, 地址为: 0xffffffffc020f598
```
可以看出，p1分配到了起始地址为0xffffffffc020f318的16页内存，p2分配到了起始地址为0xffffffffc020f818的32页内存。

然后，释放p1所分配的内存，再分配5页内存，并输出的空闲块信息，如下所示：
```
Freed 10 pages at 0xffffffffc020f318
Buddy System Tree Structure:
Node 2: longest = 8192, 地址为: 0xffffffffc025f318
Node 4: longest = 4096, 地址为: 0xffffffffc0237318
Node 8: longest = 2048, 地址为: 0xffffffffc0223318
Node 16: longest = 1024, 地址为: 0xffffffffc0219318
Node 32: longest = 512, 地址为: 0xffffffffc0214318
Node 64: longest = 256, 地址为: 0xffffffffc0211b18
Node 128: longest = 128, 地址为: 0xffffffffc0210718
Node 256: longest = 64, 地址为: 0xffffffffc020fd18
Node 511: longest = 32, 地址为: 0xffffffffc020f318

index:2047
offset:0
Allocated 5 pages at 0xffffffffc020f318
Buddy System Tree Structure:
Node 2: longest = 8192, 地址为: 0xffffffffc025f318
Node 4: longest = 4096, 地址为: 0xffffffffc0237318
Node 8: longest = 2048, 地址为: 0xffffffffc0223318
Node 16: longest = 1024, 地址为: 0xffffffffc0219318
Node 32: longest = 512, 地址为: 0xffffffffc0214318
Node 64: longest = 256, 地址为: 0xffffffffc0211b18
Node 128: longest = 128, 地址为: 0xffffffffc0210718
Node 256: longest = 64, 地址为: 0xffffffffc020fd18
Node 1024: longest = 16, 地址为: 0xffffffffc020f598
Node 2048: longest = 8, 地址为: 0xffffffffc020f458
```
可以看出，释放p1后，空闲块信息得到了更新，随后p3分配到了起始地址为0xffffffffc020f318的8页内存。

接着将p2和p3所分配的内存释放掉，并输出最终的空闲块信息，如下所示：
```
Freed 5 pages at 0xffffffffc020f318
Buddy System Tree Structure:
Node 2: longest = 8192, 地址为: 0xffffffffc025f318
Node 4: longest = 4096, 地址为: 0xffffffffc0237318
Node 8: longest = 2048, 地址为: 0xffffffffc0223318
Node 16: longest = 1024, 地址为: 0xffffffffc0219318
Node 32: longest = 512, 地址为: 0xffffffffc0214318
Node 64: longest = 256, 地址为: 0xffffffffc0211b18
Node 128: longest = 128, 地址为: 0xffffffffc0210718
Node 256: longest = 64, 地址为: 0xffffffffc020fd18
Node 511: longest = 32, 地址为: 0xffffffffc020f318

Freed 20 pages at 0xffffffffc020f818
Buddy System Tree Structure:
Node 0: longest = 16384, 地址为: 0xffffffffc020f318
```
可以看出，释放p2和p3后，整个内存块又变成了一个完整的空闲块，大小为16384页。

之后测试分配兄弟块的情况，分配1页内存两次，并输出空闲块信息，如下所示：
```
index:16383
offset:0
Allocated 1 page at 0xffffffffc020f318
Buddy System Tree Structure:
Node 2: longest = 8192, 地址为: 0xffffffffc025f318
Node 4: longest = 4096, 地址为: 0xffffffffc0237318
Node 8: longest = 2048, 地址为: 0xffffffffc0223318
Node 16: longest = 1024, 地址为: 0xffffffffc0219318
Node 32: longest = 512, 地址为: 0xffffffffc0214318
Node 64: longest = 256, 地址为: 0xffffffffc0211b18
Node 128: longest = 128, 地址为: 0xffffffffc0210718
Node 256: longest = 64, 地址为: 0xffffffffc020fd18
Node 512: longest = 32, 地址为: 0xffffffffc020f818
Node 1024: longest = 16, 地址为: 0xffffffffc020f598
Node 2048: longest = 8, 地址为: 0xffffffffc020f458
Node 4096: longest = 4, 地址为: 0xffffffffc020f3b8
Node 8192: longest = 2, 地址为: 0xffffffffc020f368
Node 16384: longest = 1, 地址为: 0xffffffffc020f340

index:16384
offset:1
Allocated 1 page at 0xffffffffc020f340
Buddy System Tree Structure:
Node 2: longest = 8192, 地址为: 0xffffffffc025f318
Node 4: longest = 4096, 地址为: 0xffffffffc0237318
Node 8: longest = 2048, 地址为: 0xffffffffc0223318
Node 16: longest = 1024, 地址为: 0xffffffffc0219318
Node 32: longest = 512, 地址为: 0xffffffffc0214318
Node 64: longest = 256, 地址为: 0xffffffffc0211b18
Node 128: longest = 128, 地址为: 0xffffffffc0210718
Node 256: longest = 64, 地址为: 0xffffffffc020fd18
Node 512: longest = 32, 地址为: 0xffffffffc020f818
Node 1024: longest = 16, 地址为: 0xffffffffc020f598
Node 2048: longest = 8, 地址为: 0xffffffffc020f458
Node 4096: longest = 4, 地址为: 0xffffffffc020f3b8
Node 8192: longest = 2, 地址为: 0xffffffffc020f368
```
可以看出，p4分配到了起始地址为0xffffffffc020f318的1页内存，p5分配到了起始地址为0xffffffffc020f340的1页内存，它们是相邻的兄弟块。

最后，释放p4和p5所分配的内存，分配最大块内存，并输出最终的空闲块信息，如下所示：
```
index:0
offset:0
Allocated 16384 pages at 0xffffffffc020f318
Buddy System Tree Structure:


```
可以看出，释放p4和p5并分配最大块内存后，没有任何空闲块，整个内存块都被分配出去。

## Challenge3：硬件的可用物理内存范围的获取方法（思考题）
如果 OS 无法提前知道当前硬件的可用物理内存范围，请问你有何办法让 OS 获取可用物理内存范围？

1.操作系统可以通过 BIOS/UEFI 固件接口获取硬件信息，包括可用的物理内存范围。
2.操作系统还可以通过扫描物理地址空间来识别有效的内存区域。例如，操作系统可以尝试在启动时扫描一系列地址范围，以确定哪些地址范围是有效的。
