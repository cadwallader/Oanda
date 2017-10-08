function books(book::String, pair::String, t::DateTime)
    df = Dates.DateFormat("yyyy-mm-ddTHH:MM:00Z")
    dt = floor(t,Dates.Minute(20)) #else "errorMessage" => "Specified time 2017-10-08T01:22:55.230Z is misaligned."
    url = "https://api-fxpractice.oanda.com/v3/instruments/" * pair * "/" * book * "?time=" * Dates.format(dt,df)
    Requests.json(get(url; headers = Oanda.headers))[book]
end

function books(book::String, pair::String)
    url = "https://api-fxpractice.oanda.com/v3/instruments/" * pair * "/" * book
    Requests.json(get(url; headers = Oanda.headers))[book]
end

function books(book::String, pair::String, t::String)
    url = "https://api-fxpractice.oanda.com/v3/instruments/" * pair * "/" * book * "?time=" * t
    Requests.json(get(url; headers = Oanda.headers))[book]
end

function books(book::String, pair::String, t0::DateTime, t1::DateTime)
    out = Array{Any,1}()
    while t0 < t1
        push!(out,books(book,pair,t0))
        t0 += Dates.Minute(20)
        sleep(.1)
    end
    return out
end

function books(book::String, pair::Array{String,1}, t0::DateTime, t1::DateTime)
    out = Dict{String,Array{Any,1}}()
    for i in pair
        out[i] = books(book,i,t0,t1)
    end
    return out
end
    
