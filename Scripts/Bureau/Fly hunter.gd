extends Node

var qtd = 0
var cost = 1400
var bonus = 1
var cap = 5

func increase_price():
	if qtd < 5:
		cost *= 1.25
	elif qtd < 10:
		cost *= 1.5
	else:
		cost *= 1.7
		
	if qtd % 5 == 0:
		bonus += 1
	if qtd % 10 == 0:
		bonus *= 2
		
	int(cost)
	return cost
