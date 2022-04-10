extends Panel


func _process(_delta):
	var inventory = get_node("../../Player").inventory
	for i in 2:
		var textureRect = get_node("ItemSlot" + str(i + 1)).get_node("TextureRect")
		textureRect.texture = null
		if i < inventory.size():
			var item_name = inventory[i]
			textureRect.texture = load("res://assets/items/" + item_name + ".png")
