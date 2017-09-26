static_url = "https://api-fxpractice.oanda.com/v3/accounts/" * account * "/pricing/?instruments="
stream_url = "https://stream-fxpractice.oanda.com/v3/accounts/" * account * "/pricing/stream?instruments="
headers = Dict("Content-Type" => "application/json", "Authorization" => "Bearer " * api_key)

function pricing(instrument::String)
    get(static_url * instrument; headers = headers)
end

function pricing(instrument::String, stream::Bool)
    stream ? get_streaming(stream_url * instrument; headers = headers) : pricing(instrument)
end

function pricing(instruments::Array{AbstractString,1})
    get(static_url * join(instruments,"%2C"); headers = headers)
end

function pricing(instruments::Array{AbstractString,1}, stream::Bool)
    stream ? get_streaming(stream_url * join(instruments,"%2C"); headers = headers) : pricing(instrument)
end
