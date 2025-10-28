extends Control

var old_value = 5.5

func _on_return_button_pressed() -> void:
	get_parent().get_parent().restart_game()
	


func _on_music_slider_value_changed(value: float) -> void:
	$"../../RaceMusic".volume_db = value/2 - 50
	if value == 0.0:
		$"../../RaceMusic".volume_db = -80
