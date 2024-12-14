extends CharacterBody2D

class_name Enemy

@onready var ball: Ball = %Ball

const SPEED = 1000.0

func _ready() -> void:
	if !ball:
		ball = get_parent().get_node('Ball')

func _physics_process(delta: float) -> void:
	if !ball:
		ball = get_parent().get_node('Ball')
		return
		
	var direction = global_position.direction_to(ball.position)
	velocity.y += direction.y * delta * SPEED
	move_and_slide()
