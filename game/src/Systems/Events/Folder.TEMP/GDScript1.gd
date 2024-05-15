extends HSlider


func _on_middleman(intValue : int) -> void:
	print("GDscript recieved value")
	value += intValue
