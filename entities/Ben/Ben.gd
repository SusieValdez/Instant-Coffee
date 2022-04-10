extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("Idle")


func _on_Area2D_body_entered(body):
	if body is Player or body is BUTLER:
		body.start_interacting_with(self)

func _on_Area2D_body_exited(body):
	if body is Player or body is BUTLER:
		body.stop_interacting_with(self)

func interact_with(body):
	Globals.meg_score += body.get_inventory_size()
	body.clear_inventory()
