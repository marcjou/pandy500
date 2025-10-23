extends Area2D


func _on_body_exited(car: CharacterBody2D) -> void:
	if car.can_add_lap:
		car.add_lap()
		car.can_add_lap = false
