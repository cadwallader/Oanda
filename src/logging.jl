function logging(stream::Requests.ResponseStream, log_path::String)
    while true
        tick = pipe(stream)
        open(log_path,"a") do f
            write(f,Dates.format(now()+Dates.Hour(7), "yyyy-mm-ddTHH:MM:SS.sss"), " ")
            write(f,tick["time"]," ")
            write(f,tick["instrument"],"\n")
        end
    end
end

function log_test(timestamps::Array{Any,1})
    sorted = [find(timestamps .== i)[1] for i in sort(timestamps)] #duplicate indices if duplicates in timestamps due to find()[1]
    straight_line = [i for i in 1:length(test1)] #vector of indices
    deltas = sorted - straight_line
    running_tally = [sum(deltas[1:i]) for i in 1:length(deltas)]
    StatsBase.countmap(deltas)
end
