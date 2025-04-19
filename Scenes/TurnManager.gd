extends Node2D
var players:Array[Node]
var turn_player:Node2D
func _ready() -> void:
	players=get_tree().get_nodes_in_group("character")
	turn_player=players[0]
func turn_switch():
	if turn_player == players [0]:
		turn_player = players [1]
	else:
		turn_player = players [0]
	turn_player.turn_start()
	
