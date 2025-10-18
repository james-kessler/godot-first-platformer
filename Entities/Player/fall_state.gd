extends MovementState

@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $"../../AnimationTree"["parameters/playback"]

func enter():
	animation_state_machine.travel("fall")

func physics_update(delta):
	super.physics_update(delta)

	owner_ref.velocity.y *= owner_ref.fall_gravity_factor
	
	if owner_ref.is_on_floor():
		state_machine.change_state("IdleState")
