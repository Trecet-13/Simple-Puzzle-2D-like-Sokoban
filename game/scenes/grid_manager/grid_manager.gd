class_name GridManager extends Node

## REFERENCIAS

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
func is_inside_grid(cell: Vector2i) -> bool: # comprueba que la posición dada este dentro de los límites
	return cell.x >= 0 and cell.x < width and cell.y >= 0 and cell.x < height

func is_walkable(cell: Vector2) -> bool: # comprueba si se puede caminar a la celda dada
	if wall_cells.has(cell): # Comprueba que no haya una pared en esa celda
		return false

	return true
