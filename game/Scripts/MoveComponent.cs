using Godot;
using System;

public partial class MoveComponent : Node
{
	[Export] public CharacterBody2D character;

	public override void _Process(double _delta)
	{
		character.MoveAndSlide();
	}
}
