extends Area2D

var lifespan = 10;
@export var speed : int = 600;
var target : Vector2

func _ready():
	target = to_local(target)
	rotation = atan2(target.y,target.x)
	print(rotation)

func _process(delta):
	var direction = Vector2(cos(rotation), sin(rotation))
	position += direction * speed * delta;
	lifespan -= delta;
	
	if lifespan <= 0:
		queue_free();
	

func _on_body_entered(body):
	if body.is_in_group("Alien"):
		body.queue_free()
