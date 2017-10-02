__precompile__()
module Oanda
using Requests, JSON
export pricing, pipe, lineTest, logging
include("init.jl")
include("pricing.jl")
include("pipe.jl")
include("logging.jl")
end
