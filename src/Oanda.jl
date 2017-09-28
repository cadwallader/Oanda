__precompile__()
module Oanda
using Requests, JSON
export pricing, pipe
include("init.jl")
include("pricing.jl")
include("pipe.jl")
end
