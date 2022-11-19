# terrain.gd - Elijah Burke


class_name Terrain
extends MeshInstance


var _enemy = preload("res://fatesong/source/enemies/Enemy.tscn")

var _map_size: Vector2 setget set_map_size, get_map_size
var _height_modifier: float
var _grass_surface: SurfaceTool
var _surfaces = {}

var _random: RandomNumberGenerator
var _noise: OpenSimplexNoise


func _init() -> void:
	self.mesh = ArrayMesh.new()
	
	_map_size = Vector2(256, 256)
	_height_modifier = 10.0
	_grass_surface = SurfaceTool.new()
	_surfaces["grass"] = SurfaceTool.new()
	_surfaces["dirt"] = SurfaceTool.new()
	_surfaces["rock"] = SurfaceTool.new()
	_surfaces["snow"] = SurfaceTool.new()
	
	_random = RandomNumberGenerator.new()
	_noise = OpenSimplexNoise.new()


func _enter_tree() -> void:
	_random.randomize()
	_setup_noise(_random.randi(), 4, 25.0, 0.5)
	_generate_mesh()


func _ready() -> void:
	for i in _map_size.x:
		for j in _map_size.y:
			if _random.randf() > 0.9999:
				var _enemy_instance = _enemy.instance()
				get_tree().root.get_node("Game").call_deferred("add_child", _enemy_instance)
				_enemy_instance.call_deferred("global_translate", Vector3(i, 10.0, j))


func set_map_size(map_size: Vector2) -> void:
	_map_size = map_size


func get_map_size() -> Vector2:
	return _map_size


func _setup_noise(
	new_seed: int,
	octaves: int,
	period: float,
	persistence: float
) -> void:
	_noise.seed = new_seed
	_noise.octaves = octaves
	_noise.period = period
	_noise.persistence = persistence


func _generate_mesh() -> void:
	for i in _surfaces:
		_surfaces[i].begin(Mesh.PRIMITIVE_TRIANGLES)
	
	_generate_heightmap()
	
	for i in _surfaces:
		_surfaces[i].index()
		_surfaces[i].generate_normals()
		self.mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, _surfaces[i].commit().surface_get_arrays(0))
	
	for i in _surfaces.size() - 1:
		self.mesh.surface_set_material(
				i,
				load(
						"res://fatesong/resources/world/materials/terrain_"
						+ i as String
						+ ".tres"
				)
		)
	
	create_trimesh_collision()


func _generate_heightmap() -> void:
	for i in range(-(_map_size.x / 2), (_map_size.x / 2) - 1):
		for j in range(-(_map_size.y / 2), (_map_size.y / 2) - 1):
			_add_point(i, j)


func _add_point(x: float, y: float) -> void:
	var surface := SurfaceTool.new()
	# Array of six vertices representing two triangles that make up the square
	# originating at (x, y). They are assigned to a surface based on centroid
	# height
	var triangles = []
	
	for i in [
			[x, y + 1],
			[x, y],
			[x + 1, y + 1],
			[x, y],
			[x + 1, y],
			[x + 1, y + 1],
	]:
		triangles.push_back(Vector3(i[0], _noise.get_noise_2d(i[0], i[1]) * _height_modifier, i[1]))
	
	for i in range(0, 6, 3):
		var centroid_height = triangles[i].y + triangles[i + 1].y + triangles[i + 2].y / 3
		
		if centroid_height <= 0.0:
			surface = _surfaces["grass"]
		elif centroid_height <= 2.0:
			surface = _surfaces["dirt"]
		elif centroid_height <= 8.0:
			surface = _surfaces["rock"]
		else:
			surface = _surfaces["snow"]
		
		for j in 3:
				surface.add_uv(Vector2(0.0, 0.0))
				surface.add_vertex(Vector3(triangles[i + j]))
