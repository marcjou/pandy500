extends Button

@export var car: String


func _on_pressed() -> void:
	print(car)
	$"../../..".chosen_car(car)
