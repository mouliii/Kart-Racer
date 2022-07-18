extends Control


func _ready():
	UiGlobals.connect("setLapTime", Callable(self, "SetTime"))
	UiGlobals.connect("showTotTime", Callable(self, "ShowTotalTime"))


func SetTime(lap:int, time:float)->void:
	var node:String = "VBoxContainer/HBoxContainer" + str(lap) + "/Lap"
	get_node(node).text = String.num(time, 3)
	$VBoxContainer/HBoxContainer4.hide()

func ShowTotalTime()->void:
	var lap1:float = $VBoxContainer/HBoxContainer1/Lap.text.to_float()
	var lap2:float = $VBoxContainer/HBoxContainer2/Lap.text.to_float()
	var lap3:float = $VBoxContainer/HBoxContainer3/Lap.text.to_float()
	var totTime:float = lap1 + lap2 + lap3
	$VBoxContainer/HBoxContainer4/VBoxContainer/HBoxContainer/Lap.text = String.num(totTime, 3)
	$VBoxContainer/HBoxContainer4.show()
