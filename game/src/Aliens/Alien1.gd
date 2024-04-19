extends CharacterBody2D

var Hp = 100
const SPEED = 230.0
@export var Targets : Array[CharacterBody2D]
var InstanceTarget

func _ready():
	InstanceTarget = Targets.pick_random()

func _physics_process(delta):
	if Hp <= 0:
		queue_free()
	var distance = InstanceTarget.global_position - global_position
	velocity.x = (distance.normalized() * SPEED).x
		
	move_and_slide()
