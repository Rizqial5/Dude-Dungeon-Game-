extends Node

export var reference_path = ""




func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if(reference_path != ""):
		get_tree().change_scene(reference_path)
	else:
		get_tree().quit()


