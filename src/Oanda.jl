__precompile__()
module Oanda
using Requests, JSON, StatsBase
export pricing, pipe, lineTest, logging, books, instruments
include("init.jl")        #return values for account and api_key
include("pricing.jl")     #return buffered stream of price data for instrument(s)
include("pipe.jl")        #return next price from stream
include("logging.jl")     #write prices or program output to file
include("books.jl")       #return order book and/or position book for instrument(s) and time period(s)
include("instruments.jl") #return array of tradeable instruments for given account
end
