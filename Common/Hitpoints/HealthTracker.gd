class_name HealthTracker
extends Node

signal die
signal hitpoints_changed(before: int, after: int)

@export var max_hitpoints = 30
var hitpoints = null

func _init() -> void:
	hitpoints = max_hitpoints

func apply_damage(damage: int) -> void:
	if hitpoints <= 0:
		return

	var original_hitpoints = hitpoints
	hitpoints = clamp(hitpoints - damage, 0, hitpoints)

	print("Damage: ", damage)

	hitpoints_changed.emit(original_hitpoints, hitpoints)
	
	if hitpoints <= 0:
		die.emit()
		print("Died")

func accepts_damage() -> bool:
	return hitpoints > 0
