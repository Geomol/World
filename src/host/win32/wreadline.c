/*
 * host/wreadline.c, John Niclasen
 * World readline operations
 */

#include <conio.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../wreadline.h"


/* History */
static char *history[100];
static int h_pos = 0;
static int h_tail = 0;


void init_history () {
	int i;
	for (i = 0; i < 100; i++) history[i] = NULL;
}


void free_history () {
	int i;
	for (i = 0; i < 100; i++) {
		if (history[i] != NULL) {
			free (history[i]);
			history[i] = NULL;
		}
	}
}


/* w_readline */
#define KEY_BS		8
#define KEY_TAB		9
#define KEY_CR		13
#define KEY_ESC		27
#define KEY_224		224


enum {
	HAS_NOTHING,
	HAS_KEY_224
};

static int state;
static unsigned int line_size;
static char *line;


static int pos;
static int line_tail;


void alloc_line () {
	state = HAS_NOTHING;
	line_size = 256;
	line = calloc (1, line_size);
	pos = line_tail = 0;
}


static void insert_char (int ch) {
	int i;
	if (++line_tail == line_size) {
		line_size += 256;
		line = realloc (line, line_size);
	}
	for (i=line_tail; i>pos; i--) line[i] = line[i-1];
	line[pos++] = ch;
	fputs (&line[pos - 1], stdout);
	if (pos < line_tail) {
		i = line_tail - pos;
		while (i--) putchar ('\b');
	}
}


int check_esc () {
	if (kbhit ()) {
		return (getch () == KEY_ESC);
	} else {
		return 0;
	}
}


