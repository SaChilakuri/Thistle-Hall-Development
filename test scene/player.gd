extends CharacterBody2D

const SPEED = 10000

func _process(delta: float) -> void:
	velocity = Vector2(0,0)
	if Input.is_action_pressed('ui_up'):
		velocity.y = -SPEED * delta
	if Input.is_action_pressed('ui_down'):
		velocity.y = SPEED * delta
	if Input.is_action_pressed('ui_left'):
		velocity.x = -SPEED * delta
	if Input.is_action_pressed('ui_right'):
		velocity.x = SPEED * delta
	
	move_and_slide()
	
