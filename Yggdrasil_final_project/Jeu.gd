extends Node2D


export (PackedScene) var Yggdrasil_Main
var  restart = true
var game

# Called when the node enters the scene tree for the first time.
func _ready():
	game = $Yggdrasil_Main
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (restart):
		if(game.gameOver):
			print("GameOver")
			$TimerGameOver.start(3)
			restart=false
		
		



func _on_TimerGameOver_timeout():
	game.queue_free()
	var new_game = Yggdrasil_Main.instance()
	add_child(new_game)
	game = new_game
	restart=true
