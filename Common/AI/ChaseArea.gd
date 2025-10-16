@tool
class_name ChaseArea
extends Area2D

var chased_entity: CollisionObject2D:
	set(value):
		chased_entity = value

@export var health_tracker: HealthTracker = null:
	set(value):
		health_tracker = value
		update_configuration_warnings()

func _init() -> void:
	collision_layer = 0
	collision_mask = 2
	
func _get_configuration_warnings() -> PackedStringArray:
	if health_tracker == null:
		return ["This node must have a health_tracker configured."]
	return []

func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	connect("area_exited", self._on_area_exited)
	health_tracker.connect("die", self._on_health_tracker_died)

func _on_area_entered(hurtbox: Hurtbox) -> void:
	if hurtbox == null or hurtbox.owner.is_in_group("enemies"):
		return
	print_debug("started chasing")
	chased_entity = hurtbox.owner
	
func _on_area_exited(hurtbox: Hurtbox) -> void:
	if hurtbox == null or hurtbox.owner == null or hurtbox.owner.is_in_group("enemies"):
		return
	print_debug("stopped chasing")
	chased_entity = null
	
func is_chasing() -> bool:
	return chased_entity != null

func _on_health_tracker_died() -> void:
	self.queue_free()
