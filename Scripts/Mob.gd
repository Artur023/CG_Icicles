extends RigidBody2D


func _ready():
	if linear_velocity.y <= 300:
		$Sprite.animation = 'yellow'
	elif linear_velocity.y <= 500:
		$Sprite.animation = 'orange'
	elif linear_velocity.y <= 600:
		$Sprite.animation = 'red'

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
