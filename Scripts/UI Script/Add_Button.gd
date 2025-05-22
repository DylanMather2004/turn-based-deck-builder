extends Node
var card:Card
var menu_manager

func _on_pressed() -> void:
	menu_manager.add_card_to_deck(card)


func _on_mouse_entered() -> void:
	menu_manager.show_card(card)
