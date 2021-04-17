extends Node

enum Songs { Regular, Battle }

export var transition_duration = 3.00
export var transition_type = 1  # TRANS_SINE


func switchMusic(song):
	# print("switchMusic", song)
	# if song == Songs.Regular:
	# 	crossFade($BattleMusic, $RegularMusic)
	# if song == Songs.Battle:
	# 	crossFade($RegularMusic, $BattleMusic)
	print("switchMusic", song)
	return


func crossFade(before, after):
	print("corssFade", before, after)
	var tween_out = $Tween1
	tween_out.interpolate_property(
		before, "volume_db", -10, -80, transition_duration, transition_type, Tween.EASE_IN, 0
	)
	tween_out.start()

	var tween_in = $Tween2
	tween_in.interpolate_property(
		after, "volume_db", -80, -10, transition_duration, transition_type, Tween.EASE_IN, 0
	)
	tween_in.start()
