extends Panel

var MissingItem = preload("res://ui/Orders/MissingItem.tscn")

func _process(_delta):
	for n in $GridContainer.get_children():
		$GridContainer.remove_child(n)
	for order in Globals.orders:
		var newMissingItem = MissingItem.instance()
		$GridContainer.add_child(newMissingItem)
		newMissingItem.get_node("TextureRect").texture = load("res://assets/items/" + order + ".png")
