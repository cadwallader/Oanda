static_url = "https://api-fxpractice.oanda.com/v3/accounts/" * account * "/pricing/?instruments="
stream_url = "https://stream-fxpractice.oanda.com/v3/accounts/" * account * "/pricing/stream?instruments="
headers = Dict("Content-Type" => "application/json", "Authorization" => "Bearer " * api_key)

function pricing(instrument::String)
    get(static_url * instrument; headers = headers)
end

function pricing(instrument::String, stream::Bool)
    url = stream ? stream_url : static_url
    get(url * instrument; headers = headers)
end
