using Godot;
using System;

public partial class MoveInputComponent : Node
{
	[Export] private MoveComponent moveComponent;

	public override void _Input(InputEvent _event)
	{
		float inputAxis = Input.GetAxis("Left", "Right");

		moveComponent.character.Velocity = new Vector2(inputAxis * 300, 0);
	}
}
