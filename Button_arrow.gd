extends Button

var arrow_pressed = false
var direction = 200

func _on_button_down():
	arrow_pressed = true
	
func _process(delta):
	if arrow_pressed:
		$"..".rotation_degrees += direction * delta


func _on_button_up():
	arrow_pressed = false
	$".".release_focus()
	direction *= -1
	
