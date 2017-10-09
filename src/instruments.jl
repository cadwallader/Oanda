function instruments(file::String)
    open(file,r) do f
        JSON.parse(readline(f))
    end
end

function instruments(fresh::Bool)
    fresh ? Requests.get("https://api-fxpractice.oanda.com/v3/accounts/"*Oanda.account*"/instruments";headers = Oanda.headers) : String["EUR_TRY","USD_JPY","CHF_ZAR","NZD_USD","USD_THB","GBP_CHF","EUR_SEK","USD_SGD","EUR_SGD","AUD_CHF","CHF_HKD","SGD_HKD","CHF_JPY","HKD_JPY","EUR_HUF","USD_CAD","USD_CHF","CAD_SGD","AUD_CAD","USD_SEK","GBP_SGD","GBP_HKD","NZD_CAD","AUD_USD","EUR_CAD","NZD_JPY","EUR_NZD","GBP_PLN","CAD_JPY","NZD_SGD","CAD_HKD","EUR_NOK","USD_SAR","GBP_CAD","USD_HUF","GBP_AUD","USD_PLN","GBP_USD","USD_MXN","AUD_JPY","EUR_CHF","AUD_SGD","EUR_CZK","GBP_ZAR","EUR_USD","EUR_ZAR","USD_ZAR","SGD_CHF","USD_CNH","GBP_JPY","USD_TRY","ZAR_JPY","USD_DKK","USD_HKD","EUR_HKD","AUD_NZD","AUD_HKD","TRY_JPY","EUR_AUD","EUR_PLN","EUR_DKK","USD_NOK","SGD_JPY","NZD_HKD","GBP_NZD","USD_CZK","EUR_JPY","EUR_GBP","NZD_CHF","CAD_CHF"]
end

function instruments()
    Requests.get("https://api-fxpractice.oanda.com/v3/accounts/"*Oanda.account*"/instruments";headers = Oanda.headers)
end

function instruments(data::HttpCommon.Response)
    [i["name"] for i in Requests.json(data)["instruments"]]
end
