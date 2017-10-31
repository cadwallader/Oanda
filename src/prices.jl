const STATIC_URL = "https://api-fxpractice.oanda.com/v3/accounts/" * ACCOUNT * "/pricing/?instruments="
const STREAM_URL = "https://stream-fxpractice.oanda.com/v3/accounts/" * ACCOUNT * "/pricing/stream?instruments="
const URL_DELIMITER = "%2C"

function price(instrument::String)
    Requests.get(STATIC_URL * instrument; headers = HEADERS)
end

function price(instruments::Array{String,1})
    price(join(instruments, URL_DELIMITER))
end

function price_stream(instrument::String)
    Requests.get_streaming(STREAM_URL * instrument; headers = HEADERS)
end

function price_stream(instruments::Array{String,1})
    price_stream(join(instruments, URL_DELIMITER))
end

function next(stream::Requests.ResponseStream)
    while nb_available(stream.buffer) == 0
        sleep(.001) #TODO do something useful like yield() instead of just sleep
    end
    tick = JSON.parse(readline(stream.buffer))
    get(tick, "type", "") == "PRICE" ? Tick(tick) : next(stream)
end

function flatten(tick::Dict{String,Any}) #NOTE ["asks"][1] and ["bids"][1] assume one liquidity provider per practice API, TODO test on live API
    Dict(
        "arrival" => Dates.format(now(Dates.UTC), "yyyy-mm-ddTHH:MM:SS.sss"),
        "instrument" => tick["instrument"],
        "time" => tick["time"][1:end-7],
        "liquidityAsk" => tick["asks"][1]["liquidity"],
        "liquidityBid" => tick["bids"][1]["liquidity"],
        "closeoutAsk" => parse(Float64,tick["closeoutAsk"]),
        "closeoutBid" => parse(Float64,tick["closeoutBid"]),
        "bid" => parse(Float64,tick["bids"][1]["price"]),
        "ask" => parse(Float64,tick["asks"][1]["price"]),
        "tradeable" => tick["tradeable"]
    )
end