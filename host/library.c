/*
 * host/library.c, John Niclasen
 * World shared libraries operations
 */


#include <dlfcn.h>


void *open_library (const char *file) {
	return dlopen (file, RTLD_LAZY);
}


int close_library (void *dll) {
	return dlclose (dll);
}


void *find_routine (void *dll, const char *rname) {
	return dlsym (dll, rname);
}


