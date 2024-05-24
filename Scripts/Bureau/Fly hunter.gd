extends Node

var qtd = 0
var cost = 1400

func increase_price():
	if qtd < 5:
		cost *= 1.05
	elif qtd < 10:
		cost *= 1.5
	else:
		cost *= 2
	int(cost)
	return cost
