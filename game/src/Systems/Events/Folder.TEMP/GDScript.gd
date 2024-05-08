extends Node

@export var intChannel : IntEventChannel
@export var dataDic : Dictionary
@export var intValue : int

func _ready() -> void:
	intChannel.callv("Invoke", [dataDic])
	intChannel


func _on_response(data : Object, dics : Dictionary) -> void:
	print("Called from gdscript")
	print(dics)
