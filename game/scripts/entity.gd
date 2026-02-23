class_name Entity extends Node2D

## SEÑALES
signal entity_moved

## PROPIEDADES
var time_tween_move : float = 0.3
var is_moving : bool = false

## MÉTODOS
func move_entity(cell_position: Vector2i) -> void:
	is_moving = true
	var new_position: Vector2 = GlobalUtils.grid_to_world(cell_position)
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", new_position, time_tween_move).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(moved)

func moved() -> void:
	is_moving = false
	entity_moved.emit()
