extends TileMap

func _ready():
	var offset = Vector2(8, 10)
	for tile in get_used_cells():
		var cell = get_cellv(tile) # Vector2
		var name = get_tileset().tile_get_name(cell)
		var path = str("res://Scenes/", name, ".tscn")
		if File.new().file_exists(path):
			var node = load(path).instance()
			var texture_offset = get_tileset().tile_get_texture_offset(cell)
			node.global_position = map_to_world(tile) + offset + texture_offset
			get_parent().call_deferred("add_child", node)
			set_cellv(tile, -1)
