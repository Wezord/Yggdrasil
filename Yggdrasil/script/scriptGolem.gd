extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var body_in_area : Array = []
var items_in_inventory : Array = []

export (int) var health = 50
export (int) var attack_cooldown = 3

var ind : int = 0 
var can_attack : bool = true
var timer : Timer

signal position_changed(position)

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var screensize = Vector2(480, 720)
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right") :
		velocity.x += 1
	if Input.is_action_pressed("ui_left") :
		velocity.x -= 1
	if Input.is_action_pressed("ui_up") :
		velocity.y -= 1
	if Input.is_action_pressed("ui_down") :
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * 300
		velocity = move_and_slide(velocity)
		
	if Input.is_action_pressed("ui_select") and can_attack:
		print("Attack")
		$AnimatedSprite2.animation ="Slash"
		can_attack = false
		timer.wait_time = 2
		timer.start()
		for i in body_in_area:
			print(i)
			i.attack()
			
	emit_signal("position_changed", global_position)
			
func _on_KinematicBody2D_mouse_entered():
	print("Mouse entered")

func _on_StoneAttack_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("ui_select") :
		print("Select")
		


func _on_StoneAttack_body_entered(body):
	if body.is_in_group("Enemy"):
		print("1")
		if not body_in_area.has(body):
			print("2")
			body_in_area.append(body)
		
		print("Enemy")


func _on_StoneAttack_body_exited(body):
	if body.is_in_group("Enemy"):
		if body_in_area.has(body):
			body_in_area.remove(body_in_area.find(body))

func _on_Timer_timeout():
	print("time_out")
	can_attack = true
	$AnimatedSprite2.animation = "default"

func hasItem():
	if items_in_inventory != []:
		return true
	return false
