extends Area2D


var velocity = Vector2.ZERO
var direction = Vector2(1,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity += direction * 500 * delta
	position += direction * 500 * delta



func _on_body_entered(body):
	if body.is_in_group("Damagable"):
		body.HP -= 10
	if not body.is_in_group("Player"):
		queue_free()
