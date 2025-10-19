extends CharacterBody2D

var speed: int
var acceleration: int
var jump_speed: int
var gravity: int
@export var fall_gravity_factor: float

var attacks = ["attack1", "attack2"]

@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
@onready var state_machine = $StateMachine
@onready var anim_tree = $AnimationTree
@onready var sprite_2d = $Sprite2D
@onready var health_tracker: HealthTracker = $HealthTracker
@onready var hitbox: Hitbox = $Hitbox


func _ready():
	speed = GameConfig.get_value("Player", "speed", 300)
	acceleration = GameConfig.get_value("Player", "acceleration", 80)
	jump_speed = -speed * GameConfig.get_value("Player", "jump_factor", 3)
	gravity = speed * GameConfig.get_value("Player", "gravity_factor", 4)
	fall_gravity_factor = GameConfig.get_value("Player", "fall_gravity_factor", 1.05)
	
	health_tracker.max_hitpoints = GameConfig.get_value("Player", "hitpoints", 30)
	hitbox.damage = GameConfig.get_value("Player", "damage", 10)
	
	anim_tree.active = true
	# Give the state machine a reference to the player
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	
	move_and_slide()

func _on_health_tracker_die() -> void:
	animation_state_machine.travel("die")
	set_physics_process(false)
	
	print("Player Died!")

func _on_health_tracker_hitpoints_changed(_before: int, after: int) -> void:
	animation_state_machine.travel("hurt")
	
	print("Player Hitpoints: ", after)

func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	print("Animation Started: ", anim_name)
