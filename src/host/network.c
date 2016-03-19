/*
 * host/network.c, John Niclasen
 * World network operations
 */


#include <stdlib.h>		/* Used by free */
#include <unistd.h>

//#include <errno.h>		// TODO Really include this?

//#include <fcntl.h>
#include <string.h>
#include <sys/types.h>

#ifndef WORLD_OF_WINDOWS
#include <netinet/in.h>
# ifdef _XOPEN_SOURCE_EXTENDED
#  include <arpa/inet.h>
# endif
#include <sys/socket.h>
#endif

#ifdef W_POSIX
#include <netdb.h>
#include <sys/select.h>
#else
#include <winsock2.h>
#include <ws2tcpip.h>
#endif

#include <event2/buffer.h>
#include <event2/event.h>
#include <event2/listener.h>

#include "network.h"


/*
 * Init
 */

void net_global_init (struct event_base** event_base) {
	//puts ("net_global_init");
#ifdef WORLD_OF_WINDOWS
	WSADATA wsa_data;
	//WSAStartup (0x0101, &wsaData);	// Before libevent. TODO Try it!
	WSAStartup (0x0201, &wsa_data);
#endif
	*event_base = event_base_new ();
}


void net_global_cleanup (struct event_base* event_base) {
	//puts ("net_global_cleanup");
	event_base_free (event_base);
}


/*
 * Check I/O
 */

void net_check_io (struct event_base* event_base) {
	//puts ("net_check_io");
	event_base_loop (event_base, EVLOOP_NONBLOCK);
}


/*
 * Buffer
 */

struct evbuffer* buffer_new () {
	//puts ("buffer_new");
	return evbuffer_new ();
}


void buffer_free (struct evbuffer* buf) {
	//puts ("buffer_free");
	evbuffer_free (buf);
}


/*
 * Socket
 */

static void socket_read_callback (struct bufferevent* bev, void* user_data) {
	//puts ("socket_read_callback");
	if (evbuffer_get_length (bufferevent_get_input (bev)) != 0)
		bufferevent_read_buffer (bev, ((DataInfo*) user_data)->read_buffer);
}


static void socket_event_callback (struct bufferevent* bev, short events, void* user_data) {
	//printf ("event_callback: %d\n", events);
	DataInfo* di = user_data;
	if (events & BEV_EVENT_CONNECTED)
		di->status = WSOCKET_CONNECTED;
	else if (events & BEV_EVENT_EOF) {
/*
		di->processed = evbuffer_get_length (di->read_buffer);
		if (di->processed > di->length)
			di->processed = di->length;
		evbuffer_remove (di->read_buffer, di->data, di->processed);
*/
		di->status = WSOCKET_CLOSED;
	} else if (events & BEV_EVENT_ERROR)
		di->status = WSOCKET_ERROR;
		//printf ("Got an error on the connection: %s\n", strerror (errno)); /* XXX win32 */
	/* None of the other events can happen here, since we haven't enabled timeouts */
}


struct bufferevent* open_socket (Socket_Spec* spec, DataInfo* di, struct event_base* event_base) {
	//puts ("open_socket");
	//struct sockaddr_storage their_addr;
	//memset (&their_addr, 0, sizeof (their_addr));
	//their_addr.sin_family = AF_INET;
	//their_addr.sin_port = htons (spec->port_id);


	struct evutil_addrinfo hints, * servinfo;
	memset (&hints, 0, sizeof (hints));
	//hints.ai_family		= AF_UNSPEC;
	hints.ai_family		= AF_INET;
	hints.ai_socktype	= SOCK_STREAM;
	int status;
	// TODO evutil_getaddrinfo is blocking! See evdns_getaddrinfo
	if ((status = evutil_getaddrinfo (spec->node, spec->service, &hints, &servinfo)) != 0) {
		puts ("**** evutil_getaddrinfo error ****");
		//evutil_freeaddrinfo (servinfo);
		return NULL;
	}
	struct bufferevent* bev = bufferevent_socket_new (event_base, -1, BEV_OPT_CLOSE_ON_FREE);
	if (!bev) {
		puts ("**** Error constructing bufferevent!");	// TODO Proper error handling
		//event_base_loopbreak (event_base);
		return NULL;
	}
	di->status = WSOCKET_CONNECTING;
	bufferevent_setcb (bev, socket_read_callback, NULL, socket_event_callback, di);
	bufferevent_enable (bev, EV_READ | EV_WRITE);
	if (-1 == bufferevent_socket_connect (bev, servinfo->ai_addr, servinfo->ai_addrlen)) {
		evutil_freeaddrinfo (servinfo);
		puts ("**** Error connecting socket!");	// TODO Proper error handling
		//event_base_loopbreak (event_base);
		return NULL;
	}
	evutil_freeaddrinfo (servinfo);
	return bev;
}


void close_socket (struct bufferevent* bev) {
	//puts ("close_socket");
	bufferevent_free (bev);
}


size_t length_socket (const struct evbuffer* buf, struct event_base* event_base) {
	//puts ("length_socket");
	event_base_loop (event_base, EVLOOP_NONBLOCK);
	return evbuffer_get_length (buf);
}


