extends Node2D
var score: int
signal gameover
signal init_settings
var _initial_volume

func _ready():
	_initial_volume = $BGMusic.volume_db
	init_settings.emit(_initial_volume)

func _on_enemy_died(points):
	score += points
	$HUD.update_score(score)

func _on_enemy_group_all_enemies_dead():
	$HUD.show_message("Well done!\nYou win!")
	$HUD.show_win_screen()
	$EnemyGroup.reset_move_timer()
	
func new_game():
	score = 0
	$HUD.hide_win_screen()
	$HUD.update_score(score)
	$Player.show()
	$Player.start($StartPosition.position)
	$EnemyGroup.start($StartPositionEnemies.position)
	
	if $BGMusic.playing == false:
		$BGMusic.play()
	
func game_over():
	$HUD.show_message("Game Over!")
	$HUD.show_game_over()
	$BGMusic.stop()
	gameover.emit()
	
func _on_enemy_goal_area_entered(area):
	if area is Enemy:
		game_over()

func _stop_music():
	if $BGMusic.playing == true:
		$BGMusic.stop()
		

func _on_hud_volume_change(volume):
	$BGMusic.volume_db = volume 
