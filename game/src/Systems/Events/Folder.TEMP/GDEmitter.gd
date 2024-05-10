extends Node

@export var emitterMiddleman : Node
@export var intValue : int

func _on_timer_timeout() -> void:
	emitterMiddleman.call("EmitEvent", intValue)
