extends Node2D
@export var title_menu:Control
@export var game_mode_screen:Control
@export var combat_scene ="res://Scenes/Combat.tscn"
@export var deck_builder_scene = "res://Scenes/Deck Builder Menu.tscn"
@export var enemy_select_menu:Control
@export var settings_menu:Control

@export_category("Player Data")
@export var starter_cards:Array[String]

var save_manager=SaveManager.new()
func _ready() -> void:
	PlayerData.owned_cards = save_manager.load_owned_cards(starter_cards,"user://owned_cards.save")
	PlayerData.deck = save_manager._load_deck("user://deck.save")
	print(PlayerData.deck)
	
func _on_play_button_pressed() -> void:
	game_mode_screen.show()
	title_menu.hide()


func _on_back_button_button_down() -> void:
	title_menu.show()
	game_mode_screen.hide()


func _on_fight_button_pressed() -> void:
	enemy_select_menu.show()
	game_mode_screen.hide()
	
	




func _on_deck_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Deck Builder Menu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_enemy_menu_back_button_pressed() -> void:
	enemy_select_menu.hide()
	game_mode_screen.show()


func _on_settings_button_pressed() -> void:
	settings_menu.show()
	title_menu.hide()


func _on_settings_back_button_pressed() -> void:
	settings_menu.hide()
	title_menu.show()
