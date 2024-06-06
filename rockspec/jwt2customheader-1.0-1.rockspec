package = "jwt2customheader"
version = "1.0-1"
source = {
  url = "git://github.com/shivam-datavid/jwt2CustomHeader",
  branch = "main"
}
description = {
  summary = "Extract JWT and set custom header in Kong",
  detailed = [[
    This Kong Plugin will extract a JWT from the Authorization header,
    decode it, and set a new header with a value extracted from the JWT.
  ]],
  homepage = "https://github.com/shivam-datavid/jwt2CustomHeader",
  license = "MIT",
}
dependencies = {
  "lua >= 5.1",
  "kong >= 2.0",
  "inspect"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.jwt2customheader.handler"] = "kong/plugins/jwt2customheader/handler.lua",
    ["kong.plugins.jwt2customheader.access"] = "kong/plugins/jwt2customheader/access.lua",
    ["kong.plugins.jwt2customheader.schema"] = "kong/plugins/jwt2customheader/schema.lua",
  }
}
