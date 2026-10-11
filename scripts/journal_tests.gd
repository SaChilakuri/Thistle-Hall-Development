extends Node2D

var memory_dict = Gamewideinfo.memory_log
@onready var top_l_button: Button = $top_L_button
@onready var button_2: Button = $button_2
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var memory_codeA = get_memory_key()
	top_l_button.text = memory_dict[1000][0]

func _on_button_pressed() -> void:
	learn_memory(get_memory_key())

func _on_button_2_pressed() -> void:
	learn_memory(get_memory_key())

func learn_memory(dict_key):
	var memory_description = memory_dict[dict_key][0]
	var memory_info = memory_dict[dict_key][1]
	if memory_dict[dict_key].size() == 4:
		var characters_name = memory_dict[dict_key][1]
		Dialogic.VAR.CHARACTER_NAMES[characters_name] = characters_name
	else:
		print("no name")
	
	# Just a bunch of print tests
	print("BEFORE:")
	print(memory_dict[dict_key])
	memory_dict[dict_key][2] = true
	
	# Changes the debug label
	label.text = "You have learnt " + memory_description + " is " + memory_info
	
	print(memory_dict[dict_key])
	Dialogic.start("timeline2")

func get_memory_key():
	return Dialogic.VAR.learnt_code
