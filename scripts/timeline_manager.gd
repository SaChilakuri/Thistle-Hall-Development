extends Node2D

# timeline_manager.gd Descrption:
# This script will run the Dialogic.start methods for the game
# (AT LEAST FOR FIRST PLAYTEST, FUTURE WHO KNOWS)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_minerva_1_1_timeline_ended)
	Dialogic.start("MinervaFirstMeeting")
	Dialogic.start("foshi_meeting")

func _on_minerva_1_1_timeline_ended():
	Dialogic.start("SilasFirstMeeting")
