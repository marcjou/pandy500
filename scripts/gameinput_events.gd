class_name GameInputEvents

static var accelerating = false
static var decelerating = false
static var dir_acceleration = 1
static var rotating = 0
static var drifting = false

static var accelerating2 = false
static var decelerating2 = false
static var dir_acceleration2 = 1
static var rotating2 = 0
static var drifting2 = false


static func movement_input():
	if Input.is_action_pressed("move_forward"):
		accelerating = true
		dir_acceleration = 1
	else:
		accelerating = false
	if Input.is_action_pressed("move_backwards"):
		decelerating = true
		dir_acceleration = -1
	else:
		decelerating = false
	if Input.is_action_pressed("turn_left"):
		rotating = -1
	elif Input.is_action_pressed("turn_right"):
		rotating = 1
	else:
		rotating = 0
		
	if Input.is_action_pressed("Drift"):
		drifting = true
	else:
		drifting = false
		
	return rotating

static func movement_input2():
	if Input.is_action_pressed("move_forward2"):
		accelerating2 = true
		dir_acceleration2 = 1
	else:
		accelerating2 = false
	if Input.is_action_pressed("move_backwards2"):
		decelerating2 = true
		dir_acceleration2 = -1
	else:
		decelerating2 = false
	if Input.is_action_pressed("turn_left2"):
		rotating2 = -1
	elif Input.is_action_pressed("turn_right2"):
		rotating2 = 1
	else:
		rotating2 = 0
		
	if Input.is_action_pressed("Drift2"):
		drifting2 = true
	else:
		drifting2 = false
		
	return rotating2
