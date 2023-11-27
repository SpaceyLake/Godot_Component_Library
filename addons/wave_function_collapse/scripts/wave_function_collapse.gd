extends Node
class_name WaveFunctionCollapse

@export var generate_on_ready = false

@export var grid_size:Vector3i = Vector3i(32,32,1)
var grid_map:Array = []

@export var tilemap:TileMap
@export var atlas_id:int
@export var number_of_tiles:Vector2i = Vector2i(1,1)
var search:Array = []

@export var rules:Dictionary = {}
@export var weights:Dictionary = {}

var directions = [
	Vector3i( 1,0,0),
	Vector3i(-1,0,0),
	Vector3i(0, 1,0),
	Vector3i(0,-1,0),
	Vector3i(0,0, 1),
	Vector3i(0,0,-1),
]

@export var seed:String
var rng:RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	if seed:
		rng.seed = seed.hash()
	else:
		rng.seed = Time.get_ticks_usec()

	create_grid_map()
	if generate_on_ready:
		generate()

# Add new rule for tile
# tile: The tile the rules applies to
# dirs: The directions from whitch the rules applies to
# can_neighbor: The tiles that can be neighbors to the tile in this direction
func add_rules(tile:Vector2i, dirs:Array, can_neighbor:Array):
	if typeof(rules.get(tile, -1)) == typeof(-1):
		rules[tile] = {}
	for dir in dirs:
		if typeof(rules[tile].get(dir, -1)) != typeof(-1):
			for item in can_neighbor:
				if item not in rules[tile][dir]:
					rules[tile][dir].append(item)
					add_rules(item, [Vector3i(dir.x*-1,dir.y*-1,dir.z*-1)], [tile])
		else:
			rules[tile][dir] = can_neighbor
			for item in can_neighbor:
				add_rules(item, [Vector3i(dir.x*-1,dir.y*-1,dir.z*-1)], [tile])

func remove_rules(tile:Vector2i, dirs:Array, cant_neighbor:Array):
	if typeof(rules.get(tile, -1)) == typeof(-1):
		rules[tile] = {}
	for dir in dirs:
		if typeof(rules[tile].get(dir, -1)) != typeof(-1):
			for item in cant_neighbor:
				if item in rules[tile][dir]:
					rules[tile][dir].remove_at(rules[tile][dir].find(item))
					remove_rules(item,[Vector3i(dir.x*-1,dir.y*-1,dir.z*-1)],[tile])
		else:
			rules[tile][dir] = []

func create_grid_map():
	var x_offset = floori(grid_size.x / 2.0)
	var y_offset = floori(grid_size.y / 2.0)
	var z_offset = 0
	for x in grid_size.x:
		grid_map.append([])
		for y in grid_size.y:
			grid_map[x].append([])
			for z in grid_size.z:
				var possible = []
				for i in number_of_tiles.x:
					for j in number_of_tiles.y:
						possible.append(Vector2i(i,j))
				var tile = WaveFunctionCollapseTile.new(
					Vector3i(x-x_offset,y-y_offset,z-z_offset), 
					possible)
				grid_map[x][y].append(tile)
				search.append(Vector3i(x,y,z))

func set_tile(tile:Vector2i, pos:Vector3i):
	grid_map[pos.x][pos.y][pos.z].tile = tile
	grid_map[pos.x][pos.y][pos.z].done = true
	update_neighbors(tile, pos)

func step():
	var next:Vector3i = find_next()
	var possible = grid_map[next.x][next.y][next.z].possible
	
	if possible.size() > 0:
		set_tile(possible[rng.randi() % possible.size()], next)
	else:
		print("ERROR: tile is missing solution at:",next)
		var check = look_around(next)
		for i in check[0].size():
			print("DIR:",check[1][i],", tile:",grid_map[check[0][i].x][check[0][i].y][check[0][i].z].tile)
	
	update_tilemap()

func generate():
	var x_start = rng.randi() % grid_size.x
	var y_start = rng.randi() % grid_size.y
	var z_start = 0
	
	print(x_start)
	print(y_start)
	
	set_tile(Vector2i(rng.randi() % number_of_tiles.x, rng.randi() % number_of_tiles.y), Vector3i(x_start, y_start, z_start))
	
	while search.size() > 0:
		step()
	
	update_tilemap()

func update_tilemap():
	for entry1 in grid_map:
		for entry2 in entry1:
			for tile in entry2:
				tilemap.set_cell(tile.pos.z, Vector2i(tile.pos.x,tile.pos.y), atlas_id, tile.tile)

func find_next() -> Vector3i:
	var min: = 0
	var pos:Vector3i
	var j = 0
	if search.size() > 0:
		min = grid_map[search[0].x][search[0].y][search[0].z].possible.size()
		pos = Vector3i(search[0].x, search[0].y, search[0].z)
		j = 0
		for i in range(1, search.size()):
			if grid_map[search[i].x][search[i].y][search[i].z].possible.size() < min:
				min = grid_map[search[i].x][search[i].y][search[i].z].possible.size()
				pos = Vector3i(search[i].x, search[i].y, search[i].z)
				j = i
			elif grid_map[search[i].x][search[i].y][search[i].z].possible.size() == min:
				if rng.randi() % 2:
					min = grid_map[search[i].x][search[i].y][search[i].z].possible.size()
					pos = Vector3i(search[i].x, search[i].y, search[i].z)
					j = i
	else:
		print("HERE")
	search.remove_at(j)
	return pos

func look_around(pos:Vector3i) -> Array:
	var ret = [[],[]]
	for dir in directions:
		if not (dir.x+pos.x < 0 or dir.x+pos.x > grid_size.x-1):
			if not (dir.y+pos.y < 0 or dir.y+pos.y > grid_size.y-1):
				if not (dir.z+pos.z < 0 or dir.z+pos.z > grid_size.z-1):
					ret[0].append(Vector3i(dir.x+pos.x,dir.y+pos.y,dir.z+pos.z))
					ret[1].append(Vector3i(dir.x,dir.y,dir.z))
	return ret

func update_neighbors(tile:Vector2i, pos:Vector3i):
	var check = look_around(pos)
	
	for i in check[0].size():
		if not grid_map[check[0][i].x][check[0][i].y][check[0][i].z].done:
			if typeof(rules[tile].get(check[1][i], -1)) != typeof(-1):
				var temp_array = []
				var temp = grid_map[check[0][i].x][check[0][i].y][check[0][i].z].possible
				for rule in rules[tile][check[1][i]]:
					if rule in temp:
						temp_array.append(rule)
				grid_map[check[0][i].x][check[0][i].y][check[0][i].z].possible = temp_array
			else:
				print("ERROR: missing rule:",tile," for ",check[1][i])
