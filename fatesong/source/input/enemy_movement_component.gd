# enemy_movement_component.gd - Elijah Burke


class_name EnemyMovementComponent
extends MovementComponent
# Input handler for AI-controlled enemies
# Processes input from state machines that transition based on environmental
# stimuli (in theory)


var _move_speed: float


var _enemy: Enemy
var _detection_area: Area
var _detected_player: Player


func _init() -> void:
    _move_speed = 5.0


# Handle continuous inputs related to physics calulations.
func _physics_process(delta) -> void:
    if _detected_player != null:
        _enemy.move_and_slide(
                (
                    _detected_player.global_transform.origin
                    - _enemy.global_transform.origin
                ).normalized() * _move_speed,
                Vector3.UP
        )

    if not _enemy.is_on_floor():
            _enemy.move_and_collide(Vector3(0.0, -GRAVITY * delta, 0.0))


func setup(enemy: Enemy, detection_area: Area) -> void:
    _enemy = enemy
    _detection_area = detection_area

    _detection_area.connect(
            "body_entered",
            self,
            "_on_DetectionArea_body_entered"
    )
    _detection_area.connect(
            "body_exited",
            self,
            "_on_DetectionArea_body_exited"
    )


func _on_DetectionArea_body_entered(body: KinematicBody) -> void:
    AudioManager.aggro()
    if body is Player:
        _detected_player = body


func _on_DetectionArea_body_exited(body: KinematicBody) -> void:
    if body is Player:
        _detected_player = null
