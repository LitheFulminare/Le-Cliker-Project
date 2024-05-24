extends Node2D

@onready var fly = 50
var click_disabled = false
var click_mult = 1

var spider_farm_gain = 0
var spider_mult = 0.5

var fly_hunter_gain = 0
var hunter_mult = 250

func _ready():
	pass

func _process(delta):
	update_text()
	
func update_text():
	$Fly.text = "Moscas: " + str(int(fly))
	$"Texto 1".text = "Empregado. \nCusto: " + str(int(employee.cost)) + "\nQuantidade: " + str(employee.qtd)
	$"Texto 2".text = "Fazenda de aranhas. \nCusto: " + str(int(spiderfarm.cost)) + "\nQuantidade:  " + str(spiderfarm.qtd)
	$"Texto 3".text = "Caçadores de aranhas. \nCusto: " + str(int(flyhunter.cost)) + "\nQuantidade: " + str(flyhunter.qtd)
	
	$"Control/Button container/Employees".tooltip_text = "Cada empregado rende " + str(employee.bonus) + " por clique" 
	$"Control/Button container/Spider Farm".tooltip_text = "Rendendo " + str(spider_farm_gain*10) + "/s"
	$"Control/Button container/Fly Hunter".tooltip_text = "Rendendo " + str(hunter_mult * flyhunter.qtd) + " a cada 15s"

func _input(event):
	if Input.is_action_just_pressed("Click"):
		if !click_disabled:
			fly += employee.qtd * employee.bonus * click_mult

func buy(choice):
	match choice:
		"employee":
			fly -= int(employee.cost)
			employee.qtd += 1
		"spider farm":
			fly -= int(spiderfarm.cost)
			spiderfarm.qtd += 1
			if spiderfarm.qtd == 1:
				$"Spider farm".start()
		"fly hunter":
			fly -= int(spiderfarm.cost)
			flyhunter.qtd += 1
			if flyhunter.qtd == 1:
				$"Fly hunter".start()
		
	increase_price(choice)
	
func increase_price(choice):
	match choice:
		"employee":
			employee.increase_price()
		"spider farm":
			spiderfarm.increase_price()
		"fly hunter":
			flyhunter.increase_price()


func _on_employees_pressed():
	if fly >= employee.cost:
		buy("employee")


func _on_spider_farm_pressed():
	if fly >= spiderfarm.cost:
		buy("spider farm")

func _on_spider_farm_timeout():
	spider_farm_gain = spider_mult * spiderfarm.qtd * spiderfarm.bonus
	fly += spider_farm_gain
	$"Spider farm".start()


func _on_fly_hunter_pressed():
	if fly >= flyhunter.cost:
		buy("fly hunter")


func _on_fly_hunter_timeout():
	fly_hunter_gain = hunter_mult * flyhunter.qtd
	fly += fly_hunter_gain
	$"Fly hunter".start()
