#ifndef __KERN_MM_PMM_H__
#define __KERN_MM_PMM_H__

#include <assert.h>
#include <defs.h>
#include <memlayout.h>
#include <mmu.h>
#include <riscv.h>

// pmm_manager 是物理内存管理类。一个特殊的 pmm 管理器 -
// XXX_pmm_manager
// 只需实现 pmm_manager 类中的方法，那么
// XXX_pmm_manager 就可以被 ucore 用来管理整个物理内存空间。
struct pmm_manager {
    const char *name;  // XXX_pmm_manager 的名称
    void (*init)(
        void);  // 初始化 XXX_pmm_manager 的内部描述与管理数据结构（空闲块链表、空闲块数量）
    void (*init_memmap)(
        struct Page *base,
        size_t n);  // 根据初始空闲物理内存空间设置描述和管理数据结构
    struct Page *(*alloc_pages)(
        size_t n);  // 分配 >= n 页，具体行为取决于分配算法
    void (*free_pages)(struct Page *base, size_t n);  // 释放 >= n 页，base 是 Page 描述符结构（见 memlayout.h）的基地址
    size_t (*nr_free_pages)(void);  // 返回空闲页数
    void (*check)(void);            // 检查 XXX_pmm_manager 的正确性
};

extern const struct pmm_manager *pmm_manager;

void pmm_init(void);

struct Page *alloc_pages(size_t n);
void free_pages(struct Page *base, size_t n);
size_t nr_free_pages(void); // 空闲页数

#define alloc_page() alloc_pages(1)
#define free_page(page) free_pages(page, 1)


/* *
 * PADDR - 接受一个内核虚拟地址（指向 KERNBASE 之上的地址），
 * 在该地址处映射着机器最多 256MB 的物理内存，并返回相应的物理地址。
 * 如果传入非内核虚拟地址则会触发 panic。
 * */
#define PADDR(kva)                                                 \
    ({                                                             \
        uintptr_t __m_kva = (uintptr_t)(kva);                      \
        if (__m_kva < KERNBASE) {                                  \
            panic("PADDR called with invalid kva %08lx", __m_kva); \
        }                                                          \
        __m_kva - va_pa_offset;                                    \
    })

/* *
 * KADDR - 接受一个物理地址并返回相应的内核虚拟地址。
 * 如果传入无效的物理地址则会触发 panic。
 * */
/**/
#define KADDR(pa)                                                \
    ({                                                           \
        uintptr_t __m_pa = (pa);                                 \
        size_t __m_ppn = PPN(__m_pa);                            \
        if (__m_ppn >= npage) {                                  \
            panic("KADDR called with invalid pa %08lx", __m_pa); \
        }                                                        \
        (void *)(__m_pa + va_pa_offset);                         \
    })

extern struct Page *pages;
extern size_t npage;
extern const size_t nbase;
extern uint64_t va_pa_offset;

static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }

static inline uintptr_t page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
}



static inline int page_ref(struct Page *page) { return page->ref; }

static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }

static inline int page_ref_inc(struct Page *page) {
    page->ref += 1;
    return page->ref;
}

static inline int page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}
/*
    * pa2page - 接受一个物理地址并返回相应的 Page 结构。
    * 如果传入无效的物理地址则会触发 panic。
    *
*/
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
}
static inline void flush_tlb() { asm volatile("sfence.vm"); }
extern char bootstack[], bootstacktop[]; // defined in entry.S

#endif /* !__KERN_MM_PMM_H__ */
