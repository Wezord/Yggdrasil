extends Label

var ArbreMonde

# Declare member variables here. Examples:
var ressources=[]
var necessaires={}
var deposees={}
var texte=""

# Called when the node enters the scene tree for the first time.
func _ready():
	ArbreMonde = get_node("../../ArbreMonde")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ressources=[]
	necessaires={}
	deposees={}
	var ressources_necc = ArbreMonde.ressources_necessaires[ArbreMonde.level]
	var ressources_dep = ArbreMonde.ressources
	for key in ressources_necc.keys():
		if (ressources_necc[key] != 0):
			ressources.append(key)
			necessaires[key] = ressources_necc[key]
			deposees[key] = ressources_dep[key]
	texte=""
	for ressource in ressources:
		texte += ressource + " : " + str(deposees[ressource]) + " / " + str(necessaires[ressource]) +"\n"
	
	text=texte
