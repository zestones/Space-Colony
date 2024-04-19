extends Area2D

var lifespan = 10;
@export var speed : int = 1000;

func _ready():
	rotation = atan2(get_local_mouse_position().y, get_local_mouse_position().x);

func _process(delta):
	var direction = Vector2(cos(rotation), sin(rotation));
	position += direction * speed * delta;
	lifespan -= delta;
	
	if lifespan <= 0:
		queue_free();
