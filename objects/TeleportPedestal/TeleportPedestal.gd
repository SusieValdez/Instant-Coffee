extends StaticBody2D

func interact_with(_body):
	$AnimationPlayer.play("Teleport")
	$TeleportSoundPlayer.stream = Globals.get_sfx('teleport')
	$TeleportSoundPlayer.play()
