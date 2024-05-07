extends Node

@export var Channel : int

func _ready():
	GlobalEvents.connect("SendData",Recv)
	
func Recv(data,chan):
	if chan == Channel:
		print(data)
