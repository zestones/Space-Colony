extends Area2D

var queue = []
var CurrentTarget = 0
var CanShoot = false
const BULLET = preload("res://src/Combat/Bullet/bullet.tscn")
@onready var spawner = $Graphics/Head/Spawner
var player
var activated = false
@export var Spawner : Node2D
@onready var animator = $Graphics/AnimationPlayer
@export var Index : int
@export var Hp: int = 100
@export var BatteryCapacity: int = 100
@export var batteryPerShot: int = 2
@export var Dammage: float = 0.2

func _process(delta):
	$Battery.value = BatteryCapacity
	$Health.value = Hp
	$Graphics/Head/VSlider.value = BatteryCapacity
	if Hp <= 0 and activated:
		$Graphics/AnimationPlayer.play("Death")
		activated = false
		
	if queue.size() > 0 and activated:
		$Graphics/Head.look_at(queue[CurrentTarget].global_position)
		$Graphics/Head.global_rotation += deg_to_rad(180)
		$Graphics/Head.global_rotation = clampf($Graphics/Head.global_rotation,deg_to_rad(-40),deg_to_rad(40))
		if rad_to_deg($Graphics/Head.global_rotation) > -40:
			if CanShoot and BatteryCapacity > 0:
				Shoot()
				CanShoot = false
		else:
			CanShoot = false
	else:
		$Graphics/Head.global_rotation = 0
		
	if is_instance_valid(Spawner):
		if not Spawner.Finished:
			$Border/Collider.disabled = false
		else:
			$Border/Collider.disabled = true
	else:
		$Border/Collider.disabled = true
		
	if player != null:
		if abs(player.global_position - global_position).length() < 300:
			
			"""
			TEMP CODE
			"""
			#if Index < 4:
				#player.CurrentObjective = 1
				#player.Update_Objective()
			#else:
				#player.CurrentObjective = 2
				#player.Update_Objective()
			
			if BatteryCapacity > 0:
				$TextPopUp/RichTextLabel.text = "E to Enable"
				$TextPopUp.visible = true
				if Input.is_action_just_pressed("Interact"):
					$EnabledEffect.play()
					if is_instance_valid(Spawner):
						Spawner.paused = false
					$TextPopUp/ColorRect.color = Color(0.098, 0.812, 0.584)
					$TextPopUp/RichTextLabel.text = "Tower Enabled"
					activated = true
			else:
				$TextPopUp/ColorRect.color = Color(0.776, 0.545, 0.871)
				$TextPopUp/RichTextLabel.text = "E to Recharge"
				$TextPopUp.visible = true
				if Input.is_action_just_pressed("Interact"):
					$EnabledEffect.play()
					BatteryCapacity = 100
					$TextPopUp/ColorRect.color = Color(0.098, 0.812, 0.584)
					$TextPopUp/RichTextLabel.text = "Tower Enabled"
					BatteryCapacity = 100
		else:
			$TextPopUp.visible = false
		

		
func Shoot():
	$Graphics/AnimationPlayer.play("Shot")
	$ShootEffect.play()
	BatteryCapacity -= batteryPerShot
	var bullet = BULLET.instantiate()
	get_tree().root.add_child(bullet)
	bullet.Dammage = 50
	bullet.global_position = spawner.global_position
	bullet.rotation = (queue[CurrentTarget].global_position - bullet.global_position).angle()



func _on_range_body_entered(body):
	if body.is_in_group("Alien"):
		queue.append(body)
		
	if body.is_in_group("Player"):
		player = body

		
func _on_range_body_exited(body):
	if body.is_in_group("Alien"):
		queue.erase(body)
	if body.is_in_group("Player"):
		$TextPopUp.visible = true


func _on_shoot_rate_timeout():
	CanShoot = true


func _on_player_detector_body_entered(body):
	if body.is_in_group("Player"):
		if is_instance_valid(Spawner):
			if not Spawner.Finished:
				animator.play("WaveToExit")
		else:
			animator.play("WaveToExit")
