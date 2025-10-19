extends MovementState

@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $"../../AnimationTree"["parameters/playback"]
@onready var animation_tree: AnimationTree = $"../../AnimationTree"

func enter():
	animation_state_machine.travel("attack1")
	# Wait for animation to finish before going idle
	await animation_tree.animation_finished
	
	if owner_ref.velocity.y > 0:
		state_machine.change_state("FallState")
	elif owner_ref.velocity.y < 0:
		state_machine.change_state("JumpState")
	else:
		state_machine.change_state("IdleState")
