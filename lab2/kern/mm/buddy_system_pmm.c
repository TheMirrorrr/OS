/*LAB2 EXERCISE 2: 2312823 CODE*/

/*
Buddy System物理内存管理器设计文档
设计参考了伙伴分配器的一个极简实现-http://coolshell.cn/articles/10427.html，和https://github.com/1973315112/OS/blob/main/lab2/kern/mm/buddy_system_pmm.c
并且通过copilot辅助生成部分代码
一、数据结构设计
详细见memlayout.h中的buddy2和buddy_system结构体
1. buddy2结构体
    - size: 管理的最大内存块大小，必须是2的幂次方
    - longest[]: 存储二叉树中每个节点所管理的最大空闲内存块大小
2. buddy_system结构体
    - base: 指向管理的物理页数组的起始地址
    - root: 指向buddy2结构体的指针
    - nr_free: 当前空闲的物理页数量
    - total_size: 总的物理页数量
二、算法设计
1. 初始化：初始化buddy_system结构体的各个字段，buddy2结构体的longest数组，构建二叉树，会将管理的内存块数量调整为小于等于n的最大2的幂次方
2. 分配内存：首先根据请求的内存大小调整为2的幂次方，并且判断是否有足够的空闲页，如果没有则返回NULL，然后进行适配搜索，深度优先遍历，当找到对应节点后，
   将其longest标记为0，即分离适配的块出来，并转换为内存块索引offset，之后获取到page指针，更新nr_free字段，并且沿着路径更新longest数组
   （如果当前节点是左节点，且右节点对应内存块完整，将右节点对应内存块拆分，但实际操作中不添加判断不会造成明显问题）
3. 释放内存：同样首先根据释放的页数n，调整为大于等于n的最小2的幂次方，若页面不是保留的，也不是空闲块的第一个页面，则将其置为空闲状态
   之后计算释放的内存块在二叉树中的位置，更新longest数组，标记释放的内存块为可用，并尝试合并相邻的空闲块
4. 查询空闲页数：直接返回buddy_system结构体中的nr_free字段
5. 空闲块的检测：设计了test_tree_structure函数，用于打印当前二叉树的状态，打印所有longest=buddy_root->size/对应层级的节点，
   若节点的父节点longest值为子节点的两倍或0，则不打印子节点，并且打印对应页的地址。
三、测试设计
1. 分配非兄弟节点测试：分配两个非兄弟节点的内存块，检查分配结果和二叉树状态
2. 释放后分配测试：释放之前分配的内存块，然后分配一个较小的内存块，检查分配结果和二叉树状态
3. 分配兄弟节点测试：分配两个兄弟节点的内存块，检查分配结果和二叉树状态
4. 分配最大块测试：分配整个管理范围内的最大内存块，检查分配结果和二叉树状态
*/

#include <pmm.h>
#include <list.h>
#include <string.h>
#include <stdio.h>
#include <buddy_system_pmm.h>

static buddy_system_t buddy_system;

#define buddy_base (buddy_system.base)
#define buddy_root (buddy_system.root)
#define buddy_nr_free (buddy_system.nr_free)
#define buddy_total_size (buddy_system.total_size)
#define LEFT_LEAF(index) ((index) * 2 + 1)
#define RIGHT_LEAF(index) ((index) * 2 + 2)
#define PARENT(index) (((index) + 1) / 2 - 1)

#define IS_POWER_OF_2(x) (!((x) & ((x) - 1)))
#define MAX(a, b) ((a) > (b) ? (a) : (b))

/*
 * fixsize - 将 size 调整为大于等于 size 的最小的 2 的幂次方
 *
*/
    static unsigned fixsize(unsigned size)
{
    size |= size >> 1;
    size |= size >> 2;
    size |= size >> 4;
    size |= size >> 8;
    size |= size >> 16;
    return size + 1;
}

/*
 * alt_fixsize - 将 size 调整为小于等于 size 的最小的 2 的幂次方
 *
*/
static unsigned alt_fixsize(unsigned size)
{
    unsigned res = 1;
    while (res <= size)
    {
        res <<= 1;
    }
    return res >> 1;
}

