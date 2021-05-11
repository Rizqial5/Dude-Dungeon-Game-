extends KinematicBody2D


const SPEED = 50
const UP = Vector2(0,-1) 
enum{
	IDLE
	MOVE,
	ATTACK,
	DAMAGED,
	DEATH
	}

const KNOCBACK = 100
var state = MOVE
var motion = Vector2()
var grav = 10
var is_moving_left = true
var keep_attack = false
var is_damaged = false
var enemy_value = randi()%11


onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
#onready var animationStateM = animationState.get()
onready var anim = $AnimationPlayer
onready var stats = $Stats
onready var deathTimer = $Death



func _ready():
	animationTree.active = true

# warning-ignore:unused_argument
func _process(delta):
	$TextureRect/Label.text = str(enemy_value)
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
		DEATH:
			Death_state()
	

func Move_state():
	move_enemy()
	turn_around()

func Attack_state():
	animationState.travel("Attack")
	
	
func Damaged_state():
	end_hit()
	if is_moving_left:
		motion.x = KNOCBACK
	else :
		motion.x = -KNOCBACK
	
	animationState.travel("Damaged")
	motion = move_and_slide(motion,UP)

func Death_state():
	animationState.travel("Death")
	
func move_enemy() :
	animationState.travel("Run")
	if is_moving_left :
		motion.x = -SPEED
		$TextureRect/Label.set_scale(Vector2(0.5,0.5))
	else :
		motion.x = SPEED
		$TextureRect/Label.set_scale(Vector2(-0.5,0.5))
	motion.y += grav
	motion = move_and_slide(motion,UP)

func turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
	
		
func hit():
	$AttackHIT.monitoring = true

func end_hit():
	$AttackHIT.monitoring = false
	
func start_walk():
	state = MOVE

func die():
	queue_free()

func _on_PlayerDetector_body_exited(_body):
	keep_attack = false

func _on_Batas_body_exited(body):
	is_moving_left = !is_moving_left
	scale.x = -scale.x

	

#func _on_DamagedArea_body_entered(body):
#	state = DAMAGED
#	keep_attack = false
#	stats.health -= 1
		
	
func _on_PlayerDetector_body_entered(body):
	keep_attack = true
	
	

func _on_DamagedArea_area_entered(_area):
	state = DAMAGED
	keep_attack = false
	stats.health -= 1


func _on_Stats_no_health():
	state = DEATH
	

