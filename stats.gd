extends Label



func _process(delta):
	$".".text = "hp:" + str(global.health) + '  Money:' + str (global.money) + '  bounces: ' + str(global.hp)
