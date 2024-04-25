extends CharacterBody2D

#Declair Vars
#Movement
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#Player Stats
@export var Hp: int = 10

#Physics
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#References
@onready var Camera = $Camera2D
@onready var player = $Player
@export var Inventory : UniversalInventory


#Preload bullet scene/prefab
const BULLET = preload("res://src/Combat/Bullet/bullet.tscn")


#Reference to the world[root node] and location of the bullet spawner
@onready var world = $".."

@onready var bullet_spawner = $bulletSpawner
@onready var animator = $AnimationPlayer

#This variable is used to define is the player is allowed to move or not
var UnderControl = true

var Dammage = 0.12
var currrentDirection = 1
func _physics_process(delta):

	#Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	$HUD/UI/Hp.value = Hp
	if Hp < 1:
		#Stop the player from moving
		UnderControl = false
		$Transitioner.Transition()
		
	
	#Check if the player is alowed to control their character
	if UnderControl:
		#Allow the player to jump and wall jump
		if is_on_floor() or is_on_wall():
			if  Input.is_action_just_pressed("Up"):
				$JumpEffect.play()
				velocity.y = JUMP_VELOCITY
				
		#Check if the player is shooting		
		if Input.is_action_just_pressed("Fire"):
			#Instantiate and shoot the bullet
			var bullet = BULLET.instantiate()
			bullet.position = bullet_spawner.global_position
			bullet.target = get_global_mouse_position()
			get_tree().root.add_child(bullet)
			$ShootEffect.play()
			

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

