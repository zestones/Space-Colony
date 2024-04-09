extends Area2D



@export var SPEED : float = 1150.0

func _ready():
	rotation = atan2(get_local_mouse_position().y, get_local_mouse_position().x)

func _process(delta):
	var direction = Vector2(cos(rotation), sin(rotation))
	position += direction * SPEED * delta


func _on_body_entered(body):
	if not body.is_in_group("Player"):
		if body.is_in_group("Dammagable"):
			body.HP -= 10
		queue_free()
