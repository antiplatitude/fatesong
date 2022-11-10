# player.gd - Elijah Burke


class_name Player
extends KinematicBody
# Component bag for all funcitonality used by user-controlled player character


onready var _camera_mount = $CameraMount
onready var _camera = $CameraMount/Camera
onready var _movement_component = $PlayerMovementComponent


# Setup components
func _ready() -> void:
	_movement_component.setup(self, _camera_mount, _camera)
