/*
 * host/time.c, John Niclasen
 * Date and Time operations
 */


#ifdef WORLD_OF_WINDOWS
#include "windows.h"
#endif

#include <sys/time.h>

#include "time.h"


static struct timeval	now_time;
static struct timezone	now_zone;


void w_sleep (struct timespec *t) {
#ifdef WORLD_OF_WINDOWS
	Sleep (t->tv_sec * 1000 + t->tv_nsec / 1000000);
#else
	nanosleep (t, NULL);
#endif
}


int now (Date *D) {
	int result = gettimeofday (&now_time, &now_zone);
	D->seconds		= (int64_t) now_time.tv_sec;
	D->useconds		= (int32_t) now_time.tv_usec;
	D->minuteswest	= (int16_t) now_zone.tz_minuteswest;
	D->dsttime		= (int16_t) now_zone.tz_dsttime;
	return result;
}


