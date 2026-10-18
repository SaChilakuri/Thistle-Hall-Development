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
var memory_dict = {
	"1000" : ["The girl with an afro's name", "Minerva", false, true]
}

func _get_memory_description(key):
	# Purpose:
	# Gets the description of the memory relating to the key
	# Param:
	# key - A valid memory key (int)
	# Returns:
	# Description relating to the memory (str)
	return memory_dict[key][0]

func _get_memory_info(key):
	# Purpose:
	# Gets the information of what the player should learn
	# Param:
	# key - A valid memory key (int)
	# Returns:
	# The memory itself (str)
	return memory_dict[key][1]

func _get_memory_learnt(key):
	# Purpose:
	# Find wether or not a player has learnt a specific memory
	# Param:
	# key - A valid memory key (int)
	# Returns:
	# Wether the player has learnt the memory or not (bool)
	return memory_dict[key][2]

func _set_memory_learnt(key, boolean):
	# Purpose:
	# Set a memory to wether it's been learnt or not
	# Params:
	# key - A valid memory key (int)
	# boolean - What to change memory learnt status to (bool)
	memory_dict[key][2] = boolean
	
func _get_is_memory_name(key):
	# Purpose:
	# Find if the memory learnt is related to a name, used to help
	# update names in Dialogic
	# Param:
	# key - A valid memory key (int)
	# Returns:
	# Wether the memory associated with the key is a character's
	# name (bool)
	return memory_dict[key][3]

func _get_memory_keys():
	pass
