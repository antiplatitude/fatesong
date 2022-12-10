extends VBoxContainer


func _ready() -> void:
    $Resume.connect("pressed", self, "_on_Resume_pressed")
    $SaveGame.connect("pressed", self, "_on_SaveGame_pressed")
    $MainMenu.connect("pressed", self, "_on_MainMenu_pressed")
    $Quit.connect("pressed", self, "_on_Quit_pressed")


func _on_Resume_pressed() -> void:
    AudioManager.button()
    get_parent().get_parent().visible = false
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    get_tree().paused = false


func _on_SaveGame_pressed() -> void:
    AudioManager.button()


func _on_MainMenu_pressed() -> void:
    AudioManager.button()
    get_tree().paused = false
    get_tree().change_scene("res://fatesong/source/menus/TitleScreen.tscn")


func _on_Quit_pressed() -> void:
    AudioManager.button()
    get_tree().quit(0)
