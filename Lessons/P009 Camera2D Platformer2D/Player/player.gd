extends CharacterBody2D

@export var tilemap : TileMap

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

# берет значение гравитации из настроек проекта
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	var r = tilemap.get_used_rect()
	var vp = tilemap.get_viewport_rect()
	var qs = tilemap.cell_quadrant_size
	$Camera2D.limit_left = r.position.x * qs
	$Camera2D.limit_top = r.position.y * qs
	$Camera2D.limit_right = $Camera2D.limit_left + r.size.x * qs
	$Camera2D.limit_bottom = $Camera2D.limit_top + r.size.y * qs
	$Camera2D.limit_top = min($Camera2D.limit_top, $Camera2D.limit_bottom - vp.size.y)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	update_animation()
	move_and_slide()
	if position.y > 480:
		on_death()
	
func update_animation():
	if velocity.x < 0:
		anim.flip_h = true
	elif velocity.x > 0:
		anim.flip_h = false
	if velocity.x:
		anim.play("Run")
	else:
		anim.play("Idle")
	if velocity.y < 0:
		anim.play("Jump")
	elif velocity.y > 0:
		anim.play("Fall")
		
func on_death():
	get_tree().change_scene_to_file("res://Menus/game_over.tscn")
	queue_free()

func _on_pickup_area_entered(area: Area2D) -> void:
	if area.has_method("on_pickup"):
		area.on_pickup(self)
