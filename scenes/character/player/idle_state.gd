extends NodeState

@export var player_car : PlayerCar

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if player_car.player_name == "Player 1":
		GameInputEvents.movement_input()
		if GameInputEvents.accelerating or GameInputEvents.decelerating:
			transition.emit("Drive")
	else:
		GameInputEvents.movement_input2()
		if GameInputEvents.accelerating2 or GameInputEvents.decelerating2:
			transition.emit("Drive")


func _on_enter() -> void:
	$"../../AnimatedSprite2D".play("d_" + player_car.car_type)


func _on_exit() -> void:
	pass
