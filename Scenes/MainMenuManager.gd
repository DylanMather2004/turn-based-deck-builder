extends Node2D
@export var title_menu:Control
@export var game_mode_screen:Control
@export var combat_scene:PackedScene
@export var deck_builder_scene:PackedScene
var save_manager=SaveManager.new()
func _ready() -> void:
	PlayerData.deck = save_manager._load_deck("user://deck.save")
	print(PlayerData.deck)
	
func _on_play_button_pressed() -> void:
	game_mode_screen.show()
	title_menu.hide()


func _on_back_button_button_down() -> void:
	title_menu.show()
	game_mode_screen.hide()


func _on_fight_button_pressed() -> void:
	get_tree().change_scene_to_packed(combat_scene)
	get_tree().unload_current_scene()




func _on_deck_button_pressed() -> void:
	get_tree().change_scene_to_packed(deck_builder_scene)
	get_tree().unload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
