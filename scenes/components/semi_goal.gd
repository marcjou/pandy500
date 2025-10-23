extends Area2D


func _on_body_exited(car: CharacterBody2D) -> void:
	car.can_add_lap = true
