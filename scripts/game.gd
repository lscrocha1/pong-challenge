extends Node2D

class_name Game

var ai_score = 0
var player_score = 0

@onready var ai_score_text: Label = %AiScoreText
@onready var player_score_text: Label = %PlayerScoreText
@onready var pause_menu: Control = %PauseMenu
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var ballScene = preload("res://scenes/ball.tscn")
var currentBall: Ball
var is_player_score = true

func _ready() -> void:
	_restart_ball(false)
	
func _process(delta: float) -> void:
	_check_should_show_pause_menu()
	
func _check_should_show_pause_menu() -> void:
	if !Input.is_action_just_pressed("esc"):
		return
		
	if get_tree().paused:
		_continue_game()
		return
	
	get_tree().paused = true
	pause_menu.visible = true

func _on_ball_enter_player_goal(ball: Ball) -> void:
	ai_score += 1;
	ai_score_text.text = str(ai_score)
	is_player_score = false
	_restart_ball(true)

func _restart_ball(restart_ball: bool) -> void:
	audio_stream_player_2d.play()
	
	if restart_ball and currentBall:
		currentBall.queue_free()
	
	currentBall = ballScene.instantiate()

	var viewport_size = get_viewport_rect().size;
	currentBall.position.x = viewport_size.x / 2
	currentBall.position.y = viewport_size.y / 2
	currentBall.set_last_goal_maker(!is_player_score)
	add_child(currentBall)

func _on_ball_enter_ai_goal(body: Node2D) -> void:
	player_score += 1;
	player_score_text.text = str(player_score)
	is_player_score = true
	_restart_ball(true)

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_continue_button_pressed() -> void:
	_continue_game()
	
func _continue_game() -> void:
	get_tree().paused = false
	pause_menu.visible = false
