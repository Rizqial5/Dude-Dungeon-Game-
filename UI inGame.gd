extends Control


var current_health = 5 setget update_bars
onready var heart = $HeartBox
var attacked = false

func _ready():
	self.current_health = 5


#func _process(delta):
	

func update_bars(value):
	current_health = value
	heart.update_health(current_health)
	
	


func _on_AttackHIT_body_entered(body):
	self.current_health -= 1

