extends KinematicBody2D

export (int) var health = 30

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func attack(dmg):
	health-=dmg
	print(health)
	if health <= 0:
		die()
		
func die():
	queue_free()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
