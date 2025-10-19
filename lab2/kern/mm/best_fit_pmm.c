#include <pmm.h>
#include <list.h>
#include <string.h>
#include <best_fit_pmm.h>
#include <stdio.h>

/* 在首次适应算法中，分配器维护一个空闲块列表（称为空闲链表），
   当接收到内存请求时，沿着列表扫描寻找第一个足够大的块来满足请求。
   如果所选块明显大于请求的大小，则通常会进行分割，剩余部分作为另一个空闲块添加到列表中。
   请参考严蔚敏中文版《数据结构——C语言》第196~198页，第8.2节。
*/
// LAB2 练习1：你的代码
// 你需要重写以下函数：default_init, default_init_memmap, default_alloc_pages, default_free_pages。

/*
 * FFMA（首次适应内存分配）的详细说明
 * (1) 准备：为了实现首次适应内存分配（FFMA），我们应该使用某种链表来管理空闲内存块。
 *             结构体 free_area_t 用于管理空闲内存块。首先你应该
 *             熟悉 list.h 中的 struct list。struct list 是一个简单的双向链表实现。
 *             你应该知道如何使用：list_init, list_add(list_add_after), list_add_before, list_del, list_next, list_prev
 *             另一个技巧是将通用链表结构转换为特殊结构（如 struct page）：
 *             你可以找到一些宏：le2page（在 memlayout.h 中），（在后续实验中：le2vma（在 vmm.h 中），le2proc（在 proc.h 中）等）
 * (2) default_init：你可以重用的演示 default_init 函数来初始化 free_list 并设置 nr_free 为 0。
 *             free_list 用于记录空闲内存块。nr_free 是空闲内存块的总数。
 * (3) default_init_memmap：调用图：kern_init --> pmm_init-->page_init-->init_memmap--> pmm_manager->init_memmap
 *             此函数用于初始化一个空闲块（参数为：addr_base, page_number）。
 *             首先你应该初始化此空闲块中的每个页面（在 memlayout.h 中），包括：
 *                 p->flags 应设置位 PG_property（表示此页面有效。在 pmm_init 函数（在 pmm.c 中）中，
 *                 位 PG_reserved 已在 p->flags 中设置）
 *                 如果此页面是空闲的且不是空闲块的第一页，p->property 应设置为 0。
 *                 如果此页面是空闲的且是空闲块的第一页，p->property 应设置为块的总数。
 *                 p->ref 应为 0，因为现在 p 是空闲的且没有引用。
 *                 我们可以使用 p->page_link 将此页面链接到 free_list，（例如：list_add_before(&free_list, &(p->page_link));）
 *             最后，我们应该累加空闲内存块的数量：nr_free+=n
 * (4) default_alloc_pages：在空闲列表中搜索找到第一个空闲块（块大小 >=n）并调整空闲块大小，返回分配块的地址。
 *             (4.1) 因此你应该像这样搜索空闲列表：
 *                      list_entry_t le = &free_list;
 *                      while((le=list_next(le)) != &free_list) {
 *                      ....
 *                (4.1.1) 在 while 循环中，获取 struct page 并检查 p->property（记录的空闲块数量）>=n？
 *                      struct Page *p = le2page(le, page_link);
 *                      if(p->property >= n){ ...
 *                (4.1.2) 如果我们找到这个 p，那么意味着我们找到了一个空闲块（块大小 >=n），并且前 n 个页面可以被分配。
 *                    应设置此页面的一些标志位：PG_reserved =1, PG_property =0
 *                    从 free_list 中取消链接这些页面
 *                    (4.1.2.1) 如果 (p->property >n)，我们应该重新计算此空闲块剩余部分的数量，
 *                          （例如：le2page(le,page_link))->property = p->property - n;）
 *                (4.1.3) 重新计算 nr_free（所有空闲块剩余部分的数量）
 *                (4.1.4) 返回 p
 *              (4.2) 如果我们找不到空闲块（块大小 >=n），则返回 NULL
 * (5) default_free_pages：将页面重新链接到空闲列表中，可能将小空闲块合并成大空闲块。
 *              (5.1) 根据收回块的基地址，搜索空闲列表，找到正确的位置
 *                    （从低地址到高地址），并插入页面。（可能使用 list_next, le2page, list_add_before）
 *              (5.2) 重置页面的字段，例如 p->ref, p->flags (PageProperty)
 *              (5.3) 尝试合并低地址或高地址的块。注意：应正确更改某些页面的 p->property。
 */
