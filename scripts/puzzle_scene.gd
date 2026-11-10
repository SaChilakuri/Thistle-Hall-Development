extends Node2D

@onready var puzzle_spot_markers: Node = $puzzle_spot_markers
@onready var wall_markers: Node = $wall_markers
@onready var h_wall: StaticBody2D = $h_wall
@onready var v_wall: StaticBody2D = $v_wall
const PUZZLE_H_WALL = preload("uid://ciirkdwewqb2h")
const PUZZLE_V_WALL = preload("uid://cmcl0tnjkgtbs")
const PUZZLE_PIECE = preload("uid://p3ligdab2mog")

var wall_positions = []
var board_spots = []
var num_walls = 10
var num_pieces = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for marker in wall_markers.get_children():
		wall_positions.append(marker.global_position)
	for marker in puzzle_spot_markers.get_children():
		board_spots.append(marker.global_position)
	board_spots.erase(Vector2(-40,40))
	_create_board()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _create_board():
	for i in num_walls:
		var instance = ''
		var rand_pos = wall_positions.pick_random()
		if i % 2 == 0:
			instance = PUZZLE_H_WALL.instantiate()
		else:
			instance = PUZZLE_V_WALL.instantiate()
		wall_positions.erase(rand_pos)
		instance.position = rand_pos
		instance.z_index = 1
		add_child(instance)
	
	for i in num_pieces:
		var instance = ''
		var rand_pos = board_spots.pick_random()
		instance = PUZZLE_PIECE.instantiate()
		instance.position = rand_pos
		board_spots.erase(rand_pos)
		instance.z_index = 0
		add_child(instance)
