extends Area2D

@onready var icon = $Icon
@onready var animation_player = $AnimationPlayer

@export var DetectionRadius : float = 1
@onready var collision_shape_2d = $CollisionShape2D
@export var Item : UniversalItem
@export var Requirnment : UniversalItem

var IconTex : Texture2D
var ItemHp : float
var PlayerInRange = false
var Player : CharacterBody2D
var Minning = false
func _ready():
	collision_shape_2d.scale.x = DetectionRadius
	collision_shape_2d.scale.y = DetectionRadius
	ItemHp = Item.Health
	IconTex = Item.IconTex
	icon.texture = IconTex
	
func _process(delta):
	if PlayerInRange:
		if not Requirnment == null:
			if Player.InHand == Requirnment:
				animation_player.play("Mine")
				Minning = true
		else:
			animation_player.play("Mine")
			Minning = true

func _on_body_entered(body):
	if body.is_in_group("Player"):
		PlayerInRange = true
		Player = body

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Mine":
		if Minning:
			if Requirnment != null:
				if ItemHp >= Requirnment.Strength:
					ItemHp -= Requirnment.Strength
				elif ItemHp < Requirnment.Strength:
					Player.inventory.add_item(Item)
					queue_free()
			else:
				Player.inventory.add_item(Item)
				queue_free()


func _on_body_exited(body):
	if body.is_in_group("Player"):
		PlayerInRange = false
		Minning = false
