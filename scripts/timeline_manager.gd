extends Node2D

var choices_dict = GameManager.important_choices
const JOURNAL = preload("uid://cndkumqu0y6mu")

# timeline_manager.gd Descrption:
# This script will run the Dialogic.start methods for the game
# (AT LEAST FOR FIRST PLAYTEST, FUTURE WHO KNOWS)

# Called when the node enters the scene tree for the first time.
var timeline_chain = [
	"res://timelines/day_one/MinervaFirstMeeting.dtl", "res://timelines/day_one/SilasFirstMeeting.dtl", 
	"res://timelines/day_one/foshi_meeting.dtl", "res://timelines/day_one/big_fight_day_1.dtl",
	"res://timelines/day_one/foshi_talk_end1.dtl", "res://timelines/day_one/silas_talk_end1.dtl" 
]

var timeline_count = 0

var end_of_day = false

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start(timeline_chain[timeline_count])

func _on_timeline_ended():
	if end_of_day == false:
		timeline_count += 1
		if timeline_count == 1:
			_journal_time()
			return
		if choices_dict["FoShiKickedOut"] == true:
			Dialogic.start(timeline_chain[5])
			end_of_day = true
		elif choices_dict["FoShiKickedOut"] == false:
			Dialogic.start(timeline_chain[4])
			end_of_day = true
		Dialogic.start(timeline_chain[timeline_count])

func _journal_time():
	print('works')
	var journal = JOURNAL.instantiate()
	add_child(journal)
	journal.global_position = Vector2(-550, -300)
