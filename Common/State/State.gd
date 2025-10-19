@abstract
class_name State
extends Node

var state_machine: StateMachine
var owner_ref: CharacterBody2D

func enter() -> void:
	pass

func handle_input() -> void:
	pass

func physics_update(delta: float) -> void:
	if "gravity" in owner_ref:
		owner_ref.velocity.y += owner_ref.gravity * delta

func exit() -> void:
	pass
