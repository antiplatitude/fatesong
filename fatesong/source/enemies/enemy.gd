# enemy.gd - Elijah Burke


class_name Enemy
extends KinematicBody
# Component bag for hostile NPCs


signal hit(damage)

onready var _movement_component = $EnemyMovementComponent
onready var _detection_area = $DetectionArea


# Setup components
func _ready() -> void:
	_movement_component.setup(self, _detection_area)
