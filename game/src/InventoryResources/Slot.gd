extends Panel


class_name InvSlot
@onready var icont = $Icon

var empty : bool = true
var item : UniversalItem
var quantity : int
var icon : Texture2D

func Update():
	if item != null:
		empty = false
		icon = item.UI_Texture
		$Icon.texture = icon
		$Total.text = str(quantity)
	else:
		empty = true
		
func Select(control : bool):
	$ItemOutline.visible = control



func is_empty():
	return empty
	
	
