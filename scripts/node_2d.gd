extends Node2D
const JOURNAL_TESTS = preload("uid://d1js1sibxgnxg")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var journal = JOURNAL_TESTS.instantiate()
	Dialogic.start("timeline")
	add_child(journal)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
