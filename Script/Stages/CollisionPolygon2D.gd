extends CollisionPolygon2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Polygon2D.polygon = polygon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
