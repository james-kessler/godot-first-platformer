extends FlyingState

@onready var attack_cooldown_timer: CooldownTimer = $"../../AttackCooldownTimer"
@onready var hit_box: Hitbox = $"../../HitBox"

func enter():
	attack_cooldown_timer.start()

func physics_update(delta: float) -> void:
	super.physics_update(delta)
	
	if attack_cooldown_timer.time_left > 0:
		return

	if hit_box.has_hostile_hurtboxes_in_area():
		state_machine.change_state("AttackState")
	else:
		state_machine.change_state("ChaseState")
