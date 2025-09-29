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
pub impl Default for Sockaddr with default() -> Sockaddr {
  sockaddr_make(0, 0)
}

///|
pub impl ToJson for Sockaddr with to_json(self : Sockaddr) -> Json {
  { "addr": self.addr(), "port": self.port() }
}

///|
extern "c" fn sockaddr_make(addr : UInt, port : UInt16) -> Bytes = "moonbit_tonyfettes_socket_inet_sockaddr_make"

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
pub struct Addr(UInt)

///|
pub impl Default for Addr with default() -> Addr {
  Addr(0)
}

///|
extern "c" fn inet_addr_make(
  b0 : Byte,
  b1 : Byte,
  b2 : Byte,
  b3 : Byte,
) -> UInt = "moonbit_tonyfettes_socket_inet_addr_make"

///|
pub fn Addr::new(b0 : Byte, b1 : Byte, b2 : Byte, b3 : Byte) -> Addr {
  Addr(inet_addr_make(b0, b1, b2, b3))
}

///|
pub fn addr(b0 : Byte, b1 : Byte, b2 : Byte, b3 : Byte) -> Addr {
  Addr(inet_addr_make(b0, b1, b2, b3))
}

///|
extern "c" fn inet_ntop(addr : UInt) -> Bytes = "moonbit_tonyfettes_socket_inet_ntop"

///|
pub fn ntop(addr : Addr) -> String {
  let buf = inet_ntop(addr.0)
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
#borrow(s)
extern "c" fn inet_pton(s : Bytes) -> UInt64 = "moonbit_tonyfettes_socket_inet_pton"

///|
pub fn pton(s : String) -> Addr? {
  let result = inet_pton(@encoding/utf8.encode(s))
  let status = (result >> 32).to_int()
  match status {
    1 => Some(Addr(result.to_uint()))
    _ => None
  }
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
extern "c" fn sockaddr_addr(sin : Sockaddr) -> UInt = "moonbit_tonyfettes_socket_inet_sockaddr_addr"

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

///|
pub const AddrStrLen = 16
