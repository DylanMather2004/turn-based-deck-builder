extends Node2D
@export_category("end screens")
@export var win_screen:AnimationPlayer
@export var lose_screen:AnimationPlayer

@export_category("Pause Menus")
@export var pause_screen:Control

var players:Array[Node]
var turn_player
func _ready() -> void:
	players=get_tree().get_nodes_in_group("character")
	turn_player=players[0]
	pause_screen.hide()
	Engine.time_scale=1
func turn_switch():
	if turn_player == players [0]:
		turn_player = players [1]
	elif turn_player==players [1]:
		turn_player = players [0]
	
	if turn_player!=null:
		turn_player.turn_start()
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func win():
	for i in players: 
		i.queue_free()
	
	var cards = get_tree().get_nodes_in_group("card")
	for i in cards:
		i.queue_free()
	win_screen.play("show")

func lose():
	for i in players: 
		i.queue_free()
	
	var cards = get_tree().get_nodes_in_group("card")
	for i in cards:
		i.queue_free()
	lose_screen.play("show")
		


func _on_area_2d_mouse_entered() -> void:
	print("mouse in")


func _on_pause_button_pressed() -> void:
	pause_screen.show()
	Engine.time_scale=0


func _on_unpause_button_pressed() -> void:
	pause_screen.hide()
	Engine.time_scale=1


func _on_quit_button_pressed() -> void:
	lose()
	pause_screen.hide()
	Engine.time_scale=1
