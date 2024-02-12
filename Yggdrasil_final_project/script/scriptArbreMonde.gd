extends StaticBody2D


export (int) var red = 0
export (int) var purple = 0
export (int) var blue = 0
export (int) var gold = 0

var ressources = {"red" : red, "purple": purple, "blue":purple, "gold":purple}
var ressources_necessaires = []

export (int) var level = 0
export (int) var levelMax = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	ressources_necessaires.append({"red" : 0, "purple": 0, "blue":1, "gold":0})
	ressources_necessaires.append({"red" : 1, "purple": 1, "blue":1, "gold":1})
	ressources_necessaires.append({"red" : 2, "purple":2, "blue":1, "gold":1})
	ressources_necessaires.append({"red" : 1, "purple": 1, "blue":2, "gold":2})
	ressources_necessaires.append({"red" : 1, "purple": 0, "blue":0, "gold":0})
	ressources_necessaires.append({"red" : 1, "purple": 0, "blue":0, "gold":0})
	ressources_necessaires.append({"red" : 1, "purple": 0, "blue":0, "gold":0})
	ressources_necessaires.append({"red" : 1, "purple": 0, "blue":0, "gold":0})
	ressources_necessaires.append({"red" : 1, "purple": 0, "blue":0, "gold":0})
	ressources_necessaires.append({"red" : 1, "purple": 0, "blue":0, "gold":0})


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func has_ressources():
	return ressources["red"] >= ressources_necessaires[level]["red"] and ressources["purple"] >= ressources_necessaires[level]["purple"] and ressources["blue"] >= ressources_necessaires[level]["blue"] and ressources["gold"] >= ressources_necessaires[level]["gold"]
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if body.hasItem():
			for i in body.items_in_inventory:
				ressources[i.GetItemName()]+=1
				i.pickup()
			body.items_in_inventory.clear()
			body.carry_item = false
			
		if has_ressources():
			scale.x = 1+(level+1)/2.0
			scale.y = 1+(level+1)/2.0
			print(scale.x, scale.y)
			ressources["red"] -= ressources_necessaires[level]["red"]
			ressources["purple"] -= ressources_necessaires[level]["purple"]
			ressources["blue"] -= ressources_necessaires[level]["blue"]
			ressources["gold"] -= ressources_necessaires[level]["gold"]
			level +=1
			print("Amelioration")
