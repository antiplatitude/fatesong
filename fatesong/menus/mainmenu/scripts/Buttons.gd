extends VBoxContainer

func _ready():
	$NewGame.connect("pressed", self, "newGame")
	$LoadGame.connect("pressed", self, "loadGame")
	$Options.connect("pressed", self, "options")


func newGame():
	$ClickSound.play(1.5)
	get_tree().change_scene("res://fatesong/game/game/Game.tscn")

func loadGame():
	$ClickSound.play(1.5)

func options():
	$ClickSound.play(1.5)
