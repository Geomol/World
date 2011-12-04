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
#define KEY_TAB		9
#define KEY_CR		13
#define KEY_ESC		27
#define KEY_BS		8
#define KEY_224		224
#define KEY_UP		'H'
#define KEY_DOWN	'P'
#define KEY_RIGHT	'M'
#define KEY_LEFT	'K'
#define KEY_DEL		'S'


char *w_readline (char *prompt) {
	int ch, i, pos = 0, line_tail = 0;
	unsigned int line_size = 256;
	char *line = realloc (NULL, line_size);
	if (line == NULL) return NULL;
	line[0] = '\0';
	if (prompt) fputs (prompt, stdout);
	fflush (stdout);
	ch = getch ();
	int stop_it = 0;
	while (ch != KEY_CR && !stop_it) {
		switch (ch) {
			case KEY_TAB:
				/* TODO tab completion */
				break;
			case KEY_224:
				ch = getch ();
				switch (ch) {
					case KEY_UP:
						h_pos == 0 ? h_pos = 99 : h_pos--;
						if (history[h_pos] == NULL || h_pos == h_tail) {
							h_pos == 99 ? h_pos = 0 : h_pos++;
						} else {
							//if (pos > 0) printf ("\x1b[%dD", pos);
							//printf ("\x1b[K");
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
						ch = getch ();
						continue;
					case KEY_DOWN:
						if (history[h_pos] != NULL && h_pos != h_tail) {
							h_pos == 99 ? h_pos = 0 : h_pos++;
							//if (pos > 0) printf ("\x1b[%dD", pos);
							//printf ("\x1b[K");
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
						ch = getch ();
						continue;
					case KEY_RIGHT:
						if (pos < line_tail) {
							putchar (line[pos]);
							fflush (stdout);
							pos++;
						}
						ch = getch ();
						continue;
					case KEY_LEFT:
						if (pos > 0) {
							putchar ('\b');
							fflush (stdout);
							pos--;
						}
						ch = getch ();
						continue;
					case KEY_DEL:
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
						ch = getch ();
						continue;
					case KEY_ESC:
						if (++line_tail == line_size) {
							line_size += 256;
							line = realloc (line, line_size);
						}
						for (i=line_tail; i>pos; i--)
							line[i] = line[i-1];
						line[pos++] = ch;
						stop_it = 1;
						continue;
					default:
						if (++line_tail == line_size) {
							line_size += 256;
							line = realloc (line, line_size);
						}
						for (i=line_tail; i>pos; i--) line[i] = line[i-1];
						line[pos++] = KEY_224;
						fputs (&line[pos - 1], stdout);
						if (pos < line_tail) {
							i = line_tail - pos;
							while (i--) putchar ('\b');
						}
						continue;
				}
			case KEY_BS:
				if (pos > 0) {
					pos--;
					if ((line[pos] == '\"' && line[pos + 1] == '\"')
							|| (line[pos] == '(' && line[pos + 1] == ')')
							|| (line[pos] == '[' && line[pos + 1] == ']')
							|| (line[pos] == '{' && line[pos + 1] == '}')) {
						for (i = pos; i < line_tail - 1; i++) line[i] = line[i+2];
						//printf ("\b%s  \x1b[%dD", &line[pos], line_tail - pos);
						printf ("\b%s  ", &line[pos]);
						i = line_tail - pos;
						while (i--) putchar ('\b');
						line_tail--;
					} else {
						for (i = pos; i < line_tail; i++) line[i] = line[i+1];
						//printf ("\b%s \x1b[%dD", &line[pos], line_tail - pos);
						printf ("\b%s ", &line[pos]);
						i = line_tail - pos;
						while (i--) putchar ('\b');
					}
					fflush (stdout);
					line_tail--;
				}
				break;
			default:
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
							if (pos < line_tail) {
								//printf ("\x1b[%dD", line_tail - pos);
								i = line_tail - pos;
								while (i--) putchar ('\b');
							}
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
						if (pos < line_tail) {
							i = line_tail - pos;
							while (i--) putchar ('\b');
						}
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
							if (pos < line_tail) {
								i = line_tail - pos;
								while (i--) putchar ('\b');
							}
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
						if (pos < line_tail) {
							i = line_tail - pos;
							while (i--) putchar ('\b');
						}
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
							if (pos < line_tail) {
								i = line_tail - pos;
								while (i--) putchar ('\b');
							}
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
						if (pos < line_tail) {
							i = line_tail - pos;
							while (i--) putchar ('\b');
						}
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
							if (pos < line_tail) {
								i = line_tail - pos;
								while (i--) putchar ('\b');
							}
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
						if (pos < line_tail) {
							i = line_tail - pos;
							while (i--) putchar ('\b');
						}
						break;
				}
				fflush (stdout);
				break;
		}
		ch = getch ();
	}
	if (line_tail > 0) {
		if (history[h_tail] != NULL) free (history[h_tail]);
		history[h_tail] = realloc (NULL, strlen (line) + 1);
		strcpy (history[h_tail], line);
		h_tail == 99 ? h_tail = 0 : h_tail++;
		h_pos = h_tail;
	}
	putchar ('\n');
	return line;
}


