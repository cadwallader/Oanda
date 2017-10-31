__precompile__()
module Oanda
using Requests, JSON
export price_stream, next, books, pairs
export Tick
type Tick
    ask::Float64
    bid::Float64
    sent::DateTime
    recd::DateTime
    pair::String
    live::Bool
end
function Tick(i::Dict{String,Any})
    new(
        parse(Float64,i["asks"][1]["price"]), #ask
        parse(Float64,i["bids"][1]["price"]), #bid
        DateTime(i["time"][1:end-7]),         #sent
        now(Dates.UTC),                       #recd
        i["instrument"],                      #pair
        i["tradeable"]                        #live
    )
end
include("init.jl")  #return values for account and api_key
const OANDA_HEADERS = Dict("Content-Type" => "application/json", "Authorization" => "Bearer " * API_KEY)
include("pairs.jl") #return array of tradeable instruments for given account
include("prices.jl")#return buffered stream of price data for instrument(s), #return next price from stream
include("books.jl") #return order book and/or position book for instrument(s) and time period(s)
include("logs.jl")  #write prices or program output to file
end