class_name Enemy


extends KinematicBody2D


var _aggro: bool
var _detected_player
onready var DetectionArea := $DetectionArea
onready var PlayerScene := load("res://fatesong/game/player/Player.tscn")


func _init():
	_aggro = false


func _physics_process(_delta):
	if _aggro:
		var collision = move_and_collide((_detected_player.position - position).normalized() * 64 * _delta)
		if collision:
			_detected_player.call("is_hit")
			_aggro = false


func _on_DetectionArea_body_entered(body):
	_aggro = true
	_detected_player = body


func _on_DetectionArea_body_exited(body):
	_aggro = false
