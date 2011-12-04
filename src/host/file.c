/*
 * file.c, John Niclasen
 * File operations
 */

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "file.h"


/*
int f_gets (char *output, int max, FILE *input) {
	fgets (output, max, input);
	if (ferror (input)) return errno;
	return 0;
}
*/


int open_file (char *file) {
	return open (file, O_RDONLY, 0);
}


int close_file (int fd) {
	return close (fd);
}


int file_length (char *file, int binary) {
	FILE *fp = binary ? fopen (file, "rb") : fopen (file, "r");
	if (fp == NULL) return -1;
	fseek (fp, 0L, SEEK_END);
	int length = ftell (fp);
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
void f_free_dir (char *dir) {
	free (dir);
}
*/


int change_dir (const char *path) {
	int result;
	result = chdir (path);
	return result;
}


