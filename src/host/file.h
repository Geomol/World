/*
 * file.h, John Niclasen
 * Type definitions for file operations
 */

#ifndef file_h
#define file_h


#include <unistd.h>


/*
 * File macros
 */
#define read_file(fd, buf, n)	read(fd, buf, n)


/*
 * Function prototypes
 */
int		 open_file (char *file);
int		 close_file (int fd);
int		 file_length (char *file, int binary);
size_t	 fread_file (char *target, char *file, int binary);
size_t	 fwrite_file (char *file, char *value, int length, int binary);
char	*to_local_file (char *file);
char	*to_world_file (char *file);
char	*what_dir ();
char	*get_pwd ();
//void	 f_free_dir (char *dir);
int		 change_dir (const char *path);

#endif
