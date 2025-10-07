class_name ChaseArea
extends Area2D

var chased_entity: CollisionObject2D:
	set(value):
		chased_entity = value

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	if self.owner.is_in_group("enemies"):
		connect("area_entered", self._on_area_entered)
		connect("area_exited", self._on_area_exited)

func _on_area_entered(hurtbox: Hurtbox) -> void:
	if hurtbox == null or hurtbox.owner.is_in_group("enemies"):
		return
	print_debug("started chasing")
	chased_entity = hurtbox.owner
	
func _on_area_exited(hurtbox: Hurtbox) -> void:
	if hurtbox == null or hurtbox.owner.is_in_group("enemies"):
		return
	print_debug("stopped chasing")
	chased_entity = null
	
func is_chasing() -> bool:
	return chased_entity != null
