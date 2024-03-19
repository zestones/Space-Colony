extends Control


@onready var grid_container = $Inventory/GridContainer
@export var Owner : CharacterBody2D
@export var StatHandler : Control
@onready var inventory = $Inventory
var isOpened = false
var CurrentSlot = 0
func _ready():
	close()
	
func _process(delta):
	if Input.is_action_just_pressed("Inventory"):
		if isOpened:
			close()
		else:
			#when Inventory is open
			open()
	if isOpened:
		var Items = Owner.inventory.Items
		var TotalItems = Owner.inventory.Items.size()
		var Slots = grid_container.get_children()
		for i in range(TotalItems):
			var ConcernedSlot = Slots[i]
			if Items[i] != null: 
				ConcernedSlot.Update(Items[i])
				if CurrentSlot == i:
					StatHandler.DisplayStats(Items[i])
					StatHandler.Show()
				if Owner.InHand == Items[i]:
					ConcernedSlot.Equip()
				else:
					ConcernedSlot.UnEquip()
			elif CurrentSlot == i:
				StatHandler.Hide()
			
			if CurrentSlot == i:
				ConcernedSlot.Select()
			else:
				ConcernedSlot.DisSelect()
				
		if CurrentSlot < 0 : CurrentSlot = 0
		if CurrentSlot > TotalItems -1 : CurrentSlot = TotalItems-1
		
		if Input.is_action_just_pressed("Right"):
			CurrentSlot += 1
		if Input.is_action_just_pressed("Left"):
			CurrentSlot -= 1
			
		if Input.is_action_just_pressed("Fire") or Input.is_action_just_pressed("ui_accept"):
			if Items[CurrentSlot] != null: 
				Owner.InHand = Items[CurrentSlot]
			

			


func close():
	Owner.UnderControl = true
	inventory.visible = false
	isOpened = false
	StatHandler.Hide()
	
func open():
	Owner.UnderControl = false
	inventory.visible = true
	isOpened = true
