extends KinematicBody2D

class_name BUTLER

onready var animation_player = $AnimationPlayer

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
		move_and_slide(velocity, Vector2.UP)

func start_interacting_with(body):
	pass

func stop_interacting_with(body):
	pass

func can_interact_with(body):
	return true
