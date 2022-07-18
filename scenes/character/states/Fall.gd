extends BaseState


func Enter(_host:CharacterBody3D)->void:
	pass

func Update(host:CharacterBody3D, delta:float)->void:
	var inputDir := Input.get_vector("right", "left", "accelerate", "reverse", 0.2)
	if not host.is_on_floor():
		host.velocity.y -= host.gravity * delta
	else:
		var speed := Vector2(host.velocity.x, host.velocity.z).length()
		if Input.is_action_pressed("jump1") or Input.is_action_pressed("jump2") and speed > 0.5:
			if inputDir.x:
				emit_signal("changeState", "Drift")
		else:
			emit_signal("changeState", "Drive")
	# Handle rotation
	if host.velocity.length() > 0.2:
		host.rotate_y(inputDir.x * host.turnRate * 0.75 * delta)
		var cartDir = -host.transform.basis.z
		var angle = atan2(cartDir.x, cartDir.z)
		var l = Vector2(host.velocity.x, host.velocity.z).length()
		host.velocity = Vector3(sin(angle)*l, host.velocity.y, cos(angle)*l)

	host.move_and_slide()

func Exit(_host:CharacterBody3D)->void:
	pass
