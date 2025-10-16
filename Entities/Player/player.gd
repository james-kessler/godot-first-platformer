extends CharacterBody2D

const JUMP_VELOCITY = -500.0

var SPEED = 200.0
var attacks = ["attack1", "attack2"]

@onready var state_machine: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]

func _physics_process(delta: float) -> void:
	var current_anim = state_machine.get_current_node()
	if current_anim in ["hurt", "die"]:
		return
		
	var movement = Input.get_axis("left", "right")

	if not is_on_floor():
		# Add the gravity.
		velocity += get_gravity() * delta

	# choose animation
	if Input.is_action_just_pressed("attack"):
		state_machine.travel(attacks.pick_random())
	elif is_on_floor() and Input.is_action_just_pressed("jump"):
		state_machine.travel("jump")
		velocity.y = JUMP_VELOCITY
	elif movement != 0:
		if is_on_floor():
			state_machine.travel("run")
		velocity.x = movement * SPEED

		$Sprite2D.flip_h = velocity.x < 0
		$Hitbox.scale.x = -1 if velocity.x < 0 else 1
	else:
		velocity.x = 0
		if current_anim == "run":
			state_machine.travel("idle")

	move_and_slide()


func _on_health_tracker_die() -> void:
	state_machine.travel("die")
	set_physics_process(false)
	
	print("Player Died!")


func _on_health_tracker_hitpoints_changed(_before: int, after: int) -> void:
	state_machine.travel("hurt")
	
	print("Player Hitpoints: ", after)


func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	print("Animation Started: ", anim_name)
