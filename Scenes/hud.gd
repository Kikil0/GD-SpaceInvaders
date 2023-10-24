extends CanvasLayer
signal start_game
signal stop_music
signal volume_change

# Called when the node enters the scene tree for the first time.
func _ready():
	$Main/ScoreLabel.hide()
	$Main/MessageLabel.hide()
	$Main/GameOver.hide()
	$Main/WinPlayAgainButton.hide()
	$Main/WinTitleScreenButton.hide()
	$Settings.hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## -------# METHODS # -------
func show_game_over():
	$Main/GameOver.show()
	$Main/GameOver/RetryButton.show()
	$Main/GameOver/TitleScreenButton.show()
	
func update_score(score):
	$Main/ScoreLabel.text = "SCORE: " + str(score)

func show_message(message):
	$Main/MessageLabel.text = message
	$Main/MessageLabel.show()

func show_win_screen():
	$Main/WinPlayAgainButton.show()
	$Main/WinTitleScreenButton.show()
	
func hide_win_screen():
	$Main/WinPlayAgainButton.hide()
	$Main/WinTitleScreenButton.hide()
## -------# SIGNALS # -------

func _on_start_game_pressed():
	$TitleScreen.hide()
	$Main/ScoreLabel.show()
	start_game.emit()

func _on_settings_button_pressed():
	$TitleScreen.hide()
	$Settings.show()

func _on_controls_button_pressed():
	$TitleScreen.hide()
	$Controls.show()

func _on_settings_exit_pressed():
	$TitleScreen.show()
	$Settings.hide()
	$Controls.hide()

## -------# GAME OVER SIGNALS # -------
func _on_retry_button_pressed():
	hide_win_screen()
	$Main/GameOver.hide()
	$Main/MessageLabel.hide()
	start_game.emit()

func _on_title_screen_button_pressed():
	hide_win_screen()
	$Main/GameOver.hide()
	$Main/MessageLabel.hide()
	$Main/ScoreLabel.hide()
	$TitleScreen.show()
	stop_music.emit()

func _on_sound_volume_changed(volume):
	volume_change.emit(volume)

func _on_main_init_settings(volume):
	$Settings/VBoxContainer/HBoxSound/HSlider.min_value = volume-20
	$Settings/VBoxContainer/HBoxSound/HSlider.value = volume
	$Settings/VBoxContainer/HBoxSound/HSlider.max_value = volume+10


