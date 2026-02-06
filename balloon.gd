extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity = Vector2 (0, randi_range(-63,-67))
	$Collision_balloon/Sprite_balloon.play('balloon', randf_range(0.9,1.1))
