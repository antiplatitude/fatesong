# player.gd - Elijah Burke


class_name Player
extends KinematicBody
# Component bag for all functionality used by user-controlled player character


onready var _camera_mount = $CameraMount
onready var _camera = $CameraMount/Camera
onready var _movement = $PlayerMovementComponent
onready var _inventory = $InventoryComponent


# Setup components
func _ready() -> void:
	_movement.setup(self, _camera_mount, _camera)


# Adds an item to the player's inventory.
# Returns true on success, false otherwise
func pickup_item(item: WorldItem) -> bool:
	if _inventory.has_space():
		_inventory.add_item(item.get_item())
		item.queue_free()
		return true
	else:
		return false
