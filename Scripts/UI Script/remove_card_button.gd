extends TextureButton
var menu_manager
var card:Card
@export var pressed_sound:WwiseEvent

func _on_pressed() -> void:
	menu_manager.remove_card_from_deck(self)
	pressed_sound.post(self)
