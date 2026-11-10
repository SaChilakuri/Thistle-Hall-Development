extends Node2D

@onready var puzzle_spot_markers: Node = $puzzle_spot_markers
@onready var h_wall_markers: Node = $h_wall_markers
@onready var v_wall_markers: Node = $v_wall_markers
const PUZZLE_H_WALL = preload("uid://ciirkdwewqb2h")
const PUZZLE_V_WALL = preload("uid://cmcl0tnjkgtbs")
const PUZZLE_PIECE = preload("uid://p3ligdab2mog")

var v_wall_positions = []
var h_wall_positions = []
var board_spots = []
var num_walls = 5
var num_pieces = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for marker in v_wall_markers.get_children():
		v_wall_positions.append(marker.global_position)
	for marker in h_wall_markers.get_children():
		h_wall_positions.append(marker.global_position)
	for marker in puzzle_spot_markers.get_children():
		board_spots.append(marker.global_position)
	_create_board()

func _create_board():
	var instance = ''
	for i in num_walls:
		var rand_pos = v_wall_positions.pick_random()
		instance = PUZZLE_V_WALL.instantiate()
		v_wall_positions.erase(rand_pos)
		instance.position = rand_pos
		instance.z_index = 1
		add_child(instance)
		rand_pos = h_wall_positions.pick_random()
		instance = PUZZLE_H_WALL.instantiate()
		instance.position = rand_pos
		add_child(instance)
	
	
	for i in num_pieces:
		var rand_pos = board_spots.pick_random()
		instance = PUZZLE_PIECE.instantiate()
		instance.position = rand_pos
		board_spots.erase(rand_pos)
		instance.z_index = 0
		instance.connect("piece_collected", _on_piece_picked_up)
		add_child(instance)

func _on_piece_picked_up():
	num_pieces -= 1
	print(num_pieces)
