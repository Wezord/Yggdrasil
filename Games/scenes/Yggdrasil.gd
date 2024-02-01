extends Node2D


# Declare member variables here. Examples:
var scenes


# Called when the node enters the scene tree for the first time.
func _ready():
	scenes=get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#for scene in scenes:
	#	scene.z_index=floor(scene.get_child(0).position.y+scene.position.y)

