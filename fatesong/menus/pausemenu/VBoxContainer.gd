extends VBoxContainer


func _ready():
	$Resume.connect("pressed", self, "resume")
	$MainMenu.connect("pressed", self, "main_menu")
	$Quit.connect("pressed", self, "quit")


func resume():
	get_tree().paused = false
	get_parent().get_parent().queue_free()


func main_menu():
	get_tree().change_scene("res://fatesong/menus/mainmenu/MainMenu.tscn")
	get_parent().get_parent().queue_free()
	get_tree().paused = false


func quit():
	get_tree().quit(0)
