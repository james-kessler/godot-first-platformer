@tool
class_name AttackTrigger
extends Node

@export var hit_box: Hitbox = null:
	set(value):
		hit_box = value
		update_configuration_warnings()

signal attack_started
signal attack_stopped

func _get_configuration_warnings() -> PackedStringArray:
	if hit_box == null:
		return ["This node must have a hit_box configured."]
	return []

func _ready() -> void:
	hit_box.connect("area_entered", self._on_area_entered)
	hit_box.connect("area_exited", self._on_area_exited)

func _on_area_entered(hurtbox: Hurtbox) -> void:
	if hurtbox == null:
		return

	self.trigger_attack(hurtbox)
	
func _on_area_exited(hurtbox: Hurtbox) -> void:
	if hurtbox == null:
		return

	self.cancel_attack()

func trigger_attack(hurtbox: Hurtbox) -> void:
	if !is_hurtbox_valid_attack_target(hurtbox):
		return
	attack_started.emit()

func cancel_attack() -> void:
	attack_stopped.emit()

func is_hurtbox_valid_attack_target(hurtbox: Hurtbox) -> bool:
	return hurtbox.accepts_damage() \
		and hit_box.is_hostile(hurtbox)
