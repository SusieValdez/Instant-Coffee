extends Sprite

onready var Item = preload("res://objects/Item.tscn")

var selected_items = []

export var sold_items = []
export var teleporter_path = []

func get_selected_item():
	if selected_items.size() > 0:
		return selected_items[0]
	return null

func _ready():
	randomize()
	for child in get_node("ItemSpawnLocations").get_children():
		spawn_coffee(child.position)

func _process(_delta):
	for i in selected_items.size():
		var selected_item = selected_items[i]
		if i == 0:
			selected_item.set_outline_color(Color.white)
		else:
			selected_item.set_outline_color(Color.transparent)

func spawn_coffee(spawn_position: Vector2):
	var item = Item.instance()
	item.item_name = sold_items[randi() % sold_items.size()]
	item.scale = Vector2(0.5, 0.5)
	item.position = spawn_position
	add_child(item)
	item.connect("item_selected", self, "_on_item_selected")
	item.connect("item_deselected", self, "_on_item_deselected")

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
	if not body.can_interact_with(self):
		return false # TODO: replace with UI feedback
	var selected_item = get_selected_item()
	if selected_item == null:
		return false
	body.inventory.push_back(selected_item.item_name)

	var copy = selected_item.duplicate()
	selected_item.queue_free()
	yield(get_tree().create_timer(10.0), "timeout")
	spawn_coffee(copy.position)
	return true
