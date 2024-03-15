extends RigidBody2D

var direction = Vector2(cos(rotation), sin(rotation));
var bulletID = preload("res://game/src/Player/Spaceship/Bullet/bullet.tscn");


func _process(delta):
	direction = Vector2(cos(rotation), sin(rotation));
	var input = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Down", "Up"));
	
	if get_meta("uniformRotation"):
		angular_velocity = input.x * get_meta("maxRotationalSpeed") * delta;
	else:
		angular_velocity += input.x * get_meta("rotationalAcceleration") * delta;
	
	if get_meta("uniformMovement"):
		linear_velocity = direction * input.y * get_meta("maxSpeed");
	else:
		apply_force(direction * input.y * get_meta("acceleration"))
	
	angular_velocity = clampf(angular_velocity, -get_meta("maxRotationalSpeed"), get_meta("maxRotationalSpeed"));
	if linear_velocity.length() > get_meta("maxSpeed"):
		linear_velocity = linear_velocity.limit_length(get_meta("maxSpeed"));
	
	if Input.is_action_just_pressed("Fire"):
		var bullet = bulletID.instantiate();
		bullet.position = position;
		get_parent().add_child(bullet);
