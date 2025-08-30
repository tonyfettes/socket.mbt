///|
struct IPv4Address(Bytes)

///|
extern "c" fn sockaddr_in_make() -> IPv4Address = "moonbit_tonyfettes_socket_sockaddr_in_make"

///|
struct IPv6Address(Bytes)

///|
extern "c" fn sockaddr_in6_make() -> IPv6Address = "moonbit_tonyfettes_socket_sockaddr_in6_make"

///|
struct Address(Bytes)

///|
extern "c" fn sockaddr_make() -> Address = "moonbit_tonyfettes_socket_sockaddr_make"

///|
struct AddressStorage(Bytes)

///|
extern "c" fn sockaddr_storage_make() -> AddressStorage = "moonbit_tonyfettes_socket_sockaddr_storage_make"

///|
pub(all) enum Protocol {
  Local
  IPv4(@ip.Protocol)
  IPv6(@ip.Protocol)
}

///|
priv enum AF {
  UNIX = 0
  INET = 1
  INET6 = 2
}

///|
priv enum SOCK {
  STREAM = 1
  DGRAM = 2
  RAW = 3
  RDM = 4
  SEQPACKET = 5
}

///|
struct Socket(UInt64)

///|
extern "c" fn socket(domain : AF, type_ : SOCK, protocol : Int) -> Socket = "moonbit_socket"

///|
pub fn Socket::stream(protocol : Protocol) -> Socket {
  match protocol {
    Local => socket(AF::UNIX, SOCK::STREAM, 0)
    IPv4(protocol) => socket(AF::INET, SOCK::STREAM, protocol.to_int())
    IPv6(protocol) => socket(AF::INET6, SOCK::STREAM, protocol.to_int())
  }
}
