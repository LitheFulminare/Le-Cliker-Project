extends Node

var qtd = 0
var cost = 50
var bonus = 1

func increase_price():
	if qtd < 5:
		cost *= 1.1
	elif qtd < 10:
		cost *= 1.3
	else:
		cost *= 1.7
		
	if qtd % 10 == 0:
		bonus += 1
	
	int(cost)
	return cost
