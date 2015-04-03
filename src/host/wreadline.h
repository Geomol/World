/*
 * host/wreadline.h, John Niclasen
 * Type definitions for World readline operations
 */

#ifndef host_wreadline_h
#define host_wreadline_h

#define KEY_CTRL_A	1
#define KEY_CTRL_D	4


enum {
	W_NO_INPUT,
	W_INPUT,
	W_ESCAPE,
	W_CTRL_D,
	W_TAB,
	W_NEWLINE
};


void	init_history ();
void	free_history ();
void	alloc_line ();
/*
int		any_input ();
*/
int		check_esc ();
int		check_input (int* auto_brackets, int* attempt, int allow_tab);
char*	w_get_line ();
void	meet_tab_completion (char* result, int l);
char*	w_readline_script ();


#endif
