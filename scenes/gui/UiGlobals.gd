extends Node

signal setBoostMeterValue(value) # 0-100
signal setLapTime(lap, time)
signal setLapCounter(lap)
signal startGame()
signal showTotTime()
signal restart()

func SetBoostMeterValue(value:int)->void:
	emit_signal("setBoostMeterValue", value)

func SetLapTime(lap:int, time:float)->void:
	emit_signal("setLapTime", lap, time)

func SetLapCounter(lap:int)->void:
	emit_signal("setLapCounter", lap)

func StartGame()->void:
	emit_signal("startGame")

func ShowTotalTime()->void:
	emit_signal("showTotTime")

func Restart()->void:
	emit_signal("restart")
