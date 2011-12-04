/*
 * host/call.c, John Niclasen
 * World system call operations
 */


/*
#include <stdlib.h>
#include <string.h>


int call_system (char *command, int wait) {
	int result;
	if (!wait) {
		int len = strlen (command);
		char *cmd = realloc (NULL, len + 2);
		strncpy (cmd, command, len);
		cmd[len] = '&';
		cmd[len + 1] = '\0';
		result = system (cmd);
		free (cmd);
	} else
		result = system (command);
	return result;
}
*/


