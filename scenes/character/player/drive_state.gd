extends NodeState

@export var player_car : PlayerCar
var start_speed = 0
var actual_speed
#@export var acceleration = 3
#@export var acceleration_power = 2
#@export var drift_power = 0.3
#@export var drift_rotation = 3.0
#@export var rotation_rad = 0.01
var car_front_direction : Vector2
var drift_flag = false
var old_direction : Vector2
var angle_diff = 0
var current_angle = 0.0

var stats: Dictionary = {} 

func _on_process(_delta : float) -> void:
	pass
	


func _on_physics_process(_delta : float) -> void:
	if player_car.player_name == "Player 1":
		var motion_vector = GameInputEvents.movement_input()
		var speed_mod = stats["acceleration"] * stats["acceleration_power"]
		
		if GameInputEvents.accelerating != GameInputEvents.decelerating:
			actual_speed = clamp(actual_speed + speed_mod * GameInputEvents.dir_acceleration, 
			player_car.speed * -1, player_car.speed)
			if actual_speed < player_car.speed:
				$"../../AccelParticle".emitting = true
			else:
				$"../../AccelParticle".emitting = false
			if !GameInputEvents.drifting:
				if drift_flag:
					#actual_speed = actual_speed/2
					#if current_angle == 0.0:
						#current_angle = player_car.direction.angle()
					#update_angle(_delta)
					player_car.direction = Vector2.UP.rotated(player_car.rotation)
					actual_speed = actual_speed*stats["drift_boost"]
					drift_flag = false
				#player_car.direction = Vector2.UP.rotated(player_car.rotation)
		else:
			if !GameInputEvents.drifting:
				var direction = sign(actual_speed)
				var min_speed = start_speed if direction>0 else player_car.speed * -1
				var max_speed = start_speed if direction<0 else player_car.speed
				actual_speed = clamp(actual_speed - speed_mod * direction, 
				min_speed, max_speed)
		
		if GameInputEvents.rotating != 0:
			var turn_modifier = GameInputEvents.rotating*GameInputEvents.dir_acceleration*stats["rotation_rad"]
			if GameInputEvents.drifting:			
				if not drift_flag:
					old_direction = player_car.direction
					drift_flag = true
				else:
					angle_diff = player_car.direction.angle_to(old_direction)
				if abs(angle_diff) < deg_to_rad(90):
					player_car.rotation = player_car.rotation + turn_modifier*stats["drift_rotation"]
					car_front_direction = player_car.direction.rotated(turn_modifier*stats["drift_rotation"])
					player_car.direction = player_car.direction.rotated(turn_modifier*stats["drift_rotation"]*0.5)
					print('estic driftejant')
					
			else:
				
				if drift_flag:
					#actual_speed = actual_speed/2
					#update_angle(_delta)
					pass
				else:
					player_car.rotation = player_car.rotation + turn_modifier
					player_car.direction = player_car.direction.rotated(turn_modifier)
					car_front_direction = player_car.direction
		
		if GameInputEvents.drifting:
			var drift = stats["acceleration"] * (stats["drift_power"]+stats["acceleration_power"]) +_delta
			var direction = sign(actual_speed)
			var min_speed = start_speed if direction>0 else player_car.speed * -1
			var max_speed = start_speed if direction<0 else player_car.speed
			actual_speed = clamp(actual_speed - drift * direction, min_speed, max_speed)
	else:
		var motion_vector = GameInputEvents.movement_input2()
		var speed_mod = stats["acceleration"] * stats["acceleration_power"]
		
		if GameInputEvents.accelerating2 != GameInputEvents.decelerating2:
			actual_speed = clamp(actual_speed + speed_mod * GameInputEvents.dir_acceleration2, 
			player_car.speed * -1, player_car.speed)
			if actual_speed < player_car.speed:
				$"../../AccelParticle".emitting = true
			else:
				$"../../AccelParticle".emitting = false
			if !GameInputEvents.drifting2:
				if drift_flag:
					#actual_speed = actual_speed/2
					#if current_angle == 0.0:
						#current_angle = player_car.direction.angle()
					#update_angle(_delta)
					player_car.direction = Vector2.UP.rotated(player_car.rotation)
					actual_speed = actual_speed*stats["drift_boost"]
					drift_flag = false
				#player_car.direction = Vector2.UP.rotated(player_car.rotation)
		else:
			if !GameInputEvents.drifting2:
				var direction = sign(actual_speed)
				var min_speed = start_speed if direction>0 else player_car.speed * -1
				var max_speed = start_speed if direction<0 else player_car.speed
				actual_speed = clamp(actual_speed - speed_mod * direction, 
				min_speed, max_speed)
		
		if GameInputEvents.rotating2 != 0:
			var turn_modifier = GameInputEvents.rotating2*GameInputEvents.dir_acceleration2*stats["rotation_rad"]
			if GameInputEvents.drifting2:			
				if not drift_flag:
					old_direction = player_car.direction
					drift_flag = true
				else:
					angle_diff = player_car.direction.angle_to(old_direction)
				if abs(angle_diff) < deg_to_rad(90):
					player_car.rotation = player_car.rotation + turn_modifier*stats["drift_rotation"]
					car_front_direction = player_car.direction.rotated(turn_modifier*stats["drift_rotation"])
					player_car.direction = player_car.direction.rotated(turn_modifier*stats["drift_rotation"]*0.5)
					print('estic driftejant')
					
			else:
				
				if drift_flag:
					#actual_speed = actual_speed/2
					#update_angle(_delta)
					pass
				else:
					player_car.rotation = player_car.rotation + turn_modifier
					player_car.direction = player_car.direction.rotated(turn_modifier)
					car_front_direction = player_car.direction
		
		if GameInputEvents.drifting2:
			var drift = stats["acceleration"] * (stats["drift_power"]+stats["acceleration_power"]) +_delta
			var direction = sign(actual_speed)
			var min_speed = start_speed if direction>0 else player_car.speed * -1
			var max_speed = start_speed if direction<0 else player_car.speed
			actual_speed = clamp(actual_speed - drift * direction, min_speed, max_speed)		
	
	#player_car.direction = car_front_direction
	player_car.velocity = actual_speed * player_car.direction
	player_car.move_and_slide()
	
func update_angle(delta):
	#var current_angle = player_car.direction.angle()
	var target_angle = player_car.rotation
	var diff = wrapf(target_angle - current_angle, -PI, PI)
	if abs(diff) > deg_to_rad(3):
		var lerp_speed = 2.0 * delta
		var new_angle = lerp_angle(current_angle, target_angle, lerp_speed)
		player_car.direction = Vector2.UP.rotated(new_angle)
		print(str(current_angle) + '   ' + str(target_angle))
		current_angle = new_angle
	else:
		player_car.direction = Vector2.UP.rotated(target_angle)
		drift_flag = false
		current_angle = 0.0

func _on_next_transitions() -> void:
	if player_car.player_name == "Player 1":
		GameInputEvents.movement_input()
		if !GameInputEvents.accelerating and actual_speed == 0 and !GameInputEvents.decelerating:
			transition.emit("Idle")
	else:
		GameInputEvents.movement_input2()
	if !GameInputEvents.accelerating2 and actual_speed == 0 and !GameInputEvents.decelerating2:
		transition.emit("Idle")

func _on_enter() -> void:
	stats = player_car.get_stats()
	actual_speed = start_speed
	car_front_direction = player_car.direction
	$"../../AnimatedSprite2D".play("moving_" + player_car.car_type)
	


func _on_exit() -> void:
	pass
