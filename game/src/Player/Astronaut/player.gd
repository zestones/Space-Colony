extends CharacterBody2D

#Declair Vars
#Movement
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

#Player Stats
@export var Hp: int = 10
var CanShoot = false

#Physics
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#References
@onready var Camera = $Camera2D
@onready var player = $Player/Body
@export var Inventory : UniversalInventory


#Preload bullet scene/prefab
const BULLET = preload("res://src/Combat/Bullet/bullet.tscn")


#Reference to the world[root node] and location of the bullet spawner
@onready var world = $".."

@onready var bullet_spawner = $bulletSpawner
@onready var animator = $AnimationPlayer

#This variable is used to define is the player is allowed to move or not
var UnderControl = true

var Dammage = 1
var currrentDirection = 1
var KillScore = 0
var CurrentObjective = 0
var Objectives = [
	"Get to the Tower to your right !",
	"Kill All Enemies !!!",
	"Get into Space !"
]

func _ready():
	Update_Objective()

func Update_Objective():
	$HUD/UI/ObjectiveSys/Objective.text = Objectives[CurrentObjective]
	
	
func _physics_process(delta):

	#Gravity
	if not is_on_floor():
		$AnimationPlayer.play("Jump")
		velocity.y += gravity * delta
		
	if $Gun.visible:
		$Gun.look_at(get_global_mouse_position())
		if get_global_mouse_position().x > global_position.x:
			$Gun.flip_h = false
			$Gun.flip_v = false
		if get_global_mouse_position().x < global_position.x:
			$Gun.flip_v = true
			$Gun.flip_h = false
		
	
	$HUD/UI/Hp.value = Hp
	$HUD/UI/KillLable.text = "Attack Points : " + str(round(KillScore))
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
		if Input.is_action_just_pressed("Fire") and CanShoot:
			#Instantiate and shoot the bullet
			var bullet = BULLET.instantiate()
			bullet.Owner = self
			bullet.position = bullet_spawner.global_position
			bullet.target = get_global_mouse_position()
			get_tree().root.add_child(bullet)
			$ShootEffect.play()
			CanShoot = false

		#Player Movement
		var direction = Input.get_axis("Left", "Right")
		if direction:
			$Gun.show()
			$AnimationPlayer.play("Walk")
			velocity.x = direction * SPEED
			if direction > 0:
				currrentDirection = 1
				player.flip_h = false
			if direction < 0: 
				currrentDirection = -1
				player.flip_h = true
		else:
			$AnimationPlayer.play("Idle")
			$Gun.hide()
			velocity.x = move_toward(velocity.x, 0, SPEED)

	
	#If the player has stopped / they are now allowed to control the sprite, slow it down and play the idle animation
	else:
		$Gun.hide()
		$AnimationPlayer.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)


	move_and_slide()



func _on_shoot_rate_timeout():
	CanShoot = true


func _on_settings_pressed():
	UnderControl = false
	$HUD/Settings_Screen.visible = true


func _on_animation_player_animation_finished(anim_name):
	print(anim_name)
