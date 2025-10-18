extends TerminalState

@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $"../../AnimationTree"["parameters/playback"]
@onready var chase_area: ChaseArea = $"../../ChaseArea"
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"

func enter():
	print_debug("bat died")
	animation_state_machine.travel("death")
	state_machine.stop()
	owner_ref.collision_layer = 0
	owner_ref.collision_mask = 1
	owner_ref.gravity = owner_ref.speed * 4
