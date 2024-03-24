extends CharacterBody2D

var bulletID = preload ("res://src/Player/Spaceship/Bullet/bullet.tscn");
@onready var anim = get_node("AnimatedSprite2D");
@export var maxSpeed : int = 200;
@export var acceleration : int = 100;
@export var rotationalSpeed : int = 360;
@export var inertia : int = 200;

var speed = 0;
var direction = Vector2.ZERO;

func _process(delta):
	var input = Input.get_vector("Left", "Right", "Up", "Down").normalized();
	if input != Vector2.ZERO:
		direction = input;
		anim.rotation = rotate_toward(anim.rotation, input.angle(), deg_to_rad(rotationalSpeed) * delta);
		speed += acceleration * delta;
		speed = clampi(speed, 0, maxSpeed);
	else:
		speed = move_toward(speed, 0, inertia * delta);
	
	velocity = direction * speed;
	
	if Input.is_action_just_pressed("Fire"):
		var bullet = bulletID.instantiate();
		bullet.position = position;
		get_parent().add_child(bullet);
	
	move_and_slide();
	animate(input);

func animate(input):
	if input == Vector2.ZERO:
		anim.play("Idle");
	else:
		anim.play("Moving");
