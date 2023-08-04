extends Node

export(PackedScene) var mob_scene

var score
onready var music = $MusicGame

func _ready():
	$MusicButton.hide()
	randomize()

func game_over():
	$ScoreTimer.stop()
	$MobeTimer.stop()
	$HUD.show_game_over()
	$deathSound.play()
	$MusicButton.hide()
	music.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message('Избегай\n сосулек!')
	get_tree().call_group('mobs', 'queue_free')
	$MusicButton.show()
	if $MusicButton/AnimatedSprite.animation == 'on':
		music.play()
	
func _on_MobeTimer_timeout():
	var mob = mob_scene.instance()
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	mob.position = mob_spawn_location.position
	var velocity = Vector2(0, rand_range(200, 600))
	mob.linear_velocity = velocity
	# TODO над придумать хороший алгоритм увеличения скорости и изменения моб таймера.
	if score % 10 == 0:
		$MobeTimer.wait_time = 0.07
		mob.linear_velocity = velocity * 1.5
	else:
		$MobeTimer.wait_time = 0.5
	add_child(mob)
	
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobeTimer.start()
	$ScoreTimer.start()
	
# Закрытие игры на Esc
#func _unhandled_input(event):
#	if event is InputEventKey:
#		if event.pressed and event.scancode == KEY_ESCAPE:
#			get_tree().quit()

# вкл/выкл музыка
func _on_MusicButton_pressed():
	if music.playing:
		music.stop()
	else:
		music.play()
