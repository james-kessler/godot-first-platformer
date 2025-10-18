extends State

func enter():
	owner_ref.animation_state_machine.travel("attack1")
	# Wait for animation to finish before going idle
	var anim_player = owner_ref.anim_tree.get("parameters/playback")
	await owner_ref.anim_tree.animation_finished
	
	if owner_ref.velocity.y > 0:
		state_machine.change_state("FallState")
	elif owner_ref.velocity.y < 0:
		state_machine.change_state("JumpState")
	else:
		state_machine.change_state("IdleState")
