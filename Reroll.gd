extends Button

signal uptade_text

var options = [ "../upgrade_choice/banana_button", "../upgrade_choice/popcorn_button", 
"../upgrade_choice/arrow_button", "../upgrade_choice/used_needle_button",
"../upgrade_choice/heavy_boots_button", "../upgrade_choice/boost_boots_button",
"../upgrade_choice/dragon_egg_button", "../upgrade_choice/mushroom_button2",
"../upgrade_choice/mirror_button", "../upgrade_choice/DVD_case_button","../upgrade_choice/BTC_button",
 "../upgrade_choice/balloon_button", "../upgrade_choice/cheapskate_button",
"../upgrade_choice/clapperboard_button", "../upgrade_choice/store_vault_button",
"../upgrade_choice/katana_button", "../upgrade_choice/evil_twin", "../upgrade_choice/aim",
"../upgrade_choice/extra_butter_button", "../upgrade_choice/water_balloon_button",
"../upgrade_choice/brick_button", "../upgrade_choice/kidney_button", 
"../upgrade_choice/holy_water_button", "../upgrade_choice/time_bomb_button",
"../upgrade_choice/coin_button", "../upgrade_choice/shotgun_button",
"../upgrade_choice/ricochet_button", "../upgrade_choice/combo_button",
"../upgrade_choice/balloon_generator_button", "../upgrade_choice/beggar_button",
"../upgrade_choice/blu_ray_button", "../upgrade_choice/glass_canon_button"]

var one = 1
var two = 1
var three = 1

var label = load ("res://label.tscn")

signal Reroll1

func _ready():
	$"../..".connect ('reroll', reroll)
	connect ('Reroll1', reroll)
	print ('number of buttons: ' + str(len(options)))

func _on_pressed():
	if global.money >= 1:
		global.money -= 1
		Reroll1.emit()
	else:
		var not_enough = label.instantiate ()
		$"../../..".add_child(not_enough)
		not_enough.global_position = Vector2(get_global_mouse_position().x - 80,get_global_mouse_position().y - 17)
		not_enough.green = 0.5
		not_enough.blue = 0.5
		not_enough.self_modulate = Color(0.95,0.05,0.05,1)
		not_enough.text = 'Not enough money'
	
func reroll():
	uptade_text.emit()
	for i in len(options):
		get_node(options[i]).visible = false
	one = randi_range(0, len(options)-1)
	two = randi_range(0, len(options)-1)
	while two == one:
		two = randi_range(0, len(options)-1)
	three = randi_range(0, len(options)-1)
	while three == one or three == two:
		three = randi_range(0, len(options)-1)
	get_node(options[one]).visible = true
	get_node(options[two]).visible = true
	get_node(options[three]).visible = true
