extends Node2D

@export var next_scene : String

var is_exit_open
var y
var time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	y = $ConfirmExit.position.y
	is_exit_open = false
	$ConfirmExit.disabled = true
	$ConfirmExit.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	$ConfirmExit.position.y = y + sin(time*20) * 20

# игрок подошел к двери
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	is_exit_open = true
	$ConfirmExit.disabled = false
	$ConfirmExit.show()

# игрок отошел от двери
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		return
	is_exit_open = false
	$ConfirmExit.disabled = true
	$ConfirmExit.hide()

# по нажатии мышкой на кнопку подтверждения
func _on_confirm_exit_pressed() -> void:
	get_tree().change_scene_to_file(next_scene)
