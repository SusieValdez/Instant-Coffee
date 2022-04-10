extends Sprite

onready var Coffee = preload("res://objects/Coffee.tscn")

var selected_items = []

func get_selected_item():
	if selected_items.size() > 0:
		return selected_items[0]
	return null

func _ready():
	spawn_coffee(get_node("ItemSpawnLocations/Node2D").position)
	spawn_coffee(get_node("ItemSpawnLocations/Node2D2").position)

func _process(_delta):
	for i in selected_items.size():
		var selected_item = selected_items[i]
		if i == 0:
			selected_item.set_outline_color(Color.white)
		else:
			selected_item.set_outline_color(Color.transparent)

func spawn_coffee(spawn_position: Vector2):
	var coffee = Coffee.instance()
	coffee.scale = Vector2(0.5, 0.5)
	coffee.position = spawn_position
	add_child(coffee)
	coffee.connect("item_selected", self, "_on_item_selected")
	coffee.connect("item_deselected", self, "_on_item_deselected")

func _on_item_selected(item, _selector):
	selected_items.push_front(item)

func _on_item_deselected(item, _selector):
	item.set_outline_color(Color.transparent)
	selected_items.erase(item)

func _on_InteractZone_body_entered(body):
	body.start_interacting_with(self)

func _on_InteractZone_body_exited(body):
	body.stop_interacting_with(self)

func interact_with(body):
	var selected_item = get_selected_item()
	if selected_item != null:
		var copy = selected_item.duplicate()
		body.add_item_to_inventory(copy)
		selected_item.queue_free()
		yield(get_tree().create_timer(10.0), "timeout")
		spawn_coffee(copy.position)
