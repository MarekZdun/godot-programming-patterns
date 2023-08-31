extends Node

var stock_mediator: StockMediator
var broker_1: StockHolder1
var broker_2: StockHolder2


func _ready():
	stock_mediator = StockMediator.new()
	broker_1 = StockHolder1.new(stock_mediator)
	broker_2 = StockHolder2.new(stock_mediator)
	
	broker_1.sale_offer("MSFT", 100)
	broker_1.sale_offer("GOOG", 50)
	
	broker_2.buy_offer("MSFT", 100)
	broker_2.sale_offer("NRG", 10)
	
	broker_1.buy_offer("NRG", 10)
	
	stock_mediator.get_stock_offerings()
