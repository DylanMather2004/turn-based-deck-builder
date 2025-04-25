extends TextureButton
var menu_manager
var card:Card


func _on_pressed() -> void:
	menu_manager.remove_card_from_deck(self)
