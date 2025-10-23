extends Control

var car_type : String
var car_type2 : String
var mode_selected : String
var player: int = 1

func _ready() -> void:
	$CanvasLayer/PanelContainer/GridContainer/SelectMode.get_popup().id_pressed.connect(_on_select_mode_pressed)
	$CanvasLayer/PanelContainer/GridContainer/SelectTrack.get_popup().id_pressed.connect(_on_select_track_pressed)
	$CanvasLayer/PanelContainer/GridContainer/SelectCar.get_popup().id_pressed.connect(_on_select_car_pressed)
	$CanvasLayer/PanelContainer/GridContainer/SelectTrack.hide()
	$CanvasLayer/PanelContainer/GridContainer/SelectCar.hide()
	
func _on_select_mode_pressed(id: int):
	match id:
		0: chosen_mode("sp")
		1: chosen_mode("2p")

func chosen_mode(mode: String):
	match mode:
		"sp": mode_selected = "sp"
		"2p": mode_selected = "2p"
	$CanvasLayer/PanelContainer/GridContainer/SelectMode.hide()
	$CanvasLayer/PanelContainer/GridContainer/SelectCar.show()
	
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
		
func _on_select_car_pressed(id: int) -> void:
	match id:
		0: chosen_car("panda")
		1: chosen_car("racoon")
		2: chosen_car("croco")
		3: chosen_car("turtle")
		
func chosen_car(car: String):
	if mode_selected == "2p":
		if player == 2:
			car_type2 = car
			$CanvasLayer/PanelContainer/GridContainer/SelectCar.hide()
			$CanvasLayer/PanelContainer/GridContainer/SelectTrack.show()
			player = 1
		else:
			car_type = car
			player = 2
	else:
		car_type = car
		$CanvasLayer/PanelContainer/GridContainer/SelectCar.hide()
		$CanvasLayer/PanelContainer/GridContainer/SelectTrack.show()
