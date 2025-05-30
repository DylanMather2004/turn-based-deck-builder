extends Node
var card:Card
var menu_manager
@export var pressed_sound:WwiseEvent

func _on_pressed() -> void:
	menu_manager.add_card_to_deck(card)
	pressed_sound.post(self)


func _on_mouse_entered() -> void:
	menu_manager.show_card(card)
