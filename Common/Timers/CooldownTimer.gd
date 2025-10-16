class_name CooldownTimer
extends Timer

func _init() -> void:
	one_shot = true

func start_cooldown()-> void:
	start()

func is_on_cooldown() -> bool:
	return !is_stopped()
