/*
 * file.c, John Niclasen
 * File operations
 */

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

#include "../file.h"

#define realpath(N,R) _fullpath((R),(N),_MAX_PATH)

//char path_buf[MAX_PATH];
char path_buf[PATH_MAX];
char winfile[PATH_MAX];
char resolved_name[PATH_MAX];


int get_file_info (WorldFile *wfile) {
	struct stat stbuf;
	/* TODO if strlen (wfile->path) > PATH_MAX) error ! */
	//char *winfile = realloc (NULL, strlen (wfile->path) + 1);
	strcpy (winfile, wfile->path);
	to_local_file (winfile);
	if (NULL == realpath (winfile, resolved_name))
		return -1;
	wfile->resolved_name = resolved_name;
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
	strcpy (path_buf, wfile->resolved_name);
	strcat (path_buf, "/");
	strncat (path_buf, cp, PATH_MAX - 2);
	struct stat stbuf;
	if (stat (path_buf, &stbuf) != -1) {
		strncpy (path_buf, cp, PATH_MAX - 2);
		if (S_ISDIR (stbuf.st_mode)) {
			strcat (path_buf, "/");
		}
	}
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
	char *winfile = realloc (NULL, strlen (file) + 1);
	strcpy (winfile, file);
	winfile = to_local_file (winfile);
	FILE *fp = binary ? fopen (winfile, "rb") : fopen (winfile, "r");
	free (winfile);
	if (fp == NULL) return -1;
	fseek (fp, 0L, SEEK_END);
	int64_t length = ftell (fp);
	fclose (fp);
	return length;
}


size_t fread_file (char *target, char *file, int binary) {
	char *winfile = realloc (NULL, strlen (file) + 1);
	strcpy (winfile, file);
	winfile = to_local_file (winfile);
	FILE *fp = binary ? fopen (winfile, "rb") : fopen (winfile, "r");
	free (winfile);
	if (fp == NULL) return -1;
	fseek (fp, 0L, SEEK_END);
	int length = ftell (fp);
	fseek (fp, 0L, SEEK_SET);
	size_t size = fread (target, length, 1, fp);
	fclose (fp);
	return size;
}


size_t fwrite_file (char *file, char *value, int length, int binary) {
	char *winfile = realloc (NULL, strlen (file) + 1);
	strcpy (winfile, file);
	winfile = to_local_file (winfile);
	FILE *fp = binary ? fopen (winfile, "wb") : fopen (winfile, "w");
	free (winfile);
	if (fp == NULL) return -1;
	size_t size = fwrite (value, length, 1, fp);
	fclose (fp);
	return size;
}


char *to_local_file (char *file) {
	if (file[0] == '/') {
		file[0] = file[1];
		file[1] = ':';
	}
	char *f;
	for (f = file; *f; f++)
		if (*f == '/') *f = '\\';
	if (*--f == '\\') *f = '\0';
	return file;
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
	char *winpath = realloc (NULL, strlen (path) + 1);
	strcpy (winpath, path);
	winpath = to_local_file (winpath);
	result = chdir (winpath);
	free (winpath);
	return result;
}


