extends Node2D

# timeline_manager.gd Descrption:
# This script will run the Dialogic.start methods for the game
# (AT LEAST FOR FIRST PLAYTEST, FUTURE WHO KNOWS)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start("MinervaFirstMeeting")
