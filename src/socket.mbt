///|
pub(all) struct Sockaddr(Bytes)

///|
#borrow(sa)
extern "c" fn sockaddr_family(sa : Sockaddr) -> UInt16 = "moonbit_tonyfettes_socket_sockaddr_family"

///|
pub fn Sockaddr::family(self : Sockaddr) -> UInt16 {
  sockaddr_family(self)
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
