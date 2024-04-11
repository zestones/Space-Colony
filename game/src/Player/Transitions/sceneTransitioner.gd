extends Control

@export_file("*.tscn") var Scene : String
func Transition():
	$Cutscenes.play("Fade")
	
	

func _on_cutscenes_animation_finished(anim_name):
	if Scene != null:
		get_tree().change_scene_to_file(Scene)


