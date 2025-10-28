extends GridContainer

@export var cars: Array
var car: String

func get_id():
	get_parent().chosen_car(car)
