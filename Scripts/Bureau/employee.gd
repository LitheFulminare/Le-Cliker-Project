extends Node

var qtd = 1
var cost = 50

func increase_price():
	if qtd < 5:
		cost *= 1.1
	elif qtd < 10:
		cost *= 1.5
	else:
		cost *= 2
	return int(cost)
