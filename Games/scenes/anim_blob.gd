extends KinematicBody2D

var action
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	$AnimatedSprite.z_index=floor(position.y)
	$Sprite.z_index=floor(position.y-1)
	
	if(action=="chill"):
		$AnimatedSprite.animation="chill"
	elif(action=="damaged"):
		$AnimatedSprite.animation="damaged"
	elif(action=="die"):
		$AnimatedSprite.animation="die"
	elif(action=="jump"):
		$AnimatedSprite.animation="jump"
