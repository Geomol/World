/*
 * host/win32/library.c, John Niclasen
 * World shared libraries operations
 */


#include <windows.h>


void *open_library (const char *file) {
	return LoadLibrary (file);
}


int close_library (void *dll) {
	return FreeLibrary ((HINSTANCE) dll);
}


void *find_routine (void *dll, const char *rname) {
	return GetProcAddress ((HMODULE) dll, rname);
}