static void
buddy_system_init(void)
{
    buddy_base = NULL;
    buddy_root = NULL;
    buddy_nr_free = 0;
    buddy_total_size = 0;
    //cprintf("Buddy System Physical Memory Manager Init\n");
}

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

static size_t
buddy_system_nr_free_pages(void)
{
    cprintf("Buddy System Physical Memory Manager Nr Free OK\n");
    cprintf("Buddy System Free Pages: %d\n", buddy_nr_free);
    return buddy_nr_free;
}

/*
用于打印此时二叉树状态
打印所有longest=buddy_root->size/对应层级的节点，若节点的父节点longest值为子节点的两倍或0，则不打印子节点
并且打印对应页的地址
*/
static void
test_tree_structure(void)
{
    cprintf("Buddy System Tree Structure:\n");
    unsigned int size = buddy_root->size;
    unsigned int len = size * 2 - 1;
    for (unsigned int i = 0; i < len; i++)
    {
        if ((buddy_root->longest[i] == buddy_root->size/alt_fixsize(i+1)))
        {
            unsigned int parent = PARENT(i);
            if (i == 0 || ((buddy_root->longest[parent] != buddy_root->longest[i] * 2)&& (buddy_root->longest[parent] != 0)))
            {
                unsigned int offset = (i + 1) * buddy_root->longest[i] - buddy_root->size;
                struct Page* page = buddy_base + offset;
                cprintf("Node %u: longest = %u, 地址为: %p\n", i, buddy_root->longest[i], page);
            }
        }
    }
    cprintf("\n");
}

static void
buddy_system_check(void)
{
    cprintf("Buddy System Physical Memory Manager Check Start\n");
    test_tree_structure();
    struct Page *p1, *p2, *p3, *p4;

    //分配非兄弟节点测试
    p1 = alloc_pages(10);
    assert(p1 != NULL);
    cprintf("Allocated 10 pages at %p\n", p1);
    test_tree_structure();

    p2 = alloc_pages(20);
    assert(p2 != NULL);
    cprintf("Allocated 20 pages at %p\n", p2);
    test_tree_structure();

    assert(page_ref(p1) == 0 && page_ref(p2) == 0);
    assert(page2pa(p1) < npage * PGSIZE);
    assert(page2pa(p2) < npage * PGSIZE);
    assert(p2 == p1 + 32);
    assert(!PageReserved(p1) && !PageProperty(p1));
    assert(!PageReserved(p2) && !PageProperty(p2));

    //释放后分配测试
    free_pages(p1, 10);
    cprintf("Freed 10 pages at %p\n", p1);
    test_tree_structure();

    p3 = alloc_pages(5);
    assert(p3 != NULL);
    cprintf("Allocated 5 pages at %p\n", p3);
    test_tree_structure();

    free_pages(p3, 5);
    cprintf("Freed 5 pages at %p\n", p3);
    test_tree_structure();

    free_pages(p2, 20);
    cprintf("Freed 20 pages at %p\n", p2);
    test_tree_structure();

    //分配兄弟节点测试
    p3 = alloc_pages(1);
    assert(p3 != NULL);
    cprintf("Allocated 1 page at %p\n", p3);
    test_tree_structure();
    assert(!PageProperty(p3) && PageProperty(p3 + 1));

    p4 = alloc_pages(1);
    assert(p4 != NULL);
    cprintf("Allocated 1 page at %p\n", p4);
    test_tree_structure();

    free_pages(p3, 1);
    free_pages(p4, 1);
    test_tree_structure();

    //分配最大块测试
    p1 = alloc_pages(buddy_root->size);
    assert(p1 != NULL);
    cprintf("Allocated %u pages at %p\n", buddy_root->size, p1);
    test_tree_structure();
    free_pages(p1, buddy_root->size);
    cprintf("Freed %u pages at %p\n", buddy_root->size, p1);
    test_tree_structure();

    cprintf("Buddy System Physical Memory Manager Check OK\n");
}

const struct pmm_manager buddy_system_pmm_manager = 
{
    .name = "buddy_system_pmm_manager",
    .init = buddy_system_init,
    .init_memmap = buddy_system_init_memmap,
    .alloc_pages = buddy_system_alloc_pages,
    .free_pages = buddy_system_free_pages,
    .nr_free_pages = buddy_system_nr_free_pages,
    .check = buddy_system_check,
};
