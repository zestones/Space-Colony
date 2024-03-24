extends CharacterBody2D

var direction = Vector2(cos(rotation), sin(rotation));
var bulletID = preload ("res://src/Player/Spaceship/Bullet/bullet.tscn");
var angular_velocity = 0;
@onready var anim = get_node("AnimatedSprite2D");

func _process(delta):
	direction = Vector2(cos(rotation), sin(rotation));
	var input = Input.get_vector("Left", "Right", "Up", "Down").normalized();
	if get_meta("controlledRotation"):
		if get_meta("uniformRotation"):
			angular_velocity = input.x * get_meta("maxRotationalSpeed");
		else:
			angular_velocity += input.x * get_meta("rotationalAcceleration") * delta;
		if get_meta("uniformMovement"):
			velocity = direction * -input.y * get_meta("maxSpeed");
		else:
			velocity += direction * -input.y * get_meta("acceleration") * delta;
	else:
		if input != Vector2.ZERO:
			anim.rotation = rotate_toward(anim.rotation, input.angle(), deg_to_rad(get_meta("maxRotationalSpeed")) * delta);
		if get_meta("uniformMovement"):
			velocity = input * get_meta("maxSpeed");
		else:
			velocity += input * get_meta("acceleration") * delta;
	
	angular_velocity = clampf(angular_velocity, -get_meta("maxRotationalSpeed"), get_meta("maxRotationalSpeed"));
	if velocity.length() > get_meta("maxSpeed"):
		velocity = velocity.limit_length(get_meta("maxSpeed"));
	
	if input.x == 0:
		velocity.x = move_toward(velocity.x, 0, get_meta("drag") * delta);
	if input.y == 0:
		velocity.y = move_toward(velocity.y, 0, get_meta("drag") * delta);
	
	if Input.is_action_just_pressed("Fire"):
		var bullet = bulletID.instantiate();
		bullet.position = position;
		get_parent().add_child(bullet);
	
	move_and_slide();
	rotate(deg_to_rad(angular_velocity) * delta);
	animate(input);

func animate(input):
	if input == Vector2.ZERO:
		anim.play("Idle");
	else:
		anim.play("Moving");
