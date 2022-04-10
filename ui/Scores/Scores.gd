extends Panel

func _process(_delta):
	$MegScore.text = str(Globals.meg_score)
