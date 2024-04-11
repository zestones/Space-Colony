extends Panel


class_name InvSlot
@onready var icont = $Icon

var empty : bool = true
var item : UniversalItem
var quantity : int

func Update():
	if item != null:
		empty = false
		
	else:
		empty = true

func is_empty():
	return empty
	
	
