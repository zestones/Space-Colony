extends StaticBody2D

var queue = []
var CurrentTarget = 0
var CanShoot = false
const BULLET = preload("res://src/Combat/Bullet/bullet.tscn")
@onready var spawner = $Graphics/Head/Spawner
var player
var activated = false
@export var Spawner : Node2D

func _process(delta):
	if queue.size() > 0 and activated:
		$Graphics/Head.look_at(queue[CurrentTarget].global_position)
		$Graphics/Head.global_rotation += deg_to_rad(180)
		$Graphics/Head.global_rotation = clampf($Graphics/Head.global_rotation,deg_to_rad(-40),deg_to_rad(40))
		if rad_to_deg($Graphics/Head.global_rotation) > -40:
			if CanShoot:
				Shoot()
				CanShoot = false
		else:
			CanShoot = false
	else:
		$Graphics/Head.global_rotation = 0
		
	if player != null:
		if abs(player.global_position - global_position).length() < 300:
			$TextPopUp.visible = true
			if Input.is_action_just_pressed("Interact"):
				Spawner.paused = false
				$TextPopUp/ColorRect.color = Color(0.098, 0.812, 0.584)
				$TextPopUp/RichTextLabel.text = "Tower Enabled"
				print("Tower Activated")
				activated = true
		else:
			$TextPopUp.visible = false
		

		
func Shoot():
	$Graphics/AnimationPlayer.play("Shot")
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
