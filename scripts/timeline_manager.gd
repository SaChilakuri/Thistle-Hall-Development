extends Node2D

var choices_dict = GameManager.important_choices
const JOURNAL = preload("uid://cndkumqu0y6mu")
@onready var tyforplaying: Label = $tyforplaying

# timeline_manager.gd Descrption:
# This script will run the Dialogic.start methods for the game
# (AT LEAST FOR FIRST PLAYTEST, FUTURE WHO KNOWS)

# Called when the node enters the scene tree for the first time.
var timeline_chains = {
	'aaa' : ["res://timelines/day_one/MinervaFirstMeeting.dtl", "res://timelines/day_one/SilasFirstMeeting.dtl", 
	"res://timelines/day_one/foshi_meeting.dtl", "res://timelines/day_one/big_fight_day_1.dtl"],
	# SPLIT ONE - Kicking Fo'Shi out or not
	'aaB' : ["res://timelines/day_one/foshi_talk_end1.dtl", "res://timelines/day_two/day_two_minerva_post_group_silas_gone.dtl", "res://timelines/day_two/day_two_minerva_rain_midday_silas_gone.dtl"],
	'aaC' : ["res://timelines/day_one/silas_talk_end1.dtl", "res://timelines/day_two/day_two_minerva_post_group_foshi_gone.dtl", "res://timelines/day_two/day_two_minerva_rain_midday_foshi_gone.dtl"],
}


var end_of_day = false

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start(timeline_chains[GameManager.current_timeline][GameManager.timeline_count])

func _on_timeline_ended():
	if GameManager.journal_after_timeline == true:
		_journal_time()
	else:
		if GameManager.timeline_count != timeline_chains[GameManager.current_timeline].size() - 1:
			GameManager.timeline_count += 1
		print('TL COUNT')
		Dialogic.start(timeline_chains[GameManager.current_timeline][GameManager.timeline_count])

func _journal_time():
	#Starts up the journal
	print('journal start works')
	var journal = JOURNAL.instantiate()
	add_child(journal)
	journal.connect("all_memories_learnt", _on_journal_finished.bind(journal))
	journal.global_position = Vector2(-550, -300)

func _on_journal_finished(journal):
	# Clears the journal from the screen and moves onto next thing
	GameManager.learnt_mem_codes_today.clear()
	GameManager.journal_after_timeline = false
	journal.queue_free()
	print("TIMELINE COUNT AFTER JOURNAL:")
	print(GameManager.timeline_count)
	_on_timeline_ended()
