extends Node2D


@export var Entity : PackedScene
@export var Positions : Array[Marker2D]
@export var Targets : Array[CharacterBody2D]
@export var ParentNode : Node2D
@export var MaxSpawns : int = 10
@export var NextSpawner : Node2D

@export var paused = true
var CurrentSpawns = 0
@export var CanActivate = false
	
	
	
func _on_spawn_timer_timeout():
	if not paused and CanActivate:
		var Location = Positions.pick_random()
		Location = Location.global_position
		var entity = Entity.instantiate()
		entity.Targets = Targets
		ParentNode.add_child(entity)
		entity.global_position = Location
		CurrentSpawns += 1
		if CurrentSpawns >= MaxSpawns:
			paused = true
			$DownTime.start()


func _on_down_time_timeout():
	print("Wave-2 has started")
	if NextSpawner != null:
		NextSpawner.CanActivate = true
	
