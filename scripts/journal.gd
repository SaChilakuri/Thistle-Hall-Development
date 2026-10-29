extends Node2D
var journal_button_path: Resource = preload("res://scenes/journal_button.tscn") 
@onready var LeftPage = $LeftPage
@onready var RightPage = $RightPage
@onready var learnt_label: Label = $LearntLabel
@onready var learnt_label_timer: Timer = $LearntLabel/Timer
@onready var num_learnable_label: Label = $NumLearnableLabel

var num_learnable = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.test_journal()
	for key in GameManager.learnt_mem_codes_today:
		create_journal_button(key)
	num_learnable = int(GameManager.learnt_mem_codes_today.size() / 2 + 1)
	_update_memories_to_learn_label()
	print(num_learnable)

func create_journal_button(memory_code: int):
	var journal_button:Control = journal_button_path.instantiate()
	journal_button = journal_button_path.instantiate()
	journal_button.memory_code = memory_code
	journal_button.pressed.connect(on_journal_button_pressed)
	RightPage.add_child(journal_button)
	print("I am a gamer")

func on_journal_button_pressed(memory_code: int):
	print(GameManager.memory_log[memory_code].get_value())
	num_learnable -= 1
	_update_memories_to_learn_label()
	display_learnt_info(memory_code)

func display_learnt_info(memory_code: int):
	var learnt_mem_instance = GameManager.memory_log[memory_code]
	learnt_label.visible = true
	learnt_label.text = "You have learnt " + learnt_mem_instance.get_description().to_lower() + ": " + learnt_mem_instance.get_value()
	learnt_label_timer.start()

func _on_label_timer_timeout() -> void:
	learnt_label.visible = false

func _update_memories_to_learn_label():
	num_learnable_label.text = "Number of Memories you can Learn: " + str(num_learnable)
