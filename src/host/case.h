/*
 * host/case.h, John Niclasen
 * Type definitions for case operations
 */

#ifndef host_case_h
#define host_case_h

#include <ctype.h>


#define charcmp(cs, ct)			(tolower (ct) - tolower (cs))


/*
 * Function prototypes
 */
void	lowercase (char *string, int length);
int		w_strncmp (char *cs, char *ct, int n);
int		wordcmp (char *cs, char *ct, int n);


#endif
