extends Node2D

@export var track_path: Path2D
@export var track_width: float = 100.0

func _ready():
	var curve = track_path.curve
	var resolution = 50  # més gran = més precís
	var left_points: Array[Vector2] = []
	var right_points: Array[Vector2] = []

	for i in range(resolution):
		var t = float(i) / (resolution - 1)
		var point = curve.sample(i, t)
		var next_t = min(t + 1.0 / resolution, 1.0)
		var next_point = curve.sample(i, next_t)

		# 1️⃣ Direcció tangent
		var tangent = (next_point - point).normalized()
		# 2️⃣ Normal perpendicular (90 graus)
		var normal = Vector2(-tangent.y, tangent.x)

		# 3️⃣ Offset lateral
		var offset = normal * (track_width / 2.0)

		# 4️⃣ Afegim punts esquerra i dreta
		left_points.append(point + offset)
		right_points.append(point - offset)

	# 5️⃣ Invertim l’ordre dels punts drets per tancar el polígon
	right_points.reverse()

	# 6️⃣ Combina els dos costats per fer un Polygon2D
	var polygon_points = left_points + right_points

	var polygon = Polygon2D.new()
	polygon.polygon = polygon_points
	polygon.color = Color(0.2, 0.2, 0.2)  # gris asfalt
	add_child(polygon)

	# 7️⃣ Col·lisió automàtica
	var collision = CollisionPolygon2D.new()
	collision.polygon = polygon_points
	add_child(collision)
