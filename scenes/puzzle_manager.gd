extends Node2D

const PUZZLE_SCENE = preload("uid://bpychkfoh1utj")
@onready var timer: Timer = $Timer
@onready var timer_label: Label = $timer_label
@onready var count_label: Label = $count_label
var puzzles_left = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_next_puzzle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_label.text = "Time Remaining: " + str(int(timer.time_left))
	count_label.text = "Puzzles Remaining: " + str(puzzles_left)

func _next_puzzle():
	if puzzles_left >= 0:
		var new_puzzle = PUZZLE_SCENE.instantiate()
		add_child(new_puzzle)
