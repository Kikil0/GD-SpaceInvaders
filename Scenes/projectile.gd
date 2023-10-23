extends Area2D
var PROJECTILE_SPEED = 100
var initial_position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= PROJECTILE_SPEED*delta

func SetPosition(pos):
	position = pos
