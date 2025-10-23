extends Area2D




func _on_body_entered(car: CharacterBody2D) -> void:
	car.set_slowed()



func _on_body_exited(car: CharacterBody2D) -> void:
	car.set_slowed()
