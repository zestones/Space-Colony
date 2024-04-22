extends CharacterBody2D

var Hp = 100
const SPEED = 230.0
@export var Targets : Array[CharacterBody2D]
var InstanceTarget
@onready var animator = $Graphics/AnimationPlayer

func _ready():
	InstanceTarget = Targets.pick_random()


func _physics_process(delta):
	if Hp <= 0:
		queue_free()
	if InstanceTarget != null:
		var distance = InstanceTarget.global_position - global_position
		velocity.x = (distance.normalized() * SPEED).x
	else:
		queue_free()
		
	move_and_slide()


func _on_detector_area_entered(area):
	if area.is_in_group("Tower"):
		area.get_parent().Hp -= 1
