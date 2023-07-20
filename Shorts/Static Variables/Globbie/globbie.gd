#для канала Уроки GODOT для всех https://www.youtube.com/@GODOTru
extends CharacterBody2D
const SPEED = 4500.0

func _start():
	$Label.text = str( PlayerVariables.number_of_globbies )

func _physics_process(delta):
	if randf() < 0.01:
		velocity.y = SPEED * delta * randf_range(-1.0, 1.0)
	if randf() < 0.01:
		velocity.x = SPEED * delta * randf_range(-1.0, 1.0)
	if position.x < 0 || position.x > 500 || \
		position.y < 0 || position.y > 500:
		queue_free()
	$Label.text = str( PlayerVariables.number_of_globbies )
	move_and_slide()

func _enter_tree():
	PlayerVariables.number_of_globbies += 1

func _exit_tree():
	PlayerVariables.number_of_globbies -= 1

func _on_area_2d_body_entered(body):
	if body != self:
		queue_free()
