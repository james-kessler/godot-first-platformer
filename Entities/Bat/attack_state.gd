extends FlyingState

@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $"../../AnimationTree"["parameters/playback"]
@onready var animation_tree: AnimationTree = $"../../AnimationTree"
@onready var chase_area: ChaseArea = $"../../ChaseArea"

func enter():

	animation_state_machine.travel("attack")
	
	# Wait for animation to finish before going idle
	await animation_tree.animation_finished
	
	state_machine.change_state("CooldownState")
	
	owner_ref.velocity.x = 0
