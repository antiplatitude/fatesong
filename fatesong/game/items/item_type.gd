extends Resource


class_name ItemType


var type_name : String setget set_type_name, get_type_name


func _init():
	set_type_name("default_type")


func set_type_name(new_type_name: String):
	if new_type_name.length() > 0:
		type_name = new_type_name


func get_type_name() -> String:
	return type_name
