class_name Main extends Node2D

# REFERENCIAS
@export var game_data : GameData
@export var level_manager : LevelManager

## ACCIONES
func _ready() -> void:
	get_level_id()
	level_manager.load_level()

## METODOS
func get_level_id() -> void: # Carga los datos de partida (level_id)
	game_data.load_data()
