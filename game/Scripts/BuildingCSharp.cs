using Godot;
using System;

public partial class BuildingCSharp : Area2D
{
	[Export] public BuildMode buildMode;
	[Export] public Polygon2D polygon;

	public override void _Ready()
	{
		this.BodyEntered += OnBodyEntered;
		this.BodyExited += OnBodyExited;
	}

	private void OnBodyEntered(Node2D _body)
	{
		if (!buildMode.inBuildMode)
			return;

		GD.Print("Can upgrade building");
		//polygon.Color = new Color(255, 51, 51);
	}

	private void OnBodyExited(Node2D _body)
	{
		//polygon.Color = new Color(170, 51, 255);
	}
}
