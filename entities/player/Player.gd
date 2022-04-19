extends KinematicBody2D

class_name Player

export (int) var speed
export (int) var jump_speed
export (int) var gravity
export (int) var hard_gravity
export (int) var max_fall_speed

var velocity = Vector2.ZERO
var interactable = null
var inventory = []
var MAX_INVENTORY_SIZE = 2

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

enum {
	MOVING,
	STUNNED,
}

var state = MOVING

func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		get_tree().quit()
	if Input.is_action_just_pressed("interact") and interactable != null:
		interactable.interact_with(self)

func _physics_process(delta):
	if state == MOVING:
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
	elif state == STUNNED:
		velocity.x = 0
		velocity.y += hard_gravity * delta
		velocity.y = clamp(velocity.y, jump_speed, max_fall_speed)
		velocity = move_and_slide(velocity, Vector2.UP)

func start_interacting_with(body):
	interactable = body

func stop_interacting_with(_body):
	interactable = null

func can_interact_with(_body):
	return inventory.size() < MAX_INVENTORY_SIZE

func _on_Hurtbox_area_entered(_area):
	state = STUNNED
	animationPlayer.play("Hurt")

func _on_AnimationPlayer_animation_finished(anim_name):
	state = MOVING
