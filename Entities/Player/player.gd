extends CharacterBody2D

@export var speed: int = 300
@export var acceleration: int = 80
@export var jump_speed: int = -speed * 3
@export var gravity: int = speed * 4
@export var fall_gravity_factor: float = 1.05

var attacks = ["attack1", "attack2"]

@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
@onready var state_machine = $StateMachine
@onready var anim_tree = $AnimationTree
@onready var sprite_2d = $Sprite2D

func _ready():
	anim_tree.active = true
	# Give the state machine a reference to the player
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	
	move_and_slide()
	
	#var current_anim = animation_state_machine.get_current_node()
	#if current_anim in ["hurt", "die"]:
		#return
		#
	#var movement = Input.get_axis("left", "right")
#
	#if not is_on_floor():
		## Add the gravity.
		#velocity += get_gravity() * delta
#
	## choose animation
	#if Input.is_action_just_pressed("attack"):
		#animation_state_machine.travel(attacks.pick_random())
	#elif is_on_floor() and Input.is_action_just_pressed("jump"):
		#animation_state_machine.travel("jump")
		#velocity.y = JUMP_VELOCITY
	#elif movement != 0:
		#if is_on_floor():
			#animation_state_machine.travel("run")
		#velocity.x = movement * SPEED
#
		#$Sprite2D.flip_h = velocity.x < 0
		#$Hitbox.scale.x = -1 if velocity.x < 0 else 1
	#else:
		#velocity.x = 0
		#if current_anim == "run":
			#animation_state_machine.travel("idle")
#
	#move_and_slide()
	
	
func _on_health_tracker_die() -> void:
	animation_state_machine.travel("die")
	set_physics_process(false)
	
	print("Player Died!")


func _on_health_tracker_hitpoints_changed(_before: int, after: int) -> void:
	animation_state_machine.travel("hurt")
	
	print("Player Hitpoints: ", after)


func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	print("Animation Started: ", anim_name)
