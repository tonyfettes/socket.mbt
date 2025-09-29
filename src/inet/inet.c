#include <moonbit.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#ifndef _WIN32
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#else
#include <winsock2.h>
#endif

MOONBIT_FFI_EXPORT
uint32_t
moonbit_tonyfettes_socket_inet_addr_make(
  uint32_t b0, // uint8_t
  uint32_t b1, // uint8_t
  uint32_t b2, // uint8_t
  uint32_t b3  // uint8_t
) {
  union {
    struct in_addr addr;
    uint8_t uint8[4];
  } addr;
  addr.uint8[0] = (uint8_t)b0;
  addr.uint8[1] = (uint8_t)b1;
  addr.uint8[2] = (uint8_t)b2;
  addr.uint8[3] = (uint8_t)b3;
  return addr.addr.s_addr;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_inet_ntop(uint32_t addr) {
  moonbit_bytes_t buf = moonbit_make_bytes(INET_ADDRSTRLEN, 0);
  if (inet_ntop(AF_INET, &addr, (char *)buf, INET_ADDRSTRLEN) == NULL) {
    return moonbit_empty_int8_array;
  }
  return buf;
}

MOONBIT_FFI_EXPORT
uint64_t
moonbit_tonyfettes_socket_inet_pton(moonbit_bytes_t buf) {
  struct in_addr addr;
  int32_t result = inet_pton(AF_INET, (const char *)buf, &addr);
  return ((uint64_t)result << 32) | addr.s_addr;
}

MOONBIT_FFI_EXPORT
uint64_t
moonbit_tonyfettes_socket_inet_socket(int32_t type, int32_t protocol) {
  return socket(AF_INET, type, protocol);
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_inet_sockaddr_make(uint32_t addr, uint32_t port) {
  moonbit_bytes_t sockaddr = moonbit_make_bytes(sizeof(struct sockaddr_in), 0);
  struct sockaddr_in *sin = (struct sockaddr_in *)sockaddr;
  sin->sin_family = AF_INET;
  sin->sin_addr.s_addr = addr;
  sin->sin_port = htons(port);
  return sockaddr;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_tonyfettes_socket_inet_sockaddr_addr(moonbit_bytes_t addr) {
  struct sockaddr_in *sin = (struct sockaddr_in *)addr;
  return sin->sin_addr.s_addr;
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
