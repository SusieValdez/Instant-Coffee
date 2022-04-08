extends KinematicBody2D

class_name Player

export (int) var speed
export (int) var jump_speed
export (int) var gravity
export (int) var hard_gravity
export (int) var max_fall_speed

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		get_tree().quit()

func _physics_process(delta):
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x = speed
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y += jump_speed
	
	# If released jump before max jump height, start falling
	if velocity.y < 0 and not is_on_floor() and Input.is_action_just_released("jump"):
		velocity.y = 0
	# If falling to ground, or just released jump, fall faster
	if velocity.y > 0 or (not is_on_floor() and Input.is_action_just_released("jump")):
		velocity.y += hard_gravity * delta
	else:
		velocity.y += gravity * delta

	velocity.y = clamp(velocity.y, jump_speed, max_fall_speed)

	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	if is_on_floor():
		if velocity.x == 0:
			animationPlayer.play("Idle")
		else:
			animationPlayer.play("Run")
	else:
		animationPlayer.play("Jump")

	velocity = move_and_slide(velocity, Vector2.UP)