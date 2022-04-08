extends KinematicBody2D

class_name BUTLER

export (int) var speed
export (int) var jump_speed
export (int) var gravity
export (int) var hard_gravity
export (int) var max_fall_speed

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200

var velocity = Vector2.ZERO

onready var animation_player = $AnimationPlayer 
onready var stun_timer = $StunTimer
onready var sprite = $Sprite

enum {
	IDLE, 
	WANDER, 
}


var state = IDLE

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	match state:
		IDLE:
			velocity.x = 0
		WANDER: 
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	if velocity.x == 0: 
		animation_player.play("Idle")
	else: 
		animation_player.play("Running")

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()	

func _on_Hurtbox_body_entered(body):
	if not body is Player:
		return
	animation_player.play("Stunned")
	stun_timer.start()

func _on_StunTimer_timeout():
	animation_player.play("Idle")
