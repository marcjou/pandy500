extends Control

var time_elapsed: float = 0.0
var formatted_time
var another_lap: Label
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	time_elapsed = time_elapsed + delta
	$CanvasGroup/PanelContainer2/MarginContainer/TimerLabel.text = time_convert(time_elapsed)

func time_convert(time: float):
	var milliseconds = (time - int(time)) * 1000
	var seconds = int(time)%60
	var minutes = (int(time)/60)%60
	var hours = (int(time)/60)/60
	
	formatted_time = "%02d:%02d:%02d:%03d" % [hours, minutes, seconds, milliseconds]
	
	return formatted_time
	
func player_2_ready():
	var another_player = Label.new()
	another_player.text = "Player 2"
	$CanvasGroup/PanelContainer/MarginContainer/GridContainer.add_child(another_player)
	another_lap = Label.new()
	another_lap.text = "Lap: 1/3"
	$CanvasGroup/PanelContainer/MarginContainer/GridContainer.add_child(another_lap)

func modify_lap_label(lap_text: String, player_name: String):
	if player_name == "Player 1":
		$CanvasGroup/PanelContainer/MarginContainer/GridContainer/LapLabel.text = "Lap: " + lap_text
	else:
		another_lap.text = "Lap: " + lap_text


func _on_button_pressed() -> void:
	get_parent().get_parent().open_settings()
