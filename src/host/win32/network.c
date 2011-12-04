/*
 * host/network.c, John Niclasen
 * World network operations
 */


#include <stdio.h>	// puts
#include <unistd.h>

#include <string.h>
#include <sys/types.h>
#include <winsock2.h>
#include <ws2tcpip.h>

#include "../network.h"


void init_net () {
	WSADATA	wsaData;
	WSAStartup (0x0101, &wsaData);
}


int open_socket (Socket_Spec *spec) {
	const char yes = 1;
	int status, sockfd;
	if (spec->node == NULL) {	/* listening */
		if ((sockfd = socket (PF_INET, SOCK_STREAM, IPPROTO_TCP)) == -1) {
			puts ("**** socket error ****");
			return -1;
		}
		if ((status = setsockopt (sockfd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof (int))) == -1) {
			puts ("**** setsockopt error ****");
			return -1;
		}
		struct sockaddr_in my_addr;
		my_addr.sin_family = AF_INET;
		my_addr.sin_port = htons ((short) atoi (spec->service));     // short, network byte order
		my_addr.sin_addr.s_addr = INADDR_ANY;
		memset(my_addr.sin_zero, '\0', sizeof (my_addr.sin_zero));
		bind(sockfd, (struct sockaddr *)&my_addr, sizeof (my_addr));
		if ((status = listen (sockfd, SOMAXCONN)) != 0) {
			puts ("**** listen error ****");
			return -1;
		}
	} else {
		if ((sockfd = socket (PF_INET, SOCK_STREAM, IPPROTO_TCP)) == -1) {
			puts ("**** socket error ****");
			return -1;
		}
		struct sockaddr_in my_addr;
		my_addr.sin_family = AF_INET;
		my_addr.sin_port = htons ((short) atoi (spec->service));     // short, network byte order
		my_addr.sin_addr.s_addr = inet_addr (spec->node);
		memset(my_addr.sin_zero, '\0', sizeof (my_addr.sin_zero));
		connect (sockfd, (struct sockaddr *) &my_addr, sizeof (my_addr));
	}
	//inet_ntop (servinfo->ia_family, get_in_addr ((struct sockaddr *) servinfo->ai_addr), );
	return sockfd;
}


int close_socket (int sockfd) {
	close (sockfd);
	return 0;
}


int accept_socket (int sockfd) {
	struct sockaddr_storage their_addr;
	socklen_t addr_size;
	addr_size = sizeof (their_addr);
	int new_fd = accept (sockfd, (struct sockaddr *) &their_addr, &addr_size);
	return new_fd;
}


int receive_socket (int sockfd, char *buf, int length) {
	int total = 0, n;
	int left = length;
	do {
		n = recv (sockfd, buf + total, left, 0);
		if (n == -1) break;
		total += n;
		left -= n;
	} while (left > 0);
	return n == -1 ? -1 : total;
}


int send_socket (int sockfd, char *message, int length) {
	int total = 0, n;
	int left = length;
	do {
		n = send (sockfd, message + total, left, 0);
		if (n == -1) break;
		total += n;
		left -= n;
	} while (left > 0);
	return n == -1 ? -1 : total;
}


