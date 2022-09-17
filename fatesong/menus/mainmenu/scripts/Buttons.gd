extends VBoxContainer

func _ready():
	$NewGame.connect("pressed", self, "newGame")
	$LoadGame.connect("pressed", self, "loadGame")
	$Options.connect("pressed", self, "options")


func newGame():
	get_tree().change_scene("res://fatesong/game/game/Game.tscn")
