extends Node
class_name BaseState

signal changeState(newState)

func Enter(_host:CharacterBody3D)->void:
	pass

func Update(_host:CharacterBody3D, _delta:float)->void:
	pass

func Exit(_host:CharacterBody3D)->void:
	pass
