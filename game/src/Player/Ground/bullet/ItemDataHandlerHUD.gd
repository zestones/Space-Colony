extends Control

@onready var item_name = $ItemName
@onready var item_cost = $ItemCost
@onready var item_engery = $ItemEngery
@onready var item_icon = $ItemIcon

func _ready():
	Hide()

func Show():
	visible = true
	
func Hide():
	visible = false

func DisplayStats(Item : UniversalItem):
		var Name = Item.Name
		var Icon = Item.IconTex
		var Cost = "Cost :  " + str(Item.Cost)
		var Energy = "Energy :  " + str(Item.Health)
		item_name.text = Name
		item_cost.text = Cost
		item_engery.text = Energy
		item_icon.texture = Icon
	
