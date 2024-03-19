using Godot;

public partial class DebugAddMaterial : Button
{
	[Export] public MaterialResource material;
	[Export] public int amount;
	[Export] public Inventory inventory;

	public override void _Ready()
	{
		Text = material.materialName;
	}

	public override void _Pressed()
	{
		inventory.AddMaterial(material.materialName, amount);
	}
}
