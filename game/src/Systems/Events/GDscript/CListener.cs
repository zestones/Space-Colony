using Godot;
using System;


public partial class CListener : Node
{
	[Export]
	private int Channel;

	public override void _Ready()
	{
		var global = GetNode("/root/GlobalEvents");
		global.Connect("SendData", new Callable(this,nameof(Recv)));
	}


	public void Recv(object data, int chan)
	{
		if (chan == Channel)
		{
			GD.Print(data);
		}
	}
}
