class_name StockOffer
extends Node

var _share_count: int
var _stock_symbol: String
var _colleague_code: int

func _init(share_count: int, stock_symbol: String, colleague_code: int):
	_share_count = share_count
	_stock_symbol = stock_symbol
	_colleague_code = colleague_code
	
	
func get_share_count() -> int:
	return _share_count
	
	
func get_stock_symbol() -> String:
	return _stock_symbol
	
	
func get_colleague_code() -> int:
	return _colleague_code
