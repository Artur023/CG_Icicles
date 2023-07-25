extends Area2D

signal hit

export var speed = 400
var screen_size

var target = Vector2()

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	target = pos
	show()
	$CollisionShape2D.disabled = false
# для сенсорного экрана	
#func _input(event):

	#if event is InputEventScreenTouch and event.pressed:
	#	target.x = event.position.x

func _process(delta):
	var velocity = Vector2()
	 #для сенсорного экрана	
	#if position.distance_to(target) > 10:
	#	velocity = target - position
	
	# для клавиатуры
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	#общее
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0 + 16, screen_size.x - 16)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = 'walk'
		$AnimatedSprite.flip_h = velocity.x > 0
	
func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred('disabled', true)
