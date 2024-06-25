extends CollisionPolygon2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Polygon2D.polygon = polygon
