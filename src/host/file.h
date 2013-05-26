/*
 * file.h, John Niclasen
 * Type definitions for file operations
 */

#ifndef file_h
#define file_h


#include <unistd.h>


#ifdef WORLD_OF_POSIX
#define MAX_PATH 1024
#endif

#define FILE_TYPE_FILE	1
#define FILE_TYPE_DIR	2


typedef struct {
	char		*path;
	void		*handle;
	long long	size;
	//long long		index;
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
int		 get_file_info (WorldFile *wfile);
int		 open_dir (WorldFile *wfile);
int		 read_dir (WorldFile *wfile);
int		 open_file (char *file);
int		 close_file (int fd);
int64_t	 file_length (char *file, int binary);
size_t	 fread_file (char *target, char *file, int binary);
size_t	 fwrite_file (char *file, char *value, int length, int binary);
char	*to_local_file (char *file);
char	*to_world_file (char *file);
char	*what_dir ();
char	*get_pwd ();
char	*get_exec_path ();
//void	 f_free_dir (char *dir);
int		 change_dir (const char *path);

#endif
