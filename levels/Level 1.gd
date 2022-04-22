extends Level

var BUTLER = preload("res://entities/BUTLER/BUTLER.tscn")
onready var BUTLER_spawn_position = $Office/BUTLERSpawnPoint.global_position
onready var BUTLER_list = $BUTLERs

func _on_BUTLERSpawnTimer_timeout():
	var shops = get_node("Shops").get_children()
	var num_shops = shops.size()
	if num_shops == 0:
		return
	var shop = shops[randi() % num_shops]
	var shopPosition = shop.position

	var itemSpawns = shop.get_node("ItemSpawnLocations").get_children()
	var num_item_spawns = itemSpawns.size()
	var itemSpawn = itemSpawns[randi() % num_item_spawns]
	var itemPosition = itemSpawn.position

	var new_BUTLER = BUTLER.instance()
	new_BUTLER.position = BUTLER_spawn_position
	new_BUTLER.commands = []
	
	for i in shop.teleporter_path.size():
		var teleporter_id = shop.teleporter_path[i]
		if i % 2 == 0:
			new_BUTLER.commands.append(["MOVE", getTelporter(teleporter_id).position])
		else:
			var previous_teleporter_id = shop.teleporter_path[i - 1]
			new_BUTLER.commands.append(["TELEPORT", {
				"from": getTelporter(previous_teleporter_id),
				"to": getTelporter(teleporter_id),
			}])
	new_BUTLER.commands.append(["MOVE", shopPosition + itemPosition])
	new_BUTLER.commands.append(["INTERACT"])
	for _i in shop.teleporter_path.size():
		var i = shop.teleporter_path.size() - 1 - _i
		var teleporter_id = shop.teleporter_path[i]
		if i % 2 == 0:
			new_BUTLER.commands.append(["MOVE", getTelporter(teleporter_id).position])
		else:
			var next_teleporter_id = shop.teleporter_path[i - 1]
			new_BUTLER.commands.append(["TELEPORT", {
				"from": getTelporter(teleporter_id),
				"to": getTelporter(next_teleporter_id),
			}])
	new_BUTLER.commands.append(["MOVE", BUTLER_spawn_position])
	new_BUTLER.commands.append(["DESPAWN"])
	BUTLER_list.add_child(new_BUTLER)
	$BUTLERSpawnTimer.wait_time = rand_range(2, 8)
	$BUTLERSpawnTimer.start()

func getTelporter(id: int):
	return get_node("TeleportPedestals/" + str(id))
