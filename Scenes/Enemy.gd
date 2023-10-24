extends Area2D

class_name Enemy
signal died

@export var width : int
@export var height : int

# Timer to delay the queue_free for the enemy
var destroy_timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	
	##Create a Shot Timer
	destroy_timer = Timer.new()
	destroy_timer.one_shot = true
	destroy_timer.wait_time = 0.1
	add_child(destroy_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	if area is Projectile:
		area.queue_free()
		died.emit()
		queue_free()
