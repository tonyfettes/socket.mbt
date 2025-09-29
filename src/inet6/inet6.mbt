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
struct Addr(FixedArray[UInt16])

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
  Addr([b0, b1, b2, b3, b4, b5, b6, b7])
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
  Addr::new(b0, b1, b2, b3, b4, b5, b6, b7)
}

///|
pub impl Show for Addr with output(self : Addr, logger : &Logger) -> Unit {
  let b = self.0
  let mut longest = None
  let mut current = None
  for i in 0..<8 {
    match current {
      None => if b[i] == 0 { current = Some(i) }
      Some(offset) =>
        if b[i] != 0 {
          current = None
          let length = i - offset
          match longest {
            None => longest = Some((offset, length))
            Some((_, l)) => if length > l { longest = Some((offset, length)) }
          }
        }
    }
  }
  match current {
    Some(offset) => {
      let length = 8 - offset
      match longest {
        None => longest = Some((offset, length))
        Some((_, l)) => if length > l { longest = Some((offset, length)) }
      }
    }
    None => ()
  }
  match longest {
    Some((offset, length)) if length > 1 => {
      for i in 0..<offset {
        if i > 0 {
          logger.write_char(':')
        }
        logger.write_string(b[i].to_int().to_string(radix=16))
      }
      logger.write_string("::")
      for i in (offset + length)..<8 {
        if i > offset + length {
          logger.write_char(':')
        }
        logger.write_string(b[i].to_int().to_string(radix=16))
      }
    }
    Some(_) | None =>
      for i in 0..<8 {
        if i > 0 {
          logger.write_char(':')
        }
        logger.write_string(b[i].to_int().to_string(radix=16))
      }
  }
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
