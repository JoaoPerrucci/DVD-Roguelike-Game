extends Label

var t = 0
var blue = 1
var green = 1

func _ready():
	await get_tree().create_timer(2.5).timeout
	queue_free()
	
func _process(delta):
	t += delta*0.075
	$".".self_modulate = $".".self_modulate.lerp(Color(1,green,blue,0), t)
