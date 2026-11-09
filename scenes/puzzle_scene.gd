extends Node2D
@onready var wall_markers: Node = $wall_markers
@onready var h_wall: StaticBody2D = $h_wall
@onready var v_wall: StaticBody2D = $v_wall

var h_wall_positions = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for marker in wall_markers.get_children():
		print(marker.global_position)
		h_wall_positions.append(marker.global_position)
	h_wall.global_position = h_wall_positions.pick_random()
	h_wall.global_position.y -= 5
	v_wall.global_position = h_wall_positions.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
