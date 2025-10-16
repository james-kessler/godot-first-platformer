@tool
class_name Hurtbox
extends Area2D

@export var health_tracker: HealthTracker = null:
	set(value):
		health_tracker = value
		update_configuration_warnings()

func _init() -> void:
	collision_layer = 2
	collision_mask = 0

func disable():
	collision_layer = 0

func _get_configuration_warnings() -> PackedStringArray:
	if health_tracker == null:
		return ["This node must have a health_tracker configured."]
	return []

func apply_damage(damage: int) -> void:
	health_tracker.apply_damage(damage)

func accepts_damage() -> bool:
	return health_tracker.accepts_damage()
