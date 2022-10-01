extends KinematicBody2D

var moveSpeed := 128.0

var coins: int
var velocity := Vector2()
var facingDirection := Vector2()
var projectile_scene := preload("res://fatesong/game/projectiles/Projectile.tscn")

onready var facingRayCast := get_node("PlayerFacingDirection")
onready var label := $Camera2D/Label

func _init():
	coins = 0


func _ready():
	label.text = "Coins: 0"


func _process(delta):
	if Input.is_action_just_pressed("fire"):
		var projectile = projectile_scene.instance()
		projectile.position = position
		get_tree().get_root().add_child(projectile)


func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_pressed("move_north"):
		velocity.y -=1
		facingDirection = Vector2(0, -1)

	if Input.is_action_pressed("move_south"):
		velocity.y += 1
		facingDirection = Vector2(0, 1)

	if Input.is_action_pressed("move_east"):
		velocity.x += 1
		facingDirection = Vector2(1, 0)

	if Input.is_action_pressed("move_west"):
		velocity.x -=1
		facingDirection = Vector2(-1, 0)
	
	move_and_slide(velocity.normalized() * moveSpeed)


func is_hit():
	get_tree().change_scene("res://fatesong/menus/YouDied.tscn")


func add_coin():
	coins += 1
	label.text = "".join(["Coins: ", coins])
	if coins >= 10:
		get_tree().change_scene("res://fatesong/menus/YouWin.tscn")
