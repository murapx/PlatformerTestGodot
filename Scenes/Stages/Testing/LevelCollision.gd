extends AnimatableBody2D

var time_elapsed := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_elapsed += delta
	position.y = 300 * sin(time_elapsed)
