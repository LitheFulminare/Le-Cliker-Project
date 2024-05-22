extends Node2D

var fly = 0
var click_disabled = false
var emp_cost = 50

var employees = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
			emp_cost = int(emp_cost * 1.1)
			employees += 1
			print(str(employees) + " empregados")
			print(str(fly) + " moscas")
			print("próximo custa: " + str(emp_cost))
		else: 
			print("pobre kk")

func _on_click_cooldown_timeout():
	click_disabled = false
