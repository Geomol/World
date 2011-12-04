/*
 * host/library.h, John Niclasen
 * Type definitions for World shared libraries operations
 */

#ifndef host_library_h
#define host_library_h


/*
 * Function prototypes
 */
void *open_library (const char *file);
int close_library (void *dll);
void *find_routine (void *dll, const char *rname);


#endif
