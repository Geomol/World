/*
 * file.c, John Niclasen
 * File operations
 */

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

#include "file.h"

/*
#ifdef WORLD_OF_MACOSX
	#include <mach-o/dyld.h>
	typedef int (*NSGetExecutablePathProcPtr) (char *buf, size_t *bufsize);
#endif
*/


/*
int f_gets (char *output, int max, FILE *input) {
	fgets (output, max, input);
	if (ferror (input)) return errno;
	return 0;
}
*/


char path_buf[MAX_PATH];


int get_file_info (WorldFile *wfile) {
	struct stat stbuf;
	if (stat (wfile->path, &stbuf) == -1)
		return -1;
	if (S_ISDIR (stbuf.st_mode)) {
		wfile->type = FILE_TYPE_DIR;
		wfile->size = 0;	// in order to be consistent on all systems
	} else {
		wfile->type = FILE_TYPE_FILE;
		wfile->size = stbuf.st_size;
	}
	wfile->time = stbuf.st_mtime;
	return 0;
}


int open_dir (WorldFile *wfile) {
	if ((wfile->handle = opendir (wfile->path)) == NULL)
		return -1;
	return 0;
}


int read_dir (WorldFile *wfile) {
	struct dirent *dp;
	char *cp;
	do {
		if ((dp = readdir (wfile->handle)) == NULL) {
			closedir (wfile->handle);
			wfile->handle = NULL;
			return 0;
		}
		cp = dp->d_name;
	} while (cp[0] == '.' && (cp[1] == 0 || cp[1] == '.'));
	strncpy (path_buf, cp, MAX_PATH - 2);
	if (dp->d_type == DT_DIR)
		strcat (path_buf, "/");
	wfile->path = path_buf;
	return 0;
}


int open_file (char *file) {
	return open (file, O_RDONLY, 0);
}


int close_file (int fd) {
	return close (fd);
}


int64_t file_length (char *file, int binary) {
	FILE *fp = binary ? fopen (file, "rb") : fopen (file, "r");
	if (fp == NULL) return -1;
	fseek (fp, 0L, SEEK_END);
	int64_t length = ftello (fp);
	fclose (fp);
	return length;
}


size_t fread_file (char *target, char *file, int binary) {
	FILE *fp = binary ? fopen (file, "rb") : fopen (file, "r");
	if (fp == NULL) return -1;
	//size_t size = fread (target, file_length (file), 1, fp);
	fseek (fp, 0L, SEEK_END);
	int length = ftell (fp);
	fseek (fp, 0L, SEEK_SET);
	size_t size = fread (target, length, 1, fp);
	fclose (fp);
	return size;
}


size_t fwrite_file (char *file, char *value, int length, int binary) {
	FILE *fp = binary ? fopen (file, "wb") : fopen (file, "w");
	if (fp == NULL) return -1;
	size_t size = fwrite (value, length, 1, fp);
	fclose (fp);
	return size;
}


//char *to_local_file (char *file) {
	//return file;
//}


char *to_world_file (char *file) {
	if (file[1] == ':') {
		file[1] = file[0];
		file[0] = '/';
	}
	char *f;
	for (f = file; *f; f++)
		if (*f == '\\') *f = '/';
	return file;
}


char *what_dir () {
	char *dir = getcwd (NULL, 0);
	int length = strlen (dir);
	char *what = malloc (length + 2);
	memcpy (what, dir, length);
	free (dir);
	what[length] = '/';
	what[length + 1] = '\0';
	return what;
}


char dir[256];

char *get_pwd () {
	//return getcwd (NULL, 0);
	return getcwd (dir, 255);
}


/*
#ifdef WORLD_OF_MACOSX
char path[1024];
char *get_exec_path () {
	size_t pathLength = 1023;
	static NSGetExecutablePathProcPtr NSGetExecutablePath = NULL;
	if (NSGetExecutablePath == NULL) {
		NSGetExecutablePath = (NSGetExecutablePathProcPtr)
			NSAddressOfSymbol(NSLookupAndBindSymbol("__NSGetExecutablePath"));
	}
	if (NSGetExecutablePath != NULL) {
		(*NSGetExecutablePath) (path, &pathLength);
		path[1023] = 0;
	}
	return path;
}
#endif
*/


/*
void f_free_dir (char *dir) {
	free (dir);
}
*/


int change_dir (const char *path) {
	int result;
	result = chdir (path);
	return result;
}