static free_area_t free_area;

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

static void
best_fit_init(void) {
    list_init(&free_list);
    nr_free = 0;
}

static void
best_fit_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    struct Page *p = base;
    for (; p != base + n; p ++) {
        assert(PageReserved(p));
        /*LAB2 EXERCISE 2: 2310511*/ 
        // 清空当前页框的标志和属性信息，并将页框的引用计数设置为0
        p->flags = 0; //清空当前页框的标志
        set_page_ref(p, 0); //将页框的引用计数设置为0
        ClearPageProperty(p); //清除当前页框的属性信息
    }
    base->property = n;
    SetPageProperty(base);
    nr_free += n;
    if (list_empty(&free_list)) {
        list_add(&free_list, &(base->page_link));
    } else {
        list_entry_t* le = &free_list;
        while ((le = list_next(le)) != &free_list) {
            struct Page* page = le2page(le, page_link);
            /*LAB2 EXERCISE 2: YOUR 2310511*/ 
            // 编写代码
            // 1、当base < page时，找到第一个大于base的页，将base插入到它前面，并退出循环
            // 2、当list_next(le) == &free_list时，若已经到达链表结尾，将base插入到链表尾部
            if (base < page) {
                list_add_before(le, &(base->page_link)); //将base插入到第一个大于base的页前面
                break; //退出循环
            } else if (list_next(le) == &free_list) {
                list_add(le, &(base->page_link)); //将base插入到链表尾部
            }

        }
    }
}

static struct Page *
best_fit_alloc_pages(size_t n) {
    assert(n > 0);
    if (n > nr_free) {
        return NULL;
    }
    struct Page *page = NULL;
    list_entry_t *le = &free_list;
    size_t min_size = nr_free + 1;
    /*LAB2 EXERCISE 2: 2310511*/ 
    // 下面的代码是first-fit的部分代码，请修改下面的代码改为best-fit
    // 遍历空闲链表，查找满足需求的空闲页框
    // 如果找到满足需求的页面，记录该页面以及当前找到的最小连续空闲页框数量
    while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        if (p->property >= n) {
            if (p->property < min_size) {
                page = p;
                min_size = p->property; //更新当前找到的最小连续空闲页框数量
            }
        }
    }

    if (page != NULL) {
        list_entry_t* prev = list_prev(&(page->page_link));
        list_del(&(page->page_link));
        if (page->property > n) {
            struct Page *p = page + n;
            p->property = page->property - n;
            SetPageProperty(p);
            list_add(prev, &(p->page_link));
        }
        nr_free -= n;
        ClearPageProperty(page);
    }
    return page;
}

static void
best_fit_free_pages(struct Page *base, size_t n) {
    assert(n > 0);
    struct Page *p = base;
    for (; p != base + n; p ++) {
        assert(!PageReserved(p) && !PageProperty(p));
        p->flags = 0;
        set_page_ref(p, 0);
    }
    /*LAB2 EXERCISE 2: 2310511*/ 
    // 编写代码
    // 具体来说就是设置当前页块的属性为释放的页块数、并将当前页块标记为已分配状态、最后增加nr_free的值
    base->property = n; 
    SetPageProperty(base);
    nr_free += n;


    if (list_empty(&free_list)) {
        list_add(&free_list, &(base->page_link));
    } else {
        list_entry_t* le = &free_list;
        while ((le = list_next(le)) != &free_list) {
            struct Page* page = le2page(le, page_link);
            if (base < page) {
                list_add_before(le, &(base->page_link));
                break;
            } else if (list_next(le) == &free_list) {
                list_add(le, &(base->page_link));
            }
        }
    }

    list_entry_t* le = list_prev(&(base->page_link));
    if (le != &free_list) {
        p = le2page(le, page_link);
        /*LAB2 EXERCISE 2: 2310511*/ 
        // 编写代码
        // 1、判断前面的空闲页块是否与当前页块是连续的，如果是连续的，则将当前页块合并到前面的空闲页块中
        // 2、首先更新前一个空闲页块的大小，加上当前页块的大小
        // 3、清除当前页块的属性标记，表示不再是空闲页块
        // 4、从链表中删除当前页块
        // 5、将指针指向前一个空闲页块，以便继续检查合并后的连续空闲页块
        if (p + p->property == base) {
            p->property += base->property; //更新前一个空闲页块的大小
            ClearPageProperty(base); //清除当前页块的属性标记
            list_del(&(base->page_link)); //从链表中删除当前页块
            base = p; //将指针指向前一个空闲页块
        }
    }

    le = list_next(&(base->page_link));
    if (le != &free_list) {
        p = le2page(le, page_link);
        if (base + base->property == p) {
            base->property += p->property;
            ClearPageProperty(p);
            list_del(&(p->page_link));
        }
    }
}

