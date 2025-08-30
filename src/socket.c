#include <moonbit.h>
#include <netinet/in.h>
#include <sys/socket.h>

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_sockaddr_in_make(void) {
  return moonbit_make_bytes(sizeof(struct sockaddr_in), 0);
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_sockaddr_in6_make(void) {
  return moonbit_make_bytes(sizeof(struct sockaddr_in), 0);
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_sockaddr_make(void) {
  return moonbit_make_bytes(sizeof(struct sockaddr), 0);
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_sockaddr_storage_make(void) {
  return moonbit_make_bytes(sizeof(struct sockaddr_storage), 0);
}

typedef enum moonbit_tonyfettes_socket_address_family {
  UNIX = 1,
  INET = 2,
  INET6 = 3
} moonbit_tonyfettes_socket_address_family_t;

static inline int
moonbit_tonyfettes_socket_address_family_to_native(
  moonbit_tonyfettes_socket_address_family_t family
) {
  switch (family) {
  case UNIX:
    return AF_UNIX;
  case INET:
    return AF_INET;
  case INET6:
    return AF_INET6;
  default:
    return -1;
  }
}

typedef enum moonbit_tonyfettes_socket_type {
  STREAM = 1,
  DGRAM = 2,
  RAW = 3,
  RDM = 4,
  SEQPACKET = 5
} moonbit_tonyfettes_socket_type_t;

typedef enum moonbit_tonyfettes_socket_ip_protocol {
  HOPOPT = 0,
  ICMP = 1,
  IGMP = 2,
  GGP = 3,
  IPV4 = 4,
  ST = 5,
  TCP = 6,
  CBT = 7,
  EGP = 8,
  IGP = 9,
  PUP = 12,
  UDP = 17,
  IDP = 22,
  RDP = 27,
  IPV6 = 41
} moonbit_tonyfettes_socket_ip_protocol_t;
