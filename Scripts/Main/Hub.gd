extends Node2D

var fly = 0
var click_disabled = false

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
		if fly >= 50:
			fly -= 50
			employees += 1
			print(str(employees) + " empregados")
			print(str(fly) + " moscas")
		else: 
			sprint("pobre kk")

func _on_click_cooldown_timeout():
	click_disabled = false
