extends Resource

class_name UniversalItem

@export var Name : String = "Resource_Name"
@export_enum("Minable","Default") var Type : String = "Minable"
@export var UI_Texture : Texture2D
@export var RealTexture : Texture2D
@export var Cost : int = 100
@export var Health : int = 100
