extends CharacterBody2D

class_name Player

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	_move_player(delta)
	
func _move_player(delta: float) -> void:
	var direction = get_viewport().get_mouse_position() - self.position
	velocity = direction * delta * SPEED
	move_and_slide()
