class_name GridManager extends Node

## SEÑALES
signal player_cell_changed

## PROPIEDADES
var wall_cells : Array[Vector2i] = []
var box_cells : Array[Vector2i] = []
var boxes_nodes : Dictionary[Vector2i, Node2D] = {}
var target_cells : Array[Vector2i] = []
var player_cell : Vector2i
var height : int # y
var width : int # x

## ACCIONES

## MÉTODOS
func get_elements(walls: Array[Vector2i], boxes: Array[Vector2i], targets: Array[Vector2i], player_position : Vector2i, grid: Vector2i) -> void:
	wall_cells = walls
	box_cells = boxes
	target_cells = targets
	player_cell = player_position
	height = grid.y
	width = grid.x

func is_inside_grid(cell: Vector2i) -> bool: # comprueba que la posición dada este dentro de los límites
	return cell.x >= 0 and cell.x < width and cell.y >= 0 and cell.x < height

func is_walkable(cell: Vector2) -> bool: # comprueba si se puede caminar a la celda dada
	if wall_cells.has(cell): # Comprueba que no haya una pared en esa celda
		return false

	return true

func try_move_player(cell : Vector2i) -> void:
	var try_position : Vector2i = player_cell + cell
	if is_inside_grid(try_position) and is_walkable(try_position):
		player_cell = try_position
		player_cell_changed.emit(player_cell)
