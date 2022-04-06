extends KinematicBody2D

export (int) var speed = 100
export (int) var jump_speed = -700
export (int) var gravity = 35
export (int) var max_fall_speed = 700

var velocity = Vector2.ZERO

func _process(delta):
	if Input.is_action_just_pressed("menu"):
		get_tree().quit()

func _physics_process(delta):
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x = speed
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	if is_on_floor() and Input.is_action_just_pressed("jump"):
			velocity.y = jump_speed
	velocity.y += gravity
	velocity.y = clamp(velocity.y, jump_speed, max_fall_speed)
	velocity = move_and_slide(velocity, Vector2.UP)
