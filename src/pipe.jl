function pipe(stream::Requests.ResponseStream)
    while nb_available(stream.buffer) == 0
        #yield()
        print(nb_available(stream.buffer) == 0)
    end
    tick = JSON.parse(readline(stream.buffer))
    get(tick,"type","") == "PRICE" ? flatten(tick): pipe(stream)
end

function flatten(tick::Dict{String,Any})
    Dict(
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
