using Godot;
using System.Collections.Generic;

public partial class BuildMode : Node
{
	[Export] private BuildingResource[] buildings;
	[Export] private ColorRect buildMenu;

	public bool inBuildMode;
	private bool inBuildMenu;

	public override void _Ready()
	{
		foreach (BuildingResource building in buildings)
		{
			GD.Print($"{building.buildingName}");
			GD.Print($"Resources required:");

			foreach (KeyValuePair<MaterialResource, int> keyValuePair in building.buildingMaterials)
			{
				GD.Print($"{keyValuePair.Key.materialName} : {keyValuePair.Value}");
			}
		}

		buildMenu.Hide();
	}

	public override void _Input(InputEvent _event)
	{
		if (_event.IsActionPressed("BuildMode"))
		{
			inBuildMode = !inBuildMode;

			if (inBuildMode)
				EnterBuildMode();
			else
				ExitBuildMode();
		}

		if (_event.IsActionPressed("OpenBuildMenu"))
		{
			inBuildMenu = !inBuildMenu;

			if (!inBuildMode)
				return;

			if (inBuildMenu)
				OpenBuildMenu();
			else
				CloseBuildMenu();
		}
	}

	private void EnterBuildMode()
	{
		GD.Print("Entered build mode");
	}

	private void ExitBuildMode()
	{
		GD.Print("Exited build mode");

		CloseBuildMenu();
	}

	private void OpenBuildMenu()
	{
		GD.Print("Open build menu");

		buildMenu.Show();
	}

	private void CloseBuildMenu()
	{
		GD.Print("Close build menu");

		buildMenu.Hide();
	}
}
