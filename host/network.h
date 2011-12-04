/*
 * host/network.h, John Niclasen
 * Type definitions for World network operations
 */

#ifndef host_network_h
#define host_network_h


#ifdef WORLD_OF_WINDOWS
#include <winsock2.h>
#else
#include <netdb.h>
#endif


typedef struct {
	char	*service;
	char	*node;
} Socket_Spec;


/*
 * Function prototypes
 */
#ifdef WORLD_OF_WINDOWS
void init_net ();
#endif
int open_socket (Socket_Spec *spec);
int close_socket (int sockfd);
int accept_socket (int sockfd);
int receive_socket (int sockfd, char *buf, int length);
int send_socket (int sockfd, char *message, int length);


#endif
