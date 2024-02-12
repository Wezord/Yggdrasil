extends Node2D

var gameOver = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Terre.level = $ArbreMonde.level
	$EnnemyHandler.level = $ArbreMonde.level
	$PickableHandler.SpawnPickables()

func _process(delta):
	if($ArbreMonde.level!=$Terre.level):
		$EnnemyHandler.spawnEnemy()
		$PickableHandler.SpawnPickables()
		print("Ennemy")
	$Terre.level = $ArbreMonde.level
	$EnnemyHandler.level = $ArbreMonde.level
	

func _on_GUI_GameOver(temps):
	print("i")
	gameOver = true
