///|
pub extern "c" fn socket(
  type_ : @socket.Type,
  protocol : @ip.Protocol,
) -> @socket.Socket = "moonbit_tonyfettes_socket_inet_socket"

///|
struct Sockaddr(Bytes)

///|
extern "c" fn sockaddr_make(addr : UInt, port : UInt16) -> Bytes = "moonbit_tonyfettes_socket_inet_sockaddr_make"

///|
#borrow(sa)
extern "c" fn is_sockaddr(sa : Bytes) -> Bool = "moonbit_tonyfettes_socket_inet_is_sockaddr"

///|
pub fn Sockaddr::new(addr : Addr, port : Port) -> Sockaddr {
  Sockaddr(sockaddr_make(addr.0, port.0))
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
pub struct Addr(UInt)

///|
pub fn Addr::new(b0 : Byte, b1 : Byte, b2 : Byte, b3 : Byte) -> Addr {
  Addr(
    (b0.to_uint() << 24) |
    (b1.to_uint() << 16) |
    (b2.to_uint() << 8) |
    (b3.to_uint() << 0),
  )
}

///|
#borrow(sin)
extern "c" fn sockaddr_addr(sin : Sockaddr) -> Addr = "moonbit_tonyfettes_socket_inet_sockaddr_addr"

///|
pub fn Sockaddr::addr(self : Sockaddr) -> Addr {
  sockaddr_addr(self)
}

///|
struct Port(UInt16)

///|
#borrow(sin)
extern "c" fn sockaddr_port(sin : Sockaddr) -> Port = "moonbit_tonyfettes_socket_inet_sockaddr_port"

///|
pub fn Sockaddr::port(self : Sockaddr) -> Port {
  sockaddr_port(self)
}

///|
extern "c" fn port_make(port : UInt16) -> UInt16 = "moonbit_tonyfettes_socket_inet_port_make"

///|
pub fn Port::new(port : UInt16) -> Port {
  Port(port_make(port))
}

///|
extern "c" fn get_address_family() -> Int = "moonbit_tonyfettes_socket_inet_address_family"

///|
pub let address_family : Int = get_address_family()

///|
pub trait ToSockaddrIn {
  to_sockaddr_in(self : Self) -> Sockaddr?
}

///|
pub impl ToSockaddrIn for @socket.Sockaddr with to_sockaddr_in(
  self : @socket.Sockaddr,
) -> Sockaddr? {
  if is_sockaddr(self.0) {
    Some(Sockaddr(self.0))
  } else {
    None
  }
}
