extends VBoxContainer


func _ready():
	$MainMenu.connect("pressed", self, "main_menu")
	$Quit.connect("pressed", self, "quit")


func main_menu():
	get_tree().change_scene("res://fatesong/menus/mainmenu/MainMenu.tscn")


func quit():
	get_tree().quit(0)
