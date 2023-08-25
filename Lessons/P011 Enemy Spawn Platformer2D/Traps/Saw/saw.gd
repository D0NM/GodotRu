extends CharacterBody2D

@export var speed : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = speed
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not move_and_slide():
		velocity.x = -velocity.x
		#velocity.y = -velocity.y
