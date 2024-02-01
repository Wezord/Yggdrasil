extends KinematicBody2D


var anim
var cont

# Called when the node enters the scene tree for the first time.
func _ready():
	anim=["blue", "gold", "purple", "red"]
	cont=0

func _process(delta):
	if(Input.is_action_just_pressed("ui_page_up")):
		cont+=1
		cont=cont%4
	$AnimatedSpriteOre.animation=anim[cont]
