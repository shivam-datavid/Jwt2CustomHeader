local jwt_decoder = require "kong.plugins.jwt.jwt_parser"
local inspect = require "inspect"

local function decode_jwt(token)
    kong.log.debug("Decoding JWT token: ", token)
    local jwt, err = jwt_decoder:new(token)
    if err then
        kong.log.err("Error decoding JWT: ", err)
        return nil, err
    end
    kong.log.debug("JWT decoded successfully: ", inspect(jwt))
    return jwt.claims, nil
end


local function get_claim_value(payload, claim_name)
    local value = payload
    for claim in claim_name:gmatch("[^.]+") do
        value = value[claim]
        if not value then
            return nil
        end
    end
    return value
end


local function execute(config)
    kong.log.debug("Executing plugin with configuration: ", config)
    local token = kong.request.get_header("authorization")
    if token then
        kong.log.debug("Authorization header found: ", token)
        local token_value = token:match("^Bearer%s+(.+)$")
        if token_value then
            local payload, _ = decode_jwt(token_value)
            if payload then
                kong.log.debug("JWT payload decoded successfully: ", inspect(payload))
                for _,mapping in ipairs(config.headers_to_claims) do
                    local header_name = mapping.header_name
                    local claim_name = mapping.claim_name
                    local value = get_claim_value(payload, claim_name)

                    if value then
                        kong.log.debug("Value extracted from JWT payload for header ", header_name, ": ", value)
                        kong.service.request.set_header(header_name, value)
                        kong.log.debug("New header added: ", header_name, "=", value)
                    else
                        kong.log.warn("Value not found in JWT payload for claim ", claim_name)
                    end
                end
            else
                kong.log.warn("Failed to decode JWT payload.")
            end
        else
            kong.log.warn("Bearer token not found in Authorization header.")
        end
    else
        kong.log.debug("Authorization header missing")
    end
end

return {
    execute = execute,
}

