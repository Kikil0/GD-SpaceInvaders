extends Area2D
@export var SPEED = 1000
var _projectile
var screen_size

signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	_projectile = preload("res://Scenes/projectile.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	#Check for input
	if (Input.is_action_pressed("move_left")):
		velocity.x -= 1 
	if (Input.is_action_pressed("move_right")):
		velocity.x += 1

	if velocity.length() > 0:
		velocity = velocity * SPEED
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if (Input.is_action_pressed("shoot")):
		var projectile = _projectile.instantiate()
		get_tree().root.add_child(projectile)
		print("shot")
		projectile.SetPosition($Marker2D.position)
		