int check_input (int *auto_brackets, int *attempt, int allow_tab) {
	int i, ch;
	fflush (stdout);
reentry:
	if (kbhit ()) {
		ch = getch ();
		if (ch == EOF)
			return W_NO_INPUT;
		switch (ch) {
			case KEY_CTRL_A:
				*auto_brackets = 1 - *auto_brackets;
				break;
			case KEY_CTRL_D:
				fputs ("\n", stdout);
				line[0] = KEY_CTRL_D;
				return W_CTRL_D;
			case KEY_TAB:
				if (allow_tab) {
					switch (state) {
						case HAS_KEY_224:
							insert_char (224);
							insert_char (ch);
							break;
						default:
							insert_char (ch);
							break;
					}
					state = HAS_NOTHING;
				} else
					return W_TAB;
				break;
			case KEY_CR:
				fflush (stdout);
				fputs ("\n", stdout);
				return W_NEWLINE;
			case 'H':
				if (state == HAS_KEY_224) {		// KEY_UP
					h_pos == 0 ? h_pos = 99 : h_pos--;
					if (history[h_pos] == NULL || h_pos == h_tail) {
						h_pos == 99 ? h_pos = 0 : h_pos++;
					} else {
						while (pos--) putchar ('\b');
						for (pos = 0; pos < line_tail; pos++) putchar (' ');
						while (pos--) putchar ('\b');
						pos = 0;
						while (history[h_pos][pos] != '\0')
							putchar (history[h_pos][pos++]);
						fflush (stdout);
						line_tail = pos;
						strcpy (line, history[h_pos]);
					}
					state = HAS_NOTHING;
				} else
					insert_char (ch);
				break;
			case 'P':
				if (state == HAS_KEY_224) {		// KEY_DOWN
					if (history[h_pos] != NULL && h_pos != h_tail) {
						h_pos == 99 ? h_pos = 0 : h_pos++;
						while (pos--) putchar ('\b');
						for (pos = 0; pos < line_tail; pos++) putchar (' ');
						while (pos--) putchar ('\b');
						pos = 0;
						if (history[h_pos] != NULL) {
							while (history[h_pos][pos] != '\0')
								putchar (history[h_pos][pos++]);
							strcpy (line, history[h_pos]);
						} else
							line[0] = '\0';
						fflush (stdout);
						line_tail = pos;
					}
					state = HAS_NOTHING;
				} else
					insert_char (ch);
				break;
			case 'M':
				if (state == HAS_KEY_224) {		// KEY_RIGHT
					if (pos < line_tail) {
						putchar (line[pos]);
						fflush (stdout);
						pos++;
					}
					state = HAS_NOTHING;
				} else
					insert_char (ch);
				break;
			case 'K':
				if (state == HAS_KEY_224) {		// KEY_LEFT
					if (pos > 0) {
						putchar ('\b');
						fflush (stdout);
						pos--;
					}
					state = HAS_NOTHING;
				} else
					insert_char (ch);
				break;
			case 'S':
				if (state == HAS_KEY_224) {		// KEY_DEL
					if (pos < line_tail) {
						if ((line[pos] == '\"' && line[pos + 1] == '\"')
								|| (line[pos] == '(' && line[pos + 1] == ')')
								|| (line[pos] == '[' && line[pos + 1] == ']')
								|| (line[pos] == '{' && line[pos + 1] == '}')) {
							for (i = pos; i < line_tail - 1; i++) line[i] = line[i+2];
							printf ("%s  ", &line[pos]);
							i = line_tail - pos;
							while (i--) putchar ('\b');
							line_tail--;
						} else {
							for (i = pos; i < line_tail; i++) line[i] = line[i+1];
							printf ("%s ", &line[pos]);
							i = line_tail - pos;
							while (i--) putchar ('\b');
						}
						fflush (stdout);
						line_tail--;
					}
					state = HAS_NOTHING;
				} else
					insert_char (ch);
				break;
			case KEY_224:
				*attempt = 1;
				if (state == HAS_NOTHING)
					state = HAS_KEY_224;
				else		// HAS_KEY_224:
					insert_char (224);
				goto reentry;
				break;
			case '\"':
				if (state == HAS_KEY_224) {
					insert_char (224);
					state = HAS_NOTHING;
				}
				if (*auto_brackets) {
					if (line[pos] == '\"') {
						putchar ('\"');
						pos++;
					} else {
						line_tail++;
						if (++line_tail >= line_size) {
							line_size += 256;
							line = realloc (line, line_size);
						}
						for (i=line_tail; i>pos+1; i--) line[i] = line[i-2];
						line[pos++]	= '\"';
						line[pos]	= '\"';
						fputs (&line[pos - 1], stdout);
						if (pos < line_tail) {
							i = line_tail - pos;
							while (i--) putchar ('\b');
						}
					}
				} else
					insert_char ('\"');
				break;
			case '(':
				if (state == HAS_KEY_224) {
					insert_char (224);
					state = HAS_NOTHING;
				}
				if (*auto_brackets) {
					line_tail++;
					if (++line_tail >= line_size) {
						line_size += 256;
						line = realloc (line, line_size);
					}
					for (i=line_tail; i>pos+1; i--) line[i] = line[i-2];
					line[pos++]	= '(';
					line[pos]	= ')';
					fputs (&line[pos - 1], stdout);
					if (pos < line_tail) {
						i = line_tail - pos;
						while (i--) putchar ('\b');
					}
				} else
					insert_char ('(');
				break;
			case ')':
				if (state == HAS_KEY_224) {
					insert_char (224);
					state = HAS_NOTHING;
				}
				if (*auto_brackets) {
					if (line[pos] == ')') {
						putchar (')');
						pos++;
					} else {
						if (++line_tail == line_size) {
							line_size += 256;
							line = realloc (line, line_size);
						}
						for (i=line_tail; i>pos; i--) line[i] = line[i-1];
						line[pos++] = ')';
						fputs (&line[pos - 1], stdout);
						if (pos < line_tail) {
							i = line_tail - pos;
							while (i--) putchar ('\b');
						}
					}
				} else
					insert_char (')');
				break;
			case '[':
				if (state == HAS_KEY_224) {
					insert_char (224);
					state = HAS_NOTHING;
				}
				if (*auto_brackets) {
					line_tail++;
					if (++line_tail >= line_size) {
						line_size += 256;
						line = realloc (line, line_size);
					}
					for (i=line_tail; i>pos+1; i--) line[i] = line[i-2];
					line[pos++]	= '[';
					line[pos]	= ']';
					fputs (&line[pos - 1], stdout);
					if (pos < line_tail) {
						i = line_tail - pos;
						while (i--) putchar ('\b');
					}
				} else
					insert_char ('[');
				break;
			case ']':
				if (state == HAS_KEY_224) {
					insert_char (224);
					state = HAS_NOTHING;
				}
				if (*auto_brackets) {
					if (line[pos] == ']') {
						putchar (']');
						pos++;
					} else {
						if (++line_tail == line_size) {
							line_size += 256;
							line = realloc (line, line_size);
						}
						for (i=line_tail; i>pos; i--) line[i] = line[i-1];
						line[pos++] = ']';
						fputs (&line[pos - 1], stdout);
						if (pos < line_tail) {
							i = line_tail - pos;
							while (i--) putchar ('\b');
						}
					}
				} else
					insert_char (']');
				break;
			case '{':
				if (state == HAS_KEY_224) {
					insert_char (224);
					state = HAS_NOTHING;
				}
				if (*auto_brackets) {
					if (pos > 0 && line[pos - 1] == '#') {
						line_tail++;
						if (++line_tail >= line_size) {
							line_size += 256;
							line = realloc (line, line_size);
						}
						for (i=line_tail; i>pos+1; i--) line[i] = line[i-2];
						line[pos++]	= '{';
						line[pos]	= '}';
					} else {
						if (++line_tail == line_size) {
							line_size += 256;
							line = realloc (line, line_size);
						}
						for (i=line_tail; i>pos; i--) line[i] = line[i-1];
						line[pos++] = ch;
					}
					fputs (&line[pos - 1], stdout);
					if (pos < line_tail) {
						i = line_tail - pos;
						while (i--) putchar ('\b');
					}
				} else
					insert_char ('{');
				break;
			case '}':
				if (state == HAS_KEY_224) {
					insert_char (224);
					state = HAS_NOTHING;
				}
				if (*auto_brackets) {
					if (line[pos] == '}') {
						putchar ('}');
						pos++;
					} else {
						if (++line_tail == line_size) {
							line_size += 256;
							line = realloc (line, line_size);
						}
						for (i=line_tail; i>pos; i--) line[i] = line[i-1];
						line[pos++] = '}';
						fputs (&line[pos - 1], stdout);
						if (pos < line_tail) {
							i = line_tail - pos;
							while (i--) putchar ('\b');
						}
					}
					break;
				} else
					insert_char ('}');
				break;
			case KEY_BS:
				if (state == HAS_KEY_224) {
					state = HAS_NOTHING;
				} else if (pos > 0) {
					pos--;
					if ((line[pos] == '\"' && line[pos + 1] == '\"')
							|| (line[pos] == '(' && line[pos + 1] == ')')
							|| (line[pos] == '[' && line[pos + 1] == ']')
							|| (line[pos] == '{' && line[pos + 1] == '}')) {
						for (i = pos; i < line_tail - 1; i++) line[i] = line[i+2];
						printf ("\b%s  ", &line[pos]);
						i = line_tail - pos;
						while (i--) putchar ('\b');
						line_tail--;
					} else {
						for (i = pos; i < line_tail; i++) line[i] = line[i+1];
						printf ("\b%s ", &line[pos]);
						i = line_tail - pos;
						while (i--) putchar ('\b');
					}
					fflush (stdout);
					line_tail--;
				}
				break;
			default:
				if (state == HAS_KEY_224) {
					insert_char (224);
					state = HAS_NOTHING;
				}
				insert_char (ch);
				break;
		}
		fflush (stdout);
		*attempt = 1;
		return W_INPUT;
	}
	return W_NO_INPUT;
}


