extends Node2D

const PUZZLE_SCENE = preload("uid://bpychkfoh1utj")
@onready var timer: Timer = $Timer
@onready var timer_label: Label = $timer_label
@onready var count_label: Label = $count_label
var puzzles_left = 5
var time = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_next_puzzle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_label.text = "Time Remaining: " + str(time)
	count_label.text = "Puzzles Remaining: " + str(puzzles_left)
	if Input.is_action_just_pressed("click"):
		time -= 5

func _next_puzzle():
	if puzzles_left >= 0:
		var new_puzzle = PUZZLE_SCENE.instantiate()
		new_puzzle.connect("puzzle_complete", _on_puzzle_complete)
		add_child(new_puzzle)
	print('complete!')

func _on_puzzle_complete():
	if puzzles_left <= 0:
		print('finished!')
	else:
		puzzles_left -= 1
		_next_puzzle.call_deferred()
	

func _on_timer_timeout() -> void:
	time -= 1
