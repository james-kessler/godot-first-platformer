extends MovementState


func enter():
	owner_ref.animation_state_machine.travel("idle")

func physics_update(delta):
	super.physics_update(delta)
	var dir = Input.get_axis("ui_left", "ui_right")

	if dir != 0 and owner_ref.is_on_floor():
		state_machine.change_state("RunState")
