extends Control


@export var Inventory : UniversalItem
@onready var animator = $Animator
@onready var container = $UI/Container

var open = false
var slots = []

func _ready():

	for slot in container.get_children():
		slots.append(slot)
		
func _process(delta):
	if open:
		for index in range(slots.size()-1):
			var SLOT = slots[index]
			SLOT.item = Inventory.Items[index]
	

func Insert(item : UniversalItem):
	if item not in Inventory.Items:
		for index in range(slots.size()-1):
			var slot = slots[index]
			if slot.is_empty() and Inventory.Items[index] == null:
				slot.item = item
				Inventory.Items[index] = item
				return
	else:
		for index in range(slots.size()-1):
			var slot = slots[index]
			if slot.item == item:
				slot.quantity += 1
				return


func _on_open_pressed():
	if not open:
		animator.play("Open_Inven")
	else:
		animator.play("Close_Inven")
		
		

func _on_animator_animation_finished(anim_name):
	if anim_name == "Open_Inven":
		open = true
	else:
		open = false
