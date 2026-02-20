class_name Level extends Node2D

## REFERENCIAS
@export var tile_set : TileMapLayer
@export var entities_container : Node2D
@export var grid_manager : GridManager
@export var camera: CamaraLevel

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
	var viewport_size : Vector2 = get_viewport_rect().size
# Obtener el numero de celdas visibles
	var x : int = ceil( viewport_size.x / ( Global.TILE_SIZE * camera.zoom.x) )
	if x % 2 != 0:
		x += 1
	var y : int = ceil( viewport_size.y / ( Global.TILE_SIZE * camera.zoom.x) )
	if y % 2 != 0:
		y += 1
	var visible_grid_size : Vector2i = Vector2i(x, y)
	var grid_size : Vector2i = Vector2i(grid_manager.width, grid_manager.height)
	var spare_grid : Vector2i = visible_grid_size - grid_size
	var centred_spare_grid : Vector2i = spare_grid / 2
	tile_set.set_cells_terrain_connect(GlobalUtils.get_matrix_difference(centred_spare_grid, grid_size) + tile_set.get_used_cells(),0,0)
