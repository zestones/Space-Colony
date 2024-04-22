extends Control


func _input(event):
	if event.is_action_pressed("Interact"):
		print("Switch flipped")
		$ActivateBtn.frame = not $ActivateBtn.frame
