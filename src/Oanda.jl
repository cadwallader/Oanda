__precompile__()
module Oanda
using Requests
export pricing
include("init.jl")
include("pricing.jl")
include("pipe.jl")
end
