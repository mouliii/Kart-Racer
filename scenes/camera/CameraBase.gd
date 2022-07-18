extends Node3D

@export var camTarget : Node3D

func _process(_delta):
	self.position = camTarget.global_transform.origin
	self.global_rotation.y = camTarget.global_rotation.y
