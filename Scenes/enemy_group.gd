extends Node2D
@export var MobScene: PackedScene

#Spawner Configuration
const ROWS = 4
const COLUMNS = 11
const HORIZONTAL_SPACING = 50
const VERTICAL_SPACING = 32
const ENEMY_HEIGHT = 8
const START_Y_POSITION = 0
const ENEMY_X_INCREMENT = 5
const ENEMY_Y_INCREMENT = 10

#Variable declaration
var enemy_count = COLUMNS*ROWS
var movement_direction = 1
var time_decrement
var initial_movement_wait_timer

#Signals
signal enemy_died
signal all_enemies_dead

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
func BeginSpawn():
	var enemy = MobScene.instantiate() as Enemy
	for row in ROWS:
		var row_width = (COLUMNS * enemy.width * 3) + ((COLUMNS-1)*HORIZONTAL_SPACING)
		var start_x = (position.x - row_width)
	
		for col in COLUMNS:
			var x = start_x + (col * enemy.width * 3) + (col * HORIZONTAL_SPACING)
			var y = START_Y_POSITION + (row * enemy.height) + (row * VERTICAL_SPACING)
			
			var spawn_position = Vector2(x, y)
			enemy.position = spawn_position
			spawn_enemy(enemy, spawn_position)
	
	$MovementTimer.start()
	initial_movement_wait_timer = $MovementTimer.wait_time
	$MovementTimer.connect("timeout", move_enemies)
	time_decrement = $MovementTimer.wait_time/enemy_count

func start(pos):
	enemy_count = COLUMNS*ROWS
	position = pos
	show()
	BeginSpawn()

#Spawn Enemy Function
func spawn_enemy(enemy_scene, spawn_position: Vector2):
	var enemy = MobScene.instantiate() as Enemy
	enemy.position = spawn_position
	add_child(enemy)
	enemy.connect("died", _on_enemy_died)

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

func _on_enemy_died(points):
	enemy_count -= 1
	$MovementTimer.wait_time -= time_decrement
	enemy_died.emit(points)
	if enemy_count == 0: ##Better here than on _process to avoid comparisons in each frame!
		reset_move_timer()
		all_enemies_dead.emit()

func _process(delta):
	pass

func _on_gameover():
	reset_move_timer()
	hide()
	get_tree().call_group("Enemies", "queue_free")

func reset_move_timer():
	$MovementTimer.wait_time = initial_movement_wait_timer
