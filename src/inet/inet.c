#include <moonbit.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#ifndef _WIN32
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#else
#include <winsock2.h>
#endif

MOONBIT_FFI_EXPORT
uint64_t
moonbit_tonyfettes_socket_inet_socket(int32_t type, int32_t protocol) {
  return socket(AF_INET, type, protocol);
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_inet_sockaddr_make(
  moonbit_bytes_t addr,
  uint32_t port
) {
  moonbit_bytes_t sockaddr = moonbit_make_bytes(sizeof(struct sockaddr_in), 0);
  struct sockaddr_in *sin = (struct sockaddr_in *)sockaddr;
  sin->sin_family = AF_INET;
  memcpy(&sin->sin_addr, addr, sizeof(struct in_addr));
  sin->sin_port = htons(port);
  return sockaddr;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_inet_sockaddr_addr(moonbit_bytes_t addr) {
  moonbit_bytes_t in_addr = moonbit_make_bytes(sizeof(struct in_addr), 0);
  struct sockaddr_in *sin = (struct sockaddr_in *)addr;
  memcpy(in_addr, &sin->sin_addr, sizeof(struct in_addr));
  return in_addr;
}

MOONBIT_FFI_EXPORT
uint32_t
moonbit_tonyfettes_socket_inet_sockaddr_port(moonbit_bytes_t addr) {
  struct sockaddr_in *sin = (struct sockaddr_in *)addr;
  return ntohs(sin->sin_port);
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_tonyfettes_socket_inet_address_family(void) {
  return AF_INET;
}
