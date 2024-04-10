extends CharacterBody2D

var bulletID = preload ("res://src/Player/Spaceship/Bullet/bullet.tscn");
@onready var anim = get_node("AnimatedSprite2D");
## The maximum speed that the spaceship can move.
@export var maxSpeed: int = 200;
## The amount that the spaceship will speed up by in one second.
@export var acceleration: int = 100;
## The speed of your spaceship while boosting.
@export var boostSpeed = 350;
## How fast the spaceship adjusts its angle (in degrees).
@export var rotationalSpeed: int = 360;
## The amount that the spaceship will slow down by in one second when not given any input.
@export var inertia: int = 200;
## Whether or not the spaceship flies towards the cursor.
@export var targetMouse: bool = true;
## How many bullets can be fired per second
@export var rateOfFire: int = 4;

var speed = 0;
var direction = Vector2.ZERO;
var cooldown = 0;

func _process(delta):
	var input = Input.get_vector("Left", "Right", "Up", "Down").normalized();
	if targetMouse:
		direction = get_local_mouse_position().normalized();
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
		
	if input != Vector2.ZERO&&Input.get_action_strength("Sprint") > 0:
		speed = boostSpeed;
	
	anim.rotation = get_local_mouse_position().angle();
	velocity = direction * speed;
	
	if cooldown > 0:
		cooldown -= delta;
	
	if Input.is_action_pressed("Fire")&&cooldown <= 0:
		var bullet = bulletID.instantiate();
		bullet.position = position;
		get_parent().add_child(bullet);
		cooldown = 1.0 / rateOfFire;
	
	move_and_slide();
	animate(input);

func animate(input):
	if input == Vector2.ZERO||(targetMouse&&input.y >= 0):
		anim.play("Idle");
	else:
		anim.play("Moving");
