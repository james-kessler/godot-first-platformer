extends MovementState

func enter():
	if owner_ref.is_on_floor():
		owner_ref.velocity.y = owner_ref.jump_speed
	owner_ref.animation_state_machine.travel("jump")

func physics_update(delta):
	super.physics_update(delta)
	owner_ref.velocity.y += owner_ref.gravity * delta

	if owner_ref.velocity.y > 0:
		state_machine.change_state("FallState")
