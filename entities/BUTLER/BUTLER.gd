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

enum {
	SPAWNING,
	MOVING,
	STUNNED,
}

var state = SPAWNING

func _ready():
	animation_player.play("WalkOut")
	yield(animation_player, "animation_finished")
	state = MOVING

func _process(delta):
	if inventory.size() > 0:
		$Item.texture = load("res://assets/items/" + inventory[0] + ".png")
	else:
		$Item.texture = null
	if state == MOVING:
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
			Globals.butler_score += 1
			state = SPAWNING
			animation_player.play("WalkIn")
			yield(animation_player, "animation_finished")
			queue_free()
			return
	elif state == STUNNED:
		pass
	elif state == SPAWNING:
		pass

func start_interacting_with(body):
	interactable = body

func stop_interacting_with(_body):
	interactable = null

func can_interact_with(_body):
	return true

func _on_Hurtbox_area_entered(_area):
	state = STUNNED
	animation_player.play("Stunned")
	$StunSoundPlayer.stream = Globals.get_sfx("robot-stun")
	$StunSoundPlayer.play()
	yield(animation_player, "animation_finished")
	state = MOVING
