extends CharacterBody2D

@export var speed: int = 100.0
@export var acceleration: int = 20
@export var gravity: int = 0

var spawn_point: Vector2

@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
@onready var state_machine: StateMachine = $StateMachine
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var down_raycast_2d: RayCast2D = $DownRaycast2D

func _ready() -> void:
	spawn_point = global_position
	anim_tree.active = true
	# Give the state machine a reference to the player
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)

	move_and_slide()

func _on_health_tracker_die() -> void:
	velocity.x = 0
	state_machine.change_state("DeadState")

func _on_health_tracker_hitpoints_changed(before: int, after: int) -> void:
	print_debug("bat took damage: ", before - after)

func _on_attack_trigger_attack_started() -> void:
	if $HealthTracker.hitpoints <= 0:
		return
	print_debug("started attacking player")
	state_machine.change_state("AttackState")

func _on_attack_trigger_attack_stopped() -> void:
	if $HealthTracker.hitpoints <= 0:
		return
	print_debug("bat stopped attacking player")
	state_machine.change_state("IdleStated")
