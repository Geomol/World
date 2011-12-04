/*
 * host/term.h, John Niclasen
 * Type definitions for World terminal operations
 */

#ifndef host_term_h
#define host_term_h


#define w_putchar(c)	{last_char = c; if (c == '\n') putchar ('\r'); putchar (c);}


extern char last_char;


/*
 * Function prototypes
 */
void set_raw ();
void reset_raw ();
void w_printf (char *fmt, ...);


#endif
