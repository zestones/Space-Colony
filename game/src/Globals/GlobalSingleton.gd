extends Node

var GroundScene = "res://src/scenes/groundExploration.tscn"
var SpaceScene = "res://src/scenes/spaceExploration.tscn"
var deathScreen = "res://src/Player/Transitions/DeathScreen.tscn"
var Scenes = [GroundScene,SpaceScene,deathScreen]
func LoadScene(index):
	return load(Scenes[index])
