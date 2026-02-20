class_name TileBorder extends TileMapLayer

## METODOS
func generate_border(visible_rect: Dictionary, level_rect: Dictionary):
	clear()
	
	var cells_to_fill: Array[Vector2i] = []

	for x in range(visible_rect.min_x, visible_rect.max_x + 1):
		for y in range(visible_rect.min_y, visible_rect.max_y + 1):

			var outside_level = \
				x < level_rect.min_x or \
				x > level_rect.max_x or \
				y < level_rect.min_y or \
				y > level_rect.max_y

			if outside_level:
				cells_to_fill.append(Vector2i(x, y))

	if cells_to_fill.size() > 0:
		set_cells_terrain_connect(cells_to_fill, 0, 0)
