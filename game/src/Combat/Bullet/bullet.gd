extends Area2D

var lifespan = 10;
@export var speed : int = 600;
var target : Vector2
var Dammage : int = 50
var Owner
func _ready():
	target = to_local(target)
	rotation = atan2(target.y,target.x)


func _process(delta):
	var direction = Vector2(cos(rotation), sin(rotation))
	position += direction * speed * delta;
	lifespan -= delta;
	
	if lifespan <= 0:
		queue_free();
	

func _on_body_entered(body):
	if body.is_in_group("Alien"):
		if Owner != null :
			if Owner.is_in_group("Player"):
				Owner.KillScore += 0.5
		body.Hp -= Dammage
		body.animator.play("Hurt")
		$Hit.play()
		await $Hit.finished 
		queue_free()
	elif not body.is_in_group("Player"):
		queue_free()
