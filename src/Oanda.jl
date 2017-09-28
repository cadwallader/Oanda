__precompile__()
module Oanda
using Requests: json, get, get_streaming
export pricing, pipe
include("init.jl")
include("pricing.jl")
include("pipe.jl")
end
