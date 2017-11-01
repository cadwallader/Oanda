using Oanda
using Base.Test
@testset "pairs" begin
    #
    #
end
@testset "pricing" begin
    @test typeof(price("USD_JPY")) == HttpCommon.Response
    @test typeof(price_stream("USD_JPY",true)) == Requests.ResponseStream{MbedTLS.SSLContext}
    @test typeof(price(["USD_JPY"])) == HttpCommon.Response
    @test typeof(price_stream(["USD_JPY"],true)) == Requests.ResponseStream{MbedTLS.SSLContext}
end
