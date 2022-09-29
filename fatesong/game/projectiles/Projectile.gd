extends RigidBody2D


class_name Projectile


var direction: Vector2
var speed: float


func _ready():
	direction = (get_global_mouse_position() - position).normalized()
	speed = 512.0
	rotation = direction.angle()
	apply_central_impulse(direction * 2000)


func _physics_process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body is Enemy:
			body.queue_free()
			queue_free()
		elif body is TileMap:
			queue_free()
