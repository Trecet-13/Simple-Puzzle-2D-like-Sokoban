class_name Player extends Node2D

## SEÑALES
signal request_move

## ACCIONES
func _input(event: InputEvent) -> void:
	movement(event)

## METODOS
func movement(event : InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		request_move.emit(Vector2i.UP)
	elif event.is_action_pressed("ui_right"):
		request_move.emit(Vector2i.RIGHT)
	elif event.is_action_pressed("ui_down"):
		request_move.emit(Vector2i.DOWN)
	elif event.is_action_pressed("ui_left"):
		request_move.emit(Vector2i.LEFT)

func update_position(cell: Vector2i) -> void:
	position = GlobalUtils.grid_to_world(cell)