static size_t
best_fit_nr_free_pages(void) {
    return nr_free;
}

static void
basic_check(void) {
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);

    assert(p0 != p1 && p0 != p2 && p1 != p2);
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);

    assert(page2pa(p0) < npage * PGSIZE);
    assert(page2pa(p1) < npage * PGSIZE);
    assert(page2pa(p2) < npage * PGSIZE);

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    assert(alloc_page() == NULL);

    free_page(p0);
    free_page(p1);
    free_page(p2);
    assert(nr_free == 3);

    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);

    assert(alloc_page() == NULL);

    free_page(p0);
    assert(!list_empty(&free_list));

    struct Page *p;
    assert((p = alloc_page()) == p0);
    assert(alloc_page() == NULL);

    assert(nr_free == 0);
    free_list = free_list_store;
    nr_free = nr_free_store;

    free_page(p);
    free_page(p1);
    free_page(p2);
}

// LAB2：以下代码用于检查最佳适应分配算法（你的练习1）
// 注意：你不应该修改 basic_check 和 default_check 函数！
static void
best_fit_check(void) {
    int score = 0 ,sumscore = 6;
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
        count ++, total += p->property;
    }
    assert(total == nr_free_pages());

    basic_check();

    #ifdef ucore_test
    score += 1;
    cprintf("grading: %d / %d points\n",score, sumscore);
    #endif
    struct Page *p0 = alloc_pages(5), *p1, *p2;
    assert(p0 != NULL);
    assert(!PageProperty(p0));

    #ifdef ucore_test
    score += 1;
    cprintf("grading: %d / %d points\n",score, sumscore);
    #endif
    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);

    #ifdef ucore_test
    score += 1;
    cprintf("grading: %d / %d points\n",score, sumscore);
    #endif
    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    // * - - * -
    free_pages(p0 + 1, 2);
    free_pages(p0 + 4, 1);
    assert(alloc_pages(4) == NULL);
    assert(PageProperty(p0 + 1) && p0[1].property == 2);
    // * - - * *
    assert((p1 = alloc_pages(1)) != NULL);
    assert(alloc_pages(2) != NULL);      // best fit feature
    assert(p0 + 4 == p1);

    #ifdef ucore_test
    score += 1;
    cprintf("grading: %d / %d points\n",score, sumscore);
    #endif
    p2 = p0 + 1;
    free_pages(p0, 5);
    assert((p0 = alloc_pages(5)) != NULL);
    assert(alloc_page() == NULL);

    #ifdef ucore_test
    score += 1;
    cprintf("grading: %d / %d points\n",score, sumscore);
    #endif
    assert(nr_free == 0);
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
    }
    assert(count == 0);
    assert(total == 0);
    #ifdef ucore_test
    score += 1;
    cprintf("grading: %d / %d points\n",score, sumscore);
    #endif
}

const struct pmm_manager best_fit_pmm_manager = {
    .name = "best_fit_pmm_manager",
    .init = best_fit_init,
    .init_memmap = best_fit_init_memmap,
    .alloc_pages = best_fit_alloc_pages,
    .free_pages = best_fit_free_pages,
    .nr_free_pages = best_fit_nr_free_pages,
    .check = best_fit_check,
};

