class_name Colleague
extends Node

var _mediator: Mediator
var _colleague_code: int


func _init(new_mediator: Mediator):
	_mediator = new_mediator
	_mediator.add_colleague(self)


func sale_offer(stock: String, shares: int) -> void:
	_mediator.sale_offer(stock, shares, _colleague_code)
	
	
func buy_offer(stock: String, shares: int) -> void:
	_mediator.buy_offer(stock, shares, _colleague_code)
	
	
func set_colleague_code(new_colleague_code: int) -> void:
	_colleague_code = new_colleague_code
