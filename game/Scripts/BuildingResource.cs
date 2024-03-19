using Godot;
using Godot.Collections;

public partial class BuildingResource : Resource
{
	[Export] public string buildingName;
	[Export] public Dictionary<MaterialResource, int> buildingMaterials = new Dictionary<MaterialResource, int>();
}
