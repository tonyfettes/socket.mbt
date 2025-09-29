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
  Stream = 1
  Datagram = 2
  Raw = 3
  RDM = 4
  SeqPacket = 5
}

///|
pub fn Type::to_int(self : Type) -> Int {
  match self {
    Type::Stream => 1
    Type::Datagram => 2
    Type::Raw => 3
    Type::RDM => 4
    Type::SeqPacket => 5
  }
}

///|
pub fn Type::of_int(i : Int) -> Type? {
  match i {
    1 => Some(Type::Stream)
    2 => Some(Type::Datagram)
    3 => Some(Type::Raw)
    4 => Some(Type::RDM)
    5 => Some(Type::SeqPacket)
    _ => None
  }
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

///|
pub extern "c" fn get_last_error() -> Int = "moonbit_tonyfettes_socket_get_last_error"

///|
pub impl ToSockaddr for Sockaddr with to_sockaddr(self : Sockaddr) -> Sockaddr {
  self
}

///|
pub impl ToSockaddr for Sockaddr with of_sockaddr(sockaddr : Sockaddr) -> Sockaddr? {
  Some(sockaddr)
}
