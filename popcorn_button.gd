extends Button

var label = load ("res://label.tscn")

func _ready():
	$"../../Reroll".connect ('uptade_text', uptade_text)
	
func uptade_text():
	$RichTextLabel.text = '[center][b]Popcorn 1[/b]
+' + str(global.popcorn) +' points[/center]'

	$".".tooltip_text = 'Kinda corny, but it\'ll pop some points'

func _on_popcorn_button_pressed():
	if global.money >= 1:
		global.money -= 1
		$"../../../inventory".inventory.append ("res://popcorn.tscn")
		$".".visible = false
	else:
		var not_enough = label.instantiate ()
		$"../../..".add_child(not_enough)
		not_enough.global_position = Vector2(get_global_mouse_position().x - 80,get_global_mouse_position().y - 17)
		not_enough.green = 0.5
		not_enough.blue = 0.5
		not_enough.self_modulate = Color(0.95,0.05,0.05,1)
		not_enough.text = 'Not enough money'
