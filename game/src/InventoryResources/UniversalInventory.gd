extends Resource

class_name UniversalInventory

@export var Items : Array[UniversalItem]
@export var ItemSlots : Array

func Insert(item : UniversalItem):
	if item not in Items:
		Items.push_front(item)
	else:
		pass
	
		
