extends Node2D

var fly = 0
var click_disabled = false
var emp_cost = 50

var employees = 1

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
			fly += 1 * employees
			print(str(fly) + " moscas")

	if Input.is_action_just_pressed("Buy"):
		
		var choice = "employee" # "choice" will be defined by which button the player presses
								# in other words, by what the players chooses to buy
		
		if fly >= emp_cost:
			fly -= emp_cost
			employees += 1
			emp_cost = int(increace_price(choice))
			print(str(employees) + " empregados")
			print(str(fly) + " moscas")
			print("próximo custa: " + str(emp_cost))
		else: 
			print("pobre kk")

func _on_click_cooldown_timeout():
	click_disabled = false
	
func increace_price(choice):
	match choice:
		"employee":
			if employees < 5:
				emp_cost *= 1.1
			elif employees < 10:
				emp_cost *= 1.5
			else:
				emp_cost *= 2
			return emp_cost
