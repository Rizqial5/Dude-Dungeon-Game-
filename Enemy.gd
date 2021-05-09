extends KinematicBody2D


const SPEED = 50
const UP = Vector2(0,-1) 
enum{
	IDLE
	MOVE,
	ATTACK,
	DAMAGED
	}

var state = MOVE
var motion = Vector2()
var grav = 10
var is_moving_left = true
var keep_attack = false


onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

	


# warning-ignore:unused_argument
func _process(delta):
	if keep_attack == true :
		state = ATTACK
	
	match state:
		IDLE:
			pass
		MOVE:
			Move_state()
		ATTACK :
			Attack_state()
			
		DAMAGED:
			Damaged_state()
	




func Move_state():
	move_enemy()
	turn_around()

func Attack_state():
	animationState.travel("Attack")
	
	
	

func Damaged_state():
	keep_attack = false
	if is_moving_left:
		position.x += 2.5
	else :
		position.x -= 2.5
	animationState.travel("Damaged")
	
	
	
func move_enemy() :
	animationState.travel("Run")
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
	
		
func hit():
	$AttackHIT.monitoring = true
#	_on_AnimationPlayer_animation_changed("Attack","Damaged")
	

func end_hit():
	$AttackHIT.monitoring = false

func start_walk():
	state = MOVE


# warning-ignore:unused_argument









# warning-ignore:unused_argument
func _on_PlayerDetector_body_exited(body):
	keep_attack = false




func _on_Batas_body_exited(body):
	is_moving_left = !is_moving_left
	scale.x = -scale.x


func _on_DamagedArea_body_entered(body):
#	pass
	state = DAMAGED
	keep_attack = false
func _on_PlayerDetector_body_entered(body):
	keep_attack = true
	


#func _on_AnimationPlayer_animation_changed(old_name, new_name):
#	$AttackHIT.monitoring =false
#	print("true")
