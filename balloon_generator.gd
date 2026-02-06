extends Timer



var balloon_generator = false

func _on_timeout():
	if balloon_generator:
		var spawn_item = load ("res://balloon.tscn")
		var item = spawn_item.instantiate ()
		$"../inventory".add_child(item)
		item.global_position = Vector2 (randi_range(0, 640), 375)
		item.collision_mask = 0
		item.collision_layer = 16
		item.name = "res://balloon.tscn"
