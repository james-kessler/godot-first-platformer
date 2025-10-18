extends FlyingState

@onready var chase_area: ChaseArea = $"../../ChaseArea"
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"

func enter():
	owner_ref.animation_state_machine.travel("idle")

func physics_update(delta):
	super.physics_update(delta)

	if chase_area.is_chasing():
		var direction = owner_ref.position.direction_to(chase_area.chased_entity.position)
		owner_ref.velocity = direction * owner_ref.speed
		if direction.x != 0:
			sprite_2d.flip_h = owner.velocity.x < 0
	else:
		state_machine.change_state("IdleState")
