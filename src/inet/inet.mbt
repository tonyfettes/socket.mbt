///|
pub typealias @ip.Protocol

///|
pub extern "c" fn socket(
  type_ : @socket.Type,
  protocol : Protocol,
) -> @socket.Socket = "moonbit_tonyfettes_socket_inet_socket"

///|
struct Sockaddr(Bytes)

///|
pub impl ToJson for Sockaddr with to_json(self : Sockaddr) -> Json {
  { "addr": self.addr(), "port": self.port() }
}

///|
#borrow(addr)
extern "c" fn sockaddr_make(addr : Bytes, port : UInt16) -> Bytes = "moonbit_tonyfettes_socket_inet_sockaddr_make"

///|
pub fn Sockaddr::new(addr : Addr, port : UInt16) -> Sockaddr {
  Sockaddr(sockaddr_make(addr.0, port))
}

///|
pub fn sockaddr(addr : Addr, port : UInt16) -> Sockaddr {
  Sockaddr::new(addr, port)
}

///|
pub impl @socket.ToSockaddr for Sockaddr with to_sockaddr(self : Sockaddr) -> @socket.Sockaddr {
  @socket.Sockaddr(self.0)
}

///|
pub impl @socket.ToSockaddr for Sockaddr with of_sockaddr(
  sockaddr : @socket.Sockaddr,
) -> Sockaddr? {
  if sockaddr.family() == family {
    Some(Sockaddr(sockaddr.0))
  } else {
    None
  }
}

///|
struct Addr(Bytes)

///|
pub fn Addr::new(b0 : Byte, b1 : Byte, b2 : Byte, b3 : Byte) -> Addr {
  Addr([b0, b1, b2, b3])
}

///|
pub fn addr(b0 : Byte, b1 : Byte, b2 : Byte, b3 : Byte) -> Addr {
  Addr::new(b0, b1, b2, b3)
}

///|
pub impl Show for Addr with output(self : Addr, logger : &Logger) -> Unit {
  let b0 = self.0.unsafe_get(0).to_int()
  let b1 = self.0.unsafe_get(1).to_int()
  let b2 = self.0.unsafe_get(2).to_int()
  let b3 = self.0.unsafe_get(3).to_int()
  logger.write_object(b0)
  logger.write_char('.')
  logger.write_object(b1)
  logger.write_char('.')
  logger.write_object(b2)
  logger.write_char('.')
  logger.write_object(b3)
}

///|
pub impl ToJson for Addr with to_json(self : Addr) -> Json {
  self.to_string().to_json()
}

///|
#borrow(sin)
extern "c" fn sockaddr_addr(sin : Sockaddr) -> Bytes = "moonbit_tonyfettes_socket_inet_sockaddr_addr"

///|
pub fn Sockaddr::addr(self : Sockaddr) -> Addr {
  Addr(sockaddr_addr(self))
}

///|
#borrow(sin)
extern "c" fn sockaddr_port(sin : Sockaddr) -> UInt16 = "moonbit_tonyfettes_socket_inet_sockaddr_port"

///|
pub fn Sockaddr::port(self : Sockaddr) -> UInt16 {
  sockaddr_port(self)
}

///|
extern "c" fn get_address_family() -> Int = "moonbit_tonyfettes_socket_inet_address_family"

///|
pub let family : Int = get_address_family()
