extends Level

var BUTLER = preload("res://entities/BUTLER/BUTLER.tscn")
onready var BUTLER_spawn_position = $Office/BUTLERSpawnPoint.global_position
onready var BUTLER_list = $BUTLERs

func _on_BUTLERSpawnTimer_timeout():
	var new_BUTLER = BUTLER.instance()
	new_BUTLER.position = BUTLER_spawn_position
	new_BUTLER.target_position = get_node("TeleportPedestals/TeleportPedestal").position
	BUTLER_list.add_child(new_BUTLER)
