///|
pub(all) enum Protocol {
  HOPOPT = 0
  ICMP = 1
  IGMP = 2
  GGP = 3
  IPV4 = 4
  ST = 5
  TCP = 6
  CBT = 7
  EGP = 8
  IGP = 9
  PUP = 12
  UDP = 17
  IDP = 22
  RDP = 27
  IPV6 = 41
}

///|
pub fn Protocol::to_int(self : Protocol) -> Int = "%identity"
