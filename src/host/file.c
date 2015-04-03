/*
 * file.c, John Niclasen
 * File operations
 */

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

#include "file.h"


/* TODO Is this a problem with tasks? */
char path_buf[PATH_MAX];
char resolved_name[PATH_MAX];


int get_file_info (WorldFile *wfile) {
	struct stat stbuf;
	struct passwd *pw;
	char *ptr;
	/* TODO if strlen (wfile->path) > PATH_MAX) error ! */
	wfile->resolved_name = resolved_name;
	if ('~' == wfile->path[0]) {
		switch (wfile->path[1]) {
			case '\0':
			case '/':
				if (NULL == (ptr = getenv ("HOME")))
					strcpy (path_buf, wfile->path);
				else {
					strcpy (path_buf, ptr);
					strcat (path_buf, &wfile->path[1]);
				}
				break;
			default:
				strcpy (path_buf, &wfile->path[1]);
				if (NULL == (ptr = strchr (path_buf, '/'))) {
					if (NULL == (pw = getpwnam (path_buf)))
						strcpy (path_buf, wfile->path);
					else
						strcpy (path_buf, pw->pw_dir);
				} else {
					*ptr = '\0';
					int l = strlen (path_buf);
					if (NULL == (pw = getpwnam (path_buf)))
						strcpy (path_buf, wfile->path);
					else {
						strcpy (path_buf, pw->pw_dir);
						strcat (path_buf, &wfile->path[l + 1]);
					}
				}
				break;
		}
		if (NULL == realpath (path_buf, resolved_name)) {
			strcpy (resolved_name, wfile->path);
			return -1;
		}
	} else {
		if (NULL == realpath (wfile->path, resolved_name)) {
			strcpy (resolved_name, wfile->path);
			return -1;
		}
	}
	if (stat (wfile->resolved_name, &stbuf) == -1)
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
	if ((wfile->handle = opendir (wfile->resolved_name)) == NULL)
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
	strncpy (path_buf, cp, PATH_MAX - 2);
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


off_t file_pos (int fd) {
	return lseek (fd, 0, SEEK_CUR);
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


char dir[256];

char *get_pwd () {
	return getcwd (dir, 255);
}


int change_dir (const char *path) {
	int result;
	result = chdir (path);
	return result;
}


