extends Node
class_name Main

var start_position1: Marker2D
var start_position2: Marker2D
var actual_lap: int
var total_laps: int
var track: String

func _ready() -> void:
	instantiate_main_menu()
	
func instantiate_main_menu():
	var main_menu = preload("res://scenes/main_menu.tscn")
	var main_menu_instance = main_menu.instantiate()
	$UIController.add_child(main_menu_instance)
	
func instantiate_ui(player2: String = "none"):
	var ui = preload("res://scenes/UI/ui.tscn")
	var ui_instance = ui.instantiate()
	$UIController.add_child(ui_instance)
	if player2 != "none":
		ui_instance.player_2_ready()
		
func instantiate_finished_menu(winner):
	var finished_menu = preload("res://scenes/UI/race_finished.tscn")
	var finished_menu_instance = finished_menu.instantiate()
	$UIController.add_child(finished_menu_instance)
	
	Global.track = track
	Global.load()
	var highscore = Global.high_score
	if highscore > $UIController/UI.time_elapsed:
		Global.high_score = $UIController/UI.time_elapsed
		Global.format_highscore = $UIController/UI.formatted_time
		Global.save()
	
	finished_menu_instance.set_result_time($UIController/UI.formatted_time, winner, Global.format_highscore)
	
	
func start_level(level_path: String,car_type: String, car_type2: String = "none"):
	track = level_path.split('_')[1]
	var level_scene = load(level_path)
	var level_instance = level_scene.instantiate()
	$Track.add_child(level_instance)
	start_position1 = level_instance.get_node("StartPosition1")
	actual_lap = 0
	total_laps = level_instance.total_laps	
	for child in $Vehicles.get_children(): child.queue_free()
	place_player("Player 1", car_type)
	if car_type2 != "none":
		start_position2 = level_instance.get_node("StartPosition2")
		place_player("Player 2", car_type2)
	$UIController/MainMenu.queue_free()
	instantiate_ui(car_type2)
	$RaceMusic.playing = true
	
func place_player(name: String, car_type: String):
	# Place player
	var player_scene = preload("res://scenes/character/player/player_car.tscn")
	var player_instance = player_scene.instantiate()
	if name == "Player 1":
		player_instance.position = start_position1.position
		player_instance.rotation = start_position1.rotation
		player_instance.direction = Vector2.UP.rotated(start_position1.rotation)
	else:
		player_instance.position = start_position2.position
		player_instance.rotation = start_position2.rotation
		player_instance.direction = Vector2.UP.rotated(start_position2.rotation)
	player_instance.total_laps = total_laps
	player_instance.player_name = name
	player_instance.car_type = car_type

	$Vehicles.add_child(player_instance)


func race_finished(winner: String):
	print('The winner is: ' + winner)
	instantiate_finished_menu(winner)
	$UIController/UI.queue_free()
	reset_game($Vehicles)
	reset_game($Track)
	$RaceMusic.playing = false

func reset_game(item_group):
	for item in item_group.get_children():
		item.queue_free()
		
func restart_game():
	if $UIController/UI:
		$UIController/UI.queue_free()
	elif $UIController/RaceFinished:
		$UIController/RaceFinished.queue_free()
	reset_game($Vehicles)
	reset_game($Track)
	reset_game($UIController)
	$RaceMusic.playing = false
	instantiate_main_menu()
	
func open_settings():
	var settings_menu = preload("res://scenes/UI/settings_menu.tscn")
	var settings_menu_instance = settings_menu.instantiate()
	$UIController.add_child(settings_menu_instance)
