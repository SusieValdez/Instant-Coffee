extends Sprite

signal item_selected(item, selector)
signal item_deselected(item, selector)

var item_name = ""

onready var area = $Area2D
onready var start_time = randf() * 100
onready var pickup_sound_player = $PickupSoundPlayer
var can_select = true

func _ready():
	texture = load("res://assets/items/" + item_name + ".png")

var time = 0.0
func _process(delta):
	offset.y = 2 * sin(start_time + time * 5)
	time += delta

func _on_Area2D_body_entered(body):
	emit_signal("item_selected", self, body)

func _on_Area2D_body_exited(body):
	emit_signal("item_deselected", self, body)

func set_outline_color(color):
	material.set_shader_param("color", color)
