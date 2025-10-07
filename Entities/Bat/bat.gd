extends CharacterBody2D

const SPEED = 100.0
var chased_player = null

var spawn_point: Vector2
@onready var state_machine: AnimationNodeStateMachinePlayback  = $AnimationTree["parameters/playback"]
var attack_cooldown: bool = false

func _ready() -> void:
	spawn_point = global_position

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO
	var current_anim = state_machine.get_current_node()
	if (current_anim == "death"):
		return
	
	if chased_player:
		if current_anim != "attack" and !attack_cooldown:
			velocity = position.direction_to(chased_player.position) * SPEED
	else:
		velocity = position.direction_to(spawn_point) * SPEED

	move_and_slide()

func _on_chase_radius_body_entered(body: Node2D) -> void:
	if body == %Player:
		print_debug("chasing player")
		chased_player = body

func _on_chase_radius_body_exited(body: Node2D) -> void:
	if body == %Player:
		print_debug("player ran away")
		chased_player = null

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name != "attack":
		return
	print_debug("attack cooldown")
	$HitBox.apply_damage()
	attack_cooldown = true
	$AttackTimer.start()

func _on_attack_timer_timeout() -> void:
	attack_cooldown = false
	if $HitBox.target != null:
		state_machine.travel("attack")

func _on_hit_box_attack_started() -> void:
	print_debug("started attacking player")
	state_machine.travel("attack")

func _on_hit_box_attack_stopped() -> void:
	print_debug("stopped attacking player")
	state_machine.travel("idle")

func _on_health_tracker_die() -> void:
	print_debug("bat died")
	state_machine.travel("death")
	set_physics_process(false)

func _on_health_tracker_hitpoints_changed(before: int, after: int) -> void:
	print_debug("bat took damage: ", before - after)
