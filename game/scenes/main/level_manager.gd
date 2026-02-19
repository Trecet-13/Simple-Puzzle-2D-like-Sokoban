class_name LevelManager extends Node

func load_level_from_txt(path: String) -> Array:
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("No se pudo abrir el archivo")
		return []

	var grid := []

	while not file.eof_reached():
		var line: String = file.get_line()
		if line.strip_edges() == "":
			continue

		var row: PackedStringArray = line.split("\t")
		grid.append(row)

	return grid
