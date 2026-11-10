extends CharacterBody2D
@onready var label: Label = $"../Label"
@onready var player_sprite: Sprite2D = $Sprite2D
@onready var puzzle_piece: Area2D = $"../puzzle_piece"
@onready var player: CharacterBody2D = $"."
@onready var puzzle_spot_markers: Node = $"../puzzle_spot_markers"


const SPEED = 500
const JUMP_VELOCITY = -400.0

var moving = false

var board_spots = []

func _ready() -> void:
	for marker in puzzle_spot_markers.get_children():
		board_spots.append(marker.global_position)

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if not moving:
		var x_direction := Input.get_axis("player_left", "player_right")
		if x_direction:
			label.text = "Moving: True"
			velocity.x = x_direction * SPEED
			global_position.x = round(global_position.x)
			print(global_position.x)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		var y_direction := Input.get_axis("player_up", "player_down")
		if y_direction == 1:
			player_sprite.z_index = -1
		elif y_direction == -1:
			player_sprite.z_index = 1
		if y_direction:
			velocity.y = y_direction * SPEED
			label.text = "Moving: True"
			global_position.y = round(global_position.y)
			print(global_position.y)
		else:
			velocity.y = y_direction * SPEED
		
		if y_direction != 0 or x_direction != 0:
			moving = true
	elif velocity.x == 0 and velocity.y == 0:
		moving = false
		global_position = _get_closest_tile()
		label.text = "Moving: False"
	move_and_slide()

func _get_closest_tile():
	var closest_pos = 9999
	var closest_spot = ''
	for spot in board_spots:
		var dist = player.global_position.distance_to(spot)
		if dist < closest_pos:
			closest_pos = dist
			closest_spot = spot
	print(closest_spot)
	return closest_spot
