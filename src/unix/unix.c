#include <moonbit.h>
#include <stdint.h>
#ifndef _WIN32
#include <sys/socket.h>
#include <sys/un.h>
#else
#include <winsock2.h>
#endif

MOONBIT_FFI_EXPORT
uint64_t
moonbit_tonyfettes_socket_unix_socket(int32_t type, int32_t protocol) {
  return socket(AF_UNIX, type, protocol);
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_unix_sockaddr_make(moonbit_bytes_t path) {
  moonbit_bytes_t sockaddr = moonbit_make_bytes(sizeof(struct sockaddr_un), 0);
  struct sockaddr_un *sun = (struct sockaddr_un *)sockaddr;
  sun->sun_family = AF_UNIX;
  strncpy(sun->sun_path, (char *)path, sizeof(sun->sun_path) - 1);
  return sockaddr;
}

MOONBIT_FFI_EXPORT
int32_t
moonbit_tonyfettes_socket_unix_is_sockaddr(moonbit_bytes_t sockaddr) {
  struct sockaddr *sa = (struct sockaddr *)sockaddr;
  return sa->sa_family == AF_UNIX;
}

MOONBIT_FFI_EXPORT
moonbit_bytes_t
moonbit_tonyfettes_socket_unix_sockaddr_path(moonbit_bytes_t addr) {
  struct sockaddr_un *sun = (struct sockaddr_un *)addr;
  size_t len = strlen(sun->sun_path);
  moonbit_bytes_t path = moonbit_make_bytes(len, 0);
  strncpy((char *)path, sun->sun_path, len);
  return path;
}
