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

///|
pub fn Protocol::of_int(i : Int) -> Protocol? {
  match i {
    0 => Some(Protocol::HOPOPT)
    1 => Some(Protocol::ICMP)
    2 => Some(Protocol::IGMP)
    3 => Some(Protocol::GGP)
    4 => Some(Protocol::IPV4)
    5 => Some(Protocol::ST)
    6 => Some(Protocol::TCP)
    7 => Some(Protocol::CBT)
    8 => Some(Protocol::EGP)
    9 => Some(Protocol::IGP)
    12 => Some(Protocol::PUP)
    17 => Some(Protocol::UDP)
    22 => Some(Protocol::IDP)
    27 => Some(Protocol::RDP)
    41 => Some(Protocol::IPV6)
    _ => None
  }
}
