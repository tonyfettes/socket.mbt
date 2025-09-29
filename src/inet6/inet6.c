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
moonbit_string_t
moonbit_tonyfettes_socket_inet6_addr_make(
  uint32_t b0, // uint16_t
  uint32_t b1, // uint16_t
  uint32_t b2, // uint16_t
  uint32_t b3, // uint16_t
  uint32_t b4, // uint16_t
  uint32_t b5, // uint16_t
  uint32_t b6, // uint16_t
  uint32_t b7  // uint16_t
) {
  moonbit_string_t addr = moonbit_make_string(8, 0);
  addr[0] = htons((uint16_t)b0);
  addr[1] = htons((uint16_t)b1);
  addr[2] = htons((uint16_t)b2);
  addr[3] = htons((uint16_t)b3);
  addr[4] = htons((uint16_t)b4);
  addr[5] = htons((uint16_t)b5);
  addr[6] = htons((uint16_t)b6);
  addr[7] = htons((uint16_t)b7);
  return addr;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_inet6_ntop(uint16_t *addr) {
  moonbit_bytes_t buf = moonbit_make_bytes(INET6_ADDRSTRLEN, 0);
  if (inet_ntop(AF_INET6, addr, (char *)buf, INET6_ADDRSTRLEN) == NULL) {
    return moonbit_empty_int8_array;
  }
  return buf;
}

MOONBIT_FFI_EXPORT
uint64_t
moonbit_tonyfettes_socket_inet6_socket(int32_t type, int32_t protocol) {
  return socket(AF_INET6, type, protocol);
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
  moonbit_bytes_t addr,
  uint32_t port
) {
  moonbit_bytes_t sockaddr = moonbit_make_bytes(sizeof(struct sockaddr_in6), 0);
  struct sockaddr_in6 *sin = (struct sockaddr_in6 *)sockaddr;
  sin->sin6_family = AF_INET6;
  memcpy(&sin->sin6_addr, addr, sizeof(struct in6_addr));
  sin->sin6_port = htons(port);
  return sockaddr;
}

MOONBIT_FFI_EXPORT
moonbit_string_t
moonbit_tonyfettes_socket_inet6_sockaddr_addr(moonbit_bytes_t sockaddr) {
  moonbit_string_t in6_addr = moonbit_make_string(sizeof(struct in6_addr), 0);
  struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sockaddr;
  memcpy(in6_addr, &sin6->sin6_addr, sizeof(struct in6_addr));
  return in6_addr;
}

MOONBIT_FFI_EXPORT
uint32_t
moonbit_tonyfettes_socket_inet6_sockaddr_port(moonbit_bytes_t sockaddr) {
  struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sockaddr;
  return ntohs(sin6->sin6_port);
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_tonyfettes_socket_inet6_address_family(void) {
  return AF_INET6;
}

MOONBIT_FFI_EXPORT
uint32_t
moonbit_tonyfettes_socket_inet6_sockaddr_scope_id(moonbit_bytes_t sockaddr) {
  struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sockaddr;
  return sin6->sin6_scope_id;
}
