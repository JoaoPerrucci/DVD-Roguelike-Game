extends Button

var label = load ("res://label.tscn")

func _ready():
	$"../../Reroll".connect ('uptade_text', uptade_text)
	
func uptade_text():
	$RichTextLabel.text = '[center][b]Banana 2[/b]
+' + str(global.banana) +' points,
slips in a random direction[/center]'

	$".".tooltip_text = 'Not allowed in car race'

func _on_pressed():
	if global.money >= 2:
		global.money -= 2
		$"../../../inventory".inventory.append ("res://banana.tscn")
		$".".visible = false
	else:
		var not_enough = label.instantiate ()
		$"../../..".add_child(not_enough)
		not_enough.global_position = Vector2(get_global_mouse_position().x - 80,get_global_mouse_position().y - 17)
		not_enough.green = 0.5
		not_enough.blue = 0.5
		not_enough.self_modulate = Color(0.95,0.05,0.05,1)
		not_enough.text = 'Not enough money'
