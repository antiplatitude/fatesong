extends Spatial


func _ready() -> void:
    AudioManager.song()


func _input(event) -> void:
    if event.is_action_pressed("pause"):
        get_tree().paused = true
        $PauseMenu.visible = true
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
