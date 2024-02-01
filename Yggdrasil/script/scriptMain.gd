extends Node2D

export (PackedScene) var Rengar
export (int) var playtime

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screensize

onready var level = get_node("ArbreMonde").level

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	spawnEnemy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawnEnemy():
	for i in range(1 + level):
		var c = Rengar.instance()
		$Enemy.add_child(c)
		c.position = Vector2(rand_range(-screensize.x, 0),
							 rand_range(screensize.y, 0))

