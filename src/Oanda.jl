__precompile__()
module Oanda
using Requests, JSON, StatsBase
export pricing, pipe, lineTest, logging, books
include("init.jl")
include("pricing.jl")
include("pipe.jl")
include("logging.jl")
include("books.jl")
end