char *w_get_line () {
	if (line_tail > 0) {
		if (history[h_tail] != NULL) free (history[h_tail]);
		history[h_tail] = realloc (NULL, strlen (line) + 1);
		strcpy (history[h_tail], line);
		h_tail == 99 ? h_tail = 0 : h_tail++;
		h_pos = h_tail;
	}
	return line;
}


void meet_tab_completion (char *result, int l) {
	int i, j;
	for (j = 0; j < l; j++) {
		if (++line_tail == line_size) {
			line_size += 256;
			line = realloc (line, line_size);
		}
		for (i = line_tail; i > pos; i--) line[i] = line[i-1];
		line[pos] = result[j];
		fputs (&line[pos++], stdout);
		if (pos < line_tail) {
			i = line_tail - pos;
			while (i--) putchar ('\b');
		}
	}
	line[line_tail] = '\0';
}


char *w_readline_script () {
	int ch, i, pos = 0, line_tail = 0;
	unsigned int line_size = 256;
	char *line = calloc (1, line_size);
	if (line == NULL) return NULL;
	line[0] = '\0';
	ch = getch ();	/* TODO Use gets */
	while (ch != KEY_CR) {
		if (++line_tail == line_size) {
			line_size += 256;
			line = realloc (line, line_size);
		}
		for (i=line_tail; i>pos; i--) line[i] = line[i-1];
		line[pos++] = ch;
		ch = getch ();
	}
	return line;
}


