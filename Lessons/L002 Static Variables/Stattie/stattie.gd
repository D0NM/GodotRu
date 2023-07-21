#для канала Уроки GODOT для всех https://www.youtube.com/@GODOTru
extends CharacterBody2D
const SPEED = 4500.0
# статические переменные ОБЩИЕ на все экземпляры (инстансы)
static var number_of_statties := 0

func _physics_process(delta):
	if randf() < 0.01:
		velocity.y = SPEED * delta * randf_range(-1.0, 1.0)
	if randf() < 0.01:
		velocity.x = SPEED * delta * randf_range(-1.0, 1.0)
	if position.x < 0 || position.x > 500 || \
		position.y < 0 || position.y > 500:
		queue_free()
	$Label.text = str( number_of_statties )
	move_and_slide()

func _enter_tree():
	number_of_statties += 1

func _exit_tree():
	number_of_statties -= 1

func _on_area_2d_body_entered(body):
	if body != self:
		queue_free()

