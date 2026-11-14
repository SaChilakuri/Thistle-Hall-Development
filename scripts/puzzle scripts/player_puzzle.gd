extends CharacterBody2D
@onready var player_sprite: Sprite2D = $Sprite2D
@onready var player: CharacterBody2D = $"."


const SPEED = 500
const JUMP_VELOCITY = -400.0
var moving = false
var board_spots = []

func _physics_process(_delta: float) -> void:
	# INTENDED MOVEMENT:
	# Player should only move when they are not moving, and when they are moving, they should move in the direction of the input axis
	# Player should be unable to move diagonally, and should be unable to change directions while moving
	# Player should be able to click on a tile to jump to that tile, and should be unable to move while jumping to a tile
	if not moving:
		var x_direction := Input.get_axis("player_left", "player_right")
		if x_direction:
			velocity.x = x_direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		var y_direction := Input.get_axis("player_up", "player_down")
		if y_direction == 1:
			player_sprite.z_index = -1
		elif y_direction == -1:
			player_sprite.z_index = 1
		if y_direction:
			velocity.y = y_direction * SPEED
		else:
			velocity.y = y_direction * SPEED
		
		if y_direction != 0 or x_direction != 0:
			moving = true
		
		if Input.is_action_just_pressed("click"):
			var mouse_pos = get_viewport().get_mouse_position()
			mouse_pos.y -= 320
			mouse_pos.x -= 580
			global_position = _get_closest_tile(mouse_pos, board_spots)
	elif velocity.x == 0 and velocity.y == 0:
		moving = false
		_get_closest_tile(player.global_position, board_spots)
	move_and_slide()

func _get_closest_tile(body_location, board_tiles):
	# Purpose:
	# Get the closest tile to the player, and return that tile's position
	# Params:
	# body_location - The player's global position (Vector2)
	# board_tiles - An array of all the board tile positions (Array of Vector2)
	# Returns:
	# The closest tile's position (Vector2)
	var closest_pos = 99999
	var closest_spot = ''
	for spot in board_tiles:
		var dist = body_location.distance_to(spot)
		if dist < closest_pos:
			closest_pos = dist
			closest_spot = spot
	return closest_spot
	
