const LOG_FORMAT = Dates.DateFormat("yyyy-mm-ddTHH:MM:SS.sss")

function log_stream(stream::Requests.ResponseStream, log_path::String; verbose::Bool = true)
    while true
        tick = next(stream)
        open(log_path,"a") do f
            write(f, Dates.format(tick.recd, LOG_FORMAT), " ")
            write(f, Dates.format(tick.sent, LOG_FORMAT), " ")
            write(f, tick.pair, "\n")
        end
    end
end

function log_stream(stream::Requests.ResponseStream, log_path::String; verbose::Bool = true)
    while true
        tick = next(stream)
        open(log_path,"a") do f
            write(f, Dates.format(tick.recd, LOG_FORMAT), " ")
            write(f, Dates.format(tick.sent, LOG_FORMAT), " ")
            write(f, tick.pair, " ")
            write(f, tick.ask, " ")
            write(f, tick.bid, "\n")
        end
    end
end

function log_tick(tick::Tick, log_path::String)
    open(log_path,"a") do f
        write(f, JSON.json(tick), "\n")
    end
end