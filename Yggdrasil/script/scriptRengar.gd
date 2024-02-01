extends "res://script/scriptEnemy.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player : KinematicBody2D
var arbre : StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene_tree = get_tree()
	player = scene_tree.get_root().get_node("Main/Golem")
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:
		var delta_x = player.position.x - position.x
		var delta_y = player.position.y - position.y
		var velocity = Vector2(delta_x, delta_y).normalized() * delta * 100
		velocity = move_and_collide(velocity)

func _attack():
	move_and_slide(Vector2.ZERO)
	