size_t length_socket_lines (DataInfo* di, struct event_base* event_base) {
	//puts ("length_socket_lines");
	event_base_loop (event_base, EVLOOP_NONBLOCK);
	size_t length = 0, eol_length;
	struct evbuffer_ptr ptr = evbuffer_search_eol (di->read_buffer, NULL, &eol_length, EVBUFFER_EOL_CRLF);
	if (ptr.pos != -1) {
		do {
			length++;
			if (-1 == evbuffer_ptr_set (di->read_buffer, &ptr, eol_length, EVBUFFER_PTR_ADD))
				break;	// Should not happen!?
			ptr = evbuffer_search_eol (di->read_buffer, &ptr, &eol_length, EVBUFFER_EOL_CRLF);
		} while (ptr.pos != -1);
	}
	if (di->status == WSOCKET_CLOSED) {
		size_t pos = ptr.pos + eol_length;
		if (pos == -1) pos = 0;
		if (pos < evbuffer_get_length (di->read_buffer))
			length++;
	}
	return length;
}


size_t length_socket_line (DataInfo* di, size_t* eol_length, struct event_base* event_base) {
	//puts ("length_socket_line");
	event_base_loop (event_base, EVLOOP_NONBLOCK);
	struct evbuffer_ptr ptr = evbuffer_search_eol (di->read_buffer, NULL, eol_length, EVBUFFER_EOL_CRLF);
	if (ptr.pos == -1 && di->status == WSOCKET_CLOSED)
		return evbuffer_get_length (di->read_buffer);
	else
		return ptr.pos;
}


void receive_socket (struct bufferevent* bev, DataInfo* di) {
	//puts ("receive_socket");
	if (evbuffer_get_length (di->read_buffer) >= di->length) {
		evbuffer_remove (di->read_buffer, di->data, di->length);
		di->processed = di->length;
	} else
		di->status = WSOCKET_READING;
}


void receive_socket_line (struct bufferevent* bev, DataInfo* di, size_t eol_length) {
	//puts ("receive_socket_line");
	evbuffer_remove (di->read_buffer, di->data, di->length);
	di->processed++;
	if (eol_length > 0)
		evbuffer_drain (di->read_buffer, eol_length);
}


int send_socket (struct bufferevent* bev, DataInfo* di, struct event_base* event_base) {
	//puts ("send_socket");
	int result = bufferevent_write (bev, di->data, di->length);
	event_base_loop (event_base, EVLOOP_NONBLOCK);
	return result;
}


/*
 * Listener
 */

static void listener_callback (struct evconnlistener* listener, evutil_socket_t sockfd,
		struct sockaddr* sa, int socklen, void* user_data) {
	//puts ("listener_callback");
	ListenerList* LL	= user_data;
	ListenerNode* ln	= malloc (sizeof (ListenerNode));
	ln->sockfd		= sockfd;
	ln->next		= NULL;
	LL->tail->next	= ln;
	LL->tail		= ln;
}


// TODO Remove this?
static void listener_error_callback (struct evconnlistener* listener, void* user_data) {
	puts ("*** listener_error ***");
}


int open_listener (Socket_Spec* spec, ListenerList* LL, struct event_base* event_base) {
	//puts ("open_listener");
	struct sockaddr_in sin;
	memset (&sin, 0, sizeof (sin));
	sin.sin_family = AF_INET;
	sin.sin_port = htons (spec->port_id);
	struct evconnlistener* listener = evconnlistener_new_bind (event_base, listener_callback,
			(void*) LL, LEV_OPT_REUSEABLE | LEV_OPT_CLOSE_ON_FREE, -1,
			//(void*) LL, LEV_OPT_CLOSE_ON_FREE, -1,
			(struct sockaddr*) &sin, sizeof (sin));
	if (!listener) return -1;
	evconnlistener_set_error_cb (listener, listener_error_callback);
	LL->listener = listener;
	return 0;
}


void close_listener (ListenerList* LL) {
	//puts ("close_listener");
	evconnlistener_free (LL->listener);
}


/* Only call accept_socket, when LL is not empty */
struct bufferevent* accept_socket (ListenerList* LL, DataInfo* di) {
	//puts ("accept_socket");
	evutil_socket_t sockfd = LL->head->sockfd;
	ListenerNode* ln = LL->head;
	LL->head = ln->next;
	if (LL->head == NULL) LL->tail = (ListenerNode*) LL;	// List is empty; point to itself
	free (ln);
	struct event_base* event_base = evconnlistener_get_base (LL->listener);
	struct bufferevent* bev = bufferevent_socket_new (event_base, sockfd, BEV_OPT_CLOSE_ON_FREE);
	if (!bev) {
		//event_base_loopbreak (event_base);
		return NULL;
	}
	bufferevent_setcb (bev, socket_read_callback, NULL, socket_event_callback, di);
	bufferevent_enable (bev, EV_READ | EV_WRITE);
	di->status = WSOCKET_OPEN;
	return bev;
}


