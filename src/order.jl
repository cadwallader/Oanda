const ORDER_URL = "https://api-fxpractice.oanda.com/v3/accounts/"*ACCOUNT*"/orders"

function order(pair::AbstractString, lotsize::Int8, stoploss::Int8, takeprofit::Int8, volatility::Int8, price::Float16)
	order = Dict{String,Dict}(
		order => Dict{String,String}(
			type => "MARKET_IF_TOUCHED", #["MARKET","LIMIT","STOP","MARKET_IF_TOUCHED","TAKE_PROFIT","STOP_LOSS","TRAILING_STOP_LOSS"]
			instrument => pair,
			# positive = long, negative = short
			units => string(lotsize),
			# The time-in-force requested for the Market Order. Restricted to FOK or IOC for a MarketOrder.
			# GTC The Order is “Good unTil Cancelled”
			# GTD The Order is “Good unTil Date” and will be cancelled at the provided time
			# GFD The Order is “Good For Day” and will be cancelled at 5pm New York time
			# FOK The Order must be immediately “Filled Or Killed”
			# IOC The Order must be “Immediatedly paritally filled Or Cancelled”
			timeInForce => "FOK",
			# How Positions are modified when Order is filled.
			# OPEN_ONLY only allow Positions to be opened or extended.
			# REDUCE_FIRST always fully reduce an existing Position before opening a new Position.
			# REDUCE_ONLY only reduce an existing Position.
			# DEFAULT use REDUCE_FIRST behaviour for non-client hedging Accounts, and OPEN_ONLY behaviour for client hedging Accounts.
			positionFill => "REDUCE_FIRST",
			# worst price acceptable
			# priceBound => string(price),
		)
	)

	Requests.post(ORDER_URL; headers = HEADERS; json = order)
end