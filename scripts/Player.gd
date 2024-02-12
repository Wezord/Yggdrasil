extends KinematicBody2D

var velocity
var carry_item
var my_timer
var wait
var speed = 150
var helditem = "nothing"

var pickable_in_area : Array = []
var items_in_inventory : Array = []
var ennemy_in_area : Array = []

export (int) var stones = 0
export (int) var logs = 0
export (int) var waters = 0

export (int) var health = 100
export (int) var attack_cooldown = 3

var ind : int = 0 
var can_attack : bool = true
var timer : Timer

var heath = 150
var isAlive = true

signal position_changed(position)

func hasItem():
	if items_in_inventory != []:
		return true
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity=Vector2(0,0)
	my_timer = $wakeup_time
	timer = $cooldown
	my_timer.connect("timeout", self, "_on_Timer_timeout_wakeup_time")
	timer.connect("timeout", self, "_on_Timer_timeout_cooldown")
	$AnimatedSprite.animation="idle"
	$AnimatedSprite.frame=26
	heath = 150

func timer_start(time):
	my_timer.wait_time=time
	my_timer.start()
	wait=true

func timer_stop():
	my_timer.stop()
	wait=false

func _on_Timer_timeout_wakeup_time():
	wait=false

func _process(delta):
	print(health)
	velocity=Vector2(0,0)
	if(isAlive):
		if(Input.is_action_pressed("ui_right")):
			velocity.x+=1
		if(Input.is_action_pressed("ui_left")):
			velocity.x-=1
		if(Input.is_action_pressed("ui_up")):
			velocity.y-=1
		if(Input.is_action_pressed("ui_down")):
			velocity.y+=1


	$AnimatedSprite.flip_h=(velocity.x>0) || ($AnimatedSprite.flip_h && (velocity.x==0))
	for item in items_in_inventory:
		item.flip = $AnimatedSprite.flip_h
	velocity=velocity.normalized()
	
	if(Input.is_action_just_pressed("ui_page_down")):
		carry_item=!carry_item
		timer_stop()

	if(carry_item):
		if($AnimatedSprite.animation=="idle"):
			$AnimatedSprite.animation="idle_item"
			$AnimatedSprite.frame=20
		if($AnimatedSprite.animation=="wait"):
			$AnimatedSprite.animation="wait_item"
			timer_start(10)
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
				timer_stop()
			elif(!wait):
				$AnimatedSprite.animation="carry"
		elif(velocity.length()==0):
			if(!wait && ($AnimatedSprite.animation=="carry" || $AnimatedSprite.animation=="wakeup_item")):
				$AnimatedSprite.animation="wait_item"
				timer_start(10)
			elif(!wait):
				$AnimatedSprite.animation="idle_item"
		
		if(!wait || ($AnimatedSprite.animation=="wait_item" || $AnimatedSprite.animation=="carry"|| $AnimatedSprite.animation=="Mine")):
			move_and_collide(velocity*speed*delta)
	else:
		if($AnimatedSprite.animation=="idle_item"):
			$AnimatedSprite.animation="idle"
			$AnimatedSprite.frame=26
		if($AnimatedSprite.animation=="wait_item"):
			$AnimatedSprite.animation="wait"
			timer_start(10)
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
				timer_stop()
			elif(!wait):
				$AnimatedSprite.animation="walk"
		elif(velocity.length()==0):
			if(!wait && ($AnimatedSprite.animation=="walk" || $AnimatedSprite.animation=="wakeup")):
				$AnimatedSprite.animation="wait"
				timer_start(10)
			elif(!wait):
				$AnimatedSprite.animation="idle"
		
		if(!wait || $AnimatedSprite.animation=="wait" || $AnimatedSprite.animation=="walk" || $AnimatedSprite.animation=="Mine"):
			move_and_collide(velocity*speed*delta)
			
	$Camera2D.align()
	
	if Input.is_action_pressed("ui_select") and can_attack and not(hasItem()):
		print("Attack")
		can_attack = false
		timer.wait_time = 1
		timer.start()
		timer_stop()
		timer_start(10)
		speed *= 0.76
		$AnimatedSprite.animation ="Mine"
		for i in pickable_in_area:
			pickable_in_area.remove(pickable_in_area.find(i))
			i.Destroy()
		for i in ennemy_in_area:
			i.attack(10)
		
	emit_signal("position_changed", global_position)
	
	
func GetItem(item):
	items_in_inventory.append(item)
	carry_item = true

func Loose():
	isAlive = false
	hide()

func TakeDamage(dam):
	print(health)
	health -= dam
	print(health)
	if health <= 0:
		Loose()
	
func _on_KinematicBody2D_mouse_entered():
	print("Mouse entered")

func _on_StoneAttack_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("ui_select") :
		print("Select")
		

func _on_Timer_timeout_cooldown():
	print("time_out")
	can_attack = true
	$AnimatedSprite.animation = "wait"
	speed /= 0.76

func _on_Detection_body_entered(body):
	if body.is_in_group("Enemy"):
		for i in items_in_inventory:
			disconnect("position_changed", i, "_on_position_changed")
		items_in_inventory.clear()
		carry_item=false
		TakeDamage(20)
		print("TakeDamage")
		print(health)

func _on_Detection_body_exited(body):
	pass


func _on_Attack_body_entered(body):
	if body.is_in_group("Pickable"):
		if not pickable_in_area.has(body):
			pickable_in_area.append(body)
		print("Pickable")
	if body.is_in_group("Enemy"):
		print("1")
		if not ennemy_in_area.has(body):
			print("2")
			ennemy_in_area.append(body)
		print("Enemy")
		

func _on_Attack_body_exited(body):
	if body.is_in_group("Pickable"):
		var i = pickable_in_area.find(body)
		if i >= 0:
			pickable_in_area.remove(i)
	if body.is_in_group("Enemy"):
		var i = ennemy_in_area.find(body)
		if i >= 0:
			ennemy_in_area.remove(i)
