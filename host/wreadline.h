/*
 * host/wreadline.h, John Niclasen
 * Type definitions for World readline operations
 */

#ifndef host_wreadline_h
#define host_wreadline_h


int init_keyboard_input ();
void free_keyboard_input ();
void init_history ();
void free_history ();
char *w_readline (char *prompt);


#endif
