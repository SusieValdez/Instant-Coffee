extends KinematicBody2D

class_name BUTLER

var speed = 30
var gravity = 1000
var commands = []
var command_index = 0

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite

var interactable = null
var inventory = []

func _ready():
	animation_player.play("Idle")

func _process(delta):
	var current_command = commands[command_index]
	var command_name = current_command[0]
	if command_name == "MOVE":
		var target_position = current_command[1]
		animation_player.play("Running")
		var velocity = (target_position - position).normalized() * speed
		if velocity.x > 0:
			sprite.flip_h = false
		elif velocity.x < 0:
			sprite.flip_h = true
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
		if abs(target_position.x - position.x) < 1:
			command_index += 1
		return
	elif command_name == "TELEPORT":
		var payload = current_command[1]
		var fromPedestal = payload["from"]
		var toPedestal = payload["to"]
		var teleport_position = toPedestal.position
		fromPedestal.interact_with(self)
		toPedestal.interact_with(self)
		position = teleport_position
		command_index += 1
		return
	elif command_name == "INTERACT":
		animation_player.play("Idle")
		if interactable.interact_with(self):
			command_index += 1
		return
	elif command_name == "DESPAWN":
		queue_free()
		return

func start_interacting_with(body):
	interactable = body

func stop_interacting_with(_body):
	interactable = null

func can_interact_with(_body):
	return true
