extends MovementState

@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $"../../AnimationTree"["parameters/playback"]

func enter():
	if owner_ref.is_on_floor():
		owner_ref.velocity.y = owner_ref.jump_speed
	animation_state_machine.travel("jump")

func physics_update(delta):
	super.physics_update(delta)
	owner_ref.velocity.y += owner_ref.gravity * delta

	if owner_ref.velocity.y > 0:
		state_machine.change_state("FallState")
