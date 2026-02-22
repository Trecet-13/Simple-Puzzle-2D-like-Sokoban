class_name Box extends Node2D

func update_position(cell: Vector2i) -> void:
	position = GlobalUtils.grid_to_world(cell)
