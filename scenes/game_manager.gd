extends Node

var memory_keys_today = []
# The key is a 4 digit int code to access that specific memory
# Index of array 0 should be the description of the info
# Index 1 is that actual info
# Index 2 is a bool to say wether the protag has learnt the info or not
# Index 3 is a bool for wether the key relates to a characters name
var memory_log = {
	1000 : ["the girl with an afro's name", "Minerva", false, true]
}

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_timeline_ended():
	# Once timeline ends, check if a new memory was obtained, and take it-
	# If it has
	var memory_key = _get_memory_key()
	if memory_key != 0:
		memory_keys_today.append(memory_key)
		print(memory_keys_today)

func _get_memory_key():
	return Dialogic.VAR.learnt_code

func _end_of_day():
	memory_keys_today.clear()

func _process(delta: float) -> void:
	# These are just debug inputs to start a test dialouge scene and-
	# -reload the scene as well
	#
	if Input.is_action_just_pressed("q"):
		Dialogic.start("timeline3")
		Dialogic.VAR.temp_bool = has_learnt_memory(1000)
	if Input.is_action_just_pressed("r"):
		get_tree().change_scene_to_file("res://scenes/node_2d.tscn")
		memory_log[1000][2] = false

func has_learnt_memory(key: int) -> bool:
	# Purpose:
	# Check if a memory has been learnt or not
	# Params:
	# Key associated with that memory's info (int)
	# Returns:
	# Bool of wether the player has learnt that memory or not (bool)
	return memory_log[key][2]
