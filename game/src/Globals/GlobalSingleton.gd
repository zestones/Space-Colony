extends Node

var GroundScene = "res://src/scenes/groundExploration.tscn"
var SpaceScene = "res://src/scenes/spaceExploration.tscn"
var Scenes = [GroundScene,SpaceScene]

func LoadScene(index):
	return load(Scenes[index])
