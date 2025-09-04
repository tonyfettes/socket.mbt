#include <moonbit.h>
#ifndef _WIN32
#include <netinet/in.h>
#include <sys/socket.h>
#else
#include <winsock2.h>
#endif

MOONBIT_FFI_EXPORT
uint64_t
moonbit_tonyfettes_socket_inet6_socket(int32_t type, int32_t protocol) {
  return socket(AF_INET6, type, protocol);
}

MOONBIT_FFI_EXPORT
uint32_t
moonbit_tonyfettes_socket_inet6_port_make(uint32_t port) {
  return htons(port);
}

typedef struct moonbit_tonyfettes_socket_inet6_addr {
  struct {
    uint64_t hi;
    uint64_t lo;
  };
  struct in6_addr in6_addr;
} moonbit_tonyfettes_socket_inet6_addr_t;

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_inet6_sockaddr_make(
  uint64_t addr0,
  uint64_t addr1,
  uint32_t port
) {
  moonbit_bytes_t sockaddr = moonbit_make_bytes(sizeof(struct sockaddr_in6), 0);
  struct sockaddr_in6 *sin = (struct sockaddr_in6 *)sockaddr;
  sin->sin6_family = AF_INET6;
  moonbit_tonyfettes_socket_inet6_addr_t addr = {.hi = addr0, .lo = addr1};
  sin->sin6_addr = addr.in6_addr;
  sin->sin6_port = port;
  return sockaddr;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_tonyfettes_socket_inet6_is_sockaddr(moonbit_bytes_t sockaddr) {
  struct sockaddr *sa = (struct sockaddr *)sockaddr;
  return sa->sa_family == AF_INET6;
}

MOONBIT_FFI_EXPORT
moonbit_tonyfettes_socket_inet6_addr_t
moonbit_tonyfettes_socket_inet6_sockaddr_addr(moonbit_bytes_t sockaddr) {
  struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sockaddr;
  moonbit_tonyfettes_socket_inet6_addr_t addr = {.in6_addr = sin6->sin6_addr};
  return addr;
}

MOONBIT_FFI_EXPORT
uint32_t
moonbit_tonyfettes_socket_inet6_sockaddr_port(moonbit_bytes_t sockaddr) {
  struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sockaddr;
  return sin6->sin6_port;
}
