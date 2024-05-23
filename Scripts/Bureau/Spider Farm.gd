extends Node

var qtd = 0
var cost = 1000

func increace_price():
	if qtd < 5:
		cost *= 1.1
	elif qtd < 10:
		cost *= 1.2
	else:
		cost *= 1.5
	int(cost)
	return cost
