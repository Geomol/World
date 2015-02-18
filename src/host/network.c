/*
 * host/network.c, John Niclasen
 * World network operations
 */


//#include <stdio.h>	// puts
#include <unistd.h>

#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>

#include "network.h"


int open_socket (Socket_Spec *spec) {
	int yes = 1;
	int status, sockfd;
	struct addrinfo hints, *servinfo; //, *p;
	memset (&hints, 0, sizeof (hints));
	hints.ai_family		= AF_UNSPEC;
	hints.ai_socktype	= SOCK_STREAM;
	if (spec->node == NULL) {	/* listening */
		hints.ai_flags	= AI_PASSIVE;
		if ((status = getaddrinfo (NULL, spec->service, &hints, &servinfo)) != 0) {
			//puts ("**** getaddrinfo error ****");
			return -1;
		}
		if ((sockfd = socket (servinfo->ai_family, servinfo->ai_socktype,
						servinfo->ai_protocol)) == -1) {
			//puts ("**** socket error ****");
			return -1;
		}
		if ((status = setsockopt (sockfd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof (int))) == -1) {
			//puts ("**** setsockopt error ****");
			return -1;
		}
		if ((status = bind (sockfd, servinfo->ai_addr, servinfo->ai_addrlen)) != 0) {
			//puts ("**** bind error ****");
			return -1;
		}
		if ((status = listen (sockfd, SOMAXCONN)) != 0) {
			//puts ("**** listen error ****");
			return -1;
		}
	} else {
		if ((status = getaddrinfo (spec->node, spec->service, &hints, &servinfo)) != 0) {
			//puts ("**** getaddrinfo error ****");
			return -1;
		}
		if ((sockfd = socket (servinfo->ai_family, servinfo->ai_socktype,
						servinfo->ai_protocol)) == -1) {
			//puts ("**** socket error ****");
			return -1;
		}
		connect (sockfd, servinfo->ai_addr, servinfo->ai_addrlen);
	}
	//inet_ntop (servinfo->ia_family, get_in_addr ((struct sockaddr *) servinfo->ai_addr), );
	freeaddrinfo (servinfo);
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
		if (n <= 0) break;
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


