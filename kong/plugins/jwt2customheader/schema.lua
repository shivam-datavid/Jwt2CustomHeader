local typedefs = require "kong.db.schema.typedefs"

return {
    name = "jwt2customheader",
    fields = {
        { consumer = typedefs.no_consumer },
        { protocols = typedefs.protocols_http },
        {
            config = {
                type = "record",
                fields = {
                    {
                        headers_to_claims = {
                            type = "array",
                            elements = {
                                type = "record",
                                fields = {
                                    { header_name = typedefs.header_name() },
				    { claim_name = {
                                        type = "string",
                                      }
			            },
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}

