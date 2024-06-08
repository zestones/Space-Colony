extends Control


@export var ObjectiveDisplay : RichTextLabel
@export var Health : RichTextLabel
var NodeBase = {}
var RelevanceIndex = 0
func _ready():
	NodeBase["Health"] = Health
	NodeBase["Objective"] = ObjectiveDisplay
	
func UpdateHUD(data : Dictionary):
	for Parameter in NodeBase:
		if Parameter in data:
			NodeBase[Parameter].text = data[Parameter]
	
func _on_data_convertor_middleman(data):
	data = data[RelevanceIndex]
	UpdateHUD(data)
