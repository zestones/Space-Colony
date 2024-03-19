using Godot;
using System;
using System.Collections.Generic;

public partial class BuildingButton : Button
{
	[Export] public BuildingResource building;
	[Export] public Inventory inventory;

	public override void _Ready()
	{
		Text = building.buildingName;
	}

	public override void _Pressed()
	{
		foreach (KeyValuePair<MaterialResource, int> pair in building.buildingMaterials)
		{
			if (!inventory.CheckForMaterial(pair.Key.materialName, pair.Value))
			{
				GD.Print($"Didn't have enough {pair.Key.materialName} to make the building");
				continue;
			}

			GD.Print($"Had enough {pair.Key.materialName} to make the building");
		}
	}
}
