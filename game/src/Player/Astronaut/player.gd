extends CharacterBody2D

#Declair Vars
#Movement
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#Player Stats
var Hp = 100

#Physics
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#References
@onready var Camera = $Camera2D
@onready var player = $Player

#Preload bullet scene/prefab
const BULLET = preload("res://src/Player/Astronaut/Bullet/bullet.tscn")

#Reference to the world[root node] and location of the bullet spawner
@onready var world = $".."

@onready var bullet_spawner = $bulletSpawner

#This variable is used to define is the player is allowed to move or not
var UnderControl = true

func _ready():
	pass

var currrentDirection = 1
func _physics_process(delta):

	#Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	

	if Hp <= 0:
		#Stop the player from moving
		UnderControl = false
		
	
	#Check if the player is alowed to control their character
	if UnderControl:
		#Allow the player to jump and wall jump
		if is_on_floor() or is_on_wall():
			if Input.is_action_just_pressed("Jump") or Input.is_action_just_pressed("Up"):
				velocity.y = JUMP_VELOCITY
				
		#Check if the player is shooting		
		if Input.is_action_just_pressed("Fire"):
			#Instantiate and shoot the bullet
			var bullet = BULLET.instantiate()
			bullet.position = bullet_spawner.global_position
			get_tree().root.add_child(bullet)
			

		#Player Movement
		var direction = Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
			if direction > 0:
				currrentDirection = 1
				player.flip_v = false
			if direction < 0: 
				currrentDirection = -1
				player.flip_v = true
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	
	#If the player has stopped / they are now allowed to control the sprite, slow it down and play the idle animation
	else:
			velocity.x = move_toward(velocity.x, 0, SPEED)


	move_and_slide()

