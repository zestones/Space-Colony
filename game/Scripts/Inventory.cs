using Godot;
using Godot.Collections;

public partial class Inventory : Node
{
	[Export] private Dictionary<string, int> materials = new Dictionary<string, int>();

	public void AddMaterial(string key, int value)
	{
		if (!materials.ContainsKey(key))
			materials[key] = value;

		materials[key] += value;
	}
}
