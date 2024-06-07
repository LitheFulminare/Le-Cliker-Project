extends Node

var qtd = 0
var cost = 1400
var bonus = 1

func increase_price():
	if qtd < 5:
		cost *= 1.25
	elif qtd < 10:
		cost *= 1.5
	else:
		cost *= 2.5
		
	if qtd % 5 == 0:
		bonus += 1
		
	int(cost)
	return cost
