#ifndef __KERN_MM_MEMLAYOUT_H__
#define __KERN_MM_MEMLAYOUT_H__

/* All physical memory mapped at this address */
#define KERNBASE            0xFFFFFFFFC0200000 // = 0x80200000(物理内存里内核的起始位置, KERN_BEGIN_PADDR) + 0xFFFFFFFF40000000(偏移量, PHYSICAL_MEMORY_OFFSET)
//把原有内存映射到虚拟内存空间的最后一页
#define KMEMSIZE            0x7E00000          // the maximum amount of physical memory
// 0x7E00000 = 0x8000000 - 0x200000
// QEMU 缺省的RAM为 0x80000000到0x88000000, 128MiB, 0x80000000到0x80200000被OpenSBI占用
#define KERNTOP             (KERNBASE + KMEMSIZE) // 0x88000000对应的虚拟地址

#define PHYSICAL_MEMORY_END         0x88000000
#define PHYSICAL_MEMORY_OFFSET      0xFFFFFFFF40000000
#define KERNEL_BEGIN_PADDR          0x80200000
#define KERNEL_BEGIN_VADDR          0xFFFFFFFFC0200000


#define KSTACKPAGE          2                           // # of pages in kernel stack
#define KSTACKSIZE          (KSTACKPAGE * PGSIZE)       // sizeof kernel stack

#ifndef __ASSEMBLER__

#include <defs.h>
#include <list.h>

typedef uintptr_t pte_t;
typedef uintptr_t pde_t;
typedef struct Page Page;     // 前向声明 Page
typedef struct buddy2 buddy2; // typedef buddy2


/* *
 * struct Page - 页描述符结构。每个 Page 描述一个物理页。
 * 在 kern/mm/pmm.h 中，你可以找到许多将 Page 转换为其他数据类型（例如物理地址）的有用函数。
 * */
struct Page {
    int ref;                        // 页框的引用计数器
    uint64_t flags;                 // 描述页框状态的标志数组
    unsigned int property;          // 空闲块的数量，用于首次适配内存管理器
    list_entry_t page_link;         // 空闲链表链接
};

/* 描述页框状态的标志 */
#define PG_reserved                 0       // 若该位=1：该 Page 被内核保留，不能用于 alloc/free_pages；若该位=0：表示未被保留
#define PG_property                 1       // 若该位=1：该 Page 是空闲内存块的首页（包含若干连续页），可用于 alloc_pages；若该位=0：要么该 Page 不是空闲块的首页，要么该空闲块已被分配

#define SetPageReserved(page)       ((page)->flags |= (1UL << PG_reserved)) // 设置页为保留状态
#define ClearPageReserved(page)     ((page)->flags &= ~(1UL << PG_reserved))  // 设置页为非保留状态
#define PageReserved(page)          (((page)->flags >> PG_reserved) & 1)         // 判断页是否为保留状态
#define SetPageProperty(page)       ((page)->flags |= (1UL << PG_property))  // 设置页为属性页
#define ClearPageProperty(page)     ((page)->flags &= ~(1UL << PG_property)) // 设置页为非属性页
#define PageProperty(page)          (((page)->flags >> PG_property) & 1)      // 判断页是否为属性页

// convert list entry to page
#define le2page(le, member)                 \
    to_struct((le), struct Page, member)

/* free_area_t - maintains a doubly linked list to record free (unused) pages */
typedef struct {
    list_entry_t free_list;         // the list header
    unsigned int nr_free;           // number of free pages in this free list
} free_area_t;

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

#endif /* !__ASSEMBLER__ */

#endif /* !__KERN_MM_MEMLAYOUT_H__ */
