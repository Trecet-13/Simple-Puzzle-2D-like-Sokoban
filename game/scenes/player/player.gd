class_name Player extends Node2D

## SEÑALES
signal request_move

## PROPIEDADES
var is_moving : bool = false

## ACCIONES
func _input(event: InputEvent) -> void:
	movement(event)

## METODOS
func movement(event : InputEvent) -> void:
	if not is_moving:
		if event.is_action("move_up") and event.pressed:
			request_move.emit(Vector2i.UP)
		elif event.is_action("move_right") and event.pressed:
			request_move.emit(Vector2i.RIGHT)
		elif event.is_action("move_down") and event.pressed:
			request_move.emit(Vector2i.DOWN)
		elif event.is_action("move_left") and event.pressed:
			request_move.emit(Vector2i.LEFT)

func update_position(cell: Vector2i) -> void:
	is_moving = true
	var new_position: Vector2 = GlobalUtils.grid_to_world(cell)
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", new_position, Global.time_tween)
	tween.tween_callback(moved)

func moved() -> void:
	is_moving = false
