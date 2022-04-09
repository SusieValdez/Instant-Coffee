extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

func _ready():
	animationPlayer.play("Idle")
