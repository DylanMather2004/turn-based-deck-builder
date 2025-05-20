extends Control
var owned_cards = []
var deck=[]
var deck_buttons=[]
@export_category("UI Settings")
@export var cells_per_row = 5
@export var attack_card_menu:VBoxContainer
@export var heal_card_menu:VBoxContainer
@export var shield_card_menu:VBoxContainer
@export var poison_card_menu:VBoxContainer
@export var deck_menu:HBoxContainer
@export var menu_button_prefab:PackedScene
@export var deck_button_prefab:PackedScene
@export_category("Save Settings")
@export var save_path:String = "user://deck.save"
var save_manager = SaveManager.new()


func _ready() -> void:
	for i in (PlayerData.owned_cards):
		owned_cards.append(load(i))
		
	for i in range(owned_cards.size()):
		var new_button:TextureButton = menu_button_prefab.instantiate()
		new_button.texture_normal=owned_cards[i].card_art
		new_button.card=owned_cards[i]
		new_button.menu_manager =self
		match owned_cards[i].card_type:
			Card.CARD_TYPE.ATTACK:
				attack_card_menu.call_deferred("add_card",new_button)
			Card.CARD_TYPE.HEAL:
				heal_card_menu.call_deferred("add_card",new_button)
			Card.CARD_TYPE.OVERSHIELD:
				shield_card_menu.call_deferred("add_child",new_button)
			Card.CARD_TYPE.POISON:
				poison_card_menu.call_deferred("add_child",new_button)
	load_deck()
				
func add_card_to_deck(card:Card):
	deck.append(card.resource_path)
	add_deck_button(card)
func remove_card_from_deck(cardbutton:TextureButton):
	deck.erase(cardbutton.card.resource_path)
	deck_buttons.erase(cardbutton)
	cardbutton.queue_free()
func save_deck():
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_var(deck)
	file.close()
func load_deck():
	clear_deck()
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path,FileAccess.READ)
		for i in file.get_var():
			deck.append(i)
			
		for i in range(deck.size()):
			add_deck_button(load(deck[i]))
	else:
		print("No File to Load")
func clear_deck():
	while deck_buttons.size()>0:
		remove_card_from_deck(deck_buttons[0])
		
		

func add_deck_button(card:Card):
	var new_button:TextureButton=deck_button_prefab.instantiate()
	new_button.texture_normal=card.card_art
	new_button.menu_manager=self
	new_button.card = card
	deck_menu.add_child(new_button)
	deck_buttons.append(new_button)
	print(card.resource_path)


func _on_save_button_pressed() -> void:
	save_manager._save_deck(deck,save_path)


func _on_load_button_pressed() -> void:
	clear_deck()
	deck = save_manager._load_deck(save_path)
	for i in range(deck.size()):
		if is_instance_valid(deck[i]):
			add_deck_button(deck[i])


func _on_texture_button_pressed() -> void:
	print("press")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
