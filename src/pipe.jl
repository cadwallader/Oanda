function pipe(stream::ResponseStream)
    data = ""
    while (data = readline(stream.buffer)) == ""
        sleep(.01)
    end
    tick = JSON.parse(data)
    tick["type"] == "PRICE" ? flatten(tick): pipe(stream)
end

function flatten(tick::Dict{String,Any})
    Dict(
        "instrument" => tick["instrument"],
        "time" => Dates.DateTime(tick["time"][1:end-7], Dates.DateFormat("y-m-dTH:M:S.s")),
        "liquidityAsk" => tick["asks"][1]["liquidity"],
        "liquidityBid" => tick["bids"][1]["liquidity"],
        "closeoutAsk" => parse(Float64,tick["closeoutAsk"]),
        "closeoutBid" => parse(Float64,tick["closeoutBid"]),
        "bid" => parse(Float64,tick["bids"][1]["price"]),
        "ask" => parse(Float64,tick["asks"][1]["price"]),
        "tradeable" => tick["tradeable"]
    )
end
