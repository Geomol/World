/*
 * host/netcurl.c, John Niclasen
 * World cURL network operations
 */

#include <curl/curl.h>
#include <sys/select.h>

#include "netcurl.h"


/* Interesting functions
 *
 * curl_global_init
 * curl_global_cleanup
 * curl_global_init_mem
 *
 * curl_easy_init
 * curl_easy_cleanup
 * curl_easy_setopt
 * curl_easy_reset
 *
 * curl_multi_init
 * curl_multi_cleanup
 * curl_multi_add_handle
 * curl_multi_remove_handle
 * curl_multi_perform
 * 		If it returns CURLM_CALL_MULTI_PERFORM, call it again soon
 *
 * curl_multi_fdset
 * select
 * curl_multi_timeout
 *
 * curl_multi_info_read
 *
 */


#define HANDLECOUNT 32

#define FALSE	0
#define TRUE	1

static CURLM *multihandle;
static CURL *easyhandle[HANDLECOUNT];
static int transfer_done[HANDLECOUNT];


static int get_handle () {
	int i = 0;
	while (i < HANDLECOUNT && easyhandle[i] != NULL)
		i++;
	if (i == HANDLECOUNT)
		return -1;
	else
		return i;
}


int netcurl_global_init () {
	curl_global_init (CURL_GLOBAL_ALL);
	multihandle = curl_multi_init ();
	return 0;
}


int netcurl_global_cleanup () {
	curl_multi_cleanup (multihandle);
	curl_global_cleanup ();
	return 0;
}


int netcurl_init () {
	int i =  get_handle ();
	if (i >= 0) easyhandle[i] = curl_easy_init ();
	return i;
}


void netcurl_cleanup (int id) {
	curl_easy_cleanup (easyhandle[id]);
	easyhandle[id] = NULL;
}


int netcurl_read (void *data_struct, char *url, int id, long *usec,
		size_t (*write_data) (char *buffer, size_t size, size_t nmemb, void *data_struct)) {
	curl_easy_setopt (easyhandle[id], CURLOPT_URL, url);
	curl_easy_setopt (easyhandle[id], CURLOPT_WRITEFUNCTION, write_data);
	curl_easy_setopt (easyhandle[id], CURLOPT_WRITEDATA, data_struct);

	curl_multi_add_handle (multihandle, easyhandle[id]);
	transfer_done[id] = FALSE;

	int running;	// Amount of easyhandles running
	curl_multi_perform (multihandle, &running);

	long us = -1;
	curl_multi_timeout (multihandle, &us);
	if (us > 0) {
		*usec = us;
		return W_IO_NOT_DONE;
	}
	curl_multi_perform (multihandle, &running);

	int remaining;
	CURLMsg *msg = curl_multi_info_read (multihandle, &remaining);

	while (msg != NULL) {
		if (msg->msg == CURLMSG_DONE) {	// Only one possible so far
			int j = 0;
			while (j < HANDLECOUNT && msg->easy_handle != easyhandle[j])
				j++;
			if (j == HANDLECOUNT)
				puts ("**** unknown msg->easy_handle in netcurl.c ****");
			else
				transfer_done[j] = TRUE;
		} else {
			puts ("**** unknown msg in netcurl.c ****");
		}
		msg = curl_multi_info_read (multihandle, &remaining);
	}

	if (transfer_done[id]) {
		curl_multi_remove_handle (multihandle, easyhandle[id]);
		return W_IO_DONE;
	} else {
		return W_IO_NOT_DONE;
	}
}


int netcurl_wait_io (int id, long *usec) {
	int running;	// Amount of easyhandles running
	curl_multi_perform (multihandle, &running);

	/* FD sets */
	fd_set read_set;
	fd_set write_set;
	fd_set exc_set;
	FD_ZERO (&read_set);
	FD_ZERO (&write_set);
	FD_ZERO (&exc_set);
	int max_fd = -1;

	/* Timeout */
	struct timeval timeout;
	//timeout.tv_sec = 1;
	timeout.tv_sec = 0;		/* Doing a poll */
	timeout.tv_usec = 0;
	/*
	long usec = -1;
	curl_multi_timeout (multihandle, &usec);
	if (usec >= 0) {
		timeout.tv_sec = usec / 1000;
		if (timeout.tv_sec > 1)
			timeout.tv_sec = 1;
		else
			timeout.tv_usec = (usec % 1000) * 1000;
	}
	*/
	/* Set FD sets and select () */
	curl_multi_fdset (multihandle, &read_set, &write_set, &exc_set, &max_fd);
	int r = select (max_fd + 1, &read_set, &write_set, &exc_set, &timeout);
	/* Check result */
	switch (r) {
		case -1:
			/* select error */
			puts ("**** select error in netcurl.c ****");
			break;
		case 0:	/* timeout */
			//return W_IO_TIMEOUT;
		default:
			curl_multi_perform (multihandle, &running);
			break;
	}

	int remaining;
	CURLMsg *msg = curl_multi_info_read (multihandle, &remaining);

	while (msg != NULL) {
		if (msg->msg == CURLMSG_DONE) {	// Only possible so far
			int j = 0;
			while (j < HANDLECOUNT && msg->easy_handle != easyhandle[j])
				j++;
			if (j == HANDLECOUNT)
				puts ("**** unknown msg->easy_handle in netcurl.c ****");
			else {
				transfer_done[j] = TRUE;
			}
		} else {
			puts ("**** unknown msg in netcurl.c ****");
		}
		msg = curl_multi_info_read (multihandle, &remaining);
	}


	if (transfer_done[id]) {
		curl_multi_remove_handle (multihandle, easyhandle[id]);
		return W_IO_DONE;
	} else {
		long us = -1;
		curl_multi_timeout (multihandle, &us);
		*usec = us;
		return W_IO_NOT_DONE;
	}
}


