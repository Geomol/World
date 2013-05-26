/*
 * host/wreadline.c, John Niclasen
 * World readline operations
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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


/* w_readline */
#define KEY_TAB		9
#define KEY_NL		10
#define KEY_ESC		27
#define KEY_BS		127


char *w_readline (int *auto_brackets, int (*tab_completion) (int code, char *line, int attempt, char **result)) {
	int ch, i, j, pos = 0, line_tail = 0;
	unsigned int line_size = 256;
	char *line = realloc (NULL, line_size);
	char *result;
	int l;
	int attempt = 1;
	if (line == NULL) return NULL;
	line[0] = '\0';
	fflush (stdout);
	ch = getchar ();
	int stop_it = 0;
	while (ch != KEY_NL && !stop_it) {
		switch (ch) {
			case KEY_CTRL_A:
				*auto_brackets = 1 - *auto_brackets;
				break;
			case KEY_CTRL_D:
				fputs ("\n", stdout);
				line[0] = KEY_CTRL_D;
				return line;
				break;
			case KEY_TAB:
				/* TODO tab completion */
				//fputs (line, stdout);
				l = (*tab_completion) (0, line, attempt++, &result);
				if (attempt == 3) attempt = 1;
				for (j=0; j < l; j++) {
					if (++line_tail == line_size) {
						line_size += 256;
						line = realloc (line, line_size);
					}
					for (i=line_tail; i>pos; i--) line[i] = line[i-1];
					line[pos] = result[j];
					fputs (&line[pos++], stdout);
					if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
				}
				line[line_tail] = '\0';
				//fflush (stdout);
				break;
			case KEY_ESC:
				attempt = 1;
				ch = getchar ();
				if (ch == '[') {
					ch = getchar ();
					switch (ch) {
						case 'A':
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
							ch = getchar ();
							continue;
						case 'B':
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
							ch = getchar ();
							continue;
						case 'C':
							if (pos < line_tail) {
								putchar (line[pos]);
								fflush (stdout);
								pos++;
							}
							ch = getchar ();
							continue;
						case 'D':
							if (pos > 0) {
								putchar ('\b');
								fflush (stdout);
								pos--;
							}
							ch = getchar ();
							continue;
						case '3':
							ch = getchar ();
							if (ch == '~') {
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
								ch = getchar ();
								continue;
							} else {
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
								continue;
							}
							break;
						default:
							if (++line_tail == line_size) {
								line_size += 256;
								line = realloc (line, line_size);
							}
							for (i=line_tail; i>pos; i--) line[i] = line[i-1];
							line[pos++] = '[';
							fputs (&line[pos - 1], stdout);
							if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
							continue;
					}
				} else if (ch == KEY_ESC) {
					if (++line_tail == line_size) {
						line_size += 256;
						line = realloc (line, line_size);
					}
					for (i=line_tail; i>pos; i--) line[i] = line[i-1];
					line[pos++] = ch;
					stop_it = 1;
					continue;
				} else
					continue;
			case KEY_BS:
				attempt = 1;
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
				attempt = 1;
				if (*auto_brackets) {
					switch (ch) {
						case '\"':
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
							break;
						case '(':
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
							break;
						case ')':
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
							break;
						case '[':
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
							break;
						case ']':
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
							break;
						case '{':
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
							break;
						case '}':
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
						default:
							if (++line_tail == line_size) {
								line_size += 256;
								line = realloc (line, line_size);
							}
							for (i=line_tail; i>pos; i--) line[i] = line[i-1];
							line[pos++] = ch;
							fputs (&line[pos - 1], stdout);
							if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
							break;
					}
				} else {
					if (++line_tail == line_size) {
						line_size += 256;
						line = realloc (line, line_size);
					}
					for (i=line_tail; i>pos; i--) line[i] = line[i-1];
					line[pos++] = ch;
					fputs (&line[pos - 1], stdout);
					if (pos < line_tail) printf ("\x1b[%dD", line_tail - pos);
				}
				fflush (stdout);
				break;
		}
		ch = getchar ();
	}
#ifdef WORLD_OF_LINUX
	if (ch == KEY_NL) fputs ("\n", stdout);
#endif
	if (line_tail > 0) {
		if (history[h_tail] != NULL) free (history[h_tail]);
		history[h_tail] = realloc (NULL, strlen (line) + 1);
		strcpy (history[h_tail], line);
		h_tail == 99 ? h_tail = 0 : h_tail++;
		h_pos = h_tail;
	}
	return line;
}


