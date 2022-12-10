extends VBoxContainer


func _ready() -> void:
    $NewGame.connect("pressed", self, "_on_NewGame_pressed")
    $LoadGame.connect("pressed", self, "_on_LoadGame_pressed")
    $About.connect("pressed", self, "_on_About_pressed")
    $HowToPlay.connect("pressed", self, "_on_HowToPlay_pressed")
    $Quit.connect("pressed", self, "_on_Quit_pressed")


func _on_NewGame_pressed() -> void:
    AudioManager.button()
    get_tree().change_scene("res://fatesong/source/game/Game.tscn")


func _on_LoadGame_pressed() -> void:
    AudioManager.button()
    pass


func _on_About_pressed() -> void:
    AudioManager.button()
    get_tree().change_scene("res://fatesong/source/menus/About.tscn")


func _on_HowToPlay_pressed() -> void:
    AudioManager.button()
    get_tree().change_scene("res://fatesong/source/menus/HowToPlay.tscn")


func _on_Quit_pressed() -> void:
    AudioManager.button()
    self.get_tree().quit(0)
