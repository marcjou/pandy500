extends Control

var result_time
var winner: String
var highscore: String

func set_result_time(result_time: String, winner: String, highscore: String) -> void:
	result_time = result_time
	winner = winner
	highscore = highscore
	$CanvasLayer/PanelContainer/MarginContainer/GridContainer/TimeLabel.text = "Time: " + result_time
	$CanvasLayer/PanelContainer/MarginContainer/GridContainer/WinnerLabel.text = "Winner is " + winner
	$CanvasLayer/PanelContainer/MarginContainer/GridContainer/HighScore.text = "Highscore is " + highscore
