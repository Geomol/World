/*
 * host/term.c, John Niclasen
 * World terminal operations
 */


#include <fcntl.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#ifdef W_POSIX
#include <termios.h>
#define LONGLONGD "%lld"
#else
#define LONGLONGD "%I64d"
#endif

#include "term.h"


#ifdef W_POSIX
static struct termios old;
#endif


void set_raw () {
#ifdef W_POSIX
	int stdin_fileno = fileno (stdin);
	tcgetattr (stdin_fileno, &old);
	struct termios trm;
	//cfmakeraw (&trm);
	trm = old;
	trm.c_lflag &= ~(ECHO | ICANON);
	trm.c_lflag |= ECHONL;
	tcsetattr (stdin_fileno, TCSAFLUSH, &trm);
	fcntl (stdin_fileno, F_SETFL, O_NONBLOCK);
#endif
}


void reset_raw () {
#ifdef W_POSIX
	tcsetattr (fileno (stdin), TCSAFLUSH, &old);
#endif
}


char last_char;


void w_printf (char *fmt, ...) {
	va_list ap;
	char *p;
	int cval;
	int64_t ival;
	va_start (ap, fmt);
	for (p = fmt; *p; p++) {
		last_char = *p;
		if (*p != '%') {
			//if (*p == '\n') putchar ('\r');
			putchar (*p);
			continue;
		}
		switch (*++p) {
			case 'c':
				cval = va_arg (ap, int);
				printf ("%d", cval);
				break;
			case 'd':
				ival = va_arg (ap, int64_t);
				printf (LONGLONGD, (long long int) ival);
				break;
			default:
				putchar ('%');
				putchar (*p);
				break;
		}
	}
	va_end (ap);
}


