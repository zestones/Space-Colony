extends Node

func Emit(data,channel):
	GlobalEvents.emit_signal("SendData" , data,channel)
	


func _on_timer_timeout():
	Emit("Test" , 1)

