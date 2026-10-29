extends Node
const Memory = preload("res://scripts/memory.gd")
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
# Index 3 is the name of the Dialogic variable associated with the memory
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Currently:
# 1xxx - Minerva
# 2xxx - Silas
# 3xxx - Fo'Shi
# THIS STRUCTURE MUST BE FOLLOWED!!!!!!!!
var memory_log : Dictionary[int, Memory]= {
	1000 : Memory.new("The girl with an afro's name", "Minerva", "Minerva.name"),
	1001 : Memory.new("Where the girl is from", "a suburb of Seattle", "Minerva.from"),
	1002 : Memory.new("The girl's hobbies", "knitting and crocheting", "Minerva.hobbies"),
	2000 : Memory.new("The guy with glasses' name", "Silas", "Silas.name"),
	2001 : Memory.new("Where the guy with glasses is from", "Rural Wisconsin", "Silas.from"),
	2002 : Memory.new("Glasses guy's hobbies", "Hiking and camping", "Silas.hobbies"),
	3000 : Memory.new("The monk's name", "Fo'Shi", "FoShi.name"),
	3001 : Memory.new("Where the monk's from", "China", "FoShi.from")
}

var important_choices = {
	"FoShiKickedOut" = null,
}

# LEARNT_MEM_CODES_TODAY GUIDE:
# A list of all memory codes obtained from dialogic's signal outputs
# (check _on_dialogic_signal for purpose and params of that)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# All memory codes learnt through one day will be stored here, and will be used to determine
# What shows up in the journal as an option to remember
var learnt_mem_codes_today = []

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(signal_arg: String):
	# Purpose:
	# When dialogic emits a signal, check if the length of the string
	# is 4, if it is, we know it's a mem code so we take it, and cast it to an int
	# to use with memory_log
	# Params:
	# signal arg - The signal from Dialogic (string)
	# Returns:
	# idk yet lol
	# IF the signal is a memory code, return that memory code as an int
	print("signal_arg: " + signal_arg)
	if signal_arg.length() == 4:
		# IF signal_arg is 4, we know it's a mem code
		var mem_code_int = int(signal_arg)
		print("memory code: " + signal_arg)
		learn_memory(mem_code_int)
		print(learnt_mem_codes_today)
	else:
		if "FoShi" in signal_arg:
			print("FoShi thing")
			if signal_arg == "KickFoShiOut":
				important_choices["FoShiKickedOut"] = true
			else:
				important_choices["FoShiKickedOut"] = false
			print(important_choices["FoShiKickedOut"])

func _end_of_day():
	learnt_mem_codes_today.clear()

func _get_memory_learnt(key):
	# Purpose:
	# Find wether or not a player has learnt a specific memory
	# Param:
	# key - A valid memory key (int)
	# Returns:
	# Wether the player has learnt the memory or not (bool)
	return memory_log[key].learnt

func _set_memory_learnt(key, boolean):
	# Purpose:
	# Set a memory to wether it's been learnt or not
	# Params:
	# key - A valid memory key (int)
	# boolean - What to change memory learnt status to (bool)
	memory_log[key].learnt = boolean

func learn_memory(key):
	learnt_mem_codes_today.append(key)

func update_dialogic(key: int) -> void:
	# Purpose:
	# Updates dialogic using the memory dictionary
	# Params:
	# Key associated with the memory's info
	memory_log[key].update_dialogic()

func test_journal():
	learn_memory(1000)
	learn_memory(2000)
	learn_memory(3000)
