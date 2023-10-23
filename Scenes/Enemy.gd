extends Area2D
var width
var height

# Called when the node enters the scene tree for the first time.
func _ready():
	width = get_node("CollisionShape2D").shape.get_size()[0]
	height = get_node("CollisionShape2D").shape.get_size()[1]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	if area.name == "Projectile":
		area.queue_free()
		queue_free()
