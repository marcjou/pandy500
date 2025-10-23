extends Control

var result_time
var winner: String

func set_result_time(result_time: String, winner: String) -> void:
	result_time = result_time
	winner = winner
	$CanvasLayer/PanelContainer/MarginContainer/GridContainer/TimeLabel.text = "Time: " + result_time
	$CanvasLayer/PanelContainer/MarginContainer/GridContainer/WinnerLabel.text = "Winner is " + winner
