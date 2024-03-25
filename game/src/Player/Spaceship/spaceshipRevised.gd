extends CharacterBody2D

var bulletID = preload ("res://src/Player/Spaceship/Bullet/bullet.tscn");
@onready var anim = get_node("AnimatedSprite2D");
## The maximum speed that the spaceship can move.
@export var maxSpeed : int = 200;
## The amount that the spaceship will speed up by in one second.
@export var acceleration : int = 100;
## How fast the spaceship adjusts its angle (in degrees).
@export var rotationalSpeed : int = 360;
## The amount that the spaceship will slow down by in one second when not given any input.
@export var inertia : int = 200;
## Whether or not the spaceship flies towards the cursor.
@export var targetMouse : bool = true;

var speed = 0;
var direction = Vector2.ZERO;

func _process(delta):
	var input = Input.get_vector("Left", "Right", "Up", "Down").normalized();
	if targetMouse:
		direction = get_local_mouse_position().normalized();
		anim.rotation = direction.angle();
		speed += acceleration * delta * max(0, -input.y);
		speed = clampi(speed, 0, maxSpeed);
		if input.y >= 0:
			speed = move_toward(speed, 0, inertia * delta);
	elif input != Vector2.ZERO:
		direction = input;
		speed += acceleration * delta;
		speed = clampi(speed, 0, maxSpeed);
	else:
		speed = move_toward(speed, 0, inertia * delta);
	anim.rotation = rotate_toward(anim.rotation, direction.angle(), deg_to_rad(rotationalSpeed) * delta);
	
	velocity = direction * speed;
	
	if Input.is_action_just_pressed("Fire"):
		var bullet = bulletID.instantiate();
		bullet.position = position;
		get_parent().add_child(bullet);
	
	move_and_slide();
	animate(input);

func animate(input):
	if input == Vector2.ZERO || (targetMouse && input.y >= 0):
		anim.play("Idle");
	else:
		anim.play("Moving");
