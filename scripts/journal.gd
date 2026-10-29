extends Node2D
var journal_button_path: Resource = preload("res://scenes/journal_button.tscn") 
@onready var LeftPage = $LeftPage
@onready var RightPage = $RightPage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.test_journal()
	for key in GameManager.learnt_mem_codes_today:
		create_journal_button(key)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_journal_button(memory_code: int):
	var journal_button:Control = journal_button_path.instantiate()
	journal_button = journal_button_path.instantiate()
	journal_button.memory_code = memory_code
	journal_button.pressed.connect(on_journal_button_pressed)
	RightPage.add_child(journal_button)
	print("I am a gamer")

func on_journal_button_pressed(memory_code: int):
	print(memory_code)
