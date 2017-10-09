function logging(stream::Requests.ResponseStream, log_path::String)
    while true
        tick = Oanda.pipe(stream)
        open(log_path,"a") do f
            write(f,Dates.format(now(Dates.UTC), "yyyy-mm-ddTHH:MM:SS.sss"), " ")
            write(f,tick["time"]," ")
            write(f,tick["instrument"],"\n")
        end
    end
end

function logging(stream::Requests.ResponseStream, log_path::String, verbose::Bool)
    while true
        tick = Oanda.pipe(stream)
        open(log_path,"a") do f
            write(f,Dates.format(now(Dates.UTC), "yyyy-mm-ddTHH:MM:SS.sss"), " ")
            write(f,tick["time"]," ")
            write(f,tick["instrument"]," ")
            write(f,tick["asks"][1]["price"]," ")
            write(f,tick["bids"][1]["price"],"\n")
        end
    end
end


function packet_order_test(departures::Array{DateTime,1})
    order = sortperm(departures)
    line = [i for i in 1:length(order)]
    StatsBase.countmap(order - line)
end

function read_log(file::String)
    df = Dates.DateFormat("y-m-dTH:M:S.s")
    departures = DateTime[]
    arrivals = DateTime[]
    travel_times = Int[]
    pairs = String[]
    open(file) do f
        while !eof(f)
            l = split(readline(f)," ")
            departed = DateTime(l[2],df)
            arrived = DateTime(l[1],df)
            push!(travel_time,(arrived-departed).value)
            push!(arrivals,arrived)
            push!(departures,departed)
            push!(pairs,l[3])
        end
    end
    Dict{String,Array{Any,1}}("sent"=>departures, "received"=>arrivals, "latency"=>travel_times,"instrument"=>pairs)
end

function plot_log(travel_times::Array{Int,1})
    PlotlyJS.plot(PlotlyJS.scatter(y=travel_times))
end
