///|
struct Sockaddr(Bytes)

///|
pub(open) trait ToSockaddr {
  bytes(Self) -> Bytes
  to_sockaddr(self : Self) -> Sockaddr = _
}

///|
impl ToSockaddr with to_sockaddr(self : Self) -> Sockaddr {
  Sockaddr(self.bytes())
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
struct Socket(UInt64)
