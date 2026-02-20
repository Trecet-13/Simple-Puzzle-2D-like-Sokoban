class_name Level extends Node2D

## REFERENCIAS
@export var tile_set : TileMapLayer
@export var entities_container : Node2D
@export var grid_manager : GridManager
@export var camera: CamaraLevel
@export var tile_border : TileMapLayer

## PROPIEDADES
const SCENE_PLAYER : PackedScene = preload("res://scenes/player/player.tscn")
const SCENE_BOX : PackedScene = preload("res://scenes/box/box.tscn")
const SCENE_TARGET : PackedScene = preload("res://scenes/target/target.tscn")

## ACCIONES
func _ready() -> void:
	instantiate_level(grid_manager.wall_cells, grid_manager.box_cells, grid_manager.target_cells, grid_manager.player_cell)
	camera.setup_camera()
	generate_border()

## METODOS
func instantiate_level(walls: Array[Vector2i], boxes: Array[Vector2i], targets: Array[Vector2i], initial_player_cell : Vector2i) -> void: # instancia todos los elementos del nivel
	_init_walls(walls)
	_init_targets(targets)
	_init_boxes(boxes)
	_init_player(initial_player_cell)

func _init_walls(walls: Array[Vector2i]) -> void:
	tile_set.set_cells_terrain_connect(walls, 0, 0)

func _init_player(initial_player_position : Vector2i) -> void:
	var player : Player = SCENE_PLAYER.instantiate()
	entities_container.add_child(player)
	player.position = GlobalUtils.grid_to_world(initial_player_position)

	player.request_move.connect(grid_manager.try_move_player)
	grid_manager.player_cell_changed.connect(player.update_position)

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

func generate_border() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	
	var zoom = camera.zoom.x
	var world_width = viewport_size.x / zoom
	var world_height = viewport_size.y / zoom
	
	var visible_tiles_x = ceil(world_width / Global.TILE_SIZE)
	var visible_tiles_y = ceil(world_height / Global.TILE_SIZE)
	
	var half_visible_x = int(visible_tiles_x / 2)
	var half_visible_y = int(visible_tiles_y / 2)
	
	var visible_rect = {
		"min_x": -half_visible_x,
		"max_x": half_visible_x - 1,
		"min_y": -half_visible_y,
		"max_y": half_visible_y - 1
	}

	@warning_ignore("integer_division")
	var half_level_x = int(grid_manager.width / 2)
	@warning_ignore("integer_division")
	var half_level_y = int(grid_manager.height / 2)

	var level_rect = {
		"min_x": 0,
		"max_x": half_level_x * 2 - 1,
		"min_y": 0,
		"max_y": half_level_y * 2 - 1
	}
	tile_border.generate_border(visible_rect, level_rect)
