extends Control
var memory_code = -1
@onready var button_ref: Button = $PanelContainer/button
signal pressed(memory_code)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if memory_code != -1:
		var memory = GameManager.memory_log[memory_code]
		button_ref.text = memory.description


func _on_button_pressed():
	pressed.emit(memory_code)
