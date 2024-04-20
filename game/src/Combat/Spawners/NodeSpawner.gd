extends Node2D


@export var Entity : PackedScene
@export var Positions : Array[Marker2D]
@export var Targets : Array[CharacterBody2D]
@export var ParentNode : Node2D
@export var MaxSpawns : int = 10
var paused = false
var CurrentSpawns = 0

func _process(delta):
	print(CurrentSpawns)
	if CurrentSpawns >= MaxSpawns:
		paused = true
		$DownTime.start()
	
		

func _on_spawn_timer_timeout():
	if not paused:
		var Location = Positions.pick_random()
		Location = Location.global_position
		var entity = Entity.instantiate()
		entity.Targets = Targets
		ParentNode.add_child(entity)
		entity.global_position = Location
		CurrentSpawns += 1


func _on_down_time_timeout():

	CurrentSpawns = 0
	paused = false
	$DownTime.stop()
