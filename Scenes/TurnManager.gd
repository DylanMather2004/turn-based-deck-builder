extends Node2D
@export_category("end screens")
@export var win_screen:AnimationPlayer
@export var reward_image:Sprite2D
@export var reward_text:Sprite2D
@export var lose_screen:AnimationPlayer

@export_category("Pause Menus")
@export var pause_screen:Control
@export_category("audio")
@export var combat_volume:WwiseRTPC
@export var win_sound:WwiseEvent
@export var lose_sound:WwiseEvent
var players:Array[Node]
var turn_player
func _ready() -> void:
	players=get_tree().get_nodes_in_group("character")
	turn_player=players[0]
	pause_screen.hide()
	Engine.time_scale=1
	combat_volume.set_global_value(100)
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
	grant_reward()
	log_battle()
	for i in players: 
		i.queue_free()
	
	var cards = get_tree().get_nodes_in_group("card")
	for i in cards:
		i.queue_free()
	win_screen.play("show")
	win_sound.post(self)

func lose():
	log_battle()
	for i in players: 
		i.queue_free()
	
	var cards = get_tree().get_nodes_in_group("card")
	for i in cards:
		i.queue_free()
	lose_screen.play("show")
	lose_sound.post(self)	


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

func grant_reward():
	for i in players[1].character_resource.reward_cards:
		if !PlayerData.owned_cards.has(i.resource_path):
			PlayerData.owned_cards.append(i.resource_path)
			var save_manager=SaveManager.new()#
			save_manager.save_owned_cards(PlayerData.owned_cards,"user://owned_cards.save")
			
			reward_text.show()
			reward_image.texture=i.card_art
			break 

func log_battle():
	var cards_used = players[0].cards_used
	var unique_cards =[]
	for i in cards_used:
		if !unique_cards.has(i):
			unique_cards.append(i)
	var file = FileAccess.open("user://battle_log.txt",FileAccess.WRITE)
	for i in unique_cards:
		file.store_line(i + ":" + str(cards_used.count(i)))
	file.close()
