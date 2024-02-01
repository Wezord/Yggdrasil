extends "res://script/scriptEnemy.gd"

var can_move = false
var initial_pos
var velocity = Vector2.ZERO
var target_position = Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	initial_pos = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite.z_index=floor(position.y)
	if can_move:
		can_move = false
		$AnimatedSprite.animation = "jump"
		target_position = Vector2(rand_range(initial_pos.x - 70, initial_pos.x + 70), rand_range(initial_pos.y - 70, initial_pos.y + 70))
		print(target_position.x)
		print(target_position.y)
		velocity = (target_position-position).normalized() * 50
		print(position.x, position.y)
		print(initial_pos)
	
	if (target_position - position).length() <= 0.5:
		velocity = Vector2.ZERO
		$AnimatedSprite.animation = "chill"
	velocity = move_and_slide(velocity)
	
	pass



func _on_Timer_timeout():
	print("Time")
	can_move = true
