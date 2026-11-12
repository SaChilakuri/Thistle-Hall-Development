extends Node2D

@onready var puzzle_spot_markers: Node = $puzzle_spot_markers
@onready var h_wall_markers: Node = $h_wall_markers
@onready var v_wall_markers: Node = $v_wall_markers
const PUZZLE_H_WALL = preload("uid://ciirkdwewqb2h")
const PUZZLE_V_WALL = preload("uid://cmcl0tnjkgtbs")
const PUZZLE_PIECE = preload("uid://p3ligdab2mog")
const PUZZLE_PLAYER = preload("uid://debf07nuvr4ll")

var v_wall_positions = []
var h_wall_positions = []
var board_spots: Array = []
var num_walls = 7
var num_pieces = 5
signal puzzle_complete
var player
var instance
var walls = []
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
	for i in num_walls:
		var rand_pos = v_wall_positions.pick_random()
		instance = PUZZLE_V_WALL.instantiate()
		v_wall_positions.erase(rand_pos)
		instance.position = rand_pos
		instance.z_index = 1
		walls.append(instance)
		add_child(instance)
		rand_pos = h_wall_positions.pick_random()
		instance = PUZZLE_H_WALL.instantiate()
		instance.position = rand_pos
		walls.append(instance)
		add_child(instance)
	
	player = PUZZLE_PLAYER.instantiate()
	player.position = board_spots.pick_random()
	player.board_spots = board_spots.duplicate()
	board_spots.erase(player.position)
	add_child(player)
	
	for i in num_pieces:
		var rand_pos = board_spots.pick_random()
		instance = PUZZLE_PIECE.instantiate()
		instance.position = rand_pos
		instance.z_index = 0
		board_spots.erase(rand_pos)
		instance.connect("piece_collected", _on_piece_picked_up)
		add_child(instance)

func _on_piece_picked_up():
	num_pieces -= 1
	if num_pieces == 0:
		emit_signal("puzzle_complete")
		player.queue_free()
		_remove_walls()
		await get_tree().create_timer(1.33).timeout
		queue_free()

func _remove_walls():
	for wall in walls:
		wall.queue_free()
