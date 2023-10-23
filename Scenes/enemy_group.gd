extends Node2D
@export var MobScene: PackedScene
@export var padding = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	## Arrange the mobs in an array
	for i in range(4):
		
		for j in range(11):
			#Create a new instance of the mob
			var mob = MobScene.instantiate()
			
			#Create a column of mobs
			mob.position = Vector2(i*(8*6 + 6*padding), -j * (6*6 + 6*padding))
			print(mob.position)
			add_child(mob)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


