extends Area2D

var anim;
## A reference to the travelPopup node in the scene.
@export var travelPopup : Control;

@onready var spaceshipRevisedScriptID = preload("res://src/Player/Spaceship/spaceshipRevised.gd");

func _ready():
	anim = get_node("AnimatedSprite2D");
	anim.play();
	travelPopup.visible = false;

func _on_body_entered(body):
	#print_debug(body.get_script());
	#print_debug(preload("res://src/Player/Spaceship/spaceshipRevised.gd"));
	#print_debug(str(body) + " entered " + ("with" if (body.get_script()) else "without" + " method spaceshipRevised"));
	if spaceshipRevisedScriptID == body.get_script():
		travelPopup.visible = true;


func _on_body_exited(body):
	#print_debug(str(body) + " exited");
	if spaceshipRevisedScriptID == body.get_script():
		travelPopup.visible = false;
