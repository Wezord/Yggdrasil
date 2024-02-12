extends Node

export (PackedScene) var ArbrePickable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func SpawnPickables():
	for i in range(20):
		SpawnPickable()

func SpawnPickable():
	var i = randi()%5+1
	var newPick = ArbrePickable.instance()
	newPick.RandPos()
	newPick.itemsContainer = $ItemsContainer
	newPick.PickableHandler = self
	print(i)
	if(i == 1):
		newPick.ChangeAnimation("red")
	if(i == 2):
		newPick.ChangeAnimation("purple")
	if(i == 3):
		pass#newPick.ChangeAnimation("green")
	if(i == 4):
		newPick.ChangeAnimation("blue")
	if(i == 5):
		newPick.ChangeAnimation("gold")
	$ItemsContainer.add_child(newPick)
	print(newPick.position)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
