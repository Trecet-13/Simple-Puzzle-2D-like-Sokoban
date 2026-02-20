class_name GameData extends Node

## Referencias
@export var data: SaveData
## Propiedades
const _PATH : String = "user://partida.tres"

## METODOS
func save_datadata():
	data.level = Global.level_id

	ResourceSaver.save(data, _PATH)

func load_data():
	if ResourceLoader.exists(_PATH):
		data = load(_PATH)

		Global.level_id = data.level
	else:
		Global.level_id = 0
