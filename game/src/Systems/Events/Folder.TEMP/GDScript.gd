extends HSlider


func _on_middleman(intData : float) -> void:
	print("This is from gdscript working with the middleman")
	print(intData)
	value += intData
