extends Node2D
@export var projectile_scene: PackedScene

# Timer to delay the player shots
var shot_timer : Timer
var state = "NotShooting"

func _ready():
	shot_timer = Timer.new()
	##Create a Shot Timer
	shot_timer.wait_time = 0.5
	add_child(shot_timer)
	shot_timer.connect("timeout", _shot_timer_cooldown)

func _input(event):
	if Input.is_action_pressed("shoot") && state == "NotShooting":
		var projectile = projectile_scene.instantiate() as Projectile
		projectile.SetPosition(get_parent().global_position - Vector2 (0,20))
		get_tree().root.get_node("Main").add_child(projectile)
		state = "Shooting"
		shot_timer.start()

func _shot_timer_cooldown():
	state = "NotShooting"
	

