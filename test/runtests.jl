using Oanda
using Base.Test

@testset "pricing" begin
    @test typeof(pricing("USD_JPY")) == HttpCommon.Response
end
