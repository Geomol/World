/*
 * host/wreadline.c, John Niclasen
 * World readline operations
 */

//#include <poll.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include <sys/select.h>
//#include <sys/types.h>
//#include <sys/uio.h>
//#include <unistd.h>

#include "wreadline.h"


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


//int test_input () {
/*
	int c = getc (stdin);
	ungetc (c, stdin);
	return (c != EOF);
*/
/*
	fseek (stdin, 0L, SEEK_END);
	int64_t length = ftello (stdin);
	return 
}
*/


/*
int test_input () {
	//int timeout = 10; // wait 10ms
	struct pollfd fd;
	fd.fd		= fileno (stdin);
	fd.events	= POLLIN;
	fd.revents	= 0;
	//int ret = poll (&fd, 1, timeout);
	int ret = poll (&fd, 1, 0);
	//if ((ret > 0) && (fd.revents & POLLIN))
	if (ret > 0) {
		//puts ("got data");
		return ret;
	// got some data
	} else {
		//puts ("got nothing");
		return 0;
	// check for error
	}
}
*/


/*
static int kbhit() {
	struct timeval timeout;
	fd_set fds;
	timeout.tv_sec	= 0;
	timeout.tv_usec	= 10;
	FD_ZERO(&fds);
	int stdin_fileno = fileno (stdin);
	FD_SET (stdin_fileno, &fds);
	select (1, &fds, NULL, NULL, &timeout);
	// return 0 if STDIN is not ready to be read.
	return FD_ISSET (stdin_fileno, &fds);
}
*/


#define KEY_TAB		9
#define KEY_NL		10
#define KEY_ESC		27
#define KEY_BS		127


enum {
	HAS_NOTHING,
	HAS_KEY_ESC,
	HAS_ESC_BRACKET,
	HAS_ESC_BRACKET_3
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
	if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
}


int check_esc () {
	return (getchar () == KEY_ESC);
}


