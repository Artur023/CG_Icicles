extends RigidBody2D


func _ready():
	if linear_velocity.y <= 300:
		$Sprite.animation = 'yellow'
		$Smoke.lifetime = 1.2
	elif linear_velocity.y <= 500:
		$Sprite.animation = 'orange'
		$Smoke.lifetime = 1.4
	elif linear_velocity.y > 500:
		$Sprite.animation = 'red'
		$Smoke.lifetime = 1.8
		$Smoke.emitting = true
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
