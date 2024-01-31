extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var stones = 0
export (int) var logs = 0

var ressources = {"Pierre" : stones, "Log":logs}

export (int) var stones_necessaire = 1
export (int) var logs_necessaire = 3

export (int) var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if body.hasItem():
			for i in body.items_in_inventory:
				ressources[i.name]+=1
				i.pickup()
			body.items_in_inventory.clear()
			
		
		#Si assez de ressources on améliore l'arbre
		if ressources["Pierre"] == stones_necessaire and ressources["Log"] == logs_necessaire:
			level +=1 
			print("Amelioration")
