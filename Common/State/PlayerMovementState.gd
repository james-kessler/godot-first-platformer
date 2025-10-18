@abstract
class_name MovementState
extends State

# Universal input handling
func handle_input():
	super.handle_input()
	if Input.is_action_just_pressed("attack"):
		state_machine.change_state("AttackState")
		return

# Universal physics handling
func physics_update(delta):
	super.physics_update(delta)
	var dir = Input.get_axis("ui_left", "ui_right")

	owner_ref.velocity.x = move_toward(owner_ref.velocity.x, owner_ref.speed * dir, owner_ref.acceleration)
	
	if dir != 0:
		owner_ref.sprite_2d.flip_h = owner.velocity.x < 0
