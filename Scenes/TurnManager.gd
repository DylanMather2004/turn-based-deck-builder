extends Node2D
@export var players:Array[Character]
var turn_player:Node2D
func _ready() -> void:
	turn_player=players[0]
func turn_switch():
	if turn_player == players [0]:
		turn_player = players [1]
	else:
		turn_player = players [0]
	turn_player.turn_start()
	
