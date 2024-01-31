extends KinematicBody2D

var velocity
var carry_item
var my_timer
var wait

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity=Vector2(0,0)
	my_timer = $wakeup_time
	my_timer.connect("timeout", self, "_on_Timer_timeout")
	$AnimatedSprite.animation="idle"
	$AnimatedSprite.frame=26


func timer_start(time):
		my_timer.wait_time=time
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


	$AnimatedSprite.flip_h=(velocity.x>0)
	velocity.normalized()
	
	if(Input.is_action_just_pressed("ui_page_down")):
		carry_item=!carry_item
		my_timer.stop()
		wait=false
	
	
	
	
	if(carry_item):
		if($AnimatedSprite.animation=="idle"):
			$AnimatedSprite.animation="idle_item"
			$AnimatedSprite.frame=20
		if($AnimatedSprite.animation=="wait"):
			$AnimatedSprite.animation="wait_item"
			$AnimatedSprite.frame=23
		if($AnimatedSprite.animation=="walk"):
			$AnimatedSprite.animation="carry"
			$AnimatedSprite.frame=3
		if($AnimatedSprite.animation=="wakeup"):
			$AnimatedSprite.animation="wakeup_item"
			$AnimatedSprite.frame=20
		
		
		if(velocity.length()>0):
			if($AnimatedSprite.animation=="idle_item"):
				$AnimatedSprite.animation="wakeup_item"
				timer_start(1.4)
			elif($AnimatedSprite.animation=="wait_item"):
				$AnimatedSprite.animation="carry"
			elif(!wait):
				$AnimatedSprite.animation="carry"
		elif(velocity.length()==0):
			if(!wait && ($AnimatedSprite.animation=="carry" || $AnimatedSprite.animation=="wakeup_item")):
				$AnimatedSprite.animation="wait_item"
				timer_start(10)
			elif(!wait):
				$AnimatedSprite.animation="idle_item"
				
		if(!wait || ($AnimatedSprite.animation=="wait_item" || $AnimatedSprite.animation=="carry")):
			position+=velocity*200*delta
	else:
		if($AnimatedSprite.animation=="idle_item"):
			$AnimatedSprite.animation="idle"
			$AnimatedSprite.frame=26
		if($AnimatedSprite.animation=="wait_item"):
			$AnimatedSprite.animation="wait"
			$AnimatedSprite.frame=23
		if($AnimatedSprite.animation=="carry"):
			$AnimatedSprite.animation="walk"
			$AnimatedSprite.frame=26
		if($AnimatedSprite.animation=="wakeup_item"):
			$AnimatedSprite.animation="wakeup"
			$AnimatedSprite.frame=26
		
		if(velocity.length()>0):
			if($AnimatedSprite.animation=="idle"):
				$AnimatedSprite.animation="wakeup"
				timer_start(1.4)
			elif($AnimatedSprite.animation=="wait"):
				$AnimatedSprite.animation="walk"
			elif(!wait):
				$AnimatedSprite.animation="walk"
		elif(velocity.length()==0):
			if(!wait && ($AnimatedSprite.animation=="walk" || $AnimatedSprite.animation=="wakeup")):
				$AnimatedSprite.animation="wait"
				timer_start(10)
			elif(!wait):
				$AnimatedSprite.animation="idle"
		
		if(!wait || $AnimatedSprite.animation=="wait" || $AnimatedSprite.animation=="walk"):
			position+=velocity*200*delta
	
	
	
	
