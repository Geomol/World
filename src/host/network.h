/*
 * host/network.h, John Niclasen
 * Type definitions for World network operations
 */

#ifndef host_network_h
#define host_network_h

#include <stdint.h>

#include <event2/bufferevent.h>
#include <event2/util.h>


/* Socket status */
enum {
	WSOCKET_CLOSED,
	WSOCKET_OPEN,
	WSOCKET_CONNECTING,
	WSOCKET_CONNECTED,
	WSOCKET_READING,
	WSOCKET_ERROR
};


/* Information associated with data */
typedef struct {
	struct evbuffer*	read_buffer;
	//struct evbuffer*	write_buffer;
	char*				data;
	size_t				length;
	size_t				processed;
	int					status;		// See Socket status
} DataInfo;


/* Information associated with a specific listener */
typedef struct ListenerNode {
	struct ListenerNode*	next;
	evutil_socket_t			sockfd;
} ListenerNode;


typedef struct {
	struct ListenerNode*	head;
	struct ListenerNode*	tail;
	struct evconnlistener*	listener;
} ListenerList;


#define listenerlist_not_empty(LL)	((LL)->head != NULL)


typedef struct {
	char*		node;
	char*		service;
	uint16_t	port_id;
} Socket_Spec;


/*
 * Function prototypes
 */

/*
#ifdef WORLD_OF_WINDOWS
void	init_net ();
#endif
*/

void	net_global_init (struct event_base** event_base);
void	net_global_cleanup (struct event_base* event_base);
void	net_check_io (struct event_base* event_base);
int		open_listener (Socket_Spec* spec, ListenerList* LL, struct event_base* event_base);
void	close_listener (ListenerList* LL);
struct bufferevent*
		open_socket (Socket_Spec* spec, DataInfo* di, struct event_base* event_base);
void	close_socket (struct bufferevent* bev);
struct bufferevent*
		accept_socket (ListenerList* LL, DataInfo* di);
struct evbuffer*
		buffer_new ();
void	buffer_free (struct evbuffer* buf);
size_t	length_socket (const struct evbuffer* buf, struct event_base* event_base);
size_t	length_socket_lines (DataInfo* di, struct event_base* event_base);
size_t	length_socket_line (DataInfo* di, size_t* eol_length, struct event_base* event_base);
void	receive_socket (struct bufferevent* bev, DataInfo* di);
void	receive_socket_line (struct bufferevent* bev, DataInfo* di, size_t eol_length);
int		send_socket (struct bufferevent* bev, DataInfo* di, struct event_base* event_base);


#endif
