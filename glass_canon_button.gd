extends Button

var label = load ("res://label.tscn")

func _on_button_pressed():
	if global.money >= 5:
		global.money -= 5
		$"../../Reroll".options.erase ("../upgrade_choice/glass_canon_button")
		$"../../Reroll".options.erase ("../upgrade_choice/DVD_case_button")
		global.mult_of_mult += global.hp
		global.hp = -100
		global.shot_hp = -100
		global.glass = true
		$".".visible = false
	else:
		var not_enough = label.instantiate ()
		$"../../..".add_child(not_enough)
		not_enough.global_position = Vector2(get_global_mouse_position().x - 80,get_global_mouse_position().y - 17)
		not_enough.green = 0.5
		not_enough.blue = 0.5
		not_enough.self_modulate = Color(0.95,0.05,0.05,1)
		not_enough.text = 'Not enough money'
