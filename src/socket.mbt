///|
pub extern "c" fn socket(domain : Int, type_ : Type, protocol : Int) -> Socket = "moonbit_tonyfettes_socket"

///|
pub(all) struct Sockaddr(Bytes)

///|
pub extern "c" fn Sockaddr::new() -> Sockaddr = "moonbit_tonyfettes_socket_sockaddr_storage_make"

///|
#borrow(sa)
extern "c" fn sockaddr_family(sa : Bytes) -> Int = "moonbit_tonyfettes_socket_sockaddr_family"

///|
pub fn Sockaddr::family(self : Sockaddr) -> Int {
  sockaddr_family(self.0)
}

///|
pub(open) trait ToSockaddr {
  to_sockaddr(self : Self) -> Sockaddr
  of_sockaddr(sockaddr : Sockaddr) -> Self?
}

///|
pub(all) enum Type {
  STREAM = 1
  DGRAM = 2
  RAW = 3
  RDM = 4
  SEQPACKET = 5
}

///|
pub(all) struct Socket(UInt64)

///|
pub fn[T : ToSockaddr] Sockaddr::to(self : Sockaddr) -> T? {
  T::of_sockaddr(self)
}

///|
#borrow(addr)
extern "c" fn socket_connect(socket : UInt64, addr : Bytes) -> Int = "moonbit_tonyfettes_socket_connect"

///|
pub fn[T : ToSockaddr] Socket::connect(self : Socket, addr : T) -> Bool {
  socket_connect(self.0, addr.to_sockaddr().0) == 0
}
