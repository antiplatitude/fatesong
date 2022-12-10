# player_movement_component.gd - Elijah Burke


class_name PlayerMovementComponent
extends MovementComponent
# Input handler for user-controlled player character
# Processes input from peripheral devices to control player actions. Parent must
# call setup to ensure proper functionality


signal item_used
signal item_unused

const Player = preload("res://fatesong/source/player/player.gd")

const MINIMUM_LOOK_ANGLE := -22.5
const MAXIMUM_LOOK_ANGLE := 67.5

var _velocity: Vector3
var _move_speed: float

var _mouse_delta: Vector2
var _look_sensitivity: float
var _camera_distance: float

var _player: Player
var _camera_mount: Spatial
var _camera: Camera


func _init() -> void:
    _velocity = Vector3.ZERO
    _move_speed = 5.0

    _mouse_delta = Vector2.ZERO
    _look_sensitivity = 0.5
    _camera_distance = 10.0


func _ready() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        _mouse_delta = event.relative
    elif event.is_action_pressed("use"):
        emit_signal("item_used")
    elif event.is_action_released("use"):
        emit_signal("item_unused")


# Handle non-physics continuous inputs
func _process(delta: float) -> void:
    _camera_mount.rotation_degrees -= (
            Vector3(rad2deg(_mouse_delta.y), 0.0, 0.0)
                * _look_sensitivity
                * delta
    )

    _camera_mount.rotation_degrees.x = (
            clamp(
                _camera_mount.rotation_degrees.x,
                MINIMUM_LOOK_ANGLE,
                MAXIMUM_LOOK_ANGLE
            )
    )

    _player.rotation_degrees -= (
            Vector3(0.0, rad2deg(_mouse_delta.x), 0.0) * _look_sensitivity * delta
    )

    _mouse_delta = Vector2()


# Handle continuous inputs related to physics calulations.
func _physics_process(delta: float) -> void:
    var movement_input := Vector2.ZERO
    var relative_velocity := Vector3.ZERO
    _velocity.x = 0.0
    _velocity.z = 0.0

    # Poll walking actions
    if Input.is_action_pressed("move_forward"):
        movement_input.y -= 1
    if Input.is_action_pressed("move_backward"):
        movement_input.y += 1
    if Input.is_action_pressed("move_left"):
        movement_input.x -= 1
    if Input.is_action_pressed("move_right"):
        movement_input.x += 1
    movement_input = movement_input.normalized()

    # Modify velocity relative to global transform
    relative_velocity = (
            global_transform.basis.z
            * movement_input.y
            + global_transform.basis.x
            * movement_input.x
    )

    _velocity.x = relative_velocity.x * _move_speed
    _velocity.z = relative_velocity.z * _move_speed
    _player.move_and_slide(_velocity, Vector3.UP, true, 4, 0.9)

    if not _player.is_on_floor():
        _player.move_and_collide(Vector3(0.0, -GRAVITY * delta, 0.0))

    if _velocity.x != 0.0 or _velocity.z != 0.0:
        AudioManager.footstep()
    else:
        AudioManager.stop_footstep()


func setup(player: Player, camera_mount: Spatial, camera: Camera) -> void:
    _player = player
    _camera_mount = camera_mount
    _camera = camera
    _camera.translate_object_local(Vector3(0.0, 10.0, 2.5))
    _camera.look_at(_player.transform.origin, Vector3.UP)


func get_velocity() -> Vector3:
    return _velocity
