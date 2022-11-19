# full_auto_use_press.gd - Elijah Burke


class_name FullAutoUsePress
extends UsePressComponent


const _projectile = preload("res://fatesong/source/combat/Projectile.tscn")

var _muzzle: Spatial
var _player
var _fire_rate_timer: Timer
var _can_fire: bool


func _init(muzzle: Spatial, player) -> void:
	_muzzle = muzzle
	_player = player
	_fire_rate_timer = Timer.new()
	self.add_child(_fire_rate_timer)
	_can_fire = true


func _ready() -> void:
	_fire_rate_timer.connect("timeout", self, "_on_fire_rate_timer_timeout")


func behavior() -> void:
	shoot()
	_fire_rate_timer.start(0.15)


func shoot() -> void:
	var _projectile_instance := _projectile.instance()
	get_tree().root.get_node("Game").add_child(_projectile_instance)
	_projectile_instance.set_velocity(100.0)
	_projectile_instance.global_translation = _muzzle.global_translation
	_projectile_instance.rotation = _player.rotation


func _on_fire_rate_timer_timeout() -> void:
	shoot()


func unused() -> void:
	_fire_rate_timer.stop()
