/*
 * host/case.c, John Niclasen
 * Case operations
 */


#include "case.h"


void lowercase (char *string, int length) {
	int i;

	for (i = 0; i < length; i++)
		string[i] = tolower ((int) string[i]);
}


int w_strncmp (char *cs, char *ct, int n) {
	int i;
	for (i = 0; i < n; i++) {
		if (tolower ((int) cs[i]) != tolower ((int) ct[i]))
			return tolower ((int) ct[i]) - tolower ((int) cs[i]);
	}
	return 0;
}


int wordcmp (char *cs, char *ct, int n) {
	int i;
	for (i = 0; i < n; i++) {
		if (tolower ((int) cs[i]) != (int) ct[i])
			return (int) ct[i] - tolower ((int) cs[i]);
	}
	return 0;
}


