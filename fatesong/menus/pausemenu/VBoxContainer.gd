extends VBoxContainer


func _ready():
	$Resume.connect("pressed", self, "resume")
	$MainMenu.connect("pressed", self, "main_menu")
	$Quit.connect("pressed", self, "quit")


func resume():
	$ClickSound.play(1.5)
	get_tree().paused = false
	get_parent().get_parent().queue_free()


func main_menu():
	$ClickSound.play(1.5)
	get_tree().change_scene("res://fatesong/menus/mainmenu/MainMenu.tscn")
	get_parent().get_parent().queue_free()
	get_tree().paused = false


func quit():
	$ClickSound.play(1.5)
	get_tree().quit(0)
