extends TileMap

# Procedural Generation
var random = RandomNumberGenerator.new()

const mapSize := Vector2(512, 512)
const tile_size := 32

var noise = OpenSimplexNoise.new()
var noise_image = noise.get_image(512, 512)

var enemy_scene := preload("res://fatesong/game/enemies/Enemy.tscn")


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
			
			# Stone
			elif height < 0.5:
				set_cell(i, j, 2)
			
			# Snow
			else:
				set_cell(i, j, 3)
			
			if random.randf() > 0.999 and get_cell(i, j) != 1 and get_cell(i, j) != 2:
				spawn_enemy_squad(Vector2(i * tile_size, j * tile_size), random.randi_range(3, 6))
	
	# Generate sand near water and bare dirt near stone
	for i in range(-(mapSize.x / 2), (mapSize.x / 2)):
		for j in range(-(mapSize.y / 2), (mapSize.y / 2)):
			# Sand near water
			if get_cell(i, j) == 0 and (get_cell(i - 1, j) == 1 or get_cell(i + 1, j) == 1 or get_cell(i, j - 1) == 1 or get_cell(i, j + 1) == 1):
				set_cell(i, j, 4)
			
			# Dirt near stone
			if get_cell(i, j) == 0 and (get_cell(i - 1, j) == 2 or get_cell(i + 1, j) == 2 or get_cell(i, j - 1) == 2 or get_cell(i, j + 1) == 2):
				set_cell(i, j, 5)


func spawn_enemy_squad(spawn_position: Vector2, squad_size: int):
	var enemies = []
	enemies.resize(squad_size)
	enemies.fill(enemy_scene.instance())
	
	for enemy in enemies:
		var position_offset := Vector2(random.randi_range(-3, 3) * tile_size, random.randi_range(-3, 3) * tile_size)
		enemy.position = spawn_position + position_offset
		get_tree().get_root().add_child(enemy)
