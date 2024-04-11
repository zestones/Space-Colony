extends Area2D

@onready var line_render = $LineRender
var drawLine = false
var player
@onready var planet = $Planet
@onready var travel_ui = $TravelPopup

@onready var transitioner = $Transitioner


# Called when the node enters the scene tree for the first time.
func _ready():
	drawLine = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if drawLine and player != null:
		#When The player in in range
		if Input.is_action_just_pressed("Interact"):
			transitioner.Transition()
			drawLine = false
		
		
		#Show the outline
		$PlanetOutline.visible = true
		
		#Show the travel ui
		travel_ui.show()
		
		#Draw the line
		line_render.visible = true
		line_render.look_at(player.global_position)
		#Set the line to its correct length
		line_render.scale.x = abs((global_position - player.global_position).length()) * delta
	else:
		#Hide all ui
		line_render.visible = false
		$PlanetOutline.visible = false
		travel_ui.hide()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		drawLine = true
		
func _on_body_exited(body):
	if body.is_in_group("Player"):
		drawLine = false
