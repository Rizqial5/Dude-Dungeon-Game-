extends KinematicBody2D

export (int) var run_speed = 250
export (int) var jump_speed = -450
export (int) var gravity = 1300

var velocity = Vector2()

var attacking = false
var jumping = false
var charging = false

var attackState = 3

onready var ani = $AnimatedSprite
onready var ui = $"UI inGame"
onready var attkCol_Right = $attackCollusion/right
onready var attkCol_Left = $attackCollusion/left
onready var specialR = $attackCollusion/specialR
onready var specialL = $attackCollusion/specialL
onready var attackReset = $attackReset

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('move_right')
	var left = Input.is_action_pressed('move_left')
	var jump = Input.is_action_just_pressed('jump')

	if attacking == false:
		if jump and is_on_floor():
			jumping = true
			velocity.y = jump_speed
			if velocity.y > 0:
				ani.play("fall")
			else:
				ani.play("jump")
			
		elif right:
			velocity.x += run_speed
			if ani.scale.x < 0:
				ani.scale.x *= -1
			if is_on_floor():
				ani.play("run")
				
		elif left:
			velocity.x -= run_speed
			if ani.scale.x > 0:
				ani.scale.x *= -1
			if is_on_floor():
				ani.play("run")
				
		elif is_on_floor():
			ani.offset.x = 0
			ani.play("Idle")


func attack():
	var attack = Input.is_action_pressed("attack")
	var spcAttack = Input.is_action_pressed("specialAttack")
	var left = ani.scale.x < 0
	var right = ani.scale.x > 0
	
	if attack and attacking == false:
		ani.stop()
		attackReset.start()
		print(attackState)
		attacking = true
		ani.offset.x = 3.403
		
		if right:
			attkCol_Right.disabled = false
		elif left:
			attkCol_Left.disabled = false
			
		if attackState == 3:
			ani.play("at1")
			attackState -=1
		elif attackState == 2:
			ani.play("at2")
			attackState -=1
		elif attackState == 1:
			ani.play("at3")
			attackState = 3 
		
	elif spcAttack and attacking == false:
		attacking = true
		ani.offset.x = 19.563
		ani.play("charge")
		
	elif charging == true:
		ani.play("spcAt")
		if right:
			specialR.disabled = false
		if left:
			specialL.disabled = false
	elif attacking == false:
		ani.offset.x = 0
		ani.offset.y = 0
		
	
func _physics_process(delta):
	get_input()
	attack()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if velocity.y >0:
		ani.play("fall")


func _on_AnimatedSprite_animation_finished():
	if ani.animation == "charge":
		charging = true
		
	if ani.animation == "spcAt":
		attacking = false
		charging = false
		specialR.disabled = true
		specialL.disabled = true
		
	if ani.animation == "at1" || ani.animation == "at2" || ani.animation == "at3":
		ani.offset.x = 0
		attacking = false
		attkCol_Right.disabled = true
		attkCol_Left.disabled = true
		

func _on_attackReset_timeout():
	attackState = 3
