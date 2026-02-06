extends Sprite2D

var mushroom = [preload("res://assets/mushroom_0001.png"), preload("res://assets/mushroom_0002.png"),
preload("res://assets/mushroom_0003.png"),preload("res://assets/mushroom_0004.png"),
preload("res://assets/mushroom_0005.png"),preload("res://assets/mushroom_0006.png")]

func _ready():
	$".".texture = mushroom[randi_range(0,5)]
