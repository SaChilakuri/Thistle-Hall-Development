extends Node2D
var journal_button_path: Resource = preload("res://scenes/journal_button.tscn") 
@onready var LeftPage = $LeftPage
@onready var RightPage = $RightPage


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var journal_button:Control = journal_button_path.instantiate()
	journal_button.memory_code = 1000
	
	RightPage.add_child(journal_button)
	
	journal_button = journal_button_path.instantiate()
	journal_button.memory_code = 1001
	
	RightPage.add_child(journal_button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
