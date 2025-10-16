extends CharacterBody2D

const SPEED = 100.0

var spawn_point: Vector2
@onready var state_machine: AnimationNodeStateMachinePlayback  = $AnimationTree["parameters/playback"]

func _ready() -> void:
	spawn_point = global_position

func _physics_process(delta: float) -> void:
	var current_anim = state_machine.get_current_node()
	
	if $HealthTracker.hitpoints <= 0:
		velocity.x = 0
		velocity.y += delta * SPEED
		move_and_slide()
		return
	
	if $ChaseArea.is_chasing():
		if current_anim != "attack" and !$AttackCooldownTimer.is_on_cooldown():
			var direction = position.direction_to($ChaseArea.chased_entity.position)
			velocity = direction * SPEED
	else:
		velocity.x = position.direction_to(spawn_point).x * SPEED
	
	velocity = self.apply_hover_gravity(velocity, delta)

	$Sprite2D.flip_h = velocity.x <= 0
	$HitBox.scale.x = -1 if velocity.x >= 0 else 1

	move_and_slide()

func apply_hover_gravity(velocity: Vector2, delta: float) -> Vector2:
	if $RayCast2D.is_colliding():
		# float off the floor
		var floor_point = $RayCast2D.get_collision_point()
		velocity.y -= delta * SPEED
	else:
		# float down to floor
		velocity.y += delta * SPEED
	return velocity

func _on_attack_timer_timeout() -> void:
	if $HitBox.has_hostile_hurtboxes_in_area():
		state_machine.travel("attack")

func _on_health_tracker_die() -> void:
	print_debug("bat died")
	$AttackCooldownTimer.stop()
	state_machine.travel("death")
	self.collision_layer = 0
	self.collision_mask = 1

func _on_health_tracker_hitpoints_changed(before: int, after: int) -> void:
	print_debug("bat took damage: ", before - after)

func _on_attack_trigger_attack_started() -> void:
	
	if $HealthTracker.hitpoints <= 0:
		return
	print_debug("started attacking player")
	state_machine.travel("attack")

func _on_attack_trigger_attack_stopped() -> void:
	if $HealthTracker.hitpoints <= 0:
		return
	print_debug("bat stopped attacking player")
	state_machine.travel("idle")
