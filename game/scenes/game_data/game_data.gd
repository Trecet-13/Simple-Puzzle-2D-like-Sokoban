class_name GameData extends Node

## Referencias
@export var game_data: SaveData
## Propiedades
const _PATH : String = "user://partida.tres"

## METODOS
func save_data():
	game_data.level = Global.level_id

	ResourceSaver.save(game_data, _PATH)

func load_data():
	if ResourceLoader.exists(_PATH):
		game_data = load(_PATH)

		Global.level_id = game_data.level
