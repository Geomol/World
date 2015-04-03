/*
 * file.h, John Niclasen
 * Type definitions for file operations
 */

#ifndef file_h
#define file_h


#include <stdlib.h>
#include <unistd.h>


#define FILE_TYPE_FILE	1
#define FILE_TYPE_DIR	2


typedef struct {
	char*		path;
	char*		resolved_name;
	void*		handle;
	long long	size;
	time_t		time;
	long		type;	/* 1 = file, 2 = dir */
} WorldFile;


/*
 * File macros
 */
#define read_file(fd, buf, n)	read(fd, buf, n)


/*
 * Function prototypes
 */
int		get_file_info (WorldFile* wfile);
int		open_dir (WorldFile* wfile);
int		read_dir (WorldFile* wfile);
int		open_file (char* file);
int		close_file (int fd);
off_t	file_pos (int fd);
int64_t	file_length (char* file, int binary);
size_t	fread_file (char* target, char* file, int binary);
size_t	fwrite_file (char* file, char* value, int length, int binary);
char*	to_local_file (char* file);	/* Used by host/win32/file.c */
char*	to_world_file (char* file);
char*	get_pwd ();
int		change_dir (const char* path);

#endif
