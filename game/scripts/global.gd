extends Node

## PROPIEDADES
const TILE_SIZE : int = 64

## MÉTODOS
static func grid_to_world(grid_pos: Vector2i) -> Vector2i:
	return Vector2i(grid_pos) * TILE_SIZE

static func world_to_grid(world_pos: Vector2i) -> Vector2i:
	@warning_ignore("integer_division")
	return Vector2i(world_pos) / TILE_SIZE
