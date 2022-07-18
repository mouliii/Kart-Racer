extends Control

var num :int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	UiGlobals.connect("restart", Callable(self, "Restrart"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	num -= 1
	$Label.text = str(num)
	if num == 0:
		$Timer.autostart = false
		UiGlobals.StartGame()
		self.hide()

func Restrart()->void:
	self.show()
	num = 3
	$Label.text = str(num)
	$Timer.autostart = true
	$Timer.start(1.0)
