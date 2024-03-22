extends Panel

@onready var slot = $Slot
@onready var select_overlay = $SelectOverlay
@onready var res_icon = $Slot/ResIcon
@onready var equip_overlay = $EquipOverlay
@onready var quantity = $Quantity

func Update(item : UniversalItem):
	var Icon = item.IconTex
	res_icon.texture = Icon
	
func UpdateQuantity(q : int):
	quantity.text = str(q)
	quantity.visible = true
	
func Equip():
	equip_overlay.visible = true
	
func UnEquip():
	equip_overlay.visible = false
	
func Select():
	select_overlay.visible = true
	
func DisSelect():
	select_overlay.visible = false


