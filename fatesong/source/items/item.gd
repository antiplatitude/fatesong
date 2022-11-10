# item.gd - Elijah Burke


class_name Item
extends Reference


const DEFAULT_NAME := "default_name"
const DEFAULT_MESH := preload("res://fatesong/resources/items/meshes/default_mesh.tres")
const DEFAULT_ICON := preload("res://fatesong/resources/items/icons/default_item.png")

var _name: String setget set_name, get_name
var _mesh: Mesh setget set_mesh, get_mesh
var _icon: Texture setget set_icon, get_icon


func _init(
		name = DEFAULT_NAME,
		mesh = DEFAULT_MESH,
		icon = DEFAULT_ICON
) -> void:
	self.set_name(name)
	self.set_mesh(mesh)
	self.set_icon(icon)


# Set the name of this item.
# Returns true on success, false otherwise.
func set_name(name: String) -> bool:
	if name.length() > 0 and name != null:
		_name = name
		return true
	else:
		_name = DEFAULT_NAME
		return false


# Returns the name of this item.
func get_name() -> String:
	return _name


# Set the mesh of this item.
# Returns true on success, false otherwise.
func set_mesh(mesh: Mesh) -> bool:
	if mesh != null:
		_mesh = mesh
		return true
	else:
		_mesh = DEFAULT_MESH
		return false


# Returns the mesh of this item.
func get_mesh() -> Mesh:
	return _mesh


# Set the icon of this item.
# Returns true on success, false otherwise.
func set_icon(icon: Texture) -> bool:
	if icon != null:
		_icon = icon
		return true
	else:
		_icon = DEFAULT_ICON
		return false


# Returns the icon of this item.
func get_icon() -> Texture:
	return _icon
