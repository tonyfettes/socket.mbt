///|
pub extern "c" fn socket(
  type_ : @socket.Type,
  protocol : @ip.Protocol,
) -> @socket.Socket = "moonbit_tonyfettes_socket_inet6_socket"

///|
struct Sockaddr(Bytes)

///|
extern "c" fn sockaddr_make(
  addr0 : UInt64,
  addr1 : UInt64,
  port : UInt16,
) -> Bytes = "moonbit_tonyfettes_socket_inet6_sockaddr_make"

///|
pub fn Sockaddr::new(addr : Addr, port : Port) -> Sockaddr {
  Sockaddr(sockaddr_make(addr.0, addr.1, port.0))
}

///|
#borrow(sa)
extern "c" fn is_sockaddr(sa : Bytes) -> Bool = "moonbit_tonyfettes_socket_inet6_is_sockaddr"

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
#valtype
struct Addr(UInt64,UInt64)

///|
pub fn Addr::new(
  b0 : UInt16,
  b1 : UInt16,
  b2 : UInt16,
  b3 : UInt16,
  b4 : UInt16,
  b5 : UInt16,
  b6 : UInt16,
  b7 : UInt16,
) -> Addr {
  Addr(
    (b0.to_uint64() << 48) |
    (b1.to_uint64() << 32) |
    (b2.to_uint64() << 16) |
    (b3.to_uint64() << 0),
    (b4.to_uint64() << 48) |
    (b5.to_uint64() << 32) |
    (b6.to_uint64() << 16) |
    (b7.to_uint64() << 0),
  )
}

///|
#borrow(sin)
extern "c" fn sockaddr_addr(sin : Sockaddr) -> Addr = "moonbit_tonyfettes_socket_inet6_sockaddr_addr"

///|
pub fn Sockaddr::addr(self : Sockaddr) -> Addr {
  sockaddr_addr(self)
}

///|
struct Port(UInt16)

///|
#borrow(sin)
extern "c" fn sockaddr_port(sin : Sockaddr) -> Port = "moonbit_tonyfettes_socket_inet6_sockaddr_port"

///|
pub fn Sockaddr::port(self : Sockaddr) -> Port {
  sockaddr_port(self)
}

///|
extern "c" fn port_make(port : UInt16) -> UInt16 = "moonbit_tonyfettes_socket_inet6_port_make"

///|
pub fn Port::new(port : UInt16) -> Port {
  Port(port_make(port))
}
