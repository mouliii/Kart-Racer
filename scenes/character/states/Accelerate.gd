extends BaseState

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func Enter(_host:CharacterBody3D)->void:
	print("vrooom")

func Update(host:CharacterBody3D, delta:float)->void:
	# Get the input direction and handle the movement/deceleration.
	var inputDir := Input.get_vector("right", "left", "accelerate", "reverse")
	var direction := (host.transform.basis * Vector3(inputDir.x, 0, inputDir.y)).normalized()
	
	# Add the gravity.
	if not host.is_on_floor():
		emit_signal("pushState", "Fall")
		return

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and host.is_on_floor():
		emit_signal("pushState", "Jump")
		return
	
	# Handle rotation
	if host.velocity.length() > 0.2:
		host.rotate_y(inputDir.x * host.turnRate * delta)
		#rotation.y = lerp_angle(rotation.y, atan2(-direction.x, -direction.z), turnRate * delta)
		var cartDir = -host.transform.basis.z
		var angle = atan2(cartDir.x, cartDir.z)
		var l = Vector2(host.velocity.x, host.velocity.z).length()
		host.velocity = Vector3(sin(angle)*l, host.velocity.y, cos(angle)*l)
		
	# Move
	if inputDir.y:
		host.velocity.x = lerp(host.velocity.x, direction.x * host.topSpeed, host.acceleration * delta)
		host.velocity.z = lerp(host.velocity.z, direction.z * host.topSpeed, host.acceleration * delta)
		#velocity.x = direction.x * speed
		#velocity.z = direction.z * speed
	else:
		host.velocity.x = lerp(host.velocity.x, 0, host.deceleration * delta)
		host.velocity.z = lerp(host.velocity.z, 0, host.deceleration * delta)
		#velocity.x = move_towrds(velocity.x, 0, deceleration * delta)
		#velocity.z = move_towrds(velocity.z, 0, deceleration * delta)

	host.move_and_slide()

func Exit(_host:CharacterBody3D)->void:
	pass
