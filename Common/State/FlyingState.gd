@abstract
class_name FlyingState
extends State

# Universal physics handling
func physics_update(delta) -> void:
	super.physics_update(delta)
	if owner_ref.down_raycast_2d.is_colliding():
		# float off the floor
		var floor_point = owner_ref.down_raycast_2d.get_collision_point()
		owner_ref.velocity.y -= delta * owner_ref.speed
	else:
		# float down to floor
		owner_ref.velocity.y += delta * owner_ref.speed
