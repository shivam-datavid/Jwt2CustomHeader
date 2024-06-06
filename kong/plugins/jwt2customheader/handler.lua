local Jwt2CustomHeader = {
    -- Plugin priority, higher runs first
    PRIORITY = 1000,
    -- Plugin version
    VERSION = "1.0",
}
-- Importing the access module
local access = require "kong.plugins.jwt2customheader.access"
-- Implements the access phase
function Jwt2CustomHeader:access(config)
    access.execute(config)
end
return Jwt2CustomHeader
