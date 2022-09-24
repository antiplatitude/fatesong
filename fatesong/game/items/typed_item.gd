extends Resource


class_name TypedItem


var name : String setget set_name, get_name
var type : ItemType setget set_type, get_type


func _init():
	set_name("default_item")
	set_type(ItemType.new())


func set_name(new_name: String):
	if new_name.length() > 0:
		name = new_name


func get_name() -> String:
	return name


func set_type(new_type: ItemType):
	type = new_type


func get_type() -> ItemType:
	return type
