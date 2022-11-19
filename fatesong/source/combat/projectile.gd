# projectile.gd - Elijah Burke


class_name Projectile
extends KinematicBody


var _velocity: float setget set_velocity, get_velocity
var _damage: float setget set_damage, get_damage


func _init(velocity := 0.0, damage := 0.0) -> void:
	self.set_velocity(velocity)
	self.set_damage(damage)


func _physics_process(delta) -> void:
	if self.move_and_collide(-self.global_transform.basis.z * self.get_velocity() * delta):
		self.queue_free()


func set_velocity(velocity: float) -> bool:
	if velocity > 0.0:
		_velocity = velocity
		return true
	else:
		_velocity = 0.0
		return false

func get_velocity() -> float:
	return _velocity


func set_damage(damage: float) -> bool:
	if damage > 0.0:
		_damage = damage
		return true
	else:
		_damage = 0.0
		return false


func get_damage() -> float:
	return _damage
