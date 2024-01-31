extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func pickup():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		print("Body entered !")
		if is_in_group("Items"):
			print("true")
			if is_in_group("Stones"):
				body.stones+=1
				print("Stones !", body.stones)
			elif is_in_group("Logs"):
				body.logs+=1
				print("Logs !", body.logs)
			elif is_in_group("Waters"):
				print("Waters !", body.waters)
				body.waters+=1
			pickup()
