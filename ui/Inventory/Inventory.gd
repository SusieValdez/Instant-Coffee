extends Panel


func _process(_delta):
	var inventory = get_node("../../Player").inventory
	for i in 2:
		var texture
		if i < inventory.size():
			texture = inventory[i].texture
		else:
			texture = null
		get_node("ItemSlot" + str(i + 1)).get_node("TextureRect").texture = texture
