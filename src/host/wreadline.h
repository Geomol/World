/*
 * host/wreadline.h, John Niclasen
 * Type definitions for World readline operations
 */

#ifndef host_wreadline_h
#define host_wreadline_h

#define KEY_CTRL_A	1
#define KEY_CTRL_D	4


void init_history ();
void free_history ();
//char *w_readline (char *prompt);
//char *w_readline (int *auto_brackets);
char *w_readline (int *auto_brackets, int (*tab_completion) (int code, char *line, int attempt, char **result));


#endif
