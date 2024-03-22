extends Resource

class_name UniversalInventory

@export var Items : Array[UniversalItem]
@export var Owner : String
@export var Quantity : Array[int]

func add_item(item : UniversalItem):

	for i in range(Items.size()-1):
		#if the item already exists in the inventory
		if Items[i] == item:
			Quantity[i] += 1
			return 
		elif item not in Items:
			if Items[i] == null:
				Items[i] = item
				Quantity[i] = 1
				return 
