class_name memory
extends Node
## Class meant to make the management of the memory mechanic easier
## Replaces the arrays in memory log, way easier to use the memory log
## outside of the game_manager.gd




## Description of the memory
var description: String = "";

## Value of the memory (for example, Someone's name)
var value: String = "";

## Where or not the memory has been learnt
var learnt: bool = false;

## Name of the dialogic variable to be written to
var dialogic_var_name = "";

func _init(Description: String, Value: String, Dialogic_Var_Name: String) -> void:
	description = Description
	value = Value
	dialogic_var_name = Dialogic_Var_Name

func update_dialogic():
	Dialogic.VAR.set_variable(dialogic_var_name,value)

static func isLearnt(mem: memory):
	return mem.learnt 
