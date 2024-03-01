extends Area2D

var lifespan = 10;

func _ready():
	if get_meta("targetCursor"):
		rotation = atan2(get_local_mouse_position().y, get_local_mouse_position().x);
		#print_debug(get_global_mouse_position());

func _process(delta):
	var direction = Vector2(cos(rotation), sin(rotation));
	position += direction * get_meta("speed") * delta;
	lifespan -= delta;
	if lifespan <= 0:
		queue_free();
