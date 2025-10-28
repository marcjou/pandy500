class_name AnimationComponent extends Node

@export var slide_speed = 14

var final_pos = Vector2(150, 200)
var org_pos : Vector2

func _ready() -> void:
	org_pos = get_parent().position
	
func _process(delta: float) -> void:
	if get_parent().visible:
		if final_pos < get_parent().position:
			get_parent().position -= Vector2(30, 0)*delta*slide_speed
		
	
