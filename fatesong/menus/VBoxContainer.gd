extends VBoxContainer


func _ready():
	$MainMenu.connect("pressed", self, "main_menu")
	$Quit.connect("pressed", self, "quit")


func main_menu():
	$ClickSound.play(1.5)
	get_tree().change_scene("res://fatesong/menus/mainmenu/MainMenu.tscn")


func quit():
	$ClickSound.play(1.5)
	get_tree().quit(0)
