extends CharacterBody2D

enum state {IDLE, WALKING, RUNNING, JUMPING}

var player_state

@export var max_speed : float
#@export var max_speed_walking : float
#@export var max_speed_running : float
@export var jump_speed : float
@export var max_fall_speed : float

@export var gravity_on_rise : float
@export var gravity_on_fall : float

@export var acceleration_ground : float
@export var acceleration_air : float

@export var friction_ground : float
@export var friction_air : float

#var max_speed : float
var friction : float
var acceleration : float

@onready var sprite = $AnimatedSprite2D

var jump_hold_time: float = 0

func _physics_process(delta):
	if Input.is_action_pressed("jump"):
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump_hold_time = 0.1
			jump()
			
		jump_hold_time += 0.1
		print(jump_hold_time)
	#if Input.is_action_just_released("jump") and velocity.y <= 0 and !is_on_floor():
		#velocity.y = move_toward(velocity.y, 0, 200)
		
	if velocity.x == 0:
		player_state = state.IDLE
	elif velocity.x != 0:
		player_state = state.WALKING
	if abs(velocity.x) >= max_speed:
		player_state = state.RUNNING
	if velocity.y != 0 and !is_on_floor():
		player_state = state.JUMPING
	
		
	#if Input.is_action_pressed("run") and player_state != state.IDLE:
		#if player_state == state.JUMPING:
			#pass
		#else: 
			#player_state = state.RUNNING
			#max_speed = max_speed_running
	#else:
		#max_speed = max_speed_walking/
	
	if not is_on_floor():
		friction = friction_air
		acceleration = acceleration_air
		
		var gravity: float
		
		if velocity.y < 0:
				gravity = gravity_on_rise / jump_hold_time
		else:
			if Input.is_action_pressed("jump"):
				gravity = gravity_on_fall - gravity_on_fall/2
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
	
	match player_state:
		state.IDLE:
			sprite.play("idle")
		state.WALKING:
			sprite.play("walking")
		state.RUNNING:
			sprite.play("running")
		state.JUMPING:
			sprite.play("jumping")
	#if player_state == state.IDLE: 
		#sprite.play("idle")
	##elif (velocity.x <= max_speed - max_speed/20) and (velocity.x >= -max_speed - -max_speed/20):
	##	sprite.play("walking")
	#else:
		#sprite.play("walking")
	#if velocity.y != 0:
		#sprite.stop()
		#sprite.play("jumping")
	
	move_and_slide()
func jump():
	velocity.y = -jump_speed
