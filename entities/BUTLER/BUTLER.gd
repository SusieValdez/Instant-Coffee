extends KinematicBody2D

class_name BUTLER

onready var animation_player = $AnimationPlayer
var interactable = null

var speed = 50
var gravity = 600

var inventory = []
var target_position: Vector2 = Vector2(0, 0)

func _ready():
	animation_player.play("Idle")

func _process(delta):
	if target_position != null:
		animation_player.play("Running")
		var velocity = (target_position - position) * delta * speed
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)

func start_interacting_with(body):
	interactable = body

func stop_interacting_with(_body):
	interactable = null

func can_interact_with(_body):
	return true
