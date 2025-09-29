///|
pub typealias @ip.Protocol

///|
pub extern "c" fn socket(
  type_ : @socket.Type,
  protocol : @ip.Protocol,
) -> @socket.Socket = "moonbit_tonyfettes_socket_inet6_socket"

///|
struct Sockaddr(Bytes)

///|
pub impl ToJson for Sockaddr with to_json(self : Sockaddr) -> Json {
  { "addr": self.addr(), "port": self.port(), "scope_id": self.scope_id() }
}

///|
#borrow(addr)
extern "c" fn sockaddr_make(addr : FixedArray[UInt16], port : UInt16) -> Bytes = "moonbit_tonyfettes_socket_inet6_sockaddr_make"

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
struct Addr(FixedArray[UInt16])

///|
extern "c" fn inet6_addr_make(
  b0 : UInt16,
  b1 : UInt16,
  b2 : UInt16,
  b3 : UInt16,
  b4 : UInt16,
  b5 : UInt16,
  b6 : UInt16,
  b7 : UInt16,
) -> FixedArray[UInt16] = "moonbit_tonyfettes_socket_inet6_addr_make"

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
  Addr(inet6_addr_make(b0, b1, b2, b3, b4, b5, b6, b7))
}

///|
pub fn addr(
  b0 : UInt16,
  b1 : UInt16,
  b2 : UInt16,
  b3 : UInt16,
  b4 : UInt16,
  b5 : UInt16,
  b6 : UInt16,
  b7 : UInt16,
) -> Addr {
  Addr(inet6_addr_make(b0, b1, b2, b3, b4, b5, b6, b7))
}

///|
#borrow(addr)
extern "c" fn inet6_ntop(addr : FixedArray[UInt16]) -> Bytes = "moonbit_tonyfettes_socket_inet6_ntop"

///|
pub fn ntop(addr : Addr) -> String {
  let buf = inet6_ntop(addr.0)
  let buf_len = buf.length()
  let strlen = for i in 0..<buf_len {
    if buf[i] == 0 {
      break i
    }
  } else {
    buf_len
  }
  @encoding/utf8.decode_lossy(buf[:strlen])
}

///|
pub impl Show for Addr with output(self : Addr, logger : &Logger) -> Unit {
  logger.write_string(ntop(self))
}

///|
pub impl ToJson for Addr with to_json(self : Addr) -> Json {
  self.to_string().to_json()
}

///|
#borrow(sin)
extern "c" fn sockaddr_addr(sin : Sockaddr) -> FixedArray[UInt16] = "moonbit_tonyfettes_socket_inet6_sockaddr_addr"

///|
pub fn Sockaddr::addr(self : Sockaddr) -> Addr {
  sockaddr_addr(self)
}

///|
#borrow(sin)
extern "c" fn sockaddr_port(sin : Sockaddr) -> UInt16 = "moonbit_tonyfettes_socket_inet6_sockaddr_port"

///|
pub fn Sockaddr::port(self : Sockaddr) -> UInt16 {
  sockaddr_port(self)
}

///|
extern "c" fn get_address_family() -> Int = "moonbit_tonyfettes_socket_inet6_address_family"

///|
pub let family : Int = get_address_family()

///|
#borrow(sin)
extern "c" fn sockaddr_scope_id(sin : Sockaddr) -> UInt = "moonbit_tonyfettes_socket_inet6_sockaddr_scope_id"

///|
pub fn Sockaddr::scope_id(self : Sockaddr) -> UInt {
  sockaddr_scope_id(self)
}

///|
pub const AddrStrLen = 46
