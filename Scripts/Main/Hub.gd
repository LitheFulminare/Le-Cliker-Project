extends Node2D

var fly = 50
var click_disabled = false
var click_mult = 1

var spider_farm_gain = 0
var spider_mult = 5

func _ready():
	pass

func _process(delta):
	$Fly.text = "Moscas: " + str(fly)
	$"Texto 1".text = "Empregado. \nCusto = " + str(int(employee.cost)) + "\nQuantidade = " + str(employee.qtd)
	$"Texto 2".text = "Fazenda de aranhas. \nCusto = " + str(int(spiderfarm.cost)) + "\nQuantidade = " + str(spiderfarm.qtd)

func _input(event):
	if Input.is_action_just_pressed("Click"):
		if !click_disabled:
			#click_disabled = true
			#$"Click Cooldown".start()
			fly += employee.qtd
			#print(str(fly) + " moscas")

func buy(choice):
	match choice:
		"employee":
			fly -= int(employee.cost)
			employee.qtd += 1
		"spider farm":
			fly -= int(spiderfarm.cost)
			spiderfarm.qtd += 1
		
	increace_price(choice)

func _on_click_cooldown_timeout():
	click_disabled = false
	
func increace_price(choice):
	match choice:
		"employee":
			employee.increase_price()
		"spider farm":
			spiderfarm.increace_price()


func _on_employees_pressed():
	if fly >= employee.cost:
		buy("employee")


func _on_spider_farm_pressed():
	if fly >= spiderfarm.cost:
		buy("spider farm")

func _on_spider_farm_timeout():
	spider_farm_gain = spider_mult * spiderfarm.qtd
	$"Control/Button container/Spider Farm".tooltip_text = "Rendendo " + str(spider_farm_gain) + "/s"
	fly += spider_farm_gain
