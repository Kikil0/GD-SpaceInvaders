extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$MessageLabel.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_score(score):
	$ScoreLabel.text = "SCORE: " + str(score)

func show_message(message):
	$MessageLabel.text = message
	$MessageLabel.show()
