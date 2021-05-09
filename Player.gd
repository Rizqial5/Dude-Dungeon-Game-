extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAV = 20
const ACCEL = 50
const MAX_SPEED = 200
var motion1 = Vector2()
var State_play = false
var attack_num = 1
var attack_anim = null
var on_air = false
var changed_face = true



onready var ui = $"UI inGame"


# warning-ignore:unused_argument
func _process(delta): 
	motion1.y += GRAV
	var fall = true
	var friction = false
	#Movemement
	if State_play == false :
		if Input.is_action_pressed("move_right"):
			motion1.x = min(motion1.x+ACCEL, MAX_SPEED)
			if changed_face == false :
				scale.x = -1
				changed_face = true
				ui.set_scale(Vector2(1,1))
#			$AnimationPlayer.play("Run")
		elif Input.is_action_pressed("move_left"):
			if changed_face == true :
				scale.x = -1
				changed_face = false
				ui.set_scale(Vector2(-1,1))
			motion1.x = max(motion1.x-ACCEL, -MAX_SPEED)
			
#			$AnimationPlayer.play("Run")
		else :
			friction = true
#			fall = false
#			$AnimationPlayer.play("Idle")
#	if on_air == false :
#		if Input.is_action_just_pressed("attack"):
#			$Timer.start()
#			State()
#			if $Timer.time_left > 0.5 :
#				attack_num += 1
#			if attack_num > 2 :
#				attack_num = 1

		
	elif scale.x == 1 :
		ui.set_scale(Vector2(1,1))
		
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion1.y = -500
		if friction == true :
			motion1.x = lerp(motion1.x, 0, 0.2) 
		on_air = false
	else:
		if motion1.y < 0:
			on_air = true
#			$AnimationPlayer.play("Jump") 
		 
		else :
#			$AnimationPlayer.play("Fall")
			if friction == true :
				motion1.x = lerp(motion1.x, 0, 0.05) 
		
	
	motion1 = move_and_slide(motion1, UP )
	pass
func State():
	State_play = true
	motion1.x = 0
#	$AnimationPlayer.play(attack_anim)
#	yield($AnimationPlayer, "animation_finished")
	State_play = false

	

#func _on_Timer_timeout():
#	attack_num = 1
#	pass # Replace with function body.


