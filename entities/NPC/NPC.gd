extends KinematicBody2D

signal orders_completed

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var level = get_node("../..")
var num_orders = 0
var can_interact_with = true

func _ready():
	var possible_orders = Globals.orders_by_level[level.name]
	for i in num_orders:
		var order = possible_orders[randi() % possible_orders.size()]
		Globals.orders.push_back(order)

func _on_Area2D_body_entered(body):
	body.start_interacting_with(self)

func _on_Area2D_body_exited(body):
	body.stop_interacting_with(self)

func interact_with(body):
	for item in body.inventory:
		if item in Globals.orders:
			Globals.orders.erase(item)
			body.inventory.erase(item)
			Globals.meg_score += 1
			num_orders -= 1
			$GiveCoffeeSoundPlayer.stream = Globals.get_sfx('pickup')
			$GiveCoffeeSoundPlayer.play()
	if num_orders == 0:
		emit_signal("orders_completed")
		can_interact_with = false
	return false
