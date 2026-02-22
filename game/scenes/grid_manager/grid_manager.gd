class_name GridManager extends Node

## SEÑALES
signal player_cell_changed
signal level_completed

## PROPIEDADES
var wall_cells : Array[Vector2i] = []
var box_cells : Array[Vector2i] = []
var boxes_nodes : Dictionary[Vector2i, Box] = {}
var target_cells : Array[Vector2i] = []
var player_cell : Vector2i # Player cell
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
	return cell.x >= 0 and cell.x < width and cell.y >= 0 and cell.y < height

func is_walkable(cell: Vector2) -> bool: # comprueba si se puede caminar a la celda dada
	if wall_cells.has(cell): # Comprueba que no haya una pared en esa celda
		return false

	return true

func try_move_player(cell : Vector2i) -> void:
	var try_position : Vector2i = player_cell + cell
	if is_inside_grid(try_position) and is_walkable(try_position):
		if box_cells.has(try_position):
			var index = box_cells.find(try_position)
			var box_try_position = box_cells[index] + cell
			if is_inside_grid(box_try_position) and is_walkable(box_try_position):
				_move_box(index, box_try_position)
				_move_player(try_position)
				_is_level_completed()
		else:
			_move_player(try_position)
			_is_level_completed()

func _move_player(position: Vector2i) -> void:
	player_cell = position
	player_cell_changed.emit(player_cell)

func _move_box(index: int, position: Vector2i) -> void:
	var pre_position: Vector2i = box_cells[index]
	box_cells[index] = position
	if boxes_nodes.has(pre_position):
		var value = boxes_nodes[pre_position]
		boxes_nodes.erase(pre_position)
		boxes_nodes[box_cells[index]] = value
		boxes_nodes[box_cells[index]].update_position(box_cells[index])

func _is_level_completed() -> void:
	for target in target_cells:
		if not box_cells.has(target):
			return
	level_completed.emit()
