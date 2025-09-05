#include <moonbit.h>
#include <stdint.h>
#ifndef _WIN32
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
uint32_t
moonbit_tonyfettes_socket_inet_port_make(uint32_t port) {
  return htons(port);
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_inet_sockaddr_make(uint32_t addr, uint32_t port) {
  moonbit_bytes_t sockaddr = moonbit_make_bytes(sizeof(struct sockaddr_in), 0);
  struct sockaddr_in *sin = (struct sockaddr_in *)sockaddr;
  sin->sin_family = AF_INET;
  sin->sin_addr.s_addr = addr;
  sin->sin_port = port;
  return sockaddr;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_tonyfettes_socket_inet_is_sockaddr(moonbit_bytes_t sockaddr) {
  struct sockaddr *sa = (struct sockaddr *)sockaddr;
  return sa->sa_family == AF_INET;
}

MOONBIT_FFI_EXPORT
uint32_t
moonbit_tonyfettes_socket_inet_sockaddr_addr(moonbit_bytes_t addr) {
  struct sockaddr_in *sin = (struct sockaddr_in *)addr;
  return sin->sin_addr.s_addr;
}

MOONBIT_FFI_EXPORT
uint32_t
moonbit_tonyfettes_socket_inet_sockaddr_port(moonbit_bytes_t addr) {
  struct sockaddr_in *sin = (struct sockaddr_in *)addr;
  return sin->sin_port;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_tonyfettes_socket_inet_address_family(void) {
  return AF_INET;
}
