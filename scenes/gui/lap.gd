extends Control



func _ready():
	UiGlobals.connect("setLapCounter", Callable(self, "UpdateLap"))


func UpdateLap(lap:int)->void:
	$HBoxContainer/Label.text = str(lap)
	UiGlobals

