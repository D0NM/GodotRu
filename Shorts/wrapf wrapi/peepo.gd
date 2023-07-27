extends Node2D

@onready var screen_size = get_viewport_rect().size
var direction
var speed

func _ready():
	rotation = randf_range(0, 2*PI)
	direction = Vector2.from_angle(rotation)
	speed = randf_range(100, 400)

func _process(delta):
	position = position + direction * speed * delta
	# плохой код
	if position.x > screen_size.x:
		position.x = 0
	if position.x < 0:
		position.x = screen_size.x
	if position.y > screen_size.y:
		position.y = 0
	if position.y < 0:
		position.y = screen_size.y
	# хороший коТ
	#position.x = wrapf(position.x, 0, screen_size.x)
	#position.y = wrapf(position.y, 0, screen_size.y)
