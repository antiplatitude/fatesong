extends Control


func _ready() -> void:
    $Back.connect("pressed", self, "_on_Back_pressed")


func _on_Back_pressed() -> void:
    AudioManager.button()
    get_tree().change_scene("res://fatesong/source/menus/TitleScreen.tscn")
