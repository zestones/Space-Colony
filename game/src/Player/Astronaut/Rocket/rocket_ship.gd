extends Area2D

var Inrange = false

func _ready():
	$Control.visible = false
	Inrange = false
	
func  _process(delta):
	if Inrange:
		if Input.is_action_just_pressed("Interact"):
			$"../Transitioner".Transition()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$Control.visible = true
		Inrange = true


func _on_body_exited(body):
	if body.is_in_group("Player"):
		$Control.visible = false
		Inrange = false


