extends FlyingState

@onready var chase_area: ChaseArea = $"../../ChaseArea"
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"
@onready var hit_box: Hitbox = $"../../HitBox"
@onready var attack_sprite: Sprite2D = $"../../AttackSprite"

func enter():
	owner_ref.animation_state_machine.travel("idle")

func physics_update(delta):
	super.physics_update(delta)

	if chase_area.is_chasing():
		var direction = owner_ref.position.direction_to(chase_area.chased_entity.position)
		
		owner_ref.velocity.x = move_toward(owner_ref.velocity.x, owner_ref.speed * direction.x, owner_ref.acceleration)
	else:
		state_machine.change_state("IdleState")
	
	print(owner_ref.velocity.x)
	if owner_ref.velocity.x < 0:
		owner_ref.rotation_degrees = 180
		owner_ref.scale.y = -1
	if owner_ref.velocity.x > 0 :
		owner_ref.rotation_degrees = 0
		owner_ref.scale.y = 1
