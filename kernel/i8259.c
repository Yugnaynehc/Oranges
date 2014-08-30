







#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"




/* Init 8259A */
PUBLIC void init_8259A()
{
    /* Master 8259, ICW1 */
    out_byte(INT_M_CTL, 0x11);
    
    /* Slave  8259, ICW1 */
    out_byte(INT_S_CTL, 0x11);
    
    /* Master 8259, ICW2, set Master 8259's enter address of interrupt to 0x20 */
    out_byte(INT_M_CTLMASK, INT_VECTOR_IRQ0);
    
    /* Slave  8259, ICW2, set Slave  8259's enter address of interrupt to 0x28 */
    out_byte(INT_S_CTLMASK, INT_VECTOR_IRQ8);

    /* Master 8259, ICW3, bind IR2 to Slave 8259 */
    out_byte(INT_M_CTLMASK, 0x4);

    /* Slave  8259, ICW3, bind slave to Master 8259's IR2 */
    out_byte(INT_S_CTLMASK, 0x2);

    /* Master 8259, ICW4 */
    out_byte(INT_M_CTLMASK, 0x1);

    /* Slave  8259, ICW4 */
    out_byte(INT_S_CTLMASK, 0x1);

    /* Master 8259, OCW1, only use clock interrupt */
    out_byte(INT_M_CTLMASK, 0xFE);

    /* Slave  8259, OCW1, block all interruput */
    out_byte(INT_S_CTLMASK, 0xFF);
}


PUBLIC void spurious_irq(int irq)
{
    disp_str("Spurious_irq: ");
    disp_int(irq);
    disp_str("\n");
}
