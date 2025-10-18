@abstract
class_name FlyingState
extends State

# Universal input handling
func handle_input():
	super.handle_input()
	if Input.is_action_just_pressed("attack"):
		state_machine.change_state("AttackState")
		return

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
