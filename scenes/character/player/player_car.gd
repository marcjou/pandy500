extends CharacterBody2D
class_name PlayerCar

@export var speed = 400 # Modifiable in stats
@export var acceleration = 2 # Should remain almost static, modified by power only
@export var acceleration_power = 1 # Modifiable in stats
@export var drift_power = 0.3
@export var drift_rotation = 1.6 # Modifiable in stats
@export var rotation_rad = 0.04 # Modifiable in stats
@export var drift_boost = 1.3


var org_speed : int
var player_position
var direction: Vector2
var slowed: bool = false
var player_name: String
var car_type: String = "panda"
var can_add_lap: bool = true
var actual_lap: int
var total_laps: int

signal race_finished



func _ready() -> void:
	player_position = position
	#TODO set good stats for each car type
	set_car_stats()
	org_speed = speed
	actual_lap = 0
	$PlayerLabel.text = player_name

func set_car_stats():
	match car_type:
		"turtle": 
			speed = speed*1.05
			acceleration_power = acceleration_power*0.93
		"croco": 
			rotation_rad = rotation_rad*0.9
			drift_rotation = drift_rotation*1.2
			drift_boost = drift_boost*1.5
		"racoon": 
			speed = speed*1.2
			acceleration_power = acceleration_power*1.1
			rotation_rad = rotation_rad*1.6

func get_stats():
	var stats = {"acceleration": acceleration, "acceleration_power": acceleration_power, 
	"drift_power": drift_power, "drift_rotation": drift_rotation, "rotation_rad": rotation_rad, "drift_boost": drift_boost}
	return stats
	
func _physics_process(delta: float) -> void:
	if actual_lap > total_laps:
		emit_signal("race_finished")

func set_slowed():
	if !slowed:
		speed = speed*0.5
		slowed = true
	else:
		speed = org_speed
		slowed = false

		
func add_lap():
	actual_lap += 1
	var lap_string = str(actual_lap) + "/" + str(total_laps)
	print(lap_string)
	$"../../UIController/UI".modify_lap_label(lap_string, player_name)

func _on_race_finished() -> void:
	get_parent().get_parent().race_finished(player_name)
