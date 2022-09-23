extends KinematicBody2D


class_name Projectile


var direction: Vector2
var speed: float


func _ready():
	direction = (get_global_mouse_position() - position).normalized()
	speed = 512.0
	rotation = direction.angle()


func _physics_process(delta):
	move_and_collide(direction * speed * delta)
