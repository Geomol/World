/*
 * host/netcurl.h, John Niclasen
 * Type definitions for World cURL network operations
 */


enum {
	W_IO_DONE,
	W_IO_NOT_DONE,
	W_IO_TIMEOUT
};


int		netcurl_global_init ();
int		netcurl_global_cleanup ();
int		netcurl_init ();
void	netcurl_cleanup (int id);
int		netcurl_read (void *data_struct, char *url, int id, long *usec,
			size_t (*write_data) (char *buffer, size_t size, size_t nmemb, void *data_struct));
int		netcurl_wait_io (int id, long *usec);
