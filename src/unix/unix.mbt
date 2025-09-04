///|
pub extern "c" fn socket(type_ : @socket.Type) -> @socket.Socket = "moonbit_tonyfettes_socket_unix_socket"

///|
struct Sockaddr(Bytes)

///|
#borrow(path)
extern "c" fn sockaddr_make(path : Bytes) -> Bytes = "moonbit_tonyfettes_socket_unix_sockaddr_make"

///|
#borrow(sa)
extern "c" fn is_sockaddr(sa : Bytes) -> Bool = "moonbit_tonyfettes_socket_unix_is_sockaddr"

///|
pub fn Sockaddr::new(path : Bytes) -> Sockaddr {
  Sockaddr(sockaddr_make(path))
}

///|
pub impl @socket.ToSockaddr for Sockaddr with to_sockaddr(self : Sockaddr) -> @socket.Sockaddr {
  @socket.Sockaddr(self.0)
}

///|
pub impl @socket.ToSockaddr for Sockaddr with of_sockaddr(
  sockaddr : @socket.Sockaddr,
) -> Sockaddr? {
  if is_sockaddr(sockaddr.0) {
    Some(Sockaddr(sockaddr.0))
  } else {
    None
  }
}

///|
#borrow(sun)
extern "c" fn sockaddr_path(sun : Sockaddr) -> Bytes = "moonbit_tonyfettes_socket_unix_sockaddr_path"

///|
pub fn Sockaddr::path(self : Sockaddr) -> Bytes {
  sockaddr_path(self)
}
