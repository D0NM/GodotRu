extends Node2D

@onready var screen_size = get_viewport_rect().size
var direction
var speed

@export_group("Лучи вокруг жабки")
@export_range(0, 500) var rays_n : int = 4
@export_subgroup("Свойства лучей")
@export var rays_rot_speed : float

func _ready():
#	rotation = randf_range(0, 2*PI)
	direction = Vector2.from_angle(rotation)
	speed = randf_range(10, 40)
	
	for i in rays_n:
		var cr = ColorRect.new()
		cr.size = Vector2(2,15)		
		cr.position = Vector2(0,50)
		cr.pivot_offset = Vector2(0,-50)		
		cr.rotation = 0.2 * i
		$Container.add_child(cr)

func _process(delta):
	position = position + direction * speed * delta

	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

	$Container.rotation += rays_rot_speed * delta
	var piece = $Container.get_children()[randi() % $Container.get_child_count()]
	piece.self_modulate = Color.from_hsv(randf(), randf(), randf())
