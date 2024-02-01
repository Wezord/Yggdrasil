extends TileMap


var level 
var init_delta
var time

# Called when the node enters the scene tree for the first time.
func _ready():
	init_delta = 0
	time = 0
	level=0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time+=1
	if init_delta+100==time:
		level+=1
		init_delta+=100
		print(level)
