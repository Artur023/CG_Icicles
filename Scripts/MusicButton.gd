extends TouchScreenButton

func _on_TouchScreenButton_pressed():
	if $AnimatedSprite.animation == 'off':
		$AnimatedSprite.animation = 'on'
	else:
		$AnimatedSprite.animation = 'off'

