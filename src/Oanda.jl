__precompile__()
module Oanda
using Requests: json, get, get_streaming
export pricing
include("init.jl")
include("pricing.jl")
end
