class_name LevelManager extends Node

## REFERENCIAS
@export var level_container : Node2D
@export var game_data : GameData

## PROPIEDADES
const SCENE_LEVEL : PackedScene = preload("res://scenes/level/level.tscn")

## METODOS
func load_level_from_txt(path: String) -> Dictionary: # Obtener los datos del nivel desde el CSV y los devuelve en diccionario
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("No se pudo abrir el archivo")
		return {}

	var walls: Array[Vector2i] = []
	var boxes: Array[Vector2i] = []
	var targets: Array[Vector2i] = []
	var player: Vector2i
	
	var grid_x : int = 0
	var y := 0

	while file.get_position() < file.get_length():
		var line: String = file.get_line()

		if line.strip_edges() == "":
			continue

		grid_x = line.length()
		
		for x in line.length():
			var value := line[x]
			var pos : Vector2i = Vector2i(x, y)

			match value:
				"w":
					walls.append(pos)
				"b":
					boxes.append(pos)
				"t":
					targets.append(pos)
				"p":
					player = pos

		y += 1

	file.close()
	return { "walls": walls, "boxes": boxes, "targets": targets, "player": player, "grid": Vector2i(grid_x, y)}

func load_level() -> void: # Función para instanciar la escena del nivel actual
	var path : String = _get_path()
	var elements : Dictionary = load_level_from_txt(path)
	var level : Level = SCENE_LEVEL.instantiate()
	level.grid_manager.get_elements(elements["walls"], elements["boxes"], elements["targets"], elements["player"], elements["grid"])
	level.grid_manager.level_completed.connect(level_completed)
	level_container.add_child(level)

func change_level() -> void: # Función para cambiar de nivel
	var level: Level
	if level_container.get_children():
		level = level_container.get_child(0)
	level.queue_free()
	load_level()

func _get_path() -> String: # Obtiene la ruta del nivel a cargar
	var id: int = Global.level_id
	return "res://levels/level_%d.txt" % id

func _update_level_id() -> void: # Actualiza Global.level_id para el siguiente nivel
	Global.level_id += 1

func level_completed() -> void:
	print("level completed")
	_update_level_id()
	game_data.save_data()
	change_level()

## TESTING WARNING
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_J:
			_update_level_id()
			change_level()
