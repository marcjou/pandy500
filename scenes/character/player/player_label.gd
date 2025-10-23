extends Label

func _process(delta: float) -> void:
	if get_parent():
		rotation = -get_parent().rotation
