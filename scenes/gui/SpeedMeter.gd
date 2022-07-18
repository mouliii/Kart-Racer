extends Control

@onready var boostMeter = $TextureProgressBar

func _ready():
	UiGlobals.connect("setBoostMeterValue", Callable(self, "SetProgress"))

func SetProgress(value:int)->void:
	if value > 50:
		boostMeter.tint_progress = Color(1,0,0,1)
	else:
		boostMeter.tint_progress = Color(0,1,0,1)
	boostMeter.value = value
