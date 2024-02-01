extends KinematicBody2D

var action
var velocity
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0, 0)
	health = 300



func _process(delta):
	#$AnimatedSprite.z_index=floor(position.y)
	#$Sprite.z_index=floor(position.y-1)
	
	
	if(health<=0):
		action="die"
	elif(velocity.length()>0):
		action="jump"
	else:
		action="chill"
	
	
	if(action=="chill"):
		$AnimatedSprite.animation="chill"
	elif(action=="damaged"):
		$AnimatedSprite.animation="damaged"
	elif(action=="die"):
		$AnimatedSprite.animation="die"
	elif(action=="jump"):
		$AnimatedSprite.animation="jump"
