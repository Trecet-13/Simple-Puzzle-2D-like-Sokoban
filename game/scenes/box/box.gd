class_name Box extends Node2D

## MÉTODOS
func update_position(cell: Vector2i) -> void:
	var new_position : Vector2 = GlobalUtils.grid_to_world(cell)
	var tween : Tween = create_tween()
	tween.tween_property(self, "position", new_position, Global.time_tween).set_trans(Tween.TRANS_SINE)
