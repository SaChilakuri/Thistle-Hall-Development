class_name memory
extends Node
## Description of the memory
var description: String = "";

## Value of the memory (for example, Someone's name)
var value: String = "";

## Where or not the memory has been learnt
var learnt: bool = false;

## Name of the dialogic variable to be written to
var dialogic_var_name = "";

func _init(Description, Value, Dialogic_Var_Name) -> void:
	description = Description
	value = Value
	dialogic_var_name = Dialogic_Var_Name

func update_dialogic():
	Dialogic.VAR.set_variable(dialogic_var_name,value)
