extends Node2D

onready var tele = $Teleport
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_detector_teleport_body_entered(body):
	tele.set_visible(true)
