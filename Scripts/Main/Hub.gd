extends Node2D

@onready var fly = 50 # starts at 50

var gain_per_second = 0.0

var click_disabled = false
var click_mult = 1

var ten_k_milestone = false
var sector = 1
var new_sector_cost = 10000

var employee_block = false
var spider_farm_block = false
var fly_hunter_block = false

var spider_farm_gain = 0
var spider_mult = 0.5

var fly_hunter_gain = 0
var hunter_mult = 250

func _ready():
	$"New sector".visible = false
	$Control/Panel.visible = false

func _process(delta):
	update_text() # updates tooltip and cost/profit numbers
	calculate_gain_per_sec() # average gain per sec
	qtd_limit() # cap of how much employees you can have
	check_fly_milestones() # check milestones (10K, 100K, etc) and makes the NewSec button visible
	
func update_text():
	if fly < new_sector_cost:
		$Fly.text = "Moscas: " + str(int(fly))
	else:
		$Fly.text = "Moscas: " + str(new_sector_cost)
	$"Texto 1".text = "Empregado. \nCusto: " + str(int(employee.cost)) + "\nQuantidade: " + str(employee.qtd)+ "/" + str(employee.cap)
	$"Texto 2".text = "Fazenda de aranhas. \nCusto: " + str(int(spiderfarm.cost)) + "\nQuantidade:  " + str(spiderfarm.qtd) + "/" + str(spiderfarm.cap)
	$"Texto 3".text = "Caçadores de aranhas. \nCusto: " + str(int(flyhunter.cost)) + "\nQuantidade: " + str(flyhunter.qtd) + "/" + str(flyhunter.cap)
	
	
	$"Control/Button container/Employees".tooltip_text = "Cada empregado rende " + str(employee.bonus) + " por clique" 
	$"Control/Button container/Spider Farm".tooltip_text = "Rendendo " + str(spider_farm_gain*10) + "/s"
	$"Control/Button container/Fly Hunter".tooltip_text = "Rendendo " + str(hunter_mult * flyhunter.qtd * flyhunter.bonus) + " a cada 15s"

	$"VBoxContainer/Gain per click".text = "Ganho por clique: " + str(employee.qtd * employee.bonus * click_mult)
	$"VBoxContainer/Gain per sec".text = "Ganho médio por segundo: " + str(gain_per_second)

func calculate_gain_per_sec():
	var sf_per_sec = (spider_mult * spiderfarm.qtd * spiderfarm.bonus) * 10
	var fh_per_sec = (hunter_mult * flyhunter.qtd * flyhunter.bonus) / 15
	gain_per_second = int( sf_per_sec + fh_per_sec )

func qtd_limit(): # makes the icon translucid and unclickable upon reaching the cap
	if employee.qtd == employee.cap:
		$"Control/Button container/Employees".self_modulate = Color(1, 1, 1, 0.3)
		employee_block = true
	else:
		$"Control/Button container/Employees".self_modulate = Color(1, 1, 1, 1)
		employee_block = false
		
	if spiderfarm.qtd == spiderfarm.cap:
		$"Control/Button container/Spider Farm".self_modulate = Color(1, 1, 1, 0.3)
		spider_farm_block = true
	else: 
		$"Control/Button container/Spider Farm".self_modulate = Color(1, 1, 1, 1)
		spider_farm_block = false
		
	if flyhunter.qtd == flyhunter.cap:
		$"Control/Button container/Fly Hunter".self_modulate = Color(1, 1, 1, 0.3)
		fly_hunter_block = true
	else:
		$"Control/Button container/Fly Hunter".self_modulate = Color(1, 1, 1, 1)
		fly_hunter_block = false

func check_fly_milestones():
	#if sector == 1: # fly cap, initially 10K
	if fly > new_sector_cost:
		fly = new_sector_cost
	
	if employee_block && spider_farm_block && fly_hunter_block:
		if sector == 1:
			$"New sector".visible = true

func _input(event):
	if Input.is_action_just_pressed("Confirm"):
		var input_text = $Control/Panel/cheat.text
		print(input_text)
		fly = int(input_text)
		$Control/Panel/cheat.clear()
		$Control/Panel.visible = false
	if Input.is_action_just_pressed("Cheat Console"):
		if !$Control/Panel.visible:
			$Control/Panel.visible = true
		else: 
			$Control/Panel.visible = false
			$Control/Panel/cheat.clear()

func buy(choice):
	match choice:
		"employee":
			if !employee_block:
				fly -= int(employee.cost)
				employee.qtd += 1
		"spider farm":
			if !spider_farm_block:
				fly -= int(spiderfarm.cost)
				spiderfarm.qtd += 1
				if spiderfarm.qtd == 1:
					$"Spider farm".start()
		"fly hunter":
			if !fly_hunter_block:
				fly -= int(flyhunter.cost)
				flyhunter.qtd += 1
				if flyhunter.qtd == 1:
					$"Fly hunter".start()
		
	increase_price(choice)
	
func increase_price(choice):
	match choice:
		"employee":
			if !employee_block:
				employee.increase_price()
		"spider farm":
			if !spider_farm_block:
				spiderfarm.increase_price()
		"fly hunter":
			if !fly_hunter_block:
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
	fly_hunter_gain = hunter_mult * flyhunter.qtd * flyhunter.bonus
	fly += fly_hunter_gain
	$"Fly hunter".start()

func _on_click_button_pressed():
	if !click_disabled:
			fly += employee.qtd * employee.bonus * click_mult


func _on_new_sector_mouse_entered():
	if fly < new_sector_cost:
		$"New sector".self_modulate = Color(0.9, 0.1, 0.1)
	else:
		$"New sector".self_modulate = Color(0, 1, 0.016)


func _on_new_sector_mouse_exited():
	$"New sector".self_modulate = Color(1, 1, 1)


func _on_new_sector_pressed():
	print("new sector pressed")
	if fly == new_sector_cost:
		fly -= new_sector_cost
		new_sector_cost *= 10
		sector += 1
		$"New sector".visible = false
		employee.cap *= 2
		spiderfarm.cap *= 2
		flyhunter.cap *= 2
