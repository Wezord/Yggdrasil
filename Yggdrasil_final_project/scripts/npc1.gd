extends Node2D
var in_area
var i
var dialoge


# Called when the node enters the scene tree for the first time.
func _ready():
	dialoge=[
	"Tu te sens seul, mon grand ? Ne t'inquiète pas, je suis là.",
	"Ah, le fidèle golem de pierre ! Tu es le seul à comprendre.",
	"Si seulement tu pouvais parler, imagine les histoires que tu raconterais !",
	"Je me demande ce que tu penses, derrière cette expression imperturbable.",
	"L'arbre monde est chanceux d'avoir un gardien aussi dévoué que toi.",
	"Salut, vieux golem ! Toujours aussi silencieux, hein ?",
	"Dans un monde bruyant, ta tranquillité est apaisante.",
	"Les jours passent et tu restes là, immuable comme toujours.",
	"Peut-être qu'un jour tu me révéleras tes secrets.",
	"Tu as l'air solide aujourd'hui, mon ami de pierre."
]
	in_area = false
	i=0
	$Area2D.connect("mouse_entered", self, "_on_Area2D_mouse_entered")
	$Area2D.connect("mouse_exited", self, "_on_Area2D_mouse_exited")


func _on_Area2D_mouse_entered():
	in_area = true
func _on_Area2D_mouse_exited():
	in_area = false
	i+=1
	i=i%10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(in_area):
		$Dialoge.text=dialoge[i]
	else:
		$Dialoge.text=""





