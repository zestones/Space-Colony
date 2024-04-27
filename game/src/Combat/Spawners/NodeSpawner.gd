extends Node2D


@export var Entity : PackedScene
@export var Positions : Array[Marker2D]
@export var Targets : Array[Area2D]
@export var ParentNode : Node2D
@export var MaxSpawns : int = 10
@export var NextSpawner : Node2D
@export var BetterPerformance : bool = true
@export var paused = true
var CurrentSpawns = 0
@export var CanActivate = false
var Finished = false
var Started = false
var EntitiesSpawned = []

func _process(delta):
	if CanActivate and not paused and not Started:
		$WaveUI/AnimationPlayer.play("WaveStarting")
		set_process(false)
	
	
func _on_spawn_timer_timeout():
	if not paused and CanActivate:
		var Location = Positions.pick_random()
		Location = Location.global_position
		var entity = Entity.instantiate()
		entity.Targets = Targets
		ParentNode.add_child(entity)
		entity.global_position = Location
		EntitiesSpawned.append(entity)
		CurrentSpawns += 1
		if CurrentSpawns >= MaxSpawns:
			paused = true
			$DownTime.start()


func _on_down_time_timeout():
	if BetterPerformance:
		for entity in EntitiesSpawned:
			if not is_instance_valid(entity):
				EntitiesSpawned.erase(entity)
		if EntitiesSpawned.size() == 0:
			$WaveUI/AnimationPlayer.play("WaveCompleted")
			Finished = true
			if NextSpawner != null:
				NextSpawner.CanActivate = true
			await $WaveUI/AnimationPlayer.animation_finished
			queue_free()
		else:
			$DownTime.start()
	else:
		for entity in EntitiesSpawned:
			if not is_instance_valid(entity):
				EntitiesSpawned.erase(entity)
		if EntitiesSpawned.size() == 0:
			$WaveUI/AnimationPlayer.play("WaveCompleted")
			Finished = true
			if NextSpawner != null:
				NextSpawner.CanActivate = true
			await $WaveUI/AnimationPlayer.animation_finished
		else:
			$DownTime.start()
		if NextSpawner != null:
			NextSpawner.CanActivate = true
	
