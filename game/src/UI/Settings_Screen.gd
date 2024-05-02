extends Control

var Music_Index = AudioServer.get_bus_index("Music")
var SFX_Index = AudioServer.get_bus_index("SFX")
func _ready():
	$Music/HSlider.value = db_to_linear(AudioServer.get_bus_volume_db(Music_Index))
	$Sound/SFX.value = db_to_linear(AudioServer.get_bus_volume_db(SFX_Index))

func _on_exit_btn_pressed():
	get_parent().get_parent().UnderControl = true
	visible = false


func _on_h_slider_value_changed(value):
	var Music_Volume = value
	AudioServer.set_bus_volume_db(Music_Index,linear_to_db(Music_Volume))


func _on_sfx_value_changed(value):
	var SFX_Volume = value
	AudioServer.set_bus_volume_db(SFX_Index,linear_to_db(SFX_Volume))
