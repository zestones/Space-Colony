extends Area2D

var lifespan = 10;
var target : Vector2

func _ready():
	rotation = (target - global_position).angle()

func _process(delta):
	var direction = Vector2(cos(rotation), sin(rotation));
	position += direction * 450 * delta;
	lifespan -= delta;
	
	if lifespan <= 0:
		queue_free();


func _on_body_entered(body):
	if not body.is_in_group("Tower"):
		if body.is_in_group("Alien"):
			body.Hp -= 25
		queue_free()
