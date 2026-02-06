extends Button

var label = load ("res://label.tscn")

var beggar = ['Do you have a spare change?', 'You could create an alt
account and buy this game
again, what do you think?', 'Perhaps you could buy
this game for a friend,
it\'s a nice gift...
at least to me it is', 'I spent months making this game.
Never once I saw the DvD hit the corner', 'Hello there', 'And so we meet again', 'I hope you\'re enjoying it.', 
'Don\'t watch JoJo,
don\'t believe what it 
says about beggars', 'I\'m stuck on an
neverending cycle...', 'Will you come back tomorrow?', 'I hope you have a succesful run', 'Drink water', 
'Is one coin going to make
a difference to you?', 'Just another day']

var sorry = ['It\'s okay', 'Worry not']

func _ready():
	$"../../Reroll".connect ('uptade_text', uptade_text)
	
func uptade_text():
	$".".tooltip_text = beggar [randi_range (0, len(beggar)-1)]

func _on_popcorn_button_pressed():
	if global.money >= 1:
		global.money -= 1
		$".".visible = false
		$"../../Reroll".options.erase ("../upgrade_choice/beggar_button")
	else:
		var not_enough = label.instantiate ()
		$"../../..".add_child(not_enough)
		not_enough.global_position = Vector2(get_global_mouse_position().x - 20,get_global_mouse_position().y - 17)
		not_enough.green = 0.5
		not_enough.blue = 0.5
		not_enough.self_modulate = Color(0.95,0.05,0.05,1)
		not_enough.text = sorry [randi_range(0,1)]
