using Godot;
using System;
using System.Collections.Generic;

public partial class Inventory : Node
{
	[Export] private Godot.Collections.Dictionary<string, int> materials = new Godot.Collections.Dictionary<string, int>();

	private event Action OnInventoryChanged;

	public void AddMaterial(string _key, int _value)
	{
		if (!materials.ContainsKey(_key))
			materials[_key] = _value;

		materials[_key] += _value;

		OnInventoryChanged?.Invoke();

		InventoryChanged();
	}

	public bool CheckForMaterial(string _key, int _amount)
	{
		if (materials.ContainsKey(_key))
		{
			if (materials[_key] >= _amount)
				return true;
		}

		return false;
	}

	private void InventoryChanged()
	{
		foreach (KeyValuePair<string, int> pair in materials)
		{
			GD.Print($"{pair.Key}: {pair.Value}");
		}
	}
}
