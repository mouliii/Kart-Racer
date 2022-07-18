extends BaseState

var speedLevels := [25,30,35]

var driftDir : int = 0
var boostCounter:int = 0
var maxBoosts:int = 3
var boostTimer := 0.0
const maxBoostTime := 1.0

var canBoost := true


func Enter(_host:CharacterBody3D)->void:
	var inputDir := Input.get_vector("right", "left", "accelerate", "reverse", 0.2)
	if Input.is_action_pressed("jump2"):
		if inputDir.x < 0.0:
			driftDir = -1
		else:
			driftDir = 1
	else:
		emit_signal("changeState", "Drive")
	boostCounter = 0
	boostTimer = 0.0
	canBoost = true
	

func Update(host:CharacterBody3D, delta:float)->void:
	var inputDir := Input.get_vector("right", "left", "accelerate", "reverse", 0.2)
	
	if Input.is_action_pressed("jump2"):
		boostTimer += delta
		if canBoost:
			if boostCounter < maxBoosts:
				if boostTimer < maxBoostTime:
					var bmValue:int = int((boostTimer / maxBoostTime) * 100)
					if Input.is_action_just_pressed("jump1"):
						if bmValue > 50:
							host.reserves += (bmValue / 100.0) * 2.0
							#print((bmValue / 100.0) * 2.0)
							boostTimer = 0.0
							boostCounter += 1
							SetSpeed(host)
						else:
							boostTimer = 0.0
					UiGlobals.SetBoostMeterValue(bmValue)
				else:
					canBoost = false
			else:
				canBoost = false
		else:
			UiGlobals.SetBoostMeterValue(0)
	else:
		emit_signal("changeState", "Drive")
		return
	# gravity
	if not host.is_on_floor():
		host.velocity.y -= host.gravity * delta
	# Handle rotation
	if host.velocity.length() > 0.2:
		var driftDrift := driftDir * deg2rad(30) * delta
		var turnFix:float = inputDir.x * host.turnRate * 0.5 * delta
		var finalDriftVal:float = 0.0
		if driftDir < 0:
			finalDriftVal = clamp(driftDrift + turnFix, -2.0, -0.01)
		else:
			finalDriftVal = clamp(driftDrift + turnFix, 0.01, 2.0)
		host.rotate_y(finalDriftVal)
		
		
		var cartDir = -host.transform.basis.z
		var angle = atan2(cartDir.x, cartDir.z)
		var l = (Vector2(host.velocity.x, host.velocity.z).normalized() * host.topSpeed).length()
		var dir:Vector3 = Vector3(sin(angle)*l, host.velocity.y, cos(angle)*l)
		host.velocity = dir
	
	host.move_and_slide()

func Exit(_host:CharacterBody3D)->void:
	UiGlobals.SetBoostMeterValue(0)

func SetSpeed(player:CharacterBody3D)->void:
	if player.topSpeed < speedLevels[boostCounter - 1]:
		player.topSpeed = speedLevels[boostCounter - 1]
