extends Node

var path := "res://game.cfg"
var config_file := ConfigFile.new()

func _init() -> void:
	
	var error := config_file.load(path)

	if error:
		print("An error happened while loading config data: ", error)
		return

func get_value(section: String, key: String, default: Variant = null) -> Variant:
	return config_file.get_value(section, key, default)
