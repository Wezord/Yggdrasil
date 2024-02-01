extends Label


# Declare member variables here. Examples:
var ressources=["a","b"]
var necessaires={"a":2,"b":4}
var deposees={"a":4,"b":8}
var texte=""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	texte=""
	for ressource in ressources:
		texte += ressource + " : " + str(deposees[ressource]) + " / " + str(necessaires[ressource]) +"\n"
	
	text=texte
