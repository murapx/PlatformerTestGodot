extends CharacterBody2D

@export var max_speed := 200.0
@export var friction := 50.0
@export var acceleration := 50.0

@export var jump_height := 100.0

@export var gravity_on_rise := 5.0
@export var gravity_on_fall := 5.0

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		var gravity: float
		if velocity.y < 0:
			gravity = gravity_on_rise
		else:
			gravity = gravity_on_fall
		velocity.y += gravity
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_height
	
	var input_direction = Input.get_axis("left", "right")
	if input_direction != 0:
		#if -max_speed < velocity.x and velocity.x < max_speed:
			#velocity.x += acceleration * input_direction
		velocity.x = move_toward(velocity.x, max_speed * input_direction, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
	
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
	
	if velocity.x == 0: 
		sprite.play("idle")
	elif (velocity.x < max_speed - max_speed/13) and (velocity.x > -max_speed - -max_speed/13):
		sprite.play("walking")	
	else:
		sprite.play("running")
	
	if velocity.y != 0:
		sprite.play("jumping")
	
		
	move_and_slide()
