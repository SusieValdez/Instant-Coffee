extends Node

var meg_score = 0
var butler_score = 0

var orders: Array = []

var orders_by_level = {
	"Level 1": [
		"coffee/americano",
		"coffee/espresso",
		"coffee/affogato",
		"coffee/cold-brew",
		"coffee/oatmilk-lavender-latte-cold",
		"coffee/oatmilk-lavender-latte-hot",
		"coffee/macchiato",
		"coffee/cappuccino",
		"coffee/hot-tea",
		"coffee/iced-tea",
		"coffee/pumpkin-latte",
		"coffee/hot-chocolate",
	]
}

const NUM_HURT_SOUNDS = 5
const NUM_TELEPORT_SOUNDS = 1
const NUM_JUMP_SOUNDS = 4
const NUM_ROBOT_STUN_SOUNDS = 5
const NUM_PICKUP_SOUNDS = 1

var sfx = {
	"hurt": [],
	"jump": [],
	"teleport": [],
	"robot-stun": [],
	"pickup": [],
}

func _ready():
	for i in NUM_HURT_SOUNDS:
		sfx['hurt'].append(load("res://assets/audio/hurt-sounds/" + str(i+1) + ".wav"))
	for i in NUM_TELEPORT_SOUNDS:
		# note that we currently have a single sound with an mp3 extension
		sfx['teleport'].append(load("res://assets/audio/teleport-sounds/" + str(i+1) + ".mp3"))
	for i in NUM_JUMP_SOUNDS:
		sfx['jump'].append(load("res://assets/audio/jump-sounds/" + str(i+1) + ".wav"))
	for i in NUM_ROBOT_STUN_SOUNDS:
		sfx['robot-stun'].append(load("res://assets/audio/robot-stun-sounds/" + str(i+1) + ".wav"))
	for i in NUM_PICKUP_SOUNDS:
		sfx['pickup'].append(load("res://assets/audio/pickup-sounds/" + str(i+1) + ".wav"))

func get_sfx(type):
	var sounds = sfx[type]
	return sounds[randi() % sounds.size()]
