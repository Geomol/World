/*
 * host/case.c, John Niclasen
 * Case operations
 */


#include <ctype.h>

#include "case.h"


void lowercase (char *string, int length) {
	int i;

	for (i = 0; i < length; i++)
		string[i] = tolower (string[i]);
}


int w_strncmp (char *cs, char *ct, int n) {
	int i;
	for (i = 0; i < n; i++) {
		if (tolower (cs[i]) != tolower (ct[i]))
			return tolower (ct[i]) - tolower (cs[i]);
	}
	return 0;
}


