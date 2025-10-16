class_name Hitbox
extends Area2D

@export var damage:= 10

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func apply_damage() -> void:
	var overlapping_areas = get_overlapping_areas()
	for area in overlapping_areas:
		if area is Hurtbox:
			if is_hostile(area):
				area.apply_damage(damage)

func has_hostile_hurtboxes_in_area() -> bool:
	var overlapping_areas = get_overlapping_areas()
	for area in overlapping_areas:
		if area is Hurtbox:
			if is_hostile(area):
				return true
	return false

func is_hostile(hurtbox: Hurtbox):
	var hitbox_groups = self.owner.get_groups()
	var hurtbox_groups = hurtbox.owner.get_groups()
	return ArrayUtils.intersect_arrays(hitbox_groups, hurtbox_groups).is_empty()

func disable():
	collision_mask = 0
