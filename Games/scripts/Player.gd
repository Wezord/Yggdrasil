extends KinematicBody2D

var velocity
var my_timer
var wait

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity=Vector2(0,0)
	my_timer = $wakeup_time
	my_timer.connect("timeout", self, "_on_Timer_timeout")


func timer_start():
		# Démarrer le Timer
		my_timer.start()
		wait=true

func _on_Timer_timeout():
	wait=false

func _process(delta):
	velocity=Vector2(0,0)
	if(Input.is_action_pressed("ui_right")):
		velocity.x+=1
	if(Input.is_action_pressed("ui_left")):
		velocity.x-=1
	if(Input.is_action_pressed("ui_up")):
		velocity.y-=1
	if(Input.is_action_pressed("ui_down")):
		velocity.y+=1


	if(velocity.length()>0):
		if($AnimatedSprite.animation=="idle"):
			$AnimatedSprite.animation="wakeup"
			timer_start()
		elif($AnimatedSprite.animation=="wait"):
			$AnimatedSprite.animation="carry"
		elif(!wait):
			$AnimatedSprite.animation="carry"
	elif(velocity.length()==0):
		if($AnimatedSprite.animation=="carry"):
			$AnimatedSprite.animation="wait"
			timer_start()
		elif(!wait):
			$AnimatedSprite.animation="idle"
			timer_start()
		
	
	$AnimatedSprite.flip_h=(velocity.x>0)
	velocity.normalized()
	if(!wait || ($AnimatedSprite.animation=="wait" || $AnimatedSprite.animation=="carry")):
		position+=velocity*100*delta
	
	
