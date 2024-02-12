extends "res://script/scriptEnemy.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player : KinematicBody2D
var arbre : StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene_tree = get_tree()
	player = get_node("../../../Player")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var wr = weakref(player)
	if wr.get_ref():
		var delta_x = player.global_position.x - global_position.x
		var delta_y = player.global_position.y - global_position.y
		var velocity = Vector2(delta_x, delta_y).normalized() * delta * 80
		$AnimatedSprite.flip_h=(velocity.x<0) || ($AnimatedSprite.flip_h && (velocity.x==0))
		velocity = move_and_collide(velocity)

func _attack():
	move_and_slide(Vector2.ZERO)
	
