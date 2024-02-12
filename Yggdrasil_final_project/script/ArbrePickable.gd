extends StaticBody2D

export (Vector2) var worldTopLeft
export (Vector2) var  worldBottomRight
export (PackedScene) var Item

var itemsContainer
var PickableHandler

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func ChangeAnimation(name):
	$AnimatedSpriteOre.animation=name

func RandPos():
	position = Vector2(rand_range(worldTopLeft.x, worldBottomRight.x), rand_range(worldTopLeft.y, worldBottomRight.y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Destroy():
	var new_item = Item.instance()
	new_item.position = position
	var rx = (randi() % 2)
	var ry = (randi() % 2)
	if(rx==0):
		rx=-1
	if(ry==0):
		ry = -1
	new_item.position.x += 15*rx
	new_item.position.y += 15*ry
	new_item.ChangeAnimation($AnimatedSpriteOre.animation)
	itemsContainer.add_child(new_item)
	PickableHandler.SpawnPickable()
	queue_free()

func _on_Collision_body_entered(body):
	if(not(body.is_in_group("Player")) and not(body.is_in_group("Enemy"))):
		RandPos()