int check_input (int *auto_brackets, int *attempt, int allow_tab) {
	int i, ch;
	fflush (stdout);
	//if (test_input ())
	//if (kbhit ()) {
		//char li[256];
		//fgets (li, 254, stdin);
reentry:
		ch = getchar ();
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
						case HAS_ESC_BRACKET:
							insert_char ('[');
							insert_char (ch);
							break;
						case HAS_ESC_BRACKET_3:
							insert_char ('[');
							insert_char ('3');
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
			case KEY_NL:
				fflush (stdout);
#ifdef WORLD_OF_LINUX
				fputs ("\n", stdout);
#endif
				return W_NEWLINE;
			case KEY_ESC:
				*attempt = 1;
				switch (state) {
					case HAS_NOTHING:
						//ch = getchar ();
						state = HAS_KEY_ESC;
						goto reentry;
						break;
					case HAS_KEY_ESC:
						state = HAS_NOTHING;
						return W_ESCAPE;
					case HAS_ESC_BRACKET:
						insert_char ('[');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET_3:
						/*
						line_tail += 2;
						if (line_tail >= line_size) {
							line_size += 256;
							line = realloc (line, line_size);
						}
						for (i=line_tail; i>pos + 1; i--) line[i] = line[i-2];
						line[pos++] = '[';
						line[pos++] = '3';
						fputs (&line[pos - 2], stdout);
						if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
						*/
						insert_char ('[');
						insert_char ('3');
						state = HAS_NOTHING;
						break;
				}
				break;
			case '\"':
				switch (state) {
					case HAS_NOTHING:
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
								if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
							}
						} else {
							insert_char ('\"');
						}
						break;
					case HAS_KEY_ESC:
						insert_char ('\"');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET:
						insert_char ('[');
						insert_char ('\"');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char ('\"');
						state = HAS_NOTHING;
						break;
				}
				break;
			case '(':
				switch (state) {
					case HAS_NOTHING:
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
							if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
						} else {
							insert_char ('(');
						}
						break;
					case HAS_KEY_ESC:
						insert_char ('(');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET:
						insert_char ('[');
						insert_char ('(');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char ('(');
						state = HAS_NOTHING;
						break;
				}
				break;
			case ')':
				switch (state) {
					case HAS_NOTHING:
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
								if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
							}
						} else {
							insert_char ('(');
						}
						break;
					case HAS_KEY_ESC:
						insert_char (')');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET:
						insert_char ('[');
						insert_char (')');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char (')');
						state = HAS_NOTHING;
						break;
				}
				break;
			case '3':
				switch (state) {
					case HAS_ESC_BRACKET:
						state = HAS_ESC_BRACKET_3;
						goto reentry;
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char ('3');
						state = HAS_NOTHING;
						break;
					default:
						insert_char ('3');
						state = HAS_NOTHING;
						break;
				}
				break;
			case 'A':
				switch (state) {
					case HAS_ESC_BRACKET:		/* KEY_UP */
						h_pos == 0 ? h_pos = 99 : h_pos--;
						if (history[h_pos] == NULL || h_pos == h_tail) {
							h_pos == 99 ? h_pos = 0 : h_pos++;
						} else {
							if (pos > 0) printf ("\x1b[%dD", pos);
							printf ("\x1b[K");
							pos = 0;
							while (history[h_pos][pos] != '\0')
								putchar (history[h_pos][pos++]);
							fflush (stdout);
							line_tail = pos;
							strcpy (line, history[h_pos]);
						}
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char ('A');
						break;
					default:
						insert_char ('A');
						break;
				}
				state = HAS_NOTHING;
				break;
			case 'B':
				switch (state) {
					case HAS_ESC_BRACKET:	/* KEY_DOWN */
						if (history[h_pos] != NULL && h_pos != h_tail) {
							h_pos == 99 ? h_pos = 0 : h_pos++;
							if (pos > 0) printf ("\x1b[%dD", pos);
							printf ("\x1b[K");
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
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char ('B');
						break;
					default:
						insert_char ('B');
						break;
				}
				state = HAS_NOTHING;
				break;
			case 'C':
				switch (state) {
					case HAS_ESC_BRACKET:	/* KEY_RIGHT */
						if (pos < line_tail) {
							putchar (line[pos]);
							fflush (stdout);
							pos++;
						}
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char ('C');
						break;
					default:
						insert_char ('C');
						break;
				}
				state = HAS_NOTHING;
				break;
			case 'D':
				switch (state) {
					case HAS_ESC_BRACKET:	/* KEY_LEFT */
						if (pos > 0) {
							putchar ('\b');
							fflush (stdout);
							pos--;
						}
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char ('D');
						break;
					default:
						insert_char ('D');
						break;
				}
				state = HAS_NOTHING;
				break;
			case '[':
				switch (state) {
					case HAS_NOTHING:
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
							if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
						} else {
							insert_char ('[');
						}
						break;
					case HAS_KEY_ESC:
						state = HAS_ESC_BRACKET;
						goto reentry;
						break;
					case HAS_ESC_BRACKET:
						insert_char ('[');
						insert_char ('[');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char ('[');
						state = HAS_NOTHING;
						break;
				}
				break;
			case ']':
				switch (state) {
					case HAS_NOTHING:
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
								if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
							}
						} else {
							insert_char (']');
						}
						break;
					case HAS_KEY_ESC:
						insert_char (']');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET:
						insert_char ('[');
						insert_char (']');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char (']');
						state = HAS_NOTHING;
						break;
				}
				break;
			case '{':
				switch (state) {
					case HAS_NOTHING:
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
							if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
						} else {
							insert_char ('{');
						}
						break;
					case HAS_KEY_ESC:
						insert_char ('{');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET:
						insert_char ('[');
						insert_char ('{');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char ('{');
						state = HAS_NOTHING;
						break;
				}
				break;
			case '}':
				switch (state) {
					case HAS_NOTHING:
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
								if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
							}
							break;
						} else {
							insert_char ('}');
						}
						break;
					case HAS_KEY_ESC:
						insert_char ('}');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET:
						insert_char ('[');
						insert_char ('}');
						state = HAS_NOTHING;
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char ('}');
						state = HAS_NOTHING;
						break;
				}
				break;
			case '~':
				switch (state) {
					case HAS_ESC_BRACKET:
						insert_char ('[');
						insert_char ('~');
						break;
					case HAS_ESC_BRACKET_3:	/* KEY_DELETE */
						if (pos < line_tail) {
							if ((line[pos] == '\"' && line[pos + 1] == '\"')
									|| (line[pos] == '(' && line[pos + 1] == ')')
									|| (line[pos] == '[' && line[pos + 1] == ']')
									|| (line[pos] == '{' && line[pos + 1] == '}')) {
								for (i = pos; i < line_tail - 1; i++)
									line[i] = line[i+2];
								printf ("%s  \x1b[%dD", &line[pos], line_tail - pos);
								line_tail--;
							} else {
								for (i = pos; i < line_tail; i++)
									line[i] = line[i+1];
								printf ("%s \x1b[%dD", &line[pos], line_tail - pos);
							}
							fflush (stdout);
							line_tail--;
						}
						break;
					default:
						insert_char ('~');
						break;
				}
				state = HAS_NOTHING;
				break;
			case KEY_BS:
				*attempt = 1;
				if (pos > 0) {
					pos--;
					if ((line[pos] == '\"' && line[pos + 1] == '\"')
							|| (line[pos] == '(' && line[pos + 1] == ')')
							|| (line[pos] == '[' && line[pos + 1] == ']')
							|| (line[pos] == '{' && line[pos + 1] == '}')) {
						for (i = pos; i < line_tail - 1; i++)
							line[i] = line[i+2];
						printf ("\b%s  \x1b[%dD", &line[pos], line_tail - pos);
						line_tail--;
					//} else if (line[pos] == KEY_TAB) {
						//for (i = pos; i < line_tail; i++)
							//line[i] = line[i+1];
						//printf ("\b\b\b\b%s \x1b[%dD", &line[pos], line_tail - pos);
					} else {
						for (i = pos; i < line_tail; i++)
							line[i] = line[i+1];
						printf ("\b%s \x1b[%dD", &line[pos], line_tail - pos);
					}
					fflush (stdout);
					line_tail--;
				}
				break;
			default:
				switch (state) {
					case HAS_ESC_BRACKET:
						insert_char ('[');
						insert_char (ch);
						break;
					case HAS_ESC_BRACKET_3:
						insert_char ('[');
						insert_char ('3');
						insert_char (ch);
						break;
					default:
						insert_char (ch);
						break;
				}
				state = HAS_NOTHING;
				break;
		}
		fflush (stdout);
		*attempt = 1;
		return W_INPUT;
	//}
	//return W_NO_INPUT;
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
		if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
	}
	line[line_tail] = '\0';
}


char *w_readline_script () {
	int ch, i, pos = 0, line_tail = 0;
	unsigned int line_size = 256;
	char *line = calloc (1, line_size);
	if (line == NULL) return NULL;
	line[0] = '\0';
	ch = getchar ();	/* TODO Use gets */
	while (ch != KEY_NL) {
		if (++line_tail == line_size) {
			line_size += 256;
			line = realloc (line, line_size);
		}
		for (i=line_tail; i>pos; i--) line[i] = line[i-1];
		line[pos++] = ch;
		ch = getchar ();
	}
	return line;
}


