extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
var item_carry


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation="titre"
	player = get_node("../Player/Player")
	$Health.hide()
	$healthbar.hide()
	$Ressources.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Health.text=str(player.health)
	item_carry=player.item_carry
	if(item_carry!="nothing"):
		$Item.text="Carry :"
	else:
		$Item.text=""
	$Item/Item.animation=item_carry
	
	if(player.get_velocity()>0):
		$AnimatedSprite.animation="hide"
		$Health.show()
		$healthbar.show()
		$Ressources.show()
	elif(player.health<=0):
		$AnimatedSprite.animation="game_over"
		$Health.hide()
		$healthbar.hide()
		$Ressources.hide()

	$healthbar.update_health(player.health)

