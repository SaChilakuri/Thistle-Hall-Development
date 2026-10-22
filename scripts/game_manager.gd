extends Node
	
var memory_keys_to_learn = []
# The key is a 4 digit int code to access that specific memory
# Index of array 0 should be the description of the info
# Index 1 is that actual info
# Index 2 is a bool to say wether the protag has learnt the info or not
# Index 3 is the associated dialogic variable name (used in an update_dialogic function)
var memory_log = {
	1000 : ["The girl with an afro's name", "Minerva", false, "Minerva.name"]
}

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_timeline_ended():
	# Once timeline ends, check if a new memory was obtained, and take it-
	# If it has
	var memory_key = _get_memory_key()
	if memory_key != 0:
		memory_keys_to_learn.append(memory_keys_to_learn)
		print(memory_keys_to_learn)

func _get_memory_key():
	return Dialogic.VAR.learnt_code

func _end_of_day():
	memory_keys_to_learn.clear()

func _process(delta: float) -> void:
	# These are just debug inputs to start a test dialouge scene and-
	# -reload the scene as well
	pass

func has_learnt_memory(key: int) -> bool:
	# Purpose:
	# Check if a memory has been learnt or not
	# Params:
	# Key associated with that memory's info (int)
	# Returns:
	# Bool of wether the player has learnt that memory or not (bool)
	return memory_log[key][2]

func update_dialogic(key: int) -> void:
	# Purpose:
	# Updates dialogic using the memory dictionary
	# Params:
	# Key associated with the memory's info
	
	Dialogic.VAR.set_variable(memory_log[key][3],memory_log[key][1])
