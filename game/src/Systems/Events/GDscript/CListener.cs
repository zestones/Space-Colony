using Godot;
using System;


public partial class CListener : Node2D
{
	[Export]
	public int Channel;

	public override void _Ready()
	{	
		var Reference = GD.Load<GDScript>("res://src/Systems/Events/GDscript/GlobalEvents.gd");
		var Script = (GodotObject)Reference.New();
		var signal = (Signal)Script.Get("SendData");
		
	}

	public void Recv(object data, int chan)
	{
		GD.Print("Called");
		if (chan == Channel)
		{
			GD.Print(data);
		}
	}
}
