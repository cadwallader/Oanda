__precompile__()
module Oanda
using Requests: json, get
export pricing
include("init.jl")
include("pricing.jl")
end
