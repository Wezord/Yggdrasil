extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var Rengar

var level=0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawnEnemy():
	for i in range(level+1):
		var c = Rengar.instance()
		$EnnemyContainer.add_child(c)
		c.position = Vector2(rand_range(0,500),
							 rand_range(0, 500))
