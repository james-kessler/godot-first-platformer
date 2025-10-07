class_name Hitbox
extends Area2D

@export var damage:= 10

var target: Hurtbox = null

signal attack_started
signal attack_stopped

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	if self.owner.is_in_group("enemies"):
		connect("area_entered", self._on_area_entered)
		connect("area_exited", self._on_area_exited)

func _on_area_entered(hurtbox: Hurtbox) -> void:
	print_debug("Hurtbox Owner:", hurtbox.owner.get_groups())
	if hurtbox == null or hurtbox.owner.is_in_group("enemies"):
		return

	self.trigger_attack(hurtbox)
	
func _on_area_exited(hurtbox: Hurtbox) -> void:
	if hurtbox == null or hurtbox.owner.is_in_group("enemies"):
		return

	self.cancel_attack()
	
func trigger_attack(hurtbox: Hurtbox) -> void:
	if !hurtbox.accepts_damage():
		return
	target = hurtbox
	attack_started.emit()

func cancel_attack() -> void:
	target = null
	attack_stopped.emit()

func apply_damage() -> void:
	if target == null:
		return
	
	target.apply_damage(damage)
