extends Area2D

signal hit

export var speed = 400
var screen_size

var target = Vector2()
var screen;

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	target = pos
	show()
	$CollisionShape2D.disabled = false
	
func _input(event):
	if event is InputEventScreenTouch and event.pressed and !get_node("/root/Main/MusicButton").is_pressed():
		screen = true
		target.x = event.position.x
	elif event is InputEventKey:
		screen = false

func _process(delta):
	var velocity = Vector2()
	 #для сенсорного экрана	
	if screen:
		if position.distance_to(target) > 10:
			velocity = target - position
	else:
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
	body.queue_free()
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred('disabled', true)

