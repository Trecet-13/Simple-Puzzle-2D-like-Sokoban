class_name CamaraLevel extends Camera2D

## REFERENCIAS
@export var grid_manager: GridManager

## PROPIEDADES
var grid_world_size : Vector2
var viewport_size : Vector2
var target_zoom : Vector2
var target_position : Vector2

## METODOS
func _get_parameters() -> void:
	grid_world_size = GlobalUtils.grid_to_world(Vector2i(grid_manager.width, grid_manager.height))
	viewport_size = get_viewport_rect().size

	target_position = grid_world_size * 0.5
	
	var zoom_scale: Vector2 = Vector2(viewport_size.x / grid_world_size.x, viewport_size.y / grid_world_size.y)
	var uniform_scale = min(zoom_scale.x, zoom_scale.y)
	target_zoom = Vector2.ONE * uniform_scale

func _resize_camera() -> void:
	position = target_position
	zoom = target_zoom

func setup_camera() -> void:
	_get_parameters()
	_resize_camera()
