using Godot;

public partial class MaterialResource : Resource
{
	[Export] public WorldLocation materialLocation;
	[Export] public MaterialType materialType;
	[Export] public string materialName;

	public enum WorldLocation
	{
		Earth,
		Mars,
		Space,
		Asteroid,
		WormholeOne,
		WormholeTwo,
		WormholeThree,
		WormholeFour
	}

	public enum MaterialType
	{
		Local,
		Global
	}
}
