extends CharacterBody2D
@onready var label: Label = $"../Label"

const SPEED = 500
const JUMP_VELOCITY = -400.0

var moving = false

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if not moving:
		var x_direction := Input.get_axis("player_left", "player_right")
		if x_direction:
			label.text = "Moving: True"
			velocity.x = x_direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		var y_direction := Input.get_axis("player_up", "player_down")
		if y_direction:
			velocity.y = y_direction * SPEED
			label.text = "Moving: True"
		else:
			velocity.y = y_direction * SPEED
		
		if y_direction != 0 or x_direction != 0:
			moving = true
	elif velocity.x == 0 and velocity.y == 0:
		moving = false
		label.text = "Moving: False"
		
	
	move_and_slide()
