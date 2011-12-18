/*
 * host/win32/library.c, John Niclasen
 * World shared libraries operations
 */


#include <windows.h>

#include "../file.h"


void *open_library (const char *file) {
	char *winfile = realloc (NULL, strlen (file) + 1);
	strcpy (winfile, file);
	winfile = to_local_file (winfile);
	void *lib = LoadLibrary (winfile);
	free (winfile);
	return lib;
}


int close_library (void *dll) {
	return FreeLibrary ((HINSTANCE) dll);
}


void *find_routine (void *dll, const char *rname) {
	return GetProcAddress ((HMODULE) dll, rname);
}


