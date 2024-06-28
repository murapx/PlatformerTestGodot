extends CharacterBody2D

@export var max_speed : float
@export var jump_speed : float
@export var max_fall_speed : float

@export var gravity_on_rise : float
@export var gravity_on_fall : float

@export var acceleration_ground : float
@export var acceleration_air : float

@export var friction_ground : float
@export var friction_air : float

var friction : float
var acceleration : float

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	if Input.is_action_just_released("jump") and velocity.y <= 0 and !is_on_floor():
		velocity.y = move_toward(velocity.y, 0, 200)
		
	if not is_on_floor():
		friction = friction_air
		acceleration = acceleration_air
		
		var gravity: float
		
		if velocity.y < 0:
				gravity = gravity_on_rise# / jump_duration
		else:
			gravity = gravity_on_fall
		if velocity.y <= max_fall_speed:
			velocity.y += gravity 
	else:
		friction = friction_ground
		acceleration = acceleration_ground
	
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
	elif (velocity.x <= max_speed - max_speed/20) and (velocity.x >= -max_speed - -max_speed/20):
		sprite.play("walking")
	else:
		sprite.play("running")
	if velocity.y != 0:
		sprite.stop()
		sprite.play("jumping")
	
	move_and_slide()
	print(velocity.y)
func jump():
	velocity.y = -jump_speed
