@abstract
class_name State
extends Node

var state_machine
var owner_ref: CharacterBody2D

func enter() -> void:
	pass

func handle_input() -> void:
	if Input.is_action_just_pressed("jump") and owner_ref.is_on_floor():
		state_machine.change_state("JumpState")

func physics_update(delta: float) -> void:
	owner_ref.velocity.y += owner_ref.gravity * delta

func exit() -> void:
	pass
