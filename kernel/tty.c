

#include "type.h"
#include "const.h"
#include "protect.h"
#include "console.h"
#include "tty.h"
#include "proto.h"
#include "string.h"
#include "proc.h"
#include "global.h"
#include "keyboard.h"

#define TTY_FIRST   (tty_table)
#define TTY_END     (tty_table + NR_CONSOLES)

PRIVATE void init_tty(TTY *p_tty);
PRIVATE void tty_do_read(TTY *p_tty);
PRIVATE void tty_do_write(TTY *p_tty);

PUBLIC void task_tty()
{
    TTY *p_tty;

    init_keyboard();
    for (p_tty=TTY_FIRST; p_tty<TTY_END; ++p_tty) {
        init_tty(p_tty);
    }

    select_console(0);
    
    while (1) {
        for (p_tty=TTY_FIRST; p_tty<TTY_END; ++p_tty) {
            tty_do_read(p_tty);
            tty_do_write(p_tty);
        }
    }
}

 /* write symbol to tty buffer */
PUBLIC void in_process(TTY *p_tty, u32 key)
{
    char output[2] = {'\0', '\0'};

    if (!(key & FLAG_EXT)) {
        if (p_tty->inbuf_count < TTY_IN_BYTES) {
            *(p_tty->p_inbuf_head) = key;
            p_tty->p_inbuf_head++;
            if (p_tty->p_inbuf_head == p_tty->in_buf + TTY_IN_BYTES) {
                p_tty->p_inbuf_head = p_tty->in_buf;
            }
            p_tty->inbuf_count++;
        }
    } else {
        int raw_code = key & MASK_RAW;
        switch(raw_code) {
        case UP:
            if ((key&FLAG_CTRL_L) || (key&FLAG_CTRL_R)) {
                scroll_screen(p_tty->p_console, SCR_DN);
            }
            break;
        case DOWN:
            if ((key&FLAG_CTRL_L) || (key&FLAG_CTRL_R)) {
                scroll_screen(p_tty->p_console, SCR_UP);
            }
            break;
        case F1:
        case F2:
        case F3:
        case F4:
        case F5:
        case F6:
        case F7:
        case F8:
        case F9:
        case F10:
        case F11:
        case F12:
            /* Alt + F1~F12, switch console */
            if ((key&FLAG_ALT_L) || (key&FLAG_ALT_R)) {
                select_console(raw_code - F1);
            }
            break;
        default:
            break;
        }
    }
}

PRIVATE void init_tty(TTY *p_tty)
{
    p_tty->inbuf_count = 0;

    p_tty->p_inbuf_head = p_tty->p_inbuf_tail = p_tty->in_buf;

    init_screen(p_tty);
}

 /* read symbol from keyboard buffer and write it to tty buffer */
PRIVATE void tty_do_read(TTY *p_tty)
{
    if (is_current_console(p_tty->p_console)) {
        keyboard_read(p_tty);
    }
}

 /* read symbol from tty buffer and write it to console screen */
PRIVATE void tty_do_write(TTY *p_tty)
{
    if (p_tty->inbuf_count > 0) {
        char ch = *(p_tty->p_inbuf_tail);
        p_tty->p_inbuf_tail++;
        if (p_tty->p_inbuf_tail == p_tty->in_buf + TTY_IN_BYTES) {
            p_tty->p_inbuf_tail = p_tty->in_buf;
        }
        p_tty->inbuf_count--;

        out_char(p_tty->p_console, ch);
    }
}
    
