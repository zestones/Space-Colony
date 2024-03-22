extends CharacterBody2D

#Stats
@export var MoveSpeed = 3.0
@export var JumpDistance : float = 50.0
@export var JumpHeight : float = 80.0
@export var AlertDistance : float = 48.0
@export var AlertRadius : float = 8.0
@export var Linear : bool = false
@export var FollowOnSight : bool = true
@export var LOS : float = 100
@export var UseGravity : bool = true
@export var MoveBlind : bool
@export var Path : PathFollow2D
#References
@onready var ground_detectors = $AI/GroundDetector
@onready var jump_detectors = $AI/GroundDetector/JumpDetector
@onready var eyes = $AI/Eyes
@onready var detector = $RangeDetector/Detector
@onready var animator = $Graphics/Animator

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum states {
	Patrol,
	GoTo,
	Attack
}
var STATE = states.Patrol
@export var Player : CharacterBody2D
var direction = 1

var Stoppers : Array
var Eyes : Array
var Jumpers : Array
func _ready():

	detector.scale.x = AlertRadius
	detector.scale.y = AlertRadius
	Eyes = eyes.get_children()
	Stoppers = ground_detectors.get_children()
	Jumpers = jump_detectors.get_children()
	#Eye Raycasts
	Eyes[0].target_position.x = LOS
	Eyes[1].target_position.x = -LOS

	
	
	#Ground Detectors
	Stoppers[0].position.x = -AlertDistance
	Stoppers[1].position.x = AlertDistance


	
	#Jump Detectors
	Jumpers[0].target_position.x = -JumpDistance
	Jumpers[1].target_position.x = JumpDistance


func _process(delta):
	
	if not is_on_floor() and UseGravity:
		velocity.y += gravity * delta
	
	if STATE == states.Patrol:
		if MoveBlind:
			if Path.progress_ratio >= 0.8:
				direction = -1
			if Path.progress_ratio <= 0.2:
				direction = 1
			Path.progress_ratio += direction * (MoveSpeed / 200)
			animator.play("Walk")
			if Eyes[0].is_colliding():
				if str(Eyes[0].get_collider()).split(":")[0] == "Player":

					STATE = states.GoTo
			if Eyes[1].is_colliding():
				if str(Eyes[1].get_collider()).split(":")[0] == "Player":
					STATE = states.GoTo
			
					
	if STATE == states.GoTo:
		var target = Player.global_position
		global_position.x = move_toward(global_position.x,target.x,MoveSpeed * 10)
		
	if STATE == states.Attack:
		#Player.Hp -= 10
		pass
	print(STATE)
	move_and_slide()
