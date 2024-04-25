extends Control

@export var Scene : int
func Transition():
	$Cutscenes.play("Fade")
	
	

func _on_cutscenes_animation_finished(anim_name):
	if Scene != null:
		get_tree().change_scene_to_packed(GlobalSingleton.LoadScene(Scene))


