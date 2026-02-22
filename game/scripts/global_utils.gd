class_name GlobalUtils extends Node

## PROPIEDADES
const time_tween : float = 0.5
const TILE_SIZE : int = 64
var level_id : int

## MÉTODOS
static func grid_to_world(grid_pos: Vector2i) -> Vector2:
	return Vector2(grid_pos) * TILE_SIZE

static func world_to_grid(world_pos: Vector2) -> Vector2i:
	@warning_ignore("integer_division")
	return Vector2i(world_pos) / TILE_SIZE

static func get_matrix_difference(large_matrix: Vector2i, small_matrix: Vector2i) -> Array[Vector2i]:
	var result: Array[Vector2i] = []

	for x in range(-large_matrix.x, small_matrix.x + large_matrix.x):
		for y in range(-large_matrix.y, small_matrix.y + large_matrix.y):
			if x < 0 or x > (small_matrix.x - 1)  or y < 0 or y > (small_matrix.y - 1):
				result.append(Vector2i(x,y))

	return result
