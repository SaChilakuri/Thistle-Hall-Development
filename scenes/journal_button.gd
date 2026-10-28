extends Node2D
var memory_code = -1
@onready var button_ref: Button = $PanelContainer/button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if memory_code != -1:
		var memory = GameManager.memory_log[memory_code]
		button_ref.text = memory[2];
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
