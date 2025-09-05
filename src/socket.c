#include <moonbit.h>
#ifndef _WIN32
#include <netinet/in.h>
#include <sys/socket.h>
#else
#include <winsock2.h>
#endif

MOONBIT_FFI_EXPORT
uint32_t
moonbit_tonyfettes_socket_sockaddr_family(moonbit_bytes_t sockaddr) {
  struct sockaddr *sa = (struct sockaddr *)sockaddr;
  return sa->sa_family;
}

MOONBIT_FFI_EXPORT
uint64_t
moonbit_tonyfettes_socket(int32_t domain, int32_t type, int32_t protocol) {
  return socket(domain, type, protocol);
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_tonyfettes_socket_connect(uint64_t socket, moonbit_bytes_t addr) {
  int32_t addrlen = Moonbit_array_length(addr);
  return connect((int)socket, (struct sockaddr *)addr, addrlen);
}
