extends Node

var qtd = 0
var cost = 50
var bonus = 1
var cap = 15

func increase_price():
	if qtd < 5:
		cost *= 1.1
	elif qtd < 10:
		cost *= 1.2
	else:
		cost *= 1.3
		
	if qtd % 5 == 0:
		bonus += 1
	if qtd % 10 == 0:
		bonus *= 2
	
	int(cost)
	return cost
