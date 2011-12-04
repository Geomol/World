/*
 * host/time.h, John Niclasen
 * Type definitions for time operations
 */

#ifndef host_time_h
#define host_time_h

#include <stdint.h>
#include <time.h>


#ifdef WORLD_OF_WINDOWS
struct timespec {
	time_t	tv_sec;
	long	tv_nsec;
};
#endif


typedef struct {
	int64_t		seconds;
	int32_t		useconds;
	int16_t		minuteswest;
	int16_t		dsttime;
} Date;


void	w_sleep (struct timespec *t);
int		now (Date *D);


#endif
