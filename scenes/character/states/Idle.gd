extends BaseState


func Enter(_host:CharacterBody3D)->void:
	pass

func Update(_host:CharacterBody3D, _delta:float)->void:
	var inputDir := Input.get_vector("right", "left", "accelerate", "reverse")
	# l/r liikuta renkaita
	if inputDir.y:
		emit_signal("pushState", "Accelerate")

func Exit(_host:CharacterBody3D)->void:
	pass
