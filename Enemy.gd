extends KinematicBody2D


const SPEED = 50
const UP = Vector2(0,-1) 

var motion = Vector2()
var grav = 10
var is_moving_left = true

func _ready():
	$AnimationPlayer.play("Run")
	


func _process(delta):
	move_enemy()
	turn_around()

func move_enemy() :
	if is_moving_left :
		motion.x = -SPEED
	else :
		motion.x = SPEED
	motion.y += grav
	
	motion = move_and_slide(motion,UP)

func turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
