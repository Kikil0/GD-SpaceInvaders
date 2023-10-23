extends Area2D
var PROJECTILE_SPEED = 400
var initial_position: Vector2
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	position = initial_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= PROJECTILE_SPEED*delta
	
	if position.y < 0:
		queue_free()

func SetPosition(pos):
	initial_position = pos
	
