extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var inventory : UniversalInventory
var InHand : UniversalItem
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player_anims = $PlayerAnims
@onready var player = $Player
const BULLET = preload("res://game/src/Player/Ground/bullet/bullet.tscn")

@onready var world = $".."
@onready var bullet_spawner = $Player/BulletSpawner

func _ready():
	InHand = inventory.Items[0]

var UnderControl = true

var currrentDirection = 1
func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta

	if UnderControl:
		if is_on_floor() or is_on_wall():
			if Input.is_action_just_pressed("Jump"):
				velocity.y = JUMP_VELOCITY
				
		if Input.is_action_just_pressed("Fire"):
			print("Shoot")
			var bullet = BULLET.instantiate()
			bullet.position = bullet_spawner.global_position
			$"..".add_child(bullet)
			bullet.direction.x = currrentDirection
			


		var direction = Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
			player_anims.play("Walk")
			if direction > 0:
				currrentDirection = 1
				player.flip_h = false
			if direction < 0: 
				currrentDirection = -1
				player.flip_h = true
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			player_anims.play("Idle")
	else:
			print(InHand.Name)
			velocity.x = move_toward(velocity.x, 0, SPEED)
			player_anims.play("Idle")

	move_and_slide()
