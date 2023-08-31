class_name StockMediator
extends Mediator
# https://www.youtube.com/watch?t=767&v=8DxIpdKd41A&feature=youtu.be

var _colleagues: Array
var _stock_buy_offers: Array
var _stock_sell_offers: Array
var _colleague_codes: int


func add_colleague(new_colleague: Colleague) -> void:
	_colleagues.append(new_colleague)
	_colleague_codes += 1
	new_colleague.set_colleague_code(_colleague_codes)


func sale_offer(stock: String, shares: int, colleague_code: int) -> void:
	var stock_sold := false
	
	for offer in _stock_buy_offers:
		if (offer as StockOffer).get_stock_symbol() == stock and (offer as StockOffer).get_share_count() == shares:
			print("%s shares of %s sold to colleague code %s" % [shares, stock, (offer as StockOffer).get_colleague_code()])	
			_stock_buy_offers.erase(offer)
			stock_sold = true
			
		if stock_sold:
			break
			
	if not stock_sold:
		print("%s share of %s added to inventory" % [shares, stock])
		var new_offering := StockOffer.new(shares, stock, colleague_code)
		_stock_sell_offers.append(new_offering)
	
	
func buy_offer(stock: String, shares: int, colleague_code: int) -> void:
	var stock_bought := false
	
	for offer in _stock_sell_offers:
		if (offer as StockOffer).get_stock_symbol() == stock and (offer as StockOffer).get_share_count() == shares:
			print("%s shares of %s bought to colleague code %s" % [shares, stock, (offer as StockOffer).get_colleague_code()])	
			_stock_sell_offers.erase(offer)
			stock_bought = true
			
		if stock_bought:
			break
			
	if not stock_bought:
		print("%s share of %s added to inventory" % [shares, stock])
		var new_offering := StockOffer.new(shares, stock, colleague_code)
		_stock_buy_offers.append(new_offering)
		
		
func get_stock_offerings() -> void:
	print("Stocks for sale")
	for offer in _stock_sell_offers:
		print("%s of %s" % [(offer as StockOffer).get_share_count(), (offer as StockOffer).get_stock_symbol()])
		
	print("Stocks for buy")
	for offer in _stock_buy_offers:
		print("%s of %s" % [(offer as StockOffer).get_share_count(), (offer as StockOffer).get_stock_symbol()])
