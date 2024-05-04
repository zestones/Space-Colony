extends CharacterBody2D

var Hp = 100
const SPEED = 230.0
@export var Targets : Array[Area2D]
var InstanceTarget
@onready var animator = $Graphics/AnimationPlayer
var CanAttack = true
var obj

func _ready():
	InstanceTarget = Targets.pick_random()


func _physics_process(delta):
	if Hp <= 0:
		$Killed.play()
		await $Killed.finished
		queue_free()
	if InstanceTarget != null:
		var distance = InstanceTarget.global_position - global_position
		velocity.x = (distance.normalized() * SPEED).x
	else:
		queue_free()
		
	if obj != null and CanAttack:
		obj.animator.play("Hit")
		if obj.Hp >= 0.1:
			if obj.is_in_group("Player"):
				obj.get_node("HitEffect").play()
			obj.Hp -= obj.Dammage
			CanAttack = false
		
	move_and_slide()





func _on_detector_body_entered(body):

	if body.is_in_group("Dammagable"):
		obj = body
		$AttackRate.start()
		
func _on_detector_body_exited(body):
	if body.is_in_group("Dammagable"):
		obj = null
		$AttackRate.stop()
		
func _on_attack_rate_timeout():
	CanAttack = true




func _on_detector_area_entered(body):

	if body.is_in_group("Dammagable"):
		obj = body
		$AttackRate.start()


func _on_detector_area_exited(body):
	if body.is_in_group("Dammagable"):
		obj = null
		$AttackRate.stop()
