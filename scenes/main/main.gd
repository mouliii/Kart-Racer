extends Node3D

@onready var player = $Player
enum GameState {INTRO, RACING, END}
var gameState = GameState.INTRO

var time := 0.0
var endTime = 0.0
var lap := 1
var totLaps := 3
var checkPoints = [0,0,0,0,0]
var miniSectorTimes = []

func _ready():
	player.global_position = $Position3D.global_position
	player.global_rotation = $Position3D.global_rotation
	var cps = $Time.get_children()
	for cp in cps:
		cp.connect("body_entered", Callable(self, "_on_body_entered"), [cp.name])
	UiGlobals.connect("startGame", Callable(self, "StartGame"))

func _process(delta):
	if gameState == GameState.INTRO:
		pass
	elif gameState == GameState.RACING:
		if lap <= 3:
			time += delta
			UiGlobals.SetLapTime(lap, time)
	elif gameState == GameState.END:
		pass
	
	if Input.is_action_just_pressed("reset"):
		gameState = GameState.INTRO
		player.SetState("Empty")
		player.topSpeed = 20.0
		player.reserves = 0.0
		player.velocity = Vector3.ZERO
		player.global_position = $Position3D.global_position
		player.global_rotation = $Position3D.global_rotation
		time = 0.0
		lap = 1
		for i in range(0,checkPoints.size()):
			checkPoints[i] = 0
		UiGlobals.SetLapCounter(lap)
		UiGlobals.SetLapTime(lap, time)
		UiGlobals.Restart()

func _on_body_entered(body, cpName):
	if body.name == "Player":
		var nimi:String = cpName # ja wtf noi argsit on??
		var point:int = nimi.to_int() # ok, kikka vitonen
		if point > 0:
			checkPoints[point-1] = 1
			#print("checkpoont " + str(point - 1))
		else:
			var validLap:bool = true
			for i in checkPoints:
				if i == 0:
					validLap = false
					break
			if validLap:
				lap += 1
				UiGlobals.SetLapCounter(lap)
				time = 0.0
				for i in range(0,checkPoints.size()):
					checkPoints[i] = 0
				if lap > totLaps:
					endTime = time
					gameState = GameState.END
					UiGlobals.ShowTotalTime()

func StartGame()->void:
	gameState = GameState.RACING
	player.SetState("Drive")
