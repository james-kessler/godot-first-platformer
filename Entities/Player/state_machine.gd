extends Node

var current_state: State
var states = {}
var owner_ref

func init(owner):
	owner_ref = owner
	# Load all child state nodes
	for child in get_children():
		states[child.name] = child
		child.state_machine = self
		child.owner_ref = owner_ref

	change_state("IdleState")

func change_state(new_name: String):
	if current_state:
		current_state.exit()
	current_state = states.get(new_name)
	current_state.enter()

func physics_update(delta):
	if current_state:
		current_state.handle_input()
		current_state.physics_update(delta)
	
	# always apply gravity
	#owner_ref.velocity.y += owner_ref.gravity * delta
