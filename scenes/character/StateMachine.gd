extends Node

@onready var player = get_parent()

var curState:BaseState = null
var allStates = {}

func _ready():
	for c in get_children():
		allStates[c.name] = c.get_path()
		c.connect("changeState", Callable(self, "ChangeState"))
	curState = get_node(allStates["Empty"])

func _physics_process(delta):
	curState.Update(player, delta)

func ChangeState(state:String)->void:
	var newState:Node = get_node(allStates[state])
	curState.Exit(player)
	curState = newState
	curState.Enter(player)
