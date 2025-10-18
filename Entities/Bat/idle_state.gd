extends FlyingState

@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $"../../AnimationTree"["parameters/playback"]
@onready var chase_area: ChaseArea = $"../../ChaseArea"
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"

func enter():
	animation_state_machine.travel("idle")

func physics_update(delta):
	super.physics_update(delta)

	if chase_area.is_chasing():
		state_machine.change_state("ChaseState")
		return

	var direction = owner_ref.position.direction_to(owner_ref.spawn_point)
	owner_ref.velocity.x = direction.x * owner_ref.speed
	if direction.x != 0:
		sprite_2d.flip_h = owner.velocity.x < 0
	else:
		# returned to spawn
		sprite_2d.flip_h = true
