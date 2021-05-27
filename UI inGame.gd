extends Control


export (int) var current_health = 5 setget update_Hbars
export (int) var current_mana = 3 setget update_Mbars

onready var heart = $HeartBox
onready var mana = $ManaBox

var attacked = false
var score = 0
export (int) var kondisi = 0
export (int) var operator = 0

func output_operator(c):
	var result
	
	if c == 0:
		result = '+'
	elif c == 1:
		result = '-' 
	if c == 2:
		result = '*'
	elif c == 3:
		result = '/' 
	
	return result

func output_kondisi(a):
	var result
	
	if a == 0:
		result = 'n > '+ str(5)
	elif a == 1:
		result = 'n < '+ str(5)
		
	return result

func _ready():
	print(kondisi)
	print(operator)
	self.current_health = 5
	self.current_mana = 3
	$TextureRect/Label.text = output_kondisi(kondisi)
	$Operator/Label.text = output_operator(operator)
	
#func _process(delta):
	
func update_Mbars(value):
	current_mana = value
	$ManaBox.update_mana(current_mana)
	
func update_Hbars(value):
	current_health = value
	$HeartBox.update_health(current_health)
	
	
func _on_AttackHIT_body_entered(body):
	self.current_health -= 1
