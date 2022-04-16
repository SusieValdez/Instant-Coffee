extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer
onready var level = get_node("../..")

var orders = []

func _ready():
	animationPlayer.play("Idle")
	orders = Globals.orders_by_level[level.name]

func _on_Area2D_body_entered(body):
	if body is Player or body is BUTLER:
		body.start_interacting_with(self)

func _on_Area2D_body_exited(body):
	if body is Player or body is BUTLER:
		body.stop_interacting_with(self)

func interact_with(body):
	var num_orders_completed = 0
	for item in body.inventory:
		if item in Globals.orders:
			Globals.orders.erase(item)
			body.inventory.erase(item)
			num_orders_completed += 1
	Globals.meg_score += num_orders_completed
	return true

func _on_NewOrderTimer_timeout():
	var order = orders[randi() % orders.size()]
	Globals.orders.push_back(order)
	$NewOrderTimer.wait_time = rand_range(2, 10)
	$NewOrderTimer.start()
