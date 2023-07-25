extends Node

export(PackedScene) var mob_scene
var score

func _ready():
	randomize()
	
func game_over():
	$ScoreTimer.stop()
	$MobeTimer.stop()
	$HUD.show_game_over()
	$MusicGame.stop()
	$deathSound.play()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message('Бегите \n глупцы!')
	get_tree().call_group('mobs', 'queue_free')
	$MusicGame.play()

func _on_MobeTimer_timeout():
	var mob = mob_scene.instance()
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	mob.position = mob_spawn_location.position
	var velocity = Vector2(0, rand_range(200, 400))
	mob.linear_velocity = velocity
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
