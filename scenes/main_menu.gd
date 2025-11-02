extends Control

var car_type : String
var car_type2 : String
var mode_selected : String
var player: int = 1

func _ready() -> void:
	$CanvasLayer/SelectMode.get_popup().id_pressed.connect(_on_select_mode_pressed)
	$CanvasLayer/SelectTrack.get_popup().id_pressed.connect(_on_select_track_pressed)
	$CanvasLayer/SelectCar.pressed.connect(_on_select_car_pressed)
	await $"CanvasLayer/Developed by/DevLogo".animation_finished
	await get_tree().create_timer(1).timeout
	$"CanvasLayer/Developed by".hide()
	$CanvasLayer/Sprite2D.show()
	$MainMenuMusic.play()
	await get_tree().create_timer(2).timeout
	$CanvasLayer/Title.show()
	$CanvasLayer/SelectMode.show()
	$CanvasLayer/Sprite2D.hide()
	$CanvasLayer/SelectMode.grab_focus.call_deferred()
func _on_select_mode_pressed(id: int):
	match id:
		0: chosen_mode("sp")
		1: chosen_mode("2p")

func chosen_mode(mode: String):
	match mode:
		"sp": mode_selected = "sp"
		"2p": mode_selected = "2p"
	$CanvasLayer/SelectMode.hide()
	$CanvasLayer/SelectCar.show()
	$CanvasLayer/SelectCar.grab_focus.call_deferred()
	
# TODO investigar como modificar un menu button
func _on_select_track_pressed(id: int):
	match id:
		0: 
			if mode_selected == "2p":
				$"../..".start_level("res://scenes/tracks/track_oval.tscn", car_type, car_type2)
			else:
				$"../..".start_level("res://scenes/tracks/track_oval.tscn", car_type)
		1:
			if mode_selected == "2p":
				$"../..".start_level("res://scenes/tracks/track_drift.tscn", car_type, car_type2)
			else:
				$"../..".start_level("res://scenes/tracks/track_drift.tscn", car_type)
		
func _on_select_car_pressed() -> void:
	$CanvasLayer/Cars.show()
	$CanvasLayer/Cars/PandaButton.grab_focus.call_deferred()
	$CanvasLayer/Player.text = "Player 1"
	$CanvasLayer/Player.show()
		
func chosen_car(car: String):
	if mode_selected == "2p":
		if player == 2:
			car_type2 = car
			
			player = 1
			$CanvasLayer/SelectCar.hide()
			$CanvasLayer/Cars.hide()
			$CanvasLayer/SelectTrack.show()
			$CanvasLayer/Player.hide()
			$CanvasLayer/SelectTrack.grab_focus.call_deferred()
		else:
			car_type = car
			player = 2
			$CanvasLayer/Player.text = "Player 2"
	else:
		car_type = car
		$CanvasLayer/SelectCar.hide()
		$CanvasLayer/Cars.hide()
		$CanvasLayer/SelectTrack.show()
		$CanvasLayer/SelectTrack.grab_focus.call_deferred()
	
