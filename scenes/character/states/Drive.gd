extends BaseState

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var baseSpeed := 20.0

func Enter(host:CharacterBody3D)->void:
	if host.topSpeed < baseSpeed:
		host.topSpeed = baseSpeed

func Update(host:CharacterBody3D, delta:float)->void:
	# Get the input direction and handle the movement/deceleration.
	var inputDir := Input.get_vector("right", "left", "accelerate", "reverse", 0.2)
	var direction := (host.transform.basis * Vector3(inputDir.x, 0, inputDir.y)).normalized()
	
	# Add the gravity.
	if not host.is_on_floor():
		emit_signal("changeState", "Fall")
		return

	# Handle Jump.
	if Input.is_action_just_pressed("jump1") or Input.is_action_just_pressed("jump2") and host.is_on_floor():
		emit_signal("changeState", "Jump")
		return
	
	# Handle rotation
	if host.velocity.length() > 0.2:
		host.rotate_y(inputDir.x * host.turnRate * delta)
		var cartDir = -host.transform.basis.z
		var angle = atan2(cartDir.x, cartDir.z)
		var l = Vector2(host.velocity.x, host.velocity.z).length()
		host.velocity = Vector3(sin(angle)*l, host.velocity.y, cos(angle)*l)
	
	# Move
	if inputDir.y:
		host.velocity.x = lerp(host.velocity.x, direction.x * host.topSpeed, host.acceleration * delta)
		host.velocity.z = lerp(host.velocity.z, direction.z * host.topSpeed, host.acceleration * delta)
	else:
		host.velocity.x = lerp(host.velocity.x, 0, host.deceleration * delta)
		host.velocity.z = lerp(host.velocity.z, 0, host.deceleration * delta)

	host.move_and_slide()

func Exit(_host:CharacterBody3D)->void:
	pass
