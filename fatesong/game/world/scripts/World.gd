extends TileMap

# Procedural Generation
var random = RandomNumberGenerator.new()

var mapSize := Vector2(512, 512)

var noise = OpenSimplexNoise.new()
var noise_image = noise.get_image(512, 512)

onready var enemy = preload("res://fatesong/game/enemies/Enemy.tscn")
onready var pause_menu_scene = preload("res://fatesong/menus/pausemenu/PauseMenu.tscn")


func _ready():
	# Set up noise
	random.randomize()
	noise.seed = random.randi()
	noise.octaves = 4
	noise.period = 25.0
	noise.persistence = 0.5
	
	# Generate tiles
	for i in range(-(mapSize.x / 2), (mapSize.x / 2)):
		for j in range(-(mapSize.y / 2), (mapSize.y / 2)):
			var height : float = noise.get_noise_2d(i, j)
			
			# Arbitrary heightmapping, TODO finetune
			# Water
			if height <= -0.5:
				set_cell(i, j, 1)
			
			# Grass
			elif height < 0.25:
				set_cell(i, j, 0)
				if random.randf() > 0.999:
					var instance = enemy.instance()
					get_tree().root.add_child(instance)
					instance.position = Vector2(i * 32, j * 32)
			
			# Stone
			elif height < 0.5:
				set_cell(i, j, 2)
			
			# Snow
			else:
				set_cell(i, j, 3)
	
	# Generate sand near water and bare dirt near stone
	for i in range(-(mapSize.x / 2), (mapSize.x / 2)):
		for j in range(-(mapSize.y / 2), (mapSize.y / 2)):
			# Sand near water
			if get_cell(i, j) == 0 and (get_cell(i - 1, j) == 1 or get_cell(i + 1, j) == 1 or get_cell(i, j - 1) == 1 or get_cell(i, j + 1) == 1):
				set_cell(i, j, 4)
			
			# Dirt near stone
			if get_cell(i, j) == 0 and (get_cell(i - 1, j) == 2 or get_cell(i + 1, j) == 2 or get_cell(i, j - 1) == 2 or get_cell(i, j + 1) == 2):
				set_cell(i, j, 5)


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		var pause_menu_instance = pause_menu_scene.instance()
		get_tree().current_scene.get_node("Player").add_child(pause_menu_instance)
		get_tree().paused = true
