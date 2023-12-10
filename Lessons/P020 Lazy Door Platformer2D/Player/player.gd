extends CharacterBody2D

var tilemap_for_camera : TileMap

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var cam = $Camera2D as Camera2D
var has_key : bool = false
var has_double_jump : bool = false
var can_double_jump : bool = false

# берет значение гравитации из настроек проекта
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	tilemap_for_camera = get_parent().find_child("TileMap")
	var r = tilemap_for_camera.get_used_rect()
	var vp = tilemap_for_camera.get_viewport_rect()
	var qs = tilemap_for_camera.cell_quadrant_size
	cam.limit_left = r.position.x * qs
	cam.limit_top = r.position.y * qs
	cam.limit_right = r.end.x * qs
	cam.limit_bottom = r.end.y * qs
	cam.limit_top = min(r.position.y, r.end.y - vp.size.y)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			can_double_jump = true
			velocity.y = JUMP_VELOCITY
		if not is_on_floor() and has_double_jump and can_double_jump:
			can_double_jump = false
			velocity.y = JUMP_VELOCITY * 0.95

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
