extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var stones = 0
export (int) var logs = 0
export (int) var waters = 0

# Called when the node enters the scene tree for the first time.
func _ready():
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
		velocity = velocity.normalized()
		position += velocity * delta * 300
		
func _on_Area2D_area_entered(area):
	print("zone")
	if area.is_in_group("Items"):
		print("true")
		if area.is_in_group("Stones"):
			stones+=1
			print("Stones !", stones)
		elif area.is_in_group("Logs"):
			logs+=1
			print("Logs !", logs)
		elif area.is_in_group("Waters"):
			print("Waters !", waters)
			waters+=1
		area.pickup()

