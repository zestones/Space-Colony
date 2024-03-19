extends CharacterBody2D

var direction = Vector2(cos(rotation), sin(rotation));
var bulletID = preload ("res://src/Player/Spaceship/Bullet/bullet.tscn");
#var linear_velocity = Vector2.ZERO;
var angular_velocity = 0;

func _process(delta):
	direction = Vector2(cos(rotation), sin(rotation));
	var input = Input.get_vector("Left", "Right", "Down", "Up").normalized(); # Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Down", "Up"));

	if get_meta("uniformRotation"):
		angular_velocity = input.x * get_meta("maxRotationalSpeed");
	else:
		angular_velocity += input.x * get_meta("rotationalAcceleration") * delta;

	if get_meta("uniformMovement"):
		velocity = direction * input.y * get_meta("maxSpeed");
	else:
		velocity += direction * input.y * get_meta("acceleration") * delta;

	angular_velocity = clampf(angular_velocity, -get_meta("maxRotationalSpeed"), get_meta("maxRotationalSpeed"));
	if velocity.length() > get_meta("maxSpeed"):
		velocity = velocity.limit_length(get_meta("maxSpeed"));

	if Input.is_action_just_pressed("Fire"):
		var bullet = bulletID.instantiate();
		bullet.position = position;
		get_parent().add_child(bullet);
	
	move_and_slide();
	rotate(deg_to_rad(angular_velocity) * delta);