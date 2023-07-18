#для канала Уроки GODOT для всех https://www.youtube.com/@GODOTru

extends CharacterBody2D

const SPEED = 5000.0
var direction: Vector2

func _physics_process(delta):
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	velocity = direction * SPEED * delta
	move_and_slide()
