extends Area3D

var boostSpeed:int = 50

func _on_boostpad_body_entered(body):
	if body.name == "Player":
		var plrSpeed = body.topSpeed
		if boostSpeed > plrSpeed:
			body.topSpeed = boostSpeed
			body.reserves += 2.0
