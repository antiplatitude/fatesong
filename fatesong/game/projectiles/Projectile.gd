extends RigidBody2D


class_name Projectile


var direction: Vector2
var speed: float

onready var CoinScene = preload("res://fatesong/game/items/Coin.tscn")


func _ready():
	direction = (get_global_mouse_position() - position).normalized()
	speed = 512.0
	rotation = direction.angle()
	apply_central_impulse(direction * 2000)
	$LaserSound.play(0.65)


func _physics_process(delta):	
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body is Enemy:
			var coin = CoinScene.instance()
			coin.position = body.position
			get_tree().get_root().add_child(coin)
			get_tree().get_root().get_node("Game/Player").call("play_death_sound")
			body.queue_free()
			queue_free()
		elif body is TileMap:
			queue_free()
