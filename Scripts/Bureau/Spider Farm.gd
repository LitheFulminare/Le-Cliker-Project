extends Node

var qtd = 0
var cost = 500
var bonus = 1
var cap = 10

func increase_price():
	if qtd < 5:
		cost *= 1.2
	elif qtd < 10:
		cost *= 1.3
	else:
		cost *= 1.4
		
	if qtd % 5 == 0:
		bonus += 1
	if qtd % 10 == 0:
		bonus *= 2
		
	int(cost)
	return cost
