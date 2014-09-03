#include "type.h"
#include "const.h"
#include "protect.h"
#include "proc.h"
#include "console.h"
#include "tty.h"
#include "proto.h"
#include "global.h"

PUBLIC void clock_handler(int irq)
{
    //disp_str("#");
    ticks++;
    //disp_int(p_proc_ready->ticks);
    p_proc_ready->ticks--;
    if (k_reenter != 0) {
        //disp_str("!");
        return;
    }

    /* if (p_proc_ready->ticks > 0) */
    /*     return; */
    
    schedule();
}

PUBLIC void init_clock()
{
    /* init 8253 */
    out_byte(TIMER_MODE, RATE_GERERATOR);
    out_byte(TIMER0, (u8)(TIMER_FREQ/HZ));
    out_byte(TIMER0, (u8)((TIMER_FREQ/HZ) >> 8));
    
    put_irq_handler(CLOCK_IRQ, clock_handler);
    enable_irq(CLOCK_IRQ);
}

PUBLIC void milli_delay(int milli_sec)
{
    int t = get_ticks();
    
    while (((get_ticks() - t) * 1000 / HZ) < milli_sec) {};
}
