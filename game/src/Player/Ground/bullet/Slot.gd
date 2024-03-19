extends Panel

@onready var slot = $Slot
@onready var select_overlay = $SelectOverlay
@onready var res_icon = $Slot/ResIcon
@onready var equip_overlay = $EquipOverlay

func Update(item : UniversalItem):
	var Icon = item.IconTex
	res_icon.texture = Icon
	
func Equip():
	equip_overlay.visible = true
	
func UnEquip():
	equip_overlay.visible = false
	
func Select():
	select_overlay.visible = true
	
func DisSelect():
	select_overlay.visible = false


