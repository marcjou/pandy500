class_name AnimationComponent extends Node

func _ready() -> void:
	get_parent().position = Vector2(150, 300)
	
func _process(delta: float) -> void:
	pass
	
