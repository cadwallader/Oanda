using Oanda
using Base.Test

@testset "pricing" begin
    @test typeof(pricing("USD_JPY")) == HttpCommon.Response
    @test typeof(pricing("USD_JPY",true)) == Requests.ResponseStream{MbedTLS.SSLContext}
    @test typeof(pricing(["USD_JPY"])) == HttpCommon.Response
    @test typeof(pricing(["USD_JPY"],true)) == Requests.ResponseStream{MbedTLS.SSLContext}
end

@testset "pipe" begin
    @test typeof(pipe(pricing("USD_JPY",true))) == Dict{String,Any}
end
