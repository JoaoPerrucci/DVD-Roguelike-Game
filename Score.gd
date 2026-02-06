extends Label

var score = 'gae'

func _process(delta):
	if len(str(round(global.score))) > 9:
		score = str(round(global.score)).left(len(str(round(global.score)))-9) + '.' + str(floor(global.score*10)).split()[-10] + 'B'
	elif len(str(round(global.score))) > 6:
		score = str(round(global.score)).left(len(str(round(global.score)))-6) + '.' + str(floor(global.score*10)).split()[-7] + 'M'
	else:
		score = str(round(global.score))
		
	$multipliers.text = '(Base Mult: ' + str(round (global.general_multiplier*100)/100) + ') x (Bonus Mult: ' + str(round (global.mult_of_mult*100)/100) + ')'
	
	text =  "level " + str(global.level) + ": " + score + "/" + $"..".goal
