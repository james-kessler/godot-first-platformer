class_name HealthTracker
extends Node

signal die
signal hitpoints_changed(before: int, after: int)

var max_hitpoints:
	set(value):
		max_hitpoints = value
		# Additional logic when health is set
		hitpoints = max_hitpoints

var hitpoints = null

func _ready() -> void:
	hitpoints = max_hitpoints

func apply_damage(damage: int) -> void:
	if hitpoints <= 0:
		return

	var original_hitpoints = hitpoints
	hitpoints = clamp(original_hitpoints - damage, 0, original_hitpoints - damage)

	print("Damage: ", damage, owner.name)

	hitpoints_changed.emit(original_hitpoints, hitpoints)
	
	if hitpoints <= 0:
		die.emit()
		print("Died")

func accepts_damage() -> bool:
	return hitpoints > 0
