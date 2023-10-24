extends Node2D
@export var MobScene: PackedScene

#Spawner Configuration
const ROWS = 11
const COLUMNS = 4
const HORIZONTAL_SPACING = 50
const VERTICAL_SPACING = 32
const ENEMY_HEIGHT = 8
const START_Y_POSITION = 0
const ENEMY_X_INCREMENT = 5
const ENEMY_Y_INCREMENT = 10

var enemy_count = COLUMNS*ROWS
var movement_direction = 1
var time_decrement

# Called when the node enters the scene tree for the first time.
func _ready():
#	## Arrange the mobs in an array
	var enemy = MobScene.instantiate() as Enemy
	for row in ROWS:
		var row_width = (COLUMNS * enemy.width * 3) + ((COLUMNS-1)*HORIZONTAL_SPACING)
		var start_x = (position.x - row_width)
	
		for col in COLUMNS:
			var x = start_x + (col * enemy.width * 3) + (col * HORIZONTAL_SPACING)
			var y = START_Y_POSITION + (row * enemy.height) + (row * VERTICAL_SPACING)
			
			var spawn_position = Vector2(x, y)
			enemy.position = spawn_position
			print(enemy.position)
			spawn_enemy(enemy, spawn_position)
	
	$MovementTimer.start()
	$MovementTimer.connect("timeout", move_enemies)
	time_decrement = $MovementTimer.wait_time/enemy_count

#Spawn Enemy Function
func spawn_enemy(enemy_scene, spawn_position: Vector2):
	var enemy = MobScene.instantiate() as Enemy
	enemy.position = spawn_position
	add_child(enemy)
	enemy.connect("died", _on_enemy_died)
	print(enemy.position)

func move_enemies():
	position.x += ENEMY_X_INCREMENT*movement_direction

func _on_wall_left_area_entered(area):
	if (movement_direction == -1):
		position.y += ENEMY_Y_INCREMENT
		movement_direction = -1 * movement_direction

func _on_wall_right_area_entered(area):
	if (movement_direction == 1):
		position.y += ENEMY_Y_INCREMENT
		movement_direction = -1 * movement_direction

func _on_enemy_died():
	print("died")
	enemy_count -= 1
	$MovementTimer.wait_time -= time_decrement

func _process(delta):
	print(str($MovementTimer.wait_time))

