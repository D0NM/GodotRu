#для канала Уроки GODOT для всех https://www.youtube.com/@GODOTru

extends CharacterBody2D

@export var player : Node2D
@onready var nav := $NavigationAgent2D as NavigationAgent2D

const SPEED = 4500.0

func _physics_process(delta):
	var direction = to_local(nav.get_next_path_position()).normalized()
	velocity.x = SPEED * delta * direction.x
	velocity.y = SPEED * delta * direction.y
	move_and_slide()


func _on_timer_timeout():
	nav.target_position = player.global_position
