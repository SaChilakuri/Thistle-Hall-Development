extends Node
	
# global_memory.gd Description:
# Global containing the Memory Dict as well as other things that
# frequently have to be accessed/updated.

# MEMORY DICT GUIDE:
# The key is a 4 digit int code to access that specific memory's info
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# The key's associated value points to an array with info 
# relating to the memory, following this structure:
#
# Index 0 should be the description of the info
# Index 1 is that actual info
# Index 2 is a bool to say wether the protag has learnt the info or not
# Index 3 is a bool for wether the key relates to a characters name
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# THIS STRUCTURE MUST BE FOLLOWED!!!!!!!!
var memory_keys_to_learn = []

var memory_log = {
	1000 : ["The girl with an afro's name", "Minerva", false, "Minerva.name"]
}

func _ready() -> void:
	print("ready")
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(signal_arg: String):
	# Purpose:
	# When dialogic emits a signal, check if the length of the string
	# is 4, if it is, we know it's a mem code
	# Params:
	# signal arg - The signal from Dialogic (string)
	# Returns:
	# idk yet lol
	if signal_arg.length() == 4:
		print("memory code")
	else:
		print("unrelated to mem codes")

func _end_of_day():
	memory_keys_to_learn.clear()

func _get_memory_learnt(key):
	# Purpose:
	# Find wether or not a player has learnt a specific memory
	# Param:
	# key - A valid memory key (int)
	# Returns:
	# Wether the player has learnt the memory or not (bool)
	return memory_log[key][2]

func _set_memory_learnt(key, boolean):
	# Purpose:
	# Set a memory to wether it's been learnt or not
	# Params:
	# key - A valid memory key (int)
	# boolean - What to change memory learnt status to (bool)
	memory_log[key][2] = boolean

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
