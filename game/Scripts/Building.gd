extends Area2D

@export var polygonColour: Polygon2D

func _on_body_entered(body: Node2D) -> void:
	polygonColour.color = Color.RED
	


func _on_body_exited(body: Node2D) -> void:
	polygonColour.color = Color.WHITE
