extends Node2D

## REFERENCIAS
@export var tile_set : TileMapLayer
@export var entities_container : Node2D
@export var grid_manager : GridManager

## PROPIEDADES
const SCENE_PLAYER : PackedScene = preload("res://scenes/player/player.tscn")
const SCENE_BOX : PackedScene = preload("res://scenes/box/box.tscn")
const  SCENE_TARGET : PackedScene = preload("res://scenes/target/target.tscn")

## METODOS
func instantiate_level(walls: Array[Vector2i], boxes: Array[Vector2i], targets: Array[Vector2i], initial_player_cell : Vector2i) -> void: # instancia todos los elementos del nivel
	_init_walls(walls)
	_init_player(initial_player_cell)
	_init_boxes(boxes)
	_init_targets(targets)

func _init_walls(walls: Array[Vector2i]) -> void:
	tile_set.set_cells_terrain_connect(walls, 0, 0)

func _init_player(initial_player_position : Vector2i) -> void:
	var player = SCENE_PLAYER.instantiate()
	entities_container.add_child(player)
	player.position = GlobalUtils.grid_to_world(initial_player_position)

func _init_boxes(boxes: Array[Vector2i]) -> void:
	for cell in boxes:
		var box : Node2D = SCENE_BOX.instantiate()
		entities_container.add_child(box)
		box.position = GlobalUtils.grid_to_world(cell)
		grid_manager.boxes_nodes[cell] = box

func _init_targets(targets: Array[Vector2i]) -> void:
	for cell in targets:
		var target : Node2D = SCENE_TARGET.instantiate()
		entities_container.add_child(target)
		target.position = GlobalUtils.grid_to_world(cell)
