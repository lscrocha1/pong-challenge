extends CharacterBody2D

class_name Ball

const SPEED = 25.0

var last_score_made_by_player = false

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:	
	_set_starter_direction()
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta * SPEED)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		audio_stream_player_2d.play()
		
func _set_starter_direction() -> void:	
	var direction = 1
	
	if last_score_made_by_player:
		direction = -1
	
	velocity.x = direction * SPEED

func set_last_goal_maker(made_by_player: bool) -> void:
	last_score_made_by_player = made_by_player
