extends CharacterBody3D

const acceleration := 4.0
const deceleration := 1.5
const jumpVelocity := 4.5
const turnRate := 3.5
var topSpeed := 20.0

var reserves := 0.0


# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = 15.0


func _physics_process(delta):
	# tähä kaikki ajo jutut? menis varmaa, if drift else normal shit. aika samat funcs kaikis
	reserves -= delta
	if reserves < 0.0:
		topSpeed = 20.0
		reserves = 0.0
	#print(topSpeed)


func SetState(stateName:String)->void:
	$StateMachine.ChangeState(stateName)


