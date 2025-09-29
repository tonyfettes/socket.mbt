///|
test "addr" {
  @json.inspect(@inet.addr(127, 0, 0, 1), content="127.0.0.1")
}

///|
test "sockaddr" {
  let addr = @inet.addr(127, 0, 0, 1)
  let sockaddr = @inet.sockaddr(addr, 8080)
  @json.inspect(sockaddr.addr(), content="127.0.0.1")
  @json.inspect(sockaddr.port(), content=8080)
}

///|
test "ToSockaddr" {
  let addr = @inet.addr(127, 0, 0, 1)
  let sockaddr = @inet.sockaddr(addr, 8080).to_sockaddr()
  @json.inspect(@inet.Sockaddr::of_sockaddr(sockaddr), content=[
    { "addr": "127.0.0.1", "port": 8080 },
  ])
}

///|
test "pton" {
  let result = @inet.pton("127.0.0.1")
  @json.inspect(result, content=["127.0.0.1"])
  let result = @inet.pton("256.0.0.1")
  @json.inspect(result, content=null)
}

///|
test "ntop" {
  let addr = @inet.addr(127, 0, 0, 1)
  let result = @inet.ntop(addr)
  @json.inspect(result, content="127.0.0.1")
}
