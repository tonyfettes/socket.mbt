///|
test "addr" {
  let addr = @inet6.addr(
    0x2001, 0x0db8, 0x85a3, 0x0000, 0x0000, 0x8a2e, 0x0370, 0x7334,
  )
  @json.inspect(addr, content="2001:db8:85a3::8a2e:370:7334")
}

///|
test "sockaddr" {
  let addr = @inet6.addr(
    0x2001, 0x0db8, 0x85a3, 0x0000, 0x0000, 0x8a2e, 0x0370, 0x7334,
  )
  let sockaddr = @inet6.sockaddr(addr, 8080)
  @json.inspect(sockaddr, content={
    "addr": "2001:db8:85a3::8a2e:370:7334",
    "port": 8080,
    "scope_id": 0,
  })
}

///|
test "ToSockaddr" {
  let addr = @inet6.addr(
    0x2001, 0x0db8, 0x85a3, 0x0000, 0x0000, 0x8a2e, 0x0370, 0x7334,
  )
  let sockaddr = @inet6.sockaddr(addr, 8080).to_sockaddr()
  @json.inspect(@inet6.Sockaddr::of_sockaddr(sockaddr), content=[
    { "addr": "2001:db8:85a3::8a2e:370:7334", "port": 8080, "scope_id": 0 },
  ])
}
