extends Button

var label = load ("res://label.tscn")


func _on_pressed():
	if global.money >= 6:
		global.money -= 6
		global.evil_twin = true
		$"../../Reroll".options.erase ("../upgrade_choice/evil_twin")
		$".".visible = false
	else:
		var not_enough = label.instantiate ()
		$"../../..".add_child(not_enough)
		not_enough.global_position = Vector2(get_global_mouse_position().x - 80,get_global_mouse_position().y - 17)
		not_enough.green = 0.5
		not_enough.blue = 0.5
		not_enough.self_modulate = Color(0.95,0.05,0.05,1)
		not_enough.text = 'Not enough money'
