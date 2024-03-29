extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var source_object : KinematicBody2D
var flip

func pickup():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene_tree = get_tree()
	source_object = get_node("../../../Player")
	flip = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		print("Body entered !")
		if is_in_group("Items"):
			if body.hasItem():
				print("Déjà un item !")
			else:
				body.GetItem(self)
				print("Récupère")
				source_object.connect("position_changed", self, "_on_position_changed")
				
				
func _on_position_changed(new_position):
	# Appliquez la nouvelle position à l'objet dans la deuxième scène
	global_position = new_position
	global_position.x -= 15
	global_position.y -= 25
	if(flip):
		global_position.x += 10
