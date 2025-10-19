class_name StateMachine
extends Node

var current_state: State
var states = {}
var owner_ref
var running = false

# Queued state to switch to at the end of physics_update
var next_state_name: String = ""

func init(owner: CharacterBody2D):
	running = true
	owner_ref = owner
	# Load all child state nodes
	for child in get_children():
		states[child.name] = child
		child.state_machine = self
		child.owner_ref = owner_ref

	change_state_immediate("IdleState")

func change_state(new_name: String):
	# Queue a state change to happen later
	if !running:
		return
	next_state_name = new_name

func _apply_queued_state_change():
	if next_state_name == "":
		return

	if current_state:
		current_state.exit()

	var new_state = states.get(next_state_name)
	if new_state:
		print("New State: ", new_state)
		current_state = new_state
		current_state.enter()
	else:
		push_warning("Unknown state: " + next_state_name)

	next_state_name = ""

func physics_update(delta):
	if !running:
		return

	if current_state:
		current_state.handle_input()
		current_state.physics_update(delta)

	# Apply any queued state change after this frame’s logic
	_apply_queued_state_change()

func change_state_immediate(new_name: String):
	# Helper for initialization or forced transitions
	if !running:
		return

	if current_state:
		current_state.exit()

	current_state = states.get(new_name)
	if current_state:
		print("New State: ", current_state)
		current_state.enter()

func stop():
	running = false
