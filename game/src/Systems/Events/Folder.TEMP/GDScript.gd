extends HSlider


func _on_middleman(intData : int) -> void:
	print("This is from gdscript working with the middleman")
	print(intData)
	value += intData
