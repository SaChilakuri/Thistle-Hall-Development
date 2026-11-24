extends Node2D

const PUZZLE_SCENE = preload("uid://bpychkfoh1utj")
@onready var timer: Timer = $Timer
@onready var timer_label: Label = $timer_label
@onready var count_label: Label = $count_label
@onready var complete: Label = $complete
@onready var tutorial: CanvasLayer = $Tutorial
signal puzzles_solved
signal puzzles_failed
var puzzles_left = 5
var time = 120
var new_puzzle
var tutorial_puzzle = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Start the timer and create the first puzzle
	if tutorial_puzzle:
		tutorial.visible = true
		time = 200
	else:
		_next_puzzle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if tutorial_puzzle:
		if Input.is_action_just_pressed("click"):
			tutorial.visible = false
			tutorial_puzzle = false
			_next_puzzle()
	else:
		timer_label.text = "Time Remaining: " + str(time)
		count_label.text = "Puzzles Remaining: " + str(puzzles_left)

		# If player jumps, remove 5 seconds from the timer
		if Input.is_action_just_pressed("click"):
			if time >= 5:
				time -= 5

func _next_puzzle():
	# Purpose:
	# Create a new puzzle and add it to the scene tree, and connect the puzzle_complete signal to the _on_puzzle_complete function
	# Params:
	# None
	# Returns:
	# None
	if puzzles_left >= 0:
		new_puzzle = PUZZLE_SCENE.instantiate()
		new_puzzle.connect("puzzle_complete", _on_puzzle_complete)
		add_child(new_puzzle)

func _on_puzzle_complete():
	# Purpose:
	# Remove the puzzle from the scene tree, and check if there are any puzzles left to
	# complete. If there are no puzzles left, emit the puzzles_solved signal, otherwise, create a new puzzle.
	# Params:
	# None
	# Returns:
	# None
	if puzzles_left <= 0:
		print('finished!')
		complete.visible = true
		emit_signal("puzzles_solved")
		timer.stop()
	else:
		puzzles_left -= 1
		_next_puzzle.call_deferred()
	
func _on_timer_timeout() -> void:
	# Purpose:
	# This is just a pseudo timer, since the timer node itself doesn't let you subtract time.
	# Params:
	# None
	# Returns:
	# None
	if time > 0:
		time -= 1
	else:
		print('L')
		emit_signal("puzzles_failed")
		timer.stop()
