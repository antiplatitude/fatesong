extends KinematicBody2D

var moveSpeed := 100.0

var velocity := Vector2()
var facingDirection := Vector2()

onready var facingRayCast := get_node("PlayerFacingDirection")


func _ready():
	pass


#func _process(delta):
#	pass


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
	
	velocity = velocity.normalized()
	
	move_and_slide(velocity * moveSpeed)
