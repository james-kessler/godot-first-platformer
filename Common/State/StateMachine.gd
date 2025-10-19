class_name StateMachine
extends Node

var current_state: State
var states = {}
var owner_ref
var running = false

func init(owner: CharacterBody2D):
	running = true
	owner_ref = owner
	# Load all child state nodes
	for child in get_children():
		states[child.name] = child
		child.state_machine = self
		child.owner_ref = owner_ref

	change_state("IdleState")

func change_state(new_name: String):
	if !running:
		return

	if current_state:
		current_state.exit()
	current_state = states.get(new_name)
	if (current_state):
		print("New State: ", current_state)
		current_state.enter()

func physics_update(delta):
	if current_state:
		current_state.handle_input()
	if current_state:
		current_state.physics_update(delta)

func stop():
	running = false
