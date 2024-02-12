extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
var item_carry = "nothing"

signal GameOver(temps)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation="titre"
	var scene_tree = get_tree()
	player = get_node("../Player")
	$Health.hide()
	$healthbar.hide()
	$Ressources.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Health.text=str(player.health)
	if player.hasItem():
		item_carry=player.items_in_inventory[0].GetItemName()
	else:
		item_carry = "nothing"
	if(item_carry!="nothing"):
		$Item.text="Carry :"
	else:
		$Item.text=""
	$Item/Item.animation=item_carry
	
	if(player.velocity.length()>0):
		$AnimatedSprite.animation="hide"
		$Health.show()
		$healthbar.show()
		$Ressources.show()
	elif(player && not(player.isAlive)):
		$AnimatedSprite.animation="game_over"
		$Health.hide()
		$healthbar.hide()
		$Ressources.hide()
		emit_signal("GameOver", 5)

	$healthbar.update_health(player.health)

