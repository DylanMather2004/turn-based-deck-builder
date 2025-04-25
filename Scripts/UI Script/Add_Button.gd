extends Node
var card:Card
var menu_manager

func _on_pressed() -> void:
	menu_manager.add_card_to_deck(card)
