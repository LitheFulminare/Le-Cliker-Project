extends Node2D

var fly = 0
var click_disabled = false

var emp_cost = 50
var spi_farm_cost = 1500

#var employees = 1
var spider_farm = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pass

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if !click_disabled:
			click_disabled = true
			$"Click Cooldown".start()
			fly += 1 * employee.qtd
			print(str(fly) + " moscas")

func buy(choice):

	if fly >= emp_cost:
		fly -= emp_cost
		employee.qtd += 1
		increace_price(choice)
		#emp_cost = int(increace_price(choice))
		print(str(employee.qtd) + choice)
		print(str(fly) + " moscas")
		print("próximo custa: " + str(emp_cost)) # find a way to put choice.cost
	else: 
		print("pobre kk")

func _on_click_cooldown_timeout():
	click_disabled = false
	
func increace_price(choice):
	match choice:
		"employee":
			employee.increase_price()


func _on_employees_pressed():
	buy("employee")


func _on_spider_farm_pressed():
	buy("spider farm")


func _on_spider_farm_timeout():
	fly += 1 * spider_farm
