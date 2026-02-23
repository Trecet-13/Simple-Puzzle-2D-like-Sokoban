class_name Player extends Entity

## SEÑALES
signal request_move


## ACCIONES
func _process(_delta: float) -> void:
	movement()

## METODOS
func movement() -> void:
	if is_moving:
		return

	var dir := Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.2)

	var grid_dir := Vector2i.ZERO

	if abs(dir.x) > abs(dir.y):
		grid_dir = Vector2i(sign(dir.x), 0)
	elif abs(dir.y) > abs(dir.x):
		grid_dir = Vector2i(0, sign(dir.y))

	if grid_dir != Vector2i.ZERO:
		request_move.emit(grid_dir)
