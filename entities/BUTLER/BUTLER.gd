extends KinematicBody2D

class_name BUTLER

onready var animation_player = $AnimationPlayer 

func _ready():
	animation_player.play("Idle")
