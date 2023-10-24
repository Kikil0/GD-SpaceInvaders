extends Node2D
var score: int
signal gameover

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemy_died(points):
	score += points
	$HUD.update_score(score)

func _on_enemy_group_all_enemies_dead():
	$HUD.show_message("Well done!\nYou win!")
	

func game_over():
	$HUD.show_message("Game Over!")
	gameover.emit()
	
func _on_enemy_goal_area_entered(area):
	if area is Enemy:
		game_over()
