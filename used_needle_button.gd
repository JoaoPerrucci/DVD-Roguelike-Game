extends Button

var num_of_uses = 4
var label = load ("res://label.tscn")

func _on_button_pressed():
	if global.money >= 2:
		global.money -= 2
		global.dvd_initial_size *= 1.2
		$".".visible = false
		num_of_uses -= 1
		global.radius *= 1.17
		$"../../../dvd_area".get_child(0).scale *= 1.17
		if num_of_uses <= 0:
			$"../../Reroll".options.erase ("../upgrade_choice/used_needle_button")
	else:
		var not_enough = label.instantiate ()
		$"../../..".add_child(not_enough)
		not_enough.global_position = Vector2(get_global_mouse_position().x - 80,get_global_mouse_position().y - 17)
		not_enough.green = 0.5
		not_enough.blue = 0.5
		not_enough.self_modulate = Color(0.95,0.05,0.05,1)
		not_enough.text = 'Not enough money'
